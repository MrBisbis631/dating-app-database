-- indexes on users table for user_role column
CREATE INDEX users_role_index
  ON users (user_role)
  COMPUTE STATISTICS;


-- indexes on client_category table for client_category column
CREATE INDEX client_category_index
  ON client_category (client_category)
  COMPUTE STATISTICS;


-- ------------------------------- inaffective indexes -------------------------------
CREATE INDEX users_id_index
  ON users (id)
  COMPUTE STATISTICS;

CREATE INDEX users_email_index
  ON users (email)
  COMPUTE STATISTICS;
