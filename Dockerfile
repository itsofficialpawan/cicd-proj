FROM python:3.9.19-slim
RUN pip install streamlit
RUN mkdir /myapp
WORKDIR /myapp
COPY . .
EXPOSE 8501
CMD ["streamlit", "run", "app.py"]
