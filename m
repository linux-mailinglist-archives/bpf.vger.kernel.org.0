Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09A5A7392
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 03:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiHaBwz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 21:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiHaBwx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 21:52:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946BDB0B10
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:52:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f12so12644572plb.11
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dJzgVxhjM6dIzgT8h6zXm9RekprH9D1fnUKm5U4Ekac=;
        b=Uz3dgMlAvIIQwKJyNk8gy79THmg2MqgIwpzEGP8y7wiS8zTUrS8IzFXC95SFQ+9sbD
         JiyECE8xKMgRgqva7ja1htxhc6aKqrsEh4vNbLc5UwIVz5fKp3FfsK8zCUoQnfex0gEB
         O9aJZdVzQqZe4P3Q7cxyKIv1OHE73IRoX8lsq9IE5/0q0yBZQvRU27HlrqB977ENPBoI
         k+0K+ggmaKCdj7ZKQfoOLhg0TvBwlNlWVNJUKzW13OVSyC5ng90UcQzz+rdGRo2Lbk9j
         /3QgrKnOEhQvabtn+cJjXVwgGt8uefTdKiGPZwy5nQjJr+xaiNtLKqjW+bymnjluVcfp
         EHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dJzgVxhjM6dIzgT8h6zXm9RekprH9D1fnUKm5U4Ekac=;
        b=UxUJjfGnFoziy2eq3UbJ9u/78S+skkCeQ3i6fsv/VIy35jorFnD/KziN1KYyepsRqC
         n/Ei8ACe2mfimr+7J8a49wAmoz/m9YgokYpieaYZ9OUhn+bCQXJWMMELDaV7K9owEPOJ
         DO7OCv+hET12wBbnf08xIRenh22FhpqRzPrC9CYDqnnomn/68c01KBOFiiMlZgBlLl/W
         xJi8KtyvhDWUc/rVxES42dt0i1uNMlUrFZnwKbHDVGDzOhbbg39p6vGabP6lT+e5vKgx
         XCJQ/D+YU98c7zjoeV/9joV/dUv5KdabbTMKNxV47G2BDe6eCg1bWHiSQMuqwZJ49kG1
         TAVg==
X-Gm-Message-State: ACgBeo2Pn55Y0xA9g4yoldo9I67sRI4rDN/f4lD2ieKYzJOAX2neNxci
        Xuvau7bT4Rm2ZRmrDKLA8Jw=
X-Google-Smtp-Source: AA6agR6nTwDhHAm/0kchoVEJmDmLOUKKW2tY2tr6qe9DiLWkNnUt3vRKmukOpyAwNTjscKO4RdMqjg==
X-Received: by 2002:a17:90a:e645:b0:1fd:7221:287c with SMTP id ep5-20020a17090ae64500b001fd7221287cmr872990pjb.176.1661910770821;
        Tue, 30 Aug 2022 18:52:50 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:de65])
        by smtp.gmail.com with ESMTPSA id i196-20020a6287cd000000b00537dde5ff7csm8878288pfe.176.2022.08.30.18.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:52:50 -0700 (PDT)
Date:   Tue, 30 Aug 2022 18:52:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "memxor@gmail.com" <memxor@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Message-ID: <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
References: <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
 <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com>
 <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
 <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
 <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
 <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com>
 <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
 <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 08:31:55PM +0000, Delyan Kratunov wrote:
> On Mon, 2022-08-29 at 23:03 -0700, Alexei Starovoitov wrote:
> > 
> > On Mon, Aug 29, 2022 at 10:03 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > > > 
> > > > So here is new proposal:
> > > > 
> > > 
> > > Thanks for the proposal, Alexei. I think we're getting close to a
> > > solution, but still some comments below.
> > > 
> > > > At load time the verifier walks all kptr_xchg(map_value, obj)
> > > > and adds obj's allocator to
> > > > map->used_allocators <- {kptr_offset, allocator};
> > > > If kptr_offset already exists -> failure to load.
> > > > Allocator can probably be a part of struct bpf_map_value_off_desc.
> > > > 
> > > > In other words the pairs of {kptr_offset, allocator}
> > > > say 'there could be an object from that allocator in
> > > > that kptr in some map values'.
> > > > 
> > > > Do nothing at prog unload.
> > > > 
> > > > At map free time walk all elements and free kptrs.
> > > > Finally drop allocator refcnts.
> > > > 
> > > 
> > > Yes, this should be possible.
> > > It's quite easy to capture the map_ptr for the allocated local kptr.
> > > Limiting each local kptr to one allocator is probably fine, at least for a v1.
> > > 
> > > One problem I see is how it works when the allocator map is an inner map.
> > > Then, it is not possible to find the backing allocator instance at
> > > verification time, hence not possible to take the reference to it in
> > > map->used_allocators.
> > > But let's just assume that is disallowed for now.
> > > 
> > > The other problem I see is that when the program just does
> > > kptr_xchg(map_value, NULL), we may not have allocator info from
> > > kptr_offset at that moment. Allocating prog which fills
> > > used_allocators may be verified later. We _can_ reject this, but it
> > > makes everything fragile (dependent on which order you load programs
> > > in), which won't be great. You can then use this lost info to make
> > > kptr disjoint from allocator lifetime.
> > > 
> > > Let me explain through an example.
> > > 
> > > Consider this order to set up the programs:
> > > One allocator map A.
> > > Two hashmaps M1, M2.
> > > Three programs P1, P2, P3.
> > > 
> > > P1 uses M1, M2.
> > > P2 uses A, M1.
> > > P3 uses M2.
> > > 
> > > Sequence:
> > > map_create A, M1, M2.
> > > 
> > > Load P1, uses M1, M2. What this P1 does is:
> > > p = kptr_xchg(M1.value, NULL);
> > > kptr_xchg(M2.value, p);
> > > 
> > > So it moves the kptr in M1 into M2. The problem is at this point
> > > kptr_offset is not populated, so we cannot fill used_allocators of M2
> > > as we cannot track which allocator is used to fill M1.value. We saw
> > > nothing filling it yet.
> > > 
> > > Next, load P3. It does:
> > > p = kptr_xchg(M2.value, NULL);
> > > unit_free(p); // let's assume p has bpf_mem_alloc ptr behind itself so
> > > this is ok if allocator is alive.
> > > 
> > > Again, M2.used_allocators is empty. Nothing is filled into it.
> > > 
> > > Next, load P2.
> > > p = alloc(&A, ...);
> > > kptr_xchg(M1.value, p);
> > > 
> > > Now, M1.used_allocators is filled with allocator ref and kptr_offset.
> > > But M2.used_allocators will remain unfilled.
> > > 
> > > Now, run programs in sequence of P2, then P1. This will allocate from
> > > A, and move the ref to M1, then to M2. But only P1 and P2 have
> > > references to M1 so it keeps the allocator alive. However, now unload
> > > both P1 and P2.
> > > P1, P2, A, allocator of A, M1 all can be freed after RCU gp wait. M2
> > > is still held by loaded P3.
> > > 
> > > Now, M2.used_allocators is empty. P3 is using it, and it is holding
> > > allocation from allocator A. Both M1 and A are freed.
> > > When P3 runs now, it can kptr_xchg and try to free it, and the same
> > > uaf happens again.
> > > If not that, uaf when M2 is freed and it does unit_free on the alive local kptr.
> > > 
> > > --
> > > 
> > > Will this case be covered by your approach? Did I miss something?
> > > 
> > > The main issue is that this allocator info can be lost depending on
> > > how you verify a set of programs. It would not be lost if we verified
> > > in order P2, P1, P3 instead of the current P1, P3, P2.
> > > 
> > > So we might have to teach the verifier to identify kptr_xchg edges
> > > between maps, and propagate any used_allocators to the other map? But
> > > it's becoming too complicated.
> > > 
> > > You _can_ reject loads of programs when you don't find kptr_offset
> > > populated on seeing kptr_xchg(..., NULL), but I don't think this is
> > > practical either. It makes the things sensitive to program
> > > verification order, which would be confusing for users.
> > 
> > Right. Thanks for brainstorming and coming up with the case
> > where it breaks.
> > 
> > Let me explain the thought process behind the proposal.
> > The way the progs will be written will be something like:
> > 
> > struct foo {
> >   int var;
> > };
> > 
> > struct {
> >   __uint(type, BPF_MAP_TYPE_ALLOCATOR);
> >   __type(value, struct foo);
> > } ma SEC(".maps");
> > 
> > struct map_val {
> >   struct foo * ptr __kptr __local;
> > };
> > 
> > struct {
> >   __uint(type, BPF_MAP_TYPE_HASH);
> >   __uint(max_entries, 123);
> >   __type(key, __u32);
> >   __type(value, struct map_val);
> > } hash SEC(".maps");
> > 
> > struct foo * p = bpf_mem_alloc(&ma, type_id_local(struct foo));
> > bpf_kptr_xchg(&map_val->ptr, p);
> > 
> > Even if prog doesn't allocate and only does kptr_xchg like
> > your P1 and P3 do the C code has to have a full
> > definition 'struct foo' to compile P1 and P3.
> > P1 and P3 don't need to see definition of 'ma' to be compiled,
> > but 'struct foo' has to be seen.
> > BTF reference will be taken by both 'ma' and by 'hash'.
> > The btf_id will come from that BTF.
> > 
> > The type is tied to BTF and tied to kptr in map value.
> > The type is also tied to the allocator.
> > The type creates a dependency chain between allocator and map.
> > So the restriction of one allocator per kptr feels
> > reasonable and doesn't feel restrictive at all.
> > That dependency chain is there in the C code of the program.
> > Hence the proposal to discover this dependency in the verifier
> > through tracking of allocator from mem_alloc into kptr_xchg.
> > But you're correct that it's not working for P1 and P3.
> 
> Encoding the allocator in the runtime type system is fine but it comes with its own
> set of tradeoffs.
> 
> > 
> > I can imagine a few ways to solve it.
> > 1. Ask users to annotate kptr local with the allocator
> > that will be used.
> > It's easy for progs P1 and P3. All definitions are likely available.
> > It's only an extra tag of some form.
> 
> This would introduce maps referring to other maps and would thus require substantial
> work in libbpf. In order to encode the link specific to field instead of the whole
> map object, we'd have to resort to something like map names as type tags, which is
> not a great design (arbitrary strings etc). 
> 
> > 2. move 'used_allocator' from map further into BTF,
> >   since BTF is the root of this dependency chain.
> 
> This would _maybe_ work. The hole I can see in this plan is that once a slot is
> claimed, it cannot be unclaimed and thus maps can remain in a state that leaves the
> local kptr fields useless (i.e. the allocator is around but no allocator map for it
> exists and thus no program can use these fields again, they can only be free()).

That's correct if we think of allocators as property of programs, but see below.

> The reason it can't be unclaimed is that programs were verified with a specific
> allocator value in mind and we can't change that after they're loaded. To be able to
> unclaim a slot, we'd need to remove everything using that system (i.e. btf object)
> and load it again, which is not great.

That's also correct.

> 
> > When the verifier sees bpf_mem_alloc in P2 it will add
> > {allocator, btf_id} pair to BTF.
> > 
> > If P1 loads first and the verifier see:
> > p = kptr_xchg(M1.value, NULL);
> > it will add {unique_allocator_placeholder, btf_id} to BTF.
> > Then
> > kptr_xchg(M2.value, p); does nothing.
> > The verifier checks that M1's BTF == M2's BTF and id-s are same.
> 
> Note to self: don't allow setting base_btf from userspace without auditing all these
> checks.
> 
> > 
> > Then P3 loads with:
> > p = kptr_xchg(M2.value, NULL);
> > unit_free(p);
> > since unique_allocator_placholder is already there for that btf_id
> > the verifier does nothing.
> > 
> > Eventually it will see bpf_mem_alloc for that btf_id and will
> > replace the placeholder with the actual allocator.
> > We can even allow P1 and P3 to be runnable after load right away.
> > Since nothing can allocate into that kptr local those
> > kptr_xchg() in P1 and P3 will be returning NULL.
> > If P2 with bpf_mem_alloc never loads it's fine. Not a safety issue.
> > 
> > Ideally for unit_free(p); in P3 the verifier would add a hidden
> > 'ma' argument, so that allocator doesn't need to be stored dynamically.
> > We can either insns of P3 after P2 was verified or
> > pass a pointer to a place in BTF->used_allocator list of pairs
> > where actual allocator pointer will be written later.
> > Then no patching is needed.
> > If P2 never loads the unit_free(*addr /* here it will load the
> > value of unique_allocator_placeholder */, ...)
> > but since unit_free() will never execute with valid obj to be freed.
> > 
> > "At map free time walk all elements and free kptrs" step stays the same.
> > but we decrement allocator refcnt only when BTF is freed
> > which should be after map free time.
> > So btf_put(map->btf); would need to move after ops->map_free.
> > 
> > Maybe unique_allocator_placeholder approach can be used
> > without moving the list into BTF. Need to think more about it tomorrow.
> 
> I don't think we have to resort to storing the type-allocator mappings in the BTF at
> all.
> 
> In fact, we can encode them where you wanted to encode them with tags - on the fields
> themselves. We can put the mem_alloc reference in the kptr field descriptors and have
> it transition to a specific allocator irreversibly. We would need to record where any
> equivalences between allocators we need for the currently loaded programs but it's
> not impossible.
> 
> Making the transition reversible is the hard part of course.
> 
> Taking a step back, we're trying to convert a runtime property (this object came from
> this allocator) into a static property. The _cleanest_ way to do this would be to
> store the dependencies explicitly and propagate/dissolve them on program load/unload.

Agree with above.

> Note that only programs introduce new dependency edges, maps on their own do not
> mandate dependencies but stored values can extend the lifetime of a dependency chain.

I think we're getting to the bottom of the issues with this api.
The api is designed around the concept of an allocator being another map type.
That felt correct in the beginning, but see below.

> There are only a couple of types of dependencies:
> Program X stores allocation from Y into map Z, field A
> Program X requires allocator for Y.A to equal allocator for Z.A (+ a version for
> inner maps)

What does it mean for two allocators to be equivalent?
Like mergeable slabs? If so the kernel gave the answer to that question long ago:
merge them whenever possible.
bpf-speak if two allocators have the same type they should be mergeable (== equivalent).
Now let's come up with a use case when bpf core would need to recognize two
equivalent allocators.
Take networking service, like katran. It has a bunch of progs that are using
pinned maps. The maps are pinned because progs can be reloaded due to
live-upgrade or due to user space restart. The map contents are preserved, but
the progs are reloaded. That's a common scenario.
If we design allocator api in a way that allocator is another map. The prog
reload case has two options:
- create new allocator map and use it in reloaded progs
- pin allocator map along with other maps at the very beginning and
  make reloaded progs use it

In the later case there is no new allocator. No need to do equivalence checks.
In the former case there is a new allocator and bpf core needs to recognize
equivalence otherwise pinned maps with kptrs won't be usable out of reloaded
progs. But what are the benefits of creating new allocators on reload?
I don't see any. Old allocator had warm caches populated with cache friendly
objects. New allocator has none of it, but it's going to be used for exactly
the same objects. What's worse. New allocator will likely bring a new BTF object
making equivalence work even harder.

I think it all points to the design issue where allocator is another map and
dependency between maps is a run-time property. As you pointed out earlier the
cleanest way is to make this dependency static. Turned out we have such static
dependency already. Existing bpf maps depend on kernel slab allocator. After
bpf_mem_alloc patches each hash map will have a hidden dependency on that
allocator.

What we've designed so far is:

struct foo {
  int var;
};

struct {
  __uint(type, BPF_MAP_TYPE_ALLOCATOR);
  __type(value, struct foo);
} ma SEC(".maps");

struct map_val {
  struct foo * ptr __kptr __local;
};

struct {
  __uint(type, BPF_MAP_TYPE_HASH);
  __uint(max_entries, 123);
  __type(key, __u32);
  __type(value, struct map_val);
} hash SEC(".maps");

struct foo * p = bpf_mem_alloc(&ma, type_id_local(struct foo));
bpf_kptr_xchg(&map_val->ptr, p);

/* this is a copy-paste of my earlier example. no changes */

but what wasn't obvious that we have two allocators here.
One explicit 'ma' and another hidden allocator in 'hash'.
Both are based on 'struct bpf_mem_alloc'.
One will be allocating 'struct foo'. Another 'struct map_val'.
But we missed opportunity to make them mergeable and
bpf prog cannot customize them.

I think the way to fix the api is to recognize:
- every map has an allocator
- expose that allocator to progs
- allow sharing of allocators between maps

so an allocator is a mandatory part of the map.
If it's not specified an implicit one will be used.
Thinking along these lines we probably need map-in-map-like
specification of explicit allocator(s) for maps:

struct {
  __uint(type, BPF_MAP_TYPE_HASH);
  __uint(max_entries, 123);
  __type(key, __u32);
  __type(value, struct map_val);
  __array(elem_allocator, struct {
      __uint(type, BPF_MAP_TYPE_ALLOCATOR);
  });
  __array(kptr_allocator, struct {
      __uint(type, BPF_MAP_TYPE_ALLOCATOR);
  });
} hash SEC(".maps");

That would be explicit and static declartion of allocators that
hash map should use.
The benefits:
- the prog writers can share the same allocator across multiple
hash maps by specifying the same 'elem_allocator'.
(struct bpf_mem_alloc already supports more than one size)
The most memory concious authors can use the same allocator
across all of their maps achieving the best memory savings.
Not talking about kptr yet. This is just plain hash maps.

- the program can influence hash map allocator.
Once we have bpf_mem_prefill() helper the bpf program can add
reserved elements to a hash map and guarantee that
bpf_map_update_elem() will succeed later.

- kptr allocator is specified statically. At map creation time
the map will take reference of allocator and will keep it until
destruction. The verifier will make sure that kptr_xchg-ed objects
come only from that allocator.
So all of the refcnt issues discussed in this thread are gone.
The prog will look like:

struct {
  __uint(type, BPF_MAP_TYPE_ALLOCATOR);
} ma SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_HASH);
  __type(value, struct map_val);
  __array(kptr_allocator, struct {
      __uint(type, BPF_MAP_TYPE_ALLOCATOR);
  });
} hash SEC(".maps") = {
        .kptr_allocator = { (void *)&ma },
};
struct foo * p = bpf_mem_alloc(&ma, type_id_local(struct foo));

If allocated kptr-s don't need to be in multiple maps the prog can be:

struct {
  __uint(type, BPF_MAP_TYPE_HASH);
  __type(value, struct map_val);
  __array(kptr_allocator, struct {
      __uint(type, BPF_MAP_TYPE_ALLOCATOR);
  });
} hash SEC(".maps");

struct foo * p = bpf_mem_alloc(&hash->kptr_allocator, type_id_local(struct foo));

The same hash->kptr_allocator can be used to allocate different types.
We can also allow the same allocator to be specified in hash->elem_allocator
and hash->kptr_allocator.

We can allow progs to skip declaring explicit BPF_MAP_TYPE_ALLOCATOR.
Like:
struct {
  __uint(type, BPF_MAP_TYPE_HASH);
  __type(value, struct map_val);
} hash SEC(".maps");

struct foo * p = bpf_mem_alloc(&hash->elem_allocator, type_id_local(struct foo));

In this case both kptr objects and map elements come from the same allocator
that was implicitly created at hash map creation time.

The prog reload use case is naturally solved.
By pinning map the user space pinned allocators and prog reload will reuse
the same maps with the same allocators.

If this design revision makes sense the bpf_mem_alloc needs a bit of work
to support the above cleanly. It should be straightforward.

> If there's a non-NULL value in the map, we can't do much - we need a program to load
> that uses this map and on that program's unload, we can check again. On map free, we
> can free the values, of course, but we can't remove the dependency edges from the
> table, since values may have propagated to other tables (this depends on the concrete
> implementation - we might be able to have the map remove all edges that reference
> it).
...
> I don't think it's worth the complexity, explicit or not.

The edge tracking dependency graph sounds quite complex and I agree that it's not worth it.
