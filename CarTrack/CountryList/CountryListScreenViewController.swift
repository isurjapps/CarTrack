//
//  CountryListScreenViewController.swift
//  CarTrack
//
//  Created by Prashant Singh on 11/5/21.
//

import UIKit

protocol CountryListScreenViewControllerDelegate {
    func displayTextOnLoginScreen(textToDisplay: String)
}

class CountryListScreenViewController: UIViewController {
    
    private lazy var contentView = CountryListScreenView()
    private let viewModel:  CountryListScreenViewModel
    
    var searchedCountry = [String]()
    var searching = false
    var countrySelected: String?
    
    var countryListScreenViewControllerDelegate: CountryListScreenViewControllerDelegate?
    
    init(viewModel:  CountryListScreenViewModel =  CountryListScreenViewModel()) {
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
        viewModel.loadCountries()
        contentView.countryTable.delegate = self
        contentView.countryTable.dataSource = self
        contentView.countrySearchBar.delegate = self
        
        contentView.countryTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }
}

extension CountryListScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCountry.count
        } else {
            return viewModel.countryListWithFlag.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        if searching {
            cell.textLabel?.text = searchedCountry[indexPath.row]
        } else {
            cell.textLabel?.text = self.viewModel.countryListWithFlag[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            let selectedCountry = searchedCountry[indexPath.row]
            countrySelected = selectedCountry
        } else {
            let selectedCountry = viewModel.countryListWithFlag[indexPath.row]
            countrySelected = selectedCountry
        }
        countryListScreenViewControllerDelegate?.displayTextOnLoginScreen(textToDisplay: countrySelected ?? "")
        self.dismiss(animated: true, completion: nil)
    }
}

extension CountryListScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCountry = viewModel.countryListWithFlag.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        contentView.countryTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        contentView.countrySearchBar.text = ""
        contentView.countryTable.reloadData()
    }
}
