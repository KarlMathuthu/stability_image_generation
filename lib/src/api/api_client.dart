import 'dart:convert';
import 'dart:typed_data';

///import the [http] package
import 'package:http/http.dart' as http;
import 'package:stability_image_generation/src/data/enums.dart';

///main holder class [ApiClient]
class ApiClient {
  ///This method[generateImage] is the one that creates image from the stability api.
  Future<Uint8List> generateImage({
    required String prompt,
    required String apiKey,
    required String aiStyle,
    int? imageHeight,
    int? imageWidth,
  }) async {
    const baseUrl = 'https://api.stability.ai';
    final url = Uri.parse(
        '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-0/text-to-image');

    // Make the HTTP POST request to the Stability Platform API
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'Accept': 'image/png',
      },
      body: jsonEncode({
        'cfg_scale': 7,
        'clip_guidance_preset': 'FAST_BLUE',
        'height': imageHeight ?? 512,
        'width': imageWidth ?? 512,
        'samples': 1,
        'steps': 50,
        'text_prompts': [
          {
            'text': "$prompt ${aiStyle.toString()}",
            'weight': 1,
          }
        ],
      }),
    );
    if (response.statusCode != 200) {
      //Return error from API
      throw Exception("Error occurred with response ${response.statusCode}");
    } else {
      return (response.bodyBytes);
    }
  }

  ///Get the AI Style using this method [getStyle]
  String getStyle(ImageAIStyle? aiStyle) {
    switch (aiStyle) {
      case ImageAIStyle.noStyle:
        return 'DEFAULT';
      case ImageAIStyle.anime:
        return 'ANIME';
      case ImageAIStyle.moreDetails:
        return 'UHD';
      case ImageAIStyle.cyberPunk:
        return 'CYBERPUNK';
      case ImageAIStyle.kandinskyPainter:
        return 'KANDINSKY';
      case ImageAIStyle.aivazovskyPainter:
        return 'AIVAZOVSKY';
      case ImageAIStyle.malevichPainter:
        return 'MALEVICH';
      case ImageAIStyle.picassoPainter:
        return 'PICASSO';
      case ImageAIStyle.goncharovaPainter:
        return 'GONCHAROVA';
      case ImageAIStyle.classicism:
        return 'CLASSICISM';
      case ImageAIStyle.renaissance:
        return 'RENAISSANCE';
      case ImageAIStyle.oilPainting:
        return 'OILPAINTING';
      case ImageAIStyle.pencilDrawing:
        return 'PENCILDRAWING';
      case ImageAIStyle.digitalPainting:
        return 'DIGITALPAINTING';
      case ImageAIStyle.medievalStyle:
        return 'MEDIEVALPAINTING';
      case ImageAIStyle.render3D:
        return 'RENDER';
      case ImageAIStyle.cartoon:
        return 'CARTOON';
      case ImageAIStyle.studioPhoto:
        return 'STUDIOPHOTO';
      case ImageAIStyle.portraitPhoto:
        return 'PORTRAITPHOTO';
      case ImageAIStyle.khokhlomaPainter:
        return 'KHOKHLOMA';
      case ImageAIStyle.christmas:
        return 'CRISTMAS';
      case ImageAIStyle.sovietCartoon:
        return 'SOVIETCARTOON';
      default:
        return 'DEFAULT';
    }
  }
}
