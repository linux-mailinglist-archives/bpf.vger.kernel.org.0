Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0A5AC7FD
	for <lists+bpf@lfdr.de>; Mon,  5 Sep 2022 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiIDW2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIDW2x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 18:28:53 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD49B26102
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 15:28:51 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e7so3902011ilc.5
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vj1q72hG7Iva1BSpn5tP0V4PD+jcDBnUTceRDPVw8p8=;
        b=SSdV+1sh0HX6pwbcIpW5thQzzrD3oPFx9b0Eix2+Wf2wJfHZNonAKekV6HSkmyNu3m
         8OqRJsYijUcL97iofbjGEgIG82Zj1MHXTh4PZa5S/r3RlynMgKRrhcbVk13BWanevvKQ
         hGtC+auMqEZ9RbNmk7FjBhSmwpCCEup7ZSKlyxJwPaqEqSn+gAYikMvPxekrY9+2KEj6
         0CaPpogLhPjBKMhHQa2ynMCmt72dbAL8JJj9WaSHzPLtZiIhmVk9o7gur5++/HnuQdhW
         a9iVEMZSdITq6118OHWOBq4Ut7X0I8zwwnPmuQOohhUH5QUThOy7zgzb9aZ8bOUX5bIm
         jZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vj1q72hG7Iva1BSpn5tP0V4PD+jcDBnUTceRDPVw8p8=;
        b=xJ45nDD6X01PVoqd4y3TpeKDu3rPTKVyHJ2L+XrO2bKI4KNalodhexPny+f37x1A+m
         pduCSe45pKWH4rRpQpybd4CALH0a8PoDPB7bMSfxqfOXI927iqCJmgF8QCHLimHWp6dV
         bdzciu0EmC+k757QekwoyzORXGyuViNhrFV80ye32m0uczt4smuRn+2e9BlgdEoKTneF
         HdCvW6BpofjvVLQi6++/moIQVoXag7Y8qsVNLGFlxAU08b1+dewfZ+j26Kxv7tok+vM9
         yIgZwtEvUivUVRagui1PITopTZe2bF1JrJ1yjBD1st6eU7eWc85pLnfseg542yyDTAvG
         RevA==
X-Gm-Message-State: ACgBeo0qmhLH+f/2fPCFIP5CVHQLXh/GwEhfFkYJRyeIOHJsaUlyEDwW
        z+mo+GLqWaOT1h7acZqtqQci1pS5FSsqDXm06TE=
X-Google-Smtp-Source: AA6agR49SSScztTM2xcBZ4exL84wjY/j72vRtwyGG+MBjGGIXEIjUp+zgb9P5OgtRk2Tw/bsNmN1oWOCWLmgvsiXj/U=
X-Received: by 2002:a05:6e02:170f:b0:2f1:6cdf:6f32 with SMTP id
 u15-20020a056e02170f00b002f16cdf6f32mr1264846ill.216.1662330530894; Sun, 04
 Sep 2022 15:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com> <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com> <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
 <e37a3f11074245b04b086f3d9877ca08f0fef7dd.camel@fb.com> <CAADnVQJOh4qW=yrK5PsC9EH=gG8jmrQrF+e=1W1BJZ9jJQi3jA@mail.gmail.com>
 <11121127244abee0df337777367a6928d95faece.camel@fb.com> <20220902001211.wrgwpvquuky5wpgn@macbook-pro-4.dhcp.thefacebook.com>
 <667008debe17cf6ced894b63841670daccbe9f4c.camel@fb.com> <20220902032912.d2xtpsbv534yaeka@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220902032912.d2xtpsbv534yaeka@macbook-pro-4.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 5 Sep 2022 00:28:14 +0200
Message-ID: <CAP01T76iodXO3rO5r0VMrEF0Hv9gMyFrZ=3An0YjWoPO_ZfNqA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2 Sept 2022 at 05:29, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 02, 2022 at 01:40:29AM +0000, Delyan Kratunov wrote:
> > On Thu, 2022-09-01 at 17:12 -0700, Alexei Starovoitov wrote:
> > > On Thu, Sep 01, 2022 at 10:46:09PM +0000, Delyan Kratunov wrote:
> > > > On Wed, 2022-08-31 at 20:55 -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Aug 31, 2022 at 2:02 PM Delyan Kratunov <delyank@fb.com> wrote:
> > > > > > Given that tracing programs can't really maintain their own freelists safely (I think
> > > > > > they're missing the building blocks - you can't cmpxchg kptrs),
> > > > >
> > > > > Today? yes, but soon we will have link lists supported natively.
> > > > >
> > > > > > I do feel like
> > > > > > isolated allocators are a requirement here. Without them, allocations can fail and
> > > > > > there's no way to write a reliable program.
> > > > >
> > > > > Completely agree that there should be a way for programs
> > > > > to guarantee availability of the element.
> > > > > Inline allocation can fail regardless whether allocation pool
> > > > > is shared by multiple programs or a single program owns an allocator.
> > > >
> > > > I'm not sure I understand this point.
> > > > If I call bpf_mem_prefill(20, type_id(struct foo)), I would expect the next 20 allocs
> > > > for struct foo to succeed. In what situations can this fail if I'm the only program
> > > > using it _and_ I've calculated the prefill amount correctly?
> > > >
> > > > Unless you're saying that the prefill wouldn't adjust the freelist limits, in which
> > > > case, I think that's a mistake - prefill should effectively _set_ the freelist
> > > > limits.
> > >
> > > There is no prefill implementation today, so we're just guessing, but let's try.
> >
> > Well, initial capacity was going to be part of the map API, so I always considered it
> > part of the same work.
> >
> > > prefill would probably have to adjust high-watermark limit.
> > > That makes sense, but for how long? Should the watermark go back after time
> > > or after N objects were consumed?
> >
> > Neither, if you want your pool of objects to not vanish from under you.
> >
> > > What prefill is going to do? Prefill on current cpu only ?
> > > but it doesn't help the prog to be deterministic in consuming them.
> > > Prefill on all cpu-s? That's possible,
> > > but for_each_possible_cpu() {irq_work_queue_on(cpu);}
> > > looks to be a significant memory and run-time overhead.
> >
> > No, that's overkill imo, especially on 100+ core systems.
> > I was imagining the allocator consuming the current cpu freelist first, then stealing
> > from other cpus, and only if they are empty, giving up and scheduling irq_work.
>
> stealing from other cpus?!
> That's certainly out of scope for bpf_mem_alloc as it's implemented.
> Stealing from other cpus would require a redesign.
>

Yes, stealing would most likely force us to use a spinlock, concurrent
llist_del_first doesn't work, so that is the only option that comes to
mind unless you have something fancy in mind (and I would be genuinely
interested to know how :)).

It will then be some more verifier side work if you want to make it
work in tracing and perf_event progs. Essentially, we would need to
teach it to treat bpf_in_nmi() branch specially and force it to use
spin_trylock, otherwise spin_lock can be used (since bpf's is an
irqsave variant so lower contexts are exclusive).
Even then there might be some corner cases I don't remember right now.

> > A little complex to implement but it's possible. It does require atomics everywhere
> > though.
>
> atomic everywhere and many more weeks of thinking and debugging.
> kernel/bpf/percpu_freelist.c does stealing from other cpus and it wasn't
> trivial to do.
>
> >
> > > When freelist is managed by the program it may contain just N elements
> > > that progs needs.
> > >
> > > > > In that sense, allowing multiple programs to create an instance
> > > > > of an allocator doesn't solve this problem.
> > > > > Short free list inside bpf_mem_cache is an implementation detail.
> > > > > "prefill to guarantee successful alloc" is a bit out of scope
> > > > > of an allocator.
> > > >
> > > > I disagree that it's out of scope. This is the only access to dynamic memory from a
> > > > bpf program, it makes sense that it covers the requirements of bpf programs,
> > > > including prefill/freelist behavior, so all programs can safely use it.
> > > >
> > > > > "allocate a set and stash it" should be a separate building block
> > > > > available to bpf progs when step "allocate" can fail and
> > > > > efficient "stash it" can probably be done on top of the link list.
> > > >
> > > > Do you imagine a BPF object that every user has to link into their programs (yuck),
> > > > or a different set of helpers? If it's helpers/kfuncs, I'm all for splitting things
> > > > this way.
> > >
> > > I'm assuming Kumar's proposed list api:
> > > struct bpf_list_head head;
> > > struct bpf_list_node node;
> > > bpf_list_insert(&node, &head);
> > >
> > > will work out.
> >
> > Given the assumed locking in that design, I don't see how it would help nmi programs
> > tbh. This is list_head, we need llist_head, relatively speaking.
>
> Of course. bpf-native link list could be per-cpu and based on llist.
> bpf_list vs bpf_llist. SMOP :)

+1. percpu NMI safe list using local_t style protection should work
out well. It will hook into the same infra for locked linked lists,
but use local_t lock for protection. percpu maps only have local_t,
non-percpu has bpf_spin_lock. Also need to limit remote percpu access
(using bpf_lookup_elem_percpu).
The only labor needed is doing the trylock part for it (since it can
fail, inc_return != 1), so only one branch with the checked result of
trylock has the lock. The lock section is already limited to current
bpf_func_state, and unlocking always happens in the same frame. Other
than that, it is trivial to support with most basic infra already
there in [0].

[0]: https://lore.kernel.org/bpf/20220904204145.3089-1-memxor@gmail.com/

> >
> > >
> > > > If it's distributed separately, I think that's an unexpected burden on developers
> > > > (I'm thinking especially of tools not writing programs in C or using libbpf/bpftool
> > > > skels). There are no other bpf features that require a userspace support library like
> > > > this. (USDT doesn't count, uprobes are the underlying bpf feature and that is useful
> > > > without a library)
> > >
> > > bpf progs must not pay for what they don't use. Hence all building blocks should be
> > > small. We will have libc-like bpf libraries with bigger blocks eventually.
> >
> > I'm not sure I understand how having the mechanism in helpers and managed by the
> > kernel is paying for something they don't use?
>
> every feature adds up.. like stealing from cpus.
>
> > >
> > > > > I think the disagreement here is that per-prog allocator based
> > > > > on bpf_mem_alloc isn't going to be any more deterministic than
> > > > > one global bpf_mem_alloc for all progs.
> > > > > Per-prog short free list of ~64 elements vs
> > > > > global free list of ~64 elements.
> > > >
> > > > Right, I think I had a hidden assumption here that we've exposed.
> > > > Namely, I imagined that after a mem_prefill(1000, struct foo) call, there would be
> > > > 1000 struct foos on the freelist and the freelist thresholds would be adjusted
> > > > accordingly (i.e., you can free all of them and allocate them again, all from the
> > > > freelist).
> > > >
> > > > Ultimately, that's what nmi programs actually need but I see why that's not an
> > > > obvious behavior.
> > >
> > > How prefill is going to work is still to-be-designed.
> >
> > That's the new part for me, though - the maps design had a mechanism to specify
> > initial capacity, and it worked for nmi programs. That's why I'm pulling on this
> > thread, it's the hardest thing to get right _and_ it needs to exist before deferred
> > work can be useful.
>
> Specifying initial capacity sounds great in theory, but what does it mean in practice?
> N elements on each cpu or evenly distributed across all?
>
> >
> > > In addition to current-cpu vs on-all-cpu question above...
> > > Will prefill() helper just do irq_work ?
> > > If so then it doesn't help nmi and irq-disabled progs at all.
> > > prefill helper working asynchronously doesn't guarantee availability of objects
> > > later to the program.
> > > prefill() becomes a hint and probably useless as such.
> >
> > Agreed.
> >
> > > So it should probably be synchronous and fail when in-nmi or in-irq?
> > > But bpf prog cannot know its context, so only safe synchronous prefill()
> > > would be out of sleepable progs.
> >
> > Initial maps capacity would've come from the syscall, so the program itself would not
> > contain a prefill() call.
> >
> > We covered this in our initial discussions - I also think that requiring every
> > perf_event program to setup a uprobe or syscall program to fill the object pool
> > (internal or external) is also a bad design.
>
> right. we did. prefill from user space makes sense.
>
> > If we're going for a global allocator, I suppose we could encode these requirements
> > in BTF and satisfy them on program load? .alloc map with some predefined names or
> > something?
>
> ohh. When I was saying 'global allocator' I meant an allocator that is not exposed
> to bpf progs at all. It's just there for all programs. It has hidden watermarks
> and prefill for it doesn't make sense. Pretty much kmalloc equivalent.
>
> >
> > [...]
> >
> > Userspace doesn't have nmi or need allocators that work from signal handlers, for a
> > more appropriate analogy. We actually need this to work reliably from nmi, so we can
> > shift work _away_ from nmi. If we didn't have this use case, I would've folded on the
> > entire issue and kicked the can down the road (plenty of helpers don't work in nmi).
>
> Sure.
> I think all the arguments against global mem_alloc come from the assumption that
> run-time percpu_ref_get/put in bpf_mem_alloc/free will work.
> Kumar mentioned that we have to carefully think when to do percpu_ref_exit()
> since it will convert percpu_ref to atomic and performance will suffer.
>
> Also there could be yet another solution to refcounting that will enable
> per-program custom bpf_mem_alloc.
> For example:
> - bpf_mem_alloc is a new map type. It's added to prog->used_maps[]
> - no run-time refcnt-ing
> - don't store mem_alloc into hidden 8 bytes
> - since __kptr __local enforces type and size we can allow:
>   obj = bpf_mem_alloc(alloc_A, btf_type_id_local(struct foo));
>   kptr_xchg(val, obj);
>   ..
>   // on different cpu in a different prog
>   obj = kptr_xchg(val, NULL);
>   bpf_mem_free(alloc_B, obj);
> The verifier will need to make sure that alloc_A and alloc_B can service the same type.
> If allocators can service any type sizes not checks are necessary.
>
> - during hash map free we do:
>   obj = xchg(val)
>   bpf_mem_free(global_alloc, obj);
> Where global_alloc is the global allocator I was talking about. It's always there.
> Cannot get any simpler.

Neat idea. The size of kptr is always known (already in the map value type).

Also realized a fun tidbit: we can technically do a sized delete [1]
as well. C, C++, Rust all support this, the first one manually
(actually will in C23 or whenever implementers get around to adopting
it), and the latter two statically using the type's size transform
delete call to do size delete. No need to do size class lookup using
bpf_mem_cache_idx in bpf_mem_free. The verifier can always pass a
hidden argument. So probably a minor perf improvement on the free path
that comes for free.

[1]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2699.htm

>
> My main point is let's postpone the discussions about features that will happen ten steps
> from now. Let's start with global allocator first and don't expose bpf_mem_alloc
> as a map just yet. It will enable plenty of new use cases and unblock other works.

+1, I think we should go with global bpf_mem_alloc, even if it only
serves as a fallback in the future. It makes things much simpler and
pretty much follows the existing kmalloc idea with an extra cache.

Also, I'm confident the BPF percpu linked list case is going to be
pretty much equivalent or at least very close to bpf_mem_alloc
freelist.
But famous last words and all, we'll see.
