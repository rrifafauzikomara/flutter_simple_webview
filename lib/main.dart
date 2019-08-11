import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String webUrl = 'https://cariaja.com/';
  final String title = 'Simple WebView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Click Me'),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return WebViewPage(
                  title: title,
                  webUrl: webUrl,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {

  final String webUrl;
  final String title;

  const WebViewPage({Key key, this.webUrl, this.title}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => WebviewScaffold(
          url: widget.webUrl,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(widget.title, style: TextStyle(color: Colors.black)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),),
          ),
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          initialChild: Container(
            child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    value: animation.value,
                  ),
                  height: 2.0,
                  width: double.infinity,
                )
            ),
          ),
        ),
      },
    );
  }

}
