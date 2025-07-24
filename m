Return-Path: <bpf+bounces-64252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624BB109E2
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36AD3ADD50
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7482C1592;
	Thu, 24 Jul 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E656/DPA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBB2BEC23
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358595; cv=none; b=Gp+vnR/XYPlpQmGT9PMoP6zv/k2sn7lrAIvc1yGoytNVuo+awYtEqLAUM6I1ZrYoiar9aTkw2yQh8bnCNCrGwaJS0vsvKoykvZf27IYKXntFbi0bzGXr+/v7xUPg1kqmdsGshyiK/ZKsyT++RphVJPwPep2mk8NzBCM0eqslAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358595; c=relaxed/simple;
	bh=nolUSilotNkAm2kLZ4cQAsSat4Ph0ssvFynBU/bqJwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH+kXA+q01QIUK4OnkIQistqgoKawXyMsVzj4dVa7aC7FVQpa0gJin26sh1j87+UWRv/cwpPjb4jV/HHsgN9cJ/HeHXuf5EyjgTwOhq1+cYJtIkoGlcmP2/VrmGAUQupve4WsGBQKApZ82fe3gmpWuDU2Xb6rBVuyjzxfUnUhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E656/DPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32CFC4CEED;
	Thu, 24 Jul 2025 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753358594;
	bh=nolUSilotNkAm2kLZ4cQAsSat4Ph0ssvFynBU/bqJwo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E656/DPA3Vs1BDk48fsoZVWmR1LSdTa2H2wS/unQ+4dOJ93gVM8anpGYithZgUNar
	 6yU+cM3NpGgUmO8z6vSInfnzWV7I/cG5fMjN79L0ZLlXvqtc1Kb8LHMu62ZsuQcbTL
	 HIFWtzAL1bOxohESUZbfE5uSIRQ4XlyJG3twozgYqQ9vY6RlIhv4mqNXEjMmpS8doN
	 X+FORj4MCs/7EVaA9LDkRSkcdZixL74us8ZiV63DSKqjaHE9NhRPLp/naLfP7utR3S
	 niigiKJ5L6uXOJxKJLTcXhW4W0bkWsjVEIZam249Xnq0zd0dssayGp+6Y+pButP3zK
	 yiWvZiYVqGAwg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: enable private stack tests for arm64
Date: Thu, 24 Jul 2025 12:02:55 +0000
Message-ID: <20250724120257.7299-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250724120257.7299-1-puranjay@kernel.org>
References: <20250724120257.7299-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As arm64 JIT now supports private stack, make sure all relevant tests
run on arm64 architecture

Relevant tests:

 #415/1   struct_ops_private_stack/private_stack:OK
 #415/2   struct_ops_private_stack/private_stack_fail:OK
 #415/3   struct_ops_private_stack/private_stack_recur:OK
 #415     struct_ops_private_stack:OK
 #549/1   verifier_private_stack/Private stack, single prog:OK
 #549/2   verifier_private_stack/Private stack, subtree > MAX_BPF_STACK:OK
 #549/3   verifier_private_stack/No private stack:OK
 #549/4   verifier_private_stack/Private stack, callback:OK
 #549/5   verifier_private_stack/Private stack, exception in mainprog:OK
 #549/6   verifier_private_stack/Private stack, exception in subprog:OK
 #549/7   verifier_private_stack/Private stack, async callback, not nested:OK
 #549/8   verifier_private_stack/Private stack, async callback, potential nesting:OK
 #549     verifier_private_stack:OK
 Summary: 2/11 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../bpf/progs/struct_ops_private_stack.c      |  2 +-
 .../bpf/progs/struct_ops_private_stack_fail.c |  2 +-
 .../progs/struct_ops_private_stack_recur.c    |  2 +-
 .../bpf/progs/verifier_private_stack.c        | 89 ++++++++++++++++++-
 4 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
index 0e4d2ff63ab81..dbe646013811a 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
@@ -7,7 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
index 58d5d8dc22352..3d89ad7cbe2a9 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
@@ -7,7 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
index 31e58389bb8b0..b1f6d7e5a8e50 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
@@ -7,7 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index fc91b414364e0..1ecd34ebde196 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -8,7 +8,7 @@
 /* From include/linux/filter.h */
 #define MAX_BPF_STACK    512
 
-#if defined(__TARGET_ARCH_x86)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 
 struct elem {
 	struct bpf_timer t;
@@ -30,6 +30,18 @@ __jited("	movabsq	$0x{{.*}}, %r9")
 __jited("	addq	%gs:{{.*}}, %r9")
 __jited("	movl	$0x2a, %edi")
 __jited("	movq	%rdi, -0x100(%r9)")
+__arch_arm64
+__jited("	stp	x25, x27, [sp, {{.*}}]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("...")
+__jited("	ldp	x25, x27, [sp], {{.*}}")
 __naked void private_stack_single_prog(void)
 {
 	asm volatile ("			\
@@ -45,6 +57,9 @@ __description("No private stack")
 __success
 __arch_x86_64
 __jited("	subq	$0x8, %rsp")
+__arch_arm64
+__jited("	mov	x25, sp")
+__jited("	sub	sp, sp, #0x10")
 __naked void no_private_stack_nested(void)
 {
 	asm volatile ("			\
@@ -81,6 +96,19 @@ __jited("	pushq	%r9")
 __jited("	callq	0x{{.*}}")
 __jited("	popq	%r9")
 __jited("	xorl	%eax, %eax")
+__arch_arm64
+__jited("	stp	x25, x27, [sp, {{.*}}]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("	bl	{{.*}}")
+__jited("...")
+__jited("	ldp	x25, x27, [sp], {{.*}}")
 __naked void private_stack_nested_1(void)
 {
 	asm volatile ("				\
@@ -131,6 +159,24 @@ __jited("	movq	%rdi, -0x200(%r9)")
 __jited("	pushq	%r9")
 __jited("	callq")
 __jited("	popq	%r9")
+__arch_arm64
+__jited("func #1")
+__jited("...")
+__jited("	stp	x25, x27, [sp, {{.*}}]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	bl	0x{{.*}}")
+__jited("	add	x7, x0, #0x0")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("	bl	0x{{.*}}")
+__jited("	add	x7, x0, #0x0")
+__jited("	mov	x7, #0x0")
+__jited("	ldp	x25, x27, [sp], {{.*}}")
 __naked void private_stack_callback(void)
 {
 	asm volatile ("			\
@@ -154,6 +200,28 @@ __arch_x86_64
 __jited("	pushq	%r9")
 __jited("	callq")
 __jited("	popq	%r9")
+__arch_arm64
+__jited("	stp	x29, x30, [sp, #-0x10]!")
+__jited("	mov	x29, sp")
+__jited("	stp	xzr, x26, [sp, #-0x10]!")
+__jited("	mov	x26, sp")
+__jited("	stp	x19, x20, [sp, #-0x10]!")
+__jited("	stp	x21, x22, [sp, #-0x10]!")
+__jited("	stp	x23, x24, [sp, #-0x10]!")
+__jited("	stp	x25, x26, [sp, #-0x10]!")
+__jited("	stp	x27, x28, [sp, #-0x10]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("	mov	x0, #0x0")
+__jited("	bl	0x{{.*}}")
+__jited("	add	x7, x0, #0x0")
+__jited("	ldp	x27, x28, [sp], #0x10")
 int private_stack_exception_main_prog(void)
 {
 	asm volatile ("			\
@@ -179,6 +247,19 @@ __jited("	movq	%rdi, -0x200(%r9)")
 __jited("	pushq	%r9")
 __jited("	callq")
 __jited("	popq	%r9")
+__arch_arm64
+__jited("	stp	x27, x28, [sp, #-0x10]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("	bl	0x{{.*}}")
+__jited("	add	x7, x0, #0x0")
+__jited("	ldp	x27, x28, [sp], #0x10")
 int private_stack_exception_sub_prog(void)
 {
 	asm volatile ("			\
@@ -220,6 +301,10 @@ __description("Private stack, async callback, not nested")
 __success __retval(0)
 __arch_x86_64
 __jited("	movabsq	$0x{{.*}}, %r9")
+__arch_arm64
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
 int private_stack_async_callback_1(void)
 {
 	struct bpf_timer *arr_timer;
@@ -241,6 +326,8 @@ __description("Private stack, async callback, potential nesting")
 __success __retval(0)
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
+__arch_arm64
+__jited("	sub	sp, sp, #0x100")
 int private_stack_async_callback_2(void)
 {
 	struct bpf_timer *arr_timer;
-- 
2.47.3


