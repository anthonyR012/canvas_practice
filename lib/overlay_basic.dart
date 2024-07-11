import 'package:flutter/material.dart';

class OverlayExample extends StatefulWidget {
  const OverlayExample({super.key});

  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample> {
  OverlayEntry? _alertEntryCenter;
  OverlayState? _overlayState;
  bool _isOverlayShown = false;
  final TextOverlayNotifier _textOverlayNotifier = TextOverlayNotifier();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayState = Overlay.of(context);
      _alertEntryCenter = OverlayEntry(
        builder: (BuildContext context) {
          return AlertOverlayCenter(
              buildContext: context, textOverlayNotifier: _textOverlayNotifier);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Prueba overlay"),
        ElevatedButton(
          onPressed: () {
            showFor(seconds: 6);
            Future.delayed(Durations.extralong4, () {
              _textOverlayNotifier.toggle();
            });
          },
          child: const Text("show for 3 seconds"),
        ),
      ],
    );
  }

  void showFor({required int seconds}) {
    assert(seconds > 0, "seconds must be greater than 0");
    if (_isOverlayShown || _overlayState == null) {
      return;
    }
    show();
    Future.delayed(Duration(seconds: seconds), hide);
  }

  void show() {
    if (_isOverlayShown || _overlayState == null) {
      return;
    }
    _overlayState!.insert(_alertEntryCenter!);
    _isOverlayShown = true;
  }

  void hide() {
    if (!_isOverlayShown && _alertEntryCenter == null) {
      return;
    }
    _alertEntryCenter?.remove();
    _isOverlayShown = false;
  }

  void toggle() {
    if (_isOverlayShown) {
      hide();
    } else {
      show();
    }
  }
}

class AlertOverlayCenter extends StatelessWidget {
  const AlertOverlayCenter(
      {super.key,
      required this.buildContext,
      required this.textOverlayNotifier,
      this.heightContainer = 300,
      this.widthContainer = 450});

  final double heightContainer;
  final double widthContainer;
  final BuildContext buildContext;
  final TextOverlayNotifier textOverlayNotifier;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(buildContext).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: (height / 2) - (heightContainer / 2),
            left: (width / 2) - (widthContainer / 2),
            child: Container(
              width: widthContainer,
              height: heightContainer,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  ListenableBuilder(
                    builder: (context, child) {
                      return Text(
                        textOverlayNotifier.text,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      );
                    },
                    listenable: textOverlayNotifier,
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              width: width,
              height: height,
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }
}

class TextOverlayNotifier extends ChangeNotifier {
  String text = "Cargando...";

  void toggle() {
    text = text == "Cargando..." ? "Cargado" : "Cargando...";
    notifyListeners();
  }
}
