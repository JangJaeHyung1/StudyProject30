//
//  ViewController.swift
//  FlickrSearch
//
//  Created by jh on 2021/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBAction func selectBtn(_ sender: UIBarButtonItem) {
        print("btn pressed")
        var selectedLabel = UIBarButtonItem(title: "0 photos selected", style: .plain, target: .none, action: nil)
//        selectedLabel.isEnabled = false
        selectedLabel.tintColor = .systemGreen
        if self.navigationItem.rightBarButtonItems?.count == 1{
            self.navigationItem.rightBarButtonItems?.append(selectedLabel)
        }
    }
    
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        collectionCellUI()
    }
    
    
}



extension ViewController: UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UIScrollViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = .gray
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let keyword = searchController.searchBar.text {
            print(keyword)
        }
    }
    
    func setupSearchController() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem?.tintColor = .systemGreen
    }
    
    func collectionCellUI(){
        let interval:CGFloat = 5
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: interval , left: interval, bottom: 0, right: interval)
        flowLayout.minimumInteritemSpacing = interval
        flowLayout.minimumLineSpacing = interval
        let width: CGFloat = ( UIScreen.main.bounds.width - interval) / 3
        flowLayout.itemSize = CGSize(width: width - interval, height: width - interval)
        
        self.imageCollectionView.collectionViewLayout = flowLayout
        self.imageCollectionView.reloadData()
    }
    
    private func createSpinenerFooter() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
}

