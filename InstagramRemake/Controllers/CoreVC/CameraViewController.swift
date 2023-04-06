//
//  CameraViewController.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 22.03.2023.
//

import UIKit
import AVFoundation

//open camera and take photo -> import AVFoundation

class CameraViewController: UIViewController {
    
    private var output = AVCapturePhotoOutput()
    private var captureSession: AVCaptureSession?
    private let previewLayer = AVCaptureVideoPreviewLayer()
    
    private let cameraView = UIView()
    
    //in order to take a photo we need to add a button and call
    private let shutterButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.label.cgColor
        button.backgroundColor = nil
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Take Photo"
        view.addSubview(cameraView)
        view.addSubview(shutterButton)
        setUpNavBar()
        checkCameraPermission()
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    
    //hide the tabBar to have a cleaner UI
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        //in order to camera to restart running
        if let session = captureSession, session.isRunning {
            session.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.frame = view.bounds
        previewLayer.frame = CGRect(x: 0,
                                    y: view.safeAreaInsets.top,
                                    width: view.width,
                                    height: view.width)
        let buttonSize: CGFloat = view.width/5
        shutterButton.frame = CGRect(x: (view.width - buttonSize)/2, y: view.safeAreaInsets.top + view.width + 100, width: buttonSize, height: buttonSize)
        shutterButton.layer.cornerRadius = buttonSize/2
    }
    
    
    //in order not to use the battery (camera is still working on background)
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession?.stopRunning()
    }
    
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
            
        case .notDetermined:
            //request
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted , .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
        
    }
    
    private func setUpCamera() {
        //add device
        let captureSession = AVCaptureSession()
        
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            }
            catch {
                print(error)
            }
            
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
            
            // layer
            
            previewLayer.session = captureSession
            previewLayer.videoGravity = .resizeAspectFill
            cameraView.layer.addSublayer(previewLayer)
            //view.layer.addSublayer(previewLayer)
            
            
            captureSession.startRunning()
            
        }
        
    }
    
    private func setUpNavBar() {
        //since the tabbar is hidden we need a button to close this tab
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    
    @objc func didTapClose() {
        //when the user pushes the close button we will reveal the tabBar and go to the homeVC - it has the index 0
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
        
    }
    
    @objc func didTapTakePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
}


extension CameraViewController: AVCapturePhotoCaptureDelegate {
    //capturing photo
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        //stop the capture
        captureSession?.stopRunning()
        //converting data into a image
        guard let image = UIImage(data: data) else {
            return
        }
       
        let vc = PostEditViewController(image: image)
        navigationController?.pushViewController(vc, animated: false)
    }
    
}
