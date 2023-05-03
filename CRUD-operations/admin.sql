-- view of admin users
CREATE VIEW all_admin AS
SELECT
  id,
  first_name,
  last_name,
  role,
  password_hash,
  password_salt,
  email,
  phone,
  created_at,
  last_password_update
FROM
  users
WHERE
  role = 'admin'
  LEFT JOIN admin ON users.id = admin.user_id
WHERE
  users.id = admin.user_id;
