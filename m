Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB16D7D99
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjDENVn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbjDENVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852305FE1
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 06:21:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso1167590wmr.0
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680700888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlKuJWoo+oat+6Ri8hbb8nnQs7jMNtjJLEl9nvYjQQc=;
        b=VVO7metP3EazRtQYvF0Say76ghZpzK19RqxFKmCTp47swub06ByA4w5c2LYt+8w19+
         88LgTx+n4vEiGuODSc44r4JGIZNf7rA6eSh+Ijx+jFsFGN6JqZwhsc7epqU0ik4jN6PP
         KKvj64nYVf+JYEsK9mCABe6mWIom80vdrueHukRweWG2cYKXuBvT/muXj7kFPLHSkAUi
         GqtTjakWyf02WzYok3I6jkMqKEhnY2niOVc0VK7lxeVTsOFv+uBBYUmY+OLLdAjFiq2/
         dqjomatspvC7PQKrXU2a6nkkR9enSg2ACYw+3tvBgfDtTq9RzBZvIW3M0Jk6RJN0L85h
         pHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlKuJWoo+oat+6Ri8hbb8nnQs7jMNtjJLEl9nvYjQQc=;
        b=TLZYS6GRxh5xDLF8BtYJd3CVCmIJB2EtwiRwzzTngMKZonm6Ipocdc1wPNusX/QLq0
         oiNkYEnzaQd6qCiRd9tHQ44dT/dUXL3aw8I6xz2xRuGVYk1idzDlWy+DKh3+c7nLNmDZ
         t2MwRG8oReqoj77RiHS3Zo+Q9LspkVF71oa8VrDzZTeX/9UDdv5yQl6Vfv7WoKC81dqN
         6UCY7nAmnRvYdSBGyG80xuVZptvY8n9fts0TpBFL1xWEbGO3rma2HoZG1KRaBXmpGYWg
         cYwzIJNIotfBZvx0YAlj7xzj2uXcCFVPus5Wk/WJvBffgd3m+ckpQxzgHK7aKKvXCwmm
         R4fg==
X-Gm-Message-State: AAQBX9eEVfRE341Ainjg8dzLsSThpNGP8BbnUSqwwyTNYGVcQZvIo1nB
        6Uln3T1VGStzGOK4BP0G5lT+eA==
X-Google-Smtp-Source: AKy350bzut10FsYN2k+tUnJegTgPO7sEAJhBsqRuOf711wxqiWozwvFnkgENd7nhu2wGJB/rWGgh/A==
X-Received: by 2002:a05:600c:b91:b0:3ed:bfb4:ad9f with SMTP id fl17-20020a05600c0b9100b003edbfb4ad9fmr1819042wmb.2.1680700887937;
        Wed, 05 Apr 2023 06:21:27 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:8147:b5f5:f4cc:b39b])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003ed243222adsm2147306wmr.42.2023.04.05.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:21:27 -0700 (PDT)
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
        bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 5/7] bpftool: Support "opcodes", "linum", "visual" simultaneously
Date:   Wed,  5 Apr 2023 14:21:18 +0100
Message-Id: <20230405132120.59886-6-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405132120.59886-1-quentin@isovalent.com>
References: <20230405132120.59886-1-quentin@isovalent.com>
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
 tools/bpf/bpftool/bash-completion/bpftool     | 17 +++---
 tools/bpf/bpftool/prog.c                      | 61 ++++++++++---------
 3 files changed, 47 insertions(+), 39 deletions(-)

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
index a3cb07172789..69c64dc18b1d 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -271,7 +271,7 @@ _bpftool()
 
     # Deal with simplest keywords
     case $prev in
-        help|hex|opcodes|visual|linum)
+        help|hex)
             return 0
             ;;
         tag)
@@ -369,13 +369,16 @@ _bpftool()
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
+                            _bpftool_once_attr 'linum opcodes'
                             if _bpftool_search_list 'xlated' && [[ "$json" == 0 ]]; then
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
index 736defc6e5d0..092525a6933a 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -905,37 +905,42 @@ static int do_dump(int argc, char **argv)
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
 	if (json_output && visual) {
@@ -2419,8 +2424,8 @@ static int do_help(int argc, char **argv)
 
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

