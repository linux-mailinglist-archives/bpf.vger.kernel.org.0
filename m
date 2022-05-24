Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F71533341
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 00:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiEXWIY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 18:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiEXWIX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 18:08:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92B819A6;
        Tue, 24 May 2022 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hld/OnviJb91e7dAYsfiEi4R7kN0ttZxY4N3wxFrQ5g=; b=PjO7kLobfDFMcseNB7bT4JL8uC
        bLx9RmLOCRAPv+Uwx+Ei9Xo1oVD2YbV0GzD8r+1hDsFEVpJ7JTgCuIC2W+8Bv7u/46e82QC2ymUWD
        kqxCxoWL6b0nezHI4R4SYHMRtOWayvEjc8RbiPTURjt0I7SoQQjdq2SynswO9TeJ0H1v8/WxtjU/g
        SgVJoxdibKDVyGaxabqSAXevIQSGMa949AsYyNBYPEhquzJs/NwB4QWPHen6fduryLFJYY9oaM+fP
        bJ7+wKxorTnctP0hX2XLlFyhvHn/MNpj5mFz2d5N1n9BvVVXwPQ0lxnEZXQzEFww3GEER8U+/p4ep
        S1FRNtfQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntchI-009IaA-61; Tue, 24 May 2022 22:08:12 +0000
Date:   Tue, 24 May 2022 15:08:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "hch@lst.de" <hch@lst.de>, "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Message-ID: <Yo1XTN441qbNTLGR@bombadil.infradead.org>
References: <20220520031548.338934-1-song@kernel.org>
 <20220520031548.338934-6-song@kernel.org>
 <Yog5yXqAQZAmpgCD@bombadil.infradead.org>
 <17c6110273d59e3fdeea3338abefac03951ff404.camel@intel.com>
 <YolGU5JGE9NVrrrc@bombadil.infradead.org>
 <a634037bb023973b8263a65b93fa73a7a5c0dc52.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a634037bb023973b8263a65b93fa73a7a5c0dc52.camel@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 24, 2022 at 05:40:53PM +0000, Edgecombe, Rick P wrote:
> On Sat, 2022-05-21 at 13:06 -0700, Luis Chamberlain wrote:
> > On Sat, May 21, 2022 at 03:20:28AM +0000, Edgecombe, Rick P wrote:
> > > On Fri, 2022-05-20 at 18:00 -0700, Luis Chamberlain wrote:
> > > > although VM_FLUSH_RESET_PERMS is rather new my concern here is
> > > > we're
> > > > essentially enabling sloppy users to grow without also addressing
> > > > what if we have to take the leash back to support
> > > > VM_FLUSH_RESET_PERMS
> > > > properly? If the hack to support this on other architectures
> > > > other
> > > > than
> > > > x86 is as simple as the one you in vm_remove_mappings() today:
> > > > 
> > > >         if (flush_reset &&
> > > > !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> > > >                 set_memory_nx(addr, area->nr_pages);
> > > >                 set_memory_rw(addr, area->nr_pages);
> > > >         }
> > > > 
> > > > then I suppose this isn't a big deal. I'm just concerned here
> > > > this
> > > > being
> > > > a slippery slope of sloppiness leading to something which we will
> > > > regret later.
> > > > 
> > > > My intution tells me this shouldn't be a big issue, but I just
> > > > want
> > > > to
> > > > confirm.
> > > 
> > > Yea, I commented the same concern on the last thread:
> > > 
> > > 
> https://lore.kernel.org/lkml/83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com/
> > > 
> > > Song said he plans to make kprobes and ftrace work with this new
> > > allocator. If that happens VM_FLUSH_RESET_PERMS would only have one
> > > user - modules. Care to chime in with your plans for modules?
> > 
> > My plans are to not break things and to slowly tidy things up. If
> > you see linux-next, things are at least starting to be split in
> > nice pieces. With time, clean that further so to not break things.
> > You were the one who added VM_FLUSH_RESET_PERMS, wasn't that to deal
> > with secmem stuff? So wouldn't you know better what you recommend for
> > it?
> 
> It was originally to correct some W^X issues. If a vmalloc was freed
> with X permission it caused some exposure.

Perhaps clarifying this on the docs would help as it was not clear
on patch review taking a time machine, but that's as a vm-outsider.

> The security side could be
> fixed with copious set_memory() calls in just the right order, but
> there was a suggestion to make vmalloc handle it so it could be done
> more efficiently and callers would not have to know the details for at
> least that part of the operation.

Makes sense also given there are more users than modules using
module_alloc() now.

> This prog pack stuff is already more
> efficient with respect to TLB flushes. So while VM_FLUSH_RESET_PERMS
> could still improve it slightly, the situation is now probably better
> than it was pre-VM_FLUSH_RESET_PERMS anyway. So that mostly leaves the
> problem of some special knowledge leaking back into the callers.

OK that I think is a good summary then of the impact of not having
this generalized.

> With a next solution it would hopefully be handled differently still,
> using the the unmapped page stuff Mike Rapoport was working on.

Thanks for the heads ups.

> > Seeing all this, given module_alloc() users are growing and seeing
> > the tiny bit of growth of use in this space, I'd think we should
> > rename module_alloc() to vmalloc_exec(), and likewise the same for
> > module_memfree() to vmalloc_exec_free(). But it would be our first
> > __weak vmalloc, and not sure if that's looked down upon.
> 
> A rename seems good to me. Module space is really just dynamically
> allocated text space now. There used to be a vmalloc_exec() that
> allocated text in vmalloc space, 

Yes I saw that but it was generic and it did not do the arch-specific
override, and so that is why Christoph ripped it out and open coded
it on the only user, on module_alloc().

> so maybe the name should have
> something to denote that it goes into the special arch specific text
> space.

On the arch space other precedents I see in vmalloc space are
vm_pgprot_modify() which calls to pgprot_modify which arch can
override. I think we'll have to just keep the __weak effort
behing module_alloc(), we can strive for that post v5.19.

> > > If there
> > > are actual near term plans to keep working on this,
> > > VM_FLUSH_RESET_PERMS might be changed again or turn into something
> > > else. Like if we are about to re-think everything, then it doesn't
> > > matter as much to fix what would then be old.
> > 
> > I think it's up to you as you added it and I'm not looking to add
> > any bells or wistles, just tidy things up *slowly*.
> > 
> > > Besides not fixing VM_FLUSH_RESET_PERMS/hibernate though, I think
> > > this
> > > allocator still feels a little rough. For example I don't think we
> > > actually know how much the huge mappings are helping.
> > 
> > Right, 100% agreed. The performance numbers provided are nice but
> > they are not anything folks can reproduce at all. I hinted towards
> > perf stuff which could be used and enable other users later to also
> > use similar stats to showcase its value if they want to move to
> > huge pages.
> > 
> > It is a side note, and perhaps a stupid question, as I don't grok mm,
> > but I'm perplexed about the fact that if the value is seen so high
> > towards
> > huge pages for exec stuff in kernel, wouldn't there be a few folks
> > who
> > might want to try this for regular exec stuff? Wouldn't there be much
> > more gains there?
> 
> Core kernel text is already 2MB mapped, on x86 at least. It indeed
> helps performance. I'd like to see about 2MB module text.

Yeah that would make sense *if* the arch supports it. I went and read
your 2020 "[PATCH RFC 00/10] New permission vmalloc interface" and
I suspect some new work on modules will help with your goals.

There are some optimizations architectures will be able to do for
v5.19+ by selecting ARCH_WANTS_MODULES_DATA_IN_VMALLOC so that
module data uses vmalloc instead. This can be for two reasons:

1) On some architectures (like book3s/32) it is not possible to protect
against execution on a page basis. The exec stuff is mapped can be
mapped by different arch segment sizes (on book3s/32 that is 256M segments).
By default the module area is in an Exec segment while vmalloc area is in a
NoExec segment. Using vmalloc lets you muck with module data as noexec
on those architectures whereas before you could not.

2) By pushing more module data to vmalloc you also increase the probability
of module text to remain within a closer distance from kernel core text
and this reduces trampolines, this has been reported on arm first and
powerpc folks are following that lead.

So I suspect that using ARCH_WANTS_MODULES_DATA_IN_VMALLOC plays well
with your idea to separate at least the allocated space. The
optimizations seem to be for exec and to zap this as well and
hence your goal to use 2 MiB pages and fancy hacks for this.

Yes, generalizing this for all architectures will be hard, but I think
we can get enough arch folks to chime for a least a generic mechanism.

> I can only
> assume that it would help performance though. Some people wiser than me
> in performance stuff suggested it should be tested to actually know.

Folks speak of performance but I don't think we have generic baselines.
For kernel image text I suppose we can use boot times. For tracepoints /
ftrace and eBPF JIT and the rest I suppose we can use something like what
Dave suggested:

[0] https://lore.kernel.org/all/Yog+d+oR5TtPp2cs@bombadil.infradead.org/

But that still begs the question as to what to use to run perf with.

Perhaps we just need a generic kernel module_alloc() abuser selftest
which stresses the hell out of things with a few variability in ways
in which we want to do allocations (2 MiB pages, test different archs,
etc). I can work on that if folks think this can be useful as I don't
think we have anything generic at the moment.

> > > It is also
> > > allocating memory in a big chunk from a single node and reusing it,
> > > where before we were allocating based on numa node for each jit.
> > > Would
> > > some user's suffer from that? Maybe it's obvious to others, but I
> > > would
> > > have expected to see more discussion of MM things like that.
> > 
> > Curious, why was it moved to use a single node?
> 
> To allocate from the closest node you need to have per-node caches.
> When I tried to do something similar to this with the grouped page
> cache, having per-node caches was suggested should be required. I never
> benchmarked the difference though.

Sounds like tribal knowledge... 

> > > But I like general direction of caching and using text_poke() to
> > > write
> > > the jits a lot. However it works, it seems to make a big impact in
> > > at
> > > least some workloads.
> > > 
> > > So yea, seems sloppy, but probably (...I guess?) more good for
> > > users
> > > then sloppy for us.
> > 
> > The impact of sloppiness lies in possible odd bugs later and trying
> > to
> > decipher what was being done. So I do have concerns with the
> > immediate
> > tribal knowlege incurred by the current implementation.
> 
> I am also bothered by it. I'm glad to hear someone else cares. I can
> think about doing it more incrementally. The problem is you kind of
> need to know if you can integrate with all the module_alloc() users and
> get sane behavior on the backend, to tell if your new interface is
> actually any good.
> 
> This is pretty much how I think we can:
>  - remove all special knowledge from callers
>  - support all module_alloc() callers
>  - do things more efficiently on x86
>  - support all the arch specific extra capabilities that I know about
> 
> https://lore.kernel.org/lkml/20201120202426.18009-1-rick.p.edgecombe@intel.com/#r

Consider me interested, I'm not a fan of hacks and requing developers to
pick up on random tribal knowledge.

> It's why I shrug a little about writing caller code with special
> knowledge in it. It's not really possible to avoid it completely with
> the current interfaces IMO.

Yeah makes sense.

> > What is your
> > own roadmap for VM_FLUSH_RESET_PERMS? Sounds like a future possibly
> > maybe re-do?
> 
> If it were me, I would start back with that RFC and try to move the
> allocation side forward too. I haven't seen anything since, that makes
> me think it was the wrong direction.

Did you get enough arch folks involved?

> But I have employer tasks that
> take priority unfortunately. If anyone else wants to take a shot at it,
> I can help review. Otherwise, hopefully I can get back to it someday.

Sure, understood.

I can perhaps help on module_alloc() sefltest, and make module_alloc()
generic. Happy to review patches too.

  Luis
