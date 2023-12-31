USE [master]
GO
/****** Object:  Database [Hospital]    Script Date: 7/19/2023 3:48:56 PM ******/
CREATE DATABASE [Hospital]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hospital', FILENAME = N'E:\Git\Hospital.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hospital_log', FILENAME = N'E:\Git\Hospital_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Hospital] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hospital].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hospital] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hospital] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hospital] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hospital] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hospital] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hospital] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hospital] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hospital] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hospital] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hospital] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hospital] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hospital] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hospital] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hospital] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hospital] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Hospital] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hospital] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hospital] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hospital] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hospital] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hospital] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hospital] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hospital] SET RECOVERY FULL 
GO
ALTER DATABASE [Hospital] SET  MULTI_USER 
GO
ALTER DATABASE [Hospital] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hospital] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hospital] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hospital] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hospital] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Hospital] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Hospital', N'ON'
GO
ALTER DATABASE [Hospital] SET QUERY_STORE = ON
GO
ALTER DATABASE [Hospital] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Hospital]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NULL,
	[birthdate] [date] NULL,
	[W_id] [int] NULL,
	[Bdate] [date] NULL,
	[Age]  AS (datepart(year,getdate())-datepart(year,[bdate])),
	[Gender] [bit] NULL,
	[medicalHistory] [varchar](100) NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GetAllPatient]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[GetAllPatient]
as
select Name,Bdate,MedicalHistory,Age , case
when gender = 0 then 'Male'
when gender = 1 then 'Female'
end as Gender 
from Patient
GO
/****** Object:  Table [dbo].[Consultant]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Consultant](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NULL,
	[Qualifications] [varchar](50) NULL,
	[Specialty] [varchar](20) NULL,
	[bdate] [date] NULL,
	[age]  AS (datepart(year,getdate()-datepart(year,[bdate]))),
 CONSTRAINT [PK_Consultant] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GetConsultant]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[GetConsultant]
as 
select * from Consultant
GO
/****** Object:  Table [dbo].[Assign_patient]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assign_patient](
	[P_id] [int] NOT NULL,
	[C_id] [int] NULL,
 CONSTRAINT [PK_Assign_patient] PRIMARY KEY CLUSTERED 
(
	[P_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[CodeNumber] [int] NOT NULL,
	[BrandName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[CodeNumber] ASC,
	[BrandName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Drug]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drug](
	[CodeNumber] [int] NOT NULL,
	[DosageRecommended] [varchar](50) NULL,
	[GenericName] [varchar](20) NULL,
 CONSTRAINT [PK_Drug] PRIMARY KEY CLUSTERED 
(
	[CodeNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Examine_patient]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Examine_patient](
	[P_id] [int] NOT NULL,
	[C_id] [int] NOT NULL,
 CONSTRAINT [PK_Examine_patient] PRIMARY KEY CLUSTERED 
(
	[P_id] ASC,
	[C_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Give_drug]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Give_drug](
	[N_id] [int] NOT NULL,
	[P_id] [int] NOT NULL,
	[CodeNumber] [int] NOT NULL,
	[Date] [date] NULL,
	[dosage] [varchar](50) NULL,
 CONSTRAINT [PK_Give_drug] PRIMARY KEY CLUSTERED 
(
	[N_id] ASC,
	[P_id] ASC,
	[CodeNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nurse]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nurse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NULL,
	[W_id] [int] NULL,
	[Gender] [bit] NULL,
	[Qualifications] [varchar](50) NULL,
	[BDate] [date] NULL,
	[age]  AS (datepart(year,getdate())-datepart(year,[bdate])),
 CONSTRAINT [PK_Nurse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nurse_Phone]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nurse_Phone](
	[Nurse_id] [int] NOT NULL,
	[PhoneNumber] [varchar](14) NOT NULL,
 CONSTRAINT [PK_Nurse_Phone] PRIMARY KEY CLUSTERED 
(
	[Nurse_id] ASC,
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ward]    Script Date: 7/19/2023 3:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ward](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[N_id] [int] NULL,
	[Capacity] [int] NULL,
	[WardType] [varchar](20) NULL,
 CONSTRAINT [PK_Ward] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Assign_patient]  WITH CHECK ADD  CONSTRAINT [FK_Assign_patient_Consultant] FOREIGN KEY([C_id])
REFERENCES [dbo].[Consultant] ([Id])
GO
ALTER TABLE [dbo].[Assign_patient] CHECK CONSTRAINT [FK_Assign_patient_Consultant]
GO
ALTER TABLE [dbo].[Assign_patient]  WITH CHECK ADD  CONSTRAINT [FK_Assign_patient_Patient] FOREIGN KEY([P_id])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[Assign_patient] CHECK CONSTRAINT [FK_Assign_patient_Patient]
GO
ALTER TABLE [dbo].[Brands]  WITH CHECK ADD  CONSTRAINT [FK_Brands_Drug] FOREIGN KEY([CodeNumber])
REFERENCES [dbo].[Drug] ([CodeNumber])
GO
ALTER TABLE [dbo].[Brands] CHECK CONSTRAINT [FK_Brands_Drug]
GO
ALTER TABLE [dbo].[Examine_patient]  WITH CHECK ADD  CONSTRAINT [FK_Examine_patient_Consultant] FOREIGN KEY([C_id])
REFERENCES [dbo].[Consultant] ([Id])
GO
ALTER TABLE [dbo].[Examine_patient] CHECK CONSTRAINT [FK_Examine_patient_Consultant]
GO
ALTER TABLE [dbo].[Examine_patient]  WITH CHECK ADD  CONSTRAINT [FK_Examine_patient_Patient] FOREIGN KEY([P_id])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[Examine_patient] CHECK CONSTRAINT [FK_Examine_patient_Patient]
GO
ALTER TABLE [dbo].[Give_drug]  WITH CHECK ADD  CONSTRAINT [FK_Give_drug_Drug] FOREIGN KEY([CodeNumber])
REFERENCES [dbo].[Drug] ([CodeNumber])
GO
ALTER TABLE [dbo].[Give_drug] CHECK CONSTRAINT [FK_Give_drug_Drug]
GO
ALTER TABLE [dbo].[Give_drug]  WITH CHECK ADD  CONSTRAINT [FK_Give_drug_Nurse] FOREIGN KEY([N_id])
REFERENCES [dbo].[Nurse] ([Id])
GO
ALTER TABLE [dbo].[Give_drug] CHECK CONSTRAINT [FK_Give_drug_Nurse]
GO
ALTER TABLE [dbo].[Give_drug]  WITH CHECK ADD  CONSTRAINT [FK_Give_drug_Patient] FOREIGN KEY([P_id])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[Give_drug] CHECK CONSTRAINT [FK_Give_drug_Patient]
GO
ALTER TABLE [dbo].[Nurse]  WITH CHECK ADD  CONSTRAINT [FK_Nurse_Ward] FOREIGN KEY([W_id])
REFERENCES [dbo].[Ward] ([Id])
GO
ALTER TABLE [dbo].[Nurse] CHECK CONSTRAINT [FK_Nurse_Ward]
GO
ALTER TABLE [dbo].[Nurse_Phone]  WITH CHECK ADD  CONSTRAINT [FK_Nurse_Phone_Nurse] FOREIGN KEY([Nurse_id])
REFERENCES [dbo].[Nurse] ([Id])
GO
ALTER TABLE [dbo].[Nurse_Phone] CHECK CONSTRAINT [FK_Nurse_Phone_Nurse]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Ward] FOREIGN KEY([W_id])
REFERENCES [dbo].[Ward] ([Id])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Ward]
GO
ALTER TABLE [dbo].[Ward]  WITH CHECK ADD  CONSTRAINT [FK_Ward_Nurse] FOREIGN KEY([N_id])
REFERENCES [dbo].[Nurse] ([Id])
GO
ALTER TABLE [dbo].[Ward] CHECK CONSTRAINT [FK_Ward_Nurse]
GO
ALTER TABLE [dbo].[Nurse]  WITH CHECK ADD CHECK  (([gender]=(0) OR [gender]=(1)))
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD CHECK  (([gender]=(0) OR [gender]=(1)))
GO
USE [master]
GO
ALTER DATABASE [Hospital] SET  READ_WRITE 
GO
