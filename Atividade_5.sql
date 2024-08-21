create schema atividade_5;
use atividade_5;

CREATE TABLE medico (
  CRM integer PRIMARY key,
  nome varchar (30),
  especialidade varchar(20),
  salario double (7,2)
);
CREATE TABLE tipo_paciente (
  id integer PRIMARY key,
  descricao varchar (30)
);
CREATE TABLE paciente (
  codigo integer PRIMARY key,
  nome varchar (30),
  cidade varchar (50),
  idade integer,
  crm_responsavel integer,
  id_tipoPaciente INTEGER,
  FOREIGN key (crm_responsavel) REFERENCES medico (CRM),
  FOREIGN key (id_tipoPaciente) REFERENCES tipo_paciente (id)
);
CREATE TABLE quarto (
  numero integer PRIMARY key,
  andar integer,
  cod_paciente integer,
  FOREIGN key (cod_paciente) REFERENCES paciente (codigo)
);

INSERT INTO medico VALUES
(123,'Maria Fernandes','Endocrinologista',7625.98),
(726,'Carolina Silva',null,4151.98),
(918,'Carlos Bezerra Salgueiro','Cardiologista',8172.98),
(162,'Adriana Santos','Pediatra',8273.12),
(362,'Jasmine Mendes','Cardiologista',3817.92),
(638,'Helena Fagundes',null,11827.01);


INSERT INTO tipo_paciente VALUES
(1,'Cardíaco'),(2,'Diabético'),(3,'Hipertenso'),(4,'Diabético e hipertenso'),(5,'Traumatismo');


INSERT INTO paciente VALUES
(1,'Vera Lucia','Recife',35,123,2),
(2,'Simone Vasques','Cabo',65,726,1),
(3,'Pedro Rangel','Jaboatão',40,123,3),
(4,'Marília Mendonça','Recife',25,362,4),
(5,'Xico Xavier',null,20,726,4),
(6,'Valeska Cibele','Cabo',10,null,2),
(7,'Carla Ribeiro','Jaboatão',13,162,3),
(8,'Jaque Feitosa',null,14,162,4),
(9,'Lua Burgos','Jaboatão',71,918,1),
(10,'Jessica Andrade','Jaboatão',22,null,null),
(11,'Linda Torres','Cabo',8,638,null);


INSERT INTO quarto VALUES
(101,1,2),(102,1,null),(103,1,null),(104,1,3),(201,2,4),
(301,3,1),(401,4,5),(302,3,2),(202,2,11), (501,5,null);

-- 1 
select descricao  from tipo_paciente;
select paciente.nome, tipo_paciente.id ,tipo_paciente.descricao from paciente, tipo_paciente order by id,nome,descricao;

-- 2

select * from quarto;

select andar, count(*) - count(cod_paciente) as "Qtde. quartos disponiveis" from quarto group by andar order by andar;

-- 3 

select 
quarto.numero as "Numero do Quarto",
paciente.nome as "Nome dos Paciente",
tipo_paciente.descricao as "Descrição do Tipo do Paciente",
medico.nome "Nome do médico" 
from quarto
LEFT JOIN paciente ON quarto.cod_paciente = paciente.codigo
LEFT JOIN tipo_paciente ON paciente.id_tipoPaciente = tipo_paciente.id
LEFT JOIN medico ON paciente.crm_responsavel = medico.CRM
order by quarto.numero;

-- 4

select 
	tipo_paciente.descricao as "Descrição do Tipo",
	count(paciente.codigo) as "Quantidade de Paciente"
from 
	tipo_paciente
left join 
	paciente  on tipo_paciente.id = paciente.id_tipoPaciente
group by 
	tipo_paciente.descricao
having 
	count(paciente.codigo) <=3
order by 
	tipo_paciente.descricao;

-- 5

select 
quarto.numero as "Numero do Quarto",
paciente.nome as "Nome dos Paciente",
tipo_paciente.descricao as "Descrição do Tipo do Paciente",
medico.nome "Nome do médico" 
from  quarto,paciente,tipo_paciente,medico;

select
medico.nome as "nome do medico",
count(quarto.numero) as "Quantidade de Quartos"
from medico
left join paciente on medico.CRM = paciente.crm_responsavel
left join quarto on paciente.codigo = quarto.cod_paciente
group by medico.nome
order by medico.nome;

-- 6

select
paciente.cidade as "cidades",
tipo_paciente.descricao as "tipo de paciente",
count(paciente.codigo) as "quantidade de pacientes",
Max(paciente.idade) as "maior idade"
from paciente
left join tipo_paciente on paciente.id_tipoPaciente = tipo_paciente.id
group by paciente.cidade,
tipo_paciente.descricao
order by paciente.cidade,
tipo_paciente.descricao;

-- finalizado



