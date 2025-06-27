Return-Path: <bpf+bounces-61734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A9AEAEA9
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 08:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAB23B5108
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 06:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4B1E5702;
	Fri, 27 Jun 2025 06:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq7hSBJu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F11DE4E5;
	Fri, 27 Jun 2025 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004110; cv=none; b=dXA7pDtVuYRGR9KAMPmr4Qv3316SFRC1BC4s9c7LfBVZCp6acHja2HHlUUw6S0lSoZ2PSzoOh6SkjGFCBrCFTmvogqqQyvo156EvSvGrpjUhaMXdRjz5AjHrlUAK4QxwSW28ZnlysbfjpoF+GWbLWg2/Hi8qnVyl5lUtk/LfgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004110; c=relaxed/simple;
	bh=Bf4EKyCOxrTmBZHf4SMzQxlv4rPMH4J5fO2ddlfe1eY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KvXy5MAGGfKcRkBmmGznwpHMTT3q20pps2Z214As5dOQfKOdtXdieqfMSZcG6V+4OdPmbJ6Qo4CcA7HsCIOnXbvZhca43qTx5CrM4eQvc3pltk3qjViDkJU48bJLWnWfvD9yheeoDvZvNFmGLY1QxMOS2avNVmEqLE3UDyejIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq7hSBJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F189C4CEE3;
	Fri, 27 Jun 2025 06:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751004109;
	bh=Bf4EKyCOxrTmBZHf4SMzQxlv4rPMH4J5fO2ddlfe1eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yq7hSBJuKnIpEB/D9A6nyJckifA2tGazI04iKXtH/T/sQPR/ofiGakBmGLvHeljz1
	 trPRMCKVPx4bzDGL+nT5bkHJJtZZJ2PKrYXmpKEUsBIf+qEN6zoo8xv+3lAa169Uce
	 Y6i/Th8PGXTjjJUUrhVO5wXzKMpPKqmr96TYm3+9zGZ4g53XUi6AfYctYAFFLVh5PB
	 Idg9LK3WEHDCj9ZLZ/JHBdYd2ohGQ9212TekVyX1Y+3kg5WjpRB/jxWd4yy2YYoHwm
	 cJd6uA6eNgeZPtagbaGAyRz7S/0Akq/b1CNborJR2z1pXh6Up2XeqAonhto5ziqyp8
	 CJZgPrwPzDQtg==
Date: Fri, 27 Jun 2025 15:01:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Alan Maguire
 <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 08/22] uprobes/x86: Add mapping for
 optimized uprobe trampolines
Message-Id: <20250627150145.15cdec0f4991a99f997a8168@kernel.org>
In-Reply-To: <aFwS2EENyOFh7IbY@krava>
References: <20250605132350.1488129-1-jolsa@kernel.org>
	<20250605132350.1488129-9-jolsa@kernel.org>
	<20250625172122.ad1e955ae2bc3957d9fb8546@kernel.org>
	<aFwS2EENyOFh7IbY@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 17:16:40 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Wed, Jun 25, 2025 at 05:21:22PM +0900, Masami Hiramatsu wrote:
> > On Thu,  5 Jun 2025 15:23:35 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > Adding support to add special mapping for user space trampoline with
> > > following functions:
> > > 
> > >   uprobe_trampoline_get - find or add uprobe_trampoline
> > >   uprobe_trampoline_put - remove or destroy uprobe_trampoline
> > > 
> > > The user space trampoline is exported as arch specific user space special
> > > mapping through tramp_mapping, which is initialized in following changes
> > > with new uprobe syscall.
> > > 
> > > The uprobe trampoline needs to be callable/reachable from the probed address,
> > > so while searching for available address we use is_reachable_by_call function
> > > to decide if the uprobe trampoline is callable from the probe address.
> > > 
> > > All uprobe_trampoline objects are stored in uprobes_state object and are
> > > cleaned up when the process mm_struct goes down. Adding new arch hooks
> > > for that, because this change is x86_64 specific.
> > > 
> > > Locking is provided by callers in following changes.
> > > 
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/uprobes.h   |   6 ++
> > >  kernel/events/uprobes.c   |  10 ++++
> > >  kernel/fork.c             |   1 +
> > >  4 files changed, 132 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index 77050e5a4680..0295cfb625c0 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -608,6 +608,121 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > >  		*sr = utask->autask.saved_scratch_register;
> > >  	}
> > >  }
> > > +
> > > +static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
> > > +{
> > > +	return -EPERM;
> > > +}
> > > +
> > > +static struct page *tramp_mapping_pages[2] __ro_after_init;
> > > +
> > > +static struct vm_special_mapping tramp_mapping = {
> > > +	.name   = "[uprobes-trampoline]",
> > > +	.mremap = tramp_mremap,
> > > +	.pages  = tramp_mapping_pages,
> > > +};
> > > +
> > > +struct uprobe_trampoline {
> > > +	struct hlist_node	node;
> > > +	unsigned long		vaddr;
> > > +};
> > > +
> > > +static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
> > > +{
> > > +	long delta = (long)(vaddr + 5 - vtramp);
> > > +
> > > +	return delta >= INT_MIN && delta <= INT_MAX;
> > > +}
> > > +
> > > +static unsigned long find_nearest_page(unsigned long vaddr)
> > 
> > nit: this does not return the nearest one, but the highest one?
> 
> ...
> 
> > 
> > If you really need the nearest one, we need to call
> > vm_unmapped_area() twice.
> > 
> > [low_limit, call_end] with TOPDOWN flag and 
> > [call_end, high_limit] without TOPDOWN.
> > 
> > and choose the nearest one. But I don't think we need it.
> 
> ugh you're right, let's rename it.. find_reachable_page ?

Hmm, I think it needs to be the nearest one if it is shared among
several uprobes in the region. Or, it will choose the farthest
address, which means it is easily out of range from the other
uprobes.

> 
> > 
> > > +{
> > > +	struct vm_unmapped_area_info info = {
> > > +		.length     = PAGE_SIZE,
> > > +		.align_mask = ~PAGE_MASK,
> > > +		.flags      = VM_UNMAPPED_AREA_TOPDOWN,
> > > +		.low_limit  = PAGE_SIZE,
> > > +		.high_limit = ULONG_MAX,
> > 
> > Maybe "TASK_SIZE" is better than ULONG_MAX?
> 
> ok
> 
> > 
> > > +	};
> > > +	unsigned long limit, call_end = vaddr + 5;
> > > +
> > > +	if (!check_add_overflow(call_end, INT_MIN, &limit))
> > > +		info.low_limit = limit;
> > > +	if (!check_add_overflow(call_end, INT_MAX, &limit))
> > > +		info.high_limit = limit;
> > > +	return vm_unmapped_area(&info);
> > > +}
> > > +
> > > +static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> > > +{
> > > +	struct pt_regs *regs = task_pt_regs(current);
> > > +	struct mm_struct *mm = current->mm;
> > > +	struct uprobe_trampoline *tramp;
> > > +	struct vm_area_struct *vma;
> > > +
> > > +	if (!user_64bit_mode(regs))
> > > +		return NULL;
> > > +
> > > +	vaddr = find_nearest_page(vaddr);
> > > +	if (IS_ERR_VALUE(vaddr))
> > > +		return NULL;
> > > +
> > > +	tramp = kzalloc(sizeof(*tramp), GFP_KERNEL);
> > > +	if (unlikely(!tramp))
> > > +		return NULL;
> > > +
> > > +	tramp->vaddr = vaddr;
> > > +	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
> > 
> > Just make sure, this special mapped page is mapped 1 page for each
> > uprobe? (I think uprobe syscall trampoline size is far smaller
> > than the page size.)
> 
> so the trampoline is created for first uprobe within 4GB region of
> the probed address and will be reused by other uprobes in that region

Ah, OK.

> 
> > 
> > > +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> > > +				&tramp_mapping);
> > > +	if (IS_ERR(vma))
> > > +		goto free_area;
> > 
> > nit: To simplify the code, instead of goto,
> > 
> > if (IS_ERR(vma)) {
> > 	kfree(tramp);
> > 	return NULL;
> > }
> 
> ok
> 
> > 
> > > +	return tramp;
> > > +
> > > +free_area:
> > > +	kfree(tramp);
> > > +	return NULL;
> > > +}
> > > +
> > > +__maybe_unused
> > > +static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
> > > +{
> > > +	struct uprobes_state *state = &current->mm->uprobes_state;
> > > +	struct uprobe_trampoline *tramp = NULL;
> > > +
> > > +	hlist_for_each_entry(tramp, &state->head_tramps, node) {
> > > +		if (is_reachable_by_call(tramp->vaddr, vaddr))
> > 
> > This should set '*new = false;' here.
> 
> right, will fix, thanks
> 
> > 
> > > +			return tramp;
> > > +	}
> > > +
> > > +	tramp = create_uprobe_trampoline(vaddr);
> > > +	if (!tramp)
> > > +		return NULL;
> > > +
> > > +	*new = true;
> > > +	hlist_add_head(&tramp->node, &state->head_tramps);
> > > +	return tramp;
> > > +}
> > > +
> > > +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> > > +{
> > > +	hlist_del(&tramp->node);
> > > +	kfree(tramp);
> > 
> > Don't we need to unmap the tramp->vaddr?
> 
> that's tricky because we have no way to make sure the application is
> no longer executing the trampoline, it's described in the changelog
> of following patch:
> 
>     uprobes/x86: Add support to optimize uprobes
> 
>     ...
> 
>     We do not unmap and release uprobe trampoline when it's no longer needed,
>     because there's no easy way to make sure none of the threads is still
>     inside the trampoline. But we do not waste memory, because there's just
>     single page for all the uprobe trampoline mappings.
> 

I think we should put this as a code comment.

>     We do waste frame on page mapping for every 4GB by keeping the uprobe
>     trampoline page mapped, but that seems ok.

Hmm, this is not right with the current find_nearest_page(), because
it always finds a page from the farthest +2GB range until it is full.
Thus, in the worst case, if we hits uprobes with the order of
uprobe0 -> 1 -> 2 which is put as below;

0x0abc0004  [uprobe2]
...
0x0abc2004  [uprobe1]
...
0x0abc4004  [uprobe0]

Then the trampoline pages can be allocated as below.

0x8abc0000  [uprobe_tramp2]
[gap]
0x8abc2000  [uprobe_tramp1]
[gap]
0x8abc4000  [uprobe_tramp0]

Using true "find_nearest_page()", this will be mitigated. But not
allocated for "every 4GB". So I think we should drop that part
from the comment :)


> 
>     ...
> 
> > 
> > > +}
> > > +
> > > +void arch_uprobe_init_state(struct mm_struct *mm)
> > > +{
> > > +	INIT_HLIST_HEAD(&mm->uprobes_state.head_tramps);
> > > +}
> > > +
> > > +void arch_uprobe_clear_state(struct mm_struct *mm)
> > > +{
> > > +	struct uprobes_state *state = &mm->uprobes_state;
> > > +	struct uprobe_trampoline *tramp;
> > > +	struct hlist_node *n;
> > > +
> > > +	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
> > > +		destroy_uprobe_trampoline(tramp);
> > > +}
> > >  #else /* 32-bit: */
> > >  /*
> > >   * No RIP-relative addressing on 32-bit
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index 5080619560d4..b40d33aae016 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/wait.h>
> > >  #include <linux/timer.h>
> > >  #include <linux/seqlock.h>
> > > +#include <linux/mutex.h>
> > >  
> > >  struct uprobe;
> > >  struct vm_area_struct;
> > > @@ -185,6 +186,9 @@ struct xol_area;
> > >  
> > >  struct uprobes_state {
> > >  	struct xol_area		*xol_area;
> > > +#ifdef CONFIG_X86_64
> > 
> > Maybe we can introduce struct arch_uprobe_state{} here?
> 
> ok, on top of that Andrii also asked for [1]:
>   - alloc 'struct uprobes_state' for mm_struct only when needed
> 
> this could be part of that follow up? I'd rather not complicate this
> patchset any further
> 
> [1] https://lore.kernel.org/bpf/CAEf4BzY2zKPM9JHgn_wa8yCr8q5KntE5w8g=AoT2MnrD2Dx6gA@mail.gmail.com/

Hmm, OK. But if you need to avoid #ifdef CONFIG_<arch>,
you can use include/asm-generic to override macros.

struct uprobes_state {
 struct xol_area *xol_area;
 uprobe_arch_specific_data
};


 --- include/asm-generic/uprobes.h

#define uprobe_arch_specific_data

 --- arch/x86/include/asm/uprobes.h

#undef uprobe_arch_specific_data
#define uprobe_arch_specific_data \
	struct hlist_head	head_tramps;


> 
> > 
> > > +	struct hlist_head	head_tramps;
> > > +#endif
> > >  };
> > >  
> > >  typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
> > > @@ -233,6 +237,8 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
> > >  extern void *arch_uretprobe_trampoline(unsigned long *psize);
> > >  extern unsigned long uprobe_get_trampoline_vaddr(void);
> > >  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
> > > +extern void arch_uprobe_clear_state(struct mm_struct *mm);
> > > +extern void arch_uprobe_init_state(struct mm_struct *mm);
> > >  #else /* !CONFIG_UPROBES */
> > >  struct uprobes_state {
> > >  };
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 6795b8d82b9c..acec91a676b7 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1802,6 +1802,14 @@ static struct xol_area *get_xol_area(void)
> > >  	return area;
> > >  }
> > >  
> > > +void __weak arch_uprobe_clear_state(struct mm_struct *mm)
> > > +{
> > > +}
> > > +
> > > +void __weak arch_uprobe_init_state(struct mm_struct *mm)
> > > +{
> > > +}
> > > +
> > >  /*
> > >   * uprobe_clear_state - Free the area allocated for slots.
> > >   */
> > > @@ -1813,6 +1821,8 @@ void uprobe_clear_state(struct mm_struct *mm)
> > >  	delayed_uprobe_remove(NULL, mm);
> > >  	mutex_unlock(&delayed_uprobe_lock);
> > >  
> > > +	arch_uprobe_clear_state(mm);
> > > +
> > >  	if (!area)
> > >  		return;
> > >  
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 1ee8eb11f38b..7108ca558518 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -1010,6 +1010,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
> > >  {
> > >  #ifdef CONFIG_UPROBES
> > >  	mm->uprobes_state.xol_area = NULL;
> > > +	arch_uprobe_init_state(mm);
> > >  #endif
> > 
> > Can't we make this uprobe_init_state(mm)?
> 
> hum, there are other mm_init_* functions around, I guess we should keep
> the same pattern?
> 
> unless you mean s/arch_uprobe_init_state/uprobe_init_state/ but that's
> arch code.. so probably not sure what you mean ;-)

Ah, I misunderstood. Yeah, this part is good to me.

Thank you!


> 
> thanks for review,
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

