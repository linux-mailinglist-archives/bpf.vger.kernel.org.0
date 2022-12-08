Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28C64775D
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 21:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLHUhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 15:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiLHUhA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 15:37:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C128F095
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 12:36:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2738559pjo.3
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 12:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRZD9Pu6TaucIoIP+CfAoCz/guQWFWy/P0O2lQEnRc0=;
        b=bTzACQnHccEKjMPlec8RPJ+2YlUhtV+ezh8bBg5K8e/xysnBFfOalZGp1MFG1kkFNP
         Lyp0ta6T0RuA4UGnClYJy3L2m13lfStL87bYEpdsZ9wsgW7B1tm9MsnBe/EL/gDcUQSd
         cBxsC94T9datKKMuXGyE4M+YBimzLBwy7WSBtewcrjqpFdM+9BZ8HIaaC4jsEJCkRqz3
         fZB/UIThpzQfR8u9dieoLHalAWYHr6tq9dEyW5pt/tyLUILjv/9K6syUcXkI8FxdwPy0
         53PWLIy7P7raEUDdLjgecL+iUsBWXnlyHwdcKGMFAFafeRuwkmJkW6UP2Jeqha9Spwmn
         jRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRZD9Pu6TaucIoIP+CfAoCz/guQWFWy/P0O2lQEnRc0=;
        b=XMSo17hk1YA0AR2bjg0sceBqSTTH09VSUZsOaKHndslDNeI7OmIgdy7NTt0Qyez1BR
         pxkHr2Ba1F3w98+Udo5mQKyK0uGPtmT8OnuHDImrbn/UqPFAaVKv9Dvbylwl5ZDtYiAF
         Lj3A2Aln5iw9mn4NU0kHU736GV5CH/bencVFgcBo6+Xl7+IPgvtbUiLPmgdcrbr28gM7
         2y6ORZKKsYeaeBQwykD2wkLXtedEY3W4EE8oTCpZNzrXI2iQVV/ockIJOpMbEy+NZWsA
         yiPuOOwRrz7m9JsZ9kISApdpHuCJLN7AViqnfE8AJl69vkOcl9IyQbw5M3vaXuf8cSyf
         Ow0Q==
X-Gm-Message-State: ANoB5pkqPb2rgTYHOL/XJ7e3uTkCdvdHSPFXHZxBvs9Y+UOugJeOQxsw
        +K+Ze3NU5xvh/k++ot/EdPM=
X-Google-Smtp-Source: AA0mqf5C+iPydmM3mCL+Ah/TgKwiVGiqIzAm3lCRFKDMT7YHyrijifnQrFL6qSJPw+ddkcVwPWHUkg==
X-Received: by 2002:a17:90b:3c1:b0:219:2b5f:148b with SMTP id go1-20020a17090b03c100b002192b5f148bmr3273819pjb.48.1670531817904;
        Thu, 08 Dec 2022 12:36:57 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id r23-20020a63d917000000b00478f0aa945csm3330293pgg.7.2022.12.08.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:36:57 -0800 (PST)
Date:   Thu, 8 Dec 2022 12:36:54 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@meta.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Message-ID: <20221208203654.zwwqxzjhx563d3z3@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
 <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
 <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
 <33b0c075-3551-b57a-76e4-bc40452b3253@meta.com>
 <20221208035140.skuadnybf5aqb4o5@macbook-pro-6.dhcp.thefacebook.com>
 <4dc1def4-74a1-d1a6-386a-32e84962a55a@meta.com>
 <20221208125729.73qr3glbyd7p6buq@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208125729.73qr3glbyd7p6buq@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 08, 2022 at 06:27:29PM +0530, Kumar Kartikeya Dwivedi wrote:
> 
> I don't mind using active_lock.id for invalidation, but using reg->id to
> associate it with reg is a bad idea IMO, it's already preserved and set when the
> object has bpf_spin_lock in it, and it's going to allow doing bpf_spin_unlock
> with that non-owing ref if it has a spin lock, essentially unlocking different
> spin lock if the reg->btf of already locked spin lock reg is same due to same
> active_lock.id.

Right. Overwriting reg->id was a bad idea.

> Even if you prevent it somehow it's more confusing to overload reg->id again for
> this purpose.
> 
> It makes more sense to introduce a new nonref_obj_id instead dedicated for this
> purpose, to associate it back to the reg->id of the collection it is coming from.

nonref_obj_id name sounds too generic and I'm not sure that it shouldn't be
connected to reg->id the way we do it for ref_obj_id.

> Also, there are two cases of invalidation, one is on remove from rbtree, which
> should only invalidate non-owning references into the rbtree, and one is on
> unlock, which should invalidate all non-owning references.

Two cases only if we're going to do invalidation on rbtree_remove.

> bpf_rbtree_remove shouldn't invalidate non-owning into list protected by same
> lock, but unlocking should do it for both rbtree and list non-owning refs it is
> protecting.
> 
> So it seems you will have to maintain two IDs for non-owning referneces, one for
> the collection it comes from, and one for the lock region it is obtained in.

Right. Like this ?
collection_id = rbroot->reg->id; // to track the collection it came from
active_lock_id = cur_state->active_lock.id // to track the lock region

but before we proceed let me demonstrate an example where
cleanup on rbtree_remove is not user friendly:

bpf_spin_lock
x = bpf_list_first(); if (!x) ..
y = bpf_list_last(); if (!y) ..

n = bpf_list_remove(x); if (!n) ..

bpf_list_add_after(n, y); // we should allow this
bpf_spin_unlock

We don't have such apis right now.
The point here that cleanup after bpf_list_remove/bpf_rbtree_remove will destroy
all regs that point somewhere in the collection.
This way we save run-time check in bpf_rbtree_remove, but sacrificing usability.

x and y could be pointing to the same thing.
In such case bpf_list_add_after() should fail in runtime after discovering
that 'y' is unlinked.

Similarly with bpf_rbtree_add().
Currently it cannot fail. It takes owning ref and will release it.
We can mark it as KF_RELEASE and no extra verifier changes necessary.

But in the future we might have failing add/insert operations on lists and rbtree.
If they're failing we'd need to struggle with 'conditional release' verifier additions,
the bpf prog would need to check return value, etc.

I think we better deal with it in run-time.
The verifier could supply bpf_list_add_after() with two hidden args:
- container_of offset (delta between rb_node and begining of prog's struct)
- struct btf_struct_meta *meta
Then inside bpf_list_add_after or any failing KF_RELEASE kfunc
it can call bpf_obj_drop_impl() that element.
Then from the verifier pov the KF_RELEASE function did the release
and 'owning ref' became 'non-owning ref'.

> > >> And you're also adding 'untrusted' here, mainly as a result of
> > >> bpf_rbtree_add(tree, node) - 'node' becoming untrusted after it's added,
> > >> instead of becoming a non-owning ref. 'untrusted' would have state like:
> > >>
> > >> PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
> > >> PTR_UNTRUSTED
> > >> ref_obj_id == 0?
> > >
> > > I'm not sure whether we really need full untrusted after going through bpf_rbtree_add()
> > > or doing 'non-owning' is enough.
> > > If it's full untrusted it will be:
> > > PTR_TO_BTF_ID | PTR_UNTRUSTED && ref_obj_id == 0
> > >
> >
> > Yeah, I don't see what this "full untrusted" is giving us either. Let's have
> > "cleanup non-owning refs on spin_unlock" just invalidate the regs for now,
> > instead of converting to "full untrusted"?
> >
> 
> +1, I prefer invalidating completely on unlock.

fine by me.

> 
> I think it's better to clean by invalidating. We have better tools to form
> untrusted pointers (like bpf_rdonly_cast) now if the BPF program writer needs
> such an escape hatch for some reason. It's also easier to review where an
> untrusted pointer is being used in a program, and has zero cost at runtime.

ok. Since it's more strict we can relax to untrusted later if necessary.

> So far I'm leaning towards:
> 
> bpf_rbtree_add(node) : node becomes non-owned ref
> bpf_spin_unlock(lock) : node is invalidated

ok

> > > Currently I'm leaning towards PTR_UNTRUSTED for cleanup after bpf_spin_unlock
> > > and non-owning after bpf_rbtree_add.
> > >
> > > Walking the example from previous email:
> > >
> > > struct bpf_rbtree_iter it;
> > > struct bpf_rb_node * node;
> > > struct bpf_rb_node *n, *m;
> > >
> > > bpf_rbtree_iter_init(&it, rb_root); // locks the rbtree works as bpf_spin_lock
> > > while ((node = bpf_rbtree_iter_next(&it)) {
> > >   // node -> PTR_TO_BTF_ID | MEM_ALLOC | MAYBE_NULL && ref_obj_id == 0
> > >   if (node && node->field == condition) {
> > >
> > >     n = bpf_rbtree_remove(rb_root, node);
> > >     if (!n) ...;
> > >     // n -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == X
> > >     m = bpf_rbtree_remove(rb_root, node); // ok, but fails in run-time
> > >     if (!m) ...;
> > >     // m -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == Y
> > >
> 
> This second remove I would simply disallow as Dave is suggesting during
> verification, by invalidating non-owning refs for rb_root.

Looks like cleanup from non-owning to untrusted|unknown on bpf_rbtree_remove is our
only remaining disagreement.
I feel run-time checks will be fast enough and will improve usabililty.

Also it feels that not doing cleanup on rbtree_remove is simpler to
implement and reason about.

Here is the proposal with one new field 'active_lock_id':

first = bpf_rbtree_first(root) KF_RET_NULL
  check_reg_allocation_locked() checks that root->reg->id == cur->active_lock.id
  R0 = PTR_TO_BTF_ID|MEM_ALLOC|PTR_MAYBE_NULL ref_obj_id = 0;
  R0->active_lock_id = root->reg->id
  R0->id = ++env->id_gen; which will be cleared after !NULL check inside prog.

same way we can add rb_find, rb_find_first,
but not rb_next, rb_prev, since they don't have 'root' argument.

bpf_rbtree_add(root, node, cb); KF_RELEASE.
  needs to see PTR_TO_BTF_ID|MEM_ALLOC node->ref_obj_id > 0
  check_reg_allocation_locked() checks that root->reg->id == cur->active_lock.id
  calls release_reference(node->ref_obj_id)
  converts 'node' to PTR_TO_BTF_ID|MEM_ALLOC ref_obj_id = 0;
  node->active_lock_id = root->reg->id

'node' is equivalent to 'first'. They both point to some element
inside rbtree and valid inside spin_locked region.
It's ok to read|write to both under lock.

removed_node = bpf_rbtree_remove(root, node); KF_ACQUIRE|KF_RET_NULL
  need to see PTR_TO_BTF_ID|MEM_ALLOC node->ref_obj_id = 0; and 
  usual check_reg_allocation_locked(root)
  R0 = PTR_TO_BTF_ID|MEM_ALLOC|MAYBE_NULL
  R0->ref_obj_id = R0->id = acquire_reference_state();
  R0->active_lock_id should stay 0
  mark_reg_unknown(node)

bpf_spin_unlock(lock);
  checks lock->id == cur->active_lock.id
  for all regs in state 
    if (reg->active_lock_id == lock->id)
       mark_reg_unknown(reg)
