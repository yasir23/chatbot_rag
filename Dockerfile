# Base image
FROM python:3.12-slim


# Set working directory
WORKDIR /app


RUN pip install poetry

COPY ./pyproject.toml /app/

RUN poetry config virtualenvs.create false

RUN poetry install


COPY . /app/
# COPY ./src/retrieval_graph/ /deps/chatbot_rag/src/retrieval_graph/

# ENV PYTHONPATH=/app/src
# Command to run the application
CMD ["python", "-m", "/retrieval_graph/graph"]