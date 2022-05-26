# Create your models here.

import os
from django.db import models

############################ 5월 26일 추가
from django.contrib.auth.models import User

class Category(models.Model):
    name = models.CharField(max_length=50, unique=True)
    slug = models.SlugField(max_length=200, unique=True, allow_unicode=True)

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return f'/blog/category/{self.slug}/'

    class Meta:
        verbose_name_plural = 'categories'


class Post(models.Model):
    title = models.CharField(max_length=30)
    hook_text = models.CharField(max_length=100, blank=True)
    content = models.TextField()

    head_image = models.ImageField(upload_to='blog/images/%Y/%m/%d/', blank=True) # blank = True는 필수가 아니라는 뜻
    file_upload = models.FileField(upload_to='blog/files/%Y/%m/%d/', blank=True)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
   
    # author: 추후 작성 예정
    def __str__(self):
        return f'[{self.pk}]{self.title}'
  
    def get_absolute_url(self):
        return f'/blog/{self.pk}/'
    
    def get_file_name(self):
        return os.path.basename(self.file_upload.name)

    def get_file_ext(self):
        return self.get_file_name().split('.')[-1]

    ############# 5월 26일 추가

    ## 외래키?
    # 말 그대로 외부에서 참조해서 사용하는 것을 말한다.
    # 이름테이블에 A,B라는 이름이 있었다면,
    # 이름테이블.USER   ====>   [A,B]
    # A가 개명하여 C가 됐다면, 이름테이블.USER   ====>   [C,B]
    # A를 제명시켰다면, 이름테이블.USER   ====>   [B]


    author = models.ForeignKey(User, null=True, on_delete=models.SET_NULL)
    category = models.ForeignKey(Category, null=True, blank=True, on_delete=models.SET_NULL) # blank = False 하면 카테고리 필수 지정