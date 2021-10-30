# jaltantra

Jaltantra is a System for the Design and Optimization of Water Distribution Networks. 
For more info about the system, please visit the following page: 
https://www.cse.iitb.ac.in/jaltantra

This version of Jaltanra contains the user management using HttpSession. 

To work with the system, either remove/modify the @WebFilter in LoginFilter.java to bypass the login requirement 
or using MySQL, create a database named "jaltantra_db" and a table named "jaltantra_users" having the following columns:

  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `organization` varchar(150) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `creationDate` datetime DEFAULT CURRENT_TIMESTAMP

You can see/modify the user credentials in the UserDao.java file. 


