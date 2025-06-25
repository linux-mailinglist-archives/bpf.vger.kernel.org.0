Return-Path: <bpf+bounces-61502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934FAE79E9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 10:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70965164299
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A710213E89;
	Wed, 25 Jun 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4qskF4o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EF20E00B;
	Wed, 25 Jun 2025 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839686; cv=none; b=hIAWrykGs2VN64rRifLUrA8x6Q4CJGZIQJUTQa6NmrY2b2Cpq38XYrDEClxOexioAm5ZtDIVttGR95nI55iUg/27vXioyjMbNUH7rNtM1JlOo0O/+jS6S5ppaT/XBaHTKJ+fgd0eXe3qnaVbsaSvsXV66f1m8Q3JBadK1znnTLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839686; c=relaxed/simple;
	bh=7DHD/1kpF16rely2ZdhPgdqVtGCe6hUy6TmFIpiu3Zo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aU8WP29UtxdpHh1MrqXLA46TlXGHiu31LkNBw3RDZnwJfV30X8WTAQOP/FkGntO1iLbZ6Eu1donkK2dmCE/4cVjQZZRa3j+GFHhMrdCU8k1iURU+ezq9HeCAx820DIpZLR/g8HfXf+clFdthPj+/Jx4Zu0SocdaXRJrWrGfn7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4qskF4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F25C4AF09;
	Wed, 25 Jun 2025 08:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750839686;
	bh=7DHD/1kpF16rely2ZdhPgdqVtGCe6hUy6TmFIpiu3Zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c4qskF4oK+b6eiVtyYhD630yma7mdCBhaFly50kHvjm7t61HPlVIPhIj5jKcYpUxS
	 /4WduTMuHmHACA6rxVD/EHvILJ58oJCUH9Oe+LZua+lzKszt4yOaclvV3UPFDs4zB8
	 jzc987240W2mLNtl05HdLVQ7kuWTdRTe0E2YYHAKiceaq94mnPq7lIRqay0k7mwjHD
	 WDbJOo2wX+pQIC8glR/xCNGRMpSROfJHJJQ72GQE2lAf/3EgQIy3GbG1tD+lag44Bh
	 fF7As9jI4yJchSKx47tx4F87QD2/wEu10Z/yylBLxsxn5u+XWwjpziOHlcPBL7P9DI
	 xKlqqVFXsR5pg==
Date: Wed, 25 Jun 2025 17:21:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, David Laight
 <David.Laight@ACULAB.COM>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas@t-8ch.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 08/22] uprobes/x86: Add mapping for
 optimized uprobe trampolines
Message-Id: <20250625172122.ad1e955ae2bc3957d9fb8546@kernel.org>
In-Reply-To: <20250605132350.1488129-9-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
	<20250605132350.1488129-9-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Jun 2025 15:23:35 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding support to add special mapping for user space trampoline with
> following functions:
> 
>   uprobe_trampoline_get - find or add uprobe_trampoline
>   uprobe_trampoline_put - remove or destroy uprobe_trampoline
> 
> The user space trampoline is exported as arch specific user space special
> mapping through tramp_mapping, which is initialized in following changes
> with new uprobe syscall.
> 
> The uprobe trampoline needs to be callable/reachable from the probed address,
> so while searching for available address we use is_reachable_by_call function
> to decide if the uprobe trampoline is callable from the probe address.
> 
> All uprobe_trampoline objects are stored in uprobes_state object and are
> cleaned up when the process mm_struct goes down. Adding new arch hooks
> for that, because this change is x86_64 specific.
> 
> Locking is provided by callers in following changes.
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h   |   6 ++
>  kernel/events/uprobes.c   |  10 ++++
>  kernel/fork.c             |   1 +
>  4 files changed, 132 insertions(+)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 77050e5a4680..0295cfb625c0 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -608,6 +608,121 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  		*sr = utask->autask.saved_scratch_register;
>  	}
>  }
> +
> +static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
> +{
> +	return -EPERM;
> +}
> +
> +static struct page *tramp_mapping_pages[2] __ro_after_init;
> +
> +static struct vm_special_mapping tramp_mapping = {
> +	.name   = "[uprobes-trampoline]",
> +	.mremap = tramp_mremap,
> +	.pages  = tramp_mapping_pages,
> +};
> +
> +struct uprobe_trampoline {
> +	struct hlist_node	node;
> +	unsigned long		vaddr;
> +};
> +
> +static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
> +{
> +	long delta = (long)(vaddr + 5 - vtramp);
> +
> +	return delta >= INT_MIN && delta <= INT_MAX;
> +}
> +
> +static unsigned long find_nearest_page(unsigned long vaddr)

nit: this does not return the nearest one, but the highest one?

If you really need the nearest one, we need to call
vm_unmapped_area() twice.

[low_limit, call_end] with TOPDOWN flag and 
[call_end, high_limit] without TOPDOWN.

and choose the nearest one. But I don't think we need it.

> +{
> +	struct vm_unmapped_area_info info = {
> +		.length     = PAGE_SIZE,
> +		.align_mask = ~PAGE_MASK,
> +		.flags      = VM_UNMAPPED_AREA_TOPDOWN,
> +		.low_limit  = PAGE_SIZE,
> +		.high_limit = ULONG_MAX,

Maybe "TASK_SIZE" is better than ULONG_MAX?

> +	};
> +	unsigned long limit, call_end = vaddr + 5;
> +
> +	if (!check_add_overflow(call_end, INT_MIN, &limit))
> +		info.low_limit = limit;
> +	if (!check_add_overflow(call_end, INT_MAX, &limit))
> +		info.high_limit = limit;
> +	return vm_unmapped_area(&info);
> +}
> +
> +static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	struct mm_struct *mm = current->mm;
> +	struct uprobe_trampoline *tramp;
> +	struct vm_area_struct *vma;
> +
> +	if (!user_64bit_mode(regs))
> +		return NULL;
> +
> +	vaddr = find_nearest_page(vaddr);
> +	if (IS_ERR_VALUE(vaddr))
> +		return NULL;
> +
> +	tramp = kzalloc(sizeof(*tramp), GFP_KERNEL);
> +	if (unlikely(!tramp))
> +		return NULL;
> +
> +	tramp->vaddr = vaddr;
> +	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,

Just make sure, this special mapped page is mapped 1 page for each
uprobe? (I think uprobe syscall trampoline size is far smaller
than the page size.)

> +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> +				&tramp_mapping);
> +	if (IS_ERR(vma))
> +		goto free_area;

nit: To simplify the code, instead of goto,

if (IS_ERR(vma)) {
	kfree(tramp);
	return NULL;
}

> +	return tramp;
> +
> +free_area:
> +	kfree(tramp);
> +	return NULL;
> +}
> +
> +__maybe_unused
> +static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
> +{
> +	struct uprobes_state *state = &current->mm->uprobes_state;
> +	struct uprobe_trampoline *tramp = NULL;
> +
> +	hlist_for_each_entry(tramp, &state->head_tramps, node) {
> +		if (is_reachable_by_call(tramp->vaddr, vaddr))

This should set '*new = false;' here.

> +			return tramp;
> +	}
> +
> +	tramp = create_uprobe_trampoline(vaddr);
> +	if (!tramp)
> +		return NULL;
> +
> +	*new = true;
> +	hlist_add_head(&tramp->node, &state->head_tramps);
> +	return tramp;
> +}
> +
> +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> +{
> +	hlist_del(&tramp->node);
> +	kfree(tramp);

Don't we need to unmap the tramp->vaddr?

> +}
> +
> +void arch_uprobe_init_state(struct mm_struct *mm)
> +{
> +	INIT_HLIST_HEAD(&mm->uprobes_state.head_tramps);
> +}
> +
> +void arch_uprobe_clear_state(struct mm_struct *mm)
> +{
> +	struct uprobes_state *state = &mm->uprobes_state;
> +	struct uprobe_trampoline *tramp;
> +	struct hlist_node *n;
> +
> +	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
> +		destroy_uprobe_trampoline(tramp);
> +}
>  #else /* 32-bit: */
>  /*
>   * No RIP-relative addressing on 32-bit
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 5080619560d4..b40d33aae016 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -17,6 +17,7 @@
>  #include <linux/wait.h>
>  #include <linux/timer.h>
>  #include <linux/seqlock.h>
> +#include <linux/mutex.h>
>  
>  struct uprobe;
>  struct vm_area_struct;
> @@ -185,6 +186,9 @@ struct xol_area;
>  
>  struct uprobes_state {
>  	struct xol_area		*xol_area;
> +#ifdef CONFIG_X86_64

Maybe we can introduce struct arch_uprobe_state{} here?

> +	struct hlist_head	head_tramps;
> +#endif
>  };
>  
>  typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
> @@ -233,6 +237,8 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
>  extern void *arch_uretprobe_trampoline(unsigned long *psize);
>  extern unsigned long uprobe_get_trampoline_vaddr(void);
>  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
> +extern void arch_uprobe_clear_state(struct mm_struct *mm);
> +extern void arch_uprobe_init_state(struct mm_struct *mm);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 6795b8d82b9c..acec91a676b7 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1802,6 +1802,14 @@ static struct xol_area *get_xol_area(void)
>  	return area;
>  }
>  
> +void __weak arch_uprobe_clear_state(struct mm_struct *mm)
> +{
> +}
> +
> +void __weak arch_uprobe_init_state(struct mm_struct *mm)
> +{
> +}
> +
>  /*
>   * uprobe_clear_state - Free the area allocated for slots.
>   */
> @@ -1813,6 +1821,8 @@ void uprobe_clear_state(struct mm_struct *mm)
>  	delayed_uprobe_remove(NULL, mm);
>  	mutex_unlock(&delayed_uprobe_lock);
>  
> +	arch_uprobe_clear_state(mm);
> +
>  	if (!area)
>  		return;
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1ee8eb11f38b..7108ca558518 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1010,6 +1010,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_UPROBES
>  	mm->uprobes_state.xol_area = NULL;
> +	arch_uprobe_init_state(mm);
>  #endif

Can't we make this uprobe_init_state(mm)?

>  }
>  
> -- 
> 2.49.0
> 

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

