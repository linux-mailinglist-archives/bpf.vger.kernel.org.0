Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73F59A00A
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 18:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352095AbiHSQTQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352846AbiHSQRy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 12:17:54 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144C1184E7
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 09:01:05 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b15so2507343ilq.10
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=e9v9kx5PSnGf1zP32Y1bgHOy6PWWhXCq1zigaJoDyP4=;
        b=IYYnhs7HlIKV7V66yYbN7hePtn7XapvZbVcS7i6nadKOsIRQfYP0Es/xidGH3R1+S1
         9Mam5G2KdXk3lgkc6joX/RI/DK7K0QPYDSw5ypbtDEp5spLOi6i/bG1f3lGcTmCSC5iU
         oLb88wTcKsoZTOyIXxjGlQKfnkdBxFELQkx1PgkuAwBpVB5ZoMQU/BakuzxjiMp/lYlj
         EJyR4WbeEnW7YaMSiELKRqjwoVxYpg5/nSl1k8CibfaCcdCLOqh+0RwJqMXrSY3panWz
         1ezgppa4YbkdIDAIL7yvcy4LoOvBdL/xmSngXwSUMvIfXHOngBl68+DEw3XxM8Z+6RUP
         tiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=e9v9kx5PSnGf1zP32Y1bgHOy6PWWhXCq1zigaJoDyP4=;
        b=hhPEoS+/kGshA01tSlksTvp48j0/JvRyicnQqEOqln6BGJWF+nWUk0wX8qtjFHyaU/
         LitY5pDJBjgR4FUiM9IHodDv/pf5dU9hVMElHVBp8IydNX19jVQ/43IFOaJHabm9bW3x
         XtL+3l5pyQQecD+wpoLeXDcwcylyDYHhw7Vk8vZ4FVkMJFNQNfurmZhv2kSGw1mi+ZBh
         KuxwlvCo07I4yS4lSjriJBohVIhryjGTdxXdWcfU+KB2SL13gGYf488HTzRNAHTM97JL
         9J0gXiCCzdG/vyRXwLd01YSDSJrQo/HXXropeRHQ7vY7o/k3qWrYo8GloKZOBulKdZid
         1zWw==
X-Gm-Message-State: ACgBeo1vHzFhOS2FofM31INgkihnEUg0c1PE3QgV0qvt/5eqX/WHjbd6
        XnlYY2414l/K+9o90aKqhDpcmP59x9fnZz9LvU4=
X-Google-Smtp-Source: AA6agR6swcHaeveUrBAFFfFxs0p69t/Uq0sh6z6zuGbPEKa+8z4LOrRpoQ63g/tMmvnEyfecrN7MduYsEEWoTjpnYbU=
X-Received: by 2002:a05:6e02:198c:b0:2e0:ac33:d22 with SMTP id
 g12-20020a056e02198c00b002e0ac330d22mr3901515ilf.219.1660924858630; Fri, 19
 Aug 2022 09:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
 <232c8439-4e34-f89c-bc97-c3a445a15ac4@fb.com>
In-Reply-To: <232c8439-4e34-f89c-bc97-c3a445a15ac4@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 19 Aug 2022 18:00:22 +0200
Message-ID: <CAP01T77PBfQ8QvgU-ezxGgUh8WmSYL3wsMT7yo4tGuZRW0qLnQ@mail.gmail.com>
Subject: Re: BPF Linked Lists discussion
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Aug 2022 at 10:55, Dave Marchevsky <davemarchevsky@fb.com> wrote=
:
>
> Hi Kumar,
>
> Alexei and I talked about locking and a few other things today in regards=
 to my
> rbtree work. Some of this isn't a direct response to your ideas/notes her=
e,
> but hoping to summarize today's discussion inline with your code samples =
and
> get your opinion.
>
> Also, some inline comments more directly addressing your notes.

Hi Dave, thanks for sharing the notes.

>
> On 8/17/22 5:04 AM, Kumar Kartikeya Dwivedi wrote:
> > Alexei and I had a meeting where we discussed some of my ideas related
> > to BPF linked lists. I am sharing the discussion with everyone to get
> > wider feedback, and document what we discussed.
> >
> > The hard stuff is the shared ownership case, hence we can discuss this
> > while we work on landing single ownership lists. I will be sharing my
> > patches for that as an RFC.
> >
> > 1. Definition
> >
> > We can use BTF declaration tags to annotate a common structure like
> > struct bpf_list_head, struct bpf_rb_root, etc.
> >
> > #define __value(kind, name, node) __attribute__((btf_decl_tag(#kind
> > ":" #name ":" #node))
> >
> > struct foo {
> >     unsigned long data;
> >     struct bpf_list_node node;
> > };
> >
> > struct map_value {
> >     struct bpf_spin_lock lock;
> >     struct bpf_list_head head __value(struct, foo, node);
> > };
> >
> > This allows us to parameterize any kind of intrusive collection.
> >
> > For the map-in-map use case:
> >
> > struct bar {
> >     unsigned long data;
> >     struct bpf_list_node node;
> > };
> > // Only two levels of types allowed, to ensure no cycles, and to
> > prevent ownership cycles
> > struct foo {
> >     unsigned long data;
> >     struct bpf_spin_lock lock;
> >     struct bpf_list_node node;
> >     struct bpf_list_head head __value(struct, bar, node);
> > };
> >
> > struct map_value {
> >     struct bpf_spin_lock lock;
> >     struct bpf_list_head head __value(struct, foo, node);
> > };
> >
>
> Will these still be 'bpf maps' under the hood? If the list were to use

Nope, my idea was to get rid of maps for intrusive collections, and
you always put bpf_list_head, bpf_rb_root in a map value. For global
map-like use cases, you instead use global variables, which are also
inside the map value of a BPF_MAP_TYPE_ARRAY. IMO there is no need
anymore to add more and more map types with this new style of data
structures. It is much more ergonomic to just use the head structure,
either as a global variable, or as an allocated object, but again,
that's my opinion. There will be some pros and cons for either
approach :).

I am aware of the problem with global bpf_spin_lock (thanks to Alexei
for spotting it), but as you described it can be solved by moving them
into a different section.

> convention similar to the rbtree RFC, the first (non map-in-map) def coul=
d be
> written like:
>
> struct foo {
>     unsigned long data;
>     struct bpf_list_node node;
> };
>
> struct {
>     __uint(type, BPF_MAP_TYPE_LINKED_LIST);
>     __type(value, struct foo);
> } list SEC(".maps");
>
> I think we're thinking along similar lines with regards to the BTF tag, b=
ut I
> was thinking of tagging the value type instead of the container, somethin=
g like:
>
> struct foo {
>     unsigned long data;
>     struct bpf_list_node node __protected_list_node;
> };
>
> 'protected' meaning verifier knows to prevent prog from touching the
> bpf_list_node. Currently my rbtree RFCv1 is just assuming that value type=
 will
> have rb_node at offset 0. BTF tag would eliminate this offset requirement
> and allow value types to be part of multiple data structures:
>
> struct foo {
>     unsigned long data;
>     struct bpf_list_node node __protected_list_node;
>     struct bpf_rb_node rb_node __protected_rb_node;
> };
>
> Not a hard requirement for me, but nice-to-have: support for heterogenous=
 value
> types in same list / rbtree. Map def's __type(value, struct foo) wouldn't=
 work
> in this case, I think your __value(struct, foo, node) would have same iss=
ue.
>
> But I think this should be possible with BTF tags somehow. List
> helpers are ostensibly only touching the list_{head,node} - and similar f=
or
> rbtree, and we're both planning on explicit in-prog typed allocation.
> If type can be propagated from alloc -> reg state -> helper input ->
> helper output, helpers could use reg BTF info w/ properly tagged field
> to manipulate the right field in the value struct.

We can have multiple __value on a list_head and add some way to
disambiguate what the type will be on list_remove. The problem is not
during list_add, as you know the type of the node being added. It is
when you list_remove, is when you need to be able to disambiguate the
type so that we set the reg as correct btf, btf_id and then set the
right reg->off (so that container_of can give the entry). Until the
disambiguation step is done, it is unknown what the type might be.

When thinking of heterogeneous values, we should probably look to add
a way to do generic variant types in BPF, such that e.g. the first
field is a tag, and then the actual data of that type follows. This
would allow us to use them not only in intrusive collections, but
anywhere else, and probably even store them in map values as kptrs.

I think it is much simpler to start with homogenous types first, though.

>
> In that case the tag would have to be on the value struct's field, not th=
e
> container. I do like that your __value(struct, foo, node) is teaching the
> container what named field to manipulate. If value struct were to be part=
 of
> two lists this would make it possible to disambiguate.
>
> When we discussed this Alexei mentioned existing pointer casting helper p=
attern
> (e.g. 'bpf_skc_to_tcp_sock') as potentially being helpful here.
>

Indeed, but I think you need some bit of info at runtime to be able to do t=
his.

> > 2. Building Blocks - A type safe allocator
> >
> > Add bpf_kptr_alloc, bpf_kptr_free
> > This will use bpf_mem_alloc infra, allocator maps.
> > Alexei mentioned that Delyan is working on support for exposing
> > bpf_mem_alloc using an allocator map.
> > Allocates referenced PTR_TO_BTF_ID (should we call these local kptr?):
> > reg->btf =3D=3D prog->aux->btf
> > reg->btf_id =3D bpf_core_type_id_local(...)
> > btf_struct_access allows writing to these objects.
> > Due to type visibility, we can embed objects with special semantics
> > inside these user defined types.
> > Add a concept of constructing/destructing kptr.
> > constructing -> normal kptr, escapable -> destructing
> > In constructing and destructing state, pointer cannot escape the
> > program. Hence, only one CPU is guaranteed to observe the object in
> > those states. So when we have access to single ownership kptr, we know
> > nobody else can access it. Hence we can also move its state from
> > normal to destructing state.
> > In case of shared ownership, we will have to rely on the result of
> > bpf_refcount_put for this to work.
> >
> > 3. Embedding special fields inside such allocated kptr
> >
> > We must allow programmer to compose their own user defined BPF object
> > out of building blocks provided by BPF.
> > BPF users may have certain special objects inside this allocated
> > object. E.g. bpf_list_node, bpf_spin_lock, even bpf_list_head
> > (map-in-map use case).
> > btf_struct_access won=E2=80=99t allow direct reads/writes to these fiel=
ds.
> > Each of them needs to be constructed before the object is considered
> > fully constructed.
> > An unconstructed object=E2=80=99s kptr cannot escape a program, it can =
only be
> > destructed and freed.
> > This has multiple advantages. We can add fields which have complex
> > initialization requirements.
> > This also allows safe recycling of memory without having to do zero
> > init or inserting constructor calls automatically from verifier.
> > Allows constructors to have parameters in future, also allows complex
> > multi-step initialization of fields in future.
> >
>
> I don't fully understand "shared ownership" from 2) and don't have a use =
case

Shared ownership is explained further later in section 5.

> for complex constructors in 3), but broadly agree with everything else. W=
ill
> do another pass.
>
> > 4. Single Ownership Linked Lists
> >
> > The kptr has single ownership.
> > Program has to release it before BPF_EXIT, either free or move it out
> > of program.
> > Once passed to list, the program loses ownership.
> > But BPF can track that until spin_lock is released, nobody else can
> > touch it, so we can technically still list_remove a node we added
> > using list_add, and then we will be owning it after unlock.
> > list_add marks reference_state as =E2=80=98release_on_unlock=E2=80=99
> > list_remove unmark reference_state
> > Alexei: Similar to Dave=E2=80=99s approach, but different implementatio=
n.
> > bpf_spin_unlock walks acquired_refs and release_reference marked ones.
> > No other function calls allows in critical section, hence
> > reference_state remains same.
> >
> > ----------
> >
> > 5. Shared Ownership
> >
> > Idea: Add bpf_refcount as special field embeddable in allocated kptrs.
> > bpf_refcount_set(const), bpf_refcount_inc(const), bpf_refcount_put(ptr)=
.
> > If combined with RCU, can allow safe kptr_get operations for such objec=
ts.
> > Each rb_root, list_head requires ownership of node.
> > Caller will transfer its reference to them.
> > If having only a single reference, do inc before transfer.
> > It is a generic concept, and can apply to kernel types as well.
> > When linking after allocation, it is extremely cheap to set, add, add, =
add=E2=80=A6
> >
> > We add =E2=80=98static_ref=E2=80=99 to each reference_state to track in=
cs/decs
> > acq =3D static_ref =3D 1
> > set  =3D static_ref =3D K (must be in [1, =E2=80=A6] range)
> > inc  =3D static_ref +=3D K
> > rel/put =3D static_ref -=3D  1 (may allow K, dunno)
> >
> > Alexei suggested that he prefers if helpers did the increment on their
> > own in case where the bpf_refcount field exists in the object. I.e.
> > instead of caller incrementing and then passing their reference to
> > lists or rbtree, the add helpers receive hidden parameter to refcount
> > field address automatically and bump the refcount when adding. In that
> > case, they won't be releasing caller's reference_state.
> > Then this static_ref code is not required.
> >
> > Kartikeya: No strong opinions, this is also another way. One advantage
> > of managing refcount on caller side and just keeping helpers move only
> > (regardless of single owner or shared owner kptr) is that helpers
> > themselves have the same semantics. It always moves ownership of a
> > reference. Also, one inc(K) and multiple add is a little cheaper than
> > multiple inc(1) on each add.
> >
> > 6. How does the verifier reason about shared kptr we don't know the sta=
te of?
> >
> > Consider a case where we load a kptr which has shared ownership from a
> > map using kptr_get.
> >
> > Now, it may have a list_node and a rb_node. We don't know whether this
> > node is already part of some list (so that list_node is occupied),
> > same for rb_node.
> >
> > There can be races like two CPUs having access to the node:
> >
> > CPU 0                         CPU 1
> > lock(&list1_lock)            lock(&list2_lock)
> > list_add(&node, &list2)
> >     next.prev =3D node;
> >     node.next =3D next;      list_remove(&node)
> >                                          node.next =3D NULL;
> >                                          node.prev =3D NULL;
> >     node.prev =3D prev;
> >     prev.next =3D node;
> > unlock(&list1_lock);         unlock(&list2_lock);
> >
> > Interleavings can leave nodes in inconsistent states.
> > We need to ensure that when we are doing list_add or list_remove for
> > kptr we don't know the state of, it is only in a safe context with
> > ownership of that operation.
> >
> > Remove:
> >
> > When inside list_for_each helper, list_remove is safe for nodes since
> > we are protected by lock.
> >
> > Idea: An owner field alongside the list_node and rb_node.
> > list_add sets it to the address of list_head, list_remove sets it to
> > NULL. This will be done under spinlock of the list.
> >
> > When we get access to the object in an unknown state for these fields,
> > we first lock the list we want to remove it from, check the owner
> > field, and only remove it when we see that owner matches locked list.
> >
> > Each list_add updates owner, list_remove sets to NULL.
> >     bpf_spin_lock(&lock);
> >     if (bpf_list_owns_node(&i->node, &list)) { // checks owner
> > list_remove(&i->node);
> >     }
> >     bpf_spin_unlock(&lock);
> >
> > bpf_list_owns_node poisons pointer in false branch, so user can only
> > list_remove in true branch.
> >
> > If the owner is not a locked list pointer, it will be either NULL or
> > some other value (because of previous list_remove while holding same
> > lock, or list_add while holding some other list lock).
> > If the owner is our list pointer, we can be sure this is safe, as we
> > have already locked list.
> > Otherwise, previous critical section must have modified owner.
> > So one single load (after inlining this helper) allows unlinking
> > random kptr we have reference to, safely.
> >
> > Cost: 8-bytes per object. Advantages: Prevents bugs like racy
> > list_remove and double list_add, doesn't need fallible helpers (the
> > check that would have been inside has to be done by the user now).
> > Don't need the abort logic.
> >
>
> I agree, keeping track of owner seems necessary. Seems harder to verify
> statically than lock as well. Alexei mentioned today that combination
> "grab lock and take ownership" helper for dynamic check might make
> sense.
>
> Tangentially, I've been poking at ergonomics of
> libbpf lock definition this week and think I have something reasonable:
>
> struct node_data {
>         struct rb_node node;
>         __u32 one;
>         __u32 two;
> };
>
> struct l {
>         __uint(type, BPF_MAP_TYPE_ARRAY);
>         __type(key, u32);
>         __type(value, struct bpf_spin_lock);
>         __uint(max_entries, 1);
> } lock_arr SEC(".maps");
>
> struct {
>         __uint(type, BPF_MAP_TYPE_RBTREE);
>         __type(value, struct node_data);
>         __array(lock, struct l);
> } rbtree1 SEC(".maps") =3D {
>         .lock =3D {
>                 [0] =3D &lock_arr,
>         },
> };
>
> struct {
>         __uint(type, BPF_MAP_TYPE_RBTREE);
>         __type(value, struct node_data);
>         __array(lock, struct l);
> } rbtree2 SEC(".maps") =3D {
>         .lock =3D {
>                 [0] =3D &lock_arr,
>         },
> };
>
> ... in BPF prog
>
>   bpf_spin_lock(&lock_arr[0]);
>
>   // Can safely operate on either tree, move nodes between them, etc.
>
>   bpf_spin_unlock(&lock_arr[0]);
>
>
> Notes:
>   * Verifier knows which lock is supposed to be used at map creation time
>     * Can reuse bpf_verifier_state's 'active_spin_lock' member, so no add=
t'l
>       bookkeeping needed to verify that rbtree_add or similar is happenin=
g
>       in critical section

Yes, this is similar to my approach, except what I'm doing is (suppose
we fix the bpf_spin_lock in mmap-able map value problem):

The list_head and lock protecting it are global variables, hence in
the same map value for the global variable's array map (for now only
one lock is allowed in a map value, but we may allow some guarded_by
annotation to associate different locks to different containers).
Now, you can use the same active_spin_lock infra to track whether I
hold the one in the same map value as the list_head. More on that
below.

>   * Can benefit from relo goodness (e.g. rbtree3 using extern lock in ano=
ther
>     file)
>   * If necessary, similar dynamic verification behavior as just keeping l=
ock
>     internal
>   * Implementation similarities with map_of_map 'inner_map'. Similarly to
>     inner_map_fd, kernel needs to know about lock_map_fd. Can use map_ext=
ra for
>     this to avoid uapi changes
>
> Alexei and I discussed possibly allowing raw 'struct bpf_spin_lock' globa=
l var,
> which would require some additional libbpf changes as bpf_spin_lock can't=
 be
> mmap'd and libbpf tries to mmap all .data maps currently. Perhaps a separ=
ate
> .data.no_mmap section.
>
> This ergonomics idea doesn't solve the map-in-map issue, I'm still unsure
> how to statically verify lock in that case. Have you had a chance to thin=
k
> about it further?
>

You rely on the lock being in the same allocation, and manipulation
done on an object from the same 'lookup'. See below:

struct foo {
        struct bpf_spin_lock lock;
        struct bpf_list_head head __value(...);
};

struct map_value {
        struct foo __local_kptr *ptr;
};

struct {
        __uint(type, BPF_MAP_TYPE_ARRAY);
        __type(key, int);
        __type(value, struct map_value);
        __uint(max_entries, 8);
} array_of_lists SEC(".maps");

In my case, the structure is the map, so pointer to the structure
inside a map makes it map-in-map (now common, the existing map-in-maps
just hide this from you, so it's pretty much the same thing
anyway...).

This is just an example, it can be one more level deep, but anyway.

When I do a map lookup, there is check in
verifier.c:reg_may_point_to_spin_lock, this preserves reg->id on NULL
unmarking.  This reg->id is then remembered when you take lock inside
this map value, to associate it back to unlock correctly.

Now, suppose you load the kptr. You know the kptr has a lock, you will
update this check to also consider local kptr with locks. The reg->id
is preserved after loaded kptr is NULL checked, but it is unique for
each load of the kptr. You lock spin_lock in the kptr, you then add to
list, the list_add verifier check goes and sees whether the current
lock held and the current list_head come from the same reg->id (you
know the reg of list_head, right? So you know the id as well, and you
match that to cur->active_spin_lock_id). If so, it is the correct
lock, we locked the lock in the same loaded kptr as the one whose
list_head we are list_add-ing to.

For global variables, the check needs more work. In the normal map
lookup case, we assign fresh reg->id whenever you do a map lookup, so
in case of array map spin lock for the same key will set different id
in cur->active_spin_lock_id for two different map values from two
different lookups. This is because we don't know if it is the same map
value on second lookup, so both locks in different map value are
considered different locks. The id is the unique lock id, essentially.

Since global variables are in direct_value_addr map with 1 max_entry,
we don't need to assign fresh reg->id and each pseudo ldimm64 insn. We
can instead teach it to either track it using id (for the case of
normal map lookups and local kptr), or map_ptr to accomodate global
variables non-unique ids. At once, only one of two is set, the other
is zero.

Then everything falls in place. We always match both map_ptr and id.
For global data and map lookups, the map_ptr is matched, id will be 0
for global data, non zero for normal map lookups. There is only one
map value so the lock protects everything in it. For the other case I
described above, map_ptr is NULL but id will be different if not from
the same 'lookup' in case of local kptr (PTR_TO_BTF_ID).

We also have map_uid, which is assigned to map_ptr of inner map
lookups. But remember that we are talking of map values above, so even
if for lookups from two differ inner maps of same map, we get two map
values whose map_ptr is technically same (even if the map_uid was
different), their reg->id _will_ be different, so the above checks are
sufficient to disambiguate spin locks for all kinds of cases.

Keeping lock and data in the same allocation thus allows you to
associate locks statically even for dynamic allocations, enabling the
map-in-map use case.

If you still find it confusing, I'll be posting the RFC early next
week, please let me know if there is a flaw in the approach above
after you look at the code in detail. I might have actually missed
something.

>  And does the above seem reasonable to you?

I still think if we can solve the mmapable spin_lock problem (e.g. by
moving it to a different section), we should do it using global
variables instead of maps. We're both essentially doing the same
thing, but in different ways. Why I prefer global variables is because
I think the stuff below looks more neat and is simple for the user
compared to defining array map with lock, then having a new map type
for the container, and then setting lock address of array map with
lock:

struct bpf_spin_lock lock;
struct bpf_rb_root rb_root __guarded_by(lock);

But that is just my opinion, we can discuss the pros and cons.


> > We can also use this to jump back to owner, lock it, list_owns_node,
> > remove safely without having to iterate owner list.
> >
> > Idea: Make it optional, so cost only paid by those who need this
> > dynamic removal of kptr from kptr_gets, only this helper would require
> > associated owner field.
> >
> > 7. How to add such a randomly acquired kptr?
> >
> > Same idea, but requires a cmpxchg owner to BPF_PTR_POISON. This can=E2=
=80=99t
> > be set from list_add or list_remove. list_owns_node will see it and
> > not return true. Hence, we will have exclusive ownership of list_node.
> >
> > Safety: Verifier will force to either add to some list, and make
> > pointer unescapable, or reset to NULL (needs a store, makes escapable)
> > (otherwise if you move it to map, it will become unlinkable on next
> > prog execution, as we lose this info when we reload from map).
> >
> > 6,7: Alternative approach: node locking
> >
> > Be able to lock kptr so that its list_node, rb_node fields are
> > protected from concurrent mutation. This requires teaching the
> > verifier to take 2 levels of locks.
> >
> > Requires building a type ownership graph and detecting cycles to avoid
> > ABBA deadlocks when loading program BTF.
> >
> > It would still require checking the owner field (i.e.
> > bpf_list_owns_node operation) inside the CS (as someone before us
> > might have taken the lock and added it or removed it), but it becomes
> > a simple branch, instead of having to do N cmpxchg for N fields to be
> > able to add them.
> >
> > 8. Insight: Need a generic concept of helpers that poison/unpoison  a
> > pointer argument depending on the checking of the result they return.
> >
> > if (use_only_in_one_branch(ptr)) { =E2=80=A6 } else { =E2=80=A6 }
> > Poisons all copies of ptr. Checking the returned pointer unpoisons.
> > Returned pointer stores ref_obj_id (currently only needed for
> > refcounted registers), which can be used to find candidates for
> > un-poisoning.
> > Generic concept, similar to CONDITIONAL_RELEASE approach from Dave,
> > but can apply to do all kinds of other things.
> > E.g. if (bpf_refcount_single(...)) does one load internally, simply
> > check to downgrade to single ownership pointer in one branch. Some
> > operations then don=E2=80=99t need lock (like adding to list_head, sinc=
e only
> > we can access it).
> > Same for bpf_refcount_put pattern.
> > if (bpf_refcount_put(kptr)) { destruct(kptr); kptr_free(kptr); }
> >
> > 9. RCU protection for single & shared ownershipkptrs
> >
> > Idea: Expose bpf_call_rcu kfunc. RCU protected kptr cannot be
> > destructed, cannot be bpf_kptr_free directly. Only bpf_call_rcu can be
> > called once refcount reaches 0, then it will invoke callback and give
> > ownership of kptr to the callback and force destruction + free (by
> > setting destructing state of pointer).
> >
> > For single ownership, once we remove visibility using kptr_xchg (it
> > can be only in one field, because of single ownership allowing one
> > move from/to map), we can call this helper as well.
> >
> >
> > In shared ownership we rely on bpf_refcount_put's true branch to call
> > bpf_call_rcu.
> >
> > Callback runs once after RCU gp, it will only be allowed to destruct
> > kptr and then call bpf_kptr_free, not escape program.
> >
> > I _think_ we can avoid taking prog reference, if we do RCU barrier
> > after synchronize_rcu in prog free path? That waits for all call_rcu
> > invoked from read sections that may be executing the prog.
> >
> > Inside callbacks, regardless of single ownership kptr or kptr with
> > refcount (possible shared ownership), we know we have single
> > ownership, and set destructing state (with all possible destructible
> > fields marked as constructed in callback func_state, so user has to
> > call all destructors and then free, can do nothing else).
> >
> > Alexei: Instead of open coding bpf_call_rcu plus destruction like
> > this, associate destructor callback with user kptr. Then
> > bpf_kptr_free_rcu automatically invokes this using call_rcu, and BPF
> > map also invokes it on map_free.
> >
> > Kartikeya: One big limitation is that now BPF map must take reference
> > to prog as it needs callback reference to stay stable, but to solve
> > the reference cycle it must release these kptr on map_release_uref. We
> > then also need to check this atomic count like the timer helper before
> > setting the kptr in the map, so that such kptr is not set after
> > map_release_uref again, which is a bit limiting. It would be limiting
> > to have to pin maps to make this work, we may not even have user
> > visible fds for such maps in future (as we are moving towards BPF
> > powered kernel programming).
> >
> > 10. Verifier callback handling is broken
> >
> > Loop callback verification is broken
> > Same issues exist now as were anticipated in open coded iteration
> > Fixing this will open clear path to enabling open coded iteration
> > https://lore.kernel.org/bpf/20220815051540.18791-1-memxor@gmail.com
> > Alexei mentioned that Andrii is working on how to do inline nested loop=
s.
> >
> > --
> >
> > This concludes what we discussed yesterday. Apologies in advance if I
> > forgot to mention anything else.
