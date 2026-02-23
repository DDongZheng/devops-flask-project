# 第一阶段：构建阶段 (Build Stage)
FROM python:3.9-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# 第二阶段：运行阶段 (Run Stage)
FROM python:3.9-slim

RUN groupadd -r flaskuser && useradd -r -g flaskuser flaskuser

WORKDIR /app

COPY --from=builder /root/.local /home/flaskuser/.local
COPY . .

RUN chown -R flaskuser:flaskuser /app
USER flaskuser

ENV PATH=/home/flaskuser/.local/bin:$PATH

EXPOSE 5000
CMD ["python", "app.py"]

# 多阶段构建
# 减小最终镜像提及，不把构建工具带入生产环境