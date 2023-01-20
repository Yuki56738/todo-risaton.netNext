# -*- coding: utf-8 -*-

from kivy.app import App
from kivy.core.text import LabelBase, DEFAULT_FONT
from kivy.resources import resource_add_path
from kivy.uix import label
from kivy.uix.label import Label
from kivy.uix.widget import Widget

# from kivy.properties import StringProperty, ObjectProperty
from kivy.properties import *

resource_add_path('fonts')
LabelBase.register(DEFAULT_FONT, 'mplus-2c-regular.ttf')


class Widget1(Widget):
    # text = StringProperty()  # プロパティの追加
    # lb1 =
    def __init__(self, **kwargs):
        super(Widget1, self).__init__(**kwargs)
        # self.text = ''

    def clicked1(self):  # ボタンをクリック時
        # self.lb1
        # print(self.lb1)
        # self.ids.label1.font_name = './fonts/Roboto-Medium.ttf'
        self.ids.label1.text = 'こんにちは'


class App1(App):
    def __init__(self, **kwargs):
        super(App1, self).__init__(**kwargs)
        # self.title = 'greeting'

    def build(self):
        return Widget1()


if __name__ == '__main__':
    App1().run()
