#(Maneja la conexión a Postgres)


from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# CONFIGURACIÓN: Cambiá 'tu_contraseña' por la que usás para entrar a pgAdmin
DATABASE_URL = "postgresql://postgres:0000@localhost:5432/EnglishApp"

# El engine es el motor encargado de gestionar las conexiones
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

# Esta función abre una sesión con la BD cada vez que entra una petición de Flutter y la cierra al terminar
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()