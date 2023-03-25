Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398D96C8A7F
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjCYC46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjCYC44 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA0F1B324
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v1so3521331wrv.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4oW0JwNogQCNfzqE6zaDTTVyaUxQaeJq8d46W//qx8=;
        b=kvtLaLPt+53W8BBO5nkqVLX0pBUhpqDUR9bTnaxwj1YufJNKRVhlMFHUTVyrF/qLhT
         P78Wd1G0r2BPZ+76tOTSv6FRU6bMJoEAwvnPUkbuvuG/QrgkRG5M5k2rUdbcspWlBfjN
         CBHyjlkSQPOvGXidluG1XD2Ew4j/ORpOYeHjsOaglJmassxXLWo/ZYARsXorofPZtyya
         /g/4YLZ6eKwSb8tFuiuvp026B+aI9wa7TFttz0rdDGQ2Nm08WxNKkSKHMrfVeg4Q5Z2J
         SXAE932Mld31UA375xF2HCfjuXhdxKSnyUnFPIit9bu9JG9ZgOqLNv4v9v43/+wiZBfp
         vIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4oW0JwNogQCNfzqE6zaDTTVyaUxQaeJq8d46W//qx8=;
        b=c6D0nPGixYsrzfOMirr5ZGWQdyCnXLHzdqH21JJSifmiYrRs9HXLLteXaQ5rYy2c35
         JayRaPEvlqf7qqk1Ua8kCc38043RtEoyS6sZAdTeDBk2G+ZY2ph5UC7wGMrP4jCW8bDJ
         AuyFRTdnEX2kF2IUeVQozHG4ya9uie36Okexzm1trikMPUhIkij+JtP0wcI4T6gXdamk
         Z9Kr7nHVGpSmN+Yc+3BIy2nK8wEAHRyqO20mCj2hT6dJGZaUtF/Tm/3aEnyO65oglMIt
         Z4hxsYweX2pqGXX//a4ScezufJewONN4Blfa/tWJETH4eeEGuf3Xj2e8wzW4/wwPmrsq
         eyXA==
X-Gm-Message-State: AAQBX9cvPg1ePvvyBLZ1BE0tQHmQXo61fhL44cShpoGPv9D3xjYuEN+T
        0JxRN7WmdJ8+EmHU1f9eP5BQdg50Fzg=
X-Google-Smtp-Source: AKy350bqmWb3RvFZCyHSSTBl7TtbOm5reD9e6L1dvzs5v5D0rhBMraXFng60juS5JasnPIkGuOQkTA==
X-Received: by 2002:a5d:4b42:0:b0:2c5:5349:22c1 with SMTP id w2-20020a5d4b42000000b002c5534922c1mr6264212wrs.5.1679713002817;
        Fri, 24 Mar 2023 19:56:42 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:42 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 36/43] selftests/bpf: verifier/uninit.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:17 +0200
Message-Id: <20230325025524.144043-37-eddyz87@gmail.com>
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

Test verifier/uninit.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_uninit.c     | 61 +++++++++++++++++++
 tools/testing/selftests/bpf/verifier/uninit.c | 39 ------------
 3 files changed, 63 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_uninit.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/uninit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index ce1ca8c0c02e..c6e69b3827dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -33,6 +33,7 @@
 #include "verifier_ringbuf.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_stack_ptr.skel.h"
+#include "verifier_uninit.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -88,3 +89,4 @@ void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
+void test_verifier_uninit(void)               { RUN(verifier_uninit); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_uninit.c b/tools/testing/selftests/bpf/progs/verifier_uninit.c
new file mode 100644
index 000000000000..7718cd7d19ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_uninit.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/uninit.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("read uninitialized register")
+__failure __msg("R2 !read_ok")
+__failure_unpriv
+__naked void read_uninitialized_register(void)
+{
+	asm volatile ("					\
+	r0 = r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("read invalid register")
+__failure __msg("R15 is invalid")
+__failure_unpriv
+__naked void read_invalid_register(void)
+{
+	asm volatile ("					\
+	.8byte %[mov64_reg];				\
+	exit;						\
+"	:
+	: __imm_insn(mov64_reg, BPF_MOV64_REG(BPF_REG_0, -1))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("program doesn't init R0 before exit")
+__failure __msg("R0 !read_ok")
+__failure_unpriv
+__naked void t_init_r0_before_exit(void)
+{
+	asm volatile ("					\
+	r2 = r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("program doesn't init R0 before exit in all branches")
+__failure __msg("R0 !read_ok")
+__msg_unpriv("R1 pointer comparison")
+__naked void before_exit_in_all_branches(void)
+{
+	asm volatile ("					\
+	if r1 >= 0 goto l0_%=;				\
+	r0 = 1;						\
+	r0 += 2;					\
+l0_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/uninit.c b/tools/testing/selftests/bpf/verifier/uninit.c
deleted file mode 100644
index 987a5871ff1d..000000000000
--- a/tools/testing/selftests/bpf/verifier/uninit.c
+++ /dev/null
@@ -1,39 +0,0 @@
-{
-	"read uninitialized register",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R2 !read_ok",
-	.result = REJECT,
-},
-{
-	"read invalid register",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_0, -1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R15 is invalid",
-	.result = REJECT,
-},
-{
-	"program doesn't init R0 before exit",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R0 !read_ok",
-	.result = REJECT,
-},
-{
-	"program doesn't init R0 before exit in all branches",
-	.insns = {
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R0 !read_ok",
-	.errstr_unpriv = "R1 pointer comparison",
-	.result = REJECT,
-},
-- 
2.40.0

