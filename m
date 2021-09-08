Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265104041D3
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 01:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhIHXen (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 19:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhIHXem (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 19:34:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24535C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 16:33:34 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b64so4566592qkg.0
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MrFx8f2Sbic52YCjTt/XxUCD8D0mz2UtAejCbMntRqM=;
        b=Y7otoefmsPF3VMf0m5rBzollI1ZgyX0Tgmchly0g12QfYjznjH4lzQQe11mcXXqYvJ
         +WssRuUBIHSFxPzQpMZJCht2WaU1h2VWq7yIuXtjkHDlDgQ+c7iI6eYzJAq7HuUKHgIg
         fjCFIPZvkiDP6zU8HLt40739TRlDYSKRzL/478UEmcplbdmDUiRGjwvdcpIdBh6D9N2r
         5GhxU5yPUxVCAM54aNCh7hGOLS8a+wreviKplPqFKwVxoj/Pv5cDyDhtH7yoAO3v/ueh
         SKEjt31f79K1SXgL+0hFrhpqE7GudawpI1u0Rn6fga+z9GifcS8uLqvAjCbok2ZNYU8A
         d9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MrFx8f2Sbic52YCjTt/XxUCD8D0mz2UtAejCbMntRqM=;
        b=1CTyXKbqVMLeNmXt+t2nh1Qd7ySKyQK9a99ZQ4CS6AllyZAsf3qYhrRIbGI7bjnGMk
         bllM4boZuWPOjrNTaT+AyhbntljkrwTf8IASPW2HhWH/BjR8WJXAnbi+naIG8Nmoqeyi
         3PipSbBH9PjAFdV3fzPXqFTYmSxhco8YdgNtZ6eU77TqhKOcdp52q1En3BeTttb8JUpl
         bo61ac2qQghQB4QVdxK9yvhColgFttYrnQG4ub/6nvlThU3JpoPd7DnRa4xfa3uVWBDA
         TpIeFMbFPfLu9echi1mH8uVG+KFI9R2QVisBY1q3KAZ5/tZ3euQiY/31qT7ogUAS++Cw
         fQBA==
X-Gm-Message-State: AOAM533DZmsL/pgq6hydaUudzsVyW0IR6uyKpNjdvDiiGz6vobjy0R9Q
        GkjC3KEJEQk8T/IKlXaL0KR61A==
X-Google-Smtp-Source: ABdhPJxQQSxNdwoc1gf8pPeDJefusJYSa7mYD4j+G6VAAQpFQNRMbsDasczgOrbWfUIEJPcBee/tgA==
X-Received: by 2002:a05:620a:4514:: with SMTP id t20mr176750qkp.114.1631144012886;
        Wed, 08 Sep 2021 16:33:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id k186sm101073qkd.47.2021.09.08.16.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 16:33:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mO74N-00EsAz-LZ; Wed, 08 Sep 2021 20:33:31 -0300
Date:   Wed, 8 Sep 2021 20:33:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yonghong Song <yhs@fb.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "walken@fb.com" <walken@fb.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Message-ID: <20210908233331.GA3544071@ziepe.ca>
References: <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
 <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
 <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
 <20210908183032.zoh6dj5xh455z47f@revolver>
 <20210908184912.GA1200268@ziepe.ca>
 <7aece51f-141c-db55-5d4c-8c6658b6a1fc@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aece51f-141c-db55-5d4c-8c6658b6a1fc@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 12:11:54PM -0700, Yonghong Song wrote:
> 
> 
> On 9/8/21 11:49 AM, Jason Gunthorpe wrote:
> > On Wed, Sep 08, 2021 at 06:30:52PM +0000, Liam Howlett wrote:
> > 
> > >   /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> > > -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> > > +struct vm_area_struct *find_vma_non_owner(struct mm_struct *mm,
> > > +					 unsigned long addr)
> > >   {
> > >   	struct rb_node *rb_node;
> > >   	struct vm_area_struct *vma;
> > > -	mmap_assert_locked(mm);
> > > +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > >   	/* Check the cache first. */
> > >   	vma = vmacache_find(mm, addr);
> > >   	if (likely(vma))
> > > @@ -2325,6 +2326,11 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> > >   	return vma;
> > >   }
> > > +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> > > +{
> > > +	lockdep_assert_held(&mm->mmap_lock);
> > > +	return find_vma_non_owner(mm, addr);
> > > +}
> > >   EXPORT_SYMBOL(find_vma);
> > >   /*
> > > 
> > > 
> > > Although this leaks more into the mm API and was referred to as ugly
> > > previously, it does provide a working solution and still maintains the
> > > same level of checking.
> > 
> > I think it is no better than before.
> > 
> > The solution must be to not break lockdep in the BPF side. If Peter's
> > reworked algorithm is not OK then BPF should drop/acquire the lockdep
> > when it punts the unlock to the WQ.
> 
> The current warning is triggered by bpf calling find_vma().

Yes, but that is because the lockdep has already been dropped.

It looks to me like it basically does this:

        mmap_read_trylock_non_owner(current->mm)

        vma = find_vma(current->mm, ips[i]);

        if (!work) {
                mmap_read_unlock_non_owner(current->mm);
        } else {
                work->mm = current->mm;
                irq_work_queue(&work->irq_work);


And the only reason for this lockdep madness is because the
irq_work_queue() does:

static void do_up_read(struct irq_work *entry)
{
        struct stack_map_irq_work *work;

        if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
                return;

        work = container_of(entry, struct stack_map_irq_work, irq_work);
        mmap_read_unlock_non_owner(work->mm);
}


This is all about deferring the unlock to outside an IRQ context. The
lockdep ownership is transfered from the IRQ to the work, which is
something that we don't usually do or model in lockdep.

Lockdep complains with the straightforward code because exiting an IRQ
with locks held is illegal.

The saner version is more like:

        mmap_read_trylock(current->mm)

        vma = find_vma(current->mm, ips[i]);

        if (!work) {
                mmap_read_unlock(current->mm);
        } else {
                work->mm = current->mm;
                <tell lockdep we really do mean to return with
		 the lock held>
                rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
                irq_work_queue(&work->irq_work);


do_up_read():
       <tell lockdep the lock was already released from the map>
       mmap_read_unlock_non_owner(work->mm);

ie properly model in lockdep that ownership moves from the IRQ to the
work. At least we don't corrupt the core mm code with this insanity.

Jason
