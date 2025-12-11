CREATE OR REPLACE VIEW vw_student_transcript AS
SELECT
  s.student_id,
  s.student_number,
  s.first_name || ' ' || s.last_name AS student_name,
  e.enrollment_id,
  c.course_code,
  c.title AS course_title,
  e.grade_numeric,
  e.grade_letter,
  e.status,
  c.credits
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN courses c ON c.course_id = e.course_id
WHERE e.status = 'completed';

CREATE OR REPLACE VIEW vw_student_gpa AS
SELECT
  s.student_id,
  s.student_number,
  s.first_name || ' ' || s.last_name AS student_name,
  COUNT(e.enrollment_id) FILTER (WHERE e.status='completed') AS courses_completed,
  AVG(e.grade_numeric) FILTER (WHERE e.status='completed') AS avg_score,
  SUM(c.credits) FILTER (WHERE e.status='completed') AS total_credits
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.student_id
LEFT JOIN courses c ON c.course_id = e.course_id
GROUP BY s.student_id, s.student_number, s.first_name, s.last_name;

CREATE OR REPLACE VIEW vw_course_roster_attendance AS
SELECT
  c.course_id,
  c.course_code,
  c.title AS course_title,
  s.student_id,
  s.first_name || ' ' || s.last_name AS student_name,
  COUNT(a.attendance_id) FILTER (WHERE a.status = 'present') AS present_count,
  COUNT(a.attendance_id) AS total_sessions,
  CASE WHEN COUNT(a.attendance_id) = 0 THEN NULL
       ELSE ROUND(100.0 * COUNT(a.attendance_id) FILTER (WHERE a.status = 'present') / COUNT(a.attendance_id), 2)
  END AS attendance_pct
FROM courses c
JOIN enrollments e ON e.course_id = c.course_id AND e.status IN ('enrolled','completed')
JOIN students s ON s.student_id = e.student_id
LEFT JOIN class_schedules cs ON cs.course_id = c.course_id
LEFT JOIN attendances a ON a.schedule_id = cs.schedule_id AND a.student_id = s.student_id
GROUP BY c.course_id, c.course_code, c.title, s.student_id, s.first_name, s.last_name;
