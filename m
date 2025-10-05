Return-Path: <bpf+bounces-70400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB49BB9598
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 12:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013A61897149
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 10:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB4D238C0A;
	Sun,  5 Oct 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="X1F35vR1"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF635949
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759661116; cv=none; b=Y1uSR50l+2PwYu5JS0DSUQZp+aCsLVH8S48M1ejrlsmiaCu043CX5BRi9E4WdK570EMcFSqUraJRZ5jtX+OIy6+qWt5rsstmgvQZ8nQ0lBRzFMnJbHcnGlDZ4C5mHrU1H1tk0eY0ggdj5/o1NTLc0TsP/oOGDzx15p79/NsSm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759661116; c=relaxed/simple;
	bh=RaEeNmedz8apFntNe4h0na+6oqupULgXN5lZyQSaJBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsONkEkGf9WnugdJRwg0UeUOrY3NQQb8yZimmhrvFH2LEpmYWG0aarVPjbkWC2payZepEd46AoxX3cmmmY4lNs6YHFjt5mW2HTfcGi7ns0+SHQ3TLKXfEGdO8wptug9g2s00nSFm4Olz55ocJoHFV0wpTgD5ctaMwJLSM/QNqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=X1F35vR1; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1759661112; bh=W4zAd3n/TZwNV1i6kGSPOeB5Z8d33z+uCjDNOtVIBR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=X1F35vR12zJyiwiGFV3nfh2dFKOF6E60oU32BYd0rfgG/XPp+rBv6Txn9AceeJocP
	 oBVGtxQVkwr4qgj9mli1rUS5gSqy3QtblvNhh0R/pXlGAXanfME95DZ5FV8LbYFrOo
	 +z/dvokwvZ8jWwLeHzR8mlxtYhckofcYWmuSSP2ukpLoVirVG13+EVNNe1N9YpzCZz
	 AqKv4iLqT+fB+ub65Dcu/VGhicXQFabms0ZiDwcZiWwyzp2vSDTgpDnUyzSx0LBS5o
	 koP7Lp2n8IAVxq5xs+glBIYnk3/JT5oxpeXOLnvraWCkDifqgQgjDBDZZAhsRpfNlJ
	 xUulb76dBvXxA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4cffDm2ZT7z8sfZ;
	Sun,  5 Oct 2025 12:45:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3632:e00:f174:1ae7:eb66:61e6
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3632:e00:f174:1ae7:eb66:61e6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19bAy/f62/7zjyX5SuvilHRALqnARDxk60=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4cffDh68LNz8sm9;
	Sun,  5 Oct 2025 12:45:08 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: luis.gerhorst@fau.de
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	eddyz87@gmail.com,
	hengqi.chen@gmail.com,
	yangtiezhu@loongson.cn,
	yonghong.song@linux.dev
Subject: [RFC 3/3] selftests/bpf: Add missing SPEC_V1-ifdefs
Date: Sun,  5 Oct 2025 12:45:00 +0200
Message-ID: <20251005104500.999626-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87plb17ijl.fsf@fau.de>
References: <87plb17ijl.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For errors that only occur if bpf_jit_bypass_spec_v1() is set (e.g., on
LoongArch), add the missing '#ifdef SPEC_V1' to the selftests.

Fixes: 03c68a0f8c68 ("bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()")
Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
Closes: https://lore.kernel.org/bpf/CAEyhmHTvj4cDRfu1FXSEXmdCqyWfs3ehw5gtB9qJCrThuUy2Kw@mail.gmail.com/
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 .../selftests/bpf/progs/verifier_bounds.c     |  6 ++++
 .../verifier_direct_stack_access_wraparound.c |  2 ++
 .../bpf/progs/verifier_map_ptr_mixing.c       |  5 +++-
 .../bpf/progs/verifier_runtime_jit.c          | 12 ++++++--
 .../selftests/bpf/progs/verifier_stack_ptr.c  | 30 ++++++++++++++++---
 .../selftests/bpf/progs/verifier_unpriv.c     | 12 +++++---
 .../bpf/progs/verifier_value_ptr_arith.c      | 30 +++++++++++++++----
 .../selftests/bpf/progs/verifier_var_off.c    | 25 ++++++++++++----
 8 files changed, 100 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index a8fc9b38633b..033211c3f486 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -48,7 +48,9 @@ SEC("socket")
 __description("subtraction bounds (map value) variant 2")
 __failure
 __msg("R0 min value is negative, either use unsigned index or do a if (index >=0) check.")
+#ifdef SPEC_V1
 __msg_unpriv("R0 pointer arithmetic of map value goes out of range, prohibited for !root")
+#endif
 __naked void bounds_map_value_variant_2(void)
 {
 	/* unpriv: nospec inserted to prevent "R1 has unknown scalar with mixed
@@ -545,7 +547,9 @@ l1_%=:	exit;						\
 SEC("socket")
 __description("bounds check map access with off+size signed 32bit overflow. test2")
 __failure __msg("pointer offset 1073741822")
+#ifdef SPEC_V1
 __msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+#endif
 __naked void size_signed_32bit_overflow_test2(void)
 {
 	asm volatile ("					\
@@ -572,7 +576,9 @@ l1_%=:	exit;						\
 SEC("socket")
 __description("bounds check map access with off+size signed 32bit overflow. test3")
 __failure __msg("pointer offset -1073741822")
+#ifdef SPEC_V1
 __msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+#endif
 __naked void size_signed_32bit_overflow_test3(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c b/tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c
index c538c6893552..5f39ceb6ce2b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_stack_access_wraparound.c
@@ -40,7 +40,9 @@ __naked void with_32_bit_wraparound_test2(void)
 SEC("socket")
 __description("direct stack access with 32-bit wraparound. test3")
 __failure __msg("fp pointer offset 1073741822")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void with_32_bit_wraparound_test3(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c
index c5a7c1ddc562..2a380a5f52b0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c
@@ -218,7 +218,10 @@ void lookup_hash_map_in_map__2(void)
 
 SEC("socket")
 __description("cond: two branches returning different map pointers for lookup (tail, tail)")
-__success __failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+#endif
 __retval(42)
 __naked void pointers_for_lookup_tail_tail_1(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_runtime_jit.c b/tools/testing/selftests/bpf/progs/verifier_runtime_jit.c
index 27ebfc1fd9ee..ab093d0930c6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_runtime_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_runtime_jit.c
@@ -252,7 +252,10 @@ l1_%=:	call %[bpf_tail_call];				\
 
 SEC("socket")
 __description("runtime/jit: tail_call within bounds, different maps, first branch")
-__success __failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+#endif
 __retval(1)
 __naked void bounds_different_maps_first_branch(void)
 {
@@ -279,7 +282,10 @@ l1_%=:	call %[bpf_tail_call];				\
 
 SEC("socket")
 __description("runtime/jit: tail_call within bounds, different maps, second branch")
-__success __failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+#endif
 __retval(42)
 __naked void bounds_different_maps_second_branch(void)
 {
@@ -341,8 +347,10 @@ __naked void negative_index_to_tail_call(void)
 SEC("socket")
 __description("runtime/jit: pass > 32bit index to tail_call")
 __success __success_unpriv __retval(42)
+#ifdef SPEC_V1
 /* Verifier rewrite for unpriv skips tail call here. */
 __retval_unpriv(2)
+#endif
 __naked void _32bit_index_to_tail_call(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 24aabc6083fd..ed74bd593a0f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -70,7 +70,9 @@ __naked void load_bad_alignment_on_reg(void)
 SEC("socket")
 __description("PTR_TO_STACK store/load - out of bounds low")
 __failure __msg("invalid write to stack R1 off=-79992 size=8")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void load_out_of_bounds_low(void)
 {
 	asm volatile ("					\
@@ -130,8 +132,10 @@ __naked void to_stack_check_high_2(void)
 
 SEC("socket")
 __description("PTR_TO_STACK check high 3")
-__success __failure_unpriv
-__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __retval(42)
 __naked void to_stack_check_high_3(void)
 {
@@ -148,7 +152,9 @@ __naked void to_stack_check_high_3(void)
 SEC("socket")
 __description("PTR_TO_STACK check high 4")
 __failure __msg("invalid write to stack R1 off=0 size=1")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void to_stack_check_high_4(void)
 {
 	asm volatile ("					\
@@ -164,7 +170,9 @@ __naked void to_stack_check_high_4(void)
 SEC("socket")
 __description("PTR_TO_STACK check high 5")
 __failure __msg("invalid write to stack R1")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void to_stack_check_high_5(void)
 {
 	asm volatile ("					\
@@ -182,7 +190,9 @@ __naked void to_stack_check_high_5(void)
 SEC("socket")
 __description("PTR_TO_STACK check high 6")
 __failure __msg("invalid write to stack")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void to_stack_check_high_6(void)
 {
 	asm volatile ("					\
@@ -201,7 +211,9 @@ __naked void to_stack_check_high_6(void)
 SEC("socket")
 __description("PTR_TO_STACK check high 7")
 __failure __msg("fp pointer offset")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void to_stack_check_high_7(void)
 {
 	asm volatile ("					\
@@ -235,8 +247,10 @@ __naked void to_stack_check_low_1(void)
 
 SEC("socket")
 __description("PTR_TO_STACK check low 2")
-__success __failure_unpriv
-__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __retval(42)
 __naked void to_stack_check_low_2(void)
 {
@@ -253,7 +267,9 @@ __naked void to_stack_check_low_2(void)
 SEC("socket")
 __description("PTR_TO_STACK check low 3")
 __failure __msg("invalid write to stack R1 off=-513 size=1")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void to_stack_check_low_3(void)
 {
 	asm volatile ("					\
@@ -287,7 +303,9 @@ __naked void to_stack_check_low_4(void)
 SEC("socket")
 __description("PTR_TO_STACK check low 5")
 __failure __msg("invalid write to stack")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void to_stack_check_low_5(void)
 {
 	asm volatile ("					\
@@ -305,7 +323,9 @@ __naked void to_stack_check_low_5(void)
 SEC("socket")
 __description("PTR_TO_STACK check low 6")
 __failure __msg("invalid write to stack")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void to_stack_check_low_6(void)
 {
 	asm volatile ("					\
@@ -324,7 +344,9 @@ __naked void to_stack_check_low_6(void)
 SEC("socket")
 __description("PTR_TO_STACK check low 7")
 __failure __msg("fp pointer offset")
+#ifdef SPEC_V1
 __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __naked void to_stack_check_low_7(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 28b4f7035ceb..4022a12f19c6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -699,8 +699,10 @@ l0_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("unpriv: adding of fp, reg")
-__success __failure_unpriv
-__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __retval(0)
 __naked void unpriv_adding_of_fp_reg(void)
 {
@@ -715,8 +717,10 @@ __naked void unpriv_adding_of_fp_reg(void)
 
 SEC("socket")
 __description("unpriv: adding of fp, imm")
-__success __failure_unpriv
-__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("R1 stack pointer arithmetic goes out of range")
+#endif
 __retval(0)
 __naked void unpriv_adding_of_fp_imm(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index b545f2b420b8..933b44d41c80 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -379,8 +379,10 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr -= known scalar from different maps")
-__success __failure_unpriv
-__msg_unpriv("R0 min value is outside of the allowed memory range")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("R0 min value is outside of the allowed memory range")
+#endif
 __retval(1)
 __naked void known_scalar_from_different_maps(void)
 {
@@ -669,8 +671,11 @@ __naked void alu_with_different_scalars_3(void)
 
 SEC("socket")
 __description("map access: value_ptr += known scalar, upper oob arith, test 1")
-__success __failure_unpriv
+__success 
+#ifdef SPEC_V1
+__failure_unpriv
 __msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+#endif
 __retval(1)
 __naked void upper_oob_arith_test_1(void)
 {
@@ -696,8 +701,11 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr += known scalar, upper oob arith, test 2")
-__success __failure_unpriv
+__success 
+#ifdef SPEC_V1
+__failure_unpriv
 __msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+#endif
 __retval(1)
 __naked void upper_oob_arith_test_2(void)
 {
@@ -749,8 +757,10 @@ l0_%=:	r0 = 1;						\
 SEC("socket")
 __description("map access: value_ptr -= known scalar, lower oob arith, test 1")
 __failure __msg("R0 min value is outside of the allowed memory range")
+#ifdef SPEC_V1
 __failure_unpriv
 __msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+#endif
 __naked void lower_oob_arith_test_1(void)
 {
 	asm volatile ("					\
@@ -776,8 +786,11 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: value_ptr -= known scalar, lower oob arith, test 2")
-__success __failure_unpriv
+__success
+#ifdef SPEC_V1
+__failure_unpriv
 __msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+#endif
 __retval(1)
 __naked void lower_oob_arith_test_2(void)
 {
@@ -1084,8 +1097,11 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("map access: unknown scalar += value_ptr, 3")
-__success __failure_unpriv
+__success
+#ifdef SPEC_V1
+__failure_unpriv
 __msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+#endif
 __retval(0xabcdef12) __flag(BPF_F_ANY_ALIGNMENT)
 __naked void unknown_scalar_value_ptr_3(void)
 {
@@ -1115,7 +1131,9 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("map access: unknown scalar += value_ptr, 4")
 __failure __msg("R1 max value is outside of the allowed memory range")
+#ifdef SPEC_V1
 __msg_unpriv("R1 pointer arithmetic of map value goes out of range")
+#endif
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void unknown_scalar_value_ptr_4(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index f345466bca68..042f2cafc576 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -34,8 +34,10 @@ __naked void variable_offset_ctx_access(void)
 
 SEC("cgroup/skb")
 __description("variable-offset stack read, priv vs unpriv")
-__success __failure_unpriv
-__msg_unpriv("R2 variable stack access prohibited for !root")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+#endif
 __retval(0)
 __naked void stack_read_priv_vs_unpriv(void)
 {
@@ -62,7 +64,9 @@ __naked void stack_read_priv_vs_unpriv(void)
 SEC("cgroup/skb")
 __description("variable-offset stack read, uninitialized")
 __success
+#ifdef SPEC_V1
 __failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+#endif
 __naked void variable_offset_stack_read_uninitialized(void)
 {
 	asm volatile ("					\
@@ -89,10 +93,13 @@ __success
  * maximum possible variable offset.
  */
 __log_level(4) __msg("stack depth 16")
+#ifdef SPEC_V1
 __failure_unpriv
-/* Variable stack access is rejected for unprivileged.
+/* Variable stack access is rejected for unprivileged due to Spectre v1
+ * mitigations.
  */
 __msg_unpriv("R2 variable stack access prohibited for !root")
+#endif
 __retval(0)
 __naked void stack_write_priv_vs_unpriv(void)
 {
@@ -129,8 +136,10 @@ __success
  * maximum possible variable offset.
  */
 __log_level(4) __msg("stack depth 16")
+#ifdef SPEC_V1
 __failure_unpriv
 __msg_unpriv("R2 variable stack access prohibited for !root")
+#endif
 __retval(0)
 __naked void stack_write_followed_by_read(void)
 {
@@ -163,11 +172,13 @@ __failure
  * of the spilled register when we analyze the write).
  */
 __msg("R2 invalid mem access 'scalar'")
+#ifdef SPEC_V1
 __failure_unpriv
 /* The unprivileged case is not too interesting; variable
  * stack access is rejected.
  */
 __msg_unpriv("R2 variable stack access prohibited for !root")
+#endif
 __naked void stack_write_clobbers_spilled_regs(void)
 {
 	asm volatile ("					\
@@ -324,7 +335,9 @@ __naked void access_min_out_of_bound(void)
 SEC("cgroup/skb")
 __description("indirect variable-offset stack access, min_off < min_initialized")
 __success
+#ifdef SPEC_V1
 __failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+#endif
 __naked void access_min_off_min_initialized(void)
 {
 	asm volatile ("					\
@@ -353,8 +366,10 @@ __naked void access_min_off_min_initialized(void)
 
 SEC("cgroup/skb")
 __description("indirect variable-offset stack access, priv vs unpriv")
-__success __failure_unpriv
-__msg_unpriv("R2 variable stack access prohibited for !root")
+__success
+#ifdef SPEC_V1
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+#endif
 __retval(0)
 __naked void stack_access_priv_vs_unpriv(void)
 {
-- 
2.51.0


