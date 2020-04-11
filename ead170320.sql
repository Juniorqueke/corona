create table virus (
id int not null primary key auto_increment,
nome varchar(80) not null,
existeVacina boolean not null
)engine = InnoDB;

create table sintoma (
id int not null primary key auto_increment,
descricao varchar (150) not null
)engine = InnoDB;

create table virusVsSintoma (
virus int not null ,
sintoma int not null ,
constraint  pk_virus primary key (virus,sintoma),
constraint fk_virus_sintomaVirus foreign key (virus) references virus (id),
constraint fk_sintoma_sintomaVirus foreign key (sintoma) references sintoma (id)
) engine = InnoDB;

insert into virus (nome,existeVacina) values ('Gripe',true), 
('Dengue',true),
('Corona',false);

insert into sintoma values (1,'Febre alta'),
(2,'Dor de cabeça'),
(3,'Dor no corpo'),
(4,'Tosse'),
(5,'Dificuldade de respirar' );

insert into virusVsSintoma values (1,1),(1,2),(1,3),(1,4),(2,1),(2,2),(3,1),(3,4),(3,5);
select * from virusVsSintoma;

delimiter $$
create function fn_getCura (idvirus int)
returns boolean
begin
	declare virus boolean;
    select existeVacina into virus  from virus where id = virus;
return virus;
 end $$
 delimiter ;

delimiter $$
create function fn_existeVacina (virus int)
returns boolean
begin 
declare  €situacaoVacina boolean;
select existeVacina into €situacaoVacina from virus where id = virus;
return €situacaoVacina;
end $$
delimiter ;
 
create view vw_vacinaSintoma as 
select virus.id,virus.nome, sintoma.descricao from  virusVsSintoma
inner join virus on virus.id = virusVsSintoma.virus 
inner join sintoma on sintoma.id = virusVsSintoma.sintoma;
select * from vw_vacinaSintoma;