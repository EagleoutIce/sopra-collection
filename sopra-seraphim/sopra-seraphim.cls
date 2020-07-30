%% sopra-seraphim.cls
%%
%% -----------------------------------------------------------------------------
%% Version: 1.0
%% Author:  Florian Sihler, 15.12.2019
%%
%% This LaTeX2e Class provides a beamer-based-class setting all necessary 
%% stuff in a one-file solution. It is to be used in all Team020
%% presentations
%%                      ulm university, WiSe2019


%% Development notes:
%%    All internal commands and registers will be prefixed with 'sos@
%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sopra-seraphim}[2019/15/02 EagleoutIce - Beamer Documentclass for the sopra-team-020]


%% -----------------------------------------------------------------------------
%% Lengths and Registers
%% -----------------------------------------------------------------------------

\newcounter{sosversion} \setcounter{sosversion}{1007}

\newcounter{sos@counter@tmp@a}

\newlength\sos@len@tmp@a

\newif\ifsos@applystyle@% if set, style to sopra-* will be automatically set!
\newif\ifsos@handout@

%% -----------------------------------------------------------------------------
%% Class-Args
%% -----------------------------------------------------------------------------


% apply style
\DeclareOption{setstyle}{ \sos@applystyle@true }
\DeclareOption{nosetstyle}{ \sos@applystyle@false }


\DeclareOption{handout}{ \sos@handout@true }
\DeclareOption{nohandout}{ \sos@handout@false }


\ExecuteOptions{setstyle}% set it explicitly
\ProcessOptions\relax%


%% -----------------------------------------------------------------------------
%% Documentclass
%% -----------------------------------------------------------------------------

% \PassOptionsToPackage{}{beamer}

% we set the metdata by our self
\ifsos@handout@
\LoadClass[aspectratio=169,usepdftitle=false,hyperref={colorlinks},handout,t]{beamer}
\else
\LoadClass[aspectratio=169,usepdftitle=false,hidelinks,t]{beamer}
\fi

%% -----------------------------------------------------------------------------
%% Basic Packages
%% -----------------------------------------------------------------------------

% encoding:
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

\RequirePackage[defaultfam,light,tabular,lining]{montserrat}
\RequirePackage{sfmath}


\RequirePackage{tikz} % we need it anyways - will load xcolor
\usetikzlibrary{calc}

\RequirePackage[english,main=ngerman]{babel}

\RequirePackage{microtype}


%% -----------------------------------------------------------------------------
%% Helper Methods
%% -----------------------------------------------------------------------------

\def\sos@thesosversion#1#2#3#4\@nil{%
    \bgroup{}v#1.#2.#3#4\egroup%
}
\def\thesosversion{%
    \edef\@tmp{\noexpand\sos@thesosversion\arabic{sosversion}\noexpand\@nil}%
    \@tmp%
}

\def\sos@mail#1{\href{mailto:#1}{#1}}
\let\mail\sos@mail%
\def\sos@month@to@name#1{%
    \ifcase#1\or{Januar}\or{Februar}\or{M\"{a}rz}\or{April}\or{Mai}\or{Juni}%
    \or{Juli}\or{August}\or{September}\or{Oktober}\or{November}\or{Dezember}%
    \else\@ctrerr\fi%
}

\def\sos@date@convert#1-#2-#3\@nil{%
    \bgroup#3.\(\;\){\sos@month@to@name{#2}}\(\;\,\)#1\egroup%
}
\def\DateConvert#1%
{\expandafter\ifx\expandafter\\#1\\\else\expandafter\sos@date@convert#1\@nil\fi}

% some styling commands
\long\def\sos@@imptext#1{\bgroup\slshape\color{cimportant}#1\egroup}
\let\imptext\sos@@imptext

\long\def\sos@@notetext#1{\bgroup\itshape\color{cprimary!70!white}#1\egroup}
\let\notetext\sos@@notetext

%% -----------------------------------------------------------------------------
%% Basic Layout Stuff
%% -----------------------------------------------------------------------------

\beamertemplatenavigationsymbolsempty

\setbeamertemplate{itemize items}{\tiny\raisebox{1.45pt}{$\blacksquare$}}
\setbeamertemplate{itemize subitem}{\tiny\tikz[baseline=-0.85ex]{\fill (0,0) circle (1.65pt);}}

\setbeamersize{text margin left=5mm,text margin right=5mm}

\setcounter{tocdepth}{4} % subsubsections in toc


%% -----------------------------------------------------------------------------
%% Fonts and align
%% -----------------------------------------------------------------------------

\renewcommand{\baselinestretch}{1.05}

\setbeamerfont{title}{size=\huge}
\setbeamerfont{frametitle}{size=\large}

\setbeamerfont{footline}{size=\fontsize{6}{6}\selectfont}

\setbeamerfont{itemize/enumerate subbody}{size=\scriptsize}
\setbeamerfont{itemize/enumerate subsubbody}{size=\scriptsize}

\setbeamerfont{description item}{series=\mdseries}

\def\supertiny{\fontsize{4.5pt}{4.5pt}\selectfont}

%% -----------------------------------------------------------------------------
%% Color Definitions
%% -----------------------------------------------------------------------------

% We will define a main/primary color, a secondary/akzent color and a tertiary
% /light color to be used everywhere throughout the document.
% there will be further colors definied (like for example header-text)

% black/contrast color to be used in the document
\definecolor{sos@color@primary}  {RGB}{012,010,007}       % RGB(012,010,007)
\definecolor{sos@color@akzent}   {RGB}{150,128,081}       % RGB(150,128,081)
% \definecolor{sos@color@akzent}   {RGB}{150,128,081}       % RGB(162,150,088)

\definecolor{sos@color@light}    {RGB}{236,200,128}       % RGB(236,200,128)

\definecolor{sos@color@gray}{RGB}{ 99, 97, 96}           % RGB(99,97,96)
\definecolor{sos@color@white}{RGB}{252,252,252}           % RGB(252,252,252)

% \definecolor{sos@color@highlight}{RGB}{135,076,150}     % RGB(135,076,150)
\definecolor{sos@color@highlight}{RGB}{153,007,051}       % RGB(153,07,051)

% main-colormappings
\colorlet{cprimary}{sos@color@primary}
\colorlet{cakzent}{sos@color@akzent}
\colorlet{clight}{sos@color@light}
\colorlet{cimportant}{sos@color@highlight}

\colorlet{cgray}{sos@color@gray}
\colorlet{cwhite}{sos@color@white}
\colorlet{chighlight}{sos@color@highlight}

% titlepage (tp) styles

\colorlet{ctpbackground}{cprimary}
\colorlet{ctptext}{cwhite}
\colorlet{ctpsymbol}{cakzent}

% header (hd) styles

\colorlet{chdtext}{cakzent}


%% -----------------------------------------------------------------------------
%% Colors & templates
%% -----------------------------------------------------------------------------

\setbeamercolor{headline}{fg=cprimary}

\setbeamercolor{frametitle}{fg=cwhite}

\setbeamercolor{itemize/enumerate subbody}{fg=cprimary}
\setbeamercolor{itemize/enumerate subsubbody}{fg=cprimary!90!white}

\setbeamercolor{itemize item}{fg=cprimary}
\setbeamercolor{itemize subitem}{fg=cprimary!90!white}
\setbeamercolor{itemize subsubitem}{fg=cprimary!80!white}

\setbeamercolor{enumerate item}{fg=cprimary}
\setbeamercolor{enumerate subitem}{fg=cprimary!90!white}
\setbeamercolor{enumerate subsubitem}{fg=cprimary!80!white}

\setbeamercolor{description item}{fg=cprimary}
\setbeamercolor{description subitem}{fg=cprimary!90!white}
\setbeamercolor{description subsubitem}{fg=cprimary!80!white}

\setbeamercolor{bibliography item}{fg=cprimary}
\setbeamercolor{bibliography entry author}{fg=cakzent!75!cprimary}
\setbeamercolor{bibliography entry title}{fg=cakzent!75!cprimary}
\setbeamercolor{bibliography entry location}{fg=black}
\setbeamercolor{bibliography entry note}{fg=black}

\setbeamercolor{section in toc}{fg=cakzent}
\setbeamercolor{subsection in toc}{fg=cprimary}
\setbeamercolor{section in toc shaded}{fg=cakzent!70!black}
\setbeamercolor{subsection in toc shaded}{fg=cprimary!70!black}

\setbeamercolor{alerted text}{fg=cakzent}
\setbeamercolor{structure}{fg=cprimary}

\setbeamercolor{frametitle continuation}{fg=cwhite}

\setbeamertemplate{frametitle continuation}{\!, \insertcontinuationcount}

\setbeamertemplate{section in toc}{\medskip\vfill\inserttocsection\par}

\setbeamertemplate{subsection in toc}{\qquad{\scalebox{0.65}{\raisebox{0.75pt}{$\blacksquare$}}} \inserttocsubsection\par}


%% -----------------------------------------------------------------------------
%% Set the Document-Metadata
%% -----------------------------------------------------------------------------

% we will populate the following fields:
% dates have to be given in YYYY-MM-DD!
% authors can be also populated by the helper methods
\foreach \field in {brief,authors,duedate,supervisor,%
    keywords,group,groupnum}{
    \expandafter\xdef\csname\field\endcsname{%
        \noexpand\@ifnextchar[%
        {\expandafter\noexpand\csname\field @hasopt\endcsname}%
        {\expandafter\noexpand\csname\field @noopt\endcsname}
    }
    \expandafter\xdef\csname\field @hasopt\endcsname[##1]##2%
    {\expandafter\noexpand\gdef\csname sos@register@\field\endcsname{##2}%
    \expandafter\noexpand\gdef\csname sos@register@short@\field\endcsname{##1}}
    \expandafter\xdef\csname\field @noopt\endcsname##1%
    {\expandafter\noexpand\gdef\csname sos@register@\field\endcsname{##1}%
    \expandafter\noexpand\gdef\csname sos@register@short@\field\endcsname{##1}}
    \expandafter\gdef\csname sos@register@\field\endcsname{}
    \expandafter\gdef\csname sos@register@short@\field\endcsname{}
}


% iterators for handling and parsing author information.
\def\sos@@add@author#1{%
    \let\sos@@tmp@old@authors\sos@register@authors%
    \expandafter\ifx\expandafter\\\sos@@tmp@old@authors\\%
    \xdef\sos@register@authors{#1}\else%
    \xdef\sos@register@authors{\sos@@tmp@old@authors,#1}\fi%
}
\let\addAuthor\sos@@add@author

\def\sos@@parse@author#1 (#2)\@nil{\bgroup\href{mailto:#2}{#1}\egroup}

\def\sos@@typeset@author#1{%
    \setcounter{sos@counter@tmp@a}{0}% start with an offset
    \foreach \@tmp in {#1}%
        {\expandafter\ifx\expandafter\\\@tmp\\\else%
            \stepcounter{sos@counter@tmp@a}\fi}%
    \edef\sos@authors@totallength{\arabic{sos@counter@tmp@a}}%
    \setcounter{sos@counter@tmp@a}{0} % stored the length of the list
    \foreach \sos@@tmp@curauthor in {#1} {%
        \expandafter\ifx\expandafter\\\sos@@tmp@curauthor\\%empty => ignore
        \else\stepcounter{sos@counter@tmp@a}%
            \ifnum\thesos@counter@tmp@a>1%
            \ifnum\thesos@counter@tmp@a=\sos@authors@totallength%
                ~und \else,\space\fi\fi
            \expandafter\sos@@parse@author\sos@@tmp@curauthor\@nil%
        \fi%
    }%
}

\def\sos@@setteam#1 #2\@nil{%
    \gdef\sos@register@group{#1}\gdef\sos@register@groupnum{#2}%
}
\newcommand\setTeam[1]{%
    \expandafter\sos@@setteam#1\@nil
}
\newcommand\typesetAuthors{%
    \edef\@tmp{\noexpand\sos@@typeset@author{\sos@register@authors}}\@tmp}

\AtEndPreamble{%
\hypersetup{
    pdftitle=\inserttitle,
    pdfauthor=\sos@register@authors,
    pdfsubject=\insertsubtitle,
    pdfkeywords=\sos@register@keywords,
    pdfcreator={LaTeX with hyperref, beamer and the sopra-seraphim class},
    linkcolor=cprimary,
    filecolor=cprimary,
    citecolor=cprimary,
    urlcolor=cprimary%
}
}

%% -----------------------------------------------------------------------------
%% "Futura" Font
%% -----------------------------------------------------------------------------

% I've invested round about 2 hours trying to set up a portable way to use the
% Futura-Font. As it worked, but wasn't portable, i've desided to recreate the
% letters in tikz and use them instead

\def\sos@font@futura@color@current{cwhite}

\newcounter{sos@counter@font@carriage@posX}
\newcounter{sos@counter@font@carriage@posY}

\def\@sos@font@futura@carriage{%
\thesos@counter@font@carriage@posX cm,-\thesos@counter@font@carriage@posY cm%
}
\def\@sos@font@futura@carriage@nl{
    \setcounter{sos@counter@font@carriage@posX}{0}
    \addtocounter{sos@counter@font@carriage@posY}{15}
}
\def\@sos@font@futura@carriage@reset{
    \setcounter{sos@counter@font@carriage@posX}{0}
    \addtocounter{sos@counter@font@carriage@posY}{0}
}
\def\@sos@font@futura@carriage@indent#1{\setcounter{sos@counter@font@carriage@posX}{#1}}
% 40x99 [off: 13] ; middle: 47-|17 -- -53,115 -| 47 17
\def\sos@font@futura@letter@N{
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) -- ++(32mm,0) -- ++(0,25mm) -- ++(-32mm,99mm-25mm) -- cycle; % lower left triangle
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(40mm+13mm,0) -| ++(47mm,17mm) -- ++(-53mm,++115mm) -| ++(-47mm,-15mm) -- cycle ; % middle block
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(101mm,34mm) -- ++(-32mm,99mm-25mm) |- ++(32mm,25mm) -- cycle; % upper right triangle
    \addtocounter{sos@counter@font@carriage@posX}{12}
}

\def\sos@font@futura@letter@O{
    \begin{scope}
        \clip (\@sos@font@futura@carriage) rectangle ++ (53mm,132mm);
        \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage)++(53mm,66mm) ellipse (53mm and 68mm);
    \end{scope}
    \begin{scope}[xshift=007mm]
        \clip (\@sos@font@futura@carriage)++ (53mm,0mm) rectangle ++(53mm,132mm);
        \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage)++(53mm,66mm) ellipse (53mm and 68mm);
    \end{scope}
    \addtocounter{sos@counter@font@carriage@posX}{13}
}

\def\sos@font@futura@letter@T{
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage)++(0,75mm) |- ++(29mm,57mm) -- cycle; % leftT
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage)++(34mm,0) rectangle ++(43mm,132mm); % TBlock
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage)++(82mm,132mm) -| ++(29mm,-57mm) -- cycle; % right
    \addtocounter{sos@counter@font@carriage@posX}{13}
}

\def\sos@font@futura@letter@I{
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) rectangle ++(43mm,132mm); % TBlock
    \addtocounter{sos@counter@font@carriage@posX}{6}
}

\def\sos@font@futura@letter@M{
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) -- ++(44mm,0) -- ++(-22mm,89mm) -- cycle; % lower left triangle
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(44mm+9mm,0) -- ++(46mm,0) -- ++(-32mm,132mm) -- ++(-34mm,0) -- ++(-7mm,-27mm) -- cycle ; % middle block
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(109mm,0) -- ++(46mm,0) -- ++(-32mm,132mm) -- ++(-34mm,0) -- ++(-7mm,-27mm) -- cycle ; % outer block

    \addtocounter{sos@counter@font@carriage@posX}{17}
}

\def\sos@font@futura@letter@E{
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) rectangle ++(43mm,132mm); % TBlock

    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(46mm,0) -| ++(47mm,57mm) -- cycle; % lower right triangle
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(46mm,132mm) -| ++(47mm,-57mm) -- cycle; % upper right triangle

    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(46mm,66mm) -- ++(29mm,24mm) -- ++(0,-48mm) -- cycle; % upper right triangle

    \addtocounter{sos@counter@font@carriage@posX}{11}
}

\def\sos@font@futura@letter@D{
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) rectangle ++(43mm,132mm); % TBlock
    \begin{scope}[xshift=-2mm]
        \clip (\@sos@font@futura@carriage)++ (53mm,0mm) rectangle ++(53mm,132mm);
        \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage)++(53mm,66mm) ellipse (53mm and 68mm);
    \end{scope}
    \addtocounter{sos@counter@font@carriage@posX}{12}
}

% 16x21
\def\sos@font@futura@letter@S{
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) -- ++(42mm/1.25,0) -- ++(-42mm/1.25,60.125mm/1.25) -- cycle; % lower left triangle
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(40mm+25mm,5mm) arc[start angle=282,end angle=360+35,radius=23.5mm] -- ++(90+35:72mm) arc[start angle=180+35,end angle=180+35-90,radius=23.5mm] -- ++(180+5:7mm) arc[start angle=95, end angle=180+35,radius=23.5mm+15mm] -- ++(-55:55mm) arc[start angle=90-55,end angle=55-90,radius=23.5mm] -- cycle; % middle block
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(82mm,34mm+43.875mm*1.25) -- ++(-42mm/1.25,55.125mm/1.25) -- ++(42mm/1.25,0) -- cycle; % upper right triangle
    \addtocounter{sos@counter@font@carriage@posX}{12}
}

\def\sos@font@futura@letter@P{
    \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) rectangle ++(43mm,132mm); % TBlock
    \begin{scope}[xshift=-2mm]
        \clip (\@sos@font@futura@carriage)++ (53mm,46mm) rectangle ++(53mm,132mm);
        \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage)++(53mm,64mm+68mm/2.35) ellipse (43mm and 68mm/1.75);
    \end{scope}
    \addtocounter{sos@counter@font@carriage@posX}{11}
}

\def\sos@font@futura@letter@Y{
    \bgroup\def\sos@scaler{*0.75}
        \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(65mm\sos@scaler,56mm) --++(0,-56mm) -| ++(43mm\sos@scaler,62mm) -- ++(-65mm\sos@scaler,132mm-62mm) -- ++(-43mm\sos@scaler,0) -- cycle; % TBlock
        \fill[\sos@font@futura@color@current] (\@sos@font@futura@carriage) ++(65mm\sos@scaler,132mm) -- ++(45mm\sos@scaler,-50mm) --  ++(45mm\sos@scaler,50mm) --cycle; % upper right triangle
    \egroup
    \addtocounter{sos@counter@font@carriage@posX}{12}
}

\def\sos@ntts{
    \@sos@font@futura@carriage@reset
    \sos@font@futura@letter@N
    \sos@font@futura@letter@O
    \@sos@font@futura@carriage@nl
    \sos@font@futura@letter@T
    \sos@font@futura@letter@I
    \sos@font@futura@letter@M
    \sos@font@futura@letter@E
    \@sos@font@futura@carriage@nl
    \@sos@font@futura@carriage@indent{13}
    \sos@font@futura@letter@T
    \sos@font@futura@letter@O\coordinate (ct@groupnum) at(\@sos@font@futura@carriage);
    \@sos@font@futura@carriage@nl
    \@sos@font@futura@carriage@indent{27}
    % \sos@font@futura@letter@D
    % \sos@font@futura@letter@I
    % \sos@font@futura@letter@E
    % \@sos@font@futura@carriage@nl
    % \@sos@font@futura@carriage@indent{27}
    \sos@font@futura@letter@S
    \sos@font@futura@letter@P
    \sos@font@futura@letter@Y\coordinate (ct@ystraw) at(\@sos@font@futura@carriage);
}


%% -----------------------------------------------------------------------------
%% Title Style
%% -----------------------------------------------------------------------------
\def\sos@sepline{%
        {\normalsize\color{ctpsymbol}{\huge$\llap{$\diamond$}\hspace*{-1pt}$}\rule[0.346\baselineskip]{\linewidth}{0.55pt}{\huge$\hspace*{-1pt}\rlap{$\diamond$}$}}%
    }

\defbeamertemplate*{title page}{seraphim}[1][]{%
    \begin{tikzpicture}[remember picture, overlay]
        % as canvas color can fail:
        \fill[ctpbackground] (current page.south west) rectangle (current page.north east);
        \node[align=center,text width=\linewidth,ctpsymbol,font=\usebeamerfont{title}] at(current page.center) {%
            \hbox{}\hfill\llap{\begin{tikzpicture}[scale=0.035]
            \def\sos@font@futura@color@current{ctptext}
            \sos@ntts
            \node[\sos@font@futura@color@current,overlay] at ($(ct@ystraw)+(-22.5mm,132mm)$) {\tiny\bfseries/};
            \end{tikzpicture}
            }\leavevmode\vspace*{0.5ex}\newline
            \begin{minipage}{0.95\linewidth}
                {\tiny\hbox{}\expandafter\ifx\expandafter\\\sos@register@groupnum\\\else\quad Team\(\;\)\sos@register@groupnum\fi\hfill\DateConvert{\sos@register@duedate}\hbox{}\quad\hbox{}}\\[-0.6\baselineskip]
            \sos@sepline
            \begin{center}
                \strut\inserttitle\vspace*{-0.5\topsep}    
            \end{center}
            \sos@sepline
            \begin{center}
                \usebeamerfont{subtitle}
                \vspace*{-\topsep}
                {\strut\insertsubtitle}
            \end{center}            
            \end{minipage}
        };
        % place the seplines
    \end{tikzpicture}
}


%% -----------------------------------------------------------------------------
%% Sizing Stuff
%% -----------------------------------------------------------------------------
\setbeamersize{text margin left=0.05\linewidth,text margin right=0.05\linewidth}

%% -----------------------------------------------------------------------------
%% Intro & Outro
%% -----------------------------------------------------------------------------

\def\Intro{
    \begin{frame}[noframenumbering,plain]
        \titlepage
    \end{frame}
    
    \InformationPage
    
    \begin{frame}[c]{Inhaltsübersicht}
        \begin{center}
            \begin{columns}
                \begin{column}[c]{.45\textwidth}
                    \tableofcontents[hideallsubsections,sections={1-3}]
                \end{column}
                \begin{column}[c]{.45\textwidth}
                    \tableofcontents[hideallsubsections,sections={4-6}]
                \end{column}
            \end{columns}
        \end{center}
    \end{frame}
}

\AtEndDocument{\OutroPage}

%% -----------------------------------------------------------------------------
%% Information Page
%% -----------------------------------------------------------------------------

\providecommand{\authorOutro}{}

\def\InformationPage{
\begin{frame}[plain,noframenumbering]
    \begin{tikzpicture}[remember picture,overlay]
        \fill[cprimary] (current page.north west) rectangle ($(current page.north east)+(0,-1cm)$);
        \node[right=14pt,cakzent,font=\LARGE] at ($(current page.north west)+(0,-1cm/2)$) {\strut}; % \strut
    \end{tikzpicture}
    \vskip4.225em% Fake header
    \parbox{12cm}{
        Bearbeitung:\\
        {\scriptsize\typesetAuthors\authorOutro}
        \\[1cm]
    }\hbox{}\hfill\llap{\begin{tikzpicture}[scale=0.035]
        \def\sos@font@futura@color@current{cprimary}
        \sos@ntts
        \node[\sos@font@futura@color@current,overlay] at ($(ct@ystraw)+(-22.5mm,132mm)$) {\tiny\bfseries/};
        \end{tikzpicture}
        }\hbox{}
    \leavevmode\vspace*{2cm}\\
    \parbox{9cm}{\scriptsize
        \textbf{\(-\,\)\DateConvert{2019-12-15}\(\,-\)}\\
        \color{cprimary}Dieses Layout wurde für das Softwaregrundprojekt
        im Wintersemester 2019/2020 von Florian Sihler im Rahmen des
        Informatikstudiums an der Universität Ulm vollständig in \LaTeXe{} erstellt.
    }
    \begin{tikzpicture}[remember picture,overlay]
        \fill[cprimary] (current page.south west) rectangle ($(current page.south east)+(0,1mm)$);
        \fill[cakzent] (current page.north west) rectangle ($(current page.north east)+(0,-1mm)$);
    \end{tikzpicture}
\end{frame}
}

\def\OutroPage{
    \begin{frame}[plain,noframenumbering]
    \begin{tikzpicture}[remember picture, overlay]
        % as canvas color can fail:
        \fill[ctpbackground] (current page.south west) rectangle (current page.north east);
        \node[align=center,text width=\linewidth,ctpsymbol,font=\usebeamerfont{title}] at(current page.center) {%
            \begin{tikzpicture}[scale=0.125]
            \def\sos@font@futura@color@current{ctptext}
            \sos@ntts
            \node[\sos@font@futura@color@current,overlay] at ($(ct@ystraw)+(-22.5mm,132mm)$) {\small\bfseries/};
            \expandafter\ifx\expandafter\\\sos@register@groupnum\\\else
            \node[right, font=\fontsize{14}{14}\selectfont,ctpsymbol,overlay] (ct@gnumt) at ($(ct@groupnum)+(-425mm,132mm/2)$){Team: \(\mathit{\sos@register@groupnum}\)};
            \fi
            \end{tikzpicture}
        };
        \fill[cakzent] (current page.south west) rectangle ($(current page.south east)+(0,1mm)$);
        \fill[cakzent] (current page.north west) rectangle ($(current page.north east)+(0,-1mm)$);
    \end{tikzpicture}
    \end{frame}
}

%% -----------------------------------------------------------------------------
%% Header & Footer
%% -----------------------------------------------------------------------------

\defbeamertemplate*{footline}{seraphim}[1][] {
    \begin{tikzpicture}[remember picture,overlay]
        \expandafter\ifx\expandafter\\\insertsectionhead\\\else%
        \expandafter\ifx\expandafter\\\insertsubsectionhead\\\else%
            \node[above right,yshift=0.1cm,scale=0.6,opacity=0.7] at (current page.south west) {\strut\bgroup\insertsectionhead\egroup\;--\;\bgroup\insertsubsectionhead\egroup};
        \fi\fi
        \fill[cprimary] (current page.south west) rectangle ($(current page.south east)+(0,1mm)$);
        \pgfmathsetmacro\curprocess{(\thepage-2)/(\insertdocumentendpage-2)*\paperwidth}
        \fill[cakzent] (current page.south west) rectangle ++(\curprocess pt,1mm);
        % \node[above left,scale=0.9] at($(current page.south east)+(-0.5em,0.25em)$){\scriptsize\insertframenumber/\inserttotalframenumber};
        % \node[above right,scale=0.9] at($(current page.south west)+(0.5em,0.25em)$){\scriptsize\insertshorttitle};
    \end{tikzpicture}\vspace{0.5cm}
}

\defbeamertemplate*{frametitle}{lucy}[1][]{
    \begin{tikzpicture}[remember picture,overlay]
        \fill[cprimary] (current page.north west) rectangle ($(current page.north east)+(0,-1cm)$);
        \node[right=14pt,cwhite,font=\usebeamerfont{frametitle}] at ($(current page.north west)+(0,-1cm/2-1mm)$) {{}\strut\insertframetitle\strut}; % \strut
        \fill[cakzent] (current page.north west) -| ($(current page.north east)+(0,-1mm)$) -| ($(current page.north east)+(-1mm,-9mm)$) -| ++(-14mm,8mm) -| cycle;
        \node[scale=0.9] at($(current page.north east)+(-1mm-7mm,-5.5mm)$){\insertframenumber};
    \end{tikzpicture}%
    \vskip0.7cm
}

% \defbeamertemplate*{frametitle}{lucy}[1][]{
%     \begin{tikzpicture}[remember picture,overlay]
%         % \fill[cprimary] (current page.north west) rectangle ($(current page.north east)+(0,-2.75em)$);
%         \node[right=14pt,cakzent,font=\LARGE,align=left] at ($(current page.north west)+(0,-2.75em/2)$) {\strut~\insertframetitle\\[-0.65\baselineskip]\settowidth{\sos@len@tmp@a}{\strut~\insertframetitle}\pgfmathsetmacro\@sos@tmp@chk{\sos@len@tmp@a<(\linewidth-14pt)}
%         \ifnum\@sos@tmp@chk=1\addtolength{\sos@len@tmp@a}{14pt}\else\setlength{\sos@len@tmp@a}{\linewidth}\fi
%         {\normalsize\color{chdtext}{\large$\llap{$\diamond$}\hspace*{-0.75pt}$}\rule[0.186\baselineskip]{\sos@len@tmp@a}{0.55pt}}}; % \strut
        
%     \end{tikzpicture}
%     \vskip2.25em
% }

%% -----------------------------------------------------------------------------
%% Table of Contents
%% -----------------------------------------------------------------------------

\setbeamertemplate{section in toc}{%
  {$\inserttocsectionnumber$}.~~\inserttocsection}
\setbeamercolor{subsection in toc}{bg=white,fg=structure}
\setbeamertemplate{subsection in toc}{%
  \hspace{1.2em}{\color{cprimary!50!white}\rule[0.3ex]{3pt}{3pt}}~~\small\inserttocsubsection\par}


\AtBeginSection[]
  {
     \begin{frame}[c]%<beamer>
     \frametitle{\secname}
     \vspace*{-0.75\baselineskip}\begin{center}
        \begin{columns}
            \begin{column}[c]{.45\textwidth}
                \tableofcontents[currentsection,sectionstyle=show/shaded,subsectionstyle=show/show/hide,sections={1-3}]
            \end{column}
            \begin{column}[c]{.45\textwidth}
                \tableofcontents[currentsection,sectionstyle=show/shaded,subsectionstyle=show/show/hide,sections={4-6}]
            \end{column}
        \end{columns}
     \end{center}
     \end{frame}
  }



%% -----------------------------------------------------------------------------
%% Listings (sopra-listings), Attachments (sopra-attachments,...)
%% -----------------------------------------------------------------------------

\def\sos@SetListing{
    \makeatletter
    \colorlet{sol@colors@lst@keywordA}{cprimary} % e.g.: class, public, static...
    \colorlet{sol@colors@lst@keywordB}{cakzent} % e.g.: int, double ...
    \colorlet{sol@colors@lst@keywordC}{cakzent!85!black} % e.g.: class-names?
    \colorlet{sol@colors@lst@numbers}{chighlight!90!cprimary} % well, numbers
    \colorlet{sol@colors@lst@literals}{cakzent!90!brown} % well, literals
    \colorlet{sol@colors@lst@comments}{clight!10!gray} % well, comments
    \colorlet{sol@colors@lst@highlight}{chighlight} % sweetspots
    \sol@list@define@styles{%
        {keywordA:      \color{sol@colors@lst@keywordA}\bfseries},%
    }
    \makeatother
}


\def\sos@SetAttachment{
    \makeatletter
    \attachfilesetup{%
        author={\sos@register@authors},
        color=cakzent,
        icon=Tag,
        mimetype=text/plain % we assume
    }
    \makeatother
}

\def\sos@SetTables{
    \makeatletter
    \colorlet{MaterialHeaderColor}{cprimary!80!white}
    \colorlet{NextMaterialHeaderColor}{cprimary!60!white}
    \makeatother
}

\def\sos@SetModels{
    \tikzumlset{fill usecase=MudWhite, fill system=MudWhite!20, fill state=MudWhite,fill object=MudWhite, fill class=MudWhite,fill note=cprimary, font=\small\ttfamily}
}

\ifsos@applystyle@
\AtBeginDocument{
    \@ifundefined{thesolversion}{}{\sos@SetListing} % listings
    \@ifundefined{thesoaversion}{}{\sos@SetAttachment} % attachments
    \@ifundefined{thesorversion}{}{\sos@SetTables} % requirements
    \@ifundefined{thesotversion}{}{\sos@SetTables} % tables
    \@ifundefined{thesomversion}{}{\sos@SetModels} % Models
}
\fi
\endinput