from flask import Flask
from flask_cors import CORS
from config import Config
from db import db
from routes.auth import auth_bp
from routes.categories import categories_bp
from routes.permissions import permissions_bp
from routes.users import users_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    CORS(app)
    db.init_app(app)
    app.register_blueprint(auth_bp, url_prefix='/api/auth')
    app.register_blueprint(categories_bp, url_prefix='/api/categories')
    app.register_blueprint(permissions_bp, url_prefix='/api/permissions')
    app.register_blueprint(users_bp, url_prefix='/api/users')
    with app.app_context():
        db.create_all()
    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)
