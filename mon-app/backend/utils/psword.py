from werkzeug.security import generate_password_hash

password = "akre"

hashed = generate_password_hash(password)

print(hashed)