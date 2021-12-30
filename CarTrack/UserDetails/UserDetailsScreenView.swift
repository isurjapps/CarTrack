//
//  UserDetailsScreenView.swift
//  CarTrack
//
//  Created by Prashant Singh on 12/5/21.
//

import UIKit
import MapKit

final class UserDetailsScreenView: UIView {
        
        lazy var userLocation = MKMapView()
        lazy var userNameLabel = UILabel()
        lazy var emailLabel = UILabel()
        
        lazy var addressLabel = UILabel()
        lazy var websiteLabel = UILabel()

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
            [userLocation, userNameLabel, emailLabel, addressLabel, websiteLabel]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        }
        
        private func setUpConstraints() {
            
            NSLayoutConstraint.activate([
                userLocation.topAnchor.constraint(equalTo: self.topAnchor),
                userLocation.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                userLocation.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
                userLocation.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0.0),
                userLocation.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
                
                userNameLabel.topAnchor.constraint(equalTo: userLocation.bottomAnchor, constant: 20),
                userNameLabel.centerXAnchor.constraint(equalTo: userLocation.centerXAnchor),
                userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
                userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
                userNameLabel.heightAnchor.constraint(equalToConstant: 60.0),
                
                emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
                emailLabel.centerXAnchor.constraint(equalTo: userNameLabel.centerXAnchor),
                emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
                emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
                emailLabel.heightAnchor.constraint(equalToConstant: 20.0),
                
                websiteLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
                websiteLabel.centerXAnchor.constraint(equalTo: emailLabel.centerXAnchor),
                websiteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
                websiteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
                websiteLabel.heightAnchor.constraint(equalToConstant: 20.0),
                
                addressLabel.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 20),
                addressLabel.centerXAnchor.constraint(equalTo: websiteLabel.centerXAnchor),
                addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
                addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
                addressLabel.heightAnchor.constraint(equalToConstant: 50.0)
            ])
        }
        
        private func setUpViews() {
            backgroundColor = UIColor.white
            userNameLabel.font = UIFont(name: "Chalkduster", size: 24)
            addressLabel.numberOfLines = 0
            addressLabel.lineBreakMode = .byWordWrapping
            
            userNameLabel.textColor = UIColor.black
            emailLabel.textColor = UIColor.black
            websiteLabel.textColor = UIColor.black
            addressLabel.textColor = UIColor.black
        }
}
