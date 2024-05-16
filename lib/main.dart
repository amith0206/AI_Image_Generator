import 'dart:async';
import 'dart:io';
import 'dart:typed_data';  // For handling binary data
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AI_Image_Generator());
}

// ignore: camel_case_types
class AI_Image_Generator extends StatefulWidget {
  const AI_Image_Generator({super.key});

  @override
  State<AI_Image_Generator> createState() => _AI_Image_Generator();
}

class _AI_Image_Generator extends State<AI_Image_Generator> {
  final TextEditingController textController = TextEditingController();
  Uint8List? imageData;  // For storing binary image data
  bool showLoading = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AI Image Generation Project"),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: "Enter the text to generate the image",
              ),
            ),
            const SizedBox(height: 10),
            UnconstrainedBox(
              child: ElevatedButton(
                onPressed: () async {
                  String userInput = textController.text.trim();
                  if (userInput.isEmpty) {
                    scaffoldKey.currentState?.showSnackBar(
                      const SnackBar(
                        content: Text("Please enter some text."),
                      ),
                    );
                    return;
                  }
                  var url = Uri.parse('http://<your-ip-adress>/generate-image?text=$userInput');
                  print("Request URL: $url");
                  setState(() {
                    showLoading = true;
                  });
                  try {
                    var response = await http.get(url).timeout(const Duration(seconds: 300));
                    print("Response status: ${response.statusCode}");
                    if (response.statusCode == 200) {
                      setState(() {
                        imageData = response.bodyBytes;  // Store binary image data
                      }); 
                    } else {
                      print("Failed to load image. Status code: ${response.statusCode}");
                      scaffoldKey.currentState?.showSnackBar(
                        SnackBar(
                          content: Text("Failed to load image. Status code: ${response.statusCode}"),
                        ),
                      );
                    }
                  } on SocketException catch (err) {
                    print("SocketException: $err");
                    scaffoldKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text("Network error: $err. Try again."),
                      ),
                    );
                  } on TimeoutException catch (err) {
                    print("TimeoutException: $err");
                    scaffoldKey.currentState?.showSnackBar(
                      const SnackBar(
                        content: Text("Request timed out. Try again."),
                      ),
                    );
                  } catch (e) {
                    print("Error: $e");
                    scaffoldKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text("Error: $e"),
                      ),
                    );
                  } finally {
                    setState(() {
                      showLoading = false;
                    });
                  }
                },
                child: const Text("Click to generate"),
              ),
            ),
            if (showLoading) const Center(child: CircularProgressIndicator()),
            if (imageData != null)
              Image.memory(
                imageData!,
                // No need for loadingBuilder here
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
    
  }
}
