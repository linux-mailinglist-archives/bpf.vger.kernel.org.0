Return-Path: <bpf+bounces-38851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1316996AC96
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 01:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459311C24878
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 23:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEED1D5CF0;
	Tue,  3 Sep 2024 23:00:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B281D58B3
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725404409; cv=none; b=gLAHJWSkrCzlBCDxcfBgiqEHmWzlFtBREs6hZkZaMMh0kAi8gp6BEl93xtpaMYFgKwwZEQSauSTyLyUwGLC9s2yz+KjMhKmKz7ZAO8fBttbb0eyOdqvITtCyKSzs+fW9V4A9dc4ZAg/En6LYgFBPgSjtnQOlZE0NkAB5D80HBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725404409; c=relaxed/simple;
	bh=BzolBEPaYQuDJK8cyLRmuL22aoQeq97Z56FyDLPUMcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/8g93DrlItHcXGvKmN+3QZqEX3SKDKB01U0Wlg1YP5pZNL5vV3Rzct63NbK+HftjecaRQ/1+czrb0LaFEtoLlJqJqHkC4abwb07w622bFAdwvSkTk2Mr78ZXG+S5UGnfBqSOjZ7YYMJoAVx4uKdclRv89FFQ68IK2JJo+nokk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id DA08F88DE24B; Tue,  3 Sep 2024 15:59:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a selftest for x86 jit convergence issues
Date: Tue,  3 Sep 2024 15:59:54 -0700
Message-ID: <20240903225954.2066646-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903225949.2066234-1-yonghong.song@linux.dev>
References: <20240903225949.2066234-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The core part of the selftest, i.e., the je <-> jmp cycle, mimics the
original sched-ext bpf program. The test will fail without the
previous patch.

I tried to create some cases for other potential cycles
(je <-> je, jmp <-> je and jmp <-> jmp) with similar pattern
to the test in this patch, but failed. So this patch
only contains one test for je <-> jmp cycle.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_jit_convergence.c      | 128 ++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_conver=
gence.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 80a90c627182..df398e714dff 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -39,6 +39,7 @@
 #include "verifier_int_ptr.skel.h"
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
+#include "verifier_jit_convergence.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
@@ -163,6 +164,7 @@ void test_verifier_helper_value_access(void)  { RUN(v=
erifier_helper_value_access
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_c=
allbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_n=
ot_null); }
+void test_verifier_jit_convergence(void)      { RUN(verifier_jit_converg=
ence); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); =
}
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_convergence.c=
 b/tools/testing/selftests/bpf/progs/verifier_jit_convergence.c
new file mode 100644
index 000000000000..fdc4ccc83c7d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_convergence.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86)
+
+struct value_t {
+	long long a[32];
+};
+
+struct {
+        __uint(type, BPF_MAP_TYPE_HASH);
+        __uint(max_entries, 1);
+        __type(key, long long);
+        __type(value, struct value_t);
+} map_hash SEC(".maps");
+
+SEC("socket")
+__description("bpf_jit_convergence je <-> jmp")
+__success __retval(0)
+__arch_x86_64
+__jited("	pushq	%rbp")
+__naked void btf_jit_convergence_je_jmp(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"if r0 =3D=3D 0 goto l20_%=3D;"
+	"if r0 =3D=3D 1 goto l21_%=3D;"
+	"if r0 =3D=3D 2 goto l22_%=3D;"
+	"if r0 =3D=3D 3 goto l23_%=3D;"
+	"if r0 =3D=3D 4 goto l24_%=3D;"
+	"call %[bpf_get_prandom_u32];"
+	"call %[bpf_get_prandom_u32];"
+"l20_%=3D:"
+"l21_%=3D:"
+"l22_%=3D:"
+"l23_%=3D:"
+"l24_%=3D:"
+	"r1 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"r2 =3D r10;"
+	"r2 +=3D -8;"
+	"r1 =3D %[map_hash] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 =3D=3D 0 goto l1_%=3D;"
+	"r6 =3D r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 =3D r0;"
+	"r5 =3D r6;"
+	"if r0 !=3D 0x0 goto l12_%=3D;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 =3D r0;"
+	"r2 =3D r6;"
+	"if r1 =3D=3D 0x0 goto l0_%=3D;"
+"l9_%=3D:"
+	"r2 =3D *(u64 *)(r6 + 0x0);"
+	"r2 +=3D 0x1;"
+	"*(u64 *)(r6 + 0x0) =3D r2;"
+	"goto l1_%=3D;"
+"l12_%=3D:"
+	"r1 =3D r7;"
+	"r1 +=3D 0x98;"
+	"r2 =3D r5;"
+	"r2 +=3D 0x90;"
+	"r2 =3D *(u32 *)(r2 + 0x0);"
+	"r3 =3D r7;"
+	"r3 &=3D 0x1;"
+	"r2 *=3D 0xa8;"
+	"if r3 =3D=3D 0x0 goto l2_%=3D;"
+	"r1 +=3D r2;"
+	"r1 -=3D r7;"
+	"r1 +=3D 0x8;"
+	"if r1 <=3D 0xb20 goto l3_%=3D;"
+	"r1 =3D 0x0;"
+	"goto l4_%=3D;"
+"l3_%=3D:"
+	"r1 +=3D r7;"
+"l4_%=3D:"
+	"if r1 =3D=3D 0x0 goto l8_%=3D;"
+	"goto l9_%=3D;"
+"l2_%=3D:"
+	"r1 +=3D r2;"
+	"r1 -=3D r7;"
+	"r1 +=3D 0x10;"
+	"if r1 <=3D 0xb20 goto l6_%=3D;"
+	"r1 =3D 0x0;"
+	"goto l7_%=3D;"
+"l6_%=3D:"
+	"r1 +=3D r7;"
+"l7_%=3D:"
+	"if r1 =3D=3D 0x0 goto l8_%=3D;"
+	"goto l9_%=3D;"
+"l0_%=3D:"
+	"r1 =3D 0x3;"
+	"*(u64 *)(r10 - 0x10) =3D r1;"
+	"r2 =3D r1;"
+	"goto l1_%=3D;"
+"l8_%=3D:"
+	"r1 =3D r5;"
+	"r1 +=3D 0x4;"
+	"r1 =3D *(u32 *)(r1 + 0x0);"
+	"*(u64 *)(r10 - 0x8) =3D r1;"
+"l1_%=3D:"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
+#else
+
+SEC("socket")
+__description("non-x86 has no jit convergence issue, use a dummy test")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.43.5


