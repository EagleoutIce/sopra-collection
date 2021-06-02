% sopra-paper.cls
% Version: 1.0
% Author:  Florian Sihler, 13.12.2019
%
% This LaTeX2e Class should provide the paper-layout to be used for
% all documents created by sopra-team-020.
%       ulm university, WiSe2019
% Development notes:
%    All internal commands and registers will be prefixed with 'sop@
%
% The general layout is inspired by the 'sopra-base' class but reimplemented
% to offer a titlepage and other styling options
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sopra-paper}[2019/13/02 EagleoutIce - Paper Documentclass for the sopra-team-020]

% Lengths and Registers
\newcounter{sopversion} \setcounter{sopversion}{1007}
\def\sop@AfterDate{}
\newif\ifsop@usedraft@% in draft mode we won't render everything
\newif\ifsop@sffmaily@% sf- or roman font?
\newif\ifsop@printmode@% in print, no colors will be used
\newif\ifsop@notoc@% should toc be hidden?
\newif\ifsop@showmail@% with show mail, the mail adresses of the authors will
                      % be used
\newif\ifsop@usebook@% scrbook or scrartcl?
\newif\ifsop@dopar@% parlen control

\newif\ifsop@applystyle@% if set, style to sopra-* will be automatically set!
\newif\ifsop@inappendix@% appendix flag

\newcounter{sop@counter@tmp@a}
\newcounter{sop@counter@chapter@counter}
\newcounter{sop@counter@chapter@counter@appendix}
\newlength\sop@len@tmp@a

% Class-Args
% draftmode:
\DeclareOption{draft}{\sop@usedraft@true}
\DeclareOption{final}{\sop@usedraft@false}
% parindent:
\DeclareOption{nopar}{\sop@dopar@false}
\DeclareOption{dopar}{\sop@dopar@true}
% font:
\DeclareOption{sffont}{\sop@sffmaily@true}
\DeclareOption{rmfont}{\sop@sffmaily@false}
% mode
\DeclareOption{defaultmode}{\sop@printmode@false}% probably shouldn't be used
\DeclareOption{print}{\sop@printmode@true}%
% mail show
\DeclareOption{showmail}{\sop@showmail@true}
\DeclareOption{hidemail}{\sop@showmail@false}
% do toc
\DeclareOption{dotoc}{\sop@notoc@false}
\DeclareOption{notoc}{\sop@notoc@true}
% use book
\DeclareOption{usebook}{\sop@usebook@true}
\DeclareOption{useartcl}{\sop@usebook@false}

% apply style
\DeclareOption{setstyle}{\sop@applystyle@true}
\DeclareOption{nosetstyle}{\sop@applystyle@false}

\ExecuteOptions{sffont,defaultmode,showmail,usebook,setstyle}% set it explicitly
\ProcessOptions\relax%

% Documentclass

% wie will use the KOMA-Book as a starting-point
\ifsop@usebook@
\LoadClass[titlepage,oneside,numbers=noenddot]{scrbook}
\else
\LoadClass[titlepage,numbers=noenddot]{scrartcl}
\fi

\newlength\sop@len@parindent \setlength\sop@len@parindent\parindent
\newlength\sop@len@logoheight \setlength\sop@len@logoheight{2.6cm}
\newlength\sop@len@header \setlength\sop@len@header{2cm}% header padding

\ifsop@dopar@ \parindent\sop@len@parindent \else \parindent\z@ \fi

% Basic Packages
\ifsop@sffmaily@
\RequirePackage[defaultfam,tabular,lining]{montserrat}
\RequirePackage{sfmath}
\else \RequirePackage{CormorantGaramond} \fi

\RequirePackage{tikz} % we need it anyways - will load xcolor
\usetikzlibrary{calc}
% encoding:
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

% language
\RequirePackage[english,main=ngerman]{babel}
% layout
\edef\sop@headheight{\dimexpr26mm + .5\sop@len@logoheight}
\edef\sop@footheight{\dimexpr\sop@len@header-8mm}
\RequirePackage[margin=\sop@len@header,a4paper,bottom=\sop@footheight,top=27mm]{geometry}
% beautify:
\RequirePackage{lmodern,microtype,scrlayer-scrpage,enumitem}
\RequirePackage[all]{nowidow}
\RequirePackage[hidelinks]{hyperref}

% Language
\def\xcontentname{Inhalts\"{u}bersicht}

\ifsop@usebook@
\addto\captionsngerman{
    \renewcommand{\contentsname}{\leavevmode\\[-.75\baselineskip]\strut\xcontentname}
}
\else
\addto\captionsngerman{
    \renewcommand{\contentsname}{\strut\xcontentname}
}
\fi
% Color Definitions
% We will define a main/primary color, a secondary/akzent color and a tertiary
% /light color to be used everywhere throughout the document.
% there will be further colors definied (like for example header-text)
% black/contrast color to be used in the document
\definecolor{sop@color@primary}  {RGB}{012,010,007}       % RGB(012,010,007)
\definecolor{sop@color@akzent}   {RGB}{150,128,081}       % RGB(150,128,081)
\definecolor{sop@color@light}    {RGB}{236,200,128}       % RGB(236,200,128)
\definecolor{sop@color@white}{RGB}{252,252,252}           % RGB(252,252,252)
\definecolor{sop@color@highlight}{RGB}{153,007,051}       % RGB(153,07,051)

% main-colormappings
\colorlet{cprimary}{sop@color@primary}
\colorlet{cakzent}{sop@color@akzent}
\colorlet{clight}{sop@color@light}
\colorlet{cimportant}{sop@color@highlight}
\colorlet{cwhite}{sop@color@white}
\colorlet{chighlight}{sop@color@highlight}
% titlepage (tp) styles
\colorlet{ctpbackground}{cprimary}
\colorlet{ctptext}{cwhite}
\colorlet{ctpsymbol}{cakzent}
% header (hd) styles
\colorlet{chdtext}{cakzent}

% Color Palette & color styling
\ifsop@printmode@ \selectcolormodel{gray}
\else \selectcolormodel{rgb}\fi

% some styling commands
\long\def\sop@@imptext#1{\begingroup\slshape\color{cimportant}#1\endgroup}
\let\imptext\sop@@imptext

\long\def\sop@@notetext#1{\begingroup\itshape\color{cprimary!70!white}#1\endgroup}
\let\notetext\sop@@notetext

% lengthts:
\def\baselinestretch{1.1}
\parskip=.75em

% beautify the footnotes:
\def\thefootnote{$\langle$\textbf{\arabic{footnote}}$\rangle$}
\def\thempfootnote{$\langle$\textbf{\roman{mpfootnote}}$\rangle$}
% Helper Methods
\def\sop@thesopversion#1#2#3#4\@nil{{#1.#2.#3#4}}

\edef\sop@version@str{\noexpand\sop@thesopversion\arabic{sopversion}\noexpand\@nil}
\edef\thesopversion{\sop@version@str}

\def\sop@mail#1{\href{mailto:#1}{#1}}
\let\mail\sop@mail
\def\sop@month@to@name#1{%
    \ifcase#1\or{Januar}\or{Februar}\or{M\"{a}rz}\or{April}\or{Mai}\or{Juni}%
    \or{Juli}\or{August}\or{September}\or{Oktober}\or{November}\or{Dezember}%
    \else\@ctrerr\fi}

\def\sop@date@convert#1-#2-#3\@nil{\begingroup#3.\space{\sop@month@to@name{#2}}\space#1\endgroup}
\def\DateConvert#1{\expandafter\ifx\expandafter!#1!\else\expandafter\sop@date@convert#1\@nil\fi}

% Set the Document-Metadata
% we will populate the following fields:
% dates have to be given in YYYY-MM-DD!
% authors can be also populated by the helper methods
\foreach \field in {title,subtitle,brief,authors,duedate,supervisor,%
    keywords,group,groupnum}{
    \expandafter\xdef\csname\field\endcsname{%
        \noexpand\@ifnextchar[%
        {\expandafter\noexpand\csname\field @hasopt\endcsname}%
        {\expandafter\noexpand\csname\field @noopt\endcsname}
    }
    \expandafter\xdef\csname\field @hasopt\endcsname[##1]##2%
    {\expandafter\noexpand\gdef\csname sop@register@\field\endcsname{##2}%
    \expandafter\noexpand\gdef\csname sop@register@short@\field\endcsname{##1}}
    \expandafter\xdef\csname\field @noopt\endcsname##1%
    {\expandafter\noexpand\gdef\csname sop@register@\field\endcsname{##1}%
    \expandafter\noexpand\gdef\csname sop@register@short@\field\endcsname{##1}}%
    \expandafter\gdef\csname sop@register@\field\endcsname{}%
    \expandafter\gdef\csname sop@register@short@\field\endcsname{}%
}

% iterators for handling and parsing author information.
\def\sop@@add@author#1{%
    \let\sop@@tmp@old@authors\sop@register@authors
    \ifx\sop@@tmp@old@authors\@empty
    \xdef\sop@register@authors{#1}\else
    \xdef\sop@register@authors{\sop@@tmp@old@authors,#1}\fi
}
\let\addAuthor\sop@@add@author

\ifsop@showmail@
\def\sop@@parse@author#1 (#2)\@nil{\begingroup#1 (\mail{#2})\endgroup}
\else
\def\sop@@parse@author#1 (#2)\@nil{\begingroup\href{mailto:#2}{#1}\endgroup}
\fi
\def\sop@@typeset@author#1{%
    \setcounter{sop@counter@tmp@a}{0}% start with an offset
    \foreach \@tmp in {#1}%
        {\ifx\@tmp\@empty\else\stepcounter{sop@counter@tmp@a}\fi}%
    \edef\sop@authors@totallength{\arabic{sop@counter@tmp@a}}%
    \setcounter{sop@counter@tmp@a}{0} % stored the length of the list
    \foreach \sop@@tmp@curauthor in {#1} {%
        \ifx\sop@@tmp@curauthor\@empty%empty => ignore
        \else\stepcounter{sop@counter@tmp@a}%
            \ifnum\thesop@counter@tmp@a>1\relax
            \ifnum\thesop@counter@tmp@a=\sop@authors@totallength\relax
                ~und \else,\space\fi\fi
            \expandafter\sop@@parse@author\sop@@tmp@curauthor\@nil
        \fi
    }%
}

\def\sop@@setteam#1 #2\@nil{\gdef\sop@register@group{#1}\gdef\sop@register@groupnum{#2}}
\newcommand\setTeam[1]{\expandafter\sop@@setteam#1\@nil}
\newcommand\typesetAuthors{\protected@edef\@tmp{\noexpand\sop@@typeset@author{\sop@register@authors}}\@tmp}

% the title field can be set by '\title{<Your title here>}'
\AtBeginDocument{\hypersetup{
    pdftitle=\sop@register@title,
    pdfauthor=\sop@register@authors,
    pdfsubject=\sop@register@subtitle,
    pdfkeywords=\sop@register@keywords,
    pdfcreator={LaTeX with hyperref and the sopra-paper class}
}}

% Header Metadata
% We modify chapter to increase the total counter to get the total number of
% chapters in the end
% in artcile the store commands will refer to the section!
\def\sop@store@chapter{\write\@auxout{\noexpand\global\noexpand \stepcounter{sop@counter@chapter@counter}}}
\def\sop@store@chapter@appendix{\write\@auxout{\noexpand\global\noexpand \stepcounter{sop@counter@chapter@counter@appendix}}}
\let\@sop@store@chpcount\sop@store@chapter

\def\sopDisableTocRegister{\let\@sop@store@chpcount\relax}
\def\sopEnableTocRegister{\let\@sop@store@chpcount\sop@store@chapter}

\ifsop@usebook@
\let\sop@chapter\chapter
\def\chapter{\@ifstar\sop@chapter@starred\sop@chapter@unstarred}
\def\sop@chapter@starred{\sop@chapter*}
\def\sop@chapter@unstarred{\@sop@store@chpcount\sop@chapter}
\else
\let\sop@section\section
\def\section{\@ifstar\sop@section@starred\sop@section@unstarred}
\def\sop@section@starred{\sop@section*}
\def\sop@section@unstarred{\@sop@store@chpcount\sop@section}
\fi

\let\sop@appendix\appendix
\def\appendix{%
\clearpage
\global\sop@inappendix@true
\ifsop@usebook@\else
\global\renewcommand{\sectionmark}[1]{\markright{\@Alph\c@section,~##1}}
\fi
\global\let\@sop@store@chpcount\sop@store@chapter@appendix\sop@appendix
}

% Total chapter number now in '\thesop@counter@chapter@counter'
\def\sop@chapblob#1#2#3#4{%
    \path[draw,fill=#2] (#3) circle (6pt) node[font=\scriptsize,align=center] {\hyperlink{#4.#1}{#1}};%
}
\def\sop@mchapblob#1#2#3#4{%
    \path[draw,fill=cprimary] (#3) circle (6pt) node[font=\scriptsize\bfseries,align=center,#2] {\hyperlink{#4.#1}{#1}};%
}
\def\sop@chapsq#1#2#3#4{%
    \path[draw,fill=#2,thin] (#3)++(-5.5pt,-5.5pt) rectangle ++(11pt,11pt) node[midway,centered,font=\scriptsize,align=center] {\hyperlink{#4.#1}{#1}};%
}
\def\sop@mchapsq#1#2#3#4{%
    \path[draw,fill=cprimary,thin] (#3)++(-5.5pt,-5.5pt) rectangle ++(11pt,11pt) node[midway,centered,font=\scriptsize\bfseries,align=center,#2] {\hyperlink{#4.#1}{#1}};%
}
% Header
\renewcommand\sectionmark[1]{\markright{\@arabic\c@section,~#1}}
\clearpairofpagestyles
\renewcommand\headfont{\normalfont}

\ifsop@usebook@
    \renewcommand\chaptermark[1]{\markboth{#1}{Kapitel:~#1}}
    \def\@sop@tlheadmarker{chapter}
\else
    \def\@sop@tlheadmarker{section}
    \renewcommand\subsectionmark[1]{\markright{\@arabic\c@subsection,~#1}}
\fi

\ifsop@usedraft@
\chead{\@nameuse{the\@sop@tlheadmarker}:\leftmark:\rightmark:\thepage}
\else
\chead{%
\def\@doheader{0}
\ifnum\value{\@sop@tlheadmarker}>0 \def\@doheader{1}\fi
\ifsop@notoc@\else\def\@doheader{1}\fi
%
\ifnum\@doheader>0
\begin{tikzpicture}[remember picture, overlay]
    \coordinate (tl@pf@lockpos) at ($(current page.north east)+(-55mm,-1.25cm)$);
    \node[cprimary,left=2pt] at (tl@pf@lockpos) {\Huge$\thepage$};
    % Cur section rectangle
    \path[fill=cakzent] (tl@pf@lockpos) rectangle ++(55mm,.55pt);
    \node[above right,yshift=-\p@,font=\footnotesize,text width=5cm,align=left,minimum height=.736cm] at (tl@pf@lockpos) {\strut\ifx\rightmark\@empty \leftmark\else \rightmark\fi\strut};
    \def\@sop@cury{0}
    \def\@sop@curxoff{0} % allow a second line
    \ifsop@notoc@ % normal mode
        \def\ioffset{0}
    \else % set Tableofcontents-Link and set offset of \i
        \def\ioffset{1}
        \coordinate (chapnode0) at ($(tl@pf@lockpos)+(1/1.6-1/1.6+.33+\@sop@curxoff,-.35+\@sop@cury)$);
        \ifnum0=\value{\@sop@tlheadmarker}  % in current chapter
        \sop@mchapsq{I}{cwhite}{chapnode0}{toc}%
        \else\sop@chapsq{I}{white}{chapnode0}{toc}\fi%
    \fi
    \ifnum\value{sop@counter@chapter@counter}>0
    \foreach \i in {1,...,\thesop@counter@chapter@counter}{%
        \edef\ix{\the\numexpr\i+\ioffset\relax}
        % \typeout{\i:\thesop@counter@chapter@counter:\thechapter x}
        \coordinate (chapnode\i) at ($(tl@pf@lockpos)+(\ix/1.6-1/1.6+.33+\@sop@curxoff,-.35+\@sop@cury)$);
        \ifsop@inappendix@\sop@chapblob{\i}{white}{chapnode\i}{\@sop@tlheadmarker}\else
        \ifnum\i=\value{\@sop@tlheadmarker}  % in current chapter
            \sop@mchapblob{\i}{cwhite}{chapnode\i}{\@sop@tlheadmarker}%
        \else \sop@chapblob{\i}{white}{chapnode\i}{\@sop@tlheadmarker}%
        \fi\fi
        \ifnum\ix=8 \gdef\@sop@cury{-.575} \gdef\@sop@curxoff{-8/1.6}\fi
    }
    \fi
    % HWA
    % Typeset Appendix
    \ifnum\value{sop@counter@chapter@counter@appendix}>0
    \foreach \i [evaluate=\i as \ai using {int(\i+\thesop@counter@chapter@counter+\ioffset)}]in {1,...,\thesop@counter@chapter@counter@appendix}{%
        % \typeout{\i:\thesop@counter@chapter@counter:\thechapter x}
        \coordinate (achapnode\i) at ($(tl@pf@lockpos)+(\ai/1.6-1/1.6+.33+\@sop@curxoff,-.35+\@sop@cury)$);
        \ifsop@inappendix@
        \ifnum\i=\value{\@sop@tlheadmarker}  % in current chapter/section
            \sop@mchapblob{\@Alph\i}{cwhite}{achapnode\i}{appendix}%
        \else \sop@chapblob{\@Alph\i}{white}{achapnode\i}{appendix}%
        \fi
        \else \sop@chapblob{\@Alph\i}{white}{achapnode\i}{appendix}\fi
        \ifnum\ai=8 \gdef\@sop@cury{-.575} \gdef\@sop@curxoff{-8/1.5}\fi
    }
    \fi
    % Typeset Appendix
\end{tikzpicture}%
\fi}
\fi

% Structure Styles
\def\sop@sepline{%
    {\color{cakzent}{\Huge$\llap{$\diamond$}\hspace*{-\p@}$}\rule[.41\baselineskip]{\linewidth}{.55pt}{\Huge$\hspace*{-\p@}\rlap{$\diamond$}$}}%
}

\ifsop@usebook@ \renewcommand\chapterformat{} %
\renewcommand\chapterlinesformat[3]{%
\vspace*{-2.5em}
\ifnum\c@chapter>0
\begin{center}
    \vspace*{-\topsep}
    \thechapter
\end{center}
\fi
{\color{chdtext}{\Huge$\llap{$\diamond$}\hspace*{-\p@}$}\rule[.22\baselineskip]{\linewidth}{.55pt}{\Huge$\hspace*{-\p@}\rlap{$\diamond$}$}}%
    \begin{center}
        \vspace*{-\topsep}
        \color{chdtext}#2#3%
    \end{center}
    {\color{chdtext}{\Huge$\llap{$\diamond$}\hspace*{-\p@}$}\rule[.22\baselineskip]{\linewidth}{.55pt}{\Huge$\hspace*{-\p@}\rlap{$\diamond$}$}}%
}%
\fi

\renewcommand\sectionlinesformat[4]{%
    \def\tmp@a{#1}\def\tmp@b{section}\ifx\tmp@a\tmp@b
    \parbox{\linewidth}{%
    {\color{chdtext}\strut#3#4}%
    \\[-.7\baselineskip]
    \settowidth{\sop@len@tmp@a}{\strut#3#4}%
    \ifdim\sop@len@tmp@a<\dimexpr\linewidth-14\p@\relax \addtolength\sop@len@tmp@a{14pt}\else \sop@len@tmp@a=\linewidth\fi
    {\normalsize\color{chdtext}{\large$\llap{$\diamond$}\hspace*{-.75pt}$}\rule[.186\baselineskip]{\sop@len@tmp@a}{.55pt}}}
    \else#3#4\fi
}%

\RedeclareSectionCommands[
  beforeskip=-3.25ex \@plus -.5ex \@minus -.2ex,
  runin=bysign,afterindent=bysign,
  afterskip=\parskip]{paragraph,subparagraph}

\setkomafont{section}{\LARGE}
\setkomafont{subsection}{\large}
\setkomafont{subsubsection}{\normalsize}
\setkomafont{paragraph}{\mdseries\itshape}

\RequirePackage{sopra-ntts}

% set the titlepage
\def\sop@layout@titlepage{%
\begin{titlepage}
    \pagecolor{ctpbackground}
    % Here we will place the Tag (Sopra....)
    \hbox{}\hfill\llap{\begin{tikzpicture}[scale=.079]
        \def\son@font@futura@color@current{ctptext}
        \son@ntts
        % lets draw a strw for 'Y'
        \node[\son@font@futura@color@current] at ($(ct@ystraw)+(-22.5mm,132mm)$) {\scriptsize\bfseries/};
        % here we will plant the group-Tag at the 007 position, having a lot of fun :D
        \ifx\sop@register@groupnum\@empty\else
        \node[right=1mm,yshift=4mm,font=\fontsize{17}{17}\selectfont\sffamily,ctpsymbol] (ct@gnumt) at (ct@groupnum) {\son@titlepage@groupnum{\sop@register@groupnum}};
        \node[right,yshift=1mm,xshift=4mm,font=\fontsize{8}{8}\selectfont\sffamily,ctpsymbol] at (ct@gnumt){\ifx\sop@register@group\@empty Team\else\rlap{\sop@register@group}\fi};
        \fi
    \end{tikzpicture}}\\[5em]
    \sop@sepline
    % Set the Documenttitle
    \begin{center}
    \scalebox{1.125}{\fontsize{30}{30}\selectfont\color{ctpsymbol}~{\sop@register@title}}
    \end{center}
    \sop@sepline
    % Set the Subtitle
    \begin{center}
        \vspace*{-\topsep}
        {\strut\color{ctpsymbol}\sop@register@subtitle}
    \end{center}
    \vfill
    % Set The Author
    \begin{minipage}{.6\linewidth}\footnotesize\color{ctpsymbol}
        \ifx\sop@register@duedate\@empty\else
            \begingroup\hbox{}\quad\scriptsize\DateConvert{\sop@register@duedate}\sop@AfterDate\endgroup\\[-.2\baselineskip]%
        \fi
        {\color{ctpsymbol}$\Large\llap{$\diamond$}\hspace*{-\p@}$\rule[.275\baselineskip]{.45\linewidth}{.55\p@}\\}%
        {{\bfseries Bearbeitung:}}\\
        \hbox{}\quad\parbox{\linewidth}{\typesetAuthors}\bigskip\par
        \ifx\sop@register@brief\@empty\else
        {\bfseries Beschreibung:}\smallskip\\
        \hbox{}\quad\parbox\linewidth{\sop@register@brief}\fi
    \end{minipage}\vspace*{2em}
\end{titlepage}
\clearpage\nopagecolor
\thispagestyle{empty}%
\hbox{}\qquad\begin{tikzpicture}[scale=.12]
    \def\son@font@futura@color@current{cprimary}
    \son@ntts
    % lets draw a strw for 'Y'
    \node[\son@font@futura@color@current] at ($(ct@ystraw)+(-22.5mm,132mm)$) {\bfseries/};
\end{tikzpicture}
\hbox{}\vfill\begingroup\scriptsize
\begin{flushright}
    \parbox{9cm}{\textbf{$-\,$\DateConvert{2019-12-15}$\,-$}\\
    \color{cprimary}Dieses Layout wurde für das Softwaregrundprojekt
    im Wintersemester 2019\thinspace /\thinspace 2020 von Florian Sihler im Rahmen des
    Informatikstudiums an der Universität Ulm vollständig in \LaTeXe{} erstellt.}
\end{flushright}\endgroup
\clearpage
}

\AtBeginDocument{
    \addtocontents{toc}{\protect\pagestyle{scrheadings}}%
    \sop@layout@titlepage
}

\ifsop@notoc@\else
\makeatletter
\newcommand\TableOfContents[1][]{\hypertarget{toc.I}\relax
    \section*{\contentsname}
    \markright{I, \xcontentname}
    \ifx!#1!\else\vspace*{-\topsep}#1\par\fi
    \begingroup\@starttoc{toc}\endgroup
}\fi

% Listings (sopra-listings), Attachments (sopra-attachments,...)
\def\sop@SetListing{
\colorlet{sol@colors@lst@keywordA}{cprimary} % e.g.: class, public, static...
\colorlet{sol@colors@lst@keywordB}{cakzent} % e.g.: int, double ...
\colorlet{sol@colors@lst@keywordC}{cakzent!85!black} % e.g.: class-names?
\colorlet{sol@colors@lst@numbers}{chighlight!90!cprimary} % well, numbers
\colorlet{sol@colors@lst@literals}{cakzent!90!brown} % well, numbers
\colorlet{sol@colors@lst@comments}{clight!10!gray} % well, comments
\colorlet{sol@colors@lst@highlight}{chighlight} % sweetspots
\sol@list@define@styles{%
    {keywordA:      \color{sol@colors@lst@keywordA}\bfseries},%
}}

\def\sop@SetAttachment{
\attachfilesetup{%
    author={\sop@register@authors},
    color=cakzent,icon=Tag,
    mimetype=text/plain % we assume
}}

\def\sop@SetTables{%
\colorlet{HeaderColor}{cprimary!80!white}
\colorlet{NextHeaderColor}{cprimary!60!white}
\colorlet{MaterialHeaderColor}{HeaderColor}
\colorlet{NextMaterialHeaderColor}{NextHeaderColor}
}

\def\sop@SetModels{
    \tikzumlset{fill usecase=cprimary!70!white, fill system=cprimary!20!white, fill state=cprimary!70!white,fill object=cprimary!70!white, fill class=cprimary!70!white,fill note=cprimary, font=\small\ttfamily}
}

\ifsop@applystyle@
\AtBeginDocument{
\ifcsname thesolversion\endcsname \sop@SetListing\fi % listings
\ifcsname thesoaversion\endcsname \sop@SetAttachment\fi % attachments
\ifcsname thesorversion\endcsname \sop@SetTables\fi % requirements
\ifcsname thesotversion\endcsname \sop@SetTables\fi % tables
\ifcsname thesomversion\endcsname \sop@SetModels\fi % Models
}
\fi
\endinput