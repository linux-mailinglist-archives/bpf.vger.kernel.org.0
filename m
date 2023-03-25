Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8410B6C8A6C
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjCYC4V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCYC4U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50245168B7
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso2015327wmo.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4azhjNKyTXZXBFu6oHCLnAxASZfct4z5pEJQmTL55Nc=;
        b=BmjMMJUc5PiDz3IzBch9H9p44LeszYkBwwP8lGQjfvjnMivsu/RfkUdQAkSVzTKofo
         /oCkNnMjXSS9OBNQuzKtuRKZU8dqsw0uB6WJ0yBVt8GJhovZbS2YiUTKyOFSixLYoI/2
         D1Fzof9fgng43YeY3ro4EO9jvxBVvYyg5pZKsaBnGTi8QsLoLEEsGoXIepGS7vLB3OTZ
         V8dKz5EvuwhRVFk5Nkof7tnNBbq14mG+HUudw5+9bm+HaY6SbPjrZNwwG/LqukboqafF
         wdO6XA26sh/Vi1My3NSc4NGToDRgccqerjyilffzV/JJhCzyvZ0flbQEn/qYGm/+WB8Y
         RQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4azhjNKyTXZXBFu6oHCLnAxASZfct4z5pEJQmTL55Nc=;
        b=y25L/egBMg6P3Vygn60XLskikakN0BkLur9fvrOd83/ByT4sulW+BeDO/AOTVeW7g8
         xclfpMGRsBQU3G2QEn0QCWBC1n6nMKf61Tvcr2+ahfJbVxWEP4J5uaCgb+JTCFxUMl/3
         Otr3BsemUdCyb+TPSelL85hWMj9ZRsBopXO01Buzzv7sCB1Lik9qZoojed5SQ/bwIZHy
         58SUSbkeNv2Jr3XhlZZZzi1JaGC5v9av6a8dxBqhQmfwQ2SOMSFMGfCuUYAJ2IoRVMsj
         SexkK+Yc+s6vA/E2KPItLvdnexY8KAXsl8MUehPWxwIWI1Z0/G95ThRAr1+nA5IwJKDL
         tzNw==
X-Gm-Message-State: AO0yUKWjYghq2ghiWEoPGfQjs2QJ3KbnGwYA9RoMUqkrKTv6zV73FOjL
        12CrK/hshI+NZLkK1SIHFrFvhB7ieeY=
X-Google-Smtp-Source: AK7set/pcdltkgFrn3/PkdF8QGJVSFYQSKTkrgsQegWNk1hO85PD2gSE0aWkom6TSb4d1IEuXVDVmw==
X-Received: by 2002:a05:600c:3595:b0:3ee:f91:19aa with SMTP id p21-20020a05600c359500b003ee0f9119aamr6457728wmq.0.1679712977495;
        Fri, 24 Mar 2023 19:56:17 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:16 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 17/43] selftests/bpf: verifier/direct_stack_access_wraparound.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:58 +0200
Message-Id: <20230325025524.144043-18-eddyz87@gmail.com>
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

Test verifier/direct_stack_access_wraparound.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../verifier_direct_stack_access_wraparound.c | 56 +++++++++++++++++++
 .../verifier/direct_stack_access_wraparound.c | 40 -------------
 3 files changed, 58 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/direct_stack_access_wraparound.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 29351c774ee2..8c33b8792a0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -14,6 +14,7 @@
 #include "verifier_cgroup_storage.skel.h"
 #include "verifier_const_or.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
+#include "verifier_direct_stack_access_wraparound.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -50,3 +51,4 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
+void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c b/tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c
new file mode 100644
index 000000000000..c538c6893552
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/direct_stack_access_wraparound.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("direct stack access with 32-bit wraparound. test1")
+__failure __msg("fp pointer and 2147483647")
+__failure_unpriv
+__naked void with_32_bit_wraparound_test1(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += 0x7fffffff;				\
+	r1 += 0x7fffffff;				\
+	w0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("direct stack access with 32-bit wraparound. test2")
+__failure __msg("fp pointer and 1073741823")
+__failure_unpriv
+__naked void with_32_bit_wraparound_test2(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += 0x3fffffff;				\
+	r1 += 0x3fffffff;				\
+	w0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("direct stack access with 32-bit wraparound. test3")
+__failure __msg("fp pointer offset 1073741822")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void with_32_bit_wraparound_test3(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += 0x1fffffff;				\
+	r1 += 0x1fffffff;				\
+	w0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/direct_stack_access_wraparound.c b/tools/testing/selftests/bpf/verifier/direct_stack_access_wraparound.c
deleted file mode 100644
index 698e3779fdd2..000000000000
--- a/tools/testing/selftests/bpf/verifier/direct_stack_access_wraparound.c
+++ /dev/null
@@ -1,40 +0,0 @@
-{
-	"direct stack access with 32-bit wraparound. test1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0x7fffffff),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0x7fffffff),
-	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "fp pointer and 2147483647",
-	.result = REJECT
-},
-{
-	"direct stack access with 32-bit wraparound. test2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0x3fffffff),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0x3fffffff),
-	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "fp pointer and 1073741823",
-	.result = REJECT
-},
-{
-	"direct stack access with 32-bit wraparound. test3",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0x1fffffff),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0x1fffffff),
-	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "fp pointer offset 1073741822",
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.result = REJECT
-},
-- 
2.40.0

