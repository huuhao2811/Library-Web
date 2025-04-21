--CREATE DATABASE 
Use Assignment_DatabaseSystem
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Librarian](
	[LibrarianID] [int]  NOT NULL,
	[LibrarianName] [nvarchar](50) NOT NULL,
	[LibrarianUsername] [nvarchar](50) UNIQUE NOT NULL,
	[LibrarianPassword] [nvarchar](50) NOT NULL,
	[LibrarianEmail] [nvarchar](50) NOT NULL,
	[LibrarianTelephone] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Librarian] PRIMARY KEY CLUSTERED 
(
	[LibrarianID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Member](
	[MemberID] [int] NOT NULL,
	[MemberName] [nvarchar](50) NOT NULL,
	[MemberUsername] [nvarchar](50) UNIQUE NOT NULL,
	[MemberPassword] [nvarchar](50) NOT NULL,
	[MemberEmail] [nvarchar](50) UNIQUE NOT NULL,
	[MemberTelephone] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Request](
	[RequestID] [int] NOT NULL IDENTITY(1,1),
	[BookID] [int] NOT NULL,
	[MemberID] [int]  NOT NULL,
	[RequestDate] [DATE] NOT NULL,
	[RequestFinish] [bit] NULL,
 CONSTRAINT [PK_Request] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Book](
	[BookID] [int] NOT NULL,
	[PublisherID] [int] NOT NULL,
	[BookName] [nvarchar](50) NOT NULL,
	[BookTitle] [nvarchar](200)  NOT NULL,
	[ISBN] [nvarchar](13) NOT NULL,
	[BookGenre] [int] NOT NULL,
	[BookPublicationDate] [DATE] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Loan](
	[LoanID] [int] IDENTITY NOT NULL,
	[IssueDate] [DATE] NOT NULL,
	[DueDate] [DATE] NOT NULL,
	[ReturnDate] [DATE] NULL,
	[BookID] [int] NOT NULL,
	[MemberID] [int] NOT NULL,
 CONSTRAINT [PK_Loan] PRIMARY KEY CLUSTERED 
(
	[LoanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
DROP TABLE Loan;
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON	
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Review](
	[ReviewID] INT IDENTITY(1,1),
	[MemberId] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[Comment] [nvarchar](2000) NOT NULL,
	[Rating] INT CHECK (Rating >= 1 AND Rating <= 5),
	[Date] [DATE] NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Reservation](
	[ReservationID] [int] IDENTITY(1,1)  NOT NULL,
	[MemberId] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[BranchID] [int] NOT NULL,
	[RequestDate] [DATE] NOT NULL,
	[Status] VARCHAR(20) CHECK (status IN ('Pending', 'Approved', 'Cancelled', 'Fulfilled')),
	[ProcessedBy] [int] NULL,
	[ProcessDate] [date] NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Branch](
	[BranchAddress] [nvarchar](100) NOT NULL,
	[BranchID] INT IDENTITY(1,1),
	[LibrarianID] [int] UNIQUE NOT NULL,
 CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
(
	[BranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Inventory](
	[BranchID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[Number] [int] DEFAULT 0,
	[LastUpdated] [date],
	CONSTRAINT UQ_Inventory UNIQUE (BranchID, BookID),
 CONSTRAINT [PK_Invertory] PRIMARY KEY CLUSTERED 
(
	[BranchID] ASC,
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [int] NOT NULL,
	[SupplierName] [nvarchar](50) NOT NULL,
	[Contact_Info] NVARCHAR(255)
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Supply](
	[SupplyID] INT IDENTITY(1,1),
	[SupplierID] INT NOT NULL,
	[BranchID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[Number] [int] DEFAULT 0,
	[SupplyDate] [date],
 CONSTRAINT [PK_Supply] PRIMARY KEY CLUSTERED 
(
	[SupplyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON		
GO
CREATE TABLE [dbo].[Event](
	[EventID] [int] NOT NULL,
	[BranchID] [int] NOT NULL,
	[EventName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255),
	[EventDate] [date] NOT NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
CREATE TABLE Author (
    [AuthorID] [int] NOT NULL,
    [AuthorName] [nvarchar](100) NOT NULL,
    [AuthorBio] [nvarchar](255),
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
CREATE TABLE Book_Author (
    [BookID] [int] NOT NULL,
    [AuthorID] [int] NOT NULL,
CONSTRAINT [PK_Book_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC,
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
CREATE TABLE Publisher (
    [PublisherID] [int] NOT NULL,
	[PublisherName] [nvarchar](100) NOT NULL,
    [PublisherAddress] [nvarchar](100) NOT NULL,
	[Contact_Info] [nvarchar](255),
CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED 
(
	[PublisherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------
CREATE TABLE BookGenre (
    [GenreID] [int]  NOT NULL,
    [GenreName] [nvarchar](50) NOT NULL
CONSTRAINT [PK_BookGenre] PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------

ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_Member] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_Branch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[Branch] ([BranchID])
GO
ALTER TABLE [dbo].[Loan]  WITH CHECK ADD  CONSTRAINT [FK_Loan_Member] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Loan]  WITH CHECK ADD  CONSTRAINT [FK_Loan_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[Loan]  WITH CHECK ADD  CONSTRAINT [FK_Loan_Branch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[Branch] ([BranchID])
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Member] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Member] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Librarians] FOREIGN KEY([ProcessedBy])
REFERENCES [dbo].[Librarian] ([LibrarianID])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Branch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[Branch] ([BranchID])
GO
ALTER TABLE [dbo].[Branch]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Librarian] FOREIGN KEY([LibrarianID])
REFERENCES [dbo].[Librarian] ([LibrarianID])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Branch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[Branch] ([BranchID])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[Supply]  WITH CHECK ADD  CONSTRAINT [FK_Supply_Supplier] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Supplier] ([SupplierID])
GO
ALTER TABLE [dbo].[Supply]  WITH CHECK ADD  CONSTRAINT [FK_Supply_Branch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[Branch] ([BranchID])
GO
ALTER TABLE [dbo].[Supply]  WITH CHECK ADD  CONSTRAINT [FK_Supply_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Branch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[Branch] ([BranchID])
GO
ALTER TABLE [dbo].[Book_Author]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[Book_Author]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author_Author] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Author] ([AuthorID])
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Publisher] FOREIGN KEY([PublisherID])
REFERENCES [dbo].[Publisher] ([PublisherID])
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_BookGenre] FOREIGN KEY([BookGenre])
REFERENCES [dbo].[BookGenre] ([GenreID])
GO



-----------------------------------------------------------------------------------------
INSERT INTO Member (MemberID, MemberName, MemberUsername, MemberPassword, MemberEmail, MemberTelephone)
VALUES
(1001, 'Nguyen Van A', 'nguyenvana', 'pass123', 'vana@example.com', '0901234567'),
(1002, 'Tran Thi B', 'tranthib', 'pass456', 'thib@example.com', '0912345678'),
(1003, 'Le Van C', 'levanc', 'pass789', 'vanc@example.com', '0923456789'),
(1004, 'Pham Thi D', 'phamthid', 'pass321', 'thid@example.com', '0934567890'),
(1005, 'Hoang Van E', 'hoangvane', 'pass654', 'vane@example.com', '0945678901'),
(1006, 'Do Thi F', 'dothif', 'pass987', 'thif@example.com', '0956789012'),
(1007, 'Nguyen Van G', 'nguyenvang', 'passabc', 'vang@example.com', '0967890123'),
(1008, 'Tran Van H', 'tranvanh', 'passdef', 'vanh@example.com', '0978901234'),
(1009, 'Le Thi I', 'lethii', 'passghi', 'thii@example.com', '0989012345'),
(1010, 'Pham Van K', 'phamvank', 'passjkl', 'vank@example.com', '0990123456');
-----------------------------------------------------------------------------------------
INSERT INTO BookGenre (GenreID, GenreName)
VALUES 
(1, 'Literature'),
(2, 'Science'),
(3, 'Children'),
(4, 'History'),
(5, 'Economics'),
(6, 'Self-study');
-----------------------------------------------------------------------------------------
INSERT INTO Publisher (PublisherID, PublisherName, PublisherAddress, Contact_Info)
VALUES
(1, 'Oxford University Press', 'Great Clarendon Street, Oxford, UK', 'contact@oup.com'),
(2, 'Penguin Random House', '1745 Broadway, New York, USA', 'info@penguinrandomhouse.com'),
(3, 'HarperCollins Publishers', '195 Broadway, New York, USA', 'support@harpercollins.com');
-----------------------------------------------------------------------------------------
INSERT INTO Book (BookID, PublisherID, BookName, BookTitle, ISBN, BookGenre, BookPublicationDate)
VALUES
(1001, 1, 'Literature Book 1', 'The Adventures of Tom Sawyer', 978123456001, 1, '2020-01-10'),
(1002, 2, 'Science Book 1', 'A Brief History of Time', 978123456002, 2, '2021-03-22'),
(1003, 1, 'Literature Book 2', 'To Kill a Mockingbird', 978123456003, 1, '2019-07-18'),
(1004, 3, 'Children Book 1', 'The Little Prince', 978123456004, 3, '2018-06-01'),
(1005, 2, 'History Book 1', 'Sapiens: A Brief History of Humankind', 978123456005, 4, '2017-09-15'),
(1006, 1, 'Literature Book 3', 'Pride and Prejudice', 978123456006, 1, '2022-02-14'),
(1007, 3, 'Science Book 2', 'The Selfish Gene', 978123456007, 2, '2020-12-01'),
(1008, 2, 'Children Book 2', 'Harry Potter and the Sorcerer''s Stone', 978123456008, 3, '1997-06-26'),
(1009, 1, 'Economics Book 1', 'Rich Dad Poor Dad', 978123456009, 5, '2000-04-05'),
(1010, 3, 'Self-study Book 1', 'Learn Python Programming', 978123456010, 6, '2021-08-09'),
(1011, 2, 'Literature Book 4', '1984', 978123456011, 1, '1949-06-08'),
(1012, 1, 'Science Book 3', 'Cosmos', 978123456012, 2, '1980-09-01'),
(1013, 2, 'History Book 2', 'The Silk Roads', 978123456013, 4, '2015-08-27'),
(1014, 3, 'Self-study Book 2', 'Mastering SQL', 978123456014, 6, '2023-01-15'),
(1015, 1, 'Children Book 3', 'Charlie and the Chocolate Factory', 978123456015, 3, '1964-01-17');
-----------------------------------------------------------------------------------------
INSERT INTO Librarian (LibrarianID, LibrarianName, LibrarianUsername, LibrarianPassword, LibrarianEmail, LibrarianTelephone)
VALUES 
(201, 'Nguyen Thi Lan', 'lannt', 'passlan123', 'lannt@library.com', '0901234567'),
(202, 'Tran Van Minh', 'minhtv', 'passminh456', 'minhtv@library.com', '0912345678'),
(203, 'Le Thi Hoa', 'hoalt', 'passhoa789', 'hoalt@library.com', '0923456789'),
(204, 'Pham Van Tuan', 'tuanpv', 'passtuan321', 'tuanpv@library.com', '0934567890');
-----------------------------------------------------------------------------------------
INSERT INTO Reservation (ReservationID, MemberId, BookID, RequestDate, Status, ProcessedBy, ProcessDate)
	VALUES
	(301, 1001, 1003, '2025-03-01', 'Pending', 201, GETDATE());
-----------------------------------------------------------------------------------------
INSERT INTO Review (MemberId, BookID, Comment, Rating, Date)
VALUES 
(1001, 1003, N'A very inspiring story with meaningful lessons.', 5, '2025-03-01'),
(1002, 1005, N'Great insights into human history, but a bit dense.', 4, '2025-03-02'),
(1003, 1007, N'Scientific concepts are well explained and engaging.', 5, '2025-03-03'),
(1004, 1010, N'A perfect book for self-learners. Highly recommended!', 5, '2025-03-04'),
(1005, 1012, N'Beautiful visuals and excellent scientific storytelling.', 4, '2025-03-05'),
(1006, 1014, N'Very helpful SQL guide. Easy to follow.', 5, '2025-03-06'),
(1007, 1015, N'A classic children''s book, still enjoyable for adults.', 5, '2025-03-07'),
(1008, 1001, N'An entertaining piece of literature with adventure.', 4, '2025-03-08'),
(1009, 1004, N'Heartwarming and philosophical at the same time.', 5, '2025-03-09'),
(1010, 1009, N'Simple yet powerful financial lessons.', 5, '2025-03-10')
;
INSERT INTO Review (MemberId, BookID, Comment, Rating, Date)
VALUES  
(1001, 1002, N'This book really changed my view on science.', 5, '2025-03-11'),
(1002, 1003, N'A bit slow at first, but the message is powerful.', 4, '2025-03-12'),
(1003, 1005, N'Impressive storytelling about human evolution.', 5, '2025-03-13'),
(1004, 1007, N'Well-structured and deeply insightful.', 4, '2025-03-14'),
(1005, 1009, N'A must-read for those interested in personal finance.', 5, '2025-03-15'),
(1006, 1010, N'Simple and practical learning guide.', 4, '2025-03-16'),
(1007, 1012, N'An amazing journey through space and time.', 5, '2025-03-17'),
(1008, 1014, N'Thoroughly written and very useful.', 4, '2025-03-18'),
(1009, 1015, N'Timeless tale for both kids and grown-ups.', 5, '2025-03-19'),
(1010, 1001, N'The adventure is captivating and beautifully written.', 5, '2025-03-20'),
(1001, 1004, N'Such a touching and deep story.', 5, '2025-03-21'),
(1002, 1006, N'Classic romance, still relevant today.', 4, '2025-03-22'),
(1003, 1008, N'Magical, immersive and creative.', 5, '2025-03-23'),
(1004, 1011, N'Profound and thought-provoking.', 5, '2025-03-24'),
(1005, 1013, N'A different perspective on history.', 4, '2025-03-25'),
(1006, 1003, N'Characters are well developed.', 4, '2025-03-26'),
(1007, 1005, N'Deep dive into human civilizations.', 5, '2025-03-27'),
(1008, 1007, N'Good balance of theory and examples.', 4, '2025-03-28'),
(1009, 1010, N'Great for beginners in programming.', 5, '2025-03-29'),
(1010, 1012, N'Fascinating documentary-style writing.', 4, '2025-03-30'),
(1001, 1013, N'You learn something new from every page.', 5, '2025-03-31'),
(1002, 1014, N'Excellent SQL practices included.', 5, '2025-04-01'),
(1003, 1002, N'Complex ideas explained simply.', 4, '2025-04-02'),
(1004, 1004, N'A philosophical read for all ages.', 5, '2025-04-03'),
(1005, 1006, N'A classic. Worth reading again.', 5, '2025-04-04'),
(1006, 1008, N'Full of imagination and mystery.', 5, '2025-04-05'),
(1007, 1011, N'Deep dystopian vision, still relevant.', 5, '2025-04-06'),
(1008, 1015, N'Enchanting and magical.', 5, '2025-04-07'),
(1009, 1014, N'Clear structure and useful examples.', 4, '2025-04-08'),
(1010, 1009, N'Best beginner finance book out there.', 5, '2025-04-09'),
(1001, 1007, N'Captivating scientific explanations.', 5, '2025-04-10');
-----------------------------------------------------------------------------------------
INSERT INTO Loan (LoanID, IssueDate, DueDate, ReturnDate, BookID, BranchID, MemberID)
VALUES
(401, '2025-03-01', '2025-03-15', '2025-03-10', 1003, 1, 1001),
(402, '2025-03-02', '2025-03-16', '2025-03-16', 1005, 2, 1002),
(403, '2025-03-03', '2025-03-17', NULL, 1007, 3, 1003),
(404, '2025-03-04', '2025-03-18', '2025-03-17', 1010, 4, 1004),
(405, '2025-03-05', '2025-03-19', NULL, 1012, 1, 1005),
(406, '2025-03-06', '2025-03-20', NULL, 1014, 2, 1006),
(407, '2025-03-07', '2025-03-21', NULL, 1015, 3, 1007),
(408, '2025-03-08', '2025-03-22', NULL, 1002, 4, 1008),
(409, '2025-03-09', '2025-03-23', NULL, 1004, 1, 1009),
(410, '2025-03-10', '2025-03-24', NULL, 1006, 2, 1010);
-----------------------------------------------------------------------------------------
INSERT INTO Branch (BranchAddress, LibrarianID)
VALUES
(N'123 Main Street, District 1, Ho Chi Minh City', 201),
(N'456 Nguyen Trai, District 5, Ho Chi Minh City', 202),
(N'789 Le Loi, District 3, Ho Chi Minh City', 203),
(N'101 Tran Hung Dao, District 1, Ho Chi Minh City', 204);
-----------------------------------------------------------------------------------------
INSERT INTO Inventory (BranchID, BookID, Number, LastUpdated)
VALUES
-- Branch 1
(1, 1001, 5, '2025-03-01'),
(1, 1002, 7, '2025-03-01'),
(1, 1003, 3, '2025-03-01'),
(1, 1004, 8, '2025-03-01'),
(1, 1005, 4, '2025-03-01'),
(1, 1006, 6, '2025-03-01'),
(1, 1007, 2, '2025-03-01'),
(1, 1008, 9, '2025-03-01'),
(1, 1009, 3, '2025-03-01'),
(1, 1010, 5, '2025-03-01'),
(1, 1011, 7, '2025-03-01'),
(1, 1012, 4, '2025-03-01'),
(1, 1013, 6, '2025-03-01'),
(1, 1014, 3, '2025-03-01'),
(1, 1015, 8, '2025-03-01'),

-- Branch 2
(2, 1001, 4, '2025-03-02'),
(2, 1002, 5, '2025-03-02'),
(2, 1003, 2, '2025-03-02'),
(2, 1004, 7, '2025-03-02'),
(2, 1005, 9, '2025-03-02'),
(2, 1006, 6, '2025-03-02'),
(2, 1007, 4, '2025-03-02'),
(2, 1008, 3, '2025-03-02'),
(2, 1009, 5, '2025-03-02'),
(2, 1010, 2, '2025-03-02'),
(2, 1011, 8, '2025-03-02'),
(2, 1012, 3, '2025-03-02'),
(2, 1013, 6, '2025-03-02'),
(2, 1014, 7, '2025-03-02'),
(2, 1015, 4, '2025-03-02'),

-- Branch 3
(3, 1001, 7, '2025-03-03'),
(3, 1002, 2, '2025-03-03'),
(3, 1003, 6, '2025-03-03'),
(3, 1004, 4, '2025-03-03'),
(3, 1005, 3, '2025-03-03'),
(3, 1006, 5, '2025-03-03'),
(3, 1007, 8, '2025-03-03'),
(3, 1008, 6, '2025-03-03'),
(3, 1009, 4, '2025-03-03'),
(3, 1010, 3, '2025-03-03'),
(3, 1011, 9, '2025-03-03'),
(3, 1012, 2, '2025-03-03'),
(3, 1013, 5, '2025-03-03'),
(3, 1014, 6, '2025-03-03'),
(3, 1015, 7, '2025-03-03'),

-- Branch 4
(4, 1001, 6, '2025-03-04'),
(4, 1002, 4, '2025-03-04'),
(4, 1003, 3, '2025-03-04'),
(4, 1004, 7, '2025-03-04'),
(4, 1005, 5, '2025-03-04'),
(4, 1006, 4, '2025-03-04'),
(4, 1007, 6, '2025-03-04'),
(4, 1008, 7, '2025-03-04'),
(4, 1009, 2, '2025-03-04'),
(4, 1010, 4, '2025-03-04'),
(4, 1011, 5, '2025-03-04'),
(4, 1012, 3, '2025-03-04'),
(4, 1013, 8, '2025-03-04'),
(4, 1014, 6, '2025-03-04'),
(4, 1015, 4, '2025-03-04');
-----------------------------------------------------------------------------------------
INSERT INTO [dbo].[Event] (EventID, BranchID, EventName, Description, EventDate)
VALUES
(1, 1, N'Reading Workshop for Children', N'A special storytelling session for young readers.', '2025-04-10'),
(2, 1, N'Book Donation Drive', N'Encourage readers to donate old books.', '2025-04-20'),
(3, 2, N'Author Meet & Greet', N'Meet the author of the best-selling novel.', '2025-04-12'),
(4, 2, N'Poetry Reading Night', N'Recital of classic and modern poems.', '2025-04-25'),
(5, 3, N'Student Book Fair', N'Books for students at discounted prices.', '2025-04-15'),
(6, 3, N'Library Orientation', N'Introduce new members to library services.', '2025-04-18'),
(7, 4, N'Local History Exhibition', N'Explore the history of the local community.', '2025-04-22'),
(8, 4, N'Movie Screening', N'Special screening of a literary film.', '2025-04-28');
INSERT INTO Event (EventID, BranchID, EventName, Description, EventDate)
VALUES 
(2001, 1, 'Children Book Fair', 'A fun event for kids with book reading activities.', '2024-12-15'),
(2002, 2, 'Author Meetup', 'Meet your favorite local authors and get your books signed.', '2025-01-10'),
(2003, 3, 'New Year Book Drive', 'Donate old books and get discount coupons.', '2025-01-01'),
(2004, 4, 'Literature Night', 'An evening of poetry and short story reading.', '2025-02-20'),
(2005, 1, 'History Talk Show', 'Discuss famous historical events and related books.', '2025-03-01');
-----------------------------------------------------------------------------------------
INSERT INTO Supplier (SupplierID, SupplierName, Contact_Info)
VALUES 
(1, N'Alpha Books Co.', N'Email: contact@alphabooks.com | Phone: 0901234567'),
(2, N'Green Leaf Publishing', N'Email: info@greenleafpub.vn | Phone: 0912345678'),
(3, N'Knowledge Source Ltd.', N'Email: support@knowledgesource.vn | Phone: 0923456789'),
(4, N'Global Education Supply', N'Email: sales@globaledu.com | Phone: 0934567890');
-----------------------------------------------------------------------------------------
INSERT INTO Author (AuthorID, AuthorName, AuthorBio)
VALUES 
(1, N'Nguyễn Nhật Ánh', N'Tác giả nổi tiếng với các tác phẩm văn học thiếu nhi.'),
(2, N'J.K. Rowling', N'Tác giả của bộ truyện Harry Potter nổi tiếng toàn cầu.'),
(3, N'Dan Brown', N'Tác giả chuyên viết tiểu thuyết trinh thám và giả tưởng.'),
(4, N'Haruki Murakami', N'Nhà văn nổi tiếng người Nhật Bản với phong cách siêu thực.'),
(5, N'Paulo Coelho', N'Tác giả nổi tiếng với cuốn sách The Alchemist.');
-----------------------------------------------------------------------------------------
INSERT INTO Book_Author (BookID, AuthorID)
VALUES
(1001, 1),  
(1002, 2),  
(1003, 3), 
(1004, 4),  
(1005, 5), 
(1006, 1),  
(1007, 2),  
(1008, 3), 
(1009, 4),  
(1010, 5), 
(1011, 1),  
(1012, 2),  
(1013, 3), 
(1014, 4),  
(1015, 5);
-----------------------------------------------------------------------------------------
INSERT INTO Supply (SupplierID, BranchID, BookID, Number, SupplyDate)
VALUES
(1, 1, 1001, 10, '2025-03-01');
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetReservationsByLibrarianName
    @LibrarianName [nvarchar](50)
AS
BEGIN
    SELECT 
        L.LibrarianName,
		B.BookName,
		B.ISBN,
        R.RequestDate,
        R.Status
    FROM Reservation R
    INNER JOIN Librarian L ON R.ProcessedBy = L.LibrarianID
    INNER JOIN Book B ON B.BookID = R.BookID
    WHERE L.LibrarianName = @LibrarianName;
END;
EXEC GetReservationsByLibrarianName N'Tran Van Minh';
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetReservationsByStatus
    @Status [nvarchar](20)
AS
BEGIN
    SELECT 
        L.LibrarianName,
        B.BookName,
        B.ISBN,
        R.RequestDate,
        R.Status
    FROM Reservation R
    INNER JOIN Librarian L ON R.ProcessedBy = L.LibrarianID
    INNER JOIN Book B ON R.BookID = B.BookID
    WHERE R.Status = @Status;
END;
EXEC GetReservationsByStatus 'Pending';
-----------------------------------------------------------------------------------------
CREATE PROCEDURE UpdateReservationStatusFull
    @ReservationID INT,
    @NewStatus VARCHAR(20),
    @LibrarianID INT
AS
BEGIN
    IF @NewStatus NOT IN ('Pending', 'Approved', 'Cancelled', 'Fulfilled')
    BEGIN
        PRINT 'Invalid status. Allowed values: Pending, Approved, Cancelled, Fulfilled';
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Librarian WHERE LibrarianID = @LibrarianID)
    BEGIN
        PRINT 'Invalid Librarian ID.';
        RETURN;
    END
    UPDATE Reservation
    SET Status = @NewStatus,
        ProcessedBy = @LibrarianID,
        ProcessDate = GETDATE()
    WHERE ReservationID = @ReservationID;

    PRINT 'Reservation status updated successfully.';
END;
EXEC UpdateReservationStatusFull 
    @ReservationID = 1, 
    @NewStatus = 'Approved', 
    @LibrarianID = 202;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetBookRatingSummaryByID
    @BookID INT
AS
BEGIN
    SELECT 
        B.BookID,
        B.BookName,
        SUM(CASE WHEN R.Rating = 5 THEN 1 ELSE 0 END) AS Rating5,
        SUM(CASE WHEN R.Rating = 4 THEN 1 ELSE 0 END) AS Rating4,
        SUM(CASE WHEN R.Rating = 3 THEN 1 ELSE 0 END) AS Rating3,
        SUM(CASE WHEN R.Rating = 2 THEN 1 ELSE 0 END) AS Rating2,
        SUM(CASE WHEN R.Rating = 1 THEN 1 ELSE 0 END) AS Rating1,
        AVG(CAST(R.Rating AS FLOAT)) AS AverageRating
    FROM Book B
    LEFT JOIN Review R ON B.BookID = R.BookID
    WHERE B.BookID = @BookID
    GROUP BY B.BookID, B.BookName
END
EXEC GetBookRatingSummaryByID @BookID = 1005;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetAllBooksRatingSummary
AS
BEGIN
    SELECT 
        B.BookID,
        B.BookName,
        SUM(CASE WHEN R.Rating = 5 THEN 1 ELSE 0 END) AS Rating5,
        SUM(CASE WHEN R.Rating = 4 THEN 1 ELSE 0 END) AS Rating4,
        SUM(CASE WHEN R.Rating = 3 THEN 1 ELSE 0 END) AS Rating3,
        SUM(CASE WHEN R.Rating = 2 THEN 1 ELSE 0 END) AS Rating2,
        SUM(CASE WHEN R.Rating = 1 THEN 1 ELSE 0 END) AS Rating1,
        ROUND(AVG(CAST(R.Rating AS FLOAT)), 1) AS AverageRating
    FROM Book B
    LEFT JOIN Review R ON B.BookID = R.BookID
    GROUP BY B.BookID, B.BookName
    ORDER BY AverageRating DESC
END
EXEC GetAllBooksRatingSummary;
select * from [dbo].[Book]
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetReviewsByRatingAndBook
    @Rating INT,
    @BookID INT
AS
BEGIN
    IF @Rating < 1 OR @Rating > 5
    BEGIN
        PRINT 'Invalid Rating. Rating must be between 1 and 5.'
        RETURN
    END
    IF NOT EXISTS (SELECT 1 FROM Book WHERE BookID = @BookID)
    BEGIN
        PRINT 'Invalid BookID. This book does not exist in the system.'
        RETURN
    END
    SELECT r.ReviewID, r.BookID, b.BookName, r.Comment, r.Rating, r.[Date]
    FROM Review r
    INNER JOIN Book b ON r.BookID = b.BookID
    WHERE r.Rating = @Rating AND r.BookID = @BookID
END
GO
EXEC GetReviewsByRatingAndBook @Rating = 5, @BookID = 1004
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetBookInventoryByID
    @BookID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Inventory WHERE BookID = @BookID)
    BEGIN
        PRINT 'Invalid BookID: This book does not exist in inventory.';
        RETURN;
    END
    SELECT 
        b.BookID,
        b.BookName,
        b.ISBN,
        br.BranchID,
        br.BranchAddress,
        i.Number AS Quantity
    FROM Book b
    LEFT JOIN Inventory i ON b.BookID = i.BookID
    LEFT JOIN Branch br ON i.BranchID = br.BranchID
    WHERE b.BookID = @BookID;
END;
EXEC GetBookInventoryByID @BookID = 1005;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetOutOfStockBooks
AS
BEGIN
    SELECT 
        b.BookID,
        b.BookName,
        b.ISBN,
        i.BranchID
    FROM Book b
    INNER JOIN Inventory i ON b.BookID = i.BookID
    WHERE i.Number = 0;
END;
EXEC GetOutOfStockBooks; 
-----------------------------------------------------------------------------------------
CREATE PROCEDURE DecreaseBookQuantity
    @BookID INT,
    @BranchID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Inventory WHERE BookID = @BookID)
    BEGIN
        PRINT 'Invalid BookID: This book does not exist in inventory.';
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Inventory WHERE BranchID = @BranchID)
    BEGIN
        PRINT 'Invalid BranchID: This branch does not exist in inventory.';
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Inventory WHERE BookID = @BookID AND BranchID = @BranchID)
    BEGIN
        PRINT 'This book is not available at the specified branch.';
        RETURN;
    END
    IF EXISTS (
        SELECT 1 
        FROM Inventory 
        WHERE BookID = @BookID AND BranchID = @BranchID AND Number > 0
    )
    BEGIN
        UPDATE Inventory
        SET Number = Number - 1,
            LastUpdated = GETDATE()
        WHERE BookID = @BookID AND BranchID = @BranchID;

        PRINT 'Quantity successfully decreased.';
    END
    ELSE
    BEGIN
        PRINT 'Cannot decrease. Quantity is already 0 or inventory not found.';
    END
END;
EXEC DecreaseBookQuantity @BookID = 1007, @BranchID = 1;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetUpcomingEvents
AS
BEGIN
    SELECT 
        E.EventID,
        E.EventName,
        E.Description,
        E.EventDate,
        B.BranchAddress
    FROM 
        Event E
    JOIN 
        Branch B ON E.BranchID = B.BranchID
    WHERE 
        E.EventDate >= CAST(GETDATE() AS DATE)
    ORDER BY 
        E.EventDate ASC;
END;
EXEC GetUpcomingEvents;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetUpcomingEventsByBranch
    @BranchID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Branch WHERE BranchID = @BranchID)
    BEGIN
        PRINT 'Error: BranchID does not exist!';
        RETURN;
    END
    SELECT 
        E.EventID,
        E.EventName,
        E.Description,
        E.EventDate,
        B.BranchAddress
    FROM 
        Event E
    JOIN 
        Branch B ON E.BranchID = B.BranchID
    WHERE 
        E.BranchID = @BranchID
        AND E.EventDate >= CAST(GETDATE() AS DATE)
    ORDER BY 
        E.EventDate;
END
EXEC GetUpcomingEventsByBranch @BranchID = 4;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE InsertSupplyAndUpdateInventory
    @SupplierID INT,
    @BranchID INT,
    @BookID INT,
    @Number INT,
    @SupplyDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Supply (SupplierID, BranchID, BookID, Number, SupplyDate)
    VALUES (@SupplierID, @BranchID, @BookID, @Number, @SupplyDate);

    IF EXISTS (SELECT 1 FROM Inventory WHERE BranchID = @BranchID AND BookID = @BookID)
    BEGIN
        UPDATE Inventory
        SET Number = Number + @Number,
            LastUpdated = GETDATE()
        WHERE BranchID = @BranchID AND BookID = @BookID;
    END
    ELSE
    BEGIN
        INSERT INTO Inventory (BranchID, BookID, Number, LastUpdated)
        VALUES (@BranchID, @BookID, @Number, GETDATE());
    END
END;
EXEC InsertSupplyAndUpdateInventory 
    @SupplierID = 1, 
    @BranchID = 1, 
    @BookID = 1007, 
    @Number = 10, 
    @SupplyDate = '2025-03-12';
-----------------------------------------------------------------------------------------
CREATE PROCEDURE UpdateReturnDateByLoanID
    @LoanID INT,
    @NewReturnDate DATE
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Loan WHERE LoanID = @LoanID)
    BEGIN
        PRINT 'LoanID does not exist.';
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Loan WHERE LoanID = @LoanID AND ReturnDate IS NOT NULL)
    BEGIN
        PRINT 'This loan has already been returned.';
        RETURN;
    END
    UPDATE Loan
    SET ReturnDate = @NewReturnDate
    WHERE LoanID = @LoanID AND ReturnDate IS NULL;
    DECLARE @BookID INT, @BranchID INT;
    SELECT @BookID = BookID, @BranchID = BranchID
    FROM Loan
    WHERE LoanID = @LoanID;
    UPDATE Inventory
    SET Number = Number + 1,
        LastUpdated = GETDATE()
    WHERE BookID = @BookID AND BranchID = @BranchID;
    SELECT 
        l.LoanID,
        m.MemberName,
        b.BookName,
        l.ReturnDate
    FROM Loan l
    JOIN Member m ON l.MemberID = m.MemberID
    JOIN Book b ON l.BookID = b.BookID
    WHERE l.LoanID = @LoanID;
END
EXEC UpdateReturnDateByLoanID @LoanID = 407, @NewReturnDate = '2025-03-12';
-----------------------------------------------------------------------------------------
CREATE PROCEDURE InsertLoan
    @LoanID INT,
    @IssueDate DATE,
    @DueDate DATE,
    @BookID INT,
    @BranchID INT,
    @MemberID INT,
	@RequestID INT = NULL
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Inventory
        WHERE BookID = @BookID AND BranchID = @BranchID
    )
    BEGIN
        PRINT 'Book or Branch does not exist in Inventory.';
        RETURN;
    END
    IF EXISTS (
        SELECT 1 FROM Inventory
        WHERE BookID = @BookID AND BranchID = @BranchID AND Number = 0
    )
    BEGIN
        PRINT 'The book is out of stock in this branch.';
        RETURN;
    END
    INSERT INTO Loan (LoanID, IssueDate, DueDate, ReturnDate, BookID, BranchID, MemberID)
    VALUES (@LoanID, @IssueDate, @DueDate, NULL, @BookID, @BranchID, @MemberID);
    UPDATE Inventory
    SET Number = Number - 1,
        LastUpdated = GETDATE()
    WHERE BookID = @BookID AND BranchID = @BranchID;
    UPDATE Request
    SET RequestFinish = 1
    WHERE RequestID = @RequestID AND BookID = @BookID AND MemberID = @MemberID
          AND BranchID = @BranchID     
          AND RequestFinish = 0;
    PRINT 'Loan inserted successfully, inventory updated, and request marked as finished.';
END
EXEC InsertLoan
    @LoanID = 417,
    @IssueDate = '2025-03-14',
    @DueDate = '2025-03-26',
    @BookID = 1006,
    @BranchID = 2,
    @MemberID = 1003,
	@RequestID = 8;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE CheckBookStockByISBN
    @ISBN NVARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        PRINT 'This book does not exist in the library system.';
        RETURN;
    END
    IF NOT EXISTS (
        SELECT 1
        FROM Book b
        JOIN Inventory i ON b.BookID = i.BookID
        WHERE b.ISBN = @ISBN AND i.Number > 0
    )
    BEGIN
        PRINT 'This book is currently out of stock in all branches.';
    END
    ELSE
    BEGIN
        SELECT 
            b.BookID,
            b.BookName,
            b.ISBN,
            i.BranchID,
            i.Number AS AvailableQuantity
        FROM Book b
        JOIN Inventory i ON b.BookID = i.BookID
        WHERE b.ISBN = @ISBN AND i.Number > 0;
    END
END
EXEC CheckBookStockByISBN @ISBN = '978123456002';
-----------------------------------------------------------------------------------------
CREATE PROCEDURE InsertRequest
    @BookID INT,
    @BranchID INT,
    @MemberID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Book WHERE BookID = @BookID)
    BEGIN
        PRINT 'BookID does not exist.';
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Branch WHERE BranchID = @BranchID)
    BEGIN
        PRINT 'BranchID does not exist.';
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Member WHERE MemberID = @MemberID)
    BEGIN
        PRINT 'MemberID does not exist.';
        RETURN;
    END
    INSERT INTO Request (BookID, BranchID, MemberID, RequestDate, RequestFinish)
    VALUES (@BookID, @BranchID, @MemberID, GETDATE(), 0);

    PRINT 'Request inserted successfully.';
END

EXEC InsertRequest
    @BookID = 1006,
    @BranchID = 2,
    @MemberID = 1003;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE CreateReservation
    @BookID INT,
    @MemberID INT,
    @RequestDate DATE,
    @BranchID INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Inventory
        WHERE BookID = @BookID AND BranchID = @BranchID AND Number > 0
    )
    BEGIN
        PRINT 'Cannot create reservation: Book is still available in this branch.';
        RETURN;
    END

    INSERT INTO Reservation (
        MemberID, BookID, RequestDate, Status, ProcessedBy, ProcessDate, BranchID
    )
    VALUES (
        @MemberID, @BookID, @RequestDate, 'Pending', NULL, NULL, @BranchID
    );

    PRINT 'Reservation created successfully with status Pending.';
END
EXEC CreateReservation
    @BookID = 1007,
    @MemberID = 1001,
    @RequestDate = '2025-03-12',
    @BranchID = 1;
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetBooksByAuthorName
    @AuthorName NVARCHAR(100)
AS
BEGIN
    SELECT 
        b.BookID,
        b.BookName,
        b.ISBN,
        b.BookPublicationDate
    FROM Book b
    INNER JOIN Book_Author ba ON b.BookID = ba.BookID
    INNER JOIN Author a ON ba.AuthorID = a.AuthorID
    WHERE a.AuthorName LIKE '%' + @AuthorName + '%';
END
EXEC GetBooksByAuthorName @AuthorName = N'Dan';
 
 ----------------------------------------------------------------------------------------------------------------------
 ALTER TABLE Book
ADD ImagePath nvarchar(255);

UPDATE Book
SET ImagePath = 'app\images\img\tomsawyer.jpg'
WHERE BookID = 1001;
UPDATE Book
SET ImagePath = 'app\images\img\Brief.jpg'
WHERE BookID = 1002;
UPDATE Book
SET ImagePath = 'app\images\img\Kill.jpg'
WHERE BookID = 1003;
UPDATE Book
SET ImagePath = 'app\images\img\Prince.jpg'
WHERE BookID = 1004;
UPDATE Book
SET ImagePath = 'app\images\img\Humankind.jpg'
WHERE BookID = 1005;
UPDATE Book
SET ImagePath = 'app\images\img\pride.avif'
WHERE BookID = 1006;
UPDATE Book
SET ImagePath = 'app\images\img\Selfish.webp'
WHERE BookID = 1007;
UPDATE Book
SET ImagePath = 'app\images\img\Harry.avif'
WHERE BookID = 1008;
UPDATE Book
SET ImagePath = 'app\images\img\rich.jpg'
WHERE BookID = 1009;
UPDATE Book
SET ImagePath = 'app\images\img\python.jpeg'
WHERE BookID = 1010;
UPDATE Book
SET ImagePath = 'app\images\img\1984.jpg'
WHERE BookID = 1011;
UPDATE Book
SET ImagePath = 'app\images\img\cosmos.jpg'
WHERE BookID = 1012;
UPDATE Book
SET ImagePath = 'app\images\img\silk.jpg'
WHERE BookID = 1013;
UPDATE Book
SET ImagePath = 'app\images\img\sql.jpg'
WHERE BookID = 1014;
UPDATE Book
SET ImagePath = 'app\images\img\chocolate.webp'
WHERE BookID = 1015;

ALTER TABLE book
ADD description NVARCHAR(1000);

UPDATE book SET description = 
'A classic American novel by Mark Twain that follows the young and mischievous Tom Sawyer as he navigates life, adventure, friendship, and growing up along the Mississippi River. The story combines humor, satire, and social commentary in a vivid portrayal of 19th-century Southern life.'
WHERE BookTitle = 'The Adventures of Tom Sawyer';

UPDATE book SET description = 
'Stephen Hawking’s groundbreaking book explores fundamental questions about the universe, time, black holes, and the Big Bang. Written in accessible language, it brings complex concepts in cosmology and physics to a general audience, blending science with philosophical insight.'
WHERE BookTitle = 'A Brief History of Time';

UPDATE book SET description = 
'Harper Lee’s Pulitzer Prize-winning novel tells the story of Scout Finch, a young girl growing up in a racially divided Southern town. It tackles deep themes of racial injustice, morality, and human compassion through the eyes of an innocent child observing adult hypocrisy.'
WHERE BookTitle = 'To Kill a Mockingbird';

UPDATE book SET description = 
'A timeless novella by Antoine de Saint-Exupéry that tells the story of a young prince who travels from planet to planet, learning about love, loneliness, and the flaws of adulthood. It’s a philosophical tale wrapped in a children’s story, loved by readers of all ages.'
WHERE BookTitle = 'The Little Prince';

UPDATE book SET description = 
'This sweeping narrative by Yuval Noah Harari examines the history of our species—from primitive hunter-gatherers to modern digital society. It analyzes biology, culture, economics, and human behavior in a thought-provoking way that challenges conventional ideas about progress.'
WHERE BookTitle = 'Sapiens: A Brief History of Humankind';

UPDATE book SET description = 
'Jane Austen’s beloved novel portrays the evolving relationship between the intelligent Elizabeth Bennet and the proud Mr. Darcy. Set in early 19th-century England, it critiques social class, marriage, and gender roles while offering witty dialogue and enduring romance.'
WHERE BookTitle = 'Pride and Prejudice';

UPDATE book SET description = 
'In this influential book on evolutionary biology, Richard Dawkins introduces the concept of the gene-centered view of evolution. He argues that genes behave selfishly to ensure their own survival and explains natural selection in a way accessible to general readers.'
WHERE BookTitle = 'The Selfish Gene';

UPDATE book SET description = 
'The first novel in J.K. Rowling’s magical series follows Harry Potter, a boy who discovers he is a wizard and attends Hogwarts School of Witchcraft and Wizardry. He makes lifelong friends and enemies while uncovering secrets about his past and destiny.'
WHERE BookTitle = 'Harry Potter and the Sorcerer''s Stone';

UPDATE book SET description = 
'A bestselling personal finance classic by Robert Kiyosaki that contrasts two perspectives on money and success—one from his biological father and the other from a mentor. The book encourages financial literacy, investing, and thinking differently about wealth.'
WHERE BookTitle = 'Rich Dad Poor Dad';

UPDATE book SET description = 
'A comprehensive guide for those who want to learn Python from the basics to advanced concepts. It covers topics like data types, functions, loops, file handling, and object-oriented programming, with practical examples and exercises to reinforce learning.'
WHERE BookTitle = 'Learn Python Programming';

UPDATE book SET description = 
'George Orwell’s dystopian novel paints a chilling vision of a totalitarian regime where surveillance is omnipresent, truth is manipulated, and independent thought is suppressed. The story of Winston Smith explores themes of freedom, resistance, and psychological control.'
WHERE BookTitle = '1984';

UPDATE book SET description = 
'Carl Sagan’s masterpiece blends science and wonder as it takes readers on a journey through space and time. It explores the history of scientific discovery, the vastness of the universe, and humanity’s place within it, urging us to embrace reason and curiosity.'
WHERE BookTitle = 'Cosmos';

UPDATE book SET description = 
'Peter Frankopan reexamines history through the lens of the Silk Roads, the ancient trade routes that linked East and West. The book reveals how power, wealth, religion, and ideas traveled across continents and how these routes shaped world civilizations.'
WHERE BookTitle = 'The Silk Roads';

UPDATE book SET description = 
'A practical and detailed reference book for mastering SQL, suitable for beginners and experienced users alike. It includes explanations of queries, joins, subqueries, indexes, and database design, with plenty of examples to help you understand relational databases.'
WHERE BookTitle = 'Mastering SQL';

UPDATE book SET description = 
'Roald Dahl’s delightful children’s book follows young Charlie Bucket as he wins a golden ticket to visit Willy Wonka’s fantastical chocolate factory. The story is filled with imagination, whimsy, colorful characters, and lessons about behavior and kindness.'
WHERE BookTitle = 'Charlie and the Chocolate Factory';


CREATE PROCEDURE GetTotalBookQuantities
AS
BEGIN
    SELECT 
        b.BookID,
        b.BookName,
        SUM(i.Number) AS TotalQuantity
    FROM Book b
    INNER JOIN Inventory i ON b.BookID = i.BookID
    GROUP BY b.BookID, b.BookName
    ORDER BY b.BookID;
END;

EXEC GetTotalBookQuantities;
select * from [dbo].[Inventory]

CREATE TABLE Wishlist (
    WishlistID INT IDENTITY PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    AddedDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);
INSERT INTO Wishlist (MemberID, BookID)
VALUES 
(1012, 1007)


Select * from Loan
INSERT INTO Loan (IssueDate, DueDate, ReturnDate, BookID, MemberID)
VALUES
('2025-03-01', '2025-03-15', NULL, 1003, 1012)


CREATE PROCEDURE InsertLoan
    @LoanID INT,
    @IssueDate DATE,
    @DueDate DATE,
    @BookID INT,
    @MemberID INT,
	@RequestID INT = NULL
AS
BEGIN
    INSERT INTO Loan (IssueDate, DueDate, ReturnDate, BookID, MemberID)
    VALUES (@IssueDate, @DueDate, NULL, @BookID, @MemberID);
    UPDATE Inventory
    SET Number = Number - 1,
        LastUpdated = GETDATE()
    WHERE BookID = @BookID AND BranchID = @BranchID;
    UPDATE Request
    SET RequestFinish = 1
    WHERE RequestID = @RequestID AND BookID = @BookID AND MemberID = @MemberID
          AND BranchID = @BranchID     
          AND RequestFinish = 0;
	PRINT 'Loan inserted successfully, inventory updated, and request marked as finished.';
END
EXEC InsertLoan
    @LoanID = 417,
    @IssueDate = '2025-03-14',
    @DueDate = '2025-03-26',
    @BookID = 1006,
    @BranchID = 2,
    @MemberID = 1003,
	@RequestID = 8;


Select * from Loan
Select * from Request
Select * from Inventory
Select * from Book
-----------------------------------------------------------------------------------------
select * from [dbo].[Book]
select * from [dbo].[Member]
select * from [dbo].[BookGenre]
select * from [dbo].[Publisher]
select * from [dbo].[Librarian]
select * from [dbo].[Reservation]
select * from [dbo].[Review]
select * from [dbo].[Event]
select * from [dbo].[Supplier]
select * from [dbo].[Supply]
select * from [dbo].[Branch]
select * from [dbo].[Request]
select * from [dbo].[Author]
select * from [dbo].[Book_Author]
select * from [dbo].[Inventory]
select * from [dbo].[Loan]
select * from [dbo].[Request]
select * from [dbo].[Reservation]
select * from [dbo].[Wishlist]



DELETE FROM Request;
