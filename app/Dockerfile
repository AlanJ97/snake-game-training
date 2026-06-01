# syntax=docker/dockerfile:1

# Imagen base: Python 3.12 en variante slim (ligera) sobre Debian.
# Coincide con la version usada en desarrollo (Python 3.12).
FROM python:3.12-slim

# Variables de entorno utiles para Python dentro del contenedor:
# - PYTHONDONTWRITEBYTECODE: no genera archivos .pyc
# - PYTHONUNBUFFERED: muestra los logs en tiempo real (sin buffer)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Directorio de trabajo dentro de la imagen
WORKDIR /app

# Primero copiamos solo requirements para aprovechar la cache de capas:
# si el codigo cambia pero las dependencias no, no se reinstala todo.
COPY requirements.txt ./

# Instala las dependencias sin guardar cache de pip (imagen mas chica)
RUN pip install --no-cache-dir -r requirements.txt

# Ahora copiamos el codigo de la app (entrypoint y paquete del juego)
COPY app.py ./
COPY snake_game ./snake_game

# Crea un usuario sin privilegios y le da la propiedad del directorio de la app.
# Buena practica de seguridad: no correr el contenedor como root.
RUN useradd --create-home appuser \
    && chown -R appuser:appuser /app
USER appuser

# Puerto en el que escucha la aplicacion (documenta el puerto del contenedor)
EXPOSE 8000

# Comando por defecto: arranca Gunicorn (servidor WSGI de produccion)
# enlazando a 0.0.0.0 para aceptar trafico externo (necesario en ECS).
# "app:app" = modulo app.py, variable app (instancia de Flask).
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "2", "app:app"]
