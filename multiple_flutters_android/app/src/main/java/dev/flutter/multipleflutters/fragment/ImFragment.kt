package dev.flutter.multipleflutters.fragment

import android.content.Context
import android.content.Intent
import android.os.Bundle
import dev.flutter.multipleflutters.EngineBindings
import dev.flutter.multipleflutters.EngineBindingsDelegate
import dev.flutter.multipleflutters.activity.MainActivity
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine

class ImFragment : FlutterFragment(), EngineBindingsDelegate {

    private var engineBindings: EngineBindings? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        engineBindings?.attach()
    }


    override fun onDestroy() {
        super.onDestroy()
        engineBindings?.detach()
    }


    private fun getEngineBindings(): EngineBindings {
        if (engineBindings == null) {
            engineBindings = EngineBindings(
                context = context,
                delegate = this,
                entrypoint = "main",
                initialRoute = "/im"
            )
        }
        return engineBindings!!
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine {
        return getEngineBindings().engine
    }

    override fun onNext() {
        val flutterIntent = Intent(activity, MainActivity::class.java)
        startActivity(flutterIntent)
    }
}