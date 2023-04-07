package dev.flutter.multipleflutters.activity

import android.content.Context
import android.content.Intent
import android.os.Bundle
import dev.flutter.multipleflutters.EngineBindings
import dev.flutter.multipleflutters.EngineBindingsDelegate
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

/**
 * 单个flutter页面
 */
class SingleFlutterActivity : FlutterActivity(), EngineBindingsDelegate {


    private var engineBindings: EngineBindings? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        engineBindings?.attach()
    }

    override fun onDestroy() {
        super.onDestroy()
        engineBindings?.detach()
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine {
        return getEngineBindings().engine
    }

    private fun getEngineBindings(): EngineBindings {
        if (engineBindings == null) {
            val initialRoute = intent.getStringExtra("initialRoute")
            engineBindings = EngineBindings(
                context = this,
                delegate = this,
                entrypoint = "main",
                initialRoute = initialRoute!!
            )
        }
        return engineBindings!!
    }

    override fun onNext() {
        val flutterIntent = Intent(this, MainActivity::class.java)
        startActivity(flutterIntent)
    }
}
