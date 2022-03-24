\ProvidesClass{comran_morshed_resume}[Comran Morshed Resume format]

\LoadClass[11pt,letterpaper]{article}

\usepackage[parfill]{parskip}
\usepackage{array}
\usepackage{ifthen}
\usepackage[left=0.4 in,top=0.4in,right=0.4 in,bottom=0.4in]{geometry}
\usepackage[default]{lato}
\usepackage[T1]{fontenc}
\usepackage{multirow}
\usepackage{tabularx}
\usepackage[table]{xcolor}

\newcommand{\tab}[1]{\hspace{.2667\textwidth}\rlap{#1}}
\newcommand{\itab}[1]{\hspace{0em}\rlap{#1}}

\usepackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,
    urlcolor=cyan,
}
\pagestyle{empty}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants

 % Size of the name at the top of the document.
\def\namesize{\fontsize{2.5em}{2.5em}\selectfont}

 % Size of the addresses at the top of the document.
 \def\addresssize{\fontsize{0.9em}{0.9em}\selectfont}
 
% The space between the two address (or phone/email) lines.
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
 
% The space above the horizontal line for each section .
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section 
 
% The space after the heading section.
\def\sectionskip{\medskip} % The space after the heading section

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADING

% Name
\def \fname#1{\def\@fname{#1}}
\def \@fname {}
\def \lname#1{\def\@lname{#1}}
\def \@lname {}

\def \addressSep { $|$ }

% One, two or three address lines can be specified 
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

% \address command can be used to set the first, second, and third address (last 2 optional)
\def \address #1{
    \@ifundefined{@addressone}{
        \def \@addressone {#1}
    }{
    \@ifundefined{@addresstwo}{
        \def \@addresstwo {#1}
    }{
        \def \@addressthree {#1}
    }}
}

% \printname is used to print the name as a page header
\def \printname {
    \begingroup
    \namesize {\@fname\,{\bf \@lname}}
    \endgroup
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
\begingroup
\def \\ {\addressSep\ }
\addresssize {#1}
\endgroup
}

%----------------------------------------------------------------------------------------
%	PRINT THE HEADING LINES
%----------------------------------------------------------------------------------------

\let\ori@document=\document
\renewcommand{\document}{
    \ori@document
    \begin{tabularx}{\textwidth}{@{}X>{\raggedleft\arraybackslash}X@{}}
        \multirow{3}{*}{\printname} & {\printaddress{\@addressone}} \\
                                    & {\printaddress{\@addresstwo}} \\
                                    & {\printaddress{\@addressthree}} \\
    \end{tabularx}
}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
    \MakeUppercase{\bf #1} % Section title
    \sectionlineskip
    \hrule % Horizontal line
    \begin{list}{}{ % List for each individual item in the section
            \setlength{\leftmargin}{0em} % Margin within the section
        }
        \item[]
              }{
    \end{list}
}

%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

\newenvironment{rSubsection}[4]{ % 4 input arguments - company name, year(s) employed, job title and location
{\bf #1} \hfill {#2} % Bold company name and date on the right
\ifthenelse{\equal{#3}{}}{}{ % If the third argument is not specified, don't print the job title and location line
\\
{\em #3} \hfill {\em #4} % Italic job title and location
}\smallskip
\begin{list}{$\cdot$}{\leftmargin=0em} % \cdot used for bullets, no indentation
    \itemsep -0.5em \vspace{-0.5em} % Compress items in list together for aesthetics
          }{
\end{list}
\vspace{0.5em} % Some space after the list of bullet points
}
