create schema vidhyadhan;
set search_path to vidhyadhan;

CREATE TABLE Conditions(
   Condition_Id INT NOT NULL,
   Is_Orphan BOOLEAN NOT NULL,
   Is_Phy_Disabled BOOLEAN NOT NULL,
   Is_BlackListed BOOLEAN NOT NULL,
   Has_Active_Backlog BOOLEAN NOT NULL,
   PRIMARY KEY(Condition_Id)
);

CREATE TABLE Registers(
    Email_id VARCHAR(255) NOT NULL,
    Register_Type VARCHAR(10) NOT NULL,
    Password_ VARCHAR(64) NOT NULL,
    PRIMARY KEY(Email_id,Register_Type)
);

CREATE TABLE Scholarships(
    Scholarship_Id CHAR(8) NOT NULL,
    S_Name VARCHAR(255) NOT NULL,
    Amount INTEGER NOT NULL,
    Starting_Date DATE NOT NULL,
    Closing_Date DATE NOT NULL,
    Sch_description TEXT NOT NULL,
    Income INTEGER NOT NULL,
    Condition_Id INT NOT NULL,
    PRIMARY KEY(Scholarship_Id),
    FOREIGN KEY(Condition_Id) REFERENCES Conditions(Condition_Id)
);

CREATE TABLE IFSC_Details(
    IFSC_Code CHAR(11) NOT NULL,
    Bank_Name VARCHAR(255) NOT NULL,
    Branch_Name VARCHAR(255) NOT NULL,
    PRIMARY KEY(IFSC_Code)
);

CREATE TABLE Bank_Details(
    Bank_Account_No VARCHAR(30) NOT NULL,
    Bank_Account_Holder_Type VARCHAR(10) NOT NULL,
	IFSC_Code CHAR(11) NOT NULL,
    PRIMARY KEY(Bank_Account_No,Bank_Account_Holder_Type),
    FOREIGN KEY(IFSC_Code) REFERENCES IFSC_Details(IFSC_Code)
);

CREATE TABLE States(
    Scholarship_Id CHAR(8) NOT NULL,
    State_Name VARCHAR(30) NOT NULL,
    PRIMARY KEY(Scholarship_Id,State_Name),
    FOREIGN KEY(Scholarship_id) REFERENCES Scholarships(Scholarship_Id)
);

CREATE TABLE Department(
    Scholarship_Id CHAR(8) NOT NULL,
    Department_Name VARCHAR(30) NOT NULL,
    PRIMARY KEY(Scholarship_Id,Department_Name),
    FOREIGN KEY(Scholarship_Id) REFERENCES Scholarships(Scholarship_Id)
);

CREATE  TABLE  Departments_with_Programs(
       Program_Name VARCHAR(30) NOT NULL,
       Department_Name VARCHAR(30) NOT NULL,
       PRIMARY KEY(Department_Name)
);

CREATE TABLE Education_Details(
    College_Id CHAR(8) NOT NULL,
    Semester VARCHAR(10) NOT NULL,
    Year_of_Admission CHAR(4) NOT NULL,
    College_Name VARCHAR(255) NOT NULL,
    Department_Name VARCHAR(30) NOT NULL,
    Tuition_Fees INTEGER NOT NULL,
    Hostel_Fees INTEGER NOT NULL,
    Received_TFWS BOOLEAN NOT NULL,
    PRIMARY KEY(College_Id,Semester,Year_of_Admission,Department_Name),
    FOREIGN KEY(Department_Name) REFERENCES Departments_with_Programs(Department_Name)

);

CREATE TABLE Religion(
    Scholarship_id CHAR(8) NOT NULL,
    Religion VARCHAR(10) NOT NULL,
    PRIMARY KEY(Scholarship_id,Religion),
    FOREIGN KEY(Scholarship_id) REFERENCES Scholarships(Scholarship_Id)
);

CREATE TABLE Parent_or_Guardian_Details(
    Email_Id VARCHAR(255) NOT NULL,
    Fname VARCHAR(255) NOT NULL,
    Mname VARCHAR(255) NOT NULL,
    Lname VARCHAR(255) NOT NULL,
    Dob DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    Occupation VARCHAR(30) NOT NULL,
    Annual_Income INTEGER NOT NULL,
    Other_Income INTEGER NOT NULL,
    Contact_no CHAR(10) NOT NULL,
    PRIMARY KEY(Email_Id)
);

CREATE TABLE Employees(
    Email_Id VARCHAR(255) NOT NULL,
    Fname VARCHAR(255) NOT NULL,
    Mname VARCHAR(255) NOT NULL,
    Lname VARCHAR(255) NOT NULL,
    Manager_Email_Id VARCHAR(255) NULL,
    Scholarship_Id CHAR(8) NULL,
    Contact_no_1 CHAR(10) NOT NULL,
    Contact_no_2 CHAR(10) NULL,
    PRIMARY KEY(Email_Id),
    FOREIGN KEY(Manager_Email_Id) REFERENCES Employees(Email_Id),
    FOREIGN KEY(Scholarship_Id) REFERENCES Scholarships(Scholarship_Id)
);

CREATE TABLE Programs(
    Scholarship_id CHAR(8) NOT NULL,
    Program_Name VARCHAR(30) NOT NULL,
    PRIMARY KEY(Scholarship_id,Program_Name),
    FOREIGN KEY(Scholarship_Id) REFERENCES Scholarships(Scholarship_Id)
);

CREATE TABLE Donor(
    Donor_Id CHAR(8) NOT NULL,
    Donor_Email_Id VARCHAR(255) NOT NULL,
    Register_Type VARCHAR(10) NOT NULL,
    Bank_Account_No VARCHAR(30) NOT NULL,
    Bank_Account_Holder_Type VARCHAR(10) NOT NULL,
    Contact_no CHAR(10) NOT NULL,
    Aadhar_No CHAR(12) NULL,
    Fname VARCHAR(255) NULL,
    Mname VARCHAR(255) NULL,
    Lname VARCHAR(255) NULL,
    CIN_No CHAR(21) NULL,
    Company_Name VARCHAR(255) NULL,
    PRIMARY KEY(Donor_Id),

    FOREIGN KEY(Donor_Email_Id,Register_Type) REFERENCES Registers(Email_Id,Register_Type),
    FOREIGN KEY(Bank_Account_No,Bank_Account_Holder_Type) REFERENCES Bank_Details(Bank_Account_No,Bank_Account_Holder_Type)
);



CREATE TABLE Donated_In(
    Scholarship_Id CHAR(8) NOT NULL,
    Donor_Id CHAR(8) NOT NULL,
    Donated_Ammount INTEGER NOT NULL,
    Reciept_No VARCHAR(30) NOT NULL,
    Donation_date DATE NOT NULL,
    PRIMARY KEY(Scholarship_Id,Donor_Id),
    FOREIGN KEY(Scholarship_Id) REFERENCES Scholarships(Scholarship_Id),
    FOREIGN KEY(Donor_Id) REFERENCES Donor(Donor_Id)
);

CREATE TABLE Citys(
       City VARCHAR(30) NOT NULL,
       State_Name VARCHAR(30) NOT NULL,
       PRIMARY KEY(City)
);

CREATE TABLE Pincodes(
       Pincode CHAR(6) NOT NULL,
       City VARCHAR(30) NOT NULL,
       PRIMARY KEY(Pincode),
       FOREIGN KEY(City) REFERENCES Citys(City)
);

CREATE TABLE Applicant(
    Applicant_Id CHAR(8) NOT NULL,
    Guardian_Email_Id VARCHAR(255) NOT NULL,
    Fname VARCHAR(255) NOT NULL,
    Mname VARCHAR(255) NOT NULL,
    Lname VARCHAR(255) NOT NULL,
    College_Id CHAR(8) NOT NULL,
    Semester VARCHAR(10) NOT NULL,
    Year_of_Admission CHAR(4) NOT NULL,
    Department_Name VARCHAR(30) NOT NULL,
    DOB DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    Category VARCHAR(10) NOT NULL,
    Religion VARCHAR(10) NOT NULL,
    Applicant_Email_Id VARCHAR(255) NOT NULL,
    Register_Type VARCHAR(30) NOT NULL,
    Appartment_Number VARCHAR(10) NOT NULL,
    Street_Name VARCHAR(255) NOT NULL,
    Pincode CHAR(6) NOT NULL,
    Contact_no CHAR(10) NOT NULL,
    Bank_Account_No VARCHAR(30) NOT NULL,
    Bank_Account_Holder_type VARCHAR(10) NOT NULL,
	Condition_Id INT NOT NULL,
    PRIMARY KEY(Applicant_Id),

    FOREIGN KEY(Guardian_Email_Id) REFERENCES Parent_or_Guardian_Details(Email_Id),

    FOREIGN KEY(Condition_Id) REFERENCES Conditions(Condition_Id),

    FOREIGN KEY(College_Id,Semester,Year_of_Admission,Department_Name ) REFERENCES Education_Details(College_Id,Semester,Year_of_Admission,Department_Name),

    FOREIGN KEY(Applicant_Email_id,Register_Type) REFERENCES Registers(Email_id,Register_Type),
	
    FOREIGN KEY(Bank_Account_No,Bank_Account_Holder_type) REFERENCES Bank_Details(Bank_Account_No,Bank_Account_Holder_type)
);

CREATE TABLE Qualification(
    Applicant_Id CHAR(8) NOT NULL,
    Type_of_Qualification VARCHAR(10) NOT NULL,
    Passing_year INTEGER NOT NULL,
    Percentile DECIMAL(4, 2) NOT NULL,
    PRIMARY KEY(Applicant_Id,Type_of_Qualification),
    FOREIGN KEY(Applicant_Id) REFERENCES Applicant(Applicant_Id)
);

CREATE TABLE Applied_in(
    Scholarship_Id CHAR(8) NOT NULL,
    Applicant_Id CHAR(8) NOT NULL,
    Applied_In DATE NOT NULL,
    PRIMARY KEY(Scholarship_Id,Applicant_Id),
    FOREIGN KEY(Scholarship_Id) REFERENCES Scholarships(Scholarship_Id),
    FOREIGN KEY(Applicant_Id) REFERENCES Applicant(Applicant_Id)
);

CREATE TABLE Received_From(
    Scholarship_Id CHAR(8) NOT NULL,
    Applicant_Id CHAR(8) NOT NULL,
    Amount_Received INTEGER NOT NULL,
    Received_On DATE NOT NULL,
    PRIMARY KEY(Scholarship_Id,Applicant_Id),
    FOREIGN KEY(Applicant_Id) REFERENCES Applicant(Applicant_Id),
    FOREIGN KEY(Scholarship_Id) REFERENCES Scholarships(Scholarship_Id)
);

CREATE TABLE Gender(
    Scholarship_id CHAR(8) NOT NULL,
    Gender CHAR(1) NOT NULL,
    PRIMARY KEY(Scholarship_id,Gender),
    FOREIGN KEY(Scholarship_Id) REFERENCES Scholarships(Scholarship_id)
);