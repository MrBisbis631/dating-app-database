import random


def get_client_f_record(id):
  served = random.choice(["Y", "N"])
  return f"('{served}', {id})"


def client_f_record_generator():
  clients_range = range(6000, 8001)
  for i in clients_range:
    yield get_client_f_record(i)
    
    
if __name__ == "__main__":
  with open("client_f_seed.sql", "a") as f:
    f.write("INSERT INTO client_f (did_national_service, client_id) VALUES\n")
    for i, record in enumerate(client_f_record_generator()):
      f.write(record)
      if i == 7999:
        f.write(";\n")
      else:
        f.write(",\n")
