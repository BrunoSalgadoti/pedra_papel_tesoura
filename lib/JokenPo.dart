import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class JokenPo extends StatefulWidget {
  const JokenPo({Key? key}) : super(key: key);

  @override
  _JokenPoState createState() => _JokenPoState();
}

class _JokenPoState extends State<JokenPo> {

// ----EXECUTANDO AUDIOS -------------------------------------------------------

  AudioCache _audioCache = AudioCache(prefix: "assets/sons/");

  _executar ( String nomeAudio ) {

    _audioCache.play( nomeAudio + ".mp3");

  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      "Applause.mp3", "Female.mp3",
      "Whaaat.mp3"
    ]);  }
// -----------------------------------------------------------------------------

  String _titulo = "Escolhas: \n  joken Po  Vs   usuário";
  var _imagemAPP = const AssetImage("imagens/joken_po/padrao.png");
  var _imagemUSU = const AssetImage("imagens/joken_po/padrao.png");
  var _wins = const AssetImage("imagens/joken_po/branco.JPG");

  var _resultado = "Resultado: Boa Sorte!";
  int _vitoriaUSU = 0;
  int _vitoriaAPP = 0;
  int _npartidas = 0;

  void _opcaoSelecionada(String escolhaUsuario){

    _npartidas++;

    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(opcoes.length);
    var escolhaAPP = opcoes[numero];

    // Escolha do APP
    switch( escolhaAPP ){

      case "pedra" :
        setState(() {
          _imagemAPP = const AssetImage("imagens/joken_po/pedra.png");
        });
        break;

      case "papel" :
        setState(() => _imagemAPP = const AssetImage("imagens/joken_po/papel.png"));
        break;

      case "tesoura" :
        setState(() {
          _imagemAPP = const AssetImage("imagens/joken_po/tesoura.png");
        });
        break;
    }

    // Escolha do Usuário
    if ( escolhaUsuario == "pedra"){
      setState(() {
        _imagemUSU = const AssetImage("imagens/joken_po/pedra.png");
      });
    } else if ( escolhaUsuario == "papel"){
      setState(() {
        _imagemUSU = const AssetImage("imagens/joken_po/papel.png");
      });
    }else if (escolhaUsuario == "tesoura"){
      setState(() {
        _imagemUSU = const AssetImage("imagens/joken_po/tesoura.png");
      });
    }

    // Verificação do resultado *****
    if (
    (escolhaUsuario == "pedra" && escolhaAPP == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaAPP == "papel") ||
        (escolhaUsuario == "papel" && escolhaAPP == "pedra")
    ){
      setState(() {
        _vitoriaUSU++;
        _resultado = ("Você Ganhou, Parabéns!!");
        _wins = const AssetImage("imagens/joken_po/fogosvitoria.gif");
        _executar("Applause");
      });
    } else if (
    (escolhaUsuario == "tesoura" && escolhaAPP == "pedra") ||
        (escolhaUsuario == "papel" && escolhaAPP == "tesoura") ||
        (escolhaUsuario == "pedra" && escolhaAPP == "papel")
    ){
      setState(() {
        _vitoriaAPP++;
        _resultado = ("Você Perdeu, Tente Novamente!! :/");
        _wins = const AssetImage("imagens/joken_po/lose.gif");
        _executar("Female");
      });
    }else{
      setState(() {
        _resultado = ("Empatamos!!! :) :)");
        _wins = const AssetImage("imagens/joken_po/draw.gif");
        _executar("Whaaat");
      });
    } //**********

    setState(() {

      _titulo = "Escolhas: Nº Partidas + ($_npartidas) \n  "
          "Joken Po($_vitoriaAPP)  Vs   Usuário ($_vitoriaUSU)";
    });

  }

  // Função Limpar Tela
  void _limpar (){
    setState(() {
      _imagemAPP = const AssetImage("imagens/joken_po/padrao.png");
      _imagemUSU = const AssetImage("imagens/joken_po/padrao.png");
      _resultado = "Boa Sorte!";
      _wins = const AssetImage("imagens/joken_po/branco.JPG");
      _vitoriaUSU = 0;
      _vitoriaAPP = 0;
      _titulo = "Escolhas: \n  Joken Po  Vs   Usuário";
      _npartidas = 0;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar: AppBar(
          title: const Text("JOGO : Pedra, papel ou tesoura"),

        ),

        body: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget> [
              /* Escopo do Projeto
                    1º Passo - text
                    2º Passo - imagem
                    3º Passo - text resultado
                    4º Passo - linha 3 imagens
                    5º Imagem Logo BRN (Bruno Salgado TI)
                    */
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),

                child: Text(
                  _titulo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[

                    Image(image: _imagemAPP),
                    Image(image: _imagemUSU),

                  ]
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),

                child: Text(
                  "Escolha uma opção abaixo:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [

                    GestureDetector(
                      onTap:  () => _opcaoSelecionada("pedra"),
                      child: Image.asset("imagens/joken_po/pedra.png", height: 100,),
                    ),

                    GestureDetector(
                      onTap:  () => _opcaoSelecionada("papel") ,
                      child: Image.asset("imagens/joken_po/papel.png", height: 100,) ,
                    ),

                    GestureDetector(
                      onTap:  () => _opcaoSelecionada("tesoura"),
                      child: Image.asset("imagens/joken_po/tesoura.png", height: 100,),
                    ),

                  ]
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5),

                child: Text(
                  "Resultado: " + _resultado,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [

                  Image(image: _wins),

                ],
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [

                    Image.asset("imagens/logobrn.png",
                      height: 90, width: 120,
                    ),

                    //NOVO BUTTON
                    ElevatedButton(
                      onPressed: _limpar,

                      child: const Text(
                        "Reiniciar",
                        style: TextStyle(
                          fontSize: 20,
                          decorationColor: Colors.black,
                        ),
                      ),

                      //ElevatedButton CUSTOMIZAÇÃO

                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.amber,
                          elevation: 20,
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),

                  ]),
            ],),

        )

    );
  }
}


