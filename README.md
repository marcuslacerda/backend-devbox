# SIGO "development box"
Regras para um bom ambiente de desenvolvimento
* Isolado
* Utilizar mesmas ferramentas de produção
* Reproduzivel
* Level e fácil

## Introduction

Isso é um [Vagrant](https://www.vagrantup.com/) box para configuração do ambiente de desenvolvimento virtualizado.

1. [Uso](#usage)
2. [Instalação](#setup)
3. [Curtomize sua máquina virtual](#customize)
4. [Configure your new box and install new software](#configure)

## <a name="usage"></a> Usage

O SIGO "development box" é um ambiente de desenvolvimento completo para desenvolvedores do SIGO[].

É necessário ter o [Vagrant](https://www.vagrantup.com/) e [Virtualbox](www.virtualbox.org) instalado no seu host.

Esse ambiente é configurado com ferramentas Open Source, especialmente:

- Ubuntu
- Git
- Maven
- OpenJDK (Oracle JDK can't be used because of license issues)
- Yarn, NPM, Bower and Gulp
- Docker e Docker Compose
- [Ubuntu Make](https://wiki.ubuntu.com/ubuntu-make) que permite uma fácil instalação do seu IDE favorito (type `umake ide idea` for Intellij IDEA or `umake ide eclipse` for Eclipse)
- Chromium e Firefox Web browsers

Esse "development box" também tem vários utilitários para trabalhar com o ambiente corporativo:

- MongoDB client
- Cassandra command line (cqlsh)
- Cloud Foundry command line (cf)
- Heroku toolbelt

## <a name="setup"></a> Installation

Siga o procedimento abaixo para gerar um "development box"


```shell
$ git clone https://github.com/marcuslacerda/cielo-devbox.git
$ cd cielo-devbox
$ vagrant up
```
Esse comando cria uma máquina virtual ubuntu e faz toda a instalação de softwares e configuração necessário para o correto funcionando, seguinto os procedimentos do arquivo /scripts/setup.sh

## <a name="customize"></a> Customize seu ambiente de desenvolviment

Nos recomendamos uma configuração de hardware no host de pelo menos:
- 4 CPUs
- 16 Gb of RAM
- 128 Mb of video RAM

## <a name="configure"></a> Configure your new box and install new software

Start up the new box:

- Login: conecte no ambiente utilizando o usuário vagrant/vagrant

- Configue o proxy (se necessário).
  - rode o arquivo ~/Desktop/config_proxy.sh
  - configure o proxy da placa de rede.

- Configura seu teclado. Por default o layout US é utilizado.
  - Abra `Settings > Keyboard`
  - Open the `Layout` tab
  - Untick the `Use system default` box
  - Use the `+` sign to add your keyboard layout

- Configure your IDE
  - Use [Ubuntu Make](https://wiki.ubuntu.com/ubuntu-make) so you can easily install your favorite IDE:
    - Type `umake ide eclipse` for Eclipse

## Problemas conhecidos
- portalcielocloud.ccorp.local/vcac não funciona
- dns nao funciona. exemplo git-corp.ccorp.local/
- configurar /etc/hosts
- ferramentas não configuradas por default
  - ruby
  - groovy
  - node
  - gradle
  - postman
  - soapUI
  - eclipse
  - HeidiSQL - free
