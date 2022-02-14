//
//  Extensions.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 14/02/2022.
//

import UIKit

extension UIView{
    func pinToLeft(_ parentView:UIView,constant:CGFloat = 0){
        self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: constant).isActive = true
    }
    
    func pinToRight(_ parentView:UIView,constant:CGFloat = 0){
        self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: constant).isActive = true
    }
    
    func pinToBottom(_ parentView:UIView,constant:CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: constant).isActive = true
    }
    
    func pinToTop(_ parentView:UIView,constant:CGFloat = 0){
        self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: constant).isActive = true
    }
    
    func setHeight(_ constant:CGFloat){
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func setWidth(_ constant:CGFloat){
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
