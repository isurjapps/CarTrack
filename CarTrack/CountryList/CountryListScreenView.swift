//
//  CountryListScreenView.swift
//  CarTrack
//
//  Created by Prashant Singh on 11/5/21.
//

import UIKit

final class CountryListScreenView: UIView {
    
    lazy var popupView = UIView()
    lazy var countrySearchBar = UISearchBar()
    lazy var countryTable = UITableView()

    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func addSubviews() {
        [popupView, countrySearchBar, countryTable]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        countryTable.accessibilityIdentifier = "countryTable"
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 36.0),
            popupView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -36.0),
            popupView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            
            countrySearchBar.topAnchor.constraint(equalTo: popupView.topAnchor),
            countrySearchBar.leftAnchor.constraint(equalTo: popupView.leftAnchor),
            countrySearchBar.widthAnchor.constraint(equalTo: popupView.widthAnchor),
            countrySearchBar.heightAnchor.constraint(equalToConstant: 30.0),
            
            countryTable.topAnchor.constraint(equalTo: countrySearchBar.bottomAnchor, constant: 2),
            countryTable.leftAnchor.constraint(equalTo: popupView.leftAnchor),
            countryTable.widthAnchor.constraint(equalTo: popupView.widthAnchor),
            countryTable.heightAnchor.constraint(equalTo: popupView.heightAnchor, constant: -30 )
        ])
    }
    
    private func setUpViews() {
        backgroundColor = UIColor.clear
        popupView.backgroundColor = UIColor.white
    }
}

