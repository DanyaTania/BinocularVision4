create table developers
(
    Id         int          not null,
    first_name varchar(45)  not null,
    last_name  varchar(45)  not null,
    email      varchar(255) not null
)
    comment 'разработчики: один разработчик может быть разработчиком нескольких приложений';

create index `PRIMARY KEY`
    on developers (Id);

create index idx_developer_email
    on developers (email);

create table httpaddresses
(
    Id       int auto_increment comment 'Id станции. Первичный синтетический ключ таблицы.'
        primary key,
    Web_shop varchar(60)  not null comment 'Локализация Web_shop, где находится приложени ( https://play.google.com/store/apps )',
    Location varchar(115) not null comment 'Название локализации где находится приложени (например, details?id=com.treatment.binocularvision.way). Альтернативный/ уникальный ключ таблицы.',
    constraint Location_UNIQUE
        unique (Location)
)
    comment 'Таблица интернет-ссылок на  приложения. Содержит локализацию приложения и id этой локализации (полный url= https://play.google.com/+
store/apps/details?id= +
com.treatment.binocularvision.way
). ';

create table roles
(
    Id   int auto_increment comment 'Id роли. Первичный синтетический ключ таблицы.'
        primary key,
    Role varchar(20) not null comment 'Тип роли.'
)
    comment 'Таблица ролей пользователя. Администратор, обычный пользователь и т.д.';

create table types
(
    Id             int auto_increment comment 'Id категории велосипеда. Первичный синтетический ключ таблицы.'
        primary key,
    Type           varchar(20)   not null comment 'Описание типа  приложения - платформер, шутер, квест и т.д.',
    Price_Per_Hour decimal(4, 2) not null,
    Image          blob          not null
)
    comment 'Таблица Типов приложений. К примеру: платформер, шутер, квест.';

create table apps
(
    Id               int auto_increment comment 'Id велосипеда. Первичный синтетический ключ таблицы.'
        primary key,
    Title            varchar(100)      not null,
    In_Rent          tinyint default 0 not null comment 'Состояние велосипеда - арендован/не арендован.',
    Is_Available     tinyint default 1 not null,
    Types_Id         int               not null comment 'Внешний ключ таблицы для связи с таблицей Типы Приложений.',
    HttpAddresses_Id int               not null comment 'Внешний ключ таблицы для связи с таблицей Http_addreses Приложений.',
    last_apdate      timestamp         null,
    description      text              null,
    http_image1      varchar(255)      null,
    http_image2      varchar(255)      null,
    http_image3      varchar(255)      null,
    constraint fk_Apps_HttpAddresses1
        foreign key (HttpAddresses_Id) references httpaddresses (Id),
    constraint fk_Apps_Types1
        foreign key (Types_Id) references types (Id)
)
    comment 'Таблица Приложений-тренажеров. Основной элемент программы. Связана связями многие ко многим с таблицей Пользователи.';

create table app_developers
(
    developers_Id int       not null,
    apps_Id       int       not null,
    last_update   timestamp not null,
    primary key (developers_Id, apps_Id),
    constraint fk_app_developers_apps1
        foreign key (apps_Id) references apps (Id),
    constraint fk_app_developers_developers1
        foreign key (developers_Id) references developers (Id)
)
    comment 'разработчики именно тех приложений, которые в базе - для одного приложения может быть несколько разработчиков';

create index fk_Apps_HttpAddresses1_idx
    on apps (HttpAddresses_Id);

create index fk_Apps_Types1_idx
    on apps (Types_Id);

create table users
(
    Id          int auto_increment comment 'Поле id пользователя. Первичный синтетический ключ таблицы. ',
    Login       varchar(10)   not null comment 'Логин пользователя для входа в систему. Также является альтернативным ключом или уникальным индексом.',
    Password    varchar(32)   not null comment 'Пароль пользователя для входа в систему.',
    First_Name  varchar(15)   not null comment 'Имя пользователя.',
    Last_Name   varchar(15)   not null comment 'Фамилия пользователя.',
    Balance     decimal(6, 2) not null comment 'Кол-во денег на счету пользователя. Ограничено типом Decimal(6,2) до 9999,99 рублей.',
    Roles_Id    int default 2 not null,
    Create_time datetime      not null comment '
',
    primary key (Id, Roles_Id),
    constraint Login_UNIQUE
        unique (Login),
    constraint fk_users_roles1
        foreign key (Roles_Id) references roles (Id)
)
    comment 'Таблица Пользователей. Содержит информацию о пользователе. Дополнительный уникальный индекс - поле Login.';

create table offers
(
    Id          int      not null,
    Description tinytext not null,
    apps_Id     int      not null,
    primary key (Id, apps_Id),
    constraint fk_Offers_apps1
        foreign key (apps_Id) references apps (Id),
    constraint fk_offers_users1
        foreign key (Id) references users (Id)
)
    comment 'предложения по усовершенствованию приложений: у одного приложения может быть несколько  предложений, на основании их могут разрабатываться карты модернизации';

create index fk_Offers_apps1_idx
    on offers (apps_Id);

create table orders
(
    Id         int auto_increment
        primary key,
    Start_Date datetime                   not null comment 'Дата когда пользователь вошел в приложение (начал пользоваться сервисом по ссылке).',
    End_Date   datetime                   null comment 'Дата когда пользователь перестал тренироваться (пользоваться сервисом по ссылке).',
    Value      decimal(4, 2) default 0.00 not null comment 'Коэффициент скидки для пользователя. По умолчанию 1. Может уменьшаться адмнистратором елси пользователь часто пользуется сервисом. Ограничено типом Decimal(2,1) до одного дробного значения (0,9 или 0,5).',
    Users_Id   int                        not null,
    Apps_Id    int                        not null,
    constraint fk_Orders_Apps1
        foreign key (Apps_Id) references apps (Id),
    constraint fk_Orders_Users1
        foreign key (Users_Id) references users (Id)
)
    comment 'Таблица связи многие ко многим для таблиц Пользователи и Приложения. Отображает, в  каком приложении  пользователь тренировался.';

create index fk_Orders_Apps1_idx
    on orders (Apps_Id);

create index fk_Orders_Users1_idx
    on orders (Users_Id);

create index fk_users_roles1_idx
    on users (Roles_Id);

