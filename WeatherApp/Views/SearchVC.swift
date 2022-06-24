//
//  SearchVC.swift
//  WeatherApp
//
//  Created by Guglielmo Chimera on 13/06/22.
//

import UIKit

class SearchVC: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = SearchViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
}


extension SearchVC {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.searchResultList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let location = viewModel.searchResultList?[indexPath.row] {
            cell.textLabel?.text = location.country
        }
        return cell
    }
}


extension SearchVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      let _ = viewModel.performSearch(byCityName: searchText, limit: 15)
        self.tableView.reloadData()
    }

}



