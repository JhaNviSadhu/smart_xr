import UIKit
import Flutter
import flutter_downloader

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
   FlutterDownloaderPlugin.setPluginRegistrantCallback { registry in if !registry.hasPlugin("FlutterDownloaderPlugin"), let registrar = registry.registrar(forPlugin: "FlutterDownloaderPlugin") { FlutterDownloaderPlugin.register(with: registrar) } }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
  
