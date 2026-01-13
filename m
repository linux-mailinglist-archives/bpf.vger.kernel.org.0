Return-Path: <bpf+bounces-78727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3990BD19E19
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9260305A474
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD6A392B90;
	Tue, 13 Jan 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPXlBcZA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC855392B87
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317956; cv=none; b=k3jJlU7y7crEuRcUllRiTjPVOpxhyCfm5qbllB7qriuXGazF26Ha9g/VVhDIsY3Pfx4lpqcrthirMNUeiwRQj8cc1JqEldHEufnfaO13KeLWkIPwYHTfqKdi9w1EYrsLCOmpn1vezyhpXwZQIjN9N5jNwxJ9O+2HPOwJwD+r5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317956; c=relaxed/simple;
	bh=x9hcPe9UpPmJcCw8SaKx5rYwAyP1CR0dRK6Ml/MNVLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNLdwUi6sZPIEjWlZPiVhDaWu/ht/wj8j+0AgCOKiSvLXw0BQJwtLPmWhpooHGr67QzRfEGclVSRn1HNOhzeEs2GyB3940Br2zx/gVjRNk+Jd/9mwtRJD9NoVEqMTAxsc2cLGfn4/BXDp1DLgvgRaAoWDj3Bok5XnP88k5t/mhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPXlBcZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46821C116C6;
	Tue, 13 Jan 2026 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317956;
	bh=x9hcPe9UpPmJcCw8SaKx5rYwAyP1CR0dRK6Ml/MNVLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPXlBcZAOn5B7znMixykT2D0Tu7QT4GRLSEk84+1wbb7CUGjdOp7NGRw7Buhz4Od0
	 NdHUuFknXwZAKFSu2rzgoU6QAYzHZ1Gv80Z3+Hqnec3zK3t//1T1j4MRvfEmbA51/q
	 ohDaT7cjZbe/nLjOYEEabdA/eT+eikR4/D3SNv9VwCtaCnCFHufuWyU+wXsUpkjEeu
	 pC78NBywispaf33Ds/809otVQpzFuXEFxsEw4QjalAhZW438166Hap5z9ukHqYA8U3
	 nrNZC2h8Kx/llZbqJa7Yrdm8YkczVCKsg6ajeL3d34T3vinoP4MPalVmTpdnBkytZc
	 +aaC4PJ/fKqfg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for improved linked register tracking
Date: Tue, 13 Jan 2026 07:25:26 -0800
Message-ID: <20260113152529.3217648-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152529.3217648-1-puranjay@kernel.org>
References: <20260113152529.3217648-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for linked register tracking with negative offsets, BPF_SUB,
and alu32. These test for all edge cases like over-flows, etc.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../bpf/progs/verifier_linked_scalars.c       | 232 +++++++++++++++++-
 1 file changed, 230 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 8f755d2464cf..62454d97a7c1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bpf.h>
+#include <limits.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -18,9 +19,9 @@ __naked void scalars(void)
 	r4 = r1;				\
 	w2 += 0x7FFFFFFF;			\
 	w4 += 0;				\
-	if r2 == 0 goto l1;			\
+	if r2 == 0 goto l0_%=;			\
 	exit;					\
-l1:						\
+l0_%=:						\
 	r4 >>= 63;				\
 	r3 = 1;					\
 	r3 -= r4;				\
@@ -31,4 +32,231 @@ l1:						\
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__success
+__naked void scalars_neg(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += -4;					\
+	if r1 s< 0 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Same test but using BPF_SUB instead of BPF_ADD with negative immediate */
+SEC("socket")
+__success
+__naked void scalars_neg_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 -= 4;					\
+	if r1 s< 0 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* alu32 with negative offset */
+SEC("socket")
+__success
+__naked void scalars_neg_alu32_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 += -4;					\
+	if w1 s< 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* alu32 with negative offset using SUB */
+SEC("socket")
+__success
+__naked void scalars_neg_alu32_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 -= 4;					\
+	if w1 s< 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Positive offset: r1 = r0 + 4, then if r1 >= 6, r0 >= 2, so r0 != 0 */
+SEC("socket")
+__success
+__naked void scalars_pos(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* SUB with negative immediate: r1 -= -4 is equivalent to r1 += 4 */
+SEC("socket")
+__success
+__naked void scalars_sub_neg_imm(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 -= -4;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Double ADD clears the ID (can't accumulate offsets) */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_double_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += 2;					\
+	r1 += 2;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test that sync_linked_regs() correctly handles large offset differences.
+ * r1.off = S32_MIN, r2.off = 1, delta = S32_MIN - 1 requires 64-bit math.
+ */
+SEC("socket")
+__success
+__naked void scalars_sync_delta_overflow(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 += %[s32_min];				\
+	r2 += 1;					\
+	if r2 s< 100 goto l0_%=;			\
+	if r1 s< 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  [s32_min]"i"(INT_MIN)
+	: __clobber_all);
+}
+
+/*
+ * Another large delta case: r1.off = S32_MAX, r2.off = -1.
+ * delta = S32_MAX - (-1) = S32_MAX + 1 requires 64-bit math.
+ */
+SEC("socket")
+__success
+__naked void scalars_sync_delta_overflow_large_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 += %[s32_max];				\
+	r2 += -1;					\
+	if r2 s< 0 goto l0_%=;				\
+	if r1 s>= 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  [s32_max]"i"(INT_MAX)
+	: __clobber_all);
+}
+
+/*
+ * Test linked scalar tracking with alu32 and large positive offset (0x7FFFFFFF).
+ * After w1 += 0x7FFFFFFF, w1 wraps to negative for any r0 >= 1.
+ * If w1 is signed-negative, then r0 >= 1, so r0 != 0.
+ */
+SEC("socket")
+__success
+__naked void scalars_alu32_big_offset(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 += 0x7FFFFFFF;				\
+	if w1 s>= 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


