from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from models import Permission
from db import db

permissions_bp = Blueprint('permissions', __name__)

@permissions_bp.route('/', methods=['GET'])
@jwt_required()
def get_permissions():
    return jsonify([p.to_dict() for p in Permission.get_all()]), 200

@permissions_bp.route('/', methods=['POST'])
@jwt_required()
def create_permission():
    data = request.get_json()
    perm = Permission(code=data['code'], label=data.get('label'), module=data.get('module'))
    db.session.add(perm); db.session.commit()
    return jsonify(perm.to_dict()), 201
