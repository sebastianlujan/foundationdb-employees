
--- departments

DROP TABLE IF EXISTS departments;

CREATE TABLE departments(
  dept_no VARCHAR(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL PRIMARY KEY,
  dept_name VARCHAR(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
);



INSERT INTO departments VALUES('d001', 'Marketing'),
                              ('d002', 'Finance'),
                              ('d003', 'Human Resources'),
                              ('d004', 'Production'),
                              ('d005', 'Development'),
                              ('d006', 'Quality Management'),
                              ('d007', 'Sales'),
                              ('d008', 'Research'),
                              ('d009', 'Customer Service');

--- employees
---  dept_emp
---  dept_manager
---  salaries
---  titles

DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
  emp_no INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  last_name VARCHAR(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  gender INT NOT NULL,
  birth_date DATE NOT NULL,
  hire_date DATE NOT NULL
);

CREATE TABLE dept_emp(
  emp_no INT NOT NULL,
  GROUPING FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
  dept_no VARCHAR(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY(emp_no, dept_no),
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);

CREATE TABLE dept_manager(
  emp_no INT NOT NULL,
  GROUPING FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
  dept_no VARCHAR(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY(emp_no, dept_no),
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);

CREATE TABLE salaries(
  emp_no INT NOT NULL,
  GROUPING FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
  from_date DATE NOT NULL,
  PRIMARY KEY(emp_no, from_date),
  to_date DATE NOT NULL,
  salary INT NOT NULL
);

CREATE TABLE titles(
  emp_no INT NOT NULL,
  GROUPING FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
  title VARCHAR(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  from_date DATE NOT NULL,
  PRIMARY KEY(emp_no, title, from_date),
  to_date DATE
);


CREATE INDEX employees_name_idx ON employees(last_name);
CREATE INDEX dept_emp_dept_no ON dept_emp(dept_no);
CREATE INDEX dept_emp_emp_no ON dept_emp(emp_no);
CREATE INDEX dept_manager_dept_no ON dept_manager(dept_no);
CREATE INDEX dept_manager_emp_no ON dept_manager(emp_no);
CREATE INDEX salaries_emp_no ON salaries(emp_no);
CREATE INDEX salaries_sal_idx ON salaries(salary);
CREATE INDEX titles_emp_no ON titles(emp_no);

INSERT INTO employees VALUES(10001, 'Georgi', 'Facello', 1, DATE '1953-09-02', DATE '1986-06-26');
INSERT INTO dept_emp VALUES(10001, 'd005', DATE '1986-06-26', DATE '9999-01-01');
INSERT INTO salaries VALUES(10001, DATE '1986-06-26', DATE '1987-06-26', 60117),
                           (10001, DATE '1987-06-26', DATE '1988-06-25', 62102),
                           (10001, DATE '1988-06-25', DATE '1989-06-25', 66074),
                           (10001, DATE '1989-06-25', DATE '1990-06-25', 66596),
                           (10001, DATE '1990-06-25', DATE '1991-06-25', 66961),
                           (10001, DATE '1991-06-25', DATE '1992-06-24', 71046),
                           (10001, DATE '1992-06-24', DATE '1993-06-24', 74333),
                           (10001, DATE '1993-06-24', DATE '1994-06-24', 75286),
                           (10001, DATE '1994-06-24', DATE '1995-06-24', 75994),
                           (10001, DATE '1995-06-24', DATE '1996-06-23', 76884),
                           (10001, DATE '1996-06-23', DATE '1997-06-23', 80013);
INSERT INTO salaries VALUES(10001, DATE '1997-06-23', DATE '1998-06-23', 81025),
                           (10001, DATE '1998-06-23', DATE '1999-06-23', 81097),
                           (10001, DATE '1999-06-23', DATE '2000-06-22', 84917),
                           (10001, DATE '2000-06-22', DATE '2001-06-22', 85112),
                           (10001, DATE '2001-06-22', DATE '2002-06-22', 85097),
                           (10001, DATE '2002-06-22', DATE '9999-01-01', 88958);
INSERT INTO titles VALUES(10001, 'Senior Engineer', DATE '1986-06-26', DATE '9999-01-01');
INSERT INTO employees VALUES(10002, 'Bezalel', 'Simmel', 2, DATE '1964-06-02', DATE '1985-11-21');
INSERT INTO dept_emp VALUES(10002, 'd007', DATE '1996-08-03', DATE '9999-01-01');
INSERT INTO salaries VALUES(10002, DATE '1996-08-03', DATE '1997-08-03', 65828),
                           (10002, DATE '1997-08-03', DATE '1998-08-03', 65909),
                           (10002, DATE '1998-08-03', DATE '1999-08-03', 67534),
                           (10002, DATE '1999-08-03', DATE '2000-08-02', 69366);
INSERT INTO salaries VALUES(10002, DATE '2000-08-02', DATE '2001-08-02', 71963),
                           (10002, DATE '2001-08-02', DATE '9999-01-01', 72527);
INSERT INTO titles VALUES(10002, 'Staff', DATE '1996-08-03', DATE '9999-01-01');
INSERT INTO employees VALUES(10003, 'Parto', 'Bamford', 1, DATE '1959-12-03', DATE '1986-08-28');
INSERT INTO dept_emp VALUES(10003, 'd004', DATE '1995-12-03', DATE '9999-01-01');
INSERT INTO salaries VALUES(10003, DATE '1995-12-03', DATE '1996-12-02', 40006),
                           (10003, DATE '1996-12-02', DATE '1997-12-02', 43616),
                           (10003, DATE '1997-12-02', DATE '1998-12-02', 43466),
                           (10003, DATE '1998-12-02', DATE '1999-12-02', 43636),
                           (10003, DATE '1999-12-02', DATE '2000-12-01', 43478),
                           (10003, DATE '2000-12-01', DATE '2001-12-01', 43699),
                           (10003, DATE '2001-12-01', DATE '9999-01-01', 43311);
INSERT INTO titles VALUES(10003, 'Senior Engineer', DATE '1995-12-03', DATE '9999-01-01');
INSERT INTO employees VALUES(10004, 'Chirstian', 'Koblick', 1, DATE '1954-05-01', DATE '1986-12-01');
INSERT INTO dept_emp VALUES(10004, 'd004', DATE '1986-12-01', DATE '9999-01-01');
INSERT INTO salaries VALUES(10004, DATE '1986-12-01', DATE '1987-12-01', 40054),
                           (10004, DATE '1987-12-01', DATE '1988-11-30', 42283),
                           (10004, DATE '1988-11-30', DATE '1989-11-30', 42542),
                           (10004, DATE '1989-11-30', DATE '1990-11-30', 46065),
                           (10004, DATE '1990-11-30', DATE '1991-11-30', 48271),
                           (10004, DATE '1991-11-30', DATE '1992-11-29', 50594),
                           (10004, DATE '1992-11-29', DATE '1993-11-29', 52119),
                           (10004, DATE '1993-11-29', DATE '1994-11-29', 54693),
                           (10004, DATE '1994-11-29', DATE '1995-11-29', 58326),
                           (10004, DATE '1995-11-29', DATE '1996-11-28', 60770),
                           (10004, DATE '1996-11-28', DATE '1997-11-28', 62566);
INSERT INTO salaries VALUES(10004, DATE '1997-11-28', DATE '1998-11-28', 64340),
                           (10004, DATE '1998-11-28', DATE '1999-11-28', 67096),
                           (10004, DATE '1999-11-28', DATE '2000-11-27', 69722),
                           (10004, DATE '2000-11-27', DATE '2001-11-27', 70698),
                           (10004, DATE '2001-11-27', DATE '9999-01-01', 74057);
INSERT INTO titles VALUES(10004, 'Engineer', DATE '1986-12-01', DATE '1995-12-01'),
                         (10004, 'Senior Engineer', DATE '1995-12-01', DATE '9999-01-01');
INSERT INTO employees VALUES(10005, 'Kyoichi', 'Maliniak', 1, DATE '1955-01-21', DATE '1989-09-12');
INSERT INTO dept_emp VALUES(10005, 'd003', DATE '1989-09-12', DATE '9999-01-01');
INSERT INTO salaries VALUES(10005, DATE '1989-09-12', DATE '1990-09-12', 78228),
                           (10005, DATE '1990-09-12', DATE '1991-09-12', 82621),
                           (10005, DATE '1991-09-12', DATE '1992-09-11', 83735);
INSERT INTO salaries VALUES(10005, DATE '1992-09-11', DATE '1993-09-11', 85572),
                           (10005, DATE '1993-09-11', DATE '1994-09-11', 85076),
                           (10005, DATE '1994-09-11', DATE '1995-09-11', 86050),
                           (10005, DATE '1995-09-11', DATE '1996-09-10', 88448),
                           (10005, DATE '1996-09-10', DATE '1997-09-10', 88063),
                           (10005, DATE '1997-09-10', DATE '1998-09-10', 89724),
                           (10005, DATE '1998-09-10', DATE '1999-09-10', 90392),
                           (10005, DATE '1999-09-10', DATE '2000-09-09', 90531),
                           (10005, DATE '2000-09-09', DATE '2001-09-09', 91453),
                           (10005, DATE '2001-09-09', DATE '9999-01-01', 94692);
INSERT INTO titles VALUES(10005, 'Senior Staff', DATE '1996-09-12', DATE '9999-01-01'),
                         (10005, 'Staff', DATE '1989-09-12', DATE '1996-09-12');
INSERT INTO employees VALUES(10006, 'Anneke', 'Preusig', 2, DATE '1953-04-20', DATE '1989-06-02');
INSERT INTO dept_emp VALUES(10006, 'd005', DATE '1990-08-05', DATE '9999-01-01');
INSERT INTO salaries VALUES(10006, DATE '1990-08-05', DATE '1991-08-05', 40000),
                           (10006, DATE '1991-08-05', DATE '1992-08-04', 42085),
                           (10006, DATE '1992-08-04', DATE '1993-08-04', 42629),
                           (10006, DATE '1993-08-04', DATE '1994-08-04', 45844),
                           (10006, DATE '1994-08-04', DATE '1995-08-04', 47518),
                           (10006, DATE '1995-08-04', DATE '1996-08-03', 47917),
                           (10006, DATE '1996-08-03', DATE '1997-08-03', 52255),
                           (10006, DATE '1997-08-03', DATE '1998-08-03', 53747),
                           (10006, DATE '1998-08-03', DATE '1999-08-03', 56032),
                           (10006, DATE '1999-08-03', DATE '2000-08-02', 58299),
                           (10006, DATE '2000-08-02', DATE '2001-08-02', 60098),
                           (10006, DATE '2001-08-02', DATE '9999-01-01', 59755);
INSERT INTO titles VALUES(10006, 'Senior Engineer', DATE '1990-08-05', DATE '9999-01-01');
INSERT INTO employees VALUES(10007, 'Tzvetan', 'Zielinski', 2, DATE '1957-05-23', DATE '1989-02-10');
INSERT INTO dept_emp VALUES(10007, 'd008', DATE '1989-02-10', DATE '9999-01-01');
INSERT INTO salaries VALUES(10007, DATE '1989-02-10', DATE '1990-02-10', 56724),
                           (10007, DATE '1990-02-10', DATE '1991-02-10', 60740),
                           (10007, DATE '1991-02-10', DATE '1992-02-10', 62745),
                           (10007, DATE '1992-02-10', DATE '1993-02-09', 63475),
                           (10007, DATE '1993-02-09', DATE '1994-02-09', 63208),
                           (10007, DATE '1994-02-09', DATE '1995-02-09', 64563),
                           (10007, DATE '1995-02-09', DATE '1996-02-09', 68833),
                           (10007, DATE '1996-02-09', DATE '1997-02-08', 70220),
                           (10007, DATE '1997-02-08', DATE '1998-02-08', 73362);
INSERT INTO salaries VALUES(10007, DATE '1998-02-08', DATE '1999-02-08', 75582),
                           (10007, DATE '1999-02-08', DATE '2000-02-08', 79513),
                           (10007, DATE '2000-02-08', DATE '2001-02-07', 80083),
                           (10007, DATE '2001-02-07', DATE '2002-02-07', 84456),
                           (10007, DATE '2002-02-07', DATE '9999-01-01', 88070);
INSERT INTO titles VALUES(10007, 'Senior Staff', DATE '1996-02-11', DATE '9999-01-01'),
                         (10007, 'Staff', DATE '1989-02-10', DATE '1996-02-11');
INSERT INTO employees VALUES(10008, 'Saniya', 'Kalloufi', 1, DATE '1958-02-19', DATE '1994-09-15');
INSERT INTO dept_emp VALUES(10008, 'd005', DATE '1998-03-11', DATE '2000-07-31');
INSERT INTO salaries VALUES(10008, DATE '1998-03-11', DATE '1999-03-11', 46671),
                           (10008, DATE '1999-03-11', DATE '2000-03-10', 48584),
                           (10008, DATE '2000-03-10', DATE '2000-07-31', 52668);
INSERT INTO titles VALUES(10008, 'Assistant Engineer', DATE '1998-03-11', DATE '2000-07-31');
INSERT INTO employees VALUES(10009, 'Sumant', 'Peac', 2, DATE '1952-04-19', DATE '1985-02-18');
INSERT INTO dept_emp VALUES(10009, 'd006', DATE '1985-02-18', DATE '9999-01-01');
INSERT INTO salaries VALUES(10009, DATE '1985-02-18', DATE '1986-02-18', 60929),
                           (10009, DATE '1986-02-18', DATE '1987-02-18', 64604),
                           (10009, DATE '1987-02-18', DATE '1988-02-18', 64780),
                           (10009, DATE '1988-02-18', DATE '1989-02-17', 66302),
                           (10009, DATE '1989-02-17', DATE '1990-02-17', 69042),
                           (10009, DATE '1990-02-17', DATE '1991-02-17', 70889),
                           (10009, DATE '1991-02-17', DATE '1992-02-17', 71434),
                           (10009, DATE '1992-02-17', DATE '1993-02-16', 74612),
                           (10009, DATE '1993-02-16', DATE '1994-02-16', 76518),
                           (10009, DATE '1994-02-16', DATE '1995-02-16', 78335),
                           (10009, DATE '1995-02-16', DATE '1996-02-16', 80944);
INSERT INTO salaries VALUES(10009, DATE '1996-02-16', DATE '1997-02-15', 82507),
                           (10009, DATE '1997-02-15', DATE '1998-02-15', 85875),
                           (10009, DATE '1998-02-15', DATE '1999-02-15', 89324),
                           (10009, DATE '1999-02-15', DATE '2000-02-15', 90668),
                           (10009, DATE '2000-02-15', DATE '2001-02-14', 93507),
                           (10009, DATE '2001-02-14', DATE '2002-02-14', 94443),
                           (10009, DATE '2002-02-14', DATE '9999-01-01', 94409);
INSERT INTO titles VALUES(10009, 'Assistant Engineer', DATE '1985-02-18', DATE '1990-02-18'),
                         (10009, 'Engineer', DATE '1990-02-18', DATE '1995-02-18'),
                         (10009, 'Senior Engineer', DATE '1995-02-18', DATE '9999-01-01');
INSERT INTO employees VALUES(10010, 'Duangkaew', 'Piveteau', 2, DATE '1963-06-01', DATE '1989-08-24');
INSERT INTO dept_emp VALUES(10010, 'd004', DATE '1996-11-24', DATE '2000-06-26');
INSERT INTO dept_emp VALUES(10010, 'd006', DATE '2000-06-26', DATE '9999-01-01');
INSERT INTO salaries VALUES(10010, DATE '1996-11-24', DATE '1997-11-24', 72488),
                           (10010, DATE '1997-11-24', DATE '1998-11-24', 74347),
                           (10010, DATE '1998-11-24', DATE '1999-11-24', 75405),
                           (10010, DATE '1999-11-24', DATE '2000-11-23', 78194),
                           (10010, DATE '2000-11-23', DATE '2001-11-23', 79580),
                           (10010, DATE '2001-11-23', DATE '9999-01-01', 80324);
INSERT INTO titles VALUES(10010, 'Engineer', DATE '1996-11-24', DATE '9999-01-01');
INSERT INTO employees VALUES(10011, 'Mary', 'Sluis', 2, DATE '1953-11-07', DATE '1990-01-22');
INSERT INTO dept_emp VALUES(10011, 'd009', DATE '1990-01-22', DATE '1996-11-09');
INSERT INTO salaries VALUES(10011, DATE '1990-01-22', DATE '1991-01-22', 42365),
                           (10011, DATE '1991-01-22', DATE '1992-01-22', 44200),
                           (10011, DATE '1992-01-22', DATE '1993-01-21', 48214);
INSERT INTO salaries VALUES(10011, DATE '1993-01-21', DATE '1994-01-21', 50927),
                           (10011, DATE '1994-01-21', DATE '1995-01-21', 51470),
                           (10011, DATE '1995-01-21', DATE '1996-01-21', 54545),
                           (10011, DATE '1996-01-21', DATE '1996-11-09', 56753);
INSERT INTO titles VALUES(10011, 'Staff', DATE '1990-01-22', DATE '1996-11-09');
INSERT INTO employees VALUES(10012, 'Patricio', 'Bridgland', 1, DATE '1960-10-04', DATE '1992-12-18');
INSERT INTO dept_emp VALUES(10012, 'd005', DATE '1992-12-18', DATE '9999-01-01');
INSERT INTO salaries VALUES(10012, DATE '1992-12-18', DATE '1993-12-18', 40000),
                           (10012, DATE '1993-12-18', DATE '1994-12-18', 41867),
                           (10012, DATE '1994-12-18', DATE '1995-12-18', 42318),
                           (10012, DATE '1995-12-18', DATE '1996-12-17', 44195),
                           (10012, DATE '1996-12-17', DATE '1997-12-17', 46460),
                           (10012, DATE '1997-12-17', DATE '1998-12-17', 46485);
INSERT INTO salaries VALUES(10012, DATE '1998-12-17', DATE '1999-12-17', 47364),
                           (10012, DATE '1999-12-17', DATE '2000-12-16', 51122),
                           (10012, DATE '2000-12-16', DATE '2001-12-16', 54794),
                           (10012, DATE '2001-12-16', DATE '9999-01-01', 54423);
INSERT INTO titles VALUES(10012, 'Engineer', DATE '1992-12-18', DATE '2000-12-18'),
                         (10012, 'Senior Engineer', DATE '2000-12-18', DATE '9999-01-01');
INSERT INTO employees VALUES(10013, 'Eberhardt', 'Terkki', 1, DATE '1963-06-07', DATE '1985-10-20');
INSERT INTO dept_emp VALUES(10013, 'd003', DATE '1985-10-20', DATE '9999-01-01');
INSERT INTO salaries VALUES(10013, DATE '1985-10-20', DATE '1986-10-20', 40000),
                           (10013, DATE '1986-10-20', DATE '1987-10-20', 40623),
                           (10013, DATE '1987-10-20', DATE '1988-10-19', 40561),
                           (10013, DATE '1988-10-19', DATE '1989-10-19', 40306);
INSERT INTO salaries VALUES(10013, DATE '1989-10-19', DATE '1990-10-19', 43569),
                           (10013, DATE '1990-10-19', DATE '1991-10-19', 46305),
                           (10013, DATE '1991-10-19', DATE '1992-10-18', 47118),
                           (10013, DATE '1992-10-18', DATE '1993-10-18', 50351),
                           (10013, DATE '1993-10-18', DATE '1994-10-18', 49887),
                           (10013, DATE '1994-10-18', DATE '1995-10-18', 53957),
                           (10013, DATE '1995-10-18', DATE '1996-10-17', 57590),
                           (10013, DATE '1996-10-17', DATE '1997-10-17', 59228),
                           (10013, DATE '1997-10-17', DATE '1998-10-17', 59571),
                           (10013, DATE '1998-10-17', DATE '1999-10-17', 63274),
                           (10013, DATE '1999-10-17', DATE '2000-10-16', 63352),
                           (10013, DATE '2000-10-16', DATE '2001-10-16', 66744),
                           (10013, DATE '2001-10-16', DATE '9999-01-01', 68901);
INSERT INTO titles VALUES(10013, 'Senior Staff', DATE '1985-10-20', DATE '9999-01-01');
INSERT INTO employees VALUES(10014, 'Berni', 'Genin', 1, DATE '1956-02-12', DATE '1987-03-11');
INSERT INTO dept_emp VALUES(10014, 'd005', DATE '1993-12-29', DATE '9999-01-01');
INSERT INTO salaries VALUES(10014, DATE '1993-12-29', DATE '1994-12-29', 46168),
                           (10014, DATE '1994-12-29', DATE '1995-12-29', 48242),
                           (10014, DATE '1995-12-29', DATE '1996-12-28', 47921),
                           (10014, DATE '1996-12-28', DATE '1997-12-28', 50715),
                           (10014, DATE '1997-12-28', DATE '1998-12-28', 53228),
                           (10014, DATE '1998-12-28', DATE '1999-12-28', 53962),
                           (10014, DATE '1999-12-28', DATE '2000-12-27', 56937),
                           (10014, DATE '2000-12-27', DATE '2001-12-27', 59142),
                           (10014, DATE '2001-12-27', DATE '9999-01-01', 60598);
INSERT INTO titles VALUES(10014, 'Engineer', DATE '1993-12-29', DATE '9999-01-01');
INSERT INTO employees VALUES(10015, 'Guoxiang', 'Nooteboom', 1, DATE '1959-08-19', DATE '1987-07-02');
INSERT INTO dept_emp VALUES(10015, 'd008', DATE '1992-09-19', DATE '1993-08-22');
INSERT INTO salaries VALUES(10015, DATE '1992-09-19', DATE '1993-08-22', 40000);
INSERT INTO titles VALUES(10015, 'Senior Staff', DATE '1992-09-19', DATE '1993-08-22');
INSERT INTO employees VALUES(10016, 'Kazuhito', 'Cappelletti', 1, DATE '1961-05-02', DATE '1995-01-27');
INSERT INTO dept_emp VALUES(10016, 'd007', DATE '1998-02-11', DATE '9999-01-01');
INSERT INTO salaries VALUES(10016, DATE '1998-02-11', DATE '1999-02-11', 70889),
                           (10016, DATE '1999-02-11', DATE '2000-02-11', 72946),
                           (10016, DATE '2000-02-11', DATE '2001-02-10', 76826),
                           (10016, DATE '2001-02-10', DATE '2002-02-10', 76381),
                           (10016, DATE '2002-02-10', DATE '9999-01-01', 77935);
INSERT INTO titles VALUES(10016, 'Staff', DATE '1998-02-11', DATE '9999-01-01');
INSERT INTO employees VALUES(10017, 'Cristinel', 'Bouloucos', 2, DATE '1958-07-06', DATE '1993-08-03');
INSERT INTO dept_emp VALUES(10017, 'd001', DATE '1993-08-03', DATE '9999-01-01');
INSERT INTO salaries VALUES(10017, DATE '1993-08-03', DATE '1994-08-03', 71380),
                           (10017, DATE '1994-08-03', DATE '1995-08-03', 75538),
                           (10017, DATE '1995-08-03', DATE '1996-08-02', 79510),
                           (10017, DATE '1996-08-02', DATE '1997-08-02', 82163),
                           (10017, DATE '1997-08-02', DATE '1998-08-02', 86157),
                           (10017, DATE '1998-08-02', DATE '1999-08-02', 89619),
                           (10017, DATE '1999-08-02', DATE '2000-08-01', 91985),
                           (10017, DATE '2000-08-01', DATE '2001-08-01', 96122),
                           (10017, DATE '2001-08-01', DATE '2002-08-01', 98522),
                           (10017, DATE '2002-08-01', DATE '9999-01-01', 99651);
INSERT INTO titles VALUES(10017, 'Senior Staff', DATE '2000-08-03', DATE '9999-01-01');
INSERT INTO titles VALUES(10017, 'Staff', DATE '1993-08-03', DATE '2000-08-03');
INSERT INTO employees VALUES(10018, 'Kazuhide', 'Peha', 2, DATE '1954-06-19', DATE '1987-04-03');
INSERT INTO dept_emp VALUES(10018, 'd004', DATE '1992-07-29', DATE '9999-01-01'),
                           (10018, 'd005', DATE '1987-04-03', DATE '1992-07-29');
INSERT INTO salaries VALUES(10018, DATE '1987-04-03', DATE '1988-04-02', 55881),
                           (10018, DATE '1988-04-02', DATE '1989-04-02', 59206),
                           (10018, DATE '1989-04-02', DATE '1990-04-02', 61361),
                           (10018, DATE '1990-04-02', DATE '1991-04-02', 61648),
                           (10018, DATE '1991-04-02', DATE '1992-04-01', 61217),
                           (10018, DATE '1992-04-01', DATE '1993-04-01', 61244),
                           (10018, DATE '1993-04-01', DATE '1994-04-01', 63286),
                           (10018, DATE '1994-04-01', DATE '1995-04-01', 65739),
                           (10018, DATE '1995-04-01', DATE '1996-03-31', 67519);
INSERT INTO salaries VALUES(10018, DATE '1996-03-31', DATE '1997-03-31', 69276),
                           (10018, DATE '1997-03-31', DATE '1998-03-31', 72585),
                           (10018, DATE '1998-03-31', DATE '1999-03-31', 72804),
                           (10018, DATE '1999-03-31', DATE '2000-03-30', 76957),
                           (10018, DATE '2000-03-30', DATE '2001-03-30', 80305),
                           (10018, DATE '2001-03-30', DATE '2002-03-30', 84541),
                           (10018, DATE '2002-03-30', DATE '9999-01-01', 84672);
INSERT INTO titles VALUES(10018, 'Engineer', DATE '1987-04-03', DATE '1995-04-03'),
                         (10018, 'Senior Engineer', DATE '1995-04-03', DATE '9999-01-01');
INSERT INTO employees VALUES(10019, 'Lillian', 'Haddadi', 1, DATE '1953-01-23', DATE '1999-04-30');
INSERT INTO dept_emp VALUES(10019, 'd008', DATE '1999-04-30', DATE '9999-01-01');
INSERT INTO salaries VALUES(10019, DATE '1999-04-30', DATE '2000-04-29', 44276);
INSERT INTO salaries VALUES(10019, DATE '2000-04-29', DATE '2001-04-29', 46946),
                           (10019, DATE '2001-04-29', DATE '2002-04-29', 46775),
                           (10019, DATE '2002-04-29', DATE '9999-01-01', 50032);
INSERT INTO titles VALUES(10019, 'Staff', DATE '1999-04-30', DATE '9999-01-01');
INSERT INTO employees VALUES(10020, 'Mayuko', 'Warwick', 1, DATE '1952-12-24', DATE '1991-01-26');
INSERT INTO dept_emp VALUES(10020, 'd004', DATE '1997-12-30', DATE '9999-01-01');
INSERT INTO salaries VALUES(10020, DATE '1997-12-30', DATE '1998-12-30', 40000),
                           (10020, DATE '1998-12-30', DATE '1999-12-30', 40647),
                           (10020, DATE '1999-12-30', DATE '2000-12-29', 43800),
                           (10020, DATE '2000-12-29', DATE '2001-12-29', 44927),
                           (10020, DATE '2001-12-29', DATE '9999-01-01', 47017);
INSERT INTO titles VALUES(10020, 'Engineer', DATE '1997-12-30', DATE '9999-01-01');
INSERT INTO employees VALUES(10021, 'Ramzi', 'Erde', 1, DATE '1960-02-20', DATE '1988-02-10');
INSERT INTO dept_emp VALUES(10021, 'd005', DATE '1988-02-10', DATE '2002-07-15');
INSERT INTO salaries VALUES(10021, DATE '1988-02-10', DATE '1989-02-09', 55025),
                           (10021, DATE '1989-02-09', DATE '1990-02-09', 56399),
                           (10021, DATE '1990-02-09', DATE '1991-02-09', 59700),
                           (10021, DATE '1991-02-09', DATE '1992-02-09', 60851),
                           (10021, DATE '1992-02-09', DATE '1993-02-08', 61117),
                           (10021, DATE '1993-02-08', DATE '1994-02-08', 60708),
                           (10021, DATE '1994-02-08', DATE '1995-02-08', 63514),
                           (10021, DATE '1995-02-08', DATE '1996-02-08', 66249),
                           (10021, DATE '1996-02-08', DATE '1997-02-07', 70570),
                           (10021, DATE '1997-02-07', DATE '1998-02-07', 74759),
                           (10021, DATE '1998-02-07', DATE '1999-02-07', 77519),
                           (10021, DATE '1999-02-07', DATE '2000-02-07', 77237);
INSERT INTO salaries VALUES(10021, DATE '2000-02-07', DATE '2001-02-06', 79631),
                           (10021, DATE '2001-02-06', DATE '2002-02-06', 82295),
                           (10021, DATE '2002-02-06', DATE '2002-07-15', 84169);
INSERT INTO titles VALUES(10021, 'Technique Leader', DATE '1988-02-10', DATE '2002-07-15');
INSERT INTO employees VALUES(10022, 'Shahaf', 'Famili', 1, DATE '1952-07-08', DATE '1995-08-22');
INSERT INTO dept_emp VALUES(10022, 'd005', DATE '1999-09-03', DATE '9999-01-01');
INSERT INTO salaries VALUES(10022, DATE '1999-09-03', DATE '2000-09-02', 40000),
                           (10022, DATE '2000-09-02', DATE '2001-09-02', 39935),
                           (10022, DATE '2001-09-02', DATE '9999-01-01', 41348);
INSERT INTO titles VALUES(10022, 'Engineer', DATE '1999-09-03', DATE '9999-01-01');
INSERT INTO employees VALUES(10023, 'Bojan', 'Montemayor', 2, DATE '1953-09-29', DATE '1989-12-17');
INSERT INTO dept_emp VALUES(10023, 'd005', DATE '1999-09-27', DATE '9999-01-01');
INSERT INTO salaries VALUES(10023, DATE '1999-09-27', DATE '2000-09-26', 47883),
                           (10023, DATE '2000-09-26', DATE '2001-09-26', 50319),
                           (10023, DATE '2001-09-26', DATE '9999-01-01', 50113);
INSERT INTO titles VALUES(10023, 'Engineer', DATE '1999-09-27', DATE '9999-01-01');
INSERT INTO employees VALUES(10024, 'Suzette', 'Pettey', 2, DATE '1958-09-05', DATE '1997-05-19');
INSERT INTO dept_emp VALUES(10024, 'd004', DATE '1998-06-14', DATE '9999-01-01');
INSERT INTO salaries VALUES(10024, DATE '1998-06-14', DATE '1999-06-14', 83733),
                           (10024, DATE '1999-06-14', DATE '2000-06-13', 86715),
                           (10024, DATE '2000-06-13', DATE '2001-06-13', 91067),
                           (10024, DATE '2001-06-13', DATE '2002-06-13', 94701),
                           (10024, DATE '2002-06-13', DATE '9999-01-01', 96646);
INSERT INTO titles VALUES(10024, 'Assistant Engineer', DATE '1998-06-14', DATE '9999-01-01');
INSERT INTO employees VALUES(10025, 'Prasadram', 'Heyers', 1, DATE '1958-10-31', DATE '1987-08-17');
INSERT INTO dept_emp VALUES(10025, 'd005', DATE '1987-08-17', DATE '1997-10-15');
INSERT INTO salaries VALUES(10025, DATE '1987-08-17', DATE '1988-08-16', 40000),
                           (10025, DATE '1988-08-16', DATE '1989-08-16', 44416),
                           (10025, DATE '1989-08-16', DATE '1990-08-16', 48680),
                           (10025, DATE '1990-08-16', DATE '1991-08-16', 50120),
                           (10025, DATE '1991-08-16', DATE '1992-08-15', 50980),
                           (10025, DATE '1992-08-15', DATE '1993-08-15', 54459),
                           (10025, DATE '1993-08-15', DATE '1994-08-15', 54395),
                           (10025, DATE '1994-08-15', DATE '1995-08-15', 56643),
                           (10025, DATE '1995-08-15', DATE '1996-08-14', 57585),
                           (10025, DATE '1996-08-14', DATE '1997-08-14', 57110),
                           (10025, DATE '1997-08-14', DATE '1997-10-15', 57157);
INSERT INTO titles VALUES(10025, 'Technique Leader', DATE '1987-08-17', DATE '1997-10-15');
INSERT INTO employees VALUES(10026, 'Yongqiao', 'Berztiss', 1, DATE '1953-04-03', DATE '1995-03-20');
INSERT INTO dept_emp VALUES(10026, 'd004', DATE '1995-03-20', DATE '9999-01-01');
INSERT INTO salaries VALUES(10026, DATE '1995-03-20', DATE '1996-03-19', 47585),
                           (10026, DATE '1996-03-19', DATE '1997-03-19', 51730),
                           (10026, DATE '1997-03-19', DATE '1998-03-19', 53682),
                           (10026, DATE '1998-03-19', DATE '1999-03-19', 56769),
                           (10026, DATE '1999-03-19', DATE '2000-03-18', 60397),
                           (10026, DATE '2000-03-18', DATE '2001-03-18', 64132),
                           (10026, DATE '2001-03-18', DATE '2002-03-18', 65415),
                           (10026, DATE '2002-03-18', DATE '9999-01-01', 66313);
INSERT INTO titles VALUES(10026, 'Engineer', DATE '1995-03-20', DATE '2001-03-19');
INSERT INTO titles VALUES(10026, 'Senior Engineer', DATE '2001-03-19', DATE '9999-01-01');
INSERT INTO employees VALUES(10027, 'Divier', 'Reistad', 2, DATE '1962-07-10', DATE '1989-07-07');
INSERT INTO dept_emp VALUES(10027, 'd005', DATE '1995-04-02', DATE '9999-01-01');
INSERT INTO salaries VALUES(10027, DATE '1995-04-02', DATE '1996-04-01', 40000),
                           (10027, DATE '1996-04-01', DATE '1997-04-01', 39520),
                           (10027, DATE '1997-04-01', DATE '1998-04-01', 42382),
                           (10027, DATE '1998-04-01', DATE '1999-04-01', 43654),
                           (10027, DATE '1999-04-01', DATE '2000-03-31', 43925),
                           (10027, DATE '2000-03-31', DATE '2001-03-31', 45157),
                           (10027, DATE '2001-03-31', DATE '2002-03-31', 45771),
                           (10027, DATE '2002-03-31', DATE '9999-01-01', 46145);
INSERT INTO titles VALUES(10027, 'Engineer', DATE '1995-04-02', DATE '2001-04-01');
INSERT INTO titles VALUES(10027, 'Senior Engineer', DATE '2001-04-01', DATE '9999-01-01');
INSERT INTO employees VALUES(10028, 'Domenick', 'Tempesti', 1, DATE '1963-11-26', DATE '1991-10-22');
INSERT INTO dept_emp VALUES(10028, 'd005', DATE '1991-10-22', DATE '1998-04-06');
INSERT INTO salaries VALUES(10028, DATE '1991-10-22', DATE '1992-10-21', 48859),
                           (10028, DATE '1992-10-21', DATE '1993-10-21', 50805),
                           (10028, DATE '1993-10-21', DATE '1994-10-21', 52082),
                           (10028, DATE '1994-10-21', DATE '1995-10-21', 54949),
                           (10028, DATE '1995-10-21', DATE '1996-10-20', 55963),
                           (10028, DATE '1996-10-20', DATE '1997-10-20', 57831),
                           (10028, DATE '1997-10-20', DATE '1998-04-06', 58502);
INSERT INTO titles VALUES(10028, 'Engineer', DATE '1991-10-22', DATE '1998-04-06');
INSERT INTO employees VALUES(10029, 'Otmar', 'Herbst', 1, DATE '1956-12-13', DATE '1985-11-20');
INSERT INTO dept_emp VALUES(10029, 'd004', DATE '1991-09-18', DATE '1999-07-08'),
                           (10029, 'd006', DATE '1999-07-08', DATE '9999-01-01');
INSERT INTO salaries VALUES(10029, DATE '1991-09-18', DATE '1992-09-17', 63163),
                           (10029, DATE '1992-09-17', DATE '1993-09-17', 66877),
                           (10029, DATE '1993-09-17', DATE '1994-09-17', 69211),
                           (10029, DATE '1994-09-17', DATE '1995-09-17', 70624),
                           (10029, DATE '1995-09-17', DATE '1996-09-16', 70294),
                           (10029, DATE '1996-09-16', DATE '1997-09-16', 70671),
                           (10029, DATE '1997-09-16', DATE '1998-09-16', 73510),
                           (10029, DATE '1998-09-16', DATE '1999-09-16', 75773),
                           (10029, DATE '1999-09-16', DATE '2000-09-15', 76067),
                           (10029, DATE '2000-09-15', DATE '2001-09-15', 76608),
                           (10029, DATE '2001-09-15', DATE '9999-01-01', 77777);
INSERT INTO titles VALUES(10029, 'Engineer', DATE '1991-09-18', DATE '2000-09-17'),
                         (10029, 'Senior Engineer', DATE '2000-09-17', DATE '9999-01-01');
INSERT INTO employees VALUES(10030, 'Elvis', 'Demeyer', 1, DATE '1958-07-14', DATE '1994-02-17');
INSERT INTO dept_emp VALUES(10030, 'd004', DATE '1994-02-17', DATE '9999-01-01');
INSERT INTO salaries VALUES(10030, DATE '1994-02-17', DATE '1995-02-17', 66956),
                           (10030, DATE '1995-02-17', DATE '1996-02-17', 68393),
                           (10030, DATE '1996-02-17', DATE '1997-02-16', 72795),
                           (10030, DATE '1997-02-16', DATE '1998-02-16', 76453),
                           (10030, DATE '1998-02-16', DATE '1999-02-16', 79290),
                           (10030, DATE '1999-02-16', DATE '2000-02-16', 83327),
                           (10030, DATE '2000-02-16', DATE '2001-02-15', 86634),
                           (10030, DATE '2001-02-15', DATE '2002-02-15', 87027);
INSERT INTO salaries VALUES(10030, DATE '2002-02-15', DATE '9999-01-01', 88806);
INSERT INTO titles VALUES(10030, 'Engineer', DATE '1994-02-17', DATE '2001-02-17'),
                         (10030, 'Senior Engineer', DATE '2001-02-17', DATE '9999-01-01');
INSERT INTO employees VALUES(10031, 'Karsten', 'Joslin', 1, DATE '1959-01-27', DATE '1991-09-01');
INSERT INTO dept_emp VALUES(10031, 'd005', DATE '1991-09-01', DATE '9999-01-01');
INSERT INTO salaries VALUES(10031, DATE '1991-09-01', DATE '1992-08-31', 40000),
                           (10031, DATE '1992-08-31', DATE '1993-08-31', 40859),
                           (10031, DATE '1993-08-31', DATE '1994-08-31', 41881),
                           (10031, DATE '1994-08-31', DATE '1995-08-31', 44191),
                           (10031, DATE '1995-08-31', DATE '1996-08-30', 47202),
                           (10031, DATE '1996-08-30', DATE '1997-08-30', 47606),
                           (10031, DATE '1997-08-30', DATE '1998-08-30', 50810);
INSERT INTO salaries VALUES(10031, DATE '1998-08-30', DATE '1999-08-30', 52675),
                           (10031, DATE '1999-08-30', DATE '2000-08-29', 54177),
                           (10031, DATE '2000-08-29', DATE '2001-08-29', 53873),
                           (10031, DATE '2001-08-29', DATE '9999-01-01', 56689);
INSERT INTO titles VALUES(10031, 'Engineer', DATE '1991-09-01', DATE '1998-09-01'),
                         (10031, 'Senior Engineer', DATE '1998-09-01', DATE '9999-01-01');
INSERT INTO employees VALUES(10032, 'Jeong', 'Reistad', 2, DATE '1960-08-09', DATE '1990-06-20');
INSERT INTO dept_emp VALUES(10032, 'd004', DATE '1990-06-20', DATE '9999-01-01');
INSERT INTO salaries VALUES(10032, DATE '1990-06-20', DATE '1991-06-20', 48426),
                           (10032, DATE '1991-06-20', DATE '1992-06-19', 49389),
                           (10032, DATE '1992-06-19', DATE '1993-06-19', 52000),
                           (10032, DATE '1993-06-19', DATE '1994-06-19', 53038);
INSERT INTO salaries VALUES(10032, DATE '1994-06-19', DATE '1995-06-19', 54336),
                           (10032, DATE '1995-06-19', DATE '1996-06-18', 53978),
                           (10032, DATE '1996-06-18', DATE '1997-06-18', 55090),
                           (10032, DATE '1997-06-18', DATE '1998-06-18', 57110),
                           (10032, DATE '1998-06-18', DATE '1999-06-18', 57926),
                           (10032, DATE '1999-06-18', DATE '2000-06-17', 57876),
                           (10032, DATE '2000-06-17', DATE '2001-06-17', 61709),
                           (10032, DATE '2001-06-17', DATE '2002-06-17', 65820),
                           (10032, DATE '2002-06-17', DATE '9999-01-01', 69539);
INSERT INTO titles VALUES(10032, 'Engineer', DATE '1990-06-20', DATE '1995-06-20'),
                         (10032, 'Senior Engineer', DATE '1995-06-20', DATE '9999-01-01');
INSERT INTO employees VALUES(10033, 'Arif', 'Merlo', 1, DATE '1956-11-14', DATE '1987-03-18');
INSERT INTO dept_emp VALUES(10033, 'd006', DATE '1987-03-18', DATE '1993-03-24');
INSERT INTO salaries VALUES(10033, DATE '1987-03-18', DATE '1988-03-17', 51258),
                           (10033, DATE '1988-03-17', DATE '1989-03-17', 54972),
                           (10033, DATE '1989-03-17', DATE '1990-03-17', 55410),
                           (10033, DATE '1990-03-17', DATE '1991-03-17', 56095),
                           (10033, DATE '1991-03-17', DATE '1992-03-16', 56038),
                           (10033, DATE '1992-03-16', DATE '1993-03-16', 57712),
                           (10033, DATE '1993-03-16', DATE '1993-03-24', 60433);
INSERT INTO titles VALUES(10033, 'Technique Leader', DATE '1987-03-18', DATE '1993-03-24');
INSERT INTO employees VALUES(10034, 'Bader', 'Swan', 1, DATE '1962-12-29', DATE '1988-09-21');
INSERT INTO dept_emp VALUES(10034, 'd007', DATE '1995-04-12', DATE '1999-10-31');
INSERT INTO salaries VALUES(10034, DATE '1995-04-12', DATE '1996-04-11', 47561),
                           (10034, DATE '1996-04-11', DATE '1997-04-11', 51192),
                           (10034, DATE '1997-04-11', DATE '1998-04-11', 52687);
INSERT INTO salaries VALUES(10034, DATE '1998-04-11', DATE '1999-04-11', 53112),
                           (10034, DATE '1999-04-11', DATE '1999-10-31', 53164);
INSERT INTO titles VALUES(10034, 'Staff', DATE '1995-04-12', DATE '1999-10-31');
INSERT INTO employees VALUES(10035, 'Alain', 'Chappelet', 1, DATE '1953-02-08', DATE '1988-09-05');
INSERT INTO dept_emp VALUES(10035, 'd004', DATE '1988-09-05', DATE '9999-01-01');
INSERT INTO salaries VALUES(10035, DATE '1988-09-05', DATE '1989-09-05', 41538),
                           (10035, DATE '1989-09-05', DATE '1990-09-05', 45131),
                           (10035, DATE '1990-09-05', DATE '1991-09-05', 45629),
                           (10035, DATE '1991-09-05', DATE '1992-09-04', 48360),
                           (10035, DATE '1992-09-04', DATE '1993-09-04', 50664),
                           (10035, DATE '1993-09-04', DATE '1994-09-04', 53060),
                           (10035, DATE '1994-09-04', DATE '1995-09-04', 56640),
                           (10035, DATE '1995-09-04', DATE '1996-09-03', 57621);
INSERT INTO salaries VALUES(10035, DATE '1996-09-03', DATE '1997-09-03', 59291),
                           (10035, DATE '1997-09-03', DATE '1998-09-03', 61793),
                           (10035, DATE '1998-09-03', DATE '1999-09-03', 62285),
                           (10035, DATE '1999-09-03', DATE '2000-09-02', 65332),
                           (10035, DATE '2000-09-02', DATE '2001-09-02', 66584),
                           (10035, DATE '2001-09-02', DATE '9999-01-01', 68755);
INSERT INTO titles VALUES(10035, 'Engineer', DATE '1988-09-05', DATE '1996-09-05'),
                         (10035, 'Senior Engineer', DATE '1996-09-05', DATE '9999-01-01');
INSERT INTO employees VALUES(10036, 'Adamantios', 'Portugali', 1, DATE '1959-08-10', DATE '1992-01-03');
INSERT INTO dept_emp VALUES(10036, 'd003', DATE '1992-04-28', DATE '9999-01-01');
INSERT INTO salaries VALUES(10036, DATE '1992-04-28', DATE '1993-04-28', 42819),
                           (10036, DATE '1993-04-28', DATE '1994-04-28', 46756);
INSERT INTO salaries VALUES(10036, DATE '1994-04-28', DATE '1995-04-28', 51084),
                           (10036, DATE '1995-04-28', DATE '1996-04-27', 52308),
                           (10036, DATE '1996-04-27', DATE '1997-04-27', 53828),
                           (10036, DATE '1997-04-27', DATE '1998-04-27', 54408),
                           (10036, DATE '1998-04-27', DATE '1999-04-27', 53929),
                           (10036, DATE '1999-04-27', DATE '2000-04-26', 56579),
                           (10036, DATE '2000-04-26', DATE '2001-04-26', 60478),
                           (10036, DATE '2001-04-26', DATE '2002-04-26', 60520),
                           (10036, DATE '2002-04-26', DATE '9999-01-01', 63053);
INSERT INTO titles VALUES(10036, 'Senior Staff', DATE '1992-04-28', DATE '9999-01-01');
INSERT INTO employees VALUES(10037, 'Pradeep', 'Makrucki', 1, DATE '1963-07-22', DATE '1990-12-05');
INSERT INTO dept_emp VALUES(10037, 'd005', DATE '1990-12-05', DATE '9999-01-01');
INSERT INTO salaries VALUES(10037, DATE '1990-12-05', DATE '1991-12-05', 40000);
INSERT INTO salaries VALUES(10037, DATE '1991-12-05', DATE '1992-12-04', 39765),
                           (10037, DATE '1992-12-04', DATE '1993-12-04', 43565),
                           (10037, DATE '1993-12-04', DATE '1994-12-04', 43104),
                           (10037, DATE '1994-12-04', DATE '1995-12-04', 46100),
                           (10037, DATE '1995-12-04', DATE '1996-12-03', 49735),
                           (10037, DATE '1996-12-03', DATE '1997-12-03', 51775),
                           (10037, DATE '1997-12-03', DATE '1998-12-03', 53198),
                           (10037, DATE '1998-12-03', DATE '1999-12-03', 56270),
                           (10037, DATE '1999-12-03', DATE '2000-12-02', 59882),
                           (10037, DATE '2000-12-02', DATE '2001-12-02', 60992),
                           (10037, DATE '2001-12-02', DATE '9999-01-01', 60574);
INSERT INTO titles VALUES(10037, 'Engineer', DATE '1990-12-05', DATE '1995-12-05'),
                         (10037, 'Senior Engineer', DATE '1995-12-05', DATE '9999-01-01');
INSERT INTO employees VALUES(10038, 'Huan', 'Lortz', 1, DATE '1960-07-20', DATE '1989-09-20');
INSERT INTO dept_emp VALUES(10038, 'd009', DATE '1989-09-20', DATE '9999-01-01');
INSERT INTO salaries VALUES(10038, DATE '1989-09-20', DATE '1990-09-20', 40000),
                           (10038, DATE '1990-09-20', DATE '1991-09-20', 43527),
                           (10038, DATE '1991-09-20', DATE '1992-09-19', 46509),
                           (10038, DATE '1992-09-19', DATE '1993-09-19', 49874),
                           (10038, DATE '1993-09-19', DATE '1994-09-19', 52969),
                           (10038, DATE '1994-09-19', DATE '1995-09-19', 56629),
                           (10038, DATE '1995-09-19', DATE '1996-09-18', 58079),
                           (10038, DATE '1996-09-18', DATE '1997-09-18', 60322),
                           (10038, DATE '1997-09-18', DATE '1998-09-18', 62274),
                           (10038, DATE '1998-09-18', DATE '1999-09-18', 62517),
                           (10038, DATE '1999-09-18', DATE '2000-09-17', 62458);
INSERT INTO salaries VALUES(10038, DATE '2000-09-17', DATE '2001-09-17', 64238),
                           (10038, DATE '2001-09-17', DATE '9999-01-01', 64254);
INSERT INTO titles VALUES(10038, 'Senior Staff', DATE '1996-09-20', DATE '9999-01-01'),
                         (10038, 'Staff', DATE '1989-09-20', DATE '1996-09-20');
INSERT INTO employees VALUES(10039, 'Alejandro', 'Brender', 1, DATE '1959-10-01', DATE '1988-01-19');
INSERT INTO dept_emp VALUES(10039, 'd003', DATE '1988-01-19', DATE '9999-01-01');
INSERT INTO salaries VALUES(10039, DATE '1988-01-19', DATE '1989-01-18', 40000),
                           (10039, DATE '1989-01-18', DATE '1990-01-18', 41525),
                           (10039, DATE '1990-01-18', DATE '1991-01-18', 43801),
                           (10039, DATE '1991-01-18', DATE '1992-01-18', 46278),
                           (10039, DATE '1992-01-18', DATE '1993-01-17', 45838),
                           (10039, DATE '1993-01-17', DATE '1994-01-17', 49155),
                           (10039, DATE '1994-01-17', DATE '1995-01-17', 52999);
INSERT INTO salaries VALUES(10039, DATE '1995-01-17', DATE '1996-01-17', 55037),
                           (10039, DATE '1996-01-17', DATE '1997-01-16', 54937),
                           (10039, DATE '1997-01-16', DATE '1998-01-16', 55204),
                           (10039, DATE '1998-01-16', DATE '1999-01-16', 59593),
                           (10039, DATE '1999-01-16', DATE '2000-01-16', 62131),
                           (10039, DATE '2000-01-16', DATE '2001-01-15', 61774),
                           (10039, DATE '2001-01-15', DATE '2002-01-15', 63592),
                           (10039, DATE '2002-01-15', DATE '9999-01-01', 63918);
INSERT INTO titles VALUES(10039, 'Senior Staff', DATE '1997-01-18', DATE '9999-01-01'),
                         (10039, 'Staff', DATE '1988-01-19', DATE '1997-01-18');
INSERT INTO employees VALUES(10040, 'Weiyi', 'Meriste', 2, DATE '1959-09-13', DATE '1993-02-14');
INSERT INTO dept_emp VALUES(10040, 'd005', DATE '1993-02-14', DATE '2002-01-22'),
                           (10040, 'd008', DATE '2002-01-22', DATE '9999-01-01');
INSERT INTO salaries VALUES(10040, DATE '1993-02-14', DATE '1994-02-14', 52153),
                           (10040, DATE '1994-02-14', DATE '1995-02-14', 53533),
                           (10040, DATE '1995-02-14', DATE '1996-02-14', 56565),
                           (10040, DATE '1996-02-14', DATE '1997-02-13', 60260),
                           (10040, DATE '1997-02-13', DATE '1998-02-13', 62101),
                           (10040, DATE '1998-02-13', DATE '1999-02-13', 63870),
                           (10040, DATE '1999-02-13', DATE '2000-02-13', 64570),
                           (10040, DATE '2000-02-13', DATE '2001-02-12', 67016),
                           (10040, DATE '2001-02-12', DATE '2002-02-12', 68185),
                           (10040, DATE '2002-02-12', DATE '9999-01-01', 72668);
INSERT INTO titles VALUES(10040, 'Engineer', DATE '1993-02-14', DATE '1999-02-14'),
                         (10040, 'Senior Engineer', DATE '1999-02-14', DATE '9999-01-01');
INSERT INTO employees VALUES(10041, 'Uri', 'Lenart', 2, DATE '1959-08-27', DATE '1989-11-12');
INSERT INTO dept_emp VALUES(10041, 'd007', DATE '1989-11-12', DATE '9999-01-01');
INSERT INTO salaries VALUES(10041, DATE '1989-11-12', DATE '1990-11-12', 56893),
                           (10041, DATE '1990-11-12', DATE '1991-11-12', 60824),
                           (10041, DATE '1991-11-12', DATE '1992-11-11', 63116),
                           (10041, DATE '1992-11-11', DATE '1993-11-11', 64128),
                           (10041, DATE '1993-11-11', DATE '1994-11-11', 65615),
                           (10041, DATE '1994-11-11', DATE '1995-11-11', 69768),
                           (10041, DATE '1995-11-11', DATE '1996-11-10', 70216),
                           (10041, DATE '1996-11-10', DATE '1997-11-10', 71322),
                           (10041, DATE '1997-11-10', DATE '1998-11-10', 74575),
                           (10041, DATE '1998-11-10', DATE '1999-11-10', 75544),
                           (10041, DATE '1999-11-10', DATE '2000-11-09', 79746),
                           (10041, DATE '2000-11-09', DATE '2001-11-09', 81012);
INSERT INTO salaries VALUES(10041, DATE '2001-11-09', DATE '9999-01-01', 81705);
INSERT INTO titles VALUES(10041, 'Senior Staff', DATE '1998-11-12', DATE '9999-01-01'),
                         (10041, 'Staff', DATE '1989-11-12', DATE '1998-11-12');
INSERT INTO employees VALUES(10042, 'Magy', 'Stamatiou', 2, DATE '1956-02-26', DATE '1993-03-21');
INSERT INTO dept_emp VALUES(10042, 'd002', DATE '1993-03-21', DATE '2000-08-10');
INSERT INTO salaries VALUES(10042, DATE '1993-03-21', DATE '1994-03-21', 81662),
                           (10042, DATE '1994-03-21', DATE '1995-03-21', 84183),
                           (10042, DATE '1995-03-21', DATE '1996-03-20', 84389),
                           (10042, DATE '1996-03-20', DATE '1997-03-20', 85501),
                           (10042, DATE '1997-03-20', DATE '1998-03-20', 89833),
                           (10042, DATE '1998-03-20', DATE '1999-03-20', 91161),
                           (10042, DATE '1999-03-20', DATE '2000-03-19', 95035),
                           (10042, DATE '2000-03-19', DATE '2000-08-10', 94868);
INSERT INTO titles VALUES(10042, 'Senior Staff', DATE '2000-03-21', DATE '2000-08-10'),
                         (10042, 'Staff', DATE '1993-03-21', DATE '2000-03-21');
INSERT INTO employees VALUES(10043, 'Yishay', 'Tzvieli', 1, DATE '1960-09-19', DATE '1990-10-20');
INSERT INTO dept_emp VALUES(10043, 'd005', DATE '1990-10-20', DATE '9999-01-01');
INSERT INTO salaries VALUES(10043, DATE '1990-10-20', DATE '1991-10-20', 49324),
                           (10043, DATE '1991-10-20', DATE '1992-10-19', 51948),
                           (10043, DATE '1992-10-19', DATE '1993-10-19', 54011),
                           (10043, DATE '1993-10-19', DATE '1994-10-19', 58302),
                           (10043, DATE '1994-10-19', DATE '1995-10-19', 62291),
                           (10043, DATE '1995-10-19', DATE '1996-10-18', 65669),
                           (10043, DATE '1996-10-18', DATE '1997-10-18', 65562),
                           (10043, DATE '1997-10-18', DATE '1998-10-18', 68328),
                           (10043, DATE '1998-10-18', DATE '1999-10-18', 70689);
INSERT INTO salaries VALUES(10043, DATE '1999-10-18', DATE '2000-10-17', 72543),
                           (10043, DATE '2000-10-17', DATE '2001-10-17', 76677),
                           (10043, DATE '2001-10-17', DATE '9999-01-01', 77659);
INSERT INTO titles VALUES(10043, 'Engineer', DATE '1990-10-20', DATE '1997-10-20'),
                         (10043, 'Senior Engineer', DATE '1997-10-20', DATE '9999-01-01');
INSERT INTO employees VALUES(10044, 'Mingsen', 'Casley', 2, DATE '1961-09-21', DATE '1994-05-21');
INSERT INTO dept_emp VALUES(10044, 'd004', DATE '1994-05-21', DATE '9999-01-01');
INSERT INTO salaries VALUES(10044, DATE '1994-05-21', DATE '1995-05-21', 40919),
                           (10044, DATE '1995-05-21', DATE '1996-05-20', 45217),
                           (10044, DATE '1996-05-20', DATE '1997-05-20', 46674),
                           (10044, DATE '1997-05-20', DATE '1998-05-20', 48623),
                           (10044, DATE '1998-05-20', DATE '1999-05-20', 51377);
INSERT INTO salaries VALUES(10044, DATE '1999-05-20', DATE '2000-05-19', 53186),
                           (10044, DATE '2000-05-19', DATE '2001-05-19', 56058),
                           (10044, DATE '2001-05-19', DATE '2002-05-19', 56810),
                           (10044, DATE '2002-05-19', DATE '9999-01-01', 58345);
INSERT INTO titles VALUES(10044, 'Technique Leader', DATE '1994-05-21', DATE '9999-01-01');
INSERT INTO employees VALUES(10045, 'Moss', 'Shanbhogue', 1, DATE '1957-08-14', DATE '1989-09-02');
INSERT INTO dept_emp VALUES(10045, 'd004', DATE '1996-11-16', DATE '9999-01-01');
INSERT INTO salaries VALUES(10045, DATE '1996-11-16', DATE '1997-11-16', 41971),
                           (10045, DATE '1997-11-16', DATE '1998-11-16', 42914),
                           (10045, DATE '1998-11-16', DATE '1999-11-16', 43046),
                           (10045, DATE '1999-11-16', DATE '2000-11-15', 43838),
                           (10045, DATE '2000-11-15', DATE '2001-11-15', 47984);
INSERT INTO salaries VALUES(10045, DATE '2001-11-15', DATE '9999-01-01', 47581);
INSERT INTO titles VALUES(10045, 'Engineer', DATE '1996-11-16', DATE '9999-01-01');
INSERT INTO employees VALUES(10046, 'Lucien', 'Rosenbaum', 1, DATE '1960-07-23', DATE '1992-06-20');
INSERT INTO dept_emp VALUES(10046, 'd008', DATE '1992-06-20', DATE '9999-01-01');
INSERT INTO salaries VALUES(10046, DATE '1992-06-20', DATE '1993-06-20', 40000),
                           (10046, DATE '1993-06-20', DATE '1994-06-20', 42385),
                           (10046, DATE '1994-06-20', DATE '1995-06-20', 43485),
                           (10046, DATE '1995-06-20', DATE '1996-06-19', 43203),
                           (10046, DATE '1996-06-19', DATE '1997-06-19', 45150),
                           (10046, DATE '1997-06-19', DATE '1998-06-19', 48222),
                           (10046, DATE '1998-06-19', DATE '1999-06-19', 50853),
                           (10046, DATE '1999-06-19', DATE '2000-06-18', 52271),
                           (10046, DATE '2000-06-18', DATE '2001-06-18', 56481);
INSERT INTO salaries VALUES(10046, DATE '2001-06-18', DATE '2002-06-18', 60249),
                           (10046, DATE '2002-06-18', DATE '9999-01-01', 62218);
INSERT INTO titles VALUES(10046, 'Senior Staff', DATE '2000-06-20', DATE '9999-01-01'),
                         (10046, 'Staff', DATE '1992-06-20', DATE '2000-06-20');
INSERT INTO employees VALUES(10047, 'Zvonko', 'Nyanchama', 1, DATE '1952-06-29', DATE '1989-03-31');
INSERT INTO dept_emp VALUES(10047, 'd004', DATE '1989-03-31', DATE '9999-01-01');
INSERT INTO salaries VALUES(10047, DATE '1989-03-31', DATE '1990-03-31', 54982),
                           (10047, DATE '1990-03-31', DATE '1991-03-31', 57350),
                           (10047, DATE '1991-03-31', DATE '1992-03-30', 59571),
                           (10047, DATE '1992-03-30', DATE '1993-03-30', 62851),
                           (10047, DATE '1993-03-30', DATE '1994-03-30', 65225),
                           (10047, DATE '1994-03-30', DATE '1995-03-30', 66330),
                           (10047, DATE '1995-03-30', DATE '1996-03-29', 69992);
INSERT INTO salaries VALUES(10047, DATE '1996-03-29', DATE '1997-03-29', 73376),
                           (10047, DATE '1997-03-29', DATE '1998-03-29', 74735),
                           (10047, DATE '1998-03-29', DATE '1999-03-29', 75748),
                           (10047, DATE '1999-03-29', DATE '2000-03-28', 77149),
                           (10047, DATE '2000-03-28', DATE '2001-03-28', 78399),
                           (10047, DATE '2001-03-28', DATE '2002-03-28', 78569),
                           (10047, DATE '2002-03-28', DATE '9999-01-01', 81037);
INSERT INTO titles VALUES(10047, 'Engineer', DATE '1989-03-31', DATE '1998-03-31'),
                         (10047, 'Senior Engineer', DATE '1998-03-31', DATE '9999-01-01');
INSERT INTO employees VALUES(10048, 'Florian', 'Syrotiuk', 1, DATE '1963-07-11', DATE '1985-02-24');
INSERT INTO dept_emp VALUES(10048, 'd005', DATE '1985-02-24', DATE '1987-01-27');
INSERT INTO salaries VALUES(10048, DATE '1985-02-24', DATE '1986-02-24', 40000);
INSERT INTO salaries VALUES(10048, DATE '1986-02-24', DATE '1987-01-27', 39507);
INSERT INTO titles VALUES(10048, 'Engineer', DATE '1985-02-24', DATE '1987-01-27');
INSERT INTO employees VALUES(10049, 'Basil', 'Tramer', 2, DATE '1961-04-24', DATE '1992-05-04');
INSERT INTO dept_emp VALUES(10049, 'd009', DATE '1992-05-04', DATE '9999-01-01');
INSERT INTO salaries VALUES(10049, DATE '1992-05-04', DATE '1993-05-04', 40000),
                           (10049, DATE '1993-05-04', DATE '1994-05-04', 39735),
                           (10049, DATE '1994-05-04', DATE '1995-05-04', 40484),
                           (10049, DATE '1995-05-04', DATE '1996-05-03', 41291),
                           (10049, DATE '1996-05-03', DATE '1997-05-03', 41301),
                           (10049, DATE '1997-05-03', DATE '1998-05-03', 41957),
                           (10049, DATE '1998-05-03', DATE '1999-05-03', 41788),
                           (10049, DATE '1999-05-03', DATE '2000-05-02', 44620),
                           (10049, DATE '2000-05-02', DATE '2001-05-02', 45933);
INSERT INTO salaries VALUES(10049, DATE '2001-05-02', DATE '2002-05-02', 48575),
                           (10049, DATE '2002-05-02', DATE '9999-01-01', 51326);
INSERT INTO titles VALUES(10049, 'Senior Staff', DATE '2000-05-04', DATE '9999-01-01'),
                         (10049, 'Staff', DATE '1992-05-04', DATE '2000-05-04');
INSERT INTO employees VALUES(10050, 'Yinghua', 'Dredge', 1, DATE '1958-05-21', DATE '1990-12-25');
INSERT INTO dept_emp VALUES(10050, 'd002', DATE '1990-12-25', DATE '1992-11-05'),
                           (10050, 'd007', DATE '1992-11-05', DATE '9999-01-01');
INSERT INTO salaries VALUES(10050, DATE '1990-12-25', DATE '1991-12-25', 74366),
                           (10050, DATE '1991-12-25', DATE '1992-12-24', 78675),
                           (10050, DATE '1992-12-24', DATE '1993-12-24', 82220),
                           (10050, DATE '1993-12-24', DATE '1994-12-24', 86604),
                           (10050, DATE '1994-12-24', DATE '1995-12-24', 88087),
                           (10050, DATE '1995-12-24', DATE '1996-12-23', 88836);
INSERT INTO salaries VALUES(10050, DATE '1996-12-23', DATE '1997-12-23', 90623),
                           (10050, DATE '1997-12-23', DATE '1998-12-23', 91530),
                           (10050, DATE '1998-12-23', DATE '1999-12-23', 93689),
                           (10050, DATE '1999-12-23', DATE '2000-12-22', 97571),
                           (10050, DATE '2000-12-22', DATE '2001-12-22', 97817),
                           (10050, DATE '2001-12-22', DATE '9999-01-01', 97830);
INSERT INTO titles VALUES(10050, 'Senior Staff', DATE '1999-12-25', DATE '9999-01-01'),
                         (10050, 'Staff', DATE '1990-12-25', DATE '1999-12-25');
INSERT INTO employees VALUES(10051, 'Hidefumi', 'Caine', 1, DATE '1953-07-28', DATE '1992-10-15');
INSERT INTO dept_emp VALUES(10051, 'd004', DATE '1992-10-15', DATE '9999-01-01');
INSERT INTO salaries VALUES(10051, DATE '1992-10-15', DATE '1993-10-15', 48817),
                           (10051, DATE '1993-10-15', DATE '1994-10-15', 50874),
                           (10051, DATE '1994-10-15', DATE '1995-10-15', 52247);
INSERT INTO salaries VALUES(10051, DATE '1995-10-15', DATE '1996-10-14', 56217),
                           (10051, DATE '1996-10-14', DATE '1997-10-14', 59402),
                           (10051, DATE '1997-10-14', DATE '1998-10-14', 59012),
                           (10051, DATE '1998-10-14', DATE '1999-10-14', 61719),
                           (10051, DATE '1999-10-14', DATE '2000-10-13', 61345),
                           (10051, DATE '2000-10-13', DATE '2001-10-13', 61400),
                           (10051, DATE '2001-10-13', DATE '9999-01-01', 64905);
INSERT INTO titles VALUES(10051, 'Engineer', DATE '1992-10-15', DATE '1998-10-15'),
                         (10051, 'Senior Engineer', DATE '1998-10-15', DATE '9999-01-01');
INSERT INTO employees VALUES(10052, 'Heping', 'Nitsch', 1, DATE '1961-02-26', DATE '1988-05-21');
INSERT INTO dept_emp VALUES(10052, 'd008', DATE '1997-01-31', DATE '9999-01-01');
INSERT INTO salaries VALUES(10052, DATE '1997-01-31', DATE '1998-01-31', 57212);
INSERT INTO salaries VALUES(10052, DATE '1998-01-31', DATE '1999-01-31', 56908),
                           (10052, DATE '1999-01-31', DATE '2000-01-31', 60084),
                           (10052, DATE '2000-01-31', DATE '2001-01-30', 63081),
                           (10052, DATE '2001-01-30', DATE '2002-01-30', 66450),
                           (10052, DATE '2002-01-30', DATE '9999-01-01', 67156);
INSERT INTO titles VALUES(10052, 'Senior Staff', DATE '2002-01-31', DATE '9999-01-01'),
                         (10052, 'Staff', DATE '1997-01-31', DATE '2002-01-31');
INSERT INTO employees VALUES(10053, 'Sanjiv', 'Zschoche', 2, DATE '1954-09-13', DATE '1986-02-04');
INSERT INTO dept_emp VALUES(10053, 'd007', DATE '1994-11-13', DATE '9999-01-01');
INSERT INTO salaries VALUES(10053, DATE '1994-11-13', DATE '1995-11-13', 67854),
                           (10053, DATE '1995-11-13', DATE '1996-11-12', 67912),
                           (10053, DATE '1996-11-12', DATE '1997-11-12', 71459),
                           (10053, DATE '1997-11-12', DATE '1998-11-12', 71283);
INSERT INTO salaries VALUES(10053, DATE '1998-11-12', DATE '1999-11-12', 74822),
                           (10053, DATE '1999-11-12', DATE '2000-11-11', 77425),
                           (10053, DATE '2000-11-11', DATE '2001-11-11', 77531),
                           (10053, DATE '2001-11-11', DATE '9999-01-01', 78478);
INSERT INTO titles VALUES(10053, 'Senior Staff', DATE '1994-11-13', DATE '9999-01-01');
INSERT INTO employees VALUES(10054, 'Mayumi', 'Schueller', 1, DATE '1957-04-04', DATE '1995-03-13');
INSERT INTO dept_emp VALUES(10054, 'd003', DATE '1995-07-29', DATE '9999-01-01');
INSERT INTO salaries VALUES(10054, DATE '1995-07-29', DATE '1996-07-28', 40000),
                           (10054, DATE '1996-07-28', DATE '1997-07-28', 42889),
                           (10054, DATE '1997-07-28', DATE '1998-07-28', 42846),
                           (10054, DATE '1998-07-28', DATE '1999-07-28', 44680),
                           (10054, DATE '1999-07-28', DATE '2000-07-27', 44958),
                           (10054, DATE '2000-07-27', DATE '2001-07-27', 49391);
INSERT INTO salaries VALUES(10054, DATE '2001-07-27', DATE '2002-07-27', 52184),
                           (10054, DATE '2002-07-27', DATE '9999-01-01', 53906);
INSERT INTO titles VALUES(10054, 'Senior Staff', DATE '2000-07-28', DATE '9999-01-01'),
                         (10054, 'Staff', DATE '1995-07-29', DATE '2000-07-28');
INSERT INTO employees VALUES(10055, 'Georgy', 'Dredge', 1, DATE '1956-06-06', DATE '1992-04-27');
INSERT INTO dept_emp VALUES(10055, 'd001', DATE '1992-04-27', DATE '1995-07-22');
INSERT INTO salaries VALUES(10055, DATE '1992-04-27', DATE '1993-04-27', 80024),
                           (10055, DATE '1993-04-27', DATE '1994-04-27', 83592),
                           (10055, DATE '1994-04-27', DATE '1995-04-27', 87473),
                           (10055, DATE '1995-04-27', DATE '1995-07-22', 90843);
INSERT INTO titles VALUES(10055, 'Staff', DATE '1992-04-27', DATE '1995-07-22');
INSERT INTO employees VALUES(10056, 'Brendon', 'Bernini', 2, DATE '1961-09-01', DATE '1990-02-01');
INSERT INTO dept_emp VALUES(10056, 'd005', DATE '1990-02-01', DATE '9999-01-01');
INSERT INTO salaries VALUES(10056, DATE '1990-02-01', DATE '1991-02-01', 48857),
                           (10056, DATE '1991-02-01', DATE '1992-02-01', 51457),
                           (10056, DATE '1992-02-01', DATE '1993-01-31', 53869),
                           (10056, DATE '1993-01-31', DATE '1994-01-31', 54677),
                           (10056, DATE '1994-01-31', DATE '1995-01-31', 56047),
                           (10056, DATE '1995-01-31', DATE '1996-01-31', 59252),
                           (10056, DATE '1996-01-31', DATE '1997-01-30', 61963),
                           (10056, DATE '1997-01-30', DATE '1998-01-30', 65622),
                           (10056, DATE '1998-01-30', DATE '1999-01-30', 67648),
                           (10056, DATE '1999-01-30', DATE '2000-01-30', 70163),
                           (10056, DATE '2000-01-30', DATE '2001-01-29', 69905),
                           (10056, DATE '2001-01-29', DATE '2002-01-29', 74004);
INSERT INTO salaries VALUES(10056, DATE '2002-01-29', DATE '9999-01-01', 74722);
INSERT INTO titles VALUES(10056, 'Engineer', DATE '1990-02-01', DATE '1999-02-01'),
                         (10056, 'Senior Engineer', DATE '1999-02-01', DATE '9999-01-01');
INSERT INTO employees VALUES(10057, 'Ebbe', 'Callaway', 2, DATE '1954-05-30', DATE '1992-01-15');
INSERT INTO dept_emp VALUES(10057, 'd005', DATE '1992-01-15', DATE '9999-01-01');
INSERT INTO salaries VALUES(10057, DATE '1992-01-15', DATE '1993-01-14', 49616),
                           (10057, DATE '1993-01-14', DATE '1994-01-14', 53897),
                           (10057, DATE '1994-01-14', DATE '1995-01-14', 58099),
                           (10057, DATE '1995-01-14', DATE '1996-01-14', 58881),
                           (10057, DATE '1996-01-14', DATE '1997-01-13', 61013),
                           (10057, DATE '1997-01-13', DATE '1998-01-13', 61055),
                           (10057, DATE '1998-01-13', DATE '1999-01-13', 61255);
INSERT INTO salaries VALUES(10057, DATE '1999-01-13', DATE '2000-01-13', 60966),
                           (10057, DATE '2000-01-13', DATE '2001-01-12', 63507),
                           (10057, DATE '2001-01-12', DATE '2002-01-12', 66430),
                           (10057, DATE '2002-01-12', DATE '9999-01-01', 68061);
INSERT INTO titles VALUES(10057, 'Engineer', DATE '1992-01-15', DATE '2000-01-15'),
                         (10057, 'Senior Engineer', DATE '2000-01-15', DATE '9999-01-01');
INSERT INTO employees VALUES(10058, 'Berhard', 'McFarlin', 1, DATE '1954-10-01', DATE '1987-04-13');
INSERT INTO dept_emp VALUES(10058, 'd001', DATE '1988-04-25', DATE '9999-01-01');
INSERT INTO salaries VALUES(10058, DATE '1988-04-25', DATE '1989-04-25', 52787),
                           (10058, DATE '1989-04-25', DATE '1990-04-25', 53377),
                           (10058, DATE '1990-04-25', DATE '1991-04-25', 53869),
                           (10058, DATE '1991-04-25', DATE '1992-04-24', 55134);
INSERT INTO salaries VALUES(10058, DATE '1992-04-24', DATE '1993-04-24', 57882),
                           (10058, DATE '1993-04-24', DATE '1994-04-24', 58807),
                           (10058, DATE '1994-04-24', DATE '1995-04-24', 63284),
                           (10058, DATE '1995-04-24', DATE '1996-04-23', 63666),
                           (10058, DATE '1996-04-23', DATE '1997-04-23', 65706),
                           (10058, DATE '1997-04-23', DATE '1998-04-23', 67913),
                           (10058, DATE '1998-04-23', DATE '1999-04-23', 68623),
                           (10058, DATE '1999-04-23', DATE '2000-04-22', 71438),
                           (10058, DATE '2000-04-22', DATE '2001-04-22', 72151),
                           (10058, DATE '2001-04-22', DATE '2002-04-22', 72363),
                           (10058, DATE '2002-04-22', DATE '9999-01-01', 72542);
INSERT INTO titles VALUES(10058, 'Senior Staff', DATE '1988-04-25', DATE '9999-01-01');
INSERT INTO employees VALUES(10059, 'Alejandro', 'McAlpine', 2, DATE '1953-09-19', DATE '1991-06-26');
INSERT INTO dept_emp VALUES(10059, 'd002', DATE '1991-06-26', DATE '9999-01-01');
INSERT INTO salaries VALUES(10059, DATE '1991-06-26', DATE '1992-06-25', 71218),
                           (10059, DATE '1992-06-25', DATE '1993-06-25', 73299),
                           (10059, DATE '1993-06-25', DATE '1994-06-25', 76448),
                           (10059, DATE '1994-06-25', DATE '1995-06-25', 80739),
                           (10059, DATE '1995-06-25', DATE '1996-06-24', 82318),
                           (10059, DATE '1996-06-24', DATE '1997-06-24', 84522),
                           (10059, DATE '1997-06-24', DATE '1998-06-24', 86290),
                           (10059, DATE '1998-06-24', DATE '1999-06-24', 89824),
                           (10059, DATE '1999-06-24', DATE '2000-06-23', 90380),
                           (10059, DATE '2000-06-23', DATE '2001-06-23', 90689),
                           (10059, DATE '2001-06-23', DATE '2002-06-23', 93280),
                           (10059, DATE '2002-06-23', DATE '9999-01-01', 94161);
INSERT INTO titles VALUES(10059, 'Senior Staff', DATE '1991-06-26', DATE '9999-01-01');
INSERT INTO employees VALUES(10060, 'Breannda', 'Billingsley', 1, DATE '1961-10-15', DATE '1987-11-02');
INSERT INTO dept_emp VALUES(10060, 'd007', DATE '1989-05-28', DATE '1992-11-11'),
                           (10060, 'd009', DATE '1992-11-11', DATE '9999-01-01');
INSERT INTO salaries VALUES(10060, DATE '1989-05-28', DATE '1990-05-28', 74686),
                           (10060, DATE '1990-05-28', DATE '1991-05-28', 75594),
                           (10060, DATE '1991-05-28', DATE '1992-05-27', 77772),
                           (10060, DATE '1992-05-27', DATE '1993-05-27', 78393),
                           (10060, DATE '1993-05-27', DATE '1994-05-27', 77964),
                           (10060, DATE '1994-05-27', DATE '1995-05-27', 78057),
                           (10060, DATE '1995-05-27', DATE '1996-05-26', 78983),
                           (10060, DATE '1996-05-26', DATE '1997-05-26', 79900);
INSERT INTO salaries VALUES(10060, DATE '1997-05-26', DATE '1998-05-26', 79684),
                           (10060, DATE '1998-05-26', DATE '1999-05-26', 84052),
                           (10060, DATE '1999-05-26', DATE '2000-05-25', 85960),
                           (10060, DATE '2000-05-25', DATE '2001-05-25', 87773),
                           (10060, DATE '2001-05-25', DATE '2002-05-25', 89769),
                           (10060, DATE '2002-05-25', DATE '9999-01-01', 93188);
INSERT INTO titles VALUES(10060, 'Senior Staff', DATE '1996-05-28', DATE '9999-01-01'),
                         (10060, 'Staff', DATE '1989-05-28', DATE '1996-05-28');
INSERT INTO employees VALUES(10061, 'Tse', 'Herber', 1, DATE '1962-10-19', DATE '1985-09-17');
INSERT INTO dept_emp VALUES(10061, 'd007', DATE '1989-12-02', DATE '9999-01-01');
INSERT INTO salaries VALUES(10061, DATE '1989-12-02', DATE '1990-12-02', 68577),
                           (10061, DATE '1990-12-02', DATE '1991-12-02', 71135),
                           (10061, DATE '1991-12-02', DATE '1992-12-01', 72464);
INSERT INTO salaries VALUES(10061, DATE '1992-12-01', DATE '1993-12-01', 74796),
                           (10061, DATE '1993-12-01', DATE '1994-12-01', 74944),
                           (10061, DATE '1994-12-01', DATE '1995-12-01', 79041),
                           (10061, DATE '1995-12-01', DATE '1996-11-30', 80248),
                           (10061, DATE '1996-11-30', DATE '1997-11-30', 84445),
                           (10061, DATE '1997-11-30', DATE '1998-11-30', 88012),
                           (10061, DATE '1998-11-30', DATE '1999-11-30', 90972),
                           (10061, DATE '1999-11-30', DATE '2000-11-29', 91371),
                           (10061, DATE '2000-11-29', DATE '2001-11-29', 95866),
                           (10061, DATE '2001-11-29', DATE '9999-01-01', 97338);
INSERT INTO titles VALUES(10061, 'Senior Staff', DATE '1989-12-02', DATE '9999-01-01');
INSERT INTO employees VALUES(10062, 'Anoosh', 'Peyn', 1, DATE '1961-11-02', DATE '1991-08-30');
INSERT INTO dept_emp VALUES(10062, 'd005', DATE '1991-08-30', DATE '9999-01-01');
INSERT INTO salaries VALUES(10062, DATE '1991-08-30', DATE '1992-08-29', 55685),
                           (10062, DATE '1992-08-29', DATE '1993-08-29', 59029),
                           (10062, DATE '1993-08-29', DATE '1994-08-29', 60089),
                           (10062, DATE '1994-08-29', DATE '1995-08-29', 62194),
                           (10062, DATE '1995-08-29', DATE '1996-08-28', 61761),
                           (10062, DATE '1996-08-28', DATE '1997-08-28', 65275),
                           (10062, DATE '1997-08-28', DATE '1998-08-28', 65544),
                           (10062, DATE '1998-08-28', DATE '1999-08-28', 66167),
                           (10062, DATE '1999-08-28', DATE '2000-08-27', 66447),
                           (10062, DATE '2000-08-27', DATE '2001-08-27', 68784),
                           (10062, DATE '2001-08-27', DATE '9999-01-01', 68559);
INSERT INTO titles VALUES(10062, 'Engineer', DATE '1991-08-30', DATE '1999-08-30'),
                         (10062, 'Senior Engineer', DATE '1999-08-30', DATE '9999-01-01');
INSERT INTO employees VALUES(10063, 'Gino', 'Leonhardt', 2, DATE '1952-08-06', DATE '1989-04-08');
INSERT INTO dept_emp VALUES(10063, 'd004', DATE '1989-04-08', DATE '9999-01-01');
INSERT INTO salaries VALUES(10063, DATE '1989-04-08', DATE '1990-04-08', 40000),
                           (10063, DATE '1990-04-08', DATE '1991-04-08', 41990),
                           (10063, DATE '1991-04-08', DATE '1992-04-07', 44342),
                           (10063, DATE '1992-04-07', DATE '1993-04-07', 48429),
                           (10063, DATE '1993-04-07', DATE '1994-04-07', 52466),
                           (10063, DATE '1994-04-07', DATE '1995-04-07', 54823),
                           (10063, DATE '1995-04-07', DATE '1996-04-05', 56442),
                           (10063, DATE '1996-04-05', DATE '1997-04-05', 60165),
                           (10063, DATE '1997-04-05', DATE '1998-04-06', 63852),
                           (10063, DATE '1998-04-06', DATE '1999-04-06', 65262),
                           (10063, DATE '1999-04-06', DATE '2000-04-05', 69354);
INSERT INTO salaries VALUES(10063, DATE '2000-04-05', DATE '2001-04-05', 71028),
                           (10063, DATE '2001-04-05', DATE '2002-04-04', 73393),
                           (10063, DATE '2002-04-04', DATE '9999-01-01', 74841);
INSERT INTO titles VALUES(10063, 'Senior Engineer', DATE '1989-04-08', DATE '9999-01-01');
INSERT INTO employees VALUES(10064, 'Udi', 'Jansch', 1, DATE '1959-04-07', DATE '1985-11-20');
INSERT INTO dept_emp VALUES(10064, 'd008', DATE '1985-11-20', DATE '1992-03-02');
INSERT INTO salaries VALUES(10064, DATE '1985-11-20', DATE '1986-11-20', 40000),
                           (10064, DATE '1986-11-20', DATE '1987-11-20', 39551),
                           (10064, DATE '1987-11-20', DATE '1988-11-19', 41264),
                           (10064, DATE '1988-11-19', DATE '1989-11-19', 40795),
                           (10064, DATE '1989-11-19', DATE '1990-11-19', 43466),
                           (10064, DATE '1990-11-19', DATE '1991-11-19', 45895),
                           (10064, DATE '1991-11-19', DATE '1992-03-02', 48454);
INSERT INTO titles VALUES(10064, 'Staff', DATE '1985-11-20', DATE '1992-03-02');
INSERT INTO employees VALUES(10065, 'Satosi', 'Awdeh', 1, DATE '1963-04-14', DATE '1988-05-18');
INSERT INTO dept_emp VALUES(10065, 'd005', DATE '1998-05-24', DATE '9999-01-01');
INSERT INTO salaries VALUES(10065, DATE '1998-05-24', DATE '1999-05-24', 40000),
                           (10065, DATE '1999-05-24', DATE '2000-05-23', 40503),
                           (10065, DATE '2000-05-23', DATE '2001-05-23', 42031),
                           (10065, DATE '2001-05-23', DATE '2002-05-23', 43655),
                           (10065, DATE '2002-05-23', DATE '9999-01-01', 47437);
INSERT INTO titles VALUES(10065, 'Engineer', DATE '1998-05-24', DATE '9999-01-01');
INSERT INTO employees VALUES(10066, 'Kwee', 'Schusler', 1, DATE '1952-11-13', DATE '1986-02-26');
INSERT INTO dept_emp VALUES(10066, 'd005', DATE '1986-02-26', DATE '9999-01-01');
INSERT INTO salaries VALUES(10066, DATE '1986-02-26', DATE '1987-02-26', 69736);
INSERT INTO salaries VALUES(10066, DATE '1987-02-26', DATE '1988-02-26', 72147),
                           (10066, DATE '1988-02-26', DATE '1989-02-25', 76616),
                           (10066, DATE '1989-02-25', DATE '1990-02-25', 78885),
                           (10066, DATE '1990-02-25', DATE '1991-02-25', 82819),
                           (10066, DATE '1991-02-25', DATE '1992-02-25', 84064),
                           (10066, DATE '1992-02-25', DATE '1993-02-24', 84161),
                           (10066, DATE '1993-02-24', DATE '1994-02-24', 84368),
                           (10066, DATE '1994-02-24', DATE '1995-02-24', 88392),
                           (10066, DATE '1995-02-24', DATE '1996-02-24', 88808),
                           (10066, DATE '1996-02-24', DATE '1997-02-23', 92405),
                           (10066, DATE '1997-02-23', DATE '1998-02-23', 96451),
                           (10066, DATE '1998-02-23', DATE '1999-02-23', 98656),
                           (10066, DATE '1999-02-23', DATE '2000-02-23', 99199);
INSERT INTO salaries VALUES(10066, DATE '2000-02-23', DATE '2001-02-22', 102425),
                           (10066, DATE '2001-02-22', DATE '2002-02-22', 102674),
                           (10066, DATE '2002-02-22', DATE '9999-01-01', 103672);
INSERT INTO titles VALUES(10066, 'Assistant Engineer', DATE '1986-02-26', DATE '1992-02-26'),
                         (10066, 'Engineer', DATE '1992-02-26', DATE '1998-02-25'),
                         (10066, 'Senior Engineer', DATE '1998-02-25', DATE '9999-01-01');
INSERT INTO employees VALUES(10067, 'Claudi', 'Stavenow', 1, DATE '1953-01-07', DATE '1987-03-04');
INSERT INTO dept_emp VALUES(10067, 'd006', DATE '1987-03-04', DATE '9999-01-01');
INSERT INTO salaries VALUES(10067, DATE '1987-03-04', DATE '1988-03-03', 44642),
                           (10067, DATE '1988-03-03', DATE '1989-03-03', 47879),
                           (10067, DATE '1989-03-03', DATE '1990-03-03', 47733),
                           (10067, DATE '1990-03-03', DATE '1991-03-03', 51396);
INSERT INTO salaries VALUES(10067, DATE '1991-03-03', DATE '1992-03-02', 52808),
                           (10067, DATE '1992-03-02', DATE '1993-03-02', 56581),
                           (10067, DATE '1993-03-02', DATE '1994-03-02', 58363),
                           (10067, DATE '1994-03-02', DATE '1995-03-02', 62607),
                           (10067, DATE '1995-03-02', DATE '1996-03-01', 66769),
                           (10067, DATE '1996-03-01', DATE '1997-03-01', 70158),
                           (10067, DATE '1997-03-01', DATE '1998-03-01', 73730),
                           (10067, DATE '1998-03-01', DATE '1999-03-01', 74242),
                           (10067, DATE '1999-03-01', DATE '2000-02-29', 75732),
                           (10067, DATE '2000-02-29', DATE '2001-02-28', 77620),
                           (10067, DATE '2001-02-28', DATE '2002-02-28', 81784),
                           (10067, DATE '2002-02-28', DATE '9999-01-01', 83254);
INSERT INTO titles VALUES(10067, 'Engineer', DATE '1987-03-04', DATE '1996-03-03');
INSERT INTO titles VALUES(10067, 'Senior Engineer', DATE '1996-03-03', DATE '9999-01-01');
INSERT INTO employees VALUES(10068, 'Charlene', 'Brattka', 1, DATE '1962-11-26', DATE '1987-08-07');
INSERT INTO dept_emp VALUES(10068, 'd007', DATE '1987-08-07', DATE '9999-01-01');
INSERT INTO salaries VALUES(10068, DATE '1987-08-07', DATE '1988-08-06', 87964),
                           (10068, DATE '1988-08-06', DATE '1989-08-06', 92176),
                           (10068, DATE '1989-08-06', DATE '1990-08-06', 92089),
                           (10068, DATE '1990-08-06', DATE '1991-08-06', 93474),
                           (10068, DATE '1991-08-06', DATE '1992-08-05', 94724),
                           (10068, DATE '1992-08-05', DATE '1993-08-05', 97058),
                           (10068, DATE '1993-08-05', DATE '1994-08-05', 100005),
                           (10068, DATE '1994-08-05', DATE '1995-08-05', 101829),
                           (10068, DATE '1995-08-05', DATE '1996-08-04', 101630);
INSERT INTO salaries VALUES(10068, DATE '1996-08-04', DATE '1997-08-04', 105533),
                           (10068, DATE '1997-08-04', DATE '1998-08-04', 106204),
                           (10068, DATE '1998-08-04', DATE '1999-08-04', 108345),
                           (10068, DATE '1999-08-04', DATE '2000-08-03', 111623),
                           (10068, DATE '2000-08-03', DATE '2001-08-03', 112470),
                           (10068, DATE '2001-08-03', DATE '9999-01-01', 113229);
INSERT INTO titles VALUES(10068, 'Senior Staff', DATE '1996-08-06', DATE '9999-01-01'),
                         (10068, 'Staff', DATE '1987-08-07', DATE '1996-08-06');
INSERT INTO employees VALUES(10069, 'Margareta', 'Bierman', 2, DATE '1960-09-06', DATE '1989-11-05');
INSERT INTO dept_emp VALUES(10069, 'd004', DATE '1992-06-14', DATE '9999-01-01');
INSERT INTO salaries VALUES(10069, DATE '1992-06-14', DATE '1993-06-14', 67932),
                           (10069, DATE '1993-06-14', DATE '1994-06-14', 68046);
INSERT INTO salaries VALUES(10069, DATE '1994-06-14', DATE '1995-06-14', 67675),
                           (10069, DATE '1995-06-14', DATE '1996-06-13', 69876),
                           (10069, DATE '1996-06-13', DATE '1997-06-13', 70464),
                           (10069, DATE '1997-06-13', DATE '1998-06-13', 71574),
                           (10069, DATE '1998-06-13', DATE '1999-06-13', 74638),
                           (10069, DATE '1999-06-13', DATE '2000-06-12', 79102),
                           (10069, DATE '2000-06-12', DATE '2001-06-12', 82731),
                           (10069, DATE '2001-06-12', DATE '2002-06-12', 85931),
                           (10069, DATE '2002-06-12', DATE '9999-01-01', 86641);
INSERT INTO titles VALUES(10069, 'Technique Leader', DATE '1992-06-14', DATE '9999-01-01');
INSERT INTO employees VALUES(10070, 'Reuven', 'Garigliano', 1, DATE '1955-08-20', DATE '1985-10-14');
INSERT INTO dept_emp VALUES(10070, 'd005', DATE '1985-10-14', DATE '1995-10-18');
INSERT INTO dept_emp VALUES(10070, 'd008', DATE '1995-10-18', DATE '9999-01-01');
INSERT INTO salaries VALUES(10070, DATE '1985-10-14', DATE '1986-10-14', 55999),
                           (10070, DATE '1986-10-14', DATE '1987-10-14', 56848),
                           (10070, DATE '1987-10-14', DATE '1988-10-13', 61306),
                           (10070, DATE '1988-10-13', DATE '1989-10-13', 63174),
                           (10070, DATE '1989-10-13', DATE '1990-10-13', 63950),
                           (10070, DATE '1990-10-13', DATE '1991-10-13', 64776),
                           (10070, DATE '1991-10-13', DATE '1992-10-12', 67223),
                           (10070, DATE '1992-10-12', DATE '1993-10-12', 70301),
                           (10070, DATE '1993-10-12', DATE '1994-10-12', 74286),
                           (10070, DATE '1994-10-12', DATE '1995-10-12', 77938),
                           (10070, DATE '1995-10-12', DATE '1996-10-11', 82124),
                           (10070, DATE '1996-10-11', DATE '1997-10-11', 83639);
INSERT INTO salaries VALUES(10070, DATE '1997-10-11', DATE '1998-10-11', 87499),
                           (10070, DATE '1998-10-11', DATE '1999-10-11', 87086),
                           (10070, DATE '1999-10-11', DATE '2000-10-10', 90690),
                           (10070, DATE '2000-10-10', DATE '2001-10-10', 94654),
                           (10070, DATE '2001-10-10', DATE '9999-01-01', 96322);
INSERT INTO titles VALUES(10070, 'Technique Leader', DATE '1985-10-14', DATE '9999-01-01');
INSERT INTO employees VALUES(10071, 'Hisao', 'Lipner', 1, DATE '1958-01-21', DATE '1987-10-01');
INSERT INTO dept_emp VALUES(10071, 'd003', DATE '1995-08-05', DATE '9999-01-01');
INSERT INTO salaries VALUES(10071, DATE '1995-08-05', DATE '1996-08-04', 40000),
                           (10071, DATE '1996-08-04', DATE '1997-08-04', 40087),
                           (10071, DATE '1997-08-04', DATE '1998-08-04', 41656),
                           (10071, DATE '1998-08-04', DATE '1999-08-04', 42768),
                           (10071, DATE '1999-08-04', DATE '2000-08-03', 46295);
INSERT INTO salaries VALUES(10071, DATE '2000-08-03', DATE '2001-08-03', 49837),
                           (10071, DATE '2001-08-03', DATE '9999-01-01', 53315);
INSERT INTO titles VALUES(10071, 'Staff', DATE '1995-08-05', DATE '9999-01-01');
INSERT INTO employees VALUES(10072, 'Hironoby', 'Sidou', 2, DATE '1952-05-15', DATE '1988-07-21');
INSERT INTO dept_emp VALUES(10072, 'd005', DATE '1989-05-21', DATE '9999-01-01');
INSERT INTO salaries VALUES(10072, DATE '1989-05-21', DATE '1990-05-21', 40000),
                           (10072, DATE '1990-05-21', DATE '1991-05-21', 39567),
                           (10072, DATE '1991-05-21', DATE '1992-05-20', 39724),
                           (10072, DATE '1992-05-20', DATE '1993-05-20', 40803),
                           (10072, DATE '1993-05-20', DATE '1994-05-20', 44781),
                           (10072, DATE '1994-05-20', DATE '1995-05-20', 49265),
                           (10072, DATE '1995-05-20', DATE '1996-05-19', 53559),
                           (10072, DATE '1996-05-19', DATE '1997-05-19', 56103);
INSERT INTO salaries VALUES(10072, DATE '1997-05-19', DATE '1998-05-19', 58578),
                           (10072, DATE '1998-05-19', DATE '1999-05-19', 60600),
                           (10072, DATE '1999-05-19', DATE '2000-05-18', 62174),
                           (10072, DATE '2000-05-18', DATE '2001-05-18', 63157),
                           (10072, DATE '2001-05-18', DATE '2002-05-18', 64726),
                           (10072, DATE '2002-05-18', DATE '9999-01-01', 64512);
INSERT INTO titles VALUES(10072, 'Engineer', DATE '1989-05-21', DATE '1995-05-21'),
                         (10072, 'Senior Engineer', DATE '1995-05-21', DATE '9999-01-01');
INSERT INTO employees VALUES(10073, 'Shir', 'McClurg', 1, DATE '1954-02-23', DATE '1991-12-01');
INSERT INTO dept_emp VALUES(10073, 'd006', DATE '1998-02-02', DATE '1998-02-22');
INSERT INTO salaries VALUES(10073, DATE '1998-02-02', DATE '1998-02-22', 56473);
INSERT INTO titles VALUES(10073, 'Engineer', DATE '1998-02-02', DATE '1998-02-22');
INSERT INTO employees VALUES(10074, 'Mokhtar', 'Bernatsky', 2, DATE '1955-08-28', DATE '1990-08-13');
INSERT INTO dept_emp VALUES(10074, 'd005', DATE '1990-08-13', DATE '9999-01-01');
INSERT INTO salaries VALUES(10074, DATE '1990-08-13', DATE '1991-08-13', 61714),
                           (10074, DATE '1991-08-13', DATE '1992-08-12', 64739),
                           (10074, DATE '1992-08-12', DATE '1993-08-12', 64655),
                           (10074, DATE '1993-08-12', DATE '1994-08-12', 67516),
                           (10074, DATE '1994-08-12', DATE '1995-08-12', 70019),
                           (10074, DATE '1995-08-12', DATE '1996-08-11', 70984),
                           (10074, DATE '1996-08-11', DATE '1997-08-11', 72145),
                           (10074, DATE '1997-08-11', DATE '1998-08-11', 73009),
                           (10074, DATE '1998-08-11', DATE '1999-08-11', 77489),
                           (10074, DATE '1999-08-11', DATE '2000-08-10', 77625),
                           (10074, DATE '2000-08-10', DATE '2001-08-10', 79934);
INSERT INTO salaries VALUES(10074, DATE '2001-08-10', DATE '9999-01-01', 80820);
INSERT INTO titles VALUES(10074, 'Technique Leader', DATE '1990-08-13', DATE '9999-01-01');
INSERT INTO employees VALUES(10075, 'Gao', 'Dolinsky', 2, DATE '1960-03-09', DATE '1987-03-19');
INSERT INTO dept_emp VALUES(10075, 'd005', DATE '1988-05-17', DATE '2001-01-15');
INSERT INTO salaries VALUES(10075, DATE '1988-05-17', DATE '1989-05-17', 43815),
                           (10075, DATE '1989-05-17', DATE '1990-05-17', 43590),
                           (10075, DATE '1990-05-17', DATE '1991-05-17', 46087),
                           (10075, DATE '1991-05-17', DATE '1992-05-16', 47765),
                           (10075, DATE '1992-05-16', DATE '1993-05-16', 48606),
                           (10075, DATE '1993-05-16', DATE '1994-05-16', 49208),
                           (10075, DATE '1994-05-16', DATE '1995-05-16', 51099),
                           (10075, DATE '1995-05-16', DATE '1996-05-15', 51323),
                           (10075, DATE '1996-05-15', DATE '1997-05-15', 51238);
INSERT INTO salaries VALUES(10075, DATE '1997-05-15', DATE '1998-05-15', 55463),
                           (10075, DATE '1998-05-15', DATE '1999-05-15', 59623),
                           (10075, DATE '1999-05-15', DATE '2000-05-14', 63624),
                           (10075, DATE '2000-05-14', DATE '2001-01-15', 67492);
INSERT INTO titles VALUES(10075, 'Senior Engineer', DATE '1988-05-17', DATE '2001-01-15');
INSERT INTO employees VALUES(10076, 'Erez', 'Ritzmann', 2, DATE '1952-06-13', DATE '1985-07-09');
INSERT INTO dept_emp VALUES(10076, 'd005', DATE '1996-07-15', DATE '9999-01-01');
INSERT INTO salaries VALUES(10076, DATE '1996-07-15', DATE '1997-07-15', 47319),
                           (10076, DATE '1997-07-15', DATE '1998-07-15', 50802),
                           (10076, DATE '1998-07-15', DATE '1999-07-15', 54783),
                           (10076, DATE '1999-07-15', DATE '2000-07-14', 57418),
                           (10076, DATE '2000-07-14', DATE '2001-07-14', 59999),
                           (10076, DATE '2001-07-14', DATE '2002-07-14', 61118);
INSERT INTO salaries VALUES(10076, DATE '2002-07-14', DATE '9999-01-01', 62921);
INSERT INTO titles VALUES(10076, 'Senior Engineer', DATE '1996-07-15', DATE '9999-01-01');
INSERT INTO employees VALUES(10077, 'Mona', 'Azuma', 1, DATE '1964-04-18', DATE '1990-03-02');
INSERT INTO dept_emp VALUES(10077, 'd003', DATE '1994-12-23', DATE '9999-01-01');
INSERT INTO salaries VALUES(10077, DATE '1994-12-23', DATE '1995-12-23', 40000),
                           (10077, DATE '1995-12-23', DATE '1996-12-22', 43745),
                           (10077, DATE '1996-12-22', DATE '1997-12-22', 43864),
                           (10077, DATE '1997-12-22', DATE '1998-12-22', 47173),
                           (10077, DATE '1998-12-22', DATE '1999-12-22', 49955),
                           (10077, DATE '1999-12-22', DATE '2000-12-21', 50403),
                           (10077, DATE '2000-12-21', DATE '2001-12-21', 51581),
                           (10077, DATE '2001-12-21', DATE '9999-01-01', 54699);
INSERT INTO titles VALUES(10077, 'Staff', DATE '1994-12-23', DATE '9999-01-01');
INSERT INTO employees VALUES(10078, 'Danel', 'Mondadori', 2, DATE '1959-12-25', DATE '1987-05-26');
INSERT INTO dept_emp VALUES(10078, 'd005', DATE '1994-09-29', DATE '9999-01-01');
INSERT INTO salaries VALUES(10078, DATE '1994-09-29', DATE '1995-09-29', 47280),
                           (10078, DATE '1995-09-29', DATE '1996-09-28', 46833),
                           (10078, DATE '1996-09-28', DATE '1997-09-28', 50652),
                           (10078, DATE '1997-09-28', DATE '1998-09-28', 50977),
                           (10078, DATE '1998-09-28', DATE '1999-09-28', 51132),
                           (10078, DATE '1999-09-28', DATE '2000-09-27', 53130),
                           (10078, DATE '2000-09-27', DATE '2001-09-27', 52860),
                           (10078, DATE '2001-09-27', DATE '9999-01-01', 54652);
INSERT INTO titles VALUES(10078, 'Engineer', DATE '1994-09-29', DATE '9999-01-01');
INSERT INTO employees VALUES(10079, 'Kshitij', 'Gils', 2, DATE '1961-10-05', DATE '1986-03-27');
INSERT INTO dept_emp VALUES(10079, 'd005', DATE '1995-12-13', DATE '9999-01-01');
INSERT INTO salaries VALUES(10079, DATE '1995-12-13', DATE '1996-12-12', 53492),
                           (10079, DATE '1996-12-12', DATE '1997-12-12', 56811),
                           (10079, DATE '1997-12-12', DATE '1998-12-12', 56717),
                           (10079, DATE '1998-12-12', DATE '1999-12-12', 56256),
                           (10079, DATE '1999-12-12', DATE '2000-12-11', 59225),
                           (10079, DATE '2000-12-11', DATE '2001-12-11', 63641),
                           (10079, DATE '2001-12-11', DATE '9999-01-01', 67231);
INSERT INTO titles VALUES(10079, 'Technique Leader', DATE '1995-12-13', DATE '9999-01-01');
INSERT INTO employees VALUES(10080, 'Premal', 'Baek', 1, DATE '1957-12-03', DATE '1985-11-19');
INSERT INTO dept_emp VALUES(10080, 'd002', DATE '1994-09-28', DATE '1997-07-09'),
                           (10080, 'd003', DATE '1997-07-09', DATE '9999-01-01');
INSERT INTO salaries VALUES(10080, DATE '1994-09-28', DATE '1995-09-28', 54916);
INSERT INTO salaries VALUES(10080, DATE '1995-09-28', DATE '1996-09-27', 56838),
                           (10080, DATE '1996-09-27', DATE '1997-09-27', 60742),
                           (10080, DATE '1997-09-27', DATE '1998-09-27', 62087),
                           (10080, DATE '1998-09-27', DATE '1999-09-27', 65129),
                           (10080, DATE '1999-09-27', DATE '2000-09-26', 68691),
                           (10080, DATE '2000-09-26', DATE '2001-09-26', 71986),
                           (10080, DATE '2001-09-26', DATE '9999-01-01', 72729);
INSERT INTO titles VALUES(10080, 'Senior Staff', DATE '2001-09-28', DATE '9999-01-01'),
                         (10080, 'Staff', DATE '1994-09-28', DATE '2001-09-28');
INSERT INTO employees VALUES(10081, 'Zhongwei', 'Rosen', 1, DATE '1960-12-17', DATE '1986-10-30');
INSERT INTO dept_emp VALUES(10081, 'd004', DATE '1986-10-30', DATE '9999-01-01');
INSERT INTO salaries VALUES(10081, DATE '1986-10-30', DATE '1987-10-30', 55786),
                           (10081, DATE '1987-10-30', DATE '1988-10-29', 58975);
INSERT INTO salaries VALUES(10081, DATE '1988-10-29', DATE '1989-10-29', 58475),
                           (10081, DATE '1989-10-29', DATE '1990-10-29', 61935),
                           (10081, DATE '1990-10-29', DATE '1991-10-29', 63172),
                           (10081, DATE '1991-10-29', DATE '1992-10-28', 64355),
                           (10081, DATE '1992-10-28', DATE '1993-10-28', 64054),
                           (10081, DATE '1993-10-28', DATE '1994-10-28', 66796),
                           (10081, DATE '1994-10-28', DATE '1995-10-28', 66704),
                           (10081, DATE '1995-10-28', DATE '1996-10-27', 68102),
                           (10081, DATE '1996-10-27', DATE '1997-10-27', 69882),
                           (10081, DATE '1997-10-27', DATE '1998-10-27', 73516),
                           (10081, DATE '1998-10-27', DATE '1999-10-27', 74714),
                           (10081, DATE '1999-10-27', DATE '2000-10-26', 74734),
                           (10081, DATE '2000-10-26', DATE '2001-10-26', 75683);
INSERT INTO salaries VALUES(10081, DATE '2001-10-26', DATE '9999-01-01', 79351);
INSERT INTO titles VALUES(10081, 'Engineer', DATE '1986-10-30', DATE '1991-10-30'),
                         (10081, 'Senior Engineer', DATE '1991-10-30', DATE '9999-01-01');
INSERT INTO employees VALUES(10082, 'Parviz', 'Lortz', 1, DATE '1963-09-09', DATE '1990-01-03');
INSERT INTO dept_emp VALUES(10082, 'd008', DATE '1990-01-03', DATE '1990-01-15');
INSERT INTO salaries VALUES(10082, DATE '1990-01-03', DATE '1990-01-15', 48935);
INSERT INTO titles VALUES(10082, 'Staff', DATE '1990-01-03', DATE '1990-01-15');
INSERT INTO employees VALUES(10083, 'Vishv', 'Zockler', 1, DATE '1959-07-23', DATE '1987-03-31');
INSERT INTO dept_emp VALUES(10083, 'd004', DATE '1987-03-31', DATE '9999-01-01');
INSERT INTO salaries VALUES(10083, DATE '1987-03-31', DATE '1988-03-30', 40000),
                           (10083, DATE '1988-03-30', DATE '1989-03-30', 44226),
                           (10083, DATE '1989-03-30', DATE '1990-03-30', 47900);
INSERT INTO salaries VALUES(10083, DATE '1990-03-30', DATE '1991-03-30', 49732),
                           (10083, DATE '1991-03-30', DATE '1992-03-29', 53520),
                           (10083, DATE '1992-03-29', DATE '1993-03-29', 54944),
                           (10083, DATE '1993-03-29', DATE '1994-03-29', 55469),
                           (10083, DATE '1994-03-29', DATE '1995-03-29', 58814),
                           (10083, DATE '1995-03-29', DATE '1996-03-28', 59286),
                           (10083, DATE '1996-03-28', DATE '1997-03-28', 62727),
                           (10083, DATE '1997-03-28', DATE '1998-03-28', 65435),
                           (10083, DATE '1998-03-28', DATE '1999-03-28', 67142),
                           (10083, DATE '1999-03-28', DATE '2000-03-27', 70495),
                           (10083, DATE '2000-03-27', DATE '2001-03-27', 73060),
                           (10083, DATE '2001-03-27', DATE '2002-03-27', 73756),
                           (10083, DATE '2002-03-27', DATE '9999-01-01', 77186);
INSERT INTO titles VALUES(10083, 'Engineer', DATE '1987-03-31', DATE '1994-03-31'),
                         (10083, 'Senior Engineer', DATE '1994-03-31', DATE '9999-01-01');
INSERT INTO employees VALUES(10084, 'Tuval', 'Kalloufi', 1, DATE '1960-05-25', DATE '1995-12-15');
INSERT INTO dept_emp VALUES(10084, 'd004', DATE '1995-12-15', DATE '9999-01-01');
INSERT INTO salaries VALUES(10084, DATE '1995-12-15', DATE '1996-12-14', 69811),
                           (10084, DATE '1996-12-14', DATE '1997-12-14', 74293),
                           (10084, DATE '1997-12-14', DATE '1998-12-14', 78493),
                           (10084, DATE '1998-12-14', DATE '1999-12-14', 81977),
                           (10084, DATE '1999-12-14', DATE '2000-12-13', 86412),
                           (10084, DATE '2000-12-13', DATE '2001-12-13', 90039),
                           (10084, DATE '2001-12-13', DATE '9999-01-01', 93621);
INSERT INTO titles VALUES(10084, 'Engineer', DATE '1995-12-15', DATE '2001-12-14');
INSERT INTO titles VALUES(10084, 'Senior Engineer', DATE '2001-12-14', DATE '9999-01-01');
INSERT INTO employees VALUES(10085, 'Kenroku', 'Malabarba', 1, DATE '1962-11-07', DATE '1994-04-09');
INSERT INTO dept_emp VALUES(10085, 'd004', DATE '1994-04-09', DATE '9999-01-01');
INSERT INTO salaries VALUES(10085, DATE '1994-04-09', DATE '1995-04-09', 40000),
                           (10085, DATE '1995-04-09', DATE '1996-04-08', 43030),
                           (10085, DATE '1996-04-08', DATE '1997-04-08', 46477),
                           (10085, DATE '1997-04-08', DATE '1998-04-08', 47707),
                           (10085, DATE '1998-04-08', DATE '1999-04-08', 50245),
                           (10085, DATE '1999-04-08', DATE '2000-04-07', 52683),
                           (10085, DATE '2000-04-07', DATE '2001-04-07', 55176),
                           (10085, DATE '2001-04-07', DATE '2002-04-06', 56905),
                           (10085, DATE '2002-04-06', DATE '9999-01-01', 60910);
INSERT INTO titles VALUES(10085, 'Senior Engineer', DATE '1994-04-09', DATE '9999-01-01');
INSERT INTO employees VALUES(10086, 'Somnath', 'Foote', 1, DATE '1962-11-19', DATE '1990-02-16');
INSERT INTO dept_emp VALUES(10086, 'd003', DATE '1992-02-19', DATE '9999-01-01');
INSERT INTO salaries VALUES(10086, DATE '1992-02-19', DATE '1993-02-18', 81613),
                           (10086, DATE '1993-02-18', DATE '1994-02-18', 81404),
                           (10086, DATE '1994-02-18', DATE '1995-02-18', 80991),
                           (10086, DATE '1995-02-18', DATE '1996-02-18', 80941),
                           (10086, DATE '1996-02-18', DATE '1997-02-17', 80934),
                           (10086, DATE '1997-02-17', DATE '1998-02-17', 84324),
                           (10086, DATE '1998-02-17', DATE '1999-02-17', 88049),
                           (10086, DATE '1999-02-17', DATE '2000-02-17', 90241),
                           (10086, DATE '2000-02-17', DATE '2001-02-16', 92125),
                           (10086, DATE '2001-02-16', DATE '2002-02-16', 96471);
INSERT INTO salaries VALUES(10086, DATE '2002-02-16', DATE '9999-01-01', 96333);
INSERT INTO titles VALUES(10086, 'Senior Staff', DATE '1999-02-19', DATE '9999-01-01'),
                         (10086, 'Staff', DATE '1992-02-19', DATE '1999-02-19');
INSERT INTO employees VALUES(10087, 'Xinglin', 'Eugenio', 2, DATE '1959-07-23', DATE '1986-09-08');
INSERT INTO dept_emp VALUES(10087, 'd007', DATE '1997-05-08', DATE '2001-01-09');
INSERT INTO salaries VALUES(10087, DATE '1997-05-08', DATE '1998-05-08', 96750),
                           (10087, DATE '1998-05-08', DATE '1999-05-08', 98200),
                           (10087, DATE '1999-05-08', DATE '2000-05-07', 98460),
                           (10087, DATE '2000-05-07', DATE '2001-01-09', 102651);
INSERT INTO titles VALUES(10087, 'Staff', DATE '1997-05-08', DATE '2001-01-09');
INSERT INTO employees VALUES(10088, 'Jungsoon', 'Syrzycki', 2, DATE '1954-02-25', DATE '1988-09-02');
INSERT INTO dept_emp VALUES(10088, 'd007', DATE '1988-09-02', DATE '1992-03-21');
INSERT INTO dept_emp VALUES(10088, 'd009', DATE '1992-03-21', DATE '9999-01-01');
INSERT INTO salaries VALUES(10088, DATE '1988-09-02', DATE '1989-09-02', 65957),
                           (10088, DATE '1989-09-02', DATE '1990-09-02', 67837),
                           (10088, DATE '1990-09-02', DATE '1991-09-02', 70774),
                           (10088, DATE '1991-09-02', DATE '1992-09-01', 70709),
                           (10088, DATE '1992-09-01', DATE '1993-09-01', 73858),
                           (10088, DATE '1993-09-01', DATE '1994-09-01', 78302),
                           (10088, DATE '1994-09-01', DATE '1995-09-01', 79993),
                           (10088, DATE '1995-09-01', DATE '1996-08-31', 79519),
                           (10088, DATE '1996-08-31', DATE '1997-08-31', 83755),
                           (10088, DATE '1997-08-31', DATE '1998-08-31', 84024),
                           (10088, DATE '1998-08-31', DATE '1999-08-31', 87639),
                           (10088, DATE '1999-08-31', DATE '2000-08-30', 91296);
INSERT INTO salaries VALUES(10088, DATE '2000-08-30', DATE '2001-08-30', 95451),
                           (10088, DATE '2001-08-30', DATE '9999-01-01', 98003);
INSERT INTO titles VALUES(10088, 'Senior Staff', DATE '1993-09-02', DATE '9999-01-01'),
                         (10088, 'Staff', DATE '1988-09-02', DATE '1993-09-02');
INSERT INTO employees VALUES(10089, 'Sudharsan', 'Flasterstein', 2, DATE '1963-03-21', DATE '1986-08-12');
INSERT INTO dept_emp VALUES(10089, 'd007', DATE '1989-01-10', DATE '9999-01-01');
INSERT INTO salaries VALUES(10089, DATE '1989-01-10', DATE '1990-01-10', 56469),
                           (10089, DATE '1990-01-10', DATE '1991-01-10', 56165),
                           (10089, DATE '1991-01-10', DATE '1992-01-10', 56040),
                           (10089, DATE '1992-01-10', DATE '1993-01-09', 60332),
                           (10089, DATE '1993-01-09', DATE '1994-01-09', 63549),
                           (10089, DATE '1994-01-09', DATE '1995-01-09', 64105);
INSERT INTO salaries VALUES(10089, DATE '1995-01-09', DATE '1996-01-09', 65543),
                           (10089, DATE '1996-01-09', DATE '1997-01-08', 69267),
                           (10089, DATE '1997-01-08', DATE '1998-01-08', 70480),
                           (10089, DATE '1998-01-08', DATE '1999-01-08', 70147),
                           (10089, DATE '1999-01-08', DATE '2000-01-08', 71560),
                           (10089, DATE '2000-01-08', DATE '2001-01-07', 72862),
                           (10089, DATE '2001-01-07', DATE '2002-01-07', 74138),
                           (10089, DATE '2002-01-07', DATE '9999-01-01', 77955);
INSERT INTO titles VALUES(10089, 'Senior Staff', DATE '1996-01-11', DATE '9999-01-01'),
                         (10089, 'Staff', DATE '1989-01-10', DATE '1996-01-11');
INSERT INTO employees VALUES(10090, 'Kendra', 'Hofting', 1, DATE '1961-05-30', DATE '1986-03-14');
INSERT INTO dept_emp VALUES(10090, 'd005', DATE '1986-03-14', DATE '1999-05-07');
INSERT INTO salaries VALUES(10090, DATE '1986-03-14', DATE '1987-03-14', 44978);
INSERT INTO salaries VALUES(10090, DATE '1987-03-14', DATE '1988-03-13', 47905),
                           (10090, DATE '1988-03-13', DATE '1989-03-13', 48211),
                           (10090, DATE '1989-03-13', DATE '1990-03-13', 50694),
                           (10090, DATE '1990-03-13', DATE '1991-03-13', 54084),
                           (10090, DATE '1991-03-13', DATE '1992-03-12', 54095),
                           (10090, DATE '1992-03-12', DATE '1993-03-12', 56190),
                           (10090, DATE '1993-03-12', DATE '1994-03-12', 58604),
                           (10090, DATE '1994-03-12', DATE '1995-03-12', 61661),
                           (10090, DATE '1995-03-12', DATE '1996-03-11', 64839),
                           (10090, DATE '1996-03-11', DATE '1997-03-11', 69311),
                           (10090, DATE '1997-03-11', DATE '1998-03-11', 71274),
                           (10090, DATE '1998-03-11', DATE '1999-03-11', 71605),
                           (10090, DATE '1999-03-11', DATE '1999-05-07', 75401);
INSERT INTO titles VALUES(10090, 'Senior Engineer', DATE '1986-03-14', DATE '1999-05-07');
INSERT INTO employees VALUES(10091, 'Amabile', 'Gomatam', 1, DATE '1955-10-04', DATE '1992-11-18');
INSERT INTO dept_emp VALUES(10091, 'd005', DATE '1992-11-18', DATE '9999-01-01');
INSERT INTO salaries VALUES(10091, DATE '1992-11-18', DATE '1993-11-18', 40000),
                           (10091, DATE '1993-11-18', DATE '1994-11-18', 41181),
                           (10091, DATE '1994-11-18', DATE '1995-11-18', 43812),
                           (10091, DATE '1995-11-18', DATE '1996-11-17', 44046),
                           (10091, DATE '1996-11-17', DATE '1997-11-17', 45385),
                           (10091, DATE '1997-11-17', DATE '1998-11-17', 46467),
                           (10091, DATE '1998-11-17', DATE '1999-11-17', 49155),
                           (10091, DATE '1999-11-17', DATE '2000-11-16', 53157),
                           (10091, DATE '2000-11-16', DATE '2001-11-16', 55958);
INSERT INTO salaries VALUES(10091, DATE '2001-11-16', DATE '9999-01-01', 60014);
INSERT INTO titles VALUES(10091, 'Engineer', DATE '1992-11-18', DATE '2001-11-18'),
                         (10091, 'Senior Engineer', DATE '2001-11-18', DATE '9999-01-01');
INSERT INTO employees VALUES(10092, 'Valdiodio', 'Niizuma', 2, DATE '1964-10-18', DATE '1989-09-22');
INSERT INTO dept_emp VALUES(10092, 'd005', DATE '1996-04-22', DATE '9999-01-01');
INSERT INTO salaries VALUES(10092, DATE '1996-04-22', DATE '1997-04-22', 53977),
                           (10092, DATE '1997-04-22', DATE '1998-04-22', 54672),
                           (10092, DATE '1998-04-22', DATE '1999-04-22', 58042),
                           (10092, DATE '1999-04-22', DATE '2000-04-21', 61969),
                           (10092, DATE '2000-04-21', DATE '2001-04-21', 62607),
                           (10092, DATE '2001-04-21', DATE '2002-04-21', 62323),
                           (10092, DATE '2002-04-21', DATE '9999-01-01', 66803);
INSERT INTO titles VALUES(10092, 'Engineer', DATE '1996-04-22', DATE '9999-01-01');
INSERT INTO employees VALUES(10093, 'Sailaja', 'Desikan', 1, DATE '1964-06-11', DATE '1996-11-05');
INSERT INTO dept_emp VALUES(10093, 'd007', DATE '1997-06-08', DATE '9999-01-01');
INSERT INTO salaries VALUES(10093, DATE '1997-06-08', DATE '1998-06-08', 67856),
                           (10093, DATE '1998-06-08', DATE '1999-06-08', 70269),
                           (10093, DATE '1999-06-08', DATE '2000-06-07', 73951),
                           (10093, DATE '2000-06-07', DATE '2001-06-07', 76944),
                           (10093, DATE '2001-06-07', DATE '2002-06-07', 78796),
                           (10093, DATE '2002-06-07', DATE '9999-01-01', 82715);
INSERT INTO titles VALUES(10093, 'Staff', DATE '1997-06-08', DATE '9999-01-01');
INSERT INTO employees VALUES(10094, 'Arumugam', 'Ossenbruggen', 2, DATE '1957-05-25', DATE '1987-04-18');
INSERT INTO dept_emp VALUES(10094, 'd008', DATE '1987-04-18', DATE '1997-11-08');
INSERT INTO salaries VALUES(10094, DATE '1987-04-18', DATE '1988-04-17', 58001),
                           (10094, DATE '1988-04-17', DATE '1989-04-17', 61131),
                           (10094, DATE '1989-04-17', DATE '1990-04-17', 63147),
                           (10094, DATE '1990-04-17', DATE '1991-04-17', 66339),
                           (10094, DATE '1991-04-17', DATE '1992-04-16', 68848),
                           (10094, DATE '1992-04-16', DATE '1993-04-16', 72932),
                           (10094, DATE '1993-04-16', DATE '1994-04-16', 73585),
                           (10094, DATE '1994-04-16', DATE '1995-04-16', 73617),
                           (10094, DATE '1995-04-16', DATE '1996-04-15', 76830),
                           (10094, DATE '1996-04-15', DATE '1997-04-15', 80759),
                           (10094, DATE '1997-04-15', DATE '1997-11-08', 85225);
INSERT INTO titles VALUES(10094, 'Senior Staff', DATE '1987-04-18', DATE '1997-11-08');
INSERT INTO employees VALUES(10095, 'Hilari', 'Morton', 1, DATE '1965-01-03', DATE '1986-07-15');
INSERT INTO dept_emp VALUES(10095, 'd007', DATE '1994-03-10', DATE '9999-01-01');
INSERT INTO salaries VALUES(10095, DATE '1994-03-10', DATE '1995-03-10', 63668),
                           (10095, DATE '1995-03-10', DATE '1996-03-09', 65982),
                           (10095, DATE '1996-03-09', DATE '1997-03-09', 66404),
                           (10095, DATE '1997-03-09', DATE '1998-03-09', 67641),
                           (10095, DATE '1998-03-09', DATE '1999-03-09', 70079),
                           (10095, DATE '1999-03-09', DATE '2000-03-08', 72169),
                           (10095, DATE '2000-03-08', DATE '2001-03-08', 74387),
                           (10095, DATE '2001-03-08', DATE '2002-03-08', 76900),
                           (10095, DATE '2002-03-08', DATE '9999-01-01', 80955);
INSERT INTO titles VALUES(10095, 'Senior Staff', DATE '2000-03-09', DATE '9999-01-01'),
                         (10095, 'Staff', DATE '1994-03-10', DATE '2000-03-09');
INSERT INTO employees VALUES(10096, 'Jayson', 'Mandell', 1, DATE '1954-09-16', DATE '1990-01-14');
INSERT INTO dept_emp VALUES(10096, 'd004', DATE '1999-01-23', DATE '9999-01-01');
INSERT INTO salaries VALUES(10096, DATE '1999-01-23', DATE '2000-01-23', 61395),
                           (10096, DATE '2000-01-23', DATE '2001-01-22', 63811),
                           (10096, DATE '2001-01-22', DATE '2002-01-22', 65962),
                           (10096, DATE '2002-01-22', DATE '9999-01-01', 68612);
INSERT INTO titles VALUES(10096, 'Engineer', DATE '1999-01-23', DATE '9999-01-01');
INSERT INTO employees VALUES(10097, 'Remzi', 'Waschkowski', 1, DATE '1952-02-27', DATE '1990-09-15');
INSERT INTO dept_emp VALUES(10097, 'd008', DATE '1990-09-15', DATE '9999-01-01');
INSERT INTO salaries VALUES(10097, DATE '1990-09-15', DATE '1991-09-15', 44886),
                           (10097, DATE '1991-09-15', DATE '1992-09-14', 47987),
                           (10097, DATE '1992-09-14', DATE '1993-09-14', 50406),
                           (10097, DATE '1993-09-14', DATE '1994-09-14', 51981),
                           (10097, DATE '1994-09-14', DATE '1995-09-14', 53075);
INSERT INTO salaries VALUES(10097, DATE '1995-09-14', DATE '1996-09-13', 53699),
                           (10097, DATE '1996-09-13', DATE '1997-09-13', 56903),
                           (10097, DATE '1997-09-13', DATE '1998-09-13', 59339),
                           (10097, DATE '1998-09-13', DATE '1999-09-13', 62690),
                           (10097, DATE '1999-09-13', DATE '2000-09-12', 65841),
                           (10097, DATE '2000-09-12', DATE '2001-09-12', 67846),
                           (10097, DATE '2001-09-12', DATE '9999-01-01', 70161);
INSERT INTO titles VALUES(10097, 'Senior Staff', DATE '1996-09-14', DATE '9999-01-01'),
                         (10097, 'Staff', DATE '1990-09-15', DATE '1996-09-14');
INSERT INTO employees VALUES(10098, 'Sreekrishna', 'Servieres', 2, DATE '1961-09-23', DATE '1985-05-13');
INSERT INTO dept_emp VALUES(10098, 'd004', DATE '1985-05-13', DATE '1989-06-29'),
                           (10098, 'd009', DATE '1989-06-29', DATE '1992-12-11');
INSERT INTO salaries VALUES(10098, DATE '1985-05-13', DATE '1986-05-13', 40000),
                           (10098, DATE '1986-05-13', DATE '1987-05-13', 41426),
                           (10098, DATE '1987-05-13', DATE '1988-05-12', 45147),
                           (10098, DATE '1988-05-12', DATE '1989-05-12', 48625),
                           (10098, DATE '1989-05-12', DATE '1990-05-12', 49228),
                           (10098, DATE '1990-05-12', DATE '1991-05-12', 51404),
                           (10098, DATE '1991-05-12', DATE '1992-05-11', 53646),
                           (10098, DATE '1992-05-11', DATE '1992-12-11', 56202);
INSERT INTO titles VALUES(10098, 'Engineer', DATE '1985-05-13', DATE '1992-05-13'),
                         (10098, 'Senior Engineer', DATE '1992-05-13', DATE '1992-12-11');
INSERT INTO employees VALUES(10099, 'Valter', 'Sullins', 2, DATE '1956-05-25', DATE '1988-10-18');
INSERT INTO dept_emp VALUES(10099, 'd007', DATE '1988-10-18', DATE '9999-01-01');
INSERT INTO salaries VALUES(10099, DATE '1988-10-18', DATE '1989-10-18', 68781),
                           (10099, DATE '1989-10-18', DATE '1990-10-18', 70711),
                           (10099, DATE '1990-10-18', DATE '1991-10-18', 75094),
                           (10099, DATE '1991-10-18', DATE '1992-10-17', 78490),
                           (10099, DATE '1992-10-17', DATE '1993-10-17', 81154),
                           (10099, DATE '1993-10-17', DATE '1994-10-17', 81480),
                           (10099, DATE '1994-10-17', DATE '1995-10-17', 85032),
                           (10099, DATE '1995-10-17', DATE '1996-10-16', 84698),
                           (10099, DATE '1996-10-16', DATE '1997-10-16', 86038),
                           (10099, DATE '1997-10-16', DATE '1998-10-16', 86212),
                           (10099, DATE '1998-10-16', DATE '1999-10-16', 89257),
                           (10099, DATE '1999-10-16', DATE '2000-10-15', 93297),
                           (10099, DATE '2000-10-15', DATE '2001-10-15', 95842);
INSERT INTO salaries VALUES(10099, DATE '2001-10-15', DATE '9999-01-01', 98538);
INSERT INTO titles VALUES(10099, 'Senior Staff', DATE '1995-10-19', DATE '9999-01-01'),
                         (10099, 'Staff', DATE '1988-10-18', DATE '1995-10-19');
INSERT INTO employees VALUES(10100, 'Hironobu', 'Haraldson', 2, DATE '1953-04-21', DATE '1987-09-21');
INSERT INTO dept_emp VALUES(10100, 'd003', DATE '1987-09-21', DATE '9999-01-01');
INSERT INTO salaries VALUES(10100, DATE '1987-09-21', DATE '1988-09-20', 54398),
                           (10100, DATE '1988-09-20', DATE '1989-09-20', 55586),
                           (10100, DATE '1989-09-20', DATE '1990-09-20', 57195),
                           (10100, DATE '1990-09-20', DATE '1991-09-20', 58209),
                           (10100, DATE '1991-09-20', DATE '1992-09-19', 57770),
                           (10100, DATE '1992-09-19', DATE '1993-09-19', 59188),
                           (10100, DATE '1993-09-19', DATE '1994-09-19', 60763);
INSERT INTO salaries VALUES(10100, DATE '1994-09-19', DATE '1995-09-19', 64797),
                           (10100, DATE '1995-09-19', DATE '1996-09-18', 68037),
                           (10100, DATE '1996-09-18', DATE '1997-09-18', 69404),
                           (10100, DATE '1997-09-18', DATE '1998-09-18', 70575),
                           (10100, DATE '1998-09-18', DATE '1999-09-18', 70464),
                           (10100, DATE '1999-09-18', DATE '2000-09-17', 72343),
                           (10100, DATE '2000-09-17', DATE '2001-09-17', 74365),
                           (10100, DATE '2001-09-17', DATE '9999-01-01', 74957);
INSERT INTO titles VALUES(10100, 'Senior Staff', DATE '1994-09-21', DATE '9999-01-01'),
                         (10100, 'Staff', DATE '1987-09-21', DATE '1994-09-21');

