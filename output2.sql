USE [master]
GO
/****** Object:  Database [elecciones_db]    Script Date: 6/10/19 7:06:00 PM ******/
CREATE DATABASE [elecciones_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'elecciones_db', FILENAME = N'/var/opt/mssql/data/elecciones_db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'elecciones_db_log', FILENAME = N'/var/opt/mssql/data/elecciones_db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [elecciones_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [elecciones_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [elecciones_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [elecciones_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [elecciones_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [elecciones_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [elecciones_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [elecciones_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [elecciones_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [elecciones_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [elecciones_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [elecciones_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [elecciones_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [elecciones_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [elecciones_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [elecciones_db] SET  ENABLE_BROKER 
GO
ALTER DATABASE [elecciones_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [elecciones_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [elecciones_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [elecciones_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [elecciones_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [elecciones_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [elecciones_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [elecciones_db] SET RECOVERY FULL 
GO
ALTER DATABASE [elecciones_db] SET  MULTI_USER 
GO
ALTER DATABASE [elecciones_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [elecciones_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [elecciones_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [elecciones_db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [elecciones_db] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'elecciones_db', N'ON'
GO
ALTER DATABASE [elecciones_db] SET QUERY_STORE = OFF
GO
USE [elecciones_db]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [elecciones_db]
GO
/****** Object:  User [kernel]    Script Date: 6/10/19 7:06:11 PM ******/
CREATE USER [kernel] FOR LOGIN [kernel] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [kernel]
GO
/****** Object:  Table [dbo].[candidato]    Script Date: 6/10/19 7:06:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidato](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idcategoria] [int] NOT NULL,
	[nombre] [varchar](40) NOT NULL,
	[urlimagen] [varchar](200) NULL,
	[color] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 6/10/19 7:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoria](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[circuito]    Script Date: 6/10/19 7:06:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[circuito](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mesa]    Script Date: 6/10/19 7:06:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mesa](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](40) NOT NULL,
	[idpuntomuestral] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mesa_candidato]    Script Date: 6/10/19 7:06:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mesa_candidato](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idmesa] [int] NOT NULL,
	[idcandidato] [int] NOT NULL,
	[cantidadvotos] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[punto_muestral]    Script Date: 6/10/19 7:06:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[punto_muestral](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[comportamiento] [varchar](10) NOT NULL,
	[celular] [varchar](30) NOT NULL,
	[peso] [int] NOT NULL,
	[id_circuito] [int] NOT NULL,
	[id_tipo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_punto_muestral]    Script Date: 6/10/19 7:06:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_punto_muestral](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[candidato] ON 

INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (1, 1, N'Bonfatti', N'https://es.wikipedia.org/wiki/Anexo:Elecciones_en_la_provincia_de_Santa_Fe_de_2019#/media/Archivo:Antonio_Bonfatti_2019.png', N'#F6E3CE')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (2, 1, N'Perotti', N'https://es.wikipedia.org/wiki/Anexo:Elecciones_en_la_provincia_de_Santa_Fe_de_2019#/media/Archivo:Omar_Perotti_2019.png', N'#CEECF5')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (3, 1, N'Corral', N'https://es.wikipedia.org/wiki/Anexo:Elecciones_en_la_provincia_de_Santa_Fe_de_2019#/media/Archivo:Jos%C3%A9_Manuel_Corral_2019.png', N'#F5F6CE')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (4, 2, N'Fein', NULL, N'#FE9A2E')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (5, 2, N'Lewandowski', NULL, N'#2E9AFE')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (6, 2, N'Rosua', NULL, N'#FFFF00')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (7, 1, N'Total Votos', NULL, N'#F2F2F2')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (8, 2, N'Total Votos', NULL, N'#BDBDBD')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (9, 3, N'Total Votos', NULL, N'#BDBDBD')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (10, 3, N'Javkin', NULL, N'#FE9A2E')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (11, 3, N'Sukerman', NULL, N'#2E9AFE')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (12, 3, N'Lopez Molina', NULL, N'#FFFF00')
INSERT [dbo].[candidato] ([id], [idcategoria], [nombre], [urlimagen], [color]) VALUES (13, 3, N'Moneteverde', NULL, N'#298A08')
SET IDENTITY_INSERT [dbo].[candidato] OFF
SET IDENTITY_INSERT [dbo].[categoria] ON 

INSERT [dbo].[categoria] ([id], [descripcion]) VALUES (1, N'Gobernador')
INSERT [dbo].[categoria] ([id], [descripcion]) VALUES (2, N'Senador')
INSERT [dbo].[categoria] ([id], [descripcion]) VALUES (3, N'Intendente')
SET IDENTITY_INSERT [dbo].[categoria] OFF
SET IDENTITY_INSERT [dbo].[circuito] ON 

INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (1, N'test')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (2, N'402')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (3, N'403')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (4, N'404A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (5, N'368A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (6, N'370')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (7, N'375')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (8, N'128A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (9, N'118')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (10, N'128C')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (11, N'128D')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (12, N'384')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (13, N'377A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (14, N'384A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (15, N'106')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (16, N'399')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (17, N'399A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (18, N'390A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (19, N'394')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (20, N'399B')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (21, N'400')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (22, N'225')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (23, N'224E')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (24, N'224')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (25, N'232')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (26, N'221')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (27, N'408')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (28, N'413A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (29, N'410')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (30, N'16')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (31, N'32')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (32, N'19')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (33, N'14')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (34, N'15')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (35, N'13')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (36, N'17')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (37, N'7')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (38, N'10')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (39, N'11A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (40, N'35')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (41, N'12')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (42, N'9')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (43, N'11')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (44, N'36')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (45, N'8')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (46, N'20A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (47, N'20')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (48, N'23')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (49, N'33')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (50, N'27')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (51, N'20B')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (52, N'22')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (53, N'55-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (54, N'55-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (55, N'44')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (56, N'52')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (57, N'285')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (58, N'291')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (59, N'329')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (60, N'334')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (61, N'333')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (62, N'340')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (63, N'323')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (64, N'330')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (65, N'302')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (66, N'328')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (67, N'307')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (68, N'316')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (69, N'327')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (70, N'331')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (71, N'320')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (72, N'318')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (73, N'301')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (74, N'347-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (75, N'347-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (76, N'347-3')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (77, N'348-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (78, N'348-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (79, N'349A-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (80, N'349A-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (81, N'359-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (82, N'359-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (83, N'353A-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (84, N'353A-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (85, N'359A-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (86, N'359A-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (87, N'342-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (88, N'342-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (89, N'353-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (90, N'353-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (91, N'349-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (92, N'349-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (93, N'349B')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (94, N'344A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (95, N'347A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (96, N'354')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (97, N'342A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (98, N'344')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (99, N'358')
GO
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (100, N'342B')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (101, N'354A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (102, N'349C')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (103, N'355')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (104, N'362A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (106, N'352')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (107, N'345')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (110, N'345')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (111, N'362F')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (112, N'356')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (113, N'356A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (114, N'362D')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (115, N'343')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (116, N'178')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (117, N'185')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (118, N'188')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (119, N'275')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (120, N'277')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (121, N'83')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (122, N'79')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (123, N'89')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (124, N'93')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (125, N'210-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (126, N'210-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (127, N'425A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (128, N'420A')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (129, N'423')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (130, N'421')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (131, N'416')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (132, N'420')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (133, N'158')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (134, N'165')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (135, N'160')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (136, N'254-1')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (137, N'254-2')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (138, N'251')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (139, N'252')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (140, N'371')
INSERT [dbo].[circuito] ([id], [descripcion]) VALUES (141, N'321')
SET IDENTITY_INSERT [dbo].[circuito] OFF
SET IDENTITY_INSERT [dbo].[mesa] ON 

INSERT [dbo].[mesa] ([id], [descripcion], [idpuntomuestral]) VALUES (1, N'17', 1)
INSERT [dbo].[mesa] ([id], [descripcion], [idpuntomuestral]) VALUES (2, N'18', 1)
INSERT [dbo].[mesa] ([id], [descripcion], [idpuntomuestral]) VALUES (3, N'19', 1)
INSERT [dbo].[mesa] ([id], [descripcion], [idpuntomuestral]) VALUES (4, N'20', 1)
INSERT [dbo].[mesa] ([id], [descripcion], [idpuntomuestral]) VALUES (5, N'21', 1)
INSERT [dbo].[mesa] ([id], [descripcion], [idpuntomuestral]) VALUES (6, N'22', 1)
INSERT [dbo].[mesa] ([id], [descripcion], [idpuntomuestral]) VALUES (7, N'23', 1)
INSERT [dbo].[mesa] ([id], [descripcion], [idpuntomuestral]) VALUES (8, N'24', 1)
SET IDENTITY_INSERT [dbo].[mesa] OFF
SET IDENTITY_INSERT [dbo].[mesa_candidato] ON 

INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (30, 1, 1, 51)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (31, 1, 2, 88)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (32, 1, 3, 99)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (33, 1, 7, 300)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (34, 4, 1, 78)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (35, 4, 2, 99)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (36, 4, 3, 12)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (37, 4, 7, 278)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (38, 7, 4, 46)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (39, 7, 6, 77)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (40, 7, 8, 998)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (41, 7, 5, 66)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (42, 7, 9, 518)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (43, 7, 10, 516)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (44, 7, 11, 728)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (45, 7, 12, 81)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (46, 7, 13, 8181)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (47, 1, 4, 20)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (48, 1, 5, 50)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (49, 1, 6, 23)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (50, 1, 8, 90)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (51, 4, 4, 51)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (52, 4, 5, 51)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (53, 4, 6, 51)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (54, 4, 8, 200)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (55, 8, 1, 54)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (56, 8, 2, 15)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (57, 8, 3, 16)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (58, 8, 7, 400)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (59, 6, 1, 54)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (60, 6, 2, 15)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (61, 6, 7, 400)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (62, 6, 3, 65)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (63, 7, 1, 10)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (64, 7, 2, 20)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (65, 7, 3, 300)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (67, 5, 1, 20)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (68, 5, 2, 10)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (69, 5, 3, 300)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (70, 5, 7, 200)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (71, 4, 9, 200)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (72, 4, 10, 20)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (73, 4, 11, 30)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (74, 4, 12, 300)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (75, 4, 13, 10)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (76, 4, 9, 200)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (77, 4, 10, 20)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (78, 4, 12, 300)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (79, 4, 11, 10)
INSERT [dbo].[mesa_candidato] ([id], [idmesa], [idcandidato], [cantidadvotos]) VALUES (80, 4, 13, 10)
SET IDENTITY_INSERT [dbo].[mesa_candidato] OFF
SET IDENTITY_INSERT [dbo].[punto_muestral] ON 

INSERT [dbo].[punto_muestral] ([id], [comportamiento], [celular], [peso], [id_circuito], [id_tipo]) VALUES (1, N'B', N'1', 19000, 2, 1)
INSERT [dbo].[punto_muestral] ([id], [comportamiento], [celular], [peso], [id_circuito], [id_tipo]) VALUES (2, N'B', N'2', 11500, 3, 1)
INSERT [dbo].[punto_muestral] ([id], [comportamiento], [celular], [peso], [id_circuito], [id_tipo]) VALUES (3, N'B', N'3', 7800, 4, 1)
INSERT [dbo].[punto_muestral] ([id], [comportamiento], [celular], [peso], [id_circuito], [id_tipo]) VALUES (4, N'B', N'4', 14600, 5, 1)
INSERT [dbo].[punto_muestral] ([id], [comportamiento], [celular], [peso], [id_circuito], [id_tipo]) VALUES (5, N'B', N'5', 950, 6, 1)
INSERT [dbo].[punto_muestral] ([id], [comportamiento], [celular], [peso], [id_circuito], [id_tipo]) VALUES (6, N'B', N'6', 1500, 7, 2)
SET IDENTITY_INSERT [dbo].[punto_muestral] OFF
SET IDENTITY_INSERT [dbo].[tipo_punto_muestral] ON 

INSERT [dbo].[tipo_punto_muestral] ([id], [descripcion]) VALUES (1, N'Tomador Datos')
INSERT [dbo].[tipo_punto_muestral] ([id], [descripcion]) VALUES (2, N'Candidato')
SET IDENTITY_INSERT [dbo].[tipo_punto_muestral] OFF
ALTER TABLE [dbo].[candidato] ADD  DEFAULT ('#000') FOR [color]
GO
ALTER TABLE [dbo].[punto_muestral] ADD  DEFAULT ((1)) FOR [id_circuito]
GO
ALTER TABLE [dbo].[punto_muestral] ADD  DEFAULT ((1)) FOR [id_tipo]
GO
ALTER TABLE [dbo].[candidato]  WITH CHECK ADD FOREIGN KEY([idcategoria])
REFERENCES [dbo].[categoria] ([id])
GO
ALTER TABLE [dbo].[mesa]  WITH CHECK ADD FOREIGN KEY([idpuntomuestral])
REFERENCES [dbo].[punto_muestral] ([id])
GO
ALTER TABLE [dbo].[mesa_candidato]  WITH CHECK ADD FOREIGN KEY([idcandidato])
REFERENCES [dbo].[candidato] ([id])
GO
ALTER TABLE [dbo].[mesa_candidato]  WITH CHECK ADD FOREIGN KEY([idmesa])
REFERENCES [dbo].[mesa] ([id])
GO
ALTER TABLE [dbo].[punto_muestral]  WITH CHECK ADD FOREIGN KEY([id_circuito])
REFERENCES [dbo].[circuito] ([id])
GO
ALTER TABLE [dbo].[punto_muestral]  WITH CHECK ADD FOREIGN KEY([id_tipo])
REFERENCES [dbo].[tipo_punto_muestral] ([id])
GO
USE [master]
GO
ALTER DATABASE [elecciones_db] SET  READ_WRITE 
GO
