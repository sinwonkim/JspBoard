package bbs;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList; //  외부에서 라이브러리 가져다 사용

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO(){
		try {
			String dbURL ="jdbc:mysql://localhost:3306/BBS"; // 3306 내꺼 포트에 BBS데이타베이스에 
			String dbID = "root";
			String dbPassword ="1234";
			Class.forName("com.mysql.jdbc.Driver"); //mysql에 접속해주는 매개체 역할을 해주는 하나의 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // conn 객체안에 접속된정보가 담기게됨
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//서버의 시간 함수
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); //실제 실행했을 떄 결과를 가져 올 수 있도록
			if(rs.next()) { 
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; 
	}
	
	//Bbs ID 가져오는
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; //가장 내림차순을 해서 가장 마지막에 쓰인 번호 가져올 수 있도록
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; // 나온 결과에 1을 더해 그다음 게시글에 번호가 들어갈 수 있도록
			}
			return 1; // 첫 번쨰 게시물인 경우 리턴값 1로 하면서 위치를 알려 줄 수 있도록
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //  데이터 베이스 오류가 발생하면 -1 을 반환해줘서 이걸 보고 오류인걸 알아 차리도록 
	}
	
	public int write(String bbsTitle,String userID,String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID );
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); // 글이 처음 작성했을떄 글 작성하는 상태 보여지는 거니깐 삭제가 안된 상태니깐 
			return pstmt.executeUpdate(); //인서트 경우 성공인 경우 0이상인 결과를 반환 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  // 오류인 경우 -1 반환해서 에러인지 알 수 있도록 표시
	}
	
	//list 담는 함수 	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; //가장 내림차순을 해서 가장 마지막에 쓰인 번호 가져올 수 있도록
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)* 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs(); // 결과 나올떄마다 bbs인스턴스 만들어서 
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			 }
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list; //뽑아온 게시글 리스트를 출력할 수 있게 list에 담아서 리턴값으로 
	}
	
	//페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; //가장 내림차순을 해서 가장 마지막에 쓰인 번호 가져올 수 있도록
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)* 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				return true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false; //뽑아온 게시글 리스트를 출력할 수 있게 list에 담아서 리턴값으로 
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";  // bbs아이디가 특정한 숫자일떄 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				Bbs bbs = new Bbs(); // 결과 나올떄마다 bbs인스턴스 만들어서 
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return	null; // 해당글이 존재 하지 않는 경우 null 을 반환 
	}
	
	// 아이티, 제목,내용 바꿔치기한다  update는 write랑 비슷한 성격 데이터 값을 바꾸거나 추가하는 SQL
	public int update(int bbsID,String bbsTitle,String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle =?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID );
			return pstmt.executeUpdate(); // 성공인 경우 0이상인 결과를 반환 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  // 오류인 경우 -1 반환해서 에러인지 알 수 있도록 표시
	
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; //어베일러블 값을 0으로 바꿈으로써 딜리트 구현 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID );
			return pstmt.executeUpdate(); // 성공인 경우 0이상인 결과를 반환 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  // db오류인 경우
	}
	
}