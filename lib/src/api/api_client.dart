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
    required ImageAIStyle aiStyle,
    int? imageHeight,
    int? imageWidth,
  }) async {
    const baseUrl = 'https://api.stability.ai';
    final url = Uri.parse(
      '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-0/text-to-image',
    );

    ///Make the HTTP POST request to the Stability Platform API
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
            'text': "$prompt using ${getStyle(aiStyle)}",
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
        return 'DEFAULT';
      case ImageAIStyle.anime:
        return 'ANIME style';
      case ImageAIStyle.moreDetails:
        return 'UHD';
      case ImageAIStyle.cyberPunk:
        return 'CYBERPUNK style';
      case ImageAIStyle.kandinskyPainter:
        return 'KANDINSKY style';
      case ImageAIStyle.aivazovskyPainter:
        return 'AIVAZOVSKY style';
      case ImageAIStyle.malevichPainter:
        return 'MALEVICH style';
      case ImageAIStyle.picassoPainter:
        return 'PICASSO style';
      case ImageAIStyle.goncharovaPainter:
        return 'GONCHAROVA style';
      case ImageAIStyle.classicism:
        return 'CLASSICISM style';
      case ImageAIStyle.renaissance:
        return 'RENAISSANCE style';
      case ImageAIStyle.oilPainting:
        return 'OILPAINTING style';
      case ImageAIStyle.pencilDrawing:
        return 'PENCILDRAWING style';
      case ImageAIStyle.digitalPainting:
        return 'DIGITALPAINTING style';
      case ImageAIStyle.medievalStyle:
        return 'MEDIEVALPAINTING style';
      case ImageAIStyle.render3D:
        return 'RENDER 3d style';
      case ImageAIStyle.cartoon:
        return 'CARTOON style';
      case ImageAIStyle.studioPhoto:
        return 'STUDIOPHOTO style';
      case ImageAIStyle.portraitPhoto:
        return 'PORTRAITPHOTO style';
      case ImageAIStyle.khokhlomaPainter:
        return 'KHOKHLOMA style';
      case ImageAIStyle.christmas:
        return 'CRISTMAS style';
      case ImageAIStyle.sovietCartoon:
        return 'SOVIETCARTOON style';
      default:
        return 'DEFAULT';
    }
  }
}
