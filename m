Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79DC6CA221
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 13:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjC0LHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 07:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjC0LHM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 07:07:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D29649F5
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so8317029wrh.6
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679915224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGQDtSSPMSR1DCIvbtvb1FsnYetWS66LzMfOIyvWXTQ=;
        b=dN4cPdm+PN+Qid6l9np5JsOkccYV4/KlMHsxqiQiNmF07qaRTN6lNaNbZs8vxnnIFU
         1JZZ8U8whzYz3S8E84atuMGqWb5//mChbAFJL8Eo3z37frCLpfzhuy3XZkC+B9p8eLU3
         6fq5to0Bi3zSWjhGcVc5FwxKKPzhapnX7wNB0xBU8N2zPUYHbcg6u5bGwVj4ZIFnVhAl
         MB0sw0OtzdCupOq7FYwm6mwTj4Bel4JqffBa4yhW60PjEi+UVzP9qrwMQh+hPzUJuX+6
         sf91TQjAtp0TpHFjndFBWvzZD8vNX8p+o3Mnp7+/l5v3Vwb4oNV7B/6HkeADhQsCSGuv
         X6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679915224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGQDtSSPMSR1DCIvbtvb1FsnYetWS66LzMfOIyvWXTQ=;
        b=sH8/3Nk01dMqBngMGUGuLlqb3ShIBPk4AtIPhYF41KGZYqYsLjk3u8ofkpDiprWvx2
         oov5Ap3t2Ja6Jd/p/XZc52M3DToGJ5MgdFL0Ukuo5HADdb4l/7A+x/AGs0yphBzKo/3P
         Pu8aHJoytKOf4A1nGmxbbw2DAWxxzvHdIKTOIlhy8N++MTYEn6OoJfDjlNtVeI6lbZn5
         NVfSphWqBzEbsJq765FQfpaWr+Q32A9A6xSCvpF8wVTGDcIT9P32a/eqwplNHUk8rHRJ
         xGbRTzLVFZKN/Z49DIeXWTRWojoPPApPESjlSCDCRLtWD7FDBj6XUe09UAz/29rDZQIg
         U8lg==
X-Gm-Message-State: AAQBX9dUt2/oXqf4kaVSI0RyUZ0KmK+nG7nwg8XOL8Vt8XRYwyE8Cph8
        /MFCDujrhXhDpxNdP52OzVoR1Q==
X-Google-Smtp-Source: AKy350bsbWdignZV5sa6x5NTUCOuxruvpRBwM0GDDFQPG7iHXEYqNM/ISwQNxVaGOFD2TOm0tec4xg==
X-Received: by 2002:adf:efc7:0:b0:2da:45b6:a1d5 with SMTP id i7-20020adfefc7000000b002da45b6a1d5mr8479541wrp.3.1679915223864;
        Mon, 27 Mar 2023 04:07:03 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:61cd:634a:c75b:ba10])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002d1daafea30sm24772958wrz.34.2023.03.27.04.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:07:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/5] bpftool: Support "opcodes", "linum", "visual" simultaneously
Date:   Mon, 27 Mar 2023 12:06:54 +0100
Message-Id: <20230327110655.58363-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327110655.58363-1-quentin@isovalent.com>
References: <20230327110655.58363-1-quentin@isovalent.com>
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
Acked-by: Stanislav Fomichev <sdf@google.com>
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

