create table aluno (rm number(10), nome varchar2(20), cpf varchar2(11));

insert into aluno values(1,'Henry','1111111111');
insert into aluno values(6,'Karen','2222222222');
insert into aluno values(4,'Karina','3333333333');
insert into aluno values(2,'Paola','44444444444');
commit;

create or replace procedure prc_insere_aluno(
p_rm_aluno in aluno.rm%type,
p_nome_aluno in aluno.nome%type,
p_cpf_aluno in aluno.cpf%type) is
begin
insert into aluno(rm, nome, cpf)
values (p_rm_aluno, p_nome_aluno, p_cpf_aluno) ;
commit;
exception
when others then
raise_application_error( -20023, 'Erro crítico ! Insere Aluno ' || sqlerrm );
end;

create or replace procedure prc_insere_aluno(
p_nome_aluno in aluno.nome%type,
p_cpf_aluno in aluno.cpf%type,
p_rm_aluno out aluno.rm%type) is
begin
insert into aluno(rm, nome, cpf)
values (seq_aluno.nextval, p_nome_aluno, p_cpf_aluno)
returning rm into p_rm_aluno;
commit;
exception
when others then
raise_application_error( -20023, 'Erro crítico ! Insere Aluno ' || sqlerrm );
end prc_insere_aluno;

select seq_aluno.currval from dual;

show errors;

alter procedure prc_insere_aluno compile;

set serveroutput on
declare
    v_rm number;
begin
    prc_insere_aluno('Roberto','6999999', v_rm);
    dbms_output.put_line('Valor do RM =>  ' || v_rm);
end;

desc prc_insere_aluno

execute prc_insere_aluno(9,'Julia','777777777');

execute prc_insere_aluno(p_nome_aluno=>'Andressa',p_cpf_aluno=>'6666666666', p_rm_aluno=>7);

create sequence seq_aluno start with 7 increment by 1 minvalue 1 nocache nocycle;

select * from aluno;

drop table aluno;