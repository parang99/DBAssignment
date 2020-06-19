set ServerOutput On;


DECLARE 
	CURSOR enroll_list(v_ecid enroll.e_cid%TYPE) IS
	SELECT e_sid
	FROM enroll
	WHERE e_cid = v_ecid;

	CURSOR course_list IS
	SELECT e_cid, ST_NUM
	FROM COURSE_SIZE;
	
	result VARCHAR2(50) := '';
	nSum NUMBER := 0;
	nCredit NUMBER := 0;
BEGIN
	DBMS_OUTPUT.enable;
	DBMS_OUTPUT.put_line('********************* Insert 및 에러 처리 테스트 *********************');

	/* 에러 처리 2: 동일한 과목 신청 여부 : 컴퓨터수학 신청 */
	/*InsertEnroll('20011234', 'C400', 3, result);*/
	/*DBMS_OUTPUT.put_line('결과 : ' || result);*/
	InsertEnroll('1010101', 'CM01', 3, result);
	DBMS_OUTPUT.put_line('결과 : ' || result);

	/* 에러 처리 3: 수강신청 인원 초과 여부 : 졸업프로젝트1 신청 */
	InsertEnroll('1010101', 'GP01', 1, result);
	DBMS_OUTPUT.put_line('결과 : ' || result);

	/* 에러 처리 4: 신청한 과목들 시간 중복 여부 : 프로그래밍개론1 신청 */
	InsertEnroll('1010101', 'PL01', 1, result);
	DBMS_OUTPUT.put_line('결과 : ' || result);

	/* 에러가 없는 경우 : 컴퓨터네트워크2 신청 */
	InsertEnroll('1010101', 'CN02', 1, result);
	DBMS_OUTPUT.put_line('결과 : ' || result);

	/* 에러 처리 1: 최대 학점 초과 여부 검사 : 데이터베이스 프로그래밍 신청 */
	InsertEnroll('1010101', 'DB01', 1, result);
	DBMS_OUTPUT.put_line('결과 : ' || result);

	DBMS_OUTPUT.put_line('******************** CURSOR를 이용한 SELECT 테스트 ********************');

	/* 최종 결과 확인 */
	SelectTimeTable('1010101', 2020, 2, nSum, nCredit);
	/*DBMS_OUTPUT.put_line('결과 : ' || nSum || ' 그리고 ' || nCredit);*/

	delete from enroll where e_sid = '1010101' and e_cid = 'CN02' and e_cno = 1;

	DBMS_OUTPUT.put_line('*********** 파라미터 있는 CURSOR를 이용한 수강생 확인 테스트 ***********');
	DBMS_OUTPUT.put_line('데이터베이스프로그래밍(DB01)을 신청한 학생입니다.');

	/*파라미터 변수의 값을 전달*/
	FOR enlist IN enroll_list('DB01') LOOP
		DBMS_OUTPUT.PUT_LINE('아이디 : ' || enlist.e_sid);
	END LOOP;

	DBMS_OUTPUT.put_line('*********** VIEW를 이용한 과목별 수강생 인원 수 확인 테스트 ***********');
	
	/*COURSE_SIZE 뷰 이용*/
	FOR clist IN course_list LOOP
		DBMS_OUTPUT.put_line('과목 아이디 : '|| clist.e_cid || ', 인원 수 : ' || clist.ST_NUM);
	END LOOP;

	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);
END;
/
