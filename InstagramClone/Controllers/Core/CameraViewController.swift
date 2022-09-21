//
//  CameraViewController.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/15.
//
import AVFoundation
import UIKit

class CameraViewController: UIViewController {
    
    private var output = AVCapturePhotoOutput()
    private var captureSession: AVCaptureSession?
    private let previewLayer = AVCaptureVideoPreviewLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Camera"
        view.backgroundColor = .black
        setUpNavBar()
        setUpCamera()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        if let session = captureSession, !session.isRunning{
            captureSession?.startRunning()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.session = captureSession
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height)
        view.layer.addSublayer(previewLayer)
        captureSession?.startRunning()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession?.stopRunning()
    }
    
    @objc func didTapClose(){
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
        
    }
    private func setUpNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
        navigationController?.navigationBar.setBackgroundImage(UIImage(),for:UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func checkCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video){
            
        case .notDetermined:
            // request access
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else{
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
        
    }
    
    private func setUpCamera(){
        
        //Add device
        let captureSession = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video){
            do{
                let input = try AVCaptureDeviceInput(device: device)
                if captureSession.canAddInput(input){
                    captureSession.addInput(input)
                }
            }
            catch {
                print(error)
            }
            if captureSession.canAddOutput(output){
                captureSession.addOutput(output)
            }
            
        }
    }
    

}
