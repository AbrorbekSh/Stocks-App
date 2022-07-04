//
//  ViewController.swift
//  First Project
//
//  Created by Аброрбек on 06.06.2022.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    weak var collectionView : UICollectionView!
  
    override func loadView() {
        super.loadView()
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cv)
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 51),
            cv.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cv.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        self.collectionView = cv
    }
    
    var favouriteMode = false
    
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
    
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    //MARK-view did load
    @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
            navigationController?.setNavigationBarHidden(true, animated: true)
            
            super.viewDidLoad()
            self.hideKeyboardWhenTappedAround()
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register( MyCell.self, forCellWithReuseIdentifier: "MyCell")
            collectionView.register(FirstHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FirstHeader")
            collectionView.register(SecondHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SecondHeader")
            
            tableView.dataSource = self
            tableView.delegate = self
            
            searchBar.delegate = self
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
            collectionView.isHidden = true
        }
    //MARK-
    @IBAction func showMoreBtnPressed(_ sender: Any) {
        searchBarCancelButtonClicked(searchBar)
        stackPressed(stackText)
    }
    @IBAction func favouriteButton(_ sender: UIButton) {
        favouriteMode = true
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
        favouriteMode = false
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
        collectionView.isHidden = true
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stackText.isHidden = true
        favouriteText.isHidden = true
        searchBar.showsCancelButton = true
        collectionView.isHidden = false
        //searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if favouriteMode {
            favouriteButton(favouriteText)
        } else {
            stackPressed(stackText)
        }
//        tableViewData = fullDataForCells
//        tableView.reloadData()
        tableView.isHidden = false
        stackText.isHidden = false
        favouriteText.isHidden = false
        showMoreButton.isHidden = true
        stocksLabel.isHidden = true
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        collectionView.isHidden = true
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableViewData.count
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "graphSegue", sender: self)
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
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var text: String!
        if indexPath.section == 0 {
            text = mostSearchs[indexPath.row]
        } else {
            text = lastSearchs[indexPath.row]
        }
        searchBarOutlet.text = text
        searchBar(searchBar, textDidChange: text)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section==0) {
            return CGSize(width:collectionView.frame.size.width, height:70)
        } else {
            return CGSize(width:collectionView.frame.size.width, height:70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            var reusableview = UICollectionReusableView()
        if (kind == UICollectionView.elementKindSectionHeader) {
                let section = indexPath.section
                switch (section) {
                case 0:
                    let  firstheader: FirstHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstHeader", for: indexPath) as! FirstHeader
                    reusableview = firstheader
                case 1:
                    let  secondheader: SecondHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SecondHeader", for: indexPath) as! SecondHeader
                    reusableview = secondheader
                default:
                    return reusableview
                    
                }
            }
            return reusableview
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mostSearchs[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 40, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return mostSearchs.count
        }
        return lastSearchs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)  as! MyCell
        let section = indexPath.section
        if section == 0 {
            cell.textLabel.text = mostSearchs[indexPath.row]
        } else {
            cell.textLabel.text = lastSearchs[indexPath.row]
        }
        return cell
    }
}


