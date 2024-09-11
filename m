Return-Path: <bpf+bounces-39579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46076974958
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 06:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C1CB2382D
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 04:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC419524D7;
	Wed, 11 Sep 2024 04:40:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128640862
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029637; cv=none; b=tg2Gj/boKFYw/zrtKatCKGeDvfPSu9z8Z0FxVxBcRk5BrVsDZZMFT9uyuih30S/5Z8l//FVSkrfShyR37rkkZVLmGxIcb73/UQ5AANYLb7xNtURcZr9kml2F8jjg8+z2lo6gDan7bbYJuufvXIZTOwR1rwIH75auldaEcy0CTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029637; c=relaxed/simple;
	bh=R/FLHw0BdYsh5xBYKCad7p6buEuf7UZX1DMA7VuoYqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I36ghz5Qw5+s9cKxB7GyCJzLssIpmsKSeyHbS486w+IlaRyHb9mbIPEPudq8pPlWGeUyra1kJ7plc77S4fJCjS1GVGDRbSLUBoq81cn7NCbJuqjLpVmUJXEo8R6bAkPxc1kjNDhYkaHKfKZY4Aj6TSObIOQPQXaUJMZ/mfufm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EF6858D48E66; Tue, 10 Sep 2024 21:40:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a couple of tests for potential sdiv overflow
Date: Tue, 10 Sep 2024 21:40:22 -0700
Message-ID: <20240911044022.2262427-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911044017.2261738-1-yonghong.song@linux.dev>
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two subtests are added to exercise the patched code which handles
LLONG_MIN/-1. The first subtest will cause kernel exception without
previous kernel verifier change. The second subtest exercises part
of the patched code logic and the end result is still correct.

Translated asm codes are parts of correctness checking and those asm
codes also make it easy to understand the patched code in verifier.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_sdiv.c       | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/te=
sting/selftests/bpf/progs/verifier_sdiv.c
index 2a2271cf0294..c9c56008e534 100644
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
@@ -770,6 +771,74 @@ __naked void smod64_zero_divisor(void)
 "	::: __clobber_all);
 }
=20
+SEC("socket")
+__description("SDIV64, overflow, LLONG_MIN/-1")
+__success __retval(1)
+__arch_x86_64
+__xlated("0: r2 =3D 0x8000000000000000")
+__xlated("2: r3 =3D -1")
+__xlated("3: r4 =3D r2")
+__xlated("4: if r3 !=3D 0x0 goto pc+2")
+__xlated("5: w2 ^=3D w2")
+__xlated("6: goto pc+8")
+__xlated("7: if r3 !=3D 0xffffffff goto pc+6")
+__xlated("8: r3 =3D 0x8000000000000000")
+__xlated("10: if r2 !=3D r3 goto pc+2")
+__xlated("11: r3 =3D -1")
+__xlated("12: goto pc+2")
+__xlated("13: r3 =3D -1")
+__xlated("14: r2 s/=3D r3")
+__xlated("15: r0 =3D 0")
+__xlated("16: if r2 !=3D r4 goto pc+1")
+__xlated("17: r0 =3D 1")
+__xlated("18: exit")
+__naked void sdiv64_overflow(void)
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
+__description("SDIV64, divisor -1")
+__success __retval(-5)
+__arch_x86_64
+__xlated("0: r2 =3D 5")
+__xlated("1: r3 =3D -1")
+__xlated("2: if r3 !=3D 0x0 goto pc+2")
+__xlated("3: w2 ^=3D w2")
+__xlated("4: goto pc+8")
+__xlated("5: if r3 !=3D 0xffffffff goto pc+6")
+__xlated("6: r3 =3D 0x8000000000000000")
+__xlated("8: if r2 !=3D r3 goto pc+2")
+__xlated("9: r3 =3D -1")
+__xlated("10: goto pc+2")
+__xlated("11: r3 =3D -1")
+__xlated("12: r2 s/=3D r3")
+__xlated("13: r0 =3D r2")
+__xlated("14: exit")
+__naked void sdiv64_divisor_neg_1(void)
+{
+	asm volatile ("					\
+	r2 =3D 5;						\
+	r3 =3D -1;					\
+	r2 s/=3D r3;					\
+	r0 =3D r2;					\
+	exit;						\
+"	:
+	: __imm_const(llong_min, LLONG_MIN)
+	: __clobber_all);
+}
+
 #else
=20
 SEC("socket")
--=20
2.43.5


