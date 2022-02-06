//
//  WriteCommentsViewController.swift
//  Instagram
//
//  Created by y i on 2022/02/02.
//

import UIKit
import Firebase
import SVProgressHUD

class WriteCommentsViewController: UIViewController {
    var image: UIImage!
    //var comment: String!
    //var nameOfComment: String!
    var id: String!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    // コメント送信ボタン
    @IBAction func handleCommentButton(_ sender: Any) {
    
        //let id = Auth.auth().currentUser?.uid
        
        let nameOfComment = Auth.auth().currentUser?.displayName
        
        /*let postDic = [
            "id": id!,
            "comment": self.textField.text,
            "nameOfComment": nameOfCommentData!,
        ] as [String : Any]
        */
        let comment = "\(nameOfComment!):\(self.textField.text!)"
        print("commentの内容「\(comment)」")
        // postRef.setData(postDic)
        // FireStoreにコメントメッセージを追加
        let updateValue = FieldValue.arrayUnion([comment])
        let postRef = Firestore.firestore().collection(Const.PostPath).document(id)
        postRef.updateData(["comments": updateValue])
        
        // HUDで送信完了を表示する
        SVProgressHUD.showSuccess(withStatus: "送信しました。")
        // 送信処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
        
    }
    
    // キャンセルボタン
    @IBAction func handleCancelButton(_ sender: Any) {
        // ホーム画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        
    }
    

}
