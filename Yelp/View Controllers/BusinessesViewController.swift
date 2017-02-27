//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController {

    var businesses: [Business]!
    
    var searchBar: UISearchBar!

    var yelpFilter = YelpFilter()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //init ui search bar
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Restaurants"
        
        //Add SeachBar to navigation
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //dymanic height according to the content height
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView() // remove divider when no data in tableview

        yelpFilter.term = "Thai"
        yelpFilter.offset = 0
        doSearch()
        
    }
    
    func doSearch(){
        // Display HUD right before the request is made
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: self.yelpFilter.term!) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                MBProgressHUD.hide(for: self.view, animated: true)
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    func doSearchWithFilter(with term: String, sort s: YelpSortMode, categories c: [String], deals d: Bool, radius r: Int){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        yelpFilter.term = term
        yelpFilter.sortBy = s
        yelpFilter.categories = c
        yelpFilter.isOfferDeal = d
        yelpFilter.distance = r
        Business.search(with: term, sort: yelpFilter.sortBy, categories: yelpFilter.categories, deals: yelpFilter.isOfferDeal, radius: yelpFilter.distance, offset: nil) { (businesses: [Business]?, error: Error?) in
            if error != nil {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("\(error)")
                return
            }
            if let businesses = businesses {
                self.businesses = businesses
                MBProgressHUD.hide(for: self.view, animated: true)
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func loadDataMore(){
        let offset = self.businesses.count
        Business.search(with: yelpFilter.term!, sort: yelpFilter.sortBy, categories: yelpFilter.categories, deals: yelpFilter.isOfferDeal, radius: yelpFilter.distance, offset: offset) { (businesses: [Business]?, error: Error?) in
            if error != nil {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("\(error)")
                return
            }
            if let businesses = businesses {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.businesses.append(contentsOf: businesses)
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        let filterVC = navVC.topViewController as! FilterViewController
        filterVC.delegate = self
    }
    
    var isLoadMoreData = false
    
   
}

extension BusinessesViewController: FilterViewDelegate{
    func onSearchWithFilters(sort s: Int, categories c: [String], deal d: Bool, radius r: Int) {
        print("jump here \(c)")
        doSearchWithFilter(with: "", sort: YelpSortMode(rawValue: s)!, categories: c, deals: d, radius: r)
    }
}

//tableView method
extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses == nil {
            return 0
        } else {
            return businesses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isLoadMoreData) {
            let scrollViewHeight = scrollView.contentSize.height
            let scrollViewOffset = scrollViewHeight - scrollView.bounds.size.height
            if (scrollView.contentOffset.y > scrollViewOffset && scrollView.isDragging) {
                isLoadMoreData = true
                //load more data
                loadDataMore()
            }
        }
    }
    
}

//SearchBar methods
extension BusinessesViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder() //close keyboard
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let value = searchBar.text
        searchBar.resignFirstResponder()
        
        //todo search
        yelpFilter.term = value
        yelpFilter.offset = 0;
        doSearch()
    }
}
