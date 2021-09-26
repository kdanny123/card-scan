//
//  TextRequest.swift
//  Card Scan
//
//  Created by Admin on 9/24/21.
//
import Foundation
import Vision
import VisionKit


class TextRequest: ObservableObject {
    @Published var text: String = ""
    
    
    func recognizeText(image: UIImage?) {
        
        guard let cgImage = image?.cgImage else {
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest {request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {return}
            
            
        
            let recognizedStrings = observations.compactMap({observation in
                return observation.topCandidates(1).first?.string
            }).joined(separator: "\n")
            
            self.text = recognizedStrings
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        do {
            try requestHandler.perform([request])
        } catch {
            print(error)
        }
        
        
    }
}
