Return-Path: <bpf+bounces-62997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6671B012AD
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 07:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72CE37B8C6C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E51C2324;
	Fri, 11 Jul 2025 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGC4meOS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D21190477;
	Fri, 11 Jul 2025 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211581; cv=none; b=BN3qrjvoEkn6rxdIonjsRzC3CRs4yRXTXtDPPrIhNizF54x7HRMMlCKafsskd5Mzuu0gp/7AWrtNz0rHQIDtH4qPqUhtJeiRBM1xpQV9T0wYmIJOrGrPKrB5XNqVREjES9415CtfkWUzUZifXxntkMCTmDNw9C9sLHfWVO7tiu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211581; c=relaxed/simple;
	bh=dppASgAanlsLZisx8bBsFuYj29uQNEX3zHa01KVeP3M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Dv4zFpRWeC0CsJw7LmoHqFKJEKXaID/0ApvMsfGGggHeX40AbzSQ5/7qticnwpoZWGarxFgKXWydqYnPPTR2Uo9weqEp2n94lMqcmhpBHt4H5W6BsAvATYAz8353YIG+KotlEQLPP6GMdcIUjWr5/1Xs2PURPycX1Q0SzpJ4oDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGC4meOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B048CC4CEED;
	Fri, 11 Jul 2025 05:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752211578;
	bh=dppASgAanlsLZisx8bBsFuYj29uQNEX3zHa01KVeP3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tGC4meOSfwwbY+Y6W1tA3PEHWqt2KNsPwCzm3fXT2q6NnL1PbDPXw3ljOYoaqome0
	 O965kDtenyVKNEsylTSoKhEry8Mn9YomFtjUcX1TjyUp4WNT0CsGq5okLbCyqwoJOe
	 0I7WbLNVS9XR/GP+suW/VwZszhPQEc+MDVShFbm0VxT9TTPuTUEgAhRdss08N7jWSm
	 uQHW0ZoWvZ0o2bXqA6JgQ8T/Qa4IHKrrYK5DZto3edHIvQ84YDOHHz2kZPohNBzdet
	 aUl40dYPSke24lmiKtWgasMLtvEQv3+CFS2xPWahQnObVQtUyGGLbkBF/IXqnnLf91
	 TCp3+x5FVc+Gw==
Date: Fri, 11 Jul 2025 14:26:15 +0900
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
Subject: Re: [PATCHv4 perf/core 08/22] uprobes/x86: Add mapping for
 optimized uprobe trampolines
Message-Id: <20250711142615.867e25926a4026f496b23e22@kernel.org>
In-Reply-To: <aG_DSXNFol_03h75@krava>
References: <20250708132333.2739553-1-jolsa@kernel.org>
	<20250708132333.2739553-9-jolsa@kernel.org>
	<20250710160233.8750ccd59b3b9d62e78491e5@kernel.org>
	<aG_DSXNFol_03h75@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 15:42:33 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Thu, Jul 10, 2025 at 04:02:33PM +0900, Masami Hiramatsu wrote:
> > Hi Jiri,
> > 
> > On Tue,  8 Jul 2025 15:23:17 +0200
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
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/x86/kernel/uprobes.c | 169 ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/uprobes.h   |   6 ++
> > >  kernel/events/uprobes.c   |  10 +++
> > >  kernel/fork.c             |   1 +
> > >  4 files changed, 186 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index 77050e5a4680..6336bb961907 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -608,6 +608,175 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
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
> > > +#define __4GB		 (1UL << 32)
> > > +#define MASK_4GB	~(__4GB - 1)
> > > +#define PAGE_COUNT(addr) ((addr & ~MASK_4GB) >> PAGE_SHIFT)
> > > +
> > > +static unsigned long find_nearest_trampoline(unsigned long vaddr)
> > > +{
> > > +	struct vm_unmapped_area_info info = {
> > > +		.length     = PAGE_SIZE,
> > > +		.align_mask = ~PAGE_MASK,
> > > +	};
> > > +	unsigned long limit, low_limit = PAGE_SIZE, high_limit = TASK_SIZE;
> > > +	unsigned long cross_4GB, low_4GB, high_4GB;
> > > +	unsigned long low_tramp, high_tramp;
> > > +	unsigned long call_end = vaddr + 5;
> > > +
> > > +	/*
> > > +	 * The idea is to create a trampoline every 4GB, so we need to find free
> > > +	 * page closest to the 4GB alignment. We find intersecting 4GB alignment
> > > +	 * address and search up and down to find the closest free page.
> > 
> > It is not guaranteed to be able to find unmapped 4GB aligned page.
> > I still think just finding the nearest area is better (simpler and
> > good enough.)
> > 
> > 	if (check_add_overflow(call_end, INT_MIN, &low_limit))
> > 		low_limit = PAGE_SIZE;
> > 
> > 	high_limit = call_end + INT_MAX;
> > 
> > 	/* Search up from intersecting 4GB alignment address. */
> > 	info.low_limit = call_end;
> > 	info.high_limit = min(high_limit, TASK_SIZE);
> > 	high_tramp = vm_unmapped_area(&info);
> > 
> > 	/* Search down from intersecting 4GB alignment address. */
> > 	info.low_limit = max(low_limit, PAGE_SIZE);
> > 	info.high_limit = call_end;
> > 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> > 	low_tramp = vm_unmapped_area(&info);
> > 
> > See below;
> > 
> > > +	 */
> > > +
> > > +	low_4GB = call_end & MASK_4GB;
> > > +	high_4GB = low_4GB + __4GB;
> > > +
> > > +	/* Restrict limits to be within (PAGE_SIZE,TASK_SIZE) boundaries. */
> > > +	if (!check_add_overflow(call_end, INT_MIN, &limit))
> > > +		low_limit = limit;
> > 
> > if not overflow, low_limit = limit = call_end - 2GB.
> > 
> > * if call_end := 2GB + 4095, limit can be 4095 < PAGE_SIZE. 
> >   at the same time, low_4G == 0.
> > 
> > Note that low_limit can be > low_4G or < low_4G.
> > 
> > > +	if (low_limit == PAGE_SIZE)
> > > +		low_4GB = low_limit;
> > 
> > If overflow, low_4GB = PAGE_SIZE too.
> > 
> > In summary, 
> > 
> > (a) 0 < call_end < 2GB: (overflow)
> >   low_limit := PAGE_SIZE
> >   low_4GB := PAGE_SIZE
> > 
> > (b) 2GB <= call_end < 2GB + PAGE_SIZE:
> >   low_limit := call_end - 2GB (>= 0, < PAGE_SIZE)
> >   low_4GB := 0 (= call_end & MASK_4GB)
> > 
> > (c) call_end == 2GB + PAGE_SIZE:
> >   low_limit := PAGE_SIZE
> >   low_4GB := PAGE_SIZE
> > 
> > (d) 2GB + PAGE_SIZE <= call_end < 4GB:
> >   low_limit := call_end - 2GB (> PAGE_SIZE)
> >   low_4GB := 0
> > 
> > (e) 4GB <= call_end:
> >   low_limit := call_end - 2GB (> 2GB)
> >   low_4GB := call_end & MASK_4GB (> 4GB)
> > 
> > Maybe (b) and (d) cases are unexpected?
> > 
> > 
> > > +
> > > +	high_limit = call_end + INT_MAX;
> > 
> > This should not overflow, OK.
> > 
> > > +	if (high_limit > TASK_SIZE)
> > > +		high_limit = high_4GB = TASK_SIZE;
> > > +
> > > +	/* Get 4GB alligned address that's within 2GB distance from call_end */
> > > +	if (low_limit <= low_4GB)
> > 
> > This means call_end is within the [low_4GB, low_4GB + 2GB).
> > Call this case as (A)
> > 
> > > +		cross_4GB = low_4GB;
> > > +	else
> > > +		cross_4GB = high_4GB;
> > 
> > And this case as (B).
> > 
> > > +
> > > +	/* Search up from intersecting 4GB alignment address. */
> > > +	info.low_limit = cross_4GB;
> > > +	info.high_limit = high_limit;
> > > +	high_tramp = vm_unmapped_area(&info);
> > 
> > This searches the unmapped pages from low_limit.
> > In (A) case, this starts from low_4GB to high_limit.
> > In (B) case, this starts from high_4GB to high_limit.
> > 
> > So basically you search the unmapped area around the 4GB
> > aligned address instead of the nearest area of the vaddr.
> > But it is not guarantee that can find unmapped area near
> > the 4GB aligned address.
> 
> ok, as you said the current code does the same logic but from 4GB
> aligned address, while you suggest nearest page from the caller
> 
> I can't think of any benefit one way or the other apart from that
> your change is less code, I ended up with code below


Yeah, below one is simple and easy to read.

Thank you!

> 
> thanks,
> jirka
> 
> 
> ---
> +static unsigned long find_nearest_trampoline(unsigned long vaddr)
> +{
> +	struct vm_unmapped_area_info info = {
> +		.length     = PAGE_SIZE,
> +		.align_mask = ~PAGE_MASK,
> +	};
> +	unsigned long low_limit, high_limit;
> +	unsigned long low_tramp, high_tramp;
> +	unsigned long call_end = vaddr + 5;
> +
> +	if (check_add_overflow(call_end, INT_MIN, &low_limit))
> +		low_limit = PAGE_SIZE;
> +
> +	high_limit = call_end + INT_MAX;
> +
> +	/* Search up from the caller address. */
> +	info.low_limit = call_end;
> +	info.high_limit = min(high_limit, TASK_SIZE);
> +	high_tramp = vm_unmapped_area(&info);
> +
> +	/* Search down from the caller address. */
> +	info.low_limit = max(low_limit, PAGE_SIZE);
> +	info.high_limit = call_end;
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
> +	/* Return address that's closest to the caller address. */
> +	if (call_end - low_tramp < high_tramp - call_end)
> +		return low_tramp;
> +	return high_tramp;
> +}


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

