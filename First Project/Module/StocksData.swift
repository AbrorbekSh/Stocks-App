
import UIKit

struct StocksData{
    //defaults
    let defaults = UserDefaults.standard
    
    var mainData: [CellObject]!
    //method to give data
    mutating func customisingDataStyle(cell: CustomTableViewCell, at index: Int, with data: [CellObject] ){
        //Names and numbers
        cell.companyName.text = data[index].companyName
        cell.currentPrice.text = data[index].currentPrice
        cell.companyTicker.text = data[index].companyTicker
        cell.difference.text = data[index].difference
        //fonts
        cell.companyName.font = .systemFont(ofSize: 20, weight: .semibold)
        cell.currentPrice.font = .systemFont(ofSize: 20, weight: .semibold)
        cell.difference.font = .systemFont(ofSize: 15, weight: .medium)
        cell.companyTicker.font = .systemFont(ofSize: 15, weight: .medium)
        
        //image

        cell.companyImage.layer.cornerRadius = 10
        DispatchQueue.main.async {
            cell.companyImage.image = data[index].companyImage.image
        }
        
//        if cell.companyImage.image == nil{
//            let firstLetter = data[index].companyName.first!.lowercased()
//            let nameEnding = firstLetter + ".square.fill"
//            cell.companyImage.image = UIImage(systemName: nameEnding)
//            cell.companyImage.tintColor = UIColor(hexString: "#878ECD")
//        }
        
        //colors of difference
        let difference = data[index].difference
        if difference.first == "-"{
            cell.difference.textColor = .red
        } else {
            cell.difference.textColor = UIColor(red: 0.0745, green: 0.7569, blue: 0, alpha: 1.0)
        }
        if index % 2 == 0 {
            cell.backgroundColor = UIColor(hexString: "#CCF2F4")
        } else {
            cell.backgroundColor = .white
        }
    }
}
