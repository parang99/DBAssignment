CREATE OR REPLACE PROCEDURE InsertEnroll(sStudentID IN VARCHAR2, sCourseID IN VARCHAR2, nCourseNo IN NUMBER, result OUT VARCHAR2)
IS
	too_many_sumCourseCredit	EXCEPTION;
	too_many_courses 		EXCEPTION;
	too_many_students		EXCEPTION;
	duplicate_time		EXCEPTION;
	nYear			NUMBER;
	nSemester		NUMBER;
	nSumCourseCredit		NUMBER;
	nCourseCredit		NUMBER;
	nCnt			NUMBER;
	nCourseMax		NUMBER;
	v_courseMax		course%ROWTYPE;
BEGIN
	result := '';
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseNo) || '의 수강등록을 요청하였습니다.');
	
	/* 수강 대상 년도, 학기 알아내기 */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);

	/* 에러 처리 1 : 최대학점 초과여부 */
	SELECT SUM(c_credit)
	INTO nSumCourseCredit
	FROM course, enroll
	WHERE e_sid = sStudentId and e_year = nYear and e_semester = nSemester and e_cid = c_id and e_cno = c_no;

	SELECT c_credit
	INTO nCourseCredit
	FROM course
	WHERE c_id = sCourseId and c_no = nCourseNo and c_year = nYear and c_semester = nSemester;

	IF (nSumCourseCredit + nCourseCredit > 18)
	THEN
		RAISE too_many_sumCourseCredit;
	END IF;

	/* 에러 처리 2 : 동일한 과목 신청 여부 */
	SELECT COUNT(*)
	INTO nCnt
	FROM enroll
	WHERE e_sid = sStudentId and e_cid = sCourseId;

	IF (nCnt > 0)
	THEN
		RAISE too_many_courses;
	END IF;

	/* 에러 처리 3 : 수강신청 인원 초과 여부 */
	SELECT c_max
	INTO v_courseMax.c_max
	FROM course
	WHERE c_year = nYear and c_semester = nSemester and c_id = sCourseId and c_no = nCourseNo ;

	SELECT COUNT(*)
	INTO nCnt
	FROM enroll
	WHERE e_year = nYear and e_semester = nSemester and e_cid = sCourseId and e_cno = nCourseNo;
	
	IF (nCnt >= v_courseMax.c_max)
	THEN
		RAISE too_many_students;
	END IF;

	/* 에러 처리 4 : 신청한 과목들 시간 중복 여부 */
	SELECT COUNT(*)
	INTO nCnt
	FROM(
		SELECT c_time
		FROM course
		WHERE c_year = nYear and c_semester = nSemester and c_id = sCourseId and c_no = nCourseNo
		
		INTERSECT
		
		SELECT c_time
		FROM course, enroll
		WHERE e_sid = sStudentId and e_year = nYear and e_semester = nSemester and c_year = nYear and c_semester = nSemester and e_cid = c_id and e_cno = c_no
	);
	
	IF (nCnt > 0)
	THEN
		RAISE duplicate_time;
	END IF;

	/* 수강 신청 등록 */
	INSERT INTO enroll(e_sid, e_cid, e_cno, e_year, e_semester) VALUES (sStudentId, sCourseId, nCourseNo, nYear, nSemester);
	
	COMMIT;
	result := '수강신청 등록이 완료되었습니다.';
EXCEPTION
	WHEN too_many_sumCourseCredit THEN
		result := '최대학점을 초과하였습니다.';
	WHEN too_many_courses THEN
		result := '이미 등록된 과목을 신청하였습니다.';
	WHEN too_many_students THEN
		result := '수강신청 인원이 초과되어 등록이 불가능합니다.';
	WHEN duplicate_time THEN
		result := '이미 등록된 과목 중 중복되는 시간이 존재합니다.';
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;
END;
/

