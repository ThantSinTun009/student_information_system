-- CREATE ROLE student_role;
-- CREATE ROLE instructor_role;
-- CREATE ROLE registrar_role;
-- CREATE ROLE admin_role;


-- Student View

SET app.student_id = ‘S001’;

ALTER TABLE enrollment ENABLE ROW LEVEL SECURITY;

CREATE POLICY student_own_rows
ON enrollment
FOR SELECT
TO student_role
USING (
    student_id = current_setting('app.student_id')
);

-- Student - course view

CREATE OR REPLACE VIEW v_student_courses AS
SELECT
    s.student_id,
    s.name,
    c.course_name,
    cs.semester,
    cs.academic_year,
    g.grade
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN course_section cs ON e.section_id = cs.section_id
JOIN course c ON cs.course_id = c.course_id
LEFT JOIN grade g
       ON g.enrollment_id = e.enrollment_id;
 

GRANT SELECT ON v_student_courses TO student_role;

-- ######################################################################

-- Instructor View

SET app.staff_id = 'ST003';
ALTER TABLE Course_Section ENABLE ROW LEVEL SECURITY;

CREATE POLICY instructor_own_sections
ON course_section
FOR SELECT
TO instructor_role
USING (instructor_id = current_setting('app.staff_id')

);

-- Create a view including instructor_id and enrollment_id
CREATE OR REPLACE VIEW v_instructor_sections AS
SELECT
    cs.section_id,
    cs.instructor_id,       -- instructor
    c.course_name,
    s.student_id,
    s.name AS student_name,
    e.enrollment_id,        -- <--- needed for entering grades
    g.grade
FROM course_section cs
JOIN course c ON cs.course_id = c.course_id
LEFT JOIN enrollment e ON cs.section_id = e.section_id
LEFT JOIN student s ON e.student_id = s.student_id
LEFT JOIN grade g ON g.enrollment_id = e.enrollment_id;

SET app.staff_id = 'ST003';

-- Select only this instructor's sections
SELECT *
FROM v_instructor_sections
WHERE instructor_id = current_setting('app.staff_id');

GRANT SELECT, UPDATE (grade) ON v_instructor_sections TO instructor_role;

-- ######################################################################

-- Register View

GRANT SELECT ON student, course, course_section, enrollment, grade TO registrar_role;

GRANT INSERT, UPDATE ON enrollment TO registrar_role;

CREATE OR REPLACE VIEW v_registrar_transcripts AS
SELECT
    s.student_id,
    s.name AS student_name,
    c.course_name,
    cs.semester,
    cs.academic_year,
    g.grade,
    e.enrollment_id
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN course_section cs ON e.section_id = cs.section_id
JOIN course c ON cs.course_id = c.course_id
LEFT JOIN grade g ON g.enrollment_id = e.enrollment_id;

-- Grant SELECT to registrar
GRANT SELECT ON v_registrar_transcripts TO registrar_role;



