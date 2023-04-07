package dev.flutter.multipleflutters.activity

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.TextView
import dev.flutter.multipleflutters.DataModel
import dev.flutter.multipleflutters.DataModelObserver
import dev.flutter.multipleflutters.R

class MainActivity : AppCompatActivity(), DataModelObserver {
    private lateinit var countView: TextView
    private val mainActivityIdentifier: Int = mainActivityCount

    private companion object {
        var mainActivityCount = 0
    }

    init {
        mainActivityCount += 1
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.main_activity)
        DataModel.instance.addObserver(this)
        countView = findViewById(R.id.count)
        countView.text = DataModel.instance.counter.toString()
    }

    override fun onDestroy() {
        super.onDestroy()
        DataModel.instance.removeObserver(this)
    }

    fun onClickNext(view: View) {
        val nextClass =
            if (mainActivityIdentifier % 2 == 0) SingleFlutterActivity::class.java else DoubleFlutterActivity::class.java
        val flutterIntent = Intent(this, nextClass)
        startActivity(flutterIntent)
    }

    fun onClickAdd(view: View) {
        DataModel.instance.counter = DataModel.instance.counter + 1
    }

    override fun onCountUpdate(newCount: Int) {
        countView.text = newCount.toString()
    }
}
