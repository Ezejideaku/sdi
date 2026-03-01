from db import db

class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text)
    permissions = db.relationship('Permission', secondary='category_permissions', backref='categories')

    @classmethod
    def get_all(cls): return cls.query.all()
    @classmethod
    def get_by_id(cls, id): return cls.query.get_or_404(id)
    @classmethod
    def create(cls, nom, description=None):
        cat = cls(nom=nom, description=description)
        db.session.add(cat); db.session.commit(); return cat

    def update(self, nom=None, description=None):
        if nom: self.nom = nom
        if description: self.description = description
        db.session.commit()

    def delete(self):
        db.session.delete(self); db.session.commit()

    def to_dict(self):
        return {'id': self.id, 'nom': self.nom, 'description': self.description,
                'permissions': [p.to_dict() for p in self.permissions]}
