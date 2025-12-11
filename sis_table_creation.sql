-- 1. students
CREATE TABLE students (
  student_id       SERIAL PRIMARY KEY,
  student_number   VARCHAR(20) NOT NULL UNIQUE, -- e.g. uni id
  first_name       VARCHAR(100) NOT NULL,
  last_name        VARCHAR(100) NOT NULL,
  email            VARCHAR(255) NOT NULL UNIQUE,
  dob              DATE,
  enrolled_date    DATE NOT NULL DEFAULT CURRENT_DATE,
  status           VARCHAR(20) NOT NULL DEFAULT 'active' -- active, inactive, graduated
);

-- 2. teachers
CREATE TABLE teachers (
  teacher_id     SERIAL PRIMARY KEY,
  staff_number   VARCHAR(20) NOT NULL UNIQUE,
  first_name     VARCHAR(100) NOT NULL,
  last_name      VARCHAR(100) NOT NULL,
  email          VARCHAR(255) UNIQUE,
  hire_date      DATE,
  department     VARCHAR(100)
);

-- 3. courses
CREATE TABLE courses (
  course_id      SERIAL PRIMARY KEY,
  course_code    VARCHAR(20) NOT NULL UNIQUE,
  title          VARCHAR(200) NOT NULL,
  description    TEXT,
  credits        NUMERIC(3,1) NOT NULL DEFAULT 3.0,
  teacher_id     INTEGER REFERENCES teachers(teacher_id) ON DELETE SET NULL
);

-- 4. enrollments (linking student <-> course)
CREATE TABLE enrollments (
  enrollment_id  SERIAL PRIMARY KEY,
  student_id     INTEGER NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  course_id      INTEGER NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
  enroll_date    DATE NOT NULL DEFAULT CURRENT_DATE,
  status         VARCHAR(20) NOT NULL DEFAULT 'enrolled', -- enrolled, dropped, completed
  grade_numeric  NUMERIC(5,2),   -- e.g. numeric score
  grade_letter   VARCHAR(2),     -- e.g. A, B+, C-
  UNIQUE(student_id, course_id) -- no duplicate enrollments
);

-- 5. class_schedules (individual class sessions / timetable)
CREATE TABLE class_schedules (
  schedule_id    SERIAL PRIMARY KEY,
  course_id      INTEGER NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
  session_date   DATE NOT NULL,
  start_time     TIME,
  end_time       TIME,
  location       VARCHAR(200),
  topic          VARCHAR(255)
);

-- 6. attendances (links student <-> class_schedules)
CREATE TABLE attendances (
  attendance_id  SERIAL PRIMARY KEY,
  schedule_id    INTEGER NOT NULL REFERENCES class_schedules(schedule_id) ON DELETE CASCADE,
  student_id     INTEGER NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  status         VARCHAR(20) NOT NULL DEFAULT 'present', -- present, absent, late, excused
  note           TEXT,
  recorded_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(schedule_id, student_id)
);

-- 7. payments
CREATE TABLE payments (
  payment_id     SERIAL PRIMARY KEY,
  student_id     INTEGER NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  amount         NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
  payment_date   DATE NOT NULL DEFAULT CURRENT_DATE,
  method         VARCHAR(50), -- cash, card, bank_transfer
  reference      VARCHAR(100)
);
