"""DjangoExam URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf.urls import url
from exam import views

urlpatterns = [
    path('admin/', admin.site.urls),
    url(r'^$', views.index),  # 默认访问首页
    path('register/', views.register),
    path('index/', views.index, name='index'),
    path('studentLogin/', views.studentLogin, name='studentLogin'),  # 学生登录
    path('examInfo/', views.examInfo, name='examInfo'),  # 学生已经报名的考试
    path('availableTest/', views.availableTest, name='availableTest'),  # 学生可报名的考试
    path('payBill/', views.payBill, name='payBill'),  # 支付
    path('startExam/', views.startExam, name='startExam'),  # 开始考试
    path('checkAnswer/', views.checkAnswer, name='checkAnswer'),  # 教师阅卷
    path('teacherLogin/', views.teacherLogin, name='teacherLogin'),  # 教师登录
    path('checkAnswer/', views.checkAnswer, name='checkAnswer'),  # 教师给主观题打分
    path('stuScore/', views.stuScore, name='stuScore'),  # 学生查看成绩
    path('uploadFile/', views.uploadFile, name='uploadFile'),  # 教师上传试卷
    path('stulogout/', views.stulogout, name='stulogout'),  # 学生退出登录
    path('insertBookRecord/', views.insertBookRecord, name='insertBookRecord'),  # 记录报名结果
]
