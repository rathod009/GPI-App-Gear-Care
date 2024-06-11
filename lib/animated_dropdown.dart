import 'package:flutter/material.dart';

class AnimatedDropdown extends StatefulWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const AnimatedDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  @override
  _AnimatedDropdownState createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<AnimatedDropdown> with SingleTickerProviderStateMixin {
  bool _isOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20, // Increased font size for selected value
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: Container(
            height: _isOpen ? widget.items.length * 48.0 : 0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: widget.items.map((item) {
                  final isSelected = item == widget.value;
                  return GestureDetector(
                    onTap: () {
                      widget.onChanged(item);
                      _toggleDropdown();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 20,
                          color: isSelected ? Colors.black : Colors.cyan,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
