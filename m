Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7A6EB0D8
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjDURnW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjDURnF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C45BA5
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f3fe12de15so1274222f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098969; x=1684690969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yDK7Ow/EQo3R038liwVGClD6X8zlhQtk+9SHaz2OOQ=;
        b=ajMn/F7KnTx5GKlBiHzwuvhMcqG2rcKSE+2RduddiwDUN0R5MWeU/mUJyOT0FjJiJk
         q4vt2pTz09/volbOnRq9t7H9hwkDarjgEx6VG74inVTGMm9ua+abvG1JDGa2MXorYRq9
         xcGgeAZW2N/j6A/Yf+as8/4+t8/Up+jZny3Bs9K5UFY6fS/VTvuvywFfdVDMZ8R4QRhM
         x8iXK9tKv67kaabpiDX48UOpZeJIMOc23bND8xtStdAGQ5q/U4X6qAfX+ZVlS4AR7u8p
         lRJlUhEEEPyTzqCi6IFuCPgxsXmmgEDScQWgG9nqHQRmjI2ipG2YNWniBQHYlTs412zt
         sZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098969; x=1684690969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yDK7Ow/EQo3R038liwVGClD6X8zlhQtk+9SHaz2OOQ=;
        b=e3ClP5/mPFF4y0RK3wFRoSOYDEh5bVBIXwNAQ/kzESkOzICaxp+Zvc1PByK8jDqP+K
         lB8obrV7m1kWcPOS8N2AqqJlOgVUDHOrEBwVHtP6FJSfRVmvHL/Eh411PIpq2Xztrsco
         JDEtb5Irv9uX7L70PVxmE873hB8QioURoEEYphHkeXI0nrYmWa3x3OwgIlCM8R7sDfpA
         5Y27VFIDOGd4tj8IhZp4LAFCzdM9eawTdWm9/R22I3vaud+gy32qGCTnJecGKHi90cj1
         5Y6Y+dPi5veoal5hmx9+HNFXN58TsiZBbTefN7XLNtzBVumM1nVtav8P8RvRtenrej0c
         UCdQ==
X-Gm-Message-State: AAQBX9f/H/6MPle40m9FtBvb3r0E4u/CI7nY/oleIPEeAjsxhssIJaOf
        Rn/AXJ3zY5m9DRwlRyPcD0T80NXn1QrnBg==
X-Google-Smtp-Source: AKy350ZeFrN2Yu4e2tXbDmwRKWSxl0rfexYgG+37+3AGszM7d3ZxC86kdKNINrtg1xwRlPmvhjNong==
X-Received: by 2002:a5d:4b91:0:b0:2f9:61d4:1183 with SMTP id b17-20020a5d4b91000000b002f961d41183mr4433399wrt.45.1682098968939;
        Fri, 21 Apr 2023 10:42:48 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:48 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 03/24] selftests/bpf: verifier/bpf_get_stack converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:13 +0300
Message-Id: <20230421174234.2391278-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/bpf_get_stack automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_bpf_get_stack.c        | 124 ++++++++++++++++++
 .../selftests/bpf/verifier/bpf_get_stack.c    |  87 ------------
 3 files changed, 126 insertions(+), 87 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_get_stack.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/bpf_get_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e61c9120e261..db55d125928c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -10,6 +10,7 @@
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
+#include "verifier_bpf_get_stack.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -85,6 +86,7 @@ void test_verifier_bounds(void)               { RUN(verifier_bounds); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
+void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_stack); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_get_stack.c b/tools/testing/selftests/bpf/progs/verifier_bpf_get_stack.c
new file mode 100644
index 000000000000..325a2bab4a71
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_get_stack.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/bpf_get_stack.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define MAX_ENTRIES 11
+
+struct test_val {
+	unsigned int index;
+	int foo[MAX_ENTRIES];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct test_val);
+} map_array_48b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+SEC("tracepoint")
+__description("bpf_get_stack return R0 within range")
+__success
+__naked void stack_return_r0_within_range(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	r9 = %[__imm_0];				\
+	r1 = r6;					\
+	r2 = r7;					\
+	r3 = %[__imm_0];				\
+	r4 = 256;					\
+	call %[bpf_get_stack];				\
+	r1 = 0;						\
+	r8 = r0;					\
+	r8 <<= 32;					\
+	r8 s>>= 32;					\
+	if r1 s> r8 goto l0_%=;				\
+	r9 -= r8;					\
+	r2 = r7;					\
+	r2 += r8;					\
+	r1 = r9;					\
+	r1 <<= 32;					\
+	r1 s>>= 32;					\
+	r3 = r2;					\
+	r3 += r1;					\
+	r1 = r7;					\
+	r5 = %[__imm_0];				\
+	r1 += r5;					\
+	if r3 >= r1 goto l0_%=;				\
+	r1 = r6;					\
+	r3 = r9;					\
+	r4 = 0;						\
+	call %[bpf_get_stack];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_stack),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) / 2)
+	: __clobber_all);
+}
+
+SEC("iter/task")
+__description("bpf_get_task_stack return R0 range is refined")
+__success
+__naked void return_r0_range_is_refined(void)
+{
+	asm volatile ("					\
+	r6 = *(u64*)(r1 + 0);				\
+	r6 = *(u64*)(r6 + 0);		/* ctx->meta->seq */\
+	r7 = *(u64*)(r1 + 8);		/* ctx->task */\
+	r1 = %[map_array_48b] ll;	/* fixup_map_array_48b */\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	if r7 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r1 = r7;					\
+	r2 = r0;					\
+	r9 = r0;			/* keep buf for seq_write */\
+	r3 = 48;					\
+	r4 = 0;						\
+	call %[bpf_get_task_stack];			\
+	if r0 s> 0 goto l2_%=;				\
+	r0 = 0;						\
+	exit;						\
+l2_%=:	r1 = r6;					\
+	r2 = r9;					\
+	r3 = r0;					\
+	call %[bpf_seq_write];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_task_stack),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_seq_write),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
deleted file mode 100644
index 3e024c891178..000000000000
--- a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
+++ /dev/null
@@ -1,87 +0,0 @@
-{
-	"bpf_get_stack return R0 within range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 28),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_9, sizeof(struct test_val)/2),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_3, sizeof(struct test_val)/2),
-	BPF_MOV64_IMM(BPF_REG_4, 256),
-	BPF_EMIT_CALL(BPF_FUNC_get_stack),
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 32),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_1, BPF_REG_8, 16),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_1, 32),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_5, sizeof(struct test_val)/2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_5),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_9),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_EMIT_CALL(BPF_FUNC_get_stack),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"bpf_get_task_stack return R0 range is refined",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_6, 0), // ctx->meta->seq
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1, 8), // ctx->task
-	BPF_LD_MAP_FD(BPF_REG_1, 0), // fixup_map_array_48b
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0), // keep buf for seq_write
-	BPF_MOV64_IMM(BPF_REG_3, 48),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_EMIT_CALL(BPF_FUNC_get_task_stack),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_seq_write),
-
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACING,
-	.expected_attach_type = BPF_TRACE_ITER,
-	.kfunc = "task",
-	.runs = -1, // Don't run, just load
-	.fixup_map_array_48b = { 3 },
-},
-- 
2.40.0

