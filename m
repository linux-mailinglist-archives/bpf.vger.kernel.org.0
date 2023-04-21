Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8136EB0F2
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjDURnv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjDURnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4F270E
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2f7a7f9667bso1276923f8f.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098990; x=1684690990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyXRXmKqnvh14RGqw8EvB0M/Pe2v+ptpbOPsZY7xPVM=;
        b=aAS33BDT3ZtvarFhX4BFQBWRlGIAfJ7cRfe00jfniiDLafzCBSxt6RhZQdvTRjcxDj
         9hqE2v+dr7C/5c29YEERKWKfUoFm+uKu4YupBgkpCc/UniwgL2FihGEKLxCFazpfB53u
         mnoxOcpxJZzG+vhUJm0o0z5dtor5uF1OboYz/Q7SdwfAAm8wQJiMW9qUnJO09XXpEClT
         chM9Hqm6WjALiik7eKuvdjBybggCgJhr8uE4PMPuvGC29p05FrJvPgkNq4Uw5vsSy/+r
         jcWoU5DvBzSzOKRMErHIXavTxEKSaZqqoxqY1zqgpQl3IMYFqzIpmb4UAiB8D6n/kYWr
         4j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098990; x=1684690990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyXRXmKqnvh14RGqw8EvB0M/Pe2v+ptpbOPsZY7xPVM=;
        b=EU3qL3ZNUA3l0Pz1goxKBNq9d2e90EcJoYeVbzpYhphojJyyDlD0kO2P+cwQzeZKdc
         LxVJAPpsCnpZRxS6s70jvhj6WiKbkSXUAiSSUU4AOJYE15AAterY9uMMFJ0ADP7+DjRv
         hUftSUT41RVwaALXmKL+bi53Ykc7hAGY+AC5cOibW2O/SxcLPiFp1hFD2AQdLW0dMvlg
         pqqWP0JF9HHTPapFTcuk5jGegxM78PNDgO3Q4a4neErtwFozWZ+N/6EG1UjmfXRoHzrL
         omsUsCqAZDMQlZPdwX+UfQEgJjm3sWkboOgPlVrzA/hSRCgPXCucEOEtURITD2UFim7N
         Tnzw==
X-Gm-Message-State: AAQBX9d5DBK3LYncV3W9VY6GKyCD4HgS+dU08Ch3B8cRBQG2AX5rJ3at
        jUheJS+yxZqYte8T++pmW1BmYf0PvKJY9w==
X-Google-Smtp-Source: AKy350bjKHvqyYrKAzeTzZgmaSOCGGdMiU+nvhuIx8vsBZ1/L4KF6OKk3ecEm0v2FiICzR0t+H01Ug==
X-Received: by 2002:a5d:4c4d:0:b0:2cf:e747:b0d4 with SMTP id n13-20020a5d4c4d000000b002cfe747b0d4mr4802589wrt.40.1682098990038;
        Fri, 21 Apr 2023 10:43:10 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:09 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 21/24] selftests/bpf: verifier/subreg converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:31 +0300
Message-Id: <20230421174234.2391278-22-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/subreg automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_subreg.c     | 673 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/subreg.c | 533 --------------
 3 files changed, 675 insertions(+), 533 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subreg.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/subreg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 0ea88282859d..999b694850d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -54,6 +54,7 @@
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
 #include "verifier_stack_ptr.skel.h"
+#include "verifier_subreg.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
@@ -147,6 +148,7 @@ void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
+void test_verifier_subreg(void)               { RUN(verifier_subreg); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
new file mode 100644
index 000000000000..8613ea160dcd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/subreg.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* This file contains sub-register zero extension checks for insns defining
+ * sub-registers, meaning:
+ *   - All insns under BPF_ALU class. Their BPF_ALU32 variants or narrow width
+ *     forms (BPF_END) could define sub-registers.
+ *   - Narrow direct loads, BPF_B/H/W | BPF_LDX.
+ *   - BPF_LD is not exposed to JIT back-ends, so no need for testing.
+ *
+ * "get_prandom_u32" is used to initialize low 32-bit of some registers to
+ * prevent potential optimizations done by verifier or JIT back-ends which could
+ * optimize register back into constant when range info shows one register is a
+ * constant.
+ */
+
+SEC("socket")
+__description("add32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void add32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = 0x100000000 ll;				\
+	w0 += w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("add32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void add32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	/* An insn could have no effect on the low 32-bit, for example:\
+	 *   a = a + 0					\
+	 *   a = a | 0					\
+	 *   a = a & -1					\
+	 * But, they should still zero high 32-bit.	\
+	 */						\
+	w0 += 0;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 += -2;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sub32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void sub32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = 0x1ffffffff ll;				\
+	w0 -= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sub32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void sub32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 -= 0;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 -= 1;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("mul32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void mul32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = 0x100000001 ll;				\
+	w0 *= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("mul32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void mul32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 *= 1;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 *= -1;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("div32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void div32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = -1;					\
+	w0 /= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("div32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void div32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 /= 1;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 /= 2;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("or32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void or32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = 0x100000001 ll;				\
+	w0 |= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("or32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void or32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 |= 0;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 |= 1;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("and32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void and32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x100000000 ll;				\
+	r1 |= r0;					\
+	r0 = 0x1ffffffff ll;				\
+	w0 &= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("and32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void and32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 &= -1;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 &= -2;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("lsh32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void lsh32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x100000000 ll;				\
+	r0 |= r1;					\
+	r1 = 1;						\
+	w0 <<= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("lsh32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void lsh32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 <<= 0;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 <<= 1;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("rsh32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void rsh32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	r1 = 1;						\
+	w0 >>= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("rsh32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void rsh32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 >>= 0;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 >>= 1;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("neg32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void neg32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 = -w0;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("mod32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void mod32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = -1;					\
+	w0 %%= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("mod32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void mod32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 %%= 1;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 %%= 2;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("xor32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void xor32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = 0x100000000 ll;				\
+	w0 ^= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("xor32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void xor32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 ^= 1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("mov32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void mov32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x100000000 ll;				\
+	r1 |= r0;					\
+	r0 = 0x100000000 ll;				\
+	w0 = w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("mov32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void mov32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 = 0;						\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 = 1;						\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("arsh32 reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void arsh32_reg_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	r1 = 1;						\
+	w0 s>>= w1;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("arsh32 imm zero extend check")
+__success __success_unpriv __retval(0)
+__naked void arsh32_imm_zero_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 s>>= 0;					\
+	r0 >>= 32;					\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w0 s>>= 1;					\
+	r0 >>= 32;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("end16 (to_le) reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void le_reg_zero_extend_check_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 <<= 32;					\
+	call %[bpf_get_prandom_u32];			\
+	r0 |= r6;					\
+	r0 = le16 r0;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("end32 (to_le) reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void le_reg_zero_extend_check_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 <<= 32;					\
+	call %[bpf_get_prandom_u32];			\
+	r0 |= r6;					\
+	r0 = le32 r0;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("end16 (to_be) reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void be_reg_zero_extend_check_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 <<= 32;					\
+	call %[bpf_get_prandom_u32];			\
+	r0 |= r6;					\
+	r0 = be16 r0;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("end32 (to_be) reg zero extend check")
+__success __success_unpriv __retval(0)
+__naked void be_reg_zero_extend_check_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 <<= 32;					\
+	call %[bpf_get_prandom_u32];			\
+	r0 |= r6;					\
+	r0 = be32 r0;					\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ldx_b zero extend check")
+__success __success_unpriv __retval(0)
+__naked void ldx_b_zero_extend_check(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -4;					\
+	r7 = 0xfaceb00c;				\
+	*(u32*)(r6 + 0) = r7;				\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	r0 = *(u8*)(r6 + 0);				\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ldx_h zero extend check")
+__success __success_unpriv __retval(0)
+__naked void ldx_h_zero_extend_check(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -4;					\
+	r7 = 0xfaceb00c;				\
+	*(u32*)(r6 + 0) = r7;				\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	r0 = *(u16*)(r6 + 0);				\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ldx_w zero extend check")
+__success __success_unpriv __retval(0)
+__naked void ldx_w_zero_extend_check(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -4;					\
+	r7 = 0xfaceb00c;				\
+	*(u32*)(r6 + 0) = r7;				\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	r0 = *(u32*)(r6 + 0);				\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/subreg.c b/tools/testing/selftests/bpf/verifier/subreg.c
deleted file mode 100644
index 4c4133c80440..000000000000
--- a/tools/testing/selftests/bpf/verifier/subreg.c
+++ /dev/null
@@ -1,533 +0,0 @@
-/* This file contains sub-register zero extension checks for insns defining
- * sub-registers, meaning:
- *   - All insns under BPF_ALU class. Their BPF_ALU32 variants or narrow width
- *     forms (BPF_END) could define sub-registers.
- *   - Narrow direct loads, BPF_B/H/W | BPF_LDX.
- *   - BPF_LD is not exposed to JIT back-ends, so no need for testing.
- *
- * "get_prandom_u32" is used to initialize low 32-bit of some registers to
- * prevent potential optimizations done by verifier or JIT back-ends which could
- * optimize register back into constant when range info shows one register is a
- * constant.
- */
-{
-	"add32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
-	BPF_ALU32_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"add32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	/* An insn could have no effect on the low 32-bit, for example:
-	 *   a = a + 0
-	 *   a = a | 0
-	 *   a = a & -1
-	 * But, they should still zero high 32-bit.
-	 */
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, -2),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"sub32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_IMM64(BPF_REG_0, 0x1ffffffffULL),
-	BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"sub32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_SUB, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_SUB, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"mul32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
-	BPF_ALU32_REG(BPF_MUL, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"mul32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, -1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"div32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_ALU32_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"div32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_DIV, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_DIV, BPF_REG_0, 2),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"or32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
-	BPF_ALU32_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"or32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_OR, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_OR, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"and32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x100000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_1, BPF_REG_0),
-	BPF_LD_IMM64(BPF_REG_0, 0x1ffffffffULL),
-	BPF_ALU32_REG(BPF_AND, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"and32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_AND, BPF_REG_0, -1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_AND, BPF_REG_0, -2),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"lsh32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x100000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_ALU32_REG(BPF_LSH, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"lsh32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_LSH, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_LSH, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"rsh32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_ALU32_REG(BPF_RSH, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"rsh32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_RSH, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_RSH, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"neg32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_NEG, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"mod32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"mod32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_MOD, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_MOD, BPF_REG_0, 2),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"xor32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
-	BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"xor32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_XOR, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"mov32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x100000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_1, BPF_REG_0),
-	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
-	BPF_MOV32_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"mov32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_MOV32_IMM(BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_MOV32_IMM(BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"arsh32 reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_ALU32_REG(BPF_ARSH, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"arsh32 imm zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_ARSH, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_ARSH, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"end16 (to_le) reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_ENDIAN(BPF_TO_LE, BPF_REG_0, 16),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"end32 (to_le) reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_ENDIAN(BPF_TO_LE, BPF_REG_0, 32),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"end16 (to_be) reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_ENDIAN(BPF_TO_BE, BPF_REG_0, 16),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"end32 (to_be) reg zero extend check",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_6),
-	BPF_ENDIAN(BPF_TO_BE, BPF_REG_0, 32),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"ldx_b zero extend check",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -4),
-	BPF_ST_MEM(BPF_W, BPF_REG_6, 0, 0xfaceb00c),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"ldx_h zero extend check",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -4),
-	BPF_ST_MEM(BPF_W, BPF_REG_6, 0, 0xfaceb00c),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_6, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"ldx_w zero extend check",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -4),
-	BPF_ST_MEM(BPF_W, BPF_REG_6, 0, 0xfaceb00c),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_LD_IMM64(BPF_REG_1, 0x1000000000ULL),
-	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0,
-},
-- 
2.40.0

