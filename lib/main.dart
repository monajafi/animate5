import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with TickerProviderStateMixin{
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2),vsync: this);
    animation = CurvedAnimation(parent: controller,curve: Curves.easeIn)
                ..addStatusListener((status){
                    if(status == AnimationStatus.completed){
                      controller.reverse();
                    }else if(status == AnimationStatus.dismissed){
                      controller.forward();
                    }
                });
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation: animation,);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.1,end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0,end: 300);

  AnimatedLogo({Key key,Animation<double> animation}):
                super(key:key,listenable:animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          width: _sizeTween.evaluate(animation),
          height: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
  
}