from db import db

category_permissions = db.Table(
    'category_permissions',
    db.Column('category_id', db.Integer, db.ForeignKey('categories.id'), primary_key=True),
    db.Column('permission_id', db.Integer, db.ForeignKey('permissions.id'), primary_key=True)
)

class Permission(db.Model):
    __tablename__ = 'permissions'
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(100), unique=True, nullable=False)
    label = db.Column(db.String(200))
    module = db.Column(db.String(100))

    @classmethod
    def get_all(cls):
        return cls.query.all()

    def to_dict(self):
        return {'id': self.id, 'code': self.code, 'label': self.label, 'module': self.module}
