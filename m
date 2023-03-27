Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA56CA21F
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 13:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjC0LHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjC0LHM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 07:07:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940B468F
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l27so8329154wrb.2
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679915223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTyVAMM1uuND5+nGcj2u1LLiV/crTg1ER+ckhOKJiPE=;
        b=gyCLTLeBMB2xrf7i7e46qAvRFa8KFdcVgdIDlKvQ7y1FRkm4ujyBigafnPd7wMWZkK
         7xBklSJGGfDUNdFMmAzM6U8M4qiG6xbN/cj/sbFnT8bR2z/JkNqna2JeNZGH+Vx48ao2
         U7Bns+/3JwgJ0EpWSDKbsJ+eoKnz9JoHtzRVZnpTXLZvg50c7mHH6dCJ82AvFXGBeUqQ
         x6gx92iJX6A/acyI/Bkocxh+aGDNqr0k3dB7rGXxCz47/FSw7POi7UVsssiHjoJXl4bE
         3udj76yn4Gecy+0D/MIJk2FqtS7UHLphTGlZ8gU6cVfZfsVhH2xR3HR3bE3viR7l0Mx6
         76kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679915223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTyVAMM1uuND5+nGcj2u1LLiV/crTg1ER+ckhOKJiPE=;
        b=MBWlVrTfsFD4LZUC1jKy8eiI2l/OrNCQVnPgFmCi742t1FKDzd26z9yKxaCvqcDMhv
         juTyn0IOy4kS+UP69nhT/PnoH5xLYuGFzIE25epZgpkRxO2TpzHQPJJ/p3bZX1rhYQdW
         StR+Uzl/GMp/LfFf/QsmzofZ/uMHXHnBYGIc0cTkTO+X/xX3UxfUj1rAj6MTT/7RJ2hu
         bBZFSEbNY8KZJnmztbKt9x6S3O0oNvK8PL28701I3QDj1MvsJLyenBKUWFa5/9Ool3pW
         txb+ig0OnTiRJzK2zOqiW54pP80JMzWWS8smrAuf6TU9CSGD9FFQHtf4IX+nycynwpyB
         RAVw==
X-Gm-Message-State: AAQBX9dzNaj9TEYqrwctczJ21cvbXijeRo9m1C/YSKzCbRFoB+EY5EBV
        3UDjmsfatV+rJyV4J47N1arWig==
X-Google-Smtp-Source: AKy350bsjGJ6GAuu2hlCNh7qC9Av95tBwABgj/pK4rxS1dlWbS3H5jnElF7jzjxEKs/l2dzX9rmReA==
X-Received: by 2002:a5d:5905:0:b0:2c7:a55:bef5 with SMTP id v5-20020a5d5905000000b002c70a55bef5mr8396046wrd.23.1679915222991;
        Mon, 27 Mar 2023 04:07:02 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:61cd:634a:c75b:ba10])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002d1daafea30sm24772958wrz.34.2023.03.27.04.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:07:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/5] bpftool: Support inline annotations when dumping the CFG of a program
Date:   Mon, 27 Mar 2023 12:06:53 +0100
Message-Id: <20230327110655.58363-4-quentin@isovalent.com>
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
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/btf_dumper.c    | 32 +++++++++++++++++++++++++++++++
 tools/bpf/bpftool/cfg.c           | 23 ++++++++++------------
 tools/bpf/bpftool/cfg.h           |  4 +++-
 tools/bpf/bpftool/main.h          |  2 ++
 tools/bpf/bpftool/prog.c          | 17 +++++++---------
 tools/bpf/bpftool/xlated_dumper.c | 32 ++++++++++++++++++++++++++++++-
 6 files changed, 85 insertions(+), 25 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index e7f6ec3a8f35..8bfc1b69497d 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -821,3 +821,35 @@ void btf_dump_linfo_json(const struct btf *btf,
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
+		case '>':
+		case '|':
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
+	if (!line)
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
index 3daa05d9bbb7..5fbe94aa8589 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -369,20 +369,50 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
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
 			printf(" | ");
 	}
-- 
2.34.1

