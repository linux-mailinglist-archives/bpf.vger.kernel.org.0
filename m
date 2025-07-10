Return-Path: <bpf+bounces-62886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB2AFFA4D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 09:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442021899F13
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9D23A995;
	Thu, 10 Jul 2025 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWvZSWlP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B10FC1D;
	Thu, 10 Jul 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130960; cv=none; b=NHMROvAiOrcut/ThHwbfMo15C5jgc3mjzgSoVMlm0sZnlCo9/ZKBKScjOad2QH3VMJVoy3QC4Y1wV3Lp86CxbVVngMthnobGpm993zj/iblMrPThHmkzvZ+GTYv0RI0YQzvjVs6xXNdqY5A+kdMKlpY/rvFisAtoCQNdNAOEE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130960; c=relaxed/simple;
	bh=XEEw/5d20JmB9v3fV8nAuBLdSU5Aoiswla5uufaEz2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NcC13no69q0fk0qO1WRew2cAHPL2X2nkEbkXFKVrkMOKNP2HfK7/0JtqPSAoGanPu4Uc3pCm/+LZko7HIc9ttoMXgsFfEDUWD5wPhBMDHFM8AqVI3lPb9WUPjKkvTRww5Lxfvfag+Zq52bSafvowPuEbgx2xWAFPaL1pQBOE8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWvZSWlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582F9C4CEE3;
	Thu, 10 Jul 2025 07:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752130957;
	bh=XEEw/5d20JmB9v3fV8nAuBLdSU5Aoiswla5uufaEz2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWvZSWlPp2IXWARvhKj2JB/6gq9qSwWuvX0EBODbpvr2EEcVq/aoDLHBMYcOmxojC
	 gvyHDRVGF7SB6PeLx/DE+7joWmnxaUziVB/7Ky1izGQFBggMoCDkLw2hli6CLpTMIr
	 Q3uxCQ6Ur06XrriyWLtvvJmBMh4Ahl5zaAGrg3kUB6ngFlN05hnnemJaj5m4LOKezx
	 xh0n038wB/2ig2sncHFfm7/HmWIUR4BRCl9HUUpAGBA2Vh3zdiC1Mvt4M0lhOW9E1a
	 uL95czx7iZpT6MhUttlK418GnUHYR7N5g1CFN7SBN4dOt2vxONWdnJ1KgCIeeCxF32
	 +iwXdu+CEZJYw==
Date: Thu, 10 Jul 2025 16:02:33 +0900
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
Subject: Re: [PATCHv4 perf/core 08/22] uprobes/x86: Add mapping for
 optimized uprobe trampolines
Message-Id: <20250710160233.8750ccd59b3b9d62e78491e5@kernel.org>
In-Reply-To: <20250708132333.2739553-9-jolsa@kernel.org>
References: <20250708132333.2739553-1-jolsa@kernel.org>
	<20250708132333.2739553-9-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jiri,

On Tue,  8 Jul 2025 15:23:17 +0200
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
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 169 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h   |   6 ++
>  kernel/events/uprobes.c   |  10 +++
>  kernel/fork.c             |   1 +
>  4 files changed, 186 insertions(+)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 77050e5a4680..6336bb961907 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -608,6 +608,175 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
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
> +#define __4GB		 (1UL << 32)
> +#define MASK_4GB	~(__4GB - 1)
> +#define PAGE_COUNT(addr) ((addr & ~MASK_4GB) >> PAGE_SHIFT)
> +
> +static unsigned long find_nearest_trampoline(unsigned long vaddr)
> +{
> +	struct vm_unmapped_area_info info = {
> +		.length     = PAGE_SIZE,
> +		.align_mask = ~PAGE_MASK,
> +	};
> +	unsigned long limit, low_limit = PAGE_SIZE, high_limit = TASK_SIZE;
> +	unsigned long cross_4GB, low_4GB, high_4GB;
> +	unsigned long low_tramp, high_tramp;
> +	unsigned long call_end = vaddr + 5;
> +
> +	/*
> +	 * The idea is to create a trampoline every 4GB, so we need to find free
> +	 * page closest to the 4GB alignment. We find intersecting 4GB alignment
> +	 * address and search up and down to find the closest free page.

It is not guaranteed to be able to find unmapped 4GB aligned page.
I still think just finding the nearest area is better (simpler and
good enough.)

	if (check_add_overflow(call_end, INT_MIN, &low_limit))
		low_limit = PAGE_SIZE;

	high_limit = call_end + INT_MAX;

	/* Search up from intersecting 4GB alignment address. */
	info.low_limit = call_end;
	info.high_limit = min(high_limit, TASK_SIZE);
	high_tramp = vm_unmapped_area(&info);

	/* Search down from intersecting 4GB alignment address. */
	info.low_limit = max(low_limit, PAGE_SIZE);
	info.high_limit = call_end;
	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
	low_tramp = vm_unmapped_area(&info);

See below;

> +	 */
> +
> +	low_4GB = call_end & MASK_4GB;
> +	high_4GB = low_4GB + __4GB;
> +
> +	/* Restrict limits to be within (PAGE_SIZE,TASK_SIZE) boundaries. */
> +	if (!check_add_overflow(call_end, INT_MIN, &limit))
> +		low_limit = limit;

if not overflow, low_limit = limit = call_end - 2GB.

* if call_end := 2GB + 4095, limit can be 4095 < PAGE_SIZE. 
  at the same time, low_4G == 0.

Note that low_limit can be > low_4G or < low_4G.

> +	if (low_limit == PAGE_SIZE)
> +		low_4GB = low_limit;

If overflow, low_4GB = PAGE_SIZE too.

In summary, 

(a) 0 < call_end < 2GB: (overflow)
  low_limit := PAGE_SIZE
  low_4GB := PAGE_SIZE

(b) 2GB <= call_end < 2GB + PAGE_SIZE:
  low_limit := call_end - 2GB (>= 0, < PAGE_SIZE)
  low_4GB := 0 (= call_end & MASK_4GB)

(c) call_end == 2GB + PAGE_SIZE:
  low_limit := PAGE_SIZE
  low_4GB := PAGE_SIZE

(d) 2GB + PAGE_SIZE <= call_end < 4GB:
  low_limit := call_end - 2GB (> PAGE_SIZE)
  low_4GB := 0

(e) 4GB <= call_end:
  low_limit := call_end - 2GB (> 2GB)
  low_4GB := call_end & MASK_4GB (> 4GB)

Maybe (b) and (d) cases are unexpected?


> +
> +	high_limit = call_end + INT_MAX;

This should not overflow, OK.

> +	if (high_limit > TASK_SIZE)
> +		high_limit = high_4GB = TASK_SIZE;
> +
> +	/* Get 4GB alligned address that's within 2GB distance from call_end */
> +	if (low_limit <= low_4GB)

This means call_end is within the [low_4GB, low_4GB + 2GB).
Call this case as (A)

> +		cross_4GB = low_4GB;
> +	else
> +		cross_4GB = high_4GB;

And this case as (B).

> +
> +	/* Search up from intersecting 4GB alignment address. */
> +	info.low_limit = cross_4GB;
> +	info.high_limit = high_limit;
> +	high_tramp = vm_unmapped_area(&info);

This searches the unmapped pages from low_limit.
In (A) case, this starts from low_4GB to high_limit.
In (B) case, this starts from high_4GB to high_limit.

So basically you search the unmapped area around the 4GB
aligned address instead of the nearest area of the vaddr.
But it is not guarantee that can find unmapped area near
the 4GB aligned address.

Thank you,

> +
> +	/* Search down from intersecting 4GB alignment address. */
> +	info.low_limit = low_limit;
> +	info.high_limit = cross_4GB;
> +	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> +	low_tramp = vm_unmapped_area(&info);
> +
> +	if (IS_ERR_VALUE(high_tramp) && IS_ERR_VALUE(low_tramp))
> +		return -ENOMEM;
> +	if (IS_ERR_VALUE(high_tramp))
> +		return low_tramp;
> +	if (IS_ERR_VALUE(low_tramp))
> +		return high_tramp;
> +
> +	/* Return address that's closest to the 4GB alignment address. */
> +	if (cross_4GB - low_tramp < high_tramp - cross_4GB)
> +		return low_tramp;
> +	return high_tramp;
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
> +	vaddr = find_nearest_trampoline(vaddr);
> +	if (IS_ERR_VALUE(vaddr))
> +		return NULL;
> +
> +	tramp = kzalloc(sizeof(*tramp), GFP_KERNEL);
> +	if (unlikely(!tramp))
> +		return NULL;
> +
> +	tramp->vaddr = vaddr;
> +	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
> +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> +				&tramp_mapping);
> +	if (IS_ERR(vma)) {
> +		kfree(tramp);
> +		return NULL;
> +	}
> +	return tramp;
> +}
> +
> +__maybe_unused
> +static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
> +{
> +	struct uprobes_state *state = &current->mm->uprobes_state;
> +	struct uprobe_trampoline *tramp = NULL;
> +
> +	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
> +		return NULL;
> +
> +	hlist_for_each_entry(tramp, &state->head_tramps, node) {
> +		if (is_reachable_by_call(tramp->vaddr, vaddr)) {
> +			*new = false;
> +			return tramp;
> +		}
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
> +	/*
> +	 * We do not unmap and release uprobe trampoline page itself,
> +	 * because there's no easy way to make sure none of the threads
> +	 * is still inside the trampoline.
> +	 */
> +	hlist_del(&tramp->node);
> +	kfree(tramp);
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
> index bd8c21d64746..70f2d4e2e8fe 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1009,6 +1009,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_UPROBES
>  	mm->uprobes_state.xol_area = NULL;
> +	arch_uprobe_init_state(mm);
>  #endif
>  }
>  
> -- 
> 2.50.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

