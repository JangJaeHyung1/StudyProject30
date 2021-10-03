//
//  ViewController.swift
//  GitFollowers
//
//  Created by jh on 2021/10/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wrongGitIdLbl: UILabel!
    @IBOutlet weak var emptyResultLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var arr : Followers = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ifEmptySearchLblSet()
        setSearchBar()
        indicatorSet()
    }

    func indicatorSet(){
        self.view.bringSubviewToFront(self.indicator)
        indicator.hidesWhenStopped = true
    }
    
    func ifEmptySearchLblSet(){
        self.view.bringSubviewToFront(self.emptyResultLbl)
        emptyResultLbl.isHidden = true
        self.view.bringSubviewToFront(self.wrongGitIdLbl)
        wrongGitIdLbl.isHidden = true
    }
    

}

// MARK: - tableVC delegate

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let url: URL = URL(string: "\(arr[indexPath.row].avatarURL)"){
            let imageData = try! Data(contentsOf: url)
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        cell.textLabel?.text = arr[indexPath.row].login
        return cell
    }
    

}

// MARK: - searchBar delegate

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        arr = []
        
        if let keyword = searchBar.text?.lowercased(){
            indicator.startAnimating()
            self.wrongGitIdLbl.isHidden = true
            self.emptyResultLbl.isHidden = true
            requestGitFollowers(userName: keyword) { [weak self] followers in
                if let followers = followers {
                    self?.arr = followers
                    DispatchQueue.main.async {
                        if followers.count == 0{
                            self?.emptyResultLbl.isHidden = false
                            self?.tableView.reloadData()
                            self?.indicator.stopAnimating()
                        }else {
                            self?.tableView.reloadData()
                            self?.indicator.stopAnimating()
                        }
                    }
                } else{
                    DispatchQueue.main.async {
                        self?.wrongGitIdLbl.isHidden = false
                        self?.indicator.stopAnimating()
                        self?.tableView.reloadData()
                    }
//                    print(followers)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arr = []
        tableView.reloadData()
    }
    
    func setSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색할 ID 를 입력해주세요"
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Git Follower Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
