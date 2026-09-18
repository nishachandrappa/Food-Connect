# 🍱 Food Connect

**Food Connect** is a Java-based web application designed to connect **food donors with people/organizations in need**. The application helps reduce food wastage by allowing donors to share available food and enabling users or organizations to request and manage food donations.

## 📌 Project Overview

Large amounts of edible food are wasted every day while many people struggle to access sufficient food. Food Connect provides a simple platform where donors can register available food and organizations or users can find and request food donations.

The project was developed as a **full-stack Java web application** using JSP, Servlets, JDBC, and MySQL.

## ✨ Features

* 👤 User registration and login
* 🔐 User authentication
* 🍱 Food donation management
* 📋 View available food donations
* 🤝 Connect donors with recipients
* 📝 Manage food requests
* 👨‍💼 Admin management
* 🗄️ MySQL database integration
* 🌐 Dynamic web pages using JSP
* ⚙️ Server-side processing using Java Servlets

## 🛠️ Technologies Used

### Frontend

* HTML
* CSS
* JavaScript
* JSP

### Backend

* Java
* Java Servlets
* JDBC

### Database

* MySQL
* MySQL Connector/J

### Server

* Apache Tomcat

### IDE

* Eclipse IDE

## 📂 Project Structure

```text
Food-Connect/
│
├── .settings/
├── .classpath
├── .project
│
└── src/
    └── main/
        ├── java/
        │   └── lab/
        │       ├── FoodManagementServlet.java
        │       └── LoginServlet.java
        │
        └── webapp/
            ├── WEB-INF/
            │   ├── lib/
            │   │   └── mysql-connector-j-9.0.0.jar
            │   └── web.xml
            │
            ├── images/
            ├── index.jsp
            ├── donor.jsp
            ├── admin.jsp
            └── other JSP files
```

## ⚙️ Requirements

Before running the project, make sure you have:

* Java JDK
* Eclipse IDE
* Apache Tomcat Server
* MySQL Server
* MySQL Workbench
* MySQL Connector/J

## 🚀 How to Run

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/Food-Connect.git
```

### 2. Import into Eclipse

1. Open Eclipse.
2. Select **File → Import**.
3. Select **Existing Projects into Workspace**.
4. Select the cloned `Food-Connect` folder.
5. Click **Finish**.

### 3. Configure Tomcat

1. Add Apache Tomcat to Eclipse.
2. Right-click the project.
3. Select **Run As → Run on Server**.
4. Select your Tomcat server.
5. Start the server.

### 4. Configure MySQL

Create the required database in MySQL.

Example:

```sql
CREATE DATABASE food;
```

Then create the required tables according to the SQL/database structure used by the application.

### 5. Configure Database Connection

Update the database connection details in the project according to your local MySQL configuration.

```text
Database: food
Username: root
Password: YOUR_PASSWORD
```

> ⚠️ Do not upload your real MySQL password or other private credentials to GitHub.

## 🎯 Objective

The main objective of Food Connect is to provide a digital platform that:

* Reduces food wastage
* Encourages food donation
* Connects donors with recipients
* Makes food donation management easier
* Promotes social responsibility

## 🔮 Future Enhancements

* Online notifications for food requests
* Location-based donor and recipient matching
* Email/SMS notifications
* Mobile application
* Online food donation tracking
* Improved admin dashboard
* Cloud database integration

## 👩‍💻 Developed By

**Nisha C and Team**

Bachelor of Engineering – Information Science and Engineering

## 📄 License

This project was developed for academic/educational purposes.
