Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166846D7D98
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbjDENVm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbjDENVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D43C0E
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 06:21:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so18418791wmq.3
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680700886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaMSq/BrjIsLAsM8tt3GL2gZ/xQ+n5MJCeoPoGN8oJc=;
        b=TADt5n86cet+PRbtp1K/Qqg0BOL9EfjZzjCStYLY0ieKxJDCHhMHkWNkAceO4RIpUx
         Vprrfeuhkc5sf8gMeb4IbviyRzJDs8Cpd4JFaFTEwqZGqgZ1xKme//9H9nQbEWgOkuRl
         oyP1zp6Cr1Lj0VFcGEKK7EWgGiVPXh0YE/1kKG3aI6x69sDnvsE1UuOdn9FRPR13Y/Hw
         AAu/PTNS5GjeiaZ9qf3peCT+AcvI0dZnz2yg357ov+TTPoqtSzTWTFgbNZa6icH1jGg1
         0CCZdqYeqLTXbqmdqsS7YNxtHilur88FvsYJ+gtiy4kYNyxM0r4AKKbHgulwupVwBC5H
         xEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaMSq/BrjIsLAsM8tt3GL2gZ/xQ+n5MJCeoPoGN8oJc=;
        b=wMp1v8aetM6nktG0BqA2EtvIQz8LTXcgkfpXpvWV7NT9mjpMuT9sD3pD5ci8OoWNP6
         OL+hbi/A8WJc+rK5QznJBdtpbppmJjvczhnjvC23leYJJjfp89jY14XiF5XNi0jFV+5W
         Tkb9Ujzm2jxxYsNOMgslHRrmYoOiwg512wO/kgMohWSpyti/aenmcBFJNje39JhDNt6r
         ewjkjCUtACAiEIWz4w5sIEDfXJf1CoJ1LAQNsf3EwE2/rJbKMwlhGTZdqLiiXaLd5ci6
         17aVRXGMkDcshti6FCAjVUkOgRjnZaUvj4XgMQOG8yK6H8nTe1oxdQ79uRv6+cmr1yYZ
         FkJQ==
X-Gm-Message-State: AAQBX9dj3oq1Id826K9mSX8W8UF6JH8jwadgVn9gXDgxGWPY1zcfExLY
        7E4pAUO/WhAqGZwNVfpfoI1KUw==
X-Google-Smtp-Source: AKy350bxnyU2I7pVJiEd8x84r5NdSxqsiY2jpk1Q9g1t4Ty7M73T/EG0d9eXLuV+d/8kkbTJ8XHKNA==
X-Received: by 2002:a7b:c455:0:b0:3ee:1afc:c15 with SMTP id l21-20020a7bc455000000b003ee1afc0c15mr4390309wmi.33.1680700885969;
        Wed, 05 Apr 2023 06:21:25 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:8147:b5f5:f4cc:b39b])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003ed243222adsm2147306wmr.42.2023.04.05.06.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:21:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/7] bpftool: Support inline annotations when dumping the CFG of a program
Date:   Wed,  5 Apr 2023 14:21:16 +0100
Message-Id: <20230405132120.59886-4-quentin@isovalent.com>
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

We support dumping the control flow graph of loaded programs to the DOT
format with bpftool, but so far this feature wouldn't display the source
code lines available through BTF along with the eBPF bytecode. Let's add
support for these annotations, to make it easier to read the graph.

In prog.c, we move the call to dump_xlated_cfg() in order to pass and
use the full struct dump_data, instead of creating a minimal one in
draw_bb_node().

We pass the pointer to this struct down to dump_xlated_for_graph() in
xlated_dumper.c, where most of the logics is added. We deal with BTF
mostly like we do for plain or JSON output, except that we cannot use a
"nr_skip" value to skip a given number of linfo records (we don't
process the BPF instructions linearly, and apart from the root of the
graph we don't know how many records we should skip, so we just store
the last linfo and make sure the new one we find is different before
printing it).

When printing the source instructions to the label of a DOT graph node,
there are a few subtleties to address. We want some special newline
markers, and there are some characters that we must escape. To deal with
them, we introduce a new dedicated function btf_dump_linfo_dotlabel() in
btf_dumper.c. We'll reuse this function in a later commit to format the
filepath, line, and column references as well.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/btf_dumper.c    | 34 +++++++++++++++++++++++++++++++
 tools/bpf/bpftool/cfg.c           | 23 +++++++++------------
 tools/bpf/bpftool/cfg.h           |  4 +++-
 tools/bpf/bpftool/main.h          |  2 ++
 tools/bpf/bpftool/prog.c          | 17 +++++++---------
 tools/bpf/bpftool/xlated_dumper.c | 34 +++++++++++++++++++++++++++++--
 6 files changed, 88 insertions(+), 26 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index e7f6ec3a8f35..583aa843df92 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -821,3 +821,37 @@ void btf_dump_linfo_json(const struct btf *btf,
 					BPF_LINE_INFO_LINE_COL(linfo->line_col));
 	}
 }
+
+static void dotlabel_puts(const char *s)
+{
+	for (; *s; ++s) {
+		switch (*s) {
+		case '\\':
+		case '"':
+		case '{':
+		case '}':
+		case '<':
+		case '>':
+		case '|':
+		case ' ':
+			putchar('\\');
+			__fallthrough;
+		default:
+			putchar(*s);
+		}
+	}
+}
+
+void btf_dump_linfo_dotlabel(const struct btf *btf,
+			     const struct bpf_line_info *linfo)
+{
+	const char *line = btf__name_by_offset(btf, linfo->line_off);
+
+	if (!line || !strlen(line))
+		return;
+	line = ltrim(line);
+
+	printf("; ");
+	dotlabel_puts(line);
+	printf("\\l\\\n");
+}
diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
index 1951219a9af7..9fdc1f0cdd6e 100644
--- a/tools/bpf/bpftool/cfg.c
+++ b/tools/bpf/bpftool/cfg.c
@@ -380,7 +380,8 @@ static void cfg_destroy(struct cfg *cfg)
 	}
 }
 
-static void draw_bb_node(struct func_node *func, struct bb_node *bb)
+static void
+draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_data *dd)
 {
 	const char *shape;
 
@@ -398,13 +399,9 @@ static void draw_bb_node(struct func_node *func, struct bb_node *bb)
 		printf("EXIT");
 	} else {
 		unsigned int start_idx;
-		struct dump_data dd = {};
-
-		printf("{");
-		kernel_syms_load(&dd);
+		printf("{\\\n");
 		start_idx = bb->head - func->start;
-		dump_xlated_for_graph(&dd, bb->head, bb->tail, start_idx);
-		kernel_syms_destroy(&dd);
+		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx);
 		printf("}");
 	}
 
@@ -430,12 +427,12 @@ static void draw_bb_succ_edges(struct func_node *func, struct bb_node *bb)
 	}
 }
 
-static void func_output_bb_def(struct func_node *func)
+static void func_output_bb_def(struct func_node *func, struct dump_data *dd)
 {
 	struct bb_node *bb;
 
 	list_for_each_entry(bb, &func->bbs, l) {
-		draw_bb_node(func, bb);
+		draw_bb_node(func, bb, dd);
 	}
 }
 
@@ -455,7 +452,7 @@ static void func_output_edges(struct func_node *func)
 	       func_idx, ENTRY_BLOCK_INDEX, func_idx, EXIT_BLOCK_INDEX);
 }
 
-static void cfg_dump(struct cfg *cfg)
+static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
 {
 	struct func_node *func;
 
@@ -463,14 +460,14 @@ static void cfg_dump(struct cfg *cfg)
 	list_for_each_entry(func, &cfg->funcs, l) {
 		printf("subgraph \"cluster_%d\" {\n\tstyle=\"dashed\";\n\tcolor=\"black\";\n\tlabel=\"func_%d ()\";\n",
 		       func->idx, func->idx);
-		func_output_bb_def(func);
+		func_output_bb_def(func, dd);
 		func_output_edges(func);
 		printf("}\n");
 	}
 	printf("}\n");
 }
 
-void dump_xlated_cfg(void *buf, unsigned int len)
+void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
 {
 	struct bpf_insn *insn = buf;
 	struct cfg cfg;
@@ -479,7 +476,7 @@ void dump_xlated_cfg(void *buf, unsigned int len)
 	if (cfg_build(&cfg, insn, len))
 		return;
 
-	cfg_dump(&cfg);
+	cfg_dump(&cfg, dd);
 
 	cfg_destroy(&cfg);
 }
diff --git a/tools/bpf/bpftool/cfg.h b/tools/bpf/bpftool/cfg.h
index e144257ea6d2..909d17e6d4c2 100644
--- a/tools/bpf/bpftool/cfg.h
+++ b/tools/bpf/bpftool/cfg.h
@@ -4,6 +4,8 @@
 #ifndef __BPF_TOOL_CFG_H
 #define __BPF_TOOL_CFG_H
 
-void dump_xlated_cfg(void *buf, unsigned int len);
+#include "xlated_dumper.h"
+
+void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len);
 
 #endif /* __BPF_TOOL_CFG_H */
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0ef373cef4c7..e9ee514b22d4 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -229,6 +229,8 @@ void btf_dump_linfo_plain(const struct btf *btf,
 			  const char *prefix, bool linum);
 void btf_dump_linfo_json(const struct btf *btf,
 			 const struct bpf_line_info *linfo, bool linum);
+void btf_dump_linfo_dotlabel(const struct btf *btf,
+			     const struct bpf_line_info *linfo);
 
 struct nlattr;
 struct ifinfomsg;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index afbe3ec342c8..d855118f0d96 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -840,11 +840,6 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 					      false))
 				goto exit_free;
 		}
-	} else if (visual) {
-		if (json_output)
-			jsonw_null(json_wtr);
-		else
-			dump_xlated_cfg(buf, member_len);
 	} else {
 		kernel_syms_load(&dd);
 		dd.nr_jited_ksyms = info->nr_jited_ksyms;
@@ -854,12 +849,14 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		dd.finfo_rec_size = info->func_info_rec_size;
 		dd.prog_linfo = prog_linfo;
 
-		if (json_output)
-			dump_xlated_json(&dd, buf, member_len, opcodes,
-					 linum);
+		if (json_output && visual)
+			jsonw_null(json_wtr);
+		else if (json_output)
+			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
+		else if (visual)
+			dump_xlated_cfg(&dd, buf, member_len);
 		else
-			dump_xlated_plain(&dd, buf, member_len, opcodes,
-					  linum);
+			dump_xlated_plain(&dd, buf, member_len, opcodes, linum);
 		kernel_syms_destroy(&dd);
 	}
 
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 3daa05d9bbb7..2ee83561b945 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -369,21 +369,51 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 		.cb_imm		= print_imm,
 		.private_data	= dd,
 	};
+	const struct bpf_prog_linfo *prog_linfo = dd->prog_linfo;
+	const struct bpf_line_info *last_linfo = NULL;
+	struct bpf_func_info *record = dd->func_info;
 	struct bpf_insn *insn_start = buf_start;
 	struct bpf_insn *insn_end = buf_end;
 	struct bpf_insn *cur = insn_start;
+	struct btf *btf = dd->btf;
 	bool double_insn = false;
+	char func_sig[1024];
 
 	for (; cur <= insn_end; cur++) {
+		unsigned int insn_off;
+
 		if (double_insn) {
 			double_insn = false;
 			continue;
 		}
 		double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);
 
-		printf("% 4d: ", (int)(cur - insn_start + start_idx));
+		insn_off = (unsigned int)(cur - insn_start + start_idx);
+		if (btf && record) {
+			if (record->insn_off == insn_off) {
+				btf_dumper_type_only(btf, record->type_id,
+						     func_sig,
+						     sizeof(func_sig));
+				if (func_sig[0] != '\0')
+					printf("; %s:\\l\\\n", func_sig);
+				record = (void *)record + dd->finfo_rec_size;
+			}
+		}
+
+		if (prog_linfo) {
+			const struct bpf_line_info *linfo;
+
+			linfo = bpf_prog_linfo__lfind(prog_linfo, insn_off, 0);
+			if (linfo && linfo != last_linfo) {
+				btf_dump_linfo_dotlabel(btf, linfo);
+				last_linfo = linfo;
+			}
+		}
+
+		printf("%d: ", insn_off);
 		print_bpf_insn(&cbs, cur, true);
+
 		if (cur != insn_end)
-			printf(" | ");
+			printf("| ");
 	}
 }
-- 
2.34.1

