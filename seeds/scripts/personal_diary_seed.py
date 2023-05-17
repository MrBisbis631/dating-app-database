"""  id INT NOT NULL,
  created_at DATE NOT NULL,
  updated_at DATE NOT NULL,
  content VARCHAR2(450 CHAR) NOT NULL,
  category VARCHAR2 CONSTRAINT category_check CHECK (category IN ('IMPORTANT', 'INFO', 'NORMAL')),
  author_id INT NOT NULL,
  client_id INT NOT NULL,"""

import random


def personal_diary_generator():
  date_sql_string = "TO_DATE('1994-12-16 12:00:00', 'yyyy-MM-dd hh:mi:ss')" 
  for i in range(1, 2001):
    yield rf"({i}, {date_sql_string}, {date_sql_string}, 'Personal diary {i}', '{random.choice(['IMPORTANT', 'INFO', 'NORMAL'])}', {random.randint(2000, 3000)}, {random.randint(4500, 7000)})"
    
    
if __name__ == "__main__":
  with open("personal_diary_seed.sql", "a") as f:
    f.write("INSERT INTO personal_diary (id, created_at, updated_at, content, category, author_id, client_id) VALUES\n")
    for i, record in enumerate(personal_diary_generator()):
      f.write(record)
      if i == 1999:
        f.write(";\n")
      else:
        f.write(",\n")
