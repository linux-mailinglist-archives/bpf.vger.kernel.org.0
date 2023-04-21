Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72BC6EB0E9
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjDURng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjDURnY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF193F3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so18121345e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098987; x=1684690987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdlIyWD2h5iDC7/QEobaar3wvJ8iJMDcSt599XJX+L8=;
        b=Om86w3r4lapgrVl32HwpLBHvLaODrr5GcuuyGqe1MYGGpNAdZzjRrOtymL+VngnjI0
         YHr4vUthQPEVBsGFQsXHS5khiBga5CpWytsDBfkalWh6cn5BlS3nW3x7lQUfSs1J7++y
         seB2XTP0tDuwazGCrkDX6KqVwNfZ+5tEHy1MK+Xf0T7OW/JTutExxNuD1Oojr2SOnGoj
         yKlrO/sV6o+lnNkH8r7VrIaKJeKvmY85CLdtJEYuswL9ez7RTeKhNND/tVxt5/4XfKPH
         61JLKwg084yxo44ONZgmCmjfZWR3YcZ41KTEPpQjvD+mC5tYstAPU/Y+Rxz5PkOl/a3J
         gjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098987; x=1684690987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdlIyWD2h5iDC7/QEobaar3wvJ8iJMDcSt599XJX+L8=;
        b=lmMM/cvC2JHrK8J04hHdtgC35UcX79Fz4BeDOINXgG/jAI17Rugo9VXAQx2wkg9Zan
         z+XZoKbGAiBU0sSvKjCI0ZSJl01YYBwMMjnIPTWpXQ8Nt8bw7vRwHcxtJ8RAGejn2cws
         PHfG6N0avWAjZ55Ti9LYooHpxts28erHzEonXKH9V/TYMd8/57b3SjQdVLPsEG/npNYM
         8gz/g56DbL1McGVjXeFh9R8rsWoZwA5v0BHioEhg0hdC5Qu9vzSFy9EitdTSAzxtQBdE
         XWQpUaKZP9GmESaxlSmR/qSer42HCXfaSrspjdS6s27AVW8MHJ5ulvLM3WnsXVkgiXv4
         TUmA==
X-Gm-Message-State: AAQBX9fTJEixykHbvMCMJwmoBK2NThEExe68VtA+OYmukcAO5KDmV/lE
        7/MFLqPgaEEYxtqWowOBeaGzF12yW4QvSg==
X-Google-Smtp-Source: AKy350Y9Rm8DpdyBQqUFPeAFTxpt0LlA4VKhOCDS5+qSIaYJbiMPYt0cIsPBXDl4j4p1lPhWXB8O6A==
X-Received: by 2002:a5d:4705:0:b0:2fb:b869:bc08 with SMTP id y5-20020a5d4705000000b002fbb869bc08mr9018204wrq.23.1682098986658;
        Fri, 21 Apr 2023 10:43:06 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:06 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 18/24] selftests/bpf: verifier/search_pruning converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:28 +0300
Message-Id: <20230421174234.2391278-19-eddyz87@gmail.com>
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

Test verifier/search_pruning automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_search_pruning.c       | 339 ++++++++++++++++++
 .../selftests/bpf/verifier/search_pruning.c   | 266 --------------
 3 files changed, 341 insertions(+), 266 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_search_pruning.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/search_pruning.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 072b0eb47391..1ef44e699e9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -49,6 +49,7 @@
 #include "verifier_regalloc.skel.h"
 #include "verifier_ringbuf.skel.h"
 #include "verifier_runtime_jit.skel.h"
+#include "verifier_search_pruning.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_uninit.skel.h"
@@ -139,6 +140,7 @@ void test_verifier_ref_tracking(void)         { RUN(verifier_ref_tracking); }
 void test_verifier_regalloc(void)             { RUN(verifier_regalloc); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
+void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
new file mode 100644
index 000000000000..5a14498d352f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/search_pruning.c */
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
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+SEC("socket")
+__description("pointer/scalar confusion in state equality check (way 1)")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr as return value")
+__retval(POINTER_VALUE)
+__naked void state_equality_check_way_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 = *(u64*)(r0 + 0);				\
+	goto l1_%=;					\
+l0_%=:	r0 = r10;					\
+l1_%=:	goto l2_%=;					\
+l2_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("pointer/scalar confusion in state equality check (way 2)")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr as return value")
+__retval(POINTER_VALUE)
+__naked void state_equality_check_way_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	r0 = r10;					\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r0 + 0);				\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("lwt_in")
+__description("liveness pruning and write screening")
+__failure __msg("R0 !read_ok")
+__naked void liveness_pruning_and_write_screening(void)
+{
+	asm volatile ("					\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* branch conditions teach us nothing about R2 */\
+	if r2 >= 0 goto l0_%=;				\
+	r0 = 0;						\
+l0_%=:	if r2 >= 0 goto l1_%=;				\
+	r0 = 0;						\
+l1_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("varlen_map_value_access pruning")
+__failure __msg("R0 unbounded memory access")
+__failure_unpriv __msg_unpriv("R0 leaks addr")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void varlen_map_value_access_pruning(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r0 + 0);				\
+	w2 = %[max_entries];				\
+	if r2 s> r1 goto l1_%=;				\
+	w1 = 0;						\
+l1_%=:	w1 <<= 2;					\
+	r0 += r1;					\
+	goto l2_%=;					\
+l2_%=:	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(max_entries, MAX_ENTRIES),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("search pruning: all branches should be verified (nop operation)")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void should_be_verified_nop_operation(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r3 = *(u64*)(r0 + 0);				\
+	if r3 == 0xbeef goto l1_%=;			\
+	r4 = 0;						\
+	goto l2_%=;					\
+l1_%=:	r4 = 1;						\
+l2_%=:	*(u64*)(r10 - 16) = r4;				\
+	call %[bpf_ktime_get_ns];			\
+	r5 = *(u64*)(r10 - 16);				\
+	if r5 == 0 goto l0_%=;				\
+	r6 = 0;						\
+	r1 = 0xdead;					\
+	*(u64*)(r6 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("search pruning: all branches should be verified (invalid stack access)")
+/* in privileged mode reads from uninitialized stack locations are permitted */
+__success __failure_unpriv
+__msg_unpriv("invalid read from stack off -16+0 size 8")
+__retval(0)
+__naked void be_verified_invalid_stack_access(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r3 = *(u64*)(r0 + 0);				\
+	r4 = 0;						\
+	if r3 == 0xbeef goto l1_%=;			\
+	*(u64*)(r10 - 16) = r4;				\
+	goto l2_%=;					\
+l1_%=:	*(u64*)(r10 - 24) = r4;				\
+l2_%=:	call %[bpf_ktime_get_ns];			\
+	r5 = *(u64*)(r10 - 16);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("precision tracking for u32 spill/fill")
+__failure __msg("R0 min value is outside of the allowed memory range")
+__naked void tracking_for_u32_spill_fill(void)
+{
+	asm volatile ("					\
+	r7 = r1;					\
+	call %[bpf_get_prandom_u32];			\
+	w6 = 32;					\
+	if r0 == 0 goto l0_%=;				\
+	w6 = 4;						\
+l0_%=:	/* Additional insns to introduce a pruning point. */\
+	call %[bpf_get_prandom_u32];			\
+	r3 = 0;						\
+	r3 = 0;						\
+	if r0 == 0 goto l1_%=;				\
+	r3 = 0;						\
+l1_%=:	/* u32 spill/fill */				\
+	*(u32*)(r10 - 8) = r6;				\
+	r8 = *(u32*)(r10 - 8);				\
+	/* out-of-bound map value access for r6=32 */	\
+	r1 = 0;						\
+	*(u64*)(r10 - 16) = r1;				\
+	r2 = r10;					\
+	r2 += -16;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r0 += r8;					\
+	r1 = *(u32*)(r0 + 0);				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("precision tracking for u32 spills, u64 fill")
+__failure __msg("div by zero")
+__naked void for_u32_spills_u64_fill(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	w7 = 0xffffffff;				\
+	/* Additional insns to introduce a pruning point. */\
+	r3 = 1;						\
+	r3 = 1;						\
+	r3 = 1;						\
+	r3 = 1;						\
+	call %[bpf_get_prandom_u32];			\
+	if r0 == 0 goto l0_%=;				\
+	r3 = 1;						\
+l0_%=:	w3 /= 0;					\
+	/* u32 spills, u64 fill */			\
+	*(u32*)(r10 - 4) = r6;				\
+	*(u32*)(r10 - 8) = r7;				\
+	r8 = *(u64*)(r10 - 8);				\
+	/* if r8 != X goto pc+1  r8 known in fallthrough branch */\
+	if r8 != 0xffffffff goto l1_%=;			\
+	r3 = 1;						\
+l1_%=:	/* if r8 == X goto pc+1  condition always true on first\
+	 * traversal, so starts backtracking to mark r8 as requiring\
+	 * precision. r7 marked as needing precision. r6 not marked\
+	 * since it's not tracked.			\
+	 */						\
+	if r8 == 0xffffffff goto l2_%=;			\
+	/* fails if r8 correctly marked unknown after fill. */\
+	w3 /= 0;					\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("allocated_stack")
+__success __msg("processed 15 insns")
+__success_unpriv __msg_unpriv("") __log_level(1) __retval(0)
+__naked void allocated_stack(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r6;				\
+	r6 = *(u64*)(r10 - 8);				\
+	*(u8*)(r10 - 9) = r7;				\
+	r7 = *(u8*)(r10 - 9);				\
+l0_%=:	if r0 != 0 goto l1_%=;				\
+l1_%=:	if r0 != 0 goto l2_%=;				\
+l2_%=:	if r0 != 0 goto l3_%=;				\
+l3_%=:	if r0 != 0 goto l4_%=;				\
+l4_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* The test performs a conditional 64-bit write to a stack location
+ * fp[-8], this is followed by an unconditional 8-bit write to fp[-8],
+ * then data is read from fp[-8]. This sequence is unsafe.
+ *
+ * The test would be mistakenly marked as safe w/o dst register parent
+ * preservation in verifier.c:copy_register_state() function.
+ *
+ * Note the usage of BPF_F_TEST_STATE_FREQ to force creation of the
+ * checkpoint state after conditional 64-bit assignment.
+ */
+
+SEC("socket")
+__description("write tracking and register parent chain bug")
+/* in privileged mode reads from uninitialized stack locations are permitted */
+__success __failure_unpriv
+__msg_unpriv("invalid read from stack off -8+1 size 8")
+__retval(0) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void and_register_parent_chain_bug(void)
+{
+	asm volatile ("					\
+	/* r6 = ktime_get_ns() */			\
+	call %[bpf_ktime_get_ns];			\
+	r6 = r0;					\
+	/* r0 = ktime_get_ns() */			\
+	call %[bpf_ktime_get_ns];			\
+	/* if r0 > r6 goto +1 */			\
+	if r0 > r6 goto l0_%=;				\
+	/* *(u64 *)(r10 - 8) = 0xdeadbeef */		\
+	r0 = 0xdeadbeef;				\
+	*(u64*)(r10 - 8) = r0;				\
+l0_%=:	r1 = 42;					\
+	*(u8*)(r10 - 8) = r1;				\
+	r2 = *(u64*)(r10 - 8);				\
+	/* exit(0) */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/search_pruning.c b/tools/testing/selftests/bpf/verifier/search_pruning.c
deleted file mode 100644
index 745d6b5842fd..000000000000
--- a/tools/testing/selftests/bpf/verifier/search_pruning.c
+++ /dev/null
@@ -1,266 +0,0 @@
-{
-	"pointer/scalar confusion in state equality check (way 1)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_A(1),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
-	BPF_JMP_A(0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-	.retval = POINTER_VALUE,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 leaks addr as return value"
-},
-{
-	"pointer/scalar confusion in state equality check (way 2)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
-	BPF_JMP_A(1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-	.retval = POINTER_VALUE,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 leaks addr as return value"
-},
-{
-	"liveness pruning and write screening",
-	.insns = {
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* branch conditions teach us nothing about R2 */
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R0 !read_ok",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-{
-	"varlen_map_value_access pruning",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV32_IMM(BPF_REG_2, MAX_ENTRIES),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_2, BPF_REG_1, 1),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.errstr = "R0 unbounded memory access",
-	.result_unpriv = REJECT,
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"search pruning: all branches should be verified (nop operation)",
-	.insns = {
-		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-		BPF_LD_MAP_FD(BPF_REG_1, 0),
-		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0xbeef, 2),
-		BPF_MOV64_IMM(BPF_REG_4, 0),
-		BPF_JMP_A(1),
-		BPF_MOV64_IMM(BPF_REG_4, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_4, -16),
-		BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -16),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_5, 0, 2),
-		BPF_MOV64_IMM(BPF_REG_6, 0),
-		BPF_ST_MEM(BPF_DW, BPF_REG_6, 0, 0xdead),
-		BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "R6 invalid mem access 'scalar'",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"search pruning: all branches should be verified (invalid stack access)",
-	.insns = {
-		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-		BPF_LD_MAP_FD(BPF_REG_1, 0),
-		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
-		BPF_MOV64_IMM(BPF_REG_4, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0xbeef, 2),
-		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_4, -16),
-		BPF_JMP_A(1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_4, -24),
-		BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -16),
-		BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr_unpriv = "invalid read from stack off -16+0 size 8",
-	.result_unpriv = REJECT,
-	/* in privileged mode reads from uninitialized stack locations are permitted */
-	.result = ACCEPT,
-},
-{
-	"precision tracking for u32 spill/fill",
-	.insns = {
-		BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
-		BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-		BPF_MOV32_IMM(BPF_REG_6, 32),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-		BPF_MOV32_IMM(BPF_REG_6, 4),
-		/* Additional insns to introduce a pruning point. */
-		BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-		/* u32 spill/fill */
-		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_6, -8),
-		BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_10, -8),
-		/* out-of-bound map value access for r6=32 */
-		BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
-		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-		BPF_LD_MAP_FD(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-		BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
-		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 15 },
-	.result = REJECT,
-	.errstr = "R0 min value is outside of the allowed memory range",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"precision tracking for u32 spills, u64 fill",
-	.insns = {
-		BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-		BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-		BPF_MOV32_IMM(BPF_REG_7, 0xffffffff),
-		/* Additional insns to introduce a pruning point. */
-		BPF_MOV64_IMM(BPF_REG_3, 1),
-		BPF_MOV64_IMM(BPF_REG_3, 1),
-		BPF_MOV64_IMM(BPF_REG_3, 1),
-		BPF_MOV64_IMM(BPF_REG_3, 1),
-		BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-		BPF_MOV64_IMM(BPF_REG_3, 1),
-		BPF_ALU32_IMM(BPF_DIV, BPF_REG_3, 0),
-		/* u32 spills, u64 fill */
-		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_6, -4),
-		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7, -8),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, -8),
-		/* if r8 != X goto pc+1  r8 known in fallthrough branch */
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_8, 0xffffffff, 1),
-		BPF_MOV64_IMM(BPF_REG_3, 1),
-		/* if r8 == X goto pc+1  condition always true on first
-		 * traversal, so starts backtracking to mark r8 as requiring
-		 * precision. r7 marked as needing precision. r6 not marked
-		 * since it's not tracked.
-		 */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 0xffffffff, 1),
-		/* fails if r8 correctly marked unknown after fill. */
-		BPF_ALU32_IMM(BPF_DIV, BPF_REG_3, 0),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "div by zero",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"allocated_stack",
-	.insns = {
-		BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_1),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-		BPF_ALU64_REG(BPF_MOV, BPF_REG_7, BPF_REG_0),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, -8),
-		BPF_STX_MEM(BPF_B, BPF_REG_10, BPF_REG_7, -9),
-		BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_10, -9),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = ACCEPT,
-	.insn_processed = 15,
-},
-/* The test performs a conditional 64-bit write to a stack location
- * fp[-8], this is followed by an unconditional 8-bit write to fp[-8],
- * then data is read from fp[-8]. This sequence is unsafe.
- *
- * The test would be mistakenly marked as safe w/o dst register parent
- * preservation in verifier.c:copy_register_state() function.
- *
- * Note the usage of BPF_F_TEST_STATE_FREQ to force creation of the
- * checkpoint state after conditional 64-bit assignment.
- */
-{
-	"write tracking and register parent chain bug",
-	.insns = {
-	/* r6 = ktime_get_ns() */
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* r0 = ktime_get_ns() */
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	/* if r0 > r6 goto +1 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_6, 1),
-	/* *(u64 *)(r10 - 8) = 0xdeadbeef */
-	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0xdeadbeef),
-	/* r1 = 42 */
-	BPF_MOV64_IMM(BPF_REG_1, 42),
-	/* *(u8 *)(r10 - 8) = r1 */
-	BPF_STX_MEM(BPF_B, BPF_REG_FP, BPF_REG_1, -8),
-	/* r2 = *(u64 *)(r10 - 8) */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_FP, -8),
-	/* exit(0) */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr_unpriv = "invalid read from stack off -8+1 size 8",
-	.result_unpriv = REJECT,
-	/* in privileged mode reads from uninitialized stack locations are permitted */
-	.result = ACCEPT,
-},
-- 
2.40.0

