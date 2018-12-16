package bbs;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList; //  �ܺο��� ���̺귯�� ������ ���

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO(){
		try {
			String dbURL ="jdbc:mysql://localhost:3306/BBS"; // 3306 ���� ��Ʈ�� BBS����Ÿ���̽��� 
			String dbID = "root";
			String dbPassword ="1234";
			Class.forName("com.mysql.jdbc.Driver"); //mysql�� �������ִ� �Ű�ü ������ ���ִ� �ϳ��� ���̺귯��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // conn ��ü�ȿ� ���ӵ������� ���Ե�
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//������ �ð� �Լ�
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); //���� �������� �� ����� ���� �� �� �ֵ���
			if(rs.next()) { 
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; 
	}
	
	//Bbs ID ��������
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; //���� ���������� �ؼ� ���� �������� ���� ��ȣ ������ �� �ֵ���
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; // ���� ����� 1�� ���� �״��� �Խñۿ� ��ȣ�� �� �� �ֵ���
			}
			return 1; // ù ���� �Խù��� ��� ���ϰ� 1�� �ϸ鼭 ��ġ�� �˷� �� �� �ֵ���
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //  ������ ���̽� ������ �߻��ϸ� -1 �� ��ȯ���༭ �̰� ���� �����ΰ� �˾� �������� 
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
			pstmt.setInt(6, 1); // ���� ó�� �ۼ������� �� �ۼ��ϴ� ���� �������� �Ŵϱ� ������ �ȵ� ���´ϱ� 
			return pstmt.executeUpdate(); //�μ�Ʈ ��� ������ ��� 0�̻��� ����� ��ȯ 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  // ������ ��� -1 ��ȯ�ؼ� �������� �� �� �ֵ��� ǥ��
	}
	
	//list ��� �Լ� 	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; //���� ���������� �ؼ� ���� �������� ���� ��ȣ ������ �� �ֵ���
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)* 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs(); // ��� ���Ë����� bbs�ν��Ͻ� ���� 
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
		return list; //�̾ƿ� �Խñ� ����Ʈ�� ����� �� �ְ� list�� ��Ƽ� ���ϰ����� 
	}
	
	//����¡ ó���� ���� �Լ�
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; //���� ���������� �ؼ� ���� �������� ���� ��ȣ ������ �� �ֵ���
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
		return false; //�̾ƿ� �Խñ� ����Ʈ�� ����� �� �ְ� list�� ��Ƽ� ���ϰ����� 
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";  // bbs���̵� Ư���� �����ϋ� 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				Bbs bbs = new Bbs(); // ��� ���Ë����� bbs�ν��Ͻ� ���� 
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
		return	null; // �ش���� ���� ���� �ʴ� ��� null �� ��ȯ 
	}
	
	// ����Ƽ, ����,���� �ٲ�ġ���Ѵ�  update�� write�� ����� ���� ������ ���� �ٲٰų� �߰��ϴ� SQL
	public int update(int bbsID,String bbsTitle,String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle =?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID );
			return pstmt.executeUpdate(); // ������ ��� 0�̻��� ����� ��ȯ 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  // ������ ��� -1 ��ȯ�ؼ� �������� �� �� �ֵ��� ǥ��
	
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; //��Ϸ��� ���� 0���� �ٲ����ν� ����Ʈ ���� 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID );
			return pstmt.executeUpdate(); // ������ ��� 0�̻��� ����� ��ȯ 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  // db������ ���
	}
	
}