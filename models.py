#(Mapea tus tablas de pgAdmin a clases de Python)

from sqlalchemy import Column, Integer, String, Text
from database import Base

class Estructura(Base):
    __tablename__ = "estructuras"

    id = Column(Integer, primary_key=True, index=True)
    categoria = Column(String(100))
    estructura_formula = Column(String(150))
    ejemplo_ingles = Column(String(250))
    ejemplo_espanol = Column(String(250))

class FraseComun(Base):
    __tablename__ = "frases_comunes"

    id = Column(Integer, primary_key=True, index=True)
    frase_ingles = Column(String(250), nullable=False)
    frase_espanol = Column(String(250), nullable=False)

class Cancion(Base):
    __tablename__ = "canciones"

    id = Column(Integer, primary_key=True, index=True)
    titulo = Column(String(150))
    artista = Column(String(150))
    estrofa_ingles = Column(Text, nullable=False)
    estrofa_espanol = Column(Text, nullable=False)