# Workshop DevOps na Nuvem - Laboratório LocalStack

Este repositório contém a infraestrutura como código (IaC) desenvolvida durante o Workshop DevOps na Nuvem. O foco é a criação de um ambiente AWS completo simulado localmente via **LocalStack**.

## 🚀 Tecnologias Utilizadas
* **Terraform**: Orquestração da infraestrutura.
* **LocalStack**: Emulação de serviços AWS (VPC, S3, EC2, NAT Gateway).
* **Docker & Docker Compose**: Gerenciamento do container do LocalStack.

## 🏗️ Arquitetura de Rede
A rede foi desenhada seguindo as melhores práticas de alta disponibilidade e segurança:
* **VPC**: 10.0.0.0/24.
* **Subnets Públicas**: Localizadas em `us-east-1a` e `us-east-1b` para recursos com acesso à internet.
* **Subnets Privadas**: Camada isolada para recursos internos.
* **NAT Gateway**: Configurado para permitir saída controlada das subnets privadas.
* **Internet Gateway**: Ponto de entrada/saída para o tráfego público.

## 🛠️ Como Executar
1. Inicie o ambiente LocalStack:
   ```Bash
   docker-compose up -d
   ```
   Nota: O ambiente conta com um script de bootstrap (setup-backend.sh) mapeado no container. Ele cria automaticamente o bucket S3 necessário para o backend do Terraform assim que o LocalStack fica pronto.

2. Entre na pasta do laboratório:
    ```Bash
    cd 01-networking   
    ```
3. Inicialize e aplique o Terraform:
    ```Bash
    terraform init
    terraform apply -auto-approve
    ```