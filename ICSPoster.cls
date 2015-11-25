% v4.0 by Erich L Foster 09 August 2013
%%% IDENTIFICATION --------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[01/01/10]
\ProvidesClass{ICSPoster}[09/08/2013 v0.1 Institute for Computational Science Poster Class]
\RequirePackage{etoolbox}

%Declaration of options
\def\@@ptsize{12pt}

\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\DeclareOption{13pt}{\def\@@ptsize{13pt}}

%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
\ExecuteOptions{}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std report class
\LoadClass[\@@ptsize]{article}
% packages needed
\RequirePackage{latexsym,amssymb}
\RequirePackage{xcolor}
\RequirePackage[pdftex]{graphicx}
\RequirePackage{amsmath,amsfonts}
\RequirePackage{multicol}
\RequirePackage{pifont}
\RequirePackage{geometry}
\RequirePackage{enumerate}
\RequirePackage{paralist}
\RequirePackage{algorithmic}
\RequirePackage[plain, nothing]{algorithm}
\RequirePackage{keyval}
\RequirePackage{etoolbox}
\RequirePackage{environ}

% graphics extensions
\DeclareGraphicsExtensions{.jpg,.pdf,.pdftex,.png}

\def\@title{}
\def\@subtitle{}
\def\@author{}
\def\@logo{}

\newbool{@sub}
\boolfalse{@sub}
\def\subtitle#1{\booltrue{@sub} \gdef\@subtitle{#1}}

\newbool{@logo}
\boolfalse{@logo}
\def\logo#1{\booltrue{@logo} \gdef\@logo{#1}}

% parameters-
\setlength{\pdfpageheight}{594mm}
\setlength{\pdfpagewidth}{420mm}
\setlength{\paperheight}{594mm}
\setlength{\paperwidth}{420mm}
\setlength{\voffset}{-.5in}
\setlength{\hoffset}{-1.0in}
\setlength{\evensidemargin}{5mm}
\setlength{\oddsidemargin}{5mm}
\setlength{\topmargin}{0mm}
\setlength{\headheight}{0mm}
\setlength{\headsep}{0mm}
\setlength{\textheight}{624mm}
\setlength{\textwidth}{410mm}
\setlength{\parindent}{0pt}
\setlength{\parskip}{2explus2ex}
\setlength{\fboxsep}{0.01\textwidth}
\setlength{\fboxrule}{0.001\textwidth}
\newlength{\boxwidth}
\setlength{\boxwidth}{0.975\textwidth}
\setlength{\columnsep}{1cm}
\setlength{\columnseprule}{0.1pt}
\setlength{\multicolsep}{0cm}


% font for titel of poster
\newcommand{\titlefont}[1]
{\protect{\fontencoding{T1}\fontfamily{pag}\fontseries{b}%
    \fontshape{n}\fontsize{1.2cm}{1ex}
    \selectfont{#1}}}

\newcommand{\subtitlefont}[1]
{\protect{\fontencoding{T1}\fontfamily{pag}\fontseries{b}%
    \fontshape{n}\fontsize{0.9cm}{1ex}
    \selectfont{#1}}}

% command for page headings
\newcommand{\newpart}[1]{
  \colorbox[rgb]{1.0000, 0.9020, 0.4549}{\makebox[0.97\columnwidth]
  {\rule[-1.2ex]{0pt}{3.7ex}\partfont{#1}}}%\bigskip
}

% font for headings of pages
\newcommand{\partfont}[1]{{\Large \textsf{\textbf{#1}}}}

% define our keys for headerbox and posterbox
\define@key{headerbox}{height}{\def\hb@height{#1}}
\define@key{headerbox}{width}{\def\hb@width{#1}}
\define@key{headerbox}{title}{\def\hb@title{#1}}

\NewEnviron{posterbox}[1][1]{
  \let\pbBODY\BODY
  \fbox{
    \parbox{0.9972\boxwidth}{
      \setlength{\fboxsep}{0.005\textwidth}
      \setlength{\fboxrule}{0.00125\textwidth}

      \raggedcolumns
      \ifnum#1<2\relax
        \pbBODY
      \else
        \begin{multicols*}{#1}
          \pbBODY
        \end{multicols*}
      \fi
    }
  }
}

\NewEnviron{headerbox}[1][]{
  \setkeys{headerbox}{title=,height=\textheight,width=\textwidth,#1}
  \newpart{\hb@title}
  \vbox to \hb@height {%
    \vspace{.5em}
    \sf
    \begin{minipage}{\hb@width}\sf
      \BODY
    \end{minipage}
    \vfill\eject% \break
    \break
  } % end vbox
}

%setup title page, abstract page, dedication page, and acknowledgement page
\def\maketitle{%
  \pagestyle{empty}

  \fbox{
    \parbox{0.9972\boxwidth}{
      \hspace*{-.3cm}
      \begin{minipage}{0.42\textwidth}
        \ifbool{@logo}{
          \includegraphics[width=\textwidth]{\@logo}
        }{
          \includegraphics[width=\textwidth]{USI-ICS.jpg}
        }
      \end{minipage}
      \hspace*{0.07\textwidth}
      \begin{minipage}{0.43\textwidth}
        \ifbool{@sub}{
          \titlefont{\@title}\\[0.7cm]
          \subtitlefont{\@subtitle}
        }{
          \titlefont{\@title}
        }
      \end{minipage}
    }
  }
}
