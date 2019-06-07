---
title: Towards the Automated Generation of Island Grammars
title-running: Towards the Automated Generation of Island Grammars
authors-running: Roberts and Griffith
affiliations:
  authors: "Rosetta Roberts and Isaac Griffith"
  department: Informatics and Computer Science
  institute: Idaho State University
  city: "Pocatello"
  state: "Idaho"
  country: "United States"
  postcode: "83208"
  email: "robepea2@isu.edu, grifisaa@isu.edu"
acm-doi:
  copyrightyear: 2019
  acmYear: 2019
  setcopyright: acmlicensed
  acmConference:
    shortTitle: "Woodstock '18"
    longTitle: "Woodstock '18: ACM Symposium on Neural Gaze Detection"
    date: "June 03--05, 2018"
    place: "Woodstock, NY"
  acmBooktitle: "Woodstock '18: ACM Symposium on Neural Gaze Detection, June 03--05, 2018, Woodstock, NY"
  acmPrice: 15.00
  acmDOI: 10.1145/1122445.1122456
  acmISBN: 978-1-4503-9999-9/18/06
submission_id:
abstract: |
    **Background**: Since the introduction of island grammars, they've been successfully used for a variety of tasks. This includes impact analysis, multilingual parsing, source code identification, and other tasks. However, there has been no attempt to automate the generation of island grammars.
    
    **Objective**: In this paper, we presented a tool to automate the generation of island grammars. It functions by receiving as input grammars from different programming languages. It then outputs and island grammars for each input grammar that describes structure and content not described by other input grammars. We perform this by converting the input grammars into equivalent graph structures, identifying maximum common subgraphs between the input grammars, removing these subgraphs from the input graphs, and then converting the remains into grammars.
    
    **Methods**: What is the statistical context and methods applied?
    
    **Results**: What are the main findings? Practical implications?
    
    **Limitations**: What are the weaknesses of this research?
    
    **Conclusions**: What is the conclusion?

acks: |
    # Acknowledgements
    

keywords:
...


# Introduction

Code analysis tools are an essential part of modern coding. Using them, software engineers find bugs, identify security flaws, increase future maintainability, and comply with business rules and regulations. Modern development workflows use code analysis tools to provide coding assistance, thereby increasing productivity. Software build processes integrate them into their pipelines for quality assurance and other services. Improvements in the technologies that these tools use allow them to solve more problems.

## Problem Statement

Codebases in modern work environments are becoming increasingly multilingual. For example, a stack for a modern web application might use 5 different languages from the start (e.g. SQL, Java, TypeScript, HTML, CSS). Multilingual codebases challenge existing code analysis tools. Especially of note is the difficulty of building static analysis tools that work across multiple programming languages @mushtaqMultilingualSourceCode2017. Current approaches focus on handwriting a grammar for each language that a tool wants to support. Our goal is to find and evaluate a way to automate this process.

## Research Objectives

Many code analysis tools transform source code into alternative forms that are easier to process before performing their analysis. One of these forms is an abstract syntax tree. The abstract syntax tree of code preserves the meaning and structure of the code, while removing details that are usually unimportant, such as spaces. The abstract syntax tree produced for code is specific to the grammar used. The focus of this research is to develop an automated method to combine grammars into an island grammar. This island grammar should describe similar constructs in the original grammars the same so that tools designed to work on this grammar will function for any programming language in the initial grammars. We anticipate that this will allow tool designers to easily support multiple programming languages in a much more maintainable way. This is especially relevant as many codebases are becoming multilingual. There is currently extremely little research on the development of multilingual parsers, which has made static analysis of these multilingual codebases difficult @mushtaqMultilingualSourceCode2017.

## Context



Code analysis tools are an essential part of modern coding. Using them, software engineers find bugs, identify security flaws, increase future maintainability, and comply with business rules and regulations. Modern development workflows use code analysis tools to provide coding assistance, thereby increasing productivity. Software build processes integrate them into their pipelines for quality assurance and other services. Improvements in the technologies that these tools use allow them to solve more problems.

## Organization



# Background and Related Work

## Context Free Grammars

A context free grammar can be described as \(G = (V,\Sigma{},P,S)\) [@haoxiangLanguagesMachinesIntroduction1988]. \(V\) is the set of non-terminal symbols. \(\Sigma\) is the set of terminal symbols. \(P \subseteq V \times (V\cup\Sigma)^* \) is the set of productions describing how the symbols of \(V\) can be substituted for other symbols. These productions are written as \(a \rightarrow b\) with \(a \in V\) and \(b \in (V\cup\Sigma)^* \). When \(b\) is empty, the production is denoted by \(a \rightarrow \varepsilon\). \(S \in V\) is the starting symbol. A valid string is represented by a grammar if it can created by repeatedly applying productions [@moonenGeneratingRobustParsers2001]. \(L(G)\) is used to denote the set of all valid sentences, or language, of grammar \(G\).

## Abstract Syntax Trees

An abstract syntax tree is an ordered tree describing the symbols and productions of a grammar that are applied for a given sentence in the grammar. An ordered tree is a tree for which the children of each node are numbered. Given a grammar \(G = (V,\Sigma,P,S)\), the leaf nodes of a tree must be elements from \(\Sigma\cup\{\varepsilon\}\) (\(\varepsilon\) represents the empty string). The concatenation from left to right of the leaf nodes should equal the sentence for which the parse tree is for. Each internal node must be a member of \(V\). For each internal node \(v\) with children \(c_1, c_2,...\), the production \(v \rightarrow c_1c_2...\) must be a member of \(P\). The root node of the tree must be \(S\). [@reinhardwilhelmCompilerDesign1995]

## Island Grammars

Island grammars are specialized grammars designed to match certain constructs of interest, called islands [@moonenGeneratingRobustParsers2001]. They are also designed to blindly match surrounding content that is not of interest as water. They offer several advantages over regular grammars for many applications including faster development time, lower complexity, and better error tolerance. Island grammars have been used for many applications including documentation extraction and processing [@deursenBuildingDocumentationGenerators1999], impact analysis [@moonenLightweightImpactAnalysis2002], and extracting code embedded in natural language documents [@bettenburgWhatMakesGood2008] [@bacchelliExtractingStructuredData2011]. Of particular interest to our research is their use for creating multilingual parsers [@synytskyyRobustMultilingualParsing2003], which inspired this research, and the development of tolerant grammars [@klusenerDerivingTolerantGrammars2003] [@goloveshkinTolerantParsingSpecial2018] [@kursBoundedSeas2015].

## Tolerant Grammars

Tolerant grammars were initially designed as a way of making island grammars more robust. To do this, Klusener and Lammel @klusenerDerivingTolerantGrammars2003 first identified possible problems with island grammars. False positives are content identified by the island grammar as islands even though they are not constructs of interest. False negatives are constructs of interest that the island grammar fails to recognize as islands. To minimize the number of false positives and false negatives, @klusenerDerivingTolerantGrammars2003 came up with the idea to share productions between the island grammar and the full grammar it's related to. The grammars created in this process minimize false negatives and false positives. The shared portions between the island grammar and the full grammar must start at their start nodes and extend to a certain depth.

## Maximum Common Subgraph (MCS)

The maximum common subgraph problem is the problem where you try to find maximal isomorphic subgraphs in two labeled graphs. It's commonly used in bioinformatics for finding similarities between chemical structures [@raymondMaximumCommonSubgraph]. This problem is usually broken down into different variations depending on the connectedness of the subgraph, the maximality measure used, and whether approximate or exact solutions are desired. These variations can usually be converted between one another with little work (with exception between approximate and exact variations). For our research, we depend on the connected maximum common induced subgraph variation (connected MCIS). An induced subgraph \(S\) of a graph \(J\) has an edge between two vertices if and only if \(J\) has the same edge between the same two vertices. In connected MCIS, the subgraphs found must be connected and must be induced. The maximality measure used is the number of vertices in the isomorphic subgraphs.

The maximum common subgraph problem is an NP-Complete problem @gareyComputersIntractabilityGuide1979. Because of the difficulty of the problem, several algorithms have been designed for solving the different variations. The algorithms for exact solutions tend to fall into two different kinds of algorithms. The first kind are clique-based algorithms that depend on reducing the MCS problem to the maximal-clique (MC) problem. This is done by calculating the modular product between two graphs. The second kind of algorithms used are backtracking algorithms. These algorithms function by modeling possible solutions with a search tree and then pruning away non-promising solutions.

For more than two graphs, this problem reduces to the maximal frequent subgraph problem. While these problems might seem quite similar, the algorithms for solving them are quite different.





# Experimental Design

## Goals, Hypotheses and Variables

We hypothesize that our method for creating multilingual grammars has the following properties:

* The grammar should accept exactly the sentences that are valid in any of the languages used to build the grammar. \(s \in L(G_1)\cup L(G_2) \leftrightarrow s \in L(G_{12})\).

## Experimental Design



## Experimental Subjects



## Experimental Objects



## Instrumentation



## Data Collection Procedures



## Analysis Procedures



## Evaluation of Validity



# Execution

## Sample


## Preparation


## Data Collection Performed


## Validity Procedures




# Analysis

## Descriptive Statistics


## Data Set Reduction


## Hypothesis Testing



# Interpretation

## Evaluation of Results


## Limitations of Study


## Inferences


## Lessons Learned



# Conclusions and Future Work

## Summary of Findings


## Relation to Existing Evidence


## Impact


## Limitations


## Future Work




\appendix

# Appendices


