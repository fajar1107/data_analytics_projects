USE student_performance;

SHOW TABLES;

SELECT * FROM studentsperformance_processed;

SELECT
	gender,
	AVG(average_score) AS average_score
FROM studentsperformance_processed
GROUP BY gender
ORDER BY average_score DESC;

SELECT
	race_ethnicity,
	AVG(average_score) AS average_score
FROM studentsperformance_processed
GROUP BY race_ethnicity
ORDER BY average_score DESC;

SELECT
	parental_level_of_education,
    AVG(average_score) AS average_score
FROM studentsperformance_processed
GROUP BY parental_level_of_education
ORDER BY average_score DESC;

SELECT
	parental_level_of_education,
    AVG(average_score) AS average_score
FROM studentsperformance_processed
GROUP BY parental_level_of_education
ORDER BY average_score DESC;

SELECT
	lunch,
    AVG(average_score) AS average_score
FROM studentsperformance_processed
GROUP BY lunch
ORDER BY average_score DESC;

SELECT
	test_preparation_course,
    AVG(average_score) AS average_score
FROM studentsperformance_processed
GROUP BY test_preparation_course
ORDER BY average_score DESC;





