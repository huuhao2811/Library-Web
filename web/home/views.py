from django.shortcuts import get_object_or_404,render, redirect
from django.http import HttpResponse, JsonResponse
from .models import *
import json
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.db import connection
from django.contrib.auth.hashers import make_password
from datetime import date
from datetime import datetime
cursor = connection.cursor()
# Create your views here.
def about(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    # Kiểm tra xem người dùng đã đăng nhập chưa
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    return render(request, 'about.html', {'request_count': request_count, 'wishlist_count': wishlist_count})
def contact(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    # Kiểm tra xem người dùng đã đăng nhập chưa
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    return render(request, 'contact.html', {'request_count': request_count, 'wishlist_count': wishlist_count})
def index(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    # Kiểm tra xem người dùng đã đăng nhập chưa
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    cursor.execute("SELECT GenreID, GenreName FROM BookGenre")
    genres = cursor.fetchall() 
    cursor.execute("SELECT * FROM Book")
    books = cursor.fetchall()
    cursor.execute("EXEC GetAllBooksRatingSummary")
    rating_summary = cursor.fetchall()
    cursor.close()

    
    return render(request, 'index.html', {'genres': genres, 'books': books, 'rating_summary': rating_summary, 'request_count': request_count, 'wishlist_count': wishlist_count})
def shop_details(request, book_id):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    # Kiểm tra xem người dùng đã đăng nhập chưa
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    cursor = connection.cursor()
    cursor.execute("EXEC GetAllBooksRatingSummary")
    rating_summary = cursor.fetchall()
    cursor.execute("SELECT * FROM Book WHERE BookID = %s", [book_id])
    row = cursor.fetchone()
    if row is None:
        # Nếu không tìm thấy sách, trả về 404
        from django.http import Http404
        raise Http404("Book not found")

    # Giả sử cột thứ 3 là title, cột thứ 7 là image path... (tùy vào cấu trúc bảng của bạn)
    book = {
        'id': row[0],
        'title': row[3],
        'image': row[7],
        'description': row[8],
        'isbn': row[4],
        'publicdate': row[6],
        # thêm các trường khác tùy ý
    }
    cursor.execute("""SELECT b.BookID, a.AuthorName, g.GenreName
                    FROM Book b
                    JOIN Book_Author ba ON b.BookID = ba.BookID
                    JOIN Author a ON ba.AuthorID = a.AuthorID
                    JOIN BookGenre g ON b.BookGenre = g.GenreID
                    WHERE b.BookID = %s""", [book_id])
    authors = cursor.fetchall()
    cursor.execute("SELECT * FROM Book")
    booklists = cursor.fetchall()
    cursor.execute("SELECT * FROM REVIEW WHERE BookID = %s", [book_id])
    reviews = cursor.fetchall()
    cursor.execute("SELECT count(*) FROM REVIEW WHERE BookID = %s", [book_id])
    review_count = cursor.fetchone()[0]
    cursor.execute("SELECT MemberID, MemberName FROM Member WHERE MemberID IN (SELECT MemberID FROM REVIEW WHERE BookID = %s)", [book_id])
    member_ids = cursor.fetchall()
    cursor.execute("EXEC GetTotalBookQuantities")
    total_quantities = cursor.fetchall()
    cursor.close()
    return render(request, 'shop-details.html', {'book': book, 'rating_summary': rating_summary, 'reviews': reviews, 'member_ids': member_ids, 'booklists': booklists
                      , 'total_quantities': total_quantities, 'request_count': request_count, 'wishlist_count': wishlist_count, 'authors': authors, 'review_count': review_count})
def shop(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    # Kiểm tra xem người dùng đã đăng nhập chưa
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    query = request.GET.get('q')
    
    # Sử dụng connection và cursor đúng cách
    with connection.cursor() as cursor:
        if query:
            # Sử dụng tham số để tránh SQL Injection
            cursor.execute("SELECT * FROM Book WHERE BookTitle LIKE %s", ['%' + query + '%'])
        else:
            cursor.execute("SELECT * FROM Book")
        
        books = cursor.fetchall()
        
        # Lấy thông tin thể loại
        cursor.execute("SELECT GenreID, GenreName FROM BookGenre")
        genres = cursor.fetchall()
        
        # Lấy thông tin Rating Summary
        cursor.execute("EXEC GetAllBooksRatingSummary")
        rating_summary = cursor.fetchall()
        cursor.execute("EXEC GetTotalBookQuantities")
        total_quantities = cursor.fetchall()
    # Trả về dữ liệu cho view
    return render(request, 'shop.html', {
        'genres': genres, 
        'books': books, 
        'rating_summary': rating_summary, 
        'query': query,
        'request_count': request_count,
        'wishlist_count': wishlist_count
        , 'total_quantities': total_quantities
    })
def author_select(request):
    #supp = Author.objects.all()                                                                    #select
    #for s in supp:
    #    print ('***', s.authorid, s.authorname, s.authorbio) 

    #s = Author(authorid = 6,authorname='John Doe', authorbio='John Doe is a writer and author.')   #create
    #s.save()

    #Author.objects.filter(authorid=6).delete()                                                     #delete

    #supp = Author.objects.get(authorid=1)                                                          #replace
    #supp.authorname = 'Nguyễn Nhật Ánh'
    #supp.save()
    try:
        cursor.execute("SELECT * FROM Author")
        result = cursor.fetchall()
        return render(request, 'author_select.html', {'result': result})
    finally:
        cursor.close()
def register(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')
        confirm_password = request.POST.get('cofpassword')
        phone = request.POST.get('phone')
        if password != confirm_password:
            messages.error(request, 'Password does not match')
            return redirect('register')
        if Member.objects.filter(memberusername=username).exists():
            messages.error(request, 'Username already exists')
            return redirect('register')
        if Member.objects.filter(memberemail=email).exists():
            messages.error(request, 'Email already exists')
            return redirect('register')
        if Member.objects.filter(membertelephone=phone).exists():
            messages.error(request, 'Phone already exists')
            return redirect('register')
        cursor = connection.cursor()
        cursor.execute("SELECT MAX(MemberID) FROM Member")
        row = cursor.fetchone()
        next_id = (row[0]) + 1 
        cursor.execute("INSERT INTO Member (MemberID, MemberName, MemberUsername, MemberPassword, MemberEmail, MemberTelephone) VALUES (%s, %s, %s, %s, %s, %s)",
                       (next_id, name, username, password, email, phone))
        cursor.close()
        messages.success(request, 'Registration successful')
        return redirect('index')
    return redirect('index')
def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        cursor = connection.cursor()
        cursor.execute("SELECT * FROM Member WHERE MemberUsername = %s AND MemberPassword = %s", [username, password])
        row = cursor.fetchone()
        cursor.execute("SELECT * FROM Librarian WHERE LibrarianUsername = %s AND LibrarianPassword = %s", [username, password])
        row2 = cursor.fetchone()
        if row:
            request.session['user_id'] = row[0]
            request.session['username'] = row[1]  
            request.session['name'] = row[2]  
            messages.success(request, 'Login successful!')
            return redirect('index')
        elif row2:
            request.session['user_id'] = row2[0]
            request.session['username'] = row2[1]  
            request.session['name'] = row2[2]  
            messages.success(request, 'Login successful!')
            return redirect('index') 
        messages.error(request, 'Invalid username or password')
        return redirect('index')
    return redirect('index')
def logout_view(request):
    request.session.flush()
    messages.success(request, 'Logout successful')
    return redirect('index')
def wishlist(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    if 'user_id' not in request.session:
        messages.error(request, "You Need to Login to view your wishlist.")
        return redirect('index')

    user_id = request.session.get('user_id')

    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT b.BookID, b.BookTitle, b.ImagePath,w.AddedDate
            FROM Wishlist w
            JOIN Book b ON w.BookID = b.BookID
            WHERE w.MemberID = %s
            ORDER BY w.AddedDate DESC
        """, [user_id])
        wishlist = cursor.fetchall()
        cursor.execute("EXEC GetTotalBookQuantities")
        total_quantities = cursor.fetchall()
    return render(request, 'wishlist.html', {'wishlist': wishlist, 'total_quantities': total_quantities, 'request_count': request_count, 'wishlist_count': wishlist_count})
def delete_wish(request, book_id):
    user_id = request.session.get('user_id')
    with connection.cursor() as cursor:
        cursor.execute("""
            DELETE FROM Wishlist 
            WHERE MemberID = %s AND BookID = %s
        """, [user_id, book_id])
    
    messages.error(request, "Book removed from wishlist.")
    return redirect('wishlist')
def add_wish(request, book_id):
    if 'user_id' not in request.session:
        messages.error(request, "You Need to Login to add books to wishlist.")
        return redirect('index')
    user_id = request.session['user_id']
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT COUNT(*) FROM Wishlist 
            WHERE MemberID = %s AND BookID = %s
        """, [user_id, book_id])
        count = cursor.fetchone()[0]
        if count > 0:
            messages.error(request, "Book already in wishlist.")
            return redirect('wishlist')
    with connection.cursor() as cursor:
        cursor.execute("""
            INSERT INTO Wishlist (MemberID, BookID, AddedDate) 
            VALUES (%s, %s, GETDATE())
        """, [user_id, book_id])
    
    messages.error(request, "Add to wishlist.")
    return redirect('shop_details', book_id=book_id)
def search_books(request):
    query = request.GET.get('q')
    results = []

    if query:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT BookID, BookName, AuthorName, ImagePath
                FROM Book
                WHERE BookName LIKE %s OR AuthorName LIKE %s
            """, [f'%{query}%', f'%{query}%'])
            results = cursor.fetchall()

    return render(request, 'search_results.html', {'results': results, 'query': query})
def add_review(request, book_id):
    if request.method == 'POST':
        if 'user_id' not in request.session:
            return redirect('index')
        
        user_id = request.session.get('user_id')
        rating = int(request.POST.get('rating', 0))
        message = request.POST.get('message')
        today = date.today()
        with connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO Review (MemberId, BookID, Comment, Rating, Date)
                VALUES (%s, %s, %s, %s, %s)
            """, [user_id, book_id, message, rating, today])
            return redirect('shop_details', book_id=book_id)
    return redirect('index')
def add_request(request, book_id):
    if 'user_id' not in request.session:
        return redirect('index')
    user_id = request.session['user_id']
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT COUNT(*) FROM Request 
            WHERE MemberID = %s AND BookID = %s
        """, [user_id, book_id])
        count = cursor.fetchone()[0]
        if count > 0:
            return redirect('shop_cart')
    with connection.cursor() as cursor:
        cursor.execute("""
            INSERT INTO Request (BookID, MemberID, RequestDate, RequestFinish)
            VALUES (%s, %s, GETDATE(), 0)
        """, [ book_id, user_id])
    
    return redirect('shop_cart')
def shop_cart(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    if 'user_id' not in request.session:
        messages.error(request, "You Need to Login to view your wishlist.")
        return redirect('index')

    user_id = request.session.get('user_id')

    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT b.BookID, b.BookTitle, b.ImagePath,r.RequestDate, r.RequestFinish, r.RequestID
            FROM Request r
            JOIN Book b ON r.BookID = b.BookID
            WHERE r.MemberID = %s
            ORDER BY r.RequestDate DESC
        """, [user_id])
        list = cursor.fetchall()
        cursor.execute("EXEC GetTotalBookQuantities")
        total_quantities = cursor.fetchall()
    
    return render(request, 'shop-cart.html', {'list': list, 'total_quantities': total_quantities, 'request_count': request_count, 'wishlist_count': wishlist_count})
def delete_request(request, book_id):
    user_id = request.session.get('user_id')
    with connection.cursor() as cursor:
        cursor.execute("""
            DELETE FROM Request 
            WHERE MemberID = %s AND BookID = %s
        """, [user_id, book_id])
    
    return redirect('shop_cart')
def loans(request):
    user_id = request.session.get('user_id')
    today = date.today()
    cursor = connection.cursor()
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    if 'user_id' not in request.session:
        messages.error(request, "You Need to Login to view your wishlist.")
        return redirect('index')
    
    cursor.execute("""
        SELECT b.BookID, b.BookTitle, b.ImagePath,l.DueDate, l.IssueDate
        FROM Loan l
        JOIN Book b ON l.BookID = b.BookID
        WHERE l.MemberID = %s And l.ReturnDate IS NULL
        ORDER BY l.DueDate DESC
    """, [user_id])
    loans = cursor.fetchall()
    cursor.execute("EXEC GetTotalBookQuantities")
    total_quantities = cursor.fetchall()
    cursor.close()
    return render(request, 'loans.html', {'total_quantities': total_quantities, 'request_count': request_count, 
                                          'wishlist_count': wishlist_count, 'loans': loans, 'today': today})
def list_request(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    if 'user_id' not in request.session:
        messages.error(request, "You Need to Login to view your wishlist.")
        return redirect('index')

    user_id = request.session.get('user_id')

    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT b.BookID, b.BookTitle, b.ImagePath,r.RequestDate, r.RequestFinish, r.RequestID, m.MemberName, r.RequestID
            FROM Request r
            JOIN Book b ON r.BookID = b.BookID
            JOIN Member m ON r.MemberID = m.MemberID
            WHERE r.RequestFinish = 0
            ORDER BY r.RequestDate ASC
        """)
        requests = cursor.fetchall()
        cursor.execute("EXEC GetTotalBookQuantities")
        total_quantities = cursor.fetchall()
    return render(request, 'list_request.html', {'requests': requests, 'total_quantities': total_quantities, 'request_count': request_count, 'wishlist_count': wishlist_count})
def add_loan(request, request_id):
    if request.method == 'POST':
        today = date.today()
        due_date = today.replace(day=today.day + 7)
        cursor = connection.cursor()
        cursor.execute("""
            SELECT BookID FROM Request WHERE RequestID = %s
        """, [request_id])
        book_id = cursor.fetchone()[0]
        cursor.execute("""
            SELECT MemberID FROM Request WHERE RequestID = %s
        """, [request_id])
        member_id = cursor.fetchone()[0]
        cursor.execute("""
            INSERT INTO Loan (IssueDate, DueDate, BookID, MemberID)
            VALUES (%s, %s, %s, %s)
        """, [today, due_date, book_id, member_id])
        cursor.execute("""
            UPDATE Request 
            SET RequestFinish = 1
            WHERE RequestID = %s
        """, [request_id])
        cursor.execute("""
            UPDATE Inventory
            SET Number = Number - 1
            WHERE BookID = %s
            AND BranchID = (
                SELECT TOP 1 BranchID
                FROM Inventory
                WHERE BookID = %s AND Number > 0
                ORDER BY Number DESC
            )
        """, [book_id, book_id])
    return redirect('list_request')
def list_loan(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]

    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT b.BookID, b.BookTitle, b.ImagePath,l.DueDate, l.IssueDate, l.LoanID, m.MemberName
            FROM Loan l
            JOIN Book b ON l.BookID = b.BookID
            JOIN Member m ON l.MemberID = m.MemberID
            WHERE l.ReturnDate IS NULL
            ORDER BY l.DueDate ASC
        """)
        loans = cursor.fetchall()
        cursor.execute("EXEC GetTotalBookQuantities")
        total_quantities = cursor.fetchall()
    return render(request, 'list_loan.html', {'loans': loans, 'total_quantities': total_quantities
                                              , 'request_count': request_count, 'wishlist_count': wishlist_count})
def delete_loan(request, loan_id):
    if request.method == 'POST':
        cursor = connection.cursor()
        cursor.execute("""
            SELECT BookID FROM Loan WHERE LoanID = %s
        """, [loan_id])
        book_id = cursor.fetchone()[0]
        cursor.execute("""
            UPDATE Loan 
            SET ReturnDate = GETDATE()
            WHERE LoanID = %s
        """, [loan_id])
        cursor.execute("""
            UPDATE Inventory
            SET Number = Number + 1
            WHERE BookID = %s
            AND BranchID = (
                SELECT TOP 1 BranchID
                FROM Inventory
                WHERE BookID = %s AND Number > 0
                ORDER BY Number ASC
            )
        """, [book_id, book_id])
    return redirect('list_loan')
def inventory(request):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    # Kiểm tra xem người dùng đã đăng nhập chưa
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    query = request.GET.get('q')
    
    # Sử dụng connection và cursor đúng cách
    with connection.cursor() as cursor:
        if query:
            # Sử dụng tham số để tránh SQL Injection
            cursor.execute("SELECT * FROM Book WHERE BookTitle LIKE %s", ['%' + query + '%'])
        else:
            cursor.execute("SELECT * FROM Book")
        
        books = cursor.fetchall()
        
        # Lấy thông tin thể loại
        cursor.execute("SELECT GenreID, GenreName FROM BookGenre")
        genres = cursor.fetchall()
        
        # Lấy thông tin Rating Summary
        cursor.execute("EXEC GetAllBooksRatingSummary")
        rating_summary = cursor.fetchall()
        cursor.execute("EXEC GetTotalBookQuantities")
        total_quantities = cursor.fetchall()
        cursor.close()
    # Trả về dữ liệu cho view
    return render(request, 'inventory.html', {'genres': genres, 'books': books, 'rating_summary': rating_summary, 'query': query,
                            'request_count': request_count,'wishlist_count': wishlist_count, 'total_quantities': total_quantities})
def search_inventory(request):
    query = request.GET.get('q')
    results = []

    if query:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT BookID, BookName, AuthorName, ImagePath
                FROM Book
                WHERE BookName LIKE %s OR AuthorName LIKE %s
            """, [f'%{query}%', f'%{query}%'])
            results = cursor.fetchall()
    return render(request, 'search_results.html', {'results': results, 'query': query})
def add_to_inventory(request, book_id):
    user_id = request.session.get('user_id')
    cursor = connection.cursor()
    # Kiểm tra xem người dùng đã đăng nhập chưa
    if user_id is None:
        request_count = 0
        wishlist_count = 0
    else:
        cursor.execute("SELECT count(*) FROM Request WHERE MemberID = %s", [user_id])
        request_count = cursor.fetchone()[0]
        cursor.execute("SELECT count(*) FROM Wishlist WHERE MemberID = %s", [user_id])
        wishlist_count = cursor.fetchone()[0]
    cursor = connection.cursor()
    cursor.execute("EXEC GetAllBooksRatingSummary")
    rating_summary = cursor.fetchall()
    cursor.execute("SELECT * FROM Book WHERE BookID = %s", [book_id])
    row = cursor.fetchone()
    if row is None:
        # Nếu không tìm thấy sách, trả về 404
        from django.http import Http404
        raise Http404("Book not found")

    # Giả sử cột thứ 3 là title, cột thứ 7 là image path... (tùy vào cấu trúc bảng của bạn)
    book = {
        'id': row[0],
        'title': row[3],
        'image': row[7],
        'description': row[8],
        'isbn': row[4],
        'publicdate': row[6],
        # thêm các trường khác tùy ý
    }
    cursor.execute("""SELECT b.BookID, a.AuthorName
                    FROM Book b
                    JOIN Book_Author ba ON b.BookID = ba.BookID
                    JOIN Author a ON ba.AuthorID = a.AuthorID
                    WHERE b.BookID = %s""", [book_id])
    authors = cursor.fetchall()
    cursor.execute("SELECT * FROM Book")
    booklists = cursor.fetchall()
    cursor.execute("SELECT * FROM REVIEW WHERE BookID = %s", [book_id])
    reviews = cursor.fetchall()
    cursor.execute("SELECT MemberID, MemberName FROM Member WHERE MemberID IN (SELECT MemberID FROM REVIEW WHERE BookID = %s)", [book_id])
    member_ids = cursor.fetchall()
    cursor.execute("EXEC GetTotalBookQuantities")
    total_quantities = cursor.fetchall()
    cursor.close()
    return render(request, 'add_to_inventory.html', {'book': book, 'rating_summary': rating_summary, 'reviews': reviews, 'member_ids': member_ids, 'booklists': booklists
                      , 'total_quantities': total_quantities, 'request_count': request_count, 'wishlist_count': wishlist_count, 'authors': authors})
def insert_inventory(request, book_id):
    if request.method == 'POST':
        number = int(request.POST.get('qty', 1))
        cursor = connection.cursor()
        cursor.execute("""
            UPDATE Inventory
            SET Number = Number + %s
            WHERE BookID = %s
            AND BranchID = (
                SELECT TOP 1 BranchID
                FROM Inventory
                WHERE BookID = %s AND Number >= 0
                ORDER BY Number ASC
            )
        """, [number, book_id, book_id])
        cursor.close()
    return redirect('add_to_inventory', book_id=book_id)
def remove_inventory(request, book_id):
    if request.method == 'POST':
        cursor = connection.cursor()
        cursor.execute("""
            UPDATE Inventory
            SET Number = Number - 1
            WHERE BookID = %s
            AND BranchID = (
                SELECT TOP 1 BranchID
                FROM Inventory
                WHERE BookID = %s AND Number > 0
                ORDER BY Number DESC
            )
        """, [book_id, book_id])
        cursor.close()
    return redirect('add_to_inventory', book_id=book_id)