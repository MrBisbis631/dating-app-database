"""
  photo_url VARCHAR2(150 CHAR) NOT NULL,
  birthday DATE NOT NULL,
  summery VARCHAR2(250 CHAR) NOT NULL,
  gender VARCHAR2(1) CONSTRAINT gender_check CHECK (gender IN ('M', 'F')),
  client_category VARCHAR2(10) CONSTRAINT client_category_check CHECK (client_category IN ('MARRIED', 'SINGLE', 'DIVORCED', 'BLACK_LIST')),
  is_dating VARCHAR2(1) CONSTRAINT is_dating_check CHECK (is_dating in ('Y', 'N')),
  id INT NOT NULL,
  match_maker_id INT NOT NULL,
"""
import random


def get_random_sql_bool():
  return random.choice(["Y", "N"])


def get_random_sql_gender():
  return random.choice(["M", "F"])


def get_random_sql_category():
  return random.choice(["SINGLE", "DIVORCED", "BLACK_LIST", "MARRIED"])


def get_sql_date():
  return "TO_DATE('1994-12-16 12:00:00', 'yyyy-MM-dd hh:mi:ss')"


def get_random_photo_url():
  return "https://randomuser.me/api/portraits/lego/" + str(random.randint(0, 8)) + ".jpg"


def get_random_sql_summery():
  return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod, nisl eget aliquam aliquam, nisl nunc aliquam elit, vitae aliq"


def get_random_sql_mm_id():
  return str(random.randint(2000, 4000))


def get_random_record(id):
  gender = "M" if id < 6000 else "F"
  return f"('{get_random_photo_url()}', {get_sql_date()}, '{get_random_sql_summery()}', '{gender}', '{get_random_sql_category()}', '{get_random_sql_bool()}', {id}, {get_random_sql_mm_id()})"

def clients_record_generator():
  clients_range = range(4000, 8001)
  for i in clients_range:
    yield get_random_record(i)
    
    
if __name__ == "__main__":
  with open("clients_seed.sql", "a") as f:
    f.write("INSERT INTO clients (  photo_url, birthday, summery, gender, client_category, is_dating, id, match_maker_id) VALUES")
    for i, record in enumerate(clients_record_generator()):
      f.write(record)
      if i == 7999:
        f.write(";")
      else:
        f.write(",\n")
