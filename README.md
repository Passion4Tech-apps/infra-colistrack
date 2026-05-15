# 🏗️ infra-colistrack

Infrastructure et configuration de déploiement du projet **ColisTrack**.

## 🧱 Stack technique

| Composant | Technologie |
|-----------|-------------|
| Frontend | Svelte / JavaScript |
| Backend | Python / Django |
| Base de données | PostgreSQL 16 |
| Cache | Redis 7 |
| Monitoring | Uptime Kuma |
| Orchestration | Docker Compose |

---

## 📁 Structure du repo

```
infra-colistrack/
├── docker-compose.yml        # Configuration principale
├── Makefile                  # Commandes utiles
├── .env.example              # Variables d'environnement (template)
├── backups/                  # Sauvegardes BDD
└── README.md
```

> Les dossiers `be-colistrack/` et `fe-colistrack/` sont les repos du backend et frontend,
> à cloner au même niveau que ce repo.

---

## ⚙️ Prérequis

- [Docker](https://docs.docker.com/get-docker/) >= 24.x
- [Docker Compose](https://docs.docker.com/compose/install/) >= 2.x
- `make` installé sur la machine

---

## 🚀 Installation

### 1. Cloner les repos

```bash
# Repo infra (ce repo)
git clone git@github.com:Passion4Tech-apps/infra-colistrack.git

# Repo backend
git clone git@github.com:Passion4Tech-apps/be-colistrack.git

# Repo frontend
git clone git@github.com:Passion4Tech-apps/fe-colistrack.git
```

Assure-toi que les trois dossiers sont au **même niveau** :

```
colistrack/
├── infra-colistrack/
├── be-colistrack/
└── fe-colistrack/
```

### 2. Configurer les variables d'environnement

```bash
cd infra-colistrack
cp .env.example .env
# Édite le fichier .env avec tes valeurs
```

Configure également les `.env` du backend et du frontend :

```bash
cp ../be-colistrack/.env.example ../be-colistrack/.env
cp ../fe-colistrack/.env.example ../fe-colistrack/.env
```

### 3. Lancer le projet

```bash
make up
```

### 4. Appliquer les migrations

```bash
make migrate
```

### 5. Créer un superutilisateur Django

```bash
make createsuperuser
```

---

## 🌐 Accès aux services

| Service | URL |
|---------|-----|
| Frontend | http://localhost:5000 |
| Backend / API | http://localhost:8000 |
| Admin Django | http://localhost:8000/admin |
| Uptime Kuma | http://localhost:3001 |
| PostgreSQL | localhost:${DB_EXTERNAL_PORT} |

---

## 🛠️ Commandes Makefile

```bash
make up               # Démarrer tous les conteneurs en arrière-plan
make down             # Arrêter tous les conteneurs
make restart          # Redémarrer le backend
make logs             # Suivre les logs du backend en temps réel
make migrate          # Créer et appliquer les migrations Django
make shell            # Ouvrir le shell Django
make createsuperuser  # Créer un superutilisateur Django
make seed             # Insérer les données de test
make flush            # Vider les données de test
make reset            # Tout supprimer et relancer (⚠️ supprime les volumes)
make backup           # Sauvegarder la base de données
make exportjson       # Exporter les données en JSON
```

---

## 🔐 Variables d'environnement

Copie `.env.example` en `.env` et remplis les valeurs :

```env
# PostgreSQL
DB_NAME=colistrack
DB_USER=
DB_PASSWORD=
DB_EXTERNAL_PORT=5433   # Port exposé sur la machine hôte (5432 en interne)
```

> ⚠️ Ne jamais committer les fichiers `.env` — ils sont dans le `.gitignore`.

---

## 📦 Services Docker

| Service | Image | Port exposé |
|---------|-------|-------------|
| `backend` | build local | 8000 |
| `frontend` | build local | 5000 → 3000 |
| `db` | postgres:16-alpine | ${DB_EXTERNAL_PORT} → 5432 |
| `redis` | redis:7-alpine | — |
| `uptime-kuma` | louislam/uptime-kuma | 3001 |

---

## 💾 Sauvegardes

Les sauvegardes de la base de données sont stockées dans `backups/`.

```bash
# Lancer une sauvegarde manuellement
make backup
```

---

## 🔗 Repos liés

- [be-colistrack](https://github.com/Passion4Tech-apps/be-colistrack) — Backend Django
- [fe-colistrack](https://github.com/Passion4Tech-apps/fe-colistrack) — Frontend Svelte

---

## 📄 Licence

MIT