import UIKit

//["DIDI", "AAPL", "AMZN", "ABEV", "F", "CCL", "NIO",
//               "CERN", "ITUB", "AAL", "NVDA", "SOFI", "NLY", "BAC", "T",
//               "BABA", "NOK", "FB" , "PBR", "SNAP", "VALE", "PLTR", "TSLA", "COIN"]

struct StocksManager {
    let urlBase = "https://finnhub.io/api/v1/stock/profile2?symbol=" // provile 2
    let urlBase2 = "https://finnhub.io/api/v1/quote?symbol=" // quote data
    let apiKey = "cajddvaad3i94jmn55s0"
    
    func fetchUrl() -> [CellObject]{
        let tickers = [ "AAPL", "AMZN"
                       , "ABEV", "F", "CCL", "NIO"
//                        ,
//                       "CERN", "AAL", "NVDA", "SOFI", "BAC", "T",
//                       "BABA", "NOK",  "PBR", "SNAP", "VALE", "PLTR", "TSLA", "COIN"
        ]
        var cellObjects: [CellObject] = []
        for ticker in tickers {
            let urlString1 = urlBase  + ticker + "&token=" + apiKey
            let urlString2 = urlBase2 + ticker + "&token=" + apiKey
            let namesData = performRequestForNames(urlString: urlString1)
            var numbersData = performRequestForNumbers(urlString: urlString2)
            var diff = ""
            if numbersData[1].first == "-" {
                if let i = numbersData[1].firstIndex(of: "-") {
                    numbersData[1].remove(at: i)
                }
                if let i = numbersData[2].firstIndex(of: "-") {
                    numbersData[2].remove(at: i)
                }
                diff = "-$\(numbersData[1]) (\(numbersData[2])%)"
            } else {
                diff = "+$\(numbersData[1]) (\(numbersData[2])%)"
            }
            let image = UIImageView()
            image.loadFrom(urlString: namesData[1])
            let cellObject = CellObject(companyName: ticker, companyTicker: namesData[0], currentPrice: "$" + numbersData[0], difference: diff, companyImage: image)
            cellObjects.append(cellObject)
        }
        return cellObjects
    }
    
    func performRequestForNumbers(urlString: String)->[String]{
        var numbersData: [String] = []
        let group = DispatchGroup()
        group.enter()
        if let url = URL(string: urlString){
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    numbersData = self.parseJSONNumbers(stocksData: safeData)
                    group.leave()
                }
            }
            task.resume()
            
        }
        group.wait()
        return numbersData
    }
    
    
    func performRequestForNames(urlString: String) -> [String] {
        var namesData: [String] = []
        guard let url = URL(string: urlString) else {
            return []
        }
        let group = DispatchGroup()
        group.enter()
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                namesData = self.parseJSONNames(stocksData: safeData)
                group.leave()
            }
        }
        task.resume()
        group.wait()
        return namesData
    }
    
    func parseJSONNames(stocksData: Data) -> [String]{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(StocksPriceData.self, from: stocksData)
            print(decodedData.name)
            return [decodedData.name, decodedData.logo]
        } catch {
            print(error)
        }
        return []
    }
    
    
    
    func parseJSONNumbers(stocksData: Data)->[String]{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(StocksMethodData.self, from: stocksData)
            return[String(format:"%.2f", decodedData.c), String(format:"%.2f", decodedData.d), String(format:"%.2f", decodedData.dp)]
        } catch {
            print(error)
        }
        return []
    }
}

extension UIImageView {
    func loadFrom(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}





