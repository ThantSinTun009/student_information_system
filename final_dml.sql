-- 1). Compare the total students from each major at the University.

SELECT 
    m.major_name, 
    COUNT(s.student_id) AS total_students
FROM 
    Major m
LEFT JOIN 
    Student s ON m.major_id = s.major_id
GROUP BY 
    m.major_id, 
    m.major_name
ORDER BY 
    total_students DESC;

-- ##############################################

-- 2). Select top 10 students with highest gpa for fall 2023 semester. 

SELECT 
    s.student_id, 
    s.name, 
    ROUND(AVG(g.grade_points), 2) AS semester_gpa
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Grade g ON e.enrollment_id = g.enrollment_id
JOIN Course_Section cs ON e.section_id = cs.section_id
WHERE 
    cs.semester = 'Fall' 
    AND cs.academic_year = 2023
    AND e.enrollment_status = 'completed'
GROUP BY 
    s.student_id, 
    s.name
ORDER BY 
    semester_gpa DESC
LIMIT 10;

-- ##############################################

-- 3). List total courses for each major.
SELECT 
    d.department_name,
    m.major_name, 
    COUNT(c.course_id) AS total_courses
FROM 
    Department d
JOIN Major m ON d.department_id = m.department_id
LEFT JOIN Course c ON m.major_id = c.major_id
GROUP BY 
    d.department_name, m.major_id, m.major_name
ORDER BY 
    d.department_name;

-- ##############################################

-- 4). Enroll student
INSERT INTO Enrollment (enrollment_id, student_id, section_id, enrollment_status)
VALUES ('E200', 'S101', 'CS043', 'enrolled');

-- Check if enrollment is completed
SELECT e.enrollment_id, s.name AS student_name, cs.section_id, c.course_name, e.enrollment_status
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Course_Section cs ON e.section_id = cs.section_id
JOIN Course c ON cs.course_id = c.course_id
WHERE e.enrollment_id = 'E200';

-- ##############################################

-- 5). Update a student's status if he/she suspended
UPDATE Student
SET status = 'suspended'
WHERE student_id = 'S050';

-- Verify status along with current enrollments
SELECT s.student_id, s.name, s.status, c.course_name, cs.semester
FROM Student s
LEFT JOIN Enrollment e ON s.student_id = e.student_id
LEFT JOIN Course_Section cs ON e.section_id = cs.section_id
LEFT JOIN Course c ON cs.course_id = c.course_id
WHERE s.student_id = 'S050';
