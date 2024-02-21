-- Create Database
CREATE DATABASE IF NOT EXISTS pair_discussion;
USE pair_discussion;

DROP TABLE IF EXISTS Company_Advertises;
DROP TABLE IF EXISTS Candidate;
DROP TABLE IF EXISTS Phone_Number;
DROP TABLE IF EXISTS Panellist;
DROP TABLE IF EXISTS Shortlist;
DROP TABLE IF EXISTS Selected_Candidates;
DROP TABLE IF EXISTS Member_;
DROP TABLE IF EXISTS Music_Group;
DROP TABLE IF EXISTS Music_Album;
DROP TABLE IF EXISTS Trailer_Views;
DROP TABLE IF EXISTS Distributor;
DROP TABLE IF EXISTS Download_Request;



-- Create Company_Advertises
CREATE TABLE Company_Advertises (
    URL_Link VARCHAR(255) NOT NULL,
    Channels VARCHAR(255) NOT NULL,
    Starting_Date DATE NOT NULL,
    PRIMARY KEY (URL_Link)
);

-- Create Candidate
CREATE TABLE Candidate (
    Candidate_ID VARCHAR(255) NOT NULL,
    First_Name VARCHAR(255) NOT NULL,
    Last_Name VARCHAR(255) NOT NULL,
    Candidate_Name VARCHAR(255) GENERATED ALWAYS AS (CONCAT(First_Name, ' ', Last_Name)) STORED,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Notification_Preference SET('Phone Number', 'Email') NOT NULL,
    Candidate_Media_Type SET('Audio', 'Video') NOT NULL,
    Channel_Number VARCHAR(255) NOT NULL,
    PRIMARY KEY (Candidate_ID)
);

-- Create Phone_Number
CREATE TABLE Phone_Number (
    Phone_Number_ID INT NOT NULL,
    Candidate_ID VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(255) NOT NULL,
    PRIMARY KEY (Phone_Number_ID),
    FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

-- Create Panellist
CREATE TABLE Panellist (
    Panellist_ID VARCHAR(255) NOT NULL,
    Panellist_Name VARCHAR(255) NOT NULL,
    Panellist_Phone VARCHAR(255) NOT NULL,
    Panellist_EmailID VARCHAR(255) NOT NULL,
    Panellist_Industry_Experience INT NOT NULL,
    Panellist_MCM_Association ENUM('Fresher', 'Senior'),
    PRIMARY KEY (Panellist_ID)
);

-- Create Shortlist
CREATE TABLE Shortlist (
    Shortlist_ID VARCHAR(255) NOT NULL,
    Candidate_ID VARCHAR(255) NOT NULL,
    PRIMARY KEY (Shortlist_ID),
    FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

-- Create Selected_Candidates
CREATE TABLE Selected_Candidates (
    Selected_Candidates_ID VARCHAR(255) NOT NULL,
    Candidate_ID VARCHAR(255) NOT NULL,
    PRIMARY KEY (Selected_Candidates_ID),
    FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

-- Create Member_
CREATE TABLE Member_ (
    Member_ID VARCHAR(255) NOT NULL,
    Music_Group_ID VARCHAR(255) NOT NULL,
    Candidate_ID VARCHAR(255) NOT NULL,
    Member_Role VARCHAR(255) NOT NULL,
    Is_Director ENUM('Yes', 'No') NOT NULL,
    PRIMARY KEY (Member_ID, Music_Group_ID),
    FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

-- Create Music_Group
CREATE TABLE Music_Group (
    Music_Group_ID VARCHAR(255) NOT NULL,
    Music_Group_Name VARCHAR(255) NOT NULL,
    Music_Group_Type SET('pop', 'classic', 'leisure', 'evergreen', 'jazz', 'rock', 'metal'),
    PRIMARY KEY (Music_Group_ID)
);

-- Create Music_Album
CREATE TABLE Music_Album (
    Music_Album_ID VARCHAR(255) NOT NULL,
    Music_Album_Name VARCHAR(255) NOT NULL,
    Music_Album_Type ENUM('Audio', 'Video'),
    Music_Group_ID VARCHAR(255) NOT NULL,
    Music_Album_Release_Date VARCHAR(255) NOT NULL,
    Music_Album_Director_Approval ENUM('Yes', 'No') NOT NULL,
    PRIMARY KEY (Music_Album_ID),
    FOREIGN KEY (Music_Group_ID) REFERENCES Music_Group(Music_Group_ID)
);

-- Create Trailer_Views
CREATE TABLE Trailer_Views (
    Trailer_Views_ID VARCHAR(255) NOT NULL,
    Music_Album_ID VARCHAR(255) NOT NULL,
    Trailer_Views_Release_Date DATE NOT NULL,
    Trailer_Views_Number_of_Visits INT NOT NULL,
    Trailer_Views_Number_of_Likes INT NOT NULL,
    Trailer_Views_Number_of_Dislikes INT NOT NULL,
    Trailer_Views_Deletion_Date DATE NOT NULL,
    PRIMARY KEY (Trailer_Views_ID),
    FOREIGN KEY (Music_Album_ID) REFERENCES Music_Album(Music_Album_ID)
);

-- Create Distributor
CREATE TABLE Distributor (
    Distributor_ID VARCHAR(255) NOT NULL,
    Distributor_Name VARCHAR(255) NOT NULL,
    Distributor_Negotiated_Price FLOAT NOT NULL,
    Music_Album_ID VARCHAR(255) NOT NULL,
    PRIMARY KEY (Distributor_ID),
    FOREIGN KEY (Music_Album_ID) REFERENCES Music_Album(Music_Album_ID)
);

-- Create Download_Request
CREATE TABLE Download_Request (
    Distributor_ID VARCHAR(255) NOT NULL,
    Music_Album_ID VARCHAR(255) NOT NULL,
    Download_Request_ID INT NOT NULL,
    Download_Request_URL VARCHAR(255) NOT NULL,
    Download_Request_Date DATE NOT NULL,
    Download_Request_Status ENUM('Success', 'Failure') NOT NULL,
    PRIMARY KEY (Download_Request_ID),
    FOREIGN KEY (Distributor_ID) REFERENCES Distributor(Distributor_ID),
    FOREIGN KEY (Music_Album_ID) REFERENCES Music_Album(Music_Album_ID)
);



-- Populate Company_Advertises
INSERT INTO Company_Advertises (URL_Link, Channels, Starting_Date) VALUES
('url1', 'Channel1', '2023-01-01'),
('url2', 'Channel2', '2023-01-02'),
('url3', 'Channel3', '2023-01-03'),
('url4', 'Channel4', '2023-01-04'),
('url5', 'Channel5', '2023-01-05'),
('url6', 'Channel1', '2023-01-06'),
('url7', 'Channel7', '2023-01-07'),
('url8', 'Channel8', '2023-01-08'),
('url9', 'Channel9', '2023-01-09'),
('url10', 'Channel10', '2023-01-10');

-- Populate Candidate
INSERT INTO Candidate (Candidate_ID, First_Name, Last_Name, Email, Notification_Preference, Candidate_Media_Type, Channel_Number) VALUES
('cand1', 'Rahul', 'Sharma', 'rahul.sharma@example.com', 'Email', 'Audio', 'Channel1'),
('cand2', 'Priya', 'Patel', 'priya.patel@example.com', 'Phone Number', 'Video', 'Channel2'),
('cand3', 'Ananya', 'Gupta', 'ananya.gupta@example.com', 'Email', 'Audio,Video', 'Channel3'),
('cand4', 'Amit', 'Singh', 'amit.singh@example.com', 'Phone Number', 'Video', 'Channel4'),
('cand5', 'Neha', 'Kumar', 'neha.kumar@example.com', 'Email', 'Audio', 'Channel2'),
('cand6', 'Vishal', 'Rao', 'vishal.rao@example.com', 'Phone Number', 'Audio,Video', 'Channel1'),
('cand7', 'Pooja', 'Mehta', 'pooja.mehta@example.com', 'Email', 'Audio', 'Channel1'),
('cand8', 'Sandeep', 'Sinha', 'sandeep.sinha@example.com', 'Phone Number', 'Video', 'Channel10'),
('cand9', 'Divya', 'Shah', 'divya.shah@example.com', 'Email', 'Audio', 'Channel1'),
('cand10', 'Arun', 'Joshi', 'arun.joshi@example.com', 'Phone Number', 'Audio,Video', 'Channel6');

-- Populate Phone_Number
INSERT INTO Phone_Number (Phone_Number_ID, Candidate_ID, Phone_Number) VALUES
(1, 'cand1', '1234567890'),
(2, 'cand2', '2345678901'),
(3, 'cand3', '3456789012,9102938273'),
(4, 'cand4', '4567890123'),
(5, 'cand5', '5678901234'),
(6, 'cand6', '6789012345'),
(7, 'cand7', '7890123456'),
(8, 'cand8', '8901234567'),
(9, 'cand9', '9012345678'),
(10, 'cand10', '0123456789');

-- Populate Panellist
INSERT INTO Panellist (Panellist_ID, Panellist_Name, Panellist_Phone, Panellist_EmailID, Panellist_Industry_Experience, Panellist_MCM_Association) VALUES
('panellist1', 'Ashok', '1111111111', 'Ashok@yahoo.com', 5, 'Senior'),
('panellist2', 'Kumar', '2222222222', 'Kumar@gmail.com', 7, 'Senior'),
('panellist3', 'Rao', '3333333333', 'Rao@yahoo.com', 3, 'Fresher'),
('panellist4', 'Shastri', '4444444444', 'Shastri@gmail.com', 8, 'Senior'),
('panellist5', 'Mishra', '5555555555', 'Mishra@yahoo.com', 4, 'Fresher'),
('panellist6', 'Jindal', '6666666666', 'Jindal@gmail.com', 6, 'Senior'),
('panellist7', 'Sanyam', '7777777777', 'Sanyam@yahoo.com', 2, 'Fresher'),
('panellist8', 'Yaksh', '8888888888', 'Yaksh@gmail.com', 9, 'Senior'),
('panellist9', 'Rahul', '9999999999', 'Rahul@yahoo.com', 1, 'Fresher'),
('panellist10', 'Raj', '0000000000', 'Raj@gmail.com', 10, 'Senior');

-- Populate Shortlist
INSERT INTO Shortlist (Shortlist_ID, Candidate_ID) VALUES
('shortlist1', 'cand1'),
('shortlist2', 'cand2'),
('shortlist3', 'cand3'),
('shortlist4', 'cand4'),
('shortlist5', 'cand5'),
('shortlist6', 'cand6'),
('shortlist7', 'cand7'),
('shortlist8', 'cand8'),
('shortlist9', 'cand9'),
('shortlist10', 'cand10');

-- Populate Selected_Candidates
INSERT INTO Selected_Candidates (Selected_Candidates_ID, Candidate_ID) VALUES
('selected1', 'cand1'),
('selected2', 'cand2'),
('selected3', 'cand3'),
('selected4', 'cand4'),
('selected5', 'cand5'),
('selected6', 'cand6'),
('selected7', 'cand7'),
('selected8', 'cand8'),
('selected9', 'cand9'),
('selected10', 'cand10');

-- Populate Member_
INSERT INTO Member_ (Member_ID, Music_Group_ID, Candidate_ID, Member_Role, Is_Director) VALUES
('member1', 'group1', 'cand1', 'Singer', 'No'),
('member2', 'group2', 'cand1', 'Singer', 'No'),
('member3', 'group1', 'cand2', 'Guitarist', 'No'),
('member4', 'group2', 'cand2', 'Guitarist', 'No'),
('member5', 'group2', 'cand3', 'Drummer', 'No'),
('member6', 'group3', 'cand4', 'Pianist', 'Yes'),
('member7', 'group3', 'cand5', 'Bassist', 'No'),
('member8', 'group4', 'cand6', 'Keyboardist', 'No'),
('member9', 'group4', 'cand7', 'Vocalist', 'No'),
('member10', 'group5', 'cand8', 'Drummer', 'Yes');

-- Populate Music_Group
INSERT INTO Music_Group (Music_Group_ID, Music_Group_Name, Music_Group_Type) VALUES
('group1', 'Band A', 'rock'),
('group2', 'Band B', 'jazz'),
('group3', 'Band C', 'pop'),
('group4', 'Band D', 'metal'),
('group5', 'Band E', 'classic');

-- Populate Music_Album
INSERT INTO Music_Album (Music_Album_ID, Music_Album_Name, Music_Album_Type, Music_Group_ID, Music_Album_Release_Date, Music_Album_Director_Approval) VALUES
('album1', 'Album 1', 'Audio', 'group1', '2020-01-01', 'Yes'),
('album2', 'Album 2', 'Video', 'group2', '2021-02-01', 'No'),
('album3', 'Album 3', 'Audio', 'group3', '2020-03-01', 'Yes'),
('album4', 'Album 4', 'Video', 'group4', '2021-04-01', 'No'),
('album5', 'Album 5', 'Audio', 'group5', '2020-05-01', 'Yes'),
('album6', 'Album 6', 'Video', 'group1', '2022-06-01', 'No'),
('album7', 'Album 7', 'Audio', 'group2', '2019-07-01', 'Yes'),
('album8', 'Album 8', 'Video', 'group3', '2020-08-01', 'No'),
('album9', 'Album 9', 'Audio', 'group4', '2021-09-01', 'Yes'),
('album10', 'Album 10', 'Video', 'group5', '2020-10-01', 'No');

-- Populate Trailer_Views
INSERT INTO Trailer_Views (Trailer_Views_ID, Music_Album_ID, Trailer_Views_Release_Date, Trailer_Views_Number_of_Visits, Trailer_Views_Number_of_Likes, Trailer_Views_Number_of_Dislikes, Trailer_Views_Deletion_Date) VALUES
('trailer1', 'album1', '2023-01-01', 10000, 8000, 2000, '2023-01-02'),
('trailer2', 'album2', '2023-02-01', 12000, 10000, 2000, '2023-02-02'),
('trailer3', 'album3', '2023-03-01', 15000, 12000, 3000, '2023-03-02'),
('trailer4', 'album4', '2023-04-01', 8000, 6000, 2000, '2023-04-02'),
('trailer5', 'album5', '2023-05-01', 20000, 18000, 2000, '2023-05-02'),
('trailer6', 'album6', '2023-06-01', 18000, 16000, 2000, '2023-06-02'),
('trailer7', 'album7', '2023-07-01', 22000, 20000, 2000, '2023-07-02'),
('trailer8', 'album8', '2023-08-01', 25000, 23000, 2000, '2023-08-02'),
('trailer9', 'album9', '2023-09-01', 30000, 28000, 2000, '2023-09-02'),
('trailer10', 'album10', '2023-10-01', 35000, 33000, 2000, '2023-10-02');

-- Populate Distributor
INSERT INTO Distributor (Distributor_ID, Distributor_Name, Distributor_Negotiated_Price, Music_Album_ID) VALUES
('distributor1', 'Distributor A', 10000.00, 'album1'),
('distributor2', 'Distributor B', 12000.00, 'album2'),
('distributor3', 'Distributor C', 15000.00, 'album3'),
('distributor4', 'Distributor D', 8000.00, 'album4'),
('distributor5', 'Distributor E', 20000.00, 'album5'),
('distributor6', 'Distributor F', 18000.00, 'album6'),
('distributor7', 'Distributor G', 22000.00, 'album7'),
('distributor8', 'Distributor H', 25000.00, 'album8'),
('distributor9', 'Distributor I', 30000.00, 'album9'),
('distributor10', 'Distributor J', 35000.00, 'album10');

-- Populate Download_Request
INSERT INTO Download_Request (Distributor_ID, Music_Album_ID, Download_Request_ID, Download_Request_URL, Download_Request_Date, Download_Request_Status) VALUES
('distributor1', 'album1', 1, 'https://example.com/download1', '2023-01-01', 'Success'),
('distributor2', 'album2', 2, 'https://example.com/download2', '2023-02-01', 'Failure'),
('distributor3', 'album3', 3, 'https://example.com/download3', '2023-03-01', 'Success'),
('distributor4', 'album4', 4, 'https://example.com/download4', '2023-04-01', 'Success'),
('distributor5', 'album5', 5, 'https://example.com/download5', '2023-05-01', 'Failure'),
('distributor6', 'album6', 6, 'https://example.com/download6', '2023-06-01', 'Success'),
('distributor7', 'album7', 7, 'https://example.com/download7', '2023-07-01', 'Failure'),
('distributor8', 'album8', 8, 'https://example.com/download8', '2023-08-01', 'Success'),
('distributor9', 'album9', 9, 'https://example.com/download9', '2023-09-01', 'Success'),
('distributor10', 'album10', 10, 'https://example.com/download10', '2023-10-01', 'Failure');



-- List all ‘Audio’ albums released in 2020
SELECT *
FROM Music_Album
WHERE Music_Album_Type = 'Audio'
AND YEAR(Music_Album_Release_Date) = 2020;

-- List all members who have been the member of more than one group
SELECT Candidate_ID, COUNT(DISTINCT Music_Group_ID) AS Num_Music_Groups
FROM Member_
GROUP BY Candidate_ID
HAVING COUNT(DISTINCT Music_Group_ID) > 1;

-- List all members of ‘Pop’ music group who are not part of any other music group
SELECT member.*
FROM Member_ member
INNER JOIN Music_Group music_group ON member.Music_Group_ID = music_group.Music_Group_ID
WHERE music_group.Music_Group_Type = 'pop'
AND music_group.Candidate_ID NOT IN (
    SELECT Candidate_ID FROM Member_
    WHERE Music_Group_ID != music_group.Music_Group_ID
);

SELECT m.*
FROM Member_ m
INNER JOIN Music_Group mg ON m.Music_Group_ID = mg.Music_Group_ID
WHERE mg.Music_Group_Type = 'pop'
AND NOT EXISTS (
    SELECT 1
    FROM Member_ m2
    WHERE m2.Candidate_ID = m.Candidate_ID
    AND m2.Music_Group_ID != m.Music_Group_ID
);

-- List all participants who have submitted both Audio and Video files
SELECT Candidate_ID, Candidate_Name
FROM Candidate
WHERE Candidate_Media_Type = 'Audio,Video';

-- The McM company would like to analyze the data for “Which advertisement channel has been effective that attracted maximum number of entry submissions?”
SELECT Channel_Number, COUNT(*) AS Max_Entry_by_Candidates
FROM Candidate
GROUP BY Channel_Number
ORDER BY Max_Entry_by_Candidates DESC
LIMIT 1;