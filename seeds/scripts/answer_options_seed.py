
def answer_options_generator():
  for q_id in range(1, 501):
    for opt_id in range(1, 5):
      yield f"('q: {q_id} opt:{opt_id}.', {opt_id}, {q_id})"


if __name__ == "__main__":
  with open("answer_options_seed.sql", "a") as f:
    f.write("INSERT INTO answer_options (content, option_id, question_id) VALUES\n")
    for i, record in enumerate(answer_options_generator()):
      f.write(record)
      if i == 4 * 500 - 1:
        f.write(";\n")
      else:
        f.write(",\n")