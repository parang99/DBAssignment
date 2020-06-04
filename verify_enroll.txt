CREATE OR REPLACE PROCEDURE SelectTimeTable(sStudentId IN VARCHAR2, nYear IN NUMBER, nSemester IN NUMBER, nSum OUT NUMBER, nCredit OUT NUMBER)
IS
	CURSOR time_table IS
	SELECT c_time, c_id, c_name, c_no, c_credit, c_where
	FROM course, enroll
	WHERE e_sid = sStudentId and e_year = nYear and e_semester = nSemester and e_cid = c_id and e_cno = c_no;
	
	v_ctime	course.c_time%TYPE;
	v_cid	course.c_id%TYPE;
	v_cname	course.c_name%TYPE;
	v_cno	course.c_no%TYPE;
	v_ccredit	course.c_credit%TYPE;
	v_cwhere	course.c_where%TYPE;
BEGIN
	nCredit := 0;
	nSum := 0;
	DBMS_OUTPUT.put_line(nYear || '년도 ' || nSemester || '학기의 ' || sStudentId || '님의 수강신청 시간표입니다.');
	OPEN time_table;
	LOOP
		FETCH time_table INTO v_ctime, v_cid, v_cname, v_cno, v_ccredit, v_cwhere;
		EXIT WHEN time_table%NOTFOUND;
		DBMS_OUTPUT.put_line('교시:' || MOD(v_ctime,10) || ', 과목번호:' || v_cid || ', 과목명:' || v_cname || ', 분반:' || v_cno || ', 학점:' || v_ccredit || ', 장소:' || v_cwhere);
		nCredit := nCredit + v_ccredit;	
	END LOOP;
	
	nSum := time_table%ROWCOUNT;
	DBMS_OUTPUT.put_line('총 과목 수 : ' || time_table%ROWCOUNT);
	DBMS_OUTPUT.put_line('총 학점 수 : ' || nCredit);
	
	CLOSE time_table;

	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE(SQLERRM || ' 에러 발생');
END;
/
