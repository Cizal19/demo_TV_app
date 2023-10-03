import "package:flutter/material.dart";
import "package:flutter/services.dart";

void main() {
  runApp(MyApp());
}

class LeftButtonIntent extends Intent {}

class RightButtonIntent extends Intent {}

class UpButtonIntent extends Intent {}

class DownButtonIntent extends Intent {}

class EnterButtonIntent extends Intent {}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo TV App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // ThemeData
      home: MyHomePage(title: 'Demo TV App'),
    ); // MaterialApp
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IconData _selectedIcon = Icons.laptop;
  FocusNode? _icon1FocusNode;
  FocusNode? _icon2FocusNode;
  FocusNode? _icon3FocusNode;
  FocusNode? _icon4FocusNode;

  _setFirstFocus(BuildContext context) {
    if (_icon1FocusNode == null) {
      _icon1FocusNode = FocusNode();
      _icon2FocusNode = FocusNode();
      _icon3FocusNode = FocusNode();
      _icon4FocusNode = FocusNode();
      FocusScope.of(context).requestFocus(_icon1FocusNode);
    }
  }

  _changeFocus(BuildContext context, FocusNode node) {
    FocusScope.of(context).requestFocus(node);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _icon1FocusNode?.dispose();
    _icon2FocusNode?.dispose();
    _icon3FocusNode?.dispose();
    _icon4FocusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_icon1FocusNode == null) {
      _setFirstFocus(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowUp): UpButtonIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowDown): DownButtonIntent(),
            LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent(),
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Icon(
                _selectedIcon,
                size: 200.0,
              )),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Actions(
                    actions: <Type, Action<Intent>>{
                      RightButtonIntent:
                          CallbackAction<RightButtonIntent>(onInvoke: (intent) {
                        _selectedIcon = Icons.desktop_windows_outlined;
                        _changeFocus(context, _icon2FocusNode!);
                      }),
                    },
                    child: Focus(
                      focusNode: _icon1FocusNode,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: !(_icon1FocusNode?.hasFocus ?? false)
                                ? null
                                : Border.all(
                                    width: 5, color: Color(0xffeb1555))),
                        child: Icon(
                          Icons.laptop,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Actions(
                    actions: <Type, Action<Intent>>{
                      RightButtonIntent:
                          CallbackAction<RightButtonIntent>(onInvoke: (intent) {
                        _selectedIcon = Icons.desktop_mac_outlined;
                        _changeFocus(context, _icon3FocusNode!);
                      }),
                      LeftButtonIntent:
                          CallbackAction<LeftButtonIntent>(onInvoke: (intent) {
                        _selectedIcon = Icons.laptop;
                        _changeFocus(context, _icon1FocusNode!);
                      }),
                    },
                    child: Focus(
                      focusNode: _icon2FocusNode,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: !(_icon2FocusNode?.hasFocus ?? false)
                                ? null
                                : Border.all(
                                    width: 5, color: Color(0xffeb1555))),
                        child: Icon(
                          Icons.desktop_windows_outlined,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Actions(
                    actions: <Type, Action<Intent>>{
                      RightButtonIntent:
                          CallbackAction<RightButtonIntent>(onInvoke: (intent) {
                        _selectedIcon = Icons.tablet_android;
                        _changeFocus(context, _icon4FocusNode!);
                      }),
                      LeftButtonIntent:
                          CallbackAction<LeftButtonIntent>(onInvoke: (intent) {
                        _selectedIcon = Icons.desktop_windows_outlined;

                        _changeFocus(context, _icon2FocusNode!);
                      }),
                    },
                    child: Focus(
                      focusNode: _icon3FocusNode,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: !(_icon3FocusNode?.hasFocus ?? false)
                                ? null
                                : Border.all(
                                    width: 5, color: Color(0xffeb1555))),
                        child: Icon(
                          Icons.desktop_mac_outlined,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Actions(
                    actions: <Type, Action<Intent>>{
                      LeftButtonIntent:
                          CallbackAction<LeftButtonIntent>(onInvoke: (intent) {
                        _selectedIcon = Icons.desktop_mac_outlined;
                        _changeFocus(context, _icon3FocusNode!);
                      }),
                    },
                    child: Focus(
                      focusNode: _icon4FocusNode,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: !(_icon4FocusNode?.hasFocus ?? false)
                                ? null
                                : Border.all(
                                    width: 5, color: Color(0xffeb1555))),
                        child: Icon(
                          Icons.tablet_android,
                          size: 50,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
