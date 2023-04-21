Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1186EB0E4
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjDURnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjDURnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717265B5
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f917585b26so1860513f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098981; x=1684690981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a/QQWc/OiP7atEYTeyVdAbMeUylaoHT0DALzB1ZFXM=;
        b=oyK0KO7VCZoiDeTOZAQLHS7aPtTvO2EZRnv2XiMKL0LADjIp2PdpCzxSk1M9I1sSPK
         exaFrx7yFNW5jjzj9wtYmi+r3ZBBIDWSclEwOVHzRVxyqvUPqj+QFjIiQmqDG1M8LFtp
         H+Rn94ztTgkAI9lPYBKROMk5dXGLZMjHW24fBSJceGdYJw/yduvEc7xXerirwfnUtgZs
         Dtp3iAianRldzop/xhUsuqzIczZazSFZM4mT3xqsooio2BIgrOZasTGH1KBiKr7kqtkl
         0C0B7f+PHOv0MdLbty54dASzt0VKyeJYYIaBEX2eiVc8kn0MRP+5FFwdghudUhHBgyj1
         L07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098981; x=1684690981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a/QQWc/OiP7atEYTeyVdAbMeUylaoHT0DALzB1ZFXM=;
        b=Z3Xd7VaeMnuh4K7pw1a//QFE/fzjbg8cgRDyj9vD8TkJDgqYmGCR/olR3s4cHmgBp1
         nRmpfkUZ9Pm7dNg7OUvbD4OwEoHoA4E/v3uWSZbJYW3vp1ImPRmxXgalGPhcM60slTel
         rvE4vm0GzXUb0A8WoJyrU+TzEjcMF8M6cbe1r28UMPMnHuENoYwMqeYSKcuVzP7yRCDu
         IrD1nH0hZ48hqcK9hzYYr6UmLLFlOddkzOfu8t4HhiNX0y3WjAX4gLv2X7x6rGt/Wywl
         avnvQhvPhLfsLATzkqafswi/wyXrZygLDJTrwtJyQgnmwrGwZCVy4qzS757lTS4QrfD0
         ljYA==
X-Gm-Message-State: AAQBX9db/2xGMwyfo5dxRqD6aPPf7D4cJjvRPOalgLGQxdgLQoPKMN2m
        GsUdtmNmju2z0QpWasvSbxdiPLRqBxcBNw==
X-Google-Smtp-Source: AKy350bt+3FnlGKfrmEVFWt50xiBC02Ul0futhVMXzF16Bi/pL+zKqOIQHdPhCNm1RduIV3K37VpOQ==
X-Received: by 2002:a5d:526e:0:b0:2f7:8f62:1a45 with SMTP id l14-20020a5d526e000000b002f78f621a45mr4508177wrc.66.1682098980742;
        Fri, 21 Apr 2023 10:43:00 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:00 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 13/24] selftests/bpf: verifier/precise converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:23 +0300
Message-Id: <20230421174234.2391278-14-eddyz87@gmail.com>
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

Test verifier/precise automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_precise.c    | 269 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  | 219 --------------
 3 files changed, 271 insertions(+), 219 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_precise.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/precise.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 261567230dd0..d5ec9054c025 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -40,6 +40,7 @@
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
+#include "verifier_precise.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"
@@ -125,6 +126,7 @@ void test_verifier_map_ptr_mixing(void)       { RUN(verifier_map_ptr_mixing); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
+void test_verifier_precise(void)              { RUN(verifier_precise); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_precise.c b/tools/testing/selftests/bpf/progs/verifier_precise.c
new file mode 100644
index 000000000000..81d58dc7d2d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_precise.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/precise.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
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
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} map_ringbuf SEC(".maps");
+
+SEC("tracepoint")
+__description("precise: test 1")
+__success
+__msg("27: (85) call bpf_probe_read_kernel#113")
+__msg("last_idx 27 first_idx 21")
+__msg("regs=4 stack=0 before 26")
+__msg("regs=4 stack=0 before 25")
+__msg("regs=4 stack=0 before 24")
+__msg("regs=4 stack=0 before 23")
+__msg("regs=4 stack=0 before 21")
+__msg("parent didn't have regs=4 stack=0 marks")
+__msg("last_idx 20 first_idx 11")
+__msg("regs=4 stack=0 before 20")
+__msg("regs=200 stack=0 before 19")
+__msg("regs=300 stack=0 before 18")
+__msg("regs=201 stack=0 before 16")
+__msg("regs=201 stack=0 before 15")
+__msg("regs=200 stack=0 before 14")
+__msg("regs=200 stack=0 before 13")
+__msg("regs=200 stack=0 before 12")
+__msg("regs=200 stack=0 before 11")
+__msg("parent already had regs=0 stack=0 marks")
+__log_level(2)
+__naked void precise_test_1(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	r6 = %[map_array_48b] ll;			\
+	r1 = r6;					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r7 = 0;						\
+	*(u64*)(r10 - 8) = r7;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r9 = r0;					\
+	r1 = r6;					\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r8 = r0;					\
+	r9 -= r8;			/* map_value_ptr -= map_value_ptr */\
+	r2 = r9;					\
+	if r2 < 8 goto l2_%=;				\
+	exit;						\
+l2_%=:	r2 += 1;			/* R2=scalar(umin=1, umax=8) */\
+	r1 = r10;					\
+	r1 += -8;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("precise: test 2")
+__success
+__msg("27: (85) call bpf_probe_read_kernel#113")
+__msg("last_idx 27 first_idx 23")
+__msg("regs=4 stack=0 before 26")
+__msg("regs=4 stack=0 before 25")
+__msg("regs=4 stack=0 before 24")
+__msg("regs=4 stack=0 before 25")
+__msg("parent didn't have regs=4 stack=0 marks")
+__msg("last_idx 21 first_idx 21")
+__msg("regs=4 stack=0 before 21")
+__msg("parent didn't have regs=4 stack=0 marks")
+__msg("last_idx 20 first_idx 18")
+__msg("regs=4 stack=0 before 20")
+__msg("regs=200 stack=0 before 19")
+__msg("regs=300 stack=0 before 18")
+__msg("parent already had regs=0 stack=0 marks")
+__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void precise_test_2(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	r6 = %[map_array_48b] ll;			\
+	r1 = r6;					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r7 = 0;						\
+	*(u64*)(r10 - 8) = r7;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r9 = r0;					\
+	r1 = r6;					\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r8 = r0;					\
+	r9 -= r8;			/* map_value_ptr -= map_value_ptr */\
+	r2 = r9;					\
+	if r2 < 8 goto l2_%=;				\
+	exit;						\
+l2_%=:	r2 += 1;			/* R2=scalar(umin=1, umax=8) */\
+	r1 = r10;					\
+	r1 += -8;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("precise: cross frame pruning")
+__failure __msg("!read_ok")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void precise_cross_frame_pruning(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r8 = 0;						\
+	if r0 != 0 goto l0_%=;				\
+	r8 = 1;						\
+l0_%=:	call %[bpf_get_prandom_u32];			\
+	r9 = 0;						\
+	if r0 != 0 goto l1_%=;				\
+	r9 = 1;						\
+l1_%=:	r1 = r0;					\
+	call precise_cross_frame_pruning__1;		\
+	if r8 == 1 goto l2_%=;				\
+	r1 = *(u8*)(r2 + 0);				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void precise_cross_frame_pruning__1(void)
+{
+	asm volatile ("					\
+	if r1 == 0 goto l0_%=;				\
+l0_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("xdp")
+__description("precise: ST insn causing spi > allocated_stack")
+__success
+__msg("5: (2d) if r4 > r0 goto pc+0")
+__msg("last_idx 5 first_idx 5")
+__msg("parent didn't have regs=10 stack=0 marks")
+__msg("last_idx 4 first_idx 2")
+__msg("regs=10 stack=0 before 4")
+__msg("regs=10 stack=0 before 3")
+__msg("regs=0 stack=1 before 2")
+__msg("last_idx 5 first_idx 5")
+__msg("parent didn't have regs=1 stack=0 marks")
+__log_level(2) __retval(-1) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void insn_causing_spi_allocated_stack_1(void)
+{
+	asm volatile ("					\
+	r3 = r10;					\
+	if r3 != 123 goto l0_%=;			\
+l0_%=:	.8byte %[st_mem];				\
+	r4 = *(u64*)(r10 - 8);				\
+	r0 = -1;					\
+	if r4 > r0 goto l1_%=;				\
+l1_%=:	exit;						\
+"	:
+	: __imm_insn(st_mem, BPF_ST_MEM(BPF_DW, BPF_REG_3, -8, 0))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("precise: STX insn causing spi > allocated_stack")
+__success
+__msg("last_idx 6 first_idx 6")
+__msg("parent didn't have regs=10 stack=0 marks")
+__msg("last_idx 5 first_idx 3")
+__msg("regs=10 stack=0 before 5")
+__msg("regs=10 stack=0 before 4")
+__msg("regs=0 stack=1 before 3")
+__msg("last_idx 6 first_idx 6")
+__msg("parent didn't have regs=1 stack=0 marks")
+__msg("last_idx 5 first_idx 3")
+__msg("regs=1 stack=0 before 5")
+__log_level(2) __retval(-1) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void insn_causing_spi_allocated_stack_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r3 = r10;					\
+	if r3 != 123 goto l0_%=;			\
+l0_%=:	*(u64*)(r3 - 8) = r0;				\
+	r4 = *(u64*)(r10 - 8);				\
+	r0 = -1;					\
+	if r4 > r0 goto l1_%=;				\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("precise: mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO")
+__failure __msg("invalid access to memory, mem_size=1 off=42 size=8")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void const_alloc_size_or_zero(void)
+{
+	asm volatile ("					\
+	r4 = *(u32*)(r1 + %[xdp_md_ingress_ifindex]);	\
+	r6 = %[map_ringbuf] ll;				\
+	r1 = r6;					\
+	r2 = 1;						\
+	r3 = 0;						\
+	if r4 == 0 goto l0_%=;				\
+	r2 = 0x1000;					\
+l0_%=:	call %[bpf_ringbuf_reserve];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r1 = r0;					\
+	r2 = *(u64*)(r0 + 42);				\
+	call %[bpf_ringbuf_submit];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_submit),
+	  __imm_addr(map_ringbuf),
+	  __imm_const(xdp_md_ingress_ifindex, offsetof(struct xdp_md, ingress_ifindex))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
deleted file mode 100644
index 6c03a7d805f9..000000000000
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ /dev/null
@@ -1,219 +0,0 @@
-{
-	"precise: test 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_LD_MAP_FD(BPF_REG_6, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
-
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8), /* map_value_ptr -= map_value_ptr */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_2, 8, 1),
-	BPF_EXIT_INSN(),
-
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1), /* R2=scalar(umin=1, umax=8) */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.fixup_map_array_48b = { 1 },
-	.result = VERBOSE_ACCEPT,
-	.errstr =
-	"26: (85) call bpf_probe_read_kernel#113\
-	last_idx 26 first_idx 20\
-	regs=4 stack=0 before 25\
-	regs=4 stack=0 before 24\
-	regs=4 stack=0 before 23\
-	regs=4 stack=0 before 22\
-	regs=4 stack=0 before 20\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 19 first_idx 10\
-	regs=4 stack=0 before 19\
-	regs=200 stack=0 before 18\
-	regs=300 stack=0 before 17\
-	regs=201 stack=0 before 15\
-	regs=201 stack=0 before 14\
-	regs=200 stack=0 before 13\
-	regs=200 stack=0 before 12\
-	regs=200 stack=0 before 11\
-	regs=200 stack=0 before 10\
-	parent already had regs=0 stack=0 marks",
-},
-{
-	"precise: test 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_LD_MAP_FD(BPF_REG_6, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
-
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8), /* map_value_ptr -= map_value_ptr */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_2, 8, 1),
-	BPF_EXIT_INSN(),
-
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1), /* R2=scalar(umin=1, umax=8) */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.fixup_map_array_48b = { 1 },
-	.result = VERBOSE_ACCEPT,
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr =
-	"26: (85) call bpf_probe_read_kernel#113\
-	last_idx 26 first_idx 22\
-	regs=4 stack=0 before 25\
-	regs=4 stack=0 before 24\
-	regs=4 stack=0 before 23\
-	regs=4 stack=0 before 22\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 20 first_idx 20\
-	regs=4 stack=0 before 20\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 19 first_idx 17\
-	regs=4 stack=0 before 19\
-	regs=200 stack=0 before 18\
-	regs=300 stack=0 before 17\
-	parent already had regs=0 stack=0 marks",
-},
-{
-	"precise: cross frame pruning",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_8, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_IMM(BPF_REG_9, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_9, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "!read_ok",
-	.result = REJECT,
-},
-{
-	"precise: ST insn causing spi > allocated_stack",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_3, -8, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
-	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "5: (2d) if r4 > r0 goto pc+0\
-	last_idx 5 first_idx 5\
-	parent didn't have regs=10 stack=0 marks\
-	last_idx 4 first_idx 2\
-	regs=10 stack=0 before 4\
-	regs=10 stack=0 before 3\
-	regs=0 stack=1 before 2\
-	last_idx 5 first_idx 5\
-	parent didn't have regs=1 stack=0 marks",
-	.result = VERBOSE_ACCEPT,
-	.retval = -1,
-},
-{
-	"precise: STX insn causing spi > allocated_stack",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
-	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "last_idx 6 first_idx 6\
-	parent didn't have regs=10 stack=0 marks\
-	last_idx 5 first_idx 3\
-	regs=10 stack=0 before 5\
-	regs=10 stack=0 before 4\
-	regs=0 stack=1 before 3\
-	last_idx 6 first_idx 6\
-	parent didn't have regs=1 stack=0 marks\
-	last_idx 5 first_idx 3\
-	regs=1 stack=0 before 5",
-	.result = VERBOSE_ACCEPT,
-	.retval = -1,
-},
-{
-	"precise: mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct xdp_md, ingress_ifindex)),
-	BPF_LD_MAP_FD(BPF_REG_6, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_2, 0x1000),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 42),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 1 },
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "invalid access to memory, mem_size=1 off=42 size=8",
-	.result = REJECT,
-},
-- 
2.40.0

