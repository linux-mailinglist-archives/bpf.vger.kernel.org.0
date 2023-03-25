Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9776C8A6E
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCYC4Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCYC4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA9F15CBB
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s13so2093005wmr.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnYhksMqIBtMLwn+VGAgtwRDsLmLXEIwPH72cKVGaYM=;
        b=RmvK5R118FAcZyHfowgFsKUEGpL/edMnAcE1RMx14KfpheFwzjEWDjsG+H4lGaKYmK
         wOVnm78Mcdm3oBA08+LT45kozxYKiNo8C0Q1Z7xlQZyX15DHA025e3yRHrGdXk5hjWf8
         Cuvu4nHaAoxclnlOS61qlEBIoxUv284TRzf1BmZwEvB6W+h/ayt3USBvk3IowTU1B4OQ
         JrWuD/XVvBcLUPAFxdvI/pWcB2hFalhHVQhrj+4FBpueOcvEwA9XfKM0OKueSdrma3aw
         sOKRiWsHdEsOfsTlPESzRK3rnGb8qFjCaUA9Z6i/LaxNFeLskzp34SavmInifguwnHUt
         KHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnYhksMqIBtMLwn+VGAgtwRDsLmLXEIwPH72cKVGaYM=;
        b=xFAfsR62/UXDh9kXUwXV4i7iVKtzQRtUfZTYRKldpev/Hw69UlPop2I7RL4zo1hMhJ
         Uk4kbqWJQuNmKwOCFTSkiWeq+cq8y61eWesRl7uLJLwOhc28ApxKogyxhmf7V0jShJtb
         20UuU2bVlmx6sv29CrT57A4AyhT1TDmhH7wGi5fuEWxh9D/mu9LBNx5CZaQI6EdkiVI4
         Ga+Im/s8/XeGLiTrRkNvk18KwAxNPHVGcDkQ9XBVoCciBDPXqwYMeioBxCWC+NT1lLHT
         y2wJFde/q7Zo+m7q2Vm9a9AgQFDEueJfFytcDdijvL/qENLEH62FMJClm81P/TgsT1Kr
         c/Xw==
X-Gm-Message-State: AO0yUKWPsp84Wo+NROQ19qQfNTugAksPoVayCDsxFgATDqNuqHxGEwOq
        Jlo2EdG2SSe82C+J0LBUe61UZYvistg=
X-Google-Smtp-Source: AK7set8vobuKsF+40aO0A7vbMUbiuVFweWgjpAujDBtrLbnbm8V/BIpeiTuwz9pbL4fdO0NWpR9oNg==
X-Received: by 2002:a05:600c:3b1b:b0:3ed:24f7:2b48 with SMTP id m27-20020a05600c3b1b00b003ed24f72b48mr6849761wms.8.1679712980173;
        Fri, 24 Mar 2023 19:56:20 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:19 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 19/43] selftests/bpf: verifier/div_overflow.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:00 +0200
Message-Id: <20230325025524.144043-20-eddyz87@gmail.com>
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

Test verifier/div_overflow.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_div_overflow.c         | 144 ++++++++++++++++++
 .../selftests/bpf/verifier/div_overflow.c     | 110 -------------
 3 files changed, 146 insertions(+), 110 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_overflow.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/div_overflow.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b172c41cdc61..d92211b4c3af 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -16,6 +16,7 @@
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
+#include "verifier_div_overflow.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -54,3 +55,4 @@ void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
+void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_div_overflow.c b/tools/testing/selftests/bpf/progs/verifier_div_overflow.c
new file mode 100644
index 000000000000..458984da804c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_div_overflow.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/div_overflow.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <limits.h>
+#include "bpf_misc.h"
+
+/* Just make sure that JITs used udiv/umod as otherwise we get
+ * an exception from INT_MIN/-1 overflow similarly as with div
+ * by zero.
+ */
+
+SEC("tc")
+__description("DIV32 overflow, check 1")
+__success __retval(0)
+__naked void div32_overflow_check_1(void)
+{
+	asm volatile ("					\
+	w1 = -1;					\
+	w0 = %[int_min];				\
+	w0 /= w1;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("DIV32 overflow, check 2")
+__success __retval(0)
+__naked void div32_overflow_check_2(void)
+{
+	asm volatile ("					\
+	w0 = %[int_min];				\
+	w0 /= -1;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("DIV64 overflow, check 1")
+__success __retval(0)
+__naked void div64_overflow_check_1(void)
+{
+	asm volatile ("					\
+	r1 = -1;					\
+	r2 = %[llong_min] ll;				\
+	r2 /= r1;					\
+	w0 = 0;						\
+	if r0 == r2 goto l0_%=;				\
+	w0 = 1;						\
+l0_%=:	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("DIV64 overflow, check 2")
+__success __retval(0)
+__naked void div64_overflow_check_2(void)
+{
+	asm volatile ("					\
+	r1 = %[llong_min] ll;				\
+	r1 /= -1;					\
+	w0 = 0;						\
+	if r0 == r1 goto l0_%=;				\
+	w0 = 1;						\
+l0_%=:	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD32 overflow, check 1")
+__success __retval(INT_MIN)
+__naked void mod32_overflow_check_1(void)
+{
+	asm volatile ("					\
+	w1 = -1;					\
+	w0 = %[int_min];				\
+	w0 %%= w1;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD32 overflow, check 2")
+__success __retval(INT_MIN)
+__naked void mod32_overflow_check_2(void)
+{
+	asm volatile ("					\
+	w0 = %[int_min];				\
+	w0 %%= -1;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD64 overflow, check 1")
+__success __retval(1)
+__naked void mod64_overflow_check_1(void)
+{
+	asm volatile ("					\
+	r1 = -1;					\
+	r2 = %[llong_min] ll;				\
+	r3 = r2;					\
+	r2 %%= r1;					\
+	w0 = 0;						\
+	if r3 != r2 goto l0_%=;				\
+	w0 = 1;						\
+l0_%=:	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("MOD64 overflow, check 2")
+__success __retval(1)
+__naked void mod64_overflow_check_2(void)
+{
+	asm volatile ("					\
+	r2 = %[llong_min] ll;				\
+	r3 = r2;					\
+	r2 %%= -1;					\
+	w0 = 0;						\
+	if r3 != r2 goto l0_%=;				\
+	w0 = 1;						\
+l0_%=:	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/div_overflow.c b/tools/testing/selftests/bpf/verifier/div_overflow.c
deleted file mode 100644
index acab4f00819f..000000000000
--- a/tools/testing/selftests/bpf/verifier/div_overflow.c
+++ /dev/null
@@ -1,110 +0,0 @@
-/* Just make sure that JITs used udiv/umod as otherwise we get
- * an exception from INT_MIN/-1 overflow similarly as with div
- * by zero.
- */
-{
-	"DIV32 overflow, check 1",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, -1),
-	BPF_MOV32_IMM(BPF_REG_0, INT_MIN),
-	BPF_ALU32_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"DIV32 overflow, check 2",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, INT_MIN),
-	BPF_ALU32_IMM(BPF_DIV, BPF_REG_0, -1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"DIV64 overflow, check 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_LD_IMM64(BPF_REG_2, LLONG_MIN),
-	BPF_ALU64_REG(BPF_DIV, BPF_REG_2, BPF_REG_1),
-	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 1),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"DIV64 overflow, check 2",
-	.insns = {
-	BPF_LD_IMM64(BPF_REG_1, LLONG_MIN),
-	BPF_ALU64_IMM(BPF_DIV, BPF_REG_1, -1),
-	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 1),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"MOD32 overflow, check 1",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, -1),
-	BPF_MOV32_IMM(BPF_REG_0, INT_MIN),
-	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = INT_MIN,
-},
-{
-	"MOD32 overflow, check 2",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_0, INT_MIN),
-	BPF_ALU32_IMM(BPF_MOD, BPF_REG_0, -1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = INT_MIN,
-},
-{
-	"MOD64 overflow, check 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_LD_IMM64(BPF_REG_2, LLONG_MIN),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
-	BPF_ALU64_REG(BPF_MOD, BPF_REG_2, BPF_REG_1),
-	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_3, BPF_REG_2, 1),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"MOD64 overflow, check 2",
-	.insns = {
-	BPF_LD_IMM64(BPF_REG_2, LLONG_MIN),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_MOD, BPF_REG_2, -1),
-	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_3, BPF_REG_2, 1),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 1,
-},
-- 
2.40.0

