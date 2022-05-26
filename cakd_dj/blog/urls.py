# from urllib.parse import urlparse
from django.urls import path
from . import views

urlpatterns = [
    path('<int:pk>', views.PostDetail.as_view()),
    path('', views.PostList.as_view()),
    path('category/<str:slug>/', views.category_page), # 5월 26일 추가
]