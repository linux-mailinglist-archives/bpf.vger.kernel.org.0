Return-Path: <bpf+bounces-78162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B8D0008C
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 21:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 754843016F9F
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 20:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94BD3090E0;
	Wed,  7 Jan 2026 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="punVIw9C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E42877ED
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818449; cv=none; b=Saku1MK4ZpdR9MgfOIk9mBjyYJBYgzlATqasmT4dO6Guyw4rvZwFcLp8wD+pATtFQAdygn4xF2ur6yvSica4DQGv0TXuoECfJpIKHsqN0ZrOR+WVJoX1+HubNy3A+dElFueOHnNDhynqlyllhfrzpIPRrKl5q3PBZmbm/G4UNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818449; c=relaxed/simple;
	bh=W10o5ueU+Foa5uw6P/Z2nn6HkfvvTdha3vgN9spDRw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AosE5uUTH5y3vwJ8mMO9AyNKR/jPmoUf7kDB0v6tBkxbkPtgD/j+dj/fFkmnZcesteplDYUIiUtsuusKQuOYi/AubSnPl3rYK+KDM058E8NPfpM/TDGOC8qIj4ES1rlktvPLTG24muYa1TLafyFkI0yhiF8f0hGxQ5hKX6M1/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=punVIw9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95973C4CEF1;
	Wed,  7 Jan 2026 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818448;
	bh=W10o5ueU+Foa5uw6P/Z2nn6HkfvvTdha3vgN9spDRw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=punVIw9C9P6vrt86dMeuSi67046TdGmWTL05CTFsOm2Kt4BfLD15v7xoavUEKy4Vw
	 hnP0WRQqzB0c1gFP9jUjll2K4M+qG/w3uibZxXk7SEhLh+F1o9+BxrCHozhKkL3lr2
	 qqLVRa4okc2mB4Ly/j+ZCpXDDPETbevXcGrQi+t8yZI5QqfcLc7ebEeexL/hR+GDSU
	 oEA9+2N4p2JGTgen1BVhp6sq1lEox2pX8aPN+aS7S1FulwDp6fnXc7U5F3ADIZFNb2
	 ODS9FuBL8dp+xJm99upKpNXLuJeY48VqL69gVVWwkvaZg+6/BJntoXJAocQvCPBBQ8
	 5VQDjLSDl8K7A==
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
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add tests for linked register tracking with negative offsets
Date: Wed,  7 Jan 2026 12:39:35 -0800
Message-ID: <20260107203941.1063754-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107203941.1063754-1-puranjay@kernel.org>
References: <20260107203941.1063754-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for linked register tracking with negative offsets and BPF_SUB:

Success cases (64-bit ALU, tracking works):
- scalars_neg: r1 += -4 with signed comparison
- scalars_neg_sub: r1 -= 4 with signed comparison
- scalars_pos: r1 += 4 with unsigned comparison
- scalars_sub_neg_imm: r1 -= -4 (equivalent to r1 += 4)

Failure cases (tracking disabled, documents limitations):
- scalars_neg_alu32_add: 32-bit ADD not tracked
- scalars_neg_alu32_sub: 32-bit SUB not tracked
- scalars_double_add: Double ADD clears ID

Large delta tests (verifies 64-bit arithmetic in sync_linked_regs):
- scalars_sync_delta_overflow: S32_MIN offset
- scalars_sync_delta_overflow_large_range: S32_MAX offset

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../bpf/progs/verifier_linked_scalars.c       | 213 ++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 8f755d2464cf..2e1ef0f96717 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -31,4 +31,217 @@ l1:						\
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("scalars: linked scalars with negative offset")
+__success
+__naked void scalars_neg(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += -4;					\
+	if r1 s< 0 goto l2;				\
+	if r0 != 0 goto l2;				\
+	r0 /= 0;					\
+l2:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Same test but using BPF_SUB instead of BPF_ADD with negative immediate */
+SEC("socket")
+__description("scalars: linked scalars with SUB")
+__success
+__naked void scalars_neg_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 -= 4;					\
+	if r1 s< 0 goto l2_sub;				\
+	if r0 != 0 goto l2_sub;				\
+	r0 /= 0;					\
+l2_sub:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 32-bit ALU: linked scalar tracking not supported, ID cleared */
+SEC("socket")
+__description("scalars: linked scalars 32-bit ADD not tracked")
+__failure
+__msg("div by zero")
+__naked void scalars_neg_alu32_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 += -4;					\
+	if w1 s< 0 goto l2_alu32_add;			\
+	if w0 != 0 goto l2_alu32_add;			\
+	r0 /= 0;					\
+l2_alu32_add:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 32-bit ALU: linked scalar tracking not supported, ID cleared */
+SEC("socket")
+__description("scalars: linked scalars 32-bit SUB not tracked")
+__failure
+__msg("div by zero")
+__naked void scalars_neg_alu32_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 -= 4;					\
+	if w1 s< 0 goto l2_alu32_sub;			\
+	if w0 != 0 goto l2_alu32_sub;			\
+	r0 /= 0;					\
+l2_alu32_sub:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Positive offset: r1 = r0 + 4, then if r1 >= 6, r0 >= 2, so r0 != 0 */
+SEC("socket")
+__description("scalars: linked scalars positive offset")
+__success
+__naked void scalars_pos(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	if r1 < 6 goto l2_pos;				\
+	if r0 != 0 goto l2_pos;				\
+	r0 /= 0;					\
+l2_pos:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* SUB with negative immediate: r1 -= -4 is equivalent to r1 += 4 */
+SEC("socket")
+__description("scalars: linked scalars SUB negative immediate")
+__success
+__naked void scalars_sub_neg_imm(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 -= -4;					\
+	if r1 < 6 goto l2_sub_neg;			\
+	if r0 != 0 goto l2_sub_neg;			\
+	r0 /= 0;					\
+l2_sub_neg:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Double ADD clears the ID (can't accumulate offsets) */
+SEC("socket")
+__description("scalars: linked scalars double ADD clears ID")
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
+	if r1 < 6 goto l2_double;			\
+	if r0 != 0 goto l2_double;			\
+	r0 /= 0;					\
+l2_double:						\
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
+__description("scalars: linked regs sync with large delta (S32_MIN offset)")
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
+	if r2 s< 100 goto l2_overflow;			\
+	if r1 s< 0 goto l2_overflow;			\
+	r0 /= 0;					\
+l2_overflow:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  [s32_min]"i"((int)(-2147483647 - 1))
+	: __clobber_all);
+}
+
+/*
+ * Another large delta case: r1.off = S32_MAX, r2.off = -1.
+ * delta = S32_MAX - (-1) = S32_MAX + 1 requires 64-bit math.
+ */
+SEC("socket")
+__description("scalars: linked regs sync with large delta (S32_MAX offset)")
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
+	if r2 s< 0 goto l2_large;			\
+	if r1 s>= 0 goto l2_large;			\
+	r0 /= 0;					\
+l2_large:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  [s32_max]"i"((int)2147483647)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


