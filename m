Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE776C88F7
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 00:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjCXXCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 19:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjCXXCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 19:02:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F931DB88
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q19so162677wrc.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679698948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSyg7i7CDZTnqKN9ZDevHyjOTAmDl0F2Z8eezV1CL60=;
        b=NyahoSg+crISts5tUVqMkKvK/1C7/t14nEHzw1ioa9iWiHM6bM7BnTjvvxz/MIa3PU
         E/md5Ha5IBzct3p+oho79i93T1+4OU0NW/Pmj1B6QGp6BHwTGWqagOXjj+inwcOYdpK5
         6asR5XBtqXVF0uZttg6LCZwAGOUkh3M3YFTzfD1nhQWxnYF5SGFUUN1ZGPlk1lQ4oN/1
         T1x7G77sbq7JKnrwJaPo9aomQsZ2OX0arwbFTXGtrXVtG1MLPhjxKDnusMx1ZHaotkmq
         bmEEW3c5lq+T0FoDjOle4r8DK0Jk0B93eLrq079UgfC/HZQkS5So9keG6vddflp4GDWM
         RGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679698948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSyg7i7CDZTnqKN9ZDevHyjOTAmDl0F2Z8eezV1CL60=;
        b=vJAwrGDqYr2cVo3sN91e2UF90YluE4rX3fu79W6eBkCGwmifc6h3Elq+mvGwi8VR6d
         WMZUDc6dhoBgVyb9+CWT0FxM58i4GcS1w5+waZSuxot7ADPhw2IG6lP4cO42FST7tfAS
         b9i+PRayq7tfT8Q1brPFyDnucXzdawEA9ownGPF6Z3xI6I9PcF7HARZlhgNfy4g8xsG7
         Fe4Vstyje9TadmMKFfrThSjI1AqWenHn3eaBYQvyvaS4An/pnuVssyeA0D/fjL/G5Neg
         g/P25BCLUL4FJzIKxEmI9Vg4fIyLmteuuZckc+RrIbqqWzKmfeBQuurknvGc6MJYkDh5
         sokw==
X-Gm-Message-State: AAQBX9ckVKv3b2Jhm2NQra9CSDLIUlCwabo79wh+qqDspMawNBlAHGew
        /Yx8FPdaAhESCsURvow5OjtO8g==
X-Google-Smtp-Source: AKy350bHkwi78rdxERmzzWwhHl5HCNaRAF1BeXwQgs8ZKIf9lsnGDHCn45N+FzeuBH4iGB6EBxKdog==
X-Received: by 2002:a5d:58e9:0:b0:2d1:87f:2cd1 with SMTP id f9-20020a5d58e9000000b002d1087f2cd1mr3954126wrd.25.1679698948203;
        Fri, 24 Mar 2023 16:02:28 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:c17f:3e3e:3455:90b])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm19340342wrs.44.2023.03.24.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:02:27 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/5] bpftool: Support printing opcodes and source file references in CFG
Date:   Fri, 24 Mar 2023 23:02:09 +0000
Message-Id: <20230324230209.161008-6-quentin@isovalent.com>
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

Add support for displaying opcodes or/and file references (filepath,
line and column numbers) when dumping the control flow graphs of loaded
BPF programs with bpftool.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/btf_dumper.c    | 19 ++++++++++++++++++-
 tools/bpf/bpftool/cfg.c           | 22 ++++++++++++++--------
 tools/bpf/bpftool/cfg.h           |  3 ++-
 tools/bpf/bpftool/main.h          |  2 +-
 tools/bpf/bpftool/prog.c          |  2 +-
 tools/bpf/bpftool/xlated_dumper.c | 15 +++++++++++++--
 tools/bpf/bpftool/xlated_dumper.h |  3 ++-
 7 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 504d7c75cc27..54cb105c1648 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -843,7 +843,7 @@ static void dotlabel_puts(const char *s)
 }
 
 void btf_dump_linfo_dotlabel(const struct btf *btf,
-			     const struct bpf_line_info *linfo)
+			     const struct bpf_line_info *linfo, bool linum)
 {
 	const char *line = btf__name_by_offset(btf, linfo->line_off);
 
@@ -851,6 +851,23 @@ void btf_dump_linfo_dotlabel(const struct btf *btf,
 		return;
 	line = ltrim(line);
 
+	if (linum) {
+		const char *file = btf__name_by_offset(btf, linfo->file_name_off);
+
+		/* More forgiving on file because linum option is
+		 * expected to provide more info than the already
+		 * available src line.
+		 */
+		if (!file)
+			file = "";
+
+		printf("; [file:");
+		dotlabel_puts(file);
+		printf("line_num:%u line_col:%u]\\l\\\n",
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
index 567ac37dbd86..848f57a7d762 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -854,7 +854,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		else if (json_output)
 			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
 		else if (visual)
-			dump_xlated_cfg(&dd, buf, member_len);
+			dump_xlated_cfg(&dd, buf, member_len, opcodes, linum);
 		else
 			dump_xlated_plain(&dd, buf, member_len, opcodes, linum);
 		kernel_syms_destroy(&dd);
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 5fbe94aa8589..c5e03833fadf 100644
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
+			printf("       ");
+			fprint_hex(stdout, cur, 8, " ");
+			if (double_insn && cur <= insn_end - 1) {
+				printf(" ");
+				fprint_hex(stdout, cur + 1, 8, " ");
+			}
+			printf("\\l\\\n");
+		}
+
 		if (cur != insn_end)
 			printf(" | ");
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

