"""  ans_comment
  client_id
  question_id
  option_id"""


import random


def answers_generator():
  for q_id in range(1, 501):
    for client_id in range(5000, 7001):
      yield f"('lorem q_id: {q_id}, c_id: {client_id}', {client_id}, {q_id}, {random.choice([1, 2, 3, 4])})"
      
      
if __name__ == "__main__":
  with open("answers_seed.sql", "a") as f:
    f.write("INSERT INTO answers (ans_comment, client_id, question_id, option_id) VALUES\n")
    for i, record in enumerate(answers_generator()):
      f.write(record)
      if i == 500 * 2000 - 1:
        f.write(";\n")
      else:
        f.write(",\n")