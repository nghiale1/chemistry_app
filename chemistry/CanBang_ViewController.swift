//
//  CanBang_ViewController.swift
//  pthh
//
//  Created by Nghia on 11/10/2021.
//

import Vision
import UIKit

class CanBang_ViewController: UIViewController,UINavigationControllerDelegate,
                              UIImagePickerControllerDelegate {

    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var List=ListChemistry
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "example4")
        recognizeText(image: imageView.image)
    }
    
    func searchElephantIndex(name: String) -> Int? {
        return List.firstIndex { $0.reactants == name }
    }
    
    private func recognizeText(image:UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        //handle
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [ :  ])
        //request
        let request = VNRecognizeTextRequest{[weak self]
            request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation ],
                  error == nil else{
                      return
                  }
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ",  ")
            DispatchQueue.main.async {
                self?.textView.text=text
                
                self?.degree()
            }
            
        }
        
        //process request
        do{
            try handler.perform([request])
        }catch{
            print(error )
        }
    }
    
    func degree(){
        let data = String((self.textView.text.filter { !" \n\t\r".contains($0) }))
        var arrTextView : [String] = data.components(separatedBy: "+")
        arrTextView.sort()
        let joined = arrTextView.joined(separator: "+")
        if let i = self.List.firstIndex(where: { $0.reactants == joined }) {
            self.labelResult.text=self.List[i].product
        }
        else{
            self.labelResult.text="Không có kết quả phù hợp"
        }
    }

    @IBAction func gallary(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage{
            imageView.image = image
            recognizeText(image: imageView.image)
        }else{
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findPT(_ sender: Any) {
        self.degree()
    }
    

}
