<html>

<head>
<meta http-equiv="Content-Language" content="es">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<font size="4"><b><i>Comunicación bidireccional por bus I<sup>2</sup>C
      entre un PC y un microcontrolador PIC de gama media actuando como servidor
      de eco.&nbsp;</i></b></font>
      <p>Por Alejandro Alonso Puig<br>
      Noviembre 2.003<br>
  <hr>
<p align="justify"><br>
Este repositorio incorpora el código e informe técnico 
que describe un sistema de comunicación por bus I<sup>2</sup>C
entre un PC y un microcontrolador PIC de gama media (PIC16F87x) que actuará
como servidor de eco, devolviendo al PC el último byte que le haya sido
enviado. Este sistema estará compuesto por los siguientes elementos
Hardware/Software:&nbsp;</p>
<p align="justify"><u>Hardware</u>&nbsp;</p>
  <li>
    <p align="left">PC&nbsp;</li>
  <li>
    <p align="left">Tarjeta interface puerto paralelo/bus I<sup>2</sup>C K8000 de
    Velleman&nbsp;</li>
  <li>
    <p align="left">Placa con Microcontrolador PIC16F876</li>
<br>
<p align="justify"><u>Software</u>&nbsp;</p>
  <li>
    <p align="left">Librerías en Visual C++ para el control de la tarjeta
    interface&nbsp;</li>
  <li>
    <p align="left">Aplicación en Visual C++ para el envío y recepción de
    datos por bus&nbsp; I<sup>2</sup>C</li>
  <li>
    <p align="left">Programa servidor de eco en ensamblador para PIC</li>
<br>
<img border="0" src="Link.jpg" width="310" height="349"></td>
 <br>
 <p align="justify">Este desarrollo pretende simplemente dar un origen para
futuros trabajos basados en comunicaciones I<sup>2</sup>C entre PC y
microcontroladores, ya que tanto el programa servidor de eco, como la
aplicación de envío y recepción de bytes del PC, pueden ser modificadas de
forma sencilla para otro tipo de aplicaciones, teniendo ya toda la comunicación
por bus I<sup>2</sup>C implementada.</p>
<p align="justify">Aunque el trabajo ha sido desarrollado sobre plataforma
Windows 98 y con lenguaje Visual C++ 6.0, en el documento se indicará donde
encontrar información para hacer desarrollos similares sobre plataforma Linux o
Windows NT/2000/XP y otros lenguajes, como Visual Basic, Qbasic, Pascal, Borland
C y Java. Asimismo se hará mención a un sustituto de la placa K8000 en caso de
que el lector no pueda disponer de ella.</p>
<ul>
  <li>
    <p align="justify"><a href="I2cPC.pdf">Informe Técnico</a>   <font size="1">
    (.PDF 700kb)</font></li>
  <li>
    <p align="justify"><a href="LibW9xVCpp.zip">Librerías para
    Visual C++
    sobre Windows 9x</a><font size="2">  </font><font size="1">(.ZIP 150kb)</font></li>
  <li>
    <p align="justify"><a href="I2C_Com.zip">Programa Master de ejemplo en
    Visual C++</a><font size="2">   </font><font size="1">(.ZIP 43kb)</font></li>
  <li>
    <p align="justify"><a href="ECOI2C01_Slave.ASM">Slave servidor de eco en
    ensamblador</a><font size="1">(.ASM 9Kb)</font><font size="2">&nbsp;</font></li>
</ul>
<p><b>Nota</b>: Master y Slave han de estar conectados mediante tres hilos:
Masa, SCL y SDA. El módulo presentado incluye las resistencias de PullUp, por
lo que no es necesario añadirlas.</p>
<p>
  <br>


</body>

</html>
