//
//  ViewController.swift
//  FlickrSearch
//
//  Created by jh on 2021/09/22.
//

import UIKit

enum FlickrConstants {
  static let reuseIdentifier = "FlickrCell"
  static let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
  static let itemsPerRow: CGFloat = 3
}

class ViewController: UIViewController {
    
    private var searches: [FlickrSearchResults] = []
    private let flickr = Flickr()
    
    // MARK: - drag n drop

    var largePhotoIndexPath: IndexPath? {
      didSet {
        var indexPaths: [IndexPath] = []
        if let largePhotoIndexPath = largePhotoIndexPath {
          indexPaths.append(largePhotoIndexPath)
        }

        if let oldValue = oldValue {
          indexPaths.append(oldValue)
        }

        imageCollectionView.performBatchUpdates({
          self.imageCollectionView.reloadItems(at: indexPaths)
        }, completion: { _ in
          if let largePhotoIndexPath = self.largePhotoIndexPath {
            self.imageCollectionView.scrollToItem(
              at: largePhotoIndexPath,
              at: .centeredVertically,
              animated: true)
          }
        })
      }
    }

    
    @IBAction func selectBtn(_ sender: UIBarButtonItem) {
//        print("btn pressed")
        var selectedLabel = UIBarButtonItem(title: "0 photos selected", style: .plain, target: .none, action: nil)
        
        selectedLabel.tintColor = .systemGreen
        if self.navigationItem.rightBarButtonItems?.count == 1{
            self.navigationItem.rightBarButtonItems?.append(selectedLabel)
        }
    }
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionCellUI()
        imageCollectionView.dragInteractionEnabled = true
    }
    
    
}



// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        let flickrPhoto = searches[indexPath.section].searchResults[indexPath.row]
        cell.backgroundColor = .white
        cell.cellImage.image = flickrPhoto.thumbnail
        return cell
    }
    
    // MARK: - HeaderCollectionReusableView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath)
            
            guard let typedHeaderView = headerView as? HeaderCollectionReusableView else { return headerView }
            
            let searchTerm = searches[indexPath.section].searchTerm
            typedHeaderView.titleLabel.text = searchTerm
            
            return typedHeaderView
            
        default:
            assert(false, "Invalid element type")
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath == largePhotoIndexPath {
          let flickrPhoto = searches[indexPath.section].searchResults[indexPath.row]
          var size = collectionView.bounds.size
          size.height -= 70
          size.width -= 40
          return flickrPhoto.sizeToFillWidth(of: size)
        }
        let paddingSpace = FlickrConstants.sectionInsets.left * (FlickrConstants.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / FlickrConstants.itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // MARK: - drag n drop IndexPath
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if largePhotoIndexPath == indexPath {
            largePhotoIndexPath = nil
        } else {
            largePhotoIndexPath = indexPath
        }
        return false
    }
    

    
}


// MARK: - Text Field Delegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, !text.isEmpty else { return true }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        flickr.searchFlickr(for: text) { searchResults in
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
                
                switch searchResults {
                case .failure(let error) :
                    print("Error Searching: \(error)")
                    
                case .success(let results):
                    self.searches.insert(results, at: 0)
                    self.imageCollectionView.reloadData()
                }
            }
        }
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

