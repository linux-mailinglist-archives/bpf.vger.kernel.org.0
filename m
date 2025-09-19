Return-Path: <bpf+bounces-68897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D0DB87B66
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8022A887D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E351274FD5;
	Fri, 19 Sep 2025 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky9yB78D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB7260563
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248354; cv=none; b=oS75FhtbrpaLOkSZJl2+3R3NQgEpogwFQqMtHs6sMQIXKZl8h6g6DHR7YGtsjYyF+fx/qyyhl2ZIf1R4ThOoQVIHrP3LzFaCm9E4WZXSoF1FnCK54RJEb6fnQ72I4/B2SQ4ugzYOEQZlq6eupBkV+I7XmMtcq/hdeZHN9sgt5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248354; c=relaxed/simple;
	bh=cdVaweJn8L+JzNRh+KQkBuOz5Q13abiwYbtEkM9oa84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBH+U+KrcAhmnsQG2giabWHXuMkLwi83UfDxaJKUKSatP24EFVmpz8FK5nW/Q+NaV+MbUlIAuaEqhdy4vpoAx5r8jB4kQKWu7ZSJpELfhVQz0I5xnD89JSZ9vmfyOurpdY2XU0WbHoB3LQxgH9IF2agltCsSG4waVyOYyTKVL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky9yB78D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445805aa2eso16220565ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248351; x=1758853151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85uJrw7xpQFyO88LPpL2d50WU+CpQKOz/FGeE7vNbzc=;
        b=ky9yB78DbcR7zTuQq5IFhPm5yN+Rdmdt26fltwLQduKzZzGmAGpq9ClnXDTPz1jl9Y
         HIgy0ks65+VR87E3UIs2Ed+x8M87yq+x5Q6QdcHU3jltn0OyyibEN5vF7P3MBFGvvOKH
         nPHeGPM2mIGo1XeHSt8UWU3tXJ41AyGEL+U01lTG8AyiPQS3lwHvf3j8ayRYZjmT1FAH
         Az2WmaZaevMgJ19HF8uWxLpx0+XxQBI0l7auq1rv60ILHtKjONJhUofOHQjflU4n7ICh
         cIfwVzD30jkd0Fm3C+b/SHbd/5LTxcxN7lDRJ94icWEbL/coQoevtsxy7kzjbJRaE6vl
         bjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248351; x=1758853151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85uJrw7xpQFyO88LPpL2d50WU+CpQKOz/FGeE7vNbzc=;
        b=PzxVI9JIJA8OqQNgD52lZkqQW8DilsQadPEgtR9cNGInHiVATKylNiW13Y9tvrp/dd
         oxNuo7+WiP04HQPg/j7eJTtWQq6WUbfn4R86V0KwET58SPk9UIRDSDuAlUM8DczUcJQO
         XThrvd1Ock3QB3HKLm1K7xZ5JHR1jDIEuhQhLdZCsyPW0hGuF2yk1OHbIa1+ECmF+dUP
         tewFvo4+8pK1KVlSHDO21qAWiEJYbkfwtbb1qRIsSI/+ocuW99roY8eQSVQtMr/Fzblr
         X8LbLq8IBjT6bLtAE5khX4vFs9NvGLUe5KwkkbL71tXJXXWvkJ5509Dj+uz/8uRAt8uN
         OkaQ==
X-Gm-Message-State: AOJu0Yxsd7HSrDCJM+P0HivAkAo/nVUS0/LCJVwimYcvkq+tkpfUT0TT
	gBF8ziRwaSVAeDU8Wg6Jeg7yFMCf8si6hq9d67SwjW4gTqWeTALGNVSXs79cBA==
X-Gm-Gg: ASbGncttfI7XzDy9LrKLNKc115Im82o8idzscsSYDc61oDnvwxQCxB61Cam/w/YO55a
	CTqApR//6NTq2V118LhIarCbHEYDYxs0TnhK0A4x9SG0oVpX8rOHO2nyUGf14NjO6xjMm1pk/4D
	bL3A8ROuIVYnWFPaIagxBXzX8fVfdMnwJ9LPgj9tJEZhBiJOXx5hTQvFtzUZdmQr5/ygUwdwLJz
	oEoWMmUud+2E7GkluHoQFhbVWWbgHa7zO+UVQUP7VIjXtNZOMaWplq14ASxkZwVdckRE60+RDh1
	JLZN3B99RZKTzEt92TwGZTaAWKAkWUCkOPtkaxACng/veTkoHe62O+IfIAkAXjDB95A5vD6KHrH
	z9TLxCF0u4n0f/u4tLn7ZjRPdPck=
X-Google-Smtp-Source: AGHT+IHgmhZcuPNv1lrGDnlwPZR/nmaR2mNa8fhRGmSFY8fLTUZMB+tOCP3n/t+x1+q8Lal3LWaelQ==
X-Received: by 2002:a17:903:320a:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-269ba5635femr21095995ad.44.1758248351307;
        Thu, 18 Sep 2025 19:19:11 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 12/12] selftests/bpf: test cases for callchain sensitive live stack tracking
Date: Thu, 18 Sep 2025 19:18:45 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-12-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
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

