Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC16C88F6
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 00:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCXXCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 19:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXXCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 19:02:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB021DB84
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j24so3258951wrd.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679698947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzN6tvpsCaYcS65BGuMVc3R8tGhbb9PBn4o+9mQg/WA=;
        b=gpn2kVZE+bNdBOgE0FlWgaTbOpM/Uh4FcGM01KTOXpZiKbY5MxQaL4u5I8CRgFF1NC
         KZdIZmOiAekH7AGjLnz0kjYtv7/pHpVHVUHlLFdAOSPGxQ2pDNe6BgAxOd7crPphwHqd
         9h6+GbhP/yf5tYFfQBdXUkDwTHLpNKbJEWypVt/XDzZLyMWYpyQBzUc/nGMoitwTx8sg
         trzZiPRvE11ybnW2FPtPLk655c3zq+K1Yje7VVwwU3PdIXlrD9yv7vsPmIEG2W+6bdpE
         sYbRCGmIExkUOkeI9f/HjUU5xmvUP7B7O/TFovRLMyBZSKoylfcjAmtryyIHCfebld9z
         PYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679698947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzN6tvpsCaYcS65BGuMVc3R8tGhbb9PBn4o+9mQg/WA=;
        b=bcXnChGBpvoN6rVyNheeZRyGSFLV7ceJToZKVaiEj+nxU6EMxxgw0woSOBslBBYE7i
         SnBz0kufxd0emwrRgKORzbxH31frfVW4zn8RkaN9MtydqVhQhBeHuXP1ri4m/+YjlwyY
         Ke4Wy3I1T9h55JBC9vkDSo3psmvMzzKQ/4nvSO52aDy9OZ5IWkggUO8f7sf/iqiMDMYq
         rPie/0Cl7NT5eSy9F3z061R/mquNSpCw1GpV++9h74Yuibg5X34eprz0J4S4iV8GbhCA
         HNb1l8vyZ5HRFbTPk7FfvXZOwfZPtiUdrvRCrxRO97VwzobAdjrYT1zcsy5CoOfYryEg
         Tg/A==
X-Gm-Message-State: AAQBX9cRINbflAJ9UdzKQgCLSJsSTFtgTn47JuhChZOv5E+0z/S4tZ66
        e6Ns4rXYS2gdk8HvhuywxQc2MA==
X-Google-Smtp-Source: AKy350asXMrek77O4CLLnwnauQ16OhbSnIQEBUjUclhNAr07z0lTLmEm9uYWA56GoZi4IxcEFCRayA==
X-Received: by 2002:a5d:4dcf:0:b0:2d1:55fe:36b3 with SMTP id f15-20020a5d4dcf000000b002d155fe36b3mr3260505wru.16.1679698946825;
        Fri, 24 Mar 2023 16:02:26 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:c17f:3e3e:3455:90b])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm19340342wrs.44.2023.03.24.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:02:26 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 4/5] bpftool: Support "opcodes", "linum", "visual" simultaneously
Date:   Fri, 24 Mar 2023 23:02:08 +0000
Message-Id: <20230324230209.161008-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324230209.161008-1-quentin@isovalent.com>
References: <20230324230209.161008-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When dumping a program, the keywords "opcodes" (for printing the raw
opcodes), "linum" (for displaying the filename, line number, column
number along with the source code), and "visual" (for generating the
control flow graph for translated programs) are mutually exclusive. But
there's no reason why they should be. Let's make it possible to pass
several of them at once. The "file FILE" option, which makes bpftool
output a binary image to a file, remains incompatible with the others.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 .../bpftool/Documentation/bpftool-prog.rst    |  8 +--
 tools/bpf/bpftool/bash-completion/bpftool     | 18 +++---
 tools/bpf/bpftool/prog.c                      | 61 ++++++++++---------
 3 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 06d1e4314406..9443c524bb76 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -28,8 +28,8 @@ PROG COMMANDS
 =============
 
 |	**bpftool** **prog** { **show** | **list** } [*PROG*]
-|	**bpftool** **prog dump xlated** *PROG* [{**file** *FILE* | **opcodes** | **visual** | **linum**}]
-|	**bpftool** **prog dump jited**  *PROG* [{**file** *FILE* | **opcodes** | **linum**}]
+|	**bpftool** **prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
+|	**bpftool** **prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
 |	**bpftool** **prog pin** *PROG* *FILE*
 |	**bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
 |	**bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
@@ -88,7 +88,7 @@ DESCRIPTION
 		  programs. On such kernels bpftool will automatically emit this
 		  information as well.
 
-	**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | **opcodes** | **visual** | **linum** }]
+	**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
 		  Dump eBPF instructions of the programs from the kernel. By
 		  default, eBPF will be disassembled and printed to standard
 		  output in human-readable format. In this case, **opcodes**
@@ -109,7 +109,7 @@ DESCRIPTION
 		  be displayed.  If **linum** is specified, the filename, line
 		  number and line column will also be displayed.
 
-	**bpftool prog dump jited**  *PROG* [{ **file** *FILE* | **opcodes** | **linum** }]
+	**bpftool prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
 		  Dump jited image (host machine code) of the program.
 
 		  If *FILE* is specified image will be written to a file,
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 35f26f7c1124..98eb3852e771 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -268,7 +268,7 @@ _bpftool()
 
     # Deal with simplest keywords
     case $prev in
-        help|hex|opcodes|visual|linum)
+        help|hex)
             return 0
             ;;
         tag)
@@ -366,13 +366,17 @@ _bpftool()
                             return 0
                             ;;
                         *)
-                            _bpftool_once_attr 'file'
+                            # "file" is not compatible with other keywords here
+                            if _bpftool_search_list 'file'; then
+                                return 0
+                            fi
+                            if ! _bpftool_search_list 'linum opcodes visual'; then
+                                _bpftool_once_attr 'file'
+                            fi
+                            _bpftool_once_attr 'linum'
+                            _bpftool_once_attr 'opcodes'
                             if _bpftool_search_list 'xlated'; then
-                                COMPREPLY+=( $( compgen -W 'opcodes visual linum' -- \
-                                    "$cur" ) )
-                            else
-                                COMPREPLY+=( $( compgen -W 'opcodes linum' -- \
-                                    "$cur" ) )
+                                _bpftool_once_attr 'visual'
                             fi
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index d855118f0d96..567ac37dbd86 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -907,37 +907,42 @@ static int do_dump(int argc, char **argv)
 	if (nb_fds < 1)
 		goto exit_free;
 
-	if (is_prefix(*argv, "file")) {
-		NEXT_ARG();
-		if (!argc) {
-			p_err("expected file path");
-			goto exit_close;
-		}
-		if (nb_fds > 1) {
-			p_err("several programs matched");
-			goto exit_close;
-		}
+	while (argc) {
+		if (is_prefix(*argv, "file")) {
+			NEXT_ARG();
+			if (!argc) {
+				p_err("expected file path");
+				goto exit_close;
+			}
+			if (nb_fds > 1) {
+				p_err("several programs matched");
+				goto exit_close;
+			}
+
+			filepath = *argv;
+			NEXT_ARG();
+		} else if (is_prefix(*argv, "opcodes")) {
+			opcodes = true;
+			NEXT_ARG();
+		} else if (is_prefix(*argv, "visual")) {
+			if (nb_fds > 1) {
+				p_err("several programs matched");
+				goto exit_close;
+			}
 
-		filepath = *argv;
-		NEXT_ARG();
-	} else if (is_prefix(*argv, "opcodes")) {
-		opcodes = true;
-		NEXT_ARG();
-	} else if (is_prefix(*argv, "visual")) {
-		if (nb_fds > 1) {
-			p_err("several programs matched");
+			visual = true;
+			NEXT_ARG();
+		} else if (is_prefix(*argv, "linum")) {
+			linum = true;
+			NEXT_ARG();
+		} else {
+			usage();
 			goto exit_close;
 		}
-
-		visual = true;
-		NEXT_ARG();
-	} else if (is_prefix(*argv, "linum")) {
-		linum = true;
-		NEXT_ARG();
 	}
 
-	if (argc) {
-		usage();
+	if (filepath && (opcodes || visual || linum)) {
+		p_err("'file' is not compatible with 'opcodes', 'visual', or 'linum'");
 		goto exit_close;
 	}
 
@@ -2417,8 +2422,8 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list } [PROG]\n"
-		"       %1$s %2$s dump xlated PROG [{ file FILE | opcodes | visual | linum }]\n"
-		"       %1$s %2$s dump jited  PROG [{ file FILE | opcodes | linum }]\n"
+		"       %1$s %2$s dump xlated PROG [{ file FILE | [opcodes] [linum] [visual] }]\n"
+		"       %1$s %2$s dump jited  PROG [{ file FILE | [opcodes] [linum] }]\n"
 		"       %1$s %2$s pin   PROG FILE\n"
 		"       %1$s %2$s { load | loadall } OBJ  PATH \\\n"
 		"                         [type TYPE] [dev NAME] \\\n"
-- 
2.34.1

