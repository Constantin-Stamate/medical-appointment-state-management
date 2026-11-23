import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataImage extends StatelessWidget {
  final String source;
  final double width;
  final double height;
  final BoxFit fit;

  const DataImage({
    super.key,
    required this.source,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (Uri.tryParse(source)?.path.toLowerCase().endsWith('.svg') == true) {
      return SvgPicture.network(
        source,
        width: width,
        height: height,
        fit: fit,
        placeholderBuilder: (_) => SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      );
    }

    return Image.network(
      source,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.broken_image_outlined),
      ),
    );
  }
}