//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Hilmihan Çalışan on 18.08.2022.
//

import UIKit
import Firebase


class FeedCell: UITableViewCell {

    @IBOutlet weak var useremailLabel: UILabel!
    
    @IBOutlet weak var commendLabel: UILabel!
    
    @IBOutlet weak var userImageLabel: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var documentIdLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        
        
        
        let firestoreDataBase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes" : likeCount + 1 ] as [String : Any]
            
            firestoreDataBase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
        
    }
}
