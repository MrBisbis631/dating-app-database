CREATE TABLE user
(
  id INT NOT NULL,
  first_name VARCHAR2(50 CHAR) NOT NULL,
  last_name VARCHAR2(50 CHAR) NOT NULL,
  role ENUM(ADMIN, MATCH_MAKER, CLIENT_M, CLIENT_F) NOT NULL,
  password_hash VARCHAR2(64 BYTE) NOT NULL,
  password_salt VARCHAR2(64 BYTE) NOT NULL,
  mail VARCHAR2(50 CHAR) NOT NULL,
  phone INT NOT NULL,
  created_at DATE NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (mail),
  UNIQUE (phone)
);

CREATE TABLE admin
(
  last_password_update DATE NOT NULL,
  id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES user(id)
);

CREATE TABLE match_maker
(
  is_charging BOOLEAN NOT NULL,
  id INT NOT NULL,
  auth_admin_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES user(id),
  FOREIGN KEY (auth_admin_id) REFERENCES admin(id)
);

CREATE TABLE client
(
  photo_url VARCHAR2(150 CHAR) NOT NULL,
  birthday DATE NOT NULL,
  summery VARCHAR2(250 CHAR) NOT NULL,
  gender ENUM(M, F) NOT NULL,
  category ENUM(MARRIED, SINGLE, DIVORCED, BLACK_LIST) NOT NULL,
  is_dating BOOLEAN NOT NULL,
  id INT NOT NULL,
  match_maker_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES user(id),
  FOREIGN KEY (match_maker_id) REFERENCES match_maker(id)
);

CREATE TABLE client_m
(
  served_in_army BOOLEAN NOT NULL,
  client_id INT NOT NULL,
  PRIMARY KEY (client_id),
  FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE client_f
(
  did_national_service BOOLEAN NOT NULL,
  client_id INT NOT NULL,
  PRIMARY KEY (client_id),
  FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE question
(
  id INT NOT NULL,
  content VARCHAR2(150 CHAR) NOT NULL,
  category ENUM(FAMILY, PERSONAL, CAREER, RELIGION) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE personal_diary
(
  id INT NOT NULL,
  created_at DATE NOT NULL,
  updated_at DATE NOT NULL,
  content VARCHAR2(450 CHAR) NOT NULL,
  category ENUM(IMPORTANT, INFO, NORMAL) NOT NULL,
  author_id INT NOT NULL,
  client_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (author_id) REFERENCES match_maker(id),
  FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE match_diary
(
  id INT NOT NULL,
  created_at DATE NOT NULL,
  content VARCHAR2(450 CHAR) NOT NULL,
  status ENUM(FAILURE, SUCCESS, IN_PROGRESS) NOT NULL,
  author_id INT NOT NULL,
  client_m_id INT NOT NULL,
  client_f_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (author_id) REFERENCES match_maker(id),
  FOREIGN KEY (client_m_id) REFERENCES client_m(client_id),
  FOREIGN KEY (client_f_id) REFERENCES client_f(client_id)
);

CREATE TABLE sherd_by
(
  permission ENUM(AUTHOR, ADD, MATCH) NOT NULL,
  client_id INT NOT NULL,
  from_mm_id INT NOT NULL,
  to_mm_id INT NOT NULL,
  PRIMARY KEY (client_id, from_mm_id, to_mm_id),
  FOREIGN KEY (client_id) REFERENCES client(id),
  FOREIGN KEY (from_mm_id) REFERENCES match_maker(id),
  FOREIGN KEY (to_mm_id) REFERENCES match_maker(id)
);

CREATE TABLE answer_option
(
  content VARCHAR2(50 CHAR) NOT NULL,
  option_id INT NOT NULL,
  question_id INT NOT NULL,
  PRIMARY KEY (option_id, question_id),
  FOREIGN KEY (question_id) REFERENCES question(id)
);

CREATE TABLE answerer
(
  comment VARCHAR2(250 CHAR),
  client_id INT NOT NULL,
  question_id INT NOT NULL,
  option_id INT NOT NULL,
  PRIMARY KEY (client_id, question_id, option_id),
  FOREIGN KEY (client_id) REFERENCES client(id),
  FOREIGN KEY (question_id, option_id) REFERENCES answer_option(question_id, option_id)
);
