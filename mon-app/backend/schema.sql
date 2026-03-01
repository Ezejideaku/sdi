CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS permissions (
    id SERIAL PRIMARY KEY,
    code VARCHAR(100) UNIQUE NOT NULL,
    label VARCHAR(200),
    module VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS category_permissions (
    category_id INT REFERENCES categories(id) ON DELETE CASCADE,
    permission_id INT REFERENCES permissions(id) ON DELETE CASCADE,
    PRIMARY KEY (category_id, permission_id)
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    category_id INT REFERENCES categories(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Seed
INSERT INTO permissions (code, label, module) VALUES
    ('view_dashboard', 'Voir le tableau de bord', 'dashboard'),
    ('create_user', 'Créer un utilisateur', 'users'),
    ('edit_user', 'Modifier un utilisateur', 'users'),
    ('delete_user', 'Supprimer un utilisateur', 'users'),
    ('manage_categories', 'Gérer les catégories', 'categories'),
    ('view_reports', 'Voir les rapports', 'reports')
ON CONFLICT DO NOTHING;

INSERT INTO categories (nom, description) VALUES
    ('Administrateur', 'Accès complet'),
    ('Manager', 'Gestion utilisateurs et rapports'),
    ('Visiteur', 'Lecture seule')
ON CONFLICT DO NOTHING;
