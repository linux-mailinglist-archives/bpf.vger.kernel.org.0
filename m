Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6C6C8A65
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjCYC4N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCYC4M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE615CBB
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so4157896wmb.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfF1GNiRtYMvmnyWcpmJoB1u66BO8g+DHW9EeywpPx8=;
        b=g9fgbwQvqqoDLZ3EQ+CsysRbkZadvgiKb7oPxI4qjm5WSD2nqmWhrjAhI4rAd81T8j
         XH+HzMvaDRD2fkGHPKB7Do2yN7W0Ab8iaSLPiV21F/5t1rayFzA6lVr2MeMzJ/vkwSlP
         fGuPi7j8shncGoivXzbc4wS1Cq4Z31oQ3MuCleBeIqPlA6q/3K6CYxgQ4mcmKvpvZ2zm
         zswzgONWKhemGu91cokHf/i6Z09lM0FV+uECGUCCCGaSmRBaJaRxFAnHfpwvqt/W5WWi
         OnR4mX7nuFq5rfL7exP9qILx6LvqoMTckpI7P48BbS5suJPxgszVqNzPodFzk7N3L03G
         DPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfF1GNiRtYMvmnyWcpmJoB1u66BO8g+DHW9EeywpPx8=;
        b=IekANplYzrV41KSueQmpk83Gfc6f+B0l8K57rrReo7KeqXNAZE9iMt5iNvnKSKESdh
         AP6Q4qbSCaTwA6VlPknHJ2pjKprgGAE8ZoTG7whytUOe2kd/NaqKdja/u/2vdL+n9Bjj
         3xtfw60RtTDvnmxjXawVH9peQjUJqW8IdPqAlukYYJMYiEahMd/VS6LT9BexSWtHa7at
         rU6AuY7p4S0PqLYzqqdCvnlpr6sCAbNhuncqeGVfFArL1uYjlUQeoJwJLtXX0OCPKGhV
         Q16lk+q7+BJBjebcmfq0ch+EXfMgl8lCzNiJedQaXKciYVVUBIIgn4PmigJL+OKG7IVX
         SfBA==
X-Gm-Message-State: AO0yUKX5d2ey8rvWeeMRZQhzvZZFAuwvGcQLjTFQe3EdCNrqc7yz9IPF
        CtmKNVhJx/wjdMhQXRxc2OK3CXhiCFk=
X-Google-Smtp-Source: AK7set9V7tZZGc45SN8M1jF8ZBbkKMsO7pWomfiOR1HShRYcZFvhno4veDwKRVRoWViyZp38bJaG+g==
X-Received: by 2002:a05:600c:2199:b0:3ee:3fd7:5f84 with SMTP id e25-20020a05600c219900b003ee3fd75f84mr3756424wme.6.1679712968771;
        Fri, 24 Mar 2023 19:56:08 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:07 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 11/43] selftests/bpf: verifier/cfg.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:52 +0200
Message-Id: <20230325025524.144043-12-eddyz87@gmail.com>
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

Test verifier/cfg.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_cfg.c        | 100 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/cfg.c    |  73 -------------
 3 files changed, 102 insertions(+), 73 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cfg.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/cfg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index bbc39412fcd1..46182abecabb 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -8,6 +8,7 @@
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
+#include "verifier_cfg.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -38,3 +39,4 @@ void test_verifier_array_access(void)         { RUN(verifier_array_access); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
+void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
new file mode 100644
index 000000000000..df7697b94007
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/cfg.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("unreachable")
+__failure __msg("unreachable")
+__failure_unpriv
+__naked void unreachable(void)
+{
+	asm volatile ("					\
+	exit;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unreachable2")
+__failure __msg("unreachable")
+__failure_unpriv
+__naked void unreachable2(void)
+{
+	asm volatile ("					\
+	goto l0_%=;					\
+	goto l0_%=;					\
+l0_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("out of range jump")
+__failure __msg("jump out of range")
+__failure_unpriv
+__naked void out_of_range_jump(void)
+{
+	asm volatile ("					\
+	goto l0_%=;					\
+	exit;						\
+l0_%=:							\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("out of range jump2")
+__failure __msg("jump out of range")
+__failure_unpriv
+__naked void out_of_range_jump2(void)
+{
+	asm volatile ("					\
+	goto -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("loop (back-edge)")
+__failure __msg("unreachable insn 1")
+__msg_unpriv("back-edge")
+__naked void loop_back_edge(void)
+{
+	asm volatile ("					\
+l0_%=:	goto l0_%=;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("loop2 (back-edge)")
+__failure __msg("unreachable insn 4")
+__msg_unpriv("back-edge")
+__naked void loop2_back_edge(void)
+{
+	asm volatile ("					\
+l0_%=:	r1 = r0;					\
+	r2 = r0;					\
+	r3 = r0;					\
+	goto l0_%=;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("conditional loop")
+__failure __msg("infinite loop detected")
+__msg_unpriv("back-edge")
+__naked void conditional_loop(void)
+{
+	asm volatile ("					\
+	r0 = r1;					\
+l0_%=:	r2 = r0;					\
+	r3 = r0;					\
+	if r1 == 0 goto l0_%=;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/cfg.c b/tools/testing/selftests/bpf/verifier/cfg.c
deleted file mode 100644
index 4eb76ed739ce..000000000000
--- a/tools/testing/selftests/bpf/verifier/cfg.c
+++ /dev/null
@@ -1,73 +0,0 @@
-{
-	"unreachable",
-	.insns = {
-	BPF_EXIT_INSN(),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "unreachable",
-	.result = REJECT,
-},
-{
-	"unreachable2",
-	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "unreachable",
-	.result = REJECT,
-},
-{
-	"out of range jump",
-	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "jump out of range",
-	.result = REJECT,
-},
-{
-	"out of range jump2",
-	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, -2),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "jump out of range",
-	.result = REJECT,
-},
-{
-	"loop (back-edge)",
-	.insns = {
-	BPF_JMP_IMM(BPF_JA, 0, 0, -1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "unreachable insn 1",
-	.errstr_unpriv = "back-edge",
-	.result = REJECT,
-},
-{
-	"loop2 (back-edge)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -4),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "unreachable insn 4",
-	.errstr_unpriv = "back-edge",
-	.result = REJECT,
-},
-{
-	"conditional loop",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -3),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "infinite loop detected",
-	.errstr_unpriv = "back-edge",
-	.result = REJECT,
-},
-- 
2.40.0

