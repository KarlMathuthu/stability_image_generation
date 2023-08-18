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
    required AIStyle aiStyle,
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
        'height': 512,
        'width': 512,
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
  String getStyle(AIStyle? aiStyle) {
    switch (aiStyle) {
      case AIStyle.noStyle:
        return 'DEFAULT';
      case AIStyle.anime:
        return 'ANIME';
      case AIStyle.moreDetails:
        return 'UHD';
      case AIStyle.cyberPunk:
        return 'CYBERPUNK';
      case AIStyle.kandinskyPainter:
        return 'KANDINSKY';
      case AIStyle.aivazovskyPainter:
        return 'AIVAZOVSKY';
      case AIStyle.malevichPainter:
        return 'MALEVICH';
      case AIStyle.picassoPainter:
        return 'PICASSO';
      case AIStyle.goncharovaPainter:
        return 'GONCHAROVA';
      case AIStyle.classicism:
        return 'CLASSICISM';
      case AIStyle.renaissance:
        return 'RENAISSANCE';
      case AIStyle.oilPainting:
        return 'OILPAINTING';
      case AIStyle.pencilDrawing:
        return 'PENCILDRAWING';
      case AIStyle.digitalPainting:
        return 'DIGITALPAINTING';
      case AIStyle.medievalStyle:
        return 'MEDIEVALPAINTING';
      case AIStyle.render3D:
        return 'RENDER';
      case AIStyle.cartoon:
        return 'CARTOON';
      case AIStyle.studioPhoto:
        return 'STUDIOPHOTO';
      case AIStyle.portraitPhoto:
        return 'PORTRAITPHOTO';
      case AIStyle.khokhlomaPainter:
        return 'KHOKHLOMA';
      case AIStyle.christmas:
        return 'CRISTMAS';
      case AIStyle.sovietCartoon:
        return 'SOVIETCARTOON';
      default:
        return 'DEFAULT';
    }
  }
}
