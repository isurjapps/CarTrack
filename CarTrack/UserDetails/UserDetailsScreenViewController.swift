//
//  UserDetailsScreenViewController.swift
//  CarTrack
//
//  Created by Prashant Singh on 12/5/21.
//
import Foundation
import UIKit
import MapKit
import CoreLocation

class UserDetailsScreenViewController: UIViewController, CLLocationManagerDelegate {
    
    private lazy var contentView = UserDetailsScreenView()
    private let viewModel:  UserDetailsScreenViewModel
    private var locationManager: CLLocationManager!

    var selectedUser: UsersList!
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    init(viewModel:  UserDetailsScreenViewModel =  UserDetailsScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    private func initialization() {
        title = "User Details"
        let logoutIcon = UIImage(systemName: "folder.circle")
        let backIcon = UIImage(systemName: "arrowshape.turn.up.backward.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logoutIcon, style: .plain, target: self, action: #selector(logoutSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backIcon, style: .plain, target: self, action: #selector(gobackToList))
        UIBarButtonItem.appearance().tintColor = UIColor.black
        
        let emailImg = NSTextAttachment()
        emailImg.image = UIImage(systemName: "envelope.circle")
        let fullEmailString = NSMutableAttributedString()
        fullEmailString.append(NSAttributedString(attachment: emailImg))
        fullEmailString.append(NSAttributedString(string: " " + selectedUser.email))
        contentView.emailLabel.attributedText = fullEmailString
        contentView.userNameLabel.text = selectedUser.name
        contentView.addressLabel.text = ((selectedUser.address?.street ?? "") + ", " + (selectedUser.address?.suite ?? "") + ", " + (selectedUser.address?.city ?? "")) + ", " + (selectedUser.address?.zipcode ?? "")
        
        let webSiteImg = NSTextAttachment()
        webSiteImg.image = UIImage(systemName: "globe")
        let fullWebSiteString = NSMutableAttributedString()
        fullWebSiteString.append(NSAttributedString(attachment: webSiteImg))
        fullWebSiteString.append(NSAttributedString(string: " " + selectedUser.website))
        contentView.websiteLabel.attributedText = fullWebSiteString
        
        if let lat = Double((selectedUser.address?.geo!.lat)!) {
            latitude = lat
        }
        
        if let lng = Double((selectedUser.address?.geo!.lng)!) {
            longitude = lng
        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        contentView.userLocation.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        contentView.userLocation.addAnnotation(pin)         
    }
    
    @objc func logoutSession(){
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let viewController = LoginScreenViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    @objc func gobackToList(){
        let viewController = UsersListScreenViewController()
        let navigationVC = UINavigationController(rootViewController: viewController)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true, completion: nil)
    }
}


