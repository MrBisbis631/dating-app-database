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
  user
WHERE
  role = 'admin'
INNER JOIN admin ON user.id = admin.user_id;
