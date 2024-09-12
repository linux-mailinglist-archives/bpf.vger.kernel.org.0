Return-Path: <bpf+bounces-39687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB98975FE7
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 06:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D510285080
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 04:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730518890E;
	Thu, 12 Sep 2024 04:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AC188596
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113605; cv=none; b=DsyC1eCp/CCDDAIR2voodObGeVEv0/N6/Ij2+1aQi3jce/YPMuh/A+X/mfJznBY6L0by84CKei3qoAAH53vCQOFnUfbVYGbCaB0zJ4kDH0un/ZmXGK7Bu67HXAjK3pLcumYhzIWovCQJAZau2cVT0VUQZMcKITwoKlj/5oucE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113605; c=relaxed/simple;
	bh=ha/Bayqu8iNJxQabG3pDKXbkaeTwz0n/eX2w4iTqdcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvC30nUrKXzb21Z/8L8on07/0tDEdEsvnFR3W1dg4365x6MmUNC0Gb+eH1631LEpkidAFGgqPUH+ZCHWCs14nkllB4idYr6M2XLeJts44QQPIpGDqsZlQYJAOrYXtumeUJ+NL8vEHndxmHmL0ZbRwCiq9wQjFWuNwo55qAlcgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2E2988DDCAB2; Wed, 11 Sep 2024 20:59:50 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for sdiv/smod overflow cases
Date: Wed, 11 Sep 2024 20:59:50 -0700
Message-ID: <20240912035950.667826-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912035945.667426-1-yonghong.song@linux.dev>
References: <20240912035945.667426-1-yonghong.song@linux.dev>
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
 .../selftests/bpf/progs/verifier_sdiv.c       | 431 ++++++++++++++++++
 1 file changed, 431 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/te=
sting/selftests/bpf/progs/verifier_sdiv.c
index 2a2271cf0294..eebe34fecc4d 100644
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
@@ -770,6 +771,436 @@ __naked void smod64_zero_divisor(void)
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
+__xlated("4: if r3 !=3D 0x0 goto pc+2")
+__xlated("5: w2 ^=3D w2")
+__xlated("6: goto pc+4")
+__xlated("7: if r3 !=3D 0xffffffff goto pc+2")
+__xlated("8: r2 =3D -r2")
+__xlated("9: goto pc+1")
+__xlated("10: r2 s/=3D r3")
+__xlated("11: r0 =3D 0")
+__xlated("12: if r2 !=3D r4 goto pc+1")
+__xlated("13: r0 =3D 1")
+__xlated("14: exit")
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
+__xlated("2: if r3 !=3D 0x0 goto pc+2")
+__xlated("3: w2 ^=3D w2")
+__xlated("4: goto pc+4")
+__xlated("5: if r3 !=3D 0xffffffff goto pc+2")
+__xlated("6: r2 =3D -r2")
+__xlated("7: goto pc+1")
+__xlated("8: r2 s/=3D r3")
+__xlated("9: r0 =3D r2")
+__xlated("10: exit")
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
+__xlated("3: if w3 !=3D 0x0 goto pc+2")
+__xlated("4: w2 ^=3D w2")
+__xlated("5: goto pc+4")
+__xlated("6: if w3 !=3D 0xffffffff goto pc+2")
+__xlated("7: w2 =3D -w2")
+__xlated("8: goto pc+1")
+__xlated("9: w2 s/=3D w3")
+__xlated("10: r0 =3D 0")
+__xlated("11: if w2 !=3D w4 goto pc+1")
+__xlated("12: r0 =3D 1")
+__xlated("13: exit")
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
+__xlated("3: if w3 !=3D 0x0 goto pc+2")
+__xlated("4: w2 ^=3D w2")
+__xlated("5: goto pc+4")
+__xlated("6: if w3 !=3D 0xffffffff goto pc+2")
+__xlated("7: w2 =3D -w2")
+__xlated("8: goto pc+1")
+__xlated("9: w2 s/=3D w3")
+__xlated("10: w0 =3D w2")
+__xlated("11: exit")
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
+__xlated("4: if r3 !=3D 0x0 goto pc+2")
+__xlated("5: w2 =3D w2")
+__xlated("6: goto pc+4")
+__xlated("7: if r3 !=3D 0xffffffff goto pc+2")
+__xlated("8: w2 ^=3D w2")
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
+__xlated("3: if r3 !=3D 0x0 goto pc+2")
+__xlated("4: w2 =3D w2")
+__xlated("5: goto pc+4")
+__xlated("6: if r3 !=3D 0xffffffff goto pc+2")
+__xlated("7: w2 ^=3D w2")
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
+__xlated("3: w2 ^=3D w2")
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
+__xlated("2: w2 ^=3D w2")
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
+__xlated("3: if w3 !=3D 0x0 goto pc+2")
+__xlated("4: w2 =3D w2")
+__xlated("5: goto pc+4")
+__xlated("6: if w3 !=3D 0xffffffff goto pc+2")
+__xlated("7: w2 ^=3D w2")
+__xlated("8: goto pc+1")
+__xlated("9: w2 s%=3D w3")
+__xlated("10: r0 =3D r2")
+__xlated("11: exit")
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
+__xlated("3: if w3 !=3D 0x0 goto pc+2")
+__xlated("4: w2 =3D w2")
+__xlated("5: goto pc+4")
+__xlated("6: if w3 !=3D 0xffffffff goto pc+2")
+__xlated("7: w2 ^=3D w2")
+__xlated("8: goto pc+1")
+__xlated("9: w2 s%=3D w3")
+__xlated("10: r0 =3D r2")
+__xlated("11: exit")
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
+__xlated("2: w2 ^=3D w2")
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
+__xlated("2: w2 ^=3D w2")
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


