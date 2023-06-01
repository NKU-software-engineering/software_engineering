# Create your models here.
from django.db import models
"""
提前说明的问题：
1.默认一套卷子只可以被某个学生做一次
2.学生可以查询可以参加的考试(通过Book表和TestPaper表结合，有testpaper的id出现在Book记录中，就不会作为可选考试展示给学生)
3.学生在选择可选考试后，进入预订和缴费页面，成功后向Book表中插入一条信息。
4.学生试卷界面展示所有Book的考试记录。考试状态分为三种：未参加考试（Book表中有学生和考试的id，Answer_Score中没有任何记录）；
已参加考试未出成绩（Answer_Score中有可以查询到有学生id和试卷id的记录，但是Record中没有）（也就是说如果学生没有做答完试卷就退出了，视作全部提交）；
已出成绩（Record中有记录）。
5.学生点击未作答的考试，会出现试题。每回答一道题就点击提交一次，提交的时候会向Answer_Score表中插入一条记录。这里记录中的分数已经被初始化为None，方便老师阅卷的时候，后面系统根据是否是None判断这道题是否已经被给过分了。给过分的题目不再出现在阅卷中。
如果全部答完，给出提示框，已答完所有题。学生点击提交的如果是客观题，系统自动对比输入答案和正确答案，在向向Answer_Score表中插入一条记录的时候就直接给分了。
6.教师登录后，系统自动搜索Answer_Score中的分数为默认值的记录。输出题目和学生的答案。画一个输入框，方便老师给分。老师给分后，update这条记录，也就是把成绩放进记录中。
我们默认教师登陆一次会给完所有的分。在教师给分的最后设置一个提交按钮，教师点击后会遍历Answer_Score表，根据学生id和考试id共同分组，求成绩总和。
得到一条总成绩记录之后在Record表中查找，如果已经有学生id和考试id的记录信息，就不再插入了，没有就插入这条记录。
这样很不合理因为每次都得算每个人每场考试的成绩，但是这样很方便写代码，为了交作业先勉强这样做。
"""

# 学生表
class Student(models.Model):
    sid = models.CharField('学号', max_length=12, primary_key=True)
    name = models.CharField('姓名', max_length=20, unique=True)
    sex = models.BooleanField('性别', choices=((0, '女'), (1, '男')))
    age = models.IntegerField('年龄')
    email = models.EmailField('邮箱', default=None)  # 默认为空   唯一值
    pwd = models.CharField('密码', max_length=20)

    # 修改显示的表的名字
    class Meta:
        verbose_name = '学生'
        verbose_name_plural = '学生信息表'

    def __str__(self):
        return self.sid

# 教师表（仅在登录时需要使用）
class Teacher(models.Model):
    tid = models.CharField('职工号', max_length=12, primary_key=True)
    name = models.CharField('姓名', max_length=20, unique=True)
    pwd = models.CharField('密码', max_length=20,null=True)
    # 修改显示的表的名字
    class Meta:
        verbose_name = '教师'
        verbose_name_plural = '教师信息表'
    def __str__(self):
        return self.tid

# 试卷表
class TestPaper(models.Model):
    id = models.AutoField('序号', primary_key=True)
    title = models.CharField('名称', max_length=40, unique=True)
    time = models.IntegerField('考试时长', help_text='单位是分钟')
    examtime = models.DateTimeField('考试时间')
    fee = models.IntegerField('费用', null=True)

    class Meta:
        # 选择这个表之后显示的名字
        verbose_name = '试卷'
        verbose_name_plural = '试卷'

    def __str__(self):
        return self.id


# 题目(存放所有题目)
class QuestionBank(models.Model):
    id = models.AutoField('序号', primary_key=True)
    paper = models.ForeignKey(TestPaper, on_delete=models.CASCADE, verbose_name='试卷')
    title = models.TextField('题目')
    qtype = models.CharField('题目类型', choices=(('单选', '单选'), ('主观', '主观')), max_length=40)
    a = models.CharField('A选项', max_length=40)
    b = models.CharField('B选项', max_length=40)
    c = models.CharField('C选项', max_length=40)
    d = models.CharField('D选项', max_length=40)
    answer = models.TextField('正确答案')
    difficulty = models.CharField('难度', choices=(('easy', '简单'), ('middle', '中等'), ('difficult', '难')), max_length=10)
    score = models.IntegerField('分值')

    class Meta:
        # 选择这个表之后显示的名字
        verbose_name = '题库'
        # 显示的表名
        verbose_name_plural = '题库'

    def __str__(self):
        return self.id

# 考试预订
class Book(models.Model):
    id = models.AutoField('序号', primary_key=True)
    sid = models.ForeignKey(Student, on_delete=models.CASCADE, verbose_name='学号')
    tid = models.ForeignKey(TestPaper, on_delete=models.CASCADE, verbose_name='序号')
    paid = models.BooleanField('是否付款', choices=((0, '否'), (1, '是')))
    # 修改显示的表的名字
    class Meta:
        verbose_name = '预订信息'
        verbose_name_plural = '预订考试及付款信息表'
    def __str__(self):
        return self.id

# 记录考生的答案和每一道题的得分
class Answer_Score(models.Model):
    id = models.AutoField('序号', primary_key=True)
    # 学生id
    sid = models.ForeignKey(Student, on_delete=models.CASCADE, verbose_name='学生')
    # 试卷id
    tid = models.ForeignKey(TestPaper, on_delete=models.CASCADE, verbose_name='试卷')
    # 题目id
    qid = models.ForeignKey(QuestionBank, on_delete=models.CASCADE, verbose_name='题目')
    title = models.TextField('题目')
    answer = models.TextField('答案')
    score = models.IntegerField('得分', default=1000)  # 有点怕None会出bug

    class Meta:
        # 选择这个表之后显示的名字
        verbose_name = '答题记录和评分'
        # 显示的表名
        verbose_name_plural = '答题记录和评分'

    def __str__(self):
        return self.id


# # 学生成绩表
class Record(models.Model):
    id = models.AutoField('序号', primary_key=True)
    sid = models.ForeignKey(Student, on_delete=models.CASCADE, verbose_name='学号', related_name='stu_xuehao')
    tid = models.ForeignKey(TestPaper, on_delete=models.CASCADE, verbose_name='考试', related_name='stu_test')
    grade = models.FloatField('成绩')

    class Meta:
        verbose_name = '学生成绩'
        verbose_name_plural = '学生成绩'

    def __str__(self):
        return '<%s:%s>' % (self.sid, self.grade)