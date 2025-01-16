Return-Path: <bpf+bounces-49027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 346DCA132C6
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 06:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE26188751E
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DDE18D65C;
	Thu, 16 Jan 2025 05:51:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516C18A943
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006714; cv=none; b=JiMmrMPOyNGm3gCb/FIj6MrYk18nn0a7dCJFSYurnNLBueccDcRVZ3rGLsxB2q0eCfj1X+fv9Rz73FxvN3VFlc+4jTcB/PBw9W2x8os2YAhEzi3sa+/78E5A/W2RwVfwmHAJWAeLfdKxbDr/1eQagkKu77bP7Oh2mYw87AbE6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006714; c=relaxed/simple;
	bh=T07ArxD+pvnzcrwkB5L/sl+WXQqXdxRo/8QQnFS7Vqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJolXX1z/49MFaQK2dnW7TP59ULprvgrnCulUiPgsrYtRqZ5yY5AbfWiN9r1nspvp2Pb19HLK/N3L7yk1F31qUl9f/QCwHw40DE/V+ltID+IjdsxLmpFyWEvjjP3768xBZAbcaRYvB3QRE3zDGnZTBiIx2/HpGH/ASP34GQ5HB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 5620CD032494; Wed, 15 Jan 2025 21:51:39 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add some tests related to 'may_goto 0' insns
Date: Wed, 15 Jan 2025 21:51:39 -0800
Message-ID: <20250116055139.605195-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116055123.603790-1-yonghong.song@linux.dev>
References: <20250116055123.603790-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add both asm-based and C-based tests which have 'may_goto 0' insns.

For the following code in C-based test,
   int i, tmp[3];
   for (i =3D 0; i < 3 && can_loop; i++)
       tmp[i] =3D 0;

The clang compiler (clang 19 and 20) generates
   may_goto 2
   may_goto 1
   may_goto 0
   r1 =3D 0
   r2 =3D 0
   r3 =3D 0

The above asm codes are due to llvm pass SROAPass. This ensures the
successful verification since tmp[0-2] are initialized.  Otherwise,
the code without SROAPass like
   may_goto 5
   r1 =3D 0
   may_goto 3
   r2 =3D 0
   may_goto 1
   r3 =3D 0
will have verification failure.

Although from the source code C-based test should have verification
failure, clang compiler optimization generates code with successful
verification. If gcc generates different asm codes than clang, the
following code can be used for gcc:
   int i, tmp[3];
   for (i =3D 0; i < 3; i++)
       tmp[i] =3D 0;

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  4 +
 .../selftests/bpf/progs/verifier_may_goto_1.c | 97 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_may_goto_2.c | 28 ++++++
 3 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_may_goto_1=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_may_goto_2=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 33cd3e035071..8a0e1ff8a2dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -52,6 +52,8 @@
 #include "verifier_map_ptr_mixing.skel.h"
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
+#include "verifier_may_goto_1.skel.h"
+#include "verifier_may_goto_2.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
@@ -182,6 +184,8 @@ void test_verifier_map_ptr(void)              { RUN(v=
erifier_map_ptr); }
 void test_verifier_map_ptr_mixing(void)       { RUN(verifier_map_ptr_mix=
ing); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val=
); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
+void test_verifier_may_goto_1(void)           { RUN(verifier_may_goto_1)=
; }
+void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2)=
; }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access=
); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_c=
tx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/to=
ols/testing/selftests/bpf/progs/verifier_may_goto_1.c
new file mode 100644
index 000000000000..e81097c96fe2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+SEC("raw_tp")
+__description("may_goto 0")
+__arch_x86_64
+__xlated("0: r0 =3D 1")
+__xlated("1: exit")
+__success
+__naked void may_goto_simple(void)
+{
+	asm volatile (
+	".8byte %[may_goto];"
+	"r0 =3D 1;"
+	".8byte %[may_goto];"
+	"exit;"
+	:
+	: __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0 /* off=
set */, 0))
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("batch 2 of may_goto 0")
+__arch_x86_64
+__xlated("0: r0 =3D 1")
+__xlated("1: exit")
+__success
+__naked void may_goto_batch_0(void)
+{
+	asm volatile (
+	".8byte %[may_goto1];"
+	".8byte %[may_goto1];"
+	"r0 =3D 1;"
+	".8byte %[may_goto1];"
+	".8byte %[may_goto1];"
+	"exit;"
+	:
+	: __imm_insn(may_goto1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0 /* of=
fset */, 0))
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("may_goto batch with offsets 2/1/0")
+__arch_x86_64
+__xlated("0: r0 =3D 1")
+__xlated("1: exit")
+__success
+__naked void may_goto_batch_1(void)
+{
+	asm volatile (
+	".8byte %[may_goto1];"
+	".8byte %[may_goto2];"
+	".8byte %[may_goto3];"
+	"r0 =3D 1;"
+	".8byte %[may_goto1];"
+	".8byte %[may_goto2];"
+	".8byte %[may_goto3];"
+	"exit;"
+	:
+	: __imm_insn(may_goto1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2 /* of=
fset */, 0)),
+	  __imm_insn(may_goto2, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1 /* of=
fset */, 0)),
+	  __imm_insn(may_goto3, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0 /* of=
fset */, 0))
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("may_goto batch with offsets 2/0")
+__arch_x86_64
+__xlated("0: *(u64 *)(r10 -8) =3D 8388608")
+__xlated("1: r11 =3D *(u64 *)(r10 -8)")
+__xlated("2: if r11 =3D=3D 0x0 goto pc+3")
+__xlated("3: r11 -=3D 1")
+__xlated("4: *(u64 *)(r10 -8) =3D r11")
+__xlated("5: r0 =3D 1")
+__xlated("6: r0 =3D 2")
+__xlated("7: exit")
+__success
+__naked void may_goto_batch_2(void)
+{
+	asm volatile (
+	".8byte %[may_goto1];"
+	".8byte %[may_goto3];"
+	"r0 =3D 1;"
+	"r0 =3D 2;"
+	"exit;"
+	:
+	: __imm_insn(may_goto1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2 /* of=
fset */, 0)),
+	  __imm_insn(may_goto3, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0 /* of=
fset */, 0))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_2.c b/to=
ols/testing/selftests/bpf/progs/verifier_may_goto_2.c
new file mode 100644
index 000000000000..b891faf50660
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_2.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+int gvar;
+
+SEC("raw_tp")
+__description("C code with may_goto 0")
+__success
+int may_goto_c_code(void)
+{
+	int i, tmp[3];
+
+	for (i =3D 0; i < 3 && can_loop; i++)
+		tmp[i] =3D 0;
+
+	for (i =3D 0; i < 3 && can_loop; i++)
+		tmp[i] =3D gvar - i;
+
+	for (i =3D 0; i < 3 && can_loop; i++)
+		gvar +=3D tmp[i];
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.43.5


