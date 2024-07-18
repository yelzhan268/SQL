/*
Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы

1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

-- 1
DROP PROCEDURE find_time;

DELIMITER $$
CREATE FUNCTION find_time(num INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
	DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
    DECLARE res VARCHAR(100) DEFAULT '';
     
    IF num < 60 THEN
		SET res = CONCAT(num, ' seconds');
	ELSEIF num > 60 AND num < 3600 THEN
		SET minutes = num DIV 60;
		SET seconds = num % 60;
		SET res = CONCAT(minutes, ' minutes ', seconds, ' seconds ');
	ELSEIF num > 3600 AND num < 86400 THEN
		SET hours = num DIV 3600;
		SET num = num % 3600;
		SET minutes = num DIV 60;
		SET seconds = num % 60;
		SET res = CONCAT(hours, ' hours ', minutes, ' minutes ', seconds, ' seconds ');
	ELSE
		SET days = num DIV 86400;
		SET num = num % 86400;
		SET hours = num DIV 3600;
		SET num = num % 3600;
		SET minutes = num DIV 60;
		SET seconds = num % 60;
		SET res = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds ');
	END IF;
    RETURN res;
END $$
DELIMITER ;

SELECT find_time(123456);


-- 2
DROP PROCEDURE even_numbers;

DELIMITER $$
CREATE PROCEDURE even_numbers(x INT)
BEGIN
	DECLARE res VARCHAR(200) DEFAULT CAST(x AS CHAR(200));
    IF x % 2 = 0 THEN
		REPEAT
			SET x = x - 2;
			SET res = CONCAT(x, ', ', res);
			UNTIL x <= 0
		END REPEAT;
	ELSE 
        SET x = x - 1;
        SET res = CAST(x AS CHAR(200));
        REPEAT
			SET x = x - 2;
			SET res = CONCAT(x, ', ', res);
			UNTIL x <= 0
		END REPEAT;
	END IF;
    SELECT res;
END $$
DELIMITER ;

CALL even_numbers(11);