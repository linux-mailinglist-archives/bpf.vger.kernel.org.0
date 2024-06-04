Return-Path: <bpf+bounces-31308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ABA8FB4F3
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EB1283491
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B18179AF;
	Tue,  4 Jun 2024 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/yl1xYe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94D3BB24;
	Tue,  4 Jun 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510399; cv=none; b=mVKLTsrXJOqqiL869S2NS3cj2Db4lH4p3myIc+JNOtjNIxMGbjgTnEBS2ZeVmqy9zg6kc4UlKhtngS9EUcPEQqLyj16ytw6hTd4XWXSkh4om1n/KtEnjq9MUNBwgw8g5jdUC7E5o7GdXMdIZHM0wx3lulcPFvS+VnIAt4abS3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510399; c=relaxed/simple;
	bh=TybqTnYv/G8almeqnEbRGLQ+Mr7wcLlFiwLjpfYRdgQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DwRypkXgZDNvlp0QUceMpnsRujNyBeNDUAtY+VffGk4HFgN9XlSnGfiQAAv7gNkCsMBgQn9G0AejZIWPINOiDJtbUhByc2P36sVXFwE3dj38nbsGqHdI8urnvu0WFvUNpt468eDkJPumVKN1vI7ddQm674pRbQmev/xCso+OR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/yl1xYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6018C32786;
	Tue,  4 Jun 2024 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510399;
	bh=TybqTnYv/G8almeqnEbRGLQ+Mr7wcLlFiwLjpfYRdgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N/yl1xYe7Un7Bwx5pfdUzmCwe9WODTi+9/3mwRcs8hU1OU2MNTY5QRRGEMT8VNs4S
	 PjyIypNlGq0k4+6ZdC89aCkYyH5YLxb+SGlG1mut4mSsc24DOEvcqtZAiAEATbs3j/
	 fJHx6gOePNwjXWBxnDWZiaWWPCnS26pe3E8e4QgCQ7KLmQJ+ASB26Q6iWySI/e5wUx
	 4RW+cjt1qEUOYIoaTAMz7Jpd5ifLdwr63Odz8LI4yJao1ZA9bzH7ZDFJONZs2CtR+l
	 QC76PiNq+z9v+JqyeDGThBw9I44IwJNHoNPSxUVxW9nokoMUb8JrSS1gPBHa3Vow8j
	 nwazA3g6VZxVQ==
Date: Tue, 4 Jun 2024 23:13:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, x86@kernel.org,
 peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
 bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org, Riham
 Selim <rihams@meta.com>
Subject: Re: [PATCH v2 2/4] perf,uprobes: fix user stack traces in the
 presence of pending uretprobes
Message-Id: <20240604231314.e924c51f7b9a18428a8a7f0f@kernel.org>
In-Reply-To: <20240522013845.1631305-3-andrii@kernel.org>
References: <20240522013845.1631305-1-andrii@kernel.org>
	<20240522013845.1631305-3-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 18:38:43 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> When kernel has pending uretprobes installed, it hijacks original user
> function return address on the stack with a uretprobe trampoline
> address. There could be multiple such pending uretprobes (either on
> different user functions or on the same recursive one) at any given
> time within the same task.
> 
> This approach interferes with the user stack trace capture logic, which
> would report suprising addresses (like 0x7fffffffe000) that correspond
> to a special "[uprobes]" section that kernel installs in the target
> process address space for uretprobe trampoline code, while logically it
> should be an address somewhere within the calling function of another
> traced user function.
> 
> This is easy to correct for, though. Uprobes subsystem keeps track of
> pending uretprobes and records original return addresses. This patch is
> using this to do a post-processing step and restore each trampoline
> address entries with correct original return address. This is done only
> if there are pending uretprobes for current task.
> 
> This is a similar approach to what fprobe/kretprobe infrastructure is
> doing when capturing kernel stack traces in the presence of pending
> return probes.
> 

This looks good to me because this trampoline information is only
managed in uprobes. And it should be provided when unwinding user
stack.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Reported-by: Riham Selim <rihams@meta.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/callchain.c | 43 ++++++++++++++++++++++++++++++++++++++-
>  kernel/events/uprobes.c   |  9 ++++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1273be84392c..b17e3323f7f6 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -11,6 +11,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/slab.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/uprobes.h>
>  
>  #include "internal.h"
>  
> @@ -176,13 +177,51 @@ put_callchain_entry(int rctx)
>  	put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
>  }
>  
> +static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entry,
> +					       int start_entry_idx)
> +{
> +#ifdef CONFIG_UPROBES
> +	struct uprobe_task *utask = current->utask;
> +	struct return_instance *ri;
> +	__u64 *cur_ip, *last_ip, tramp_addr;
> +
> +	if (likely(!utask || !utask->return_instances))
> +		return;
> +
> +	cur_ip = &entry->ip[start_entry_idx];
> +	last_ip = &entry->ip[entry->nr - 1];
> +	ri = utask->return_instances;
> +	tramp_addr = uprobe_get_trampoline_vaddr();
> +
> +	/*
> +	 * If there are pending uretprobes for the current thread, they are
> +	 * recorded in a list inside utask->return_instances; each such
> +	 * pending uretprobe replaces traced user function's return address on
> +	 * the stack, so when stack trace is captured, instead of seeing
> +	 * actual function's return address, we'll have one or many uretprobe
> +	 * trampoline addresses in the stack trace, which are not helpful and
> +	 * misleading to users.
> +	 * So here we go over the pending list of uretprobes, and each
> +	 * encountered trampoline address is replaced with actual return
> +	 * address.
> +	 */
> +	while (ri && cur_ip <= last_ip) {
> +		if (*cur_ip == tramp_addr) {
> +			*cur_ip = ri->orig_ret_vaddr;
> +			ri = ri->next;
> +		}
> +		cur_ip++;
> +	}
> +#endif
> +}
> +
>  struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
>  		   u32 max_stack, bool crosstask, bool add_mark)
>  {
>  	struct perf_callchain_entry *entry;
>  	struct perf_callchain_entry_ctx ctx;
> -	int rctx;
> +	int rctx, start_entry_idx;
>  
>  	entry = get_callchain_entry(&rctx);
>  	if (!entry)
> @@ -215,7 +254,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
>  			if (add_mark)
>  				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
>  
> +			start_entry_idx = entry->nr;
>  			perf_callchain_user(&ctx, regs);
> +			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
>  		}
>  	}
>  
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index d60d24f0f2f4..1c99380dc89d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2149,6 +2149,15 @@ static void handle_trampoline(struct pt_regs *regs)
>  
>  		instruction_pointer_set(regs, ri->orig_ret_vaddr);
>  		do {
> +			/* pop current instance from the stack of pending return instances,
> +			 * as it's not pending anymore: we just fixed up original
> +			 * instruction pointer in regs and are about to call handlers;
> +			 * this allows fixup_uretprobe_trampoline_entries() to properly fix up
> +			 * captured stack traces from uretprobe handlers, in which pending
> +			 * trampoline addresses on the stack are replaced with correct
> +			 * original return addresses
> +			 */
> +			utask->return_instances = ri->next;
>  			if (valid)
>  				handle_uretprobe_chain(ri, regs);
>  			ri = free_ret_instance(ri);
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

