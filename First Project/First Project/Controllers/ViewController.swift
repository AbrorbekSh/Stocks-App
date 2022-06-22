//
//  ViewController.swift
//  First Project
//
//  Created by Аброрбек on 06.06.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var stocksLabel: UILabel!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var favouriteText: UIButton!
    @IBOutlet weak var stackText: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    var stocksManager = StocksManager()
    
    var stocksData = StocksData()
    var tableViewData: [CellObject]!
    var fullDataForCells: [CellObject]!
    let defaults = UserDefaults.standard
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableViewData.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
        
            stocksData.customisingDataStyle(cell: cell, at: indexPath.row, with: tableViewData)
            cell.isFav = defaults.bool(forKey: tableViewData[indexPath.row].companyTicker)
        
            return cell
        }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
    //MARK-view did load
    @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
            tableView.dataSource = self
            tableView.delegate = self
            searchBar.delegate = self
            collectionViewOutlet.dataSource = self
            //buttonI
            //searchBar.buttonItem
            //searchBar.isActive = true
            fullDataForCells = stocksManager.fetchUrl()
            tableViewData = fullDataForCells
            registerTableViewCells()
            stackText.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
            favouriteText.titleLabel?.font = .systemFont(ofSize: 20)
            stackText.setTitleColor(.black, for: .normal)
            favouriteText.setTitleColor(.lightGray, for: .normal)
            stocksLabel.font = .systemFont(ofSize: 20, weight: .bold)
            showMoreButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
            showMoreButton.isHidden = true
            stocksLabel.isHidden = true
            //collectionViewOutlet.isHidden = true
        }
    //MARK-
    @IBAction func showMoreBtnPressed(_ sender: Any) {
        searchBarCancelButtonClicked(searchBar)
        stackPressed(stackText)
    }
    @IBAction func favouriteButton(_ sender: UIButton) {
        recolorButton(sender)
        tableViewData = []
        stocksData.mainData = fullDataForCells
        for object in stocksData.mainData {
            if defaults.bool(forKey: object.companyTicker) {
                tableViewData.append(object)
            }
        }
        tableView.reloadData()
    }
    @IBAction func stackPressed(_ sender: UIButton) {
        recolorButton(sender)
        tableViewData = fullDataForCells
        tableView.reloadData()
    }
    
    private func recolorButton(_ sender: UIButton){
        if sender == stackText{
            sender.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
            favouriteText.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            stackText.setTitleColor(.black, for: .normal)
            favouriteText.setTitleColor(.lightGray, for: .normal)
        } else {
            stackText.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            sender.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
            stackText.setTitleColor(.lightGray, for: .normal)
            favouriteText.setTitleColor(.black, for: .normal)
        }
    }
}

extension ViewController: CustomTableViewCellDelegate {
    
    func didTapped(with cell: CustomTableViewCell) {
        guard let objectIndex = tableView.indexPath(for: cell) else {
            return
        }
        let pressedCellObject: CellObject = tableViewData[objectIndex.item]
        cell.isFav = !cell.isFav
        if cell.isFav == true {
                defaults.set(true, forKey: pressedCellObject.companyTicker)
        } else {
            defaults.removeObject(forKey: pressedCellObject.companyTicker)
        }
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showMoreButton.isHidden = false
        stocksLabel.isHidden = false
        var filteredData: [CellObject] = []
        for object in fullDataForCells{
            if object.companyName.starts(with: searchText) ||  object.companyTicker.starts(with: searchText){
                filteredData.append(object)
            }
        }
        tableViewData = filteredData
        tableView.isHidden = false
        //collectionViewOutlet.isHidden = true
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stackText.isHidden = true
        favouriteText.isHidden = true
        searchBar.showsCancelButton = true
        //collectionViewOutlet.isHidden = false
        //searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableViewData = fullDataForCells
        tableView.reloadData()
        tableView.isHidden = false
        stackText.isHidden = false
        favouriteText.isHidden = false
        showMoreButton.isHidden = true
        stocksLabel.isHidden = true
        //collectionViewOutlet.isHidden = true
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mostSearchs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        //cell.cellButtonOutlet.setTitle(mostSearchs[indexPath.row], for: .normal)
        return cell
    }
}
