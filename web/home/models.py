# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Author(models.Model):
    authorid = models.IntegerField(db_column='AuthorID', primary_key=True)  # Field name made lowercase.
    authorname = models.CharField(db_column='AuthorName', max_length=100, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    authorbio = models.CharField(db_column='AuthorBio', max_length=255, db_collation='SQL_Latin1_General_CP1_CI_AS', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Author'


class Book(models.Model):
    bookid = models.IntegerField(db_column='BookID', primary_key=True)  # Field name made lowercase.
    publisherid = models.ForeignKey('Publisher', models.DO_NOTHING, db_column='PublisherID')  # Field name made lowercase.
    bookname = models.CharField(db_column='BookName', max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    booktitle = models.CharField(db_column='BookTitle', max_length=200, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    isbn = models.CharField(db_column='ISBN', unique=True, max_length=13, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    bookgenre = models.ForeignKey('Bookgenre', models.DO_NOTHING, db_column='BookGenre')  # Field name made lowercase.
    bookpublicationdate = models.DateField(db_column='BookPublicationDate')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Book'


class Bookgenre(models.Model):
    genreid = models.IntegerField(db_column='GenreID', primary_key=True)  # Field name made lowercase.
    genrename = models.CharField(db_column='GenreName', max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'BookGenre'


class BookAuthor(models.Model):
    bookid = models.ForeignKey(Book, models.DO_NOTHING, db_column='BookID')  # Field name made lowercase.
    authorid = models.OneToOneField(Author, models.DO_NOTHING, db_column='AuthorID', primary_key=True)  # Field name made lowercase. The composite primary key (AuthorID, BookID) found, that is not supported. The first column is selected.

    class Meta:
        managed = False
        db_table = 'Book_Author'
        unique_together = (('authorid', 'bookid'),)


class Branch(models.Model):
    branchaddress = models.CharField(db_column='BranchAddress', max_length=100, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    branchid = models.AutoField(db_column='BranchID', primary_key=True)  # Field name made lowercase.
    librarianid = models.OneToOneField('Librarian', models.DO_NOTHING, db_column='LibrarianID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Branch'


class Event(models.Model):
    eventid = models.IntegerField(db_column='EventID', primary_key=True)  # Field name made lowercase.
    branchid = models.ForeignKey(Branch, models.DO_NOTHING, db_column='BranchID')  # Field name made lowercase.
    eventname = models.CharField(db_column='EventName', max_length=100, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=255, db_collation='SQL_Latin1_General_CP1_CI_AS', blank=True, null=True)  # Field name made lowercase.
    eventdate = models.DateField(db_column='EventDate')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Event'


class Inventory(models.Model):
    branchid = models.OneToOneField(Branch, models.DO_NOTHING, db_column='BranchID', primary_key=True)  # Field name made lowercase. The composite primary key (BranchID, BookID) found, that is not supported. The first column is selected.
    bookid = models.ForeignKey(Book, models.DO_NOTHING, db_column='BookID')  # Field name made lowercase.
    number = models.IntegerField(db_column='Number', blank=True, null=True)  # Field name made lowercase.
    lastupdated = models.DateField(db_column='LastUpdated', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Inventory'
        unique_together = (('branchid', 'bookid'), ('branchid', 'bookid'),)


class Librarian(models.Model):
    librarianid = models.IntegerField(db_column='LibrarianID', primary_key=True)  # Field name made lowercase.
    librarianname = models.CharField(db_column='LibrarianName', max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    librarianusername = models.CharField(db_column='LibrarianUsername', unique=True, max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    librarianpassword = models.CharField(db_column='LibrarianPassword', max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    librarianemail = models.CharField(db_column='LibrarianEmail', max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    librariantelephone = models.CharField(db_column='LibrarianTelephone', max_length=20, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Librarian'


class Loan(models.Model):
    loanid = models.IntegerField(db_column='LoanID', primary_key=True)  # Field name made lowercase.
    issuedate = models.DateField(db_column='IssueDate')  # Field name made lowercase.
    duedate = models.DateField(db_column='DueDate')  # Field name made lowercase.
    returndate = models.DateField(db_column='ReturnDate', blank=True, null=True)  # Field name made lowercase.
    bookid = models.ForeignKey(Book, models.DO_NOTHING, db_column='BookID')  # Field name made lowercase.
    branchid = models.ForeignKey(Branch, models.DO_NOTHING, db_column='BranchID')  # Field name made lowercase.
    memberid = models.ForeignKey('Member', models.DO_NOTHING, db_column='MemberID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Loan'


class Member(models.Model):
    memberid = models.IntegerField(db_column='MemberID', primary_key=True)  # Field name made lowercase.
    membername = models.CharField(db_column='MemberName', max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    memberusername = models.CharField(db_column='MemberUsername', unique=True, max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    memberpassword = models.CharField(db_column='MemberPassword', max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    memberemail = models.CharField(db_column='MemberEmail', unique=True, max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    membertelephone = models.CharField(db_column='MemberTelephone', max_length=20, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Member'


class Publisher(models.Model):
    publisherid = models.IntegerField(db_column='PublisherID', primary_key=True)  # Field name made lowercase.
    publishername = models.CharField(db_column='PublisherName', max_length=100, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    publisheraddress = models.CharField(db_column='PublisherAddress', max_length=100, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    contact_info = models.CharField(db_column='Contact_Info', max_length=255, db_collation='SQL_Latin1_General_CP1_CI_AS', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Publisher'


class Request(models.Model):
    requestid = models.AutoField(db_column='RequestID', primary_key=True)  # Field name made lowercase.
    bookid = models.ForeignKey(Book, models.DO_NOTHING, db_column='BookID')  # Field name made lowercase.
    branchid = models.ForeignKey(Branch, models.DO_NOTHING, db_column='BranchID')  # Field name made lowercase.
    memberid = models.ForeignKey(Member, models.DO_NOTHING, db_column='MemberID')  # Field name made lowercase.
    requestdate = models.DateField(db_column='RequestDate')  # Field name made lowercase.
    requestfinish = models.BooleanField(db_column='RequestFinish', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Request'


class Reservation(models.Model):
    reservationid = models.AutoField(db_column='ReservationID', primary_key=True)  # Field name made lowercase.
    memberid = models.ForeignKey(Member, models.DO_NOTHING, db_column='MemberId')  # Field name made lowercase.
    bookid = models.ForeignKey(Book, models.DO_NOTHING, db_column='BookID')  # Field name made lowercase.
    branchid = models.ForeignKey(Branch, models.DO_NOTHING, db_column='BranchID')  # Field name made lowercase.
    requestdate = models.DateField(db_column='RequestDate')  # Field name made lowercase.
    status = models.CharField(db_column='Status', max_length=20, db_collation='SQL_Latin1_General_CP1_CI_AS', blank=True, null=True)  # Field name made lowercase.
    processedby = models.ForeignKey(Librarian, models.DO_NOTHING, db_column='ProcessedBy', blank=True, null=True)  # Field name made lowercase.
    processdate = models.DateField(db_column='ProcessDate', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Reservation'


class Review(models.Model):
    reviewid = models.AutoField(db_column='ReviewID', primary_key=True)  # Field name made lowercase.
    memberid = models.ForeignKey(Member, models.DO_NOTHING, db_column='MemberId')  # Field name made lowercase.
    bookid = models.ForeignKey(Book, models.DO_NOTHING, db_column='BookID')  # Field name made lowercase.
    comment = models.CharField(db_column='Comment', max_length=2000, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    rating = models.IntegerField(db_column='Rating', blank=True, null=True)  # Field name made lowercase.
    date = models.DateField(db_column='Date')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Review'


class Supplier(models.Model):
    supplierid = models.IntegerField(db_column='SupplierID', primary_key=True)  # Field name made lowercase.
    suppliername = models.CharField(db_column='SupplierName', max_length=50, db_collation='SQL_Latin1_General_CP1_CI_AS')  # Field name made lowercase.
    contact_info = models.CharField(db_column='Contact_Info', max_length=255, db_collation='SQL_Latin1_General_CP1_CI_AS', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Supplier'


class Supply(models.Model):
    supplyid = models.AutoField(db_column='SupplyID', primary_key=True)  # Field name made lowercase.
    supplierid = models.ForeignKey(Supplier, models.DO_NOTHING, db_column='SupplierID')  # Field name made lowercase.
    branchid = models.ForeignKey(Branch, models.DO_NOTHING, db_column='BranchID')  # Field name made lowercase.
    bookid = models.ForeignKey(Book, models.DO_NOTHING, db_column='BookID')  # Field name made lowercase.
    number = models.IntegerField(db_column='Number', blank=True, null=True)  # Field name made lowercase.
    supplydate = models.DateField(db_column='SupplyDate', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Supply'


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150, db_collation='SQL_Latin1_General_CP1_CI_AS')

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255, db_collation='SQL_Latin1_General_CP1_CI_AS')
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100, db_collation='SQL_Latin1_General_CP1_CI_AS')

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128, db_collation='SQL_Latin1_General_CP1_CI_AS')
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150, db_collation='SQL_Latin1_General_CP1_CI_AS')
    first_name = models.CharField(max_length=150, db_collation='SQL_Latin1_General_CP1_CI_AS')
    last_name = models.CharField(max_length=150, db_collation='SQL_Latin1_General_CP1_CI_AS')
    email = models.CharField(max_length=254, db_collation='SQL_Latin1_General_CP1_CI_AS')
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(db_collation='SQL_Latin1_General_CP1_CI_AS', blank=True, null=True)
    object_repr = models.CharField(max_length=200, db_collation='SQL_Latin1_General_CP1_CI_AS')
    action_flag = models.SmallIntegerField()
    change_message = models.TextField(db_collation='SQL_Latin1_General_CP1_CI_AS')
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100, db_collation='SQL_Latin1_General_CP1_CI_AS')
    model = models.CharField(max_length=100, db_collation='SQL_Latin1_General_CP1_CI_AS')

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255, db_collation='SQL_Latin1_General_CP1_CI_AS')
    name = models.CharField(max_length=255, db_collation='SQL_Latin1_General_CP1_CI_AS')
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40, db_collation='SQL_Latin1_General_CP1_CI_AS')
    session_data = models.TextField(db_collation='SQL_Latin1_General_CP1_CI_AS')
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Sysdiagrams(models.Model):
    name = models.CharField(max_length=128, db_collation='SQL_Latin1_General_CP1_CI_AS')
    principal_id = models.IntegerField()
    diagram_id = models.AutoField(primary_key=True)
    version = models.IntegerField(blank=True, null=True)
    definition = models.BinaryField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'sysdiagrams'
        unique_together = (('principal_id', 'name'),)
