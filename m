Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6655160B2
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 23:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbiD3WBU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Apr 2022 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245553AbiD3WBT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Apr 2022 18:01:19 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5C8527F8
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 14:57:55 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y6so6868442qke.10
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNpBpGUgYqgY5zLedqhYAkjgPBNdNPOuprlVRpNv+4U=;
        b=nr6gCzkk6vmoHjrxd96xa0mf7O1YIPhiTzJvLkKLILPPD17LgXQphBy8n5vgoL5Ms1
         vIZGlAqWyn6CpPURsH+oGj/ewAWbcYNs2xcf8F5tHw8rUGBTOR8uBsproTzES5iA9Vr4
         ++1rTXFUGCD+4bjjqZukWtab6VcoifM6sRSFKSQgy1w3rU/wgFgeN6MgV920eWglzlTF
         ZqMooB7HPZHst33nfgggiHzbZqwbuTAqu5I5FJevatT0Jm4ZlYEWz9zmv2HsleUl4cEY
         SJ4nsDUITjAaaP+SFmpFaWBCc6pLnKAMJ15gb5pGKIvlcInk0LN1LvKKWQCZaSnS0Ejh
         Eqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNpBpGUgYqgY5zLedqhYAkjgPBNdNPOuprlVRpNv+4U=;
        b=cm7TQmnhGvzcL1YawSm7QoXi7rdoePm3E8fWBPxlvc/w/zODMgPpaTGwORvLyunI1Y
         BYa4B2e+84KL8bV/nzBjq4EgBpW2DMNLQi2ax7inHDNImzhlMJ2h4meVeLdflagRWSnI
         T3/pp75dNHRH8I6436OvAJ5nAKLWy2bPTpa8pjKC/1pLTxGG7zwc8ioTlt/Vrt2BM2sS
         +RmSD0KeYRUAl9bUXGpfWUZxYq/nOutVTgRSAHD2HK8oYKlPU37eaBJcwmxLkJwGCM/6
         v+Lx0k7HxGKSM41Kcww197R5QKKAwlLEVtdXHwhtrtKJpuQIwbmZck9+4p4B8UcJ9iqO
         PhjA==
X-Gm-Message-State: AOAM5326alYnSIZCV5nwGeDh22XgDgbE7bLNVdBgrvSxXqOcqWnFoMU6
        jtaZJrmSnVE9oPXAIdH1J/LsI6xgoL8pBtbp
X-Google-Smtp-Source: ABdhPJxlRxQ3/ra1gMga2xtn26dCKY0VRzrBThQ6U9HBCPM4fNXouYPUPhGK1fmdOEAs2DINALDdZQ==
X-Received: by 2002:a05:620a:16c2:b0:69f:ca37:f6b5 with SMTP id a2-20020a05620a16c200b0069fca37f6b5mr1990226qkn.48.1651355874491;
        Sat, 30 Apr 2022 14:57:54 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-7-220-131.nyc.res.rr.com. [98.7.220.131])
        by smtp.gmail.com with ESMTPSA id a7-20020a05620a124700b0069fc13ce211sm1688286qkl.66.2022.04.30.14.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 14:57:53 -0700 (PDT)
From:   Langston Barrett <langston.barrett@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Langston Barrett <langston.barrett@gmail.com>
Subject: [PATCH] bpf: KUnit-based soundness tests for tnums
Date:   Sat, 30 Apr 2022 17:57:27 -0400
Message-Id: <20220430215727.113472-1-langston.barrett@gmail.com>
X-Mailer: git-send-email 2.33.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that check that each binary operation on tnums is a valid
abstraction of the corresponding operation on u64s. This soundness
condition is an important part of the security of eBPF.

Signed-off-by: Langston Barrett <langston.barrett@gmail.com>
---

I also made sure that these tests are meaningful by changing the tnum
operations or test conditions and ensuring that they fail when such
erroneous modifications are made.

This is my first time submitting a kernel patch. I've read through the
documentation on doing so, but apologies in advance if I've missed
something. Thank you very much for your time.

 kernel/bpf/Kconfig     |   7 ++
 kernel/bpf/Makefile    |   2 +
 kernel/bpf/tnum_test.c | 208 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 kernel/bpf/tnum_test.c

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index d56ee177d5f8..c1a726f33193 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -36,6 +36,13 @@ config BPF_SYSCALL
 	  Enable the bpf() system call that allows to manipulate BPF programs
 	  and maps via file descriptors.
 
+config BPF_TNUM_TEST
+	tristate "Enable soundness tests for BPF tnums" if !KUNIT_ALL_TESTS
+	depends on BPF_SYSCALL && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit-based soundness tests for BPF tnums.
+
 config BPF_JIT
 	bool "Enable BPF Just In Time compiler"
 	depends on BPF
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index c1a9be6a4b9f..11d88798a538 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -40,3 +40,5 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+obj-$(CONFIG_BPF_TNUM_TEST) += tnum_test.o
diff --git a/kernel/bpf/tnum_test.c b/kernel/bpf/tnum_test.c
new file mode 100644
index 000000000000..168780b648ac
--- /dev/null
+++ b/kernel/bpf/tnum_test.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Soundness tests for tnums.
+ *
+ * Its important that tnums (and other BPF verifier analyses) soundly
+ * overapproximate the runtime values of registers. If they fail to do so, then
+ * kernel memory corruption may result (see e.g., CVE-2020-8835 and
+ * CVE-2021-3490 for examples where unsound bounds tracking led to exploitable
+ * bugs).
+ *
+ * The implementations of some tnum arithmetic operations have been proven
+ * sound, see "Sound, Precise, and Fast Abstract Interpretation with Tristate
+ * Numbers" (https://arxiv.org/abs/2105.05398). These tests corroborate these
+ * results on actual machine hardware, protect against regressions if the
+ * implementations change, and provide a template for testing new abstract
+ * operations.
+ */
+
+#include <kunit/test.h>
+#include <linux/tnum.h>
+
+/* Some number of test cases, particular values not super important but chosen
+ * to be most likely to trigger edge cases.
+ */
+static u64 interesting_ints[] = { S64_MIN, S32_MIN, -1,	     0,
+				  1,	   2,	    U32_MAX, U64_MAX };
+
+typedef struct tnum (*tnum_binop_fun)(struct tnum a, struct tnum b);
+typedef u64 (*u64_binop_fun)(u64 a, u64 b);
+
+struct tnum_binop {
+	tnum_binop_fun tnum_binop;
+	u64_binop_fun u64_binop;
+};
+
+static u64 u64_add(u64 a, u64 b)
+{
+	return a + b;
+}
+static u64 u64_sub(u64 a, u64 b)
+{
+	return a - b;
+}
+static u64 u64_mul(u64 a, u64 b)
+{
+	return a * b;
+}
+static u64 u64_and(u64 a, u64 b)
+{
+	return a & b;
+}
+static u64 u64_or(u64 a, u64 b)
+{
+	return a | b;
+}
+static u64 u64_xor(u64 a, u64 b)
+{
+	return a ^ b;
+}
+
+static const struct tnum_binop ADD_BINOP = { .tnum_binop = tnum_add,
+					     .u64_binop = u64_add };
+
+static const struct tnum_binop SUB_BINOP = { .tnum_binop = tnum_sub,
+					     .u64_binop = u64_sub };
+
+static const struct tnum_binop MUL_BINOP = { .tnum_binop = tnum_mul,
+					     .u64_binop = u64_mul };
+
+static const struct tnum_binop AND_BINOP = { .tnum_binop = tnum_and,
+					     .u64_binop = u64_and };
+
+static const struct tnum_binop OR_BINOP = { .tnum_binop = tnum_or,
+					    .u64_binop = u64_or };
+
+static const struct tnum_binop XOR_BINOP = { .tnum_binop = tnum_xor,
+					     .u64_binop = u64_xor };
+
+static struct tnum *test_tnums;
+
+#define NUM_TEST_TNUMS (1 + ARRAY_SIZE(interesting_ints))
+
+/* Test setup: Generate some number of tnums to be used in test cases, store
+ * them in test_tnums.
+ */
+static int tnum_test_init(struct kunit *test)
+{
+	struct tnum *tests;
+
+	test_tnums = kunit_kmalloc_array(test, NUM_TEST_TNUMS,
+					 sizeof(struct tnum), GFP_KERNEL);
+	tests = test_tnums;
+
+	*tests = tnum_unknown;
+	tests++;
+	for (int i = 0; i < ARRAY_SIZE(interesting_ints); i++) {
+		*tests = tnum_const(interesting_ints[i]);
+		tests++;
+	}
+	return 0;
+}
+
+static void tnum_test_exit(struct kunit *test)
+{
+	kfree(test_tnums);
+}
+
+static int valid(struct tnum t)
+{
+	return (t.value & t.mask) == 0;
+}
+
+/* Check whether a number is in the set of numbers represented by a tnum. */
+static int member(struct tnum t, u64 x)
+{
+	return valid(t) ? (x & (~t.mask)) == t.value : 0;
+}
+
+static void test_tnum_valid(struct kunit *test)
+{
+	for (int i = 0; i < NUM_TEST_TNUMS; i++)
+		KUNIT_EXPECT_EQ(test, 1, valid(test_tnums[i]));
+}
+
+/* Check that a binary operation (binop) on tnums soundly overapproximates the
+ * corresponding operation on u64s.
+ *
+ * These tests are not exhaustive - they only check that applying the u64 binop
+ * in question to the minimum and maximum u64s represented by the tnum (in
+ * either order) results in a u64 that is represented by the result of the
+ * corresponding tnum binop.
+ *
+ * Also checks that each operation takes valid tnums to valid tnums.
+ */
+static void tnum_binop_test(struct kunit *test, struct tnum_binop binop)
+{
+	u64 ll;
+	u64 lu;
+	u64 ul;
+	u64 uu;
+	struct tnum x;
+	struct tnum y;
+	struct tnum result;
+
+	for (int i = 0; i < NUM_TEST_TNUMS; i++) {
+		for (int j = 0; j < NUM_TEST_TNUMS; j++) {
+			x = test_tnums[i];
+			y = test_tnums[j];
+			result = binop.tnum_binop(x, y);
+
+			KUNIT_EXPECT_EQ(test, 1, valid(result));
+
+			ll = binop.u64_binop(x.value, y.value);
+			lu = binop.u64_binop(x.value, (y.value | y.mask));
+			ul = binop.u64_binop((x.value | x.mask), y.value);
+			uu = binop.u64_binop((x.value | x.mask),
+					     (y.value | y.mask));
+			KUNIT_EXPECT_EQ(test, 1, member(result, ll));
+			KUNIT_EXPECT_EQ(test, 1, member(result, lu));
+			KUNIT_EXPECT_EQ(test, 1, member(result, ul));
+			KUNIT_EXPECT_EQ(test, 1, member(result, uu));
+		}
+	}
+}
+
+static void test_tnum_add(struct kunit *test)
+{
+	tnum_binop_test(test, ADD_BINOP);
+}
+
+static void test_tnum_sub(struct kunit *test)
+{
+	tnum_binop_test(test, SUB_BINOP);
+}
+
+static void test_tnum_mul(struct kunit *test)
+{
+	tnum_binop_test(test, MUL_BINOP);
+}
+
+static void test_tnum_and(struct kunit *test)
+{
+	tnum_binop_test(test, AND_BINOP);
+}
+
+static void test_tnum_or(struct kunit *test)
+{
+	tnum_binop_test(test, OR_BINOP);
+}
+
+static void test_tnum_xor(struct kunit *test)
+{
+	tnum_binop_test(test, XOR_BINOP);
+}
+
+static struct kunit_case tnum_test_cases[] = {
+	KUNIT_CASE(test_tnum_valid), KUNIT_CASE(test_tnum_add),
+	KUNIT_CASE(test_tnum_sub),   KUNIT_CASE(test_tnum_mul),
+	KUNIT_CASE(test_tnum_and),   KUNIT_CASE(test_tnum_or),
+	KUNIT_CASE(test_tnum_xor),   {}
+};
+
+static struct kunit_suite tnum_test_suite = {
+	.name = "tnum",
+	.init = tnum_test_init,
+	.exit = tnum_test_exit,
+	.test_cases = tnum_test_cases,
+};
+kunit_test_suite(tnum_test_suite);
-- 
2.33.3

