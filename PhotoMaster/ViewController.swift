//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 福井彩乃 on 2020/05/08.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    //写真表示用ImageView
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()}
        // Do any additional setup after loading the view.
    
//カメラ、アルバムの呼び出しメソッド（カメラorアルバムのソースタイプが引数）
func presentPickerController(sourceType: UIImagePickerController.SourceType){
    if UIImagePickerController.isSourceTypeAvailable(sourceType){
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = self
        self.present(picker,animated:true, completion: nil)}
    }
    //写真が選択された時に呼ばれるメソッド
func imagePickerController(_ picker: UIImagePickerController,
                           didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]){
self.dismiss(animated: true, completion: nil)
//画像を出力
    photoImageView.image = info[.originalImage]as? UIImage}
    
    //カメラボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedCameraButton(){
            presentPickerController(sourceType: .camera)}
    //アルバムボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedAlbumButton(){
           presentPickerController(sourceType: .photoLibrary)}
   
    //テキスト合成ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedTextButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawText(image: photoImageView.image!)
        } else{print("画像がありません")}
    }
    //イラスト合成ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedIllusutButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else{print("画像がありません")}
    }
    //アップロードボタンが押された時に呼ばれるメソッド
    @IBAction func onTappedUploadButton(){
        if photoImageView.image != nil{
        //共有するアイテムを設定
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!, "#Photoaster"],applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }else{print("画像がありません")}
    }

    func drawText(image: UIImage)->UIImage{//元の画像にテキストを合成するメソッド
        let text = "LifeisTech!"//テキストの内容の設定
        
        let textFontAttributes = [//textFontAttributes:文字の特性の設定
            NSAttributedString.Key.font:UIFont(name:"Arial",size:120)!,
            NSAttributedString.Key.foregroundColor: UIColor.red]
            UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y:0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 5.0//余白
let textRect = CGRect(x: margin, y:margin, width: image.size.width - margin, height: image.size.height - margin)
        text.draw(in: textRect, withAttributes: textFontAttributes)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!}
    
    func drawMaskImage(image: UIImage)-> UIImage{//元の画像にイラストを合成するメソッド
        let maskImage = UIImage(named: "furo_ducky")!//マスク画像保存場所の設定
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin,
                              y: image.size.height - maskImage.size.height - margin,
                              width: maskImage.size.width, height: maskImage.size.height)
        maskImage.draw(in: maskRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }  
}
