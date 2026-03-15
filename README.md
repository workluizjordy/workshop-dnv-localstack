# Workshop DevOps na Nuvem - Laboratório LocalStack

Este repositório contém a infraestrutura como código (IaC) desenvolvida durante o Workshop DevOps na Nuvem. O foco é a criação de um ambiente AWS completo simulado localmente via **LocalStack**.

## 🚀 Tecnologias Utilizadas
* **Terraform**: Orquestração da infraestrutura.
* **LocalStack**: Emulação de serviços AWS (VPC, S3, EC2, NAT Gateway).
* **Docker & Docker Compose**: Gerenciamento do container do LocalStack.
* **Kind (Kubernetes in Docker)**: Criação de um cluster Kubernetes local.
* **K9s**: Interface de linha de comando (CLI) para gerenciamento interativo do Kubernetes.

## 🏗️ Arquitetura de Rede
A rede foi desenhada seguindo as melhores práticas de alta disponibilidade e segurança:
* **VPC**: 10.0.0.0/24.
* **Subnets Públicas**: Localizadas em `us-east-1a` e `us-east-1b` para recursos com acesso à internet.
* **Subnets Privadas**: Camada isolada para recursos internos.
* **NAT Gateway**: Configurado para permitir saída controlada das subnets privadas.
* **Internet Gateway**: Ponto de entrada/saída para o tráfego público.

## 🛠️ Como Executar

### Laboratório 1: Rede (VPC)

1. Inicie o ambiente LocalStack:
   ```Bash
   docker-compose up -d
   ```
   Nota: O ambiente conta com um script de bootstrap (setup-backend.sh) mapeado no container. Ele cria automaticamente o bucket S3 necessário para o backend do Terraform assim que o LocalStack fica pronto.

2. Entre na pasta do laboratório de rede:
    ```Bash
    cd 01-networking   
    ```
3. Inicialize e aplique o Terraform para criar a VPC:
    ```Bash
    terraform init -reconfigure
    terraform apply -auto-approve
    ```

### Laboratório 2: Kubernetes com Kind

> **Nota**: A criação de clusters EKS é um recurso da versão Pro do LocalStack. Para este laboratório, utilizaremos o **Kind (Kubernetes in Docker)** como uma alternativa leve e eficiente para rodar um cluster Kubernetes localmente, enquanto usamos o Terraform para gerenciar recursos de suporte (como Roles de IAM) no LocalStack.

4. Instale o Kind (se ainda não tiver):
   ```bash
   # Para Linux/WSL
   curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
   chmod +x ./kind
   sudo mv ./kind /usr/local/bin/kind
   ```

5. (Opcional) Instale o K9s para gerenciar o cluster via terminal:
   ```bash
   # Para Linux/WSL
   curl -L -o k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz
   tar -xvzf k9s.tar.gz
   sudo mv k9s /usr/local/bin/
   rm k9s.tar.gz LICENSE README.md
   ```

6. Crie o cluster Kubernetes com o Kind:
   ```bash
   # O arquivo kind-config.yaml já está na raiz do projeto.
   kind create cluster --name workshop-dnv --config kind-config.yaml
   ```

7. Conecte o cluster Kind à rede do LocalStack:
   Isso permite que as aplicações dentro do Kubernetes acessem os serviços AWS simulados (S3, DynamoDB, etc.).
   ```bash
   docker network connect localstack-net workshop-dnv-control-plane
   ```

8. Crie as Roles de IAM para o cluster:
   Navegue até a pasta `02-eks-cluster` e aplique o Terraform. Ele criará apenas as Roles, pois os recursos do cluster EKS estão comentados no código.
   ```bash
   cd ../02-eks-cluster
   terraform init -reconfigure
   terraform apply -auto-approve
   ```

Seu ambiente com Rede e Kubernetes local está pronto! Para verificar o cluster, use `kubectl get nodes` ou execute o `k9s` para uma visão interativa.