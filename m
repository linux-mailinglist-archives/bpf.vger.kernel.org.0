Return-Path: <bpf+bounces-39838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0DB97833C
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD65281FE2
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C02BD0D;
	Fri, 13 Sep 2024 15:03:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515218054
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239826; cv=none; b=Rk/rUYkpejcYotjM6SOIWWq4GMyrzsuyBG7gxrKT4GZxrJt8ijRyrCl6JkB/zHFn9mgdZnCafMY6R/cKBflMBBgY8/BMLtkDJAR6GvccqSQKzC2rn0geKgwJAooow+cIfaa5XUtADIwB0r3vVAPEavLT/TwTFSJfz9h7whMGgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239826; c=relaxed/simple;
	bh=v5h8DAu/1EkTfrIYD91GTbqmSuscyvLc9FRs0gDCd5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddzdlPpt4qTUy8alQN8umeLcQDmp9qjTjv4HnaQB1fp4bXvweenhG2qKRXpFG7IUkUqGWIjSPAz3JGls/rP9LHEKBkqoCedW/ZuitENWeQB96lETKeN81EGLSxhs6g4YANeTXOMLIuRJIlLjJHLL3W13nFlgKBLPwHUtrxxJUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1BBE48EB8AC5; Fri, 13 Sep 2024 08:03:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for sdiv/smod overflow cases
Date: Fri, 13 Sep 2024 08:03:32 -0700
Message-ID: <20240913150332.1188102-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913150326.1187788-1-yonghong.song@linux.dev>
References: <20240913150326.1187788-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Subtests are added to exercise the patched code which handles
  - LLONG_MIN/-1
  - INT_MIN/-1
  - LLONG_MIN%-1
  - INT_MIN%-1
where -1 could be an immediate or in a register.
Without the previous patch, all these cases will crash the kernel on
x86_64 platform.

Additional tests are added to use small values (e.g. -5/-1, 5%-1, etc.)
in order to exercise the additional logic with patched insns.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_sdiv.c       | 439 ++++++++++++++++++
 1 file changed, 439 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/te=
sting/selftests/bpf/progs/verifier_sdiv.c
index 2a2271cf0294..148d2299e5b4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
=20
 #include <linux/bpf.h>
+#include <limits.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
=20
@@ -770,6 +771,444 @@ __naked void smod64_zero_divisor(void)
 "	::: __clobber_all);
 }
=20
+SEC("socket")
+__description("SDIV64, overflow r/r, LLONG_MIN/-1")
+__success __retval(1)
+__arch_x86_64
+__xlated("0: r2 =3D 0x8000000000000000")
+__xlated("2: r3 =3D -1")
+__xlated("3: r4 =3D r2")
+__xlated("4: r11 =3D r3")
+__xlated("5: r11 +=3D 1")
+__xlated("6: if r11 > 0x1 goto pc+4")
+__xlated("7: if r11 =3D=3D 0x0 goto pc+1")
+__xlated("8: r2 =3D 0")
+__xlated("9: r2 =3D -r2")
+__xlated("10: goto pc+1")
+__xlated("11: r2 s/=3D r3")
+__xlated("12: r0 =3D 0")
+__xlated("13: if r2 !=3D r4 goto pc+1")
+__xlated("14: r0 =3D 1")
+__xlated("15: exit")
+__naked void sdiv64_overflow_rr(void)
+{
+	asm volatile ("					\
+	r2 =3D %[llong_min] ll;				\
+	r3 =3D -1;					\
+	r4 =3D r2;					\
+	r2 s/=3D r3;					\
+	r0 =3D 0;						\
+	if r2 !=3D r4 goto +1;				\
+	r0 =3D 1;						\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, r/r, small_val/-1")
+__success __retval(-5)
+__arch_x86_64
+__xlated("0: r2 =3D 5")
+__xlated("1: r3 =3D -1")
+__xlated("2: r11 =3D r3")
+__xlated("3: r11 +=3D 1")
+__xlated("4: if r11 > 0x1 goto pc+4")
+__xlated("5: if r11 =3D=3D 0x0 goto pc+1")
+__xlated("6: r2 =3D 0")
+__xlated("7: r2 =3D -r2")
+__xlated("8: goto pc+1")
+__xlated("9: r2 s/=3D r3")
+__xlated("10: r0 =3D r2")
+__xlated("11: exit")
+__naked void sdiv64_rr_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	r2 =3D 5;						\
+	r3 =3D -1;					\
+	r2 s/=3D r3;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, overflow r/i, LLONG_MIN/-1")
+__success __retval(1)
+__arch_x86_64
+__xlated("0: r2 =3D 0x8000000000000000")
+__xlated("2: r4 =3D r2")
+__xlated("3: r2 =3D -r2")
+__xlated("4: r0 =3D 0")
+__xlated("5: if r2 !=3D r4 goto pc+1")
+__xlated("6: r0 =3D 1")
+__xlated("7: exit")
+__naked void sdiv64_overflow_ri(void)
+{
+	asm volatile ("					\
+	r2 =3D %[llong_min] ll;				\
+	r4 =3D r2;					\
+	r2 s/=3D -1;					\
+	r0 =3D 0;						\
+	if r2 !=3D r4 goto +1;				\
+	r0 =3D 1;						\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, r/i, small_val/-1")
+__success __retval(-5)
+__arch_x86_64
+__xlated("0: r2 =3D 5")
+__xlated("1: r4 =3D r2")
+__xlated("2: r2 =3D -r2")
+__xlated("3: r0 =3D r2")
+__xlated("4: exit")
+__naked void sdiv64_ri_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	r2 =3D 5;						\
+	r4 =3D r2;					\
+	r2 s/=3D -1;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, overflow r/r, INT_MIN/-1")
+__success __retval(1)
+__arch_x86_64
+__xlated("0: w2 =3D -2147483648")
+__xlated("1: w3 =3D -1")
+__xlated("2: w4 =3D w2")
+__xlated("3: r11 =3D r3")
+__xlated("4: w11 +=3D 1")
+__xlated("5: if w11 > 0x1 goto pc+4")
+__xlated("6: if w11 =3D=3D 0x0 goto pc+1")
+__xlated("7: w2 =3D 0")
+__xlated("8: w2 =3D -w2")
+__xlated("9: goto pc+1")
+__xlated("10: w2 s/=3D w3")
+__xlated("11: r0 =3D 0")
+__xlated("12: if w2 !=3D w4 goto pc+1")
+__xlated("13: r0 =3D 1")
+__xlated("14: exit")
+__naked void sdiv32_overflow_rr(void)
+{
+	asm volatile ("					\
+	w2 =3D %[int_min];				\
+	w3 =3D -1;					\
+	w4 =3D w2;					\
+	w2 s/=3D w3;					\
+	r0 =3D 0;						\
+	if w2 !=3D w4 goto +1;				\
+	r0 =3D 1;						\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, r/r, small_val/-1")
+__success __retval(5)
+__arch_x86_64
+__xlated("0: w2 =3D -5")
+__xlated("1: w3 =3D -1")
+__xlated("2: w4 =3D w2")
+__xlated("3: r11 =3D r3")
+__xlated("4: w11 +=3D 1")
+__xlated("5: if w11 > 0x1 goto pc+4")
+__xlated("6: if w11 =3D=3D 0x0 goto pc+1")
+__xlated("7: w2 =3D 0")
+__xlated("8: w2 =3D -w2")
+__xlated("9: goto pc+1")
+__xlated("10: w2 s/=3D w3")
+__xlated("11: w0 =3D w2")
+__xlated("12: exit")
+__naked void sdiv32_rr_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	w2 =3D -5;					\
+	w3 =3D -1;					\
+	w4 =3D w2;					\
+	w2 s/=3D w3;					\
+	w0 =3D w2;					\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, overflow r/i, INT_MIN/-1")
+__success __retval(1)
+__arch_x86_64
+__xlated("0: w2 =3D -2147483648")
+__xlated("1: w4 =3D w2")
+__xlated("2: w2 =3D -w2")
+__xlated("3: r0 =3D 0")
+__xlated("4: if w2 !=3D w4 goto pc+1")
+__xlated("5: r0 =3D 1")
+__xlated("6: exit")
+__naked void sdiv32_overflow_ri(void)
+{
+	asm volatile ("					\
+	w2 =3D %[int_min];				\
+	w4 =3D w2;					\
+	w2 s/=3D -1;					\
+	r0 =3D 0;						\
+	if w2 !=3D w4 goto +1;				\
+	r0 =3D 1;						\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, r/i, small_val/-1")
+__success __retval(-5)
+__arch_x86_64
+__xlated("0: w2 =3D 5")
+__xlated("1: w4 =3D w2")
+__xlated("2: w2 =3D -w2")
+__xlated("3: w0 =3D w2")
+__xlated("4: exit")
+__naked void sdiv32_ri_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	w2 =3D 5;						\
+	w4 =3D w2;					\
+	w2 s/=3D -1;					\
+	w0 =3D w2;					\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, overflow r/r, LLONG_MIN/-1")
+__success __retval(0)
+__arch_x86_64
+__xlated("0: r2 =3D 0x8000000000000000")
+__xlated("2: r3 =3D -1")
+__xlated("3: r4 =3D r2")
+__xlated("4: r11 =3D r3")
+__xlated("5: r11 +=3D 1")
+__xlated("6: if r11 > 0x1 goto pc+3")
+__xlated("7: if r11 =3D=3D 0x1 goto pc+3")
+__xlated("8: w2 =3D 0")
+__xlated("9: goto pc+1")
+__xlated("10: r2 s%=3D r3")
+__xlated("11: r0 =3D r2")
+__xlated("12: exit")
+__naked void smod64_overflow_rr(void)
+{
+	asm volatile ("					\
+	r2 =3D %[llong_min] ll;				\
+	r3 =3D -1;					\
+	r4 =3D r2;					\
+	r2 s%%=3D r3;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, r/r, small_val/-1")
+__success __retval(0)
+__arch_x86_64
+__xlated("0: r2 =3D 5")
+__xlated("1: r3 =3D -1")
+__xlated("2: r4 =3D r2")
+__xlated("3: r11 =3D r3")
+__xlated("4: r11 +=3D 1")
+__xlated("5: if r11 > 0x1 goto pc+3")
+__xlated("6: if r11 =3D=3D 0x1 goto pc+3")
+__xlated("7: w2 =3D 0")
+__xlated("8: goto pc+1")
+__xlated("9: r2 s%=3D r3")
+__xlated("10: r0 =3D r2")
+__xlated("11: exit")
+__naked void smod64_rr_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	r2 =3D 5;						\
+	r3 =3D -1;					\
+	r4 =3D r2;					\
+	r2 s%%=3D r3;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, overflow r/i, LLONG_MIN/-1")
+__success __retval(0)
+__arch_x86_64
+__xlated("0: r2 =3D 0x8000000000000000")
+__xlated("2: r4 =3D r2")
+__xlated("3: w2 =3D 0")
+__xlated("4: r0 =3D r2")
+__xlated("5: exit")
+__naked void smod64_overflow_ri(void)
+{
+	asm volatile ("					\
+	r2 =3D %[llong_min] ll;				\
+	r4 =3D r2;					\
+	r2 s%%=3D -1;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, r/i, small_val/-1")
+__success __retval(0)
+__arch_x86_64
+__xlated("0: r2 =3D 5")
+__xlated("1: r4 =3D r2")
+__xlated("2: w2 =3D 0")
+__xlated("3: r0 =3D r2")
+__xlated("4: exit")
+__naked void smod64_ri_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	r2 =3D 5;						\
+	r4 =3D r2;					\
+	r2 s%%=3D -1;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, overflow r/r, INT_MIN/-1")
+__success __retval(0)
+__arch_x86_64
+__xlated("0: w2 =3D -2147483648")
+__xlated("1: w3 =3D -1")
+__xlated("2: w4 =3D w2")
+__xlated("3: r11 =3D r3")
+__xlated("4: w11 +=3D 1")
+__xlated("5: if w11 > 0x1 goto pc+3")
+__xlated("6: if w11 =3D=3D 0x1 goto pc+4")
+__xlated("7: w2 =3D 0")
+__xlated("8: goto pc+1")
+__xlated("9: w2 s%=3D w3")
+__xlated("10: goto pc+1")
+__xlated("11: w2 =3D w2")
+__xlated("12: r0 =3D r2")
+__xlated("13: exit")
+__naked void smod32_overflow_rr(void)
+{
+	asm volatile ("					\
+	w2 =3D %[int_min];				\
+	w3 =3D -1;					\
+	w4 =3D w2;					\
+	w2 s%%=3D w3;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, r/r, small_val/-1")
+__success __retval(0)
+__arch_x86_64
+__xlated("0: w2 =3D -5")
+__xlated("1: w3 =3D -1")
+__xlated("2: w4 =3D w2")
+__xlated("3: r11 =3D r3")
+__xlated("4: w11 +=3D 1")
+__xlated("5: if w11 > 0x1 goto pc+3")
+__xlated("6: if w11 =3D=3D 0x1 goto pc+4")
+__xlated("7: w2 =3D 0")
+__xlated("8: goto pc+1")
+__xlated("9: w2 s%=3D w3")
+__xlated("10: goto pc+1")
+__xlated("11: w2 =3D w2")
+__xlated("12: r0 =3D r2")
+__xlated("13: exit")
+__naked void smod32_rr_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	w2 =3D -5;				\
+	w3 =3D -1;					\
+	w4 =3D w2;					\
+	w2 s%%=3D w3;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, overflow r/i, INT_MIN/-1")
+__success __retval(0)
+__arch_x86_64
+__xlated("0: w2 =3D -2147483648")
+__xlated("1: w4 =3D w2")
+__xlated("2: w2 =3D 0")
+__xlated("3: r0 =3D r2")
+__xlated("4: exit")
+__naked void smod32_overflow_ri(void)
+{
+	asm volatile ("					\
+	w2 =3D %[int_min];				\
+	w4 =3D w2;					\
+	w2 s%%=3D -1;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, r/i, small_val/-1")
+__success __retval(0)
+__arch_x86_64
+__xlated("0: w2 =3D 5")
+__xlated("1: w4 =3D w2")
+__xlated("2: w2 =3D 0")
+__xlated("3: w0 =3D w2")
+__xlated("4: exit")
+__naked void smod32_ri_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	w2 =3D 5;						\
+	w4 =3D w2;					\
+	w2 s%%=3D -1;					\
+	w0 =3D w2;					\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
 #else
=20
 SEC("socket")
--=20
2.43.5


