CREATE OR REPLACE FUNCTION Date2EnrollYear(dDate IN DATE)
RETURN NUMBER
IS
	year NUMBER;
	month NUMBER;
BEGIN
	SELECT TO_NUMBER(TO_CHAR(dDate, 'YYYY'))
	INTO year
	FROM dual;

	SELECT TO_NUMBER(TO_CHAR(dDate, 'MM'))
	INTO month
	FROM dual;

	IF (month >= 11) THEN
		year := year + 1;
	END IF;

	RETURN year;
END;
/

CREATE OR REPLACE FUNCTION Date2EnrollSemester(dDate IN DATE)
RETURN NUMBER
IS
	semester NUMBER;
BEGIN
	SELECT TO_NUMBER(TO_CHAR(dDate, 'MM'))
	INTO semester
	FROM dual;

	IF (semester >=5 and semester <= 10) THEN
		semester := 2;
	ELSE
		semester := 1;	
	END IF;

	RETURN semester;
END;
/