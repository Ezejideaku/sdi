from models import User

def authenticate(email, password):
    user = User.query.filter_by(email=email).first()
    if user and user.check_password(password):
        return user
    return None

def has_permission(user, permission_code):
    return permission_code in user.get_permissions()
