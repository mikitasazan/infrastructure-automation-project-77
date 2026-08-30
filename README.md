## Infrastructure as Code

[![Actions Status](https://github.com/mikitasazan/infrastructure-automation-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/mikitasazan/infrastructure-automation-project-77/actions)

Учебный проект по созданию AWS-инфраструктуры через Terraform и настройке
серверов через Ansible. Terraform создаёт сеть, две VM, балансировщик,
сертификат, управляемую базу и мониторинг Datadog; Ansible устанавливает
Docker и запускает приложение.

## Структура

- `terraform/` — провайдеры, backend, VM, Load Balancer, ACM, RDS и Datadog;
- `ansible/` — плейбук, переменные и systemd-задачи;
- `ansible/db_info.json` — локальный файл, который Terraform создаёт после
  `apply` и который Ansible передаёт контейнеру.

## Требования

- OpenTofu/Terraform и AWS CLI;
- Ansible 2.12+, `community.docker` и `datadog.dd`;
- AWS-аккаунт с правами на EC2, ELB, ACM, Route53, RDS и S3 backend;
- Datadog API/App keys;
- SSH-ключ, доступный Terraform и Ansible.

Все секреты передаются через защищённые `.tfvars` и `ansible_secrets.yml`.
Эти файлы игнорируются Git; `terraform/encrypted.file` хранит зашифрованные
данные для учебного сценария.

## Порядок запуска

```bash
make -C terraform up
make -C ansible deploy
```

Перед `apply` настройте `terraform/backend.hcl`, DNS-зону и переменные
Terraform. Перед Ansible проверьте сгенерированный `ansible/db_info.json` и
инвентарь. Для удаления тестовой инфраструктуры используйте
`make -C terraform down`.

## Проверки

```bash
tofu -chdir=terraform fmt -check -recursive
tofu -chdir=terraform validate
ansible-playbook --syntax-check -i ansible/hosts.ini ansible/playbook.yml
