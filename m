Return-Path: <bpf+bounces-79431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B433D3A236
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70180300E4C5
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07108352924;
	Mon, 19 Jan 2026 08:56:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C86350A1B
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812964; cv=none; b=aytKDo4cEnCNB2vyi1OsBQ8BfN1HINtMK2y5EdbqbcRWp1YMAJp7HejcBKxeQdS7Ruig1Ll+AWiqcD0whks5HltKZApquCqtHRHOfbqYXZrwa228gxnl6ddVMjxpo3vlqWk3RnVgy4lS60b6oO8Ud7GuiTZSSb+kT87CyAi38T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812964; c=relaxed/simple;
	bh=8Y5gw8lvBHJMsKlqclhNkcPtMmtIM6TbbdOifNgfsxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrHJuoGBsT0//rPJd67fhrmXuVEROSx8oKbJEnWcpccAWVofRQ4yPuWpUTF8tCr8vZRmLaURj2qg/HlRymSqEnuB+Xy9rWhSOcPtd5XLnSp1b4R18hPNl4GhJ+gDlS01A6ONYAX+L5eZStYBJl/6E9ttKfG969l5TpGMqyiYo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.146.110])
	by mtasvr (Coremail) with SMTP id _____wDHGFyB8W1p5_wUAA--.2263S3;
	Mon, 19 Jan 2026 16:55:29 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.146.110])
	by mail-app4 (Coremail) with SMTP id zi_KCgCHaH998W1pMWzDBA--.58179S2;
	Mon, 19 Jan 2026 16:55:25 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add tests for BPF_DIV and BPF_MOD range tracking
Date: Mon, 19 Jan 2026 16:54:58 +0800
Message-ID: <20260119085458.182221-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
References: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCHaH998W1pMWzDBA--.58179S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgsQCmltN4Ud8AABsJ
X-CM-DELIVERINFO: =?B?LS/zuwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9LSQH5k6yERQEnmROljT+VcdUZon8HfEN+F7O9peqs7aL3VM8EMqF/57R/SdRtSKLK7G
	4kGgHvgWoZqj/M95vC0VCZCQJCiSv4mTk/AKttlqw4s/naP1niUQXy1fD1OuTw==
X-Coremail-Antispam: 1Uk129KBj9fXoWfZr47Jr1DJryDJFyfZr1xCrX_yoW5Zry5Zo
	W5u39rX3yrKr1FgFWq9FWSgr17X3W3K34kJ343Kr15Ga1xJ3ykA348Can8ur1F9r17ZFZ5
	Zay5Gr1Svw45Janrl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYp7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07URlksUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

Now BPF_DIV has range tracking support via interval analysis. This patch
adds selftests to cover various cases of BPF_DIV and BPF_MOD operations
when the divisor is a constant, also covering both signed and unsigned variants.

This patch includes several types of tests in 32-bit and 64-bit variants:

1. For UDIV
   - positive divisor
   - zero divisor

2. For SDIV
   - positive divisor, positive dividend
   - positive divisor, negative dividend
   - positive divisor, mixed sign dividend
   - negative divisor, positive dividend
   - negative divisor, negative dividend
   - negative divisor, mixed sign dividend
   - zero divisor
   - overflow (SIGNED_MIN/-1), normal dividend
   - overflow (SIGNED_MIN/-1), constant dividend

3. For UMOD
   - positive divisor
   - positive divisor, small dividend
   - zero divisor

4. For SMOD
   - positive divisor, positive dividend
   - positive divisor, negative dividend
   - positive divisor, mixed sign dividend
   - positive divisor, mixed sign dividend, small dividend
   - negative divisor, positive dividend
   - negative divisor, negative dividend
   - negative divisor, mixed sign dividend
   - negative divisor, mixed sign dividend, small dividend
   - zero divisor
   - overflow (SIGNED_MIN/-1), normal dividend
   - overflow (SIGNED_MIN/-1), constant dividend

Specifically, these selftests are based on dead code elimination:
If the BPF verifier can precisely analyze the result of BPF_DIV/BPF_MOD
instruction, it can prune the path that leads to an error (here we use
invalid memory access as the error case), allowing the program to pass
verification.

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../bpf/progs/verifier_div_mod_bounds.c       | 1149 +++++++++++++++++
 2 files changed, 1151 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 38c5ba70100c..fa9e506cc36f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -33,6 +33,7 @@
 #include "verifier_direct_packet_access.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
+#include "verifier_div_mod_bounds.skel.h"
 #include "verifier_div_overflow.skel.h"
 #include "verifier_global_subprogs.skel.h"
 #include "verifier_global_ptr_args.skel.h"
@@ -175,6 +176,7 @@ void test_verifier_d_path(void)               { RUN(verifier_d_path); }
 void test_verifier_direct_packet_access(void) { RUN(verifier_direct_packet_access); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
+void test_verifier_div_mod_bounds(void)       { RUN(verifier_div_mod_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c b/tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c
new file mode 100644
index 000000000000..4672af0b3268
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c
@@ -0,0 +1,1149 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <limits.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* This file contains unit tests for signed/unsigned division and modulo
+ * operations (with divisor as a constant), focusing on verifying whether
+ * BPF verifier's range tracking module soundly and precisely computes
+ * the results.
+ */
+
+SEC("socket")
+__description("UDIV32, positive divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 /= 3 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3))")
+__naked void udiv32_pos_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w1 /= 3;					\
+	if w1 > 3 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UDIV32, zero divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 /= w2 {{.*}}; R1=0 R2=0")
+__naked void udiv32_zero_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w2 = 0;						\
+	w1 /= w2;					\
+	if w1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UDIV64, positive divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 /= 3 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3))")
+__naked void udiv64_pos_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r1 /= 3;					\
+	if r1 > 3 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UDIV64, zero divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 /= r2 {{.*}}; R1=0 R2=0")
+__naked void udiv64_zero_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r2 = 0;						\
+	r1 /= r2;					\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, positive divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= 3 {{.*}}; R1=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=3,var_off=(0x2; 0x1))")
+__naked void sdiv32_pos_divisor_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< 8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s/= 3;					\
+	if w1 s< 2 goto l1_%=;				\
+	if w1 s> 3 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, positive divisor, negative dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= 3 {{.*}}; R1=scalar(smin=umin=umin32=0xfffffffd,smax=umax=umax32=0xfffffffe,smin32=-3,smax32=-2,var_off=(0xfffffffc; 0x3))")
+__naked void sdiv32_pos_divisor_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s> -8 goto l0_%=;				\
+	if w1 s< -10 goto l0_%=;			\
+	w1 s/= 3;					\
+	if w1 s< -3 goto l1_%=;				\
+	if w1 s> -2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, positive divisor, mixed sign dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= 3 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=3,var_off=(0x0; 0xffffffff))")
+__naked void sdiv32_pos_divisor_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< -8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s/= 3;					\
+	if w1 s< -2 goto l1_%=;				\
+	if w1 s> 3 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, negative divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= -3 {{.*}}; R1=scalar(smin=umin=umin32=0xfffffffd,smax=umax=umax32=0xfffffffe,smin32=-3,smax32=-2,var_off=(0xfffffffc; 0x3))")
+__naked void sdiv32_neg_divisor_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< 8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s/= -3;					\
+	if w1 s< -3 goto l1_%=;				\
+	if w1 s> -2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, negative divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= -3 {{.*}}; R1=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=3,var_off=(0x2; 0x1))")
+__naked void sdiv32_neg_divisor_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s> -8 goto l0_%=;				\
+	if w1 s< -10 goto l0_%=;			\
+	w1 s/= -3;					\
+	if w1 s< 2 goto l1_%=;				\
+	if w1 s> 3 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, negative divisor, mixed sign dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= -3 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-3,smax32=2,var_off=(0x0; 0xffffffff))")
+__naked void sdiv32_neg_divisor_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< -8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s/= -3;					\
+	if w1 s< -3 goto l1_%=;				\
+	if w1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, zero divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= w2 {{.*}}; R1=0 R2=0")
+__naked void sdiv32_zero_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w2 = 0;						\
+	w1 s/= w2;					\
+	if w1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, overflow (S32_MIN/-1)")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= -1 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__naked void sdiv32_overflow_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w2 = %[int_min];				\
+	w2 += 10;					\
+	if w1 s> w2 goto l0_%=;				\
+	w1 s/= -1;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, overflow (S32_MIN/-1), constant dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= -1 {{.*}}; R1=0x80000000")
+__naked void sdiv32_overflow_2(void)
+{
+	asm volatile ("					\
+	w1 = %[int_min];				\
+	w1 s/= -1;					\
+	if w1 != %[int_min] goto l0_%=;			\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, positive divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= 3 {{.*}}; R1=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=3,var_off=(0x2; 0x1))")
+__naked void sdiv64_pos_divisor_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< 8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s/= 3;					\
+	if r1 s< 2 goto l1_%=;				\
+	if r1 s> 3 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, positive divisor, negative dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= 3 {{.*}}; R1=scalar(smin=smin32=-3,smax=smax32=-2,umin=0xfffffffffffffffd,umax=0xfffffffffffffffe,umin32=0xfffffffd,umax32=0xfffffffe,var_off=(0xfffffffffffffffc; 0x3))")
+__naked void sdiv64_pos_divisor_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s> -8 goto l0_%=;				\
+	if r1 s< -10 goto l0_%=;			\
+	r1 s/= 3;					\
+	if r1 s< -3 goto l1_%=;				\
+	if r1 s> -2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, positive divisor, mixed sign dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= 3 {{.*}}; R1=scalar(smin=smin32=-2,smax=smax32=3)")
+__naked void sdiv64_pos_divisor_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< -8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s/= 3;					\
+	if r1 s< -2 goto l1_%=;				\
+	if r1 s> 3 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, negative divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= -3 {{.*}}; R1=scalar(smin=smin32=-3,smax=smax32=-2,umin=0xfffffffffffffffd,umax=0xfffffffffffffffe,umin32=0xfffffffd,umax32=0xfffffffe,var_off=(0xfffffffffffffffc; 0x3))")
+__naked void sdiv64_neg_divisor_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< 8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s/= -3;					\
+	if r1 s< -3 goto l1_%=;				\
+	if r1 s> -2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, negative divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= -3 {{.*}}; R1=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=3,var_off=(0x2; 0x1))")
+__naked void sdiv64_neg_divisor_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s> -8 goto l0_%=;				\
+	if r1 s< -10 goto l0_%=;			\
+	r1 s/= -3;					\
+	if r1 s< 2 goto l1_%=;				\
+	if r1 s> 3 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, negative divisor, mixed sign dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= -3 {{.*}}; R1=scalar(smin=smin32=-3,smax=smax32=2)")
+__naked void sdiv64_neg_divisor_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< -8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s/= -3;					\
+	if r1 s< -3 goto l1_%=;				\
+	if r1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, zero divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= r2 {{.*}}; R1=0 R2=0")
+__naked void sdiv64_zero_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r2 = 0;						\
+	r1 s/= r2;					\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, overflow (S64_MIN/-1)")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= -1 {{.*}}; R1=scalar()")
+__naked void sdiv64_overflow_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	r1 = r0;					\
+	r2 = %[llong_min] ll;				\
+	r2 += 10;					\
+	if r1 s> r2 goto l0_%=;				\
+	r1 s/= -1;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, overflow (S64_MIN/-1), constant dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= -1 {{.*}}; R1=0x8000000000000000")
+__naked void sdiv64_overflow_2(void)
+{
+	asm volatile ("					\
+	r1 = %[llong_min] ll;				\
+	r1 s/= -1;					\
+	r2 = %[llong_min] ll;				\
+	if r1 != r2 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UMOD32, positive divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 %= 3 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3))")
+__naked void umod32_pos_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w1 %%= 3;					\
+	if w1 > 3 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UMOD32, positive divisor, small dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 %= 10 {{.*}}; R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=9,var_off=(0x1; 0x8))")
+__naked void umod32_pos_divisor_unchanged(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w1 %%= 10;					\
+	if w1 < 1 goto l0_%=;				\
+	if w1 > 9 goto l0_%=;				\
+	if w1 & 1 != 1 goto l0_%=;			\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UMOD32, zero divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 %= w2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=9,var_off=(0x1; 0x8)) R2=0")
+__naked void umod32_zero_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w2 = 0;						\
+	w1 %%= w2;					\
+	if w1 < 1 goto l0_%=;				\
+	if w1 > 9 goto l0_%=;				\
+	if w1 & 1 != 1 goto l0_%=;			\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UMOD64, positive divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 %= 3 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3))")
+__naked void umod64_pos_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r1 %%= 3;					\
+	if r1 > 3 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UMOD64, positive divisor, small dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 %= 10 {{.*}}; R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=9,var_off=(0x1; 0x8))")
+__naked void umod64_pos_divisor_unchanged(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r1 %%= 10;					\
+	if r1 < 1 goto l0_%=;				\
+	if r1 > 9 goto l0_%=;				\
+	if r1 & 1 != 1 goto l0_%=;			\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UMOD64, zero divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 %= r2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=9,var_off=(0x1; 0x8)) R2=0")
+__naked void umod64_zero_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r2 = 0;						\
+	r1 %%= r2;					\
+	if r1 < 1 goto l0_%=;				\
+	if r1 > 9 goto l0_%=;				\
+	if r1 & 1 != 1 goto l0_%=;			\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, positive divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= 3 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3))")
+__naked void smod32_pos_divisor_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< 8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s%%= 3;					\
+	if w1 s< 0 goto l1_%=;				\
+	if w1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, positive divisor, negative dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= 3 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff))")
+__naked void smod32_pos_divisor_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s> -8 goto l0_%=;				\
+	if w1 s< -10 goto l0_%=;			\
+	w1 s%%= 3;					\
+	if w1 s< -2 goto l1_%=;				\
+	if w1 s> 0 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, positive divisor, mixed sign dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= 3 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=2,var_off=(0x0; 0xffffffff))")
+__naked void smod32_pos_divisor_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< -8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s%%= 3;					\
+	if w1 s< -2 goto l1_%=;				\
+	if w1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, positive divisor, small dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= 11 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-8,smax32=10,var_off=(0x0; 0xffffffff))")
+__naked void smod32_pos_divisor_unchanged(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< -8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s%%= 11;					\
+	if w1 s< -8 goto l1_%=;				\
+	if w1 s> 10 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, negative divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= -3 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3))")
+__naked void smod32_neg_divisor_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< 8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s%%= -3;					\
+	if w1 s< 0 goto l1_%=;				\
+	if w1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, negative divisor, negative dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= -3 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=0,var_off=(0x0; 0xffffffff))")
+__naked void smod32_neg_divisor_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s> -8 goto l0_%=;				\
+	if w1 s< -10 goto l0_%=;			\
+	w1 s%%= -3;					\
+	if w1 s< -2 goto l1_%=;				\
+	if w1 s> 0 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, negative divisor, mixed sign dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= -3 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-2,smax32=2,var_off=(0x0; 0xffffffff))")
+__naked void smod32_neg_divisor_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< -8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s%%= -3;					\
+	if w1 s< -2 goto l1_%=;				\
+	if w1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, negative divisor, small dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= -11 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-8,smax32=10,var_off=(0x0; 0xffffffff))")
+__naked void smod32_neg_divisor_unchanged(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< -8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w1 s%%= -11;					\
+	if w1 s< -8 goto l1_%=;				\
+	if w1 s> 10 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, zero divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= w2 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-8,smax32=10,var_off=(0x0; 0xffffffff)) R2=0")
+__naked void smod32_zero_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 s< -8 goto l0_%=;				\
+	if w1 s> 10 goto l0_%=;				\
+	w2 = 0;						\
+	w1 s%%= w2;					\
+	if w1 s< -8 goto l1_%=;				\
+	if w1 s> 10 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, overflow (S32_MIN%-1)")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= -1 {{.*}}; R1=0")
+__naked void smod32_overflow_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w2 = %[int_min];				\
+	w2 += 10;					\
+	if w1 s> w2 goto l0_%=;				\
+	w1 s%%= -1;					\
+	if w1 != 0 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, overflow (S32_MIN%-1), constant dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s%= -1 {{.*}}; R1=0")
+__naked void smod32_overflow_2(void)
+{
+	asm volatile ("					\
+	w1 = %[int_min];				\
+	w1 s%%= -1;					\
+	if w1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, positive divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= 3 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3))")
+__naked void smod64_pos_divisor_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< 8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s%%= 3;					\
+	if r1 s< 0 goto l1_%=;				\
+	if r1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, positive divisor, negative dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= 3 {{.*}}; R1=scalar(smin=smin32=-2,smax=smax32=0)")
+__naked void smod64_pos_divisor_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s> -8 goto l0_%=;				\
+	if r1 s< -10 goto l0_%=;			\
+	r1 s%%= 3;					\
+	if r1 s< -2 goto l1_%=;				\
+	if r1 s> 0 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, positive divisor, mixed sign dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= 3 {{.*}}; R1=scalar(smin=smin32=-2,smax=smax32=2)")
+__naked void smod64_pos_divisor_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< -8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s%%= 3;					\
+	if r1 s< -2 goto l1_%=;				\
+	if r1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, positive divisor, small dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= 11 {{.*}}; R1=scalar(smin=smin32=-8,smax=smax32=10)")
+__naked void smod64_pos_divisor_unchanged(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< -8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s%%= 11;					\
+	if r1 s< -8 goto l1_%=;				\
+	if r1 s> 10 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, negative divisor, positive dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= -3 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3))")
+__naked void smod64_neg_divisor_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< 8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s%%= -3;					\
+	if r1 s< 0 goto l1_%=;				\
+	if r1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, negative divisor, negative dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= -3 {{.*}}; R1=scalar(smin=smin32=-2,smax=smax32=0)")
+__naked void smod64_neg_divisor_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s> -8 goto l0_%=;				\
+	if r1 s< -10 goto l0_%=;			\
+	r1 s%%= -3;					\
+	if r1 s< -2 goto l1_%=;				\
+	if r1 s> 0 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, negative divisor, mixed sign dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= -3 {{.*}}; R1=scalar(smin=smin32=-2,smax=smax32=2)")
+__naked void smod64_neg_divisor_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< -8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s%%= -3;					\
+	if r1 s< -2 goto l1_%=;				\
+	if r1 s> 2 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, negative divisor, small dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= -11 {{.*}}; R1=scalar(smin=smin32=-8,smax=smax32=10)")
+__naked void smod64_neg_divisor_unchanged(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< -8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r1 s%%= -11;					\
+	if r1 s< -8 goto l1_%=;				\
+	if r1 s> 10 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, zero divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= r2 {{.*}}; R1=scalar(smin=smin32=-8,smax=smax32=10) R2=0")
+__naked void smod64_zero_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r1 s< -8 goto l0_%=;				\
+	if r1 s> 10 goto l0_%=;				\
+	r2 = 0;						\
+	r1 s%%= r2;					\
+	if r1 s< -8 goto l1_%=;				\
+	if r1 s> 10 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, overflow (S64_MIN%-1)")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= -1 {{.*}}; R1=0")
+__naked void smod64_overflow_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	r1 = r0;					\
+	r2 = %[llong_min] ll;				\
+	r2 += 10;					\
+	if r1 s> r2 goto l0_%=;				\
+	r1 s%%= -1;					\
+	if r1 != 0 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, overflow (S64_MIN%-1), constant dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s%= -1 {{.*}}; R1=0")
+__naked void smod64_overflow_2(void)
+{
+	asm volatile ("					\
+	r1 = %[llong_min] ll;				\
+	r1 s%%= -1;					\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
-- 
2.52.0


