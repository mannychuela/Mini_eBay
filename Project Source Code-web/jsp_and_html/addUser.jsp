<%@ page import="java.lang.*"%>
<%@ page import="ut.JAR.CPEN410.*"%>
<%//Import the java.sql package to use the ResultSet class %>
<%@ page import="java.sql.*"%>
<html>
	<head>
		<title>Add User</title>
	</head>
	<body>

<%
	//Retrieve variables
	String userName = request.getParameter("userName");
	String userPass = request.getParameter("userPass");
	String completeName = request.getParameter("completeName");
	String telephone = request.getParameter("telephone");	

	//Try to connect the database using the applicationDBManager class
	try{

		/*//Check the authentication process
		if (session.getAttribute("userName")==null || session.getAttribute("currentPage")==null) {
			session.setAttribute("currentPage", null);
			session.setAttribute("userName", null);
			response.sendRedirect("newUser.html");
		}*/

		//Create the appDBMnger object
		applicationDBAuthenticationGoodComplete appDBAuth = new applicationDBAuthenticationGoodComplete();
		System.out.println("Connecting...");
		System.out.println(appDBAuth.toString());

		//verify if user entered user info in before accessing jsp
		if (userName ==  null || userName == "" || userPass=="" || completeName == "" || telephone == ""){
			response.sendRedirect("newUser.html");
			appDBAuth.close();
		}
			
		//Call the listAllDepartment method. This method returns a ResultSet containing all the tuples in the table Department
		boolean resUser=appDBAuth.addUser(userName, completeName, userPass, telephone);
		boolean resRoleUser = appDBAuth.setUserRole(userName);%>

		<%//Verify if the user has been authenticated
		if (resUser){%>
			User succesfully added 
			<%
			//Create the current page attribute
            session.setAttribute("currentPage", "addUser.jsp");

            //Create a session variable
            if (session.getAttribute("userName")==null ){
                //create the session variable
                session.setAttribute("userName", userName);
            } else{
                //Update the session variable
                session.setAttribute("userName", userName);
            }

            //redirect to the welcome page
            response.sendRedirect("welcomeMenu.jsp"); %>

		<%}else{
			//Close any session associated with the user
			session.setAttribute("userName", null);
			%>
			Cannot be added <br>
			response.sendRedirect("newUser.html");
		<%}
				
			//Close the connection to the database
			appDBAuth.close();
			
	} catch(Exception e){
		%>Nothing to show!<%
		e.printStackTrace();
	}finally{
		System.out.println("Finally");
	}
	%>//sessionName=<%=session.getAttribute("userName")%>
	</body>
</html>
