import random
import string

number_of_records = 8_000

admin_range = range(1, 2000)
match_macker_range = range(2000, 4000)
client_m_range = range(4000, 6000)
client_f_range = range(6000, 8000)

def get_user_role(id):
  if id in admin_range:
    return "ADMIN"
  elif id in match_macker_range:
    return "MATCH_MACKER"
  elif id in client_m_range:
    return "CLIENT_M"
  elif id in client_f_range:
    return "CLIENT_F"
  else:
    return 'CLIENT_F'


def random_string(length):
  return ''.join(random.choice(string.ascii_letters) for _ in range(length))


def random_number(length):
  return ''.join(random.choice(string.digits) for _ in range(length))


def random_email():
  return random_string(10) + '@' + random_string(5) + '.com'


def random_user(id):
  return {
    "id": id,
    "first_name": random_string(10),
    "last_name": random_string(10),
    "user_role": get_user_role(id),
    "password_hash": "password_hash",
    "password_salt": "password_salt",
    "mail": random_email(),
    "phone": random_string(10),
    "created_at": "TO_DATE('1994-12-16 12:00:00', 'yyyy-MM-dd hh:mi:ss')",
  }
  

def user_to_sql_record(user):
  return f"""({user["id"]}, '{user["first_name"]}', '{user["last_name"]}', '{user["user_role"]}', '{user["password_hash"]}', '{user["password_salt"]}', '{user["mail"]}', '{user["phone"]}', {user["created_at"]})"""


def generate_users(length):
  for i in range(1, length + 1):
    yield user_to_sql_record(random_user(i))


def create_user_see_sql_file(records_number, filename="users_seed.sql"):
  with open(filename, "a") as f:
    f.write("INSERT INTO users (id, first_name, last_name, user_role, password_hash, password_salt, mail, phone, created_at) VALUES\n")
    for i, user in enumerate(generate_users(records_number)):
      f.write(user)
      if i != records_number - 1:
        f.write(",\n")
    f.write(";\n")
    


if __name__ == "__main__":
  create_user_see_sql_file(number_of_records)