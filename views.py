from datetime import datetime
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.urls import reverse
from exam import models
from django.db.models import Sum
import pandas as pd
import os

UPLOADFILE = '../upload/'


# 首页应该有三个按钮(或者导航栏)：教师登录(teacherLogin)，学生登录(studentLogin)，学生注册(register)
def index(request):
    if request.session.get('is_login', None):  # 若session认证为真
        username = request.session.get('username', None)
        print(username)
        try:
            student = models.Student.objects.get(sid=username)
            return render(request, 'index.html', {'user': student})
        except:
            teacher = models.Teacher.objects.get(tid=username)
            return render(request, 'index.html', {'user': teacher})
    else:
        return render(request, 'index.html')


# 方便起见就只学生需要注册了，教师只需要登录
def register(request):
    if request.method == 'POST':
        # 获取表单信息
        sid = request.POST.get('sid')  # 学号
        password = request.POST.get('password')  # 密码

        print("sid", sid, "password", password)
        try:
            models.Student.objects.create(sid=sid, pwd=password)
        except:
            return render(request, 'register.html', {'message': '注册失败'})
        return render(request, 'register.html', {'message': '注册成功'})  # 给一个返回主界面的按钮
    elif request.method == 'GET':
        return render(request, 'register.html')
    else:
        return HttpResponse("请使用GET或POST请求数据")


# 学生登录
def studentLogin(request):
    if request.method == 'POST':
        # 获取表单信息
        sid = request.POST.get('sid')
        password = request.POST.get('password')
        print("sid", sid, "password", password)
        # 通过学号获取该学生实体
        try:
            student = models.Student.objects.get(sid=sid)
        except:
            return render(request, 'studentLogin.html', {'message': '账号或密码不正确'})
        print(student)
        if password == student.pwd:  # 登录成功
            request.session['username'] = sid  # user的值发送给session里的username
            request.session['is_login'] = True  # 认证为真
            return redirect('/examInfo')  # , 'paper': paper, 'grade': grade})
        else:
            return render(request, 'studentLogin.html', {'message': '账号或密码不正确'})
    elif request.method == 'GET':
        return render(request, 'studentLogin.html')
    else:
        return HttpResponse("请使用GET或POST请求数据")


# 学生登录后可以看到所有已注册的考试，包括未考、已考为批阅、已批阅
"""
大致布局可以是这样：

按钮（点击查看可报名的考试）跳转到availableTest

我的考试（这里是已报名已缴费的考试）：

--------------
|  考试名     |         未完成的的考试   按钮（点击进入考试界面）跳转到startExam
|            |
--------------
--------------
|  考试名     |         已完成的的考试   按钮，啥也不跳转，提示：尚未批阅
|            |
--------------
--------------
|  考试名     |         已完成的的考试   按钮（点击查看成绩）跳转到stuScore
|            |
--------------
"""


def examInfo(request):
    # 查看已注册的考试信息
    username = request.session.get('username', None)
    booked = models.Book.objects.filter(sid=username)
    exams_info = {}
    for i in booked:
        exam_info = {}
        testpaper = models.TestPaper.objects.get(id=i.id)
        print(i.id)
        exam_info['name'] = testpaper.title
        is_finished = models.Answer_Score.objects.filter(sid=username, tid=i.id)
        print(len(is_finished))
        if len(is_finished) > 0:
            exam_info['is_finished'] = 1
        else:
            exam_info['is_finished'] = 0
        is_marked = models.Record.objects.filter(sid=username, tid=i.id)
        if len(is_marked) > 0:
            exam_info['is_marked'] = 1
        else:
            exam_info['is_marked'] = 0
        exams_info[exam_info['name']] = exam_info
        print(exams_info)
    return render(request, 'examInfo.html', {'exams_info': exams_info, 'student': username})


# 查看可报名的考试
"""
大致布局可以是这样：

按钮（返回我的已注册的考试界面）跳转到examInfo

可报名的考试（这里是从未参加过的考试）：

--------------
|  考试名     |    费用       勾选框（点击报名）
|            |
--------------
--------------
|  考试名     |     费用      勾选框（点击报名）
|            |
--------------
--------------
|  考试名     |     费用      勾选框（点击报名）
|            |
--------------
提交按钮(跳转到payBill函数)
"""


def availableTest(request):
    username = request.session.get('username', None)
    available = {}

    exams = models.TestPaper.objects.all()

    for i in exams:
        try:
            booked = models.Book.objects.get(sid=username, tid=i.id)
        except:
            available[i.title] = i.fee

    print(available)
    # 测试数据是否传递
    context = {
        'available': available,
    }
    return render(request, 'availableTest.html', context)


# 放一个付款码和一个 确定按钮（跳转到insertBookRecord函数）
def payBill(request):
    # exams是前端给我返回来的一个列表，由0和1组成，1表示勾选了该项考试（这个列表可以根据复选框获取）
    fee = 0
    available = request.GET.get('available')
    exams = request.POST.get('exams')
    all_fee = list(available.values())
    for i in range(len(exams)):
        if exams[i]:
            fee += all_fee[i]
    return render(request, 'payBill.html', {'available': available, 'fee': fee})  # fee是一共要付的费用


# 插入考试报名记录
def insertBookRecord(request):
    # 上一步的payBill一定要把available和exams给我传过来
    available = request.GET.get('available')
    exams = request.GET.get('exams')
    username = request.session.get('username', None)
    exam_names = list(available.keys())
    num = models.Book.count()
    for i in range(len(exams)):
        if exams[i]:
            testpaper = models.TestPaper.objects.get(title=exam_names[i])
            try:
                models.Book.objects.create(id=num, sid=username, tid=testpaper.id, paid=1)
                num += 1
            except:
                return render(request, 'examInfo.html', {'message': '缴费失败'})
    return redirect('/examInfo', {'message': '缴费成功'})


# 考试界面最后给一个交卷按钮（跳转到插入答题记录函数insertAnswerRecord）
def startExam(request):
    sid = request.GET.get('sid')
    title = request.GET.get('title')
    # 去掉传回来的引号
    #print(sid)
    #print(title)
    # 获取学生信息
    student = models.Student.objects.get(sid=sid)
    # 试卷信息
    paper = models.TestPaper.objects.get(title=title)
    questions = models.QuestionBank.objects.filter(paper=paper.id)

    context = {
        'student': student,
        'paper': paper,
        'title': title,
        'questions': questions,
        # 问题我就一起传了，每个问题有主客观的属性，去前端判断主客观题吧
        'count': questions.count()
        # 数据表中数据的条数
    }
    print(questions[0].title, paper.id, questions.count())
    return render(request, 'startExam.html', context)


def insertAnswerRecord(request):  # 相当于原来的calculateGrade那个位置
    if request.method == 'POST':
        sid = request.GET.get('sid')  # 这个上一步的student怎么传过去的按照原样传回来就行
        paper = request.GET.get('paper')  # 这个上一步paper怎么传过去的按照原样传回来就行
        questions = request.GET.get('questions')  # 这个上一步questions怎么传过去的按照原样传回来就行
        answers = request.GET.get('answers')  # 传一个链表，请按照题目顺序传，如果是选择题，传字符串'A', 'B', 'C', 'D'(不知道是否可以实现？)，主观题传字符串答案
        select_question_answer = ['A', 'B', 'C', 'D']
        num = models.Answer_Score.count()
        for i in range(len(answers)):
            score = 0
            if answers[i] in select_question_answer:
                if answers[i] == questions[i].answer:  # 应该可以用索引的形式访问吧？不可以再改
                    score = questions[i].score
                try:
                    models.Answer_Score.objects.create(id=num, sid_id=sid, tid=paper.id, qid=questions[i].id,
                                                       title=questions[i].title, answer=answers[i], score=score)
                    num += 1
                except:
                    return redirect('/examInfo', {'message': '答题提交失败'})
                    # 这里会出现一个问题，如果不是第一条记录插入失败，这里会返回提交失败；但是由于Record表中有它的答题记录
                    # 最后examInfo.html界面会显示已答题，再说吧，先交了这个demo

            else:
                try:
                    models.Answer_Score.objects.create(id=num, sid_id=sid, tid=paper.id, qid=questions[i].id,
                                                       title=questions[i].title, answer=answers[i])
                    num += 1
                except:
                    return redirect('/examInfo', {'message': '答案提交失败'})

        return redirect('/examInfo', {'message': '答案提交成功'})


# 教师登录
def teacherLogin(request):
    if request.method == 'POST':
        # 获取表单信息
        tid = request.POST.get('tid')
        password = request.POST.get('password')
        print("tid", tid, "password", password)
        # 通过学号获取该教师实体
        try:
            teacher = models.Teacher.objects.get(tid=tid)
        except:
            return render(request, 'teacherLogin.html', {'message': '账号或密码不正确'})
        if password == teacher.pwd:  # 登录成功
            request.session['username'] = tid  # user的值发送给session里的username
            request.session['is_login'] = True  # 认证为真
            return redirect('/checkAnswer', {'teacher': teacher})
        else:
            return render(request, 'teacherLogin.html', {'message': '账号或密码不正确'})
    elif request.method == 'GET':
        return render(request, 'teacherLogin.html')
    else:
        return HttpResponse("请使用GET或POST请求数据")


# 教师给主观题打分
"""
大致界面长这样：
题目    答案    打分框
按钮（提交，跳转到成绩计算函数updateScore）
按钮：上传试卷，点击后跳转到upload
"""


def checkAnswer(request):
    records = models.Answer_Score.objects.all()
    unchecked = []
    for i in records:
        if i.score == 1000:
            unchecked.append(i)
    return render(request, 'checkAnswer.html', {'unchecked': unchecked})


def updateScore(request):
    username = request.session.get('username', None)
    scores = request.GET.get("scores")  # 按照顺序传回来得分
    unchecked = request.GET.get("")  # 怎么传过去的怎么传回来
    for i in range(len(unchecked)):
        id = unchecked[i].id
        try:
            models.Answer_Score.objects.filter(id=id).update(score=scores[i], is_active=True)
        except:
            return redirect('/index', {'message': '评分提交失败', 'user': username})
    calculateScore()
    return redirect('/index', {'message': '评分提交成功', 'user': username})


def calculateScore():
    records = models.Answer_Score.objects.values("sid", "tid").annotate(sum_num=Sum("score"))
    for i in records:
        try:
            re = models.Record.objects.get(sid=i["sid"], tid=i["tid"])
        except:
            models.Record.objects.create(sid=i["sid"], tid=i["tid"], grade=i["sum_num"])


# 上传试卷，试卷格式为：考试名称_
def upload_file(request):
    username = request.session.get('username', None)
    if request.method == "POST":  # 请求方法为POST时，进行处理
        if not os.path.exists(UPLOADFILE):
            os.makedirs(UPLOADFILE)
        myFile = request.FILES.get("myfile", None)  # 获取上传的文件，如果没有文件，则默认为None
        if not myFile:
            return render(request, 'checkAnswer.html', {'message': '文件上传失败', 'user': username})
        if myFile.name.split('.')[-1] == 'xlsx':
            return render(request, 'checkAnswer.html', {'message': '请上传.xlsx格式的文件', 'user': username})
        destination = open(os.path.join(UPLOADFILE, myFile.name), 'wb+')  # 打开特定的文件进行二进制的写操作
        for chunk in myFile.chunks():  # 分块写入文件
            destination.write(chunk)
        destination.close()
        '''
        try:
            paper2DB(myFile.name)
        except:
            return render(request, 'checkAnswer.html', {'message': '文件上传失败', 'user': username})
        return render(request, 'checkAnswer.html', {'message': '文件上传成功', 'user': username})
        '''
    else:
        return render(request, 'checkAnswer.html', {'message': '文件上传失败', 'user': username})


'''
def paper2DB(fname):
    element = fname.split('_')
    models.TestPaper.objects.create(id=element, sid=, tid=, grade=)
    df = pd.read_excel(os.path.join(UPLOADFILE, fname))
    for i in range(len(df)):
'''


# 查看成绩
def stuScore(request):
    sid = request.GET.get('sid')
    title = request.GET.get('title')  # 试卷名字 唯一
    # 获取学生信息
    student = models.Student.objects.get(sid=sid)
    # 试卷
    paper = models.TestPaper.objects.get(title=title)
    # 答题记录
    answer_record = models.Answer_Score.objects.filter(tid=paper.id, sid=sid)
    # 试卷总分
    grade = models.Record.objects.get(tid=paper.id, sid=sid)
    context = {
        'student': student,
        'paper': paper,
        'title': title,
        'answer_record': answer_record,
        'score': grade.grade
    }
    return render(request, 'stuScore.html', context=context)


# 学生退出登录
def stulogout(request):
    request.session.clear()
    url = reverse('index')
    return redirect(url)

# 上传试卷，试卷格式为：考试名称_
def uploadFile(request):
    username = request.session.get('username', None)
    if request.method == "POST":    # 请求方法为POST时，进行处理
        if not os.path.exists(UPLOADFILE):
            os.makedirs(UPLOADFILE)
        myFile = request.FILES.get("myfile", None)    # 获取上传的文件，如果没有文件，则默认为None
        if not myFile:
            return render(request, 'checkAnswer.html', {'message': '文件上传失败', 'user': username})
        if myFile.name.split('.')[-1] == 'xlsx':
            return render(request, 'checkAnswer.html', {'message': '请上传.xlsx格式的文件', 'user': username})
        destination = open(os.path.join(UPLOADFILE, myFile.name), 'wb+')    # 打开特定的文件进行二进制的写操作
        for chunk in myFile.chunks():      # 分块写入文件
            destination.write(chunk)
        destination.close()
        try:
            paper2DB(myFile.name)
        except:
            return render(request, 'checkAnswer.html', {'message': '文件上传失败', 'user': username})
        return render(request, 'checkAnswer.html', {'message': '文件上传成功', 'user': username})

    else:
        return render(request, 'checkAnswer.html', {'message': '文件上传失败', 'user': username})

def paper2DB(fname):
    element = fname.split('_')
    models.TestPaper.objects.create(id=element[0], title=element[1], time=element[2], examtime=element[3], fee=element[4].replace(".xlsx", ""))
    df = pd.read_excel(os.path.join(UPLOADFILE, fname))
    for i in range(len(df)):
        id, paper, title, qtype, a, b, c, d, answer, difficulty, score = df.loc[i]
        models.QuestionBank.objects.create(id, paper, title, qtype, a, b, c, d, answer, difficulty, score)


