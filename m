Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98B6C8A68
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCYC4S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCYC4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C8618AA1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1993753wmq.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCUfblk8A1MSGt5UUlQyjdhL/TWgLB8awAOm+BExeaI=;
        b=funSw7I8h6H6Bm+mavzQipP1kH1bBSVXI6L3g4PFUN225jek9ksxZ7xJDcxOtjb4pT
         t7HtrdX90qFbXIjk+KbNRrLl12QeunwTwbubsZ8wd7izeYBrDWaxQcp+9NvVsWlMCYJf
         jWNudtLq0vFNmupmHxjk+mT6/TMGVAFdNeOz7b2EZm3eFDQFPt69+7LNmh1pRT7qbBrO
         VwxaIXDetc+YtEKFv6YWH3T2289BF1ZDYh9kaRsWvQBAcX+uXG3uVtlY1/sAC0rFGKQF
         irSQZK1XLx2e/mzo6ek3/+XqbygMrt3pYPUKKTgUPrrNPIYilwzG10nSWXZrPX0oA3su
         dvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCUfblk8A1MSGt5UUlQyjdhL/TWgLB8awAOm+BExeaI=;
        b=muqaE/x9yi92ZjeyDFUaXwOdU8wF6KCJl1JxH8iyjtrTZR76uUGVyysioaZkOrBR4B
         b0muue6KjETFjz9YrcmWFemByTPr14yk9jOSkOromZHIbH9g2SLrGxS15+VcLMsStZi7
         4Dm6IXJa/8fnA38+HNzRxZGtIUmTIss+oCVEmqx9PODJLEBT8Vb3kuvwIglxBRmjSIeP
         QyVkJvv4JP6oZJOEP518oflgRwahPnohsrs8CIytNn0TI2jLNRaEinV0Hf8UvpBCGIgC
         I4RvO0NhuVCHhI9zHXfzwrx50EcJqV9OuhR/AMTcWBoQRcTBwDaymFKc4V7CLpnKga+z
         MgRg==
X-Gm-Message-State: AO0yUKUTYYYAeHu/v0zD7OXqD+y+Wr0c7wPYI8vsjRY2xCYDbnQ89ZQP
        0uPoe2PRVxurWs9e20EiZHdaMpxbkBo=
X-Google-Smtp-Source: AK7set+3LsInezHt9cR1Krbc0911CryBq8gSAN2kNILG+cn8oi3lUF7uNN6LP/YLBXAWz2RTRtvOtw==
X-Received: by 2002:a7b:c419:0:b0:3ed:e447:1ed0 with SMTP id k25-20020a7bc419000000b003ede4471ed0mr4008213wmi.14.1679712974879;
        Fri, 24 Mar 2023 19:56:14 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:14 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 15/43] selftests/bpf: verifier/const_or.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:56 +0200
Message-Id: <20230325025524.144043-16-eddyz87@gmail.com>
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

Test verifier/const_or.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_const_or.c   | 82 +++++++++++++++++++
 .../testing/selftests/bpf/verifier/const_or.c | 60 --------------
 3 files changed, 84 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_const_or.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/const_or.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 3b47620a1f42..36fdede7dcab 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -12,6 +12,7 @@
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
 #include "verifier_cgroup_storage.skel.h"
+#include "verifier_const_or.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -46,3 +47,4 @@ void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
+void test_verifier_const_or(void)             { RUN(verifier_const_or); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_const_or.c b/tools/testing/selftests/bpf/progs/verifier_const_or.c
new file mode 100644
index 000000000000..ba8922b2eebd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_const_or.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/const_or.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tracepoint")
+__description("constant register |= constant should keep constant type")
+__success
+__naked void constant_should_keep_constant_type(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -48;					\
+	r2 = 34;					\
+	r2 |= 13;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("constant register |= constant should not bypass stack boundary checks")
+__failure __msg("invalid indirect access to stack R1 off=-48 size=58")
+__naked void not_bypass_stack_boundary_checks_1(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -48;					\
+	r2 = 34;					\
+	r2 |= 24;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("constant register |= constant register should keep constant type")
+__success
+__naked void register_should_keep_constant_type(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -48;					\
+	r2 = 34;					\
+	r4 = 13;					\
+	r2 |= r4;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("constant register |= constant register should not bypass stack boundary checks")
+__failure __msg("invalid indirect access to stack R1 off=-48 size=58")
+__naked void not_bypass_stack_boundary_checks_2(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -48;					\
+	r2 = 34;					\
+	r4 = 24;					\
+	r2 |= r4;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/const_or.c b/tools/testing/selftests/bpf/verifier/const_or.c
deleted file mode 100644
index 0719b0ddec04..000000000000
--- a/tools/testing/selftests/bpf/verifier/const_or.c
+++ /dev/null
@@ -1,60 +0,0 @@
-{
-	"constant register |= constant should keep constant type",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -48),
-	BPF_MOV64_IMM(BPF_REG_2, 34),
-	BPF_ALU64_IMM(BPF_OR, BPF_REG_2, 13),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"constant register |= constant should not bypass stack boundary checks",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -48),
-	BPF_MOV64_IMM(BPF_REG_2, 34),
-	BPF_ALU64_IMM(BPF_OR, BPF_REG_2, 24),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid indirect access to stack R1 off=-48 size=58",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"constant register |= constant register should keep constant type",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -48),
-	BPF_MOV64_IMM(BPF_REG_2, 34),
-	BPF_MOV64_IMM(BPF_REG_4, 13),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"constant register |= constant register should not bypass stack boundary checks",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -48),
-	BPF_MOV64_IMM(BPF_REG_2, 34),
-	BPF_MOV64_IMM(BPF_REG_4, 24),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid indirect access to stack R1 off=-48 size=58",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-- 
2.40.0

