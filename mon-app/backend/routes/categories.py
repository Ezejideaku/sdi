from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from models import Category, Permission
from db import db

categories_bp = Blueprint('categories', __name__)

@categories_bp.route('/', methods=['GET'])
@jwt_required()
def get_categories():
    return jsonify([c.to_dict() for c in Category.get_all()]), 200

@categories_bp.route('/<int:id>', methods=['GET'])
@jwt_required()
def get_category(id):
    return jsonify(Category.get_by_id(id).to_dict()), 200

@categories_bp.route('/', methods=['POST'])
@jwt_required()
def create_category():
    data = request.get_json()
    cat = Category.create(nom=data['nom'], description=data.get('description'))
    return jsonify(cat.to_dict()), 201

@categories_bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def update_category(id):
    data = request.get_json()
    cat = Category.get_by_id(id)
    cat.update(nom=data.get('nom'), description=data.get('description'))
    return jsonify(cat.to_dict()), 200

@categories_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_category(id):
    Category.get_by_id(id).delete()
    return jsonify({'message': 'Catégorie supprimée'}), 200

@categories_bp.route('/<int:id>/permissions', methods=['POST'])
@jwt_required()
def assign_permissions(id):
    data = request.get_json()
    cat = Category.get_by_id(id)
    cat.permissions = Permission.query.filter(Permission.code.in_(data.get('permissions', []))).all()
    db.session.commit()
    return jsonify(cat.to_dict()), 200
