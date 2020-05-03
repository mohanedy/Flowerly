//
//  ViewController.swift
//  Flowerly
//
//  Created by Mohaned Yossry on 5/1/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import Vision
import CoreML


class HomeViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    let imagePicker = UIImagePickerController()
    var wikiServices = WikiServices()
    var currentFlower:Flower?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        wikiServices.delegate = self
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
             picker.dismiss(animated: true, completion: nil)
            guard let ciImage = CIImage(image: selectedImage) else{
                fatalError("Cannot Get the CIImage")
            }
           
            self.showSpinner(onView: self.view)
            detect(image:ciImage)
            
        }
        
    }
    
    func detect(image:CIImage){
        guard let model = try? VNCoreMLModel(for: FlowerlyClassifier().model) else {
                   fatalError("Cannot load the model")
               }
               
               
               let request = VNCoreMLRequest(model: model) { (request, error) in
                   guard let results = request.results as? [VNClassificationObservation] else{
                       fatalError("Cannot convert the array to VNClassificationObservation")
                   }
                   if let firstResult = results.first {
                    print(firstResult.identifier.capitalized)
                    self.wikiServices.fetchQuery(query: firstResult.identifier)
                    
                   }
               }
               
               
               let handler = VNImageRequestHandler(ciImage: image)
               
               do {
                   try handler.perform([request])
               } catch  {
                   print("There's Problem in handling the request \(error)")
               }
               
    }
    
    @IBAction func identifyUsingCameraPressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        showImagePicker()
    }
    
    @IBAction func identifyUsingGallery(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        showImagePicker()
    }
    
    func showImagePicker(){
        present(imagePicker, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toDetailsSegue {
            let destinationVC = segue.destination as! DetailsViewController
             destinationVC.flower = currentFlower
        }
    }
}

extension HomeViewController : WikiServicesDelegate{
    func didLoadFlowerData(_ wikiServices: WikiServices, flower: Flower) {
        removeSpinner()
        currentFlower = flower
        performSegue(withIdentifier: K.toDetailsSegue, sender: self)
    }
    
    func didFailWithError(_ error: String) {
        removeSpinner()
        print(error)
    }
    
    
}

