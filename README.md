```bash
docker compose up -d

uv sync

optimum-cli export onnx --model sentence-transformers/all-MiniLM-L12-v2 all-MiniLM-L12-v2_onnx/
```


1. Am pornit containerul Docker folosind
    ```bash
    docker compose up -d
    ``` 

2. Am configurat conexiunea
- Connection name: Oracle26ai
- User Info:
    - Authentication type: Default
    - Role: SYSDBA
    - Username: sys
    - Password: parola din docker-compose.yml
- Connection type: Basic
- Details:
    - Host name: localhost
    - Port: 1522
    - Type: Service Name
    - Service name: FREE

3. Am descărcat modelul de embedding de pe acest site și am urmat instrucțiunile: https://blogs.oracle.com/machinelearning/use-our-prebuilt-onnx-model-now-available-for-embedding-generation-in-oracle-database-23ai

4. 
    ```bash
    uv sync
    ```

5. Încărcăm embedding-urile în baza de date folosind scriptul `main.py`:
    ```bash
    python main.py
    ```
    