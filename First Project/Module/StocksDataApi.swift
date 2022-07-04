import Foundation

struct StocksPriceData: Decodable {
    var name: String
    //var ticker: String
    var logo: String

}

struct StocksMethodData: Decodable{
    var c: Double // current price
    var d: Double // change
    var dp: Double// change in percent
}
