const ENV env = ENV.development;

enum ENV { development, qa, prod }

extension ConfigExt on ENV {
  String get baseurl {
    switch (this) {
      case ENV.qa:
        return 'https://xc62c4nbgb.execute-api.ap-south-1.amazonaws.com/dev';
      case ENV.development:
        return 'https://xc62c4nbgb.execute-api.ap-south-1.amazonaws.com/dev';
      case ENV.prod:
        return 'https://xc62c4nbgb.execute-api.ap-south-1.amazonaws.com/dev';
    }
  }

  String get baseimagurl {
    switch (this) {
      case ENV.qa:
        return '';
      case ENV.development:
        return '';
      case ENV.prod:
        return '';
    }
  }
}
