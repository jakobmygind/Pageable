//
//  Pageable.swift
//  DoGood
//
//  Created by Jakob Mygind on 13/07/16.
//  Copyright © 2016 DooGood. All rights reserved.
//

import Foundation
import PagedArray
import Nodes

public protocol Pageable {
    var pagesLoading:Set<Int> {get set}
}

extension Pageable {
    
    public func loadDataIfNeededForRow<T>(_ dataSource:PagedArray<T>, row: Int, preloadMargin:Int = 5, loadDataBlock:((Int)->Void)) {
        
        let currentPage = dataSource.page(for: row)
        if needsLoadDataForPage(dataSource, page: currentPage) {
            loadDataBlock(currentPage)
            return
        }
        
        let preloadIndex = row+preloadMargin
        if preloadIndex < dataSource.endIndex {
            let preloadPage = dataSource.page(for: preloadIndex)
            if preloadPage > currentPage && needsLoadDataForPage(dataSource, page: preloadPage) {
                loadDataBlock(preloadPage)
            }
        }
    }
    
    fileprivate func needsLoadDataForPage<T>(_ dataSource:PagedArray<T>, page: Int) -> Bool {
        if let index = dataSource.indexes(for: page).first?.advanced(by: 1), index < dataSource.count {
            return dataSource[index] == nil && !pagesLoading.contains(page)
        }
        return false
    }
    
    public func configureDataSourceFromResponse<T>(_ scrolltypeView: UIScrollView?, dataSource: inout PagedArray<T>, response:PaginatedResponse<T>){
        guard let scrolltypeView = scrolltypeView else { return }
        
        let page = response.meta.pagination.currentPage
        
        if page == 1 {
            dataSource = PagedArray<T>(count: response.meta.pagination.total, pageSize: response.meta.pagination.perPage, startPage: 1)
        }
        
        dataSource.set(elements: response.data, at: page)
        
        if page == 1 {
            
            reloadDataForScrollTypeView(scrolltypeView)
        }
        else {
            
            if let visiblePaths = visiblePathsForScrollTypeView(scrolltypeView) {
                var indexPathsToReload = [IndexPath]()
                for p in visiblePaths {
                    let currentPage = dataSource.page(for: p.row)
                    if page == currentPage {
                        indexPathsToReload.append(p)
                    }
                }
                if indexPathsToReload.count > 0 {
                    print("reloading paths after api response")
                    reloadIndexPathsForScrollTypeView(indexPathsToReload, scrolltypeView: scrolltypeView)
                    
                }
            }
        }
        
    }
    
    fileprivate func reloadIndexPathsForScrollTypeView(_ indexPaths:[IndexPath], scrolltypeView: UIScrollView) {
        
        if let tbl = scrolltypeView as? UITableView {
            tbl.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }
        else  if let col = scrolltypeView as? UICollectionView {
            col.reloadItems(at: indexPaths)
        }
    }
    
    fileprivate func reloadDataForScrollTypeView(_ scrolltypeView: UIScrollView) {
        
        if let tbl = scrolltypeView as? UITableView {
            tbl.reloadData()
        }
        else  if let col = scrolltypeView as? UICollectionView {
            col.reloadData()
        }
    }
    
    fileprivate func visiblePathsForScrollTypeView(_ scrolltypeView:UIScrollView) -> [IndexPath]? {
        var visiblePaths:[IndexPath]?
        if let tbl = scrolltypeView as? UITableView {
            visiblePaths = tbl.indexPathsForVisibleRows
        }
        else if let col = scrolltypeView as? UICollectionView {
            visiblePaths = col.indexPathsForVisibleItems
        }
        return visiblePaths
    }
    
}


