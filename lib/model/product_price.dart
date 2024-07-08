class ProductPrice {
  final String ecommerce;
  final String originalPrice;
  final String discountedPrice;

  ProductPrice({
    required this.ecommerce,
    required this.originalPrice,
    required this.discountedPrice,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) {
    return ProductPrice(
      ecommerce: json['ecommerce'],
      originalPrice: json['originalPrice'],
      discountedPrice: json['discountedPrice'],
    );
  }
}
