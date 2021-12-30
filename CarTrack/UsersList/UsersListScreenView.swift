//
//  UsersListScreenView.swift
//  CarTrack
//
//  Created by Prashant Singh on 12/5/21.
//

import UIKit

final class UsersListScreenView: UIView {
    
    lazy var userListView = UIView()
    lazy var userListTable = UITableView()

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
        [userListView, userListTable]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            userListView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userListView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userListView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            userListView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            userListView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            
            userListTable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userListTable.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50),
            userListTable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            userListTable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            userListTable.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1)
        ])
    }
    
    private func setUpViews() {
        userListView.backgroundColor = UIColor.white
        userListTable.backgroundColor = UIColor.white
    }
}


