--���������ʾ
set serveroutput on;

--��ϰ1��PLSQL֮HelloWorld
begin
	dbms_output.put_line('Hello,PLSQL.');
end;
/

--��ϰ2��������������ֵ
declare
	--������������ֵ
	a number(4):=3;
	b number(4):=5;
	--��������������ֵĬ��Ϊnull
	c number(4);
begin
	--����c=a+b
	c:=a+b;
	--���c
	dbms_output.put_line(c);
end;
/


--��ϰ3��ʹ��if�жϱ�����ֵ
declare
	sex varchar2(1):='M';
begin
	if sex='M' then
		dbms_output.put_line('��');
	elsif sex='F' then
		dbms_output.put_line('Ů');
	else
		dbms_output.put_line('����');
	end if;
end;
/


--��ϰ4���ۺ���ϰ
declare
	m number(4):=7;
	n number(4):=5;
	k number(4);
begin
	if m>n then
		k:=1;
	elsif m<n then
		k:=-1;
	else
		k:=0;
	end if;
	dbms_output.put_line(k);
end;
/


--��ϰ5��ʹ��loopѭ�����1-10
declare
	--����ѭ������
	i number(4):=1;
begin
	loop
		--����ѭ���߼����������
		dbms_output.put_line(i);
		--ѭ����������1
		i:=i+1;
		--�˳�ѭ��
		exit when i>10;
	end loop;
end;
/


--��ϰ6��ʹ��loopѭ����1�ۼӵ�100
declare
	--����ѭ������
	i number(4):=1;
	--�����ϼƱ���
	s number(6):=0;
begin
	loop
		s:=s+i; --�ۼ�
		i:=i+1; --��������
		exit when i>100; --�˳�
	end loop;
	dbms_output.put_line(s);
end;
/

--��ϰ7��ʹ��whileѭ�����1-10
declare
	i number(4):=1; --����ѭ������
begin
	while i<=10 loop --��������ʱѭ��
		dbms_output.put_line(i);
		i:=i+1; --��������
	end loop;
end;
/

--��ϰ8��ʹ��forѭ�����1-10
begin
	--1.��������i������Ĭ���Ǽ�����Ԫ������
	--2.������һ�����ּ���[1-10]
	for i in 1..10 loop
		dbms_output.put_line(i);
	end loop;
end;
/

--��ϰ9���Բ��ű���������ɾ���Ĳ���
begin
	--����һ������
	insert into dept values(4,'ddd','shenzhen');
	--�޸�һ������
	update dept set address='nanjing' where id=1;
	--ɾ��һ������
	delete from dept where id=2;
	commit;
end;
/

--��ϰ10������һ�ű���������һ������
begin
	--����Ա����
	execute immediate '
		create table employee(
			id number(4) primary key,
			name varchar2(100),
			salary number(9,2)
		)';
	--����һ������
	execute immediate '
		insert into employee values(1,''zs'',2000.00)';
	commit;
end;
/

--��ϰ11����ѯһ��dept����װ�����������
declare
	--������������ڷ�װ��ѯ���
	dept_id number(4);
	dept_name varchar2(100);
	dept_address varchar2(100);
begin
	--��ѯ���������װ��������
	select id,name,address
	into dept_id,dept_name,dept_address
	from dept where id=1;
	dbms_output.put_line('ID:'||dept_id);
	dbms_output.put_line('Name:'||dept_name);
	dbms_output.put_line('Address:'||dept_address);
end;
/

--��ϰ12���޸���ϰ11����������������Ϊ%type�ķ�ʽ
declare
	dept_id dept.id%type;
	dept_name dept.name%type;
	dept_address dept.address%type;
begin
	select id,name,address
	into dept_id,dept_name,dept_address
	from dept where id=1;
	dbms_output.put_line('ID:'||dept_id);
	dbms_output.put_line('Name:'||dept_name);
	dbms_output.put_line('Address:'||dept_address);
end;
/

--��ϰ13����ѯ����dept��ʹ���α���������
declare
	--�����α꣬��װ�˲�ѯ��������dept����
	cursor dept_cursor is
		select id,name from dept;
	--������������װÿһ�е��ֶ�ֵ
	dept_id dept.id%type;
	dept_name dept.name%type;
begin
	open dept_cursor; --�����α�
		loop
			--�ƶ��α�ָ�룬������ǰ���������ø�����
			fetch dept_cursor into dept_id,dept_name;
			--�жϴ˴��ƶ�ָ���Ƿ�����±�Խ��
			exit when dept_cursor%notfound;
			--���ûԽ�磬���˳����������
			dbms_output.put_line(dept_id||' '||dept_name);
		end loop;
	close dept_cursor; --�ر��α�
end;
/

--��ϰ14��ʹ��whileѭ�������α�
declare
	cursor dept_cursor is
		select id,name from dept;
	dept_id dept.id%type;
	dept_name dept.name%type;
begin
	open dept_cursor;
		fetch dept_cursor into dept_id,dept_name;
		while dept_cursor%found loop
			dbms_output.put_line(dept_id||' '||dept_name);
			fetch dept_cursor into dept_id,dept_name;
		end loop;
	close dept_cursor;
end;
/


--��ϰ15��ʹ��rowtype�����б���
declare
	--�α��з�װ�����ڱ����з�װ����Ҫһ��
	cursor dept_cursor is
		select * from dept;
	--�����б�������װһ��dept���ݣ�����dept�����ֶ�
	dept_row dept%type;
begin
	open dept_cursor;
		fetch dept_cursor into dept_row;
		while dept_cursor%found loop
			dbms_output.put_line(dept_row.id||' '||dept_row.name);
			fetch dept_cursor into dept_row;
		end loop;
	close dept_cursor;
end;
/

--��ϰ16��ʹ��forѭ�������α�
declare
	cursor dept_cursor is
		select * from dept;
begin
	--�����б�������ṹ���α��е�������һ�£�
	--������dept�Ľṹ��forѭ�����Զ��������ر��αꡣ
	for dept_row in dept_cursor loop
		dbms_output.put_line(dept_row.id||' '||dept_row.name);
	end loop;
end;
/