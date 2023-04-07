package dev.flutter.multipleflutters.activity

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.viewpager.widget.ViewPager
import dev.flutter.multipleflutters.R
import dev.flutter.multipleflutters.adapter.MyPagerAdapter
import dev.flutter.multipleflutters.fragment.FirstFragment
import dev.flutter.multipleflutters.fragment.ImFragment
import dev.flutter.multipleflutters.fragment.SecondFragment
import dev.flutter.multipleflutters.widget.NoScrollViewPager


class HomeActivity : AppCompatActivity() {
    private var selectIndex = -1

    private lateinit var viewPager: NoScrollViewPager

    private lateinit var first: TextView
    private lateinit var im: TextView
    private lateinit var second: TextView


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.home_activity)


        initView()
        changeFragment(0)
    }


    private fun initView() {
        viewPager = findViewById(R.id.view_pager)
        val adapter = MyPagerAdapter(supportFragmentManager)
        adapter.addFragment(FirstFragment(), "First")
        adapter.addFragment(ImFragment(), "im")
        adapter.addFragment(SecondFragment(), "Second")
        viewPager.adapter = adapter
        viewPager.offscreenPageLimit = 3
        viewPager.isScrollable = false

        viewPager.addOnPageChangeListener(object : ViewPager.OnPageChangeListener {
            override fun onPageScrolled(
                position: Int,
                positionOffset: Float,
                positionOffsetPixels: Int
            ) {
            }

            override fun onPageSelected(position: Int) {
                changeBottom(position, updatePage = false)
            }

            override fun onPageScrollStateChanged(state: Int) {
            }
        })

        first = findViewById(R.id.first)
        im = findViewById(R.id.im)
        second = findViewById(R.id.second)

        first.setOnClickListener {
            changeBottom(0)
        }
        im.setOnClickListener {
            changeBottom(1)
        }
        second.setOnClickListener {
            changeBottom(2)
        }
    }


    /// 改变底部视图
    private fun changeBottom(index: Int, updatePage: Boolean = true) {
        first.setBackgroundColor(0xffffff)
        im.setBackgroundColor(0xffffff)
        second.setBackgroundColor(0xffffff)
        when (index) {
            0 -> {
                first.setBackgroundResource(R.color.purple_500)
            }
            1 -> {
                im.setBackgroundResource(R.color.purple_500)
            }
            2 -> {
                second.setBackgroundResource(R.color.purple_500)
            }
        }
        // 切换
        if (updatePage) {
            changeFragment(index)
        }
    }

    /// 选择哪个fragment显示
    private fun changeFragment(index: Int) {
        selectIndex = index
        viewPager.setCurrentItem(index, false)
    }
}