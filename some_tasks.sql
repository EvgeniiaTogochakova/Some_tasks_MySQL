DELIMITER //

DROP DATABASE IF EXISTS finals//
CREATE DATABASE finals//
USE finals//

DROP FUNCTION IF EXISTS get_days_hours_min_sec//
CREATE FUNCTION get_days_hours_min_sec(value INT)
RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
  IF (value >= 0) THEN
	SET @particle = value;
  
	SET @days = floor(@particle/86400);
	SET @particle = mod(@particle, 86400);
  
	SET @hours = floor(@particle/3600);
	SET @particle = mod(@particle,3600);
  
	SET @minutes = floor(@particle/60);
  
	SET @seconds = mod(@particle, 60);
  
	SET @a = CONCAT(@days, " days ", @hours, " hours ", @minutes, " minutes ", @seconds, " seconds" ); 
    RETURN @a;
  ELSE 
	SET @a = CONCAT('Вы ввели некорректное число ', value);
	RETURN @a;
  END IF;
END//

SELECT get_days_hours_min_sec(123456) AS 'Результат конвертации'//

SELECT get_days_hours_min_sec(-123456) AS 'Результат конвертации'//

DROP PROCEDURE IF EXISTS just_even_numbers//
CREATE PROCEDURE just_even_numbers(value1 INT, value2 INT)
BEGIN
  SET @result = '';
  IF (value1 < value2) THEN
	cycle: LOOP
	  SET @i = value1 + 1;
	  IF (mod(@i,2) = 0) THEN
		SET @result = CONCAT(@result, ' ', @i);
	  END IF;
      SET value1 = value1 + 1;
	  IF (@i = value2) THEN LEAVE cycle;
      END IF;
	END LOOP cycle;
  ELSE 
	SELECT 'Число слева должно быть меньше, чем число справа' AS 'Предупреждение';
  END IF;
  SELECT @result AS 'Ряд четных чисел';
END//
    
CALL just_even_numbers(1,10)//
 