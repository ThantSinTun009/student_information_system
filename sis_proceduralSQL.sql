-- 1) Add new student (returns student_id)
CREATE OR REPLACE FUNCTION fn_add_student(
  p_student_number VARCHAR,
  p_first_name     VARCHAR,
  p_last_name      VARCHAR,
  p_email          VARCHAR,
  p_dob            DATE
) RETURNS INTEGER AS $$
DECLARE
  v_id INTEGER;
BEGIN
  INSERT INTO students(student_number, first_name, last_name, email, dob)
  VALUES (p_student_number, p_first_name, p_last_name, p_email, p_dob)
  RETURNING student_id INTO v_id;
  RETURN v_id;
EXCEPTION WHEN unique_violation THEN
  RAISE EXCEPTION 'Student with that number or email already exists';
END;
$$ LANGUAGE plpgsql;


-- 2) Enroll student in a course (checks: student active, not already enrolled)
CREATE OR REPLACE FUNCTION fn_enroll_student(
  p_student_id INTEGER,
  p_course_id  INTEGER
) RETURNS INTEGER AS $$
DECLARE
  v_enroll_id INTEGER;
  v_status TEXT;
BEGIN
  SELECT status INTO v_status FROM students WHERE student_id = p_student_id;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Student % not found', p_student_id;
  END IF;
  IF v_status <> 'active' THEN
    RAISE EXCEPTION 'Only active students can enroll';
  END IF;

  -- check for existing enrollment
  IF EXISTS (SELECT 1 FROM enrollments WHERE student_id = p_student_id AND course_id = p_course_id) THEN
    RAISE EXCEPTION 'Student % already enrolled in course %', p_student_id, p_course_id;
  END IF;

  INSERT INTO enrollments(student_id, course_id, enroll_date, status)
  VALUES (p_student_id, p_course_id, CURRENT_DATE, 'enrolled')
  RETURNING enrollment_id INTO v_enroll_id;

  RETURN v_enroll_id;
END;
$$ LANGUAGE plpgsql;


-- 3) Record final grade for an enrollment (numeric -> letter mapping example)
CREATE OR REPLACE FUNCTION fn_set_final_grade(
  p_enrollment_id INTEGER,
  p_grade_numeric NUMERIC
) RETURNS VOID AS $$
DECLARE
  v_letter VARCHAR(2);
BEGIN
  IF p_grade_numeric IS NULL OR p_grade_numeric < 0 OR p_grade_numeric > 100 THEN
    RAISE EXCEPTION 'Grade must be between 0 and 100';
  END IF;

  -- simple conversion
  IF p_grade_numeric >= 85 THEN
    v_letter := 'A';
  ELSIF p_grade_numeric >= 70 THEN
    v_letter := 'B';
  ELSIF p_grade_numeric >= 55 THEN
    v_letter := 'C';
  ELSIF p_grade_numeric >= 40 THEN
    v_letter := 'D';
  ELSE
    v_letter := 'F';
  END IF;

  UPDATE enrollments
  SET grade_numeric = p_grade_numeric,
      grade_letter  = v_letter,
      status        = 'completed'
  WHERE enrollment_id = p_enrollment_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Enrollment % not found', p_enrollment_id;
  END IF;
END;
$$ LANGUAGE plpgsql;
