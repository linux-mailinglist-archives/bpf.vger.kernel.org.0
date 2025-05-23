Return-Path: <bpf+bounces-58865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34146AC2B22
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 22:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFDB16ADF4
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4C1FFC7E;
	Fri, 23 May 2025 20:53:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2D1FF1CE
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033626; cv=none; b=PCQjPaMX3Hoip1Ivx4j5aRofI+I4MvUvX0Eej6ZF9zXH52VXrMm2fAbWxveWm6RHZYMc6kaTIeKBq+tRNhPKrqatZ+IxVJAjoKdUGFqyTEtwINwhm/vcYbEjsgrlIaSSLQwdi9PYlMrgscAgdaoWB/EYV9yTlPCo3ZJAtp5PeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033626; c=relaxed/simple;
	bh=QRmNgkoBK8/xFbKmu3/SoWdchyuu4Q4KMa9xkvfyyZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUMuvDbO7RPbnXFdtIsoy2nfkEUATa9Z/Vid/CsUQdX59yCE0Kg1GYGbLXKXBejBjVXzkayKiyTfwP1xo61Xn2ej9k0pUceD03ZgX4QMxyVtfRcQV4C/YYoDLuqFyJWu27QU6GE6WfrmqyXC9rPh45bO6+8eLFyl0VDgIB/WAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 90D418141E5A; Fri, 23 May 2025 13:53:31 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Add unit tests with __bpf_trap() kfunc
Date: Fri, 23 May 2025 13:53:31 -0700
Message-ID: <20250523205331.1291734-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250523205316.1291136-1-yonghong.song@linux.dev>
References: <20250523205316.1291136-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add some inline-asm tests and C tests where __bpf_trap() or
__builtin_trap() is used in the code. The __builtin_trap()
test is guarded with llvm21 ([1]) since otherwise the compilation
failure will happen.

  [1] https://github.com/llvm/llvm-project/pull/131731

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_bpf_trap.c   | 71 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_trap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index e66a57970d28..c9da06741104 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -14,6 +14,7 @@
 #include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
 #include "verifier_bpf_get_stack.skel.h"
+#include "verifier_bpf_trap.skel.h"
 #include "verifier_bswap.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
@@ -148,6 +149,7 @@ void test_verifier_bounds_deduction(void)     { RUN(v=
erifier_bounds_deduction);
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_b=
ounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mi=
x_sign_unsign); }
 void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_sta=
ck); }
+void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); =
}
 void test_verifier_bswap(void)                { RUN(verifier_bswap); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_acc=
ess); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unrelia=
ble_prog); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_trap.c b/tool=
s/testing/selftests/bpf/progs/verifier_bpf_trap.c
new file mode 100644
index 000000000000..c90da08ab2df
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_trap.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if __clang_major__ >=3D 21
+SEC("socket")
+__description("__builtin_trap with simple c code")
+__failure __msg("unexpected __bpf_trap() due to uninitialized variable?"=
)
+void bpf_builtin_trap_with_simple_c(void)
+{
+	__builtin_trap();
+}
+#endif
+
+SEC("socket")
+__description("__bpf_trap with simple c code")
+__failure __msg("unexpected __bpf_trap() due to uninitialized variable?"=
)
+void bpf_trap_with_simple_c(void)
+{
+	__bpf_trap();
+}
+
+SEC("socket")
+__description("__bpf_trap as the second-from-last insn")
+__failure __msg("unexpected __bpf_trap() due to uninitialized variable?"=
)
+__naked void bpf_trap_at_func_end(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"call %[__bpf_trap];"
+	"exit;"
+	:
+	: __imm(__bpf_trap)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("dead code __bpf_trap in the middle of code")
+__success
+__naked void dead_bpf_trap_in_middle(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"if r0 =3D=3D 0 goto +1;"
+	"call %[__bpf_trap];"
+	"r0 =3D 2;"
+	"exit;"
+	:
+	: __imm(__bpf_trap)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("reachable __bpf_trap in the middle of code")
+__failure __msg("unexpected __bpf_trap() due to uninitialized variable?"=
)
+__naked void live_bpf_trap_in_middle(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"if r0 =3D=3D 1 goto +1;"
+	"call %[__bpf_trap];"
+	"r0 =3D 2;"
+	"exit;"
+	:
+	: __imm(__bpf_trap)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.47.1


