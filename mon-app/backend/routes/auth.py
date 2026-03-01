from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from models import User

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    user = User.query.filter_by(email=data.get('email')).first()
    if not user or not user.check_password(data.get('password')):
        return jsonify({'error': 'Email ou mot de passe incorrect'}), 401
    token = create_access_token(identity=user.id)
    return jsonify({'token': token, 'user': user.to_dict()}), 200

@auth_bp.route('/me', methods=['GET'])
@jwt_required()
def me():
    user = User.query.get_or_404(get_jwt_identity())
    return jsonify(user.to_dict()), 200
