Return-Path: <bpf+bounces-31295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727398FAEAF
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE541F21CB6
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2153A143C44;
	Tue,  4 Jun 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL1F9D7q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624C14374B;
	Tue,  4 Jun 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493088; cv=none; b=tmP5b6ozH9u8/mEKy0/0UIZ9QcOLlFPYkrOpo2jIu3GCWljsIMd1s8gYrK+tcLbC9aULM4ANQ8UPjO5jubZATxBke6I8wYe4W9F+y8C1wpUWIYsowUut5CgYAtEsI8CZolyhHkt4nb5t7+9DzPIlVdrKEvnuJKcKm96GxSPQGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493088; c=relaxed/simple;
	bh=yOjB7ZAP5RO7pzz2ve/vsO4b0uZjpOP5jFAuhVWgUYg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtXOOCeioVL4VhK5sshkUZKDbbPKROqVeWgB8B9TOg+yJKOdbaMiIVFvZdFY4iKW4J/Uni+p+XN2eEF0XUpnEL/BZwOchbAn8QkGyz0oBcG3l1jdZPdcMJRx/jPSExfPo3g32GOJ2oBkkbkGFrRTgnBteowHsltzCAqGlMgTlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL1F9D7q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a692130eb19so174037266b.2;
        Tue, 04 Jun 2024 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717493085; x=1718097885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N43+CQqubVBGSkmc/WFKOx/su1F+ul7WAa/riHvyHGg=;
        b=VL1F9D7qxl+VsVV62CcpV/8F+dMML/G9kBHIlgTTsmj6eFbTQ+5vwlYgvzUtw2Y0sq
         utjecJRslUo9XwfA2+Ik6WMCF41WgO66KM6zcj6Y+opfR4YwmKZDmp33poHWGvGzQ0ye
         nmxyzEUWVa4eIJLvb0S9T8JW+EVXC1qjAZ2SGrVsJkG+y4V4ksJwKdyRbsINf8eOejR1
         KDgRJTXgs45hKKHxbpmjQDCDDnChqsOW9sHDBHQ/c5Nys8qwvbJXtcVhMY4mDvPBWg+8
         J59OXS8VyMjE40FsfTZ4XovCiYVrBtsnnA7GIdf3cA+Ajq/OWIevnVXNfd28zmTUHjkh
         30wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717493085; x=1718097885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N43+CQqubVBGSkmc/WFKOx/su1F+ul7WAa/riHvyHGg=;
        b=HER/WJq4dZYOKBObobXDZnE+fngscjMzXX6AszJQUUJbojp3pOg+ug3GO55/u6M5tQ
         5mh8ZJmaShmpF25fnaKGakEi2Ye+9VlTdD9nMYtgjQnVDqZmbr9Fd7ZXk1Q+v5XCL2AT
         pmxRLCXC1dMQ4SJkb2HWt5hWRLIfpp2LnK8TMBVddf2v2y1k9ZB9UwdV9Oi2xKvdOSGL
         J9BRi9JvoNTrcjBLWmcwNu37NWJDPGbYZgCfpastZbyA6T2Pk4t09yBbMIIPb4IADHBC
         0oO70eGBcLBNNfn1HgbkZuucJkeBAGysriYrP7X+no7Q4VgkkqTPmNCVy5y3/jTyAK9V
         gQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCt8dtwqmuldgihBaKh2RvZoEUMtUW+nwsmYXqDpE51rbq7L+4bgx6Y1WNgFliHyzr2Vpgo0G4XejxgK03dVdBVHAtkPWCs0H8NicdmmxtkwSZXG5/ht9twusxu8wlddz5OE3vZw==
X-Gm-Message-State: AOJu0YxJC636+GOB9NeoIou5Brpa0Cnn5a1qziFhzdoF6JshxSYyajBA
	1Z7lD52aOEldg0CMSzIvIuXYYSZzX6fqqibAxGC7k6itEDnAbDzY
X-Google-Smtp-Source: AGHT+IFaqFUoiiSBXOyJ0Ipl5gANo/RvpOKu0BxMEfT5BV+yOIXd9R+SS0BUnZ+6ZJbDjMsPZC+Z9A==
X-Received: by 2002:a17:906:743:b0:a68:a800:5f7e with SMTP id a640c23a62f3a-a68a80061bcmr555880966b.10.1717493084811;
        Tue, 04 Jun 2024 02:24:44 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f0371dsm596338466b.42.2024.06.04.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:24:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Jun 2024 11:24:42 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, x86@kernel.org, peterz@infradead.org,
	mingo@redhat.com, tglx@linutronix.de, bpf@vger.kernel.org,
	rihams@fb.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/bpf: add test validating
 uprobe/uretprobe stack traces
Message-ID: <Zl7dWp3orPPVU_tH@krava>
References: <20240522013845.1631305-1-andrii@kernel.org>
 <20240522013845.1631305-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522013845.1631305-5-andrii@kernel.org>

On Tue, May 21, 2024 at 06:38:45PM -0700, Andrii Nakryiko wrote:
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

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

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
> 

