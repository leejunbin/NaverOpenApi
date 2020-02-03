<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String search1=request.getParameter("search");
	String start=request.getParameter("start");
	if(search1==null) search1="jquery";
	if(start==null) start="1";
	
	StringBuffer sb=new StringBuffer();
	search1=URLEncoder.encode(search1,"UTF-8");
	String surl="https://openapi.naver.com/v1/search/book.xml?query=" + search1 +
			 "&display=5&start=" + start;
	
	URL url=new URL(surl);
	HttpURLConnection conn=(HttpURLConnection)url.openConnection();
	conn.setRequestProperty("X-Naver-Client-Id","MxacW9xTfMI7aKYzLLIs");
    conn.setRequestProperty("X-Naver-Client-Secret", "YheIrOeUB5");
    if(conn!=null){
    	conn.setConnectTimeout(10000);//접속대기시간 10초 설정
    	conn.setUseCaches(false);//캐쉬사용안하기
    	if(conn.getResponseCode()==HttpURLConnection.HTTP_OK){//서버로부터 응답이 성공적으로 왔으면
    		BufferedReader br=
    		 new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
    		String line="";
    		while((line=br.readLine())!=null){
    			sb.append(line);
    		}
    		br.close();
    		conn.disconnect();//네이버와 접속해제
    	}
    }
	//네이버open api로 얻어온 결과를 응답하기
	response.setContentType("text/xml;charset=utf-8");
	PrintWriter pw=response.getWriter();
	pw.print(sb.toString());
	pw.close();
%>













