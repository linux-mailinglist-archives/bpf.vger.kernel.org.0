Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BD56AA72F
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 02:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCDBPR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 20:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCDBPG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 20:15:06 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27609772
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 17:14:11 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id x6so4144324ljq.1
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 17:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677892382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOY1m2SsvTbi/S7B2YAKQfC/WGgmaDiClgic6srzk+A=;
        b=I7stzi8cwPCvBaj5FG3sG9W3aJ0WjIMF6ucZX/wjqUk4ffd7n/cLMCJm4f+Bo6F1QN
         AxPq1d7X8MENLGkuJiT6Tis6O9S/PHPMvrFdXGq0UvD2L0lm+tX3wlbWO0ASG5tHGpJg
         Hx+19BWg4XuHwk9zEFGZ3b3PayAiyzEXWba5v9zyDWyBUtDqw9KRL54S/GwiYAmKjox3
         vpZ83VJIpJZxbWkbFmA6yziJLk9Gw10sn7pvZLqXeelVDAGTuQoBycJPbHuxjVOEFdq7
         fv4TFfbTo+mGhh4cJl9C2shFSh0QbqJt9XoE5LiyT8zPpaqg0pdieDfIwqWQMLRE8u/j
         PX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677892382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOY1m2SsvTbi/S7B2YAKQfC/WGgmaDiClgic6srzk+A=;
        b=Dz3AoVWQEMIrkjOT992CyLUUgzylNskohPJz22uBrGpDA112zZ+Vl3XnDu06MyCqON
         XT5fJ4eRjr0WlAjjIjYqOo3bIB6zdoTJDNDzvfOMpmm2SR9i+Q9u1rM6g4a6jHn8t0Yn
         Hvltrz58hBjaqsU73pdqphcoiCvRRt2BNGRRCIu8d08jf7+VPap+qe9Tw2RKyERE1Zg1
         6bvVCxxnrvhZ36zcLxeL93LCWE1plLyloDBEu6XwsYSxlQakqi4vFfqTE06FX16gVZ5M
         OklvsuMWs96wh/9tTK36nuuFX9GCuvlst6CGj4KlTuV54jnQ8SDL2bLBCkKp12xvuAw5
         ZC9Q==
X-Gm-Message-State: AO0yUKVlCytM70argEYNo+X7NsQ5lVN5f2M2Sqci5uY60TjWyD6+rP5L
        +SaJfH7/jBHuTx8lR2j7ddMwubfJPbnXCA==
X-Google-Smtp-Source: AK7set/I/xan8lw5C0fWYlolqD3o2dM6/hNZBdq4yJA0ersOEh8iT9m9vq0xOxw1CYIz99nAM2XP4g==
X-Received: by 2002:a2e:9694:0:b0:295:b2a1:20e4 with SMTP id q20-20020a2e9694000000b00295b2a120e4mr1146319lji.47.1677892381504;
        Fri, 03 Mar 2023 17:13:01 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x7-20020a05651c104700b00295b588d21dsm569609ljm.49.2023.03.03.17.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 17:13:01 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Disassembler tests for verifier.c:convert_ctx_access()
Date:   Sat,  4 Mar 2023 03:12:47 +0200
Message-Id: <20230304011247.566040-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230304011247.566040-1-eddyz87@gmail.com>
References: <20230304011247.566040-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Function verifier.c:convert_ctx_access() applies some rewrites to BPF
instructions that read or write BPF program context. This commit adds
machinery to allow test cases that inspect BPF program after these
rewrites are applied.

An example of a test case:

  {
        // Shorthand for field offset and size specification
	N(CGROUP_SOCKOPT, struct bpf_sockopt, retval),

        // Pattern generated for field read
	.read  = "$dst = *(u64 *)($ctx + bpf_sockopt_kern::current_task);"
		 "$dst = *(u64 *)($dst + task_struct::bpf_ctx);"
		 "$dst = *(u32 *)($dst + bpf_cg_run_ctx::retval);",

        // Pattern generated for field write
	.write = "*(u64 *)($ctx + bpf_sockopt_kern::tmp_reg) = r9;"
		 "r9 = *(u64 *)($ctx + bpf_sockopt_kern::current_task);"
		 "r9 = *(u64 *)(r9 + task_struct::bpf_ctx);"
		 "*(u32 *)(r9 + bpf_cg_run_ctx::retval) = $src;"
		 "r9 = *(u64 *)($ctx + bpf_sockopt_kern::tmp_reg);" ,
  },

For each test case, up to three programs are created:
- One that uses BPF_LDX_MEM to read the context field.
- One that uses BPF_STX_MEM to write to the context field.
- One that uses BPF_ST_MEM to write to the context field.

The disassembly of each program is compared with the pattern specified
in the test case.

Kernel code for disassembly is reused (as is in the bpftool).
To keep Makefile changes to the minimum, symbolic links to
`kernel/bpf/disasm.c` and `kernel/bpf/disasm.h ` are added.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/disasm.c          |   1 +
 tools/testing/selftests/bpf/disasm.h          |   1 +
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 917 ++++++++++++++++++
 4 files changed, 920 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/bpf/disasm.c
 create mode 120000 tools/testing/selftests/bpf/disasm.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index eab3cf5399f5..16f404aa1b23 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -559,7 +559,7 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c test_loader.c xsk.c
+			 cap_helpers.c test_loader.c xsk.c disasm.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
diff --git a/tools/testing/selftests/bpf/disasm.c b/tools/testing/selftests/bpf/disasm.c
new file mode 120000
index 000000000000..b1571927bd54
--- /dev/null
+++ b/tools/testing/selftests/bpf/disasm.c
@@ -0,0 +1 @@
+../../../../kernel/bpf/disasm.c
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/disasm.h b/tools/testing/selftests/bpf/disasm.h
new file mode 120000
index 000000000000..8054fd497340
--- /dev/null
+++ b/tools/testing/selftests/bpf/disasm.h
@@ -0,0 +1 @@
+../../../../kernel/bpf/disasm.h
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
new file mode 100644
index 000000000000..d5fe3d4b936c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -0,0 +1,917 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <regex.h>
+#include <test_progs.h>
+
+#include "bpf/btf.h"
+#include "bpf_util.h"
+#include "linux/filter.h"
+#include "disasm.h"
+
+#define MAX_PROG_TEXT_SZ (32 * 1024)
+
+/* The code in this file serves the sole purpose of executing test cases
+ * specified in the test_cases array. Each test case specifies a program
+ * type, context field offset, and disassembly patterns that correspond
+ * to read and write instructions generated by
+ * verifier.c:convert_ctx_access() for accessing that field.
+ *
+ * For each test case, up to three programs are created:
+ * - One that uses BPF_LDX_MEM to read the context field.
+ * - One that uses BPF_STX_MEM to write to the context field.
+ * - One that uses BPF_ST_MEM to write to the context field.
+ *
+ * The disassembly of each program is then compared with the pattern
+ * specified in the test case.
+ */
+struct test_case {
+	char *name;
+	enum bpf_prog_type prog_type;
+	enum bpf_attach_type expected_attach_type;
+	int field_offset;
+	int field_sz;
+	/* Program generated for BPF_ST_MEM uses value 42 by default,
+	 * this field allows to specify custom value.
+	 */
+	struct {
+		bool use;
+		int value;
+	} st_value;
+	/* Pattern for BPF_LDX_MEM(field_sz, dst, ctx, field_offset) */
+	char *read;
+	/* Pattern for BPF_STX_MEM(field_sz, ctx, src, field_offset) and
+	 *             BPF_ST_MEM (field_sz, ctx, src, field_offset)
+	 */
+	char *write;
+	/* Pattern for BPF_ST_MEM(field_sz, ctx, src, field_offset),
+	 * takes priority over `write`.
+	 */
+	char *write_st;
+	/* Pattern for BPF_STX_MEM (field_sz, ctx, src, field_offset),
+	 * takes priority over `write`.
+	 */
+	char *write_stx;
+};
+
+#define N(_prog_type, type, field, name_extra...)	\
+	.name = #_prog_type "." #field name_extra,	\
+	.prog_type = BPF_PROG_TYPE_##_prog_type,	\
+	.field_offset = offsetof(type, field),		\
+	.field_sz = sizeof(typeof(((type *)NULL)->field))
+
+static struct test_case test_cases[] = {
+/* Sign extension on s390 changes the pattern */
+#if defined(__x86_64__) || defined(__aarch64__)
+	{
+		N(SCHED_CLS, struct __sk_buff, tstamp),
+		.read  = "r11 = *(u8 *)($ctx + sk_buff::__pkt_vlan_present_offset);"
+			 "w11 &= 160;"
+			 "if w11 != 0xa0 goto pc+2;"
+			 "$dst = 0;"
+			 "goto pc+1;"
+			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
+		.write = "r11 = *(u8 *)($ctx + sk_buff::__pkt_vlan_present_offset);"
+			 "if w11 & 0x80 goto pc+1;"
+			 "goto pc+2;"
+			 "w11 &= -33;"
+			 "*(u8 *)($ctx + sk_buff::__pkt_vlan_present_offset) = r11;"
+			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
+	},
+#endif
+	{
+		N(SCHED_CLS, struct __sk_buff, priority),
+		.read  = "$dst = *(u32 *)($ctx + sk_buff::priority);",
+		.write = "*(u32 *)($ctx + sk_buff::priority) = $src;",
+	},
+	{
+		N(SCHED_CLS, struct __sk_buff, mark),
+		.read  = "$dst = *(u32 *)($ctx + sk_buff::mark);",
+		.write = "*(u32 *)($ctx + sk_buff::mark) = $src;",
+	},
+	{
+		N(SCHED_CLS, struct __sk_buff, cb[0]),
+		.read  = "$dst = *(u32 *)($ctx + $(sk_buff::cb + qdisc_skb_cb::data));",
+		.write = "*(u32 *)($ctx + $(sk_buff::cb + qdisc_skb_cb::data)) = $src;",
+	},
+	{
+		N(SCHED_CLS, struct __sk_buff, tc_classid),
+		.read  = "$dst = *(u16 *)($ctx + $(sk_buff::cb + qdisc_skb_cb::tc_classid));",
+		.write = "*(u16 *)($ctx + $(sk_buff::cb + qdisc_skb_cb::tc_classid)) = $src;",
+	},
+	{
+		N(SCHED_CLS, struct __sk_buff, tc_index),
+		.read  = "$dst = *(u16 *)($ctx + sk_buff::tc_index);",
+		.write = "*(u16 *)($ctx + sk_buff::tc_index) = $src;",
+	},
+	{
+		N(SCHED_CLS, struct __sk_buff, queue_mapping),
+		.read      = "$dst = *(u16 *)($ctx + sk_buff::queue_mapping);",
+		.write_stx = "if $src >= 0xffff goto pc+1;"
+			     "*(u16 *)($ctx + sk_buff::queue_mapping) = $src;",
+		.write_st  = "*(u16 *)($ctx + sk_buff::queue_mapping) = $src;",
+	},
+	{
+		/* This is a corner case in filter.c:bpf_convert_ctx_access() */
+		N(SCHED_CLS, struct __sk_buff, queue_mapping, ".ushrt_max"),
+		.st_value = { true, USHRT_MAX },
+		.write_st = "goto pc+0;",
+	},
+	{
+		N(CGROUP_SOCK, struct bpf_sock, bound_dev_if),
+		.read  = "$dst = *(u32 *)($ctx + sock_common::skc_bound_dev_if);",
+		.write = "*(u32 *)($ctx + sock_common::skc_bound_dev_if) = $src;",
+	},
+	{
+		N(CGROUP_SOCK, struct bpf_sock, mark),
+		.read  = "$dst = *(u32 *)($ctx + sock::sk_mark);",
+		.write = "*(u32 *)($ctx + sock::sk_mark) = $src;",
+	},
+	{
+		N(CGROUP_SOCK, struct bpf_sock, priority),
+		.read  = "$dst = *(u32 *)($ctx + sock::sk_priority);",
+		.write = "*(u32 *)($ctx + sock::sk_priority) = $src;",
+	},
+	{
+		N(SOCK_OPS, struct bpf_sock_ops, replylong[0]),
+		.read  = "$dst = *(u32 *)($ctx + bpf_sock_ops_kern::replylong);",
+		.write = "*(u32 *)($ctx + bpf_sock_ops_kern::replylong) = $src;",
+	},
+	{
+		N(CGROUP_SYSCTL, struct bpf_sysctl, file_pos),
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+		.read  = "$dst = *(u64 *)($ctx + bpf_sysctl_kern::ppos);"
+			 "$dst = *(u32 *)($dst +0);",
+		.write = "*(u64 *)($ctx + bpf_sysctl_kern::tmp_reg) = r9;"
+			 "r9 = *(u64 *)($ctx + bpf_sysctl_kern::ppos);"
+			 "*(u32 *)(r9 +0) = $src;"
+			 "r9 = *(u64 *)($ctx + bpf_sysctl_kern::tmp_reg);",
+#else
+		.read  = "$dst = *(u64 *)($ctx + bpf_sysctl_kern::ppos);"
+			 "$dst = *(u32 *)($dst +4);",
+		.write = "*(u64 *)($ctx + bpf_sysctl_kern::tmp_reg) = r9;"
+			 "r9 = *(u64 *)($ctx + bpf_sysctl_kern::ppos);"
+			 "*(u32 *)(r9 +4) = $src;"
+			 "r9 = *(u64 *)($ctx + bpf_sysctl_kern::tmp_reg);",
+#endif
+	},
+	{
+		N(CGROUP_SOCKOPT, struct bpf_sockopt, sk),
+		.read  = "$dst = *(u64 *)($ctx + bpf_sockopt_kern::sk);",
+		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
+	},
+	{
+		N(CGROUP_SOCKOPT, struct bpf_sockopt, level),
+		.read  = "$dst = *(u32 *)($ctx + bpf_sockopt_kern::level);",
+		.write = "*(u32 *)($ctx + bpf_sockopt_kern::level) = $src;",
+		.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
+	},
+	{
+		N(CGROUP_SOCKOPT, struct bpf_sockopt, optname),
+		.read  = "$dst = *(u32 *)($ctx + bpf_sockopt_kern::optname);",
+		.write = "*(u32 *)($ctx + bpf_sockopt_kern::optname) = $src;",
+		.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
+	},
+	{
+		N(CGROUP_SOCKOPT, struct bpf_sockopt, optlen),
+		.read  = "$dst = *(u32 *)($ctx + bpf_sockopt_kern::optlen);",
+		.write = "*(u32 *)($ctx + bpf_sockopt_kern::optlen) = $src;",
+		.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
+	},
+	{
+		N(CGROUP_SOCKOPT, struct bpf_sockopt, retval),
+		.read  = "$dst = *(u64 *)($ctx + bpf_sockopt_kern::current_task);"
+			 "$dst = *(u64 *)($dst + task_struct::bpf_ctx);"
+			 "$dst = *(u32 *)($dst + bpf_cg_run_ctx::retval);",
+		.write = "*(u64 *)($ctx + bpf_sockopt_kern::tmp_reg) = r9;"
+			 "r9 = *(u64 *)($ctx + bpf_sockopt_kern::current_task);"
+			 "r9 = *(u64 *)(r9 + task_struct::bpf_ctx);"
+			 "*(u32 *)(r9 + bpf_cg_run_ctx::retval) = $src;"
+			 "r9 = *(u64 *)($ctx + bpf_sockopt_kern::tmp_reg);",
+		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
+	},
+	{
+		N(CGROUP_SOCKOPT, struct bpf_sockopt, optval),
+		.read  = "$dst = *(u64 *)($ctx + bpf_sockopt_kern::optval);",
+		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
+	},
+	{
+		N(CGROUP_SOCKOPT, struct bpf_sockopt, optval_end),
+		.read  = "$dst = *(u64 *)($ctx + bpf_sockopt_kern::optval_end);",
+		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
+	},
+};
+
+#undef N
+
+static regex_t *ident_regex;
+static regex_t *field_regex;
+
+static char *skip_space(char *str)
+{
+	while (*str && isspace(*str))
+		++str;
+	return str;
+}
+
+static char *skip_space_and_semi(char *str)
+{
+	while (*str && (isspace(*str) || *str == ';'))
+		++str;
+	return str;
+}
+
+static char *match_str(char *str, char *prefix)
+{
+	while (*str && *prefix && *str == *prefix) {
+		++str;
+		++prefix;
+	}
+	if (*prefix)
+		return NULL;
+	return str;
+}
+
+static char *match_number(char *str, int num)
+{
+	char *next;
+	int snum = strtol(str, &next, 10);
+
+	if (next - str == 0 || num != snum)
+		return NULL;
+
+	return next;
+}
+
+static int find_field_offset_aux(struct btf *btf, int btf_id, char *field_name, int off)
+{
+	const struct btf_type *type = btf__type_by_id(btf, btf_id);
+	const struct btf_member *m;
+	__u16 mnum;
+	int i;
+
+	if (!type) {
+		PRINT_FAIL("Can't find btf_type for id %d\n", btf_id);
+		return -1;
+	}
+
+	if (!btf_is_struct(type) && !btf_is_union(type)) {
+		PRINT_FAIL("BTF id %d is not struct or union\n", btf_id);
+		return -1;
+	}
+
+	m = btf_members(type);
+	mnum = btf_vlen(type);
+
+	for (i = 0; i < mnum; ++i, ++m) {
+		const char *mname = btf__name_by_offset(btf, m->name_off);
+
+		if (strcmp(mname, "") == 0) {
+			int msize = find_field_offset_aux(btf, m->type, field_name,
+							  off + m->offset);
+			if (msize >= 0)
+				return msize;
+		}
+
+		if (strcmp(mname, field_name))
+			continue;
+
+		return (off + m->offset) / 8;
+	}
+
+	return -1;
+}
+
+static int find_field_offset(struct btf *btf, char *pattern, regmatch_t *matches)
+{
+	int type_sz  = matches[1].rm_eo - matches[1].rm_so;
+	int field_sz = matches[2].rm_eo - matches[2].rm_so;
+	char *type   = pattern + matches[1].rm_so;
+	char *field  = pattern + matches[2].rm_so;
+	char field_str[128] = {};
+	char type_str[128] = {};
+	int btf_id, field_offset;
+
+	if (type_sz >= sizeof(type_str)) {
+		PRINT_FAIL("Malformed pattern: type ident is too long: %d\n", type_sz);
+		return -1;
+	}
+
+	if (field_sz >= sizeof(field_str)) {
+		PRINT_FAIL("Malformed pattern: field ident is too long: %d\n", field_sz);
+		return -1;
+	}
+
+	strncpy(type_str, type, type_sz);
+	strncpy(field_str, field, field_sz);
+	btf_id = btf__find_by_name(btf, type_str);
+	if (btf_id < 0) {
+		PRINT_FAIL("No BTF info for type %s\n", type_str);
+		return -1;
+	}
+
+	field_offset = find_field_offset_aux(btf, btf_id, field_str, 0);
+	if (field_offset < 0) {
+		PRINT_FAIL("No BTF info for field %s::%s\n", type_str, field_str);
+		return -1;
+	}
+
+	return field_offset;
+}
+
+static regex_t *compile_regex(char *pat)
+{
+	regex_t *re;
+	int err;
+
+	re = malloc(sizeof(regex_t));
+	if (!re) {
+		PRINT_FAIL("Can't alloc regex\n");
+		return NULL;
+	}
+
+	err = regcomp(re, pat, REG_EXTENDED);
+	if (err) {
+		char errbuf[512];
+
+		regerror(err, re, errbuf, sizeof(errbuf));
+		PRINT_FAIL("Can't compile regex: %s\n", errbuf);
+		free(re);
+		return NULL;
+	}
+
+	return re;
+}
+
+static void free_regex(regex_t *re)
+{
+	if (!re)
+		return;
+
+	regfree(re);
+	free(re);
+}
+
+static u32 max_line_len(char *str)
+{
+	u32 max_line = 0;
+	char *next = str;
+
+	while (next) {
+		next = strchr(str, '\n');
+		if (next) {
+			max_line = max_t(u32, max_line, (next - str));
+			str = next + 1;
+		} else {
+			max_line = max_t(u32, max_line, strlen(str));
+		}
+	}
+
+	return min(max_line, 60u);
+}
+
+/* Print strings `pattern_origin` and `text_origin` side by side,
+ * assume `pattern_pos` and `text_pos` designate location within
+ * corresponding origin string where match diverges.
+ * The output should look like:
+ *
+ *   Can't match disassembly(left) with pattern(right):
+ *   r2 = *(u64 *)(r1 +0)  ;  $dst = *(u64 *)($ctx + bpf_sockopt_kern::sk1)
+ *                     ^                             ^
+ *   r0 = 0                ;
+ *   exit                  ;
+ */
+static void print_match_error(FILE *out,
+			      char *pattern_origin, char *text_origin,
+			      char *pattern_pos, char *text_pos)
+{
+	char *pattern = pattern_origin;
+	char *text = text_origin;
+	int middle = max_line_len(text) + 2;
+
+	fprintf(out, "Can't match disassembly(left) with pattern(right):\n");
+	while (*pattern || *text) {
+		int column = 0;
+		int mark1 = -1;
+		int mark2 = -1;
+
+		/* Print one line from text */
+		while (*text && *text != '\n') {
+			if (text == text_pos)
+				mark1 = column;
+			fputc(*text, out);
+			++text;
+			++column;
+		}
+		if (text == text_pos)
+			mark1 = column;
+
+		/* Pad to the middle */
+		while (column < middle) {
+			fputc(' ', out);
+			++column;
+		}
+		fputs(";  ", out);
+		column += 3;
+
+		/* Print one line from pattern, pattern lines are terminated by ';' */
+		while (*pattern && *pattern != ';') {
+			if (pattern == pattern_pos)
+				mark2 = column;
+			fputc(*pattern, out);
+			++pattern;
+			++column;
+		}
+		if (pattern == pattern_pos)
+			mark2 = column;
+
+		fputc('\n', out);
+		if (*pattern)
+			++pattern;
+		if (*text)
+			++text;
+
+		/* If pattern and text diverge at this line, print an
+		 * additional line with '^' marks, highlighting
+		 * positions where match fails.
+		 */
+		if (mark1 > 0 || mark2 > 0) {
+			for (column = 0; column <= max(mark1, mark2); ++column) {
+				if (column == mark1 || column == mark2)
+					fputc('^', out);
+				else
+					fputc(' ', out);
+			}
+			fputc('\n', out);
+		}
+	}
+}
+
+/* Test if `text` matches `pattern`. Pattern consists of the following elements:
+ *
+ * - Field offset references:
+ *
+ *     <type>::<field>
+ *
+ *   When such reference is encountered BTF is used to compute numerical
+ *   value for the offset of <field> in <type>. The `text` is expected to
+ *   contain matching numerical value.
+ *
+ * - Field groups:
+ *
+ *     $(<type>::<field> [+ <type>::<field>]*)
+ *
+ *   Allows to specify an offset that is a sum of multiple field offsets.
+ *   The `text` is expected to contain matching numerical value.
+ *
+ * - Variable references, e.g. `$src`, `$dst`, `$ctx`.
+ *   These are substitutions specified in `reg_map` array.
+ *   If a substring of pattern is equal to `reg_map[i][0]` the `text` is
+ *   expected to contain `reg_map[i][1]` in the matching position.
+ *
+ * - Whitespace is ignored, ';' counts as whitespace for `pattern`.
+ *
+ * - Any other characters, `pattern` and `text` should match one-to-one.
+ *
+ * Example of a pattern:
+ *
+ *                    __________ fields group ________________
+ *                   '                                        '
+ *   *(u16 *)($ctx + $(sk_buff::cb + qdisc_skb_cb::tc_classid)) = $src;
+ *            ^^^^                   '______________________'
+ *     variable reference             field offset reference
+ */
+static bool match_pattern(struct btf *btf, char *pattern, char *text, char *reg_map[][2])
+{
+	char *pattern_origin = pattern;
+	char *text_origin = text;
+	regmatch_t matches[3];
+
+_continue:
+	while (*pattern) {
+		if (!*text)
+			goto err;
+
+		/* Skip whitespace */
+		if (isspace(*pattern) || *pattern == ';') {
+			if (!isspace(*text) && text != text_origin && isalnum(text[-1]))
+				goto err;
+			pattern = skip_space_and_semi(pattern);
+			text = skip_space(text);
+			continue;
+		}
+
+		/* Check for variable references */
+		for (int i = 0; reg_map[i][0]; ++i) {
+			char *pattern_next, *text_next;
+
+			pattern_next = match_str(pattern, reg_map[i][0]);
+			if (!pattern_next)
+				continue;
+
+			text_next = match_str(text, reg_map[i][1]);
+			if (!text_next)
+				goto err;
+
+			pattern = pattern_next;
+			text = text_next;
+			goto _continue;
+		}
+
+		/* Match field group:
+		 *   $(sk_buff::cb + qdisc_skb_cb::tc_classid)
+		 */
+		if (strncmp(pattern, "$(", 2) == 0) {
+			char *group_start = pattern, *text_next;
+			int acc_offset = 0;
+
+			pattern += 2;
+
+			for (;;) {
+				int field_offset;
+
+				pattern = skip_space(pattern);
+				if (!*pattern) {
+					PRINT_FAIL("Unexpected end of pattern\n");
+					goto err;
+				}
+
+				if (*pattern == ')') {
+					++pattern;
+					break;
+				}
+
+				if (*pattern == '+') {
+					++pattern;
+					continue;
+				}
+
+				printf("pattern: %s\n", pattern);
+				if (regexec(field_regex, pattern, 3, matches, 0) != 0) {
+					PRINT_FAIL("Field reference expected\n");
+					goto err;
+				}
+
+				field_offset = find_field_offset(btf, pattern, matches);
+				if (field_offset < 0)
+					goto err;
+
+				pattern += matches[0].rm_eo;
+				acc_offset += field_offset;
+			}
+
+			text_next = match_number(text, acc_offset);
+			if (!text_next) {
+				PRINT_FAIL("No match for group offset %.*s (%d)\n",
+					   (int)(pattern - group_start),
+					   group_start,
+					   acc_offset);
+				goto err;
+			}
+			text = text_next;
+		}
+
+		/* Match field reference:
+		 *   sk_buff::cb
+		 */
+		if (regexec(field_regex, pattern, 3, matches, 0) == 0) {
+			int field_offset;
+			char *text_next;
+
+			field_offset = find_field_offset(btf, pattern, matches);
+			if (field_offset < 0)
+				goto err;
+
+			text_next = match_number(text, field_offset);
+			if (!text_next) {
+				PRINT_FAIL("No match for field offset %.*s (%d)\n",
+					   (int)matches[0].rm_eo, pattern, field_offset);
+				goto err;
+			}
+
+			pattern += matches[0].rm_eo;
+			text = text_next;
+			continue;
+		}
+
+		/* If pattern points to identifier not followed by '::'
+		 * skip the identifier to avoid n^2 application of the
+		 * field reference rule.
+		 */
+		if (regexec(ident_regex, pattern, 1, matches, 0) == 0) {
+			if (strncmp(pattern, text, matches[0].rm_eo) != 0)
+				goto err;
+
+			pattern += matches[0].rm_eo;
+			text += matches[0].rm_eo;
+			continue;
+		}
+
+		/* Match literally */
+		if (*pattern != *text)
+			goto err;
+
+		++pattern;
+		++text;
+	}
+
+	return true;
+
+err:
+	test__fail();
+	print_match_error(stdout, pattern_origin, text_origin, pattern, text);
+	return false;
+}
+
+/* Request BPF program instructions after all rewrites are applied,
+ * e.g. verifier.c:convert_ctx_access() is done.
+ */
+static int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 xlated_prog_len;
+	__u32 buf_element_size = sizeof(struct bpf_insn);
+
+	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("bpf_prog_get_info_by_fd failed");
+		return -1;
+	}
+
+	xlated_prog_len = info.xlated_prog_len;
+	if (xlated_prog_len % buf_element_size) {
+		printf("Program length %d is not multiple of %d\n",
+		       xlated_prog_len, buf_element_size);
+		return -1;
+	}
+
+	*cnt = xlated_prog_len / buf_element_size;
+	*buf = calloc(*cnt, buf_element_size);
+	if (!buf) {
+		perror("can't allocate xlated program buffer");
+		return -ENOMEM;
+	}
+
+	bzero(&info, sizeof(info));
+	info.xlated_prog_len = xlated_prog_len;
+	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
+	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("second bpf_prog_get_info_by_fd failed");
+		goto out_free_buf;
+	}
+
+	return 0;
+
+out_free_buf:
+	free(*buf);
+	return -1;
+}
+
+static void print_insn(void *private_data, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vfprintf((FILE *)private_data, fmt, args);
+	va_end(args);
+}
+
+/* Disassemble instructions to a stream */
+static void print_xlated(FILE *out, struct bpf_insn *insn, __u32 len)
+{
+	const struct bpf_insn_cbs cbs = {
+		.cb_print	= print_insn,
+		.cb_call	= NULL,
+		.cb_imm		= NULL,
+		.private_data	= out,
+	};
+	bool double_insn = false;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (double_insn) {
+			double_insn = false;
+			continue;
+		}
+
+		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
+		print_bpf_insn(&cbs, insn + i, true);
+	}
+}
+
+/* We share code with kernel BPF disassembler, it adds '(FF) ' prefix
+ * for each instruction (FF stands for instruction `code` byte).
+ * This function removes the prefix inplace for each line in `str`.
+ */
+static void remove_insn_prefix(char *str, int size)
+{
+	const int prefix_size = 5;
+
+	int write_pos = 0, read_pos = prefix_size;
+	int len = strlen(str);
+	char c;
+
+	size = min(size, len);
+
+	while (read_pos < size) {
+		c = str[read_pos++];
+		if (c == 0)
+			break;
+		str[write_pos++] = c;
+		if (c == '\n')
+			read_pos += prefix_size;
+	}
+	str[write_pos] = 0;
+}
+
+struct prog_info {
+	char *prog_kind;
+	enum bpf_prog_type prog_type;
+	enum bpf_attach_type expected_attach_type;
+	struct bpf_insn *prog;
+	u32 prog_len;
+};
+
+static void match_program(struct btf *btf,
+			  struct prog_info *pinfo,
+			  char *pattern,
+			  char *reg_map[][2],
+			  bool skip_first_insn)
+{
+	struct bpf_insn *buf = NULL;
+	int err = 0, prog_fd = 0;
+	FILE *prog_out = NULL;
+	char *text = NULL;
+	__u32 cnt = 0;
+
+	text = calloc(MAX_PROG_TEXT_SZ, 1);
+	if (!text) {
+		PRINT_FAIL("Can't allocate %d bytes\n", MAX_PROG_TEXT_SZ);
+		goto out;
+	}
+
+	// TODO: log level
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	opts.log_buf = text;
+	opts.log_size = MAX_PROG_TEXT_SZ;
+	opts.log_level = 1 | 2 | 4;
+	opts.expected_attach_type = pinfo->expected_attach_type;
+
+	prog_fd = bpf_prog_load(pinfo->prog_type, NULL, "GPL",
+				pinfo->prog, pinfo->prog_len, &opts);
+	if (prog_fd < 0) {
+		PRINT_FAIL("Can't load program, errno %d (%s), verifier log:\n%s\n",
+			   errno, strerror(errno), text);
+		goto out;
+	}
+
+	memset(text, 0, MAX_PROG_TEXT_SZ);
+
+	err = get_xlated_program(prog_fd, &buf, &cnt);
+	if (err) {
+		PRINT_FAIL("Can't load back BPF program\n");
+		goto out;
+	}
+
+	prog_out = fmemopen(text, MAX_PROG_TEXT_SZ - 1, "w");
+	if (!prog_out) {
+		PRINT_FAIL("Can't open memory stream\n");
+		goto out;
+	}
+	if (skip_first_insn)
+		print_xlated(prog_out, buf + 1, cnt - 1);
+	else
+		print_xlated(prog_out, buf, cnt);
+	fclose(prog_out);
+	remove_insn_prefix(text, MAX_PROG_TEXT_SZ);
+
+	ASSERT_TRUE(match_pattern(btf, pattern, text, reg_map),
+		    pinfo->prog_kind);
+
+out:
+	if (prog_fd)
+		close(prog_fd);
+	free(buf);
+	free(text);
+}
+
+static void run_one_testcase(struct btf *btf, struct test_case *test)
+{
+	struct prog_info pinfo = {};
+	int bpf_sz;
+
+	if (!test__start_subtest(test->name))
+		return;
+
+	switch (test->field_sz) {
+	case 8:
+		bpf_sz = BPF_DW;
+		break;
+	case 4:
+		bpf_sz = BPF_W;
+		break;
+	case 2:
+		bpf_sz = BPF_H;
+		break;
+	case 1:
+		bpf_sz = BPF_B;
+		break;
+	default:
+		PRINT_FAIL("Unexpected field size: %d, want 8,4,2 or 1\n", test->field_sz);
+		return;
+	}
+
+	pinfo.prog_type = test->prog_type;
+	pinfo.expected_attach_type = test->expected_attach_type;
+
+	if (test->read) {
+		struct bpf_insn ldx_prog[] = {
+			BPF_LDX_MEM(bpf_sz, BPF_REG_2, BPF_REG_1, test->field_offset),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		};
+		char *reg_map[][2] = {
+			{ "$ctx", "r1" },
+			{ "$dst", "r2" },
+			{}
+		};
+
+		pinfo.prog_kind = "LDX";
+		pinfo.prog = ldx_prog;
+		pinfo.prog_len = ARRAY_SIZE(ldx_prog);
+		match_program(btf, &pinfo, test->read, reg_map, false);
+	}
+
+	if (test->write || test->write_st || test->write_stx) {
+		struct bpf_insn stx_prog[] = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_STX_MEM(bpf_sz, BPF_REG_1, BPF_REG_2, test->field_offset),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		};
+		char *stx_reg_map[][2] = {
+			{ "$ctx", "r1" },
+			{ "$src", "r2" },
+			{}
+		};
+		struct bpf_insn st_prog[] = {
+			BPF_ST_MEM(bpf_sz, BPF_REG_1, test->field_offset,
+				   test->st_value.use ? test->st_value.value : 42),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		};
+		char *st_reg_map[][2] = {
+			{ "$ctx", "r1" },
+			{ "$src", "42" },
+			{}
+		};
+
+		if (test->write || test->write_stx) {
+			char *pattern = test->write_stx ? test->write_stx : test->write;
+
+			pinfo.prog_kind = "STX";
+			pinfo.prog = stx_prog;
+			pinfo.prog_len = ARRAY_SIZE(stx_prog);
+			match_program(btf, &pinfo, pattern, stx_reg_map, true);
+		}
+
+		if (test->write || test->write_st) {
+			char *pattern = test->write_st ? test->write_st : test->write;
+
+			pinfo.prog_kind = "ST";
+			pinfo.prog = st_prog;
+			pinfo.prog_len = ARRAY_SIZE(st_prog);
+			match_program(btf, &pinfo, pattern, st_reg_map, false);
+		}
+	}
+
+	test__end_subtest();
+}
+
+void test_ctx_rewrite(void)
+{
+	struct btf *btf;
+	int i;
+
+	field_regex = compile_regex("^([[:alpha:]_][[:alnum:]_]+)::([[:alpha:]_][[:alnum:]_]+)");
+	ident_regex = compile_regex("^[[:alpha:]_][[:alnum:]_]+");
+	if (!field_regex || !ident_regex)
+		return;
+
+	btf = btf__load_vmlinux_btf();
+	if (!btf) {
+		PRINT_FAIL("Can't load vmlinux BTF, errno %d (%s)\n", errno, strerror(errno));
+		goto out;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); ++i)
+		run_one_testcase(btf, &test_cases[i]);
+
+out:
+	btf__free(btf);
+	free_regex(field_regex);
+	free_regex(ident_regex);
+}
-- 
2.39.1

