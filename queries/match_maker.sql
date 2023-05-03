CREATE VIEW
  all_match_maker AS
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
  is_charging,
  auth_admin_id
FROM
  user
WHERE
  role = 'match_maker'
  INNER JOIN match_maker ON user.id = match_maker.user_id;
