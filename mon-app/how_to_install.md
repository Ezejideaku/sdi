install python en utilisant ce lien : https://www.python.org/downloads/

fait cd chemin_vers_mon_app

créer un environnement virtuel en utilsant la commande: python -m venv .venv

positionne toi dans l'env virtuel : venv\Scripts\activate

fait cd pour aller dans le dossier backend du dossier mon_app

tape  pip install -r requirements.txt pour installer toutes les dépendences

ajouter C:\Program Files\PostgreSQL\17\bin aux variable d'environnement système [adapte l'adress vers le bin] pour pourvoir utiliser la commande postgre qui va suivre etant dans un terminal quelconque

redemarre ton vscode et positionne toi dans ton env virtuel

tape psql -U postgres -c "CREATE DATABASE mon_app_db;"   ça suppose que tu as déjà installer pgSQL

adapte l'URL dans config.py avec ton vrai mot de passe (quand tu installais pgSQL) comme suit: 
'postgresql://postgres:TON_MOT_DE_PASSE@localhost:5432/mon_app_db'

etant dans le dossier backend, tape python app.py