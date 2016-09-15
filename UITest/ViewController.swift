//
//  ViewController.swift
//  UITest
//
//  Created by Jakob Mygind on 14/09/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import UIKit
import Nodes
import Pageable
import Serializable
import Alamofire
import PagedArray

class TableViewController: UIViewController, Pageable, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var manager:SessionManager = SessionManager(configuration: TableViewController.configuration())
    
    var pagesLoading = Set<Int>()
    var listings = PagedArray<Listing>(count: 0, pageSize: 0, startPage: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(page: Int = 1) {
        if pagesLoading.contains(page) { return } else { pagesLoading.insert(page)}
        
        listingsClosest(pageNo: page) { (response) in
            self.pagesLoading.remove(page)
            switch response.result {
            case .success(let res):
                self.configureDataSourceFromResponse(self.tableView, dataSource: &self.listings, response: res)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadDataIfNeededForRow(self.listings, row: indexPath.row) { (page) in
            self.loadData(page: page)
        }
    }
}












extension TableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let id = listings[indexPath.row]?.id {
            cell.textLabel?.text = String(id)
        }
        else {
            cell.textLabel?.text = ""
        }
        
        return cell
    }
}

extension TableViewController {
   
    
    static func configuration() -> URLSessionConfiguration {
        let staticHeaders = ["Accept" : "application/vnd.nodes.v1+json" , "Cache-Control" : "no-cache", "User-Agent" : "test"] //, "Cache-Control" : "no-cache"
        
        let configuration = SessionManager.default.session.configuration
        configuration.timeoutIntervalForRequest = 20.0
        configuration.httpAdditionalHeaders = staticHeaders
        return configuration
    }
    
    
    static var authHeadersNStack:[String: String] {
        return ["X-Application-Id" : "H8zKJ3pI7MEUSxJtHj9OeFdG6bZoKdI2SjnX", "X-Rest-Api-Key" :  "TblNOy227Kp0DIjaFhIasN5VPyQOSIuvszEK"]
    }
    
    func listingsClosest(pageNo:Int = 1, completion: @escaping (DataResponse<PaginatedResponse<Listing>>) -> Void) {
        let url = "https://dogood.like.st/api/listings/search?coordinate=55.45,12.25&page=\(pageNo)"
        manager.request(url, method: .get).responseSerializable(completion)
        
    }
    
}

