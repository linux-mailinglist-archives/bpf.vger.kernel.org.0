Return-Path: <bpf+bounces-74966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E33C6996B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0F363A42
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF734F259;
	Tue, 18 Nov 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDgKmdfJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB01D61A3;
	Tue, 18 Nov 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763472307; cv=none; b=E4Bycwz2I9Co35A9oIkSBhZpkLbPg7uTE7S4BZ1lPHmhbRkpIVsN7jAGqDxfaEOvszgBk0kJHsP0VJdTDComVcSq5FPAQn7ejQk5ZdTsl9JilC0Ogocq+8YOAfq0bSEyIBMymTPqID7S1B4YcIvxJrjYojNsWyQkmwJKt00rTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763472307; c=relaxed/simple;
	bh=F5W+P0I3YFJHta4PTmiymq7vv23UWVkLDdd8del4PDA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=p9Mgs9zxSyVtmr/9pQh4qPnVlnR/jQ/zjXYHS6mavGJJfFvXhrmjw7k1ZIe1ylYEKcCPnmn/wn2uRw9l6VaPBCpSkTdhdSXUCBf0h9FtmnWgnrk17f+uKDDmRLbTYRTGbIX9QCh+oqo2PIE5Rcq/pko6jmY0BiJdIgbntsEDfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDgKmdfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92180C19425;
	Tue, 18 Nov 2025 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763472306;
	bh=F5W+P0I3YFJHta4PTmiymq7vv23UWVkLDdd8del4PDA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pDgKmdfJMGU7ptY98gy55Bju3+TsbaUDRLfhPB2yzMB+PMEfiyQAqC/CuxMb7IzTM
	 0YIu8ZT/SJfZJ0rqA6R63ZK3Hjb72JDZeLqJFH762L36IZRrcvzXql8tXpB85MXntF
	 6dITIVlUsKHM4/I2V2nwBuvvYoc4VnCnsP38koVIrCJMxyaJkjYh+gbU5bqFFWRRjP
	 J5OKZVGHVbblqiUiN23F9oUz4BjRvO1ldsyAzlVZ9GOA1Yis8jvZxMxnvb5sZ7NX7y
	 E0VFCw8gEwHY9qnJmc9WaxxR5gB+naRIiYPWn+u+LGW9AzV693T3uHoYDmB4cO+32+
	 P9t5IPpQ9lzlg==
Content-Type: multipart/mixed; boundary="===============3617201011509474706=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83e39931f7cb3894d6fd3537550448b89a5aa60fb2e3757b56d6e8db91496e3d@mail.kernel.org>
In-Reply-To: <20251118123639.688444-2-dongml2@chinatelecom.cn>
References: <20251118123639.688444-2-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v3 1/6] ftrace: introduce FTRACE_OPS_FL_JMP
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,rostedt@goodmis.org
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mhiramat@kernel.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,jiang.biao@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Nov 2025 13:25:04 +0000 (UTC)

--===============3617201011509474706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 07f8c309e..015dd1049 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h

[ ... ]

> @@ -577,6 +578,38 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
>  						 unsigned long addr) { }
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
> +static inline bool ftrace_is_jmp(unsigned long addr)
> +{
> +	return addr & 1;
> +}
> +
> +static inline unsigned long ftrace_jmp_set(unsigned long addr)
> +{
> +	return addr | 1UL;
> +}
> +
> +static inline unsigned long ftrace_jmp_get(unsigned long addr)
> +{
> +	return addr & ~1UL;
> +}
> +#else
> +static inline bool ftrace_is_jmp(unsigned long addr)
> +{
> +	return false;
> +}
> +
> +static inline unsigned long ftrace_jmp_set(unsigned long addr)
> +{
> +	return addr;
> +}
> +
> +static inline unsigned long ftrace_jmp_get(unsigned long addr)
> +{
> +	return addr;
> +}
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_JMP */

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 59cfacb8a..bbb37c0f8 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> @@ -5951,7 +5951,8 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
>  	for (i = 0; i < size; i++) {
>  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
>  			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> -			if (del && del->direct == addr) {
> +			if (del && ftrace_jmp_get(del->direct) ==
> +				   ftrace_jmp_get(addr)) {
>  				remove_hash_entry(direct_functions, del);
>  				kfree(del);
>  			}

[ ... ]

> @@ -6016,8 +6017,15 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	if (ftrace_hash_empty(hash))
>  		return -EINVAL;
>
> +	/* This is a "raw" address, and this should never happen. */
> +	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
> +		return -EINVAL;
> +
>  	mutex_lock(&direct_mutex);
>
> +	if (ops->flags & FTRACE_OPS_FL_JMP)
> +		addr = ftrace_jmp_set(addr);
> +
>  	/* Make sure requested entries are not already registered.. */

[ ... ]

>  	/* ... and add the new entries */
>  	size = 1 << hash->size_bits;
>  	for (i = 0; i < size; i++) {
>  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
>  			new = add_hash_entry(new_hash, entry->ip);
>  			if (!new)
>  				goto out_unlock;
>  			/* Update both the copy and the hash entry */
>  			new->direct = addr;
>  			entry->direct = addr;
>  		}
>  	}

After addr is potentially encoded with ftrace_jmp_set(), it gets stored in
entry->direct. However, ftrace_find_rec_direct() returns entry->direct
without masking:

unsigned long ftrace_find_rec_direct(unsigned long ip)
{
	struct ftrace_func_entry *entry;

	entry = __ftrace_lookup_ip(direct_functions, ip);
	if (!entry)
		return 0;

	return entry->direct;
}

This encoded address flows to two consumers:

1. ftrace_get_addr_new() and ftrace_get_addr_curr() return it directly,
   which eventually reaches architecture-specific ftrace_call_replace().
   Can the architecture code handle addresses with LSB set?

2. The debug output at kernel/trace/ftrace.c in ftrace_enabled_show():
   seq_printf(m, "\n\tdirect-->%pS", (void *)direct);

   Won't this print the wrong symbol due to the LSB being set?

>  	ops->func = call_direct_funcs;
>  	ops->flags = MULTI_FLAGS;
>  	ops->trampoline = FTRACE_REGS_ADDR;
>  	ops->direct_call = addr;

Similarly, ops->direct_call stores the encoded address. In
call_direct_funcs():

static void call_direct_funcs(unsigned long ip, unsigned long pip,
			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
{
	unsigned long addr = READ_ONCE(ops->direct_call);

	if (!addr)
		return;

	arch_ftrace_set_direct_caller(fregs, addr);
}

The encoded address is passed directly to arch_ftrace_set_direct_caller()
without masking. Looking at arch implementations like x86:

static inline void
__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
{
	/* Emulate a call */
	regs->orig_ax = addr;
}

Does arch_ftrace_set_direct_caller() expect addresses with the LSB set?
The implementations directly store the address into registers without any
masking.

The commit message says "we can tell if we should use 'jmp' for the
callback in ftrace_call_replace()", but no architecture code is updated
to check the LSB. Should ftrace_find_rec_direct() and call_direct_funcs()
mask the JMP bit before returning addresses to architecture code?

> @@ -6136,8 +6146,13 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>
>  	lockdep_assert_held_once(&direct_mutex);
>
> +	/* This is a "raw" address, and this should never happen. */
> +	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
> +		return -EINVAL;
> +
> +	if (ops->flags & FTRACE_OPS_FL_JMP)
> +		addr = ftrace_jmp_set(addr);

Same encoding happens here with the same flow issues.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19466635856

--===============3617201011509474706==--

