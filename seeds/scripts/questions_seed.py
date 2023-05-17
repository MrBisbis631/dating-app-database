import random


def get_questions_record_sql(id):
  return f"({id}, 'Question {id}', '{random.choice(['FAMILY', 'PERSONAL', 'CAREER', 'RELIGION'])}')"


def questions_record_generator():
  questions_range = range(1, 501)
  for i in questions_range:
    yield get_questions_record_sql(i)


if __name__ == "__main__":
  with open("questions_seed.sql", "a") as f:
    f.write("INSERT INTO questions (id, content, q_category) VALUES\n")
    for i, record in enumerate(questions_record_generator()):
      f.write(record)
      if i == 499:
        f.write(";\n")
      else:
        f.write(",\n")
