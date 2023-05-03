-- view for all client female 
CREATE VIEW
  all_client_f AS
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
  did_national_service
FROM
  user
WHERE
  role = 'client_f'
  INNER JOIN client ON user.id = client.user_id
  INNER JOIN client_f ON client_m.id = client_f.user_id;
