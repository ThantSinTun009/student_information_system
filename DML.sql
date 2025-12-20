-- 1. Add new student
INSERT INTO Student (student_id, name, date_of_birth, class_of_year, gender, email, program, address, status, major_id)
VALUES ('S101', 'Thant', '2004-04-9', 2027, 'M','thantsintun2004@university.edu', 'BA', 'Sagaing', 'active', 'M001');

SELECT *
FROM Student
WHERE student_id = 'S101';

-- ######################################################################

-- 2. Enroll student
INSERT INTO Enrollment (enrollment_id, student_id, section_id, enrollment_status)
VALUES ('E200', 'S101', 'CS043', 'enrolled');

-- Check if enrollment is completed
SELECT e.enrollment_id, s.name AS student_name, cs.section_id, c.course_name, e.enrollment_status
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Course_Section cs ON e.section_id = cs.section_id
JOIN Course c ON cs.course_id = c.course_id
WHERE e.enrollment_id = 'E200';


-- ######################################################################

-- 3. Update a student's status if he/she suspended
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


-- ######################################################################

-- 4. Drop a course
DELETE FROM Enrollment
WHERE enrollment_id = 'E021';

-- Check if there is still enrollment
SELECT *
FROM Enrollment
WHERE enrollment_id = 'E021';

-- ######################################################################

-- 5. Assign grades as an instructor
UPDATE Grade
SET grade = 'A', grade_points = 4.0
WHERE enrollment_id = 'E017';

-- Check
SELECT enrollment_id, grade, grade_points
FROM Grade
WHERE enrollment_id = 'E017';

-- ######################################################################