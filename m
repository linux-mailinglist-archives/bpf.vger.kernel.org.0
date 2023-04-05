Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE46D7D9B
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjDENVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjDENVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F35B87
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 06:21:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so2094699wms.1
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680700888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rt5aDcXQLaaDyJ0K5Mqzee6WsTmFbybk17U/ISZxVw=;
        b=A7RyUVJ9sRIlYtIrXLU2FycKCBDrqvi4SXrT75E/q8LwI2l39KPmxKRk+tyb9Vj6qv
         D0DejYxlgzgVk76KqLvNyu/DqNY58jqyEAwcR3K+Fb7E5PES2qCnvFjCWA+ODj9wR6LC
         xNPdMfDSl586pmXA+gktb7Mp/+tCJtr1Zo7/lPHnSZNDI89o41pPWfSenMcD2Ja+ihmW
         0SPVgE3r8p41YRCyubmeh8zgtrqPO0fw69XQNmKx+SM9MAXz5JWZW3RBXNFavbANo0z0
         +KL/0C2y1j0OguscAv5OJHvawngqXv7D0jH4TTQWvGeBQPrJg0xsWo239X3C1MtmuwOU
         Hr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rt5aDcXQLaaDyJ0K5Mqzee6WsTmFbybk17U/ISZxVw=;
        b=NogIqXLl5L9YO+VX6BzpIPn4Kn6bFq9JE1JM5ICdFsefsvPw6oA+/cnVbxw4A/D5fA
         HbP/raJJC2pGvHgRyAh1xCM9A2P9fRQH798U6E/jpD2PojEeVRfE90GgEeWazJhqfngH
         0IvUhZyeBrZOb2y3IG4oxWh9ceD/5sKWA6OIIJ3xMi57RJ7yjB4aQxlXBlB9LfRzKxXf
         bH4iOxsKh/OPfLa2ivILw2Wr8i/DrjDaKYyT9XoUSv+9rTbAYE/8tDmUCDMCtNwhFGNM
         JFR6mCtdX6xNf9s9QT+Y4bOQsg+L7P/wvAS3uaAhV4YdIPU3t+CaQlHfh+P6/NuXx0Dh
         4kQA==
X-Gm-Message-State: AAQBX9fUPkaiGmW6jps3MH3UBIK+4sNUcUlABAmAv3ks+ByQ1xaBko1R
        7PmGmWmQUCHpOaKE1Ag30bk1Xg==
X-Google-Smtp-Source: AKy350ZYWV7EmnR2DX1g4yd/+/TMDgI6NqURNOa1AgDkdJDB3wp0hhgdhcwFQPWfa3b9p0+8RvCmjQ==
X-Received: by 2002:a1c:7211:0:b0:3ef:7584:9896 with SMTP id n17-20020a1c7211000000b003ef75849896mr4624502wmc.26.1680700888747;
        Wed, 05 Apr 2023 06:21:28 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:8147:b5f5:f4cc:b39b])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003ed243222adsm2147306wmr.42.2023.04.05.06.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:21:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/7] bpftool: Support printing opcodes and source file references in CFG
Date:   Wed,  5 Apr 2023 14:21:19 +0100
Message-Id: <20230405132120.59886-7-quentin@isovalent.com>
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

Add support for displaying opcodes or/and file references (filepath,
line and column numbers) when dumping the control flow graphs of loaded
BPF programs with bpftool.

The filepaths in the records are absolute. To avoid blocks on the graph
to get too wide, we truncate them when they get too long (but we always
keep the entire file name). In the unlikely case where the resulting
file name is ambiguous, it remains possible to get the full path with a
regular dump (no CFG).

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/btf_dumper.c    | 51 ++++++++++++++++++++++++++++++-
 tools/bpf/bpftool/cfg.c           | 22 ++++++++-----
 tools/bpf/bpftool/cfg.h           |  3 +-
 tools/bpf/bpftool/main.h          |  2 +-
 tools/bpf/bpftool/prog.c          |  2 +-
 tools/bpf/bpftool/xlated_dumper.c | 15 +++++++--
 tools/bpf/bpftool/xlated_dumper.h |  3 +-
 7 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 583aa843df92..6c5e0e82da22 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -842,8 +842,37 @@ static void dotlabel_puts(const char *s)
 	}
 }
 
+static const char *shorten_path(const char *path)
+{
+	const unsigned int MAX_PATH_LEN = 32;
+	size_t len = strlen(path);
+	const char *shortpath;
+
+	if (len <= MAX_PATH_LEN)
+		return path;
+
+	/* Search for last '/' under the MAX_PATH_LEN limit */
+	shortpath = strchr(path + len - MAX_PATH_LEN, '/');
+	if (shortpath) {
+		if (shortpath < path + strlen("..."))
+			/* We removed a very short prefix, e.g. "/w", and we'll
+			 * make the path longer by prefixing with the ellipsis.
+			 * Not worth it, keep initial path.
+			 */
+			return path;
+		return shortpath;
+	}
+
+	/* File base name length is > MAX_PATH_LEN, search for last '/' */
+			shortpath = strrchr(path, '/');
+	if (shortpath)
+		return shortpath;
+
+	return path;
+}
+
 void btf_dump_linfo_dotlabel(const struct btf *btf,
-			     const struct bpf_line_info *linfo)
+			     const struct bpf_line_info *linfo, bool linum)
 {
 	const char *line = btf__name_by_offset(btf, linfo->line_off);
 
@@ -851,6 +880,26 @@ void btf_dump_linfo_dotlabel(const struct btf *btf,
 		return;
 	line = ltrim(line);
 
+	if (linum) {
+		const char *file = btf__name_by_offset(btf, linfo->file_name_off);
+		const char *shortfile;
+
+		/* More forgiving on file because linum option is
+		 * expected to provide more info than the already
+		 * available src line.
+		 */
+		if (!file)
+			shortfile = "";
+		else
+			shortfile = shorten_path(file);
+
+		printf("; [%s", shortfile > file ? "..." : "");
+		dotlabel_puts(shortfile);
+		printf(" line:%u col:%u]\\l\\\n",
+		       BPF_LINE_INFO_LINE_NUM(linfo->line_col),
+		       BPF_LINE_INFO_LINE_COL(linfo->line_col));
+	}
+
 	printf("; ");
 	dotlabel_puts(line);
 	printf("\\l\\\n");
diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
index 9fdc1f0cdd6e..eec437cca2ea 100644
--- a/tools/bpf/bpftool/cfg.c
+++ b/tools/bpf/bpftool/cfg.c
@@ -381,7 +381,8 @@ static void cfg_destroy(struct cfg *cfg)
 }
 
 static void
-draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_data *dd)
+draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_data *dd,
+	     bool opcodes, bool linum)
 {
 	const char *shape;
 
@@ -401,7 +402,8 @@ draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_data *dd)
 		unsigned int start_idx;
 		printf("{\\\n");
 		start_idx = bb->head - func->start;
-		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx);
+		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx,
+				      opcodes, linum);
 		printf("}");
 	}
 
@@ -427,12 +429,14 @@ static void draw_bb_succ_edges(struct func_node *func, struct bb_node *bb)
 	}
 }
 
-static void func_output_bb_def(struct func_node *func, struct dump_data *dd)
+static void
+func_output_bb_def(struct func_node *func, struct dump_data *dd,
+		   bool opcodes, bool linum)
 {
 	struct bb_node *bb;
 
 	list_for_each_entry(bb, &func->bbs, l) {
-		draw_bb_node(func, bb, dd);
+		draw_bb_node(func, bb, dd, opcodes, linum);
 	}
 }
 
@@ -452,7 +456,8 @@ static void func_output_edges(struct func_node *func)
 	       func_idx, ENTRY_BLOCK_INDEX, func_idx, EXIT_BLOCK_INDEX);
 }
 
-static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
+static void
+cfg_dump(struct cfg *cfg, struct dump_data *dd, bool opcodes, bool linum)
 {
 	struct func_node *func;
 
@@ -460,14 +465,15 @@ static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
 	list_for_each_entry(func, &cfg->funcs, l) {
 		printf("subgraph \"cluster_%d\" {\n\tstyle=\"dashed\";\n\tcolor=\"black\";\n\tlabel=\"func_%d ()\";\n",
 		       func->idx, func->idx);
-		func_output_bb_def(func, dd);
+		func_output_bb_def(func, dd, opcodes, linum);
 		func_output_edges(func);
 		printf("}\n");
 	}
 	printf("}\n");
 }
 
-void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
+void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len,
+		     bool opcodes, bool linum)
 {
 	struct bpf_insn *insn = buf;
 	struct cfg cfg;
@@ -476,7 +482,7 @@ void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
 	if (cfg_build(&cfg, insn, len))
 		return;
 
-	cfg_dump(&cfg, dd);
+	cfg_dump(&cfg, dd, opcodes, linum);
 
 	cfg_destroy(&cfg);
 }
diff --git a/tools/bpf/bpftool/cfg.h b/tools/bpf/bpftool/cfg.h
index 909d17e6d4c2..b3793f4e1783 100644
--- a/tools/bpf/bpftool/cfg.h
+++ b/tools/bpf/bpftool/cfg.h
@@ -6,6 +6,7 @@
 
 #include "xlated_dumper.h"
 
-void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len);
+void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len,
+		     bool opcodes, bool linum);
 
 #endif /* __BPF_TOOL_CFG_H */
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index e9ee514b22d4..00d11ca6d3f2 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -230,7 +230,7 @@ void btf_dump_linfo_plain(const struct btf *btf,
 void btf_dump_linfo_json(const struct btf *btf,
 			 const struct bpf_line_info *linfo, bool linum);
 void btf_dump_linfo_dotlabel(const struct btf *btf,
-			     const struct bpf_line_info *linfo);
+			     const struct bpf_line_info *linfo, bool linum);
 
 struct nlattr;
 struct ifinfomsg;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 092525a6933a..430f72306409 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -852,7 +852,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		if (json_output)
 			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
 		else if (visual)
-			dump_xlated_cfg(&dd, buf, member_len);
+			dump_xlated_cfg(&dd, buf, member_len, opcodes, linum);
 		else
 			dump_xlated_plain(&dd, buf, member_len, opcodes, linum);
 		kernel_syms_destroy(&dd);
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 2ee83561b945..da608e10c843 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -361,7 +361,8 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
 }
 
 void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
-			   unsigned int start_idx)
+			   unsigned int start_idx,
+			   bool opcodes, bool linum)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_print	= print_insn_for_graph,
@@ -405,7 +406,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 
 			linfo = bpf_prog_linfo__lfind(prog_linfo, insn_off, 0);
 			if (linfo && linfo != last_linfo) {
-				btf_dump_linfo_dotlabel(btf, linfo);
+				btf_dump_linfo_dotlabel(btf, linfo, linum);
 				last_linfo = linfo;
 			}
 		}
@@ -413,6 +414,16 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 		printf("%d: ", insn_off);
 		print_bpf_insn(&cbs, cur, true);
 
+		if (opcodes) {
+			printf("\\ \\ \\ \\ ");
+			fprint_hex(stdout, cur, 8, " ");
+			if (double_insn && cur <= insn_end - 1) {
+				printf(" ");
+				fprint_hex(stdout, cur + 1, 8, " ");
+			}
+			printf("\\l\\\n");
+		}
+
 		if (cur != insn_end)
 			printf("| ");
 	}
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index 54847e174273..9a946377b0e6 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -34,6 +34,7 @@ void dump_xlated_json(struct dump_data *dd, void *buf, unsigned int len,
 void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
 		       bool opcodes, bool linum);
 void dump_xlated_for_graph(struct dump_data *dd, void *buf, void *buf_end,
-			   unsigned int start_index);
+			   unsigned int start_index,
+			   bool opcodes, bool linum);
 
 #endif
-- 
2.34.1

