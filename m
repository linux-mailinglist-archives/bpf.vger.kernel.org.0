Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED573380137
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhENAiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:38:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E490C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p17so14416401pjz.3
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BhhaGO0jcEnyrel1VbP+/PTq9rk1BJq+xFYlbg7wepc=;
        b=mmPEfeC6p4z1TatyPTldPuFtnzvKgnW3KQM0C19xaaFnwxJcNytoq6uKU4YhmlK6S+
         KaSzOV714eO7F4dfU4vALWJry3nRHCfCUuNMZZgf6AoLnLSpoaEK8D2uhaYLdsykxSpp
         VWEEEittKBkvBDdmQ2oJ46ixLjpjvIPIzVioubkPK4hC/hnCioR+89hdZNTqAUuRytUN
         1DnZPir65UvXN1JE+mf3jibuRZiHRkXDsoPR2SXAk884gbgBOE8rMu3a1TjdQzs3+owZ
         0eYO3xZjf6EyiDTglN72rzb22rWAMzI4TiNCnGw9qaj7CRXo7/W/O96R8eSuUaFv32Dv
         Wa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BhhaGO0jcEnyrel1VbP+/PTq9rk1BJq+xFYlbg7wepc=;
        b=PAHS3LbeAaoKzSsxytDw7PufUJWu/jEEBFPjOQKgegwW3BwLYkqFWoJHqzkKVDomy5
         djkvR46Y7lu4o7id1ngGCL4x0gF+SqUIF2o1Yvh/5AbT2T3MLPYr1yu1OBb4WzcQ1zJ5
         QaqLwzpP6YyM5ID7L3hnMFUoYEi6aSdbWKpn3dV9h3DrY22Ni/u9E0TkfZZhwl5tobpz
         3/yf5Q0Tn9ybSVeskch9rNQgNbmgmOV7TXA+epvvalbT6adNe5yQN1dnYhvQ/I1krbT4
         j5W7b9ZgNVuzpEKMvO6mYgiUWtcF2F9E87Z4J3YCcJtxSm5iGjWVq2Zev0M1AeCTOE/f
         5CeA==
X-Gm-Message-State: AOAM530KUI5xq2MoANYRDTNiflMLY30I1ky4cDAQ6yhrEIxCgUecx19V
        ofgqKyJNCrxxQURO4jNGB3k=
X-Google-Smtp-Source: ABdhPJwkK0olST+wAE8ySnbB32uC4oDVaFxsM/xIZklv+Niz+zp0BqjyxG6HR+7vg7qOY5NmL//aXg==
X-Received: by 2002:a17:902:74c3:b029:ed:5a91:472d with SMTP id f3-20020a17090274c3b02900ed5a91472dmr42807390plt.32.1620952612649;
        Thu, 13 May 2021 17:36:52 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:52 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 14/21] libbpf: Generate loader program out of BPF ELF file.
Date:   Thu, 13 May 2021 17:36:16 -0700
Message-Id: <20210514003623.28033-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The BPF program loading process performed by libbpf is quite complex
and consists of the following steps:
"open" phase:
- parse elf file and remember relocations, sections
- collect externs and ksyms including their btf_ids in prog's BTF
- patch BTF datasec (since llvm couldn't do it)
- init maps (old style map_def, BTF based, global data map, kconfig map)
- collect relocations against progs and maps
"load" phase:
- probe kernel features
- load vmlinux BTF
- resolve externs (kconfig and ksym)
- load program BTF
- init struct_ops
- create maps
- apply CO-RE relocations
- patch ld_imm64 insns with src_reg=PSEUDO_MAP, PSEUDO_MAP_VALUE, PSEUDO_BTF_ID
- reposition subprograms and adjust call insns
- sanitize and load progs

During this process libbpf does sys_bpf() calls to load BTF, create maps,
populate maps and finally load programs.
Instead of actually doing the syscalls generate a trace of what libbpf
would have done and represent it as the "loader program".
The "loader program" consists of single map with:
- union bpf_attr(s)
- BTF bytes
- map value bytes
- insns bytes
and single bpf program that passes bpf_attr(s) and data into bpf_sys_bpf() helper.
Executing such "loader program" via bpf_prog_test_run() command will
replay the sequence of syscalls that libbpf would have done which will result
the same maps created and programs loaded as specified in the elf file.
The "loader program" removes libelf and majority of libbpf dependency from
program loading process.

kconfig, typeless ksym, struct_ops and CO-RE are not supported yet.

The order of relocate_data and relocate_calls had to change, so that
bpf_gen__prog_load() can see all relocations for a given program with
correct insn_idx-es.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Build              |   2 +-
 tools/lib/bpf/bpf_gen_internal.h |  40 ++
 tools/lib/bpf/gen_loader.c       | 689 +++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c           | 226 ++++++++--
 tools/lib/bpf/libbpf.h           |  12 +
 tools/lib/bpf/libbpf.map         |   1 +
 tools/lib/bpf/libbpf_internal.h  |   2 +
 tools/lib/bpf/skel_internal.h    | 123 ++++++
 8 files changed, 1060 insertions(+), 35 deletions(-)
 create mode 100644 tools/lib/bpf/bpf_gen_internal.h
 create mode 100644 tools/lib/bpf/gen_loader.c
 create mode 100644 tools/lib/bpf/skel_internal.h

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 9b057cc7650a..430f6874fa41 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,3 +1,3 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o xsk.o hashmap.o \
-	    btf_dump.o ringbuf.o strset.o linker.o
+	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o
diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
new file mode 100644
index 000000000000..f42a55efd559
--- /dev/null
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2021 Facebook */
+#ifndef __BPF_GEN_INTERNAL_H
+#define __BPF_GEN_INTERNAL_H
+
+struct ksym_relo_desc {
+	const char *name;
+	int kind;
+	int insn_idx;
+};
+
+struct bpf_gen {
+	struct gen_loader_opts *opts;
+	void *data_start;
+	void *data_cur;
+	void *insn_start;
+	void *insn_cur;
+	__u32 nr_progs;
+	__u32 nr_maps;
+	int log_level;
+	int error;
+	struct ksym_relo_desc *relos;
+	int relo_cnt;
+	char attach_target[128];
+	int attach_kind;
+};
+
+void bpf_gen__init(struct bpf_gen *gen, int log_level);
+int bpf_gen__finish(struct bpf_gen *gen);
+void bpf_gen__free(struct bpf_gen *gen);
+void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 raw_size);
+void bpf_gen__map_create(struct bpf_gen *gen, struct bpf_create_map_attr *map_attr, int map_idx);
+struct bpf_prog_load_params;
+void bpf_gen__prog_load(struct bpf_gen *gen, struct bpf_prog_load_params *load_attr, int prog_idx);
+void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *value, __u32 value_size);
+void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
+void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
+void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, int kind, int insn_idx);
+
+#endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
new file mode 100644
index 000000000000..0fc54b1ca311
--- /dev/null
+++ b/tools/lib/bpf/gen_loader.c
@@ -0,0 +1,689 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2021 Facebook */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <linux/filter.h>
+#include "btf.h"
+#include "bpf.h"
+#include "libbpf.h"
+#include "libbpf_internal.h"
+#include "hashmap.h"
+#include "bpf_gen_internal.h"
+#include "skel_internal.h"
+
+#define MAX_USED_MAPS 64
+#define MAX_USED_PROGS 32
+
+/* The following structure describes the stack layout of the loader program.
+ * In addition R6 contains the pointer to context.
+ * R7 contains the result of the last sys_bpf command (typically error or FD).
+ * R9 contains the result of the last sys_close command.
+ *
+ * Naming convention:
+ * ctx - bpf program context
+ * stack - bpf program stack
+ * blob - bpf_attr-s, strings, insns, map data.
+ *        All the bytes that loader prog will use for read/write.
+ */
+struct loader_stack {
+	__u32 btf_fd;
+	__u32 map_fd[MAX_USED_MAPS];
+	__u32 prog_fd[MAX_USED_PROGS];
+	__u32 inner_map_fd;
+};
+
+#define stack_off(field) \
+	(__s16)(-sizeof(struct loader_stack) + offsetof(struct loader_stack, field))
+
+#define attr_field(attr, field) (attr + offsetof(union bpf_attr, field))
+
+static int realloc_insn_buf(struct bpf_gen *gen, __u32 size)
+{
+	size_t off = gen->insn_cur - gen->insn_start;
+	void *insn_start;
+
+	if (gen->error)
+		return gen->error;
+	if (size > INT32_MAX || off + size > INT32_MAX) {
+		gen->error = -ERANGE;
+		return -ERANGE;
+	}
+	insn_start = realloc(gen->insn_start, off + size);
+	if (!insn_start) {
+		gen->error = -ENOMEM;
+		free(gen->insn_start);
+		gen->insn_start = NULL;
+		return -ENOMEM;
+	}
+	gen->insn_start = insn_start;
+	gen->insn_cur = insn_start + off;
+	return 0;
+}
+
+static int realloc_data_buf(struct bpf_gen *gen, __u32 size)
+{
+	size_t off = gen->data_cur - gen->data_start;
+	void *data_start;
+
+	if (gen->error)
+		return gen->error;
+	if (size > INT32_MAX || off + size > INT32_MAX) {
+		gen->error = -ERANGE;
+		return -ERANGE;
+	}
+	data_start = realloc(gen->data_start, off + size);
+	if (!data_start) {
+		gen->error = -ENOMEM;
+		free(gen->data_start);
+		gen->data_start = NULL;
+		return -ENOMEM;
+	}
+	gen->data_start = data_start;
+	gen->data_cur = data_start + off;
+	return 0;
+}
+
+static void emit(struct bpf_gen *gen, struct bpf_insn insn)
+{
+	if (realloc_insn_buf(gen, sizeof(insn)))
+		return;
+	memcpy(gen->insn_cur, &insn, sizeof(insn));
+	gen->insn_cur += sizeof(insn);
+}
+
+static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn insn2)
+{
+	emit(gen, insn1);
+	emit(gen, insn2);
+}
+
+void bpf_gen__init(struct bpf_gen *gen, int log_level)
+{
+	gen->log_level = log_level;
+	emit(gen, BPF_MOV64_REG(BPF_REG_6, BPF_REG_1));
+}
+
+static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
+{
+	void *prev;
+
+	if (realloc_data_buf(gen, size))
+		return 0;
+	prev = gen->data_cur;
+	memcpy(gen->data_cur, data, size);
+	gen->data_cur += size;
+	return prev - gen->data_start;
+}
+
+static int insn_bytes_to_bpf_size(__u32 sz)
+{
+	switch (sz) {
+	case 8: return BPF_DW;
+	case 4: return BPF_W;
+	case 2: return BPF_H;
+	case 1: return BPF_B;
+	default: return -1;
+	}
+}
+
+/* *(u64 *)(blob + off) = (u64)(void *)(blob + data) */
+static void emit_rel_store(struct bpf_gen *gen, int off, int data)
+{
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, data));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, off));
+	emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0));
+}
+
+/* *(u64 *)(blob + off) = (u64)(void *)(%sp + stack_off) */
+static void emit_rel_store_sp(struct bpf_gen *gen, int off, int stack_off)
+{
+	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_10));
+	emit(gen, BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, stack_off));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, off));
+	emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0));
+}
+
+static void move_ctx2blob(struct bpf_gen *gen, int off, int size, int ctx_off,
+				   bool check_non_zero)
+{
+	emit(gen, BPF_LDX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_0, BPF_REG_6, ctx_off));
+	if (check_non_zero)
+		/* If value in ctx is zero don't update the blob.
+		 * For example: when ctx->map.max_entries == 0, keep default max_entries from bpf.c
+		 */
+		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, off));
+	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_1, BPF_REG_0, 0));
+}
+
+static void move_stack2blob(struct bpf_gen *gen, int off, int size, int stack_off)
+{
+	emit(gen, BPF_LDX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_0, BPF_REG_10, stack_off));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, off));
+	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_1, BPF_REG_0, 0));
+}
+
+static void move_stack2ctx(struct bpf_gen *gen, int ctx_off, int size, int stack_off)
+{
+	emit(gen, BPF_LDX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_0, BPF_REG_10, stack_off));
+	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_6, BPF_REG_0, ctx_off));
+}
+
+static void emit_sys_bpf(struct bpf_gen *gen, int cmd, int attr, int attr_size)
+{
+	emit(gen, BPF_MOV64_IMM(BPF_REG_1, cmd));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_2, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, attr));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_3, attr_size));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_bpf));
+	/* remember the result in R7 */
+	emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
+}
+
+static void emit_check_err(struct bpf_gen *gen)
+{
+	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 2));
+	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
+	/* TODO: close intermediate FDs in case of error */
+	emit(gen, BPF_EXIT_INSN());
+}
+
+/* reg1 and reg2 should not be R1 - R5. They can be R0, R6 - R10 */
+static void emit_debug(struct bpf_gen *gen, int reg1, int reg2,
+		       const char *fmt, va_list args)
+{
+	char buf[1024];
+	int addr, len, ret;
+
+	if (!gen->log_level)
+		return;
+	ret = vsnprintf(buf, sizeof(buf), fmt, args);
+	if (ret < 1024 - 7 && reg1 >= 0 && reg2 < 0)
+		/* The special case to accommodate common debug_ret():
+		 * to avoid specifying BPF_REG_7 and adding " r=%%d" to
+		 * prints explicitly.
+		 */
+		strcat(buf, " r=%d");
+	len = strlen(buf) + 1;
+	addr = add_data(gen, buf, len);
+
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, addr));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_2, len));
+	if (reg1 >= 0)
+		emit(gen, BPF_MOV64_REG(BPF_REG_3, reg1));
+	if (reg2 >= 0)
+		emit(gen, BPF_MOV64_REG(BPF_REG_4, reg2));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_trace_printk));
+}
+
+static void debug_regs(struct bpf_gen *gen, int reg1, int reg2, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	emit_debug(gen, reg1, reg2, fmt, args);
+	va_end(args);
+}
+
+static void debug_ret(struct bpf_gen *gen, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	emit_debug(gen, BPF_REG_7, -1, fmt, args);
+	va_end(args);
+}
+
+static void __emit_sys_close(struct bpf_gen *gen)
+{
+	emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0,
+			      /* 2 is the number of the following insns
+			       * * 6 is additional insns in debug_regs
+			       */
+			      2 + (gen->log_level ? 6 : 0)));
+	emit(gen, BPF_MOV64_REG(BPF_REG_9, BPF_REG_1));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
+	debug_regs(gen, BPF_REG_9, BPF_REG_0, "close(%%d) = %%d");
+}
+
+static void emit_sys_close_stack(struct bpf_gen *gen, int stack_off)
+{
+	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, stack_off));
+	__emit_sys_close(gen);
+}
+
+static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
+{
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, blob_off));
+	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0));
+	__emit_sys_close(gen);
+}
+
+int bpf_gen__finish(struct bpf_gen *gen)
+{
+	int i;
+
+	emit_sys_close_stack(gen, stack_off(btf_fd));
+	for (i = 0; i < gen->nr_progs; i++)
+		move_stack2ctx(gen,
+			       sizeof(struct bpf_loader_ctx) +
+			       sizeof(struct bpf_map_desc) * gen->nr_maps +
+			       sizeof(struct bpf_prog_desc) * i +
+			       offsetof(struct bpf_prog_desc, prog_fd), 4,
+			       stack_off(prog_fd[i]));
+	for (i = 0; i < gen->nr_maps; i++)
+		move_stack2ctx(gen,
+			       sizeof(struct bpf_loader_ctx) +
+			       sizeof(struct bpf_map_desc) * i +
+			       offsetof(struct bpf_map_desc, map_fd), 4,
+			       stack_off(map_fd[i]));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
+	emit(gen, BPF_EXIT_INSN());
+	pr_debug("gen: finish %d\n", gen->error);
+	if (!gen->error) {
+		struct gen_loader_opts *opts = gen->opts;
+
+		opts->insns = gen->insn_start;
+		opts->insns_sz = gen->insn_cur - gen->insn_start;
+		opts->data = gen->data_start;
+		opts->data_sz = gen->data_cur - gen->data_start;
+	}
+	return gen->error;
+}
+
+void bpf_gen__free(struct bpf_gen *gen)
+{
+	if (!gen)
+		return;
+	free(gen->data_start);
+	free(gen->insn_start);
+	free(gen);
+}
+
+void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
+		       __u32 btf_raw_size)
+{
+	int attr_size = offsetofend(union bpf_attr, btf_log_level);
+	int btf_data, btf_load_attr;
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_size);
+	pr_debug("gen: load_btf: size %d\n", btf_raw_size);
+	btf_data = add_data(gen, btf_raw_data, btf_raw_size);
+
+	attr.btf_size = btf_raw_size;
+	btf_load_attr = add_data(gen, &attr, attr_size);
+
+	/* populate union bpf_attr with user provided log details */
+	move_ctx2blob(gen, attr_field(btf_load_attr, btf_log_level), 4,
+		      offsetof(struct bpf_loader_ctx, log_level), false);
+	move_ctx2blob(gen, attr_field(btf_load_attr, btf_log_size), 4,
+		      offsetof(struct bpf_loader_ctx, log_size), false);
+	move_ctx2blob(gen, attr_field(btf_load_attr, btf_log_buf), 8,
+		      offsetof(struct bpf_loader_ctx, log_buf), false);
+	/* populate union bpf_attr with a pointer to the BTF data */
+	emit_rel_store(gen, attr_field(btf_load_attr, btf), btf_data);
+	/* emit BTF_LOAD command */
+	emit_sys_bpf(gen, BPF_BTF_LOAD, btf_load_attr, attr_size);
+	debug_ret(gen, "btf_load size %d", btf_raw_size);
+	emit_check_err(gen);
+	/* remember btf_fd in the stack, if successful */
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7, stack_off(btf_fd)));
+}
+
+void bpf_gen__map_create(struct bpf_gen *gen,
+			 struct bpf_create_map_attr *map_attr, int map_idx)
+{
+	int attr_size = offsetofend(union bpf_attr, btf_vmlinux_value_type_id);
+	bool close_inner_map_fd = false;
+	int map_create_attr;
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_size);
+	attr.map_type = map_attr->map_type;
+	attr.key_size = map_attr->key_size;
+	attr.value_size = map_attr->value_size;
+	attr.map_flags = map_attr->map_flags;
+	memcpy(attr.map_name, map_attr->name,
+	       min((unsigned)strlen(map_attr->name), BPF_OBJ_NAME_LEN - 1));
+	attr.numa_node = map_attr->numa_node;
+	attr.map_ifindex = map_attr->map_ifindex;
+	attr.max_entries = map_attr->max_entries;
+	switch (attr.map_type) {
+	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
+	case BPF_MAP_TYPE_CGROUP_ARRAY:
+	case BPF_MAP_TYPE_STACK_TRACE:
+	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+	case BPF_MAP_TYPE_HASH_OF_MAPS:
+	case BPF_MAP_TYPE_DEVMAP:
+	case BPF_MAP_TYPE_DEVMAP_HASH:
+	case BPF_MAP_TYPE_CPUMAP:
+	case BPF_MAP_TYPE_XSKMAP:
+	case BPF_MAP_TYPE_SOCKMAP:
+	case BPF_MAP_TYPE_SOCKHASH:
+	case BPF_MAP_TYPE_QUEUE:
+	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_RINGBUF:
+		break;
+	default:
+		attr.btf_key_type_id = map_attr->btf_key_type_id;
+		attr.btf_value_type_id = map_attr->btf_value_type_id;
+	}
+
+	pr_debug("gen: map_create: %s idx %d type %d value_type_id %d\n",
+		 attr.map_name, map_idx, map_attr->map_type, attr.btf_value_type_id);
+
+	map_create_attr = add_data(gen, &attr, attr_size);
+	if (attr.btf_value_type_id)
+		/* populate union bpf_attr with btf_fd saved in the stack earlier */
+		move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
+				stack_off(btf_fd));
+	switch (attr.map_type) {
+	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+	case BPF_MAP_TYPE_HASH_OF_MAPS:
+		move_stack2blob(gen, attr_field(map_create_attr, inner_map_fd), 4,
+				stack_off(inner_map_fd));
+		close_inner_map_fd = true;
+		break;
+	default:
+		break;
+	}
+	/* conditionally update max_entries */
+	if (map_idx >= 0)
+		move_ctx2blob(gen, attr_field(map_create_attr, max_entries), 4,
+			      sizeof(struct bpf_loader_ctx) +
+			      sizeof(struct bpf_map_desc) * map_idx +
+			      offsetof(struct bpf_map_desc, max_entries),
+			      true /* check that max_entries != 0 */);
+	/* emit MAP_CREATE command */
+	emit_sys_bpf(gen, BPF_MAP_CREATE, map_create_attr, attr_size);
+	debug_ret(gen, "map_create %s idx %d type %d value_size %d value_btf_id %d",
+		  attr.map_name, map_idx, map_attr->map_type, attr.value_size,
+		  attr.btf_value_type_id);
+	emit_check_err(gen);
+	/* remember map_fd in the stack, if successful */
+	if (map_idx < 0) {
+		/* This bpf_gen__map_create() function is called with map_idx >= 0
+		 * for all maps that libbpf loading logic tracks.
+		 * It's called with -1 to create an inner map.
+		 */
+		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
+				      stack_off(inner_map_fd)));
+	} else if (map_idx != gen->nr_maps) {
+		gen->error = -EDOM; /* internal bug */
+		return;
+	} else {
+		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
+				      stack_off(map_fd[map_idx])));
+		gen->nr_maps++;
+	}
+	if (close_inner_map_fd)
+		emit_sys_close_stack(gen, stack_off(inner_map_fd));
+}
+
+void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *attach_name,
+				   enum bpf_attach_type type)
+{
+	const char *prefix;
+	int kind, ret;
+
+	btf_get_kernel_prefix_kind(type, &prefix, &kind);
+	gen->attach_kind = kind;
+	ret = snprintf(gen->attach_target, sizeof(gen->attach_target), "%s%s",
+		       prefix, attach_name);
+	if (ret == sizeof(gen->attach_target))
+		gen->error = -ENOSPC;
+}
+
+static void emit_find_attach_target(struct bpf_gen *gen)
+{
+	int name, len = strlen(gen->attach_target) + 1;
+
+	pr_debug("gen: find_attach_tgt %s %d\n", gen->attach_target, gen->attach_kind);
+	name = add_data(gen, gen->attach_target, len);
+
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, name));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_2, len));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_3, gen->attach_kind));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_4, 0));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_btf_find_by_name_kind));
+	emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
+	debug_ret(gen, "find_by_name_kind(%s,%d)",
+		  gen->attach_target, gen->attach_kind);
+	emit_check_err(gen);
+	/* if successful, btf_id is in lower 32-bit of R7 and
+	 * btf_obj_fd is in upper 32-bit
+	 */
+}
+
+void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, int kind,
+			    int insn_idx)
+{
+	struct ksym_relo_desc *relo;
+
+	relo = libbpf_reallocarray(gen->relos, gen->relo_cnt + 1, sizeof(*relo));
+	if (!relo) {
+		gen->error = -ENOMEM;
+		return;
+	}
+	gen->relos = relo;
+	relo += gen->relo_cnt;
+	relo->name = name;
+	relo->kind = kind;
+	relo->insn_idx = insn_idx;
+	gen->relo_cnt++;
+}
+
+static void emit_relo(struct bpf_gen *gen, struct ksym_relo_desc *relo, int insns)
+{
+	int name, insn, len = strlen(relo->name) + 1;
+
+	pr_debug("gen: emit_relo: %s at %d\n", relo->name, relo->insn_idx);
+	name = add_data(gen, relo->name, len);
+
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, name));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_2, len));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_3, relo->kind));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_4, 0));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_btf_find_by_name_kind));
+	emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
+	debug_ret(gen, "find_by_name_kind(%s,%d)", relo->name, relo->kind);
+	emit_check_err(gen);
+	/* store btf_id into insn[insn_idx].imm */
+	insn = insns + sizeof(struct bpf_insn) * relo->insn_idx +
+		offsetof(struct bpf_insn, imm);
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, insn));
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, 0));
+	if (relo->kind == BTF_KIND_VAR) {
+		/* store btf_obj_fd into insn[insn_idx + 1].imm */
+		emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_7, 32));
+		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
+				      sizeof(struct bpf_insn)));
+	}
+}
+
+static void emit_relos(struct bpf_gen *gen, int insns)
+{
+	int i;
+
+	for (i = 0; i < gen->relo_cnt; i++)
+		emit_relo(gen, gen->relos + i, insns);
+}
+
+static void cleanup_relos(struct bpf_gen *gen, int insns)
+{
+	int i, insn;
+
+	for (i = 0; i < gen->relo_cnt; i++) {
+		if (gen->relos[i].kind != BTF_KIND_VAR)
+			continue;
+		/* close fd recorded in insn[insn_idx + 1].imm */
+		insn = insns +
+			sizeof(struct bpf_insn) * (gen->relos[i].insn_idx + 1) +
+			offsetof(struct bpf_insn, imm);
+		emit_sys_close_blob(gen, insn);
+	}
+	if (gen->relo_cnt) {
+		free(gen->relos);
+		gen->relo_cnt = 0;
+		gen->relos = NULL;
+	}
+}
+
+void bpf_gen__prog_load(struct bpf_gen *gen,
+			struct bpf_prog_load_params *load_attr, int prog_idx)
+{
+	int attr_size = offsetofend(union bpf_attr, fd_array);
+	int prog_load_attr, license, insns, func_info, line_info;
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_size);
+	pr_debug("gen: prog_load: type %d insns_cnt %zd\n",
+		 load_attr->prog_type, load_attr->insn_cnt);
+	/* add license string to blob of bytes */
+	license = add_data(gen, load_attr->license, strlen(load_attr->license) + 1);
+	/* add insns to blob of bytes */
+	insns = add_data(gen, load_attr->insns,
+			 load_attr->insn_cnt * sizeof(struct bpf_insn));
+
+	attr.prog_type = load_attr->prog_type;
+	attr.expected_attach_type = load_attr->expected_attach_type;
+	attr.attach_btf_id = load_attr->attach_btf_id;
+	attr.prog_ifindex = load_attr->prog_ifindex;
+	attr.kern_version = 0;
+	attr.insn_cnt = (__u32)load_attr->insn_cnt;
+	attr.prog_flags = load_attr->prog_flags;
+
+	attr.func_info_rec_size = load_attr->func_info_rec_size;
+	attr.func_info_cnt = load_attr->func_info_cnt;
+	func_info = add_data(gen, load_attr->func_info,
+			     attr.func_info_cnt * attr.func_info_rec_size);
+
+	attr.line_info_rec_size = load_attr->line_info_rec_size;
+	attr.line_info_cnt = load_attr->line_info_cnt;
+	line_info = add_data(gen, load_attr->line_info,
+			     attr.line_info_cnt * attr.line_info_rec_size);
+
+	memcpy(attr.prog_name, load_attr->name,
+	       min((unsigned)strlen(load_attr->name), BPF_OBJ_NAME_LEN - 1));
+	prog_load_attr = add_data(gen, &attr, attr_size);
+
+	/* populate union bpf_attr with a pointer to license */
+	emit_rel_store(gen, attr_field(prog_load_attr, license), license);
+
+	/* populate union bpf_attr with a pointer to instructions */
+	emit_rel_store(gen, attr_field(prog_load_attr, insns), insns);
+
+	/* populate union bpf_attr with a pointer to func_info */
+	emit_rel_store(gen, attr_field(prog_load_attr, func_info), func_info);
+
+	/* populate union bpf_attr with a pointer to line_info */
+	emit_rel_store(gen, attr_field(prog_load_attr, line_info), line_info);
+
+	/* populate union bpf_attr fd_array with a pointer to stack where map_fds are saved */
+	emit_rel_store_sp(gen, attr_field(prog_load_attr, fd_array),
+			  stack_off(map_fd[0]));
+
+	/* populate union bpf_attr with user provided log details */
+	move_ctx2blob(gen, attr_field(prog_load_attr, log_level), 4,
+		      offsetof(struct bpf_loader_ctx, log_level), false);
+	move_ctx2blob(gen, attr_field(prog_load_attr, log_size), 4,
+		      offsetof(struct bpf_loader_ctx, log_size), false);
+	move_ctx2blob(gen, attr_field(prog_load_attr, log_buf), 8,
+		      offsetof(struct bpf_loader_ctx, log_buf), false);
+	/* populate union bpf_attr with btf_fd saved in the stack earlier */
+	move_stack2blob(gen, attr_field(prog_load_attr, prog_btf_fd), 4,
+			stack_off(btf_fd));
+	if (gen->attach_kind) {
+		emit_find_attach_target(gen);
+		/* populate union bpf_attr with btf_id and btf_obj_fd found by helper */
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
+						 0, 0, 0, prog_load_attr));
+		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
+				      offsetof(union bpf_attr, attach_btf_id)));
+		emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_7, 32));
+		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
+				      offsetof(union bpf_attr, attach_btf_obj_fd)));
+	}
+	emit_relos(gen, insns);
+	/* emit PROG_LOAD command */
+	emit_sys_bpf(gen, BPF_PROG_LOAD, prog_load_attr, attr_size);
+	debug_ret(gen, "prog_load %s insn_cnt %d", attr.prog_name, attr.insn_cnt);
+	/* successful or not, close btf module FDs used in extern ksyms and attach_btf_obj_fd */
+	cleanup_relos(gen, insns);
+	if (gen->attach_kind)
+		emit_sys_close_blob(gen,
+				    attr_field(prog_load_attr, attach_btf_obj_fd));
+	emit_check_err(gen);
+	/* remember prog_fd in the stack, if successful */
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
+			      stack_off(prog_fd[gen->nr_progs])));
+	gen->nr_progs++;
+}
+
+void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
+			      __u32 value_size)
+{
+	int attr_size = offsetofend(union bpf_attr, flags);
+	int map_update_attr, value, key;
+	union bpf_attr attr;
+	int zero = 0;
+
+	memset(&attr, 0, attr_size);
+	pr_debug("gen: map_update_elem: idx %d\n", map_idx);
+
+	value = add_data(gen, pvalue, value_size);
+	key = add_data(gen, &zero, sizeof(zero));
+
+	/* if (map_desc[map_idx].initial_value)
+	 *    copy_from_user(value, initial_value, value_size);
+	 */
+	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
+			      sizeof(struct bpf_loader_ctx) +
+			      sizeof(struct bpf_map_desc) * map_idx +
+			      offsetof(struct bpf_map_desc, initial_value)));
+	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 4));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, value));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
+
+	map_update_attr = add_data(gen, &attr, attr_size);
+	move_stack2blob(gen, attr_field(map_update_attr, map_fd), 4,
+			stack_off(map_fd[map_idx]));
+	emit_rel_store(gen, attr_field(map_update_attr, key), key);
+	emit_rel_store(gen, attr_field(map_update_attr, value), value);
+	/* emit MAP_UPDATE_ELEM command */
+	emit_sys_bpf(gen, BPF_MAP_UPDATE_ELEM, map_update_attr, attr_size);
+	debug_ret(gen, "update_elem idx %d value_size %d", map_idx, value_size);
+	emit_check_err(gen);
+}
+
+void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx)
+{
+	int attr_size = offsetofend(union bpf_attr, map_fd);
+	int map_freeze_attr;
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_size);
+	pr_debug("gen: map_freeze: idx %d\n", map_idx);
+	map_freeze_attr = add_data(gen, &attr, attr_size);
+	move_stack2blob(gen, attr_field(map_freeze_attr, map_fd), 4,
+			stack_off(map_fd[map_idx]));
+	/* emit MAP_FREEZE command */
+	emit_sys_bpf(gen, BPF_MAP_FREEZE, map_freeze_attr, attr_size);
+	debug_ret(gen, "map_freeze");
+	emit_check_err(gen);
+}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0ba0e80749f8..3f7d184c7e3a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -54,6 +54,7 @@
 #include "str_error.h"
 #include "libbpf_internal.h"
 #include "hashmap.h"
+#include "bpf_gen_internal.h"
 
 #ifndef BPF_FS_MAGIC
 #define BPF_FS_MAGIC		0xcafe4a11
@@ -412,8 +413,6 @@ struct module_btf {
 	int fd;
 };
 
-struct bpf_gen;
-
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -2656,7 +2655,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 	int err;
 
 	/* btf_vmlinux could be loaded earlier */
-	if (obj->btf_vmlinux)
+	if (obj->btf_vmlinux || obj->gen_loader)
 		return 0;
 
 	if (!force && !obj_needs_vmlinux_btf(obj))
@@ -2738,7 +2737,20 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		bpf_object__sanitize_btf(obj, kern_btf);
 	}
 
-	err = btf__load(kern_btf);
+	if (obj->gen_loader) {
+		__u32 raw_size = 0;
+		const void *raw_data = btf__get_raw_data(kern_btf, &raw_size);
+
+		if (!raw_data)
+			return -ENOMEM;
+		bpf_gen__load_btf(obj->gen_loader, raw_data, raw_size);
+		/* Pretend to have valid FD to pass various fd >= 0 checks.
+		 * This fd == 0 will not be used with any syscall and will be reset to -1 eventually.
+		 */
+		btf__set_fd(kern_btf, 0);
+	} else {
+		err = btf__load(kern_btf);
+	}
 	if (sanitize) {
 		if (!err) {
 			/* move fd to libbpf's BTF */
@@ -4314,6 +4326,12 @@ static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id f
 	struct kern_feature_desc *feat = &feature_probes[feat_id];
 	int ret;
 
+	if (obj->gen_loader)
+		/* To generate loader program assume the latest kernel
+		 * to avoid doing extra prog_load, map_create syscalls.
+		 */
+		return true;
+
 	if (READ_ONCE(feat->res) == FEAT_UNKNOWN) {
 		ret = feat->probe();
 		if (ret > 0) {
@@ -4396,6 +4414,13 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 	char *cp, errmsg[STRERR_BUFSIZE];
 	int err, zero = 0;
 
+	if (obj->gen_loader) {
+		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
+					 map->mmaped, map->def.value_size);
+		if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG)
+			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
+		return 0;
+	}
 	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
 	if (err) {
 		err = -errno;
@@ -4421,7 +4446,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 
 static void bpf_map__destroy(struct bpf_map *map);
 
-static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
+static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
 {
 	struct bpf_create_map_attr create_attr;
 	struct bpf_map_def *def = &map->def;
@@ -4469,7 +4494,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
 		if (map->inner_map) {
 			int err;
 
-			err = bpf_object__create_map(obj, map->inner_map);
+			err = bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
 				pr_warn("map '%s': failed to create inner map: %d\n",
 					map->name, err);
@@ -4481,7 +4506,15 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
 			create_attr.inner_map_fd = map->inner_map_fd;
 	}
 
-	map->fd = bpf_create_map_xattr(&create_attr);
+	if (obj->gen_loader) {
+		bpf_gen__map_create(obj->gen_loader, &create_attr, is_inner ? -1 : map - obj->maps);
+		/* Pretend to have valid FD to pass various fd >= 0 checks.
+		 * This fd == 0 will not be used with any syscall and will be reset to -1 eventually.
+		 */
+		map->fd = 0;
+	} else {
+		map->fd = bpf_create_map_xattr(&create_attr);
+	}
 	if (map->fd < 0 && (create_attr.btf_key_type_id ||
 			    create_attr.btf_value_type_id)) {
 		char *cp, errmsg[STRERR_BUFSIZE];
@@ -4502,6 +4535,8 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
 		return -errno;
 
 	if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
+		if (obj->gen_loader)
+			map->inner_map->fd = -1;
 		bpf_map__destroy(map->inner_map);
 		zfree(&map->inner_map);
 	}
@@ -4509,11 +4544,11 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
 	return 0;
 }
 
-static int init_map_slots(struct bpf_map *map)
+static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
 {
 	const struct bpf_map *targ_map;
 	unsigned int i;
-	int fd, err;
+	int fd, err = 0;
 
 	for (i = 0; i < map->init_slots_sz; i++) {
 		if (!map->init_slots[i])
@@ -4521,7 +4556,13 @@ static int init_map_slots(struct bpf_map *map)
 
 		targ_map = map->init_slots[i];
 		fd = bpf_map__fd(targ_map);
-		err = bpf_map_update_elem(map->fd, &i, &fd, 0);
+		if (obj->gen_loader) {
+			pr_warn("// TODO map_update_elem: idx %ld key %d value==map_idx %ld\n",
+				map - obj->maps, i, targ_map - obj->maps);
+			return -ENOTSUP;
+		} else {
+			err = bpf_map_update_elem(map->fd, &i, &fd, 0);
+		}
 		if (err) {
 			err = -errno;
 			pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %d\n",
@@ -4563,7 +4604,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			pr_debug("map '%s': skipping creation (preset fd=%d)\n",
 				 map->name, map->fd);
 		} else {
-			err = bpf_object__create_map(obj, map);
+			err = bpf_object__create_map(obj, map, false);
 			if (err)
 				goto err_out;
 
@@ -4579,7 +4620,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			}
 
 			if (map->init_slots_sz) {
-				err = init_map_slots(map);
+				err = init_map_slots(obj, map);
 				if (err < 0) {
 					zclose(map->fd);
 					goto err_out;
@@ -4989,6 +5030,9 @@ static int load_module_btfs(struct bpf_object *obj)
 	if (obj->btf_modules_loaded)
 		return 0;
 
+	if (obj->gen_loader)
+		return 0;
+
 	/* don't do this again, even if we find no module BTFs */
 	obj->btf_modules_loaded = true;
 
@@ -6136,6 +6180,12 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
 	if (str_is_empty(spec_str))
 		return -EINVAL;
 
+	if (prog->obj->gen_loader) {
+		pr_warn("// TODO core_relo: prog %ld insn[%d] %s %s kind %d\n",
+			prog - prog->obj->programs, relo->insn_off / 8,
+			local_name, spec_str, relo->kind);
+		return -ENOTSUP;
+	}
 	err = bpf_core_parse_spec(local_btf, local_id, spec_str, relo->kind, &local_spec);
 	if (err) {
 		pr_warn("prog '%s': relo #%d: parsing [%d] %s %s + %s failed: %d\n",
@@ -6866,6 +6916,20 @@ bpf_object__relocate_calls(struct bpf_object *obj, struct bpf_program *prog)
 	return 0;
 }
 
+static void
+bpf_object__free_relocs(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+	int i;
+
+	/* free up relocation descriptors */
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->programs[i];
+		zfree(&prog->reloc_desc);
+		prog->nr_reloc = 0;
+	}
+}
+
 static int
 bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
@@ -6935,12 +6999,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 			return err;
 		}
 	}
-	/* free up relocation descriptors */
-	for (i = 0; i < obj->nr_programs; i++) {
-		prog = &obj->programs[i];
-		zfree(&prog->reloc_desc);
-		prog->nr_reloc = 0;
-	}
+	if (!obj->gen_loader)
+		bpf_object__free_relocs(obj);
 	return 0;
 }
 
@@ -7129,6 +7189,9 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
 	enum bpf_func_id func_id;
 	int i;
 
+	if (obj->gen_loader)
+		return 0;
+
 	for (i = 0; i < prog->insns_cnt; i++, insn++) {
 		if (!insn_is_helper_call(insn, &func_id))
 			continue;
@@ -7213,6 +7276,12 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.log_level = prog->log_level;
 	load_attr.prog_flags = prog->prog_flags;
 
+	if (prog->obj->gen_loader) {
+		bpf_gen__prog_load(prog->obj->gen_loader, &load_attr,
+				   prog - prog->obj->programs);
+		*pfd = -1;
+		return 0;
+	}
 retry_load:
 	if (log_buf_size) {
 		log_buf = malloc(log_buf_size);
@@ -7290,6 +7359,38 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	return ret;
 }
 
+static int bpf_program__record_externs(struct bpf_program *prog)
+{
+	struct bpf_object *obj = prog->obj;
+	int i;
+
+	for (i = 0; i < prog->nr_reloc; i++) {
+		struct reloc_desc *relo = &prog->reloc_desc[i];
+		struct extern_desc *ext = &obj->externs[relo->sym_off];
+
+		switch (relo->type) {
+		case RELO_EXTERN_VAR:
+			if (ext->type != EXT_KSYM)
+				continue;
+			if (!ext->ksym.type_id) {
+				pr_warn("typeless ksym %s is not supported yet\n",
+					ext->name);
+				return -ENOTSUP;
+			}
+			bpf_gen__record_extern(obj->gen_loader, ext->name, BTF_KIND_VAR,
+					       relo->insn_idx);
+			break;
+		case RELO_EXTERN_FUNC:
+			bpf_gen__record_extern(obj->gen_loader, ext->name, BTF_KIND_FUNC,
+					       relo->insn_idx);
+			break;
+		default:
+			continue;
+		}
+	}
+	return 0;
+}
+
 static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd, int *btf_type_id);
 
 int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
@@ -7335,6 +7436,8 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 			pr_warn("prog '%s': inconsistent nr(%d) != 1\n",
 				prog->name, prog->instances.nr);
 		}
+		if (prog->obj->gen_loader)
+			bpf_program__record_externs(prog);
 		err = load_program(prog, prog->insns, prog->insns_cnt,
 				   license, kern_ver, &fd);
 		if (!err)
@@ -7411,6 +7514,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		if (err)
 			return err;
 	}
+	if (obj->gen_loader)
+		bpf_object__free_relocs(obj);
 	return 0;
 }
 
@@ -7791,6 +7896,12 @@ static int bpf_object__resolve_ksyms_btf_id(struct bpf_object *obj)
 		if (ext->type != EXT_KSYM || !ext->ksym.type_id)
 			continue;
 
+		if (obj->gen_loader) {
+			ext->is_set = true;
+			ext->ksym.kernel_btf_obj_fd = 0;
+			ext->ksym.kernel_btf_id = 0;
+			continue;
+		}
 		t = btf__type_by_id(obj->btf, ext->btf_id);
 		if (btf_is_var(t))
 			err = bpf_object__resolve_ksym_var_btf_id(obj, ext);
@@ -7905,6 +8016,9 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 		return -EINVAL;
 	}
 
+	if (obj->gen_loader)
+		bpf_gen__init(obj->gen_loader, attr->log_level);
+
 	err = bpf_object__probe_loading(obj);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
@@ -7915,6 +8029,15 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	err = err ? : bpf_object__relocate(obj, attr->target_btf_path);
 	err = err ? : bpf_object__load_progs(obj, attr->log_level);
 
+	if (obj->gen_loader) {
+		/* reset FDs */
+		btf__set_fd(obj->btf, -1);
+		for (i = 0; i < obj->nr_maps; i++)
+			obj->maps[i].fd = -1;
+		if (!err)
+			err = bpf_gen__finish(obj->gen_loader);
+	}
+
 	/* clean up module BTFs */
 	for (i = 0; i < obj->btf_module_cnt; i++) {
 		close(obj->btf_modules[i].fd);
@@ -8540,6 +8663,7 @@ void bpf_object__close(struct bpf_object *obj)
 	if (obj->clear_priv)
 		obj->clear_priv(obj, obj->priv);
 
+	bpf_gen__free(obj->gen_loader);
 	bpf_object__elf_finish(obj);
 	bpf_object__unload(obj);
 	btf__free(obj->btf);
@@ -8630,6 +8754,22 @@ void *bpf_object__priv(const struct bpf_object *obj)
 	return obj ? obj->priv : ERR_PTR(-EINVAL);
 }
 
+int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
+{
+	struct bpf_gen *gen;
+
+	if (!opts)
+		return -EFAULT;
+	if (!OPTS_VALID(opts, gen_loader_opts))
+		return -EINVAL;
+	gen = calloc(sizeof(*gen), 1);
+	if (!gen)
+		return -ENOMEM;
+	gen->opts = opts;
+	obj->gen_loader = gen;
+	return 0;
+}
+
 static struct bpf_program *
 __bpf_program__iter(const struct bpf_program *p, const struct bpf_object *obj,
 		    bool forward)
@@ -9267,6 +9407,28 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 #define BTF_ITER_PREFIX "bpf_iter_"
 #define BTF_MAX_NAME_SIZE 128
 
+void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
+				const char **prefix, int *kind)
+{
+	switch (attach_type) {
+	case BPF_TRACE_RAW_TP:
+		*prefix = BTF_TRACE_PREFIX;
+		*kind = BTF_KIND_TYPEDEF;
+		break;
+	case BPF_LSM_MAC:
+		*prefix = BTF_LSM_PREFIX;
+		*kind = BTF_KIND_FUNC;
+		break;
+	case BPF_TRACE_ITER:
+		*prefix = BTF_ITER_PREFIX;
+		*kind = BTF_KIND_FUNC;
+		break;
+	default:
+		*prefix = "";
+		*kind = BTF_KIND_FUNC;
+	}
+}
+
 static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind)
 {
@@ -9287,21 +9449,11 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 static inline int find_attach_btf_id(struct btf *btf, const char *name,
 				     enum bpf_attach_type attach_type)
 {
-	int err;
-
-	if (attach_type == BPF_TRACE_RAW_TP)
-		err = find_btf_by_prefix_kind(btf, BTF_TRACE_PREFIX, name,
-					      BTF_KIND_TYPEDEF);
-	else if (attach_type == BPF_LSM_MAC)
-		err = find_btf_by_prefix_kind(btf, BTF_LSM_PREFIX, name,
-					      BTF_KIND_FUNC);
-	else if (attach_type == BPF_TRACE_ITER)
-		err = find_btf_by_prefix_kind(btf, BTF_ITER_PREFIX, name,
-					      BTF_KIND_FUNC);
-	else
-		err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
+	const char *prefix;
+	int kind;
 
-	return err;
+	btf_get_kernel_prefix_kind(attach_type, &prefix, &kind);
+	return find_btf_by_prefix_kind(btf, prefix, name, kind);
 }
 
 int libbpf_find_vmlinux_btf_id(const char *name,
@@ -9400,7 +9552,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd,
 	__u32 attach_prog_fd = prog->attach_prog_fd;
 	const char *name = prog->sec_name, *attach_name;
 	const struct bpf_sec_def *sec = NULL;
-	int i, err;
+	int i, err = 0;
 
 	if (!name)
 		return -EINVAL;
@@ -9435,7 +9587,13 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd,
 	}
 
 	/* kernel/module BTF ID */
-	err = find_kernel_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
+	if (prog->obj->gen_loader) {
+		bpf_gen__record_attach_target(prog->obj->gen_loader, attach_name, attach_type);
+		*btf_obj_fd = 0;
+		*btf_type_id = 1;
+	} else {
+		err = find_kernel_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
+	}
 	if (err) {
 		pr_warn("failed to find kernel BTF type ID of '%s': %d\n", attach_name, err);
 		return err;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3f3a24763459..8cf168f3717c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -756,6 +756,18 @@ LIBBPF_API int bpf_object__attach_skeleton(struct bpf_object_skeleton *s);
 LIBBPF_API void bpf_object__detach_skeleton(struct bpf_object_skeleton *s);
 LIBBPF_API void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s);
 
+struct gen_loader_opts {
+	size_t sz; /* size of this struct, for forward/backward compatiblity */
+	const char *data;
+	const char *insns;
+	__u32 data_sz;
+	__u32 insns_sz;
+};
+
+#define gen_loader_opts__last_field insns_sz
+LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
+				      struct gen_loader_opts *opts);
+
 enum libbpf_tristate {
 	TRI_NO = 0,
 	TRI_YES = 1,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b9b29baf1df8..889ee2f3611c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -360,5 +360,6 @@ LIBBPF_0.4.0 {
 		bpf_linker__free;
 		bpf_linker__new;
 		bpf_map__inner_map;
+		bpf_object__gen_loader;
 		bpf_object__set_kversion;
 } LIBBPF_0.3.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ee426226928f..55d9b4dca64f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -258,6 +258,8 @@ int bpf_object__section_size(const struct bpf_object *obj, const char *name,
 int bpf_object__variable_offset(const struct bpf_object *obj, const char *name,
 				__u32 *off);
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
+void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
+				const char **prefix, int *kind);
 
 struct btf_ext_info {
 	/*
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
new file mode 100644
index 000000000000..12a126b452c1
--- /dev/null
+++ b/tools/lib/bpf/skel_internal.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2021 Facebook */
+#ifndef __SKEL_INTERNAL_H
+#define __SKEL_INTERNAL_H
+
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+
+/* This file is a base header for auto-generated *.lskel.h files.
+ * Its contents will change and may become part of auto-generation in the future.
+ *
+ * The layout of bpf_[map|prog]_desc and bpf_loader_ctx is feature dependent
+ * and will change from one version of libbpf to another and features
+ * requested during loader program generation.
+ */
+struct bpf_map_desc {
+	union {
+		/* input for the loader prog */
+		struct {
+			__aligned_u64 initial_value;
+			__u32 max_entries;
+		};
+		/* output of the loader prog */
+		struct {
+			int map_fd;
+		};
+	};
+};
+struct bpf_prog_desc {
+	int prog_fd;
+};
+
+struct bpf_loader_ctx {
+	size_t sz;
+	__u32 log_level;
+	__u32 log_size;
+	__u64 log_buf;
+};
+
+struct bpf_load_and_run_opts {
+	struct bpf_loader_ctx *ctx;
+	const void *data;
+	const void *insns;
+	__u32 data_sz;
+	__u32 insns_sz;
+	const char *errstr;
+};
+
+static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
+			  unsigned int size)
+{
+	return syscall(__NR_bpf, cmd, attr, size);
+}
+
+static inline int skel_closenz(int fd)
+{
+	if (fd > 0)
+		return close(fd);
+	return -EINVAL;
+}
+
+static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
+{
+	int map_fd = -1, prog_fd = -1, key = 0, err;
+	union bpf_attr attr;
+
+	map_fd = bpf_create_map_name(BPF_MAP_TYPE_ARRAY, "__loader.map", 4,
+				     opts->data_sz, 1, 0);
+	if (map_fd < 0) {
+		opts->errstr = "failed to create loader map";
+		err = -errno;
+		goto out;
+	}
+
+	err = bpf_map_update_elem(map_fd, &key, opts->data, 0);
+	if (err < 0) {
+		opts->errstr = "failed to update loader map";
+		err = -errno;
+		goto out;
+	}
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
+	attr.insns = (long) opts->insns;
+	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
+	attr.license = (long) "Dual BSD/GPL";
+	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
+	attr.fd_array = (long) &map_fd;
+	attr.log_level = opts->ctx->log_level;
+	attr.log_size = opts->ctx->log_size;
+	attr.log_buf = opts->ctx->log_buf;
+	attr.prog_flags = BPF_F_SLEEPABLE;
+	prog_fd = skel_sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (prog_fd < 0) {
+		opts->errstr = "failed to load loader prog";
+		err = -errno;
+		goto out;
+	}
+
+	memset(&attr, 0, sizeof(attr));
+	attr.test.prog_fd = prog_fd;
+	attr.test.ctx_in = (long) opts->ctx;
+	attr.test.ctx_size_in = opts->ctx->sz;
+	err = skel_sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
+	if (err < 0 || (int)attr.test.retval < 0) {
+		opts->errstr = "failed to execute loader prog";
+		if (err < 0)
+			err = -errno;
+		else
+			err = (int)attr.test.retval;
+		goto out;
+	}
+	err = 0;
+out:
+	if (map_fd >= 0)
+		close(map_fd);
+	if (prog_fd >= 0)
+		close(prog_fd);
+	return err;
+}
+
+#endif
-- 
2.30.2

