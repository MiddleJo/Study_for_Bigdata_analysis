--[���̺� ���� ��Ģ]

--���̺���� ��ü�� �ǹ��� �� �ִ� ������ �̸��� ����Ѵ�. ������ �ܼ����� �ǰ��Ѵ�.--
--���̺���� �ٸ� ���̺��� �̸��� �ߺ����� �ʾƾ� �Ѵ�.--
--�� ���̺� �������� Į������ �ߺ��ǰ� ������ �� ����. --
--���̺� �̸��� �����ϰ� �� Į������ ��ȣ "( )" �� ���� �����Ѵ�.--
--�� Į������ �޸�" ", �� ���еǰ�, �׻� ���� �����ݷ� ";"���� ������.--
--Į���� ���ؼ��� �ٸ� ���̺���� ����Ͽ� �����ͺ��̽� �������� �ϰ��� �ְ� ����ϴ� ���� ����. (������ ǥ��ȭ ����)--
--Į�� �ڿ� ������ ������ �� �����Ǿ�� �Ѵ�.--
--���̺��� Į������ �ݵ�� ���ڷ� �����ؾ� �ϰ�, �������� ���̿� ���� �Ѱ谡 �ִ�.--
--�������� ������ ������ �����(Reserved word)�� �� �� ����.--
--A-Z, a-z, 0-9, _, $, # ���ڸ� ���ȴ�.

SELECT * from TABS;
CREATE TABLE MEMBER
(
ID       VARCHAR2(50),
PWD      VARCHAR2(50),
NAME     VARCHAR2(50),
GENDER   VARCHAR2(50),
AGE      NUMBER,
BIRTHDAY VARCHAR2(50),
PHONE    VARCHAR2(50),
REGDATE  DATE
);

DROP TABLE MEMBER;

CREATE TABLE MEMBER
(
ID       VARCHAR2(20),
PWD      VARCHAR2(20),
NAME     VARCHAR2(50),
GENDER   NCHAR(2),
AGE      NUMBER,
BIRTHDAY VARCHAR2(10),
PHONE    VARCHAR2(13),
REGDATE  DATE
);
--�Ϻ� �Ӽ��� �Է�
INSERT INTO MEMBER(ID, PWD, NAME)VALUES('200901','111','YOON');
SELECT * FROM MEMBER;
--��ü ��� �Է�
INSERT INTO MEMBER VALUES('200902','112','HYEON','M',26,'31-MAY-97','010-3219-3897','1997/05/31');

SELECT * FROM MEMBER;

ALTER TABLE MEMBER ADD TEXT NCLOB;

INSERT INTO MEMBER(ID,PWD,TEXT) VALUES('200903','113','��ġ�� ������ ���� �����Ѵ�');

--���� ���̺��� �̿��Ͽ� ���ο� ���̺��� ����
CREATE TABLE MEMBER1 AS SELECT * FROM MEMBER;
SELECT * from MEMBER1;
DESC member1;
CREATE TABLE member2 AS SELECT * FROM member1 WHERE 1=0;
DESC member2;


--���̺��� ��� row ����
TRUNCATE TABLE member1;

--���̺� �Ӽ� �� Ÿ�� ��ȸ
DESC MEMBER;
--���̺� ����Ʈ ��ȸ
SELECT * FROM TABS;
SELECT * FROM MEMBER1;

--����
DESC MEMBER1;
ALTER TABLE MEMBER1 MODIFY(ID VARCHAR2(50), NAME NVARCHAR2(50));
--����
ALTER TABLE MEMBER1 RENAME COLUMN BIRTHDAY TO BD;
--����
ALTER TABLE MEMBER1 DROP COLUMN AGE;
--�߰�
ALTER TABLE MEMBER1 ADD AGE NUMBER;
--�������� �߰� (�⺻Ű�� �������� Ÿ�� ���� NOT NULL ���ִ�)
--���������� ����: NOT NULL, UNIQUE, PRIMARY KEY(UNIQUE+NOT NULL),
--              FROEIGN KEY(�ٸ� ���̺��� �÷����� ���Ἲ �˻�), CHECK(�������� ������ ���� ���
ALTER TABLE MEMBER1 ADD CONSTRAINT MEMBER1_PK PRIMARY KEY (ID);

--[����] MEMBER2 ���̺��� ������ �� ����, ����, ����, �߰� �۾��� �����ϼ���.(�л� �̷� TABLE, �Ӽ�5�� �̻�)
--CREATE TABLE STUDENT_CAREER(
--NAME 	    VARCHAR2(50),
--S_date 		DATE,
--E_date 		DATE,

--Q. �Ʒ� ������ ������� PLAYER ���̺��� �����ϼ���.
--���̺�� : PLAYER
--���̺� ���� : K-���� �������� ������ ������ �ִ� ���̺�
--Į���� : PLAYER_ID (����ID) ���� ���� �ڸ��� 7�ڸ�,
--PLAYER_NAME (������) ���� ���� �ڸ��� 20�ڸ�,
--TEAM_ID (��ID) ���� ���� �ڸ��� 3�ڸ�,
--JOIN_YYYY (�Դܳ⵵) ���� ���� �ڸ��� 4�ڸ�,
--POSITION (������) ���� ���� �ڸ��� 10�ڸ�,
--BACK_NO (���ȣ) ���� 2�ڸ�,
--NATION (����) ���� ���� �ڸ��� 20�ڸ�,
--BIRTH_DATE (�������) ��¥,
--�������� : �⺻Ű(PRIMARY KEY) :  PLAYER_ID
--(�������Ǹ��� PLAYER_PK)
--���� �ݵ�� ���� (NOT NULL) : PLAYER_NAME, TEAM_ID

CREATE TABLE PLAYER
(
PLAYER_ID          CHAR(7),
PLAYER_NAME         VARCHAR2(20)    NOT NULL,
TEAM_ID        CHAR(3)    NOT NULL,
JOIN_YYYY      CHAR(4),
POSITION         VARCHAR2(10),
BACK_NO    NUMBER(2,0),
NATION       VARCHAR2(20),
BIRTH_DATE     DATE
);
ALTER TABLE PLAYER ADD CONSTRAINT PLAYER_PK PRIMARY KEY (PLAYER_ID);

select * from player;


