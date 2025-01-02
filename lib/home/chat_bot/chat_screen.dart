import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/app_const.dart';
import '../../widgets/chat/chat_text_form_field.dart';
import '../../widgets/chat/message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final GenerativeModel _model;
  late final ScrollController _scrollController;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late ChatSession _chatSession;
  late bool _isLoading;
  List<String> _messages = []; // List to store messages

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _isLoading = false;

    _model = GenerativeModel(
      model: geminiModel,
      apiKey: apiKey,
    );

    _chatSession = _model.startChat();
  }

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleMessageSubmission(String message) async {
    if (message.trim().isEmpty) return;

    // Add user's message to the list and update UI
    setState(() {
      _messages.add(message);
    });

    _setIsLoading(true);
    _textController.clear();

    try {
      var response = await _chatSession.sendMessage(
        Content.text(message),
      );

      final text = response.text;
      if (text == null) {
        _showError('No response was received');
      } else {
        // Add AI's response to the list
        setState(() {
          _messages.add(text);
        });
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      _setIsLoading(false);
      _focusNode.requestFocus();

      // Scroll to the bottom of the chat after message is sent
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr('app.chat'),
            style: GoogleFonts.k2d(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).dividerColor,
          leading: IconButton(
            icon: const Icon(LineIcons.chevronCircleLeft),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return MessageWidget(
                          isFromUser: index % 2 == 0, // Assuming even indices are user messages
                          message: message,
                        );
                      },
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Form(
                            key: _formKey,
                            child: ChatTextFormField(
                              focusNode: _focusNode,
                              controller: _textController,
                              isRoadOnly: _isLoading,
                              onFieldSubmitted: (text) {
                                if (_formKey.currentState!.validate()) {
                                  _handleMessageSubmission(text);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (!_isLoading)
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _handleMessageSubmission(_textController.text);
                              }
                            },
                            child: const Text('Send'),
                          )
                        else
                          const CircularProgressIndicator.adaptive(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isKeyboardVisible)
              Positioned(
                right: 10,
                bottom: 120,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _QuickMessageButton(
                        message: "ทำไมถึงต้องจัดฟัน",
                        onPressed: () =>
                            _handleMessageSubmission("ทำไมถึงต้องจัดฟัน"),
                      ),
                      const SizedBox(height: 8),
                      _QuickMessageButton(
                        message: "การทำฟันสำคัญอย่างไร",
                        onPressed: () => _handleMessageSubmission(
                            "การทำฟันสำคัญอย่างไร"),
                      ),
                      const SizedBox(height: 8),
                      _QuickMessageButton(
                        message: "ขั้นตอนการจัดฟันมีอะไรบ้าง",
                        onPressed: () => _handleMessageSubmission(
                            "ขั้นตอนการจัดฟันมีอะไรบ้าง"),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

class _QuickMessageButton extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const _QuickMessageButton({
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          message,
          style: GoogleFonts.k2d(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}