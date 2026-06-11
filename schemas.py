#(Define qué datos va a recibir y devolver la API)

from pydantic import BaseModel

# Qué datos necesitamos recibir para guardar una Estructura (Sección 1)
class EstructuraCreate(BaseModel):
    categoria: str
    estructura_formula: str
    ejemplo_ingles: str
    ejemplo_espanol: str

# Qué datos necesitamos recibir para guardar una Frase Nueva (Sección 2)
class FraseCreate(BaseModel):
    frase_ingles: str
    frase_espanol: str

# Qué datos necesitamos recibir para guardar una Canción Nueva (Sección 3)
class CancionCreate(BaseModel):
    titulo: str
    artista: str
    estrofa_ingles: str
    estrofa_espanol: str