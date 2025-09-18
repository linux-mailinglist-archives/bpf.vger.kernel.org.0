Return-Path: <bpf+bounces-68849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF087B8683C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437651C26658
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102502DA76C;
	Thu, 18 Sep 2025 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcQpdyvv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56892D6E7A
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221299; cv=none; b=n7cV3HH5tU5EiantNa6/ZRAMGuoMbhqBYeLpx5+Sd0Q/56SZLfS/cq68gv3AvB70wG7p0d64Vjt8XxBQ7CnnTwl6T0/I/SJiYrPq/upy06d5sfI241Ay561XRD2GZjoMEa82f3NwQUjZ+g4TW9EDK62JYRJ5i6Buw+YYz+hnr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221299; c=relaxed/simple;
	bh=cdVaweJn8L+JzNRh+KQkBuOz5Q13abiwYbtEkM9oa84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L90Q0WedbTWNlI/sWmgaQ2s2CtqH/K3wCt4XO/xECif86/RkQK7N+FxcqX+A2hKcLavx3YwHUt0gh9nljFGhV/7Sht5nyXWMvTYcnhRXTfLZGPfTGcCBtS09ooR1B8xJ5ZtIat70XoQ0xjBfPhaNKt7NYBLecwtCAx0z3dw6qyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcQpdyvv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445806e03cso15600675ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221296; x=1758826096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85uJrw7xpQFyO88LPpL2d50WU+CpQKOz/FGeE7vNbzc=;
        b=OcQpdyvvGPDDO3ujz6WDo6aVXXZkRpcdw8Ow4177HIls5MViN6745OitqoDW7NScyY
         S1lW8HovZjHa67i9498ekxbA2MQ5TdowlGky+nFzZ7wudo/fXIxO/b20kyrQcFotR0fn
         ZZI8WRlvp3DDboKQuMlZXn0GZyV3puoc+/fSE12gNJZF3ZUI2kyegSAS/M/KnOHEdUeL
         dh5Mrl6hrkwCivbsHiGJouXr57yx6FozlQ0Z9MMbJwQ5T9aVJtQSonR1h6jU7CA61eJs
         +KuT2wtNtwOpp1Q8/9fUOtM24LahnTLwZizF8MZCm6wStksuP1t2NYdnB9KO+/4rC+Fp
         9KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221296; x=1758826096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85uJrw7xpQFyO88LPpL2d50WU+CpQKOz/FGeE7vNbzc=;
        b=AHIG7k3iYWI7ajmoPgltD7oGO1U01Q9bHf6axpxSUQhKh5VzMyArA2+0hYt8bk9Hir
         zERQh8Fif+hG48DBPwfLrhsZ/dgdBK6mJQ+0jypZH4mV0k9b8dsiVyB7D5TLsIy5Z9UC
         L6BUj0VV/GGAxP8ynd9oIln/KdMUoI+QZft7LTVVCV4DWnlm6IxHw/2MbQ87ON6Y3DcN
         rylETbpDlV0C+9wUZ14pwOTWTBFL9BAqK2afhVQE2gZbbkCp8EEp7XSZya4oXWQ6S4Xr
         kVJ5GZcvV+wD7Zakur/IpxiVGDZbB0f9kKLsTfNFaoMbgzD6p4yd2yOpMLD8KgotVyt6
         lMvg==
X-Gm-Message-State: AOJu0YyKfTNietSBeGAho9409zLL3Bgdb6UsCrijnSL4thcik4ZS+o4V
	lZ1LsBwCY2WXAOhhYZx7oASeoN/jysTyHdjvLTkxl5jejFYHL6shXQjIPqpMOgxi
X-Gm-Gg: ASbGncstYgHZi1/g1ioAMX3aIv1V8bzZLjOIOZ/zVf6w6Z3aJYHd8xPjl+cheEgGpq/
	bYJGBfHeWUkWA1XIwC69UPx0sCCD1iRfpCyZYIqo7xIvnVG7y0v3PCVVO/5NfgUFxgkExN2Lmz/
	DB+0cfWLF/f5IlitGfg2Owb3zKfAzWLT4/aDOrDKh5XErnrIafRp5TucOJqjNyWckiOfIHWKqw1
	PZR5bRt+p9YGuO7gzRT1wTGSsBuyBHC33lypGob9SdHf5N4NWUPb0PVtLjG+nTu/yN6Wu/rmIn0
	qZSyPSki72wHSfMW2tYX4jIobbOxgI5VEXga3BMcHFiGU2oNX6PoPgD1shg4lsHfhtRF5bQF5Ct
	j4p2d5E9Q4x7v5jxKzItlRlb6UzZv397abQLJ8WT5vvwEXQ==
X-Google-Smtp-Source: AGHT+IEs9i9F+x6/UKaD/mv7ypZZvfcPYLtpVvtQALcRvNcNFpbdE31vNsydur7u2GnbD3ARQqNTKQ==
X-Received: by 2002:a17:902:db0e:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-269ba5762dfmr6505905ad.61.1758221295749;
        Thu, 18 Sep 2025 11:48:15 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 12/12] selftests/bpf: test cases for callchain sensitive live stack tracking
Date: Thu, 18 Sep 2025 11:47:41 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-12-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

- simple propagation of read/write marks;
- joining read/write marks from conditional branches;
- avoid must_write marks in when same instruction accesses different
  stack offsets on different execution paths;
- avoid must_write marks in case same instruction accesses stack
  and non-stack pointers on different execution paths;
- read/write marks propagation to outer stack frame;
- independent read marks for different callchains ending with the same
  function;
- bpf_calls_callback() dependent logic in
  liveness.c:bpf_stack_slot_alive().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_live_stack.c      | 294 +++++++++++++++++++++
 2 files changed, 296 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e35c216dbaf21cf05a88475a247ef91f60d424ed..28e81161e6fca9efa69aa42b137d300c541f6da1 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -46,6 +46,7 @@
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_linked_scalars.skel.h"
+#include "verifier_live_stack.skel.h"
 #include "verifier_load_acquire.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
@@ -184,6 +185,7 @@ void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
+void test_verifier_live_stack(void)           { RUN(verifier_live_stack); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
new file mode 100644
index 0000000000000000000000000000000000000000..c0e80850926827ca52f73dd6da6deb7f13d1ea70
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long long);
+} map SEC(".maps");
+
+SEC("socket")
+__log_level(2)
+__msg("(0) frame 0 insn 2 +written -8")
+__msg("(0) frame 0 insn 1 +live -24")
+__msg("(0) frame 0 insn 1 +written -8")
+__msg("(0) frame 0 insn 0 +live -8,-24")
+__msg("(0) frame 0 insn 0 +written -8")
+__msg("(0) live stack update done in 2 iterations")
+__naked void simple_read_simple_write(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r10 - 8);"
+	"r2 = *(u64 *)(r10 - 24);"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("(0) frame 0 insn 1 +live -8")
+__not_msg("(0) frame 0 insn 1 +written")
+__msg("(0) live stack update done in 2 iterations")
+__msg("(0) frame 0 insn 1 +live -16")
+__msg("(0) frame 0 insn 1 +written -32")
+__msg("(0) live stack update done in 2 iterations")
+__naked void read_write_join(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"if r0 > 42 goto 1f;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"*(u64 *)(r10 - 32) = r0;"
+	"*(u64 *)(r10 - 40) = r0;"
+	"exit;"
+"1:"
+	"r0 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r10 - 32) = r0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("2: (25) if r0 > 0x2a goto pc+1")
+__msg("7: (95) exit")
+__msg("(0) frame 0 insn 2 +written -16")
+__msg("(0) live stack update done in 2 iterations")
+__msg("7: (95) exit")
+__not_msg("(0) frame 0 insn 2")
+__msg("(0) live stack update done in 1 iterations")
+__naked void must_write_not_same_slot(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = -8;"
+	"if r0 > 42 goto 1f;"
+	"r1 = -16;"
+"1:"
+	"r2 = r10;"
+	"r2 += r1;"
+	"*(u64 *)(r2 + 0) = r0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("(0) frame 0 insn 0 +written -8,-16")
+__msg("(0) live stack update done in 2 iterations")
+__msg("(0) frame 0 insn 0 +written -8")
+__msg("(0) live stack update done in 2 iterations")
+__naked void must_write_not_same_type(void)
+{
+	asm volatile (
+	"*(u64*)(r10 - 8) = 0;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 != 0 goto 1f;"
+	"r0 = r10;"
+	"r0 += -16;"
+"1:"
+	"*(u64 *)(r0 + 0) = 42;"
+	"exit;"
+	:
+        : __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("(2,4) frame 0 insn 4 +written -8")
+__msg("(2,4) live stack update done in 2 iterations")
+__msg("(0) frame 0 insn 2 +written -8")
+__msg("(0) live stack update done in 2 iterations")
+__naked void caller_stack_write(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"call write_first_param;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void write_first_param(void)
+{
+	asm volatile (
+	"*(u64 *)(r1 + 0) = 7;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+/* caller_stack_read() function */
+__msg("2: .12345.... (85) call pc+4")
+__msg("5: .12345.... (85) call pc+1")
+__msg("6: 0......... (95) exit")
+/* read_first_param() function */
+__msg("7: .1........ (79) r0 = *(u64 *)(r1 +0)")
+__msg("8: 0......... (95) exit")
+/* update for callsite at (2) */
+__msg("(2,7) frame 0 insn 7 +live -8")
+__msg("(2,7) live stack update done in 2 iterations")
+__msg("(0) frame 0 insn 2 +live -8")
+__msg("(0) live stack update done in 2 iterations")
+/* update for callsite at (5) */
+__msg("(5,7) frame 0 insn 7 +live -16")
+__msg("(5,7) live stack update done in 2 iterations")
+__msg("(0) frame 0 insn 5 +live -16")
+__msg("(0) live stack update done in 2 iterations")
+__naked void caller_stack_read(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"call read_first_param;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"call read_first_param;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void read_first_param(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2)
+/* read_first_param2() function */
+__msg(" 9: .1........ (79) r0 = *(u64 *)(r1 +0)")
+__msg("10: .......... (b7) r0 = 0")
+__msg("11: 0......... (05) goto pc+0")
+__msg("12: 0......... (95) exit")
+/*
+ * The purpose of the test is to check that checkpoint in
+ * read_first_param2() stops path traversal. This will only happen if
+ * verifier understands that fp[0]-8 at insn (12) is not alive.
+ */
+__msg("12: safe")
+__msg("processed 20 insns")
+__naked void caller_stack_pruning(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 42 goto 1f;"
+	"r0 = %[map] ll;"
+"1:"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	/*
+	 * fp[0]-8 is either pointer to map or a scalar,
+	 * preventing state pruning at checkpoint created for call.
+	 */
+	"call read_first_param2;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_addr(map)
+	: __clobber_all);
+}
+
+static __used __naked void read_first_param2(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"r0 = 0;"
+	/*
+	 * Checkpoint at goto +0 should fire,
+	 * as caller stack fp[0]-8 is not alive at this point.
+	 */
+	"goto +0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure
+__msg("R1 type=scalar expected=map_ptr")
+__naked void caller_stack_pruning_callback(void)
+{
+	asm volatile (
+	"r0 = %[map] ll;"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r1 = 2;"
+	"r2 = loop_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	/*
+	 * fp[0]-8 is either pointer to map or a scalar,
+	 * preventing state pruning at checkpoint created for call.
+	 */
+	"call %[bpf_loop];"
+	"r0 = 42;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_loop),
+	  __imm_addr(map)
+	: __clobber_all);
+}
+
+static __used __naked void loop_cb(void)
+{
+	asm volatile (
+	/*
+	 * Checkpoint at function entry should not fire, as caller
+	 * stack fp[0]-8 is alive at this point.
+	 */
+	"r6 = r2;"
+	"r1 = *(u64 *)(r6 + 0);"
+	"*(u64*)(r10 - 8) = 7;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_lookup_elem];"
+	/*
+	 * This should stop verifier on a second loop iteration,
+	 * but only if verifier correctly maintains that fp[0]-8
+	 * is still alive.
+	 */
+	"*(u64 *)(r6 + 0) = 0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Because of a bug in verifier.c:compute_postorder()
+ * the program below overflowed traversal queue in that function.
+ */
+SEC("socket")
+__naked void syzbot_postorder_bug1(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"if r0 != 0 goto -1;"
+	"exit;"
+	::: __clobber_all);
+}

-- 
2.51.0

