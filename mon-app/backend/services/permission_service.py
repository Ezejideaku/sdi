from models import Category, Permission
from db import db

def assign_permissions_to_category(category_id, permission_codes):
    cat = Category.get_by_id(category_id)
    cat.permissions = Permission.query.filter(Permission.code.in_(permission_codes)).all()
    db.session.commit()
    return cat
