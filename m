Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A45A5AF9
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 07:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiH3FDd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 01:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiH3FDb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 01:03:31 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC979E12B
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 22:03:29 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i77so8358223ioa.7
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8XjOpXG2D7bTRqHoQFhgnZIvSz7+1ypV627Qnx/qSwk=;
        b=fgTD7u0Vk819wJPJ5cVogcjxYjz9yykQIgZmylFDmypIC+cSrVcnqy0vZAErIc/RIw
         QT6uqE6rFe6HJSoU4rVMS1o7O7AnqoTDHEv4pHYVYe2DrA1Aj1nEia1Lkv6r0MFxBmGD
         gv7thPLYDZ6yV85j+yTNM9qvnCsKpSW5FmYWOFYT2rVwYGv08FtI4Ez7h7RyC3t9vU9K
         iIJn86JurEkBWHBLY7WyQ/Upvs2Upzen0zBufK/YDFC5h9kGtDlzbNARZABFSvvgL9YY
         59cYD1wdbgrW29ACjPf/j8HT2rpI1kmhSkas0jD6PxJMznl+m3DRBeh95mUB9TasMMIh
         O0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8XjOpXG2D7bTRqHoQFhgnZIvSz7+1ypV627Qnx/qSwk=;
        b=YC+bdKcWumjnqUy1z2/MOJFIseXeomVq8fTF3Yx52VUYJFQioky6okfFgNyxOaVyUJ
         JbqZD+Ffeg6nT65QZAPBq8KZ5FRXTG6soexTFUpLHlQ9B9eVMlVPSMdCB7vVKjtSPh+p
         l8vgZCntXSWnZ69qlgTY5KsVAJsqKlbwYBgYUkyY57PJMLQeaS9vpIUvUBUBmOLoK//o
         JyrtoIPo+vNXoXxeYiDBTedxXOMGIpZCNVBigx9fyQYuPFddmajH3onci9NPiHGiNbRo
         9zJv6pe7zhHueM0pipRQDq23Z6QKU1jyaCf0bwrean8fIBdHNMUzUyc6MvXNARAsjDzh
         rTJg==
X-Gm-Message-State: ACgBeo0hbftIP2634LI2ucHa5cc0lt40mpD2oVSvWCDiR+BF9q9LpXpI
        Y4zHG8I/vNXijMjCyJresCn5jcZja4kKGTZ+dHE=
X-Google-Smtp-Source: AA6agR5kLIf7AXHStCq/uOamBC6RiXppCKoPSMHDxOAWjWOSNKnKSHFCaBY9JIndVHoEwTwR/H4GXAEdLt9L3J9FZ/8=
X-Received: by 2002:a02:3f63:0:b0:349:cef9:d8c2 with SMTP id
 c35-20020a023f63000000b00349cef9d8c2mr11771100jaf.231.1661835809262; Mon, 29
 Aug 2022 22:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com> <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
 <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com> <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
 <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com>
 <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
 <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
 <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
 <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com> <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
In-Reply-To: <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 30 Aug 2022 07:02:52 +0200
Message-ID: <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>, "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
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

On Tue, 30 Aug 2022 at 05:35, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 29, 2022 at 6:40 PM Delyan Kratunov <delyank@fb.com> wrote:
> >
> > Yes, if we populate used_allocators on load and copy them to inner maps, this might
> > work. It requires the most conservative approach where loading and unloading a
> > program in a loop would add its allocators to the visible pinned maps, accumulating
> > allocators we can't release until the map is gone.
> >
> > However, I thought you wanted to walk the values instead to prevent this abuse. At
> > least that's the understanding I was operating under.
> >
> > If a program has the max number of possible allocators and we just load/unload it in
> > a loop, with a visible pinned map, the used_allocators list of that map can easily
> > skyrocket.
>
> Right. That will be an issue if we don't trim the list
> at prog unload.
>
> > > Sorry I confused myself and others with release_uref.
> > > I meant map_poke_untrack-like call.
> > > When we drop refs from used maps in __bpf_free_used_maps
> > > we walk all elements.
> > > Similar idea here.
> > > When prog is unloaded it cleans up all objects it allocated
> > > and stored into maps before dropping refcnt-s
> > > in prog->used_allocators.
> >
> > For an allocator that's visible from multiple programs (say, it's in a map-of-maps),
> > how would we know which values were allocated by which program? Do we forbid shared
> > allocators outright?
>
> Hopefully we don't need to forbid shared allocators and
> allow map-in-map to contain kptr local.
>
> > Separately, I think I just won't allow allocators as inner maps, that's for another
> > day too (though it may work just fine).
> >
> > Perfect, enemy of the good, something-something.
>
> Right, but if we can allow that with something simple
> it would be nice.
>
> After a lot of head scratching realized that
> walk-all-elems-and-kptr_xchg approach doesn't work,
> because prog_A and prog_B might share a map and when
> prog_A is unloaded and trying to do kptr_xchg on all elems
> the prog_B might kptr_xchg as well and walk_all loop
> will miss kptrs.

Agreed, I can't see it working either.

> prog->used_allocators[] approach is broken too.
> Since the prog_B (in the example above) might see
> objects that were allocated from prog_A's allocators.
> prog->used_allocators at load time is incorrect.
>
> To prevent all of these issues how about we
> restrict kptr local to contain a pointer only
> from one allocator.
> When parsing map's BTF if there is only one kptr local
> in the map value the equivalent of map->used_allocators[]
> will guarantee to contain only one allocator.
> Two kptr locals in the map value -> potentially two allocators.
>
> So here is new proposal:
>

Thanks for the proposal, Alexei. I think we're getting close to a
solution, but still some comments below.

> At load time the verifier walks all kptr_xchg(map_value, obj)
> and adds obj's allocator to
> map->used_allocators <- {kptr_offset, allocator};
> If kptr_offset already exists -> failure to load.
> Allocator can probably be a part of struct bpf_map_value_off_desc.
>
> In other words the pairs of {kptr_offset, allocator}
> say 'there could be an object from that allocator in
> that kptr in some map values'.
>
> Do nothing at prog unload.
>
> At map free time walk all elements and free kptrs.
> Finally drop allocator refcnts.
>

Yes, this should be possible.
It's quite easy to capture the map_ptr for the allocated local kptr.
Limiting each local kptr to one allocator is probably fine, at least for a v1.

One problem I see is how it works when the allocator map is an inner map.
Then, it is not possible to find the backing allocator instance at
verification time, hence not possible to take the reference to it in
map->used_allocators.
But let's just assume that is disallowed for now.

The other problem I see is that when the program just does
kptr_xchg(map_value, NULL), we may not have allocator info from
kptr_offset at that moment. Allocating prog which fills
used_allocators may be verified later. We _can_ reject this, but it
makes everything fragile (dependent on which order you load programs
in), which won't be great. You can then use this lost info to make
kptr disjoint from allocator lifetime.

Let me explain through an example.

Consider this order to set up the programs:
One allocator map A.
Two hashmaps M1, M2.
Three programs P1, P2, P3.

P1 uses M1, M2.
P2 uses A, M1.
P3 uses M2.

Sequence:
map_create A, M1, M2.

Load P1, uses M1, M2. What this P1 does is:
p = kptr_xchg(M1.value, NULL);
kptr_xchg(M2.value, p);

So it moves the kptr in M1 into M2. The problem is at this point
kptr_offset is not populated, so we cannot fill used_allocators of M2
as we cannot track which allocator is used to fill M1.value. We saw
nothing filling it yet.

Next, load P3. It does:
p = kptr_xchg(M2.value, NULL);
unit_free(p); // let's assume p has bpf_mem_alloc ptr behind itself so
this is ok if allocator is alive.

Again, M2.used_allocators is empty. Nothing is filled into it.

Next, load P2.
p = alloc(&A, ...);
kptr_xchg(M1.value, p);

Now, M1.used_allocators is filled with allocator ref and kptr_offset.
But M2.used_allocators will remain unfilled.

Now, run programs in sequence of P2, then P1. This will allocate from
A, and move the ref to M1, then to M2. But only P1 and P2 have
references to M1 so it keeps the allocator alive. However, now unload
both P1 and P2.
P1, P2, A, allocator of A, M1 all can be freed after RCU gp wait. M2
is still held by loaded P3.

Now, M2.used_allocators is empty. P3 is using it, and it is holding
allocation from allocator A. Both M1 and A are freed.
When P3 runs now, it can kptr_xchg and try to free it, and the same
uaf happens again.
If not that, uaf when M2 is freed and it does unit_free on the alive local kptr.

--

Will this case be covered by your approach? Did I miss something?

The main issue is that this allocator info can be lost depending on
how you verify a set of programs. It would not be lost if we verified
in order P2, P1, P3 instead of the current P1, P3, P2.

So we might have to teach the verifier to identify kptr_xchg edges
between maps, and propagate any used_allocators to the other map? But
it's becoming too complicated.

You _can_ reject loads of programs when you don't find kptr_offset
populated on seeing kptr_xchg(..., NULL), but I don't think this is
practical either. It makes the things sensitive to program
verification order, which would be confusing for users.
