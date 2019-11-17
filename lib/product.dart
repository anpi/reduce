class Product {
  final String name;
  final String productType;
  final String pictureUrl;

  Product(this.name, this.productType, this.pictureUrl);

  Product.fromJson(var json)
      : name = json['marketingName']['finnish'],
        productType = json['segment']['id'],
        pictureUrl = json['pictureUrls'][0]['original'] + '?w=150&h=150&fit=clip';
}