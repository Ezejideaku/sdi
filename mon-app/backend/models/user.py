from db import db
from werkzeug.security import generate_password_hash, check_password_hash

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(100))
    email = db.Column(db.String(150), unique=True, nullable=False)
    password_hash = db.Column(db.Text)
    category_id = db.Column(db.Integer, db.ForeignKey('categories.id'))
    created_at = db.Column(db.DateTime, server_default=db.func.now())
    category = db.relationship('Category', backref='users')

    def set_password(self, password): self.password_hash = generate_password_hash(password)
    def check_password(self, password): return check_password_hash(self.password_hash, password)
    def get_permissions(self):
        if not self.category: return []
        return [p.code for p in self.category.permissions]

    def to_dict(self):
        return {'id': self.id, 'nom': self.nom, 'email': self.email,
                'category': self.category.nom if self.category else None,
                'permissions': self.get_permissions()}
