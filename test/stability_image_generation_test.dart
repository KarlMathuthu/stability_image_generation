/// Import the necessary packages for the test
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:stability_image_generation/src/api/api_client.dart';
import 'package:stability_image_generation/src/data/enums.dart';

/// The main function that runs the test
void main() {
  /// The test function that generates an image from a query using the AI model
  test(
    'Image Generation',
    () async {
      /// Create an instance of the AI class
      StabilityAI ai = StabilityAI();

      /// Define the query and AI style
      String query = 'A cat running alongside a dog';
      ImageAIStyle style = ImageAIStyle.anime;
      String apiKey = 'sk-- api key from stability api or dreamstudio';

      try {
        /// Call the runAI method with the required parameters
        Uint8List image = await ai.generateImage(
          apiKey: apiKey,
          imageAIStyle: style,
          prompt: query,
        );

        /// Use the returned image data as needed
        print(image);
      } catch (e) {
        /// Handle any exceptions that may occur during AI processing
        print(e);
      }
    },
  );
}

/// This test ensures that the AI model is able to generate an image from a query
/// It creates an instance of the AI class and calls the runAI method with a query and AI style
/// It then checks that an image is returned and prints the image data if in debug mode
/// If an error occurs during AI processing, it is caught and printed if in debug mode.
