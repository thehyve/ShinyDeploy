%%%
%% ping.cls
%%   based on pnas-new.cls and supporting material from
%%   http://www.pnas.org/site/authors/latex.xhtml
%%   as well as local changes
%%
%% Dirk Eddelbuettel and James Balamuta
%% August - September 2017
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pnas-new.cls, v1.2, 2016/02/28
%
% This class file enables authors to prepare research
% articles for submission to PNAS.
%
% Please note that whilst this template provides a
% preview of the typeset manuscript for submission, it
% will not necessarily be the final publication layout.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either
% version 1.3 of this license or any later version.
% The latest version of this license is in
% http://www.latex-project.org/lppl.txt and
% version 1.3 or later is part of all distributions
% of LaTeX version 2005/12/01 or later.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% For use with latex+dvipdfm, pdflatex, xelatex & lualatex
% For compiling with plain latex, please use latex+dvipdfm
% to produce the PDF, not dvis -> ps -> pdf nor dvipdf
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pnas-new}[28/02/2015, v1.2]
\AtEndOfClass{\RequirePackage{microtype}}
% Option for line numbers
\newif\if@pnaslineno
\DeclareOption{lineno}{\@pnaslinenotrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions*
\LoadClass{extarticle}

%% Fonts and language
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage{lmodern}
\RequirePackage[scaled]{helvet}
\RequirePackage[T1]{fontenc}
\RequirePackage{lettrine} % For dropped capitals

%% For the Significance Statement & footnote on the first page
\RequirePackage{afterpage}
\RequirePackage{ifpdf,ifxetex}
\ifpdf\else
  \ifxetex\else
    \def\pgfsysdriver{pgfsys-dvipdfm.def}
    \pdfpagewidth=\paperwidth
    \pdfpageheight=\paperheight
\fi\fi
\RequirePackage[table]{xcolor}
\RequirePackage{tikz}
\RequirePackage[framemethod=tikz]{mdframed}

%% For single column equations and balancing the columns on final page
%\RequirePackage{widetext}
%% BEGIN
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{widetext}

%% Mimics the widetext environment of revtex4 for any other class package
%% Eg: article.cls
%%
%% Compiled by: Anjishnu Sarkar
%%
%% Advantages:
%% *) Supports float (eg: figure) in two column format (Advantage over
%%      multicol package)
%% *) One and twocolumn exist on the same page
%% *) Flow of text shown via rule
%% *) Equal height of text when in two column format
%%
%% Acknowledgment(s):
%% 1. Instead of re-inventing the wheel, two packages (flushend, cuted) of
%% the sttools bundle are used. The sttools bundle is available from CTAN.
%% Lisence of these packages rests with their corresponding author.
%% Any bug/problem with flushend and cuted should be forwarded to their
%% corresponding package authors.
%% 2. The idea of the rule came from the following latex community website
%% http://www.latex-community.org/forum/viewtopic.php?f=5&t=2770
%%
%% This package just defines the widetext environment and the rules.
%%
%% Usage:
%% \documentclass[a4paper,12pt,twocolumn]{article}
%% \usepackage{widetext}
%%
%% \begin{document}
%%
%% Some text in twocolumn
%%
%% \begin{widetext}
%% Text in onecolumn format.
%% \end{widetext}
%%
%% Some more text in twocolumn
%%
%% \end{document}
%%%%%%%%%%%%%%%%%%%%

%% Package required for equal height while in 2 columns format
\IfFileExists{flushend.sty}
    {\RequirePackage{flushend}}
    {\typeout{}
    \typeout{Package widetext error: Install the flushend package which is
    a part of sttools bundle. Available from CTAN.}
    \typeout{}
    \stop
    }

%% Package required for onecolumn and twocolumn to exist on the same page.
%% and also required for widetext environment.
\IfFileExists{cuted.sty}
    {\RequirePackage{cuted}}
    {\typeout{}
    \typeout{Package widetext error: Install the cuted package which is
    a part of sttools bundle. Available from CTAN.}
    \typeout{}
    \stop
    }


\newlength\@parindent
\setlength\@parindent{\parindent}

\if@twocolumn
    \newenvironment{widetext}
        {%
            \begin{strip}
            \rule{\dimexpr(0.5\textwidth-0.5\columnsep-0.4pt)}{0.4pt}%
            \rule{0.4pt}{6pt}
            \par %\vspace{6pt}
            \parindent \@parindent
        }%
        {%
            \par
            \hfill\rule[-6pt]{0.4pt}{6.4pt}%
            \rule{\dimexpr(0.5\textwidth-0.5\columnsep-1pt)}{0.4pt}
            \end{strip}
        }
\else
    \newenvironment{widetext}{}{}
\fi
%% END

%% Hyperlinking
% from below
%\definecolor{pnasbluetext}{RGB}{0,101,165} %
%\definecolor{pnasblueback}{RGB}{205,217,235} %
\RequirePackage[colorlinks=true, allcolors=pnasbluetext]{hyperref}

%% Set up main title page fonts
\newcommand{\headerfont}{\normalfont\sffamily\fontsize{7}{9} \selectfont}
\newcommand{\footerfont}{\normalfont\sffamily\fontsize{7}{9} \selectfont}
\newcommand{\titlefont}{\fontfamily{lmss}\bfseries\fontsize{22pt}{24pt}\selectfont}
\newcommand{\dropcapfont}{\fontfamily{lmss}\bfseries\fontsize{26pt}{28pt}\selectfont}
\newcommand{\datesfont}{\normalfont\sffamily\fontsize{7}{8}\selectfont}
\newcommand{\absfont}{\normalfont\sffamily\bfseries\fontsize{8}{11}\selectfont}
\newcommand{\keywordsfont}{\normalfont\rmfamily\fontsize{7}{10}\selectfont}
\newcommand{\copyrightfont}{\normalfont\rmfamily\fontsize{6}{8}\selectfont}

%% Set URL link color & font
\renewcommand\UrlFont{\color{pnasbluetext}\sffamily}

%% Author and affiliation
\RequirePackage{authblk}
\setlength{\affilsep}{8.5pt} % 16.5pts between base of author line and base of affil line
\renewcommand\Authfont{\color{color0}\normalfont\sffamily\bfseries\fontsize{9}{11}\selectfont}
\renewcommand\Affilfont{\color{color0}\normalfont\sffamily\fontsize{7}{8}\selectfont}
\makeatletter
\renewcommand\AB@affilsepx{; \protect\Affilfont}
\makeatother
\renewcommand\Authands{, and }

%% Options for element switching
\RequirePackage{xifthen}
\newboolean{shortarticle}
\newboolean{singlecolumn}

%% For numbering just one line of an equation
\newcommand\numberthis{\addtocounter{equation}{1}\tag{\theequation}}

%% Watermark
% See: http://mirrors.ctan.org/macros/latex/contrib/xwatermark/doc/xwatermark-guide.pdf#page=3
\RequirePackage[printwatermark]{xwatermark}
\newwatermark[allpages,color=gray!20,angle=45,scale=3,xpos=0,ypos=0]{DRAFT}

\RequirePackage{textcomp} % For copyright symbol styling

%% Graphics, tables and other formatting
\RequirePackage{graphicx}
\RequirePackage{colortbl}
\RequirePackage{booktabs}
\RequirePackage{algorithm}
\RequirePackage[noend]{algpseudocode}
\RequirePackage{changepage}
\RequirePackage[twoside,%
				includeheadfoot,
                left=38.5pt,%
                right=43pt,%
                top=43pt,% 10pt provided by headsep
                bottom=32pt,%
                headheight=0pt,% No Header
                headsep=10pt,%
                footskip=25pt]{geometry}
\RequirePackage[labelfont={bf,sf},%
                labelsep=period,%
                figurename=Fig.]{caption}
\setlength{\columnsep}{13.5pt} % Distance between the two columns of text
\setlength{\parindent}{12pt} % Paragraph indent

%% Set document color scheme
\definecolor{black50}{gray}{0.5} % 50% black for hrules
\definecolor{color0}{RGB}{0,0,0} % Base
\definecolor{color1}{RGB}{59,90,198} % author email, doi
%\definecolor{color2}{RGB}{16,131,16} %
% For sig statement box
% already define above
%\definecolor{pnasbluetext}{RGB}{0,101,165} %
%\definecolor{pnasblueback}{RGB}{205,217,235} %

%% Bibliography
\RequirePackage{natbib}
\setlength{\bibsep}{0.0pt}
%\bibliographystyle{pnas2011}
%\renewcommand{\bibsection}{} % Remove header
\renewcommand\bibfont{\normalfont\sffamily\fontsize{8}{10}\selectfont} % set font to be sans serif

%% Figure caption style
\DeclareCaptionFormat{pnasformat}{\normalfont\sffamily\fontsize{7}{9}\selectfont#1#2#3}
\captionsetup{format=pnasformat}

%% Table style
\RequirePackage{etoolbox}
\captionsetup[table]{labelfont+={small},textfont+={small,sf,bf},skip=10pt,position=above}
% booktabs provide nice spacing, but rule widths and distances need fixing
\setlength{\heavyrulewidth}{0.5pt}
\setlength{\lightrulewidth}{0.5pt}
\setlength{\aboverulesep}{1.5pt}
\setlength{\belowrulesep}{1.5pt}
\setlength{\belowbottomsep}{10pt}
\AtBeginEnvironment{tabular}{
\sffamily\fontsize{7.5}{10}\selectfont
}
\newcommand{\addtabletext}[1]{{\setlength{\leftskip}{9pt}\fontsize{7}{9}\selectfont#1}}

%% Headers and footers
\RequirePackage{fancyhdr}  % custom headers/footers
\RequirePackage{lastpage}  % Number of pages in the document
\pagestyle{fancy}          % Enables the custom headers/footers

% Add name footer option
\def\pinpfootercontents#1{\def\@pinpfootercontents{#1}}
\pinpfootercontents{Package Vignette}
\newcommand{\printpinpfootercontents}{\@pinpfootercontents}

%% For the line numbers overlay
\def\leftlinenos{%
  \pgfmathtruncatemacro{\leftstartlineno}{2*(\thepage - 1)*62 + 1}%
  \pgfmathtruncatemacro{\leftendlineno}{(2*(\thepage - 1) + 1)*62}%
  \foreach \x in {\leftstartlineno,...,\leftendlineno}{\noindent\x\\}%
}
\def\rightlinenos{%
  \pgfmathtruncatemacro{\rightstartlineno}{(2*(\thepage - 1) + 1)*62 + 1}%
  \pgfmathtruncatemacro{\rightendlineno}{(2*\thepage)*62}%
  \foreach \x in {\rightstartlineno,...,\rightendlineno}{\noindent\x\\}%
}


\makeatletter
\fancypagestyle{firststyle}{
   \fancyfoot[R]{\footerfont \printpinpfootercontents\hspace{7pt}|\hspace{7pt}\textbf{\today}\hspace{7pt}|\hspace{7pt}\textbf{\thepage\textendash\pageref{LastPage}}}
   \fancyfoot[L]{\footerfont\@ifundefined{@doi}{}{\@doi}}
}
\makeatother

% Headers
\fancyhead[LE,RO]{}
\fancyhead[LO,RE]{}
% Footers
\lfoot{}%
\cfoot{}%
\rfoot{}%
\makeatletter
\fancyfoot[LE]{\footerfont\textbf{\thepage}\hspace{7pt}|\hspace{7pt}\@ifundefined{@doi}{}{\@doi}}
\fancyfoot[RO]{\footerfont \printpinpfootercontents\hspace{7pt}|\hspace{7pt}\textbf{\today}\hspace{7pt}|\hspace{7pt}\textbf{\thepage}}
\fancyfoot[RE,LO]{\footerfont\@ifundefined{@leadauthor}{}{\@leadauthor}}

% Use footer routine for line numbers
\AtBeginDocument{
  \if@pnaslineno
    \ifthenelse{\boolean{singlecolumn}}{
      % use lineno package if singlecolumn
      \RequirePackage{lineno}
      \linenumbers
    }{% use tikz if twocolumn
    \fancyfoot[C]{\begin{tikzpicture}[remember picture,overlay]
    \node at([xshift=1.5em,yshift=\dimexpr -0.0625in-53pt] current page.north west)[anchor=north west,text width=3em,font=\rmfamily,align=right] {\leftlinenos};%
    \node at([xshift=-1.5em,yshift=\dimexpr -0.0625in-53pt] current page.north east)[anchor=north east,text width=3em,font=\rmfamily,align=left] {\rightlinenos};%
    \end{tikzpicture}}
    }
  \fi
}
\makeatother

\renewcommand{\headrulewidth}{0pt}% % No header rule
\renewcommand{\footrulewidth}{0pt}% % No footer rule

%% Section/subsection/paragraph set-up
\RequirePackage[explicit]{titlesec}
%% \renewcommand{\thesubsection}{\Alph{subsection}}

\titleformat{\section}
  {\large\sffamily\bfseries}
  {\thesection.}
  {0.5em}
  {#1}
  []
\titleformat{name=\section,numberless}
  {\large\sffamily\bfseries}
  {}
  {0em}
  {#1}
  []
\titleformat{\subsection}[runin]
  {\sffamily\bfseries}
  {\thesubsection.}
  {0.5em}
  {#1. }
  []
\titleformat{\subsubsection}[runin]
  {\sffamily\small\bfseries\itshape}
  {\thesubsubsection.}
  {0.5em}
  {#1. }
  []
\titleformat{\paragraph}[runin]
  {\sffamily\small\bfseries}
  {}
  {0em}
  {#1}
\titlespacing*{\section}{0pc}{3ex \@plus4pt \@minus3pt}{5pt}
\titlespacing*{\subsection}{0pc}{2.5ex \@plus3pt \@minus2pt}{2pt}
\titlespacing*{\subsubsection}{0pc}{2ex \@plus2.5pt \@minus1.5pt}{2pt}
\titlespacing*{\paragraph}{0pc}{1.5ex \@plus2pt \@minus1pt}{12pt}

%% Article meta data additional fields
\newcommand{\additionalelement}[1]{\def\@additionalelement{#1}}
\newcommand{\dates}[1]{\def\@dates{#1}}
\newcommand{\doi}[1]{\def\@doi{#1}}
\newcommand{\leadauthor}[1]{\def\@leadauthor{#1}}
\newcommand{\etal}[1]{\def\@etal{#1}}
\newcommand{\keywords}[1]{\def\@keywords{#1}}
\newcommand{\authorcontributions}[1]{\def\@authorcontributions{#1}}
\newcommand{\authordeclaration}[1]{\def\@authordeclaration{#1}}
\newcommand{\equalauthors}[1]{\def\@equalauthors{#1}}
\newcommand{\correspondingauthor}[1]{\def\@correspondingauthor{#1}}
\newcommand{\significancestatement}[1]{\def\@significancestatement{#1}}
\newcommand{\matmethods}[1]{\def\@matmethods{#1}}
\newcommand{\acknow}[1]{\def\@acknow{#1}}

%% Dropped capital for first letter of main text
\newcommand{\dropcap}[1]{\lettrine[lines=2,lraise=0.05,findent=0.1em, nindent=0em]{{\dropcapfont{#1}}}{}}

%% Abstract formatting
\def\xabstract{abstract}
\long\def\abstract#1\end#2{\def\two{#2}\ifx\two\xabstract
\long\gdef\theabstract{\ignorespaces#1}
\def\go{\end{abstract}}\else
\typeout{^^J^^J PLEASE DO NOT USE ANY \string\begin\space \string\end^^J
COMMANDS WITHIN ABSTRACT^^J^^J}#1\end{#2}
\gdef\theabstract{\vskip12pt BADLY FORMED ABSTRACT: PLEASE DO
NOT USE {\tt\string\begin...\string\end} COMMANDS WITHIN
THE ABSTRACT\vskip12pt}\let\go\relax\fi
\go}

% Define an environment with abstract content and styling
\newcommand{\abscontent}{
\noindent
{%
\parbox{\dimexpr\linewidth}{%
    \vskip3pt%
	\absfont \theabstract
}%
}%
\vskip10pt%
\noindent
{\parbox{\dimexpr\linewidth}{%
{
 \keywordsfont \@ifundefined{@keywords}{}{\@keywords}}%
}}%
\vskip12pt%
}

% Option to format abstract differently for certain layouts (not used)
\newcommand{\abscontentformatted}{
\abscontent
}

%% Manual adjustment to line up main content with line numbers
\newlength\pnas@vertadjust
\newcommand\verticaladjustment[1]{\setlength{\pnas@vertadjust}{#1}}

%% Custom title page
\renewcommand{\@maketitle}{%
{%
\ifthenelse{\boolean{shortarticle}}
{\ifthenelse{\boolean{singlecolumn}}{}{
{\raggedright\baselineskip= 24pt\titlefont \@title\par}%
\vskip10pt% 21pts between base of title and base of author line
{\raggedright \@author\par}
\vskip8pt% 16pts between base of affiliations and base of dates line
{\raggedright \datesfont \@ifundefined{@dates}{}{\@dates}\par}
\vskip12pt%
}}
{% else
%
\vskip10pt%
{\raggedright\baselineskip= 24pt\titlefont \@title\par}%
\vskip10pt% 21pts between base of title and base of author line
{\raggedright \@author\par}
\vskip8pt% 16pts between base of affiliations and base of dates line
{\raggedright \datesfont \@ifundefined{@dates}{}{\@dates}\par}
\vskip12pt
{%
\abscontent
}%
\vskip25pt%
}%
%%%
%\@additionalelement
}%
\vskip\pnas@vertadjust
}%

%% Footnotes set up
\RequirePackage[flushmargin,ragged]{footmisc}
\renewcommand*{\footnotelayout}{\normalfont\sffamily\fontsize{6}{8}\selectfont} % set the footnote font
\renewcommand{\footnoterule}{% Set the footnote hrule style
  \kern -3pt
  {\color{black50} \hrule width 72pt height 0.25pt}
  \kern 2.5pt
}

\definecolor{pinpblue}{HTML}{EB6622}  % imagecolorpicker on blue for new R logo -- 185FAF

%% Set up the acknowledgments field
\titleclass{\acknow@section}{straight}[\part]
\newcounter{acknow@section}
\providecommand*{\toclevel@acknow@section}{0}
% Format is set for research articles by default
\titleformat{\acknow@section}[runin]
   {\sffamily\normalsize\bfseries\color{pinpblue}}
   {}
   {0em}
   {#1.}
   []
\titlespacing{\acknow@section}
	{0pt}
	{3.25ex plus 1ex minus .2ex}
	{1.5ex plus .2ex}
\newcommand{\showacknow}{% Display acknowledgments section
\@ifundefined{@acknow}{}{\acknow@section{Acknowledgments}\@acknow}
}

%% Set up the materials&methods field
\titleclass{\matmethods@section}{straight}[\part]
\newcounter{matmethods@section}
\providecommand*{\toclevel@matmethods@section}{0}
% Format is set for research articles by default
\titleformat{\matmethods@section}
   {\sffamily\normalsize\bfseries}
   {}
   {0em}
   {#1}
   []
\titlespacing{\matmethods@section}
	{0pt}
	{3.25ex plus 1ex minus .2ex}
	{1.5ex plus .2ex}
\newcommand{\showmatmethods}{% Display materials&methods section
\@ifundefined{@matmethods}{}{\matmethods@section{Materials and Methods}{\small\noindent\@matmethods}}
}

%% Other packages
\RequirePackage{enumitem} % For reducing bullet list item separation

% Taken from RJournal styling
\makeatletter
\DeclareRobustCommand\code{\bgroup\@noligs\@codex}
\def\@codex#1{\texorpdfstring%
{{\normalfont\ttfamily\hyphenchar\font=-1 #1}}%
{#1}\egroup}
\makeatother

\usepackage{fancyvrb}
\newcommand{\VerbBar}{|}
\newcommand{\VERB}{\Verb[commandchars=\\\{\}]}
\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\{\}}

%% using mdframed (loaded above) for shaded box around code
\global\mdfdefinestyle{codebox}{%
  linecolor=gray!70,
  linewidth=0.5pt,
  backgroundcolor=gray!05,
  innerleftmargin=2pt,
  innerrightmargin=2pt}
\newenvironment{Shaded}{\begin{mdframed}[style=codebox]}{\end{mdframed}}
\global\mdfdefinestyle{resultbox}{%
  linecolor=gray!50,
  linewidth=0.5pt,
  backgroundcolor=gray!02,
  innerleftmargin=2pt,
  innerrightmargin=2pt}
\newenvironment{ShadedResult}{\begin{mdframed}[style=resultbox]}{\end{mdframed}}
\newcommand{\KeywordTok}[1]{\textcolor[rgb]{0.13,0.29,0.53}{\textbf{#1}}}
\newcommand{\DataTypeTok}[1]{\textcolor[rgb]{0.13,0.29,0.53}{#1}}
\newcommand{\DecValTok}[1]{\textcolor[rgb]{0.00,0.00,0.81}{#1}}
\newcommand{\BaseNTok}[1]{\textcolor[rgb]{0.00,0.00,0.81}{#1}}
\newcommand{\FloatTok}[1]{\textcolor[rgb]{0.00,0.00,0.81}{#1}}
\newcommand{\ConstantTok}[1]{\textcolor[rgb]{0.00,0.00,0.00}{#1}}
\newcommand{\CharTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{#1}}
\newcommand{\SpecialCharTok}[1]{\textcolor[rgb]{0.00,0.00,0.00}{#1}}
\newcommand{\StringTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{#1}}
\newcommand{\VerbatimStringTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{#1}}
\newcommand{\SpecialStringTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{#1}}
\newcommand{\ImportTok}[1]{#1}
\newcommand{\CommentTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textit{#1}}}
\newcommand{\DocumentationTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{#1}}}}
\newcommand{\AnnotationTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{#1}}}}
\newcommand{\CommentVarTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{#1}}}}
\newcommand{\OtherTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{#1}}
\newcommand{\FunctionTok}[1]{\textcolor[rgb]{0.00,0.00,0.00}{#1}}
\newcommand{\VariableTok}[1]{\textcolor[rgb]{0.00,0.00,0.00}{#1}}
\newcommand{\ControlFlowTok}[1]{\textcolor[rgb]{0.13,0.29,0.53}{\textbf{#1}}}
\newcommand{\OperatorTok}[1]{\textcolor[rgb]{0.81,0.36,0.00}{\textbf{#1}}}
\newcommand{\BuiltInTok}[1]{#1}
\newcommand{\ExtensionTok}[1]{#1}
\newcommand{\PreprocessorTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textit{#1}}}
\newcommand{\AttributeTok}[1]{\textcolor[rgb]{0.77,0.63,0.00}{#1}}
\newcommand{\RegionMarkerTok}[1]{#1}
\newcommand{\InformationTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{#1}}}}
\newcommand{\WarningTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{#1}}}}
\newcommand{\AlertTok}[1]{\textcolor[rgb]{0.94,0.16,0.16}{#1}}
\newcommand{\ErrorTok}[1]{\textcolor[rgb]{0.64,0.00,0.00}{\textbf{#1}}}
\newcommand{\NormalTok}[1]{#1}

\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}


%\RequirePackage{pnasresearcharticle}
%%% BEGIN pnasresearcharticle
%%% PNAS two column research article  style file
%%% For use with pnas-new.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{pnasresearcharticle}[2016/02/28 v1.2 PNAS two column research article style]

%% Set whether the abstract is set into the first column
\setboolean{shortarticle}{true}
% true = set into first column
% false = spans page width

%% Set up the first page footnote/fact box here
\RequirePackage{float}
\floatstyle{plain}
\newfloat{sigstatement}{b!}{sst}

\additionalelement{%
\afterpage{\begin{sigstatement}
\sffamily
\mdfdefinestyle{pnassigstyle}{linewidth=0.7pt,backgroundcolor=pnasblueback,linecolor=pnasbluetext,fontcolor=pnasbluetext,innertopmargin=6pt,innerrightmargin=6pt,innerbottommargin=6pt,innerleftmargin=6pt}
\@ifundefined{@significancestatement}{}{%
	\begin{mdframed}[style=pnassigstyle]%
	\section*{Significance Statement}%
	\@significancestatement
	\end{mdframed}}
%     \medskip
\scriptsize
\@ifundefined{@authorcontributions}{}{\@authorcontributions}
\vskip5pt%
\@ifundefined{@authordeclaration}{}{\@authordeclaration}
\vskip5pt%
\@ifundefined{@equalauthors}{}{\@equalauthors}
\vskip5pt%
\@ifundefined{@correspondingauthor}{}{\@correspondingauthor}
\end{sigstatement}}
}


%% Break at end of article (before references)
% The blank line before the strip command ensures there is nothing placed
% directly before the break (which can cause formatting issues).
\newcommand{\pnasbreak}{
\begin{strip}
\vskip-11pt
\end{strip}
}

\DefineVerbatimEnvironment{Sinput}{Verbatim}{fontshape=sl}
\DefineVerbatimEnvironment{Soutput}{Verbatim}{}
\DefineVerbatimEnvironment{Scode}{Verbatim}{fontshape=sl}
\newenvironment{Schunk}{}{}
\DefineVerbatimEnvironment{Code}{Verbatim}{}
\DefineVerbatimEnvironment{CodeInput}{Verbatim}{fontshape=sl}
\DefineVerbatimEnvironment{CodeOutput}{Verbatim}{}
\newenvironment{CodeChunk}{}{}

%% Set colors -- now via test and fallback default in template
%\definecolor{pinpblue}{HTML}{185FAF}  % imagecolorpicker on blue for new R logo

\definecolor{pinpblue}{HTML}{EB6622}

% Add colour to the title
\appto{\titlefont}{\color{pinpblue}}

% ...and section headings
\titleformat{\section}
  {\large\sffamily\bfseries\color{pinpblue}}
  {\thesection.}
  {0.5em}
  {#1}
  []
\titleformat{name=\section,numberless}
  {\large\sffamily\bfseries\color{pinpblue}}
  {}
  {0em}
  {#1}
  []
\titleformat{\subsection}[runin]
  {\sffamily\bfseries\color{pinpblue}} %\itshape}%
  {\thesubsection.}
  {0.5em}
  {#1. }
  []
% Other section headings left unchanged.

%% Other packages
\RequirePackage{enumitem} % For reducing bullet list item separation

%% microtype with mathdesign, microtype already loaded
%\usepackage[bitstream-charter]{mathdesign} %% cf http://www.khirevich.com/latex/font/

\endinput

%%% END pnasresearcharticle





