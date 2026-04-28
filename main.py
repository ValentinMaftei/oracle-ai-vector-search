import oracledb
import os
from dotenv import load_dotenv
from langchain_text_splitters import RecursiveCharacterTextSplitter

load_dotenv()

user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
dsn = os.getenv("DB_DSN")


def insert_text_vector(file_path):
    with oracledb.connect(
        user=user, password=password, dsn=dsn, mode=oracledb.AUTH_MODE_SYSDBA
    ) as conn:
        cursor = conn.cursor()

        sql = """
            INSERT INTO documents (file_name, content, embedding)
            VALUES (:file_name, :content, VECTOR_EMBEDDING(ALL_MINILM_L12_V2 USING :content as data))
        """

        with open(file_path, "r") as f:
            text_input = f.read()
            
        text_splitter = RecursiveCharacterTextSplitter(chunk_size=200, chunk_overlap=50)
        chunks = text_splitter.split_text(text_input)

        for chunk in chunks:
            cursor.execute(sql, {"file_name": file_path, "content": chunk})
        conn.commit()


file_path = "texts/photo.txt"
insert_text_vector(file_path)
