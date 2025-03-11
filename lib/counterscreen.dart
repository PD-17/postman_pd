import 'package:flutter/material.dart';
import 'package:posrtman_pd/apiservice.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterScreen extends StatefulWidget {
  final String counterName;
  final int index;
  
  const CounterScreen({
    super.key,
    required this.counterName,
    required this.index,
  });
  
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final ApiService apiService = ApiService();
  int counterValue = 0;
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadCounterValue();
  }
  
  Future<void> _loadCounterValue() async {
    try {
      final value = await apiService.getCounterValue(widget.counterName, widget.index);
      setState(() {
        counterValue = value;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load counter: $e')),
          );
        }
      }
    }
  }
  
  Future<void> _incrementCounter() async {
    try {
      final value = await apiService.incrementCounter(widget.counterName, widget.index);
      setState(() {
        counterValue = value;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to increment counter: $e')),
        );
      }
    }
  }
  
  Future<void> _decrementCounter() async {
    try {
      final value = await apiService.decrementCounter(widget.counterName, widget.index);
      setState(() {
        counterValue = value;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to decrement counter: $e')),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.counterName, style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Counter Value',
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$counterValue',
                    style: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _decrementCounter,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _incrementCounter,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
