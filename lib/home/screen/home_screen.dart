import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:dream_ai/home/components/app_colors.dart';
import 'package:dream_ai/home/components/custom_tab.dart';
import 'package:dream_ai/home/screen/product_search_sreen.dart';
import 'package:dream_ai/provider/price_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

// final description =
//     '''The iPhone 15 is Apples latest addition to its iconic smartphone lineup, offering a blend of cutting-edge technology and refined design. It features a sleek, aerospace-grade aluminum frame paired with a durable ceramic shield front cover, providing both aesthetics and durability. The device comes in a variety of colors, including a new titanium black, appealing to a wide range of tastes.

// At the heart of the iPhone 15 is the powerful A16 Bionic chip, ensuring lightning-fast performance and energy efficiency. This processor handles complex tasks with ease, from gaming and augmented reality to photography and multitasking, making it one of the most advanced smartphones on the market.

// The iPhone 15 boasts a 6.1-inch Super Retina XDR display with ProMotion technology, offering an immersive viewing experience with vibrant colors, deep blacks, and smooth scrolling. The display also supports HDR10 and Dolby Vision, enhancing video playback quality.

// One of the standout features of the iPhone 15 is its advanced camera system. It includes a 48-megapixel main sensor, a 12-megapixel ultra-wide lens, and a 12-megapixel telephoto lens, allowing for stunning photography in various conditions. The improved Night mode and Deep Fusion technology ensure clear and detailed images even in low-light environments. Additionally, the front-facing 12-megapixel TrueDepth camera supports high-quality selfies and Face ID authentication.

// The iPhone 15 also introduces new software capabilities with iOS 16, offering enhanced customization options, new widgets, and improved privacy features. It supports 5G connectivity for faster internet speeds and has improved battery life, allowing for all-day usage on a single charge. The device also features MagSafe technology, enabling easy attachment of accessories and faster wireless charging.

// Overall, the iPhone 15 combines top-tier hardware with innovative software, providing a premium user experience that caters to both everyday users and tech enthusiasts.''';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final controller = TextEditingController();

  final List<Map<String, dynamic>> productPrices = [
    {
      'ecommerce': 'Amazon India',
      'originalPrice': '1,20,000',
      'discountedPrice': '1,15,000',
    },
    {
      'ecommerce': 'Flipkart',
      'originalPrice': '1,18,000',
      'discountedPrice': '1,12,000',
    },
    {
      'ecommerce': 'Apple Store India',
      'originalPrice': '1,25,000',
      'discountedPrice': '1,20,000',
    },
  ];

  String searchedProduct = '';

  void _navigateToSearchPage(BuildContext context) async {
    final selectedProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductSearchBar()),
    );
    previousSearch.add(selectedProduct);

    // Handle the selected product data returned from search page
    if (selectedProduct != null) {
      setState(() {
        searchedProduct = selectedProduct;
      });
    }

    Provider.of<ProductProvider>(context, listen: false)
        .fetchDescription(searchedProduct);

    Provider.of<ProductProvider>(context, listen: false)
        .fetchPrices(searchedProduct);
  }

  void onTapPrevious(BuildContext context, String product) async {
    final selectedProduct = product;
    previousSearch.add(selectedProduct);

    // Handle the selected product data returned from search page
    setState(() {
      searchedProduct = selectedProduct;
    });

    Provider.of<ProductProvider>(context, listen: false)
        .fetchDescription(searchedProduct);

    Provider.of<ProductProvider>(context, listen: false)
        .fetchPrices(searchedProduct);
  }

  TabController? _tabController;

  List<String> previousSearch = [
    'Iphone 15 pro max 256 gb - black',
    'Iphone 15 pro 128 gb - black',
    'Iphone 11 white',
    'Iphone 15 pro max 256 gb - black'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController != null) {
      log('tab controller ; ${_tabController!.index}');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Dream AI',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body:
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
              .copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField(
              //   controller: controller,
              //   decoration: InputDecoration(
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(50),
              //       borderSide: const BorderSide(color: AppColors.lightBlue),
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(50),
              //       borderSide: const BorderSide(color: AppColors.grey),
              //     ),
              //     disabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(50),
              //       borderSide: const BorderSide(
              //           color: Color.fromARGB(235, 178, 175, 175)),
              //     ),
              //     contentPadding: const EdgeInsets.only(
              //         left: 32.0, top: 20, bottom: 20, right: 16),
              //     labelText: 'Enter product name',
              //     errorMaxLines: 3,
              //     labelStyle: const TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.normal,
              //       color: AppColors.black,
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () => _navigateToSearchPage(context),
                child: Hero(
                  tag: "Search",
                  child: Container(
                    height: 50.0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: const Color(0xFF999999)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          searchedProduct.isEmpty
                              ? 'Search Product'
                              : searchedProduct,
                          style: searchedProduct.isEmpty
                              ? const TextStyle(
                                  height: 1.5,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF999999))
                              : const TextStyle(
                                  height: 1.5,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.search,
                          color: Color(0xFF999999),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (searchedProduct.isNotEmpty) ...[
                Text(
                  searchedProduct,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  //  padding: EdgeInsets.zero,
                  // indicatorPadding: EdgeInsets.all(8),
                  // splashFactory: NoSplash.splashFactory,

                  overlayColor:
                      WidgetStateProperty.all<Color>(Colors.transparent),
                  splashBorderRadius: BorderRadius.circular(30),
                  labelPadding: const EdgeInsets.only(right: 15),
                  isScrollable: true,
                  tabs: [
                    CustomTab(
                        label: 'Description',
                        tabController: _tabController!,
                        index: 0),
                    CustomTab(
                        label: 'Price comparison',
                        tabController: _tabController!,
                        index: 1),
                    CustomTab(
                        label: 'images',
                        tabController: _tabController!,
                        index: 2),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        children: [
                          productProvider.loading
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.9,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: LoadingIndicator(
                                          indicatorType:
                                              Indicator.ballScaleRippleMultiple,
                                          colors: [
                                            AppColors.lightBlue,
                                            AppColors.primaryFG
                                          ],
                                          strokeWidth: 2,
                                          backgroundColor: Colors.transparent,
                                          pathBackgroundColor:
                                              Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Generating description..',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.8,
                                  color: Colors.grey[100],
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(productProvider.description),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (productProvider.description.isNotEmpty)
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      AppColors.white, // Set the button color
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: AppColors.lightBlue),
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Set the border radius
                                  ),
                                ),
                                onPressed: () {
                                  FlutterClipboard.copy(
                                          productProvider.description)
                                      .then((value) =>
                                          print('Product description copied'));

                                  showSucessMessage(
                                      'Product description copied', context);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Copy',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.lightBlue,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.copy,
                                      size: 15,
                                      color: AppColors.lightBlue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      productProvider.isPriceloading
                          ? Container(
                              height: MediaQuery.of(context).size.height / 1.8,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: LoadingIndicator(
                                      indicatorType:
                                          Indicator.ballScaleRippleMultiple,
                                      colors: [
                                        AppColors.lightBlue,
                                        AppColors.primaryFG
                                      ],
                                      strokeWidth: 2,
                                      backgroundColor: Colors.transparent,
                                      pathBackgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Fetching prices..',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : DataTable(
                              border:
                                  TableBorder.all(color: AppColors.borderColor),
                              headingRowColor: WidgetStateColor.resolveWith(
                                  (states) => AppColors.lightBlue),
                              columns: const <DataColumn>[
                                DataColumn(
                                    label: Text(
                                  'E-commerce \nWebsite',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Original Price',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Price After\nDiscounts',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )),
                              ],
                              rows: productProvider.prices.map((product) {
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(product.ecommerce)),
                                    DataCell(Text(product.originalPrice)),
                                    DataCell(Text(product.discountedPrice)),
                                  ],
                                );
                              }).toList(),
                            ),
                      const Center(
                          child: Text('Similar and Opposite Words Content')),
                    ],
                  ),
                ),
              ],

              if (searchedProduct.isEmpty) ...[
                const Text(
                  'Previous search',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: previousSearch.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.search),
                      onTap: () =>
                          onTapPrevious(context, previousSearch[index]),
                      contentPadding: EdgeInsets.zero,
                      title: Text(previousSearch[index]),
                    );
                  },
                )
              ]

              // const SizedBox(
              //   height: 30,
              // ),
              // const Text(
              //   'Product Description',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //     color: AppColors.black,
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   //  height: 400,
              //   color: Colors.grey[100],
              //   child: Padding(
              //     padding: const EdgeInsets.all(15.0),
              //     child: Text(description),
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // const Text(
              //   'Price comparison',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //     color: AppColors.black,
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        );
      }),
    );
  }
}

void showSucessMessage(String? message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                message!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.lightBlue,
    ),
  );
}
