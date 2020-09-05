# 수강신청 프로그램
Work with JooyeonJung   
Use Eclipse, Apache Tomcat, Oracle

---
DB schema
- student(s_id: varchar2, s_pwd: varchar2, s_name: varchar2, s_addr varchar2)
- course(c_id: varchar2, c_no: number, c_year: number, c_semester: number, c_name: varchar2, c_credit: number, c_max: number, c_time: number, c_where: varchar2)
- enroll(e_sid: varchar2, e_cid: varchar2, e_cno: number, e_year: number, e_semester: number)
---
jsp 설명
- main.jsp : 메인화면
- top.jsp : 탭(로그인, 사용자 정보 수정, 수강신청 입력, 수강신청 삭제, 수강신청 조회) 표시
- login.jsp : 로그인 화면
- login_verify.jsp : 로그인 여부 확인
- logout.jsp : 로그아웃
- update.jsp : 사용자 정보 수정 화면
- update_verify.jsp : 사용자 정보 수정 관리
- insert.jsp : 수강신청 입력 화면
- insert_verify.jsp : 수강신청 입력 관리
- delete.jsp : 수강신청 삭제 화면
- delete.verify.jsp : 수강신청 삭제 관리
- select.jsp : 수강신청 조회 화면
---
sql 설명
- table.sql : 테이블 생성 및 레코드 삽입
- enrollView.sql : View 생성
- updateTrigger.sql : trigger 작성
- function.sql : 사용자 정의 함수
- InsertTest.sql : 수강신청 가능 여부 테스트
- verify_enroll.sql : callableStament에서 사용되는 stored procedure
- InsertEnroll.sql : 수강신청 입력 처리. insert_verify.jsp에서 사용. 
---
프로젝트 기여   
parang99 : insert, select, delete, etc..   
JooyeonJung : login, update, trigger, view, etc..   
