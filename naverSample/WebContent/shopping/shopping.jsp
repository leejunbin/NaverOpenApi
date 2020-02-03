<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String text = request.getParameter("text");
	String start = request.getParameter("start");
	String sort = request.getParameter("sort");
	String clientId = "MxacW9xTfMI7aKYzLLIs";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "YheIrOeUB5";//애플리케이션 클라이언트 시크릿값";
    
	if(text == null || text == "" || start == null || sort == null) {
		text = "독서대";
		start = "1";
		sort = "sim";
	}
	StringBuffer sb = new StringBuffer();
	text=URLEncoder.encode(text,"UTF-8"); // 한글입력시 깨지지 않도록 인코딩처리
	try {
        text = text + "&display=10&start=" + start + "&sort=" + sort;
        String apiURL = "https://openapi.naver.com/v1/search/shop.xml?query=" + text;
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
        while ((inputLine = br.readLine()) != null) {
            sb.append(inputLine);
        }
        br.close();
      	//네이버open api로 얻어온 결과를 응답하기
    	response.setContentType("text/xml;charset=utf-8");
    	PrintWriter pw=response.getWriter();
    	pw.print(sb.toString());
    	pw.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>