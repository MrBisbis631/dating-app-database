CREATE TABLE users (
id INT NOT NULL,
first_name VARCHAR2(50 CHAR) NOT NULL,
last_name VARCHAR2(50 CHAR) NOT NULL,
user_role VARCHAR2(10) CONSTRAINT user_role_check CHECK (user_role IN ('ADMIN', 'MATCH_MACKER', 'CLIENT_M', 'CLIENT_F')),
password_hash VARCHAR2(64 BYTE) NOT NULL,
password_salt VARCHAR2(64 BYTE) NOT NULL,
mail VARCHAR2(50 CHAR) UNIQUE NOT NULL,
phone VARCHAR(25 CHAR) UNIQUE NOT NULL,
created_at DATE NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE app_admin (
id INT NOT NULL,
last_password_updae DATE NOT NULL,

PRIMARY KEY(id),
FOREIGN KEY (id) REFERENCES users(id) 
);

CREATE TABLE match_maker (
id INT NOT NULL,
is_charging VARCHAR2(1) CONSTRAINT is_charging_check CHECK (is_charging in ('Y', 'N')),
auth_admin_id INT NOT NULL,

PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES users(id)
);

CREATE TABLE clients
(
  photo_url VARCHAR2(150 CHAR) NOT NULL,
  birthday DATE NOT NULL,
  summery VARCHAR2(250 CHAR) NOT NULL,
  gender VARCHAR2(1) CONSTRAINT gender_check CHECK (gender IN ('M', 'F')),
  client_category VARCHAR2(10) CONSTRAINT client_category_check CHECK (client_category IN ('MARRIED', 'SINGLE', 'DIVORCED', 'BLACK_LIST')),
  is_dating VARCHAR2(1) CONSTRAINT is_dating_check CHECK (is_dating in ('Y', 'N')),
  id INT NOT NULL,
  match_maker_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES users(id),
  FOREIGN KEY (match_maker_id) REFERENCES match_maker(id)
);

CREATE TABLE client_m
(
  served_in_army VARCHAR2(1) CONSTRAINT serverd_in_army_check CHECK (served_in_army IN ('Y', 'N')),
  client_id INT NOT NULL,
  PRIMARY KEY (client_id),
  FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE client_f
(
  did_national_service VARCHAR2(1) CONSTRAINT did_national_service_check CHECK (did_national_service IN ('Y', 'N')),
  client_id INT NOT NULL,
  PRIMARY KEY (client_id),
  FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE questions
(
  id INT NOT NULL,
  content VARCHAR2(150 CHAR) NOT NULL,
  q_category VARCHAR2(1) CONSTRAINT q_category_check CHECK (q_category IN ('FAMILY', 'PERSONAL', 'CAREER', 'RELIGION')),
  PRIMARY KEY (id)
);

CREATE TABLE answer_options
(
  content VARCHAR2(50 CHAR) NOT NULL,
  option_id INT NOT NULL,
  question_id INT NOT NULL,
  PRIMARY KEY (option_id, question_id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE answers
(
  ans_comment VARCHAR2(250 CHAR),
  client_id INT NOT NULL,
  question_id INT NOT NULL,
  option_id INT NOT NULL,
  UNIQUE (client_id, question_id),
  PRIMARY KEY (client_id, question_id, option_id),
  FOREIGN KEY (client_id) REFERENCES clients(id),
  FOREIGN KEY (question_id, option_id) REFERENCES answer_options(question_id, option_id)
);

CREATE TABLE personal_diary
(
  id INT NOT NULL,
  created_at DATE NOT NULL,
  updated_at DATE NOT NULL,
  content VARCHAR2(450 CHAR) NOT NULL,
  category VARCHAR2 CONSTRAINT category_check CHECK (category IN ('IMPORTANT', 'INFO', 'NORMAL')),
  author_id INT NOT NULL,
  client_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (author_id) REFERENCES match_maker(id),
  FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE sherd_by
(
  permission VARCHAR(10) CONSTRAINT permission_check CHECK (permission IN ('AUTHOR', 'ADD', 'MATCH')),
  client_id INT NOT NULL,
  from_mm_id INT NOT NULL,
  to_mm_id INT NOT NULL,
  PRIMARY KEY (client_id, from_mm_id, to_mm_id),
  FOREIGN KEY (client_id) REFERENCES clients(id),
  FOREIGN KEY (from_mm_id) REFERENCES match_maker(id),
  FOREIGN KEY (to_mm_id) REFERENCES match_maker(id)
);

CREATE TABLE match_diary
(
  id INT NOT NULL,
  created_at DATE NOT NULL,
  updated_at DATE NOT NULL,
  content VARCHAR2(450 CHAR) NOT NULL,
  match_diary_category VARCHAR2(15 CHAR) CONSTRAINT match_diary_category_check CHECK (match_diary_category IN ('IMPORTANT', 'INFO', 'NORMAL')),
  author_id INT NOT NULL,
  client_m_id INT NOT NULL,
  client_f_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (author_id) REFERENCES match_maker(id),
  FOREIGN KEY (client_m_id) REFERENCES client_m(client_id),
  FOREIGN KEY (client_f_id) REFERENCES client_f(client_id)
);
