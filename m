Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522BB6EBAE4
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 20:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDVSmx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 14:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVSmw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 14:42:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C719BD
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 11:42:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso406199866b.2
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682188969; x=1684780969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/oKFFC0hGYyokaEScPEJX/oEmFF91P++fpXVnF3bi0=;
        b=EPQxj7Qvrt8Om00UpAVnKQt4lPdZap5kEnTyDhplFVU1jC4jif84fiY4esCdPGAxbA
         qTZ2y5C4z31SZ3pD16Pf4ZlJoyJJQjRKmxV4I7+InxHnscCT4bPS8UhdA/jtQk5uJY6O
         MX7OXZEtT2fdJZoQ33l9xq8mgpqI8RazgROP4ClZPHIICcqJ1GHnVfh4cXmXeuFzaexd
         SfIpQSlF7vOIkWRk14P3EvjV/uqVNrth+waD/t/KjzATShny6L7CnpkFxGgcnCMRgnzO
         BHgECdKXvM50RsOPkDr6h2ax3yjQDOuPaq4Jg//mk6lyKeefDSY1UhxjD9wdfN7c2D2K
         wLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682188969; x=1684780969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/oKFFC0hGYyokaEScPEJX/oEmFF91P++fpXVnF3bi0=;
        b=HOoM33xeBalc+K44mME+9893dHX7SJywph7e4bD1LEogfczx9s03u339ysv0SGbtWC
         iRLraJpiZveJXLzdCBdt5J7UUGiVitie/6gfhe3ACK6KUM+KNJo7M3Mm4nuIWNmKdjO9
         SMCnR4fH30OqMGE8iehdB6qEqJYdc6ywI+ELtrUNrqz+IF8XRVeNhOexnlFbnmE0iOlj
         CkJQghYAHiFl76/JVDCb0VRxrnRdqeHAzEcfsuzZxbM+d+KW6EkmttHd06isXlRXsbCP
         RMgbPXHAgbEdttfwANFeH1TvDru1PXzN6DEb+jKMQnxoJ8RVMC9ouJvxhAieWce9hD5Y
         xsTQ==
X-Gm-Message-State: AAQBX9eA/bef+yKlw5AFt9JfY49OK1hZVpAjvEVQbyo/HQQZ3NXef++x
        5SPfqnStNrol6pwU6feS3RI=
X-Google-Smtp-Source: AKy350Zz0qm0SfCi1y5nj48S11eys9xLULBIi8DoFQrtnxAtekbEOwBGS11ltHokE5FSy6yg4V2aqg==
X-Received: by 2002:a17:906:950b:b0:94f:cee:56f3 with SMTP id u11-20020a170906950b00b0094f0cee56f3mr5583611ejx.2.1682188968999;
        Sat, 22 Apr 2023 11:42:48 -0700 (PDT)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id qm10-20020a170907674a00b0094f282fc29asm3487957ejc.207.2023.04.22.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 11:42:48 -0700 (PDT)
Date:   Sat, 22 Apr 2023 20:42:47 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 0/9] Shared ownership for local kptrs
Message-ID: <34lxxctwuknuxuntyc5dpuneylzmbj72b3twwk2xgottb74kkf@jjc3xxffp3z2>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xyut5qnwivyeru@ysdq543otzv2>
 <20230422032136.fiyt7btkvol4ujk5@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422032136.fiyt7btkvol4ujk5@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 22, 2023 at 05:21:36AM CEST, Alexei Starovoitov wrote:
> On Sat, Apr 22, 2023 at 04:03:45AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Sat, Apr 15, 2023 at 10:18:02PM CEST, Dave Marchevsky wrote:
> > > This series adds support for refcounted local kptrs to the verifier. A local
> > > kptr is 'refcounted' if its type contains a struct bpf_refcount field:
> > >
> > >   struct refcounted_node {
> > >     long data;
> > >     struct bpf_list_node ll;
> > >     struct bpf_refcount ref;
> > >   };
> > >
> > > bpf_refcount is used to implement shared ownership for local kptrs.
> > >
> > > Motivating usecase
> > > ==================
> > >
> > > If a struct has two collection node fields, e.g.:
> > >
> > >   struct node {
> > >     long key;
> > >     long val;
> > >     struct bpf_rb_node rb;
> > >     struct bpf_list_node ll;
> > >   };
> > >
> > > It's not currently possible to add a node to both the list and rbtree:
> > >
> > >   long bpf_prog(void *ctx)
> > >   {
> > >     struct node *n = bpf_obj_new(typeof(*n));
> > >     if (!n) { /* ... */ }
> > >
> > >     bpf_spin_lock(&lock);
> > >
> > >     bpf_list_push_back(&head, &n->ll);
> > >     bpf_rbtree_add(&root, &n->rb, less); /* Assume a resonable less() */
> > >     bpf_spin_unlock(&lock);
> > >   }
> > >
> > > The above program will fail verification due to current owning / non-owning ref
> > > logic: after bpf_list_push_back, n is a non-owning reference and thus cannot be
> > > passed to bpf_rbtree_add. The only way to get an owning reference for the node
> > > that was added is to bpf_list_pop_{front,back} it.
> > >
> > > More generally, verifier ownership semantics expect that a node has one
> > > owner (program, collection, or stashed in map) with exclusive ownership
> > > of the node's lifetime. The owner free's the node's underlying memory when it
> > > itself goes away.
> > >
> > > Without a shared ownership concept it's impossible to express many real-world
> > > usecases such that they pass verification.
> > >
> > > Semantic Changes
> > > ================
> > >
> > > Before this series, the verifier could make this statement: "whoever has the
> > > owning reference has exclusive ownership of the referent's lifetime". As
> > > demonstrated in the previous section, this implies that a BPF program can't
> > > have an owning reference to some node if that node is in a collection. If
> > > such a state were possible, the node would have multiple owners, each thinking
> > > they have exclusive ownership. In order to support shared ownership it's
> > > necessary to modify the exclusive ownership semantic.
> > >
> > > After this series' changes, an owning reference has ownership of the referent's
> > > lifetime, but it's not necessarily exclusive. The referent's underlying memory
> > > is guaranteed to be valid (i.e. not free'd) until the reference is dropped or
> > > used for collection insert.
> > >
> > > This change doesn't affect UX of owning or non-owning references much:
> > >
> > >   * insert kfuncs (bpf_rbtree_add, bpf_list_push_{front,back}) still require
> > >     an owning reference arg, as ownership still must be passed to the
> > >     collection in a shared-ownership world.
> > >
> > >   * non-owning references still refer to valid memory without claiming
> > >     any ownership.
> > > [...]
> >
> > I think there are a series of major issues right now. I am not sure everything
> > can be addressed using bug fixes.
> >
> > If I had to summarize the main problems in one liners:
> > The mutation of the node fields of an object can be racy.
> > Lack of collection identity either at runtime or verification.
> >
> > --
> >
> > It is possible for multiple CPUs to get owned references to an object containing
> > a rbtree or list node, and they can attempt to modify those fields in parallel
> > without any synchronization.
> >
> > CPU 0					CPU 1
> > n = bpf_obj_new(...)
> > m = bpf_refcount_acquire(n)
> > kptr_xchg(map, m)
> > 					m = kptr_xchg(map, NULL)
> > // m == n
> > bpf_spin_lock(lock1)			bpf_spin_lock(lock2)
> > bpf_rbtree_add(rbtree1, m)		bpf_rbtree_add(rbtree2, n)
> > 	if (!RB_EMPTY_NODE)			if (!RB_EMPTY_NODE) // RACE, both continue with 'else'
> > bpf_spin_unlock(lock1)			bpf_spin_unlock(lock2)
> >
> > --
> >
> > Blocking kptr_xchg for shared ownership nodes as a stopgap solution won't be
> > sufficient. Consider this:
> >
> > Two CPUs can do (consider rbtree1 having the only element we add from CPU 0):
> >
> > CPU 0					CPU 1
> > n = bpf_obj_new(...)
> > bpf_spin_lock(lock1)
> > bpf_rbtree_add(rbtree1, n)
> > m = bpf_refcount_acquire(n)
> > bpf_spin_unlock(lock1)
> > 					bpf_spin_lock(lock1)
> > 					n = bpf_rbtree_remove(bpf_rbtree_first(rbtree1))
> > 					bpf_spin_unlock(lock1)
> > // let m == n
> > bpf_spin_lock(lock1)			bpf_spin_lock(lock2)
> > bpf_rbtree_add(rbtree1, m)		bpf_rbtree_add(rbtree2, n)
> > 	if (!RB_EMPTY_NODE)			if (!RB_EMPTY_NODE) // RACE, both continue with 'else'
> > bpf_spin_unlock(lock1)			bpf_spin_unlock(lock2)
> >
> > --
> >
> > There's also no discussion on the problem with collection identities we
> > discussed before (maybe you plan to address it later):
> > https://lore.kernel.org/bpf/45e80d2e-af16-8584-12ec-c4c301d9a69d@meta.com
> >
> > But static tracaking won't be sufficient any longer. Considering another case
> > where the runtime will be confused about which rbtree a node belongs to.
> >
> > CPU 0								CPU 1
> > n = bpf_obj_new(...)
> > m = bpf_refcount_acquire(n)
> > kptr_xchg(map, m)
> > 								p = kptr_xchg(map, NULL)
> > 								lock(lock2)
> > 								bpf_rbtree_add(rbtree2, p->rnode)
> > 								unlock(lock2)
> > lock(lock1)
> > bpf_list_push_back(head1, n->lnode)
> > // make n non-owning ref
> > bpf_rbtree_remove(rbtree1, n->rnode); // OOPS, remove without lock2
> > unlock(lock1)
>
> Thanks for describing the races.
>
> > --
> >
> > I can come up with multiple other examples. The point I'm trying to drive home
> > is that it's a more fundamental issue in the way things are set up right now,
> > not something that was overlooked during the implementation.
> >
> > The root cause is that access to a node's fields is going to be racy once
> > multiple CPUs have *mutable* references to it. The lack of ownership information
> > mapped to the collection either at runtime or during verification is also a
> > separate problem.
> >
> > When we were discussing this a few months ago, we tried to form consensus on
> > synchronizing updates over a node using an 'owner' pointer to eliminate similar
> > races. Every node field has an associated owner field, which each updater
> > modifying that node synchronizes over.
> >
> > In short:
> > Node's owner describes its state at runtime.
> > node.owner == ptr_of_ds // part of DS
>
> what is DS ?
>

The graph data structure.

> > node.owner == NULL // not part of DS
> > node.owner == BPF_PTR_POISON // busy (about to go to NULL or ptr_of_ds before BPF_EXIT)
> >
> > cmpxchg(node.owner, NULL, BPF_PTR_POISON) to make a free node busy.
> > bpf_rbtree_add and such will do this to claim node ownership before trying to
> > link it in, and then store owner to ptr_of_ds. The _store_ will be the
> > *linearization* point of bpf_rbtree_add, not cmpxchg.
> >
> > READ_ONCE(node.owner) == ptr_of_ds to ensure node belongs to locked ds, and will
> > remain in this state until the end of CS, since ptr_to_ds to NULL only happens
> > in remove under a held lock for the ds. bpf_rbtree_remove will do this check
> > before WRITE_ONCE of NULL to unlink a node.
> >
> > Ofcourse, this is slower, and requires extra space in the object, but unless
> > this or something else is used to eliminate races, there will be bugs.
>
> Makes sense to me. Where do you propose to store the owner? Another explicit
> field that bpf prog has to provide inside a node?
> A hidden field in bpf_refcount ?
> A hidden field in bpf_list_node / bpf_rb_node ?

It will have to be with each bpf_list_node / bpf_rb_node.

Pseudocode wise, this is how things will work:

bpf_rbtree_add(rbtree, node):
	// Move a node from free to busy state
	if (!cmpxchg(node.owner, NULL, BPF_PTR_POISON))
		return -EINVAL
	__rb_add(...)
	WRITE_ONCE(node.owner, rbtree)

bpf_rbtree_remove(rbtree, node):
	// Check if node is part of rbtree:
	// If != rbtree, it could be changing concurrently
	// If == rbtree, changing it requires the lock we are holding
	if (READ_ONCE(node.owner) != rbtree)
		return -EINVAL
	__rb_remove(...)
	WRITE_ONCE(node.owner, NULL)

Likewise for the linked list helpers.

My opinion would be to have a different bpf_list_node_shared and
bpf_rb_node_shared for refcount_off >= 0 case, which encode both bpf_list_node
and bpf_rb_node and their owner together, since the space and runtime check
tradeoff is not required if you're using exclusive ownership.

One more point is that you can minimize cost of cmpxchg by adding compound
operation helpers.

For instance (under appropriate locking):

bpf_rbtree_move(rbtree1, rbtree2, node):
	if (READ_ONCE(node.owner) != rbtree1)
		return -EINVAL
	__rb_remove(rbtree1, node)
	__rb_add(rbtree2, node)
	WRITE_ONCE(node.owner, rbtree2)

Instead of:
	bpf_rbtree_remove(rbtree1, node)
	bpf_rbtree_add(rbtree2, node)
