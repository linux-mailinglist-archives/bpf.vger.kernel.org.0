Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E035A8909
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 00:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiHaWdM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiHaWdM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 18:33:12 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE646D9E3
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 15:33:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b17so1003610ilh.0
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=v4lImSENi5KPW8WGLM941rwt0f9jjjGHY5oeaa+py10=;
        b=VCkKR9ZCTnt+CtYPmUX+N3+nwggT0GGyA74dBdATJNzYuNJERu/5TL9NaxhLn8xJdO
         /NjkeU4IPAzsopnyH8Bho13TzYFGrBeSU6oDu7n4P1H9UPHL2fcF+vbEh9GzBmxjOkPB
         Am8gt6VSc88OCLtQtLJHtnTgg7sgcmEHfRAKfXUmgp2Ss0GBQ5Zn0LMpp+tToZ4XZ3Ly
         1X1r4Dp2HnC7Hy7TsS21Piq33f44jLPNpSslr8XowIrjXbpkq3z5LxZniapsWhqOgvXG
         /Wm2zYaDufON1LswG6b/vf+RRnJ/Tsdfu34K0johU0v49jx6w66UG2f62nl7NgAH9Kfn
         F1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=v4lImSENi5KPW8WGLM941rwt0f9jjjGHY5oeaa+py10=;
        b=VjZ++I0r8FgxQK2puPQdl78KjPCnMLVknNv28jggHtqvQgl7y3Q7EZduDPH3c6/Zzi
         3iA5qc3blCo10Lf9I+ZFbjMbJCnb6aAWXDakUmkWtV/qOa8kjmwEMjtSslhoyIjv+95X
         nXNYhaENYJk1WSNtk8hshfTym6ETQnXghbzA1VERboZFyhpUp/mDH9oNLGORcJTrVpP+
         IxMllOOmAJZkulflsJDn3as7PGmSfP37NOoJpwjDWtrIW5SuoMWFZc+rZlBj7sXF4dLC
         n7vZrxksxDbMHoBP/knVZDtyWjJ5XVpjdjsbQl+ATe1zyAfvHmLvaNaV6/Qz7uKej0h9
         H1OA==
X-Gm-Message-State: ACgBeo2/sI+FB5lcumWESOnmvXZdbidL0++pHh4OupSJBUS2xkUhZdlX
        oANoem7iudLWrkvGa9JswM1qV9HuLd58FgRlZFUnkLHL
X-Google-Smtp-Source: AA6agR7cdFLnRmGXLNwOfX4CQxv99oaibxN7bQqPVmH/f5+FDnglQuKxOpvJOGFG5TSc333IQYPngL7dNc5w1rJY/Bs=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr3699790ila.164.1661985189947; Wed, 31
 Aug 2022 15:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
 <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
 <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
 <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com> <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
 <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com> <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com> <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
 <e37a3f11074245b04b086f3d9877ca08f0fef7dd.camel@fb.com>
In-Reply-To: <e37a3f11074245b04b086f3d9877ca08f0fef7dd.camel@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 1 Sep 2022 00:32:33 +0200
Message-ID: <CAP01T77gfP5ogEfvAgkGxfqypUtVzaPKu5pE2dYqFgp6=UL20w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
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

On Wed, 31 Aug 2022 at 23:02, Delyan Kratunov <delyank@fb.com> wrote:
>
> On Wed, 2022-08-31 at 11:57 -0700, Alexei Starovoitov wrote:
> > !-------------------------------------------------------------------|
> >   This Message Is From an External Sender
> >
> > > -------------------------------------------------------------------!
> >
> > On Wed, Aug 31, 2022 at 05:38:15PM +0000, Delyan Kratunov wrote:
> > >
> > > Overall, this design (or maybe the way it's presented here) conflates a few ideas.
> > >
> > > 1) The extensions to expose and customize map's internal element allocator are fine
> > > independently of even this patchset.
> > >
> > > 2) The idea that kptrs in a map need to have a statically identifiable allocator is
> > > taken as an axiom, and then expanded to its extreme (single allocator per map as
> > > opposed to the smarter verifier schemes). I still contest that this is not the case
> > > and the runtime overhead it avoids is paid back in bad developer experience multiple
> > > times over.
> > >
> > > 3) The idea that allocators can be merged between elements and kptrs is independent
> > > of the static requirements. If the map's internal allocator is exposed per 1), we can
> > > still use it to allocate kptrs but not require that all kptrs in a map are from the
> > > same allocator.
> > >
> > > Going this coarse in the API is easy for us but fundamentally more limiting for
> > > developers. It's not hard to imagine situations where the verifier dependency
> > > tracking or runtime lifetime tracking would allow for pinned maps to be retained but
> > > this scheme would require new maps entirely. (Any situation where you just refactored
> > > the implicit allocator out to share it, for example)
> > >
> > > I also don't think that simplicity for us (a one time implementation cost +
> > > continuous maintenance cost) trumps over long term developer experience (a much
> > > bigger implementation cost over a much bigger time span).
> >
> > It feels we're thinking about scope and use cases for the allocator quite
> > differently and what you're seeing as 'limiting developer choices' to me looks
> > like 'not a limiting issue at all'. To me the allocator is one
> > jemalloc/tcmalloc instance. One user space application with multiple threads,
> > lots of maps and code is using exactly one such allocator. The allocator
> > manages all the memory of user space process. In bpf land we don't have a bpf
> > process. We don't have a bpf name space either.  A loose analogy would be a set
> > of programs and maps managed by one user space agent. The bpf allocator would
> > manage all the memory of these maps and programs and provide a "memory namespace"
> > for this set of programs. Another user space agent with its own programs
> > would never want to share the same allocator. In user space a chunk of memory
> > could be mmap-ed between different process to share the data, but you would never
> > put a tcmalloc over such memory to be an allocator for different processes.
> >
> > More below.
> >
> > > So far, my ranked choice vote is:
> > >
> > > 1) maximum flexibility and runtime live object counts (with exposed allocators, I
> > > like the merging)
> > > 2) medium flexibility with per-field allocator tracking in the verifier and the
> > > ability to lose the association once programs are unloaded and values are gone. This
> > > also works better with exposed allocators since they are implicitly pinned and would
> > > be usable to store values in another map.
> > > 3) minimum flexibility with static whole-map kptr allocators
> >
> > The option 1 flexibility is necessary when allocator is seen as a private pool
> > of objects of given size. Like kernel's kmem_cache instance.
> > I don't think we quite there yet.
>
> If we're not there, we should aim to get there :)
>
> > There is a need to "preallocate this object from sleepable context,
> > so the prog has a guaranteed chunk of memory to use in restricted context",
> > but, arguably, it's not a job of bpf allocator.
>
> Leaving it to the programs is worse for memory usage (discussed below).
>
> > bpf prog can allocate an object, stash it into kptr, and use it later.
>
> Given that tracing programs can't really maintain their own freelists safely (I think
> they're missing the building blocks - you can't cmpxchg kptrs), I do feel like
> isolated allocators are a requirement here. Without them, allocations can fail and
> there's no way to write a reliable program.
>
> *If* we ensure that you can build a usable freelist out of allocator-backed memory
> for (a set of) nmi programs, then I can maybe get behind this (but there's other
> reasons not to do this).
>
> > So option 3 doesn't feel less flexible to me. imo the whole-map-allocator is
> > more than we need. Ideally it would be easy to specifiy one single
> > allocator for all maps and progs in a set of .c files. Sort-of a bpf package.
> > In other words one bpf allocator per bpf "namespace" is more than enough.
>
> _Potentially_. Programs need to know that when they reserved X objects, they'll have
> them available at a later time and any sharing with other programs can remove this
> property. A _set_ of programs can in theory determine the right prefill levels, but
> this is certainly easier to reason about on a per-program basis, given that programs
> will run at different rates.
>
> > Program authors shouldn't be creating allocators left and right. All these
> > free lists will waste memory.
> > btw I've added an extra patch to bpf_mem_alloc series:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=memalloc&id=6a586327a270272780bdad7446259bbe62574db1
> > that removes kmem_cache usage.
> > Turned out (hindsight 20/20) kmem_cache for each bpf map was a bad idea.
> > When free_lists are not shared they will similarly waste memory.
> > In user space the C code just does malloc() and the memory is isolated per process.
> > Ideally in bpf world the programs would just do:
> > bpf_mem_alloc(btf_type_id_local(struct foo));
> > without specifying an allocator, but that would require one global allocator
> > for all bpf programs in the kernel which is probably not a direction we should go ?
>
> Why does it require a global allocator? For example, you can have each program have
> its own internal allocator and with runtime live counts, this API is very achievable.
> Once the program unloads, you can drain the freelists, so most allocator memory does
> not have to live as long as the longest-lived object from that allocator. In
> addition, all allocators can share a global freelist too, so chunks released after
> the program unloads get a chance to be reused.
>
> > So the programs have to specify an allocator to use in bpf_mem_alloc(),
> > but it should be one for all progs, maps in a bpf-package/set/namespace.
> > If it's easy for programs to specify a bunch of allocators, like one for each program,
> > or one for each btf_type_id the bpf kernel infra would be required to merge
> > these allocators from day one.
>
> How is having one allocator per program different from having one allocator per set
> of programs, with per-program bpf-side freelists? The requirement that some (most?)
> programs need deterministic access to their freelists is still there, no matter the
> number of allocators. If we fear that the default freelist behavior will waste
> memory, then the defaults need to be aggressively conservative, with programs being
> able to adjust them.
>
> Besides, if we punt the freelists to bpf, then we get absolutely no control over the
> memory usage, which is strictly worse for us (and worse developer experience on top).
>
> > (The profileration of kmem_cache-s in the past
> > forced merging of them). By restricting bpf program choices with allocator-per-map
> > (this option 3) we're not only making the kernel side to do less work
> > (no run-time ref counts, no merging is required today), we're also pushing
> > bpf progs to use memory concious choices.
>
> This is conflating "there needs to be a limit on memory stuck in freelists" with "you
> can only store kptrs from one allocator in each map." The former practically
> advocates for freelists to _not_ be hand-rolled inside bpf progs. I still disagree
> with the latter - it's coming strictly from the desire to have static mappings
> between object storage and allocators; it's not coming from a memory usage need, it
> only avoids runtime live object counts.
>
> > Having said all that maybe one global allocator is not such a bad idea.
>
> It _is_ a bad idea because it doesn't have freelist usage determinism. I do, however,
> think there is value in having precise and conservative freelist policies, along with
> a global freelist for overflow and draining after program unload. The latter would
> allow us to share memory between allocators without sacrificing per-allocator
> freelist determinism, especially if paired with very static (but configurable)
> freelist thresholds.
>

These are all good points. Sharing an allocator between all programs
means bpf_mem_prefill request cannot really guarantee much, it does
hurt determinism. The prefilled items can be drained by some other
program with an inconsistent allocation pattern.

But going back to what Alexei replied in the other thread:
> bpf progs are more analogous to kernel modules.
> The modules just do kmalloc.
> The more we discuss the more I'm leaning towards the same model as well:
> Just one global allocator for all bpf progs.

There does seem to be one big benefit in having a global allocator
(not per program, but actually globally in the kernel, basically a
percpu freelist cache fronting kmalloc) usable safely in any context.
We don't have to do any allocator lifetime tracking at all, that case
reduces to basically how we handle kernel kptrs currently.

I am wondering if we can go with such an approach: by default, the
global allocator in the kernel serves bpf_mem_alloc requests, which
allows freelist sharing between all programs, it is basically kmalloc
but safe in NMI and with reentrancy protection. When determinism is
needed, use the percpu refcount approach with option 1 from Delyan for
the custom allocator case.

Now by default you have conservative global freelist sharing (percpu),
and when required program can use a custom allocator and prefill to
keep the cache ready to serve requests (where that kind of control
will be very useful for progs in NMI/hardirq context, where depletion
of cache means NULL from unit_alloc), where its own allocator freelist
will be unaffected by other allocations.

Any kptr from the bpf_mem_alloc allocator can go to any map, no problem at all.
The only extra cost is maintaining the percpu live counts for
non-global allocators, it is basically free for the global case.
And it would also be allowed to probably choose and share allocators
between maps, as proposed by Alexei before. That has no effect on
kptrs being stored in them, as most commonly they would be from the
global allocator.

Thoughts on this?
