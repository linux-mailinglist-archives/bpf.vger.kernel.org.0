Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2359A5EE
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349680AbiHSTDr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbiHSTDo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 15:03:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDBE2DAAE
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 12:03:38 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 73so4366806pgb.9
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=ZcDJuCXsuFF/4vXqRGd8LTIef9rnrxnwgWgTmTXI9h8=;
        b=GX4AclTp40ZT23ESrVydcjoJfC/UtN1ugoDzzDycQlNGdrpqyNBWOuh3joMZM5GlGg
         olY6nlwCQrAgCG34JNXM6XGFPDIzHxlZCepqDtNIcBnKn0ox07mUnC7T30uJTBnRZ58n
         E8AROAJek3AAJR6K9fksn1wi/ta59zzRuPGVelgYV+zwj9XCXirq1VgRp6r39aFFjg3f
         eA238MXsIsWec+B/WBk45qWywPcOecBdRu/0Ro8QJ85SR26WS0X0G19HzcdWpy2faHon
         Xm/UFPqQL07jAVTw6V9ECZPD+L3433z6/OUS84P7HrrEzUd5PenFBDhtXnARQuqXj3t4
         UiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=ZcDJuCXsuFF/4vXqRGd8LTIef9rnrxnwgWgTmTXI9h8=;
        b=AjnhxdzNtAGuLLrYjv1Q8mR3lodYvOyWTUQFnVNgGgRU31QCOpjcOLxi1NzjeGANE+
         Q1B6NwfVP22Fp/YEVHDQl5W9lfc+jcdQCRHNfKsdx5GKeIcgcfl5bv/WUkb/jKgNUs7c
         Du+u9yAq1r9yP8IVdxn4Nm71KPz38WvA151SL+lCZ/O/99UpyWi7qq5KDgJrvYXO3TKR
         UFZQBen518xbq8dyGQleG+m4izLcWvyF1bUeyNcDNue3oK+IvAsPJwqtajrxV9ZLCHu3
         LNMwraSp+jPKWgGbAtPCvbi69PJvajJU+VZDPFqvnWUOtUkHb9H4p+wqK8M9FxE+63J2
         XTcA==
X-Gm-Message-State: ACgBeo2Wh9KCUBC1ZhO2pIGtxFQK49WstafpOHEERSvnyy9ZXbKWR9sF
        Vg0f2WCH44SZ51ifuJnvUepVESvwLSU=
X-Google-Smtp-Source: AA6agR5B6qX2F6cFiI4Wv3aAkM/xr3ujBUc3CDuwSUkmb+sylxC3tKbnyjWDg5w/+8jrWleiZH5Ipg==
X-Received: by 2002:a63:ed52:0:b0:429:8f3f:e025 with SMTP id m18-20020a63ed52000000b004298f3fe025mr7614275pgk.50.1660935817790;
        Fri, 19 Aug 2022 12:03:37 -0700 (PDT)
Received: from MacBook-Pro-3.local.dhcp.thefacebook.com ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id d135-20020a621d8d000000b0052d4b0d0c74sm3787609pfd.70.2022.08.19.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:03:37 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:03:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Subject: Re: BPF Linked Lists discussion
Message-ID: <20220819190334.gmu6ewdumam4ggzi@MacBook-Pro-3.local.dhcp.thefacebook.com>
References: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
 <232c8439-4e34-f89c-bc97-c3a445a15ac4@fb.com>
 <CAP01T77PBfQ8QvgU-ezxGgUh8WmSYL3wsMT7yo4tGuZRW0qLnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T77PBfQ8QvgU-ezxGgUh8WmSYL3wsMT7yo4tGuZRW0qLnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 19, 2022 at 06:00:22PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, 19 Aug 2022 at 10:55, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > Hi Kumar,
> >
> > Alexei and I talked about locking and a few other things today in regards to my
> > rbtree work. Some of this isn't a direct response to your ideas/notes here,
> > but hoping to summarize today's discussion inline with your code samples and
> > get your opinion.
> >
> > Also, some inline comments more directly addressing your notes.
> 
> Hi Dave, thanks for sharing the notes.
> 
> >
> > On 8/17/22 5:04 AM, Kumar Kartikeya Dwivedi wrote:
> > > Alexei and I had a meeting where we discussed some of my ideas related
> > > to BPF linked lists. I am sharing the discussion with everyone to get
> > > wider feedback, and document what we discussed.
> > >
> > > The hard stuff is the shared ownership case, hence we can discuss this
> > > while we work on landing single ownership lists. I will be sharing my
> > > patches for that as an RFC.
> > >
> > > 1. Definition
> > >
> > > We can use BTF declaration tags to annotate a common structure like
> > > struct bpf_list_head, struct bpf_rb_root, etc.
> > >
> > > #define __value(kind, name, node) __attribute__((btf_decl_tag(#kind
> > > ":" #name ":" #node))
> > >
> > > struct foo {
> > >     unsigned long data;
> > >     struct bpf_list_node node;
> > > };
> > >
> > > struct map_value {
> > >     struct bpf_spin_lock lock;
> > >     struct bpf_list_head head __value(struct, foo, node);
> > > };
> > >
> > > This allows us to parameterize any kind of intrusive collection.
> > >
> > > For the map-in-map use case:
> > >
> > > struct bar {
> > >     unsigned long data;
> > >     struct bpf_list_node node;
> > > };
> > > // Only two levels of types allowed, to ensure no cycles, and to
> > > prevent ownership cycles
> > > struct foo {
> > >     unsigned long data;
> > >     struct bpf_spin_lock lock;
> > >     struct bpf_list_node node;
> > >     struct bpf_list_head head __value(struct, bar, node);
> > > };
> > >
> > > struct map_value {
> > >     struct bpf_spin_lock lock;
> > >     struct bpf_list_head head __value(struct, foo, node);
> > > };
> > >
> >
> > Will these still be 'bpf maps' under the hood? If the list were to use
> 
> Nope, my idea was to get rid of maps for intrusive collections, and
> you always put bpf_list_head, bpf_rb_root in a map value. For global
> map-like use cases, you instead use global variables, which are also
> inside the map value of a BPF_MAP_TYPE_ARRAY. IMO there is no need
> anymore to add more and more map types with this new style of data
> structures. It is much more ergonomic to just use the head structure,
> either as a global variable, or as an allocated object, but again,
> that's my opinion. There will be some pros and cons for either
> approach :).

+1
If we can avoid adding new map types and instead recognize 'struct bpf_list_head'
and 'struct bpf_rb_root' in global data and in map values that
would be the best.
The code would look the most natural to developers familiar with the kernel code.

> I am aware of the problem with global bpf_spin_lock (thanks to Alexei
> for spotting it), but as you described it can be solved by moving them
> into a different section.
> 
> > convention similar to the rbtree RFC, the first (non map-in-map) def could be
> > written like:
> >
> > struct foo {
> >     unsigned long data;
> >     struct bpf_list_node node;
> > };
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_LINKED_LIST);
> >     __type(value, struct foo);
> > } list SEC(".maps");
> >
> > I think we're thinking along similar lines with regards to the BTF tag, but I
> > was thinking of tagging the value type instead of the container, something like:
> >
> > struct foo {
> >     unsigned long data;
> >     struct bpf_list_node node __protected_list_node;
> > };
> >
> > 'protected' meaning verifier knows to prevent prog from touching the
> > bpf_list_node. Currently my rbtree RFCv1 is just assuming that value type will
> > have rb_node at offset 0. BTF tag would eliminate this offset requirement
> > and allow value types to be part of multiple data structures:
> >
> > struct foo {
> >     unsigned long data;
> >     struct bpf_list_node node __protected_list_node;
> >     struct bpf_rb_node rb_node __protected_rb_node;
> > };

I'm not sure what '__protected_rb_node' tag buys here.
The verifier can infer the same from 'struct bpf_rb_node' type name.

> >
> > Not a hard requirement for me, but nice-to-have: support for heterogenous value
> > types in same list / rbtree. Map def's __type(value, struct foo) wouldn't work
> > in this case, I think your __value(struct, foo, node) would have same issue.

I thought Kumar's proposal to do:
  struct bpf_list_head head __value(struct, foo, node);
was to tell the verifier how to do iterate link list with appropriate container_of().

Same tagging is needed for:
  struct bpf_rb_root tree __value(struct, foo, node)
to tell bpf_rb_find(key, tree, cmp_cb) what btf_id to return
and how to container_of() from rb_node to bpf program supplied struct to
pass that btf_id pointer into cmb_cb.

> >
> > But I think this should be possible with BTF tags somehow. List
> > helpers are ostensibly only touching the list_{head,node} - and similar for
> > rbtree, and we're both planning on explicit in-prog typed allocation.
> > If type can be propagated from alloc -> reg state -> helper input ->
> > helper output, helpers could use reg BTF info w/ properly tagged field
> > to manipulate the right field in the value struct.
> 
> We can have multiple __value on a list_head and add some way to
> disambiguate what the type will be on list_remove. The problem is not
> during list_add, as you know the type of the node being added. It is
> when you list_remove, is when you need to be able to disambiguate the
> type so that we set the reg as correct btf, btf_id and then set the
> right reg->off (so that container_of can give the entry). Until the
> disambiguation step is done, it is unknown what the type might be.

list_remove and list iterate/find need that btf_id.

> When thinking of heterogeneous values, we should probably look to add
> a way to do generic variant types in BPF, such that e.g. the first
> field is a tag, and then the actual data of that type follows. This
> would allow us to use them not only in intrusive collections, but
> anywhere else, and probably even store them in map values as kptrs.

Not following this idea. Could you give an example?

> 
> I think it is much simpler to start with homogenous types first, though.
> 
> >
> > In that case the tag would have to be on the value struct's field, not the
> > container. I do like that your __value(struct, foo, node) is teaching the
> > container what named field to manipulate. If value struct were to be part of
> > two lists this would make it possible to disambiguate.
> >
> > When we discussed this Alexei mentioned existing pointer casting helper pattern
> > (e.g. 'bpf_skc_to_tcp_sock') as potentially being helpful here.
> >
> 
> Indeed, but I think you need some bit of info at runtime to be able to do this.
> 
> > > 2. Building Blocks - A type safe allocator
> > >
> > > Add bpf_kptr_alloc, bpf_kptr_free
> > > This will use bpf_mem_alloc infra, allocator maps.
> > > Alexei mentioned that Delyan is working on support for exposing
> > > bpf_mem_alloc using an allocator map.
> > > Allocates referenced PTR_TO_BTF_ID (should we call these local kptr?):
> > > reg->btf == prog->aux->btf
> > > reg->btf_id = bpf_core_type_id_local(...)
> > > btf_struct_access allows writing to these objects.
> > > Due to type visibility, we can embed objects with special semantics
> > > inside these user defined types.
> > > Add a concept of constructing/destructing kptr.
> > > constructing -> normal kptr, escapable -> destructing
> > > In constructing and destructing state, pointer cannot escape the
> > > program. Hence, only one CPU is guaranteed to observe the object in
> > > those states. So when we have access to single ownership kptr, we know
> > > nobody else can access it. Hence we can also move its state from
> > > normal to destructing state.
> > > In case of shared ownership, we will have to rely on the result of
> > > bpf_refcount_put for this to work.
> > >
> > > 3. Embedding special fields inside such allocated kptr
> > >
> > > We must allow programmer to compose their own user defined BPF object
> > > out of building blocks provided by BPF.
> > > BPF users may have certain special objects inside this allocated
> > > object. E.g. bpf_list_node, bpf_spin_lock, even bpf_list_head
> > > (map-in-map use case).
> > > btf_struct_access won’t allow direct reads/writes to these fields.
> > > Each of them needs to be constructed before the object is considered
> > > fully constructed.
> > > An unconstructed object’s kptr cannot escape a program, it can only be
> > > destructed and freed.
> > > This has multiple advantages. We can add fields which have complex
> > > initialization requirements.
> > > This also allows safe recycling of memory without having to do zero
> > > init or inserting constructor calls automatically from verifier.
> > > Allows constructors to have parameters in future, also allows complex
> > > multi-step initialization of fields in future.
> > >
> >
> > I don't fully understand "shared ownership" from 2) and don't have a use case
> 
> Shared ownership is explained further later in section 5.
> 
> > for complex constructors in 3), but broadly agree with everything else. Will
> > do another pass.
> >
> > > 4. Single Ownership Linked Lists
> > >
> > > The kptr has single ownership.
> > > Program has to release it before BPF_EXIT, either free or move it out
> > > of program.
> > > Once passed to list, the program loses ownership.
> > > But BPF can track that until spin_lock is released, nobody else can
> > > touch it, so we can technically still list_remove a node we added
> > > using list_add, and then we will be owning it after unlock.
> > > list_add marks reference_state as ‘release_on_unlock’
> > > list_remove unmark reference_state
> > > Alexei: Similar to Dave’s approach, but different implementation.
> > > bpf_spin_unlock walks acquired_refs and release_reference marked ones.
> > > No other function calls allows in critical section, hence
> > > reference_state remains same.
> > >
> > > ----------
> > >
> > > 5. Shared Ownership
> > >
> > > Idea: Add bpf_refcount as special field embeddable in allocated kptrs.
> > > bpf_refcount_set(const), bpf_refcount_inc(const), bpf_refcount_put(ptr).
> > > If combined with RCU, can allow safe kptr_get operations for such objects.
> > > Each rb_root, list_head requires ownership of node.
> > > Caller will transfer its reference to them.
> > > If having only a single reference, do inc before transfer.
> > > It is a generic concept, and can apply to kernel types as well.
> > > When linking after allocation, it is extremely cheap to set, add, add, add…
> > >
> > > We add ‘static_ref’ to each reference_state to track incs/decs
> > > acq = static_ref = 1
> > > set  = static_ref = K (must be in [1, …] range)
> > > inc  = static_ref += K
> > > rel/put = static_ref -=  1 (may allow K, dunno)
> > >
> > > Alexei suggested that he prefers if helpers did the increment on their
> > > own in case where the bpf_refcount field exists in the object. I.e.
> > > instead of caller incrementing and then passing their reference to
> > > lists or rbtree, the add helpers receive hidden parameter to refcount
> > > field address automatically and bump the refcount when adding. In that
> > > case, they won't be releasing caller's reference_state.
> > > Then this static_ref code is not required.
> > >
> > > Kartikeya: No strong opinions, this is also another way. One advantage
> > > of managing refcount on caller side and just keeping helpers move only
> > > (regardless of single owner or shared owner kptr) is that helpers
> > > themselves have the same semantics. It always moves ownership of a
> > > reference. Also, one inc(K) and multiple add is a little cheaper than
> > > multiple inc(1) on each add.
> > >
> > > 6. How does the verifier reason about shared kptr we don't know the state of?
> > >
> > > Consider a case where we load a kptr which has shared ownership from a
> > > map using kptr_get.
> > >
> > > Now, it may have a list_node and a rb_node. We don't know whether this
> > > node is already part of some list (so that list_node is occupied),
> > > same for rb_node.
> > >
> > > There can be races like two CPUs having access to the node:
> > >
> > > CPU 0                         CPU 1
> > > lock(&list1_lock)            lock(&list2_lock)
> > > list_add(&node, &list2)
> > >     next.prev = node;
> > >     node.next = next;      list_remove(&node)
> > >                                          node.next = NULL;
> > >                                          node.prev = NULL;
> > >     node.prev = prev;
> > >     prev.next = node;
> > > unlock(&list1_lock);         unlock(&list2_lock);
> > >
> > > Interleavings can leave nodes in inconsistent states.
> > > We need to ensure that when we are doing list_add or list_remove for
> > > kptr we don't know the state of, it is only in a safe context with
> > > ownership of that operation.
> > >
> > > Remove:
> > >
> > > When inside list_for_each helper, list_remove is safe for nodes since
> > > we are protected by lock.
> > >
> > > Idea: An owner field alongside the list_node and rb_node.
> > > list_add sets it to the address of list_head, list_remove sets it to
> > > NULL. This will be done under spinlock of the list.
> > >
> > > When we get access to the object in an unknown state for these fields,
> > > we first lock the list we want to remove it from, check the owner
> > > field, and only remove it when we see that owner matches locked list.
> > >
> > > Each list_add updates owner, list_remove sets to NULL.
> > >     bpf_spin_lock(&lock);
> > >     if (bpf_list_owns_node(&i->node, &list)) { // checks owner
> > > list_remove(&i->node);
> > >     }
> > >     bpf_spin_unlock(&lock);
> > >
> > > bpf_list_owns_node poisons pointer in false branch, so user can only
> > > list_remove in true branch.
> > >
> > > If the owner is not a locked list pointer, it will be either NULL or
> > > some other value (because of previous list_remove while holding same
> > > lock, or list_add while holding some other list lock).
> > > If the owner is our list pointer, we can be sure this is safe, as we
> > > have already locked list.
> > > Otherwise, previous critical section must have modified owner.
> > > So one single load (after inlining this helper) allows unlinking
> > > random kptr we have reference to, safely.
> > >
> > > Cost: 8-bytes per object. Advantages: Prevents bugs like racy
> > > list_remove and double list_add, doesn't need fallible helpers (the
> > > check that would have been inside has to be done by the user now).
> > > Don't need the abort logic.
> > >
> >
> > I agree, keeping track of owner seems necessary. Seems harder to verify
> > statically than lock as well. Alexei mentioned today that combination
> > "grab lock and take ownership" helper for dynamic check might make
> > sense.
> >
> > Tangentially, I've been poking at ergonomics of
> > libbpf lock definition this week and think I have something reasonable:
> >
> > struct node_data {
> >         struct rb_node node;
> >         __u32 one;
> >         __u32 two;
> > };
> >
> > struct l {
> >         __uint(type, BPF_MAP_TYPE_ARRAY);
> >         __type(key, u32);
> >         __type(value, struct bpf_spin_lock);
> >         __uint(max_entries, 1);
> > } lock_arr SEC(".maps");
> >
> > struct {
> >         __uint(type, BPF_MAP_TYPE_RBTREE);
> >         __type(value, struct node_data);
> >         __array(lock, struct l);
> > } rbtree1 SEC(".maps") = {
> >         .lock = {
> >                 [0] = &lock_arr,
> >         },
> > };
> >
> > struct {
> >         __uint(type, BPF_MAP_TYPE_RBTREE);
> >         __type(value, struct node_data);
> >         __array(lock, struct l);
> > } rbtree2 SEC(".maps") = {
> >         .lock = {
> >                 [0] = &lock_arr,
> >         },
> > };
> >
> > ... in BPF prog
> >
> >   bpf_spin_lock(&lock_arr[0]);
> >
> >   // Can safely operate on either tree, move nodes between them, etc.
> >
> >   bpf_spin_unlock(&lock_arr[0]);
> >
> >
> > Notes:
> >   * Verifier knows which lock is supposed to be used at map creation time
> >     * Can reuse bpf_verifier_state's 'active_spin_lock' member, so no addt'l
> >       bookkeeping needed to verify that rbtree_add or similar is happening
> >       in critical section
> 
> Yes, this is similar to my approach, except what I'm doing is (suppose
> we fix the bpf_spin_lock in mmap-able map value problem):

We can teach libbpf to support more than 3 hard coded global maps
(bss, rodata, data). So any named section will go into its own array with max_entries=1
that won't be mmap-able and will allow to host bpf_rb_root, bpf_spin_lock, etc.

> The list_head and lock protecting it are global variables, hence in
> the same map value for the global variable's array map (for now only
> one lock is allowed in a map value, but we may allow some guarded_by
> annotation to associate different locks to different containers).
> Now, you can use the same active_spin_lock infra to track whether I
> hold the one in the same map value as the list_head. More on that
> below.
> 
> >   * Can benefit from relo goodness (e.g. rbtree3 using extern lock in another
> >     file)
> >   * If necessary, similar dynamic verification behavior as just keeping lock
> >     internal
> >   * Implementation similarities with map_of_map 'inner_map'. Similarly to
> >     inner_map_fd, kernel needs to know about lock_map_fd. Can use map_extra for
> >     this to avoid uapi changes
> >
> > Alexei and I discussed possibly allowing raw 'struct bpf_spin_lock' global var,
> > which would require some additional libbpf changes as bpf_spin_lock can't be
> > mmap'd and libbpf tries to mmap all .data maps currently. Perhaps a separate
> > .data.no_mmap section.
> >
> > This ergonomics idea doesn't solve the map-in-map issue, I'm still unsure
> > how to statically verify lock in that case. Have you had a chance to think
> > about it further?
> >
> 
> You rely on the lock being in the same allocation, and manipulation
> done on an object from the same 'lookup'. See below:
> 
> struct foo {
>         struct bpf_spin_lock lock;
>         struct bpf_list_head head __value(...);
> };
> 
> struct map_value {
>         struct foo __local_kptr *ptr;
> };
> 
> struct {
>         __uint(type, BPF_MAP_TYPE_ARRAY);
>         __type(key, int);
>         __type(value, struct map_value);
>         __uint(max_entries, 8);
> } array_of_lists SEC(".maps");
> 
> In my case, the structure is the map, so pointer to the structure
> inside a map makes it map-in-map (now common, the existing map-in-maps
> just hide this from you, so it's pretty much the same thing
> anyway...).
> 
> This is just an example, it can be one more level deep, but anyway.
> 
> When I do a map lookup, there is check in
> verifier.c:reg_may_point_to_spin_lock, this preserves reg->id on NULL
> unmarking.  This reg->id is then remembered when you take lock inside
> this map value, to associate it back to unlock correctly.
> 
> Now, suppose you load the kptr. You know the kptr has a lock, you will
> update this check to also consider local kptr with locks. The reg->id
> is preserved after loaded kptr is NULL checked, but it is unique for
> each load of the kptr. You lock spin_lock in the kptr, you then add to
> list, the list_add verifier check goes and sees whether the current
> lock held and the current list_head come from the same reg->id (you
> know the reg of list_head, right? So you know the id as well, and you
> match that to cur->active_spin_lock_id). If so, it is the correct
> lock, we locked the lock in the same loaded kptr as the one whose
> list_head we are list_add-ing to.
> 
> For global variables, the check needs more work. In the normal map
> lookup case, we assign fresh reg->id whenever you do a map lookup, so
> in case of array map spin lock for the same key will set different id
> in cur->active_spin_lock_id for two different map values from two
> different lookups. This is because we don't know if it is the same map
> value on second lookup, so both locks in different map value are
> considered different locks. The id is the unique lock id, essentially.
> 
> Since global variables are in direct_value_addr map with 1 max_entry,
> we don't need to assign fresh reg->id and each pseudo ldimm64 insn. We
> can instead teach it to either track it using id (for the case of
> normal map lookups and local kptr), or map_ptr to accomodate global
> variables non-unique ids. At once, only one of two is set, the other
> is zero.
> 
> Then everything falls in place. We always match both map_ptr and id.
> For global data and map lookups, the map_ptr is matched, id will be 0
> for global data, non zero for normal map lookups. There is only one
> map value so the lock protects everything in it. For the other case I
> described above, map_ptr is NULL but id will be different if not from
> the same 'lookup' in case of local kptr (PTR_TO_BTF_ID).
> 
> We also have map_uid, which is assigned to map_ptr of inner map
> lookups. But remember that we are talking of map values above, so even
> if for lookups from two differ inner maps of same map, we get two map
> values whose map_ptr is technically same (even if the map_uid was
> different), their reg->id _will_ be different, so the above checks are
> sufficient to disambiguate spin locks for all kinds of cases.
> 
> Keeping lock and data in the same allocation thus allows you to
> associate locks statically even for dynamic allocations, enabling the
> map-in-map use case.

All that makes sense, but consider use case where we need rb_root for every cgroup.
The 'struct bpf_rb_root' will be created dynamically in cgroup local storage.
We can create a lock in the same cgroup local storage as well.
It's all nice and the verifier can do locking checks statically,
but how the program can trasnfer and rb_node from one rb tree to another
in a different cgroup?
Either two locks need to be held and I don't see a way to check that
statically or one bpf_spin_lock should be used across all cgroups.
Thoughts?
