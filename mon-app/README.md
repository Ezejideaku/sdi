# Mon App — Gestion de catégories et droits utilisateurs

## Stack
- **Frontend** : HTML + CSS + JS (Vanilla)
- **Backend** : Flask (Python)
- **Base de données** : PostgreSQL

## Installation

### 1. Base de données
```bash
psql -U postgres -c "CREATE DATABASE mon_app_db;"
psql -U postgres -d mon_app_db -f backend/schema.sql
```

### 2. Backend
```bash
cd backend
pip install -r requirements.txt
export DATABASE_URL="postgresql://user:password@localhost:5432/mon_app_db"
export SECRET_KEY="votre-secret"
export JWT_SECRET_KEY="votre-jwt-secret"
python app.py
```

### 3. Frontend
```bash
cd frontend
python -m http.server 8080
# Ouvrir http://localhost:8080
```

## Endpoints API
| Méthode | Route | Description |
|---------|-------|-------------|
| POST | /api/auth/login | Connexion |
| GET | /api/auth/me | Utilisateur courant |
| GET | /api/categories/ | Liste des catégories |
| POST | /api/categories/ | Créer une catégorie |
| PUT | /api/categories/:id | Modifier une catégorie |
| DELETE | /api/categories/:id | Supprimer une catégorie |
| POST | /api/categories/:id/permissions | Assigner des permissions |
| GET | /api/permissions/ | Liste des permissions |
| POST | /api/permissions/ | Créer une permission |
| GET | /api/users/ | Liste des utilisateurs |
| POST | /api/users/ | Créer un utilisateur |
| DELETE | /api/users/:id | Supprimer un utilisateur |
