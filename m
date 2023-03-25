Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F66C8A64
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjCYC4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCYC4J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C80F18AA1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v1so3520731wrv.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXbt1KgeX7qUTNjP/3lsldEQfO1ury8+wQusKj9l1U4=;
        b=HbT0DZh8Uws58PuiXZT8FIxYYrTiKxfQIJbBQQJSxY5tW1EYq9k/XXm3dGT0NtMOv7
         RFYD/WzFXq9AJS1uhyXsRqBxudbd5WrW5Hq8c7LF+oek+xHscjfqGw5MipFJRP9kAryX
         s8LMAxC6HnHTiSxm43a43kI6Ic5lZ0h9n13KbsRIemiWcf6dDEpmiryVHvztT8kg6Iab
         LQZ/rYkSyYBeQE+weZQ8xiU3ZAhQ2F62ahUrSkYpiOCim807estWZraUmjQKwR/H8KII
         WJVaySpA/RHR61mvG1YReatVrHkRt6WfBSKbyHmGsRksh9NPeHNZVewLvh3Iv7nEh3vI
         9V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXbt1KgeX7qUTNjP/3lsldEQfO1ury8+wQusKj9l1U4=;
        b=ugmhCeZTa7xtWW9Wpiji9r0nUNvRVUc5MroiAdyolSp4bbxESJ5hbWbDAPaPZxZOuv
         dZPG+kgc/PRYwe7It2VE68+YjU+p6aw8bOB/i/3QT5gH0co5+XomgDRlSz8KJ/cZoHSv
         Zu2y3wWVff3GVePKOFnzs08ikRCSS+uNSTSUlaC/diUyb3TSb6jWSrDW6MvOh8udrMFR
         SwlRc0GoCNyi4uookzNfwYfuOsd/rG4jSsG9XY0tApBMYSMdNGxUbpqo/ISHU4JmT+gm
         KWZb02Yjz21Mof+jyqyVwEsGP6zEjlMmXQZQG0gM1FAG/7ZTE7VS0NcG6TSY3OlbPmjD
         b1Rw==
X-Gm-Message-State: AAQBX9cfBgMD3B31UNXdfFeUJ1mz9GGxdsCXF+1cfROW+aOLaUE4p27s
        iOOmh3Q3CYLGA5KvNP9RlqzCal8+GIY=
X-Google-Smtp-Source: AKy350YQGIcMaT8MfYpJXWYeBwiyaYDy3tG6PjgvFwNUJWUY/VUUUD9Auv4q+1jtUL6VjFk0On/nhA==
X-Received: by 2002:adf:f14c:0:b0:2d0:776:b766 with SMTP id y12-20020adff14c000000b002d00776b766mr3942964wro.8.1679712965725;
        Fri, 24 Mar 2023 19:56:05 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:05 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 09/43] selftests/bpf: verifier/bounds_deduction.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:50 +0200
Message-Id: <20230325025524.144043-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/bounds_deduction.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_bounds_deduction.c     | 171 ++++++++++++++++++
 .../selftests/bpf/verifier/bounds_deduction.c | 136 --------------
 3 files changed, 173 insertions(+), 136 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/bounds_deduction.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 95a3151db052..a8cfef92ed64 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -6,6 +6,7 @@
 #include "verifier_and.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
+#include "verifier_bounds_deduction.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -34,3 +35,4 @@ static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_fac
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_array_access(void)         { RUN(verifier_array_access); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
+void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
new file mode 100644
index 000000000000..c506afbdd936
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/bounds_deduction.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("check deducing bounds from const, 1")
+__failure __msg("R0 tried to subtract pointer from scalar")
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__naked void deducing_bounds_from_const_1(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	if r0 s>= 1 goto l0_%=;				\
+l0_%=:	r0 -= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 2")
+__success __failure_unpriv
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__retval(1)
+__naked void deducing_bounds_from_const_2(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	if r0 s>= 1 goto l0_%=;				\
+	exit;						\
+l0_%=:	if r0 s<= 1 goto l1_%=;				\
+	exit;						\
+l1_%=:	r1 -= r0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 3")
+__failure __msg("R0 tried to subtract pointer from scalar")
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__naked void deducing_bounds_from_const_3(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	if r0 s<= 0 goto l0_%=;				\
+l0_%=:	r0 -= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 4")
+__success __failure_unpriv
+__msg_unpriv("R6 has pointer with unsupported alu operation")
+__retval(0)
+__naked void deducing_bounds_from_const_4(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r0 = 0;						\
+	if r0 s<= 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	if r0 s>= 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r6 -= r0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 5")
+__failure __msg("R0 tried to subtract pointer from scalar")
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__naked void deducing_bounds_from_const_5(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	if r0 s>= 1 goto l0_%=;				\
+	r0 -= r1;					\
+l0_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 6")
+__failure __msg("R0 tried to subtract pointer from scalar")
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__naked void deducing_bounds_from_const_6(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	if r0 s>= 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r0 -= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 7")
+__failure __msg("dereference of modified ctx ptr")
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void deducing_bounds_from_const_7(void)
+{
+	asm volatile ("					\
+	r0 = %[__imm_0];				\
+	if r0 s>= 0 goto l0_%=;				\
+l0_%=:	r1 -= r0;					\
+	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, ~0),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 8")
+__failure __msg("negative offset ctx ptr R1 off=-1 disallowed")
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void deducing_bounds_from_const_8(void)
+{
+	asm volatile ("					\
+	r0 = %[__imm_0];				\
+	if r0 s>= 0 goto l0_%=;				\
+	r1 += r0;					\
+l0_%=:	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, ~0),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 9")
+__failure __msg("R0 tried to subtract pointer from scalar")
+__msg_unpriv("R1 has pointer with unsupported alu operation")
+__naked void deducing_bounds_from_const_9(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	if r0 s>= 0 goto l0_%=;				\
+l0_%=:	r0 -= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from const, 10")
+__failure
+__msg("math between ctx pointer and register with unbounded min value is not allowed")
+__failure_unpriv
+__naked void deducing_bounds_from_const_10(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	if r0 s<= 0 goto l0_%=;				\
+l0_%=:	/* Marks reg as unknown. */			\
+	r0 = -r0;					\
+	r0 -= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/bounds_deduction.c b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
deleted file mode 100644
index 3931c481e30c..000000000000
--- a/tools/testing/selftests/bpf/verifier/bounds_deduction.c
+++ /dev/null
@@ -1,136 +0,0 @@
-{
-	"check deducing bounds from const, 1",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 1, 0),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "R0 tried to subtract pointer from scalar",
-	.result = REJECT,
-},
-{
-	"check deducing bounds from const, 2",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 1, 1),
-		BPF_EXIT_INSN(),
-		BPF_JMP_IMM(BPF_JSLE, BPF_REG_0, 1, 1),
-		BPF_EXIT_INSN(),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"check deducing bounds from const, 3",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSLE, BPF_REG_0, 0, 0),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "R0 tried to subtract pointer from scalar",
-	.result = REJECT,
-},
-{
-	"check deducing bounds from const, 4",
-	.insns = {
-		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSLE, BPF_REG_0, 0, 1),
-		BPF_EXIT_INSN(),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
-		BPF_EXIT_INSN(),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_6, BPF_REG_0),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R6 has pointer with unsupported alu operation",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"check deducing bounds from const, 5",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 1, 1),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "R0 tried to subtract pointer from scalar",
-	.result = REJECT,
-},
-{
-	"check deducing bounds from const, 6",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
-		BPF_EXIT_INSN(),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "R0 tried to subtract pointer from scalar",
-	.result = REJECT,
-},
-{
-	"check deducing bounds from const, 7",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, ~0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 0),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
-		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-			    offsetof(struct __sk_buff, mark)),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "dereference of modified ctx ptr",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"check deducing bounds from const, 8",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, ~0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1),
-		BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-			    offsetof(struct __sk_buff, mark)),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "negative offset ctx ptr R1 off=-1 disallowed",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"check deducing bounds from const, 9",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 0),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-		BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "R0 tried to subtract pointer from scalar",
-	.result = REJECT,
-},
-{
-	"check deducing bounds from const, 10",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JSLE, BPF_REG_0, 0, 0),
-		/* Marks reg as unknown. */
-		BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-		BPF_EXIT_INSN(),
-	},
-	.errstr = "math between ctx pointer and register with unbounded min value is not allowed",
-	.result = REJECT,
-},
-- 
2.40.0

