drop table enroll;
drop table course;
drop table student;
purge recyclebin;

CREATE TABLE student(
s_id varchar2(7) CONSTRAINT student_pk PRIMARY KEY, 
s_pwd varchar2(20) CONSTRAINT student_nn NOT NULL, 
s_name varchar2(6), 
s_addr varchar2(60)
);
INSERT INTO STUDENT VALUES('1111111', 'oneone', '정하나', '경기도 광명시 광덕산로 26');
INSERT INTO STUDENT VALUES('2222222', 'twotwo', '김둘둘', '서울특별시 용산구 청파로 47길');
INSERT INTO STUDENT VALUES('3333333', 'three', '이셋셋', '서울특별시 성북구 성북로4길 52');
INSERT INTO STUDENT VALUES('4444444', 'four', '심넷넷', '서울특별시 광진구 구의강변로 104');
INSERT INTO STUDENT VALUES('5555555', 'five', '연다섯', '강원도 춘천시 춘천로 167번길');
INSERT INTO STUDENT VALUES('6666666', 'sixsix', '나여섯', '강원도 홍천군 홍천읍 홍천로 388');
INSERT INTO STUDENT VALUES('7777777', 'seven', '권일곱', '경기도 광명시 하안로');
INSERT INTO STUDENT VALUES('8888888', 'eight', 'Janet', '경기도 광명시 일직로');
INSERT INTO STUDENT VALUES('9999999', 'nine', 'Stella', '경기도 광명시 오리로');
INSERT INTO STUDENT VALUES('1010101', 'tenten', 'Juno', '경기도 광명시 광명로');

CREATE TABLE course(
c_id varchar2(8), 
c_no NUMBER, 
c_year NUMBER, 
c_semester NUMBER, 
c_name varchar2(50), 
c_credit NUMBER, 
c_max NUMBER, 
c_time NUMBER, 
c_where varchar2(20), 
CONSTRAINT course_pk PRIMARY KEY(c_id, c_no, c_year, c_semester)
);
INSERT INTO COURSE VALUES('DB01', 1, 2020, 2, '데이터베이스 프로그래밍', 3, 31, 11, '명신관'); 
INSERT INTO COURSE VALUES('DB01', 2, 2020, 2, '데이터베이스 프로그래밍', 3, 31, 12, '명신관');
INSERT INTO COURSE VALUES('DB02', 1, 2020, 2, '데이터베이스 설계와 질의', 3, 40, 31, '명신관'); 
INSERT INTO COURSE VALUES('DB02', 2, 2020, 2, '데이터베이스 설계와 질의', 3, 40, 32, '명신관'); 
INSERT INTO COURSE VALUES('CM01', 1, 2020, 2, '컴퓨터수학', 3, 50, 21, '명신관'); 
INSERT INTO COURSE VALUES('CM01', 2, 2020, 2, '컴퓨터수학', 3, 50, 22, '명신관'); 
INSERT INTO COURSE VALUES('CM01', 3, 2020, 2, '컴퓨터수학', 3, 50, 23, '명신관'); 
INSERT INTO COURSE VALUES('CN01', 1, 2020, 2, '컴퓨터네트워크1', 3, 60, 33, '명신관'); 
INSERT INTO COURSE VALUES('CN02', 1, 2020, 2, '컴퓨터네트워크2', 3, 60, 34, '명신관'); 
INSERT INTO COURSE VALUES('PL01', 1, 2020, 2, '프로그래밍개론1', 3, 20, 31, '명신관'); 
INSERT INTO COURSE VALUES('PL02', 1, 2020, 2, '프로그래밍개론2', 3, 20, 32, '명신관'); 
INSERT INTO COURSE VALUES('GP01', 1, 2020, 2, '졸업 프로젝트1', 3, 3, 51, '순헌관'); 
INSERT INTO COURSE VALUES('GP02', 1, 2020, 2, '졸업 프로젝트2', 3, 3, 52, '순헌관'); 
INSERT INTO COURSE VALUES('ED01', 1, 2020, 2, '특수교육학개론',2, 30, 43, '새힘관'); 
INSERT INTO COURSE VALUES('ED01', 2, 2020, 2, '특수교육학개론', 2, 30, 44, '새힘관'); 
INSERT INTO COURSE VALUES('ED02', 1, 2020, 2, '학교폭력예방', 2, 30, 45, '새힘관'); 


CREATE TABLE enroll(
e_sid varchar2(7),
e_cid varchar2(8), 
e_cno NUMBER, 
e_year NUMBER, 
e_semester NUMBER, 
CONSTRAINT enroll_pk PRIMARY KEY(e_sid, e_cid),
CONSTRAINT enroll_fk_student FOREIGN KEY(e_sid) REFERENCES student(s_id), 
CONSTRAINT enroll_fk_teach FOREIGN KEY(e_cid, e_cno, e_year, e_semester) REFERENCES course(c_id, c_no, c_year, c_semester)
);
INSERT INTO ENROLL VALUES('1111111', 'GP01', 1, 2020, 2);
INSERT INTO ENROLL VALUES('2222222', 'GP01', 1, 2020, 2);
INSERT INTO ENROLL VALUES('3333333', 'GP01', 1, 2020, 2);

INSERT INTO ENROLL VALUES('1010101', 'CM01', 1, 2020, 2);
INSERT INTO ENROLL VALUES('1010101', 'DB02', 1, 2020, 2);
INSERT INTO ENROLL VALUES('1010101', 'CN01', 1, 2020, 2);
INSERT INTO ENROLL VALUES('1010101', 'GP02', 1, 2020, 2);
INSERT INTO ENROLL VALUES('1010101', 'ED01', 1, 2020, 2);




