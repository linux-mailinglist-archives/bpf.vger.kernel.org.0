Return-Path: <bpf+bounces-77266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480D3CD3DF9
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B263006F7C
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634B28136F;
	Sun, 21 Dec 2025 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="TuQx2lep"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2CE223DD4
	for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310032; cv=none; b=qHEOWMXVqdLo1KD9XC0afFywZgqhZFkTokfhJs2WWl5cNuz1+2D1uEq2ovg8rDwaKFSZ983IrX+mWvSRqfCtifiEjPdQC0Bs4Z/tiwAs5ahe+IEWl+WTobnSlKkYWm0lKKXCtAvfdBw+a8sf3qfM27e0mhhprY8cnGAweUajdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310032; c=relaxed/simple;
	bh=UAqLDN6N9thFC/rcAVeq7Xl33nezkp/tFC6iueNcwhs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VpXX696DZUkJueXVLDjggXzI337vRhLCmYbHnMzPJdVB/rxk4X3PV6Tzot9gW/tOYDqAhbPnultr9jl9AS5cNirVHERrW6oye5uEly+tjdrHdCv+Wp9/LDmU6cxpffwlA4JuSNfsrCi3x6uxtFs/0MqUH6iyN4nDDkF0XkbHcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=TuQx2lep; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766310025;
	bh=hPbLzDxSxaJ+uP6kTfZXohy4YoMFi0UAnAEiEeiOiCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TuQx2lepFkcYiezV1lJC0qbI6DpC7APShae0DYvo8HD9XnKruwoCSMsDWi5Ugvd5H
	 nyBJ/CavlsbE+bFzkuD1Noxnw2QLdn6aAxjeabIxGDw8nlT0n3c0ZIYNeq7syQblTA
	 AXuglJOJRxtLGwmZD+SS8FFO5SW9lL0yobcubk/Y=
Received: from wolframium.tail477849.ts.net ([122.224.66.116])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id A1689CC1; Sun, 21 Dec 2025 17:40:22 +0800
X-QQ-mid: xmsmtpt1766310022tvme1sn2x
Message-ID: <tencent_44C4CE4914743467026998C8EDFA0CC04909@qq.com>
X-QQ-XMAILINFO: OTSqlCUlzTO05kbQE1HEVMAof3hF2n6GVF/ItriWc7VvXVa1GybJJnqIezylNy
	 zCtjk9K9DMqtSpZ17F2ltSVGY3OqaffolonjKHnEQ+wWBurRwhlyxiG/zC++DBApymuJMfeBIOd3
	 Y3+unTz2ZywZp0okcp7LxgBlBOOt0sLnBxyomNUc+bIRKzpwFNx9mxTARP6r+OmGTEuT5KHE6ijT
	 vj9z7AMIdu5M2pjiDPu/dNHrZP794c7PPCte1zP0v2aBaoJU7uuKCABInQ+5DHU+iX1vd0aqUYBn
	 lJP6KkjlOlgu43ZOMnd1E/tbhDYvhmdFYmyutDHcrd97XXSLYckSSsN6fQJddhUE6ZxdxWhLrXq9
	 CEUGw0BsdQrgg3NjdyZ7TdZaj6eYwmrLAVgvSpAjKrggLoQkQRo6ZvNVzQ0fFLGeI/JujSSRqJ55
	 oH7cZ5x8Y6XEa9qfCzgl/fhDwmExpCyXeVUXBoPpCXxD3tmmBAxJ2SrSfyglz+qzvj7Y4ZVk7cIB
	 SwGidNafnXs/x6H8XeOWmR/QfXGjuieKuwkqS2PkaYv37fHtZQhmYs4IWrEJ3/9zxoCXTY+5GLGi
	 rjJIETI1w0jmPy7uUNwQl/uAnMlk/5H9d0VcmdM/k2AV+TR62+gkP8owTbJ/Ja2OkuE6Wf0/EtMh
	 p3YmxQ+6+ZaRDDrgCh3NY4mPxO6WeWaFKfUT3/Q8S0RRpMr+yR4jEjsdq/kH2knbe7oOUye1JVeq
	 HYCxoSzsLkrhhfcyDGkBziRWEHhpkmqNEolJ//npGUNKasPeR/sj4YwfOkB1SIFBJSS2Hv9fGBa+
	 AZ7eyUHWuRLvUbthLWtEOPYOmiDpJKXkIKvATr404ChT8ZqYdVEv+M3IANsTwb8aZcotm0FnjQFr
	 nWyFrxQ6Ms6l/gtX8Naz8arH+Y340E+oEe2zD8w4eKlFa63fM+JDbMYRAULV036OONqKQ2D5fcQn
	 yfs4PV9N6i1NmOKEjH1ZEXIjJZciNbdvfQsUNyXSnHIkVtNe3ETF5GMPfqb946jqTN937DytkPiH
	 DBuL+eoTEmxJQdjc0obL6iLb7iILYojF7c5oLvGWZGUCE5ffWOF4qdidxKuqOXuY8K3qWXIw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yazhou Tang <yazhoutang@foxmail.com>
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for BPF_DIV analysis
Date: Sun, 21 Dec 2025 17:39:54 +0800
X-OQ-MSGID: <20251221093955.109312-3-yazhoutang@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251221093955.109312-1-yazhoutang@foxmail.com>
References: <20251221093955.109312-1-yazhoutang@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 000000000000..b6f790fc8b63
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
+__msg("w1 s/= w2 {{.*}}; R1=scalar(smin=umin=umin32=0xfffffffc,smax=umax=0xffffffff,smin32=-4,smax32=-1,var_off=(0xfffffffc; 0x3))")
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


