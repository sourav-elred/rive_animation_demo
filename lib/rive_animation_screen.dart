import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveAnimationScreen extends StatefulWidget {
  const RiveAnimationScreen({super.key});

  @override
  RiveAnimationScreenState createState() => RiveAnimationScreenState();
}

class RiveAnimationScreenState extends State<RiveAnimationScreen> {
  Artboard? _artboard;
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  void _loadRiveFile() async {
    final data = await rootBundle.load('assets/animation.riv');
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;
    artboard.addController(
      _controller = SimpleAnimation('idle'),
    );
    setState(() => _artboard = artboard);
  }

  void _toggleAnimation() {
    if (_controller is SimpleAnimation) {
      setState(() {
        _controller?.isActive = !_controller!.isActive;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Animation Demo'),
      ),
      body: Center(
        child: _artboard == null
            ? const SizedBox()
            : GestureDetector(
                onTap: _toggleAnimation,
                child: Rive(
                  artboard: _artboard!,
                ),
              ),
      ),
    );
  }
}
