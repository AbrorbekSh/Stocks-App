//
//  GraphViewController.swift
//  First Project
//
//  Created by Аброрбек on 30.06.2022.
//

import UIKit
import Charts

class GraphViewController: UIViewController, UICollectionViewDelegateFlowLayout, ChartViewDelegate {
    
    weak var graph: LineChartView!
    weak var timeButtonsView: UIView!
    
    var selectedPaths:IndexPath!
    
    weak var buyButton: UIButton!
    
    weak var dayButton: UIButton!
    weak var weakButton: UIButton!
    weak var monthButton: UIButton!
    weak var halfYearButton: UIButton!
    weak var yearButton: UIButton!
    
    weak var premiumImage: UIImageView!
    weak var availableLabel: UILabel!

    weak var tickerLabel: UILabel!
    weak var companyNameLabel: UILabel!
    
    weak var starButton: UIButton!
    
    weak var labelsCollectionView: UICollectionView!
    
    weak var labelPriceDifference: UILabel!
    weak var labelPrice: UILabel!
    
    var anotherEntries = [155.96,154.12,154.32,154.33,154.705,154.745,155.12,155.075,155.1,154.98,155,154.45,154.79,154.95,155.13,155.38,155.3,155.27,154.94,154.91,154.44,154.5,154.12,154.31,154.3,154.3,154.27,154.91,154.83,154.9,154.97,154.86,155.345,154.34,149.2,150.28,149.99,149.88,149,148.98,149.15,148.88,148.67,149.92,150.22,150.4,150.29,150.5,149.87,150.059,149.49,150.03,148.96,149.28,149.62,149.75,149.74,149.56,149.53,150.04,149.94,150,149.8,150.26,149.87]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Line
        let line = LineChartView()
//        var entries = [ChartDataEntry]()
//        var anotherEntries = [Double]()
//        for x in 1..<20 {
//            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
//            if x%2 == 0{
//                anotherEntries.append(Double(x*3-5))
//            } else {
//                anotherEntries.append(Double(x*2+4))
//            }
//
//        }
        
        line.translatesAutoresizingMaskIntoConstraints = false
        setChart(values: anotherEntries, line)
//        line.borderColor = .black
//        line.borderLineWidth =
        graph = line
        view.addSubview(graph)
        NSLayoutConstraint.activate([
            graph.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            graph.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            graph.bottomAnchor.constraint(equalTo: timeButtonsView.topAnchor, constant: -40),
            graph.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        
        //Buy button
        let button = UIButton()
        button.setTitle("Buy for $138.93", for: .normal)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont(name: "Montserrat", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.tintColor = .white
        buyButton = button
        view.addSubview(buyButton)
        
        //view for day weak ... butons
        let timesView = UIView()
        timesView.translatesAutoresizingMaskIntoConstraints = false
        timesView.backgroundColor = .white
        timeButtonsView = timesView
        view.addSubview(timeButtonsView)
        
        //buttons with time
        dayButton = returnButton(name: "D")
        timeButtonsView.addSubview(dayButton)
        
        weakButton = returnButton(name: "W")
        weakButton.backgroundColor = .black
        weakButton.setTitleColor(.white, for: .normal)
        timeButtonsView.addSubview(weakButton)
        
        monthButton = returnButton(name: "M")
        timeButtonsView.addSubview(monthButton)
        
        halfYearButton = returnButton(name: "6M")
        timeButtonsView.addSubview(halfYearButton)
        
        yearButton = returnButton(name: "Y")
        timeButtonsView.addSubview(yearButton)
        
        //Premium image
        let image = UIImageView()
        image.image = UIImage(named: "premium")
        image.translatesAutoresizingMaskIntoConstraints = false
        premiumImage = image
        view.addSubview(premiumImage)
        //Available label
        let label = UILabel()
        label.text = "Available only for premium users"
        label.font = UIFont(name: "Montserrat", size: 20)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        availableLabel = label
        view.addSubview(availableLabel)
        
        //Ticker label
        let labelTicker = UILabel()
        labelTicker.text = "APPL"
        labelTicker.font = UIFont(name: "Montserrat", size: 18)
        labelTicker.font = .boldSystemFont(ofSize: 18)
        labelTicker.textColor = .black
        labelTicker.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel = labelTicker
        view.addSubview(tickerLabel)
        //cOMPANY NAM LABEL
        let labelCompany = UILabel()
        labelCompany.text = "Apple Inc."
        labelCompany.font = UIFont(name: "Montserrat", size: 12)
        labelCompany.textColor = .black
        labelCompany.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel = labelCompany
        view.addSubview(companyNameLabel)
        
//        //STAR botton
//        let star = UIButton() //frame: CGRect(x: 280, y: 0, width: 44, height: 44)
////        let imageView = UIImageView()
////        imageView.image = UIImage(S)
//        let image 
////        star.imageView?.image = UIImage(systemName: "star.fill")
//        star.setBackgroundImage(UIImage(systemName: "star.fill" )?.SymbolConfiguration(font: .systemFont(ofSize: 32, weight: .bold)), for: .normal)
//        star.translatesAutoresizingMaskIntoConstraints = false
//        star.backgroundColor = .white
//
//        starButton = star
//        view.addSubview(starButton)
        
        //Collectionview
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        labelsCollectionView = cv
        view.addSubview(labelsCollectionView)
        
        //Price and Difference Labels
        let labelx = UILabel()
        labelx.text = "$138.93"
        labelx.textColor = .black
        labelx.font = UIFont(name: "Montserrat", size: 32)
        labelx.font = UIFont.boldSystemFont(ofSize: 32)
        labelx.translatesAutoresizingMaskIntoConstraints = false
        labelPrice  = labelx
        view.addSubview(labelPrice)
        let labely = UILabel()
        labely.text = "+$2.21 (1.62%)"
        labely.textColor = .green
        labely.font = UIFont(name: "Montserrat", size: 12)
//            .systemFont(ofSize: 12)
        labely.translatesAutoresizingMaskIntoConstraints = false
        labelPriceDifference = labely
        view.addSubview(labelPriceDifference)

        NSLayoutConstraint.activate([
            buyButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            buyButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buyButton.heightAnchor.constraint(equalToConstant: 56),
            
            timeButtonsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            timeButtonsView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            timeButtonsView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -52),
            timeButtonsView.heightAnchor.constraint(equalToConstant: 44),
            
            dayButton.topAnchor.constraint(equalTo: timeButtonsView.topAnchor),
            dayButton.bottomAnchor.constraint(equalTo: timeButtonsView.bottomAnchor),
            dayButton.trailingAnchor.constraint(equalTo: weakButton.leadingAnchor, constant: -10),
            dayButton.widthAnchor.constraint(equalToConstant: 45),
            
            weakButton.topAnchor.constraint(equalTo: timeButtonsView.topAnchor),
            weakButton.bottomAnchor.constraint(equalTo: timeButtonsView.bottomAnchor),
            weakButton.trailingAnchor.constraint(equalTo: monthButton.leadingAnchor, constant: -10),
            weakButton.widthAnchor.constraint(equalToConstant: 45),
            
            monthButton.topAnchor.constraint(equalTo: timeButtonsView.topAnchor),
            monthButton.bottomAnchor.constraint(equalTo: timeButtonsView.bottomAnchor),
            monthButton.centerXAnchor.constraint(equalTo: timeButtonsView.centerXAnchor),
            monthButton.widthAnchor.constraint(equalToConstant: 45),
            
            halfYearButton.topAnchor.constraint(equalTo: timeButtonsView.topAnchor),
            halfYearButton.bottomAnchor.constraint(equalTo: timeButtonsView.bottomAnchor),
            halfYearButton.leadingAnchor.constraint(equalTo: monthButton.trailingAnchor, constant: 10),
            halfYearButton.widthAnchor.constraint(equalToConstant: 45),
            
            yearButton.topAnchor.constraint(equalTo: timeButtonsView.topAnchor),
            yearButton.bottomAnchor.constraint(equalTo: timeButtonsView.bottomAnchor),
            yearButton.leadingAnchor.constraint(equalTo: halfYearButton.trailingAnchor, constant: 10),
            yearButton.widthAnchor.constraint(equalToConstant: 45),
            
            premiumImage.heightAnchor.constraint(equalToConstant: 260),
            premiumImage.widthAnchor.constraint(equalToConstant: 260),
            premiumImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 248),
            premiumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            availableLabel.bottomAnchor.constraint(equalTo: premiumImage.topAnchor),
            availableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            availableLabel.heightAnchor.constraint(equalToConstant: 56),
            
            tickerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tickerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            tickerLabel.heightAnchor.constraint(equalToConstant: 24),
            
            companyNameLabel.topAnchor.constraint(equalTo: tickerLabel.bottomAnchor, constant: 4),
            companyNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelsCollectionView.topAnchor.constraint(equalTo: companyNameLabel.topAnchor, constant: 24),
            labelsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            labelsCollectionView.heightAnchor.constraint(equalToConstant: 24),
            
            labelPriceDifference.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPriceDifference.bottomAnchor.constraint(equalTo: timeButtonsView.topAnchor, constant: -350),
            labelPriceDifference.heightAnchor.constraint(equalToConstant: 16),
            labelPriceDifference.widthAnchor.constraint(equalToConstant: 120),
            
            labelPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPrice.bottomAnchor.constraint(equalTo: labelPriceDifference.topAnchor, constant: -8),
            labelPrice.heightAnchor.constraint(equalToConstant: 32),
            labelPrice.widthAnchor.constraint(equalToConstant: 140)
//            starButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
//            starButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 16),
//            starButton.heightAnchor.constraint(equalToConstant: 48),
//            starButton.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        graph?.delegate = self
        availableLabel.isHidden = true
        premiumImage.isHidden = true
        title = ""
        labelsCollectionView.delegate = self
        labelsCollectionView.dataSource = self
        labelsCollectionView.register( labelsCell.self, forCellWithReuseIdentifier: "labelsCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func returnButton(name: String) -> UIButton{
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(name: "Montserrat", size: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#F0F4F7")
        button.setTitleColor(.black, for: .normal)
        return button
    }
}

extension GraphViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let index = selectedPaths {
            let deselectedCell = labelsCollectionView.cellForItem(at: index as IndexPath)! as! labelsCell
            deselectedCell.txtLabel.font = .systemFont(ofSize: 14, weight: .semibold)
            deselectedCell.txtLabel.textColor = .lightGray
        }
        
        selectedPaths = indexPath
        let selectedCell = labelsCollectionView.cellForItem(at:indexPath as IndexPath)! as! labelsCell
        selectedCell.txtLabel.font = .boldSystemFont(ofSize: 18)
        selectedCell.txtLabel.textColor = .black
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelsCell", for: indexPath)  as! labelsCell
        if indexPath.row == 0 {
            selectedPaths = indexPath
            cell.txtLabel.font = UIFont(name: "Montserrat", size: 18)
            cell.txtLabel.font = .boldSystemFont(ofSize: 18)
            cell.txtLabel.textColor = .black
        }
        cell.txtLabel.text = labels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: labels[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 30, height: 24)
    }
}
