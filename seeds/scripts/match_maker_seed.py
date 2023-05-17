
import random


def get_random_sql_bool():
  return random.choice(["Y", "N"])


def get_random_admin_id():
  return random.randint(1, 2000)


def match_macker_record(id):
  return f"({id}, '{get_random_sql_bool()}', {get_random_admin_id()})"


def generate_match_mackers():
  match_macker_range = range(2000, 4000)
  for i in match_macker_range:
    yield match_macker_record(i) 
    
    
if __name__ == "__main__":
  with open("match_macker_seed.sql", "a") as f:
    f.write("INSERT INTO match_maker (id, is_charging, auth_admin_id) VALUES\n")
    for i, match_macker in enumerate(generate_match_mackers()):
      f.write(match_macker)
      if i != 3999:
        f.write(",\n")
    f.write(";\n")
