package sample01;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class Sample01 {
	public static void main(String[] args) {
        String clientId = "MxacW9xTfMI7aKYzLLIs";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "YheIrOeUB5";//애플리케이션 클라이언트 시크릿값";
        try {
            String text = "%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=sim";
            String apiURL = "https://openapi.naver.com/v1/search/news.xml?query=" + text;
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
