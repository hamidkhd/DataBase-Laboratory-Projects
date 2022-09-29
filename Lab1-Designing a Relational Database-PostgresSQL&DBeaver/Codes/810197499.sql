CREATE TABLE "public"."User"
(
 "id"          serial NOT NULL,
 "first name"  char(50) NOT NULL,
 "last name"   char(50) NOT NULL,
 email       json NOT NULL,
 "access type" char(50) NOT NULL,
 age         int NOT NULL,
 gender      char(50) NOT NULL,
 phone       json NOT NULL,
 "date"        date NOT NULL,
 CONSTRAINT PK_8 PRIMARY KEY ( "id" )
);



CREATE TABLE Admin
(
 "id"         serial NOT NULL,
 "first name" char(50) NOT NULL,
 "last name"  char(50) NOT NULL,
 email      json NOT NULL,
 phone      json NOT NULL,
 CONSTRAINT PK_84 PRIMARY KEY ( "id" )
);



CREATE TABLE Company
(
 "id"          serial NOT NULL,
 name        char(50) NOT NULL,
 email       json NOT NULL,
 web_site    varchar(50) NOT NULL,
 address     char(50) NOT NULL,
 description varchar(50) NOT NULL,
 phone       json NOT NULL,
 CONSTRAINT PK_68 PRIMARY KEY ( "id" )
);



CREATE TABLE Education_experience
(
 major                char(50) NOT NULL,
 education_place_name char(50) NOT NULL,
 education_field      char(50) NOT NULL,
 gpa                  int NOT NULL,
 description          char(50) NOT NULL,
 CONSTRAINT PK_26 PRIMARY KEY ( major, education_place_name, education_field )
);



CREATE TABLE Work_experience
(
 job_title           char(50) NOT NULL,
 company_name        char(50) NOT NULL,
 experience_duration int NOT NULL,
 description         char(50) NOT NULL,
 CONSTRAINT PK_45 PRIMARY KEY ( job_title, company_name )
);



CREATE TABLE Bill
(
 job_advertisement_id uuid NOT NULL,
 "id"                   uuid NOT NULL,
 amount               numeric NOT NULL,
 status               boolean NOT NULL,
 data                 data NOT NULL,
 description           NOT NULL,
 CONSTRAINT PK_230 PRIMARY KEY ( "id", amount, status, data, description ),
 CONSTRAINT FK_189 FOREIGN KEY ( job_advertisement_id ) REFERENCES Job_advertisement ( "id" )
);

CREATE INDEX fkIdx_191 ON Bill
(
 job_advertisement_id
);



CREATE TABLE Worker
(
 "id" serial NOT NULL,
 CONSTRAINT PK_95 PRIMARY KEY ( "id" ),
 CONSTRAINT FK_92 FOREIGN KEY ( "id" ) REFERENCES "public"."User" ( "id" )
);

CREATE INDEX fkIdx_94 ON Worker
(
 "id"
);



CREATE TABLE Representative
(
 "id"          serial NOT NULL,
 employer_id serial NOT NULL,
 CONSTRAINT PK_103 PRIMARY KEY ( "id" ),
 CONSTRAINT FK_100 FOREIGN KEY ( "id" ) REFERENCES "public"."User" ( "id" ),
 CONSTRAINT FK_116 FOREIGN KEY ( employer_id ) REFERENCES Employer ( "id" )
);

CREATE INDEX fkIdx_102 ON Representative
(
 "id"
);

CREATE INDEX fkIdx_118 ON Representative
(
 employer_id
);



CREATE TABLE Skill
(
 name        char(50) NOT NULL,
 level       char(50) NOT NULL,
 description char(50) NOT NULL,
 CONSTRAINT PK_51 PRIMARY KEY ( name )
);



CREATE TABLE Support_question
(
 "id"           uuid NOT NULL,
 "date"         date NOT NULL,
 User_id      serial NOT NULL,
 title        char(50) NOT NULL,
 text         char(50) NOT NULL,
 urgency_rate char(50) NOT NULL,
 CONSTRAINT PK_77 PRIMARY KEY ( "id" ),
 CONSTRAINT FK_142 FOREIGN KEY ( User_id ) REFERENCES "public"."User" ( "id" )
);

CREATE INDEX fkIdx_144 ON Support_question
(
 User_id
);



CREATE TABLE Job_advertisement
(
 "id"                uuid NOT NULL,
 contract_type     char(50) NOT NULL,
 employer_id       serial NOT NULL,
 company_place     char(50) NOT NULL,
 hours_of_work     int NOT NULL,
 deadline_for_work char(50) NOT NULL,
 work_difficulty   char(50) NOT NULL,
 priority          char(50) NOT NULL,
 title             char(50) NOT NULL,
 description       char(50) NOT NULL,
 proposed_salary   numeric NOT NULL,
 CONSTRAINT PK_56 PRIMARY KEY ( "id" ),
 CONSTRAINT FK_223 FOREIGN KEY ( employer_id ) REFERENCES Employer ( "id" )
);

CREATE INDEX fkIdx_225 ON Job_advertisement
(
 employer_id
);



CREATE TABLE Can_observe
(
 representative_id    serial NOT NULL,
 job_advertisement_id uuid NOT NULL,
 "date"                 date NOT NULL,
 CONSTRAINT PK_237 PRIMARY KEY ( representative_id, job_advertisement_id ),
 CONSTRAINT FK_234 FOREIGN KEY ( representative_id ) REFERENCES Representative ( "id" ),
 CONSTRAINT FK_238 FOREIGN KEY ( job_advertisement_id ) REFERENCES Job_advertisement ( "id" )
);

CREATE INDEX fkIdx_236 ON Can_observe
(
 representative_id
);

CREATE INDEX fkIdx_240 ON Can_observe
(
 job_advertisement_id
);



CREATE TABLE Check_status_of_job_advertisement
(
 Job_advertisement_id uuid NOT NULL,
 admin_id             serial NOT NULL,
 CONSTRAINT PK_232 PRIMARY KEY ( Job_advertisement_id, admin_id ),
 CONSTRAINT FK_204 FOREIGN KEY ( Job_advertisement_id ) REFERENCES Job_advertisement ( "id" ),
 CONSTRAINT FK_208 FOREIGN KEY ( admin_id ) REFERENCES Admin ( "id" )
);

CREATE INDEX fkIdx_206 ON Check_status_of_job_advertisement
(
 Job_advertisement_id
);

CREATE INDEX fkIdx_210 ON Check_status_of_job_advertisement
(
 admin_id
);



CREATE TABLE Employer
(
 "id"              serial NOT NULL,
 determines_task char(50) NOT NULL,
 determines_date date NOT NULL,
 registers_date  date NOT NULL,
 CONSTRAINT PK_99 PRIMARY KEY ( "id" ),
 CONSTRAINT FK_96 FOREIGN KEY ( "id" ) REFERENCES "public"."User" ( "id" )
);

CREATE INDEX fkIdx_98 ON Employer
(
 "id"
);



CREATE TABLE Chooses
(
 employer_id serial NOT NULL,
 company_id  serial NOT NULL,
 CONSTRAINT PK_151 PRIMARY KEY ( employer_id, company_id ),
 CONSTRAINT FK_148 FOREIGN KEY ( employer_id ) REFERENCES Company ( "id" ),
 CONSTRAINT FK_152 FOREIGN KEY ( company_id ) REFERENCES Employer ( "id" )
);

CREATE INDEX fkIdx_150 ON Chooses
(
 employer_id
);

CREATE INDEX fkIdx_154 ON Chooses
(
 company_id
);



CREATE TABLE Has_work_experience
(
 job_title    char(50) NOT NULL,
 company_name char(50) NOT NULL,
 worker_id    serial NOT NULL,
 CONSTRAINT PK_160 PRIMARY KEY ( job_title, company_name, worker_id ),
 CONSTRAINT FK_156 FOREIGN KEY ( job_title, company_name ) REFERENCES Work_experience ( job_title, company_name ),
 CONSTRAINT FK_161 FOREIGN KEY ( worker_id ) REFERENCES Worker ( "id" )
);

CREATE INDEX fkIdx_159 ON Has_work_experience
(
 job_title,
 company_name
);

CREATE INDEX fkIdx_163 ON Has_work_experience
(
 worker_id
);



CREATE TABLE Handles
(
 "date"                date NOT NULL,
 response            char(50) NOT NULL,
 support_question_is uuid NOT NULL,
 admin_id            serial NOT NULL,
 CONSTRAINT PK_146 PRIMARY KEY ( support_question_is, admin_id ),
 CONSTRAINT FK_134 FOREIGN KEY ( support_question_is ) REFERENCES Support_question ( "id" ),
 CONSTRAINT FK_138 FOREIGN KEY ( admin_id ) REFERENCES Admin ( "id" )
);

CREATE INDEX fkIdx_136 ON Handles
(
 support_question_is
);

CREATE INDEX fkIdx_140 ON Handles
(
 admin_id
);



CREATE TABLE Confirms
(
 admin_id          serial NOT NULL,
 iepresentative_id serial NOT NULL,
 CONSTRAINT PK_124 PRIMARY KEY ( admin_id, iepresentative_id ),
 CONSTRAINT FK_121 FOREIGN KEY ( admin_id ) REFERENCES Representative ( "id" ),
 CONSTRAINT FK_128 FOREIGN KEY ( iepresentative_id ) REFERENCES Admin ( "id" )
);

CREATE INDEX fkIdx_123 ON Confirms
(
 admin_id
);

CREATE INDEX fkIdx_130 ON Confirms
(
 iepresentative_id
);




CREATE TABLE Has_education_experience
(
 major                char(50) NOT NULL,
 education_place_name char(50) NOT NULL,
 education_field      char(50) NOT NULL,
 worker_id            serial NOT NULL,
 CONSTRAINT PK_170 PRIMARY KEY ( major, education_place_name, education_field, worker_id ),
 CONSTRAINT FK_165 FOREIGN KEY ( major, education_place_name, education_field ) REFERENCES Education_experience ( major, education_place_name, education_field ),
 CONSTRAINT FK_171 FOREIGN KEY ( worker_id ) REFERENCES Worker ( "id" )
);

CREATE INDEX fkIdx_169 ON Has_education_experience
(
 major,
 education_place_name,
 education_field
);

CREATE INDEX fkIdx_173 ON Has_education_experience
(
 worker_id
);




CREATE TABLE Has_skill
(
 skill_name char(50) NOT NULL,
 worker_id  serial NOT NULL,
 CONSTRAINT PK_178 PRIMARY KEY ( skill_name, worker_id ),
 CONSTRAINT FK_175 FOREIGN KEY ( skill_name ) REFERENCES Skill ( name ),
 CONSTRAINT FK_179 FOREIGN KEY ( worker_id ) REFERENCES Worker ( "id" )
);

CREATE INDEX fkIdx_177 ON Has_skill
(
 skill_name
);

CREATE INDEX fkIdx_181 ON Has_skill
(
 worker_id
);



CREATE TABLE Observe
(
 data                 date NOT NULL,
 employer_id          uuid NOT NULL,
 Job_advertisement_id serial NOT NULL,
 CONSTRAINT PK_233 PRIMARY KEY ( employer_id, Job_advertisement_id ),
 CONSTRAINT FK_213 FOREIGN KEY ( employer_id ) REFERENCES Job_advertisement ( "id" ),
 CONSTRAINT FK_217 FOREIGN KEY ( Job_advertisement_id ) REFERENCES Employer ( "id" )
);

CREATE INDEX fkIdx_215 ON Observe
(
 employer_id
);

CREATE INDEX fkIdx_219 ON Observe
(
 Job_advertisement_id
);




CREATE TABLE Observes_and_reviews
(
 job_advertisement_id uuid NOT NULL,
 worker_id            serial NOT NULL,
 "date"                  NOT NULL,
 CONSTRAINT PK_246 PRIMARY KEY ( job_advertisement_id, worker_id ),
 CONSTRAINT FK_243 FOREIGN KEY ( job_advertisement_id ) REFERENCES Job_advertisement ( "id" ),
 CONSTRAINT FK_247 FOREIGN KEY ( worker_id ) REFERENCES Worker ( "id" )
);

CREATE INDEX fkIdx_245 ON Observes_and_reviews
(
 job_advertisement_id
);

CREATE INDEX fkIdx_249 ON Observes_and_reviews
(
 worker_id
);




CREATE TABLE Requests
(
 status              boolean NOT NULL,
 data                 NOT NULL,
 job_advertisment_id uuid NOT NULL,
 worker_id           serial NOT NULL,
 CONSTRAINT PK_231 PRIMARY KEY ( job_advertisment_id, worker_id ),
 CONSTRAINT FK_196 FOREIGN KEY ( job_advertisment_id ) REFERENCES Job_advertisement ( "id" ),
 CONSTRAINT FK_200 FOREIGN KEY ( worker_id ) REFERENCES Worker ( "id" )
);

CREATE INDEX fkIdx_198 ON Requests
(
 job_advertisment_id
);

CREATE INDEX fkIdx_202 ON Requests
(
 worker_id
);





