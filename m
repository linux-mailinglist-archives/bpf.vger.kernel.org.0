Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26C5A5B65
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 08:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiH3GDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 02:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH3GDh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 02:03:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B9B56C8
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 23:03:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h5so8402828ejb.3
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 23:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vHmDOKclbq9Z1gTCv3qpu17YcA0uf8dDpZV2IS/0er0=;
        b=AQ8zuQrdASCbIh23et8zzRJBiHERW7P7a8ica0iVq8qxylXnU86IYAw+EdP1CPlyMz
         WvK6PX3yW8HiwbzuqS841x85hgU+el09DCrE8zBzAlanyJY2kZHD+IvqfTyFpU+nU2eZ
         gWfA1b9sXTJmJnruByiWR/ahTkOYSstZvlRu9S3YVoTHI5MtJLscrEv2drQ8LswYRKRT
         67G6HwDSU72JpHGgqPjUT/DcrxxFtIFhHPFzIMgeyoMB2e58L97RdGtc3r7Flz14r5TO
         FDzcAyyjVL/2+R/4cC6CQSGecCZF3yxx/WsoPRwkX5flPgSmc8tG8/oaaF1O6g7VlUAb
         smSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vHmDOKclbq9Z1gTCv3qpu17YcA0uf8dDpZV2IS/0er0=;
        b=n0t8Z7RDNMnBkUA89j2EjyuiA8uwmhY/VbleNVgddNt1qH6oaTtcJz5zchNWqSyho4
         ZVYw8CAp9ug+pX+br6Od8MSuFXFSH4RuCZSGRvlJJuhOJW4hxo3HqcXDoq7f3psGXEh6
         bZOPG0EsIFtUi6lTShyOfiOiEBSC+tx7Vvcbq8vmE29hlDv8XOWdOU+0Q3R2TKyxDvDu
         jWhsgsPxR21G5hhQPT5rK/hGlKrejrEUtCeqBm8JLyOuq4OkyswlcnieDafbqxPzWXT0
         sptfSbqkuc5XnoiaQqsJ5FtQvZDhuQoy+c98lEyfSTxEBPGAdTwghLRCiaHKyNOq/2Ai
         Yvmg==
X-Gm-Message-State: ACgBeo2j10RXa7i9Cc71r2DJisBEbdy3azxDBZneUoil5IfHpNUoSZRI
        7vEAb+Po0nE16R1kQ0+w7yicBXpb43kgGtR6eTs=
X-Google-Smtp-Source: AA6agR4lz5q0etH8VxNRBLQ+njVweXhBNRteJaN5qpr9s+POEWA7RXHYh7fqDH1MfwgOcIbKViVSErRBMzzGnFFjRBs=
X-Received: by 2002:a17:906:3a15:b0:73d:80bf:542c with SMTP id
 z21-20020a1709063a1500b0073d80bf542cmr16013018eje.633.1661839413449; Mon, 29
 Aug 2022 23:03:33 -0700 (PDT)
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
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
In-Reply-To: <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 23:03:22 -0700
Message-ID: <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Mon, Aug 29, 2022 at 10:03 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> >
> > So here is new proposal:
> >
>
> Thanks for the proposal, Alexei. I think we're getting close to a
> solution, but still some comments below.
>
> > At load time the verifier walks all kptr_xchg(map_value, obj)
> > and adds obj's allocator to
> > map->used_allocators <- {kptr_offset, allocator};
> > If kptr_offset already exists -> failure to load.
> > Allocator can probably be a part of struct bpf_map_value_off_desc.
> >
> > In other words the pairs of {kptr_offset, allocator}
> > say 'there could be an object from that allocator in
> > that kptr in some map values'.
> >
> > Do nothing at prog unload.
> >
> > At map free time walk all elements and free kptrs.
> > Finally drop allocator refcnts.
> >
>
> Yes, this should be possible.
> It's quite easy to capture the map_ptr for the allocated local kptr.
> Limiting each local kptr to one allocator is probably fine, at least for a v1.
>
> One problem I see is how it works when the allocator map is an inner map.
> Then, it is not possible to find the backing allocator instance at
> verification time, hence not possible to take the reference to it in
> map->used_allocators.
> But let's just assume that is disallowed for now.
>
> The other problem I see is that when the program just does
> kptr_xchg(map_value, NULL), we may not have allocator info from
> kptr_offset at that moment. Allocating prog which fills
> used_allocators may be verified later. We _can_ reject this, but it
> makes everything fragile (dependent on which order you load programs
> in), which won't be great. You can then use this lost info to make
> kptr disjoint from allocator lifetime.
>
> Let me explain through an example.
>
> Consider this order to set up the programs:
> One allocator map A.
> Two hashmaps M1, M2.
> Three programs P1, P2, P3.
>
> P1 uses M1, M2.
> P2 uses A, M1.
> P3 uses M2.
>
> Sequence:
> map_create A, M1, M2.
>
> Load P1, uses M1, M2. What this P1 does is:
> p = kptr_xchg(M1.value, NULL);
> kptr_xchg(M2.value, p);
>
> So it moves the kptr in M1 into M2. The problem is at this point
> kptr_offset is not populated, so we cannot fill used_allocators of M2
> as we cannot track which allocator is used to fill M1.value. We saw
> nothing filling it yet.
>
> Next, load P3. It does:
> p = kptr_xchg(M2.value, NULL);
> unit_free(p); // let's assume p has bpf_mem_alloc ptr behind itself so
> this is ok if allocator is alive.
>
> Again, M2.used_allocators is empty. Nothing is filled into it.
>
> Next, load P2.
> p = alloc(&A, ...);
> kptr_xchg(M1.value, p);
>
> Now, M1.used_allocators is filled with allocator ref and kptr_offset.
> But M2.used_allocators will remain unfilled.
>
> Now, run programs in sequence of P2, then P1. This will allocate from
> A, and move the ref to M1, then to M2. But only P1 and P2 have
> references to M1 so it keeps the allocator alive. However, now unload
> both P1 and P2.
> P1, P2, A, allocator of A, M1 all can be freed after RCU gp wait. M2
> is still held by loaded P3.
>
> Now, M2.used_allocators is empty. P3 is using it, and it is holding
> allocation from allocator A. Both M1 and A are freed.
> When P3 runs now, it can kptr_xchg and try to free it, and the same
> uaf happens again.
> If not that, uaf when M2 is freed and it does unit_free on the alive local kptr.
>
> --
>
> Will this case be covered by your approach? Did I miss something?
>
> The main issue is that this allocator info can be lost depending on
> how you verify a set of programs. It would not be lost if we verified
> in order P2, P1, P3 instead of the current P1, P3, P2.
>
> So we might have to teach the verifier to identify kptr_xchg edges
> between maps, and propagate any used_allocators to the other map? But
> it's becoming too complicated.
>
> You _can_ reject loads of programs when you don't find kptr_offset
> populated on seeing kptr_xchg(..., NULL), but I don't think this is
> practical either. It makes the things sensitive to program
> verification order, which would be confusing for users.

Right. Thanks for brainstorming and coming up with the case
where it breaks.

Let me explain the thought process behind the proposal.
The way the progs will be written will be something like:

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

Even if prog doesn't allocate and only does kptr_xchg like
your P1 and P3 do the C code has to have a full
definition 'struct foo' to compile P1 and P3.
P1 and P3 don't need to see definition of 'ma' to be compiled,
but 'struct foo' has to be seen.
BTF reference will be taken by both 'ma' and by 'hash'.
The btf_id will come from that BTF.

The type is tied to BTF and tied to kptr in map value.
The type is also tied to the allocator.
The type creates a dependency chain between allocator and map.
So the restriction of one allocator per kptr feels
reasonable and doesn't feel restrictive at all.
That dependency chain is there in the C code of the program.
Hence the proposal to discover this dependency in the verifier
through tracking of allocator from mem_alloc into kptr_xchg.
But you're correct that it's not working for P1 and P3.

I can imagine a few ways to solve it.
1. Ask users to annotate kptr local with the allocator
that will be used.
It's easy for progs P1 and P3. All definitions are likely available.
It's only an extra tag of some form.

2. move 'used_allocator' from map further into BTF,
  since BTF is the root of this dependency chain.
When the verifier sees bpf_mem_alloc in P2 it will add
{allocator, btf_id} pair to BTF.

If P1 loads first and the verifier see:
p = kptr_xchg(M1.value, NULL);
it will add {unique_allocator_placeholder, btf_id} to BTF.
Then
kptr_xchg(M2.value, p); does nothing.
The verifier checks that M1's BTF == M2's BTF and id-s are same.

Then P3 loads with:
p = kptr_xchg(M2.value, NULL);
unit_free(p);
since unique_allocator_placholder is already there for that btf_id
the verifier does nothing.

Eventually it will see bpf_mem_alloc for that btf_id and will
replace the placeholder with the actual allocator.
We can even allow P1 and P3 to be runnable after load right away.
Since nothing can allocate into that kptr local those
kptr_xchg() in P1 and P3 will be returning NULL.
If P2 with bpf_mem_alloc never loads it's fine. Not a safety issue.

Ideally for unit_free(p); in P3 the verifier would add a hidden
'ma' argument, so that allocator doesn't need to be stored dynamically.
We can either insns of P3 after P2 was verified or
pass a pointer to a place in BTF->used_allocator list of pairs
where actual allocator pointer will be written later.
Then no patching is needed.
If P2 never loads the unit_free(*addr /* here it will load the
value of unique_allocator_placeholder */, ...)
but since unit_free() will never execute with valid obj to be freed.

"At map free time walk all elements and free kptrs" step stays the same.
but we decrement allocator refcnt only when BTF is freed
which should be after map free time.
So btf_put(map->btf); would need to move after ops->map_free.

Maybe unique_allocator_placeholder approach can be used
without moving the list into BTF. Need to think more about it tomorrow.
