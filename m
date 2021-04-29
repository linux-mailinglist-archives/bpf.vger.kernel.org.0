Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD48736F231
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 23:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhD2Vlu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbhD2Vlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 17:41:49 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3912C06138C
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 14:41:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o5so68802063qkb.0
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7N4W24reCRk4JmUbPCfP10EVmpvZYDdRbmAGafvM9O8=;
        b=fuBQb978uPyUp486mOyDjfycdBhqAWEsaw9IXS5d+zGWYtXfyPQpzowtxTwU1XhNol
         e9za6oHbiEB9B94IiCmVSC/mt4LixhS+E+I6rihnrZTijdoZDtq+tBeT8mrtdUatcYQv
         hgcjEdKtIrOFSRmdm18qIvtIKCz9zVjtro5Rmp/cIQACXhXmDrRhUqTaK2LfR4jBqB6l
         Eal1WaW0pYTWwTjWKW6z+nDjq4aQxFrzrCidPoC+8oOdxP5vSeDmlwIAFOfVqLJmf4Ka
         Jz4c35eiX/3QZB+hAPmECnwOUk3zbfr6llExfnUuDAU5dWtaQq+4fWQ30aHKfqysZ7h+
         tTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7N4W24reCRk4JmUbPCfP10EVmpvZYDdRbmAGafvM9O8=;
        b=RISu1rgcGyTMX5mEzwx+5vZAG5aNW633l+bzfMndIYOS7oXr2KjSoaxLw/1axewSGz
         LSAOp7KFtcUABxwIf528tEdLM5FFYeWWr5LPq2maqRDPRJ+wMaWhIL34dYn7gWzelZVZ
         lV6W4auMkQIHgryva89hjUk+ZsyrKn2E+56Qsq3jlJ1n1zNd9gXrNyXAjwelLkPRhDwk
         i5WOVgVt75Px748S2PbLLrhzed1ziL+HGPhmxbSdgZfZhHXc9/bUFzd5Ee/+PZyxwzfg
         gVh+Ysi04l7hc940ipA5L8dw11tYFsKTJMwirzLyhFDQ9YqxX1DtfH3QqNGPrlh2BFTx
         RrAg==
X-Gm-Message-State: AOAM531+BWxLzn5hdr+CYAcetidn9ZjPceMH6LENg03HYkjJyfMitqFh
        wBocO3uTGFJaRl2sFBNGbM4=
X-Google-Smtp-Source: ABdhPJxWrSrf+Js0U/xFchMEDwwnHUiXPqffgJ+YJoqKEcKi7+DxvNhpyW6IOfxAI2qGo3lwByUrXg==
X-Received: by 2002:a05:620a:a4e:: with SMTP id j14mr1777548qka.441.1619732462179;
        Thu, 29 Apr 2021 14:41:02 -0700 (PDT)
Received: from localhost.localdomain (pool-100-33-2-40.nycmny.fios.verizon.net. [100.33.2.40])
        by smtp.gmail.com with ESMTPSA id m16sm2993869qkm.100.2021.04.29.14.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:41:01 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net
Cc:     grantseltzer@gmail.com, bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/3] bpf: Add doxygen configuration file
Date:   Thu, 29 Apr 2021 05:47:33 +0000
Message-Id: <20210429054734.53264-3-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210429054734.53264-1-grantseltzer@gmail.com>
References: <20210429054734.53264-1-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds Doxyfile, the configuration file for Doxygen.
It can be evoked by navigating to it's containing directory
and running `doxygen`. Doxyfile is the default filename.

Evoking sphinx from the tools/lib/bpf/sphinx directory will
also evoke doxygen. This integrates doxygen XML output into
sphinx HTML output.

The majority of these configuraiton settings are defaults,
the main important settings are INPUT, OUTPUT_DIRECTORY,
GENERATE_XML, EXCLUDE_SYMBOLS, and OPTIMIZE_OUTPUT_FOR_C.

Signed-off-by: grantseltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/docs/sphinx/doxygen/Doxyfile | 320 +++++++++++++++++++++
 1 file changed, 320 insertions(+)
 create mode 100644 tools/lib/bpf/docs/sphinx/doxygen/Doxyfile

diff --git a/tools/lib/bpf/docs/sphinx/doxygen/Doxyfile b/tools/lib/bpf/docs/sphinx/doxygen/Doxyfile
new file mode 100644
index 000000000..905eace7b
--- /dev/null
+++ b/tools/lib/bpf/docs/sphinx/doxygen/Doxyfile
@@ -0,0 +1,320 @@
+DOXYFILE_ENCODING      = UTF-8
+PROJECT_NAME           = "libbpf"
+PROJECT_NUMBER         =
+PROJECT_BRIEF          =
+PROJECT_LOGO           =
+OUTPUT_DIRECTORY       = ./build
+CREATE_SUBDIRS         = NO
+ALLOW_UNICODE_NAMES    = NO
+OUTPUT_LANGUAGE        = English
+OUTPUT_TEXT_DIRECTION  = None
+BRIEF_MEMBER_DESC      = YES
+REPEAT_BRIEF           = YES
+ALWAYS_DETAILED_SEC    = NO
+INLINE_INHERITED_MEMB  = NO
+FULL_PATH_NAMES        = YES
+STRIP_FROM_PATH        =
+STRIP_FROM_INC_PATH    =
+SHORT_NAMES            = NO
+JAVADOC_AUTOBRIEF      = NO
+JAVADOC_BANNER         = NO
+QT_AUTOBRIEF           = NO
+MULTILINE_CPP_IS_BRIEF = NO
+PYTHON_DOCSTRING       = YES
+INHERIT_DOCS           = YES
+SEPARATE_MEMBER_PAGES  = NO
+TAB_SIZE               = 4
+ALIASES                =
+OPTIMIZE_OUTPUT_FOR_C  = YES
+OPTIMIZE_OUTPUT_JAVA   = NO
+OPTIMIZE_FOR_FORTRAN   = NO
+OPTIMIZE_OUTPUT_VHDL   = NO
+OPTIMIZE_OUTPUT_SLICE  = NO
+EXTENSION_MAPPING      =
+MARKDOWN_SUPPORT       = YES
+TOC_INCLUDE_HEADINGS   = 5
+AUTOLINK_SUPPORT       = YES
+BUILTIN_STL_SUPPORT    = NO
+CPP_CLI_SUPPORT        = NO
+SIP_SUPPORT            = NO
+IDL_PROPERTY_SUPPORT   = YES
+DISTRIBUTE_GROUP_DOC   = NO
+GROUP_NESTED_COMPOUNDS = NO
+SUBGROUPING            = YES
+INLINE_GROUPED_CLASSES = NO
+INLINE_SIMPLE_STRUCTS  = NO
+TYPEDEF_HIDES_STRUCT   = NO
+LOOKUP_CACHE_SIZE      = 0
+NUM_PROC_THREADS       = 1
+EXTRACT_ALL            = NO
+EXTRACT_PRIVATE        = NO
+EXTRACT_PRIV_VIRTUAL   = NO
+EXTRACT_PACKAGE        = NO
+EXTRACT_STATIC         = NO
+EXTRACT_LOCAL_CLASSES  = YES
+EXTRACT_LOCAL_METHODS  = NO
+EXTRACT_ANON_NSPACES   = NO
+RESOLVE_UNNAMED_PARAMS = YES
+HIDE_UNDOC_MEMBERS     = NO
+HIDE_UNDOC_CLASSES     = NO
+HIDE_FRIEND_COMPOUNDS  = NO
+HIDE_IN_BODY_DOCS      = NO
+INTERNAL_DOCS          = NO
+CASE_SENSE_NAMES       = YES
+HIDE_SCOPE_NAMES       = NO
+HIDE_COMPOUND_REFERENCE= NO
+SHOW_INCLUDE_FILES     = YES
+SHOW_GROUPED_MEMB_INC  = NO
+FORCE_LOCAL_INCLUDES   = NO
+INLINE_INFO            = YES
+SORT_MEMBER_DOCS       = YES
+SORT_BRIEF_DOCS        = NO
+SORT_MEMBERS_CTORS_1ST = NO
+SORT_GROUP_NAMES       = NO
+SORT_BY_SCOPE_NAME     = NO
+STRICT_PROTO_MATCHING  = NO
+GENERATE_TODOLIST      = YES
+GENERATE_TESTLIST      = YES
+GENERATE_BUGLIST       = YES
+GENERATE_DEPRECATEDLIST= YES
+ENABLED_SECTIONS       =
+MAX_INITIALIZER_LINES  = 30
+SHOW_USED_FILES        = YES
+SHOW_FILES             = YES
+SHOW_NAMESPACES        = YES
+FILE_VERSION_FILTER    =
+LAYOUT_FILE            =
+CITE_BIB_FILES         =
+QUIET                  = NO
+WARNINGS               = YES
+WARN_IF_UNDOCUMENTED   = YES
+WARN_IF_DOC_ERROR      = YES
+WARN_NO_PARAMDOC       = NO
+WARN_AS_ERROR          = NO
+WARN_FORMAT            = "$file:$line: $text"
+WARN_LOGFILE           =
+INPUT                  = ../../..
+INPUT_ENCODING         = UTF-8
+FILE_PATTERNS          = *.c \
+                         *.cc \
+                         *.cxx \
+                         *.cpp \
+                         *.c++ \
+                         *.java \
+                         *.ii \
+                         *.ixx \
+                         *.ipp \
+                         *.i++ \
+                         *.inl \
+                         *.idl \
+                         *.ddl \
+                         *.odl \
+                         *.h \
+                         *.hh \
+                         *.hxx \
+                         *.hpp \
+                         *.h++ \
+                         *.cs \
+                         *.d \
+                         *.php \
+                         *.php4 \
+                         *.php5 \
+                         *.phtml \
+                         *.inc \
+                         *.m \
+                         *.markdown \
+                         *.md \
+                         *.mm \
+                         *.dox \
+                         *.py \
+                         *.pyw \
+                         *.f90 \
+                         *.f95 \
+                         *.f03 \
+                         *.f08 \
+                         *.f18 \
+                         *.f \
+                         *.for \
+                         *.vhd \
+                         *.vhdl \
+                         *.ucf \
+                         *.qsf \
+                         *.ice
+RECURSIVE              = NO
+EXCLUDE                =
+EXCLUDE_SYMLINKS       = NO
+EXCLUDE_PATTERNS       =
+EXCLUDE_SYMBOLS        = ___*
+EXAMPLE_PATH           =
+EXAMPLE_PATTERNS       = *
+EXAMPLE_RECURSIVE      = NO
+IMAGE_PATH             =
+INPUT_FILTER           =
+FILTER_PATTERNS        =
+FILTER_SOURCE_FILES    = NO
+FILTER_SOURCE_PATTERNS =
+USE_MDFILE_AS_MAINPAGE = YES
+SOURCE_BROWSER         = NO
+INLINE_SOURCES         = NO
+STRIP_CODE_COMMENTS    = YES
+REFERENCED_BY_RELATION = NO
+REFERENCES_RELATION    = NO
+REFERENCES_LINK_SOURCE = YES
+SOURCE_TOOLTIPS        = YES
+USE_HTAGS              = NO
+VERBATIM_HEADERS       = YES
+ALPHABETICAL_INDEX     = YES
+IGNORE_PREFIX          =
+GENERATE_HTML          = NO
+HTML_OUTPUT            = html
+HTML_FILE_EXTENSION    = .html
+HTML_HEADER            =
+HTML_FOOTER            =
+HTML_STYLESHEET        =
+HTML_EXTRA_STYLESHEET  =
+HTML_EXTRA_FILES       =
+HTML_COLORSTYLE_HUE    = 220
+HTML_COLORSTYLE_SAT    = 100
+HTML_COLORSTYLE_GAMMA  = 80
+HTML_TIMESTAMP         = NO
+HTML_DYNAMIC_MENUS     = YES
+HTML_DYNAMIC_SECTIONS  = NO
+HTML_INDEX_NUM_ENTRIES = 100
+GENERATE_DOCSET        = NO
+DOCSET_FEEDNAME        = "Doxygen generated docs"
+DOCSET_BUNDLE_ID       = org.doxygen.Project
+DOCSET_PUBLISHER_ID    = org.doxygen.Publisher
+DOCSET_PUBLISHER_NAME  = Publisher
+GENERATE_HTMLHELP      = NO
+CHM_FILE               =
+HHC_LOCATION           =
+GENERATE_CHI           = NO
+CHM_INDEX_ENCODING     =
+BINARY_TOC             = NO
+TOC_EXPAND             = NO
+GENERATE_QHP           = NO
+QCH_FILE               =
+QHP_NAMESPACE          = org.doxygen.Project
+QHP_VIRTUAL_FOLDER     = doc
+QHP_CUST_FILTER_NAME   =
+QHP_CUST_FILTER_ATTRS  =
+QHP_SECT_FILTER_ATTRS  =
+QHG_LOCATION           =
+GENERATE_ECLIPSEHELP   = NO
+ECLIPSE_DOC_ID         = org.doxygen.Project
+DISABLE_INDEX          = NO
+GENERATE_TREEVIEW      = NO
+ENUM_VALUES_PER_LINE   = 4
+TREEVIEW_WIDTH         = 250
+EXT_LINKS_IN_WINDOW    = NO
+HTML_FORMULA_FORMAT    = png
+FORMULA_FONTSIZE       = 10
+FORMULA_TRANSPARENT    = YES
+FORMULA_MACROFILE      =
+USE_MATHJAX            = NO
+MATHJAX_FORMAT         = HTML-CSS
+MATHJAX_RELPATH        = https://cdn.jsdelivr.net/npm/mathjax@2
+MATHJAX_EXTENSIONS     =
+MATHJAX_CODEFILE       =
+SEARCHENGINE           = YES
+SERVER_BASED_SEARCH    = NO
+EXTERNAL_SEARCH        = NO
+SEARCHENGINE_URL       =
+SEARCHDATA_FILE        = searchdata.xml
+EXTERNAL_SEARCH_ID     =
+EXTRA_SEARCH_MAPPINGS  =
+GENERATE_LATEX         = NO
+LATEX_OUTPUT           = latex
+LATEX_CMD_NAME         =
+MAKEINDEX_CMD_NAME     = makeindex
+LATEX_MAKEINDEX_CMD    = makeindex
+COMPACT_LATEX          = NO
+PAPER_TYPE             = a4
+EXTRA_PACKAGES         =
+LATEX_HEADER           =
+LATEX_FOOTER           =
+LATEX_EXTRA_STYLESHEET =
+LATEX_EXTRA_FILES      =
+PDF_HYPERLINKS         = YES
+USE_PDFLATEX           = YES
+LATEX_BATCHMODE        = NO
+LATEX_HIDE_INDICES     = NO
+LATEX_SOURCE_CODE      = NO
+LATEX_BIB_STYLE        = plain
+LATEX_TIMESTAMP        = NO
+LATEX_EMOJI_DIRECTORY  =
+GENERATE_RTF           = NO
+RTF_OUTPUT             = rtf
+COMPACT_RTF            = NO
+RTF_HYPERLINKS         = NO
+RTF_STYLESHEET_FILE    =
+RTF_EXTENSIONS_FILE    =
+RTF_SOURCE_CODE        = NO
+GENERATE_MAN           = NO
+MAN_OUTPUT             = man
+MAN_EXTENSION          = .3
+MAN_SUBDIR             =
+MAN_LINKS              = NO
+GENERATE_XML           = YES
+XML_OUTPUT             = xml
+XML_PROGRAMLISTING     = YES
+XML_NS_MEMB_FILE_SCOPE = NO
+GENERATE_DOCBOOK       = NO
+DOCBOOK_OUTPUT         = docbook
+DOCBOOK_PROGRAMLISTING = NO
+GENERATE_AUTOGEN_DEF   = NO
+GENERATE_PERLMOD       = NO
+PERLMOD_LATEX          = NO
+PERLMOD_PRETTY         = YES
+PERLMOD_MAKEVAR_PREFIX =
+ENABLE_PREPROCESSING   = YES
+MACRO_EXPANSION        = YES
+EXPAND_ONLY_PREDEF     = NO
+SEARCH_INCLUDES        = YES
+INCLUDE_PATH           =
+INCLUDE_FILE_PATTERNS  =
+PREDEFINED             =
+EXPAND_AS_DEFINED      =
+SKIP_FUNCTION_MACROS   = YES
+TAGFILES               =
+GENERATE_TAGFILE       =
+ALLEXTERNALS           = NO
+EXTERNAL_GROUPS        = YES
+EXTERNAL_PAGES         = YES
+CLASS_DIAGRAMS         = YES
+DIA_PATH               =
+HIDE_UNDOC_RELATIONS   = YES
+HAVE_DOT               = NO
+DOT_NUM_THREADS        = 0
+DOT_FONTNAME           = Helvetica
+DOT_FONTSIZE           = 10
+DOT_FONTPATH           =
+CLASS_GRAPH            = YES
+COLLABORATION_GRAPH    = YES
+GROUP_GRAPHS           = YES
+UML_LOOK               = NO
+UML_LIMIT_NUM_FIELDS   = 10
+DOT_UML_DETAILS        = NO
+DOT_WRAP_THRESHOLD     = 17
+TEMPLATE_RELATIONS     = NO
+INCLUDE_GRAPH          = YES
+INCLUDED_BY_GRAPH      = YES
+CALL_GRAPH             = NO
+CALLER_GRAPH           = NO
+GRAPHICAL_HIERARCHY    = YES
+DIRECTORY_GRAPH        = YES
+DOT_IMAGE_FORMAT       = png
+INTERACTIVE_SVG        = NO
+DOT_PATH               =
+DOTFILE_DIRS           =
+MSCFILE_DIRS           =
+DIAFILE_DIRS           =
+PLANTUML_JAR_PATH      =
+PLANTUML_CFG_FILE      =
+PLANTUML_INCLUDE_PATH  =
+DOT_GRAPH_MAX_NODES    = 50
+MAX_DOT_GRAPH_DEPTH    = 0
+DOT_TRANSPARENT        = NO
+DOT_MULTI_TARGETS      = NO
+GENERATE_LEGEND        = YES
+DOT_CLEANUP            = YES
-- 
2.29.2

