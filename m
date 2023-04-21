Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E46EB0DF
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDURn2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjDURnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1D759C9
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so3999745e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098976; x=1684690976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtHegdPWnCoIIvj3+l4JBdWz9kJSGRAe8dNbroWWinI=;
        b=O06I/38hNs7T5SlnDyk9JfEPJ6txHOmp1g+wrro+zP6HiR8dUXSnsCuFPoLsdv1wcU
         N+xBb1PeZt0uMsMZrztqkocOybDvwTWB7bkTVAZSMqZUFoNBTRnnBiEG/nbnS9SSwtOA
         racdFnFmD3CiT1hbLb27eYLI7MS7+oRqIhNMs2fosRpI0O/aVOOfALNn8va7gLPIZn+O
         lP7duSnAcjXgemwOaFdNrXUuPO0VlDtwsjFP8b08rXvWJ3HKWL4VFXa4ZuddbsD1upoY
         RDmEvaKuey4uPZBfBZ43kzfnCt4Sldpjp2qmq4+6H3WaYSfnDpeonHfpw6N3cQ2H3/U0
         hoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098976; x=1684690976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtHegdPWnCoIIvj3+l4JBdWz9kJSGRAe8dNbroWWinI=;
        b=Byxw1jfcckmqylS+mzkRe5+DGLFHPs2ama2cGL+s/MkzhZRC0tceTfezBDek5gJYkd
         Hqr9SDlgoMkBqB/3TYaXTHxFBnOGJTSO+G5UZNubB8d1aHeh2vbjFIX34FKm78mtVXN4
         LJ1yBTWgFYnzDM4UslXD9Lmpx44Tpqdm+dIL8d2rkxJAOpnDteuqHIAqt2SMwIpzkRpI
         wO9KgOJUyfUFAI15JWK+0WwYrTIN2z8fHxiTKWLTUMim/mNmHCORK/w+ufoMXdwLmtwR
         ymlKt22o19L4sh5YUbYyJPBefv3CoZo9NL7ujMweLG+Z7+cZCtof+bmPGOs/VGrM+aQs
         uAlg==
X-Gm-Message-State: AAQBX9fgAOHRjqpAw8EyFF+FMZNdjMtCIoSaKfY9A39EBEQeggFdjUZ7
        x+D/uDD4chhhjGyUzdipWX2YC7zLu5OVjw==
X-Google-Smtp-Source: AKy350aaYkGYJJkEaBcJiC90JIhfcwPq2MlV8RRcE++BNT9V2XJP807fc1QBGefkqtuGK8q6OxJvLg==
X-Received: by 2002:a7b:c38e:0:b0:3f1:718d:a21c with SMTP id s14-20020a7bc38e000000b003f1718da21cmr2609436wmj.31.1682098975917;
        Fri, 21 Apr 2023 10:42:55 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:55 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 09/24] selftests/bpf: verifier/loops1 converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:19 +0300
Message-Id: <20230421174234.2391278-10-eddyz87@gmail.com>
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

Test verifier/loops1 automatically converted to use inline assembly.

There are a few modifications for the converted tests.
"tracepoint" programs do not support test execution, change program
type to "xdp" (which supports test execution) for the following tests
that have __retval tags:
- bounded loop, count to 4
- bonded loop containing forward jump

Also, remove the __retval tag for test:
- bounded loop, count from positive unknown to 4

As it's return value is a random number.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_loops1.c     | 259 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/loops1.c | 206 --------------
 3 files changed, 261 insertions(+), 206 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loops1.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/loops1.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index de5db0de98a1..33a50dbc2321 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -32,6 +32,7 @@
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_leak_ptr.skel.h"
+#include "verifier_loops1.skel.h"
 #include "verifier_map_ptr.skel.h"
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
@@ -113,6 +114,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
+void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
new file mode 100644
index 000000000000..5bc86af80a9a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/loops1.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("xdp")
+__description("bounded loop, count to 4")
+__success __retval(4)
+__naked void bounded_loop_count_to_4(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+l0_%=:	r0 += 1;					\
+	if r0 < 4 goto l0_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bounded loop, count to 20")
+__success
+__naked void bounded_loop_count_to_20(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+l0_%=:	r0 += 3;					\
+	if r0 < 20 goto l0_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bounded loop, count from positive unknown to 4")
+__success
+__naked void from_positive_unknown_to_4(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	if r0 s< 0 goto l0_%=;				\
+l1_%=:	r0 += 1;					\
+	if r0 < 4 goto l1_%=;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bounded loop, count from totally unknown to 4")
+__success
+__naked void from_totally_unknown_to_4(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+l0_%=:	r0 += 1;					\
+	if r0 < 4 goto l0_%=;				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bounded loop, count to 4 with equality")
+__success
+__naked void count_to_4_with_equality(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+l0_%=:	r0 += 1;					\
+	if r0 != 4 goto l0_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bounded loop, start in the middle")
+__failure __msg("back-edge")
+__naked void loop_start_in_the_middle(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	goto l0_%=;					\
+l1_%=:	r0 += 1;					\
+l0_%=:	if r0 < 4 goto l1_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("xdp")
+__description("bounded loop containing a forward jump")
+__success __retval(4)
+__naked void loop_containing_a_forward_jump(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+l1_%=:	r0 += 1;					\
+	if r0 == r0 goto l0_%=;				\
+l0_%=:	if r0 < 4 goto l1_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bounded loop that jumps out rather than in")
+__success
+__naked void jumps_out_rather_than_in(void)
+{
+	asm volatile ("					\
+	r6 = 0;						\
+l1_%=:	r6 += 1;					\
+	if r6 > 10000 goto l0_%=;			\
+	call %[bpf_get_prandom_u32];			\
+	goto l1_%=;					\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("infinite loop after a conditional jump")
+__failure __msg("program is too large")
+__naked void loop_after_a_conditional_jump(void)
+{
+	asm volatile ("					\
+	r0 = 5;						\
+	if r0 < 4 goto l0_%=;				\
+l1_%=:	r0 += 1;					\
+	goto l1_%=;					\
+l0_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("bounded recursion")
+__failure __msg("back-edge")
+__naked void bounded_recursion(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	call bounded_recursion__1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void bounded_recursion__1(void)
+{
+	asm volatile ("					\
+	r1 += 1;					\
+	r0 = r1;					\
+	if r1 < 4 goto l0_%=;				\
+	exit;						\
+l0_%=:	call bounded_recursion__1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("infinite loop in two jumps")
+__failure __msg("loop detected")
+__naked void infinite_loop_in_two_jumps(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+l1_%=:	goto l0_%=;					\
+l0_%=:	if r0 < 4 goto l1_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("infinite loop: three-jump trick")
+__failure __msg("loop detected")
+__naked void infinite_loop_three_jump_trick(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+l2_%=:	r0 += 1;					\
+	r0 &= 1;					\
+	if r0 < 2 goto l0_%=;				\
+	exit;						\
+l0_%=:	r0 += 1;					\
+	r0 &= 1;					\
+	if r0 < 2 goto l1_%=;				\
+	exit;						\
+l1_%=:	r0 += 1;					\
+	r0 &= 1;					\
+	if r0 < 2 goto l2_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("xdp")
+__description("not-taken loop with back jump to 1st insn")
+__success __retval(123)
+__naked void back_jump_to_1st_insn_1(void)
+{
+	asm volatile ("					\
+l0_%=:	r0 = 123;					\
+	if r0 == 4 goto l0_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("xdp")
+__description("taken loop with back jump to 1st insn")
+__success __retval(55)
+__naked void back_jump_to_1st_insn_2(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	r2 = 0;						\
+	call back_jump_to_1st_insn_2__1;		\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void back_jump_to_1st_insn_2__1(void)
+{
+	asm volatile ("					\
+l0_%=:	r2 += r1;					\
+	r1 -= 1;					\
+	if r1 != 0 goto l0_%=;				\
+	r0 = r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("xdp")
+__description("taken loop with back jump to 1st insn, 2")
+__success __retval(55)
+__naked void jump_to_1st_insn_2(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	r2 = 0;						\
+	call jump_to_1st_insn_2__1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void jump_to_1st_insn_2__1(void)
+{
+	asm volatile ("					\
+l0_%=:	r2 += r1;					\
+	r1 -= 1;					\
+	if w1 != 0 goto l0_%=;				\
+	r0 = r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/loops1.c b/tools/testing/selftests/bpf/verifier/loops1.c
deleted file mode 100644
index 1af37187dc12..000000000000
--- a/tools/testing/selftests/bpf/verifier/loops1.c
+++ /dev/null
@@ -1,206 +0,0 @@
-{
-	"bounded loop, count to 4",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.retval = 4,
-},
-{
-	"bounded loop, count to 20",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 3),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 20, -2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"bounded loop, count from positive unknown to 4",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.retval = 4,
-},
-{
-	"bounded loop, count from totally unknown to 4",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"bounded loop, count to 4 with equality",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, -2),
-		BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"bounded loop, start in the middle",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_A(1),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
-		BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "back-edge",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.retval = 4,
-},
-{
-	"bounded loop containing a forward jump",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -3),
-		BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.retval = 4,
-},
-{
-	"bounded loop that jumps out rather than in",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_6, 0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_6, 10000, 2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_JMP_A(-4),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"infinite loop after a conditional jump",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 5),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, 2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_A(-2),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "program is too large",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"bounded recursion",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 4, 1),
-	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -5),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "back-edge",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"infinite loop in two jumps",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_A(0),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "loop detected",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"infinite loop: three-jump trick",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, 1),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, 1),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, -11),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "loop detected",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"not-taken loop with back jump to 1st insn",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 123),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 4, -2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.retval = 123,
-},
-{
-	"taken loop with back jump to 1st insn",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -3),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.retval = 55,
-},
-{
-	"taken loop with back jump to 1st insn, 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
-	BPF_JMP32_IMM(BPF_JNE, BPF_REG_1, 0, -3),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.retval = 55,
-},
-- 
2.40.0

