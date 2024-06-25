Return-Path: <bpf+bounces-32979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8FC915B86
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5611C212D7
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253312B82;
	Tue, 25 Jun 2024 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6wxVwWn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96A1D54F;
	Tue, 25 Jun 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278092; cv=none; b=gvBpwFjCRSjksiL7b7g2LA/yR1WIQHD82U1lHRO5m/1YcO7B+XyJNXFgvNV3gZvh3qz1JVi3Fvcslvc726Ty/o373J7g3aWVRW4ohndGOQZ+oJY6yqsFTZ3BKPU5qb4Jxl2Qt9fDY96J1XxnEeP2VaUPxrJ0r2X0DnvAFzSbyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278092; c=relaxed/simple;
	bh=V7woCnDJIt5FXltY3SGt5B/sUDtrMfLtaeLuuDjex6A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jDfGjcMW9swbQVV+goCXTq6Q0lWu4uQWRGxD4izEIPQm4rd/bbxgWPiLpWy7Hnls7fV/ySBDrwsR+yze9eEESLJwyrwyibmRteP8xxrR98zxVGDsYA2Hc0ThYajalf4HDXflNacDQXdMPewGbkbpYprfnlZ2UBjXQ2bas40fBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6wxVwWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01884C2BBFC;
	Tue, 25 Jun 2024 01:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719278091;
	bh=V7woCnDJIt5FXltY3SGt5B/sUDtrMfLtaeLuuDjex6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f6wxVwWnpDYm65qHScbt6t863aCOxWeVjNNj8pfBrs8vbstB9kdlmvTRhgp4OOpG5
	 1DyJ6b2eZOeh/lGw6yiD6/J00yQxsSdH+lFBBOiAbmahP1R+0JPqCj4XRxFhsAauLg
	 OUd0BXA6JfOL9HWnjJFGGl7Da0FJCaHG5oXI/X2GWxqfaKS28gtdVPKajDiX2bTlJw
	 Z4whLGwMWB16PkNfx33m1FgGVAVofrxSPPmmWLgFlmLc5EndtI4ENHI3/4bvkP2xYy
	 58UbUvFf+BguzabsMcg84zdKzb5jfT/sjfFZhCzfdbGXtbimmnqTqeEwNJa1tTXee/
	 38VsXe+o5Z3ig==
Date: Tue, 25 Jun 2024 10:14:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, x86@kernel.org,
 peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
 bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/bpf: add test validating
 uprobe/uretprobe stack traces
Message-Id: <20240625101446.9dd0f4767392462e9923f0ba@kernel.org>
In-Reply-To: <20240522013845.1631305-5-andrii@kernel.org>
References: <20240522013845.1631305-1-andrii@kernel.org>
	<20240522013845.1631305-5-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 18:38:45 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Add a set of tests to validate that stack traces captured from or in the
> presence of active uprobes and uretprobes are valid and complete.
> 
> For this we use BPF program that are installed either on entry or exit
> of user function, plus deep-nested USDT. One of target funtions
> (target_1) is recursive to generate two different entries in the stack
> trace for the same uprobe/uretprobe, testing potential edge conditions.
> 
> Without fixes in this patch set, we get something like this for one of
> the scenarios:
> 
>  caller: 0x758fff - 0x7595ab
>  target_1: 0x758fd5 - 0x758fff
>  target_2: 0x758fca - 0x758fd5
>  target_3: 0x758fbf - 0x758fca
>  target_4: 0x758fb3 - 0x758fbf
>  ENTRY #0: 0x758fb3 (in target_4)
>  ENTRY #1: 0x758fd3 (in target_2)
>  ENTRY #2: 0x758ffd (in target_1)
>  ENTRY #3: 0x7fffffffe000
>  ENTRY #4: 0x7fffffffe000
>  ENTRY #5: 0x6f8f39
>  ENTRY #6: 0x6fa6f0
>  ENTRY #7: 0x7f403f229590
> 
> Entry #3 and #4 (0x7fffffffe000) are uretprobe trampoline addresses
> which obscure actual target_1 and another target_1 invocations. Also
> note that between entry #0 and entry #1 we are missing an entry for
> target_3, which is fixed in patch #2.

Please avoid using `patch #2` because after commit, this means nothing.

Thank you,

> 
> With all the fixes, we get desired full stack traces:
> 
>  caller: 0x758fff - 0x7595ab
>  target_1: 0x758fd5 - 0x758fff
>  target_2: 0x758fca - 0x758fd5
>  target_3: 0x758fbf - 0x758fca
>  target_4: 0x758fb3 - 0x758fbf
>  ENTRY #0: 0x758fb7 (in target_4)
>  ENTRY #1: 0x758fc8 (in target_3)
>  ENTRY #2: 0x758fd3 (in target_2)
>  ENTRY #3: 0x758ffd (in target_1)
>  ENTRY #4: 0x758ff3 (in target_1)
>  ENTRY #5: 0x75922c (in caller)
>  ENTRY #6: 0x6f8f39
>  ENTRY #7: 0x6fa6f0
>  ENTRY #8: 0x7f986adc4cd0
> 
> Now there is a logical and complete sequence of function calls.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../bpf/prog_tests/uretprobe_stack.c          | 186 ++++++++++++++++++
>  .../selftests/bpf/progs/uretprobe_stack.c     |  96 +++++++++
>  2 files changed, 282 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uretprobe_stack.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uretprobe_stack.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uretprobe_stack.c b/tools/testing/selftests/bpf/prog_tests/uretprobe_stack.c
> new file mode 100644
> index 000000000000..6deb8d560ddd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/uretprobe_stack.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include "uretprobe_stack.skel.h"
> +#include "../sdt.h"
> +
> +/* We set up target_1() -> target_2() -> target_3() -> target_4() -> USDT()
> + * call chain, each being traced by our BPF program. On entry or return from
> + * each target_*() we are capturing user stack trace and recording it in
> + * global variable, so that user space part of the test can validate it.
> + *
> + * Note, we put each target function into a custom section to get those
> + * __start_XXX/__stop_XXX symbols, generated by linker for us, which allow us
> + * to know address range of those functions
> + */
> +__attribute__((section("uprobe__target_4")))
> +__weak int target_4(void)
> +{
> +	STAP_PROBE1(uretprobe_stack, target, 42);
> +	return 42;
> +}
> +
> +extern const void *__start_uprobe__target_4;
> +extern const void *__stop_uprobe__target_4;
> +
> +__attribute__((section("uprobe__target_3")))
> +__weak int target_3(void)
> +{
> +	return target_4();
> +}
> +
> +extern const void *__start_uprobe__target_3;
> +extern const void *__stop_uprobe__target_3;
> +
> +__attribute__((section("uprobe__target_2")))
> +__weak int target_2(void)
> +{
> +	return target_3();
> +}
> +
> +extern const void *__start_uprobe__target_2;
> +extern const void *__stop_uprobe__target_2;
> +
> +__attribute__((section("uprobe__target_1")))
> +__weak int target_1(int depth)
> +{
> +	if (depth < 1)
> +		return 1 + target_1(depth + 1);
> +	else
> +		return target_2();
> +}
> +
> +extern const void *__start_uprobe__target_1;
> +extern const void *__stop_uprobe__target_1;
> +
> +extern const void *__start_uretprobe_stack_sec;
> +extern const void *__stop_uretprobe_stack_sec;
> +
> +struct range {
> +	long start;
> +	long stop;
> +};
> +
> +static struct range targets[] = {
> +	{}, /* we want target_1 to map to target[1], so need 1-based indexing */
> +	{ (long)&__start_uprobe__target_1, (long)&__stop_uprobe__target_1 },
> +	{ (long)&__start_uprobe__target_2, (long)&__stop_uprobe__target_2 },
> +	{ (long)&__start_uprobe__target_3, (long)&__stop_uprobe__target_3 },
> +	{ (long)&__start_uprobe__target_4, (long)&__stop_uprobe__target_4 },
> +};
> +
> +static struct range caller = {
> +	(long)&__start_uretprobe_stack_sec,
> +	(long)&__stop_uretprobe_stack_sec,
> +};
> +
> +static void validate_stack(__u64 *ips, int stack_len, int cnt, ...)
> +{
> +	int i, j;
> +	va_list args;
> +
> +	if (!ASSERT_GT(stack_len, 0, "stack_len"))
> +		return;
> +
> +	stack_len /= 8;
> +
> +	/* check if we have enough entries to satisfy test expectations */
> +	if (!ASSERT_GE(stack_len, cnt, "stack_len2"))
> +		return;
> +
> +	if (env.verbosity >= VERBOSE_NORMAL) {
> +		printf("caller: %#lx - %#lx\n", caller.start, caller.stop);
> +		for (i = 1; i < ARRAY_SIZE(targets); i++)
> +			printf("target_%d: %#lx - %#lx\n", i, targets[i].start, targets[i].stop);
> +		for (i = 0; i < stack_len; i++) {
> +			for (j = 1; j < ARRAY_SIZE(targets); j++) {
> +				if (ips[i] >= targets[j].start && ips[i] < targets[j].stop)
> +					break;
> +			}
> +			if (j < ARRAY_SIZE(targets)) { /* found target match */
> +				printf("ENTRY #%d: %#lx (in target_%d)\n", i, (long)ips[i], j);
> +			} else if (ips[i] >= caller.start && ips[i] < caller.stop) {
> +				printf("ENTRY #%d: %#lx (in caller)\n", i, (long)ips[i]);
> +			} else {
> +				printf("ENTRY #%d: %#lx\n", i, (long)ips[i]);
> +			}
> +		}
> +	}
> +
> +	va_start(args, cnt);
> +
> +	for (i = cnt - 1; i >= 0; i--) {
> +		/* most recent entry is the deepest target function */
> +		const struct range *t = va_arg(args, const struct range *);
> +
> +		ASSERT_GE(ips[i], t->start, "addr_start");
> +		ASSERT_LT(ips[i], t->stop, "addr_stop");
> +	}
> +
> +	va_end(args);
> +}
> +
> +/* __weak prevents inlining */
> +__attribute__((section("uretprobe_stack_sec")))
> +__weak void test_uretprobe_stack(void)
> +{
> +	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> +	struct uretprobe_stack *skel;
> +	int err;
> +
> +	skel = uretprobe_stack__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err = uretprobe_stack__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	/* trigger */
> +	ASSERT_EQ(target_1(0), 42 + 1, "trigger_return");
> +
> +	/*
> +	 * Stacks captured on ENTRY uprobes
> +	 */
> +
> +	/* (uprobe 1) target_1 in stack trace*/
> +	validate_stack(skel->bss->entry_stack1, skel->bss->entry1_len,
> +		       2, &caller, &targets[1]);
> +	/* (uprobe 1, recursed) */
> +	validate_stack(skel->bss->entry_stack1_recur, skel->bss->entry1_recur_len,
> +		       3, &caller, &targets[1], &targets[1]);
> +	/* (uprobe 2) caller -> target_1 -> target_1 -> target_2 */
> +	validate_stack(skel->bss->entry_stack2, skel->bss->entry2_len,
> +		       4, &caller, &targets[1], &targets[1], &targets[2]);
> +	/* (uprobe 3) */
> +	validate_stack(skel->bss->entry_stack3, skel->bss->entry3_len,
> +		       5, &caller, &targets[1], &targets[1], &targets[2], &targets[3]);
> +	/* (uprobe 4) caller -> target_1 -> target_1 -> target_2 -> target_3 -> target_4 */
> +	validate_stack(skel->bss->entry_stack4, skel->bss->entry4_len,
> +		       6, &caller, &targets[1], &targets[1], &targets[2], &targets[3], &targets[4]);
> +
> +	/* (USDT): full caller -> target_1 -> target_1 -> target_2 (uretprobed)
> +	 *              -> target_3 -> target_4 (uretprobes) chain
> +	 */
> +	validate_stack(skel->bss->usdt_stack, skel->bss->usdt_len,
> +		       6, &caller, &targets[1], &targets[1], &targets[2], &targets[3], &targets[4]);
> +
> +	/*
> +	 * Now stacks captured on the way out in EXIT uprobes
> +	 */
> +
> +	/* (uretprobe 4) everything up to target_4, but excluding it */
> +	validate_stack(skel->bss->exit_stack4, skel->bss->exit4_len,
> +		       5, &caller, &targets[1], &targets[1], &targets[2], &targets[3]);
> +	/* we didn't install uretprobes on target_2 and target_3 */
> +	/* (uretprobe 1, recur) first target_1 call only */
> +	validate_stack(skel->bss->exit_stack1_recur, skel->bss->exit1_recur_len,
> +		       2, &caller, &targets[1]);
> +	/* (uretprobe 1) just a caller in the stack trace */
> +	validate_stack(skel->bss->exit_stack1, skel->bss->exit1_len,
> +		       1, &caller);
> +
> +cleanup:
> +	uretprobe_stack__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/uretprobe_stack.c b/tools/testing/selftests/bpf/progs/uretprobe_stack.c
> new file mode 100644
> index 000000000000..9fdcf396b8f4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uretprobe_stack.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/usdt.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u64 entry_stack1[32], exit_stack1[32];
> +__u64 entry_stack1_recur[32], exit_stack1_recur[32];
> +__u64 entry_stack2[32];
> +__u64 entry_stack3[32];
> +__u64 entry_stack4[32], exit_stack4[32];
> +__u64 usdt_stack[32];
> +
> +int entry1_len, exit1_len;
> +int entry1_recur_len, exit1_recur_len;
> +int entry2_len, exit2_len;
> +int entry3_len, exit3_len;
> +int entry4_len, exit4_len;
> +int usdt_len;
> +
> +#define SZ sizeof(usdt_stack)
> +
> +SEC("uprobe//proc/self/exe:target_1")
> +int BPF_UPROBE(uprobe_1)
> +{
> +	/* target_1 is recursive wit depth of 2, so we capture two separate
> +	 * stack traces, depending on which occurence it is
> +	 */
> +	static bool recur = false;
> +
> +	if (!recur)
> +		entry1_len = bpf_get_stack(ctx, &entry_stack1, SZ, BPF_F_USER_STACK);
> +	else
> +		entry1_recur_len = bpf_get_stack(ctx, &entry_stack1_recur, SZ, BPF_F_USER_STACK);
> +
> +	recur = true;
> +	return 0;
> +}
> +
> +SEC("uretprobe//proc/self/exe:target_1")
> +int BPF_URETPROBE(uretprobe_1)
> +{
> +	/* see above, target_1 is recursive */
> +	static bool recur = false;
> +
> +	/* NOTE: order of returns is reversed to order of entries */
> +	if (!recur)
> +		exit1_recur_len = bpf_get_stack(ctx, &exit_stack1_recur, SZ, BPF_F_USER_STACK);
> +	else
> +		exit1_len = bpf_get_stack(ctx, &exit_stack1, SZ, BPF_F_USER_STACK);
> +
> +	recur = true;
> +	return 0;
> +}
> +
> +SEC("uprobe//proc/self/exe:target_2")
> +int BPF_UPROBE(uprobe_2)
> +{
> +	entry2_len = bpf_get_stack(ctx, &entry_stack2, SZ, BPF_F_USER_STACK);
> +	return 0;
> +}
> +
> +/* no uretprobe for target_2 */
> +
> +SEC("uprobe//proc/self/exe:target_3")
> +int BPF_UPROBE(uprobe_3)
> +{
> +	entry3_len = bpf_get_stack(ctx, &entry_stack3, SZ, BPF_F_USER_STACK);
> +	return 0;
> +}
> +
> +/* no uretprobe for target_3 */
> +
> +SEC("uprobe//proc/self/exe:target_4")
> +int BPF_UPROBE(uprobe_4)
> +{
> +	entry4_len = bpf_get_stack(ctx, &entry_stack4, SZ, BPF_F_USER_STACK);
> +	return 0;
> +}
> +
> +SEC("uretprobe//proc/self/exe:target_4")
> +int BPF_URETPROBE(uretprobe_4)
> +{
> +	exit4_len = bpf_get_stack(ctx, &exit_stack4, SZ, BPF_F_USER_STACK);
> +	return 0;
> +}
> +
> +SEC("usdt//proc/self/exe:uretprobe_stack:target")
> +int BPF_USDT(usdt_probe)
> +{
> +	usdt_len = bpf_get_stack(ctx, &usdt_stack, SZ, BPF_F_USER_STACK);
> +	return 0;
> +}
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

