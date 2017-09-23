--��ϰ1���洢����֮HelloWorld
create or replace procedure hello_proc
is
	vcount number(4);
begin
	select count(*) into vcount from emp;
	dbms_output.put_line(vcount);
end;
/

call hello_proc();

--��ϰ2����ѯָ������ε�Ա��н�ʺϼ�
create or replace procedure sum_salary_proc
(vage number)
is
	vsumsalary emp.salary%type;
begin
	--ʹ�ò�����ѯ��ǰ����ε�н�ʺϼ�
	select sum(salary) into vsumsalary
	from emp where age=vage;
	dbms_output.put_line(vsumsalary);
end;
/

--��ϰ3������Ա��ID���Ա������н��
create or replace procedure show_emp_proc
(vid number)
is
	emp_row emp%rowtype;
begin
	select * into emp_row
	from emp where id=vid;
	dbms_output.put_line(emp_row.name);
	dbms_output.put_line(emp_row.salary);
end;
/

--��ϰ4������2��������������ϼ�ֵ�Ͳ�ֵ
create or replace procedure sum_sub
(m number,n number,vsum out number,vsub out number)
is
begin
	--����ϼ�ֵ
	vsum:=m+n;
	--�����ֵ
	vsub:=m-n;
end;
/

declare
  vsum number(6);
  vsub number(6);
begin
  --�������е��ô洢���̲���дcall
  sum_sub(8,6,vsum,vsub);
  --�������
  dbms_output.put_line(vsum||' '||vsub);
end;
/

--��ϰ5������ʱ�������Զ�ͬ����service��
create or replace procedure service_bak_proc
is
	cursor bak_cursor is
		select * from service_update_bak 
		where id in (
			select max(id) from service_update_bak
			group by service_id);
begin
	for bak_row in bak_cursor loop
		--�����ݱ�����ͬ����service
		update service set cost_id=bak_row.cost_id
		where id=bak_row.service_id;
	end loop;
	--ɾ�����ݱ�����
	delete from service_update_bak;
	commit;
end;
/

--��ϰ6��ɽկsign����
create or replace function mysign
(n number) return number is
begin
	if n>0 then
		return 1;
	elsif n<0 then
		return -1;
	else
		return 0;
	end if;
end;
/

--��ϰ7���Ƚ�2��Ա��н�ʸߵ�
--���a����b����1��a����b����-1��һ������0
create or replace function compare_salary
(emp_id1 number,emp_id2 number)
return number
is
	vsalary1 emp.salary%type;
	vsalary2 emp.salary%type;
begin
	--��ѯԱ��1��н��
	select salary into vsalary1 from emp 
	where id=emp_id1;
	--��ѯԱ��2��н��
	select salary into vsalary2 from emp
	where id=emp_id2;
	--�Ƚ�2��Ա����н��
	if vsalary1>vsalary2 then
		return 1;
	elsif vsalary1<vsalary2 then
		return -1;
	else
		return 0;
	end if;
end;
/

--��ϰ8������Ա�����䣬ͳ����н�ʺϼ�
create or replace function sum_salary
(vage number)
return number
is
	vsumsalary emp.salary%type;
begin
	select sum(salary) into vsumsalary
	from emp where age=vage;
	return vsumsalary;
end;
/

--��ϰ9������2�����ֵĺͣ�����������������
create or replace function add_num 
(m in out number,n in out number)
return number
is 
begin
	--���mΪnull������1����
	if m is null then
		m:=1;
	end if;
	--���nΪnull������1����
	if n is null then
		n:=1;
	end if;
	return m+n;
end;
/

declare 
	m number(4):=3;
	n number(4);
	s number(4);
begin
	--������������ú��������غϼ�ֵ
	s:=add_num(m,n);
	--m,nҲ���Է���
	dbms_output.put_line(m);
	dbms_output.put_line(n);
	dbms_output.put_line(s);
end;
/


--��ϰ10���ڽ����κ���ɾ�Ĳ����󣬼����
--Ա������Ա��н�ʺϼơ�Ա��ƽ�����ʡ�
create or replace trigger emp_trigger
after insert or update or delete on emp
declare
	vcount number(7);
	vsum number(7);
	vavg number(7);
begin
	--ͳ��Ա����
	select count(*) into vcount from emp;
	--ͳ�ƹ��ʺϼ�
	select sum(salary) into vsum from emp;
	--ͳ��ƽ������
	select avg(salary) into vavg from emp;
	dbms_output.put_line(vcount);
	dbms_output.put_line(vsum);
	dbms_output.put_line(vavg);
end;
/


--��ϰ11��ɾ��emp֮ǰ����ɾ����¼���뱸�ݱ�
create or replace trigger emp_bak_trigger
before delete on emp for each row
declare
begin
	--ͨ���б�����ȡ���ݣ�������뱸�ݱ�
	insert into emp_bak values(:old.id,:old.name);
end;
/


--��ϰ12��ʹ��too_many_rowsԤ�����쳣
declare
	vsalary emp.salary%type;
begin
	select salary into vsalary from emp;
	exception
		when too_many_rows then
		dbms_output.put_line('��¼���.');
end;
/