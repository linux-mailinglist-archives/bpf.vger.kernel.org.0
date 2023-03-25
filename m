Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BDD6C8A78
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjCYC4q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjCYC4p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A901ADFE
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1993906wmq.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr/e6ndCSiRb7PRBR/ZbeCotzdzcJT4rJb4DjVQu1uc=;
        b=H32oapEmNz9SzAoTnPLSg5+rG1FSUQWMUqhWK0xNTRCEQswwZVDNfOvijbTSthFcmN
         rD9aIfYAFHDR5ac095rHD4S9sXMF2Q0lUIMZe54CoZaJBSuskF03GsAGtixqgW0VbLhc
         i6+stqqGQ0AEFleFRzeHjzd9eorSstUX1kHwsHqeo6vkWdhTUKmX7utg0NzUlnhhjNDw
         UoU6FBTlfdfR6SSXdNqAJM9AP1p2Uk2FP4clZ2Y6ExOacglf0wt/yqkf5CWUteDjbp66
         sIT8cju+Pk79gOUPxlH8xGPqNrsnY6m09IGWzBO0ZzgkUySScDlUdwpL7Y/45hGbmR5q
         u5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr/e6ndCSiRb7PRBR/ZbeCotzdzcJT4rJb4DjVQu1uc=;
        b=VQ05TrRJuKl8xIN7JwIiqSoMLFJzOBQIbulIJJufiDgUCOBeqBKkns2NihN2g+6NhJ
         tUMX9aM4FH90v7LbYkfZaOQpLkSPQYfTxw6XUxaM0wL9j1nsvaQuQ19jZx94fqrGZE+K
         DLoGL3CZD1r+gMKfFqVewTTtFfbLSk0WE2ywbJ3DYXmeNUIvcU+089g39qvlJCqKamIS
         +Np4sey7k2OJ5JMghSJW+uRu39EAAw5DIZIZ4O7zSewJ4IcyfqmogQMMxZQ/7Js9KN2b
         /drfaA3X7nK6At0JT6QSQ0etnd4vPlWOfmXPwaMM7IQnCB/48i7QM0UjXQstbNumI/Od
         4OnA==
X-Gm-Message-State: AO0yUKUUWNhwnC1j14DozI+ufZEmx3nfgz8kiNnENy1HMilefg4afuyd
        oBr02VK9Dq35X0+Vv5xaoOHwTHCRXSk=
X-Google-Smtp-Source: AK7set+9QoSANP0dt0u7xaj1/NXW6TXmgkoZZzkI6wZJVDEopVw794iIA2vi/ac0t+gGOLQ3MpPf/Q==
X-Received: by 2002:a05:600c:20f:b0:3eb:5ab3:b6d0 with SMTP id 15-20020a05600c020f00b003eb5ab3b6d0mr3915426wmi.6.1679712993119;
        Fri, 24 Mar 2023 19:56:33 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:32 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 29/43] selftests/bpf: verifier/masking.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:10 +0200
Message-Id: <20230325025524.144043-30-eddyz87@gmail.com>
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

Test verifier/masking.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_masking.c    | 410 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/masking.c  | 322 --------------
 3 files changed, 412 insertions(+), 322 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_masking.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/masking.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 5131a73fd225..b23fcbe4f83b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -26,6 +26,7 @@
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_map_ptr.skel.h"
 #include "verifier_map_ret_val.skel.h"
+#include "verifier_masking.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -74,3 +75,4 @@ void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
+void test_verifier_masking(void)              { RUN(verifier_masking); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_masking.c b/tools/testing/selftests/bpf/progs/verifier_masking.c
new file mode 100644
index 000000000000..5732cc1b4c47
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_masking.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/masking.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("masking, test out of bounds 1")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_1(void)
+{
+	asm volatile ("					\
+	w1 = 5;						\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 5 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 2")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_2(void)
+{
+	asm volatile ("					\
+	w1 = 1;						\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 1 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 3")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_3(void)
+{
+	asm volatile ("					\
+	w1 = 0xffffffff;				\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0xffffffff - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 4")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_4(void)
+{
+	asm volatile ("					\
+	w1 = 0xffffffff;				\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 1 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 5")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_5(void)
+{
+	asm volatile ("					\
+	w1 = -1;					\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 1 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 6")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_6(void)
+{
+	asm volatile ("					\
+	w1 = -1;					\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0xffffffff - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 7")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_7(void)
+{
+	asm volatile ("					\
+	r1 = 5;						\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 5 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 8")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_8(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 1 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 9")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_9(void)
+{
+	asm volatile ("					\
+	r1 = 0xffffffff;				\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0xffffffff - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 10")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_10(void)
+{
+	asm volatile ("					\
+	r1 = 0xffffffff;				\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 1 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 11")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_11(void)
+{
+	asm volatile ("					\
+	r1 = -1;					\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 1 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test out of bounds 12")
+__success __success_unpriv __retval(0)
+__naked void test_out_of_bounds_12(void)
+{
+	asm volatile ("					\
+	r1 = -1;					\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0xffffffff - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test in bounds 1")
+__success __success_unpriv __retval(4)
+__naked void masking_test_in_bounds_1(void)
+{
+	asm volatile ("					\
+	w1 = 4;						\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 5 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test in bounds 2")
+__success __success_unpriv __retval(0)
+__naked void masking_test_in_bounds_2(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0xffffffff - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test in bounds 3")
+__success __success_unpriv __retval(0xfffffffe)
+__naked void masking_test_in_bounds_3(void)
+{
+	asm volatile ("					\
+	w1 = 0xfffffffe;				\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0xffffffff - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test in bounds 4")
+__success __success_unpriv __retval(0xabcde)
+__naked void masking_test_in_bounds_4(void)
+{
+	asm volatile ("					\
+	w1 = 0xabcde;					\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0xabcdef - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test in bounds 5")
+__success __success_unpriv __retval(0)
+__naked void masking_test_in_bounds_5(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 1 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test in bounds 6")
+__success __success_unpriv __retval(46)
+__naked void masking_test_in_bounds_6(void)
+{
+	asm volatile ("					\
+	w1 = 46;					\
+	w2 = %[__imm_0];				\
+	r2 -= r1;					\
+	r2 |= r1;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r1 &= r2;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 47 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test in bounds 7")
+__success __success_unpriv __retval(46)
+__naked void masking_test_in_bounds_7(void)
+{
+	asm volatile ("					\
+	r3 = -46;					\
+	r3 *= -1;					\
+	w2 = %[__imm_0];				\
+	r2 -= r3;					\
+	r2 |= r3;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r3 &= r2;					\
+	r0 = r3;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 47 - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("masking, test in bounds 8")
+__success __success_unpriv __retval(0)
+__naked void masking_test_in_bounds_8(void)
+{
+	asm volatile ("					\
+	r3 = -47;					\
+	r3 *= -1;					\
+	w2 = %[__imm_0];				\
+	r2 -= r3;					\
+	r2 |= r3;					\
+	r2 = -r2;					\
+	r2 s>>= 63;					\
+	r3 &= r2;					\
+	r0 = r3;					\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 47 - 1)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/masking.c b/tools/testing/selftests/bpf/verifier/masking.c
deleted file mode 100644
index 6e1358c544fd..000000000000
--- a/tools/testing/selftests/bpf/verifier/masking.c
+++ /dev/null
@@ -1,322 +0,0 @@
-{
-	"masking, test out of bounds 1",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 5),
-	BPF_MOV32_IMM(BPF_REG_2, 5 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 2",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 1),
-	BPF_MOV32_IMM(BPF_REG_2, 1 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 3",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0xffffffff),
-	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 4",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0xffffffff),
-	BPF_MOV32_IMM(BPF_REG_2, 1 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 5",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, -1),
-	BPF_MOV32_IMM(BPF_REG_2, 1 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 6",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, -1),
-	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 7",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 5),
-	BPF_MOV32_IMM(BPF_REG_2, 5 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 8",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_MOV32_IMM(BPF_REG_2, 1 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 9",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 0xffffffff),
-	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 10",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 0xffffffff),
-	BPF_MOV32_IMM(BPF_REG_2, 1 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 11",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_MOV32_IMM(BPF_REG_2, 1 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test out of bounds 12",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test in bounds 1",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 4),
-	BPF_MOV32_IMM(BPF_REG_2, 5 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 4,
-},
-{
-	"masking, test in bounds 2",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test in bounds 3",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0xfffffffe),
-	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0xfffffffe,
-},
-{
-	"masking, test in bounds 4",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0xabcde),
-	BPF_MOV32_IMM(BPF_REG_2, 0xabcdef - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0xabcde,
-},
-{
-	"masking, test in bounds 5",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_MOV32_IMM(BPF_REG_2, 1 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"masking, test in bounds 6",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_1, 46),
-	BPF_MOV32_IMM(BPF_REG_2, 47 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 46,
-},
-{
-	"masking, test in bounds 7",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, -46),
-	BPF_ALU64_IMM(BPF_MUL, BPF_REG_3, -1),
-	BPF_MOV32_IMM(BPF_REG_2, 47 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_3),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 46,
-},
-{
-	"masking, test in bounds 8",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, -47),
-	BPF_ALU64_IMM(BPF_MUL, BPF_REG_3, -1),
-	BPF_MOV32_IMM(BPF_REG_2, 47 - 1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_3),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 63),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_3, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-- 
2.40.0

