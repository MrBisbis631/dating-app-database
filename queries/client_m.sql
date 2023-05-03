CREATE VIEW
  all_client_m AS
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
  photo_url,
  birthday,
  summery,
  gender,
  category,
  is_dating,
  served_in_army
FROM
  user
WHERE
  role = 'client_m'
  INNER JOIN client ON user.id = client.user_id
  INNER JOIN client_m ON client_m.id = client_m.user_id;