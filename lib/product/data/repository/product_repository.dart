import '../../../data/data_provider.dart';
import '../model/models.dart';

class ProductRepository {
  DataProvider dataProvider = DataProvider();
  Future<List<Products>> getProducts() async {
    try {
      final response = await DataProvider.getRequest(
          endpoint: "https://gist.githubusercontent.com/atabekkr/3db39f767470a99c8119d5f55a02265e/raw/ba14f0df092685ae178502bff7ab54fc39c15794/gistfile1.txt");
      if (response.statusCode == 200) {
        List<Products> products =
            ProductModel.fromRawJson(response.body).products;
        return products;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
