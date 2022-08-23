Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E215359ED4A
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 22:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiHWU2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiHWU21 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 16:28:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6933A80015
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 13:02:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso15772258pjo.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3a/teVGRUtINjjG/jfrzDzUVkomn5ssD87cuN5MQN6E=;
        b=Oeelywv3z552AfnLJnrGnrLnYb9VdaVwuFcjpq0xTteeiC0Ipn4xTJCVWAIKg8TanB
         wAjWtzjGLx5iwSAipQr2pbpuVVethDW7a48+cZn7z3eSCwzDshpEHaYM2EWcle44DboA
         VukfoC9OyoeS46jw6ltBLcuBMrdCxMeOm33MJqW8IdgpKP+wZsTtg8OIrrdYbQNvZjdS
         kVv8hBwIhVvJgTca1w8qn77IrFEhWwTNvEgTuBO1d9XCaboffYDKTBg6ccpiB3dIdB3t
         FytHUiME7y+k+KngtvLD5cBIttM2jH1GB7bDJJmQj81PeOKcaSIe4aYxHkOUuJYUKlE7
         VfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3a/teVGRUtINjjG/jfrzDzUVkomn5ssD87cuN5MQN6E=;
        b=y0qHx+yTzK5rH6KOHUuTfmRO9zXUUX7cyZ36dab2yUMqmci81AYswD7notSfZEpv53
         pjgkBE3VoD0C5qcoKKza57scl4IqQdqzSbmT9gI0/p/Et2kbfkwHM9nhWJAQrIODB5EZ
         3tFsuY1+Y7uZskTCGIHS1ypHOf6PCw8grCCe+v3yXkHXuelrNFPhvg/+vgv6jI/bMTQx
         aRJsx02J3bv+qqrDsgjkJs5NbpnAr/u2k3o4DFlhDx5a20q/qhqVN27CCe4Xa7Ps8qak
         yxTljoGf9kdSU0Vo4LsEMWfg2unmbwn6QPTKUVeiFm5vByYtyxDV4hrgQdT6sLXSHTa5
         8f4w==
X-Gm-Message-State: ACgBeo3QmfRa+IfuwIixnKIedRh9R205s3THKQyiI5phlj7Mei1sn/K2
        +E8OlKx+aZKhBmMtOVQISvS7Ckcq9js=
X-Google-Smtp-Source: AA6agR7DwySDl3TeCBR1XvDL9oP4ifF4kTB5Zk8dMoLEPFb6tRHs2zuJo5leHussCJ38fKBj/NELyw==
X-Received: by 2002:a17:90b:1bd1:b0:1fb:5640:ffa4 with SMTP id oa17-20020a17090b1bd100b001fb5640ffa4mr4624107pjb.220.1661284955687;
        Tue, 23 Aug 2022 13:02:35 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::3:7ebb])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b0016ecc7d5297sm4018488plt.292.2022.08.23.13.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:02:35 -0700 (PDT)
Date:   Tue, 23 Aug 2022 13:02:32 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Subject: Re: BPF Linked Lists discussion
Message-ID: <20220823200232.s253rim2thlzpzon@MacBook-Pro-3.local>
References: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
 <232c8439-4e34-f89c-bc97-c3a445a15ac4@fb.com>
 <CAP01T77PBfQ8QvgU-ezxGgUh8WmSYL3wsMT7yo4tGuZRW0qLnQ@mail.gmail.com>
 <20220819190334.gmu6ewdumam4ggzi@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <CAP01T75Xq8evu_-g+1BCW1WXVRR0LN8s7n+MCCKLFn7bQTYKjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75Xq8evu_-g+1BCW1WXVRR0LN8s7n+MCCKLFn7bQTYKjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 19, 2022 at 10:24:17PM +0200, Kumar Kartikeya Dwivedi wrote:
> >
> > > When thinking of heterogeneous values, we should probably look to add
> > > a way to do generic variant types in BPF, such that e.g. the first
> > > field is a tag, and then the actual data of that type follows. This
> > > would allow us to use them not only in intrusive collections, but
> > > anywhere else, and probably even store them in map values as kptrs.
> >
> > Not following this idea. Could you give an example?
> >
> 
> Basically a tagged union in C.
> 
> For list_head to take value A, B, C, we define a struct type that has
> a enum type field that tells the type, some common fields that can be
> assumed at the same offset in all types sharing, and then the various
> remaining members in a union that may differ.
> 
> Basically, how we do variable type structs in the kernel with a common
> initial sequence in structs (e.g. sock_common), but with an added type
> field to be able to implement safe casting at runtime. list_remove
> then sets btf_id to variant, and it needs to be casted before
> non-common sequence can be used.

More like class inheritance with run-time type casts ?
I guess it can be useful one day, but let's put on back burner for now.
We're still trying to figure out the basic link lists :)
Advanced hierarchy can wait.

> > All that makes sense, but consider use case where we need rb_root for every cgroup.
> > The 'struct bpf_rb_root' will be created dynamically in cgroup local storage.
> > We can create a lock in the same cgroup local storage as well.
> > It's all nice and the verifier can do locking checks statically,
> > but how the program can trasnfer and rb_node from one rb tree to another
> > in a different cgroup?
> > Either two locks need to be held and I don't see a way to check that
> > statically or one bpf_spin_lock should be used across all cgroups.
> > Thoughts?
> 
> Thanks for the concrete example, much easier to reason about this :).
> Here's my thought dump, comments welcome.
> 
> So it depends on your use case and the type of node (single ownership
> vs shared ownership).
> 
> Do you want an atomic move or not?
> If yes, for the single ownership case, the following works.
> 
> lock lock1
> remove_rb_node
> unlock lock1
> lock lock2
> add_rb_node
> unlock lock2
> 
> Due to single ownership, nobody can write (reads may be safe e.g.
> using RCU) to the removed rb_node between the two critical sections.
> Both locks can be checked statically for their rb_root. For shared
> ownership, the above won't be atomic (as someone else with ref to the
> node may be able to steal it while we unlock lock1 to lock lock2.
> 
> So the main question is, can we allow holding two locks at the same
> time safely, we only need it to do atomic moves for the shared
> ownership case. Then the problem becomes a deadlock avoidance problem.

We can add bpf_spin_lock_double(lock1, lock2)
that would take the lock in address order.
The verifier can enforce only one bpf_spin_lock or bpf_spin_lock_double
is used at a time.

> The first pass solution might be to make first lock a proper spin_lock
> call, but second attempt a spin_trylock. If it succeeds, you can do
> the operation, but if it fails, it may be due to ABBA deadlock, or
> just contention.
> 
> However, this is not good, because under contention we'll see a lot of
> failed operations. The next best thing we can do is define a lock
> order, to do it generically, we can impose a simple rule for all BPF
> programs:
> Whenever two bpf_spin_locks are taken, they are always taken in the
> order of the pointer address of the lock. I.e. you must lock l1 before
> l2 if &l1 < &l2, and l2 before l1 if &l2 < &l1.
> Then it becomes a problem of enforcing the correct order in the right branch.

right, but that can only be a run-time check done inside the helper
(like bpf_spin_lock_double)

> One catch is that both locks may have the same address, in that case,
> we can use spin_lock_nested with SINGLE_DEPTH_NESTING to allow taking
> the same lock twice (or the user can have an else case).

afaik spin_lock_nested is only lockdep special.
Not sure how it helps us.

> This ensures that as long as we have two levels of locking supported
> in the verifier, there is never an ABBA deadlock condition across all
> BPF programs on the system.
> 
> ----
> 
> Anyway, this is one approach, which I really like, but I understand
> there might be cases in the future where you need to share locks
> dynamically between structures. For this, I am thinking that we can
> use the same idea we used in bpf_list_owns_node, but make it
> convenient. It is a copy paste of Alexei's refcounted locks idea, but
> with a few small tweaks.
> 
> For this case, you will have:
> 
> struct foo {
>   struct bpf_spin_lock *lock;
>   ...;
> };
> 
> When you construct such kptr, the verifier enforces you "move" a
> reference to an allocated lock (with a refcount to share it among
> multiple structures), and it disallows mutation of this field until
> you enter the single ownership phase of the object (i.e. refcount == 1
> for refcounted ones, or just having ownership of pointer for
> non-refcounted objects). For RCU protected ones, we might have to also
> enforce the RCU grace period. But the thing is, mutation should only
> be permitted once we know no other CPU can take the lock.
> 
> Then, whenever you know two nodes share the same lock, you upgrade the
> unlocked structure using the following pattern to mark it as locked in
> the true branch by the currently held spinlock.
> 
> p1 = foo();
> p2 = foo();
> lock(p1->lock_ptr);
> if (p1->lock_ptr == p2->lock_ptr) // cannot change while we can observe p2 {
>     // Both are locked, do operations protecting structs in both, like
> atomic moves
> }
> unlock(p1->lock_ptr);

yeah. A pointer to a lock creates all this complexity.
We're discussing complex cases yet haven't agreed on the path for the basics.

Here is minimal-viable-rbtree-linklist proposal composed from ideas expressed
in this thread:

- allow special structs 
  bpf_lock,
  bpf_rb_root, bpf_rb_node, 
  bpf_list_head, bpf_list_node
  bpf_refcount
  to be defined inside map value, global data, and local storage.
  (The rbtree is no longer special map type).
  The verifier enforces that there is only one bpf_lock in the same "allocation"
  with one or more bpf_rb_root and bpf_list_head.
  To have 2 or more locks in the global data the user would have to do
  SEC("my_data_section1") struct bpf_lock lock; // protects rbtree
  SEC("my_data_section1") struct bpf_rb_root rbtree;
  SEC("my_data_section2") struct bpf_lock another_lock; // protects list
  SEC("my_data_section2") struct bpf_list_head list;
  The user would have to put such special structs into named sections,
  so that libbpf doesn't make them mmap-able.
  Only one bpf_lock will be allowed in map value and in local storage.
  It will protect all bpf_rb_root-s and bpf_list_head-s in the same map value/local storage.

- bpf_rb_root and bpf_list_heade have to be tagged with contain(struct_name,field)
  btf_decl_tag to allow the verifier enforcing contain_of() type casts.

Example:
  struct rb_elem {
     int var;
     struct bpf_rb_node node;
  };
  struct list_elem {
     int var;
     struct bpf_list_node node;
  };

  struct roots {
     struct bpf_lock lock; // lock protects both root and head
         // any operation on value->root or value->head has to precede with bpf_lock(value->lock)
     struct bpf_rb_root root contain(rb_elem, node);
     struct bpf_list_head head contain(list_elem, node);
  };
  struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __uint(max_entries, 123);
    __type(key, __u32);
    __type(value, struct roots);
  } hash SEC(".maps");


- allow bpf_obj_alloc(bpf_core_type_id_local(struct list_elem))
  It returns acquired ptr_to_btf_id to program local btf type.
  This is single owner ship case. The ptr_to_btf_id is acquired (in the verifier terminology)
  and has to be kptr_xchg-ed into a map value or bpf_list_add-ed to a link list.
  Same thing with bpf_obj_alloc(bpf_core_type_id_local(struct rb_elem))

- the verifier ensures single lock is taken to allows ops on root or head.
  value = bpf_map_lookup_elem(hash, key);
  rb_elem = bpf_obj_alloc(bpf_core_type_id_local(struct rb_elem));
  list_elem = bpf_obj_alloc(bpf_core_type_id_local(struct list_elem));

  bpf_lock(&value->lock);
  bpf_rb_add(&rb_elem->node, &value->root, cb);
  bpf_list_add(&list_elem->node, &value->head);
  bpf_unlock(&value->lock);

  The verifier checks that arg1 type matches btf_decl_tag "contain" of root/head of arg2.
  In this example one lock protects rbtree and list.

- walking link list or bpf_rb_find do not return acuquired pointer.
  bpf_rb_erase and bpf_list_del convert the pointer to acquired,
  so it has to be inserted into another list or rbtree, freed with bpf_obj_free,
  or bpf_kptr_xchg-ed.
  bpf_rb_add doesn't fail.

- one element can be a part of an rbtree and a link list. In such cases it has to contain
  an explicit bpf_refcount field.
  Example:
  struct elem {
     int var;
     struct bpf_rb_node rb_node;
     struct bpf_list_node list_node;
     struct bpf_refcount refcount;
  };

  SEC("data1") struct bpf_lock lock1; // lock1 protects rb_root
  SEC("data1") struct bpf_rb_root rb_root contain(elem, rb_node);
  SEC("data2") struct bpf_lock lock2; // lock2 protects list_head
  SEC("data2") struct bpf_list_head list_head contain(elem, list_node);

  elem = bpf_obj_alloc(bpf_core_type_id_local(struct elem));

  bpf_lock(&lock1);
  if (bpf_rb_add(&elem->rb_node, &rb_root, cb));
  bpf_unlock(&lock1);

  bpf_lock(&lock2);
  if (bpf_list_add(&elem->list_node, &list_head));
  bpf_unlock(&lock2);
  bpf_obj_put(elem);

  bpf_obj_alloc automatically sets refcount to 1.
  bpf_rb_add() and bpf_list_add() automatically increment refcount.
  This is achieved by passing hidden offset to refcount into these helpers.
  Explicit operations on bpf_refcount can be allowed in theory,
  but it's simpler to start with implicit operations.
  Eventually explicit destructor for 'struct elem' would be needed as well.
  For now it will be implicit. The verifier will recursively destroy the object
  if 'struct elem' has other containers like bpf_rb_root or bpf_list_head.

- bpf_rb_add() also checks that owner field hidden inside bpf_rb_node is still NULL.
  Since the object is shared the multiple CPUs can obtain a pointer to elem and
  attemp to insert it into different link lists.
  bpf_rb_add() can fail, but bpf program can ignore the failure.
  It has to call bpf_obj_put() regardless.
  bpf_obj_put will decrement refcnt and will call bpf_obj_free() when it reaches zero.

- allow one level of nesting:
  struct elem {
     int var;
     struct bpf_rb_node rb_node;
     struct bpf_list_node list_node;
     struct bpf_refcount refcount;

     struct bpf_lock lock; // lock that protects nested_root
     struct bpf_rb_root nested_root contain(elem2, node);
  };
  if bpf_rb_node and bpf_rb_root are seen in the same struct
  the contain() tag has to be different than the struct elem.
  Other circular checks might be necessary.

Implementation steps:
1. allow single owner for lock, rbtree, link_list
2. add bpf_refcount and shared elems
3. nested

Thoughts?
