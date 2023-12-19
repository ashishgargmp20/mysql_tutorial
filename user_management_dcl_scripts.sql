-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLoginDate TIMESTAMP,
    AccountStatus ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active'
);

-- Roles Table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(50) NOT NULL
);

-- UserRoles Table (Many-to-Many)
CREATE TABLE UserRoles (
    UserRoleID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    RoleID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Sessions Table
CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Token VARCHAR(255) NOT NULL,
    ExpiryDate TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- PasswordResetRequests Table
CREATE TABLE PasswordResetRequests (
    RequestID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Token VARCHAR(255) NOT NULL,
    ExpiryDate TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- LoginAttempts Table
CREATE TABLE LoginAttempts (
    AttemptID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    IPAddress VARCHAR(50),
    AttemptTimestamp TIMESTAMP,
    Success BOOLEAN,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- UserDetails Table
CREATE TABLE UserDetails (
    DetailID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Two-Factor Authentication Table
CREATE TABLE TwoFactorAuthentication (
    UserID INT PRIMARY KEY,
    SecretKey VARCHAR(255) NOT NULL,
    Enabled BOOLEAN DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- AuditTrail Table
CREATE TABLE AuditTrail (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Activity VARCHAR(255),
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- BlockedUsers Table
CREATE TABLE BlockedUsers (
    BlockedUserID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    BlockedTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Reason VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
