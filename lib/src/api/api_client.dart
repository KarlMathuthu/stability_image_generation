import 'dart:convert';
import 'dart:typed_data';

///import the [http] package
import 'package:http/http.dart' as http;
import 'package:stability_image_generation/src/data/enums.dart';

///main holder class [StabilityAI]
class StabilityAI {
  ///This method[generateImage] is the one that creates image from the stability api.
  Future<Uint8List> generateImage({
    required String prompt,
    required String apiKey,
    required ImageAIStyle imageAIStyle,
    String? engineId,
  }) async {
    const baseUrl = 'https://api.stability.ai';
    const engineId_in = 'stable-diffusion-xl-1024-v1-0';
    //const engineId = "stable-diffusion-512-v2-0";
    final url = Uri.parse(
      '$baseUrl/v1/generation/${engineId ?? engineId_in}/text-to-image',
    );
    /* final url = Uri.parse(
      '$baseUrl/v1/generation/$engineId/text-to-image',
    ); */

    ///Make the HTTP POST request to the Stability Platform API
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'Accept': 'image/png',
      },
      body: jsonEncode({
        'cfg_scale': 12,
        'clip_guidance_preset': 'FAST_BLUE',
        'height': 1024,
        'width': 1024,
        'samples': 1,
        'steps': 50,
        'seed': 2000000,
        'text_prompts': [
          {
            'text': "$prompt ${getStyle(imageAIStyle)}",
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
  String getStyle(ImageAIStyle aiStyle) {
    switch (aiStyle) {
      case ImageAIStyle.noStyle:
        return 'no style';
      case ImageAIStyle.anime:
        return ',{masterpiece} anime style, best quality, ultra-detailed, cinematic lighting, illustration';
      case ImageAIStyle.moreDetails:
        return ',{masterpiece}, UHD';
      case ImageAIStyle.cyberPunk:
        return ',{masterpiece}, cyberpunk, future';
      case ImageAIStyle.kandinskyPainter:
        return ',{masterpiece}, KANDINSKY style painter';
      case ImageAIStyle.aivazovskyPainter:
        return ',{masterpiece}, AIVAZOVSKY style';
      case ImageAIStyle.malevichPainter:
        return ',{masterpiece}, MALEVICH style painter';
      case ImageAIStyle.picassoPainter:
        return ',{masterpiece}, PICASSO style painter';
      case ImageAIStyle.goncharovaPainter:
        return ',{masterpiece}, GONCHAROVA style painter';
      case ImageAIStyle.classicism:
        return ',{masterpiece}, CLASSICISM style';
      case ImageAIStyle.renaissance:
        return ',{masterpiece}, RENAISSANCE style';
      case ImageAIStyle.oilPainting:
        return ',{masterpiece}, OILPAINTING style';
      case ImageAIStyle.pencilDrawing:
        return ',{masterpiece}, PENCILDRAWING style';
      case ImageAIStyle.digitalPainting:
        return ',{masterpiece}, DIGITALPAINTING style';
      case ImageAIStyle.medievalStyle:
        return ',{masterpiece}, MEDIEVALPAINTING style';
      case ImageAIStyle.render3D:
        return ',{masterpiece}, RENDER 3d style';
      case ImageAIStyle.cartoon:
        return ',{masterpiece}, CARTOON style';
      case ImageAIStyle.studioPhoto:
        return ',{masterpiece}, STUDIOPHOTO style';
      case ImageAIStyle.portraitPhoto:
        return ',{masterpiece}, PORTRAITPHOTO style';
      case ImageAIStyle.khokhlomaPainter:
        return ',{masterpiece}, KHOKHLOMA style';
      case ImageAIStyle.christmas:
        return ',{masterpiece}, CRISTMAS style';
      case ImageAIStyle.sovietCartoon:
        return ',{masterpiece}, SOVIETCARTOON style';
      default:
        return 'DEFAULT';
    }
  }
}
