Return-Path: <bpf+bounces-42344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920789A30CB
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3741C218B1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7BE1D86ED;
	Thu, 17 Oct 2024 22:32:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60F1D7E54
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204357; cv=none; b=B4EsJMDtK6OkQdsJ0Qqtv+4205tIvampJK996m8l4QKwxCTv3Lt1s8bYb485tqAWIYKhkTO6U6mgSM5BXTCdA76NEha2jhlF+DRVki+WckSALV4+eWn0OCGeJsl/A4rnWxDeZMZktnwO+Ogs/Ebt26GGBTPv4zfR/03r+1k++H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204357; c=relaxed/simple;
	bh=PVex4oQGYUtDO9nwOQiGRd76tefilsibaOCaDd1I45w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoLmjjEu14FmCB/JLJFExm1wcuwlzLSVODlphIpInush8E1qOLpHVM8clqbADW93LmLBlQF/9ZAQscU68OFn4U01rJIwEUye9wPSFlAkHUm630NssCDGOKzJuFNEb/SGulfHWatpF3Gg7rb9o/bPREIA43UNW8cF3iYUsXY1NMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B51B5A2F086C; Thu, 17 Oct 2024 15:32:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v5 8/9] selftests/bpf: Add tracing prog private stack tests
Date: Thu, 17 Oct 2024 15:32:19 -0700
Message-ID: <20241017223219.3178522-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017223138.3175885-1-yonghong.song@linux.dev>
References: <20241017223138.3175885-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some private stack tests are added including:
  - prog with stack size greater than BPF_PSTACK_MIN_SUBTREE_SIZE.
  - prog with stack size less than BPF_PSTACK_MIN_SUBTREE_SIZE.
  - prog with one subprog having MAX_BPF_STACK stack size and another
    subprog having non-zero stack size.
  - prog with callback function.
  - prog with exception in main prog or subprog.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_private_stack.c        | 216 ++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_private_st=
ack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index e26b5150fc43..635ff3509403 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -59,6 +59,7 @@
 #include "verifier_or_jmp32_k.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
+#include "verifier_private_stack.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"
@@ -185,6 +186,7 @@ void test_verifier_bpf_fastcall(void)         { RUN(v=
erifier_bpf_fastcall); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k)=
; }
 void test_verifier_precision(void)            { RUN(verifier_precision);=
 }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map=
_lookup); }
+void test_verifier_private_stack(void)        { RUN(verifier_private_sta=
ck); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack);=
 }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writ=
able); }
 void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal);=
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b=
/tools/testing/selftests/bpf/progs/verifier_private_stack.c
new file mode 100644
index 000000000000..e8de565f8b34
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+/* From include/linux/filter.h */
+#define MAX_BPF_STACK    512
+
+#if defined(__TARGET_ARCH_x86)
+
+SEC("kprobe")
+__description("Private stack, single prog")
+__success
+__arch_x86_64
+__jited("	movabsq	$0x{{.*}}, %r9")
+__jited("	addq	%gs:0x{{.*}}, %r9")
+__jited("	movl	$0x2a, %edi")
+__jited("	movq	%rdi, -0x100(%r9)")
+__naked void private_stack_single_prog(void)
+{
+	asm volatile (
+	"r1 =3D 42;"
+	"*(u64 *)(r10 - 256) =3D r1;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	:
+	: __clobber_all);
+}
+
+__used
+__naked static void cumulative_stack_depth_subprog(void)
+{
+        asm volatile (
+	"r1 =3D 41;"
+        "*(u64 *)(r10 - 32) =3D r1;"
+        "call %[bpf_get_smp_processor_id];"
+        "exit;"
+        :: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("kprobe")
+__description("Private stack, subtree > MAX_BPF_STACK")
+__success
+__arch_x86_64
+/* private stack fp for the main prog */
+__jited("	movabsq	$0x{{.*}}, %r9")
+__jited("	addq	%gs:0x{{.*}}, %r9")
+__jited("	movl	$0x2a, %edi")
+__jited("	movq	%rdi, -0x200(%r9)")
+__jited("	pushq	%r9")
+__jited("	callq	0x{{.*}}")
+__jited("	popq	%r9")
+__jited("	xorl	%eax, %eax")
+__naked void private_stack_nested_1(void)
+{
+	asm volatile (
+	"r1 =3D 42;"
+	"*(u64 *)(r10 - %[max_bpf_stack]) =3D r1;"
+	"call cumulative_stack_depth_subprog;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(max_bpf_stack, MAX_BPF_STACK)
+	: __clobber_all);
+}
+
+SEC("kprobe")
+__description("Private stack, subtree > MAX_BPF_STACK")
+__success
+__arch_x86_64
+/* private stack fp for the subprog */
+__jited("	addq	$0x20, %r9")
+__naked void private_stack_nested_2(void)
+{
+	asm volatile (
+	"r1 =3D 42;"
+	"*(u64 *)(r10 - %[max_bpf_stack]) =3D r1;"
+	"call cumulative_stack_depth_subprog;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(max_bpf_stack, MAX_BPF_STACK)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("No private stack, nested")
+__success
+__arch_x86_64
+__jited("	subq	$0x8, %rsp")
+__naked void no_private_stack_nested(void)
+{
+	asm volatile (
+	"r1 =3D 42;"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"call cumulative_stack_depth_subprog;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	:
+	: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long loop_callback(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 =3D 42;"
+	"*(u64 *)(r10 - 512) =3D r1;"
+	"call cumulative_stack_depth_subprog;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_common);
+}
+
+SEC("raw_tp")
+__description("Private stack, callback")
+__success
+__arch_x86_64
+/* for func loop_callback */
+__jited("func #1")
+__jited("	endbr64")
+__jited("	nopl	(%rax,%rax)")
+__jited("	nopl	(%rax)")
+__jited("	pushq	%rbp")
+__jited("	movq	%rsp, %rbp")
+__jited("	endbr64")
+__jited("	movabsq	$0x{{.*}}, %r9")
+__jited("	addq	%gs:0x{{.*}}, %r9")
+__jited("	pushq	%r9")
+__jited("	callq")
+__jited("	popq	%r9")
+__jited("	movl	$0x2a, %edi")
+__jited("	movq	%rdi, -0x200(%r9)")
+__jited("	pushq	%r9")
+__jited("	callq")
+__jited("	popq	%r9")
+__naked void private_stack_callback(void)
+{
+	asm volatile (
+	"r1 =3D 1;"
+	"r2 =3D %[loop_callback];"
+	"r3 =3D 0;"
+	"r4 =3D 0;"
+	"call %[bpf_loop];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_ptr(loop_callback),
+	  __imm(bpf_loop)
+	: __clobber_common);
+}
+
+SEC("fentry/bpf_fentry_test9")
+__description("Private stack, exception in main prog")
+__success __retval(0)
+__arch_x86_64
+__jited("	pushq	%r9")
+__jited("	callq")
+__jited("	popq	%r9")
+int private_stack_exception_main_prog(void)
+{
+	asm volatile (
+	"r1 =3D 42;"
+	"*(u64 *)(r10 - 512) =3D r1;"
+	::: __clobber_common);
+
+	bpf_throw(0);
+	return 0;
+}
+
+__used static int subprog_exception(void)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test9")
+__description("Private stack, exception in subprog")
+__success __retval(0)
+__arch_x86_64
+__jited("	movq	%rdi, -0x200(%r9)")
+__jited("	pushq	%r9")
+__jited("	callq")
+__jited("	popq	%r9")
+int private_stack_exception_sub_prog(void)
+{
+	asm volatile (
+	"r1 =3D 42;"
+	"*(u64 *)(r10 - 512) =3D r1;"
+	"call subprog_exception;"
+	::: __clobber_common);
+
+	return 0;
+}
+
+#else
+
+SEC("kprobe")
+__description("private stack is not supported, use a dummy test")
+__success
+int dummy_test(void)
+{
+        return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.43.5


