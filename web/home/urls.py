from django.urls import path
from django.contrib import admin
from . import views

urlpatterns = [
    path('', views.index, name="home"),
    path('about/', views.about, name="about"),
    path('contact/', views.contact, name="contact"),
    path('index/', views.index, name="index"),
    path('shop-cart/', views.shop_cart, name="shop_cart"),
    path('shop-details/<int:book_id>/', views.shop_details, name="shop_details"),
    path('add_to_inventory/<int:book_id>/', views.add_to_inventory, name="add_to_inventory"),
    path('shop/', views.shop, name="shop"),
    path('wishlist/', views.wishlist, name="wishlist"),
    path('create/', views.author_select, name="create"),
    path('author_select/', views.author_select, name="author_select"),
    path('register/', views.register, name="register"),
    path('login/', views.login_view, name="login"),
    path('logout/', views.logout_view, name="logout"),
    path('wishlist/delete/<int:book_id>/', views.delete_wish, name='deleteWish'),
    path('wishlist/add/<int:book_id>/', views.add_wish, name='addWish'),
    path('shop-cart/delete/<int:book_id>/', views.delete_request, name='delete_request'),
    path('shop-cart/add/<int:book_id>/', views.add_request, name='add_request'),
    path('search/', views.search_books, name='search'),
    path('review/add/<int:book_id>/', views.add_review, name='add_review'),
    path('loans/', views.loans, name='loans'),
    path('list_request/', views.list_request, name='list_request'),
    path('add-loan/<int:request_id>/', views.add_loan, name='add_loan'),
    path('list_loan/', views.list_loan, name='list_loan'),
    path('delete-loan/<int:loan_id>/', views.delete_loan, name='delete_loan'),
    path('inventory/', views.inventory, name='inventory'),
    path('search_inventory/', views.search_inventory, name='search_inventory'),
    path('insert_inventory/<int:book_id>/', views.insert_inventory, name='insert_inventory'),
    path('remove_inventory/<int:book_id>/', views.remove_inventory, name='remove_inventory'),
]

