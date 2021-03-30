prompt PL/SQL Developer Export User Objects for user HEYDAR86@ORCL
prompt Created by hd_ei on سه شنبه, 30 مارس 2021
set define off
spool heydar_project.log

prompt
prompt Creating table BILL
prompt ===================
prompt
create table HEYDAR86.BILL
(
  bill_id                     NUMBER default "HEYDAR86"."PK_BILL"."NEXTVAL" not null,
  sub_id                      NUMBER not null,
  sub_name                    VARCHAR2(60) not null,
  sub_phone                   CHAR(11) not null,
  tracking_code               NUMBER default "HEYDAR86"."BILL_TRACKING"."NEXTVAL" not null,
  start_date                  DATE not null,
  end_date                    DATE not null,
  count_of_trans_by_credit    NUMBER not null,
  cost_of_trans_by_credit     NUMBER(7) not null,
  count_of_trans_by_package   NUMBER not null,
  cost_of_trans_by_package    NUMBER(7) not null,
  total_count_of_trans        NUMBER not null,
  total_cost_of_trans         NUMBER(7) not null,
  cost_of_package             NUMBER(7) not null,
  count_of_activation_package NUMBER(2) not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.BILL
  add primary key (BILL_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table BILLING_DETAIL
prompt =============================
prompt
create table HEYDAR86.BILLING_DETAIL
(
  bill_detail_id            NUMBER default "HEYDAR86"."PK_BILL_DT"."NEXTVAL" not null,
  bill_id                   NUMBER not null,
  service_name              VARCHAR2(20),
  count_of_trans_by_credit  NUMBER not null,
  cost_of_trans_by_credit   NUMBER(7) not null,
  count_of_trans_by_package NUMBER not null,
  total_count_of_trans      NUMBER not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.BILLING_DETAIL
  add primary key (BILL_DETAIL_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.BILLING_DETAIL
  add constraint FK_BILL_ID foreign key (BILL_ID)
  references HEYDAR86.BILL (BILL_ID);

prompt
prompt Creating table LOOK_UP
prompt ======================
prompt
create table HEYDAR86.LOOK_UP
(
  look_up_id          NUMBER(3) not null,
  look_up_code        VARCHAR2(25) not null,
  look_up_description VARCHAR2(50) not null,
  title               CHAR(4)
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HEYDAR86.LOOK_UP
  add primary key (LOOK_UP_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HEYDAR86.LOOK_UP
  add constraint UNIGE_TITLE unique (TITLE)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SUBSCRIBER
prompt =========================
prompt
create table HEYDAR86.SUBSCRIBER
(
  sub_id       NUMBER default "HEYDAR86"."PK_SUB"."NEXTVAL" not null,
  first_name   VARCHAR2(30) not null,
  last_name    VARCHAR2(30) not null,
  national_id  CHAR(10) not null,
  gender       CHAR(4) not null,
  dob          DATE not null,
  phone_number CHAR(11) not null,
  reg_datetime DATE,
  is_active    CHAR(4) not null,
  address      VARCHAR2(252)
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HEYDAR86.SUBSCRIBER
  add primary key (SUB_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HEYDAR86.SUBSCRIBER
  add constraint UNIQ_NATIONA unique (NATIONAL_ID, PHONE_NUMBER)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HEYDAR86.SUBSCRIBER
  add constraint FK_LOOKUP_SUBSCRIBER_GENDER foreign key (GENDER)
  references HEYDAR86.LOOK_UP (TITLE);
alter table HEYDAR86.SUBSCRIBER
  add constraint FK_LOOKUP_SUBSCRIBER_ISACTIVE foreign key (IS_ACTIVE)
  references HEYDAR86.LOOK_UP (TITLE);

prompt
prompt Creating table CREDIT
prompt =====================
prompt
create table HEYDAR86.CREDIT
(
  credit_id            NUMBER default "HEYDAR86"."PK_CRED"."NEXTVAL" not null,
  sub_id               NUMBER not null,
  amount_of_credit     NUMBER(9) not null,
  allowed_limit        NUMBER(8),
  expiration_of_credit DATE,
  sim_type             NUMBER(1)
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.CREDIT
  add primary key (CREDIT_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.CREDIT
  add constraint FK_CRED_SUB_ID foreign key (SUB_ID)
  references HEYDAR86.SUBSCRIBER (SUB_ID);

prompt
prompt Creating table CREDIT_INCREMENT_HISTORY
prompt =======================================
prompt
create table HEYDAR86.CREDIT_INCREMENT_HISTORY
(
  cred_his_id      NUMBER default "HEYDAR86"."PK_CRED_HIST"."NEXTVAL" not null,
  credit_id        NUMBER not null,
  amount_of_credit NUMBER(9) not null,
  update_date      DATE,
  sim_type         NUMBER
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.CREDIT_INCREMENT_HISTORY
  add primary key (CRED_HIS_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.CREDIT_INCREMENT_HISTORY
  add constraint FK_CREDHIS_CRED_ID foreign key (CREDIT_ID)
  references HEYDAR86.CREDIT (CREDIT_ID);

prompt
prompt Creating table NOTIFICATION
prompt ===========================
prompt
create table HEYDAR86.NOTIFICATION
(
  notif_id     NUMBER(2) default "HEYDAR86"."PK_NOTF"."NEXTVAL" not null,
  notification VARCHAR2(200)
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.NOTIFICATION
  add primary key (NOTIF_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table SERVICE
prompt ======================
prompt
create table HEYDAR86.SERVICE
(
  service_id           NUMBER default "HEYDAR86"."PK_SERV"."NEXTVAL" not null,
  service_name         VARCHAR2(20) not null,
  service_for_sim_type CHAR(4) not null,
  is_active            CHAR(4) not null,
  reg_datetime         DATE,
  tariff_default       NUMBER(5,2)
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.SERVICE
  add primary key (SERVICE_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.SERVICE
  add constraint FK_LOOKUP_SERVICE_ISACTIVE foreign key (IS_ACTIVE)
  references HEYDAR86.LOOK_UP (TITLE);

prompt
prompt Creating table PACKAGE_OF_SERVICE
prompt =================================
prompt
create table HEYDAR86.PACKAGE_OF_SERVICE
(
  pack_id              NUMBER default "HEYDAR86"."PK_PACK"."NEXTVAL" not null,
  service_id           NUMBER not null,
  package_name         VARCHAR2(25) not null,
  price                NUMBER(7) not null,
  is_active            CHAR(4) not null,
  package_for_sim_type CHAR(4),
  reg_datetime         DATE not null,
  expiration_duration  NUMBER(5),
  volume               NUMBER(10),
  detail               VARCHAR2(200) not null,
  package_type         CHAR(4)
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.PACKAGE_OF_SERVICE
  add primary key (PACK_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.PACKAGE_OF_SERVICE
  add constraint UNIQ_VOLME unique (VOLUME, EXPIRATION_DURATION, PACKAGE_TYPE)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.PACKAGE_OF_SERVICE
  add constraint FK_LOOKUP_PACKAGEOFSERVICE_ISACTIVE foreign key (IS_ACTIVE)
  references HEYDAR86.LOOK_UP (TITLE);
alter table HEYDAR86.PACKAGE_OF_SERVICE
  add constraint FK_LOOKUP_PACKAGEOFSERVICE_PACKAGETYPE foreign key (PACKAGE_TYPE)
  references HEYDAR86.LOOK_UP (TITLE);
alter table HEYDAR86.PACKAGE_OF_SERVICE
  add constraint FK_PACK_SERV_ID foreign key (SERVICE_ID)
  references HEYDAR86.SERVICE (SERVICE_ID);

prompt
prompt Creating table PACKAGE_ACTIVATION
prompt =================================
prompt
create table HEYDAR86.PACKAGE_ACTIVATION
(
  pack_act_id         NUMBER default "HEYDAR86"."PK_PACK_ACT"."NEXTVAL" not null,
  sub_id              NUMBER not null,
  pack_id             NUMBER not null,
  package_volume      NUMBER(10),
  activation_datetime DATE not null,
  still_valid         CHAR(4) default 'SV1' not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.PACKAGE_ACTIVATION
  add primary key (PACK_ACT_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.PACKAGE_ACTIVATION
  add constraint UNIQ_VOLUME unique (SUB_ID, PACK_ID, ACTIVATION_DATETIME)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.PACKAGE_ACTIVATION
  add constraint FKPACKACT_SUB_ID foreign key (SUB_ID)
  references HEYDAR86.SUBSCRIBER (SUB_ID);
alter table HEYDAR86.PACKAGE_ACTIVATION
  add constraint FK_LOOKUP_PACKAGEACT_ISACTIVE foreign key (STILL_VALID)
  references HEYDAR86.LOOK_UP (TITLE);
alter table HEYDAR86.PACKAGE_ACTIVATION
  add constraint FK_PACK_ID foreign key (PACK_ID)
  references HEYDAR86.PACKAGE_OF_SERVICE (PACK_ID);

prompt
prompt Creating table PACKAGE_HISTORY
prompt ==============================
prompt
create table HEYDAR86.PACKAGE_HISTORY
(
  pack_his_id         NUMBER default "HEYDAR86"."PK_PACK_HIST"."NEXTVAL" not null,
  pack_id             NUMBER not null,
  price               NUMBER(7) not null,
  expiration_duration NUMBER(5) not null,
  volume              NUMBER(10),
  is_active           CHAR(4) not null,
  update_date         DATE,
  detail              VARCHAR2(200) not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.PACKAGE_HISTORY
  add primary key (PACK_HIS_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.PACKAGE_HISTORY
  add constraint FK_LOOKUP_PACKAGEHIST_ISACTIVE foreign key (IS_ACTIVE)
  references HEYDAR86.LOOK_UP (TITLE);
alter table HEYDAR86.PACKAGE_HISTORY
  add constraint FK_PACKHIST_PACK_ID foreign key (PACK_ID)
  references HEYDAR86.PACKAGE_OF_SERVICE (PACK_ID);

prompt
prompt Creating table SERVICE_ACTIVATION
prompt =================================
prompt
create table HEYDAR86.SERVICE_ACTIVATION
(
  serv_act_id          NUMBER default "HEYDAR86"."PK_SERV_ACT"."NEXTVAL" not null,
  sub_id               NUMBER not null,
  activation_datetime  DATE not null,
  credit_check_service CHAR(4) not null,
  package_check        CHAR(4) not null,
  is_active            NUMBER(1) default 1 not null,
  support              CHAR(4) default 'Yes' not null,
  service_id           NUMBER not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.SERVICE_ACTIVATION
  add primary key (SERV_ACT_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.SERVICE_ACTIVATION
  add constraint UNIQ_SERV unique (SUB_ID, SERVICE_ID, ACTIVATION_DATETIME)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.SERVICE_ACTIVATION
  add constraint FK_SERVACT_SERV_ID foreign key (SERVICE_ID)
  references HEYDAR86.SERVICE (SERVICE_ID);
alter table HEYDAR86.SERVICE_ACTIVATION
  add constraint FK_SERVACT_SUB_ID foreign key (SUB_ID)
  references HEYDAR86.SUBSCRIBER (SUB_ID);

prompt
prompt Creating table SERVICE_HISTORY
prompt ==============================
prompt
create table HEYDAR86.SERVICE_HISTORY
(
  service_his_id NUMBER default "HEYDAR86"."PK_SERV_HIS"."NEXTVAL" not null,
  service_id     NUMBER not null,
  service_name   VARCHAR2(20) not null,
  is_active      CHAR(4),
  update_date    DATE not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.SERVICE_HISTORY
  add primary key (SERVICE_HIS_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.SERVICE_HISTORY
  add constraint FK_LOOKUP_SERVICEHISTORY_ISACTIVE foreign key (IS_ACTIVE)
  references HEYDAR86.LOOK_UP (TITLE);
alter table HEYDAR86.SERVICE_HISTORY
  add constraint FK_SERV_HIST foreign key (SERVICE_ID)
  references HEYDAR86.SERVICE (SERVICE_ID);

prompt
prompt Creating table SUBSCRIBER_HISTORY
prompt =================================
prompt
create table HEYDAR86.SUBSCRIBER_HISTORY
(
  sub_his_id  NUMBER default "HEYDAR86"."PK_SUB_HIS"."NEXTVAL" not null,
  sub_id      NUMBER not null,
  first_name  VARCHAR2(30) not null,
  last_name   VARCHAR2(30) not null,
  dob         DATE not null,
  is_active   CHAR(4) not null,
  update_date DATE not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.SUBSCRIBER_HISTORY
  add primary key (SUB_HIS_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.SUBSCRIBER_HISTORY
  add constraint FK_LOOKUP_SUBSCRIBERHISTORY_ISACTIVE foreign key (IS_ACTIVE)
  references HEYDAR86.LOOK_UP (TITLE);
alter table HEYDAR86.SUBSCRIBER_HISTORY
  add constraint FK_SUB_ID foreign key (SUB_ID)
  references HEYDAR86.SUBSCRIBER (SUB_ID);

prompt
prompt Creating table TARIFF
prompt =====================
prompt
create table HEYDAR86.TARIFF
(
  tariff_id    NUMBER default "HEYDAR86"."PK_TARIFF"."NEXTVAL" not null,
  service_id   NUMBER not null,
  tariff_price NUMBER(5,2) not null,
  eff_datetime DATE not null,
  reg_datetime DATE not null,
  is_active    CHAR(4) not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.TARIFF
  add primary key (TARIFF_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.TARIFF
  add constraint FK_LOOKUP_TTARIFF_ISACTIVE foreign key (IS_ACTIVE)
  references HEYDAR86.LOOK_UP (TITLE);
alter table HEYDAR86.TARIFF
  add constraint FK_SERVICE_TARIFF_SERVICEID foreign key (SERVICE_ID)
  references HEYDAR86.SERVICE (SERVICE_ID);

prompt
prompt Creating table TRANSACTION
prompt ==========================
prompt
create table HEYDAR86.TRANSACTION
(
  trans_id      NUMBER default "HEYDAR86"."PK_TRANS"."NEXTVAL" not null,
  sub_id        NUMBER not null,
  service_id    NUMBER not null,
  reg_datetime  DATE,
  tracking_code NUMBER default "HEYDAR86"."TRANS_TRACKING"."NEXTVAL" not null,
  bill_id       NUMBER not null
)
tablespace HEYDAR86
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HEYDAR86.TRANSACTION
  add primary key (TRANS_ID)
  using index 
  tablespace HEYDAR86
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HEYDAR86.TRANSACTION
  add constraint FK_TRANS_BILL_ID foreign key (BILL_ID)
  references HEYDAR86.BILL (BILL_ID);
alter table HEYDAR86.TRANSACTION
  add constraint FK_TRANS_PACK_ID foreign key (SERVICE_ID)
  references HEYDAR86.SERVICE (SERVICE_ID);
alter table HEYDAR86.TRANSACTION
  add constraint FK_TRANS_SUB_ID foreign key (SUB_ID)
  references HEYDAR86.SUBSCRIBER (SUB_ID);

prompt
prompt Creating sequence BILL_TRACKING
prompt ===============================
prompt
create sequence HEYDAR86.BILL_TRACKING
minvalue 10000000
maxvalue 9999999999999999999999999999
start with 10000200
increment by 1
cache 200;

prompt
prompt Creating sequence PK_BILL
prompt =========================
prompt
create sequence HEYDAR86.PK_BILL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_BILL_DT
prompt ============================
prompt
create sequence HEYDAR86.PK_BILL_DT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_CRED
prompt =========================
prompt
create sequence HEYDAR86.PK_CRED
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_CRED_HIST
prompt ==============================
prompt
create sequence HEYDAR86.PK_CRED_HIST
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_NOTF
prompt =========================
prompt
create sequence HEYDAR86.PK_NOTF
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_PACK
prompt =========================
prompt
create sequence HEYDAR86.PK_PACK
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_PACK_ACT
prompt =============================
prompt
create sequence HEYDAR86.PK_PACK_ACT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_PACK_HIST
prompt ==============================
prompt
create sequence HEYDAR86.PK_PACK_HIST
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_SERV
prompt =========================
prompt
create sequence HEYDAR86.PK_SERV
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_SERV_ACT
prompt =============================
prompt
create sequence HEYDAR86.PK_SERV_ACT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_SERV_HIS
prompt =============================
prompt
create sequence HEYDAR86.PK_SERV_HIS
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_SUB
prompt ========================
prompt
create sequence HEYDAR86.PK_SUB
minvalue 1
maxvalue 9999999999999999999999999999
start with 51
increment by 1
cache 50;

prompt
prompt Creating sequence PK_SUB_HIS
prompt ============================
prompt
create sequence HEYDAR86.PK_SUB_HIS
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_TARIFF
prompt ===========================
prompt
create sequence HEYDAR86.PK_TARIFF
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence PK_TRANS
prompt ==========================
prompt
create sequence HEYDAR86.PK_TRANS
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50;

prompt
prompt Creating sequence TRANS_TRACKING
prompt ================================
prompt
create sequence HEYDAR86.TRANS_TRACKING
minvalue 10000000
maxvalue 9999999999999999999999999999
start with 10000200
increment by 1
cache 200;

prompt
prompt Creating package PACKAGE_ACT_PACK
prompt =================================
prompt
create or replace package heydar86.package_act_pack is
  FUNCTION check_and_update_credit_for_activating_package(sub_id  subscriber.sub_id%TYPE,
                                                         pack_id package_activation.pack_id%TYPE)
  RETURN NUMBER ;

   procedure inserting_in_package_activation(sub_id           package_activation.sub_id%type,
                                              pack_id          package_activation.pack_id%type,
                                              force_hamrahaval number);
end package_act_pack;
/

prompt
prompt Creating package SERVICE_ACT_PACK
prompt =================================
prompt
CREATE OR REPLACE PACKAGE HEYDAR86.service_act_pack is
 procedure inserting_in_service_activation(sub_id subscriber.sub_id%type
                                           ,service_id  service.service_id%type
                                           ,force_hamrahaval number);

end service_act_pack;
/

prompt
prompt Creating package TRANSACTIONS_PACKAGE
prompt =====================================
prompt
create or replace package heydar86.transactions_package is
procedure insert_transactions(sub_id      number,
                              service_id  number,
                              bill_id     number);


end transactions_package;
/

prompt
prompt Creating function CHECK_AND_UPDATE_CREDIT_FOR_ACTIVATING_PACKAGE
prompt ================================================================
prompt
CREATE OR REPLACE FUNCTION HEYDAR86.check_and_update_credit_for_activating_package(sub_id  subscriber.sub_id%TYPE,
                                                                          pack_id package_activation.pack_id%TYPE)
  RETURN NUMBER IS
  amount_credit credit.amount_of_credit%TYPE;
  price         package_of_service.price%TYPE;
  status        NUMBER(1);
BEGIN

  select c.amount_of_credit
    into amount_credit
    from credit c
   where c.sub_id = sub_id;

  select ps.price
    into price
    from package_of_service ps
   where ps.pack_id = pack_id;

  IF amount_credit >= price THEN
    UPDATE credit c
       SET c.amount_of_credit =
           (c.amount_of_credit - price)
     WHERE c.sub_id = sub_id;
    status := 1;
  ELSE
    status := 0;
  END IF;

  RETURN status;
END;
/

prompt
prompt Creating function INSERTING_IN_PACKAGE_ACTIVATION
prompt =================================================
prompt
CREATE OR REPLACE FUNCTION HEYDAR86.inserting_in_package_activation(sub_id           package_activation.sub_id%type,
                                                           pack_id          package_activation.pack_id%type,
                                                           force_hamrahaval number)
  RETURN CHAR IS
  SIM_type            Credit.Sim_Type%TYPE;
  pack_for_SIM_type   package_of_service.package_for_sim_type%TYPE;
  activity            package_of_service.is_active%TYPE;
  FirstVolume         package_of_service.volume%TYPE;
  Expiration_duration package_of_service.expiration_duration%TYPE;
  Still_valid         package_activation.still_valid%TYPE;
BEGIN

  select c.SIM_Type into SIM_type from Credit c where c.sub_id = sub_id;

  SELECT ps.is_active
    INTO activity
    FROM Package_of_service ps
   WHERE ps.pack_id = pack_ID;

  SELECT ps.package_for_sim_type
    INTO pack_for_SIM_type
    FROM Package_of_service ps
   WHERE ps.pack_id = pack_ID;

  SELECT ps.volume, ps.expiration_duration
    INTO FirstVolume, Expiration_duration
    FROM Package_of_service ps
   WHERE ps.pack_id = pack_ID
     AND ps.package_for_sim_type = pack_for_SIM_type; -- baste mortabet be SIM card

  IF (SIM_type = 0 -- SIM card daemi
     AND (pack_for_SIM_type = 'PS01' OR pack_for_SIM_type = 'PS11')) -- basetye makhsoose SIM card daemi ya moshtarak beyne daemi va etebari
     OR (SIM_type = 1 -- -- SIM card etebari
     AND (pack_for_SIM_type = 'PS10' OR pack_for_SIM_type = 'PS11')) --  -- basteye makhsoose SIM card etebari ya moshtarak beyne daemi va etebari
   THEN
    IF activity = 'Yes' -- agar baste mojud bud
       AND
       check_and_update_credit_for_activating_package(sub_id, pack_id) = 1 --chon gharare sabt she az alan poolo begir, ya engar migim pool bede ta insert konam
       AND force_hamrahaval = 1

     THEN

      INSERT INTO Package_activation
        (Sub_Id, Pack_Id, Package_Volume, Activation_Datetime)
      VALUES
        (sub_id, pack_ID, FirstVolume, SYSDATE);
    END IF;
  end if;

  UPDATE Package_activation pa
     SET pa.still_valid = 'SV2' -- melak va meyare faal budan va faal mandane baste baraye moshtarek
   WHERE EXTRACT(day FROM to_date(SYSDATE, 'dd-mm-yyyy hh24:mi:ss')) -
         EXTRACT(day FROM
                 to_date(pa.activation_datetime, 'dd-mm-yyyy hh24:mi:ss')) * 24 >=
         Expiration_duration -- age baste tarikh enghezash sar resid
      OR pa.package_volume <= 0; -- age hajme baste tamum shod

  SELECT pa.still_valid
    INTO Still_valid
    FROM Package_activation pa
   WHERE pa.sub_id = sub_id
     AND pa.pack_id = pack_id;

  RETURN Still_valid;

end ;
/

prompt
prompt Creating procedure BILLING_REPORT
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.Billing_report(sub NUMBER, start_date DATE, end_date DATE) -- bayad tuye package inserte soorathesab bashe va moteghayer ha global bashan
IS
  Sub_Name                                        Bill.Sub_Name%TYPE ;
  Sub_Phone                                       Bill.Sub_Phone%TYPE ;
  Count_Of_Trans_By_Credit                        Bill.Count_Of_Trans_By_Credit%TYPE ;
  Cost_Of_Trans_By_Credit                         Bill.Cost_Of_Trans_By_Credit%TYPE ;
  Count_Of_Trans_By_Package                       Bill.Count_Of_Trans_By_Package%TYPE ;
  Cost_Of_Trans_By_Package                        Bill.Cost_Of_Trans_By_Package%TYPE ;
  Total_Count_Of_Trans                            Bill.Total_Count_Of_Trans%TYPE ;
  Total_Cost_Of_Trans                             Bill.Total_Cost_Of_Trans%TYPE ;
  Cost_Of_Package                                 Bill.Cost_Of_Package%TYPE ;
  Count_Of_Activation_Package                     Bill.Count_Of_Activation_Package%TYPE ;

BEGIN

    SELECT s.first_name || s.last_name, s.phone_number -- Name and phone number
    INTO Sub_Name, Sub_Phone
    FROM subscriber s
    JOIN transaction t ON s.sub_id = t.sub_id
    WHERE s.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date ;


    SELECT COUNT(t.trans_id) -- count of trans by credit
    INTO Count_Of_Trans_By_Credit
    FROM transaction t
    JOIN service s on t.service_id = s.service_id
    JOIN service_activation sa ON s.service_id = sa.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
          AND
          sa.credit_check_service = 'CCS1' ;


    SELECT SUM(s.tariff_default * COUNT(t.trans_id)) --cost of trans by credit
    INTO Cost_Of_Trans_By_Credit
    FROM transaction t
    JOIN service s on t.service_id = s.service_id
    JOIN service_activation sa ON s.service_id = sa.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
          AND
          sa.credit_check_service = 'CCS1'
    GROUP BY(s.tariff_default);


    SELECT COUNT(t.trans_id) -- count of trans by package
    INTO Count_Of_Trans_By_Credit
    FROM transaction t
    JOIN service s on t.service_id = s.service_id
    JOIN service_activation sa ON s.service_id = sa.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
          AND
          sa.package_check = 'PC1' ;


    SELECT SUM(s.tariff_default * COUNT(t.trans_id)) --cost of trans by package
    INTO Cost_Of_Trans_By_Credit
    FROM transaction t
    JOIN service s on t.service_id = s.service_id
    JOIN service_activation sa ON s.service_id = sa.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
          AND
          sa.package_check = 'PC1'
    GROUP BY(s.tariff_default);


    SELECT COUNT(t.trans_id) -- Total count of trans
    INTO Total_Count_Of_Trans
    FROM transaction t
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date ;


    SELECT SUM(s.tariff_default * COUNT(t.trans_id)) -- Total cost of trans
    INTO Total_Cost_Of_Trans
    FROM transaction t
    JOIN service s ON t.service_id = s.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
    GROUP BY s.tariff_default ;


    SELECT SUM(pos.price) -- cost of package
    INTO Cost_Of_Package
    FROM transaction t
    JOIN subscriber s ON t.sub_id = s.sub_id
    JOIN package_activation pa ON s.sub_id = pa.sub_id
    JOIN package_of_service pos ON pa.pack_id = pos.pack_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date;


    SELECT COUNT(pos.pack_id) -- count of package
    INTO Count_Of_Activation_Package
    FROM transaction t
    JOIN subscriber s ON t.sub_id = s.sub_id
    JOIN package_activation pa ON s.sub_id = pa.sub_id
    JOIN package_of_service pos ON pa.pack_id = pos.pack_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date;

  DBMS_OUTPUT.put_line('Report of billing');
  DBMS_OUTPUT.put_line('Name: '|| Sub_Name);
  DBMS_OUTPUT.put_line('Phone number: '||Sub_Phone);
  DBMS_OUTPUT.put_line('Number of transactions done by credit of subscriber: '|| Count_Of_Trans_By_Credit);
  DBMS_OUTPUT.put_line('Cost of all tranasactions done by credit of subscriber'|| Cost_Of_Trans_By_Credit);
  DBMS_OUTPUT.put_line('Number of transactions done by package of subscriber: '|| Count_Of_Trans_By_Package);
  DBMS_OUTPUT.put_line('Cost of all transactions done by package of subscriber: '|| Cost_Of_Trans_By_Package);
  DBMS_OUTPUT.put_line('Total number of transactions done: '|| Total_Count_Of_Trans);
  DBMS_OUTPUT.put_line('Total cost of transactions done:'||Total_Cost_Of_Trans);
  DBMS_OUTPUT.put_line('Cost of packages: '|| Cost_Of_Package);
  DBMS_OUTPUT.put_line('Number of packages activated: '|| Count_Of_Activation_Package);

END;
/

prompt
prompt Creating procedure INSERTING_A_NEW_TARIFF
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.inserting_a_new_tariff(Service_id NUMBER, Tariff_price NUMBER, eff_date DATE)
IS
BEGIN
  IF eff_date > SYSDATE
    THEN
        INSERT INTO tariff(service_id,tariff_price,eff_datetime,reg_datetime,is_active)
        VALUES(Service_ID, Tariff_price, eff_date, SYSDATE, 0);
   ELSIF  eff_date = SYSDATE THEN
        INSERT INTO tariff(service_id,tariff_price,eff_datetime,reg_datetime,is_active)
        VALUES(service_id, Tariff_price, eff_date, SYSDATE, 1);
   ELSE DBMS_OUTPUT.put_line('Insert failed. The effective date you have chosen cant be before current datetime');
   END IF;
END;
-----
/

prompt
prompt Creating procedure INSERTING_CREDIT_FOR_SUBSCRIBERS
prompt ===================================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.inserting_credit_for_subscribers(sub_id NUMBER,Amount_of_credit NUMBER, Allowed_limit NUMBER
                                                  ,Expiration_of_credit DATE, SIM_type number)
IS
BEGIN
  INSERT INTO Credit(Sub_Id, Amount_Of_Credit, Allowed_Limit, Expiration_Of_Credit, Sim_Type)
              VALUES(sub_id, Amount_of_credit, Allowed_limit, Expiration_Of_Credit, SIM_type) ;
END;
/

prompt
prompt Creating procedure INSERTING_IN_BILLING
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.inserting_in_Billing  (Sub NUMBER
                                                  ,Start_date DATE
                                                  ,End_date DATE)

IS
  Sub_Name                                        Bill.Sub_Name%TYPE ;
  Sub_Phone                                       Bill.Sub_Phone%TYPE ;
  Count_Of_Trans_By_Credit                        Bill.Count_Of_Trans_By_Credit%TYPE ;
  Cost_Of_Trans_By_Credit                         Bill.Cost_Of_Trans_By_Credit%TYPE ;
  Count_Of_Trans_By_Package                       Bill.Count_Of_Trans_By_Package%TYPE ;
  Cost_Of_Trans_By_Package                        Bill.Cost_Of_Trans_By_Package%TYPE ;
  Total_Count_Of_Trans                            Bill.Total_Count_Of_Trans%TYPE ;
  Total_Cost_Of_Trans                             Bill.Total_Cost_Of_Trans%TYPE ;
  Cost_Of_Package                                 Bill.Cost_Of_Package%TYPE ;
  Count_Of_Activation_Package                     Bill.Count_Of_Activation_Package%TYPE ;

BEGIN

    SELECT s.first_name || s.last_name, s.phone_number -- Name and phone number
    INTO Sub_Name, Sub_Phone
    FROM subscriber s
    JOIN transaction t ON s.sub_id = t.sub_id
    WHERE s.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date ;


    SELECT COUNT(t.trans_id) -- count of trans by credit
    INTO Count_Of_Trans_By_Credit
    FROM transaction t
    JOIN service s on s.service_id= t.service_id
    JOIN service_activation sa on sa.service_id = s.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
          AND
          sa.credit_check_service = 'CCS1' ;


    SELECT SUM(s.tariff_default * COUNT(t.trans_id)) --cost of trans by credit
    INTO Cost_Of_Trans_By_Credit
    FROM transaction t
    JOIN service s on s.service_id= t.service_id
    JOIN service_activation sa on sa.service_id = s.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
          AND
          sa.credit_check_service = 'CCS1'
    GROUP BY(s.tariff_default);


    SELECT COUNT(t.trans_id) -- count of trans by package
    INTO Count_Of_Trans_By_Credit
    FROM transaction t
    JOIN service s on s.service_id= t.service_id
    JOIN service_activation sa on sa.service_id = s.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
          AND
          sa.package_check = 'PC1' ;


    SELECT SUM(s.tariff_default * COUNT(t.trans_id)) --cost of trans by package
    INTO Cost_Of_Trans_By_Credit
    FROM transaction t
    JOIN service s on s.service_id= t.service_id
    JOIN service_activation sa on sa.service_id = s.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
          AND
          sa.package_check = 'PC1'
    GROUP BY(s.tariff_default);


    SELECT COUNT(t.trans_id) -- Total count of trans
    INTO Total_Count_Of_Trans
    FROM transaction t
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date ;


    SELECT SUM(s.tariff_default * COUNT(t.trans_id)) -- Total cost of trans
    INTO Total_Cost_Of_Trans
    FROM transaction t
    JOIN service s on s.service_id = t.service_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date
    GROUP BY s.tariff_default ;


    SELECT SUM(ps.price) -- cost of package
    INTO Cost_Of_Package
    FROM transaction t
    JOIN subscriber s ON t.sub_id = s.sub_id
    JOIN package_activation pa ON s.sub_id = pa.sub_id
    JOIN package_of_service ps ON pa.pack_id = ps.pack_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date;


    SELECT COUNT(ps.pack_id) -- count of package
    INTO Count_Of_Activation_Package
    FROM transaction t
    JOIN subscriber s ON t.sub_id = s.sub_id
    JOIN package_activation pa ON s.sub_id = pa.sub_id
    JOIN package_of_service ps ON pa.pack_id = ps.pack_id
    WHERE t.sub_id = Sub
          AND
          t.reg_datetime BETWEEN Start_date AND End_date;


  INSERT INTO Bill(Sub_Id,
                      Sub_Name,
                      Sub_Phone,
                      Start_Date,
                      End_Date,
                      Count_Of_Trans_By_Credit,
                      Cost_Of_Trans_By_Credit,
                      Count_Of_Trans_By_Package,
                      Cost_Of_Trans_By_Package,
                      Total_Count_Of_Trans,
                      Total_Cost_Of_Trans,
                      Cost_Of_Package,
                      Count_Of_Activation_Package)
               VALUES(Sub,
                      Sub_Name,
                      Sub_Phone,
                      Start_Date,
                      End_Date,
                      Count_Of_Trans_By_Credit,
                      Cost_Of_Trans_By_Credit,
                      Count_Of_Trans_By_Package,
                      Cost_Of_Trans_By_Package,
                      Total_Count_Of_Trans,
                      Total_Cost_Of_Trans,
                      Cost_Of_Package,
                      Count_Of_Activation_Package);

END;
/

prompt
prompt Creating procedure INSERTING_IN_BILLING_DETAIL
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.inserting_in_Billing_detail(Sub_ID NUMBER
                                                       ,Start_date DATE
                                                       ,End_date DATE)
IS
  Bill_Id                    Billing_detail.Bill_Id%TYPE ;
  Service_Name               Billing_detail.Service_Name%TYPE ;
  Count_Of_Trans_By_Credit   Billing_detail.Count_Of_Trans_By_Credit%TYPE ;
  Cost_Of_Trans_By_Credit    Billing_detail.Cost_Of_Trans_By_Credit%TYPE ;
  Count_Of_Trans_By_Package  Billing_detail.Count_Of_Trans_By_Package%TYPE ;
  Total_Count_Of_Trans       Billing_detail.Total_Count_Of_Trans%TYPE ;

BEGIN

  SELECT b.bill_id, s.service_name, COUNT(t.trans_id)
  INTO Bill_Id, Service_Name, Count_Of_Trans_By_Credit
  FROM Billing_detail bd
  JOIN Bill b ON bd.bill_id = b.bill_id
  JOIN transaction t ON b.bill_id = t.bill_id
  JOIN service s ON t.service_id = s.service_id
  JOIN service_activation sa ON sa.service_id = s.service_id
  WHERE b.start_date = Start_date
        AND
        b.end_date = End_date
        AND
        sa.package_check = 'PC2'
        AND
        sa.credit_check_service = 'CCS1'
  GROUP BY(b.bill_id, s.service_name);


  SELECT SUM(s.tariff_default*COUNT(t.trans_id))
  INTO Cost_Of_Trans_By_Credit
  FROM Billing_detail bd
  JOIN Bill b ON bd.bill_id = b.bill_id
  JOIN transaction t ON b.bill_id = t.bill_id
  JOIN service s ON t.service_id = s.service_id
  JOIN service_activation sa ON sa.service_id = s.service_id
  WHERE b.start_date = Start_date
        AND
        b.end_date = End_date
        AND
        sa.package_check = 'PC2'
        AND
        sa.credit_check_service = 'CCS1'
  GROUP BY(b.bill_id, s.service_name);


  SELECT COUNT(t.trans_id)
  INTO Count_Of_Trans_By_Package
  FROM Billing_detail bd
  JOIN Bill b ON bd.bill_id = b.bill_id
  JOIN transaction t ON b.bill_id = t.bill_id
  JOIN service s ON t.service_id = s.service_id
  JOIN service_activation sa ON sa.service_id = s.service_id
  WHERE b.start_date = Start_date
        AND
        b.end_date = End_date
        AND
        sa.package_check = 'PC1'
        AND
        (sa.credit_check_service = 'CCS1' OR sa.credit_check_service = 'CCS2')
  GROUP BY(b.bill_id, s.service_name);



  SELECT COUNT(t.trans_id)
  INTO Total_Count_Of_Trans
  FROM Billing_detail bd
  JOIN Bill b ON bd.bill_id = b.bill_id
  JOIN transaction t ON b.bill_id = t.bill_id
  JOIN service s ON t.service_id = s.service_id
  JOIN service_activation sa ON sa.service_id = s.service_id
  WHERE b.start_date = Start_date
        AND
        b.end_date = End_date
  GROUP BY(b.bill_id, s.service_name);

INSERT INTO Billing_detail(Bill_Id,
                           Service_Name,
                           Count_Of_Trans_By_Credit,
                           Cost_Of_Trans_By_Credit,
                           Count_Of_Trans_By_Package,
                           Total_Count_Of_Trans)
                    VALUES(Bill_Id,
                           Service_Name,
                           Count_Of_Trans_By_Credit,
                           Cost_Of_Trans_By_Credit,
                           Count_Of_Trans_By_Package,
                           Total_Count_Of_Trans);

END;
/

prompt
prompt Creating procedure INSERT_INTO_SERVICE
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.insert_into_service(service_name varchar2,service_for_sim_type char,is_active char,tariff_default service.tariff_default%type)
IS
BEGIN
  insert into service(service_name,service_for_sim_type,is_active,reg_datetime,tariff_default)
  values (service_name,service_for_sim_type,is_active,sysdate,tariff_default);
END;
/

prompt
prompt Creating procedure INSERT_IN_PACKAGE_OF_SERVICE
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.insert_in_package_of_service(Service_ID NUMBER
                                                       , Package_Name VARCHAR
                                                       , Price NUMBER
                                                       , Is_Active CHAR
                                                       , Package_for_SIM_type CHAR
                                                       , Expiration_duration NUMBER
                                                       , Volume NUMBER
                                                       , Detail VARCHAR2)

IS
BEGIN

  INSERT INTO Package_of_service
    (
       Service_ID
       ,Package_Name
       ,Price
       ,Is_Active
       ,Package_for_SIM_type
       ,Reg_Datetime
       ,Expiration_duration
       ,Volume
       ,Detail
       )
     VALUES
       (
          Service_ID
          ,Package_Name
          ,Price
          ,Is_Active
          ,Package_for_SIM_type
          ,SYSDATE
          ,Expiration_duration
          ,Volume
          ,Detail
        );
       COMMIT;
END insert_in_package_of_service;
/

prompt
prompt Creating procedure INSERT_SUBSCRIBER
prompt ====================================
prompt
create or replace procedure heydar86.insert_Subscriber(First_Name   VARCHAR,
                                              Last_Name    VARCHAR,
                                              National_Id  CHAR,
                                              Gender       CHAR,
                                              Dob          date,
                                              Phone_Number CHAR,
                                              Is_Active    CHAR,
                                              Address      varchar2) is

begin

  insert into Subscriber
    (First_Name,
     Last_Name,
     National_Id,
     Gender,
     Dob,
     Phone_Number,
     Reg_Datetime,
     Is_Active,
     Address)

  values
    (First_Name,
     Last_Name,
     National_Id,
     Gender,
     Dob,
     Phone_Number,
     sysdate,
     Is_Active,
     Address);

end;
/

prompt
prompt Creating procedure JOB_CHECK_EXPIRATION_DATETIME_OF_PACKAGES
prompt ============================================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.job_check_expiration_datetime_of_packages -- in ye jobe
IS
BEGIN
  FOR r IN (SELECT *
              FROM Package_activation pa
              JOIN package_of_service pos
                ON pa.pack_id = pos.pack_id) LOOP
    IF (EXTRACT(DAY FROM to_date(SYSDATE, 'dd-mm-yyyy hh24:mi:ss')) -
       EXTRACT(DAY FROM
                to_date(r.activation_datetime, 'dd-mm-yyyy hh24:mi:ss')) * 24 >=
       r.expiration_duration) THEN
      DBMS_OUTPUT.put_line('Your package got expired');
    END IF;
  END LOOP;
END;
/

prompt
prompt Creating procedure JOB_CHECK_SUBSCRIBERS_WHO_ONLY_HAVE_7_HOURS
prompt ==============================================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.job_check_subscribers_who_only_have_7_hours
IS
BEGIN
  FOR r IN (SELECT * FROM Package_activation pa JOIN package_of_service pos ON pa.pack_id = pos.pack_id )
    LOOP
      IF(r.expiration_duration
         -((EXTRACT(DAY FROM to_date(SYSDATE, 'dd-mm-yyyy hh24:mi:ss'))*24) -(EXTRACT(DAY FROM to_date(r.activation_datetime, 'dd-mm-yyyy hh24:mi:ss'))*24 )) <= 7)
                         THEN DBMS_OUTPUT.put_line('You have only 7 hours to expiration of your package ');

      END IF;
    END LOOP ;
END;
/

prompt
prompt Creating procedure REPORT_OF_CREDIT
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.report_of_credit(sub_id credit.sub_id%TYPE)
IS
  credit_ credit.amount_of_credit%TYPE;
BEGIN
  SELECT c.amount_of_credit INTO credit_ FROM credit c WHERE c.sub_id = sub_id;
  DBMS_OUTPUT.put_line('etebar shoma: ' || credit_ || ' mibashad');
END;
/

prompt
prompt Creating procedure REPORT_OF_PACKAGE
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.report_of_package(sub_id package_activation.sub_id%TYPE)
IS
volume         package_activation.package_volume%TYPE;
time_of_pack   package_activation.activation_datetime%TYPE;
BEGIN
  SELECT pa.package_volume INTO volume FROM package_activation pa WHERE pa.sub_id=sub_id;
  DBMS_OUTPUT.put_line('Hajme baghimande shoma: ' || volume || ' Mibashad');
  SELECT pa.activation_datetime INTO time_of_pack FROM package_activation pa WHERE pa.sub_id=sub_id;
  DBMS_OUTPUT.put_line('Mohlat baghimande az baste shoma: ' || TO_CHAR(sysdate - time_of_pack) || ' Mibashad');
END;
/

prompt
prompt Creating procedure REPORT_OF_TRANSACTIONS
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.report_of_transactions(sub_id transaction.sub_id%TYPE, bill_id  transaction.bill_id%TYPE)
IS
report_trans  NUMBER;
BEGIN
  select count(t.trans_id) into report_trans from transaction t where t.sub_id =sub_id and t.bill_id=bill_id;
  DBMS_OUTPUT.put_line('List trakonesh shoma: ' || report_trans || ' Mibashad' );
END;
/

prompt
prompt Creating procedure SHOWING_RELATED_NOTIFICATION
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.Showing_related_notification(id NUMBER)
IS
BEGIN
  CASE id
    WHEN 1 THEN DBMS_OUTPUT.put_line('You have charged your account '|| ' Rials. And Your current amount of credit is ');
    WHEN 2 THEN DBMS_OUTPUT.put_line('Your package volume has been finished.');
    WHEN 3 THEN DBMS_OUTPUT.put_line('Your amount of credit has been finished');
    WHEN 4 THEN DBMS_OUTPUT.put_line('Your package got expired');
    WHEN 5 THEN DBMS_OUTPUT.put_line('Your credit got expired');
    WHEN 6 THEN DBMS_OUTPUT.put_line('You have used 90 percent of your package amount');-- har vaght <kam shodane etebar ya hajme baste be ezaye har tarakonesh> ro neveshtim ino bayad rush benevisim ke
    WHEN 7 THEN DBMS_OUTPUT.put_line('You have only 7 hours to expiration of your package ');
    WHEN 8 THEN DBMS_OUTPUT.put_line('Service of '  || ' has been activated for you.');
    WHEN 9 THEN DBMS_OUTPUT.put_line('Service of '  || ' has been deactivated for you.');
  END CASE;
END;
/

prompt
prompt Creating procedure UPDATE_SUBSCRIBER
prompt ====================================
prompt
create or replace procedure heydar86.update_Subscriber(first_name   VARCHAR,
                                              last_name    VARCHAR,
                                              dob          date,
                                              is_active    char,
                                              address      VARCHAR2,
                                              phone_number char) is

begin

  update Subscriber s
     set s.first_name = first_name,
         s.last_name  = last_name,
         s.dob        = dob,
         s.is_active  = is_active,
         s.address    = address
   where s.phone_number = phone_number;

end;
/

prompt
prompt Creating procedure UPDATING_A_SERVICE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE HEYDAR86.updating_a_service(Service_ID NUMBER, Service_name VARCHAR, Is_Active CHAR)
IS
BEGIN
  UPDATE Service s
   SET s.service_name = Service_name , s.is_active = Is_Active
   WHERE s.service_id = Service_ID ;
END;
/

prompt
prompt Creating package body PACKAGE_ACT_PACK
prompt ======================================
prompt
CREATE OR REPLACE PACKAGE BODY HEYDAR86.package_act_pack is




 FUNCTION check_and_update_credit_for_activating_package(sub_id  subscriber.sub_id%TYPE,
                                                         pack_id package_activation.pack_id%TYPE)
  RETURN NUMBER IS
  amount_credit credit.amount_of_credit%TYPE;
  price         package_of_service.price%TYPE;
  status        NUMBER(1);
BEGIN

  select c.amount_of_credit
    into amount_credit
    from credit c
   where c.sub_id = sub_id;

  select ps.price
    into price
    from package_of_service ps
   where ps.pack_id = pack_id;

  IF amount_credit >= price THEN
    UPDATE credit c
       SET c.amount_of_credit =
           (c.amount_of_credit - price)
     WHERE c.sub_id = sub_id;
    status := 1;
  ELSE
    status := 0;
  END IF;

  RETURN status;
END;
 procedure inserting_in_package_activation(sub_id           package_activation.sub_id%type,
                                                           pack_id          package_activation.pack_id%type,
                                                           force_hamrahaval number)
   IS
  SIM_type            Credit.Sim_Type%TYPE;
  pack_for_SIM_type   package_of_service.package_for_sim_type%TYPE;
  activity            package_of_service.is_active%TYPE;
  FirstVolume         package_of_service.volume%TYPE;
  Expiration_duration package_of_service.expiration_duration%TYPE;
 BEGIN

  select c.SIM_Type into SIM_type from Credit c where c.sub_id = sub_id;

  SELECT ps.is_active
    INTO activity
    FROM Package_of_service ps
   WHERE ps.pack_id = pack_ID;

  SELECT ps.package_for_sim_type
    INTO pack_for_SIM_type
    FROM Package_of_service ps
   WHERE ps.pack_id = pack_ID;

  SELECT ps.volume, ps.expiration_duration
    INTO FirstVolume, Expiration_duration
    FROM Package_of_service ps
   WHERE ps.pack_id = pack_ID
     AND ps.package_for_sim_type = pack_for_SIM_type; -- baste mortabet be SIM card

  IF (SIM_type = 0 -- SIM card daemi
     AND (pack_for_SIM_type = 'PS01' OR pack_for_SIM_type = 'PS11')) -- basetye makhsoose SIM card daemi ya moshtarak beyne daemi va etebari
     OR (SIM_type = 1 -- -- SIM card etebari
     AND (pack_for_SIM_type = 'PS10' OR pack_for_SIM_type = 'PS11')) --  -- basteye makhsoose SIM card etebari ya moshtarak beyne daemi va etebari
   THEN
    IF activity = 'Yes' -- agar baste mojud bud
       AND
       check_and_update_credit_for_activating_package(sub_id, pack_id) = 1 --chon gharare sabt she az alan poolo begir, ya engar migim pool bede ta insert konam
       AND force_hamrahaval = 1

     THEN

      INSERT INTO Package_activation
        (Sub_Id, Pack_Id, Package_Volume, Activation_Datetime)
      VALUES
        (sub_id, pack_ID, FirstVolume, SYSDATE);
    END IF;
  end if;

  UPDATE Package_activation pa
     SET pa.still_valid = 'SV2' -- melak va meyare faal budan va faal mandane baste baraye moshtarek
   WHERE EXTRACT(day FROM to_date(SYSDATE, 'dd-mm-yyyy hh24:mi:ss')) -
         EXTRACT(day FROM
                 to_date(pa.activation_datetime, 'dd-mm-yyyy hh24:mi:ss')) * 24 >=
         Expiration_duration -- age baste tarikh enghezash sar resid
      OR pa.package_volume <= 0; -- age hajme baste tamum shod

 end ;

end package_act_pack;
/

prompt
prompt Creating package body SERVICE_ACT_PACK
prompt ======================================
prompt
CREATE OR REPLACE PACKAGE BODY HEYDAR86.service_act_pack is

  FUNCTION Check_credit_more_than_tariff_default(Sub_ID NUMBER
                                                                ,service_id NUMBER)
  RETURN CHAR
  IS
    amount               Credit.Amount_Of_Credit%TYPE ;
  Tariff_def           Service.Tariff_Default%TYPE ;

 BEGIN
  SELECT Amount_of_credit
  INTO amount
  FROM Credit c
  WHERE c.Sub_ID = Sub_ID;

  SELECT Tariff_default
  INTO Tariff_def
  FROM Service s
  WHERE s.service_id = service_id;

  IF(amount >= Tariff_def) THEN
    RETURN 'CCS1';
  ELSE
    RETURN 'CCS2';
  END IF;


 END ;

 PROCEDURE inserting_in_service_activation(sub_id subscriber.sub_id%type
                                           ,service_id  service.service_id%type
                                           ,force_hamrahaval number)
IS
  SIM_type                  Credit.Sim_Type%TYPE;
  Service_for_SIM_Type      service.service_for_sim_type%TYPE;
  activity                  service.is_active%TYPE;
  credit_check              Service_activation.Credit_Check_Service%TYPE ;
  Package_Check             Service_activation.Package_Check%TYPE;
  --status                    service_activation.is_active%TYPE;
  still_valid               package_activation.still_valid%type;
BEGIN

  select c.SIM_Type
  into SIM_type
  from Credit c
  where c.sub_id = sub_id ;

  SELECT s.is_active
  INTO activity
  FROM Service s
  WHERE s.service_id=service_id;

  SELECT s.Service_for_SIM_Type
  INTO Service_for_SIM_Type
  FROM Service s
  WHERE s.service_id=service_id ;

  SELECT pa.still_valid
  INTO still_valid
  FROM package_activation pa
  WHERE pa.sub_id=sub_id;

  credit_check := check_credit_more_than_tariff_default(sub_id ,service_id);

  IF        (SIM_type = 0 -- SIM card daemi
              AND
            (Service_for_SIM_Type = 'SS01' OR Service_for_SIM_Type = 'SS11')) -- service makhsoose SIM card daemi ya moshtarak beyne daemi va etebari
      OR
            (SIM_type = 1 -- -- SIM card etebari
              AND
            (Service_for_SIM_Type = 'SS10' OR Service_for_SIM_Type = 'SS11')) -- service makhsoose SIM card etebari ya moshtarak beyne daemi va etebari
   THEN
     IF
          activity = 'Yes' -- agar service mojud bud

       AND
         force_hamrahaval = 1

     THEN
       IF still_valid = 'SV1' THEN
         Package_Check := 'PC1';
         INSERT INTO Service_activation(Sub_Id, service_id, Activation_Datetime, Credit_Check_Service, Package_Check)
                               VALUES(sub_id,service_id , SYSDATE, credit_check, Package_Check);
         ELSIF still_valid = 'SV2' THEN
           Package_Check := 'PC2';
           INSERT INTO Service_activation(Sub_Id, service_id, Activation_Datetime, Credit_Check_Service, Package_Check)
                               VALUES(sub_id,service_id , SYSDATE, credit_check, Package_Check);
       END IF;
     END IF;
  END IF;

       UPDATE Service_activation sa
       SET sa.is_active = 0
       WHERE
             (credit_check = 'CCS2'
               and
              Package_Check = 'PC2')
            AND
              sa.sub_id = sub_id
            AND
              sa.service_id = service_id ;


 END ;
END service_act_pack;
/

prompt
prompt Creating package body TRANSACTIONS_PACKAGE
prompt ==========================================
prompt
create or replace package body heydar86.transactions_package is

  function subscriber_check(sub_id  subscriber.sub_id%type) return number is
    total number(1);

  begin

    select 1
      into total
      from subscriber s
     where s.sub_id = sub_id
       and s.is_active = 'yes';
    return total;
  exception
    when no_data_found then
      return 0;

  end subscriber_check;

  function package_check(sub_id         transaction.sub_id%type,
                         service_id     transaction.service_id%type)
    return number is
    total number(1);
  begin
    select 1
      into total
      from package_activation p
     where p.sub_id = sub_id
       and p.still_valid = 'SV1'
       and p.pack_id in (select o.pack_id
                           from package_of_service o
                           where o.service_id=service_id);
    return total;
  exception
    when no_data_found then
      return 0;

  end package_check;

  function calculatin_hours_from_days(sub_id      package_activation.sub_id%type,
                                      service_id  service.service_id%type)
    return number is

    total number(10);

  begin

    select (EXTRACT(day from
                    to_date(SYSDATE, 'dd-mm-yyyy hh24:mi:ss') -
                    EXTRACT(day FROM to_date(p.activation_datetime,
                                    'dd-mm-yyyy hh24:mi:ss'))))
      into total
      from package_activation p
     where p.pack_act_id in
           (select pa.pack_act_id
              from Package_activation pa
             where pa.sub_id = sub_id
               and p.still_valid = 'SV1'
               and p.pack_id in
                   (select o.pack_id
                      from package_of_service o
                      where o.service_id=service_id));
    total := total * 24;
    return total;

  end calculatin_hours_from_days;
  function credit_check_service(sub_id number, service_id number)
    return number is

    total            number(2);
    amount_of_credit number(10);

  begin

    select c.amount_of_credit
      into amount_of_credit
      from credit c
     where c.sub_id = sub_id;

    select 1
      into total
      from service s
     where s.tariff_default <= amount_of_credit
       and s.service_id=service_id;
    return total;

  exception
    when no_data_found then
      return 0;

  end credit_check_service;

  procedure insert_transactions(sub_id      number,
                                service_id number,
                                bill_id     number) is

    SIM_type            char(4);
    serv_sim_type       char(4);
    Package_Type        char(4);
    expiration_duration number(5);
    tariff_price        number(5, 2);
    package_volume      number(10);

  begin

    select c.sim_type into SIM_type from credit c where c.sub_id = sub_id;

    select s.service_for_sim_type
      into serv_sim_type
      from service s
     where s.service_id=service_id;

    select s.tariff_default
      into tariff_price
      from service s
     where s.service_id=service_id;

    select p.Package_Type, p.expiration_duration
      into Package_Type, expiration_duration
      from package_of_service p
      where p.service_id=service_id;

    if subscriber_check(sub_id) = 1 and
       ((SIM_type = 0 and
        (serv_sim_type = 'SS01' or serv_sim_type = 'SS11')) or
        (SIM_type = 1 and
        (serv_sim_type = 'SS10' or serv_sim_type = 'SS11'))) then

      --dar in marhale package mortabet va faal check mishavad ke aya vojod darad ya na

      if package_check(sub_id, service_id) = 1 then
        if Package_Type = 'PT10' or Package_Type = 'PT11' then
          update package_activation p
             set p.package_volume =
                 (p.package_volume - 1)
           where p.pack_act_id in
                 (select p.pack_act_id
                    from package_activation p
                   where p.sub_id = sub_id
                     and p.still_valid = 'SV1'
                     and p.pack_id in
                         (select o.pack_id
                            from package_of_service o
                            where o.service_id=service_id));

          /*manzor az (p.package_volume-1) yani ya 1kb internet
          ya 1 adad SMS ya 1 daghigheh mokalemeh kam shavad*/

        end if;

        insert into transaction
          (sub_id, service_id, reg_datetime, bill_id)
        values
          (sub_id, service_id, sysdate, bill_id);

        select p.package_volume
          into package_volume
          from package_activation p
         where p.pack_act_id in
               (select pa.pack_act_id
                  from Package_activation pa
                 where pa.sub_id = sub_id
                   and p.still_valid = 'SV1'
                   and p.pack_id in
                       (select o.pack_id
                          from package_of_service o
                          where o.service_id = service_id));

        if calculatin_hours_from_days(sub_id, service_id) >=
           Expiration_duration or package_volume <= 0 then

          update package_activation p
             set p.still_valid = 'SV2'
           where p.pack_act_id in
                 (select pa.pack_act_id
                    from Package_activation pa
                   where pa.sub_id = sub_id
                     and p.still_valid = 'SV1'
                     and p.pack_id in
                         (select o.pack_id
                            from package_of_service o
                            where o.service_id = service_id));

        end if;

      elsif credit_check_service(sub_id, service_id) = 1 then

        update credit c
           set c.amount_of_credit =
               (c.amount_of_credit - tariff_price)
         where c.sub_id = sub_id;

        insert into transaction
          (sub_id, service_id, reg_datetime, bill_id)
        values
          (sub_id, service_id, sysdate, bill_id);

      end if;
    end if;

  end;

end transactions_package;
/

prompt
prompt Creating trigger CHECK_EXPIRATION_OF_CREDIT
prompt ===========================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.check_expiration_of_credit
  BEFORE UPDATE ON Credit
  FOR EACH ROW
BEGIN
  IF (SYSDATE >= :OLD.Expiration_of_credit) -- If the credit is not valid anymore
   THEN
    RAISE_APPLICATION_ERROR(-20001, 'The credit is expired!');
  END IF;
END;
/

prompt
prompt Creating trigger DONT_ALLOW_TO_DELETE_THE_DEFAULT_TARIFF
prompt ========================================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.Dont_allow_to_delete_the_default_tariff
BEFORE DELETE ON Service
BEGIN
    raise_application_error(-20001,'Records can not be deleted');
    dbms_output.put_line( 'The tariff default value can not be deleted');
END;
/

prompt
prompt Creating trigger INSERTING_CREDIT_INCREASMENT
prompt =============================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.inserting_credit_increasment
AFTER UPDATE ON Credit
FOR EACH ROW
DECLARE
  etebare_ezafe_shode  Credit.Amount_Of_Credit%TYPE ; -- Bayad global bashe chon tuye soale 33 azash bayad estefade koni
  etebare_feli         Credit.Amount_Of_Credit%TYPE ;
BEGIN
  IF( :NEW.Amount_of_credit > :OLD.Amount_of_credit )
    THEN
        etebare_ezafe_shode := :NEW.Amount_of_credit - :OLD.Amount_of_credit ;
        etebare_feli := :New.Amount_of_credit ;
        DBMS_OUTPUT.put_line('You have charged your account '|| etebare_ezafe_shode || ' Rials. And Your current amount of credit is '|| etebare_feli);
        INSERT INTO Credit_Increment_History(Credit_Id, Sim_Type, Amount_Of_Credit, Update_date)
        VALUES(:old.Credit_Id, :old.SIM_Type, :old.Amount_Of_Credit, SYSDATE) ;
  END IF;
END;
/

prompt
prompt Creating trigger PREVENT_DELETING_OLD_EFFECTIVEDATES
prompt ====================================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.Prevent_Deleting_Old_EffectiveDates
  BEFORE DELETE ON Tariff
  FOR EACH ROW
BEGIN
  IF( :old.eff_datetime <= SYSDATE )
  THEN
    /*write_audit;*/
    RAISE_APPLICATION_ERROR( -20001, 'Query has attempted to delete old effective dates!' );
    DBMS_OUTPUT.PUT_LINE('You cant delete old effective dates');
  END IF;
END;
/

prompt
prompt Creating trigger PREVENT_UPDATING_ACTIVE_PACKAGES
prompt =================================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.Prevent_Updating_Active_Packages

  BEFORE UPDATE ON Package_of_service
  FOR EACH ROW
BEGIN
  IF (:old.is_active = 'Yes') then
    RAISE_APPLICATION_ERROR(-20001, 'The credit is expired!');
    DBMS_OUTPUT.put_line('sdcvsdcvsdc');
  end if;
END;
/

prompt
prompt Creating trigger PREVENT_UPDATING_SERVICE
prompt =========================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.Prevent_Updating_service
BEFORE UPDATE OF Service_ID, Reg_Datetime, tariff_default,service_for_sim_type  ON Service
BEGIN
  RAISE_APPLICATION_ERROR (-20000, 'updating not supported on this table');
  DBMS_OUTPUT.put_line( 'Records can not be updated');
END;
/

prompt
prompt Creating trigger SERVICE_HIS
prompt ============================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.Service_His
  AFTER UPDATE ON Service
  FOR EACH ROW
BEGIN
  INSERT INTO Service_History(Service_Id,Service_Name,is_Active,Update_Date)

  VALUES
    (:old.service_id, :old.service_name, :old.is_active, SYSDATE);
END;
/

prompt
prompt Creating trigger SHOWING_NOTIFICATION_NUMBER_2
prompt ==============================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.showing_notification_number_2
AFTER UPDATE ON Package_activation
FOR EACH ROW
BEGIN

  IF(:new.Package_volume <= 0 AND :old.Package_volume>0) -- agar old ra lahaz nakonim madami ke hajme baste 0 hast elan mifreste dar halike ye bar bayad befreste :))
    THEN DBMS_OUTPUT.put_line('Your package volume has been finished.');
  END IF;

END;
/

prompt
prompt Creating trigger SHOWING_NOTIFICATION_NUMBER_8_AND_9
prompt ====================================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.showing_notification_number_8_and_9
AFTER UPDATE ON service_activation
FOR EACH ROW
DECLARE
  name_service_faal_shode          Service.Service_Name%TYPE ;
  name_service_gheyre_faal_shode   Service.Service_Name%TYPE ;
BEGIN
  IF(:new.Is_Active = 1 AND :old.Is_Active = 0)
    THEN SELECT s.service_name
         INTO name_service_faal_shode
         FROM service s;

         DBMS_OUTPUT.put_line('Service of ' || name_service_faal_shode || ' has been activated for you.');
  END IF;


   IF(:new.Is_Active = 0 AND :old.Is_Active = 1)
    THEN SELECT s.service_name
         INTO name_service_gheyre_faal_shode
         FROM service s;

         DBMS_OUTPUT.put_line('Service of ' || name_service_gheyre_faal_shode || ' has been deactivated for you.');
  END IF;

END ;
/

prompt
prompt Creating trigger SHOWING_NOTIFICATION_NUMBER_THREE_AND_FIVE
prompt ===========================================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.showing_notification_number_three_and_five
AFTER UPDATE ON Credit
FOR EACH ROW
BEGIN

  IF(:new.Amount_of_credit <= 0 AND :old.Amount_of_credit > 0) -- agar old ra lahaz nakonim madami ke etebare moshtarek 0 hast elan mifreste dar halike ye bar bayad befreste :))
    THEN DBMS_OUTPUT.put_line('Your amount of credit has been finished');
  END IF;

  IF(SYSDATE >= :old.Expiration_of_credit) -- mamulan tarikhe engheza avaz nemishe ta old ya new mani bede
    THEN DBMS_OUTPUT.put_line('Your credit got expired');
  END IF;
END;
/

prompt
prompt Creating trigger SUBSCRIBER_NOT_UPDATING
prompt ========================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.Subscriber_not_updating
BEFORE update of sub_id , national_id, gender, phone_number,reg_datetime ON  Subscriber
BEGIN
  RAISE_APPLICATION_ERROR (-20000, 'updating not supported on this table');
  dbms_output.put_line( 'Records can not be updated');
END;
/

prompt
prompt Creating trigger SUB_HISTORY
prompt ============================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.Sub_history

  after update on Subscriber
  for each row

declare

begin
  insert into Subscriber_history
    (Sub_Id, First_Name, Last_Name, Dob, Is_Active, Update_Date)
  values
    (:old.sub_id,
     :old.First_Name,
     :old.Last_Name,
     :old.dob,
     :old.Is_Active,
     sysdate);

end;
/

prompt
prompt Creating trigger UPDATING_DEACTIVE_PACKAGES
prompt ===========================================
prompt
CREATE OR REPLACE TRIGGER HEYDAR86.Updating_Deactive_Packages
  AFTER UPDATE ON Package_of_service
  for each row

BEGIN
  IF (:old.Is_Active = 'NO') THEN
    INSERT INTO Package_History
      (Pack_Id,
       Price,
       Expiration_Duration,
       Volume,
       Is_Active,
       Update_Date,
       Detail)
    VALUES
      (:OLD.Pack_ID,
       :OLD.Price,
       :OLD.Expiration_duration,
       :OLD.Volume,
       :OLD.Is_Active,
       SYSDATE,
       :OLD.Detail);
  END IF;
END;
/


prompt Done
spool off
set define on
