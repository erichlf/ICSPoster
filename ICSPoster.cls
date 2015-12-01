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
\DeclareOption{14pt}{\def\@@ptsize{14pt}}
\DeclareOption{17pt}{\def\@@ptsize{17pt}}
\DeclareOption{20pt}{\def\@@ptsize{20pt}}

%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
\ExecuteOptions{}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std report class
\LoadClass[\@@ptsize]{extarticle}
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
\setlength{\pdfpageheight}{1189mm}
\setlength{\pdfpagewidth}{841mm}
\setlength{\paperheight}{1189mm}
\setlength{\paperwidth}{841mm}
\setlength{\voffset}{-.25in}
\setlength{\hoffset}{-.75in}
\setlength{\evensidemargin}{5mm}
\setlength{\oddsidemargin}{5mm}
\setlength{\topmargin}{0mm}
\setlength{\headheight}{0mm}
\setlength{\headsep}{0mm}
\setlength{\textheight}{1153mm}
\setlength{\textwidth}{821mm}
\setlength{\parindent}{0pt}
\setlength{\parskip}{2explus2ex}
\setlength{\fboxsep}{0.01\textwidth}
\setlength{\fboxrule}{0.001\textwidth}
\newlength{\boxwidth}
\setlength{\boxwidth}{0.975\textwidth}
\setlength{\columnsep}{1cm}
\setlength{\columnseprule}{0.1pt}
\setlength{\multicolsep}{0cm}

% font for title of poster
\newcommand{\titlefont}[1]
{\protect{\fontencoding{T1}\fontfamily{pag}\fontseries{b}%
    \fontshape{n}\fontsize{2.4cm}{1ex}
    \selectfont{#1}}}

\newcommand{\subtitlefont}[1]
{\protect{\fontencoding{T1}\fontfamily{pag}\fontseries{b}%
    \fontshape{n}\fontsize{1.8cm}{1ex}
    \selectfont{#1}}}

\newcommand{\partfont}[1]
{\protect{\fontencoding{T1}\fontfamily{pag}\fontseries{b}%
    \fontshape{n}\fontsize{1.1cm}{1ex}
    \selectfont{#1}}}

% command for page headings
\newcommand{\newpart}[1]{
  \colorbox[rgb]{1.0000, 0.9020, 0.4549}{\makebox[0.97\columnwidth]
  {\rule[-1.2ex]{0pt}{3.7ex}\partfont{#1}}}%\bigskip
}

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
  \vbox to \hb@height {%
    \newpart{\hb@title}\\[0.8em]
    \sf
    \begin{minipage}{\hb@width}\sf
      \BODY
    \end{minipage}
    \vfill\eject
    \break
  } % end vbox
}

%setup title page, abstract page, dedication page, and acknowledgement page
\def\maketitle{%
  \pagestyle{empty}

  \begin{posterbox}
      \begin{minipage}{0.45\textwidth}
        \ifbool{@logo}{
          \includegraphics[width=\textwidth]{\@logo}
        }{
          \includegraphics[width=\textwidth]{USI-ICS.jpg}
        }
      \end{minipage}
      \hspace*{0.07\textwidth}
      \begin{minipage}{0.43\textwidth}
        \ifbool{@sub}{
          \titlefont{\@title}\\[1em]
          \subtitlefont{\@subtitle}[1em]
          \@author
        }{
          \titlefont{\@title}\\[1em]
          \@author
        }
      \end{minipage}
  \end{posterbox}
}
