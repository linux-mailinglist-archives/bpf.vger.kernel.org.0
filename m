Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D986EBB7F
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 23:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDVV0J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 17:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjDVV0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 17:26:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611192D73
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 14:26:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a686260adcso36760885ad.0
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682198762; x=1684790762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbnxeT+XG5lJmoAt86CnzxaKgE14MLUjS9f+qo7eKc8=;
        b=cwBiWXIiZGhw3yUHgcF+dPEb6y7NddchhL5mt2lKy6OjphUD73l83u3F7G8MxMQbh3
         baYao9jUze2/n8f/yFoNik0ui9PHlAgdr7fiesYxYs+3/PT0EqFSYZ9cSNLq2BAjV0+b
         jv/PJbhZoBOIZmp00rcb90g/LQCMRhhmoIcBTwyveHOsR6AoZU1hDz1yv0tym0OeYS+m
         kZz/9G6+2Bcxbd+/HZoAnlyRPa+Tl/qOdWbsiJPvIQUNEiVu2gSvIv/EsKLwp0HjoSNt
         qgvVEmz/dh1mWlJefPOiVbv9M3DdCdiDE7x88bYdSs4Tgl/VYTQLmD+oZwK182vuqeMu
         OmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682198762; x=1684790762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbnxeT+XG5lJmoAt86CnzxaKgE14MLUjS9f+qo7eKc8=;
        b=WzlgDBsMdxvBFFMURU6XAs58a7NWCJjlFi1JcajSyelN/5W0eF6ILsrhrVBaz6CMt7
         6xfOv0tLhcIJ4kPVRu6xgpM1ehx4s7UH98WhioqmIJVs53cgR5/BgefNgHhUs7ch9hOT
         CmM6M8Q+FM+NHCtcb/s7ekI80fkR4961Lzr3a4/6ws1UvQ5k35zp4WQZa3PZ4vLB0Okf
         iV+QXSPiGGmUtUr8ca0XeCEvF+bquYtzVXBicgpoY3RqDC7/cheEOHQE1mAKC5jA7n7S
         OfC5QfuPO4yHPQlezp1aMt9pieQwFvg3djLJAQZTzyawkZWFum8UjBbcUqRymaERTEJe
         2WfA==
X-Gm-Message-State: AAQBX9eyM+7dGKPRW7kRhgNUg4s1HFKz1SYO8abMRIh74XIO9Ln2uUyT
        s4UApVkEepm+3cCdjiH6ARw=
X-Google-Smtp-Source: AKy350ay6KS6GmiGwmX04Bdd1wVntbVUfp+RfZdYxu7+JgUeTY+mCw3RzR6/X2r+z3yzwhHi10ZFSw==
X-Received: by 2002:a17:903:2442:b0:19f:188c:3e34 with SMTP id l2-20020a170903244200b0019f188c3e34mr11067445pls.53.1682198762072;
        Sat, 22 Apr 2023 14:26:02 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:ef5e])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902ed4100b001a6ebc39fd9sm4325267plb.309.2023.04.22.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 14:26:01 -0700 (PDT)
Date:   Sat, 22 Apr 2023 14:25:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 0/9] Shared ownership for local kptrs
Message-ID: <20230422212558.7qoet6aexkc5axbq@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xyut5qnwivyeru@ysdq543otzv2>
 <20230422032136.fiyt7btkvol4ujk5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <34lxxctwuknuxuntyc5dpuneylzmbj72b3twwk2xgottb74kkf@jjc3xxffp3z2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34lxxctwuknuxuntyc5dpuneylzmbj72b3twwk2xgottb74kkf@jjc3xxffp3z2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 22, 2023 at 08:42:47PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat, Apr 22, 2023 at 05:21:36AM CEST, Alexei Starovoitov wrote:
> > On Sat, Apr 22, 2023 at 04:03:45AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Sat, Apr 15, 2023 at 10:18:02PM CEST, Dave Marchevsky wrote:
> > > > This series adds support for refcounted local kptrs to the verifier. A local
> > > > kptr is 'refcounted' if its type contains a struct bpf_refcount field:
> > > >
> > > >   struct refcounted_node {
> > > >     long data;
> > > >     struct bpf_list_node ll;
> > > >     struct bpf_refcount ref;
> > > >   };
> > > >
> > > > bpf_refcount is used to implement shared ownership for local kptrs.
> > > >
> > > > Motivating usecase
> > > > ==================
> > > >
> > > > If a struct has two collection node fields, e.g.:
> > > >
> > > >   struct node {
> > > >     long key;
> > > >     long val;
> > > >     struct bpf_rb_node rb;
> > > >     struct bpf_list_node ll;
> > > >   };
> > > >
> > > > It's not currently possible to add a node to both the list and rbtree:
> > > >
> > > >   long bpf_prog(void *ctx)
> > > >   {
> > > >     struct node *n = bpf_obj_new(typeof(*n));
> > > >     if (!n) { /* ... */ }
> > > >
> > > >     bpf_spin_lock(&lock);
> > > >
> > > >     bpf_list_push_back(&head, &n->ll);
> > > >     bpf_rbtree_add(&root, &n->rb, less); /* Assume a resonable less() */
> > > >     bpf_spin_unlock(&lock);
> > > >   }
> > > >
> > > > The above program will fail verification due to current owning / non-owning ref
> > > > logic: after bpf_list_push_back, n is a non-owning reference and thus cannot be
> > > > passed to bpf_rbtree_add. The only way to get an owning reference for the node
> > > > that was added is to bpf_list_pop_{front,back} it.
> > > >
> > > > More generally, verifier ownership semantics expect that a node has one
> > > > owner (program, collection, or stashed in map) with exclusive ownership
> > > > of the node's lifetime. The owner free's the node's underlying memory when it
> > > > itself goes away.
> > > >
> > > > Without a shared ownership concept it's impossible to express many real-world
> > > > usecases such that they pass verification.
> > > >
> > > > Semantic Changes
> > > > ================
> > > >
> > > > Before this series, the verifier could make this statement: "whoever has the
> > > > owning reference has exclusive ownership of the referent's lifetime". As
> > > > demonstrated in the previous section, this implies that a BPF program can't
> > > > have an owning reference to some node if that node is in a collection. If
> > > > such a state were possible, the node would have multiple owners, each thinking
> > > > they have exclusive ownership. In order to support shared ownership it's
> > > > necessary to modify the exclusive ownership semantic.
> > > >
> > > > After this series' changes, an owning reference has ownership of the referent's
> > > > lifetime, but it's not necessarily exclusive. The referent's underlying memory
> > > > is guaranteed to be valid (i.e. not free'd) until the reference is dropped or
> > > > used for collection insert.
> > > >
> > > > This change doesn't affect UX of owning or non-owning references much:
> > > >
> > > >   * insert kfuncs (bpf_rbtree_add, bpf_list_push_{front,back}) still require
> > > >     an owning reference arg, as ownership still must be passed to the
> > > >     collection in a shared-ownership world.
> > > >
> > > >   * non-owning references still refer to valid memory without claiming
> > > >     any ownership.
> > > > [...]
> > >
> > > I think there are a series of major issues right now. I am not sure everything
> > > can be addressed using bug fixes.
> > >
> > > If I had to summarize the main problems in one liners:
> > > The mutation of the node fields of an object can be racy.
> > > Lack of collection identity either at runtime or verification.
> > >
> > > --
> > >
> > > It is possible for multiple CPUs to get owned references to an object containing
> > > a rbtree or list node, and they can attempt to modify those fields in parallel
> > > without any synchronization.
> > >
> > > CPU 0					CPU 1
> > > n = bpf_obj_new(...)
> > > m = bpf_refcount_acquire(n)
> > > kptr_xchg(map, m)
> > > 					m = kptr_xchg(map, NULL)
> > > // m == n
> > > bpf_spin_lock(lock1)			bpf_spin_lock(lock2)
> > > bpf_rbtree_add(rbtree1, m)		bpf_rbtree_add(rbtree2, n)
> > > 	if (!RB_EMPTY_NODE)			if (!RB_EMPTY_NODE) // RACE, both continue with 'else'
> > > bpf_spin_unlock(lock1)			bpf_spin_unlock(lock2)
> > >
> > > --
> > >
> > > Blocking kptr_xchg for shared ownership nodes as a stopgap solution won't be
> > > sufficient. Consider this:
> > >
> > > Two CPUs can do (consider rbtree1 having the only element we add from CPU 0):
> > >
> > > CPU 0					CPU 1
> > > n = bpf_obj_new(...)
> > > bpf_spin_lock(lock1)
> > > bpf_rbtree_add(rbtree1, n)
> > > m = bpf_refcount_acquire(n)
> > > bpf_spin_unlock(lock1)
> > > 					bpf_spin_lock(lock1)
> > > 					n = bpf_rbtree_remove(bpf_rbtree_first(rbtree1))
> > > 					bpf_spin_unlock(lock1)
> > > // let m == n
> > > bpf_spin_lock(lock1)			bpf_spin_lock(lock2)
> > > bpf_rbtree_add(rbtree1, m)		bpf_rbtree_add(rbtree2, n)
> > > 	if (!RB_EMPTY_NODE)			if (!RB_EMPTY_NODE) // RACE, both continue with 'else'
> > > bpf_spin_unlock(lock1)			bpf_spin_unlock(lock2)
> > >
> > > --
> > >
> > > There's also no discussion on the problem with collection identities we
> > > discussed before (maybe you plan to address it later):
> > > https://lore.kernel.org/bpf/45e80d2e-af16-8584-12ec-c4c301d9a69d@meta.com
> > >
> > > But static tracaking won't be sufficient any longer. Considering another case
> > > where the runtime will be confused about which rbtree a node belongs to.
> > >
> > > CPU 0								CPU 1
> > > n = bpf_obj_new(...)
> > > m = bpf_refcount_acquire(n)
> > > kptr_xchg(map, m)
> > > 								p = kptr_xchg(map, NULL)
> > > 								lock(lock2)
> > > 								bpf_rbtree_add(rbtree2, p->rnode)
> > > 								unlock(lock2)
> > > lock(lock1)
> > > bpf_list_push_back(head1, n->lnode)
> > > // make n non-owning ref
> > > bpf_rbtree_remove(rbtree1, n->rnode); // OOPS, remove without lock2
> > > unlock(lock1)
> >
> > Thanks for describing the races.
> >
> > > --
> > >
> > > I can come up with multiple other examples. The point I'm trying to drive home
> > > is that it's a more fundamental issue in the way things are set up right now,
> > > not something that was overlooked during the implementation.
> > >
> > > The root cause is that access to a node's fields is going to be racy once
> > > multiple CPUs have *mutable* references to it. The lack of ownership information
> > > mapped to the collection either at runtime or during verification is also a
> > > separate problem.
> > >
> > > When we were discussing this a few months ago, we tried to form consensus on
> > > synchronizing updates over a node using an 'owner' pointer to eliminate similar
> > > races. Every node field has an associated owner field, which each updater
> > > modifying that node synchronizes over.
> > >
> > > In short:
> > > Node's owner describes its state at runtime.
> > > node.owner == ptr_of_ds // part of DS
> >
> > what is DS ?
> >
> 
> The graph data structure.
> 
> > > node.owner == NULL // not part of DS
> > > node.owner == BPF_PTR_POISON // busy (about to go to NULL or ptr_of_ds before BPF_EXIT)
> > >
> > > cmpxchg(node.owner, NULL, BPF_PTR_POISON) to make a free node busy.
> > > bpf_rbtree_add and such will do this to claim node ownership before trying to
> > > link it in, and then store owner to ptr_of_ds. The _store_ will be the
> > > *linearization* point of bpf_rbtree_add, not cmpxchg.
> > >
> > > READ_ONCE(node.owner) == ptr_of_ds to ensure node belongs to locked ds, and will
> > > remain in this state until the end of CS, since ptr_to_ds to NULL only happens
> > > in remove under a held lock for the ds. bpf_rbtree_remove will do this check
> > > before WRITE_ONCE of NULL to unlink a node.
> > >
> > > Ofcourse, this is slower, and requires extra space in the object, but unless
> > > this or something else is used to eliminate races, there will be bugs.
> >
> > Makes sense to me. Where do you propose to store the owner? Another explicit
> > field that bpf prog has to provide inside a node?
> > A hidden field in bpf_refcount ?
> > A hidden field in bpf_list_node / bpf_rb_node ?
> 
> It will have to be with each bpf_list_node / bpf_rb_node.

yeah. realized after pressed 'send'.

> Pseudocode wise, this is how things will work:
> 
> bpf_rbtree_add(rbtree, node):
> 	// Move a node from free to busy state
> 	if (!cmpxchg(node.owner, NULL, BPF_PTR_POISON))
> 		return -EINVAL

should be bpf_obj_drop here instead of plain return.
In other words the current 
if (!RB_EMPTY_NODE()) bpf_obj_drop
will be replaced by the above cmpxchg

> 	__rb_add(...)
> 	WRITE_ONCE(node.owner, rbtree)
> 
> bpf_rbtree_remove(rbtree, node):
> 	// Check if node is part of rbtree:
> 	// If != rbtree, it could be changing concurrently
> 	// If == rbtree, changing it requires the lock we are holding
> 	if (READ_ONCE(node.owner) != rbtree)
> 		return -EINVAL

should be 'return NULL'.
The above check will replace current RB_EMPTY_NODE check.

> 	__rb_remove(...)
> 	WRITE_ONCE(node.owner, NULL)

comparing to existing code it's only extra WRITE_ONCE
and cmpxchg instead of load+cmp.
imo the perf cost is roughly the same.
Because of that there is no need to have
two bpf_rbtree_add/remove for shared/exclusive nodes.

> Likewise for the linked list helpers.
> 
> My opinion would be to have a different bpf_list_node_shared and
> bpf_rb_node_shared for refcount_off >= 0 case, which encode both bpf_list_node
> and bpf_rb_node and their owner together, since the space and runtime check
> tradeoff is not required if you're using exclusive ownership.

true, but runtime performance of bpf_rbtree_add/remove is the same for both cases.
With bpf_rb_node_shared the bpf prog will save 8 bytes of memory at the expense
of plenty verifier complexity that would need to have two checks
if (btf_id == bpf_rb_node_shared || btf_id == bpf_rb_node) in a bunch of places
and one of the two in another set of places.
I'd rather waste 8 bytes than complicate the verifier.
Having valid node->owner for exclusive rb-tree and link list is a nice debug feature too.
Not saying we screwed up non-shared rb-tree, but I won't be surprised if
somebody will figure out how to construct similar race there in the future.

> One more point is that you can minimize cost of cmpxchg by adding compound
> operation helpers.
> 
> For instance (under appropriate locking):
> 
> bpf_rbtree_move(rbtree1, rbtree2, node):
> 	if (READ_ONCE(node.owner) != rbtree1)
> 		return -EINVAL
> 	__rb_remove(rbtree1, node)
> 	__rb_add(rbtree2, node)
> 	WRITE_ONCE(node.owner, rbtree2)
> 
> Instead of:
> 	bpf_rbtree_remove(rbtree1, node)
> 	bpf_rbtree_add(rbtree2, node)

That makes sense. Not urgent. Distant follow up.
