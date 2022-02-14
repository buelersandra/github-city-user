//
//  ProfileCell.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 09/02/2022.
//

import UIKit

class ProfileCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var user:UserRecord!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    lazy var profileImage:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        let gesturen = UITapGestureRecognizer(target: self, action: #selector(viewUser))
        view.addGestureRecognizer(gesturen)
        view.image = UIImage(named: "default_image")
        return view
    }()
    
    lazy var favImage:UIButton = {
        let view = UIButton()
        view.setImage( UIImage(named: "unfavorite"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
        return view
    }()
    
    lazy var profileName:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var container:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.selectionStyle = .none
         setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        self.contentView.addSubview(container)
        container.pinToLeft(self.contentView,constant: 16)
        container.pinToRight(self.contentView,constant: -16)
        container.pinToTop(self.contentView,constant:16)
        container.pinToBottom(self.contentView,constant: -16)
        container.setHeight(60)
        
        container.addSubview(profileName)
        container.addSubview(profileImage)
        container.addSubview(favImage)
        
        profileImage.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        profileImage.pinToLeft(container)
        profileImage.setHeight(40)
        profileImage.setWidth(40)
        
        profileName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 8).isActive = true
        profileName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true

        profileName.pinToRight(container)
        profileName.setHeight(20)
        
        favImage.pinToRight(container)
        favImage.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        favImage.setHeight(40)
        favImage.setWidth(30)
        
        
    }
    
    
    @objc func tapFavorite(){
        DataHelper.shared.favoriteUser(user: self.user)
    }
    
    func openBrowser(url : String){
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func viewUser(){
        openBrowser(url: user.html_url ?? "")
    }
    
    func render(user:UserRecord){
        self.user = user
        profileName.text = user.login
        if let profileUrl = user.avatar_url{
            Requester.shared.loadUserImage(url: profileUrl) { downloadedImage in
                self.setDefaultImage(uimage: downloadedImage)
            }
        }else{
            setDefaultImage()
        }
        
        favImage.setImage(  user.favorite ? UIImage(named: "favorite") : UIImage(named: "unfavorite"), for: .normal)
    }
    
    func setDefaultImage(uimage:UIImage? = nil){
        profileImage.image = uimage ?? UIImage(named: "default_image")
    }
    

}


