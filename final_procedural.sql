-- student: access courses
CREATE OR REPLACE FUNCTION get_student_courses(p_student_id VARCHAR)
RETURNS TABLE (
    student_id VARCHAR,
    student_name VARCHAR,
    course_name VARCHAR,
    semester VARCHAR,
    academic_year INT,  -- match the table type
    grade CHAR(1)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        s.student_id,
        s.name,
        c.course_name,
        cs.semester,
        cs.academic_year,
        g.grade
    FROM Student s
    JOIN Enrollment e ON s.student_id = e.student_id
    JOIN Course_Section cs ON e.section_id = cs.section_id
    JOIN Course c ON cs.course_id = c.course_id
    LEFT JOIN Grade g ON g.enrollment_id = e.enrollment_id
    WHERE s.student_id = p_student_id;
END;
$$ LANGUAGE plpgsql;

-- ################################################

-- instructor : enter grade
CREATE OR REPLACE FUNCTION enter_grade(
    p_enrollment_id VARCHAR,
    p_grade VARCHAR,
    p_grade_points NUMERIC
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    v_grade_id VARCHAR(4);
BEGIN
    -- Generate next grade_id (G001, G002, ...)
    SELECT 'G' || LPAD((COALESCE(MAX(SUBSTRING(grade_id FROM 2)::INT), 0) + 1)::TEXT, 3, '0')
    INTO v_grade_id
    FROM grade;

    INSERT INTO grade (grade_id, enrollment_id, grade, grade_points)
    VALUES (v_grade_id, p_enrollment_id, p_grade, p_grade_points)
    ON CONFLICT (enrollment_id)
    DO UPDATE
    SET grade = EXCLUDED.grade,
        grade_points = EXCLUDED.grade_points;
END;
$$;

-- ################################################

-- registrar
CREATE OR REPLACE FUNCTION add_enrollment(
    p_enrollment_id VARCHAR,
    p_student_id VARCHAR,
    p_section_id VARCHAR,
    p_status VARCHAR
)
RETURNS VOID
AS $$
BEGIN
    INSERT INTO Enrollment (enrollment_id, student_id, section_id, enrollment_status)
    VALUES (p_enrollment_id, p_student_id, p_section_id, p_status);
END;
$$ LANGUAGE plpgsql;

-- ################################################

CREATE OR REPLACE FUNCTION check_graduation_requirements(p_student_id VARCHAR(4))
RETURNS TABLE (
	Section_title TEXT,
	Requirement_details TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
v_program VARCHAR(2);
v_major_id VARCHAR(4);
v_student_name VARCHAR(100);

-- Program Based Requirements
v_core_courses_required INT;
v_core_credits_required INT;
v_elective_courses_required INT;
v_elective_credits_required INT;
v_pillar_courses_required INT := 6;
v_pillar_credits_required INT := 24;
v_arts_courses_required INT := 1;
v_arts_credits_required INT := 4;
v_total_courses_required INT;
v_total_credits_required INT;

-- Current Student Progress
 v_core_courses_completed INT;
 v_core_credits_completed INT;
 v_elective_courses_completed INT;
 v_elective_credits_completed INT;
 v_pillar_courses_completed INT;
 v_pillar_credits_completed INT;
 v_arts_courses_completed INT;
 v_arts_credits_completed INT;
 v_total_courses_completed INT;
 v_total_credits_completed INT;
 v_current_gpa DECIMAL(4,2);

 -- What's needed
v_core_courses_needed INT;
v_core_credits_needed INT;
v_elective_courses_needed INT;
v_elective_credits_needed INT;
v_pillar_courses_needed INT;
v_pillar_credits_needed INT;
v_arts_courses_needed INT;
v_arts_credits_needed INT;
v_total_courses_needed INT;
v_total_credits_needed INT;

BEGIN
SELECT s.program, s.major_id, s.name 
INTO v_program, v_major_id, v_student_name
FROM Student s
WHERE s.student_id = p_student_id;

IF NOT FOUND THEN
	RAISE EXCEPTION 'Student ID: % Not Found.' , p_student_id;
END IF;


IF v_program = 'AA' THEN
v_core_courses_required := 5;
v_core_credits_required := 20;
v_elective_courses_required := 3;
v_elective_credits_required := 12;
v_total_courses_required := 15;
v_total_credits_required := 60;
ELSIF v_program = 'BA' THEN
v_core_courses_required := 8;
v_core_credits_required := 32;
v_elective_courses_required := 8;
v_elective_credits_required := 32;
v_total_courses_required := 30;
v_total_credits_required := 120;
END IF;

SELECT 
COALESCE(COUNT(DISTINCT e.section_id), 0),
COALESCE(SUM(c.credit_hours), 0)
INTO
v_core_courses_completed,
v_core_credits_completed
FROM Enrollment e
JOIN Course_Section cs ON e.section_id = cs.section_id
JOIN Course c ON cs.course_id = c.course_id
JOIN Major_Course_Requirement mcr ON c.course_id = mcr.course_id
	AND mcr.major_id = v_major_id
	AND mcr.requirement_type = 'core'
WHERE e.student_id = p_student_id
	AND e.enrollment_status = 'completed';

SELECT
	COALESCE(COUNT(DISTINCT e.section_id), 0),
	COALESCE(SUM(c.credit_hours), 0)
INTO 
	v_pillar_courses_completed,
	v_pillar_credits_completed
FROM Enrollment e
JOIN Course_Section cs ON e.section_id = cs.section_id
JOIN Course c ON cs.course_id = c.course_id
JOIN Major_Course_Requirement mcr ON c.course_id = mcr.course_id
	AND mcr.major_id = v_major_id
	AND mcr.requirement_type = 'pillar'
WHERE e.student_id = p_student_id
	AND e.enrollment_status = 'completed';

SELECT
	COALESCE(COUNT(DISTINCT e.section_id), 0),
	COALESCE(SUM(c.credit_hours), 0)
INTO 
	v_arts_courses_completed,
	v_arts_credits_completed
FROM Enrollment e
JOIN Course_Section cs ON e.section_id = cs.section_id
JOIN Course c ON cs.course_id = c.course_id
JOIN Major_Course_Requirement mcr on c.course_id = mcr.course_id
	AND mcr.major_id = v_major_id
	AND mcr.requirement_type = 'arts'
WHERE e.student_id = p_student_id
	AND e.enrollment_status = 'completed';

SELECT
	COALESCE(COUNT(DISTINCT e.section_id), 0),
	COALESCE(SUM(c.credit_hours), 0)
INTO
	v_elective_courses_completed,
	v_elective_credits_completed
FROM Enrollment e
JOIN Course_Section cs ON e.section_id = cs.section_id
JOIN Course c ON cs.course_id = c.course_id
WHERE e.student_id = p_student_id
	AND e.enrollment_status = 'completed'
	AND c.course_id NOT IN (
		SELECT course_id
		FROM Major_Course_Requirement
		WHERE major_id = v_major_id
	);

SELECT 
	COALESCE(COUNT(DISTINCT e.section_id), 0),
	COALESCE(SUM(c.credit_hours), 0)
INTO
	v_total_courses_completed,
	v_total_credits_completed
FROM Enrollment e
JOIN Course_Section cs ON e.section_id = cs.section_id
JOIN Course c ON cs.course_id = c.course_id
WHERE e.student_id = p_student_id
	AND e.enrollment_status = 'completed';

SELECT
	COALESCE(ROUND(AVG(g.grade_points), 2), 0.00)
INTO v_current_gpa
FROM Enrollment e
JOIN Grade g ON e.enrollment_id = g.enrollment_id
WHERE e.student_id = p_student_id
	AND e.enrollment_status = 'completed'
	AND g.grade_points IS NOT NULL;

v_core_courses_needed := GREATEST(0, v_core_courses_required - v_core_courses_completed);
v_core_credits_needed := GREATEST(0, v_core_credits_required - v_core_credits_completed);
v_elective_courses_needed := GREATEST(0, v_elective_courses_required - v_elective_courses_completed);
v_elective_credits_needed := GREATEST(0, v_elective_credits_required - v_elective_credits_completed);
v_pillar_courses_needed := GREATEST(0, v_pillar_courses_required - v_pillar_courses_completed);
v_pillar_credits_needed := GREATEST(0, v_pillar_credits_required - v_pillar_credits_completed);
v_arts_courses_needed := GREATEST(0, v_arts_courses_required - v_arts_courses_completed);
v_arts_credits_needed := GREATEST(0, v_arts_credits_required - v_arts_credits_completed);
v_total_courses_needed := GREATEST(0, v_total_courses_required - v_total_courses_completed);
v_total_credits_needed := GREATEST(0, v_total_credits_required - v_total_credits_completed);

-- Haven't vetted code. 
   RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        'GRADUATION REQUIREMENTS CHECK'::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        'Student'::TEXT,
        (v_student_name || ' (' || p_student_id || ')')::TEXT;
    
    RETURN QUERY SELECT 
        'Program'::TEXT,
        v_program::TEXT;
    
    RETURN QUERY SELECT 
        'Major ID'::TEXT,
        v_major_id::TEXT;
    
    RETURN QUERY SELECT 
        ''::TEXT,
        ''::TEXT;
    
    -- Section 1: Requirements to Graduate
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        '1. REQUIREMENTS TO GRADUATE'::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        'Core Courses'::TEXT,
        (v_core_courses_required || ' courses (' || v_core_credits_required || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Elective Courses'::TEXT,
        (v_elective_courses_required || ' courses (' || v_elective_credits_required || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Pillar Courses'::TEXT,
        (v_pillar_courses_required || ' courses (' || v_pillar_credits_required || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Arts/General Electives'::TEXT,
        (v_arts_courses_required || ' course (' || v_arts_credits_required || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        '-----------------------------------------'::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        'TOTAL'::TEXT,
        (v_total_courses_required || ' courses (' || v_total_credits_required || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Minimum GPA'::TEXT,
        '2.00'::TEXT;
    
    RETURN QUERY SELECT 
        ''::TEXT,
        ''::TEXT;
    
    -- Section 2: Current Progress
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        '2. CURRENT PROGRESS'::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        'Core Courses'::TEXT,
        (v_core_courses_completed || ' courses (' || v_core_credits_completed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Elective Courses'::TEXT,
        (v_elective_courses_completed || ' courses (' || v_elective_credits_completed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Pillar Courses'::TEXT,
        (v_pillar_courses_completed || ' courses (' || v_pillar_credits_completed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Arts/General Electives'::TEXT,
        (v_arts_courses_completed || ' course (' || v_arts_credits_completed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        '-----------------------------------------'::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        'TOTAL'::TEXT,
        (v_total_courses_completed || ' courses (' || v_total_credits_completed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Current GPA'::TEXT,
        v_current_gpa::TEXT;
    
    RETURN QUERY SELECT 
        ''::TEXT,
        ''::TEXT;
    
    -- Section 3: What's Needed
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        '3. REMAINING REQUIREMENTS'::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        'Core Courses'::TEXT,
        (v_core_courses_needed || ' more courses (' || v_core_credits_needed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Elective Courses'::TEXT,
        (v_elective_courses_needed || ' more courses (' || v_elective_credits_needed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Pillar Courses'::TEXT,
        (v_pillar_courses_needed || ' more courses (' || v_pillar_credits_needed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        'Arts/General Electives'::TEXT,
        (v_arts_courses_needed || ' more course (' || v_arts_credits_needed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        '-----------------------------------------'::TEXT,
        ''::TEXT;
    
    RETURN QUERY SELECT 
        'TOTAL REMAINING'::TEXT,
        (v_total_courses_needed || ' courses (' || v_total_credits_needed || ' credits)')::TEXT;
    
    RETURN QUERY SELECT 
        ''::TEXT,
        ''::TEXT;
    
    -- Graduation eligibility
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    IF v_total_courses_needed = 0 AND v_total_credits_needed = 0 AND v_current_gpa >= 2.00 THEN
        RETURN QUERY SELECT 
            'STATUS'::TEXT,
            '✓ ELIGIBLE TO GRADUATE'::TEXT;
    ELSE
        RETURN QUERY SELECT 
            'STATUS'::TEXT,
            '✗ NOT YET ELIGIBLE TO GRADUATE'::TEXT;
    END IF;
    
    RETURN QUERY SELECT 
        '========================================='::TEXT,
        ''::TEXT;
    
    RETURN;
END;
$$;





