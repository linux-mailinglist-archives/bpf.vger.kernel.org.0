Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784BF596BC6
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiHQJF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiHQJFY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 05:05:24 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3FD61129
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 02:05:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h78so5014042iof.13
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=CzTHhU+nR/MQyXwUZYFyxQN+2T1C9d4uZD8F0WWxdOQ=;
        b=Y2h20d9JQYFHhn+uv+NtNecs8Gu8BiuL/KcwawHCtapQ7ZTKgkW/+hODFmGWqt39ua
         WIVHyo6yJRr80oqT0BK6B+YcreCSxph9EWCz+6Sr+QtSywMWl4/PriOZbo1H+YMvpw+6
         8Fu+TcjZb1KiCtlifJTg1FTd8M7tgiuVRPVK49Mu7j4c27eUh9NdWLYpp217KYgU0AlU
         tIEg+EBsZBJafJqOm5oAsieB9hK06qV3VzDwwQlGkdjz/gcOfTWNvR3JGrQreSAmV0E2
         pujyGibTNmb25v0mkfcotQ4xlM8CmJxbNXRGMPdQeZPO4KBjNXPNCaZBfaQ2QUMtHZCy
         KLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CzTHhU+nR/MQyXwUZYFyxQN+2T1C9d4uZD8F0WWxdOQ=;
        b=LRMVx/aittJUSdQNL1DBSgubIrNDim04KbgbUaw0P1Gt/4PO0l9Fp2zG8HxhYhJj5F
         Azxmq6T4gy83OJzRkG0hj62qsZ35ha4Q39/RufDd3l3z6fFtAeYZpwglI+6ImsaZsrXr
         NAyDLmBZydW/XwfKi1mnjX5Mlqk0AnHFhUeeiFPcBUvViA1YuNAp1Tkb+C2SlImDB/hr
         +C5KAe5Nu8QA76NripSUA8chWFWGXLfIaFOubD0pVvHMP+6A54asYLz4iuATFZBPV5h5
         9Hov4zsV7G3xovhS/vgatKTH0RV2ZOEbcA+o+gKwB13wMzEUNbSjoR1snp6swHEeanci
         sPVA==
X-Gm-Message-State: ACgBeo1+sjuyYGync4A4UlyB72iRE7fwuYkfAakvPcwY6TTMHV5ZTstX
        VWitJDrF6qpWqE7qO9dNXnhUn1FKMssu0jCEhWALVXZ3Nds=
X-Google-Smtp-Source: AA6agR6P/grQhJGE2rmNoDANTEzqBo56PmxEz1KpbTqou6mHrPouiQrryyd58n670jYH/eUAKNUt9tT3avV45YOwp98=
X-Received: by 2002:a05:6638:2381:b0:346:c583:9fa0 with SMTP id
 q1-20020a056638238100b00346c5839fa0mr1111018jat.93.1660727122633; Wed, 17 Aug
 2022 02:05:22 -0700 (PDT)
MIME-Version: 1.0
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 17 Aug 2022 11:04:47 +0200
Message-ID: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
Subject: BPF Linked Lists discussion
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.next, andrii@kernel.org,
        "davemarchevsky@fb.com" <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei and I had a meeting where we discussed some of my ideas related
to BPF linked lists. I am sharing the discussion with everyone to get
wider feedback, and document what we discussed.

The hard stuff is the shared ownership case, hence we can discuss this
while we work on landing single ownership lists. I will be sharing my
patches for that as an RFC.

1. Definition

We can use BTF declaration tags to annotate a common structure like
struct bpf_list_head, struct bpf_rb_root, etc.

#define __value(kind, name, node) __attribute__((btf_decl_tag(#kind
":" #name ":" #node))

struct foo {
    unsigned long data;
    struct bpf_list_node node;
};

struct map_value {
    struct bpf_spin_lock lock;
    struct bpf_list_head head __value(struct, foo, node);
};

This allows us to parameterize any kind of intrusive collection.

For the map-in-map use case:

struct bar {
    unsigned long data;
    struct bpf_list_node node;
};
// Only two levels of types allowed, to ensure no cycles, and to
prevent ownership cycles
struct foo {
    unsigned long data;
    struct bpf_spin_lock lock;
    struct bpf_list_node node;
    struct bpf_list_head head __value(struct, bar, node);
};

struct map_value {
    struct bpf_spin_lock lock;
    struct bpf_list_head head __value(struct, foo, node);
};

2. Building Blocks - A type safe allocator

Add bpf_kptr_alloc, bpf_kptr_free
This will use bpf_mem_alloc infra, allocator maps.
Alexei mentioned that Delyan is working on support for exposing
bpf_mem_alloc using an allocator map.
Allocates referenced PTR_TO_BTF_ID (should we call these local kptr?):
reg->btf =3D=3D prog->aux->btf
reg->btf_id =3D bpf_core_type_id_local(...)
btf_struct_access allows writing to these objects.
Due to type visibility, we can embed objects with special semantics
inside these user defined types.
Add a concept of constructing/destructing kptr.
constructing -> normal kptr, escapable -> destructing
In constructing and destructing state, pointer cannot escape the
program. Hence, only one CPU is guaranteed to observe the object in
those states. So when we have access to single ownership kptr, we know
nobody else can access it. Hence we can also move its state from
normal to destructing state.
In case of shared ownership, we will have to rely on the result of
bpf_refcount_put for this to work.

3. Embedding special fields inside such allocated kptr

We must allow programmer to compose their own user defined BPF object
out of building blocks provided by BPF.
BPF users may have certain special objects inside this allocated
object. E.g. bpf_list_node, bpf_spin_lock, even bpf_list_head
(map-in-map use case).
btf_struct_access won=E2=80=99t allow direct reads/writes to these fields.
Each of them needs to be constructed before the object is considered
fully constructed.
An unconstructed object=E2=80=99s kptr cannot escape a program, it can only=
 be
destructed and freed.
This has multiple advantages. We can add fields which have complex
initialization requirements.
This also allows safe recycling of memory without having to do zero
init or inserting constructor calls automatically from verifier.
Allows constructors to have parameters in future, also allows complex
multi-step initialization of fields in future.

4. Single Ownership Linked Lists

The kptr has single ownership.
Program has to release it before BPF_EXIT, either free or move it out
of program.
Once passed to list, the program loses ownership.
But BPF can track that until spin_lock is released, nobody else can
touch it, so we can technically still list_remove a node we added
using list_add, and then we will be owning it after unlock.
list_add marks reference_state as =E2=80=98release_on_unlock=E2=80=99
list_remove unmark reference_state
Alexei: Similar to Dave=E2=80=99s approach, but different implementation.
bpf_spin_unlock walks acquired_refs and release_reference marked ones.
No other function calls allows in critical section, hence
reference_state remains same.

----------

5. Shared Ownership

Idea: Add bpf_refcount as special field embeddable in allocated kptrs.
bpf_refcount_set(const), bpf_refcount_inc(const), bpf_refcount_put(ptr).
If combined with RCU, can allow safe kptr_get operations for such objects.
Each rb_root, list_head requires ownership of node.
Caller will transfer its reference to them.
If having only a single reference, do inc before transfer.
It is a generic concept, and can apply to kernel types as well.
When linking after allocation, it is extremely cheap to set, add, add, add=
=E2=80=A6

We add =E2=80=98static_ref=E2=80=99 to each reference_state to track incs/d=
ecs
acq =3D static_ref =3D 1
set  =3D static_ref =3D K (must be in [1, =E2=80=A6] range)
inc  =3D static_ref +=3D K
rel/put =3D static_ref -=3D  1 (may allow K, dunno)

Alexei suggested that he prefers if helpers did the increment on their
own in case where the bpf_refcount field exists in the object. I.e.
instead of caller incrementing and then passing their reference to
lists or rbtree, the add helpers receive hidden parameter to refcount
field address automatically and bump the refcount when adding. In that
case, they won't be releasing caller's reference_state.
Then this static_ref code is not required.

Kartikeya: No strong opinions, this is also another way. One advantage
of managing refcount on caller side and just keeping helpers move only
(regardless of single owner or shared owner kptr) is that helpers
themselves have the same semantics. It always moves ownership of a
reference. Also, one inc(K) and multiple add is a little cheaper than
multiple inc(1) on each add.

6. How does the verifier reason about shared kptr we don't know the state o=
f?

Consider a case where we load a kptr which has shared ownership from a
map using kptr_get.

Now, it may have a list_node and a rb_node. We don't know whether this
node is already part of some list (so that list_node is occupied),
same for rb_node.

There can be races like two CPUs having access to the node:

CPU 0                         CPU 1
lock(&list1_lock)            lock(&list2_lock)
list_add(&node, &list2)
    next.prev =3D node;
    node.next =3D next;      list_remove(&node)
                                         node.next =3D NULL;
                                         node.prev =3D NULL;
    node.prev =3D prev;
    prev.next =3D node;
unlock(&list1_lock);         unlock(&list2_lock);

Interleavings can leave nodes in inconsistent states.
We need to ensure that when we are doing list_add or list_remove for
kptr we don't know the state of, it is only in a safe context with
ownership of that operation.

Remove:

When inside list_for_each helper, list_remove is safe for nodes since
we are protected by lock.

Idea: An owner field alongside the list_node and rb_node.
list_add sets it to the address of list_head, list_remove sets it to
NULL. This will be done under spinlock of the list.

When we get access to the object in an unknown state for these fields,
we first lock the list we want to remove it from, check the owner
field, and only remove it when we see that owner matches locked list.

Each list_add updates owner, list_remove sets to NULL.
    bpf_spin_lock(&lock);
    if (bpf_list_owns_node(&i->node, &list)) { // checks owner
list_remove(&i->node);
    }
    bpf_spin_unlock(&lock);

bpf_list_owns_node poisons pointer in false branch, so user can only
list_remove in true branch.

If the owner is not a locked list pointer, it will be either NULL or
some other value (because of previous list_remove while holding same
lock, or list_add while holding some other list lock).
If the owner is our list pointer, we can be sure this is safe, as we
have already locked list.
Otherwise, previous critical section must have modified owner.
So one single load (after inlining this helper) allows unlinking
random kptr we have reference to, safely.

Cost: 8-bytes per object. Advantages: Prevents bugs like racy
list_remove and double list_add, doesn't need fallible helpers (the
check that would have been inside has to be done by the user now).
Don't need the abort logic.

We can also use this to jump back to owner, lock it, list_owns_node,
remove safely without having to iterate owner list.

Idea: Make it optional, so cost only paid by those who need this
dynamic removal of kptr from kptr_gets, only this helper would require
associated owner field.

7. How to add such a randomly acquired kptr?

Same idea, but requires a cmpxchg owner to BPF_PTR_POISON. This can=E2=80=
=99t
be set from list_add or list_remove. list_owns_node will see it and
not return true. Hence, we will have exclusive ownership of list_node.

Safety: Verifier will force to either add to some list, and make
pointer unescapable, or reset to NULL (needs a store, makes escapable)
(otherwise if you move it to map, it will become unlinkable on next
prog execution, as we lose this info when we reload from map).

6,7: Alternative approach: node locking

Be able to lock kptr so that its list_node, rb_node fields are
protected from concurrent mutation. This requires teaching the
verifier to take 2 levels of locks.

Requires building a type ownership graph and detecting cycles to avoid
ABBA deadlocks when loading program BTF.

It would still require checking the owner field (i.e.
bpf_list_owns_node operation) inside the CS (as someone before us
might have taken the lock and added it or removed it), but it becomes
a simple branch, instead of having to do N cmpxchg for N fields to be
able to add them.

8. Insight: Need a generic concept of helpers that poison/unpoison  a
pointer argument depending on the checking of the result they return.

if (use_only_in_one_branch(ptr)) { =E2=80=A6 } else { =E2=80=A6 }
Poisons all copies of ptr. Checking the returned pointer unpoisons.
Returned pointer stores ref_obj_id (currently only needed for
refcounted registers), which can be used to find candidates for
un-poisoning.
Generic concept, similar to CONDITIONAL_RELEASE approach from Dave,
but can apply to do all kinds of other things.
E.g. if (bpf_refcount_single(...)) does one load internally, simply
check to downgrade to single ownership pointer in one branch. Some
operations then don=E2=80=99t need lock (like adding to list_head, since on=
ly
we can access it).
Same for bpf_refcount_put pattern.
if (bpf_refcount_put(kptr)) { destruct(kptr); kptr_free(kptr); }

9. RCU protection for single & shared ownershipkptrs

Idea: Expose bpf_call_rcu kfunc. RCU protected kptr cannot be
destructed, cannot be bpf_kptr_free directly. Only bpf_call_rcu can be
called once refcount reaches 0, then it will invoke callback and give
ownership of kptr to the callback and force destruction + free (by
setting destructing state of pointer).

For single ownership, once we remove visibility using kptr_xchg (it
can be only in one field, because of single ownership allowing one
move from/to map), we can call this helper as well.


In shared ownership we rely on bpf_refcount_put's true branch to call
bpf_call_rcu.

Callback runs once after RCU gp, it will only be allowed to destruct
kptr and then call bpf_kptr_free, not escape program.

I _think_ we can avoid taking prog reference, if we do RCU barrier
after synchronize_rcu in prog free path? That waits for all call_rcu
invoked from read sections that may be executing the prog.

Inside callbacks, regardless of single ownership kptr or kptr with
refcount (possible shared ownership), we know we have single
ownership, and set destructing state (with all possible destructible
fields marked as constructed in callback func_state, so user has to
call all destructors and then free, can do nothing else).

Alexei: Instead of open coding bpf_call_rcu plus destruction like
this, associate destructor callback with user kptr. Then
bpf_kptr_free_rcu automatically invokes this using call_rcu, and BPF
map also invokes it on map_free.

Kartikeya: One big limitation is that now BPF map must take reference
to prog as it needs callback reference to stay stable, but to solve
the reference cycle it must release these kptr on map_release_uref. We
then also need to check this atomic count like the timer helper before
setting the kptr in the map, so that such kptr is not set after
map_release_uref again, which is a bit limiting. It would be limiting
to have to pin maps to make this work, we may not even have user
visible fds for such maps in future (as we are moving towards BPF
powered kernel programming).

10. Verifier callback handling is broken

Loop callback verification is broken
Same issues exist now as were anticipated in open coded iteration
Fixing this will open clear path to enabling open coded iteration
https://lore.kernel.org/bpf/20220815051540.18791-1-memxor@gmail.com
Alexei mentioned that Andrii is working on how to do inline nested loops.

--

This concludes what we discussed yesterday. Apologies in advance if I
forgot to mention anything else.
