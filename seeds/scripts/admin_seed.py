
def get_sql_date():
  return "TO_DATE('1994-12-16 12:00:00', 'yyyy-MM-dd hh:mi:ss')"


def admin_record(id):
  return f"({id}, {get_sql_date()})"


def generate_admins():
  admin_range = range(1, 2000)
  for i in admin_range:
    yield admin_record(i)
    

if __name__ == "__main__":
  with open("admin_seed.sql", "a") as f:
    f.write("INSERT INTO app_admin (id, last_password_updae) VALUES\n")
    for i, admin in enumerate(generate_admins()):
      f.write(admin)
      if i != 1999:
        f.write(",\n")
    f.write(";\n")  