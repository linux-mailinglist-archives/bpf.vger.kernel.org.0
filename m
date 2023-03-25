Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA26C8A67
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjCYC4P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjCYC4O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393CD1B2CF
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1993721wmq.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZB0iab56BorWwWklop7biP9gABjAGVoxUSxp2Blqn4=;
        b=n/S063OvRPt+e9pG6O5B7S1uXGyfPDsuQQOTHYSP3HnjTlqsy8x2dHVfgVbi5FY9PE
         zv92PNIsNE+cw/Wf2Bo/F2hii8/z7Xa2YfUvxyza6xG3T/Wc0CvMQi1tqrtPvxGVHhwD
         pXPoInG8Yuojib7/mcxiExNGmXDyfNjqnxEywxvytty+To74KwdqGhJYmKgAyby+L+Iy
         WyLvMKP2mcmoEgGSfAb/OOmvJS2DMDx+d4cByM/jBz/qEH6jH4G2/MaUBl1Uq0FvYOks
         NSKNDyJdMbxefHv3V1VBaqy+tUXoQFm+x2tEDtYV6oU7mlwMJzS8QjEVSJ9tiNm1qrHE
         g6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZB0iab56BorWwWklop7biP9gABjAGVoxUSxp2Blqn4=;
        b=WgqiRJbgKmnlciznOJX+74cDYeRaFkOGN7LdYz5lge5IJgY391nNTM8EyHyXHy1sbz
         557rPjJv442zv2Lrboe3SSh9h3LG7H2B9BqU9JAqWn7J24nyaVtnOG2E7NgHF7eGx4KS
         8pATtuV7Q45th+HSdBpm57PS2n8vUvXHsl9Rs507HZTr5Ibw32Zs+1CC/9QWvIbf8Tfo
         4/snZyuCRZtb9Z4XUwI9V/ODhotnIKYW8LpUpJ7+V1uzz20kr51KukY4H69oaVbuVjHK
         hf/jyc8X+Nw0hVqwKchHt5Dy/TpN/6Ycyu65WiTCcwAIIrLEecIo9wgCFjrsaGDof9o5
         q5Dw==
X-Gm-Message-State: AO0yUKVY6ssCFh9XwjKdeDr2mQFF1OQzce4yvCBI+YDFNdwWntP7tWVQ
        cVDovEPCqUQ33iRCVbv8JiSEWGsDch0=
X-Google-Smtp-Source: AK7set9aGbicIji+T1ERDSB/MSlJEjRMVoYPY6jhRPLvSZMWTeThvE+XsFKs0aL3eE3a+kX0vJb2gg==
X-Received: by 2002:a05:600c:2108:b0:3ed:6c71:9dc8 with SMTP id u8-20020a05600c210800b003ed6c719dc8mr4303032wml.22.1679712970397;
        Fri, 24 Mar 2023 19:56:10 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:09 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 12/43] selftests/bpf: verifier/cgroup_inv_retcode.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:53 +0200
Message-Id: <20230325025524.144043-13-eddyz87@gmail.com>
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

Test verifier/cgroup_inv_retcode.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_cgroup_inv_retcode.c   | 89 +++++++++++++++++++
 .../bpf/verifier/cgroup_inv_retcode.c         | 72 ---------------
 3 files changed, 91 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/cgroup_inv_retcode.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 46182abecabb..b138c9894abb 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -9,6 +9,7 @@
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
 #include "verifier_cfg.skel.h"
+#include "verifier_cgroup_inv_retcode.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -40,3 +41,4 @@ void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
+void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
new file mode 100644
index 000000000000..d6c4a7f3f790
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/cgroup_inv_retcode.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("cgroup/sock")
+__description("bpf_exit with invalid return code. test1")
+__failure __msg("R0 has value (0x0; 0xffffffff)")
+__naked void with_invalid_return_code_test1(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/sock")
+__description("bpf_exit with invalid return code. test2")
+__success
+__naked void with_invalid_return_code_test2(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + 0);				\
+	r0 &= 1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/sock")
+__description("bpf_exit with invalid return code. test3")
+__failure __msg("R0 has value (0x0; 0x3)")
+__naked void with_invalid_return_code_test3(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + 0);				\
+	r0 &= 3;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/sock")
+__description("bpf_exit with invalid return code. test4")
+__success
+__naked void with_invalid_return_code_test4(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/sock")
+__description("bpf_exit with invalid return code. test5")
+__failure __msg("R0 has value (0x2; 0x0)")
+__naked void with_invalid_return_code_test5(void)
+{
+	asm volatile ("					\
+	r0 = 2;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/sock")
+__description("bpf_exit with invalid return code. test6")
+__failure __msg("R0 is not a known value (ctx)")
+__naked void with_invalid_return_code_test6(void)
+{
+	asm volatile ("					\
+	r0 = r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/sock")
+__description("bpf_exit with invalid return code. test7")
+__failure __msg("R0 has unknown scalar value")
+__naked void with_invalid_return_code_test7(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + 0);				\
+	r2 = *(u32*)(r1 + 4);				\
+	r0 *= r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/cgroup_inv_retcode.c b/tools/testing/selftests/bpf/verifier/cgroup_inv_retcode.c
deleted file mode 100644
index 6d65fe3e7321..000000000000
--- a/tools/testing/selftests/bpf/verifier/cgroup_inv_retcode.c
+++ /dev/null
@@ -1,72 +0,0 @@
-{
-	"bpf_exit with invalid return code. test1",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R0 has value (0x0; 0xffffffff)",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-},
-{
-	"bpf_exit with invalid return code. test2",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-},
-{
-	"bpf_exit with invalid return code. test3",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 3),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R0 has value (0x0; 0x3)",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-},
-{
-	"bpf_exit with invalid return code. test4",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-},
-{
-	"bpf_exit with invalid return code. test5",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 2),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R0 has value (0x2; 0x0)",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-},
-{
-	"bpf_exit with invalid return code. test6",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R0 is not a known value (ctx)",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-},
-{
-	"bpf_exit with invalid return code. test7",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 4),
-	BPF_ALU64_REG(BPF_MUL, BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R0 has unknown scalar value",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-},
-- 
2.40.0

