Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A76EB0E5
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjDURnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjDURnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237BD7299
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso57651635e9.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098984; x=1684690984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjSfMSsA0BhMtkvdtPTQKu8q0hhIRVZqcFrrmVXoS9U=;
        b=QyxeTPi8+r8OjTNJXSel8dyIMrKkmAQL1xySk8Nwtw+clxaKPmjcHIeH5/AVD8gKY0
         yMuLnDsXC4tuck636ZagQYzdTFpmX6mcDqh2YrnEOSp5BBMr2IjPtV8qN9pGIxxI7Tur
         Ai87RnG4T9bIO5IkfMpbJNFmavwWZu+1PsXqyjE01teRglO2cLw9jhhRshwtCyQKnFy8
         UzHZUXf9OSDIPiInqeMVv4958EqVal0p0JcSJFWkVZlWeAG4bt9yTymsJVqq2ZvXBYEg
         LDQc3GotWC0MkFAWCBV3AYt2haJwbtsPg78jSwg7AJX4qI5xZpi0RJ/Sr/N8MLRqte8D
         wm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098984; x=1684690984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjSfMSsA0BhMtkvdtPTQKu8q0hhIRVZqcFrrmVXoS9U=;
        b=fgThRqkF+8EAuHsBm9o9Atqmin8eTLSBs8raOkRCmDFFFEkkWrQXE46C8xf7DIrgz5
         QsEijG+52bcWdLV8uYPZkHnzrTIyk1H+yN8zgSmEVaS/qhU/cIL7vhTRfDtAZ/CyPXU8
         3RQ+q2znz6ifKdFn8xJ3hGXcAWhNCJz3gLrIip7qbvCC1ZYysyTteD9c3WJ2/h39Xedz
         uWm57KGGUdIM1I+NKoMfwp02+Bknihc/OqkN7FarsqRnyBzURYAmV0vsRDRghRb8fSrl
         6m5891MUZL8uaxIpMmq7pZThUxmGvsHEmLL6Slni+ET4spIYY+KQQ8gn2wOlkvGtK/0o
         pe7g==
X-Gm-Message-State: AAQBX9dRjsVC3IlutHmlFudM7SL21r+wydMnNBg8ZA9vcBC6B1lVqIxx
        VNukqiOBdUD5TL9ShhOIK0VOkv3LnJZ9yQ==
X-Google-Smtp-Source: AKy350YhqYb4HV/Muy968ruxiqiX7iSMqDenortmU9X4tQGsgjSSgYoEKk8xStNv55fSYyNO+JIHZQ==
X-Received: by 2002:a5d:414c:0:b0:2fa:d00d:cab8 with SMTP id c12-20020a5d414c000000b002fad00dcab8mr4485324wrq.18.1682098984279;
        Fri, 21 Apr 2023 10:43:04 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:03 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 16/24] selftests/bpf: verifier/regalloc converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:26 +0300
Message-Id: <20230421174234.2391278-17-eddyz87@gmail.com>
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

Test verifier/regalloc automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_regalloc.c   | 364 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/regalloc.c | 277 -------------
 3 files changed, 366 insertions(+), 277 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_regalloc.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/regalloc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 5941ef59ed76..f0b9b74c43d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -46,6 +46,7 @@
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"
 #include "verifier_ref_tracking.skel.h"
+#include "verifier_regalloc.skel.h"
 #include "verifier_ringbuf.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_stack_ptr.skel.h"
@@ -134,6 +135,7 @@ void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
 void test_verifier_ref_tracking(void)         { RUN(verifier_ref_tracking); }
+void test_verifier_regalloc(void)             { RUN(verifier_regalloc); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_regalloc.c b/tools/testing/selftests/bpf/progs/verifier_regalloc.c
new file mode 100644
index 000000000000..ee5ddea87c91
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_regalloc.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/regalloc.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define MAX_ENTRIES 11
+
+struct test_val {
+	unsigned int index;
+	int foo[MAX_ENTRIES];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+SEC("tracepoint")
+__description("regalloc basic")
+__success __flag(BPF_F_ANY_ALIGNMENT)
+__naked void regalloc_basic(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	if r0 s> 20 goto l0_%=;				\
+	if r2 s< 0 goto l0_%=;				\
+	r7 += r0;					\
+	r7 += r2;					\
+	r0 = *(u64*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc negative")
+__failure __msg("invalid access to map value, value_size=48 off=48 size=1")
+__naked void regalloc_negative(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	if r0 s> 24 goto l0_%=;				\
+	if r2 s< 0 goto l0_%=;				\
+	r7 += r0;					\
+	r7 += r2;					\
+	r0 = *(u8*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc src_reg mark")
+__success __flag(BPF_F_ANY_ALIGNMENT)
+__naked void regalloc_src_reg_mark(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	if r0 s> 20 goto l0_%=;				\
+	r3 = 0;						\
+	if r3 s>= r2 goto l0_%=;			\
+	r7 += r0;					\
+	r7 += r2;					\
+	r0 = *(u64*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc src_reg negative")
+__failure __msg("invalid access to map value, value_size=48 off=44 size=8")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void regalloc_src_reg_negative(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	if r0 s> 22 goto l0_%=;				\
+	r3 = 0;						\
+	if r3 s>= r2 goto l0_%=;			\
+	r7 += r0;					\
+	r7 += r2;					\
+	r0 = *(u64*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc and spill")
+__success __flag(BPF_F_ANY_ALIGNMENT)
+__naked void regalloc_and_spill(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	if r0 s> 20 goto l0_%=;				\
+	/* r0 has upper bound that should propagate into r2 */\
+	*(u64*)(r10 - 8) = r2;		/* spill r2 */	\
+	r0 = 0;						\
+	r2 = 0;				/* clear r0 and r2 */\
+	r3 = *(u64*)(r10 - 8);		/* fill r3 */	\
+	if r0 s>= r3 goto l0_%=;			\
+	/* r3 has lower and upper bounds */		\
+	r7 += r3;					\
+	r0 = *(u64*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc and spill negative")
+__failure __msg("invalid access to map value, value_size=48 off=48 size=8")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void regalloc_and_spill_negative(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	if r0 s> 48 goto l0_%=;				\
+	/* r0 has upper bound that should propagate into r2 */\
+	*(u64*)(r10 - 8) = r2;		/* spill r2 */	\
+	r0 = 0;						\
+	r2 = 0;				/* clear r0 and r2 */\
+	r3 = *(u64*)(r10 - 8);		/* fill r3 */\
+	if r0 s>= r3 goto l0_%=;			\
+	/* r3 has lower and upper bounds */		\
+	r7 += r3;					\
+	r0 = *(u64*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc three regs")
+__success __flag(BPF_F_ANY_ALIGNMENT)
+__naked void regalloc_three_regs(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	r4 = r2;					\
+	if r0 s> 12 goto l0_%=;				\
+	if r2 s< 0 goto l0_%=;				\
+	r7 += r0;					\
+	r7 += r2;					\
+	r7 += r4;					\
+	r0 = *(u64*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc after call")
+__success __flag(BPF_F_ANY_ALIGNMENT)
+__naked void regalloc_after_call(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r8 = r0;					\
+	r9 = r0;					\
+	call regalloc_after_call__1;			\
+	if r8 s> 20 goto l0_%=;				\
+	if r9 s< 0 goto l0_%=;				\
+	r7 += r8;					\
+	r7 += r9;					\
+	r0 = *(u64*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void regalloc_after_call__1(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc in callee")
+__success __flag(BPF_F_ANY_ALIGNMENT)
+__naked void regalloc_in_callee(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r2 = r0;					\
+	r3 = r7;					\
+	call regalloc_in_callee__1;			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void regalloc_in_callee__1(void)
+{
+	asm volatile ("					\
+	if r1 s> 20 goto l0_%=;				\
+	if r2 s< 0 goto l0_%=;				\
+	r3 += r1;					\
+	r3 += r2;					\
+	r0 = *(u64*)(r3 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("regalloc, spill, JEQ")
+__success
+__naked void regalloc_spill_jeq(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	*(u64*)(r10 - 8) = r0;		/* spill r0 */	\
+	if r0 == 0 goto l0_%=;				\
+l0_%=:	/* The verifier will walk the rest twice with r0 == 0 and r0 == map_value */\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	if r2 == 20 goto l1_%=;				\
+l1_%=:	/* The verifier will walk the rest two more times with r0 == 20 and r0 == unknown */\
+	r3 = *(u64*)(r10 - 8);		/* fill r3 with map_value */\
+	if r3 == 0 goto l2_%=;		/* skip ldx if map_value == NULL */\
+	/* Buggy verifier will think that r3 == 20 here */\
+	r0 = *(u64*)(r3 + 0);		/* read from map_value */\
+l2_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/regalloc.c b/tools/testing/selftests/bpf/verifier/regalloc.c
deleted file mode 100644
index bb0dd89dd212..000000000000
--- a/tools/testing/selftests/bpf/verifier/regalloc.c
+++ /dev/null
@@ -1,277 +0,0 @@
-{
-	"regalloc basic",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 20, 4),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"regalloc negative",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 24, 4),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=48 off=48 size=1",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"regalloc src_reg mark",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 20, 5),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_3, BPF_REG_2, 3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"regalloc src_reg negative",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 22, 5),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_3, BPF_REG_2, 3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=48 off=44 size=8",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"regalloc and spill",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 20, 7),
-	/* r0 has upper bound that should propagate into r2 */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8), /* spill r2 */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 0), /* clear r0 and r2 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_10, -8), /* fill r3 */
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_0, BPF_REG_3, 2),
-	/* r3 has lower and upper bounds */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_3),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"regalloc and spill negative",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 48, 7),
-	/* r0 has upper bound that should propagate into r2 */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8), /* spill r2 */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 0), /* clear r0 and r2 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_10, -8), /* fill r3 */
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_0, BPF_REG_3, 2),
-	/* r3 has lower and upper bounds */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_3),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=48 off=48 size=8",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"regalloc three regs",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 12, 5),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_4),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"regalloc after call",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 6),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 20, 4),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_9, 0, 3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_8),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_9),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"regalloc in callee",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 20, 5),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_2, 0, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_2),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"regalloc, spill, JEQ",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8), /* spill r0 */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 0),
-	/* The verifier will walk the rest twice with r0 == 0 and r0 == map_value */
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 20, 0),
-	/* The verifier will walk the rest two more times with r0 == 20 and r0 == unknown */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_10, -8), /* fill r3 with map_value */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 1), /* skip ldx if map_value == NULL */
-	/* Buggy verifier will think that r3 == 20 here */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0), /* read from map_value */
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-- 
2.40.0

