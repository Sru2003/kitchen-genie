import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitchen_genie/api_key.dart';

class ChatGPTScreen extends StatefulWidget {
  @override
  _ChatGPTScreenState createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  final List<Message> _messages = [];

  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage() async {
    Message message = Message(text: _textEditingController.text, isMe: true);

    _textEditingController.clear();

    setState(() {
      _messages.insert(0, message);
    });

    String response = await sendMessageToChatGpt(message.text);

    Message chatGpt = Message(text: response, isMe: false);

    setState(() {
      _messages.insert(0, chatGpt);
    });
  }

  Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");
    String question =
        "Make a recipe from given ingredients and if the ingredients are not proper, tell me to give correct ingredients: ";
    message = question + message;
    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${APIKey.apiKey}",
      },
      body: json.encode(body),
    );

    print(response.body);

    Map<String, dynamic> parsedReponse = json.decode(response.body);

    String reply = parsedReponse['choices'][0]['message']['content'];

    return reply;
  }

  Widget _buildMessage(Message message) {
    Color myColor = Color(0xFF003366);
    Color myColor2 = Color(0xFF39FF02);
    Color myColor3 = Color(0xFFFFCC00);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: message.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isMe ? 'Ingredients' : 'Recipe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: myColor,
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: message.isMe ? myColor2 : myColor3,
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: message.isMe ? myColor2 : myColor3,
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                message.text,
                style: TextStyle(
                  color: myColor,
                  fontWeight:
                  message.isMe ? FontWeight.normal : FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color myColor = Color(0xFF003366);
    Color myColor2 = Color(0xFF39FF02);
    Color myColor3 = Color(0xFFFFCC00);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: myColor,),
        backgroundColor: myColor2,
        shadowColor: Colors.lightGreenAccent,
        title: Center(
          child: Text(
            'Recipes',
            style: TextStyle(
              color: myColor,
              fontSize: 30,
              fontFamily: 'ShortBaby',
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.all(10),
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildMessage(_messages[index]),
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: 'Enter new ingredients...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: myColor2,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.fastfood_rounded, color: myColor),
                    onPressed: onSendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}