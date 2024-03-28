import 'package:flutter/material.dart';

class AminatedShoppingCart extends StatefulWidget {
  const AminatedShoppingCart({super.key});

  @override
  State<AminatedShoppingCart> createState() => _AminatedShoppingCartState();
}

class _AminatedShoppingCartState extends State<AminatedShoppingCart> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: animateCart,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            height: 60,
            width: isExpanded ? 200 : 80,
            decoration: BoxDecoration(
              color: isExpanded ? Colors.green : Colors.blueGrey,
              borderRadius: BorderRadius.circular(isExpanded ? 20 : 8),
            ),
            child: !isExpanded
                ? const Icon(Icons.shopping_cart)
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      Text(
                        'Added to Cart!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void animateCart() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
