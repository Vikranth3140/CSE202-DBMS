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