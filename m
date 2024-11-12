Return-Path: <bpf+bounces-44653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3AB9C5D96
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12C91F227BC
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7AF206972;
	Tue, 12 Nov 2024 16:41:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094B206951
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429709; cv=none; b=PL65K1rIs8HBXelRfnVEXSCeGr6Y/+nPMFVkxN/utbXybHyph4xNl0ZxXG3epWqCCR/Yjf8PoS0qhH1LAqKIWLpb2lYozx9hAuujh88lCvlMpNz+lt8sEzEEbZ8FlU23bD5Mkm612+k1ywSszid/2ynU3Fi0NEQWHq0nsjMGsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429709; c=relaxed/simple;
	bh=0i0qoMsPI/gwZFvf/9Gf4WnAAY/a8mpe4tYYz/MW2xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXn0iFe1kOhPAcHkCdj62zDrsdF1wY5ivdOyDREB0KwTLa4ltmjLsMEsHSUZ0X/QcOP+eUKOagz7o8YOo9DMeRi3lAAT+ZJY8fkuDMGdc0+yHaP/CbzZ9ccrqYFWt6INvDrjvtwJkXYPN2OjHRfivoMpwIZVzQn7WwNXxLxGwp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id F1A9CAFAF8E5; Tue, 12 Nov 2024 08:39:27 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v12 5/7] selftests/bpf: Add tracing prog private stack tests
Date: Tue, 12 Nov 2024 08:39:27 -0800
Message-ID: <20241112163927.2224750-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112163902.2223011-1-yonghong.song@linux.dev>
References: <20241112163902.2223011-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some private stack tests are added including:
  - main prog only with stack size greater than BPF_PSTACK_MIN_SIZE.
  - main prog only with stack size smaller than BPF_PSTACK_MIN_SIZE.
  - prog with one subprog having MAX_BPF_STACK stack size and another
    subprog having non-zero small stack size.
  - prog with callback function.
  - prog with exception in main prog or subprog.
  - prog with async callback without nesting
  - prog with async callback with possible nesting

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_private_stack.c        | 272 ++++++++++++++++++
 2 files changed, 274 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_private_st=
ack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 75f7a2ce334b..d9f65adb456b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -61,6 +61,7 @@
 #include "verifier_or_jmp32_k.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
+#include "verifier_private_stack.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"
@@ -188,6 +189,7 @@ void test_verifier_bpf_fastcall(void)         { RUN(v=
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
index 000000000000..b1fbdf119553
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -0,0 +1,272 @@
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
+struct elem {
+	struct bpf_timer t;
+	char pad[256];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} array SEC(".maps");
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
+	asm volatile ("			\
+	r1 =3D 42;			\
+	*(u64 *)(r10 - 256) =3D r1;	\
+	r0 =3D 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("No private stack")
+__success
+__arch_x86_64
+__jited("	subq	$0x8, %rsp")
+__naked void no_private_stack_nested(void)
+{
+	asm volatile ("			\
+	r1 =3D 42;			\
+	*(u64 *)(r10 - 8) =3D r1;		\
+	r0 =3D 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+__used
+__naked static void cumulative_stack_depth_subprog(void)
+{
+	asm volatile ("				\
+	r1 =3D 41;				\
+	*(u64 *)(r10 - 32) =3D r1;		\
+	call %[bpf_get_smp_processor_id];	\
+	exit;					\
+"	:
+	: __imm(bpf_get_smp_processor_id)
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
+	asm volatile ("				\
+	r1 =3D 42;				\
+	*(u64 *)(r10 - %[max_bpf_stack]) =3D r1;	\
+	call cumulative_stack_depth_subprog;	\
+	r0 =3D 0;					\
+	exit;					\
+"	:
+	: __imm_const(max_bpf_stack, MAX_BPF_STACK)
+	: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long loop_callback(void)
+{
+	asm volatile ("				\
+	call %[bpf_get_prandom_u32];		\
+	r1 =3D 42;				\
+	*(u64 *)(r10 - 512) =3D r1;		\
+	call cumulative_stack_depth_subprog;	\
+	r0 =3D 0;					\
+	exit;					\
+"	:
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
+	asm volatile ("			\
+	r1 =3D 1;				\
+	r2 =3D %[loop_callback];		\
+	r3 =3D 0;				\
+	r4 =3D 0;				\
+	call %[bpf_loop];		\
+	r0 =3D 0;				\
+	exit;				\
+"	:
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
+	asm volatile ("			\
+	r1 =3D 42;			\
+	*(u64 *)(r10 - 512) =3D r1;	\
+"	::: __clobber_common);
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
+	asm volatile ("			\
+	r1 =3D 42;			\
+	*(u64 *)(r10 - 512) =3D r1;	\
+	call subprog_exception;		\
+"	::: __clobber_common);
+
+	return 0;
+}
+
+int glob;
+__noinline static void subprog2(int *val)
+{
+	glob +=3D val[0] * 2;
+}
+
+__noinline static void subprog1(int *val)
+{
+	int tmp[64] =3D {};
+
+	tmp[0] =3D *val;
+	subprog2(tmp);
+}
+
+__noinline static int timer_cb1(void *map, int *key, struct bpf_timer *t=
imer)
+{
+	subprog1(key);
+	return 0;
+}
+
+__noinline static int timer_cb2(void *map, int *key, struct bpf_timer *t=
imer)
+{
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test9")
+__description("Private stack, async callback, not nested")
+__success __retval(0)
+__arch_x86_64
+__jited("	movabsq	$0x{{.*}}, %r9")
+int private_stack_async_callback_1(void)
+{
+	struct bpf_timer *arr_timer;
+	int array_key =3D 0;
+
+	arr_timer =3D bpf_map_lookup_elem(&array, &array_key);
+	if (!arr_timer)
+		return 0;
+
+	bpf_timer_init(arr_timer, &array, 1);
+	bpf_timer_set_callback(arr_timer, timer_cb2);
+	bpf_timer_start(arr_timer, 0, 0);
+	subprog1(&array_key);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test9")
+__description("Private stack, async callback, potential nesting")
+__success __retval(0)
+__arch_x86_64
+__jited("	subq	$0x100, %rsp")
+int private_stack_async_callback_2(void)
+{
+	struct bpf_timer *arr_timer;
+	int array_key =3D 0;
+
+	arr_timer =3D bpf_map_lookup_elem(&array, &array_key);
+	if (!arr_timer)
+		return 0;
+
+	bpf_timer_init(arr_timer, &array, 1);
+	bpf_timer_set_callback(arr_timer, timer_cb1);
+	bpf_timer_start(arr_timer, 0, 0);
+	subprog1(&array_key);
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
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.43.5


