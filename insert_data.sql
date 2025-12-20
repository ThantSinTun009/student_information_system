--Department Table

INSERT INTO Department (department_id, department_name) VALUES
('D001', 'Social Sciences and Humanities'),
('D002', 'Sciences and Mathematics'),
('D003', 'Arts and Creative Studies'),
('D004', 'Administration'),
('D005', 'IT Support');

-- Should we make department name as 'Department of *'? 

-- Major Table

INSERT INTO Major (major_id, major_name, department_id, status) VALUES
('M001', 'Data Science', 'D002', 'active'),
('M002', 'Statistics', 'D002', 'active'),
('M003', 'Philosophy', 'D001', 'active'),
('M004', 'Politics', 'D001', 'active'),
('M005', 'Economics', 'D001', 'active'),
('M006', 'Environmental Science', 'D001', 'active');


-- Course Table

-- Data Science (M001)
INSERT INTO Course (course_id, course_name, credit_hours, major_id) VALUES
('DATA101', 'Introduction to Data Science', 4, 'M001'),
('DATA102', 'Data Wrangling', 4, 'M001'),
('DATA103', 'Data Visualization', 4, 'M001'),
('DATA104', 'Machine Learning', 4, 'M001'),
('DATA105', 'Big Data Analytics', 4, 'M001'),
('DATA106', 'Python for Data Science', 4, 'M001'),
('DATA301', 'Deep Learning', 4, 'M001'),
('DATA302', 'Cybersecurity in Data Science', 4, 'M001');

-- Statistics (M002)
INSERT INTO Course (course_id, course_name, credit_hours, major_id) VALUES
('STAT101', 'Introduction to Statistics', 4, 'M002'),
('STAT102', 'Probability Theory', 4, 'M002'),
('STAT103', 'Statistical Inference', 4, 'M002'),
('STAT104', 'Regression Analysis', 4, 'M002'),
('STAT105', 'Time Series Analysis', 4, 'M002'),
('STAT106', 'Applied Statistics', 4, 'M002'),
('STAT201', 'Intermediate Statistics', 4, 'M002'),
('STAT301', 'Bayesian Statistics', 4, 'M002'),
('STAT302', 'Data Mining', 4, 'M002');

-- Philosophy (M003)
INSERT INTO Course (course_id, course_name, credit_hours, major_id) VALUES
('PHIL101', 'Introduction to Philosophy', 4, 'M003'),
('PHIL102', 'Ethics', 4, 'M003'),
('PHIL103', 'Logic and Reasoning', 4, 'M003'),
('PHIL104', 'Philosophy of Science', 4, 'M003'),
('PHIL105', 'History of Philosophy', 4, 'M003'),
('PHIL106', 'Metaphysics', 4, 'M003'),
('PHIL301', 'Political Philosophy', 4, 'M003'),
('PHIL302', 'Philosophy of Mind', 4, 'M003');

-- Politics (M004)
INSERT INTO Course (course_id, course_name, credit_hours, major_id) VALUES
('POL101', 'Introduction to Political Science', 4, 'M004'),
('POL102', 'Political Theory', 4, 'M004'),
('POL103', 'Comparative Politics', 4, 'M004'),
('POL104', 'International Relations', 4, 'M004'),
('POL105', 'Public Policy', 4, 'M004'),
('POL106', 'Research Methods in Politics', 4, 'M004'),
('POL301', 'Conflict Resolution', 4, 'M004'),
('POL302', 'Human Rights', 4, 'M004');

-- Economics (M005)
INSERT INTO Course (course_id, course_name, credit_hours, major_id) VALUES
('ECON101' , 'Principles of Economics I', 4, 'M005'),
('ECON102', 'Principles of Economics II', 4, 'M005'),
('ECON103', 'Microeconomics', 4, 'M005'),
('ECON104', 'Macroeconomics', 4, 'M005'),
('ECON105', 'Econometrics', 4, 'M005'),
('ECON106', 'Statistics for Economics', 4, 'M005'),
('ECON301', 'International Economics', 4, 'M005'),
('ECON302', 'Behavioral Economics', 4, 'M005');

-- Environmental Science (M006)
INSERT INTO Course (course_id, course_name, credit_hours, major_id) VALUES
('ENV101', 'Introduction to Environmental Science', 4, 'M006'),
('ENV102', 'Ecology', 4, 'M006'),
('ENV103', 'Environmental Policy', 4, 'M006'),
('ENV104', 'Climate Change Studies', 4, 'M006'),
('ENV105', 'Sustainable Development', 4, 'M006'),
('ENV106', 'Environmental Data Analysis', 4, 'M006'),
('ENV301', 'Environmental Risk Assessment', 4, 'M006'),
('ENV302', 'Advanced Environmental Modeling', 4, 'M006');

-- Pillar courses (all majors)
INSERT INTO Course (course_id, course_name, credit_hours, major_id) VALUES
('ENCP101', 'English Communication Pillar', 4, NULL),
('ENCP102', 'Advanced Communication Pillar', 4, NULL),
('SEM101', 'University Seminar 1', 4, NULL),
('SEM102', 'University Seminar 2', 4, NULL),
('SEM201', 'University Seminar 3', 4, NULL),
('SEM202', 'University Seminar 4', 4, NULL);

-- Arts / General electives (all majors)
INSERT INTO Course (course_id, course_name, credit_hours, major_id) VALUES
('ARTS101', 'Introduction to Arts', 4, NULL),
('MUS101', 'Introduction to Music', 4, NULL),
('PE101', 'Physical Education', 4, NULL);


-- Students

-- Possible change if we have time is to set student ID as PIUS20220001 for class of 2026 and PIUS20230001 for class of 27.

INSERT INTO Student (student_id, name, date_of_birth, class_of_year, gender, email, program, address, status, major_id) VALUES

-- Class 2026 (50 students)
('S001', 'Aung Min', '2005-02-12', 2026, 'M', 'aung.min2026@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S002', 'Htet Htet', '2005-05-23', 2026, 'F', 'htet.htet2026@university.edu', 'BA', 'Mandalay', 'active', 'M002'),
('S003', 'Ko Ko', '2005-01-15', 2026, 'M', 'ko.ko2026@university.edu', 'AA', 'Yangon', 'active', 'M003'),
('S004', 'Nandar', '2005-04-10', 2026, 'F', 'nandar2026@university.edu', 'BA', 'Yangon', 'active', 'M004'),
('S005', 'Win Win', '2005-08-05', 2026, 'M', 'win.win2026@university.edu', 'AA', 'Mandalay', 'active', 'M005'),
('S006', 'Mya Thuzar', '2005-11-12', 2026, 'F', 'mya.thuzar2026@university.edu', 'BA', 'Yangon', 'active', 'M006'),
('S007', 'Zaw Htet', '2005-03-18', 2026, 'M', 'zaw.htet2026@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S008', 'May Thu', '2005-06-22', 2026, 'F', 'may.thu2026@university.edu', 'AA', 'Mandalay', 'active', 'M002'),
('S009', 'Kyaw Zin', '2005-09-15', 2026, 'M', 'kyaw.zin2026@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S010', 'Su Su', '2005-12-02', 2026, 'F', 'su.su2026@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S011', 'Hnin Ei', '2005-07-03', 2026, 'F', 'hnin.ei2026@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S012', 'Thet Naing', '2005-05-19', 2026, 'M', 'thet.naing2026@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S013', 'Thiri Kyaw', '2005-01-28', 2026, 'F', 'thiri.kyaw2026@university.edu', 'BA', 'Mandalay', 'active', 'M001'),
('S014', 'Soe Win', '2005-04-11', 2026, 'M', 'soe.win2026@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S015', 'Ei Mon', '2005-08-20', 2026, 'F', 'ei.mon2026@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S016', 'Kyaw Htet', '2005-10-15', 2026, 'M', 'kyaw.htet2026@university.edu', 'BA', 'Yangon', 'active', 'M004'),
('S017', 'May Hnin', '2005-03-30', 2026, 'F', 'may.hnin2026@university.edu', 'AA', 'Yangon', 'active', 'M005'),
('S018', 'Aung Kyaw', '2005-06-25', 2026, 'M', 'aung.kyaw2026@university.edu', 'BA', 'Mandalay', 'active', 'M006'),
('S019', 'Hla Hla', '2005-09-18', 2026, 'F', 'hla.hla2026@university.edu', 'AA', 'Yangon', 'active', 'M001'),
('S020', 'Zaw Min', '2005-12-12', 2026, 'M', 'zaw.min2026@university.edu', 'BA', 'Yangon', 'active', 'M002'),
('S021', 'Thazin', '2005-02-08', 2026, 'F', 'thazin2026@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S022', 'Min Thu', '2005-03-14', 2026, 'M', 'min.thu2026@university.edu', 'AA', 'Mandalay', 'active', 'M004'),
('S023', 'Nay Chi', '2005-07-20', 2026, 'F', 'nay.chi2026@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S024', 'Ko Zin', '2005-09-28', 2026, 'M', 'ko.zin2026@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S025', 'San Hla', '2005-01-05', 2026, 'M', 'san.hla2026@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S026', 'Ei Thiri', '2005-04-18', 2026, 'F', 'ei.thiri2026@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S027', 'Htet Wai', '2005-06-12', 2026, 'M', 'htet.wai2026@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S028', 'Thiri Hnin', '2005-08-23', 2026, 'F', 'thiri.hnin2026@university.edu', 'AA', 'Mandalay', 'active', 'M004'),
('S029', 'Soe Htet', '2005-11-07', 2026, 'M', 'soe.htet2026@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S030', 'May Su', '2005-12-21', 2026, 'F', 'may.su2026@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S031', 'Hla Min', '2005-03-11', 2026, 'M', 'hla.min2026@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S032', 'Khin Thandar', '2005-05-22', 2026, 'F', 'khin.thandar2026@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S033', 'Aung Thu', '2005-07-14', 2026, 'M', 'aung.thu2026@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S034', 'May Hla', '2005-09-02', 2026, 'F', 'may.hla2026@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S035', 'Ko Aung', '2005-01-28', 2026, 'M', 'ko.aung2026@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S036', 'Hnin Thu', '2005-04-10', 2026, 'F', 'hnin.thu2026@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S037', 'Zaw Min Thura', '2005-06-19', 2026, 'M', 'zaw.min.thura2026@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S038', 'Ei Hla', '2005-08-30', 2026, 'F', 'ei.hla2026@university.edu', 'AA', 'Mandalay', 'active', 'M002'),
('S039', 'Thura Kyaw', '2005-10-14', 2026, 'M', 'thura.kyaw2026@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S040', 'May Nandar', '2005-12-01', 2026, 'F', 'may.nandar2026@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S041', 'Soe Min', '2005-02-17', 2026, 'M', 'soe.min2026@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S042', 'Htet Hla', '2005-05-03', 2026, 'F', 'htet.hla2026@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S043', 'Ko Thura', '2005-07-11', 2026, 'M', 'ko.thura2026@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S044', 'Ei Thuzar', '2005-09-25', 2026, 'F', 'ei.thuzar2026@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S045', 'Min Htet', '2005-11-09', 2026, 'M', 'min.htet2026@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S046', 'May Thandar', '2005-01-16', 2026, 'F', 'may.thandar2026@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S047', 'Kyaw Min', '2005-03-27', 2026, 'M', 'kyaw.min2026@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S048', 'Hnin Nandar', '2005-06-08', 2026, 'F', 'hnin.nandar2026@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S049', 'Aung Hla', '2005-08-19', 2026, 'M', 'aung.hla2026@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S050', 'May Su Hlaing', '2005-10-30', 2026, 'F', 'may.su.hlaing2026@university.edu', 'AA', 'Yangon', 'active', 'M002'),

-- Class 2027 (50 students)

('S051', 'Thuzar Htet', '2006-01-20', 2027, 'F', 'thuzar.htet2027@university.edu', 'BA', 'Mandalay', 'active', 'M001'),
('S052', 'Ko Aung', '2006-02-15', 2027, 'M', 'ko.aung2027@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S053', 'Hnin Hnin', '2006-03-12', 2027, 'F', 'hnin.hnin2027@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S054', 'Soe Soe', '2006-04-10', 2027, 'M', 'soe.soe2027@university.edu', 'BA', 'Yangon', 'active', 'M004'),
('S055', 'Ei Thandar', '2006-05-05', 2027, 'F', 'ei.thandar2027@university.edu', 'AA', 'Yangon', 'active', 'M005'),
('S056', 'Kyaw Htun', '2006-06-11', 2027, 'M', 'kyaw.htun2027@university.edu', 'BA', 'Yangon', 'active', 'M006'),
('S057', 'May Khin', '2006-07-18', 2027, 'F', 'may.khin2027@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S058', 'Aung Hla', '2006-08-22', 2027, 'M', 'aung.hla2027@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S059', 'Hla Min', '2006-09-15', 2027, 'M', 'hla.min2027@university.edu', 'BA', 'Mandalay', 'active', 'M003'),
('S060', 'Su Htet', '2006-10-12', 2027, 'F', 'su.htet2027@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S061', 'Thiri Hla', '2006-01-08', 2027, 'F', 'thiri.hla2027@university.edu', 'AA', 'Yangon', 'active', 'M005'),
('S062', 'Ko Min', '2006-02-14', 2027, 'M', 'ko.min2027@university.edu', 'BA', 'Yangon', 'active', 'M006'),
('S063', 'Hnin Thuzar Win', '2006-03-20', 2027, 'F', 'hnin.thuzar.win2027@university.edu', 'AA', 'Yangon', 'active', 'M001'),
('S064', 'Zaw Htun', '2006-04-26', 2027, 'M', 'zaw.htun2027@university.edu', 'BA', 'Mandalay', 'active', 'M002'),
('S065', 'May Nwe', '2006-05-02', 2027, 'F', 'may.nwe2027@university.edu', 'AA', 'Yangon', 'active', 'M003'),
('S066', 'Kyaw Thura', '2006-06-10', 2027, 'M', 'kyaw.thura2027@university.edu', 'BA', 'Yangon', 'active', 'M004'),
('S067', 'Ei Hnin', '2006-07-15', 2027, 'F', 'ei.hnin2027@university.edu', 'AA', 'Yangon', 'active', 'M005'),
('S068', 'Aung Zaw', '2006-08-22', 2027, 'M', 'aung.zaw2027@university.edu', 'BA', 'Yangon', 'active', 'M006'),
('S069', 'Hla Htun', '2006-09-28', 2027, 'M', 'hla.htun2027@university.edu', 'BA', 'Mandalay', 'active', 'M001'),
('S070', 'Su Hla', '2006-10-05', 2027, 'F', 'su.hla2027@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S071', 'Thazin Nwe', '2006-01-12', 2027, 'F', 'thazin.nwe2027@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S072', 'Min Hla', '2006-02-18', 2027, 'M', 'min.hla2027@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S073', 'Hnin Nwe', '2006-03-25', 2027, 'F', 'hnin.nwe2027@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S074', 'Ko Kyaw', '2006-04-02', 2027, 'M', 'ko.kyaw2027@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S075', 'Ei Mon', '2006-05-11', 2027, 'F', 'ei.mon2027@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S076', 'Zaw Thura', '2006-06-17', 2027, 'M', 'zaw.thura2027@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S077', 'May Hla', '2006-07-23', 2027, 'F', 'may.hla2027@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S078', 'Kyaw Min', '2006-08-29', 2027, 'M', 'kyaw.min2027@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S079', 'Hnin Su', '2006-09-05', 2027, 'F', 'hnin.su2027@university.edu', 'BA', 'Mandalay', 'active', 'M005'),
('S080', 'Aung Thura', '2006-10-12', 2027, 'M', 'aung.thura2027@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S081', 'Thiri Nwe', '2006-01-20', 2027, 'F', 'thiri.nwe2027@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S082', 'Ko Htun', '2006-02-26', 2027, 'M', 'ko.htun2027@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S083', 'May Thuzar', '2006-03-05', 2027, 'F', 'may.thuzar2027@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S084', 'Zaw Kyaw', '2006-04-11', 2027, 'M', 'zaw.kyaw2027@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S085', 'Hla Nandar', '2006-05-19', 2027, 'F', 'hla.nandar2027@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S086', 'Kyaw Thandar', '2006-06-25', 2027, 'M', 'kyaw.thandar2027@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S087', 'Ei Thuzar', '2006-07-30', 2027, 'F', 'ei.thuzar2027@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S088', 'Min Hla Aung', '2006-08-15', 2027, 'M', 'min.hla.aung2027@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S089', 'Hnin Thandar', '2006-09-21', 2027, 'F', 'hnin.thandar2027@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S090', 'Ko Min Naing', '2006-10-28', 2027, 'M', 'ko.min.naing2027@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S091', 'May Thandar', '2006-01-07', 2027, 'F', 'may.thandar2027@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S092', 'Aung Kyaw', '2006-02-13', 2027, 'M', 'aung.kyaw2027@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S093', 'Thiri Su', '2006-03-20', 2027, 'F', 'thiri.su2027@university.edu', 'BA', 'Yangon', 'active', 'M001'),
('S094', 'Zaw Hla', '2006-04-26', 2027, 'M', 'zaw.hla2027@university.edu', 'AA', 'Yangon', 'active', 'M002'),
('S095', 'Hla Min Zaw', '2006-05-02', 2027, 'M', 'hla.min.zaw2027@university.edu', 'BA', 'Yangon', 'active', 'M003'),
('S096', 'Su Thandar', '2006-06-10', 2027, 'F', 'su.thandar2027@university.edu', 'AA', 'Yangon', 'active', 'M004'),
('S097', 'Ko Zaw', '2006-07-15', 2027, 'M', 'ko.zaw2027@university.edu', 'BA', 'Yangon', 'active', 'M005'),
('S098', 'May Hnin', '2006-08-22', 2027, 'F', 'may.hnin2027@university.edu', 'AA', 'Yangon', 'active', 'M006'),
('S099', 'Kyaw Su', '2006-09-28', 2027, 'M', 'kyaw.su2027@university.edu', 'BA', 'Mandalay', 'active', 'M001'),
('S100', 'Hnin Thuzar', '2006-10-05', 2027, 'F', 'hnin.thuzar2027@university.edu', 'AA', 'Yangon', 'active', 'M002');


-- Staff



-- Administrative staff
INSERT INTO Staff (staff_id, name, email, position, role, department_id) VALUES
('ST001', 'Dr. Aung Min', 'aung.min@university.edu', 'Registrar', 'Administration', 'D004'), -- Academic Affairs
('ST002', 'Htet Htet', 'htet.htet@university.edu', 'Tech Support', 'Administration', 'D005'), -- IT Support
('ST035', 'Zaw Naing', 'zawn@university.edu', 'Administrator', 'Administration', 'D004'),


-- Academic staff (Social Sciences and Humanities → D001)
('ST003', 'Dr. Ko Ko', 'ko.ko@university.edu', 'Instructor', 'Academics', 'D001'),
('ST004', 'Dr. Nandar', 'nandar@university.edu', 'Instructor', 'Academics', 'D001'),
('ST005', 'Dr. Win Win', 'win.win@university.edu', 'Instructor', 'Academics', 'D001'),
('ST006', 'Dr. Thiri Su', 'thiri.su@university.edu', 'Instructor', 'Academics', 'D001'),
('ST007', 'Dr. Hnin Ei', 'hnin.ei@university.edu', 'Instructor', 'Academics', 'D001'),
('ST008', 'Dr. May Thuzar', 'may.thuzar@university.edu', 'Instructor', 'Academics', 'D001'),
('ST009', 'Dr. Zaw Htun', 'zaw.htun@university.edu', 'Instructor', 'Academics', 'D001'),
('ST010', 'Dr. Ei Mon', 'ei.mon@university.edu', 'Instructor', 'Academics', 'D001'),
('ST011', 'Dr. Kyaw Myint', 'kyaw.myint@university.edu', 'Instructor', 'Academics', 'D001'),
('ST012', 'Dr. Thazin Nwe', 'thazin.nwe@university.edu', 'Instructor', 'Academics', 'D001'),
('ST013', 'Dr. Aye Chan', 'aye.chan@university.edu', 'Instructor', 'Academics', 'D001'),
('ST014', 'Dr. Su Su', 'su.su@university.edu', 'Instructor', 'Academics', 'D001'),
('ST015', 'Dr. Ko Zaw', 'ko.zaw@university.edu', 'Instructor', 'Academics', 'D001'),
('ST016', 'Dr. Thiri Lwin', 'thiri.lwin@university.edu', 'Instructor', 'Academics', 'D001'),

-- Academics staff (Sciences and Mathematics → D002)

('ST017', 'Dr. Aung Kyaw', 'aung.kyaw@university.edu', 'Instructor', 'Academics', 'D002'),
('ST018', 'Dr. Hla Min', 'hla.min@university.edu', 'Instructor', 'Academics', 'D002'),
('ST019', 'Dr. Zaw Naing', 'zaw.naing@university.edu', 'Instructor', 'Academics', 'D002'),
('ST020', 'Dr. Mya Aye', 'mya.aye@university.edu', 'Instructor', 'Academics', 'D002'),
('ST021', 'Dr. Kyaw Zin', 'kyaw.zin@university.edu', 'Instructor', 'Academics', 'D002'),
('ST022', 'Dr. Thura Lin', 'thura.lin@university.edu', 'Instructor', 'Academics', 'D002'),
('ST023', 'Dr. Min Htet', 'min.htet@university.edu', 'Instructor', 'Academics', 'D002'),
('ST024', 'Dr. Nwe Nwe', 'nwe.nwe@university.edu', 'Instructor', 'Academics', 'D002'),
('ST025', 'Dr. Aung Thura', 'aung.thura@university.edu', 'Instructor', 'Academics', 'D002'),
('ST026', 'Dr. Zaw Oo', 'zaw.oo@university.edu', 'Instructor', 'Academics', 'D002'),
('ST027', 'Dr. Kyaw Thant', 'kyaw.thant@university.edu', 'Instructor', 'Academics', 'D002'),
('ST028', 'Dr. Su Mon', 'su.mon@university.edu', 'Instructor', 'Academics', 'D002'),
('ST029', 'Dr. May Hla', 'may.hla@university.edu', 'Instructor', 'Academics', 'D002'),

-- Academics staff (Arts and Creative Studies → D003)
('ST030', 'Dr. Thandar Hlaing', 'thandar.hlaing@university.edu', 'Instructor', 'Academics', 'D003'),
('ST031', 'Dr. Min Ko', 'min.ko@university.edu', 'Instructor', 'Academics', 'D003'),
('ST032', 'Dr. Su Htet', 'su.htet@university.edu', 'Instructor', 'Academics', 'D003'),
('ST033', 'Dr. May Zaw', 'may.zaw@university.edu', 'Instructor', 'Academics', 'D003'),
('ST034', 'Dr. Kyaw Win', 'kyaw.win@university.edu', 'Instructor', 'Academics', 'D003');



-- Course_Section

INSERT INTO Course_Section (
    section_id, course_id, instructor_id,
    semester, academic_year) VALUES

('CS001','DATA101','ST011','Fall',2022),
('CS002','STAT101','ST012','Fall',2022),
('CS003','PHIL101','ST003','Fall',2022),
('CS004','ECON101','ST004','Fall',2022),
('CS005','ENCP101','ST013','Fall',2022),
('CS006','ARTS101','ST019','Fall',2022),

('CS007','DATA102','ST011','Spring',2023),
('CS008','STAT201','ST012','Spring',2023),
('CS009','PHIL101','ST005','Spring',2023),
('CS010','ECON101','ST006','Spring',2023),
('CS011','ENCP102','ST014','Spring',2023),
('CS012','SEM101','ST007','Spring',2023),

('CS013','DATA101','ST015','Fall',2023),
('CS014','STAT101','ST016','Fall',2023),
('CS015','ENV101','ST017','Fall',2023),
('CS016','ECON101','ST004','Fall',2023),
('CS017','SEM202','ST008','Fall',2023),
('CS018','ARTS101','ST020','Fall',2023),

('CS019','DATA102','ST015','Spring',2024),
('CS020','STAT201','ST016','Spring',2024),
('CS021','PHIL101','ST006','Spring',2024),
('CS022','ENV101','ST017','Spring',2024),
('CS023','ENCP101','ST013','Spring',2024),
('CS024','SEM201','ST007','Spring',2024),

('CS025','DATA101','ST011','Fall',2024),
('CS026','STAT101','ST012','Fall',2024),
('CS027','ECON101','ST004','Fall',2024),
('CS028','PHIL101','ST003','Fall',2024),
('CS029','SEM102','ST008','Fall',2024),
('CS030','ARTS101','ST021','Fall',2024),

('CS031','DATA102','ST011','Spring',2025),
('CS032','STAT201','ST012','Spring',2025),
('CS033','ENV101','ST017','Spring',2025),
('CS034','ECON101','ST006','Spring',2025),
('CS035','ENCP102','ST014','Spring',2025),
('CS036','SEM101','ST007','Spring',2025),

('CS037','DATA101','ST015','Fall',2025),
('CS038','STAT101','ST016','Fall',2025),
('CS039','PHIL101','ST005','Fall',2025),
('CS040','ENV101','ST017','Fall',2025),
('CS041','SEM202','ST008','Fall',2025),
('CS042','ARTS101','ST019','Fall',2025),

('CS043','DATA102','ST011','Fall',2026),
('CS044','STAT201','ST012','Fall',2026),
('CS045','ECON101','ST004','Fall',2026),
('CS046','PHIL101','ST003','Fall',2026),
('CS047','SEM202','ST008','Fall',2026),
('CS048','ARTS101','ST020','Fall',2026);



-- Enrollment

-- ===============================
-- Student 1: S001 (Data Science, M001, Class of 2026)
-- ===============================

-- Completed courses (Fall 2022 – Fall 2025)
INSERT INTO Enrollment (enrollment_id, student_id, section_id, enrollment_status) VALUES
('E001', 'S001', 'CS001', 'completed'),  -- DATA101
('E002', 'S001', 'CS007', 'completed'),  -- DATA102
('E003', 'S001', 'CS013', 'completed'),  -- DATA101
('E004', 'S001', 'CS019', 'completed'),  -- DATA102
('E005', 'S001', 'CS025', 'completed'),  -- DATA101
('E006', 'S001', 'CS031', 'completed'),  -- DATA102
('E007', 'S001', 'CS037', 'completed'),  -- DATA101
('E008', 'S001', 'CS005', 'completed'),  -- ENCP101
('E009', 'S001', 'CS011', 'completed'),  -- ENCP102
('E010', 'S001', 'CS017', 'completed'),  -- SEMINAR2
('E011', 'S001', 'CS023', 'completed'),  -- ENCP101
('E012', 'S001', 'CS024', 'completed'),  -- SEMINAR1
('E013', 'S001', 'CS006', 'completed'),  -- ARTS101
('E014', 'S001', 'CS012', 'completed'),  -- SEMINAR1
('E015', 'S001', 'CS018', 'completed'),  -- ARTS101
('E016', 'S001', 'CS042', 'completed');  -- ARTS101

-- Fall 2026 (currently enrolled)
INSERT INTO Enrollment (enrollment_id, student_id, section_id, enrollment_status) VALUES
('E017', 'S001', 'CS043', 'enrolled'),  -- DATA102
('E018', 'S001', 'CS045', 'enrolled'),  -- ECON101 (elective)
('E019', 'S001', 'CS046', 'enrolled'),  -- PHIL101 (elective)
('E020', 'S001', 'CS047', 'enrolled'),  -- SEMINAR2
('E021', 'S001', 'CS048', 'enrolled');  -- ARTS101

-- ===============================
-- Student 2: S002 (Statistics, M002, Class of 2027)
-- ===============================

-- Completed courses (Fall 2022 – Fall 2025)
INSERT INTO Enrollment (enrollment_id, student_id, section_id, enrollment_status) VALUES
('E022', 'S002', 'CS002', 'completed'),  -- STAT101
('E023', 'S002', 'CS008', 'completed'),  -- STAT201
('E024', 'S002', 'CS014', 'completed'),  -- STAT101
('E025', 'S002', 'CS020', 'completed'),  -- STAT201
('E026', 'S002', 'CS026', 'completed'),  -- STAT101
('E027', 'S002', 'CS032', 'completed'),  -- STAT201
('E028', 'S002', 'CS038', 'completed'),  -- STAT101
('E029', 'S002', 'CS005', 'completed'),  -- ENCP101
('E030', 'S002', 'CS011', 'completed'),  -- ENCP102
('E031', 'S002', 'CS017', 'completed'),  -- SEMINAR2
('E032', 'S002', 'CS023', 'completed'),  -- ENCP101
('E033', 'S002', 'CS024', 'completed'),  -- SEMINAR1
('E034', 'S002', 'CS006', 'completed'),  -- ARTS101
('E035', 'S002', 'CS012', 'completed'),  -- SEMINAR1
('E036', 'S002', 'CS018', 'completed'),  -- ARTS101
('E037', 'S002', 'CS042', 'completed');  -- ARTS101

-- Fall 2026 (currently enrolled)
INSERT INTO Enrollment (enrollment_id, student_id, section_id, enrollment_status) VALUES
('E038', 'S002', 'CS044', 'enrolled'),  -- STAT201
('E039', 'S002', 'CS045', 'enrolled'),  -- ECON101 (elective)
('E040', 'S002', 'CS046', 'enrolled'),  -- PHIL101 (elective)
('E041', 'S002', 'CS047', 'enrolled'),  -- SEMINAR2
('E042', 'S002', 'CS048', 'enrolled');  -- ARTS101


-- Grade

-- Grades for S001 (Data Science, completed courses)
INSERT INTO Grade (grade_id, enrollment_id, grade, grade_points) VALUES
('G001', 'E001', 'A', 4.0),
('G002', 'E002', 'A', 4.0),
('G003', 'E003', 'B', 3.0),
('G004', 'E004', 'A', 4.0),
('G005', 'E005', 'A', 4.0),
('G006', 'E006', 'B', 3.0),
('G007', 'E007', 'A', 4.0),
('G008', 'E008', 'A', 4.0),
('G009', 'E009', 'B', 3.0),
('G010', 'E010', 'A', 4.0),
('G011', 'E011', 'A', 4.0),
('G012', 'E012', 'B', 3.0),
('G013', 'E013', 'A', 4.0),
('G014', 'E014', 'A', 4.0),
('G015', 'E015', 'B', 3.0),
('G016', 'E016', 'A', 4.0);

-- Grades for S001 (currently enrolled Fall 2026)
INSERT INTO Grade (grade_id, enrollment_id, grade, grade_points) VALUES
('G017', 'E017', NULL, NULL),
('G018', 'E018', NULL, NULL),
('G019', 'E019', NULL, NULL),
('G020', 'E020', NULL, NULL),
('G021', 'E021', NULL, NULL);

-- Grades for S002 (Statistics, completed courses)
INSERT INTO Grade (grade_id, enrollment_id, grade, grade_points) VALUES
('G022', 'E022', 'A', 4.0),
('G023', 'E023', 'B', 3.0),
('G024', 'E024', 'A', 4.0),
('G025', 'E025', 'B', 3.0),
('G026', 'E026', 'A', 4.0),
('G027', 'E027', 'B', 3.0),
('G028', 'E028', 'A', 4.0),
('G029', 'E029', 'B', 3.0),
('G030', 'E030', 'A', 4.0),
('G031', 'E031', 'B', 3.0),
('G032', 'E032', 'A', 4.0),
('G033', 'E033', 'B', 3.0),
('G034', 'E034', 'A', 4.0),
('G035', 'E035', 'B', 3.0),
('G036', 'E036', 'A', 4.0),
('G037', 'E037', 'B', 3.0);

-- Grades for S002 (currently enrolled Fall 2026)
INSERT INTO Grade (grade_id, enrollment_id, grade, grade_points) VALUES
('G038', 'E038', NULL, NULL),
('G039', 'E039', NULL, NULL),
('G040', 'E040', NULL, NULL),
('G041', 'E041', NULL, NULL),
('G042', 'E042', NULL, NULL);