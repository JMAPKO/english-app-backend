#(Donde se crean las rutas/endpoints que va a consumir Flutter)

from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from sqlalchemy import func
from typing import List

# Importamos nuestros módulos locales
from database import engine, Base, get_db
import models, schemas

# Le decimos a SQLAlchemy que revise la base de datos y cree lo que falte
Base.metadata.create_all(bind=engine)

app = FastAPI(title="API de Inglés Personal")

# ¡Mucha atención acá! Esto es el CORS Middleware.
# Permite que tu aplicación de Flutter (desde el celu o emulador) 
# pueda hacer peticiones a esta API sin que Windows o el navegador la bloqueen.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # En desarrollo permitimos cualquier origen
    allow_credentials=True,
    allow_methods=["*"],  # Permite GET, POST, PUT, DELETE, etc.
    allow_headers=["*"],
)

@app.get("/")
def inicio():
    return {"mensaje": "API de Inglés funcionando correctamente"}


# ==========================================
# SECCIÓN 1: ESTRUCTURAS GRAMATICALES
# ==========================================

@app.get("/estructuras", response_model=List[schemas.EstructuraCreate])
def obtener_estructuras(db: Session = Depends(get_db)):
    # Trae todas las estructuras ordenadas por categoría
    return db.query(models.Estructura).order_by(models.Estructura.categoria).all()

@app.post("/estructuras")
def guardar_estructura(estructura: schemas.EstructuraCreate, db: Session = Depends(get_db)):
    nueva_est = models.Estructura(**estructura.dict())
    db.add(nueva_est)
    db.commit()
    db.refresh(nueva_est)
    return {"status": "Estructura guardada", "id": nueva_est.id}


# ==========================================
# SECCIÓN 2: FRASES COMUNES (ALEATORIAS)
# ==========================================

@app.get("/frases", response_model=List[schemas.FraseCreate])
def obtener_frases_aleatorias(db: Session = Depends(get_db)):
    # func.random() hace que PostgreSQL mezcle las filas antes de enviarlas
    # Así en Flutter siempre te aparecerán en orden aleatorio
    return db.query(models.FraseComun).order_by(func.random()).all()


@app.post("/frases")
def guardar_frase(frase: schemas.FraseCreate, db: Session = Depends(get_db)):
    nueva_frase = models.FraseComun(**frase.dict())
    db.add(nueva_frase)
    db.commit()
    db.refresh(nueva_frase)
    return {"status": "Frase común guardada", "id": nueva_frase.id}


# ==========================================
# SECCIÓN 3: CANCIONES (ALEATORIAS)
# ==========================================

@app.get("/canciones")
def obtener_canciones_aleatorias(db: Session = Depends(get_db)):
    # Al igual que las frases, se mezclan de forma aleatoria en la BD
    return db.query(models.Cancion).order_by(func.random()).all()

 
@app.post("/canciones")
def guardar_cancion(cancion: schemas.CancionCreate, db: Session = Depends(get_db)):
    nueva_cancion = models.Cancion(**cancion.dict())
    db.add(nueva_cancion)
    db.commit()
    db.refresh(nueva_cancion)
    return {"status": "Canción guardada con éxito", "id": nueva_cancion.id} 
    

   
  