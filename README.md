# 🎓 VidhyaDhan - Online Scholarship Management System

> A comprehensive database design for managing scholarships, applications, and donations seamlessly.

## 📘 Project Overview

**VidhyaDhan** is an Online Scholarship Management System designed as part of the **IT214 - Database Management System (Winter 2024)** course project. The system aims to streamline the process of applying for scholarships, handling donations from individuals or companies, and managing scholarship distribution by an admin unit.

---

## 🧠 Team Members

| Name              | Roll Number   |
|-------------------|---------------|
| Vraj Dobariya     | 202201106     |
| Dip Baldha        | 202201142     |
| Rishi Godhasara   | 202201154     |
| Aman Mangukiya    | 202201156     |
| Darshak Kukadiya  | 202201180     |

---

## 🎯 Objective

To design and implement a **robust relational database** that:

- Allows **applicants** to register and apply for scholarships
- Enables **donors** to create scholarships or donate to existing ones
- Empowers **admins, managers, and facilitators** to verify, manage, and distribute scholarships
- Maintains transparency and structure in the scholarship management workflow

---

## 👤 Users and Roles

### 🧑‍🎓 Applicant (Student)
- Register & update profile
- Search & apply for scholarships
- View application status
- Manage personal, academic & bank details

### 💰 Donor (Individual/Company)
- Register & update profile
- Donate to existing scholarships
- Companies can also create new scholarships
- View donation history

### 🛠️ Admin Unit
- Assign facilitators & managers to scholarships
- Monitor applicant documents & scholarship distribution
- Manage workloads across facilitators

---

## 🗃️ Database Schema

The system consists of **25+ normalized tables**, including:

- `Applicant`, `Scholarships`, `Donor`, `Employees`
- `Applied_in`, `Received_From`, `Donated_In`
- `Registers`, `Conditions`, `Qualification`, `Education_Details`, etc.
- Full DDL script available in [`schema.sql`](./schema.sql)

---

## 🔐 Key Features

- Many-to-many relationships using associative tables
- Role-based user registration and authentication (`Registers`)
- Condition-based eligibility criteria for scholarships
- Education, bank, guardian, and location detail tracking
- Admin-managed document verification and fraud tracking
- Manager-facilitator hierarchy with workload balancing

---

## 🙌 Acknowledgements

Thanks to the faculty of **DA-IICT** for the DBMS course and guidance on real-world database design.
