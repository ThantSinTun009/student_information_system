

-- Department
CREATE TABLE Department (
    department_id VARCHAR(4) PRIMARY KEY CHECK (department_id ~ '^D[0-9]{3}$'),
    department_name VARCHAR(100) NOT NULL 
); 

-- Major / Program
CREATE TABLE Major (
    major_id VARCHAR(4) PRIMARY KEY CHECK (major_id ~ '^M[0-9]{3}$'),
    major_name VARCHAR(100) NOT NULL,
    department_id VARCHAR(4) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('active', 'postponed')), 
    CONSTRAINT fk_major_department
        FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- Student
CREATE TABLE Student (
    student_id VARCHAR(4) PRIMARY KEY CHECK (student_id ~ '^S[0-9]{3}$'),
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    class_of_year INT,
    gender VARCHAR(1) CHECK (gender IN ('M', 'F')),
    email VARCHAR(100) UNIQUE CHECK (email ~ '^[A-Za-z0-9._%+-]+@university\.edu$'),
    program VARCHAR(2) NOT NULL CHECK (program IN ('AA', 'BA')),
    address VARCHAR(100),
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('active', 'graduated', 'suspended')),
    major_id VARCHAR(4),
    CONSTRAINT fk_student_major
        FOREIGN KEY (major_id)
        REFERENCES Major(major_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);



-- Staff
CREATE TABLE Staff (
    staff_id VARCHAR(5) PRIMARY KEY 
CHECK  (staff_id ~ '^ST[0-9]{3}$'),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE 
CHECK (email ~ '^[A-Za-z0-9._%+-]+@university\.edu$'),
    position VARCHAR(100)
CHECK (position IN ('Instructor', 'Tech Support', 'Registrar', 'Administrator')),
    role VARCHAR(50)
CHECK (role IN ('Academics', 'Administration')),
    department_id VARCHAR(4) NOT NULL,
    CONSTRAINT fk_staff_department
        FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);



-- Course
CREATE TABLE Course (
    course_id VARCHAR(7) PRIMARY KEY CHECK (course_id ~ '^[A-Z]{2,4}[0-9]{3}$'),
    course_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL,
    major_id VARCHAR(4),
    CONSTRAINT fk_course_department
        FOREIGN KEY (major_id)
        REFERENCES Major(major_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Course Section
CREATE TABLE Course_Section (
    section_id VARCHAR (5) PRIMARY KEY CHECK(section_id ~ '^CS[0-9]{3}$'),
    course_id VARCHAR(7) NOT NULL,
    instructor_id VARCHAR(5) NOT NULL,
    semester VARCHAR(20)
        CHECK (semester IN ('Fall', 'Spring', 'Summer')),
    academic_year INT,
    CONSTRAINT fk_section_course
        FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_section_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES Staff(staff_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Enrollment
CREATE TABLE Enrollment (
    enrollment_id VARCHAR(4) PRIMARY KEY CHECK (enrollment_id ~ '^E[0-9]{3}$'), 
    student_id VARCHAR(4) NOT NULL,
    section_id VARCHAR(5) NOT NULL,
    enrollment_status VARCHAR(20)
        CHECK (enrollment_status IN ('enrolled', 'dropped', 'completed')),
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES Student(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_section
        FOREIGN KEY (section_id)
        REFERENCES Course_Section(section_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT uq_student_section UNIQUE (student_id, section_id)
);

-- Grade
CREATE TABLE Grade (
    grade_id VARCHAR(4) PRIMARY KEY CHECK (grade_id ~ '^G[0-9]{3}$'),
    enrollment_id VARCHAR(4) NOT NULL,
    grade CHAR(1)
        CHECK (grade IN ('A', 'B', 'C', 'D', 'E', 'F')),
    grade_points DECIMAL(3,2),
    CONSTRAINT fk_grade_enrollment
        FOREIGN KEY (enrollment_id)
        REFERENCES Enrollment(enrollment_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT uq_grade_enrollment UNIQUE (enrollment_id)
);

CREATE TABLE Major_Course_Requirement (
	major_id VARCHAR(4) NOT NULL,
	course_id VARCHAR(7) NOT NULL,
requirement_type VARCHAR(20) 
	CHECK (requirement_type IN ('core', 'pillar', 'arts')),
CONSTRAINT pk_major_requirement
	PRIMARY KEY(major_id, course_id),
CONSTRAINT fk_mcr_major
	FOREIGN KEY (major_id)
	REFERENCES Major (major_id),
CONSTRAINT fk_mcr_course
	FOREIGN KEY (course_id)
	REFERENCES Course(course_id)
);







