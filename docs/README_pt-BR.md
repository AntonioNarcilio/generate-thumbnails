<p align="center">
  <img width="13%" src="../.github/icon.svg">

  <h3 align="center"><b>Gerador de miniaturas</b></h3>
  <p align="center">Crie miniaturas a partir de um video de forma simples e pratica</p>

  <img src="../.github/thumbnails-preview.gif">
</p>

---

<br>
<h2 id="dependencies">🛠️ Dependências</h2>

Para que o script de geração de miniaturas funcione conforme o esperado, antes você precisar ter as seguintes dependências instaladas em sua maquina.


<h3><a href="https://apps.kde.org/kdialog/"><b>Kdialog</b></a></h4>
<p align="justify"> 
  <b>Onde é utilizado ?</b> <br>
  Utilizado nas notificações popup e em diálogos como:

  > Obtenção de senha de super usuário/administrador (utilizado no arquivo de instalação);

  >Escolha da grade na geração da miniatura;

  >Mostra mensagens (popup) contendo informações sobre o processo de geração das miniaturas ...

  <b>Como instalar ?</b> <br>
  Primeiro verifique se você possui o kdialog instalado em sua maquina (se preferir o arquivo `install.sh` faz essa verificação para você).
  ~~~bash
  kdialog --version
  ~~~
  
  > 💡 Se retornar algo diferente `kdialog <numero_da_versao>` é sinal que você não tem tal dependência instalada em sua maquina se for o caso siga para o proximo passo.

  Não irei me aprofundar muito nessa questão pois existe "outras formas de se instalar tal" aplicação, mais de forma bem sucinta execute no terminal um dos comandos:

  ##### Distros Debian
  ~~~bash
  sudo apt update
  ~~~
  ~~~bash
  sudo apt install kdialog -y
  ~~~
  >ou simplificando
  ~~~bash
  sudo apt update && sudo apt install kdialog -y
  ~~~  
  ##### Distro Arch Linux
  ~~~bash
  $ sudo pacman -Sy kdialog
  ~~~

  > 💡 Para mais, clique no nome `kdialog` (em azul) lá no inicio do tópico; onde você será redirecionado para a pagina oficial da aplicação.

</p>

---

<h3><a href="https://www.ffmpeg.org/download.html"><b>FFmpeg</b></a></h4>
<p align="justify"> 
  <b>Onde é utilizado ?</b> <br>  
  Utilizado na geração das miniaturas (arquivos separados) em um intervalo de tempo...

  <b>Como instalar ?</b> <br>
  Primeiro verifique se você possui o ffmpeg instalado em sua maquina (se preferir o arquivo `install.sh` faz essa verificação para você).
  ~~~bash
  ffmpeg -version
  ~~~
  
  > 💡 Se retornar algo diferente `ffmpeg version <numero_da_versao> Copyright ...` é sinal que você não tem tal dependência instalada em sua maquina se for o caso siga para o proximo passo.
  
  Conforme descrito no processo de instalação do kdialog, faço a mesma citação aqui [...] Execute no terminal um dos comandos:

  ##### Distros Debian
  ~~~bash
  sudo apt update
  ~~~
  ~~~bash
  sudo apt install ffmpeg -y
  ~~~
  > ou simplificando
  ~~~bash
  sudo apt update && sudo apt install ffmpeg -y
  ~~~  
  ##### Distro Arch Linux
  ~~~bash
  $ sudo pacman -Sy ffmpeg
  ~~~

  > 💡 Para mais, clique no nome `FFmpeg` (em azul) lá no inicio do tópico; onde você será redirecionado para a pagina oficial da aplicação.

</p>

---

<h3><a href="https://imagemagick.org/script/download.php"><b>ImageMagick</b></a></h4>
<p align="justify"> 
  <b>Onde é utilizado ?</b> <br>  
  O ImageMagick é uma ferramenta de manipulação de imagem via linha de comando poderosíssima. Aqui ele/ela é utilizado na conversão das miniaturas separadas em um arquivo final (união dos arquivos) e otimização do mesmo.

  <b>Como instalar ?</b> <br>
  Primeiro verifique se você possui o imagemagick instalado em sua maquina (se preferir o arquivo `install.sh` faz essa verificação para você).
  ~~~bash
  convert --version
  ~~~
  
  > 💡 Se retornar algo diferente `Version: ImageMagick  <numero_da_versao> Copyright ...` é sinal que você não tem tal dependência instalada em sua maquina se for o caso siga para o proximo passo.

  Conforme descrito nos dois processo de instalação anteriormente, faço a mesma citação aqui [...] Execute no terminal um dos comandos:

  ##### Distros Debian
  ~~~bash
  sudo apt update
  ~~~
  ~~~bash
  sudo apt install imagemagick -y
  ~~~
  > ou simplificando
  ~~~bash
  sudo apt update && sudo apt install imagemagick -y
  ~~~  
  ##### Distro Arch Linux
  ~~~bash
  $ sudo pacman -Sy imagemagick
  ~~~

  > 💡 Para mais, clique no nome `ImageMagick` (em azul) lá no inicio do tópico; onde você será redirecionado para a pagina oficial da aplicação.

</p>

---

<br>
<h2 id="features">🛸 Funcionalidades</h2>

- Geração de miniaturas via linha de comando. [Veja como usar](#how-to-use).
- Geração de miniaturas via menu de contexto no gerenciador de arquivos [dolphin](https://apps.kde.org/dolphin/). [Veja como usar](#how-to-use).
- Opção de escolha entre qual grade o arquivo final contendo as miniaturas terá. 

<br>
<h2 id="format-support">📽 Formatos de video identificados</h2>

  Por padrão os seguintes formatos são identificados ao tentar gerar uma miniatura, via linha de comando (terminal) ou pelo gerenciador de arquivo dolphin.

  |       | Extensões |        |
  |:-----:| :-------: |:------:|
  |`.avi` |     -     | `.mp4` |
  |`.m4v` |     -     | `.mov` |
  |`.mpg` |     -     | `.mpeg`|
  |`.wmv` |     -     | `.mkv` |
  |`.ts`  |     -     |        |
  
  <br>

> 💡 No gerenciador de arquivo dolphin por exemplo o "atalho" no menu de contexto so aparecerá se você selecionar um video que tenha uma dessa extensões especificadas acima. Leia mais em [como usar]()

<br>
<h2 id="how-to-use">🤔 Como usar ?</h2>
  
  


<br>

criado por [@antonionarcilio](https://linkedin.com/in/antonionarcilio)