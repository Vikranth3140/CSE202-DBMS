-- List all ‘Audio’ albums released in 2020
SELECT *
FROM Music_Album
WHERE Music_Album_Type = 'Audio'
AND YEAR(Music_Album_Release_Date) = 2020;

-- List all members who have been the member of more than one group
SELECT Candidate_ID, COUNT(DISTINCT Music_Group_ID) AS More_than_one_group
FROM Member_
GROUP BY Candidate_ID
HAVING COUNT(DISTINCT Music_Group_ID) > 1;

-- List all members of ‘Pop’ music group who are not part of any other music group
SELECT M.Member_ID, M.Music_Group_ID, M.Candidate_ID, M.Member_Role, M.Is_Director
FROM Member_ M
NATURAL JOIN (
    SELECT R1.Member_ID, R1.Music_Group_ID
    FROM Member_ R1
    WHERE EXISTS (
        SELECT *
        FROM Music_Group
        WHERE Music_Group_ID = R1.Music_Group_ID
        AND Music_Group_Type = 'pop'
    )
    AND NOT EXISTS (
        SELECT *
        FROM Member_ R2
        WHERE R2.Member_ID = R1.Member_ID
        AND R2.Music_Group_ID <> R1.Music_Group_ID
    )
) AS MEMBER2;

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