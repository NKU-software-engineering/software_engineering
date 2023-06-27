from django.contrib import admin

# Register your models here.

# 修改名称
admin.site.site_header='在线考试系统后台'
admin.site.site_title='在线考试系统'

from exam.models import Teacher, Student, TestPaper, QuestionBank, Book, Answer_Score, Record

admin.site.register([Teacher, Student, TestPaper, QuestionBank, Book, Answer_Score, Record])