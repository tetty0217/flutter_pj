import 'package:flutter/material.dart';

void main() {
  runApp(new FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "tetty_app",
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("tetty_app"),
          backgroundColor: Theme.of(context).primaryColor,
      ),
      body: new Column(                                        //modified
        children: <Widget>[                                         
          new Flexible(                                             
            child: new ListView.builder(                             
              padding: new EdgeInsets.all(8.0),                     
              reverse: true,                                        
              itemBuilder: (_, int index) => _messages[index],      
              itemCount: _messages.length,                          
            ),                                                      
          ),                                                        
          new Divider(height: 1.0),                                 
          new Container(                                            
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor),                  
            child: _buildTextComposer(),                       //modified
          ),                                                        
        ],                                                          
      ),                                                            
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(                                            
        data: new IconThemeData(color: Theme.of(context).accentColor), 
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration: new InputDecoration.collapsed(
                      hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    color: Theme.of(context).textSelectionColor,
                    onPressed: () => _handleSubmitted(_textController.text)),
              ),
            ],
          ),
        ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
      ChatMessage message = new ChatMessage(
        text: text,
      );
      setState(() {
        _messages.insert(0, message);
      });
  }
}

const String _name = 'tetty';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset('images/icon_user.jpg'),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
