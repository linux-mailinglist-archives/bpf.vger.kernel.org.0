Return-Path: <bpf+bounces-77358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC81CCD8889
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 10:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6253046FAE
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8273254BC;
	Tue, 23 Dec 2025 09:12:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315C30C614
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481155; cv=none; b=H9J35ZPZUvKKsYrEEkpB2cfwrYfMr8dsb1M04+31Nln/XvI0sOOgCZP7V+z/hxvSU2vGBRHInEDBjXSKSOKINipH6DiiD6K431rbUw2BTBPIx7Kl2219/ZnoZZMP9C/n/rVhjeAYrFk1446QOxvj3s3JHnfH3dTXkflA852f9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481155; c=relaxed/simple;
	bh=ezgnj8xUWsAj5N8gZGleyFTE7MCpHg4GM26vbU/B/Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2ya4ZOmZ/5BAYAQdPs69D0LKRFlzBf3ujHq1bR2IRT3ZZj2Yhx9m/CtIJ2W4efYGxERcSx44OpFQ7dYCG7pKkq5QZaDtAsqxELQEnKlFSU/+PHtttFyid/4y7eHNZDuH4zMhVkGUYFHCsgT6dNlwoClFFucJbFkPjdeRk2DdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.146.110])
	by mtasvr (Coremail) with SMTP id _____wAnRVTVXEppejo7AQ--.6375S3;
	Tue, 23 Dec 2025 17:11:49 +0800 (CST)
Received: from lutetium.localdomain (unknown [10.162.146.110])
	by mail-app4 (Coremail) with SMTP id zi_KCgAHwIbUXEppG9UDBA--.64806S2;
	Tue, 23 Dec 2025 17:11:48 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for BPF_DIV analysis
Date: Tue, 23 Dec 2025 17:10:50 +0800
Message-ID: <20251223091120.2413435-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223091120.2413435-1-tangyazhou@zju.edu.cn>
References: <20251223091120.2413435-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAHwIbUXEppG9UDBA--.64806S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhIJCmlJnwMlDAAAsC
X-CM-DELIVERINFO: =?B?pjyQ9QXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BF8DE4vll40/IW/Z/fxYo9MA67HtrGqYRT0tRX5KuyA1rC+Z1Ohprqb6wZt+v5O4NGF
	lTWPltwpevijvLaapUH90Dma9oGEmkOOqEEvwpKCyk4I8baYTMCiFI6Ay0Uo7w==
X-Coremail-Antispam: 1Uk129KBj93XoW3tr4UKF1fCw17Xr1xtr17CFX_yoWktF43pr
	9aga45urWkAr95uwn7XFZ3JFyayFZYqw4UXr1rAr1UAF4UXrsFqrs2kryfJws3Casru3yY
	vFy7KFWakF1jk3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2Ta0DUUUU

From: Yazhou Tang <tangyazhou518@outlook.com>

Now BPF_DIV has value tracking support via interval and tnum analysis.
This patch adds selftests to cover various cases of signed and
unsigned division operations, including edge cases like division by
zero and signed division overflow.

Specifically, these selftests are based on dead code elimination: If
the BPF verifier can precisely analyze the result of a division
operation, it can prune the path that leads to an error (here we use
invalid memory access as the error case), allowing the program to pass
verification.

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
Hello everyone,

Thanks for reviewing our patch! This patch adds the necessary selftests
for the BPF_DIV range tracking enhancements.

Regarding the test implementation: I noticed multiple patterns for BPF
selftests (e.g., out-of-bounds read in `verifier_bounds.c`, illegal
return value in `verifier_mul.c` and `verifier_precision.v`). I have
opted for the invalid memory access approach with `__msg` label as it
is concise and straightforward.

If the community prefers these tests to be integrated into existing
files or follow a different pattern, please let me know and I will
gladly refactor them.

Best,

Yazhou Tang

 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_div_bounds.c | 404 ++++++++++++++++++
 2 files changed, 406 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_bounds.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 5829ffd70f8f..d892ad7b688e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -33,6 +33,7 @@
 #include "verifier_direct_packet_access.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
+#include "verifier_div_bounds.skel.h"
 #include "verifier_div_overflow.skel.h"
 #include "verifier_global_subprogs.skel.h"
 #include "verifier_global_ptr_args.skel.h"
@@ -174,6 +175,7 @@ void test_verifier_d_path(void)               { RUN(verifier_d_path); }
 void test_verifier_direct_packet_access(void) { RUN(verifier_direct_packet_access); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
+void test_verifier_div_bounds(void)           { RUN(verifier_div_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_div_bounds.c b/tools/testing/selftests/bpf/progs/verifier_div_bounds.c
new file mode 100644
index 000000000000..7a8b6905de56
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_div_bounds.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <limits.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* This file contains unit tests for signed/unsigned division
+ * operations, focusing on verifying whether BPF verifier's
+ * tnum and interval analysis modules soundly and precisely
+ * compute the results.
+ */
+
+SEC("socket")
+__description("UDIV32, non-zero divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 /= w2 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__naked void udiv32_non_zero(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w2 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w2 &= 1;					\
+	w2 |= 2;					\
+	w1 /= w2;					\
+	if w1 <= 4 goto l0_%=;				\
+	/* Precise analysis will prune the path with error code */\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
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
+	if w1 == 0 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("UDIV64, non-zero divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 /= r2 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__naked void udiv64_non_zero(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r2 &= 1;					\
+	r2 |= 2;					\
+	r1 /= r2;					\
+	if r1 <= 4 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
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
+	if r1 == 0 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= w2 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__naked void sdiv32_non_zero(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w2 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w2 &= 1;					\
+	w2 |= 2;					\
+	w1 s/= w2;					\
+	if w1 s<= 4 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero divisor, negative dividend")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= w2 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=0,var_off=(0x0; 0xffffffff))")
+__naked void sdiv32_negative_dividend(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w2 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w1 = -w1;					\
+	w2 &= 1;					\
+	w2 |= 2;					\
+	w1 s/= w2;					\
+	if w1 s>= -4 goto l0_%=;			\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero divisor, negative divisor")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= w2 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=0,var_off=(0x0; 0xffffffff))")
+__naked void sdiv32_negative_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w2 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w2 &= 1;					\
+	w2 |= 2;					\
+	w2 = -w2;					\
+	w1 s/= w2;					\
+	if w1 s>= -4 goto l0_%=;			\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero divisor, both negative")
+__success __retval(0) __log_level(2)
+__msg("w1 s/= w2 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__naked void sdiv32_both_negative(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w2 = w0;					\
+	w1 &= 8;					\
+	w1 |= 1;					\
+	w2 &= 1;					\
+	w2 |= 2;					\
+	w1 = -w1;					\
+	w2 = -w2;					\
+	w1 s/= w2;					\
+	if w1 s<= 4 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
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
+	if w1 == 0 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, S32_MIN/-1")
+__success __retval(0) __log_level(2)
+__msg("w2 s/= -1 {{.*}}; R2=0x80000000")
+__naked void sdiv32_overflow(void)
+{
+	asm volatile ("					\
+	w1 = %[int_min];				\
+	w2 = w1;					\
+	w2 s/= -1;					\
+	if w1 == w2 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+
+SEC("socket")
+__description("SDIV64, non-zero divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= r2 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__naked void sdiv64_non_zero(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r2 &= 1;					\
+	r2 |= 2;					\
+	r1 s/= r2;					\
+	if r1 s<= 4 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero divisor, negative dividend")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= r2 {{.*}}; R1=scalar(smin=smin32=-4,smax=smax32=0)")
+__naked void sdiv64_negative_dividend(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r1 = -r1;					\
+	r2 &= 1;					\
+	r2 |= 2;					\
+	r1 s/= r2;					\
+	if r1 s>= -4 goto l0_%=;			\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero divisor, negative divisor")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= r2 {{.*}}; R1=scalar(smin=smin32=-4,smax=smax32=0)")
+__naked void sdiv64_negative_divisor(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r2 &= 1;					\
+	r2 |= 2;					\
+	r2 = -r2;					\
+	r1 s/= r2;					\
+	if r1 s>= -4 goto l0_%=;			\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero divisor, both negative")
+__success __retval(0) __log_level(2)
+__msg("r1 s/= r2 {{.*}}; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__naked void sdiv64_both_negative(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 &= 8;					\
+	r1 |= 1;					\
+	r2 &= 1;					\
+	r2 |= 2;					\
+	r1 = -r1;					\
+	r2 = -r2;					\
+	r1 s/= r2;					\
+	if r1 s<= 4 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
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
+	if r1 == 0 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, S64_MIN/-1")
+__success __retval(0) __log_level(2)
+__msg("r2 s/= -1 {{.*}}; R2=0x8000000000000000")
+__naked void sdiv64_overflow(void)
+{
+	asm volatile ("					\
+	r1 = %[llong_min] ll;				\
+	r2 = r1;					\
+	r2 s/= -1;					\
+	if r1 == r2 goto l0_%=;				\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
\ No newline at end of file
-- 
2.52.0


