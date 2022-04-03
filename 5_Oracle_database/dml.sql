--dml
DESC BOOK;
SELECT * FROM BOOK;
SELECT BOOKNAME,PRICE FROM BOOK;
SELECT DISTINCT PUBLISHER FROM BOOK;
SELECT *
FROM BOOK
WHERE PRICE < 10000;
--Q. ������ 10000�� �̻� 20000�� ������ ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE PRICE BETWEEN 10000 AND 20000;
--Q. ���ǻ簡 �½�����, Ȥ�� ���ѹ̵���� ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE PUBLISHER = '���ѹ̵��' OR PUBLISHER = '�½�����';
SELECT * FROM BOOK WHERE PUBLISHER IN ('�½�����','���ѹ̵��')
--Q. �����̸��� �౸�� ���Ե� ���ǻ縦 �˻��ϼ���.
select PUBLISHER from book where BOOKNAME like '%�౸%';
--[����] �����̸��� ���� �� ��° ��ġ�� ����� ���ڿ��� ���� ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE BOOKNAME LIKE '_��%';
--[����] �౸�� ���� ���� �� ������ 20000�� �̻��� ������ �˻��ϼ���.
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%' AND PRICE > 20000;

SELECT * FROM BOOK ORDER BY BOOKNAME DESC;

--Q. ������ ���ݼ����� �˻��ϰ� ������ ������ �̸������� �˻�
SELECT * FROM BOOK ORDER BY PRICE,BOOKNAME;
--Q. ������ ������ ������������ �˻��ϰ� ������ ������ ���ǻ��� ��������
SELECT * FROM BOOK ORDER BY PRICE DESC,PUBLISHER;

SELECT * FROM ORDERS;
SELECT SUM(SALEPRICE) AS "�Ѹ���" FROM orders;

--Q. CUSTID�� 2���� ��
SELECT SUM(SALEPRICE) AS "���Ǹž�" FROM ORDERS WHERE CUSTID = 2;
SELECT SUM(SALEPRICE) AS TOTAL,
AVG(SALEPRICE) AS AVERAGE,
MIN(SALEPRICE) AS MINIMUM,
MAX(SALEPRICE) AS MAXIMUM
FROM ORDERS;

SELECT COUNT(*) FROM ORDERS;

--Q. CUSTID�� ���������� ���Ǹž��� ����ϼ���.
SELECT CUSTID,
COUNT(*) AS ��������,
SUM(SALEPRICE) AS ���Ǹž�
FROM ORDERS
GROUP BY CUSTID;

--Q. ������ 8000�� �̻��� ������ ������ ���� ���� ���� �ֹ� ������ �� ������ ���ϼ���. �� �α� �̻� ������ ���� ������.
SELECT CUSTID, COUNT(*) AS ��������
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2;

SELECT * FROM CUSTOMER;

SELECT * FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ������ �����ϼ���.
SELECT NAME, SUM(SALEPRICE)
FROM CUSTOMER,ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
GROUP BY CUSTOMER.NAME
ORDER BY CUSTOMER.NAME;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���.
SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM CUSTOMER, ORDERS, BOOK
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID AND ORDERS.BOOKID = BOOK.BOOKID;
-- �����ϰ� ����
SELECT C.NAME, B.BOOKNAME
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID;

--[����] ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���ϼ���.
SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM CUSTOMER, ORDERS, BOOK
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID AND ORDERS.BOOKID = BOOK.BOOKID AND BOOK.PRICE = 20000;

--[����] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���ϼ���.
SELECT NAME, SALEPRICE
FROM CUSTOMER LEFT OUTER JOIN ORDERS ON CUSTOMER.CUSTID  = ORDERS.CUSTID;
-- �ٸ� ��� - RIGHT JOIN
SELECT CUSTOMER.NAME, SALEPRICE
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID(+);
-- �ٸ� ��� - LEFT JOIN
SELECT CUSTOMER.NAME, SALEPRICE
FROM CUSTOMER, ORDERS
WHERE ORDERS.CUSTID(+) = CUSTOMER.CUSTID;

--[����] ���� ��� ������ �̸��� ����ϼ���
SELECT BOOKNAME FROM BOOK WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);

--[����] ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ���.
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);

--[����] ���ѹ̵��� ������ ������ ������ ���� �̸��� ����ϼ���.
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS WHERE BOOKID IN (SELECT BOOKID FROM BOOK WHERE PUBLISHER = '���ѹ̵��'));

--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
SELECT b1.bookname
from Book b1
where b1.price > (select avg(b2.price)
from book b2
where b2.publisher=b1.publisher);
--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
select name
from customer
minus
select name
from customer
where custid in (select custid from orders);
--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
select name,address
from customer cs
where exists (select *
from orders od
where cs.custid=od.custid);
--Q. Customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����Ͻÿ�.
update Customer
set address = '���ѹα� �λ�'
where custid=5;
--Q. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
update Customer
set address=(select address from customer where name='�迬��')
where name='�ڼ���';
--Q. customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���Ͻÿ�.
delete from Customer where custid=5;
select * from Customer;

select abs(-78), abs(+78) from dual;
select round(4.875,1) from dual;

--Q. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
select custid "����ȣ",round(sum(saleprice)/count(*),-2) "��ձݾ�"
from orders
group by custid;
select custid as "����ȣ",round(avg(saleprice),-2) as "��� �ֹ� �ݾ�"
from orders
group by custid;
SELECT NAME,ROUND(AVG(SALEPRICE),-2)
FROM CUSTOMER,ORDERS
WHERE CUSTOMER.CUSTID=ORDERS.CUSTID
GROUP BY CUSTOMER.NAME;
--Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ���, ������ ���̽ÿ�.
select bookid, replace(bookname,'�߱�','��') bookname, publisher, price
from Book;
--Q. '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
select bookname "����", length(bookname) "���ڼ�", LENGTHB(bookname) "����Ʈ��"
from book
where publisher = '�½�����';

insert into customer values(5,'�ڼ���','���ѹα�����',null);
insert into customer values(6,'�ڼ���','���ѹα�����','000-9000-0001');
delete customer where custid=6;

--Q. ���缭���� �� �߿��� ���� ���� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
select SUBSTR(name,1,1) "��", count(*) "�ο�"
from Customer
Group by SUBSTR(name,1,1);

--Q. DMBS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
select sysdate from dual;
select sysdate, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss')SYSDATE1 FROM DUAL;

--Q. ���缭���� 2020�� 7�� 7�Ͽ� �ֹ� ���� ������ �ֹ� ��ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�.
SELECT ORDERID "�ֹ���ȣ", TO_CHAR(orderdate, 'yyyy-mm-dd dy') �ֹ���, custid ����ȣ, bookid ������ȣ
from orders
where orderdate = TO_DATE('20200707','yyyymmdd');

--Q. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.
SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM<=2;

--Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid, saleprice from orders where saleprice <= (select avg(saleprice) from orders);
--Q. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
select orderid, custid, saleprice
from orders o1
where saleprice > (select avg(saleprice) from orders o2 where o1.custid = o2.custid);
--Q. '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
semlect sum(saleprice) ���Ǹž� from orders
where custid in (select custid from customer where adress like '%���ѹα�%');
--Q. 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid, saleprice from orders 
where saleprice > (select max(saleprice) from orders where custid='3');

select orderid, saleprice from orders 
where saleprice > all (select saleprice from orders where custid='3');

--[����] EXISTS �����ڸ� ����Ͽ� '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select sum(saleprice) ���Ǹž� from orders o
where EXISTS (select * from customer c where address like '%���ѹα�%' and c.custid = o.custid);

--[����] ���缭���� ���� �Ǹž��� ���̽ÿ�.(���̸��� ���� �Ǹž� ���)
select (select name from customer c where c.custid = o.custid) �̸�,
sum(saleprice) �Ǹž�
from orders o
group by o.custid;

--[����] ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�.(���̸��� ���� �Ǹž� ���)
select c.name, sum(o.saleprice) �Ѿ�
from (select custid, name from customer where custid <= 2) c, orders o
where c.custid = o.custid
group by c.name;

--Q. �ּҿ� '���ѹα�'�� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer��.
create view vw_Customer as 
select * from customer where address like '%���ѹα�%';

select * from vw_Customer;

--[����] orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��,
create view vw_Orders (orderid,custid,name,bookid,bookname,saleprice,orderdate) as
select o.orderid, o.custid, c.name, o.bookid, b.bookname, o.saleprice, o.orderdate
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid;

--[����] '�迬��' ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
select orderid, bookname, saleprice from vw_orders
where name='�迬��';

--[����] vw_Customer�� �̱��� �ּҷ� ���� ������ �����ϼ���.
create or replace view vw_Customer (custid,name,address) as
select custid,name,address from Customer
where address like '%�̱�%';

select * from vw_customer;

--[����] �ռ� ������ �� vw_customer�� �����Ͻÿ�.
drop view vw_customer;


select * from employees;
--[����] EMPLOYEEs ���̺��� commission_pct�� Null�� ������ ���.
select count(*) null���� from employees where commission_pct is null;
--[����] employees ���̺��� employee_id�� Ȧ���� �͸� ���\
select count(*) Ȧ��id from employees where mod(employee_id,2)=1; 
--[����] job_id�� ���� ���̸� ���ϼ���.
select length(job_id) ���ڱ��� from employees;
--[����] job_id ���� �����հ� ������� �ְ��� �������� ���
select job_id,sum(salary) �����հ�, avg(salary) �������, max(salary) �ְ���, min(salary) ��������
from employees
group by job_id;

--��¥ ���� �Լ�
select sysdate from dual;
select * from employees;
select last_name, hire_date,trunc((sysdate - hire_date)/365,0) �ټӿ��� from employees;

--Ư�� ���� ���� ���� ��¥�� ���ϱ�
select last_name, hire_date, add_months(hire_date,6) "6������" from employees;

--�ش� ��¥�� ���� ���� ������ ��ȯ�ϴ� �Լ�
select LAST_DAY(sysdate) from dual;

--Q. ������ ����
select last_name, hire_date,last_DAY(ADD_MONTHS(hire_date,1)) "�Ի� ������ ����"
from employees;

--�ش� ��¥�� �������� ���� ����� ��õ� ������ ��¥�� ��ȯ
select last_name,hire_date,
NEXT_DAY(hire_date,'������') "6���� �� ù ������"
from employees;

--month_between() ��¥�� ��¥ ������ ���� ���� ���ϱ�
select last_name, trunc(MONTHS_BETWEEN(sysdate,hire_date),0)�ݼӿ��� from employees;

--Q. �Ի��� 6���� �� ù ���� �������� �����̸����� ���
select last_name, NEXT_DAY(ADD_MONTHS(hire_date,6),'������') "6���� �� ù ������"
from employees;

--Q. job id ���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ���
select job_id,sum(salary) �����հ�, avg(salary) �������, max(salary) �ְ���, min(salary) ��������
from employees
group by job_id
having avg(salary) >= 5000;

--Q. job_id ���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻�, ��������
select job_id,sum(salary) �����հ�, avg(salary) �������, max(salary) �ְ���, min(salary) ��������
from employees
group by job_id
having avg(salary) >= 5000
order by avg(salary) desc;

--Q. last_name�� L�� ���Ե� ������ ������ ���ϼ���.
select last_name, salary from employees where last_name like '%L%';
--Q. job_id�� PROG�� ���Ե� ������ �Ի����� ���ϼ���.
select last_name, job_id,hire_date from employees where job_id like '%PROG%';
--Q. ������ 10000 �̻��� manager_id�� 100�� ������ �����͸� ���
select * from employees where salary >= 10000 and manager_id = 100;
--Q. department_id�� 100���� ���� ��� ������ ������ ���ϼ���
select last_name, department_id, salary from employees where department_id < 100;
--Q. department_id�� 101, 103�� ������ job_id�� ���ϼ���
select last_name, manager_id, job_id from employees where manager_id = 101 or manager_id = 103;

--join
select * from employees;
select * from departments;
select * from jobs;
--Q. �����ȣ�� 110�� ����� �μ���
SELECT e.last_name, d.department_name
FROM employees e
join departments d on d.department_id(+) = e.department_id
where employee_id = 110;

SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE d.department_id(+) = e.department_id and employee_id = 110;

--Q. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���
select e.employee_id, e.last_name, e.job_id, j.job_title
from employees e, jobs j
where e.job_id(+) = j.job_id and e.employee_id = 120;


--Q. 100�� �μ��� ������ ����� �޿����� �� ���� �޿��� �޴� ����� ���
select e.last_name, e.salary from employees e
where e.salary > (select max(salary) from employees where department_id = 100);

select e.last_name, e.salary from employees e
where e.salary > all (select salary from employees where department_id = 100);

--Q. ���, �̸�, department_name, job_title(employees, departments, jobs)
select e.employee_id, e.last_name, d.department_name, j.job_title
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id;

select * from employees;

--self join �ϳ��� ���̺��� �� ���� ���̺��� ��ó�� ����
select e.employee_id ���, e.last_name �μ���, m.last_name �̵���, m.manager_id �Ŵ����ڵ�
from employees e, employees m
where e.employee_id = m.manager_id
order by e.employee_id;

--outer join ���� ���ǿ� �������� ���ϴ��� �ش� ���� ��Ÿ���� ���� �� ���
select e.employee_id ���, e.last_name �̸�, m.last_name, m.manager_id
from employees e, employees m
where e.employee_id = m.manager_id(+)
order by e.employee_id;

select e.employee_id ���, e.last_name �̸�, m.last_name, m.manager_id
from employees e, employees m
where e.employee_id(+) = m.manager_id
order by m.manager_id;



--[����] 2005�� ���Ŀ� �Ի��� ������ ���, �̸�, �Ի���, �μ���(d.name), ������(j.title)�� ���
select e.employee_id, e.last_name, e.hire_date, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id = j.job_id
and e.hire_date >= '2005/01/01';

select e.employee_id, e.last_name, e.hire_date, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id = j.job_id
and datepart(year,e.hire_date) >= 2005;

--[����] job_title, department_name�� ��� ������ ���� �� ���
select j.job_title, d.department_name, round(avg(salary)) ��տ���
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id = j.job_id
group by j.job_title, d.department_name;
--[����] ��պ��� ���� �޿��� �޴� ���� �˻� �� ���
select * from employees where salary > (select avg(salary) from employees);
--[����] last_name�� King�� ������ last_name, hire_date, department_id�� ���
select last_name, hire_date, department_id
from employees where last_name = 'King';
--[����] ���, �̸�, ������ ��� ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�'
--salary > 10000 then '����'
--salary > 5000 then '�븮'
select employee_id, last_name,
case
    when salary > 20000 then '��ǥ�̻�'
    when salary > 15000 then '�̻�'
    when salary > 10000 then '����'
    when salary > 5000 then '�븮'
    else '���'
end as ����
from employees;

--ESCAPE
SELECT * FROM employees WHERE job_id like '%\_A%' escape '\';
SELECT * FROM employees WHERE job_id like '%#_A%' escape '#';

--IN : OR ��� ���
SELECT * FROM employees WHERE manager_id=101 or manager_id=102 or manager_id=103;
SELECT * FROM employees WHERE manager_id IN(101,102,103);

--BETWEEN AND : ����
SELECT * FROM employees WHERE manager_id BETWEEN 101 AND 103;

--IS NULL / IS NOT NULL
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

--[�ֿ� �Լ�]
--MOD
SELECT * FROM employees WHERE MOD(employee_id,2)=1;
SELECT MOD(10,3) FROM dual;

--ROUND()
SELECT ROUND(355.95555) FROM dual;
SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

--TRUNC()
SELECT TRUNC(45.5555,1) FROM dual;
SELECT last_name, TRUNC(salary/12,2) FROM employees;

--��¥ ���� �Լ�
SELECT SYSDATE FROM dual;
SELECT SYSDATE + 1 FROM dual;
SELECT last_name, TRUNC((SYSDATE - hire_date)/365)�ټӿ��� FROM employees;
SELECT last_name, hire_date, ADD_MONTHS(hire_date, 6) FROM employees;
SELECT LAST_DAY(sysdate) - sysdate FROM dual;
SELECT hire_date, NEXT_DAY(hire_date,'��') FROM employees;
SELECT sysdate, NEXT_DAY(sysdate,'��') FROM dual;

--MONTHS_BETWEEN()
SELECT last_name, SYSDATE,hire_date, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) FROM employees;

--����ȯ �Լ�
--number character date
--to_date() ���ڿ��� ��¥��
--to_number, to_char, to_date
SELECT last_name, months_between('2012/12/31',hire_date) FROM employees;
SELECT trunc(sysdate - to_date('2014/01/01')) FROM dual;
SELECT TRUNC(SYSDATE - TO_DATE('20140101')) FROM dual;
SELECT TRUNC(SYSDATE - TO_DATE('140101')) FROM dual;

--Q. employees ���̺� �ִ� ������(���, �̸� ��������)�� ���Ͽ� ����������� �ټӿ����� ���ϼ���.
SELECT * FROM employees;
SELECT employee_id, last_name,TRUNC(((to_date('2022/02/21') - hire_date)/365))�ټӿ��� FROM employees;

SELECT TO_DATE('20210101'),
TO_CHAR(TO_DATE('20210101'),'MonthDD YYYY','NLS_DATE_LANGUAGE=ENGLISH') format1 FROM dual;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(SYSDATE, 'yy/mm/dd') FROM dual;
SELECT TO_CHAR(SYSDATE, 'yyyy-MM-DD') FROM dual;
SELECT TO_CHAR(SYSDATE, 'hh24:mi:ss') FROM dual;
SELECT TO_CHAR(SYSDATE, 'day') FROM dual;
SELECT TO_CHAR(SYSDATE, 'day','NLS_DATE_LANGUAGE=ENGLISH') FROM dual;

--TO_CHAR
--9 ���ڸ��� ����ǥ��
--0 �պκ��� 0���� ǥ��
--$ �޷� ��ȣ�� �տ� ǥ��
--. �Ҽ����� ǥ��
--, Ư�� ��ġ�� ǥ��
--MI �����ʿ� ? ��ȣ ǥ��
--PR �������� <>���� ǥ��
--EEEE ������ ǥ��
--L ������ȭ
SELECT salary, TO_CHAR(salary,'0999999') FROM employees;
SELECT TO_CHAR(-salary, '999999PR') FROM employees;
SELECT TO_CHAR(1111,'99.99EEEE') FROM dual;
SELECT TO_CHAR(1111,'B9999.99') FROM dual;
SELECT TO_CHAR(1111,'L99999') FROM dual;

--WIDTH_BUCKET() ������, �ּҰ�, �ִ밪, BUCKET ����
SELECT WIDTH_BUCKET(95,0,100,10) FROM dual;
SELECT department_id, last_name, salary, WIDTH_BUCKET(salary,0,20000,5) FROM employees WHERE department_id=50;

--[����] employees ���̺��� employee_id, last_name, salary, hire_date �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ�������
--�߰��� �� ����ϼ���. 2001�� 1�� 1�� â���Ͽ� ����(2020�� 12�� 31��) ���� 20�Ⱓ ��Ǿ�� ȸ���� ������ �ټӿ����� ����
--30������� ������ ��޿� ���� 1000���� bonus�� ����(bonus ���� �������� ����)
SELECT employee_id, last_name, salary, hire_date,
TRUNC(((to_date('20201231') - hire_date)/365))�ټӿ���,
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30)) ���ʽ����,
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30))*1000 bonus
FROM employees
ORDER BY bonus DESC;

--�����Լ�
select upper('Hello World') from dual;
select lower('Hello World') from dual;
select last_name, salary from employees where lower(last_name) = 'seo';
--ù���ڴ� �빮��, ������ �ҹ��� (����� ���ĺ� ����)
select initcap(job_id) from employees;
select job_id, length(job_id) from employees;
-- �˻���,ã������,������ġ,ã������ �� ���°
select INSTR('Hello World','o',3,2) from dual;
-- ������ġ���� 3�� �̱�
select SUBSTR('Hello World',3,3) from dual;
-- ������ġ���� 
select SUBSTR('Hello World',-3,3) from dual;
-- �˻���, ��ü�ڸ���, ��ĭ�� ���ʺ��� #����.
select LPAD('Hello World',20,'#') from dual;
-- ������
select RPAD('Hello World',20,'#') from dual;
-- Ư������ ���� ���ʸ�
select LTRIM('aaaHello Worldaaa','a') from dual;
-- Ư������ ���� �����ʸ�
select RTRIM('aaaHello Worldaaa','a') from dual;
--��Ÿ�Լ�
SELECT salary, commission_pct, salary*12*NVL(commission_pct,0) FROM employees;

SELECT last_name, department_id,
CASE WHEN department_id=90 THEN '�濵������'
WHEN department_id =60 THEN '���α׷���'
WHEN department_id = 100 THEN '�λ��'
END AS �Ҽ�
FROM employees;

--�м��Լ� : ���� ���� ������ ������ ���� ����� return �� �� ������ ó�� ����� �Ǵ� ���� ������ window��� ��Ī
--FIRST_VALUE() OVER() �׷��� ù��° ���� ���Ѵ�.
SELECT first_name �̸�, salary ����,
FIRST_VALUE(salary) OVER(ORDER BY salary DESC) �ְ���
FROM employees;

SELECT first_name �̸�, salary ����,
FIRST_VALUE(salary) OVER(ORDER BY salary DESC ROWS 3 PRECEDING) �ְ���
FROM employees;

--Q. 3�� ���� �������� ��������
SELECT first_name �̸�, salary ����,
FIRST_VALUE(salary) OVER(ORDER BY salary ROWS 3 PRECEDING) ��������
FROM employees;

SELECT first_name �̸�, salary ����,
LAST_VALUE(salary) OVER(ORDER BY salary desc ROWS 4 PRECEDING) ��������
FROM employees;

SELECT first_name �̸�, salary ����,
LAST_VALUE(salary) OVER(ORDER BY salary desc) ��������
FROM employees;

--Q. ���Ʒ� ���� 2�� ���� �� ������ ��
SELECT first_name �̸�, salary ����,
LAST_VALUE(salary) OVER(ORDER BY salary DESC ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) ��������
FROM employees;
SELECT first_name �̸�, salary ����
FROM employees where first_name = 'Steven';
--[����] employees ���̺��� department_id=50�� ������ ������ �������� �����Ͽ� ���� ī��Ʈ�� ����ϼ���.
SELECT department_id, last_name, salary, COUNT(*) over(order by salary desc) 
FROM employees
WHERE department_id=50;
--[����] employees ���̺��� department_id�� �������� �������� �����ϰ� ������ ���� ���� �հ踦 ����ϼ���.
SELECT department_id, last_name, salary, SUM(salary) OVER(PARTITION BY department_id 
ORDER BY department_id asc) FROM employees;
SELECT department_id, last_name, salary, SUM(salary) OVER( 
ORDER BY department_id asc) FROM employees;
--[����] employees ���̺��� department_id(�μ�)�� ���� ���������� ����ϼ���. 
SELECT first_name, department_id �μ�, salary ����,
RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) �μ���������
FROM employees;

SELECT first_name, department_id �μ�, salary ����,
RANK() OVER(ORDER BY salary DESC) ��������
FROM employees;