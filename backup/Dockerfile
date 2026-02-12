FROM python:3.12-slim AS builder
WORKDIR /app

#prevent python from  writing .pyc files and enable unbuffered logging

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# install build dependancies
RUN  apt-get update && apt-get install -y --no-install-recommends gcc python3-dev

# install dependancies into the temporary directory
COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

#--Stage 2: final stage--#

FROM python:3.12-slim

WORKDIR /app

# create non-root user 
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy only the installed packages from builder
COPY --from=builder /install /usr/local
COPY . .

# Set permissions
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
