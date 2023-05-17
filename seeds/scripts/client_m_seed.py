import random

def get_client_m_record(id):
  served = random.choice(["Y", "N"])
  return f"('{served}', {id})"


def client_m_record_generator():
  clients_range = range(4000, 6000)
  for i in clients_range:
    yield get_client_m_record(i)


if __name__ == "__main__":
  with open("client_m_seed.sql", "a") as f:
    f.write("INSERT INTO client_m (served_in_army, client_id) VALUES\n")
    for i, record in enumerate(client_m_record_generator()):
      f.write(record)
      if i == 5999:
        f.write(";\n")
      else:
        f.write(",\n")
