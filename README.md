# 수강신청 프로그램
This project is worked with JooyeonJung
---
.txt is table   
.jsp is opened in eclipse   
---
DB schema
- student(s_id: varchar2, s_pwd: varchar2, s_name: varchar2, s_addr varchar2)
- course(c_id: varchar2, c_no: number, c_year: number, c_semester: number, c_name: varchar2, c_credit: number, c_max: number, c_time: number, c_where: varchar2)
- enroll(e_sid: varchar2, e_cid: varchar2, e_cno: number, e_year: number, e_semester: number)
---
jsp 코드 설명
- main.jsp : 
- top.jsp : 
- login.jsp : 
- login_verify.jsp : 
- logout.jsp : 
- select.jsp : 
- insert.jsp : 
- insert_verify.jsp : 
- delete.jsp : 
- delete.verify.jsp : 
- update.jsp : 
- update_verify.jsp : 
---
sql 코드 설명
- table.sql : 테이블 생성 및 레코드 삽입
- enrollView.sql : View 생성
- InsertTest.sql : 
- updateTrigger.sql : 
- verify_enroll.sql :
- InsertEnroll.sql : 
- function.sql : 
