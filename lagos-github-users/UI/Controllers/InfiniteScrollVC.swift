//
//  InfiniteScrollVC.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 10/02/2022.
//

import Foundation
import UIKit
class InfiniteScrollTableViewController:UITableViewController{
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
         showDataLoading(scrollView: scrollView)
    }
    
    open func fetchData(){}
   
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
           spinner.hidesWhenStopped = true
           spinner.tag = 419
           return spinner
    }()
    

    
    var isLoadingPaginatedResults = false
    
    var page = 1
    
    func showDataLoading(scrollView: UIScrollView){
        let scrollHeight = scrollView.contentOffset.y + scrollView.frame.size.height - 40
               
               /// If user drags screen to height more than what is shown in content, show loader and load more data
               if (scrollHeight > (scrollView.contentSize.height-100)) && isLoadingPaginatedResults == false {
                   //activityIndicatorView?.startAnimating()
                   
                if page != 1 {
                    tableView.tableFooterView = spinner
                    tableView.tableFooterView?.isHidden = false
                     spinner.startAnimating()
                }
                  
                   isLoadingPaginatedResults = true
            
                   fetchData()
               }
    }
    
    
   func stopLoading(){
       self.isLoadingPaginatedResults = false
       self.spinner.stopAnimating()
   }
}

