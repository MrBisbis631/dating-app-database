"""
  id INT NOT NULL,
created_at DATE NOT NULL,
updated_at DATE NOT NULL,
content VARCHAR2(450 CHAR) NOT NULL,
match_diary_category VARCHAR2(15 CHAR) CONSTRAINT match_diary_category_check CHECK (match_diary_category IN ('IMPORTANT', 'INFO', 'NORMAL')),
author_id INT NOT NULL,
client_m_id INT NOT NULL,
client_f_id INT NOT NULL,
"""

import random


def rand_client_f_id():
  return random.randint(6000, 7000)

def rand_client_m_id():
  return random.randint(4000, 5000)

def rand_mm_id():
  return random.randint(2000, 3000)


def match_diary_generator():
  date_sql_string = "TO_DATE('1994-12-16 12:00:00', 'yyyy-MM-dd hh:mi:ss')" 
  for i in range(1, 2001):
    yield rf"({i}, {date_sql_string}, {date_sql_string}, 'Match diary {i}', '{random.choice(['IMPORTANT', 'INFO', 'NORMAL'])}', {rand_mm_id()}, {rand_client_m_id()}, {rand_client_f_id()})"
    
if __name__ == "__main__":
  with open("match_diary_seed.sql", "w") as f:
    f.write("INSERT INTO match_diary (id, created_at, updated_at, content, match_diary_category, author_id, client_m_id, client_f_id) VALUES\n")
    for i, record in enumerate(match_diary_generator()):
      f.write(record)
      if i == 1999:
        f.write(";\n")
      else:
        f.write(",\n")
