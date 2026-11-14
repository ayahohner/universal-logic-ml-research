%% ulpaper.cls -- general-purpose class for research papers.
%%
%% Two layouts that follow the conventions of current ML venues:
%%   twocolumn (default)  ICML-like: 6.75in x 9in text, 0.25in gutter
%%   onecolumn            NeurIPS-like: 5.5in x 9in text
%% Both use 10pt Times on 11pt leading, no paragraph indent with 6pt
%% paragraph skip, title between rules, a running head, author-year
%% citations, and table captions above tables. No page limit is imposed.
%%
%% Options:
%%   twocolumn | onecolumn   layout (default twocolumn)
%%   letterpaper | a4paper   paper size (default letterpaper)
%%   review                  line numbers for drafts sent to reviewers
%%   numbers                 numeric citations [1] instead of author-year
%%   nocolorlinks            black hyperlinks (for print)
%%
%% Builds with pdfLaTeX (arXiv) and with Tectonic/XeTeX.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ulpaper}[2026/11/14 v1.0 Research paper class]

%-----------------------------------------------------------------------------
% Options
%-----------------------------------------------------------------------------
\newif\ifulp@twocol   \ulp@twocoltrue
\newif\ifulp@afour    \ulp@afourfalse
\newif\ifulp@review   \ulp@reviewfalse
\newif\ifulp@numbers  \ulp@numbersfalse
\newif\ifulp@color    \ulp@colortrue
\DeclareOption{twocolumn}{\ulp@twocoltrue}
\DeclareOption{onecolumn}{\ulp@twocolfalse}
\DeclareOption{letterpaper}{\ulp@afourfalse}
\DeclareOption{a4paper}{\ulp@afourtrue}
\DeclareOption{review}{\ulp@reviewtrue}
\DeclareOption{numbers}{\ulp@numberstrue}
\DeclareOption{nocolorlinks}{\ulp@colorfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\ifulp@twocol
  \LoadClass[10pt,twocolumn]{article}
\else
  \LoadClass[10pt]{article}
\fi

%-----------------------------------------------------------------------------
% Page geometry
%-----------------------------------------------------------------------------
\ifulp@afour
  \PassOptionsToPackage{a4paper}{geometry}
\else
  \PassOptionsToPackage{letterpaper}{geometry}
\fi
\ifulp@twocol
  \RequirePackage[text={6.75in,9in},centering,columnsep=0.25in,
                  headsep=10pt,footskip=25pt]{geometry}
\else
  \RequirePackage[text={5.5in,9in},centering,
                  headsep=14pt,footskip=30pt]{geometry}
\fi

%-----------------------------------------------------------------------------
% Fonts: Times text and math, Inconsolata for code
% amsthm must be loaded before newtxmath.
%-----------------------------------------------------------------------------
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage{newtxtext}
  \RequirePackage{newtxmath}
  \RequirePackage[varqu,scaled=0.95]{zi4}
\else
  % XeTeX/LuaTeX (Tectonic): newtxtext loads TeX Gyre Termes X via fontspec
  \RequirePackage{newtxtext}
  \RequirePackage{newtxmath}
  \setmonofont{Inconsolatazi4}[Scale=0.95,
    Extension=.otf, UprightFont=*-Regular, BoldFont=*-Bold,
    ItalicFont=*-Regular, ItalicFeatures={FakeSlant=0.15}]
\fi
\RequirePackage{mathtools}
\RequirePackage[protrusion=true,expansion=false]{microtype}

% Font sizes: 10pt on 11pt leading (ICML and NeurIPS).
\renewcommand\normalsize{%
  \@setfontsize\normalsize\@xpt\@xipt
  \abovedisplayskip 7\p@ \@plus 2\p@ \@minus 5\p@
  \abovedisplayshortskip \z@ \@plus 3\p@
  \belowdisplayshortskip 4\p@ \@plus 3\p@ \@minus 3\p@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
\renewcommand\small{%
  \@setfontsize\small\@ixpt\@xpt
  \abovedisplayskip 6\p@ \@plus 1.5\p@ \@minus 4\p@
  \abovedisplayshortskip \z@ \@plus 2\p@
  \belowdisplayshortskip 3\p@ \@plus 2\p@ \@minus 2\p@
  \belowdisplayskip \abovedisplayskip}
\renewcommand\footnotesize{\@setfontsize\footnotesize\@ixpt\@xpt}
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viipt\@viiipt}
\renewcommand\tiny{\@setfontsize\tiny\@vipt\@viipt}
\renewcommand\large{\@setfontsize\large\@xiipt{14}}
\renewcommand\Large{\@setfontsize\Large\@xivpt{16}}
\renewcommand\LARGE{\@setfontsize\LARGE\@xviipt{20}}

%-----------------------------------------------------------------------------
% Paragraphs and lists
%-----------------------------------------------------------------------------
\setlength\parindent{0pt}
\setlength\parskip{6pt \@plus 1pt}
\RequirePackage{enumitem}
\setlist{topsep=2pt, partopsep=0pt, itemsep=2pt, parsep=1pt}
\setlist[itemize]{leftmargin=1.5em}
\setlist[enumerate]{leftmargin=1.8em}
\setlist[description]{leftmargin=1em, font=\normalfont\bfseries}
\renewcommand\footnoterule{\kern-3\p@\hrule width 0.8in\kern 2.6\p@}
\setlength\footnotesep{6.65pt}
\setlength{\skip\footins}{9pt plus 4pt minus 2pt}
\widowpenalty=10000
\clubpenalty=10000
\flushbottom

%-----------------------------------------------------------------------------
% Section headings: "1. Introduction", "3.1. Setup", run-in paragraphs
%-----------------------------------------------------------------------------
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-2.0ex \@plus -0.5ex \@minus -0.2ex}{1.0ex \@plus 0.2ex}%
  {\large\bfseries\raggedright}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-1.6ex \@plus -0.5ex \@minus -0.2ex}{0.6ex \@plus 0.2ex}%
  {\normalsize\bfseries\raggedright}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-1.4ex \@plus -0.5ex \@minus -0.2ex}{0.4ex \@plus 0.2ex}%
  {\normalsize\itshape\raggedright}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {0.5ex \@plus 0.3ex \@minus 0.2ex}{-0.6em}%
  {\normalsize\bfseries}}
\renewcommand\@seccntformat[1]{\csname the#1\endcsname.\hskip 0.5em}
\setcounter{secnumdepth}{3}

%-----------------------------------------------------------------------------
% Graphics, floats, captions
%-----------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage[table]{xcolor}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup{skip=6pt, font=small, labelfont=bf, labelsep=period,
              justification=justified, singlelinecheck=true}
\captionsetup[table]{position=above, skip=4pt}
\captionsetup[figure]{position=below}
\captionsetup[sub]{font=small, labelfont=normalfont, labelformat=parens}
\setlength\textfloatsep{12pt \@plus 2pt \@minus 4pt}
\setlength\floatsep{10pt \@plus 2pt \@minus 2pt}
\setlength\intextsep{10pt \@plus 2pt \@minus 2pt}
\setlength\dbltextfloatsep{12pt \@plus 2pt \@minus 4pt}
\renewcommand\topfraction{0.9}
\renewcommand\dbltopfraction{0.9}
\renewcommand\bottomfraction{0.8}
\renewcommand\textfraction{0.1}
\renewcommand\floatpagefraction{0.8}
\renewcommand\dblfloatpagefraction{0.8}
\setcounter{topnumber}{3}
\setcounter{dbltopnumber}{3}
\setcounter{totalnumber}{5}
% Float pages fill from the top instead of centering a lone float.
\setlength\@fptop{0pt}
\setlength\@fpsep{12pt plus 2fil}
\setlength\@fpbot{0pt plus 1fil}
\setlength\@dblfptop{0pt}
\setlength\@dblfpsep{12pt plus 2fil}
\setlength\@dblfpbot{0pt plus 1fil}

% Colors (Okabe-Ito, colorblind-safe)
\definecolor{ulblue}{RGB}{0,114,178}
\definecolor{ulorange}{RGB}{230,159,0}
\definecolor{ulgreen}{RGB}{0,158,115}
\definecolor{ulvermilion}{RGB}{213,94,0}
\definecolor{ulpurple}{RGB}{204,121,167}
\definecolor{ulsky}{RGB}{86,180,233}
\definecolor{ulgray}{RGB}{110,110,110}
\definecolor{ullink}{RGB}{0,51,153}
\definecolor{ulcodebg}{RGB}{248,248,248}

%-----------------------------------------------------------------------------
% Algorithms and code
%-----------------------------------------------------------------------------
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{listings}
\lstset{
  basicstyle=\ttfamily\footnotesize,
  keywordstyle=\color{ulblue}\bfseries,
  commentstyle=\color{ulgray}\itshape,
  stringstyle=\color{ulgreen!70!black},
  backgroundcolor=\color{ulcodebg},
  frame=tb, framerule=0.4pt, rulecolor=\color{black!40},
  breaklines=true, breakatwhitespace=false,
  columns=fullflexible, keepspaces=true, showstringspaces=false,
  numbers=none, xleftmargin=0pt, aboveskip=6pt, belowskip=4pt,
  captionpos=t, abovecaptionskip=2pt,
}
\lstdefinelanguage{JavaScript}{
  keywords={const,let,var,function,return,if,else,for,while,new,true,false,null,undefined,class,import,export,await,async},
  sensitive=true, comment=[l]{//}, morecomment=[s]{/*}{*/},
  morestring=[b]", morestring=[b]', morestring=[b]`,
}

%-----------------------------------------------------------------------------
% Theorem-like environments
%-----------------------------------------------------------------------------
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{conjecture}[theorem]{Conjecture}
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{assumption}[theorem]{Assumption}
\newtheorem{hypothesis}{Hypothesis}
\newtheorem{example}[theorem]{Example}
\theoremstyle{remark}
\newtheorem{remark}[theorem]{Remark}

%-----------------------------------------------------------------------------
% Citations
%-----------------------------------------------------------------------------
\ifulp@numbers
  \RequirePackage[numbers,sort&compress]{natbib}
\else
  \RequirePackage[authoryear,round]{natbib}
\fi
\setlength\bibsep{3pt plus 1pt}
\renewcommand\bibfont{\small}
\bibliographystyle{plainnat}

%-----------------------------------------------------------------------------
% Title block, authors, affiliations, notice
%-----------------------------------------------------------------------------
\def\@shorttitle{}
\def\@affiliations{}
\def\@correspondence{}
\def\@notice{Preprint.}
\def\@keywords{}
\newcommand\shorttitle[1]{\gdef\@shorttitle{#1}}
\newcommand\affiliations[1]{\gdef\@affiliations{#1}}
\newcommand\correspondence[1]{\gdef\@correspondence{#1}}
\newcommand\notice[1]{\gdef\@notice{#1}}
\newcommand\keywords[1]{\gdef\@keywords{#1}}
% \affil{1} inside \author gives a superscript affiliation mark
% (math superscripts: the OpenType Times under XeTeX lacks superior digits)
\newcommand\affil[1]{\ensuremath{^{\textnormal{\scriptsize #1}}}}
\newcommand\equalcontrib{\ensuremath{^{*}}}
% Inside \author, \And separates authors on a line and \AND (or \\) starts
% a new line. Both are defined only while the title block is typeset.

\newcommand\ulp@titlebar[1]{\hrule height #1\relax}
\newcommand\ulp@titleblock{%
  \vskip 0.05in
  \ulp@titlebar{1pt}\vskip 0.2in
  {\centering\Large\bfseries\@title\par}%
  \vskip 0.2in\ulp@titlebar{1pt}%
  \vskip 0.2in
  {\centering\normalsize\bfseries\def\\{\par\vskip 2pt}%
   \def\And{\hskip 1.2em\ignorespaces}\def\AND{\\}\@author\par}%
  \vskip 0.25in}

\newcommand\ulp@frontnote{%
  \begingroup
  \renewcommand\thefootnote{}%
  \def\@tmp{}%
  \footnotetext{\raggedright
    \ifx\@affiliations\@tmp\else\@affiliations\par\fi
    \ifx\@correspondence\@tmp\else Correspondence to: \@correspondence\par\fi
    \ifx\@notice\@tmp\else\vskip 3pt\@notice\par\fi}%
  \endgroup}

\renewcommand\maketitle{%
  \ifx\@shorttitle\@empty\let\@shorttitle\@title\fi
  \ifulp@twocol
    \twocolumn[\ulp@titleblock]%
  \else
    \ulp@titleblock
  \fi
  \thispagestyle{plain}%
  \ulp@frontnote
  \setcounter{footnote}{0}%
  \let\maketitle\relax}

% Abstract: centered heading, indented block, keywords after.
\renewenvironment{abstract}{%
  \centerline{\large\bfseries Abstract}%
  \vspace{0.3ex}%
  \list{}{\ifulp@twocol\leftmargin 0.15in\rightmargin 0.15in
          \else\leftmargin 0.4in\rightmargin 0.4in\fi
          \parsep 4pt \topsep 0pt}%
  \item\relax}{%
  \ifx\@keywords\@empty\else
    \par\vskip 4pt{\small\textbf{Keywords:} \@keywords}\fi
  \endlist\vskip 0.08in}

%-----------------------------------------------------------------------------
% Running head and page numbers
%-----------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\small\bfseries\@shorttitle}
\fancyfoot[C]{\thepage}
\renewcommand\headrulewidth{1pt}
\renewcommand\footrulewidth{0pt}
\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\thepage}%
  \renewcommand\headrulewidth{0pt}}
\setlength\headheight{12pt}

%-----------------------------------------------------------------------------
% Appendix: lettered sections, start on a fresh page
%-----------------------------------------------------------------------------
\let\ulp@appendix\appendix
\renewcommand\appendix{\clearpage\ulp@appendix}

%-----------------------------------------------------------------------------
% Review mode: line numbers
%-----------------------------------------------------------------------------
\ifulp@review
  \RequirePackage[switch]{lineno}
  \renewcommand\linenumberfont{\normalfont\tiny\color{ulgray}}
  \AtBeginDocument{\linenumbers}
\fi

%-----------------------------------------------------------------------------
% Hyperlinks and cross-references (load last)
%-----------------------------------------------------------------------------
\RequirePackage{url}
\RequirePackage{hyperref}
\ifulp@color
  \hypersetup{colorlinks=true, linkcolor=ullink, citecolor=ullink,
              urlcolor=ullink, filecolor=ullink}
\else
  \hypersetup{hidelinks}
\fi
\hypersetup{bookmarksnumbered=true, bookmarksopen=true, pdfstartview=FitH}
\RequirePackage[capitalize,noabbrev]{cleveref}
\crefname{hypothesis}{Hypothesis}{Hypotheses}
\crefname{assumption}{Assumption}{Assumptions}
\crefname{definition}{Definition}{Definitions}
\crefname{lstlisting}{Listing}{Listings}
\crefname{algorithm}{Algorithm}{Algorithms}

\endinput
