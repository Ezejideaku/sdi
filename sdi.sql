-- supprimer la base de donnée
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- ===============================
-- 1️⃣ Création des types ENUM
-- ===============================

CREATE TYPE role_name AS ENUM (
    'ADMINISTRATEUR',
    'GREFFIER',
    'JUGE',
    'AGENT PENITENTIAIRE'
);


CREATE TYPE statut_detenu AS ENUM (
    'EN_DETENTION',
    'TRANSFERE',
    'LIBERE'
);

CREATE TYPE type_document_enum AS ENUM (
    'MANDAT_DEPOT',
    'JUGEMENT',
    'ORDONNANCE',
    'AUTORISATION_TRANSFERT'
);

-- ===============================
-- 2️⃣ Table roles
-- ===============================

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nom_role role_name UNIQUE NOT NULL
);

-- ===============================
-- 3️⃣ Table users
-- ===============================

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role_id INTEGER NOT NULL,

    CONSTRAINT fk_role
        FOREIGN KEY (role_id)
        REFERENCES roles(id)
        ON DELETE RESTRICT
);

--CREATE INDEX idx_users_role ON users(role_id);

-- ===============================
-- 4️⃣ Table detenus
-- ===============================

CREATE TABLE detenus (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    date_naissance DATE NOT NULL,
    numero_dossier VARCHAR(100) UNIQUE NOT NULL,
    statut statut_detenu DEFAULT 'EN_DETENTION',
    lieu_detention VARCHAR(150) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from detenus;
CREATE INDEX idx_detenu_numero ON detenus(numero_dossier);

-- ===============================
-- 5️⃣ Table documents_juridiques
-- ===============================

CREATE TABLE documents_juridiques (
    id SERIAL PRIMARY KEY,
    type_document type_document_enum NOT NULL,
    fichier_path TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cree_par INTEGER NOT NULL,
    detenu_id INTEGER NOT NULL,

    CONSTRAINT fk_user_document
        FOREIGN KEY (cree_par)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_detenu_document
        FOREIGN KEY (detenu_id)
        REFERENCES detenus(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_document_detenu ON documents_juridiques(detenu_id);

































--DROP TYPE role_name CASCADE;
/*SELECT typname
FROM pg_type
WHERE typname = 'role_name';*/

/*SELECT enumlabel
FROM pg_enum
JOIN pg_type ON pg_enum.enumtypid = pg_type.oid
WHERE pg_type.typname = 'role_name';

select typname from pg_type
where typname = "statut_detenu";*/

-- ===============================
-- 6️⃣ Table logs_echanges
-- ===============================

/*CREATE TABLE logs_echanges (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    action TEXT NOT NULL,
    adresse_ip INET NOT NULL,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_log_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_logs_user ON logs_echanges(user_id);
CREATE INDEX idx_logs_ip ON logs_echanges(adresse_ip);

-- ===============================
-- 7️⃣ Insertion des rôles par défaut
-- ===============================

INSERT INTO roles (nom_role) VALUES
('JUGE'),
('GREFFIER'),
('REGISSEUR_PRISON'),
('ADMIN_SI');

select * from roles;*/















/*

-- supprimer la base de donnée
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- ===============================
-- 1️⃣ Création des types ENUM
-- ===============================

CREATE TYPE role_name AS ENUM (
    'ADMINISTRATEUR',
    'GREFFIER',
    'JUGE',
    'AGENT PENITENTIAIRE'
);

--DROP TYPE role_name CASCADE;
/*SELECT typname
FROM pg_type
WHERE typname = 'role_name';*/

/*SELECT enumlabel
FROM pg_enum
JOIN pg_type ON pg_enum.enumtypid = pg_type.oid
WHERE pg_type.typname = 'role_name';

select typname from pg_type
where typname = "statut_detenu";*/

CREATE TYPE statut_detenu AS ENUM (
    'EN_DETENTION',
    'TRANSFERE',
    'LIBERE'
);

CREATE TYPE type_document_enum AS ENUM (
    'MANDAT_DEPOT',
    'JUGEMENT',
    'ORDONNANCE',
    'AUTORISATION_TRANSFERT'
);

-- ===============================
-- 2️⃣ Table roles
-- ===============================

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nom_role role_name UNIQUE NOT NULL
);

-- ===============================
-- 3️⃣ Table users
-- ===============================

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role_id INTEGER NOT NULL,
    institution VARCHAR(150) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_role
        FOREIGN KEY (role_id)
        REFERENCES roles(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_users_role ON users(role_id);

-- ===============================
-- 4️⃣ Table detenus
-- ===============================

CREATE TABLE detenus (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    date_naissance DATE NOT NULL,
    numero_dossier VARCHAR(100) UNIQUE NOT NULL,
    statut statut_detenu DEFAULT 'EN_DETENTION',
    lieu_detention VARCHAR(150) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_detenu_numero ON detenus(numero_dossier);

-- ===============================
-- 5️⃣ Table documents_juridiques
-- ===============================

CREATE TABLE documents_juridiques (
    id SERIAL PRIMARY KEY,
    type_document type_document_enum NOT NULL,
    fichier_path TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cree_par INTEGER NOT NULL,
    detenu_id INTEGER NOT NULL,

    CONSTRAINT fk_user_document
        FOREIGN KEY (cree_par)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_detenu_document
        FOREIGN KEY (detenu_id)
        REFERENCES detenus(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_document_detenu ON documents_juridiques(detenu_id);

-- ===============================
-- 6️⃣ Table logs_echanges
-- ===============================

CREATE TABLE logs_echanges (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    action TEXT NOT NULL,
    adresse_ip INET NOT NULL,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_log_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_logs_user ON logs_echanges(user_id);
CREATE INDEX idx_logs_ip ON logs_echanges(adresse_ip);

-- ===============================
-- 7️⃣ Insertion des rôles par défaut
-- ===============================

INSERT INTO roles (nom_role) VALUES
('JUGE'),
('GREFFIER'),
('REGISSEUR_PRISON'),
('ADMIN_SI');

select * from roles;*/