package com.fuse.scanner.fuse_scanner

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FuseScannerPlugin */
class FuseScannerPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel
  private val myBroadcastReceiver = MyBroadcastReceiver()
  private val HONEYWELL_SCAN_ACTION = "com.honeywell.decode.intent.action.EDIT_DATA"
  private val BARCODE_DATA_ACTION   = "com.ehsy.warehouse.action.BARCODE_DATA"
  private val IDATA_SCAN_ACTION    = "android.intent.action.SCANRESULT"
  private val CHANNEL_NAME = "com.fuse.scanner/methods"

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
    channel.setMethodCallHandler(this)
    registerReceiver(flutterPluginBinding.applicationContext)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }else if (call.method == "startScan") {
      //手動執行掃碼，需要調用掃碼槍接口
      result.success("手動執行掃碼,需要調用第三方方法")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    unregisterReceiver(binding.applicationContext)
  }

  private fun registerReceiver(context: Context) {
    val honeywellIntentFilter  = IntentFilter()
    honeywellIntentFilter .addAction(HONEYWELL_SCAN_ACTION)
    context.registerReceiver(myBroadcastReceiver, honeywellIntentFilter )

    val honeyIntentFilter  = IntentFilter()
    honeyIntentFilter.addAction(BARCODE_DATA_ACTION)
    context.registerReceiver(myBroadcastReceiver, honeyIntentFilter)

    val iDataIntentFilter   = IntentFilter()
    iDataIntentFilter.addAction(IDATA_SCAN_ACTION)
    context.registerReceiver(myBroadcastReceiver, iDataIntentFilter)
  }

  private fun unregisterReceiver(context: Context) {
    context.unregisterReceiver(myBroadcastReceiver)
  }

  inner class MyBroadcastReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
      val action = intent.action
      var data="";
      if(action != null){
        if (action==HONEYWELL_SCAN_ACTION||action==BARCODE_DATA_ACTION) {
          data = intent.getStringExtra("data").toString();
        }else if(action==IDATA_SCAN_ACTION){
          data = intent.getStringExtra("value").toString();
        }
        // 将扫描结果数据发送给 Flutter 侧进行处理
        Log.i("Allen","onScanResult: $data")
        channel.invokeMethod("onScanResult", data)
      }
    }
  }
}


