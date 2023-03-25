Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EFC6C8A6D
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCYC4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjCYC4W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878A168B7
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p34so2096790wms.3
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBnID/EmIxIy+7+TQO1thQTa6qWM6UCpTxDg4cjZCnA=;
        b=Uwzz/Sf4wMZ0dQp+aRWtcchYJHgPkduVONHtfpvatB4HKYA6REx7NojQoBG+13P5q/
         xF0ahLbo2JP5Doa2RhX8v91yD/fUS2ggp45h7E/VO+N2Gv+5neBFnxs4by5/5IA3QmgJ
         cjPnKz2mZVCz0IuB5L6hpV5nLZj9w3xD1Ct1jiIhxS4gUD6jMYP0I+sGGjDnMWWGYnJX
         OwqcYrvn1FkugdyHKRtRcqCnGG0V2uf25h/Y1ffGU+SiV2WqrQ7/aGrVrblBtvunrVQR
         jkmTh9suK5m4Q1lN7QsnvlAXqQxtt5i2ChZA7nBOI1nabkWh1DJAN0oU+ezJvmYYxviN
         zvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBnID/EmIxIy+7+TQO1thQTa6qWM6UCpTxDg4cjZCnA=;
        b=X+Jt974peV+brGuNFQPze9VohLh+v7hUt0YLC6ayqOMTVpEctXOFQDLkBN9/Rf9hor
         RR94hUP5zGqpTWWVvP/oPgBTQpnmM9fTG9s59/kzYRw4nHNzVtxg+bhz390VwLyD4tch
         QFvuwW0w6fAUofrd/WVnN9T2CtR3iVFsqMI+Stx6wAoPbXYH6OD4mMh6KClvgFm0oHuz
         SSFTnDxqlWusv/iqscwSikI6kVJeALu41asa6lnolGUA3btdW3qJoVH/yiYNdR88fmEX
         6wqssXFLdmaohAHoO3R+X9aAJSxlJ/SSUViFpHgpvdelBXHuYiYjG7wZlk3T6lN2DJqx
         1r2Q==
X-Gm-Message-State: AO0yUKV85fUyIDNZcV1Bwi7iod3u/t4v3piiDg8PmhjjgBLoaD5bGui/
        xxDbdMG9+uIgQIxviYZyrBZywu/IGL0=
X-Google-Smtp-Source: AK7set9fL9g8MhFCX3HkCOIZtCCbpnxkLmNXwvn1VmSJSpk5fjZW1wtoU6Oq8VQk7vF8UyE+qQN6/w==
X-Received: by 2002:a7b:ce16:0:b0:3ed:9b20:c7c1 with SMTP id m22-20020a7bce16000000b003ed9b20c7c1mr3571310wmc.20.1679712978773;
        Fri, 24 Mar 2023 19:56:18 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:18 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 18/43] selftests/bpf: verifier/div0.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:59 +0200
Message-Id: <20230325025524.144043-19-eddyz87@gmail.com>
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

Test verifier/div0.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_div0.c       | 213 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/div0.c   | 184 ---------------
 3 files changed, 215 insertions(+), 184 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div0.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/div0.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8c33b8792a0a..b172c41cdc61 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -15,6 +15,7 @@
 #include "verifier_const_or.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
+#include "verifier_div0.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -52,3 +53,4 @@ void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
+void test_verifier_div0(void)                 { RUN(verifier_div0); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_div0.c b/tools/testing/selftests/bpf/progs/verifier_div0.c
new file mode 100644
index 000000000000..cca5ea18fc28
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_div0.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/div0.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("DIV32 by 0, zero check 1")
+__success __success_unpriv __retval(42)
+__naked void by_0_zero_check_1_1(void)
+{
+	asm volatile ("					\
+	w0 = 42;					\
+	w1 = 0;						\
+	w2 = 1;						\
+	w2 /= w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("DIV32 by 0, zero check 2")
+__success __success_unpriv __retval(42)
+__naked void by_0_zero_check_2_1(void)
+{
+	asm volatile ("					\
+	w0 = 42;					\
+	r1 = 0xffffffff00000000LL ll;			\
+	w2 = 1;						\
+	w2 /= w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("DIV64 by 0, zero check")
+__success __success_unpriv __retval(42)
+__naked void div64_by_0_zero_check(void)
+{
+	asm volatile ("					\
+	w0 = 42;					\
+	w1 = 0;						\
+	w2 = 1;						\
+	r2 /= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOD32 by 0, zero check 1")
+__success __success_unpriv __retval(42)
+__naked void by_0_zero_check_1_2(void)
+{
+	asm volatile ("					\
+	w0 = 42;					\
+	w1 = 0;						\
+	w2 = 1;						\
+	w2 %%= w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOD32 by 0, zero check 2")
+__success __success_unpriv __retval(42)
+__naked void by_0_zero_check_2_2(void)
+{
+	asm volatile ("					\
+	w0 = 42;					\
+	r1 = 0xffffffff00000000LL ll;			\
+	w2 = 1;						\
+	w2 %%= w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOD64 by 0, zero check")
+__success __success_unpriv __retval(42)
+__naked void mod64_by_0_zero_check(void)
+{
+	asm volatile ("					\
+	w0 = 42;					\
+	w1 = 0;						\
+	w2 = 1;						\
+	r2 %%= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("DIV32 by 0, zero check ok, cls")
+__success __retval(8)
+__naked void _0_zero_check_ok_cls_1(void)
+{
+	asm volatile ("					\
+	w0 = 42;					\
+	w1 = 2;						\
+	w2 = 16;					\
+	w2 /= w1;					\
+	r0 = r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("DIV32 by 0, zero check 1, cls")
+__success __retval(0)
+__naked void _0_zero_check_1_cls_1(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+	w0 = 1;						\
+	w0 /= w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("DIV32 by 0, zero check 2, cls")
+__success __retval(0)
+__naked void _0_zero_check_2_cls_1(void)
+{
+	asm volatile ("					\
+	r1 = 0xffffffff00000000LL ll;			\
+	w0 = 1;						\
+	w0 /= w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("DIV64 by 0, zero check, cls")
+__success __retval(0)
+__naked void by_0_zero_check_cls(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+	w0 = 1;						\
+	r0 /= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD32 by 0, zero check ok, cls")
+__success __retval(2)
+__naked void _0_zero_check_ok_cls_2(void)
+{
+	asm volatile ("					\
+	w0 = 42;					\
+	w1 = 3;						\
+	w2 = 5;						\
+	w2 %%= w1;					\
+	r0 = r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD32 by 0, zero check 1, cls")
+__success __retval(1)
+__naked void _0_zero_check_1_cls_2(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+	w0 = 1;						\
+	w0 %%= w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD32 by 0, zero check 2, cls")
+__success __retval(1)
+__naked void _0_zero_check_2_cls_2(void)
+{
+	asm volatile ("					\
+	r1 = 0xffffffff00000000LL ll;			\
+	w0 = 1;						\
+	w0 %%= w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD64 by 0, zero check 1, cls")
+__success __retval(2)
+__naked void _0_zero_check_1_cls_3(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+	w0 = 2;						\
+	r0 %%= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD64 by 0, zero check 2, cls")
+__success __retval(-1)
+__naked void _0_zero_check_2_cls_3(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+	w0 = -1;					\
+	r0 %%= r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/div0.c b/tools/testing/selftests/bpf/verifier/div0.c
deleted file mode 100644
index 7685edfbcf71..000000000000
--- a/tools/testing/selftests/bpf/verifier/div0.c
+++ /dev/null
@@ -1,184 +0,0 @@
-{
-	"DIV32 by 0, zero check 1",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, 42),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_2, 1),
-	BPF_ALU32_REG(BPF_DIV, BPF_REG_2, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"DIV32 by 0, zero check 2",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, 42),
-	BPF_LD_IMM64(BPF_REG_1, 0xffffffff00000000LL),
-	BPF_MOV32_IMM(BPF_REG_2, 1),
-	BPF_ALU32_REG(BPF_DIV, BPF_REG_2, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"DIV64 by 0, zero check",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, 42),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_2, 1),
-	BPF_ALU64_REG(BPF_DIV, BPF_REG_2, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"MOD32 by 0, zero check 1",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, 42),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_2, 1),
-	BPF_ALU32_REG(BPF_MOD, BPF_REG_2, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"MOD32 by 0, zero check 2",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, 42),
-	BPF_LD_IMM64(BPF_REG_1, 0xffffffff00000000LL),
-	BPF_MOV32_IMM(BPF_REG_2, 1),
-	BPF_ALU32_REG(BPF_MOD, BPF_REG_2, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"MOD64 by 0, zero check",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, 42),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_2, 1),
-	BPF_ALU64_REG(BPF_MOD, BPF_REG_2, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"DIV32 by 0, zero check ok, cls",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, 42),
-	BPF_MOV32_IMM(BPF_REG_1, 2),
-	BPF_MOV32_IMM(BPF_REG_2, 16),
-	BPF_ALU32_REG(BPF_DIV, BPF_REG_2, BPF_REG_1),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 8,
-},
-{
-	"DIV32 by 0, zero check 1, cls",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_ALU32_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"DIV32 by 0, zero check 2, cls",
-	.insns = {
-	BPF_LD_IMM64(BPF_REG_1, 0xffffffff00000000LL),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_ALU32_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"DIV64 by 0, zero check, cls",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_ALU64_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"MOD32 by 0, zero check ok, cls",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, 42),
-	BPF_MOV32_IMM(BPF_REG_1, 3),
-	BPF_MOV32_IMM(BPF_REG_2, 5),
-	BPF_ALU32_REG(BPF_MOD, BPF_REG_2, BPF_REG_1),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 2,
-},
-{
-	"MOD32 by 0, zero check 1, cls",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"MOD32 by 0, zero check 2, cls",
-	.insns = {
-	BPF_LD_IMM64(BPF_REG_1, 0xffffffff00000000LL),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"MOD64 by 0, zero check 1, cls",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_0, 2),
-	BPF_ALU64_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 2,
-},
-{
-	"MOD64 by 0, zero check 2, cls",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_0, -1),
-	BPF_ALU64_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = -1,
-},
-- 
2.40.0

