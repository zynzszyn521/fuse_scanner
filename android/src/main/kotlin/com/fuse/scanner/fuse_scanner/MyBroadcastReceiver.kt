//import android.content.BroadcastReceiver
//import android.content.Context
//import android.content.Intent
//import android.util.Log
//
//class MyBroadcastReceiver : BroadcastReceiver() {
//    private val TAG = "MyBroadcastReceiver"
//
//    override fun onReceive(context: Context, intent: Intent) {
//        val action = intent.action
//        if (action != null && action == "com.honeywell.tools.datawedge.api.ACTION_RESULT") {
//            val data = intent.getStringExtra("com.honeywell.tools.datawedge.api.RESULT_GET_DATA")
//            if (data != null && data.isNotEmpty()) {
//                // 在这里将 data 发送给 Flutter 侧进行处理
//                Log.d(TAG, "Received scan data: $data")
//            }
//        }
//    }
//}
