Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6935A1F9D
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 06:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbiHZEEI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbiHZEEI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 00:04:08 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D23A1A78
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 21:04:06 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-11c5505dba2so634634fac.13
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 21:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SGK5ZlWM9b6qYmqhXgGoTObxhcpjAzjA6xu2vbvNzqE=;
        b=UWqfkndplOFof4e6snuSaWT+543Kt9prIaFWJwUSH3UJSwvSCVqTJJvXzxvz2SiNvQ
         Bq/Rb7sGF9R0bBUU++inHNBs2v7EiHsqqkRrZcaLhA8JS6S4bxx+fn984Y0G+a1cYZ/u
         43QnsxnJY1vcC/D7fxHfFnMHGixloX+WF+dRhp8//UMfSNlw3f4W54g4bnI+uKo0oF2t
         yLT1FWNetB+fJwSaPd4p0mEvC81ndP04MJz/lx3hSaKzEZqpZSByXbTcFZ8AZOG/GYyy
         75WIup8qewB0ENMlviy/x2c4teFym7eOwgUJH6RBqZCn3jPIgL3M41MPhWxp87C1j3hA
         0YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SGK5ZlWM9b6qYmqhXgGoTObxhcpjAzjA6xu2vbvNzqE=;
        b=2bR4s44p24xFgURTPQhMN35ZLeYroHC2D+TRrSEtdhmp3S8YJRMPnGhIdOP0Q70TTn
         +VAV1+MEA1RWHr8UwcCy+Q3f1XNTJOVu1MST+HI9EruNmpSIWRnU4HxbH5nC71P97+F5
         cS8FJqlP6sd8MgYNuJBbmZ/Id7KP4ud1Ki/IJWCH1gMyVYp8YatfO4gf6TCHBsNzre+P
         uw3/sV3fawJejxzIRIBHUaRkKqitU9DRMbLQFjCS1ZD0vGGhI9bXwTNOCcpZHTArLjsY
         koilz9AMBBBLKMBdZp5CgWPMlM5qgRDBo9aWr4gHuJz/JAMTcVSYxm2/as9RfCTglX6B
         39wg==
X-Gm-Message-State: ACgBeo2ZNP+WNRIemzSAErshzlFqQVmdF6VjRHsJVp5w5mfhDvkCffek
        lrLQKNfjO5Wyl6KunSMgYGp39XmuEpC1GmnedbA=
X-Google-Smtp-Source: AA6agR7pLHTfldeXNwLfE+rVeL7/pSV0Fs2jtcKp7LO9QzN3zhf2Ll3z+uBsadyKuiH0WLQ9xYOjs12o64hQL5KlEwM=
X-Received: by 2002:a05:6870:fb9f:b0:11d:6525:6746 with SMTP id
 kv31-20020a056870fb9f00b0011d65256746mr1050988oab.28.1661486645716; Thu, 25
 Aug 2022 21:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com> <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com>
In-Reply-To: <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 26 Aug 2022 06:03:29 +0200
Message-ID: <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
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

On Thu, 25 Aug 2022 at 02:56, Delyan Kratunov <delyank@fb.com> wrote:
>
> Alexei and I spent some time today going back and forth on what the uapi to this
> allocator should look like in a BPF program. To both of our surprise, the problem
> space became far more complicated than we anticipated.
>
> There are three primary problems we have to solve:
> 1) Knowing which allocator an object came from, so we can safely reclaim it when
> necessary (e.g., freeing a map).
> 2) Type confusion between local and kernel types. (I.e., a program allocating kernel
> types and passing them to helpers/kfuncs that don't expect them). This is especially
> important because the existing kptr mechanism assumes kernel types everywhere.

Why is the btf_is_kernel(reg->btf) check not enough to distinguish
local vs kernel kptr?
We add that wherever kfunc/helpers verify the PTR_TO_BTF_ID right now.

Fun fact: I added a similar check on purpose in map_kptr_match_type,
since Alexei mentioned back then he was working on a local type
allocator, so forgetting to add it later would have been a problem.

> 3) Allocated objects lifetimes, allocator refcounting, etc. It all gets very hairy
> when you allow allocated objects in pinned maps.
>
> This is the proposed design that we landed on:
>
> 1. Allocators get their own MAP_TYPE_ALLOCATOR, so you can specify initial capacity
> at creation time. Value_size > 0 takes the kmem_cache path. Probably with
> btf_value_type_id enforcement for the kmem_cache path.
>
> 2. The helper APIs are just bpf_obj_alloc(bpf_map *, bpf_core_type_id_local(struct
> foo)) and bpf_obj_free(void *). Note that obj_free() only takes an object pointer.
>
> 3. To avoid mixing BTF type domains, a new type tag (provisionally __kptr_local)
> annotates fields that can hold values with verifier type `PTR_TO_BTF_ID |
> BTF_ID_LOCAL`. obj_alloc only ever returns these local kptrs and only ever resolves
> against program-local btf (in the verifier, at runtime it only gets an allocation
> size).

This is ok too, but I think just gating everywhere with btf_is_kernel
would be fine as well.

> 3.1. If eventually we need to pass these objects to kfuncs/helpers, we can introduce
> a new bpf_obj_export helper that takes a PTR_TO_LOCAL_BTF_ID and returns the
> corresponding PTR_TO_BTF_ID, after verifying against an allowlist of some kind. This

It would be fine to allow passing if it is just plain data (e.g. what
scalar_struct check does for kfuncs).
There we had the issue where it can take PTR_TO_MEM, PTR_TO_BTF_ID,
etc. so it was necessary to restrict the kind of type to LCD.

But we don't have to do it from day 1, just listing what should be ok.

> would be the only place these objects can leak out of bpf land. If there's no runtime
> aspect (and there likely wouldn't be), we might consider doing this transparently,
> still against an allowlist of types.
>
> 4. To ensure the allocator stays alive while objects from it are alive, we must be
> able to identify which allocator each __kptr_local pointer came from, and we must
> keep the refcount up while any such values are alive. One concern here is that doing
> the refcount manipulation in kptr_xchg would be too expensive. The proposed solution
> is to:
> 4.1 Keep a struct bpf_mem_alloc* in the header before the returned object pointer
> from bpf_mem_alloc(). This way we never lose track which bpf_mem_alloc to return the
> object to and can simplify the bpf_obj_free() call.
> 4.2. Tracking used_allocators in each bpf_map. When unloading a program, we would
> walk all maps that the program has access to (that have kptr_local fields), walk each
> value and ensure that any allocators not already in the map's used_allocators are
> refcount_inc'd and added to the list. Do note that allocators are also kept alive by
> their bpf_map wrapper but after that's gone, used_allocators is the main mechanism.
> Once the bpf_map is gone, the allocator cannot be used to allocate new objects, we
> can only return objects to it.
> 4.3. On map free, we walk and obj_free() all the __kptr_local fields, then
> refcount_dec all the used_allocators.
>

So to summarize your approach:
Each allocation has a bpf_mem_alloc pointer before it to track its
owner allocator.
We know used_maps of each prog, so during unload of program, walk all
local kptrs in each used_maps map values, and that map takes a
reference to the allocator stashing it in used_allocators list,
because prog is going to relinquish its ref to allocator_map (which if
it were the last one would release allocator reference as well for
local kptrs held by those maps).
Once prog is gone, the allocator is kept alive by other maps holding
objects allocated from it. References to the allocator are taken
lazily when required.
Did I get it right?

I see two problems: the first is concurrency. When walking each value,
it is going to be hard to ensure the kptr field remains stable while
you load and take ref to its allocator. Some other programs may also
have access to the map value and may concurrently change the kptr
field (xchg and even release it). How do we safely do a refcount_inc
of its allocator?

For the second problem, consider this:
obj = bpf_obj_alloc(&alloc_map, ...);
inner_map = bpf_map_lookup_elem(&map_in_map, ...);
map_val = bpf_map_lookup_elem(inner_map, ...);
kptr_xchg(&map_val->kptr, obj);

Now delete the entry having that inner_map, but keep its fd open.
Unload the program, since it is map-in-map, no way to fill used_allocators.
alloc_map is freed, releases reference on allocator, allocator is freed.
Now close(inner_map_fd), inner_map is free. Either bad unit_free or memory leak.
Is there a way to prevent this in your scheme?

--

I had another idea, but it's not _completely_ 0 overhead. Heavy
prototyping so I might be missing corner cases.
It is to take reference on each allocation and deallocation. Yes,
naive and slow if using atomics, but instead we can use percpu_ref
instead of atomic refcount for the allocator. percpu_ref_get/put on
each unit_alloc/unit_free.
The problem though is that once initial reference is killed, it
downgrades to atomic, which will kill performance. So we need to be
smart about how that initial reference is managed.
My idea is that the initial ref is taken and killed by the allocator
bpf_map pinning the allocator. Once that bpf_map is gone, you cannot
do any more allocations anyway (since you need to pass the map pointer
to bpf_obj_alloc), so once it downgrades to atomics at that point we
will only be releasing the references after freeing its allocated
objects. Yes, then the free path becomes a bit costly after the
allocator map is gone.

We might be able to remove the cost on free path as well using the
used_allocators scheme from above (to delay percpu_ref_kill), but it
is not clear how to safely increment the ref of the allocator from map
value...

wdyt?

> Overall, we think this handles all the nasty corners - objects escaping into
> kfuncs/helpers when they shouldn't, pinned maps containing pointers to allocations,
> programs accessing multiple allocators having deterministic freelist behaviors -
> while keeping the API and complexity sane. The used_allocators approach can certainly
> be less conservative (or can be even precise) but for a v1 that's probably overkill.
>
> Please, feel free to shoot holes in this design! We tried to capture everything but
> I'd love confirmation that we didn't miss anything.
>
> --Delyan
