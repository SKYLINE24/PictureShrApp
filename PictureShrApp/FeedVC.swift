//
//  FeedVC.swift
//  PictureShrApp
//
//  Created by Erbil Can on 3.09.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    //databaseden gelen veriler dizi halinde gelecek onları bir değişkene atamamız için değişkenlerimizi oluşturuyoruz
    
    /*var emailDizisi = [String]()
    var yorumDizisi = [String]()
    var gorselDizisi = [String]()*/
    
    var postDizisi = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        firebaseVerileriAl()
        
        // Do any additional setup after loading the view.
    }
    
    func firebaseVerileriAl(){
        let firestoreDatabase = Firestore.firestore()//database değişkenimizi oluşturduk
        
        firestoreDatabase.collection("Post").order(by: "tarih", descending: true)
            .addSnapshotListener { (snapshot, error) in
            
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    //her feed sayfasına geçtiğinde üstüne ekleyecek olduğu için silip aşşağıda tekrar yüklenmesini sağlıyoruz
                    
                    
                    /*self.emailDizisi.removeAll(keepingCapacity: false)
                    self.gorselDizisi.removeAll(keepingCapacity: false)
                    self.yorumDizisi.removeAll(keepingCapacity: false)*/
                    self.postDizisi.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents{
                        
                        
                        //let documentId = document.documentID
                        
                        if let gorselUrl = document.get("gorselUrl") as? String{
                            if let yorum = document.get("yorum") as? String{
                                if let email = document.get("email") as? String{
                                    let post = Post(email: email, yorum: yorum, gorselUrl: gorselUrl)
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()//yeni bir veri geldiğini ve gösterileceğini söylüyoruz
                }
            }
        }  //databasedeki post klasörüne kulaşabiliyorum şuan
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell       //feed kısmındaki başlangıçta gösterilecekleri ayarladık
        cell.emailText.text = postDizisi[indexPath.row].email
        cell.yorumText.text = postDizisi[indexPath.row].yorum
        cell.postImageView.sd_setImage(with: URL(string: self.postDizisi[indexPath.row].gorselUrl))
        return cell
    }


}
