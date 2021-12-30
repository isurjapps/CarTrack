//
//  UsersListScreenViewController.swift
//  CarTrack
//
//  Created by Prashant Singh on 12/5/21.
//

import UIKit
import Combine
import CoreLocation

class UsersListScreenViewController: UIViewController {
    
    private lazy var contentView = UsersListScreenView()
    private let viewModel:  UsersListScreenViewModel
    
    var userList: [UsersList] = []
    
    private let apiManager = APIManager()
    private var subscriber: AnyCancellable?
    
    init(viewModel:  UsersListScreenViewModel =  UsersListScreenViewModel(apiManager: APIManager())) {
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
        contentView.userListTable.delegate = self
        contentView.userListTable.dataSource = self
        
        title = "User's List"
        let logoutIcon = UIImage(systemName: "folder.circle")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logoutIcon, style: .plain, target: self, action: #selector(logoutSession))
        UIBarButtonItem.appearance().tintColor = UIColor.black
                    
        viewModel.fetchUser()
        observeViewModel()
        
        contentView.userListTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }
    
    private func observeViewModel() {
        subscriber = viewModel.usersSubject.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }) { (users) in
            DispatchQueue.main.async {
                self.userList = users
                self.contentView.userListTable.reloadData()
            }
        }
    }
    
    @objc func logoutSession(){
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let viewController = LoginScreenViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}

extension UsersListScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let modelUser = userList[indexPath.row]
        cell.textLabel?.text = modelUser.name
        cell.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.highlightedTextColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userSelected = userList[indexPath.item]
        let viewController = UserDetailsScreenViewController()
        let navigationVC = UINavigationController(rootViewController: viewController)
        viewController.selectedUser = userSelected
        
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true, completion: nil)
    }
}

