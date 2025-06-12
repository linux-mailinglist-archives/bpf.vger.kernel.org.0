Return-Path: <bpf+bounces-60505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB85AD78D6
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8446D17BA5E
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5129B792;
	Thu, 12 Jun 2025 17:19:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647462F4324
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748793; cv=none; b=XKPYWww5CVs4VlfcbyogAk2UWEvoPNOZ6WddsWzuFhu+lIlc5yvc3EC8TaE/Epr1RYlh3LUdxx7/Qy2hnRlW+cWeLw9ZNqfjjrTnUC+YRS5vzNwgMB4jsbf6gSEpnSjGmLR0rNiW/Q6YMRyKHksxr3nx5jDPGaIiYLyyEVpNem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748793; c=relaxed/simple;
	bh=omsmMPLf0nAlw7bDThI8Rb04Uw+Z31qanVutjgp/Y4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiGkHpvAidAy8vXfkSqr86AJcIuM7hrEF8XTK7P30CJcKTngw2mfUBFmwfbuwI782NW6bUgFOXuR2ZzzEHU06XdSxFzNeP8W6mgSMOCkUytPSKvMCdT0UKfOPN69GTLG4PyyfPgNe2fZtWwcHlN5c2BfYhWZKHPe5blNUxOAtZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id ABCB7979DF94; Thu, 12 Jun 2025 10:19:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm codes
Date: Thu, 12 Jun 2025 10:19:38 -0700
Message-ID: <20250612171938.2373564-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In one of upstream thread ([1]), there is a discussion about
the below inline asm code:

  if r1 =3D=3D 0xdeadbeef goto +2;
  ...

In actual llvm backend, the above 0xdeadbeef will actually do
sign extension to 64bit value and then compare to register r1.

But the code itself does not imply the above semantics. It looks
like the comparision is between r1 and 0xdeadbeef. For example,
let us at a simple C code:
  $ cat t1.c
  int foo(long a) { return a =3D=3D 0xdeadbeef ? 2 : 3; }
  $ clang --target=3Dbpf -O2 -c t1.c && llvm-objdump -d t1.o
    ...
    w0 =3D 0x2
    r2 =3D 0xdeadbeef ll
    if r1 =3D=3D r2 goto +0x1
    w0 =3D 0x3
    exit
It does try to compare r1 and 0xdeadbeef.

To address the above confusing inline asm issue, llvm backend ([2])
added some range checking for such insns and beyond. For the above
insn asm, the warning like below
  warning: immediate out of range, shall fit in int range
will be issued. If -Werror is in the compilation flags, the
error will be issued.

To avoid the above warning/error, the afore-mentioned inline asm
should be rewritten to

  if r1 =3D=3D -559038737 goto +2;
  ...

Fix a few selftest cases like the above based on insn range checking
requirement in [2].

  [1] https://lore.kernel.org/bpf/70affb12-327b-4882-bd1d-afda8b8c6f56@li=
nux.dev/
  [2] https://github.com/llvm/llvm-project/pull/142989

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/progs/dummy_st_ops_success.c |  2 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c        |  2 +-
 tools/testing/selftests/bpf/progs/iters.c              |  2 +-
 tools/testing/selftests/bpf/progs/verifier_and.c       |  2 +-
 tools/testing/selftests/bpf/progs/verifier_bounds.c    |  4 ++--
 .../bpf/progs/verifier_direct_packet_access.c          |  8 ++++----
 tools/testing/selftests/bpf/progs/verifier_ldsx.c      |  2 +-
 tools/testing/selftests/bpf/progs/verifier_masking.c   |  4 ++--
 tools/testing/selftests/bpf/progs/verifier_movsx.c     |  2 +-
 .../testing/selftests/bpf/progs/verifier_or_jmp32_k.c  |  2 +-
 tools/testing/selftests/bpf/progs/verifier_raw_stack.c |  4 ++--
 .../selftests/bpf/progs/verifier_search_pruning.c      |  6 +++---
 .../testing/selftests/bpf/progs/verifier_spill_fill.c  |  6 +++---
 tools/testing/selftests/bpf/progs/verifier_stack_ptr.c | 10 +++++-----
 tools/testing/selftests/bpf/progs/verifier_subreg.c    |  6 +++---
 tools/testing/selftests/bpf/progs/verifier_unpriv.c    |  2 +-
 16 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c b/t=
ools/testing/selftests/bpf/progs/dummy_st_ops_success.c
index ec0c595d47af..54b3d599f31a 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
@@ -19,7 +19,7 @@ int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
 	 */
 	asm volatile (
 		"if %[state] !=3D 0 goto +2;"
-		"r0 =3D 0xf2f3f4f5;"
+		"r0 =3D -218893067;"
 		"exit;"
 	::[state]"p"(state));
=20
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
index bd8f15229f5c..7c7dac6bd3c2 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -761,7 +761,7 @@ int dynptr_pruning_type_confusion(struct __sk_buff *c=
tx)
 		 *(u64 *)(r2 + 0) =3D r9;			\
 		 r3 =3D r10;				\
 		 r3 +=3D -24;				\
-		 r9 =3D 0xeB9FeB9F;			\
+		 r9 =3D -341840993;			\
 		 *(u64 *)(r10 - 16) =3D r9;		\
 		 *(u64 *)(r10 - 24) =3D r9;		\
 		 r9 =3D 0;				\
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/se=
lftests/bpf/progs/iters.c
index 7dd92a303bf6..e13023fa9593 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -774,7 +774,7 @@ __naked int delayed_read_mark(void)
 	"3:"
 		"r1 =3D r7;"
 		"r2 =3D 8;"
-		"r3 =3D 0xdeadbeef;"
+		"r3 =3D -559038737;"
 		"call %[bpf_probe_read_user];"
 		"goto 1b;"
 	"2:"
diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/tes=
ting/selftests/bpf/progs/verifier_and.c
index 2b4fdca162be..b53b41590b5e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_and.c
+++ b/tools/testing/selftests/bpf/progs/verifier_and.c
@@ -99,7 +99,7 @@ __naked void known_subreg_with_unknown_reg(void)
 	call %[bpf_get_prandom_u32];			\
 	r0 <<=3D 32;					\
 	r0 +=3D 1;					\
-	r0 &=3D 0xFFFF1234;				\
+	r0 &=3D -60876;					\
 	/* Upper bits are unknown but AND above masks out 1 zero'ing lower bits=
 */\
 	if w0 < 1 goto l0_%=3D;				\
 	r1 =3D *(u32*)(r1 + 512);				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
index 30e16153fdf1..4a174f182768 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -152,7 +152,7 @@ __naked void on_sign_extended_mov_test1(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 =3D=3D 0 goto l0_%=3D;				\
 	/* r2 =3D 0xffff'ffff'ffff'ffff */		\
-	r2 =3D 0xffffffff;				\
+	r2 =3D -1;					\
 	/* r2 =3D 0xffff'ffff */				\
 	r2 >>=3D 32;					\
 	/* r0 =3D <oob pointer> */			\
@@ -183,7 +183,7 @@ __naked void on_sign_extended_mov_test2(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 =3D=3D 0 goto l0_%=3D;				\
 	/* r2 =3D 0xffff'ffff'ffff'ffff */		\
-	r2 =3D 0xffffffff;				\
+	r2 =3D -1;					\
 	/* r2 =3D 0xfff'ffff */				\
 	r2 >>=3D 36;					\
 	/* r0 =3D <oob pointer> */			\
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_acc=
ess.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 28b602ac9cbe..1213b495a0e4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -485,7 +485,7 @@ __naked void test20_x_pkt_ptr_1(void)
 	asm volatile ("					\
 	r2 =3D *(u32*)(r1 + %[__sk_buff_data]);		\
 	r3 =3D *(u32*)(r1 + %[__sk_buff_data_end]);	\
-	r0 =3D 0xffffffff;				\
+	r0 =3D -1;					\
 	*(u64*)(r10 - 8) =3D r0;				\
 	r0 =3D *(u64*)(r10 - 8);				\
 	r0 &=3D 0x7fff;					\
@@ -515,7 +515,7 @@ __naked void test21_x_pkt_ptr_2(void)
 	r0 =3D r2;					\
 	r0 +=3D 8;					\
 	if r0 > r3 goto l0_%=3D;				\
-	r4 =3D 0xffffffff;				\
+	r4 =3D -1;					\
 	*(u64*)(r10 - 8) =3D r4;				\
 	r4 =3D *(u64*)(r10 - 8);				\
 	r4 &=3D 0x7fff;					\
@@ -548,7 +548,7 @@ __naked void test22_x_pkt_ptr_3(void)
 	r3 =3D *(u64*)(r10 - 16);				\
 	if r0 > r3 goto l0_%=3D;				\
 	r2 =3D *(u64*)(r10 - 8);				\
-	r4 =3D 0xffffffff;				\
+	r4 =3D -1;					\
 	lock *(u64 *)(r10 - 8) +=3D r4;			\
 	r4 =3D *(u64*)(r10 - 8);				\
 	r4 >>=3D 49;					\
@@ -605,7 +605,7 @@ __naked void test24_x_pkt_ptr_5(void)
 	asm volatile ("					\
 	r2 =3D *(u32*)(r1 + %[__sk_buff_data]);		\
 	r3 =3D *(u32*)(r1 + %[__sk_buff_data_end]);	\
-	r0 =3D 0xffffffff;				\
+	r0 =3D -1;					\
 	*(u64*)(r10 - 8) =3D r0;				\
 	r0 =3D *(u64*)(r10 - 8);				\
 	r0 &=3D 0xff;					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
index 52edee41caf6..5fa84834cba0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -50,7 +50,7 @@ __success __success_unpriv __retval(-1)
 __naked void ldsx_s32(void)
 {
 	asm volatile (
-	"r1 =3D 0xfffffffe;"
+	"r1 =3D -2;"
 	"*(u64 *)(r10 - 8) =3D r1;"
 #if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
 	"r0 =3D *(s32 *)(r10 - 8);"
diff --git a/tools/testing/selftests/bpf/progs/verifier_masking.c b/tools=
/testing/selftests/bpf/progs/verifier_masking.c
index 5732cc1b4c47..7581cd61241e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_masking.c
+++ b/tools/testing/selftests/bpf/progs/verifier_masking.c
@@ -171,7 +171,7 @@ __success __success_unpriv __retval(0)
 __naked void test_out_of_bounds_9(void)
 {
 	asm volatile ("					\
-	r1 =3D 0xffffffff;				\
+	r1 =3D -1;					\
 	w2 =3D %[__imm_0];				\
 	r2 -=3D r1;					\
 	r2 |=3D r1;					\
@@ -191,7 +191,7 @@ __success __success_unpriv __retval(0)
 __naked void test_out_of_bounds_10(void)
 {
 	asm volatile ("					\
-	r1 =3D 0xffffffff;				\
+	r1 =3D -1;					\
 	w2 =3D %[__imm_0];				\
 	r2 -=3D r1;					\
 	r2 |=3D r1;					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/t=
esting/selftests/bpf/progs/verifier_movsx.c
index a4d8814eb5ed..93b513ab7007 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -64,7 +64,7 @@ __success __success_unpriv __retval(-1)
 __naked void mov64sx_s32(void)
 {
 	asm volatile ("					\
-	r0 =3D 0xfffffffe;				\
+	r0 =3D -2;					\
 	r0 =3D (s32)r0;					\
 	r0 >>=3D 1;					\
 	exit;						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c b/to=
ols/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
index f37713a265ac..bee5363c1c08 100644
--- a/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
+++ b/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
@@ -11,7 +11,7 @@ __msg("R0 invalid mem access 'scalar'")
 __naked void or_jmp32_k(void)
 {
 	asm volatile ("					\
-	r0 =3D 0xffffffff;				\
+	r0 =3D -1;					\
 	r0 /=3D 1;					\
 	r1 =3D 0;						\
 	w1 =3D -1;					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/too=
ls/testing/selftests/bpf/progs/verifier_raw_stack.c
index c689665e07b9..0219d5890d7c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -280,9 +280,9 @@ __naked void load_bytes_invalid_access_3(void)
 	asm volatile ("					\
 	r2 =3D 4;						\
 	r6 =3D r10;					\
-	r6 +=3D 0xffffffff;				\
+	r6 +=3D -1;					\
 	r3 =3D r6;					\
-	r4 =3D 0xffffffff;				\
+	r4 =3D -1;					\
 	call %[bpf_skb_load_bytes];			\
 	r0 =3D *(u64*)(r6 + 0);				\
 	exit;						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c =
b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
index f40e57251e94..def73e133930 100644
--- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -253,14 +253,14 @@ l0_%=3D:	w3 /=3D 0;					\
 	*(u32*)(r10 - 8) =3D r7;				\
 	r8 =3D *(u64*)(r10 - 8);				\
 	/* if r8 !=3D X goto pc+1  r8 known in fallthrough branch */\
-	if r8 !=3D 0xffffffff goto l1_%=3D;			\
+	if r8 !=3D -1 goto l1_%=3D;				\
 	r3 =3D 1;						\
 l1_%=3D:	/* if r8 =3D=3D X goto pc+1  condition always true on first\
 	 * traversal, so starts backtracking to mark r8 as requiring\
 	 * precision. r7 marked as needing precision. r6 not marked\
 	 * since it's not tracked.			\
 	 */						\
-	if r8 =3D=3D 0xffffffff goto l2_%=3D;			\
+	if r8 =3D=3D -1 goto l2_%=3D;				\
 	/* fails if r8 correctly marked unknown after fill. */\
 	w3 /=3D 0;					\
 l2_%=3D:	r0 =3D 0;						\
@@ -324,7 +324,7 @@ __naked void and_register_parent_chain_bug(void)
 	/* if r0 > r6 goto +1 */			\
 	if r0 > r6 goto l0_%=3D;				\
 	/* *(u64 *)(r10 - 8) =3D 0xdeadbeef */		\
-	r0 =3D 0xdeadbeef;				\
+	r0 =3D -559038737;				\
 	*(u64*)(r10 - 8) =3D r0;				\
 l0_%=3D:	r1 =3D 42;					\
 	*(u8*)(r10 - 8) =3D r1;				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index 1e5a511e8494..78acd6360267 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -393,7 +393,7 @@ __naked void spill_32bit_of_64bit_fail(void)
 	call %[bpf_get_prandom_u32];			\
 	r0 &=3D 0x8;					\
 	/* Put a large number into r1. */		\
-	r1 =3D 0xffffffff;				\
+	r1 =3D -1;					\
 	r1 <<=3D 32;					\
 	r1 +=3D r0;					\
 	/* Assign an ID to r1. */			\
@@ -827,7 +827,7 @@ __naked void spill_64bit_of_64bit_ok(void)
 	asm volatile ("					\
 	/* Roll one bit to make the register inexact. */\
 	call %[bpf_get_prandom_u32];			\
-	r0 &=3D 0x80000000;				\
+	r0 &=3D -2147483648;				\
 	r0 <<=3D 32;					\
 	/* 64-bit spill r0 to stack - should assign an ID. */\
 	*(u64*)(r10 - 8) =3D r0;				\
@@ -1057,7 +1057,7 @@ __naked void fill_32bit_after_spill_64bit_clear_id(=
void)
 	call %[bpf_get_prandom_u32];			\
 	r0 &=3D 0x8;					\
 	/* Put a large number into r1. */		\
-	r1 =3D 0xffffffff;				\
+	r1 =3D -1;					\
 	r1 <<=3D 32;					\
 	r1 +=3D r0;					\
 	/* 64-bit spill r1 to stack - should assign an ID. */\
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 24aabc6083fd..1d05d5fe04bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -28,7 +28,7 @@ __naked void ptr_to_stack_store_load(void)
 	asm volatile ("					\
 	r1 =3D r10;					\
 	r1 +=3D -10;					\
-	r0 =3D 0xfaceb00c;				\
+	r0 =3D -87117812;					\
 	*(u64*)(r1 + 2) =3D r0;				\
 	r0 =3D *(u64*)(r1 + 2);				\
 	exit;						\
@@ -44,7 +44,7 @@ __naked void load_bad_alignment_on_off(void)
 	asm volatile ("					\
 	r1 =3D r10;					\
 	r1 +=3D -8;					\
-	r0 =3D 0xfaceb00c;				\
+	r0 =3D -87117812;					\
 	*(u64*)(r1 + 2) =3D r0;				\
 	r0 =3D *(u64*)(r1 + 2);				\
 	exit;						\
@@ -60,7 +60,7 @@ __naked void load_bad_alignment_on_reg(void)
 	asm volatile ("					\
 	r1 =3D r10;					\
 	r1 +=3D -10;					\
-	r0 =3D 0xfaceb00c;				\
+	r0 =3D -87117812;					\
 	*(u64*)(r1 + 8) =3D r0;				\
 	r0 =3D *(u64*)(r1 + 8);				\
 	exit;						\
@@ -76,7 +76,7 @@ __naked void load_out_of_bounds_low(void)
 	asm volatile ("					\
 	r1 =3D r10;					\
 	r1 +=3D -80000;					\
-	r0 =3D 0xfaceb00c;				\
+	r0 =3D -87117812;					\
 	*(u64*)(r1 + 8) =3D r0;				\
 	r0 =3D *(u64*)(r1 + 8);				\
 	exit;						\
@@ -92,7 +92,7 @@ __naked void load_out_of_bounds_high(void)
 	asm volatile ("					\
 	r1 =3D r10;					\
 	r1 +=3D -8;					\
-	r0 =3D 0xfaceb00c;				\
+	r0 =3D -87117812;					\
 	*(u64*)(r1 + 8) =3D r0;				\
 	r0 =3D *(u64*)(r1 + 8);				\
 	exit;						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/=
testing/selftests/bpf/progs/verifier_subreg.c
index 8613ea160dcd..23584d5880a4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -615,7 +615,7 @@ __naked void ldx_b_zero_extend_check(void)
 	asm volatile ("					\
 	r6 =3D r10;					\
 	r6 +=3D -4;					\
-	r7 =3D 0xfaceb00c;				\
+	r7 =3D -87117812;					\
 	*(u32*)(r6 + 0) =3D r7;				\
 	call %[bpf_get_prandom_u32];			\
 	r1 =3D 0x1000000000 ll;				\
@@ -636,7 +636,7 @@ __naked void ldx_h_zero_extend_check(void)
 	asm volatile ("					\
 	r6 =3D r10;					\
 	r6 +=3D -4;					\
-	r7 =3D 0xfaceb00c;				\
+	r7 =3D -87117812;					\
 	*(u32*)(r6 + 0) =3D r7;				\
 	call %[bpf_get_prandom_u32];			\
 	r1 =3D 0x1000000000 ll;				\
@@ -657,7 +657,7 @@ __naked void ldx_w_zero_extend_check(void)
 	asm volatile ("					\
 	r6 =3D r10;					\
 	r6 +=3D -4;					\
-	r7 =3D 0xfaceb00c;				\
+	r7 =3D -87117812;					\
 	*(u32*)(r6 + 0) =3D r7;				\
 	call %[bpf_get_prandom_u32];			\
 	r1 =3D 0x1000000000 ll;				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
index 4470541b5e71..cfe7c013ec2b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -776,7 +776,7 @@ __naked void unpriv_spec_v1_type_confusion(void)
 	r6 =3D r10;					\
 	r6 +=3D -8;					\
 	/* r6: pointer to readable stack slot */	\
-	r9 =3D 0xffffc900;				\
+	r9 =3D -14080;					\
 	r9 <<=3D 32;					\
 	/* r9: scalar controlled by attacker */		\
 	r0 =3D *(u64 *)(r0 + 0); /* cache miss */		\
--=20
2.47.1


