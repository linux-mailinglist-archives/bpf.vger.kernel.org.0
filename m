Return-Path: <bpf+bounces-61536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F70AE87B5
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CE53A9AEF
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA225D54E;
	Wed, 25 Jun 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivU64cyW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24464C92;
	Wed, 25 Jun 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864606; cv=none; b=r9umEXQBOEzMIkzdxSsxnM5R/xmM5SWbE8BVm4wnaDEpnv8+S4FAcByjPhh7ig1AfW/i3LTxePt7m5Z+gPgwmILTYAoLgCikWWGNqmUCg5pmxW3//ZK+guJDYlGfeh8gJfGnVJOuhPG2mqC4lqwJRamfdZlD/GPk5jk6LbTxVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864606; c=relaxed/simple;
	bh=5gzcU5lYVyaDltG2aptsCIuIuEFSrzU7kQ1MaPmQcyU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgKNDUWj251VujVgK6FuBvrJSVt2SRVr22pf3Po+Gw2HeC6cBbZDnGTk/i2tchrmL6J8Tr2Fn0FkL8KMnifhbnEMCthbrgiZe5D+eAhUdzn0qRmDByUl7Zp0HWDDgSGSih6eOXRw7jfK2qlHyEWkaW/lZ/ZTlSkoS9Smkm9szHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivU64cyW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso3433571a12.1;
        Wed, 25 Jun 2025 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750864603; x=1751469403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1Vd7rjX99Xeecq3johLhJAXQYPhI5NMHiZ59CBcF44=;
        b=ivU64cyW+u+zRr0RwOzOzfb2OD43qtGp/Yu5AbRhGSVmE2JphtJ7wahFDqKc7p2Vve
         eTAGQeNSURPsdLZIBM42BW9Hdxi4Scjrv8PBDH725l/+D0qrrl5tGBeEXJXCEVpdhB6z
         yPJNrlm8yjNPWMg1k67ozvHvxQj9qBGTDNjzHGuj3FXxM9VRgsZXwQ6Rddtst+973i9p
         i0Fo4Scdgiq3qHaNhiq95MJdOompfs3FomOrrXsOHwcTIT7ALNtEJX2K7YMgrRK3fFod
         7NUaN66+MRP0GZrz7KusbW/6NPI6/3IEHB5BAny8ke/UQQNBzBQVTy0S5CRKv4z6+b15
         H8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864603; x=1751469403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1Vd7rjX99Xeecq3johLhJAXQYPhI5NMHiZ59CBcF44=;
        b=qwFnhMDntqy36oITwNs6kRIbP4MPpPCGCKkcN9OSGhTmIYutwzaW9U4yiNxX7olK2p
         npbDyoksFI3ek1CC6qpo4McdqyUReW5+bORlbzPrB30niEJhdtLVLdqItQsIAWKzPc2N
         SknfGGlGXcIQ3660OM2NGlKnyTXYG5tEdgNvVovJc/z/qRX+JTcn8E6nYvuqwgSWw0f0
         CaqOFx05egWXcMDRiVnd5puBZTvpHiSs9LSBOtFv+hq9ghG+7EaMs4f0GF9tOWhGcaVQ
         T9Q4mWT7z1R7JBRsuvuodkczEiYNdB1ZSBfsSgiufH1LVs5TX6WRWauZXdO/unMqK6nQ
         N+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Nm2a6TF8DbqIJrsAuO83jW5fcp0xeWaUe313Ki5iu/VJc1raaVgvwyQ839EuhamvqPA=@vger.kernel.org, AJvYcCUjbBl3e72V6MzViKT8bBEg/eC0T2Qf5gnosFFqZJc7sGR7XcXUzRLEASuIVLPYAVE5GGM40HWXXT/yZuamgodypw03@vger.kernel.org, AJvYcCXQMuTf7rRTfis/6M1OqZXNFTDqb3dU3+Qltcce7Ik2o/65zBEHGWMPNBmWl9MbtXo6gotp+DiWtNUcuJeW@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5DzpCcIY+cVL5WYAb/wwO2jx7JGZBmqOS4iwsdaA1I/jtzLQ
	iYQEdkcduSBPfVjsrfs0uIO1HYJ/V1+WcCt9WPwECLXc9cTyPQZfm3oP
X-Gm-Gg: ASbGnctaNX93Ob63iBpwD4mBdrh2yE0GZmmR41JbvJHzHIbJdQgS0nVJmCWNONEAJYJ
	I/Pe4NYihFE4TPp64hKJ/6VrLaD2L02AjnIk3jvj1i276+1qk9Wddg45Zg3ThPm3nnnDbhRu/L5
	uOh1LG2aPjvsUrmx0T8fXC3RCqx/TFt6eeXSGuR1iBm/TvuEVIgxP9In6Khiz1YYB02blSLvlGF
	BcN8thodnG9M+tP79XMe2IW3qF2JvxC/IWnvW+d361QdO3NXnaCMPBlpIijUVo0v3TnZKVL+yN1
	piu+K1YLOrImrFV9lHsposhwn+35OUxDpM+skq7cBiEF0g35mw==
X-Google-Smtp-Source: AGHT+IGUKxVhzxYCbIyoITknvzZShVkYdCi+GTibaqaGfhvNfAbQjUzsgBS38MqE6qM6Hm5NGQhQ6Q==
X-Received: by 2002:a17:906:7956:b0:ae0:b239:7fcc with SMTP id a640c23a62f3a-ae0bea8113amr381247066b.58.1750864602548;
        Wed, 25 Jun 2025 08:16:42 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054083406sm1066721466b.75.2025.06.25.08.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:16:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Jun 2025 17:16:40 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aFwS2EENyOFh7IbY@krava>
References: <20250605132350.1488129-1-jolsa@kernel.org>
 <20250605132350.1488129-9-jolsa@kernel.org>
 <20250625172122.ad1e955ae2bc3957d9fb8546@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625172122.ad1e955ae2bc3957d9fb8546@kernel.org>

On Wed, Jun 25, 2025 at 05:21:22PM +0900, Masami Hiramatsu wrote:
> On Thu,  5 Jun 2025 15:23:35 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding support to add special mapping for user space trampoline with
> > following functions:
> > 
> >   uprobe_trampoline_get - find or add uprobe_trampoline
> >   uprobe_trampoline_put - remove or destroy uprobe_trampoline
> > 
> > The user space trampoline is exported as arch specific user space special
> > mapping through tramp_mapping, which is initialized in following changes
> > with new uprobe syscall.
> > 
> > The uprobe trampoline needs to be callable/reachable from the probed address,
> > so while searching for available address we use is_reachable_by_call function
> > to decide if the uprobe trampoline is callable from the probe address.
> > 
> > All uprobe_trampoline objects are stored in uprobes_state object and are
> > cleaned up when the process mm_struct goes down. Adding new arch hooks
> > for that, because this change is x86_64 specific.
> > 
> > Locking is provided by callers in following changes.
> > 
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/uprobes.h   |   6 ++
> >  kernel/events/uprobes.c   |  10 ++++
> >  kernel/fork.c             |   1 +
> >  4 files changed, 132 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 77050e5a4680..0295cfb625c0 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -608,6 +608,121 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  		*sr = utask->autask.saved_scratch_register;
> >  	}
> >  }
> > +
> > +static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
> > +{
> > +	return -EPERM;
> > +}
> > +
> > +static struct page *tramp_mapping_pages[2] __ro_after_init;
> > +
> > +static struct vm_special_mapping tramp_mapping = {
> > +	.name   = "[uprobes-trampoline]",
> > +	.mremap = tramp_mremap,
> > +	.pages  = tramp_mapping_pages,
> > +};
> > +
> > +struct uprobe_trampoline {
> > +	struct hlist_node	node;
> > +	unsigned long		vaddr;
> > +};
> > +
> > +static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
> > +{
> > +	long delta = (long)(vaddr + 5 - vtramp);
> > +
> > +	return delta >= INT_MIN && delta <= INT_MAX;
> > +}
> > +
> > +static unsigned long find_nearest_page(unsigned long vaddr)
> 
> nit: this does not return the nearest one, but the highest one?

...

> 
> If you really need the nearest one, we need to call
> vm_unmapped_area() twice.
> 
> [low_limit, call_end] with TOPDOWN flag and 
> [call_end, high_limit] without TOPDOWN.
> 
> and choose the nearest one. But I don't think we need it.

ugh you're right, let's rename it.. find_reachable_page ?

> 
> > +{
> > +	struct vm_unmapped_area_info info = {
> > +		.length     = PAGE_SIZE,
> > +		.align_mask = ~PAGE_MASK,
> > +		.flags      = VM_UNMAPPED_AREA_TOPDOWN,
> > +		.low_limit  = PAGE_SIZE,
> > +		.high_limit = ULONG_MAX,
> 
> Maybe "TASK_SIZE" is better than ULONG_MAX?

ok

> 
> > +	};
> > +	unsigned long limit, call_end = vaddr + 5;
> > +
> > +	if (!check_add_overflow(call_end, INT_MIN, &limit))
> > +		info.low_limit = limit;
> > +	if (!check_add_overflow(call_end, INT_MAX, &limit))
> > +		info.high_limit = limit;
> > +	return vm_unmapped_area(&info);
> > +}
> > +
> > +static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +	struct mm_struct *mm = current->mm;
> > +	struct uprobe_trampoline *tramp;
> > +	struct vm_area_struct *vma;
> > +
> > +	if (!user_64bit_mode(regs))
> > +		return NULL;
> > +
> > +	vaddr = find_nearest_page(vaddr);
> > +	if (IS_ERR_VALUE(vaddr))
> > +		return NULL;
> > +
> > +	tramp = kzalloc(sizeof(*tramp), GFP_KERNEL);
> > +	if (unlikely(!tramp))
> > +		return NULL;
> > +
> > +	tramp->vaddr = vaddr;
> > +	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
> 
> Just make sure, this special mapped page is mapped 1 page for each
> uprobe? (I think uprobe syscall trampoline size is far smaller
> than the page size.)

so the trampoline is created for first uprobe within 4GB region of
the probed address and will be reused by other uprobes in that region

> 
> > +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> > +				&tramp_mapping);
> > +	if (IS_ERR(vma))
> > +		goto free_area;
> 
> nit: To simplify the code, instead of goto,
> 
> if (IS_ERR(vma)) {
> 	kfree(tramp);
> 	return NULL;
> }

ok

> 
> > +	return tramp;
> > +
> > +free_area:
> > +	kfree(tramp);
> > +	return NULL;
> > +}
> > +
> > +__maybe_unused
> > +static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
> > +{
> > +	struct uprobes_state *state = &current->mm->uprobes_state;
> > +	struct uprobe_trampoline *tramp = NULL;
> > +
> > +	hlist_for_each_entry(tramp, &state->head_tramps, node) {
> > +		if (is_reachable_by_call(tramp->vaddr, vaddr))
> 
> This should set '*new = false;' here.

right, will fix, thanks

> 
> > +			return tramp;
> > +	}
> > +
> > +	tramp = create_uprobe_trampoline(vaddr);
> > +	if (!tramp)
> > +		return NULL;
> > +
> > +	*new = true;
> > +	hlist_add_head(&tramp->node, &state->head_tramps);
> > +	return tramp;
> > +}
> > +
> > +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> > +{
> > +	hlist_del(&tramp->node);
> > +	kfree(tramp);
> 
> Don't we need to unmap the tramp->vaddr?

that's tricky because we have no way to make sure the application is
no longer executing the trampoline, it's described in the changelog
of following patch:

    uprobes/x86: Add support to optimize uprobes

    ...

    We do not unmap and release uprobe trampoline when it's no longer needed,
    because there's no easy way to make sure none of the threads is still
    inside the trampoline. But we do not waste memory, because there's just
    single page for all the uprobe trampoline mappings.

    We do waste frame on page mapping for every 4GB by keeping the uprobe
    trampoline page mapped, but that seems ok.

    ...

> 
> > +}
> > +
> > +void arch_uprobe_init_state(struct mm_struct *mm)
> > +{
> > +	INIT_HLIST_HEAD(&mm->uprobes_state.head_tramps);
> > +}
> > +
> > +void arch_uprobe_clear_state(struct mm_struct *mm)
> > +{
> > +	struct uprobes_state *state = &mm->uprobes_state;
> > +	struct uprobe_trampoline *tramp;
> > +	struct hlist_node *n;
> > +
> > +	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
> > +		destroy_uprobe_trampoline(tramp);
> > +}
> >  #else /* 32-bit: */
> >  /*
> >   * No RIP-relative addressing on 32-bit
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 5080619560d4..b40d33aae016 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/wait.h>
> >  #include <linux/timer.h>
> >  #include <linux/seqlock.h>
> > +#include <linux/mutex.h>
> >  
> >  struct uprobe;
> >  struct vm_area_struct;
> > @@ -185,6 +186,9 @@ struct xol_area;
> >  
> >  struct uprobes_state {
> >  	struct xol_area		*xol_area;
> > +#ifdef CONFIG_X86_64
> 
> Maybe we can introduce struct arch_uprobe_state{} here?

ok, on top of that Andrii also asked for [1]:
  - alloc 'struct uprobes_state' for mm_struct only when needed

this could be part of that follow up? I'd rather not complicate this
patchset any further

[1] https://lore.kernel.org/bpf/CAEf4BzY2zKPM9JHgn_wa8yCr8q5KntE5w8g=AoT2MnrD2Dx6gA@mail.gmail.com/

> 
> > +	struct hlist_head	head_tramps;
> > +#endif
> >  };
> >  
> >  typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
> > @@ -233,6 +237,8 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
> >  extern void *arch_uretprobe_trampoline(unsigned long *psize);
> >  extern unsigned long uprobe_get_trampoline_vaddr(void);
> >  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
> > +extern void arch_uprobe_clear_state(struct mm_struct *mm);
> > +extern void arch_uprobe_init_state(struct mm_struct *mm);
> >  #else /* !CONFIG_UPROBES */
> >  struct uprobes_state {
> >  };
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 6795b8d82b9c..acec91a676b7 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1802,6 +1802,14 @@ static struct xol_area *get_xol_area(void)
> >  	return area;
> >  }
> >  
> > +void __weak arch_uprobe_clear_state(struct mm_struct *mm)
> > +{
> > +}
> > +
> > +void __weak arch_uprobe_init_state(struct mm_struct *mm)
> > +{
> > +}
> > +
> >  /*
> >   * uprobe_clear_state - Free the area allocated for slots.
> >   */
> > @@ -1813,6 +1821,8 @@ void uprobe_clear_state(struct mm_struct *mm)
> >  	delayed_uprobe_remove(NULL, mm);
> >  	mutex_unlock(&delayed_uprobe_lock);
> >  
> > +	arch_uprobe_clear_state(mm);
> > +
> >  	if (!area)
> >  		return;
> >  
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 1ee8eb11f38b..7108ca558518 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1010,6 +1010,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
> >  {
> >  #ifdef CONFIG_UPROBES
> >  	mm->uprobes_state.xol_area = NULL;
> > +	arch_uprobe_init_state(mm);
> >  #endif
> 
> Can't we make this uprobe_init_state(mm)?

hum, there are other mm_init_* functions around, I guess we should keep
the same pattern?

unless you mean s/arch_uprobe_init_state/uprobe_init_state/ but that's
arch code.. so probably not sure what you mean ;-)

thanks for review,
jirka

