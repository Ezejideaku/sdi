from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from models import User
from db import db

users_bp = Blueprint('users', __name__)

@users_bp.route('/', methods=['GET'])
@jwt_required()
def get_users():
    return jsonify([u.to_dict() for u in User.query.all()]), 200

@users_bp.route('/', methods=['POST'])
@jwt_required()
def create_user():
    data = request.get_json()
    user = User(nom=data['nom'], email=data['email'], category_id=data.get('category_id'))
    user.set_password(data['password'])
    db.session.add(user); db.session.commit()
    return jsonify(user.to_dict()), 201

@users_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_user(id):
    user = User.query.get_or_404(id)
    db.session.delete(user); db.session.commit()
    return jsonify({'message': 'Utilisateur supprimé'}), 200
