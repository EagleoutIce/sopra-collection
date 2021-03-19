%% sopra-paper.cls
%%
%% -----------------------------------------------------------------------------
%% Version: 1.0
%% Author:  Florian Sihler, 13.12.2019
%%
%% This LaTeX2e Class should provide the paper-layout to be used for
%% all documents created by sopra-team-020.
%%                      ulm university, WiSe2019


%% Development notes:
%%    All internal commands and registers will be prefixed with 'sop@
%%

%% The general layout is inspired by the 'sopra-base' class but reimplemented
%% to offer a titlepage and other styling options

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
\DeclareOption{draft}{ \sop@usedraft@true }%
\DeclareOption{final}{ \sop@usedraft@false }%
% parindent:
\DeclareOption{nopar}{ \sop@dopar@false }%
\DeclareOption{dopar}{ \sop@dopar@true }%
% font:
\DeclareOption{sffont}{ \sop@sffmaily@true }%
\DeclareOption{rmfont}{ \sop@sffmaily@false }%
% mode
\DeclareOption{defaultmode}{ \sop@printmode@false }% probably shouldn't be used
\DeclareOption{print}{ \sop@printmode@true }%
% mail show
\DeclareOption{showmail}{ \sop@showmail@true }
\DeclareOption{hidemail}{ \sop@showmail@false }
% do toc
\DeclareOption{dotoc}{ \sop@notoc@false }
\DeclareOption{notoc}{ \sop@notoc@true }
% use book
\DeclareOption{usebook}{ \sop@usebook@true }
\DeclareOption{useartcl}{ \sop@usebook@false }

% apply style
\DeclareOption{setstyle}{ \sop@applystyle@true }
\DeclareOption{nosetstyle}{ \sop@applystyle@false }

\ExecuteOptions{final,nopar,sffont,defaultmode,showmail,dotoc,usebook,setstyle}% set it explicitly
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

\ifsop@dopar@ \setlength\parindent\sop@len@parindent%
\else \parindent=\z@ \fi

% Basic Packages

\ifsop@sffmaily@
\RequirePackage[defaultfam,tabular,lining]{montserrat}
\RequirePackage{sfmath}
% \usepackage[sfdefault]{overlock}
% \usepackage{libertine}
% \renewcommand*\familydefault{\sfdefault}
\else
\usepackage{CormorantGaramond}
\fi

\RequirePackage{tikz} % we need it anyways - will load xcolor
\usetikzlibrary{calc}
% encoding:
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

% language
\RequirePackage[english,main=ngerman]{babel}
% layout
\pgfmathsetmacro\sop@headheight{2.6cm + \sop@len@logoheight/2}
\pgfmathsetmacro\sop@footheight{\sop@len@header-8mm}
\RequirePackage[margin=\sop@len@header,a4paper,%
    bottom=\sop@footheight pt,top=2.7cm]{geometry}
% beautify:
\RequirePackage{lmodern,microtype,scrlayer-scrpage}
\RequirePackage{enumitem}

\RequirePackage[all]{nowidow}
\RequirePackage[hidelinks]{hyperref}

% Language

\def\xcontentname{Inhalts\"{u}bersicht}

\ifsop@usebook@
\addto\captionsngerman{
    \renewcommand{\contentsname}{\leavevmode\\[-0.75\baselineskip]\strut\xcontentname}
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

% \definecolor{sop@color@highlight}{RGB}{135,076,150}     % RGB(135,076,150)
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

\ifsop@printmode@ \selectcolormodel{gray}%
\else \selectcolormodel{rgb}\fi %\maskcolors[cmy]{gray} \fi

% some styling commands
\long\def\sop@@imptext#1{\begingroup\slshape\color{cimportant}#1\endgroup}
\let\imptext\sop@@imptext

\long\def\sop@@notetext#1{\begingroup\itshape\color{cprimary!70!white}#1\endgroup}
\let\notetext\sop@@notetext

% lengthts:
\renewcommand{\baselinestretch}{1.1}
\setlength{\parskip}{0.75em}

% beautify the footnotes:
\renewcommand*{\thefootnote}{$\langle$\textbf{\arabic{footnote}}$\rangle$}
\renewcommand*{\thempfootnote}{$\langle$\textbf{\roman{mpfootnote}}$\rangle$}

% TODO: restyle chapters, sections, \ldots

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

\def\sop@date@convert#1-#2-#3\@nil{%
    \begingroup#3.\space{\sop@month@to@name{#2}}\space#1\endgroup%
}
\def\DateConvert#1%
{\expandafter\ifx\expandafter!#1!\else\expandafter\sop@date@convert#1\@nil\fi}

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
    \expandafter\noexpand\gdef\csname sop@register@short@\field\endcsname{##1}}
    \expandafter\gdef\csname sop@register@\field\endcsname{}
    \expandafter\gdef\csname sop@register@short@\field\endcsname{}
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
        {\ifx\@tmp\@empty\else%
            \stepcounter{sop@counter@tmp@a}\fi}%
    \edef\sop@authors@totallength{\arabic{sop@counter@tmp@a}}%
    \setcounter{sop@counter@tmp@a}{0} % stored the length of the list
    \foreach \sop@@tmp@curauthor in {#1} {%
        \ifx\sop@@tmp@curauthor\@empty%empty => ignore
        \else\stepcounter{sop@counter@tmp@a}%
            \ifnum\thesop@counter@tmp@a>1%
            \ifnum\thesop@counter@tmp@a=\sop@authors@totallength%
                ~und \else,\space\fi\fi
            \expandafter\sop@@parse@author\sop@@tmp@curauthor\@nil%
        \fi%
    }%
}

\def\sop@@setteam#1 #2\@nil{%
    \gdef\sop@register@group{#1}\gdef\sop@register@groupnum{#2}%
}
\newcommand\setTeam[1]{%
    \expandafter\sop@@setteam#1\@nil
}
\newcommand\typesetAuthors{%
    \edef\@tmp{\noexpand\sop@@typeset@author{\sop@register@authors}}\@tmp}

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

% TODO: Document
\def\sopDisableTocRegister{\let\@sop@store@chpcount\relax}
\def\sopEnableTocRegister{\let\@sop@store@chpcount\sop@store@chapter}

\ifsop@usebook@
\let\sop@chapter\chapter
\def\chapter{%
    \@ifstar\sop@chapter@starred\sop@chapter@unstarred%
}
\def\sop@chapter@starred{\sop@chapter*}
\def\sop@chapter@unstarred{\@sop@store@chpcount\sop@chapter}
\else
\let\sop@section\section
\def\section{%
    \@ifstar\sop@section@starred\sop@section@unstarred%
}
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
    \draw[fill=#2] (#3) circle (6pt) node[font=\scriptsize,align=center] {\hyperlink{#4.#1}{#1}};%
}

\def\sop@mchapblob#1#2#3#4{%
    \draw[fill=cprimary] (#3) circle (6pt) node[font=\scriptsize\bfseries,align=center,#2] {\hyperlink{#4.#1}{#1}};%
}

\def\sop@chapsq#1#2#3#4{%
    \draw[fill=#2,thin] (#3)++(-5.5pt,-5.5pt) rectangle ++(11pt,11pt) node[midway,centered,font=\scriptsize,align=center] {\hyperlink{#4.#1}{#1}};%
}

\def\sop@mchapsq#1#2#3#4{%
    \draw[fill=cprimary,thin] (#3)++(-5.5pt,-5.5pt) rectangle ++(11pt,11pt) node[midway,centered,font=\scriptsize\bfseries,align=center,#2] {\hyperlink{#4.#1}{#1}};%
}
% Header

\renewcommand{\sectionmark}[1]{\markright{\@arabic\c@section,~#1}}

\clearpairofpagestyles
\renewcommand\headfont{\normalfont}

\ifsop@usebook@
    \renewcommand{\chaptermark}[1]{\markboth{#1}{Kapitel:~#1}}
    \def\@sop@tlheadmarker{chapter}
\else
    \def\@sop@tlheadmarker{section}
    \renewcommand{\subsectionmark}[1]{\markright{\@arabic\c@subsection,~#1}}
\fi

\ifsop@usedraft@
\chead{\@nameuse{the\@sop@tlheadmarker}:\leftmark:\rightmark:\thepage}
\else
\chead{%
\def\@doheader{0}
\ifnum\value{\@sop@tlheadmarker}>0
    \def\@doheader{1}\fi
\ifsop@notoc@\else\def\@doheader{1}\fi
%
\ifnum\@doheader>0
\begin{tikzpicture}[remember picture, overlay]
    \coordinate (tl@pf@lockpos) at ($(current page.north east)+(-5.5cm,-1.25cm)$);
    \node[cprimary,left=2pt] at (tl@pf@lockpos) {\Huge$\thepage$};
    % Cur section rectangle
    \fill[cakzent] (tl@pf@lockpos) rectangle ++(5.5cm,0.55pt);
    \node[above right,yshift=-1pt,font=\footnotesize,text width=5cm,align=left,minimum height=0.736cm] at (tl@pf@lockpos) {\strut\ifx\rightmark\@empty \leftmark\else \rightmark\fi\strut};
    \def\@sop@cury{0}
    \def\@sop@curxoff{0} % allow a second line
    \ifsop@notoc@ % normal mode
        \def\ioffset{0}
    \else % set Tableofcontents-Link and set offset of \i
        \def\ioffset{1}
        \coordinate (chapnode0) at ($(tl@pf@lockpos)+(1/1.6-1/1.6+0.33+\@sop@curxoff,-0.35+\@sop@cury)$);
        \ifnum0=\value{\@sop@tlheadmarker}  % in current chapter
        \sop@mchapsq{I}{cwhite}{chapnode0}{toc}%
        \else\sop@chapsq{I}{white}{chapnode0}{toc}\fi%
    \fi
    % \node[below right,yshift=1pt,font=\footnotesize,text width=5cm,align=left] at (tl@pf@lockpos) {\strut\sop@chapterbubbles};
    \ifnum\value{sop@counter@chapter@counter}>0
    \foreach \i in {1,...,\thesop@counter@chapter@counter}{%
        \pgfmathsetmacro\ix{int(\i+\ioffset)}
        % \typeout{\i:\thesop@counter@chapter@counter:\thechapter x}
        \coordinate (chapnode\i) at ($(tl@pf@lockpos)+(\ix/1.6-1/1.6+0.33+\@sop@curxoff,-0.35+\@sop@cury)$);
        \ifsop@inappendix@\sop@chapblob{\i}{white}{chapnode\i}{\@sop@tlheadmarker}\else
        \ifnum\i=\value{\@sop@tlheadmarker}  % in current chapter
            \sop@mchapblob{\i}{cwhite}{chapnode\i}{\@sop@tlheadmarker}%
        \else \sop@chapblob{\i}{white}{chapnode\i}{\@sop@tlheadmarker}%
        \fi\fi
        \ifnum\ix=8 \gdef\@sop@cury{-0.575} \gdef\@sop@curxoff{-8/1.6}\fi
    }
    \fi
    % HWA
    % Typeset Appendix
    \ifnum\value{sop@counter@chapter@counter@appendix}>0
    \foreach \i [evaluate=\i as \ai using {int(\i+\thesop@counter@chapter@counter+\ioffset)}]in {1,...,\thesop@counter@chapter@counter@appendix}{%
        % \typeout{\i:\thesop@counter@chapter@counter:\thechapter x}
        \coordinate (achapnode\i) at ($(tl@pf@lockpos)+(\ai/1.6-1/1.6+0.33+\@sop@curxoff,-0.35+\@sop@cury)$);
        \ifsop@inappendix@
        \ifnum\i=\value{\@sop@tlheadmarker}  % in current chapter/section
            \sop@mchapblob{\@Alph\i}{cwhite}{achapnode\i}{appendix}%
        \else \sop@chapblob{\@Alph\i}{white}{achapnode\i}{appendix}%
        \fi
        \else \sop@chapblob{\@Alph\i}{white}{achapnode\i}{appendix}\fi
        \ifnum\ai=8 \gdef\@sop@cury{-0.575} \gdef\@sop@curxoff{-8/1.5}\fi
    }
    \fi
    % Typeset Appendix
\end{tikzpicture}%0.75*\sop@len@header
\fi
}
\fi

% \cehead{%
% \begin{tikzpicture}[remember picture, overlay]
%     \coordinate (tl@pf@lockpos) at ($(current page.north west)+(5.5cm,-1.25cm)$);
%     \node[cprimary,right=2pt] at (tl@pf@lockpos) {\Huge$\thepage$};
%     % Cur section rectangle
%     \fill[cakzent] (tl@pf@lockpos) rectangle ++(-5.5cm,0.55pt);
%     \node[above left,yshift=-1pt,font=\footnotesize,text width=5cm,align=right] at (tl@pf@lockpos) {\strut\expandafter\ifx\expandafter\\\rightmark\\ \leftmark\else \rightmark\fi};
%     % \node[below right,yshift=1pt,font=\footnotesize,text width=5cm,align=left] at (tl@pf@lockpos) {\strut\sop@chapterbubbles};
%     \foreach \i in {1,...,\thesop@counter@chapter@counter}{%
%         % \typeout{\i:\thesop@counter@chapter@counter:\thechapter x}
%         \coordinate (chapnode\i) at ($(tl@pf@lockpos)-(\i/1.5-1/1.5+0.33,0.35)$);
%         \ifnum\i=0\thechapter  % in current chapter
%             \sop@chapblob{\i}{clight}{chapnode\i}%
%         \else \sop@chapblob{\i}{white}{chapnode\i}%
%         \fi\hfill{}
%     }
% \end{tikzpicture}%0.75*\sop@len@header
% }

% Structure Styles

% \input RoyalIn.fd
% \def\sop@font@roya#1{\begingroup\usefont{U}{RoyalIn}{xl}{n}#1\endgroup}

\def\sop@sepline{%
    {\color{cakzent}{\Huge$\llap{$\diamond$}\hspace*{-1pt}$}\rule[0.41\baselineskip]{\linewidth}{0.55pt}{\Huge$\hspace*{-1pt}\rlap{$\diamond$}$}}%
}

\ifsop@usebook@ \renewcommand\chapterformat{} %
\renewcommand\chapterlinesformat[3]{%
\vspace*{-2.5em}
\ifnum\value{chapter}>0
\begin{center}
    \vspace*{-\topsep}
    \thechapter
\end{center}
\fi
{\color{chdtext}{\Huge$\llap{$\diamond$}\hspace*{-1pt}$}\rule[0.22\baselineskip]{\linewidth}{0.55pt}{\Huge$\hspace*{-1pt}\rlap{$\diamond$}$}}%
    \begin{center}
        \vspace*{-\topsep}
        \color{chdtext}#2#3%
    \end{center}
    {\color{chdtext}{\Huge$\llap{$\diamond$}\hspace*{-1pt}$}\rule[0.22\baselineskip]{\linewidth}{0.55pt}{\Huge$\hspace*{-1pt}\rlap{$\diamond$}$}}%
}%
\fi

\renewcommand\sectionlinesformat[4]{%
    \def\tmp@a{#1}\def\tmp@b{section}\ifx\tmp@a\tmp@b
    \parbox{\linewidth}{%
    {\color{chdtext}\strut#3#4}%{\Large\hspace*{-1ex}$\llap{$\diamond$}$\hspace*{1ex}}
    \\[-0.7\baselineskip]
    \settowidth{\sop@len@tmp@a}{\strut#3#4}\pgfmathsetmacro\@sop@tmp@chk{\sop@len@tmp@a<(\linewidth-14pt)}
    \ifnum\@sop@tmp@chk=1\addtolength{\sop@len@tmp@a}{14pt}\else\setlength{\sop@len@tmp@a}{\linewidth}\fi
    {\normalsize\color{chdtext}{\large$\llap{$\diamond$}\hspace*{-0.75pt}$}\rule[0.186\baselineskip]{\sop@len@tmp@a}{0.55pt}}}
    \else#3#4\fi
}%

\RedeclareSectionCommands[
    beforeskip=-3.25ex plus -0.5ex minus -0.2ex,
    runin=bysign,
    afterindent=bysign,
    afterskip=\parskip%
    % font=\,
]{paragraph,subparagraph}

\setkomafont{section}{\LARGE}
\setkomafont{subsection}{\large}
\setkomafont{subsubsection}{\normalsize}
\setkomafont{paragraph}{\mdseries\itshape}

% "Futura" Font

% I've invested round about 2 hours trying to set up a portable way to use the
% Futura-Font. As it worked, but wasn't portable, i've desided to recreate the
% letters in tikz and use them instead

\def\sop@font@futura@color@current{cwhite}

\newcounter{sop@counter@font@carriage@posX}
\newcounter{sop@counter@font@carriage@posY}

\def\@sop@font@futura@carriage{%
\thesop@counter@font@carriage@posX cm,-\thesop@counter@font@carriage@posY cm%
}
\def\@sop@font@futura@carriage@nl{
    \setcounter{sop@counter@font@carriage@posX}{0}
    \addtocounter{sop@counter@font@carriage@posY}{15}
}
\def\@sop@font@futura@carriage@reset{
    \setcounter{sop@counter@font@carriage@posX}{0}
    \addtocounter{sop@counter@font@carriage@posY}{0}
}
\def\@sop@font@futura@carriage@indent#1{\setcounter{sop@counter@font@carriage@posX}{#1}}
% 40x99 [off: 13] ; middle: 47-|17 -- -53,115 -| 47 17
\def\sop@font@futura@letter@N{
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) -- ++(32mm,0) -- ++(0,25mm) -- ++(-32mm,99mm-25mm) -- cycle; % lower left triangle
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(40mm+13mm,0) -| ++(47mm,17mm) -- ++(-53mm,++115mm) -| ++(-47mm,-15mm) -- cycle ; % middle block
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(101mm,34mm) -- ++(-32mm,99mm-25mm) |- ++(32mm,25mm) -- cycle; % upper right triangle
    \addtocounter{sop@counter@font@carriage@posX}{12}
}

\def\sop@font@futura@letter@O{
    \begin{scope}
        \clip (\@sop@font@futura@carriage) rectangle ++ (53mm,132mm);
        \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage)++(53mm,66mm) ellipse (53mm and 68mm);
    \end{scope}
    \begin{scope}[xshift=007mm]
        \clip (\@sop@font@futura@carriage)++ (53mm,0mm) rectangle ++(53mm,132mm);
        \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage)++(53mm,66mm) ellipse (53mm and 68mm);
    \end{scope}
    \addtocounter{sop@counter@font@carriage@posX}{13}
}

\def\sop@font@futura@letter@T{
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage)++(0,75mm) |- ++(29mm,57mm) -- cycle; % leftT
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage)++(34mm,0) rectangle ++(43mm,132mm); % TBlock
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage)++(82mm,132mm) -| ++(29mm,-57mm) -- cycle; % right
    \addtocounter{sop@counter@font@carriage@posX}{13}
}

\def\sop@font@futura@letter@I{
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) rectangle ++(43mm,132mm); % TBlock
    \addtocounter{sop@counter@font@carriage@posX}{6}
}

\def\sop@font@futura@letter@M{
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) -- ++(44mm,0) -- ++(-22mm,89mm) -- cycle; % lower left triangle
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(44mm+9mm,0) -- ++(46mm,0) -- ++(-32mm,132mm) -- ++(-34mm,0) -- ++(-7mm,-27mm) -- cycle ; % middle block
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(109mm,0) -- ++(46mm,0) -- ++(-32mm,132mm) -- ++(-34mm,0) -- ++(-7mm,-27mm) -- cycle ; % outer block

    \addtocounter{sop@counter@font@carriage@posX}{17}
}

\def\sop@font@futura@letter@E{
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) rectangle ++(43mm,132mm); % TBlock

    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(46mm,0) -| ++(47mm,57mm) -- cycle; % lower right triangle
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(46mm,132mm) -| ++(47mm,-57mm) -- cycle; % upper right triangle

    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(46mm,66mm) -- ++(29mm,24mm) -- ++(0,-48mm) -- cycle; % upper right triangle

    \addtocounter{sop@counter@font@carriage@posX}{11}
}

\def\sop@font@futura@letter@D{
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) rectangle ++(43mm,132mm); % TBlock
    \begin{scope}[xshift=-2mm]
        \clip (\@sop@font@futura@carriage)++ (53mm,0mm) rectangle ++(53mm,132mm);
        \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage)++(53mm,66mm) ellipse (53mm and 68mm);
    \end{scope}
    \addtocounter{sop@counter@font@carriage@posX}{12}
}

% 16x21
\def\sop@font@futura@letter@S{
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) -- ++(42mm/1.25,0) -- ++(-42mm/1.25,60.125mm/1.25) -- cycle; % lower left triangle
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(40mm+25mm,5mm) arc[start angle=282,end angle=360+35,radius=23.5mm] -- ++(90+35:72mm) arc[start angle=180+35,end angle=180+35-90,radius=23.5mm] -- ++(180+5:7mm) arc[start angle=95, end angle=180+35,radius=23.5mm+15mm] -- ++(-55:55mm) arc[start angle=90-55,end angle=55-90,radius=23.5mm] -- cycle; % middle block
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(82mm,34mm+43.875mm*1.25) -- ++(-42mm/1.25,55.125mm/1.25) -- ++(42mm/1.25,0) -- cycle; % upper right triangle
    \addtocounter{sop@counter@font@carriage@posX}{12}
}

\def\sop@font@futura@letter@P{
    \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) rectangle ++(43mm,132mm); % TBlock
    \begin{scope}[xshift=-2mm]
        \clip (\@sop@font@futura@carriage)++ (53mm,46mm) rectangle ++(53mm,132mm);
        \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage)++(53mm,64mm+68mm/2.35) ellipse (43mm and 68mm/1.75);
    \end{scope}
    \addtocounter{sop@counter@font@carriage@posX}{11}
}

\def\sop@font@futura@letter@Y{
    \begingroup\def\sop@scaler{*0.75}
        \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(65mm\sop@scaler,56mm) --++(0,-56mm) -| ++(43mm\sop@scaler,62mm) -- ++(-65mm\sop@scaler,132mm-62mm) -- ++(-43mm\sop@scaler,0) -- cycle; % TBlock
        \fill[\sop@font@futura@color@current] (\@sop@font@futura@carriage) ++(65mm\sop@scaler,132mm) -- ++(45mm\sop@scaler,-50mm) --  ++(45mm\sop@scaler,50mm) --cycle; % upper right triangle
    \endgroup
    \addtocounter{sop@counter@font@carriage@posX}{12}
}

% Titlepage

\def\sop@tp@plussymb{+}
\def\sop@titlepage@groupnum@iter#1#2\@nil{%
    \def\tmp@a{#1}%
    \ifx\tmp@a\sop@tp@plussymb\else
    %\rotatebox{-4}{$\mathbf{#1}\hspace*{-1pt}$}%
    $\mathbf{#1}$%
        \def\tmp@a{#2}%
        \ifx\tmp@a\sop@tp@plussymb\else
             \sop@titlepage@groupnum@iter#2+\@nil
        \fi
    \fi
}

\def\sop@titlepage@groupnum#1{\edef\@tmp{\noexpand\sop@titlepage@groupnum@iter#1+\noexpand\@nil}\@tmp}

\def\sop@ntts{
    \@sop@font@futura@carriage@reset
    \sop@font@futura@letter@N
    \sop@font@futura@letter@O
    \@sop@font@futura@carriage@nl
    \sop@font@futura@letter@T
    \sop@font@futura@letter@I
    \sop@font@futura@letter@M
    \sop@font@futura@letter@E
    \@sop@font@futura@carriage@nl
    \@sop@font@futura@carriage@indent{13}
    \sop@font@futura@letter@T
    \sop@font@futura@letter@O\coordinate (ct@groupnum) at(\@sop@font@futura@carriage);
    \@sop@font@futura@carriage@nl
    \@sop@font@futura@carriage@indent{27}
    % \sop@font@futura@letter@D
    % \sop@font@futura@letter@I
    % \sop@font@futura@letter@E
    % \@sop@font@futura@carriage@nl
    % \@sop@font@futura@carriage@indent{27}
    \sop@font@futura@letter@S
    \sop@font@futura@letter@P
    \sop@font@futura@letter@Y\coordinate (ct@ystraw) at(\@sop@font@futura@carriage);
}

% set the titlepage
\def\sop@layout@titlepage{
    \begin{titlepage}
        \pagecolor{ctpbackground}
        % Here we will place the Tag (Sopra....)
        % \scalebox{2}{\fontsize{30}{30}\selectfont\color{ctpsymbol}\sop@font@head{\sop@register@tag}}
        \hbox{}\hfill\llap{\begin{tikzpicture}[scale=0.079]
            \def\sop@font@futura@color@current{ctptext}
            \sop@ntts
            % lets draw a strw for 'Y'
            \node[\sop@font@futura@color@current] at ($(ct@ystraw)+(-22.5mm,132mm)$) {\scriptsize\bfseries/};
            % \coordinate (olive) at($(ct@ystraw)+(-34mm,105mm)$);
            % \fill[ctpsymbol,rotate around={45:(olive)},] (olive) ellipse (9mm and 8.15mm);
            % here we will plant the group-Tag at the 007 position, having a lot of fun :D
            \ifx\sop@register@groupnum\@empty\else
            \node[right=0.1cm,yshift=0.4cm,font=\fontsize{17}{17}\selectfont\sffamily,ctpsymbol] (ct@gnumt) at (ct@groupnum) {\sop@titlepage@groupnum{\sop@register@groupnum}};
            \node[right,yshift=0.10cm,xshift=0.4cm,font=\fontsize{8}{8}\selectfont\sffamily,ctpsymbol] at (ct@gnumt){\ifx\sop@register@group\@empty Team\else\rlap{\sop@register@group}\fi};
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
        \begin{minipage}{0.6\linewidth}\footnotesize\color{ctpsymbol}
            \ifx\sop@register@duedate\@empty\else
                \begingroup\hbox{}\quad\scriptsize\DateConvert{\sop@register@duedate}\sop@AfterDate\endgroup\\[-0.2\baselineskip]%
            \fi
            {\color{ctpsymbol}$\Large\llap{$\diamond$}\hspace*{-1pt}$\rule[0.275\baselineskip]{0.45\linewidth}{0.55pt}\\}%
            \ignorespaces{{\bfseries{}Bearbeitung:}}\\
            \ignorespaces\hbox{}\quad\parbox{\linewidth}{\typesetAuthors}\bigskip\par
            \ifx\sop@register@brief\@empty\else
            \ignorespaces{\bfseries{}Beschreibung:}\smallskip\\
            \hbox{}\quad\parbox{\linewidth}{\sop@register@brief}\fi
        \end{minipage}\vspace*{2em}
    \end{titlepage}
    \clearpage\nopagecolor
    \thispagestyle{empty}%
    \hbox{}\qquad\begin{tikzpicture}[scale=0.12]
        \def\sop@font@futura@color@current{cprimary}
            \@sop@font@futura@carriage@reset
            \sop@ntts
            % lets draw a strw for 'Y'
            \node[\sop@font@futura@color@current] at ($(ct@ystraw)+(-22.5mm,132mm)$) {\bfseries/};
            % \coordinate (olive) at($(ct@ystraw)+(-34mm,105mm)$);
            % \fill[cakzent,rotate around={45:(olive)},] (olive) ellipse (9mm and 8.15mm);
            % here we will plant the group-Tag at the 007 position, having a lot of fun :D
    \end{tikzpicture}
    \hbox{}\vfill\begingroup\scriptsize
    \begin{flushright}
        \parbox{9cm}{
        \textbf{$-\,$\DateConvert{2019-12-15}$\,-$}\\
        \color{cprimary}Dieses Layout wurde für das Softwaregrundprojekt
        im Wintersemester 2019/2020 von Florian Sihler im Rahmen des
        Informatikstudiums an der Universität Ulm vollständig in \LaTeXe{} erstellt.}
    \end{flushright}\endgroup
    %\ifsop@usebook@\else\clearpage\fi
    \clearpage
}

\AtBeginDocument{
    \addtocontents{toc}{\protect\pagestyle{scrheadings}}%
    \sop@layout@titlepage
}

\ifsop@notoc@\else%
% \addtocontents{toc}{\protect\renewcommand{\protect\baselinestretch}{0.9}}
\makeatletter
\newcommand\TableOfContents[1][]{\hypertarget{toc.I}\relax%
    \section*{\contentsname}\relax%
    \markright{I, \xcontentname}
    \ifx!#1!\else\vspace*{-\topsep}#1\par\fi%
    \begingroup\@starttoc{toc}\endgroup%
}\fi

% Listings (sopra-listings), Attachments (sopra-attachments,...)

\def\sop@SetListing{
    \makeatletter
    \colorlet{sol@colors@lst@keywordA}{cprimary} % e.g.: class, public, static...
    \colorlet{sol@colors@lst@keywordB}{cakzent} % e.g.: int, double ...
    \colorlet{sol@colors@lst@keywordC}{cakzent!85!black} % e.g.: class-names?
    \colorlet{sol@colors@lst@numbers}{chighlight!90!cprimary} % well, numbers
    \colorlet{sol@colors@lst@literals}{cakzent!90!brown} % well, numbers
    \colorlet{sol@colors@lst@comments}{clight!10!gray} % well, comments
    \colorlet{sol@colors@lst@highlight}{chighlight} % sweetspots
    \sol@list@define@styles{%
        {keywordA:      \color{sol@colors@lst@keywordA}\bfseries},%
    }
    \makeatother
}


\def\sop@SetAttachment{
    \makeatletter
    \attachfilesetup{%
        author={\sop@register@authors},
        color=cakzent,
        icon=Tag,
        mimetype=text/plain % we assume
    }
    \makeatother
}

\def\sop@SetTables{
    \makeatletter
    \colorlet{HeaderColor}{cprimary!80!white}
    \colorlet{NextHeaderColor}{cprimary!60!white}
    \colorlet{MaterialHeaderColor}{HeaderColor}
    \colorlet{NextMaterialHeaderColor}{NextHeaderColor}
    \makeatother
}

\def\sop@SetModels{
    \tikzumlset{fill usecase=cprimary!70!white, fill system=cprimary!20!white, fill state=cprimary!70!white,fill object=cprimary!70!white, fill class=cprimary!70!white,fill note=cprimary, font=\small\ttfamily}
}

\ifsop@applystyle@
\AtBeginDocument{
    \@ifundefined{thesolversion}{}{\sop@SetListing} % listings
    \@ifundefined{thesoaversion}{}{\sop@SetAttachment} % attachments
    \@ifundefined{thesorversion}{}{\sop@SetTables} % requirements
    \@ifundefined{thesotversion}{}{\sop@SetTables} % tables
    \@ifundefined{thesomversion}{}{\sop@SetModels} % Models
}
\fi
\endinput