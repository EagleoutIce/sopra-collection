% Version: 1.0
% Author:  Florian Sihler, 02.12.2019
% This LaTeX2e Class should provide the basic layout to be used for
% all documents created by sopra-team-020.
%                      ulm university, WiSe2019
% Development notes:
%    All internal commands and registers will be prefixed with 'sob@
%    as 'sob' fits the creation-Process of this Package perfectly :P
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sopra-base}[2019/12/02 EagleoutIce - Basic Documentclass for the sopra-team-020]
% this class won't base on KOMA or other nice Documentclass :/
\LoadClass{article}
% Lengths and Registers
\newcounter{sobversion} \setcounter{sobversion}{1001}

\newif\ifsob@usedraft@% in draft mode we won't render everything
\newif\ifsob@printmode@% in print, no colors will be used
\newif\ifsob@showmail@% with show mail, the mail adresses of the authors will
                      % be used
\newlength\sob@len@parindent \sob@len@parindent=\parindent
\newlength\sob@len@logoheight \sob@len@logoheight=2.6cm
\newlength\sob@len@header \sob@len@header=2cm % header padding

\newcounter{sob@counter@tmp@a}

% Class-Args
% draftmode:
\DeclareOption{draft}{ \sob@usedraft@true }%
\DeclareOption{final}{ \sob@usedraft@false }%
% parindent:
\DeclareOption{nopar}{ \parindent=\z@ }%
\DeclareOption{dopar}{ \parindent=\sob@len@parindent }%
% font:
\DeclareOption{sffont}{ \renewcommand*\familydefault{\sfdefault} }%
\DeclareOption{rmfont}{ \renewcommand*\familydefault{\rmdefault} }%
% mode
\DeclareOption{defaultmode}{ \sob@printmode@false }% probably shouldn't be used
\DeclareOption{print}{ \sob@printmode@true }%
% mail show
\DeclareOption{showmail}{ \sob@showmail@true }
\DeclareOption{hidemail}{ \sob@showmail@false }

\ExecuteOptions{final,nopar,sffont,defaultmode,showmail}% set it explicitly
\ProcessOptions\relax

% Basic Packages
\RequirePackage{tikz} % we need it anyways - will load xcolor
\usetikzlibrary{calc}
% encoding:
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
% language
\RequirePackage[english,main=ngerman]{babel}
% layout
\pgfmathsetmacro\sob@headheight{2.6cm + \sob@len@logoheight/2}
\edef\sob@footheight{\the\dimexpr\sob@len@header-8mm\relax}
\RequirePackage[margin=\sob@len@header,a4paper,%
    bottom=\sob@footheight,headheight=13.3pt]{geometry}
% beautify:
\RequirePackage{sfmath,lmodern,microtype,scrlayer-scrpage,titlesec}
\RequirePackage{enumitem}
\RequirePackage[all]{nowidow}

\RequirePackage[hidelinks]{hyperref}

% Color Definitions
\definecolor{sob@col@uulm}{RGB}{130,161,180}            % RGB(130,161,180)
\definecolor{sob@col@uulm@akzent}{RGB}{169,162,141}     % RGB(169,162,141)
\definecolor{sob@col@uulm@cs}{RGB}{163,038,059}         % RGB(163,038,59)

\definecolor{sob@col@text@header}{RGB}{255,255,255}     % RGB(255,255,255)
\definecolor{sob@col@text@sub}{RGB}{000,000,000}        % RGB(000,000,000)

% Color Palette & color styling
\ifsob@printmode@ \selectcolormodel{gray}%
\else \selectcolormodel{rgb}\fi %\maskcolors[cmy]{gray} \fi

% some styling commands
\long\def\sob@@imptext#1{\slshape\color{sob@col@uulm@cs}#1}
\newcommand\imptext[1]{\begingroup\sob@@imptext{#1}\endgroup}
\long\def\sob@@notetext#1{\color{sob@col@uulm@akzent}#1}
\newcommand\notetext[1]{\begingroup\sob@@notetext{#1}\endgroup}

% lengthts:
\def\baselinestretch{1.1}
\parskip=.75em

% beautify the footnotes:
\renewcommand*\thefootnote{$\langle$\textbf{\arabic{footnote}}$\rangle$}
\renewcommand*\thempfootnote{$\langle$\textbf{\roman{mpfootnote}}$\rangle$}

% differenz section styles
\renewcommand{\section}{\@startsection{section}{1}{\z@}
{-4ex \@plus 1ex \@minus -.4ex}
{1ex \@plus.2ex }
{\normalfont\Large\bfseries}}
\renewcommand{\subsection}{\@startsection {subsection}{2}{\z@}
{-3ex \@plus .1ex \@minus -.4ex}
{.5ex \@plus.2ex }
{\normalfont\large\bfseries}}
\renewcommand{\subsubsection}{\@startsection {subsubsection}{3}{\z@}
{-2ex \@plus .1ex \@minus -.2ex}
{.2ex \@plus.2ex }
{\normalfont\normalsize\sffamily\itshape}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}
{-2ex \@plus .2ex \@minus .2ex}
{.1ex}
{\normalfont\small\itshape}}

% Helper Methods

\def\sob@thesobversion#1#2#3#4\@nil{{v#1.#2.#3#4}}
\edef\sob@version@str{\noexpand\sob@thesobversion\arabic{sobversion}\noexpand\@nil}
\edef\thesobversion{\sob@version@str}

\def\sob@mail#1{\href{mailto:#1}{#1}}
\let\mail\sob@mail%
\def\sob@month@to@name#1{%
    \ifcase#1\or{Januar}\or{Februar}\or{M\"{a}rz}\or{April}\or{Mai}\or{Juni}%
    \or{Juli}\or{August}\or{September}\or{Oktober}\or{November}\or{Dezember}%
    \else\@ctrerr\fi
}



\def\sob@date@convert#1-#2-#3\@nil{%
    \begingroup#3.\space{\sob@month@to@name{#2}}\space{}#1\endgroup
}
\def\DateConvert#1%
{\expandafter\ifx\expandafter!#1!\else\expandafter\sob@date@convert#1\@nil\fi}

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
    {\expandafter\noexpand\gdef\csname sob@register@\field\endcsname{##2}%
    \expandafter\noexpand\gdef\csname sob@register@short@\field\endcsname{##1}}
    \expandafter\xdef\csname\field @noopt\endcsname##1%
    {\expandafter\noexpand\gdef\csname sob@register@\field\endcsname{##1}%
    \expandafter\noexpand\gdef\csname sob@register@short@\field\endcsname{##1}}
    \expandafter\gdef\csname sob@register@\field\endcsname{}
    \expandafter\gdef\csname sob@register@short@\field\endcsname{}
}


% iterators for handling and parsing author information.
\def\sob@@add@author#1{%
    \let\sob@@tmp@old@authors\sob@register@authors
    \ifx\sob@@tmp@old@authors\@empty
    \xdef\sob@register@authors{#1}\else
    \xdef\sob@register@authors{\sob@@tmp@old@authors,#1}\fi
}
\let\addAuthor\sob@@add@author

\ifsob@showmail@
\def\sob@@parse@author#1 (#2)\@nil{\begingroup#1 (\mail{#2})\endgroup}
\else
\def\sob@@parse@author#1 (#2)\@nil{\begingroup\href{mailto:#2}{#1}\endgroup}
\fi
\def\sob@@typeset@author#1{%
    \setcounter{sob@counter@tmp@a}{0}% start with an offset
    \foreach \@tmp in {#1}%
        {\ifx\@tmp\@empty\else
            \stepcounter{sob@counter@tmp@a}\fi}%
    \edef\sob@authors@totallength{\arabic{sob@counter@tmp@a}}%
    \setcounter{sob@counter@tmp@a}{0} % stored the length of the list
    \foreach \sob@@tmp@curauthor in {#1} {%
        \ifx\sob@@tmp@curauthor\@empty%empty => ignore
        \else\stepcounter{sob@counter@tmp@a}%
            \ifnum\thesob@counter@tmp@a>1%
            \ifnum\thesob@counter@tmp@a=\sob@authors@totallength
                ~und \else,\space\fi\fi
            \expandafter\sob@@parse@author\sob@@tmp@curauthor\@nil
        \fi%
    }%
}

\def\sob@@setteam#1 #2\@nil{%
    \gdef\sob@register@group{#1}\gdef\sob@register@groupnum{#2}%
}
\newcommand\setTeam[1]{\expandafter\sob@@setteam#1\@nil}

\newcommand\typesetAuthors{%
    \protected@edef\@tmp{\noexpand\sob@@typeset@author{\sob@register@authors}}\@tmp}

% the title field can be set by '\title{<Your title here>}'
\AtBeginDocument{\hypersetup{
    pdftitle=\sob@register@title,
    pdfauthor=\sob@register@authors,
    pdfsubject=\sob@register@subtitle,
    pdfkeywords=\sob@register@keywords,
    pdfcreator={LaTeX with hyperref and the sopra-base class}
}}


% Set the Title for the maketitle command
\def\sob@team@name{Gruppe}

\renewcommand{\maketitle}{
\thispagestyle{empty}
\begin{tikzpicture}[remember picture,overlay,
    tnode/.style={font=\large,sob@col@uulm@akzent!50!black,left}]
\ifx\sob@register@groupnum\@empty
\node[above right,sob@col@uulm@akzent,font=\small] at%
($(current page.north west)+(\sob@len@header,-\sob@len@logoheight/2+1mm)$)
{\sob@team@name}; \node[right,sob@col@uulm@akzent] at%
($(current page.north west)+(\sob@len@header,-\sob@len@logoheight/2-3mm)$)
{\Huge\sob@register@group};
\else
\usetikzlibrary{shapes}
\node[right,sob@col@uulm@akzent] at%
    ($(current page.north west)+(\sob@len@header,-\sob@len@logoheight/2)$)%
    {\Huge\sob@register@group\quad\expandafter\tikz[baseline=-.6ex]{%
        \node[regular polygon, regular polygon sides=6, draw,%
        sob@col@uulm@akzent, fill=sob@col@uulm@akzent!60,
        inner sep=1.5/1.635,transform shape,minimum width=2em] at (0,0)
        {\color{sob@col@uulm@akzent!50!black}\sob@register@groupnum};}};
\fi
\node[left=1.5pt,scale=.75] at($(current page.north east)+(-\sob@len@header,-\sob@len@logoheight/2)$) {\uulmlogo{\ifsob@printmode@ black\else black!80!white\fi}};
\fill[sob@col@uulm@cs] %
    ($(current page.north west)+(0,-\sob@len@logoheight)$) rectangle
    ($(current page.north east)+(0,-\sob@len@logoheight-1.2cm)$);
\node[font=\huge,white,left] at%
    ($(current page.north east)+(-\sob@len@header,-\sob@len@logoheight-6mm)$)
    {\strut\sob@register@title};

\fill[sob@col@uulm@akzent!60]
        ($(current page.north west)+(0,-\sob@len@logoheight-12mm)$) rectangle%
        ($(current page.north east)+(0,-\sob@len@logoheight-28mm)$);
% set subtitle:
\node[tnode] at ($(current page.north east)+%
        (-\sob@len@header,-\sob@len@logoheight-2cm+.65\baselineskip)$)
        {\strut\sob@register@subtitle};
% set authors:
\node[tnode,font=\small] at ($(current page.north east)+%
        (-\sob@len@header,-\sob@len@logoheight-2cm-.65\baselineskip)$)
        {\strut\typesetAuthors};
% due date
\node[tnode,right] at ($(current page.north west)+%
        (\sob@len@header,-\sob@len@logoheight-2cm-.65\baselineskip)$)
        {\strut\bfseries\DateConvert{\sob@register@duedate}};
\end{tikzpicture}
\vspace*{\sob@headheight pt}\par
}

% pagestyle
\clearpairofpagestyles
\renewcommand\headfont{\normalfont}
\def\headersplit{\space$\mid$\space}
\chead{%
\begin{tikzpicture}[remember picture, overlay]
    \fill[sob@col@uulm@cs]($(current page.north west)+(15mm,0)$)
        rectangle ($(current page.north west)+(0,-8mm)$) %
        node[midway,centered,text=sob@col@text@header] {\strut\pagemark};
    \fill[sob@col@uulm@akzent!40] (current page.north east) rectangle
        ($(current page.north west)+(15mm,-8mm)$);
    \path ($(current page.north west)+(\sob@len@header,0)$) -- ++(0,-8mm) node[right=\z@,text=sob@col@uulm@akzent!50!black,inner sep=\z@,pos=.5]%
        {\strut\sob@register@title\headersplit\sob@register@short@subtitle};
\end{tikzpicture}%.75*\sob@len@header
}

% Logo stuff
% PGF commands, generated using http://sourceforge.net/projects/eps2pgf/
\newcommand*\uulmlogo[1]{%
\ifsob@usedraft@\else
\begin{tikzpicture}[y=.8\p@, x=.8\p@,yscale=-1,every path/.style={fill=#1,even odd rule}]
    \path (152.1,29.3)--(141.0,29.3)--(141.0,50.2)..controls
    (141.0,55.7) and (139.3,64.4)..(131.2,64.4)..controls
    (124.1,64.4) and (124.0,57.3)..(124.0,52.1)--
    (124.0,29.3)--(112.9,29.3)--(112.9,56.3)..controls
    (112.9,65.9) and (117.3,73.1)..(127.4,73.1)..controls
    (133.2,73.1) and (138.0,70.4)..(141.4,66.3)--
    (141.6,66.3)--(141.6,72.1)--(152.1,72.1)--
    (152.1,29.3)--cycle;
\path[rounded corners=\z@] (210.5,7.8) rectangle (215.7,72.1);
\path (199.2,11.2)--(196.9,11.2)--(196.9,8.3)--
(195.6,8.7)--(195.6,11.1)--(193.6,11.1)--
(193.6,12.2)--(195.6,12.2)--(195.6,18.1)..controls
(195.6,20) and (195.7,21.5)..(197.9,21.5)..controls
(198.5,21.5) and (199.1,21.3)..(199.4,21.2)--
(199.3,20.2)..controls(198.9,20.3) and (198.6,20.4)..
(198.1,20.4)..controls(197.1,20.4) and (196.7,19.6)..
(196.7,18.7)--(196.7,12.1)--(199.0,12.1)--
(199.0,11.2)--cycle(185.7,9.5)--(187.2,9.5)--
(187.2,7.8)--(185.7,7.8)--(185.7,9.5)--
cycle(189.1,9.5)--(190.6,9.5)--(190.6,7.8)--
(189.1,7.8)--(189.1,9.5)--cycle(190.5,16.8)..controls
(190.5,17.9) and (190.4,20.5)..(187.5,20.5)..controls
(186.3,20.5) and (185.4,20)..(185.4,18.7)..controls
(185.4,16.5) and (188.0,16.3)..(190.2,16.3)--
(190.6,16.3)--(190.6,16.8)--cycle(190.6,21.3)--
(191.8,21.3)..controls(191.7,20.6) and (191.7,20)..
(191.7,19.2)--(191.7,14.7)..controls(191.7,12.1) and
(190.6,10.9)..(188.1,10.9)..controls(187.2,10.9) and
(185.9,11.2)..(185.1,11.6)--(185.1,12.8)..controls
(186.0,12.2) and (187.0,12)..(188.1,12)..controls
(189.8,12) and (190.4,12.9)..(190.4,14.6)--
(190.4,15.1)--(190.2,15.1)..controls(187.6,15.1) and
(184.0,15.3)..(184.0,18.7)..controls(184.0,19.6) and
(184.5,21.6)..(187.3,21.6)..controls(188.6,21.6) and
(190.0,20.9)..(190.5,19.7)--(190.5,19.7)--
(190.5,21.3)--cycle(182.4,11.2)--(180.1,11.2)--
(180.1,8.3)--(178.8,8.7)--(178.8,11.1)--
(176.8,11.1)--(176.8,12.2)--(178.8,12.2)--
(178.8,18.1)..controls(178.8,20) and (178.9,21.5)..
(181.1,21.5)..controls(181.7,21.5) and (182.3,21.3)..
(182.6,21.2)--(182.5,20.2)..controls(182.1,20.3) and
(181.8,20.4)..(181.3,20.4)..controls(180.3,20.4) and
(179.9,19.6)..(179.9,18.7)--(179.9,12.1)--
(182.2,12.1)--(182.2,11.2)--cycle(174.7,6.8)--
(173.4,6.8)--(173.4,8.5)--(174.7,8.5)--
(174.7,6.8)--cycle(173.5,21.3)--(174.8,21.3)--
(174.8,11.2)--(173.5,11.2)--(173.5,21.3)--
cycle(164.7,21.1)..controls(165.6,21.5) and (166.6,21.6)
..(167.5,21.6)..controls(169.0,21.6) and (171.0,20.9)..
(171.0,18.7)..controls(171.0,15.4) and (166.0,15.6)..
(166.0,13.7)..controls(166.0,12.4) and (166.9,12)..
(168.2,12)..controls(168.9,12) and (169.8,12.2)..
(170.4,12.5)--(170.5,11.4)..controls(169.6,11.1) and
(168.5,10.9)..(168.0,10.9)..controls(166.3,10.9) and
(164.7,11.7)..(164.7,13.7)..controls(164.7,16.6) and
(169.6,16.3)..(169.6,18.7)..controls(169.6,19.9) and
(168.5,20.5)..(167.4,20.5)..controls(166.4,20.5) and
(165.5,20.2)..(164.8,19.9)--(164.7,21.1)--
cycle(158.9,21.3)--(160.2,21.3)--(160.2,16.3)..
controls(160.2,14.5) and (160.7,12.2)..(162.7,12.2)..
controls(163.0,12.2) and (163.4,12.2)..(163.6,12.3)--
(163.6,11)..controls(163.4,10.9) and (163.0,10.9)..
(162.7,10.9)..controls(161.4,10.9) and (160.6,12)..
(160.1,13.1)--(160.1,13.1)--(160.1,11.1)--
(158.8,11.1)..controls(158.9,11.8) and (158.9,12.3)..
(158.9,13.4)--(158.9,21.3)--cycle(149.4,15.6)..
controls(149.4,13.9) and (150.5,12.1)..(152.4,12.1)..
controls(154.3,12.1) and (155.0,13.9)..(155.0,15.6)--
(149.4,15.6)--cycle(155.6,19.8)..controls(155.0,20.2)
and (153.7,20.6)..(152.8,20.6)..controls(150.6,20.6)
and (149.5,18.9)..(149.5,16.7)--(156.4,16.7)--
(156.4,16)..controls(156.4,13.3) and (155.2,11)..
(152.4,11)..controls(149.8,11) and (148.1,13.2)..
(148.1,16.3)..controls(148.1,19.3) and (149.4,21.6)..
(152.7,21.6)..controls(153.6,21.6) and (154.8,21.4)..
(155.6,21)--(155.6,19.8)--cycle(146.9,11.2)--
(145.6,11.2)--(142.7,20)--(142.7,20)--
(139.9,11.2)--(138.5,11.2)--(141.9,21.3)--
(143.4,21.3)--(146.9,11.2)--cycle(136.6,6.8)--
(135.3,6.8)--(135.3,8.5)--(136.6,8.5)--
(136.6,6.8)--cycle(135.3,21.3)--(136.6,21.3)--
(136.6,11.2)--(135.3,11.2)--(135.3,21.3)--
cycle(124.1,21.3)--(125.4,21.3)--(125.4,15.7)..
controls(125.4,14) and (126.1,12)..(128.4,12)..
controls(130.1,12) and (130.8,13.2)..(130.8,15.1)--
(130.8,21.3)--(132.1,21.3)--(132.1,14.8)..controls
(132.1,12.6) and (131.1,10.9)..(128.6,10.9)..controls
(126.5,10.9) and (125.7,12)..(125.3,13)--
(125.3,13)--(125.3,11.2)--(124.1,11.2)..controls
(124.2,12) and (124.2,12.8)..(124.2,13.6)--
(124.2,21.3)--cycle(120.9,11.2)--(119.6,11.2)--
(119.6,16.8)..controls(119.6,18.5) and (118.9,20.5)..
(116.6,20.5)..controls(114.9,20.5) and (114.2,19.3)..
(114.2,17.4)--(114.2,11.2)--(113.0,11.2)--
(113.0,17.7)..controls(113.0,19.9) and (114.0,21.6)..
(116.5,21.6)..controls(118.6,21.6) and (119.4,20.5)..
(119.8,19.6)--(119.8,19.6)--(119.8,21.4)--
(121.0,21.4)..controls(120.9,20.6) and (120.9,19.8)..
(120.9,19)--(120.9,11.2)--cycle;
\path (198.6,29.2)--(193.3,29.2)--(193.3,52.9)..controls
(193.3,60) and (190.3,68.5)..(180.6,68.5)..controls
(173.3,68.5) and (170.4,63.3)..(170.4,55.2)--
(170.4,29.2)--(165.1,29.2)--(165.1,56.6)..controls
(165.1,66) and (169.1,73.1)..(179.7,73.1)..controls
(188.6,73.1) and (191.8,68.3)..(193.5,64.5)--
(193.7,64.5)--(193.7,72)--(198.8,72)..controls
(198.5,68.6) and (198.5,65.2)..(198.5,61.9)--
(198.5,29.2)--cycle;
\path (283.9,72.1)--(283.9,42.6)..controls(283.9,34.3)
and (279.0,28.3)..(270.4,28.3)..controls(263.7,28.3)
and (258.7,32.3)..(256.7,37.4)--(256.5,37.4)..controls
(255.2,29.9) and (249.0,28.3)..(245.2,28.3)..controls
(236.1,28.3) and (233.6,33.7)..(231.9,36.6)--
(231.7,36.5)--(231.7,29.3)--(226.6,29.3)..controls
(226.9,32.7) and (226.9,36.1)..(226.9,39.4)--
(226.9,72.1)--(232.2,72.1)--(232.2,48.4)..controls
(232.2,37.8) and (237.9,32.8)..(243.7,32.8)..controls
(250.5,32.8) and (252.7,37.6)..(252.7,43.6)--
(252.7,72)--(258.0,72)--(258.0,48.4)..controls
(258.0,37.8) and (263.7,32.8)..(269.5,32.8)..controls
(276.3,32.8) and (278.5,37.6)..(278.5,43.6)--
(278.5,72)--(283.9,72)--cycle;
\path (32.0,55.3)..controls(32.3,56.7) and (32.6,58)..
(33.0,59.2)..controls(33.0,59.2) and (33.0,59.2)..
(33.1,59.2)..controls(34.2,59.2) and (35.2,60.1)..
(35.2,61.3)..controls(35.2,61.9) and (34.9,62.5)..
(34.4,62.9)..controls(36.0,66.4) and (37.8,68.3)..
(39.7,68.3)..controls(42.6,68.3) and (45.7,63.3)..
(47.4,55)..controls(45.0,54.2) and (42.5,53.1)..
(40.0,51.9)..controls(37.2,53.3) and (34.6,54.4)..
(32.0,55.3);
\path (34.5,49.1)..controls(33.3,48.4) and (32.0,47.6)..
(30.8,46.8)..controls(31.0,49.4) and (31.3,51.7)..
(31.7,53.9)..controls(33.8,53.1) and (36.0,52.2)..
(38.3,51.2)..controls(37.1,50.5) and (35.8,49.8)..
(34.5,49.1);
\path (45.0,31)..controls(46.2,31.7) and (47.3,32.4)..
(48.5,33.1)..controls(48.3,30.8) and (48.0,28.6)..
(47.6,26.6)..controls(45.6,27.3) and (43.6,28.1)..
(41.5,29.1)..controls(42.6,29.7) and (43.8,30.3)..
(45.0,31);
\path (24.8,25.7)..controls(23.8,25.7) and (23.0,25)..
(22.8,24.1)..controls(22.0,24) and (21.3,24)..
(20.7,24)..controls(18.0,24) and (16.2,24.7)..
(15.4,26)..controls(14.0,28.5) and (16.7,33.6)..
(23.0,39.2)..controls(25.0,37.5) and (27.1,35.9)..
(29.4,34.3)..controls(29.6,31.4) and (30.0,28.5)..
(30.5,25.9)..controls(29.1,25.5) and (27.8,25.1)..
(26.5,24.8)..controls(26.2,25.4) and (25.5,25.7)..
(24.8,25.7);
\path (41.5,51.2)..controls(43.6,52.2) and (45.7,53)..
(47.6,53.7)..controls(48.0,51.7) and (48.3,49.5)..
(48.5,47.1)..controls(47.3,47.9) and (46.1,48.6)..
(44.9,49.3)..controls(43.7,50) and (42.6,50.6)..
(41.5,51.2);
\path (47.3,25.2)..controls(47.0,23.6) and (46.6,22.1)..
(46.1,20.7)..controls(45.0,20.6) and (44.1,19.7)..
(44.1,18.6)..controls(44.1,18) and (44.3,17.5)..
(44.7,17.2)..controls(43.2,14) and (41.4,12.2)..
(39.6,12.2)..controls(36.7,12.2) and (33.7,17)..
(32.0,25)..controls(34.5,25.9) and (37.2,27)..
(39.8,28.3)..controls(42.4,27.1) and (44.9,26)..
(47.3,25.2);
\path (24.0,40.1)..controls(25.6,41.4) and (27.3,42.8)..
(29.3,44.1)..controls(29.2,42.8) and (29.2,41.5)..
(29.2,40.2)..controls(29.2,38.8) and (29.2,37.4)..
(29.3,36)..controls(27.4,37.4) and (25.6,38.8)..
(24.0,40.1);
\path (38.3,29.1)..controls(36.1,28) and (33.9,27.1)..
(31.7,26.4)..controls(31.3,28.5) and (31.0,30.9)..
(30.8,33.4)..controls(32.0,32.6) and (33.2,31.9)..
(34.4,31.2)..controls(35.7,30.5) and (37.0,29.7)..
(38.3,29.1);
\path (23.0,41)..controls(21.9,42) and (20.8,43)..
(19.9,44)..controls(20.1,44.3) and (20.2,44.7)..
(20.2,45)..controls(20.2,46.1) and (19.3,47.1)..
(18.1,47.1)..controls(17.9,47.1) and (17.6,47.1)..
(17.4,47)..controls(15.1,50.1) and (14.4,52.7)..
(15.3,54.3)..controls(16.4,56.3) and (20.1,56.8)..
(25.3,55.7)..controls(26.9,55.4) and (28.6,54.9)..
(30.4,54.3)..controls(29.9,51.6) and (29.5,48.7)..
(29.3,45.8)..controls(27.1,44.3) and (25.0,42.7)..
(23.0,41);
\path (36.9,45.2)..controls(36.9,45.8) and (37.9,46.6)..
(39.4,46.8)..controls(39.4,46.8) and (39.4,46.8)..
(39.4,46.8)--(39.4,43.7)..controls(38.2,43.8) and
(36.9,44.5)..(36.9,45.2);
\path (55.6,40.1)..controls(53.9,38.7) and (52.1,37.2)..
(50.0,35.8)..controls(50.1,37.3) and (50.1,38.8)..
(50.1,40.2)..controls(50.1,41.6) and (50.1,43)..
(50.0,44.4)..controls(52.1,43) and (54.0,41.5)..
(55.6,40.1);
\path (56.6,41)..controls(54.6,42.8) and (52.3,44.5)..
(49.9,46.1)..controls(49.7,48.9) and (49.4,51.6)..
(48.9,54.1)..controls(50.4,54.6) and (51.9,55)..
(53.4,55.3)..controls(53.7,54.6) and (54.4,54.2)..
(55.2,54.2)..controls(56.2,54.2) and (57.1,54.9)..
(57.2,55.9)..controls(60.7,56.2) and (63.1,55.5)..
(64.0,54)..controls(65.5,51.6) and (62.8,46.6)..
(56.6,41);
\path (58.8,57.4)..controls(58.2,57.4) and (57.7,57.4)..
(57.1,57.3)..controls(56.7,57.9) and (56.1,58.4)..
(55.3,58.4)..controls(54.3,58.4) and (53.5,57.7)..
(53.3,56.7)..controls(51.8,56.4) and (50.3,56)..
(48.8,55.5)..controls(47.1,63.6) and (44.0,69.7)..
(39.8,69.7)..controls(37.1,69.7) and (34.9,67.2)..
(33.2,63.4)..controls(33.2,63.4) and (33.2,63.4)..
(33.2,63.4)..controls(32.1,63.4) and (31.1,62.5)..
(31.1,61.3)..controls(31.1,60.7) and (31.4,60.1)..
(31.8,59.7)..controls(31.4,58.4) and (31.1,57.1)..
(30.8,55.7)..controls(29.0,56.3) and (27.3,56.7)..
(25.7,57.1)..controls(23.9,57.5) and (22.2,57.7)..
(20.7,57.7)..controls(17.5,57.7) and (15.2,56.8)..
(14.2,55.1)..controls(12.9,52.8) and (13.9,49.6)..
(16.4,46.2)..controls(16.2,45.9) and (16.1,45.5)..
(16.1,45.1)..controls(16.1,44) and (17.0,43)..
(18.2,43)..controls(18.5,43) and (18.7,43.1)..
(19.0,43.2)..controls(19.9,42.2) and (21.0,41.2)..
(22.1,40.2)..controls(15.9,34.7) and (12.3,29)..
(14.3,25.4)..controls(15.5,23.3) and (18.6,22.4)..
(23.0,22.9)..controls(23.3,22.2) and (24.0,21.7)..
(24.9,21.7)..controls(26.0,21.7) and (26.9,22.5)..
(27.0,23.6)..controls(28.3,23.9) and (29.6,24.3)..
(30.9,24.7)..controls(32.6,16.8) and (35.7,10.9)..
(39.8,10.9)..controls(42.3,10.9) and (44.5,13.1)..
(46.1,16.7)..controls(46.2,16.7) and (46.3,16.7)..
(46.3,16.7)..controls(47.4,16.7) and (48.4,17.6)..
(48.4,18.8)..controls(48.4,19.5) and (48.0,20.1)..
(47.5,20.5)..controls(47.9,21.9) and (48.3,23.4)..
(48.7,24.9)..controls(50.5,24.3) and (52.2,23.9)..
(53.8,23.5)..controls(59.7,22.3) and (63.8,23.1)..
(65.3,25.6)..controls(66.5,27.8) and (65.7,30.7)..
(63.5,33.8)..controls(63.7,34.1) and (63.8,34.5)..
(63.8,35)..controls(63.8,36.1) and (62.9,37.1)..
(61.7,37.1)..controls(61.4,37.1) and (61.2,37)..
(61.0,37)..controls(60.0,38.1) and (58.9,39.2)..
(57.7,40.3)..controls(63.8,45.8) and (67.4,51.4)..
(65.3,55)..controls(64.3,56.5) and (62.0,57.4)..
(58.8,57.4)(39.7,8.6)..controls(22.2,8.6) and
(8.0,22.8)..(8.0,40.2)..controls(8.0,57.7) and
(22.2,71.8)..(39.6,71.8)..controls(57.0,71.8) and
(71.2,57.6)..(71.2,40.2)..controls(71.3,22.8) and
(57.1,8.6)..(39.7,8.6);
\path (56.6,39.2)..controls(57.8,38.1) and (58.9,37)..
(59.9,35.9)..controls(59.7,35.6) and (59.6,35.2)..
(59.6,34.8)..controls(59.6,33.7) and (60.5,32.7)..
(61.7,32.7)..controls(61.9,32.7) and (62.1,32.7)..
(62.3,32.8)..controls(64.2,29.9) and (64.8,27.6)..
(64.0,26.1)..controls(63.3,24.8) and (61.4,24.1)..
(58.7,24.1)..controls(57.3,24.1) and (55.7,24.3)..
(54.0,24.6)..controls(52.4,24.9) and (50.7,25.4)..
(48.9,26)..controls(49.4,28.5) and (49.7,31.2)..
(49.9,33.9)..controls(52.3,35.7) and (54.6,37.5)..
(56.6,39.2);
\path (36.5,40.9)..controls(36.5,41.6) and (37.9,42.5)..
(39.4,42.7)--(39.4,39.2)..controls(37.9,39.4) and
(36.5,40.2)..(36.5,40.9);
\path (44.9,40.9)..controls(44.9,41.8) and (44.0,42.7)..
(42.5,43.2)..controls(43.7,43.6) and (44.5,44.4)..
(44.5,45.2)..controls(44.5,46.1) and (43.7,46.8)..
(42.4,47.3)..controls(42.2,47.4) and (41.4,47.6)..
(40.7,47.6)..controls(40.7,47.6) and (40.7,47.6)..
(40.7,47.6)..controls(40.7,47.6) and (40.7,47.6)..
(40.7,47.6)--(40.7,48.7)..controls(40.7,49) and
(40.5,49.3)..(40.1,49.3)..controls(39.8,49.3) and
(39.5,49.1)..(39.5,48.7)--(39.5,47.6)..controls
(39.5,47.6) and (39.5,47.6)..(39.5,47.6)..controls
(39.5,47.6) and (39.5,47.6)..(39.5,47.6)..controls
(38.8,47.6) and (38.0,47.4)..(37.8,47.3)..controls
(36.5,46.9) and (35.7,46.1)..(35.7,45.2)..controls
(35.7,44.4) and (36.4,43.7)..(37.7,43.2)..controls
(36.0,42.8) and (35.0,41.9)..(35.0,40.9)..controls
(35.0,40) and (35.8,39.2)..(37.2,38.7)..controls
(35.5,38.2) and (34.4,37.2)..(34.4,36.2)..controls
(34.4,35.3) and (35.1,34.5)..(36.4,34)..controls
(36.5,33.7) and (36.8,33.4)..(37.2,33.2)..controls
(37.5,33.1) and (37.8,33.1)..(38.1,33.2)..controls
(38.4,33.3) and (38.6,33.4)..(38.6,33.7)..controls
(38.7,33.9) and (38.6,34.2)..(38.5,34.4)..controls
(38.3,34.6) and (38.1,34.8)..(37.8,34.9)..controls
(37.6,35) and (37.4,35)..(37.2,35)..controls
(36.5,35.4) and (36.1,35.9)..(36.1,36.3)..controls
(36.1,37.2) and (37.7,38.1)..(39.4,38.3)--
(39.4,32)..controls(39.4,31.6) and (39.6,31.4)..
(39.9,31.3)..controls(40.3,31.3) and (40.5,31.6)..
(40.5,32)--(40.5,38.3)..controls(42.3,38.1) and
(43.8,37.2)..(43.8,36.3)..controls(43.8,35.9) and
(43.4,35.4)..(42.7,35)..controls(42.5,35) and
(42.3,35)..(42.1,34.9)..controls(41.8,34.8) and
(41.6,34.6)..(41.4,34.4)..controls(41.2,34.2) and
(41.2,33.9)..(41.2,33.7)..controls(41.3,33.5) and
(41.5,33.3)..(41.7,33.2)..controls(42.0,33.1) and
(42.3,33.1)..(42.6,33.2)..controls(43.0,33.3) and
(43.3,33.6)..(43.4,34)..controls(44.6,34.6) and
(45.4,35.4)..(45.4,36.2)..controls(45.4,37.3) and
(44.3,38.2)..(42.6,38.7)..controls(44.0,39.2) and
(44.9,40.1)..(44.9,40.9)(44.3,32.2)..controls
(42.8,31.4) and (41.4,30.6)..(39.9,29.8)..controls
(38.3,30.6) and (36.7,31.4)..(35.1,32.4)..controls
(33.6,33.3) and (32.1,34.2)..(30.7,35.1)..controls
(30.6,36.7) and (30.5,38.5)..(30.5,40.2)..controls
(30.5,41.9) and (30.5,43.5)..(30.6,45.1)..controls
(32.0,46) and (33.5,47)..(35.1,47.9)..controls
(36.7,48.8) and (38.2,49.6)..(39.8,50.4)..controls
(41.2,49.7) and (42.7,48.9)..(44.1,48.1)..controls
(45.6,47.2) and (47.1,46.3)..(48.5,45.4)..controls
(48.6,43.8) and (48.7,42)..(48.7,40.3)..controls
(48.7,38.4) and (48.6,36.6)..(48.5,34.9)..controls
(47.2,34) and (45.8,33.1)..(44.3,32.2);
\path (40.5,42.7)..controls(42.0,42.5) and (43.4,41.7)..
(43.4,40.9)..controls(43.4,40.2) and (42.0,39.3)..
(40.5,39.1)--(40.5,42.7)--cycle;
\path (40.5,46.8)..controls(40.5,46.8) and (40.5,46.8)..
(40.5,46.8)..controls(41.7,46.6) and (43.0,45.9)..
(43.0,45.2)..controls(43.0,44.5) and (41.7,43.8)..
(40.5,43.6)--(40.5,46.8)--cycle;
\path (6.0,26.7)..controls(6.3,26.8) and (6.6,26.7)..
(6.7,26.4)..controls(6.8,26.1) and (6.7,25.8)..
(6.4,25.8)..controls(6.2,25.7) and (5.9,25.8)..
(5.8,26.1)..controls(5.7,26.3) and (5.8,26.6)..
(6.0,26.7)(3.5,33.8)..controls(5.2,34.3) and
(6.7,33.6)..(7.2,31.8)..controls(7.7,30.1) and
(6.7,28.7)..(5.0,28.3)..controls(3.3,27.8) and
(1.8,28.5)..(1.3,30.3)..controls(0.8,32) and
(1.8,33.4)..(3.5,33.8)(3.7,33)..controls
(2.5,32.7) and (1.6,31.8)..(2.0,30.5)..controls
(2.3,29.2) and (3.6,28.9)..(4.7,29.2)..controls
(5.8,29.5) and (6.8,30.4)..(6.4,31.7)..controls
(6.1,33) and (4.8,33.3)..(3.7,33)(0.8,39.2)--
(0.9,38.2)..controls(1.0,37) and (1.8,36.1)..
(3.2,36.2)..controls(4.7,36.3) and (5.4,37.1)..
(5.3,38.6)--(5.2,39.5)--(0.8,39.2)--
cycle(5.9,40.3)--(6.0,38.6)..controls(6.1,36.7) and
(5.2,35.4)..(3.2,35.3)..controls(1.4,35.2) and
(0.2,36.5)..(0.1,38.3)--(0.0,40)--(5.9,40.3)
-- cycle(6.6,46.9)--(6.5,46.1)--(1.7,46.8)--
(1.7,46.8)--(6.1,43.5)--(6.0,42.4)--(0.1,43.2)
-- (0.2,44)--(4.9,43.3)--(4.9,43.3)--
(0.5,46.5)--(0.7,47.6)--(6.6,46.9)--
cycle(5.3,50.6)--(6.0,52.9)--(2.8,52.7)--
(5.3,50.6)--cycle(8.7,53.8)--(8.4,53)--
(6.8,52.9)--(5.9,50.2)--(7.1,49.1)--(6.8,48.2)
-- (2.0,52.5)--(2.3,53.3)--(8.7,53.8)--
cycle(6.1,59.9)--(5.7,59.2)..controls(5.3,58.5) and
(5.4,58)..(5.9,57.7)..controls(6.4,57.4) and
(6.9,57.7)..(7.3,58.4)--(7.6,59)--(6.1,59.9)
-- cycle(11.1,58.2)--(10.7,57.5)--(8.4,58.8)--
(8.2,58.4)..controls(8.0,58) and (7.9,57.8)..
(8.2,57.3)--(9.6,55.5)--(9.1,54.7)--(7.6,56.8)
.. controls(7.4,57.1) and (7.3,57.3)..(7.4,57.6)--
(7.4,57.6)..controls(7.0,57.1) and (6.3,56.8)..
(5.6,57.2)..controls(4.4,57.9) and (4.7,59)..
(5.3,60)--(5.9,61)--(11.1,58.2)--
cycle(7.4,63.5)--(8.0,64.1)--(10.6,62)..controls
(11.5,61.3) and (12.3,61.1)..(13.0,61.9)..controls
(13.7,62.7) and (13.3,63.5)..(12.4,64.2)--
(9.8,66.3)--(10.3,67)--(13.0,64.8)..controls
(14.3,63.7) and (14.4,62.5)..(13.5,61.4)..controls
(12.6,60.3) and (11.4,60.2)..(10.1,61.3)--
(7.4,63.5)--cycle(12.2,68.7)..controls(12.4,69.1) and
(12.7,69.5)..(13.0,69.8)..controls(14.4,71) and
(16.2,70.9)..(17.3,69.5)..controls(18.5,68.1) and
(18.4,66.3)..(16.9,65.1)..controls(16.6,64.9) and
(16.2,64.5)..(15.7,64.4)--(15.3,65)..controls
(15.6,65.1) and (16.1,65.3)..(16.5,65.6)..controls
(17.4,66.4) and (17.6,67.8)..(16.7,68.8)..controls
(15.8,69.8) and (14.5,70)..(13.5,69.1)..controls
(13.2,68.8) and (12.9,68.5)..(12.8,68.1)--
(12.2,68.7)--cycle(20.0,70.8)..controls(20.1,70.6) and
(20.1,70.2)..(19.9,70.1)..controls(19.7,69.9) and
(19.4,70)..(19.2,70.3)..controls(19.0,70.5) and
(19.1,70.8)..(19.3,71)..controls(19.5,71) and
(19.9,71)..(20.0,70.8)(26.6,74.6)..controls
(27.4,73) and (27.0,71.4)..(25.3,70.6)..controls
(23.7,69.8) and (22.2,70.5)..(21.4,72.2)..controls
(20.7,73.8) and (21.1,75.4)..(22.7,76.2)..controls
(24.4,76.9) and (25.9,76.2)..(26.6,74.6)(25.8,74.2)
.. controls(25.3,75.3) and (24.2,76)..(23.1,75.5)..
controls(21.9,75) and (21.8,73.7)..(22.3,72.6)..
controls(22.8,71.5) and (23.8,70.8)..(25.0,71.3)..
controls(26.3,71.9) and (26.3,73.2)..
(25.8,74.2)(31.2,78.2)--(30.2,77.9)..controls
(29.0,77.6) and (28.3,76.6)..(28.7,75.2)..controls
(29.1,73.7) and (30.1,73.3)..(31.5,73.6)--
(32.4,73.8)--(31.2,78.2)--cycle(33.4,73.4)--
(31.7,73)..controls(29.8,72.5) and (28.4,73.2)..
(27.9,75.1)..controls(27.4,76.9) and (28.5,78.3)..
(30.2,78.7)--(31.9,79.2)--(33.4,73.4)--
cycle(39.9,74)--(39.0,74)--(38.7,78.9)--
(38.7,78.9)--(36.3,73.9)--(35.2,73.8)--
(34.9,79.7)--(35.7,79.7)--(36.0,74.9)--
(36.0,74.9)--(38.3,79.8)--(39.5,79.9)--
(39.9,74)--cycle(44.9,73.6)--(41.6,74)--
(41.7,74.7)--(44.2,74.4)--(44.4,76.3)--
(42.2,76.6)--(42.3,77.3)--(44.5,77)--
(44.7,78.7)--(42.2,79)--(42.3,79.7)--
(45.6,79.3)--(44.9,73.6)--cycle(48.0,78.9)..controls
(48.5,79) and (48.9,78.9)..(49.3,78.8)..controls
(51.0,78.3) and (52.0,76.8)..(51.5,75)..controls
(51.0,73.2) and (49.4,72.4)..(47.6,72.9)..controls
(47.3,73) and (46.7,73.2)..(46.4,73.5)--
(46.7,74.3)..controls(46.9,74) and (47.4,73.8)..
(47.9,73.7)..controls(49.1,73.4) and (50.3,74)..
(50.7,75.3)..controls(51.1,76.6) and (50.5,77.8)..
(49.2,78.2)..controls(48.8,78.3) and (48.4,78.3)..
(47.9,78.2)--(48.0,78.9)--cycle(57.8,72.2)..controls
(57.0,70.6) and (55.5,69.9)..(53.9,70.7)..controls
(52.3,71.5) and (51.9,73.1)..(52.7,74.7)..controls
(53.5,76.3) and (55.0,77)..(56.6,76.2)..controls
(58.2,75.4) and (58.5,73.7)..(57.8,72.2)(57.0,72.6)
.. controls(57.5,73.7) and (57.4,75)..(56.3,75.5)..
controls(55.1,76.1) and (54.1,75.3)..(53.5,74.3)..
controls(53.0,73.2) and (53.0,72)..(54.2,71.4)..
controls(55.4,70.8) and (56.4,71.5)..
(57.0,72.6)(63.5,71)--(62.7,71.6)..controls
(61.7,72.3) and (60.5,72.2)..(59.7,71.1)..controls
(58.8,69.9) and (59.1,68.8)..(60.3,68)--
(61.0,67.5)--(63.5,71)--cycle(61.2,66.2)--
(59.8,67.2)..controls(58.2,68.3) and (57.8,69.9)..
(59.0,71.5)..controls(60.1,73) and (61.8,73.1)..
(63.3,72)--(64.7,71)--(61.2,66.2)--
cycle(65.0,66.2)..controls(64.8,66) and (64.5,66)..
(64.3,66.2)..controls(64.1,66.4) and (64.1,66.7)..
(64.3,66.9)..controls(64.5,67.1) and (64.8,67.1)..
(65.0,66.9)..controls(65.1,66.7) and (65.2,66.4)..
(65.0,66.2)(70.2,60.6)..controls(68.8,59.5) and
(67.1,59.5)..(66.0,61)..controls(64.9,62.4) and
(65.2,64)..(66.7,65.1)..controls(68.1,66.2) and
(69.8,66.2)..(70.9,64.7)..controls(72.0,63.3) and
(71.6,61.7)..(70.2,60.6)(69.7,61.3)..controls
(70.6,62) and (71.1,63.2)..(70.3,64.3)..controls
(69.5,65.3) and (68.2,65.2)..(67.3,64.4)..controls
(66.4,63.7) and (65.8,62.5)..(66.7,61.4)..controls
(67.5,60.3) and (68.7,60.6)..(69.7,61.3)(74.8,56.8)
-- (74.3,57.7)..controls(73.7,58.8) and (72.6,59.2)..
(71.3,58.6)..controls(70.0,57.9) and (69.7,56.8)..
(70.4,55.6)--(70.8,54.8)--(74.8,56.8)--
cycle(70.6,53.7)--(69.8,55.2)..controls(68.9,56.9) and
(69.2,58.5)..(71.0,59.4)..controls(72.6,60.3) and
(74.2,59.5)..(75.0,58)--(75.8,56.5)--
(70.6,53.7)--cycle(72.6,47.5)--(72.4,48.3)--
(77.1,49.7)--(77.1,49.7)--(71.7,50.9)--
(71.4,51.9)--(77.1,53.6)--(77.3,52.8)--
(72.7,51.5)--(72.7,51.5)--(78.0,50.3)--
(78.3,49.2)--(72.6,47.5)--cycle(73.2,42.4)--
(72.8,45.7)--(73.5,45.8)--(73.8,43.3)--
(75.7,43.5)--(75.5,45.7)--(76.2,45.8)--
(76.4,43.6)--(78.1,43.8)--(78.0,46.3)--
(78.7,46.4)--(79.1,43.1)--(73.2,42.4)--
cycle(73.2,39.3)--(73.2,40.1)--(79.1,40)--
(79.1,39.2)--(73.2,39.3)--cycle(78.9,36.9)..controls
(79.0,36.5) and (79.0,36)..(79.0,35.5)..controls
(78.8,33.7) and (77.4,32.6)..(75.6,32.8)..controls
(73.7,33.1) and (72.7,34.5)..(73.0,36.3)..controls
(73.0,36.6) and (73.1,37.2)..(73.4,37.6)--
(74.2,37.4)..controls(74.0,37.1) and (73.8,36.6)..
(73.7,36.2)..controls(73.5,35) and (74.3,33.9)..
(75.7,33.7)..controls(77.0,33.5) and (78.1,34.3)..
(78.3,35.6)..controls(78.4,36) and (78.3,36.5)..
(78.1,36.9)--(78.9,36.9)--cycle(77.8,30.3)..controls
(77.8,29.9) and (77.8,29.4)..(77.6,29)..controls
(77.3,28) and (76.5,27.3)..(75.5,27.6)..controls
(73.7,28.1) and (74.8,30.5)..(73.5,30.8)..controls
(72.8,31) and (72.4,30.4)..(72.2,30)..controls
(72.1,29.6) and (72.1,29.1)..(72.1,28.7)--
(71.3,28.8)..controls(71.3,29.2) and (71.3,29.6)..
(71.4,30)..controls(71.7,31.1) and (72.5,31.9)..
(73.7,31.6)..controls(75.6,31.1) and (74.6,28.7)..
(75.7,28.4)..controls(76.3,28.2) and (76.6,28.7)..
(76.7,29.2)..controls(76.8,29.6) and (76.8,29.9)..
(76.8,30.3)--(77.8,30.3)--cycle(72.7,25.6)..controls
(72.5,25.7) and (72.3,26)..(72.4,26.3)..controls
(72.5,26.5) and (72.8,26.7)..(73.1,26.6)..controls
(73.4,26.5) and (73.5,26.2)..(73.4,26)..controls
(73.3,25.6) and (73.0,25.5)..(72.7,25.6)(66.2,19.4)
-- (66.7,20.1)--(71.0,17.3)--(71.0,17.3)--
(67.7,21.7)--(68.1,22.4)--(73.5,21.3)--
(73.5,21.3)--(69.2,24.1)--(69.7,24.8)--
(74.7,21.6)--(73.9,20.4)--(68.8,21.5)--
(71.9,17.3)--(71.1,16.1)--(66.2,19.4)--
cycle(63.2,16.3)--(65.5,18.7)--(66.0,18.2)--
(64.3,16.4)--(68.0,12.8)--(67.4,12.2)--
(63.2,16.3)--cycle(65.4,10.3)--(64.7,9.8)--
(62.6,12.4)..controls(61.9,13.3) and (61.1,13.7)..
(60.3,13)..controls(59.4,12.3) and (59.6,11.5)..
(60.3,10.6)--(62.5,8)--(61.8,7.5)--(59.7,10.2)
.. controls(58.7,11.5) and (58.8,12.7)..(59.9,13.6)..
controls(61.1,14.5) and (62.3,14.3)..(63.3,13)--
(65.4,10.3)--cycle(53.3,9.6)--(54.1,10)--
(56.3,5.3)--(57.9,6)--(58.2,5.3)--(54.1,3.4)
-- (53.8,4.1)--(55.5,4.9)--(53.3,9.6)--
cycle(51.1,1.9)--(51.9,2.1)--(52.1,1.3)--
(51.3,1.1)--(51.1,1.9)--cycle(49.7,1.5)--
(50.5,1.7)--(50.7,0.9)--(50.0,0.7)--(49.7,1.5)
-- cycle(50.7,6.2)--(48.4,5.5)--(50.4,3)--
(50.7,6.2)--cycle(46.1,7.1)--(47.0,7.4)--
(48.0,6.1)--(50.8,7)--(51.0,8.6)--(51.9,8.9)
-- (51.2,2.5)--(50.3,2.2)--(46.1,7.1)--
cycle(43.6,6.9)--(44.4,7)--(45.1,1.9)--
(46.9,2.1)--(47.0,1.4)--(42.5,0.8)--(42.4,1.5)
-- (44.2,1.7)--(43.6,6.9)--cycle(40.0,6.6)--
(40.8,6.6)--(41.0,0.7)--(40.2,0.7)--(40.0,6.6)
-- cycle(37.6,0.9)..controls(37.2,0.8) and (36.7,0.8)..
(36.3,0.8)..controls(35.2,0.9) and (34.5,1.5)..
(34.6,2.6)..controls(34.8,4.4) and (37.3,3.8)..
(37.4,5.2)..controls(37.5,5.9) and (36.8,6.2)..
(36.3,6.3)..controls(35.9,6.3) and (35.3,6.2)..
(35.1,6.1)--(35.1,6.9)..controls(35.5,7) and
(35.9,7.1)..(36.3,7)..controls(37.5,6.9) and
(38.4,6.3)..(38.3,5.1)..controls(38.1,3.2) and
(35.6,3.6)..(35.5,2.5)..controls(35.4,1.9) and
(36.0,1.7)..(36.5,1.6)..controls(36.9,1.6) and
(37.2,1.6)..(37.6,1.7)--(37.6,0.9)--
cycle(29.4,2.8)--(30.2,2.6)..controls(31.0,2.4) and
(31.4,2.7)..(31.6,3.2)..controls(31.7,3.8) and
(31.4,4.2)..(30.6,4.4)--(29.9,4.6)--(29.4,2.8)
-- cycle(29.8,8)--(30.6,7.8)--(30.0,5.3)--
(30.5,5.2)..controls(31.0,5.1) and (31.2,5)..
(31.6,5.5)--(33.0,7.3)--(33.9,7.1)--(32.3,5.1)
.. controls(32.0,4.8) and (31.9,4.7)..(31.6,4.7)--
(31.6,4.7)..controls(32.2,4.4) and (32.6,3.8)..
(32.5,3.1)..controls(32.2,1.7) and (31.0,1.8)..
(29.9,2.1)--(28.5,2.4)--(29.8,8)--
cycle(25.1,9.9)--(28.1,8.6)--(27.8,7.9)--
(25.5,8.9)--(24.7,7.1)--(26.8,6.2)--(26.5,5.5)
-- (24.4,6.4)--(23.7,4.8)--(26.0,3.8)--
(25.7,3.1)--(22.7,4.4)--(25.1,9.9)--
cycle(20.7,5.4)--(20.0,5.9)--(21.2,11.3)--
(21.2,11.3)--(16.9,7.9)--(16.1,8.4)--(21.2,12.2)
-- (22.1,11.6)--(20.7,5.4)--cycle(17.7,14.8)--
(18.4,14.3)--(14.6,9.7)--(13.9,10.2)--
(17.7,14.8)--cycle(13.0,19.6)--(13.6,19)--
(10.0,15.7)--(10.0,15.7)--(15.4,17)--
(16.1,16.2)--(11.7,12.2)--(11.1,12.8)--
(14.6,16)--(14.6,16)--(9.3,14.7)--(8.5,15.6)
-- (13.0,19.6)--cycle(6.9,18)--(6.5,18.7)--
(9.4,20.4)..controls(10.4,21) and (10.9,21.7)..
(10.3,22.6)..controls(9.7,23.5) and (8.9,23.4)..
(7.9,22.9)--(5.0,21.2)--(4.6,21.9)--(7.6,23.7)
.. controls(9.0,24.6) and (10.2,24.3)..(11.0,23)..
controls(11.7,21.7) and (11.4,20.6)..(10.0,19.7)--
(6.9,18)--cycle;
\end{tikzpicture}\fi}%uulmlogo
\endinput