Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA55A56C1
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiH2WH4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH2WHz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:07:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8763422DD
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:07:53 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id d15so5259264ilf.0
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MR7AVse1zjWwgFJLzuKASsTlcTaSaFEfD2lnhZ83pf0=;
        b=D8Y0CIG9/3sJiolzW0yHmReY2jPCdC9vHVxb0wifDnXnq5zoCkD9TDIY8db4aZPbPX
         rNPRGqDIZWu7W82GkmJ5uRwOqwZiB/zzTtqtpTWkVccCJ6AXFkZ6uM0PYc535RFg7DXZ
         kyi9aPrGCwZg4ns2cmOuL8qKli90u1Lq71FFDl0DuY/LQ5p4ELTt1xN8o6sw98KSc4bc
         4diiiNOLdGmTv+JveCtIaq5iMDWHHt8pKC2qBh/p1mybwF7iesMToICGsCD0EbwlSV23
         yXYYrrwZ5PoltB9m2Sk7TjsuL8gBlC4ZEpEuVk78mxGGEOrDuQfQUYBjn9gwSh/PL1AV
         +Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MR7AVse1zjWwgFJLzuKASsTlcTaSaFEfD2lnhZ83pf0=;
        b=TiL4JcpAHVdzNxINpvE2L9l8Au1PQQrnISONFtt7XWT6NHvsrMkgwUc7gE8Nf3QqoL
         Y7Jg9/DtyA9+q7c+brl5nmyqXo760zOHyiq2irP5sozdPL481n/6x3x1uZuYeFhJaviy
         byygHgfm0Bw9l0pkoojssWmrU6QaxFQneX8rsr4DJc15zDc/vhCc+xIB31mUy5JOJxNo
         G9YTkTuLL7XfeRnaF4+vxAVPi8oR3mjZ4wOgloVQmNlQL4MvGxaY0QTRXHsAYbSVSk8B
         YgDd2QURepDatRqOr9dhj1Xlb4w8/jlS6LNpoPPM+5YUbQi2bbfVvir4j/G9WbK/s65G
         uEuA==
X-Gm-Message-State: ACgBeo0evvBUNXsdWT8LzHAGmTRgn2fdfBJd2n9PaW+TQt7Lf8bZ3b8O
        zO8MmmtPob2N9EdYhoPFve8CnsOLa2m0tJhSHUQ3Co1v
X-Google-Smtp-Source: AA6agR4J2XWpzbXtMw2Qc6IohzAaD1rmDwKOyaMlx+rj96OrIPwtHVuoo5FprUj6dxJAciDq+67tf8kG+8uh9IZSCfc=
X-Received: by 2002:a05:6e02:168d:b0:2ea:f6b7:d954 with SMTP id
 f13-20020a056e02168d00b002eaf6b7d954mr4234755ila.216.1661810873013; Mon, 29
 Aug 2022 15:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com>
In-Reply-To: <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 30 Aug 2022 00:07:17 +0200
Message-ID: <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
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

On Mon, 29 Aug 2022 at 23:29, Delyan Kratunov <delyank@fb.com> wrote:
>
> Thanks for taking a look, Kumar!
>
> On Fri, 2022-08-26 at 06:03 +0200, Kumar Kartikeya Dwivedi wrote:
> > >
> > > On Thu, 25 Aug 2022 at 02:56, Delyan Kratunov <delyank@fb.com> wrote:
> > > > >
> > > > > Alexei and I spent some time today going back and forth on what the uapi to this
> > > > > allocator should look like in a BPF program. To both of our surprise, the problem
> > > > > space became far more complicated than we anticipated.
> > > > >
> > > > > There are three primary problems we have to solve:
> > > > > 1) Knowing which allocator an object came from, so we can safely reclaim it when
> > > > > necessary (e.g., freeing a map).
> > > > > 2) Type confusion between local and kernel types. (I.e., a program allocating kernel
> > > > > types and passing them to helpers/kfuncs that don't expect them). This is especially
> > > > > important because the existing kptr mechanism assumes kernel types everywhere.
> > >
> > > Why is the btf_is_kernel(reg->btf) check not enough to distinguish
> > > local vs kernel kptr?
>
> Answered below.
>
> > > We add that wherever kfunc/helpers verify the PTR_TO_BTF_ID right now.
> > >
> > > Fun fact: I added a similar check on purpose in map_kptr_match_type,
> > > since Alexei mentioned back then he was working on a local type
> > > allocator, so forgetting to add it later would have been a problem.
> > >
> > > > > 3) Allocated objects lifetimes, allocator refcounting, etc. It all gets very hairy
> > > > > when you allow allocated objects in pinned maps.
> > > > >
> > > > > This is the proposed design that we landed on:
> > > > >
> > > > > 1. Allocators get their own MAP_TYPE_ALLOCATOR, so you can specify initial capacity
> > > > > at creation time. Value_size > 0 takes the kmem_cache path. Probably with
> > > > > btf_value_type_id enforcement for the kmem_cache path.
> > > > >
> > > > > 2. The helper APIs are just bpf_obj_alloc(bpf_map *, bpf_core_type_id_local(struct
> > > > > foo)) and bpf_obj_free(void *). Note that obj_free() only takes an object pointer.
> > > > >
> > > > > 3. To avoid mixing BTF type domains, a new type tag (provisionally __kptr_local)
> > > > > annotates fields that can hold values with verifier type `PTR_TO_BTF_ID |
> > > > > BTF_ID_LOCAL`. obj_alloc only ever returns these local kptrs and only ever resolves
> > > > > against program-local btf (in the verifier, at runtime it only gets an allocation
> > > > > size).
> > >
> > > This is ok too, but I think just gating everywhere with btf_is_kernel
> > > would be fine as well.
>
>
> Yeah, I can get behind not using BTF_LOCAL_ID as a type flag and just encoding that
> in the btf field of the register/stack slot/kptr/helper proto. That said, we still
> need the new type tag to tell the map btf parsing code to use the local btf in the
> kptr descriptor.
>

Agreed, the new __local type tag looks necessary to make it search in
map BTF instead.

> > >
> > > > > 3.1. If eventually we need to pass these objects to kfuncs/helpers, we can introduce
> > > > > a new bpf_obj_export helper that takes a PTR_TO_LOCAL_BTF_ID and returns the
> > > > > corresponding PTR_TO_BTF_ID, after verifying against an allowlist of some kind. This
> > >
> > > It would be fine to allow passing if it is just plain data (e.g. what
> > > scalar_struct check does for kfuncs).
> > > There we had the issue where it can take PTR_TO_MEM, PTR_TO_BTF_ID,
> > > etc. so it was necessary to restrict the kind of type to LCD.
> > >
> > > But we don't have to do it from day 1, just listing what should be ok.
>
> That's a good call, I'll add it to the initial can-transition-to-kernel-kptr logic.
>
> > >
> > > > > would be the only place these objects can leak out of bpf land. If there's no runtime
> > > > > aspect (and there likely wouldn't be), we might consider doing this transparently,
> > > > > still against an allowlist of types.
> > > > >
> > > > > 4. To ensure the allocator stays alive while objects from it are alive, we must be
> > > > > able to identify which allocator each __kptr_local pointer came from, and we must
> > > > > keep the refcount up while any such values are alive. One concern here is that doing
> > > > > the refcount manipulation in kptr_xchg would be too expensive. The proposed solution
> > > > > is to:
> > > > > 4.1 Keep a struct bpf_mem_alloc* in the header before the returned object pointer
> > > > > from bpf_mem_alloc(). This way we never lose track which bpf_mem_alloc to return the
> > > > > object to and can simplify the bpf_obj_free() call.
> > > > > 4.2. Tracking used_allocators in each bpf_map. When unloading a program, we would
> > > > > walk all maps that the program has access to (that have kptr_local fields), walk each
> > > > > value and ensure that any allocators not already in the map's used_allocators are
> > > > > refcount_inc'd and added to the list. Do note that allocators are also kept alive by
> > > > > their bpf_map wrapper but after that's gone, used_allocators is the main mechanism.
> > > > > Once the bpf_map is gone, the allocator cannot be used to allocate new objects, we
> > > > > can only return objects to it.
> > > > > 4.3. On map free, we walk and obj_free() all the __kptr_local fields, then
> > > > > refcount_dec all the used_allocators.
> > > > >
> > >
> > > So to summarize your approach:
> > > Each allocation has a bpf_mem_alloc pointer before it to track its
> > > owner allocator.
> > > We know used_maps of each prog, so during unload of program, walk all
> > > local kptrs in each used_maps map values, and that map takes a
> > > reference to the allocator stashing it in used_allocators list,
> > > because prog is going to relinquish its ref to allocator_map (which if
> > > it were the last one would release allocator reference as well for
> > > local kptrs held by those maps).
> > > Once prog is gone, the allocator is kept alive by other maps holding
> > > objects allocated from it. References to the allocator are taken
> > > lazily when required.
> > > Did I get it right?
>
> That's correct!
>
> > >
> > > I see two problems: the first is concurrency. When walking each value,
> > > it is going to be hard to ensure the kptr field remains stable while
> > > you load and take ref to its allocator. Some other programs may also
> > > have access to the map value and may concurrently change the kptr
> > > field (xchg and even release it). How do we safely do a refcount_inc
> > > of its allocator?
>
> Fair question. You can think of that pointer as immutable for the entire time that
> the allocator is able to interact with the object. Once the object makes it on a
> freelist, it won't be released until an rcu gp has elapsed. Therefore, the first time
> that value can change - when we return the object to the global kmalloc pool - it has
> provably no bpf-side concurrent observers.
>

I don't think that assumption will hold. Requiring RCU protection for
all local kptrs means allocator cache reuse becomes harder, as
elements are stuck in freelist until the next grace period. It
necessitates use of larger caches.
For some use cases where they can tolerate reuse, it might not be
optimal. IMO the allocator should be independent of how the lifetime
of elements is managed.

That said, even if you assume RCU protection, that still doesn't
address the real problem. Yes, you can access the value without
worrying about it moving to another map, but consider this case:
Prog unloading,
populate_used_allocators -> map walks map_values, tries to take
reference to local kptr whose backing allocator is A.
Loads kptr, meanwhile some other prog sharing access to the map value
exchanges (kptr_xchg) another pointer into that field.
Now you take reference to allocator A in used_allocators, while actual
value in map is for allocator B.

So you either have to cmpxchg and then retry if it fails (which is not
a wait-free operation, and honestly not great imo), or if you don't
handle this:
Someone moved an allocated local kptr backed by B into your map, but
you don't hold reference to it. That other program may release
allocator map -> allocator, and then when this map is destroyed, on
unit_free it will be use-after-free of bpf_mem_alloc *.

I don't see an easy way around these kinds of problems. And this is
just one specific scenario.

> Alexei, please correct me if I misunderstood how the design is supposed to work.
>
> > >
> > > For the second problem, consider this:
> > > obj = bpf_obj_alloc(&alloc_map, ...);
> > > inner_map = bpf_map_lookup_elem(&map_in_map, ...);
> > > map_val = bpf_map_lookup_elem(inner_map, ...);
> > > kptr_xchg(&map_val->kptr, obj);
> > >
> > > Now delete the entry having that inner_map, but keep its fd open.
> > > Unload the program, since it is map-in-map, no way to fill used_allocators.
> > > alloc_map is freed, releases reference on allocator, allocator is freed.
> > > Now close(inner_map_fd), inner_map is free. Either bad unit_free or memory leak.
> > > Is there a way to prevent this in your scheme?
>
> This is fair, inner maps not being tracked in used_maps is a wrench in that plan.
> However, we can have the parent map propagate its used_allocators on inner map
> removal.
>

But used_allocators are not populated until unload? inner_map removal
can happen while the program is loaded/attached.
Or will you populate it before unloading, everytime during inner_map
removal? Then that would be very costly for a bpf_map_delete_elem...

> > > -
> > >
> > > I had another idea, but it's not _completely_ 0 overhead. Heavy
> > > prototyping so I might be missing corner cases.
> > > It is to take reference on each allocation and deallocation. Yes,
> > > naive and slow if using atomics, but instead we can use percpu_ref
> > > instead of atomic refcount for the allocator. percpu_ref_get/put on
> > > each unit_alloc/unit_free.
> > > The problem though is that once initial reference is killed, it
> > > downgrades to atomic, which will kill performance. So we need to be
> > > smart about how that initial reference is managed.
> > > My idea is that the initial ref is taken and killed by the allocator
> > > bpf_map pinning the allocator. Once that bpf_map is gone, you cannot
> > > do any more allocations anyway (since you need to pass the map pointer
> > > to bpf_obj_alloc), so once it downgrades to atomics at that point we
> > > will only be releasing the references after freeing its allocated
> > > objects. Yes, then the free path becomes a bit costly after the
> > > allocator map is gone.
> > >
> > > We might be able to remove the cost on free path as well using the
> > > used_allocators scheme from above (to delay percpu_ref_kill), but it
> > > is not clear how to safely increment the ref of the allocator from map
> > > value...
>
> As explained above, the values are already rcu-protected, so we can use that to
> coordinate refcounting of the allocator. That said, percpu_ref could work (I was
> considering something similar within the allocator itself) but I'm not convinced the
> cost is right. My main concern would be that once it becomes atomic_t, it erases the
> benefits of all the work in the allocator that maintains percpu data structures.
>
> If we want to go down this path, the allocator can maintain percpu live counts (with
> underflow for unbalanced alloc-free pairs on a cpu) in its percpu structures. Then,
> we can have explicit "sum up all the counts to discover if you should be destroyed"
> calls. If we keep the used_allocators scheme, these calls can be inserted at program
> unload for maps in used_maps and at map free time for maps that escape that
> mechanism.

Yes, it would be a good idea to put the percpu refcount for this case
inside the already percpu bpf_mem_cache struct, since that will be
much better than allocating it separately. The increment will then be
a 100% cache hit.

The main question is how this "sum up all the count" operation needs
to be done. Once that initial reference of bpf_map is gone, you need
to track the final owner who will be responsible to release the
allocator. You will need to do something similar to percpu_ref's
atomic count upgrade unless I'm missing something.

Once you establish that used_allocators cannot be safely populated on
unload (which you can correct me on), the only utility I see for it is
delaying the atomic upgrade for this idea.

So another approach (though I don't like this too much):
One solution to delay the upgrade can be that when you have allocator
maps and other normal maps in used_maps, it always incs ref on the
allocator pinned by allocator map on unload for maps that have local
kptr, so each map having local kptrs speculatively takes ref on
allocator maps of this prog, assuming allocations from that allocator
map are more likely to be in these maps.

Same with other progs having different allocator map but sharing these maps.

It is not very precise, but until those maps are gone it delays
release of the allocator (we can empty all percpu caches to save
memory once bpf_map pinning the allocator is gone, because allocations
are not going to be served). But it allows unit_free to be relatively
less costly as long as those 'candidate' maps are around.



>
> Or, we just extend the map-in-map mechanism to propagate used_allocators as needed.
> There are nice debug properties of the allocator knowing the liveness counts but we
> don't have to put them on the path to correctness.
>
> > >
> > > wdyt?
> > >
> > > > > Overall, we think this handles all the nasty corners - objects escaping into
> > > > > kfuncs/helpers when they shouldn't, pinned maps containing pointers to allocations,
> > > > > programs accessing multiple allocators having deterministic freelist behaviors -
> > > > > while keeping the API and complexity sane. The used_allocators approach can certainly
> > > > > be less conservative (or can be even precise) but for a v1 that's probably overkill.
> > > > >
> > > > > Please, feel free to shoot holes in this design! We tried to capture everything but
> > > > > I'd love confirmation that we didn't miss anything.
> > > > >
> > > > > --Delyan
>
>
