import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TextEditorScreen(),
    );
  }
}

class TextEditorScreen extends StatefulWidget {
  const TextEditorScreen({super.key});

  @override
  _TextEditorScreenState createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  String _text = '';
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Editor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _text = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Text',
                helperText: 'Enter some text',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text('Font size: ${_fontSize.toInt()}'),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 10.0,
                    max: 30.0,
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewScreen(
                      text: _text,
                      fontSize: _fontSize,
                    ),
                  ),
                );

                String message;
                if (result == 'ok') {
                  message = 'Cool!';
                } else if (result == 'cancel') {
                  message = 'Let’s try something else.';
                } else {
                  message = 'Don\'t know what to say.';
                }

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/Robot.webp',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 10),
                        Text(message),
                      ],
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Preview'),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String text;
  final double fontSize;

  const PreviewScreen({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontSize: fontSize),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'ok');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Ok'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'cancel');
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
