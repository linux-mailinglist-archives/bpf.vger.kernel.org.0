Return-Path: <bpf+bounces-72594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F0EC1610E
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8B8188D1B6
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1230348468;
	Tue, 28 Oct 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFsEAYZR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074132D0FA;
	Tue, 28 Oct 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671371; cv=none; b=HYKtOkTJzhrUqe3xWzada72hR8PoQi3OSOeVYBSeu3FStGu0qEANs8KfV3ZGQN9z6S6livj7VLzag2HksS+J15UoyiHhXg/3EDOWwsuMauUx31WGfE54YknOe9DHZb3C5b13+T06pizbhv7rOwrq3Evmv4ToAHv1fp9m7WNjUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671371; c=relaxed/simple;
	bh=Q/DvAf8uCkX2SPY6TkNj/fjy6KkdM9UtV7Vt2f04sMY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V+RUDQ0z8XYuDjlEjN0t9H3BknG1ad5S5DJCdVMbrhCirjVcmmms/hjtaTxJEbZ4X8iL31DjU7D0k5OqEydEVT+9z4Txvksb4zN3+pbC0bZFlTp7cYx49XBWGpdy+NfU3v0BY3wfaTeEIjCAHJz/42b3kg1a4dXORtf+N5yTx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFsEAYZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931ADC4CEE7;
	Tue, 28 Oct 2025 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761671370;
	bh=Q/DvAf8uCkX2SPY6TkNj/fjy6KkdM9UtV7Vt2f04sMY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mFsEAYZRCq4UENune6IVXZdDlYzHgHBAwXb8WugQxY6+syeePOp+ipAyNcx50ahmG
	 O5+SL4Hbaj/XZ4qDPrEdGABNuzalNBc2QKpKkNGsHFCvFS1dLjgAdXotJkPiqqH3kR
	 SZx4o84mEt9zrh30Wd0vaMrfi5ogJIeMrxe8bPuB6a1x4r+M9QDArvkwry6q2qeP+O
	 NOQy1j0c3bCQ8TANoCaWQtcSMWd7vNxUoG0PS0wN1Uerwxr6GNCD7ZjiANvRrRGKNV
	 3l+d5AFNOJxNmu6XwqLoYp3Ne/L+qA1IS+bGbata46auw5Yv4s5/WvecO/6niXiOaj
	 bXzALiH5vNOvg==
Content-Type: multipart/mixed; boundary="===============9046533533940140989=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a48e281e6912037490270da40f79e45c1ad1e430c8c1cc84c48306106b06113a@mail.kernel.org>
In-Reply-To: <20251028162502.3418817-2-chen.dylane@linux.dev>
References: <20251028162502.3418817-2-chen.dylane@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/2] perf: Refactor get_perf_callchain
From: bot+bpf-ci@kernel.org
To: chen.dylane@linux.dev,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,kan.liang@linux.intel.com,song@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,chen.dylane@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 17:09:28 +0000 (UTC)

--===============9046533533940140989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 59cfc61f83ad4ec998f4242ca000c554e3001b47
Author: Tao Chen <chen.dylane@linux.dev>

perf: Refactor get_perf_callchain

This patch refactors get_perf_callchain() by extracting logic into new
helper functions to provide more flexible stack-sampling APIs for BPF.

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index fd1d91017..14a382cad 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
>  	u32				nr;
>  	short				contexts;
>  	bool				contexts_maxed;
> +	bool				add_mark;
>  };

[ ... ]

> @@ -1718,9 +1719,17 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
>
>  extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>  extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
> +
> +extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
> +				      struct perf_callchain_entry *entry,
> +				      u32 max_stack, bool add_mark);
> +
> +extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
> +extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
> +
>  extern struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -		   u32 max_stack, bool crosstask, bool add_mark);
> +		   u32 max_stack, bool crosstask);

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4d53cdd13..e28b35c7e 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  		max_depth = sysctl_perf_event_max_stack;
>
>  	trace = get_perf_callchain(regs, kernel, user, max_depth,
> -				   false, false);
> +				   false);
                                       ^^^^^ removed last parameter

Previously bpf_get_stackid() passed add_mark=false to get_perf_callchain().
Now the parameter is gone, but get_perf_callchain() hardcodes add_mark=true
when calling __init_perf_callchain_ctx(). This means BPF stack traces will
now include PERF_CONTEXT_KERNEL/PERF_CONTEXT_USER marker values when they
didn't before.

The markers get added by __get_perf_callchain_kernel() and
__get_perf_callchain_user() when ctx->add_mark is true. These markers are
sentinel values (-128 for KERNEL, -512 for USER) that appear in the trace
IP array alongside actual instruction pointers.

>
>  	if (unlikely(!trace))
>  		/* couldn't fetch the stack trace */
> @@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  		trace = get_callchain_entry_for_task(task, max_depth);
>  	else
>  		trace = get_perf_callchain(regs, kernel, user, max_depth,
> -					   crosstask, false);
> +					   crosstask);
                                                   ^^^^^ same issue here

Same problem in __bpf_get_stack() which was also passing add_mark=false.

This changes BPF stack map behavior in user-visible ways:

1) bpf_get_stackid() hashes the entire trace->ip[] array including any
   markers, so identical stacks will now produce different stack IDs.

2) bpf_get_stack() copies trace->ip[] directly to userspace buffers,
   so BPF programs will see marker values mixed with instruction pointers.

Can BPF tools handle these unexpected marker values? The commit message
says "The next patch will modify the BPF part" but doesn't explain this
intermediate behavior change.

> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 808c0d7a3..2c36e4906 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c

[ ... ]

>  struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -		   u32 max_stack, bool crosstask, bool add_mark)
> +		   u32 max_stack, bool crosstask)
>  {
>  	struct perf_callchain_entry *entry;
>  	struct perf_callchain_entry_ctx ctx;
> -	int rctx, start_entry_idx;
> +	int rctx;
>
>  	/* crosstask is not supported for user stacks */
>  	if (crosstask && user && !kernel)
> @@ -232,34 +273,14 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>  	if (!entry)
>  		return NULL;
>
> -	ctx.entry		= entry;
> -	ctx.max_stack		= max_stack;
> -	ctx.nr			= entry->nr = 0;
> -	ctx.contexts		= 0;
> -	ctx.contexts_maxed	= false;
> +	__init_perf_callchain_ctx(&ctx, entry, max_stack, true);
                                                                ^^^^
Here's where add_mark is hardcoded to true for all callers. The old code
allowed callers to control this via parameter. BPF was passing false,
perf_callchain() was passing true. Now both get true unconditionally.

[ ... ]

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7541f6f85..eb0f11059 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8218,7 +8218,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  		return &__empty_callchain;
>
>  	callchain = get_perf_callchain(regs, kernel, user,
> -				       max_stack, crosstask, true);
> +				       max_stack, crosstask);
>  	return callchain ?: &__empty_callchain;
>  }


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `perf: Refactor get_perf_callchain`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18882141979

--===============9046533533940140989==--

