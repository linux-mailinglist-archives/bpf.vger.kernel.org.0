Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18C264643A
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLGWqf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 17:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWqe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 17:46:34 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4C83E84
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 14:46:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jn7so18427167plb.13
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 14:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KQyHOZjVHTIgBU5j32bId61Jd6T/gyDZF/vkvyMAWg=;
        b=nziBRAG+r7X8dbkqQnynXpbX+i5cwfLYUkyRe6jyVetOIljD3XtYckQPxOIZiHb+Kd
         E3wQY0nAhAItFv7WDFkN1lGwiR3TwCtXfOD6/pskGbruz96GDfu/qb5PZZ+a6bEY7wc+
         QINQ0XdMqWoiVGcrm/vTQDpeKorfCgux3nCghLXTDX5mWXpeEA0iNCVlUBqv85ZekK6e
         uTBsD6G0zZScDz0CjYR3rVP6BchQxyTBAIORbvxzN2MIrwTkivNk/+yC6KZabSkgyGUy
         G6O1vsVsocK7tI0+flEIB+aiAgjCuzklRiq1mGBvkoFPNAGarRE/TbbqyZAivlhUjSyP
         IT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KQyHOZjVHTIgBU5j32bId61Jd6T/gyDZF/vkvyMAWg=;
        b=fIUtST4FaVRTyYZohrSVzhfPrZsikNn8fDkZaGwXYuYDSVeU/vWBhbtB/ho2MF5H+J
         pQOKwmIxvYD7NZAYrmz+Y+iZbkcw0N6DOmVb2VUV4256tSD0J6XdtoEKJq6H3VqqeysR
         DtWO+T0/jI3xvn5T7jl7UFCEX7aZD/bWGAvPG9N1+79aGV6BxVZvoaNqdQ5RTDq2Ei8d
         ePcz7zQ9xtgi+bjNaIZb/nxkO/2rA5E/esHPf1DeGdM5VMHWxgkJDSxGc4fBi/KUaYZ5
         svM1F6nafm+LU08ldmRzg4CdK3nqJu0xVmST2/h1FVfhc2PNVlh+uQ9ZKdmLcZ58IRle
         mpQA==
X-Gm-Message-State: ANoB5pniUX2Qmbkf7xxVOVp8q43UDmsKqd0klXuGkQTiWlwbGAZt8anT
        +3MIaDiwxz4Ny3XMztrRU7c=
X-Google-Smtp-Source: AA0mqf70nZkCWUr663mT+MBAJ6OGrCuyWWrbagGhvOWVVvLqEWKVnHBFj3Jsv6TuL++MUMxFXpp4zQ==
X-Received: by 2002:a17:902:d2cb:b0:188:8679:bb1e with SMTP id n11-20020a170902d2cb00b001888679bb1emr1666490plc.46.1670453192288;
        Wed, 07 Dec 2022 14:46:32 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b0018912c37c8fsm15028246pln.129.2022.12.07.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:46:31 -0800 (PST)
Date:   Wed, 7 Dec 2022 14:46:28 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 01/13] bpf: Loosen alloc obj test in verifier's
 reg_btf_record
Message-ID: <20221207224628.zwgxlurf2vdpc6gm@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-2-davemarchevsky@fb.com>
 <20221207164121.h6wm5crfhhvekqvd@apollo>
 <a8079b93-15d5-147d-226b-13bbebfda75e@meta.com>
 <20221207185931.hvte3vutd4y4qfh4@macbook-pro-6.dhcp.thefacebook.com>
 <c6e5fb34-3dc5-de80-2e45-c0502be1c3ca@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e5fb34-3dc5-de80-2e45-c0502be1c3ca@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 03:38:55PM -0500, Dave Marchevsky wrote:
> On 12/7/22 1:59 PM, Alexei Starovoitov wrote:
> > On Wed, Dec 07, 2022 at 01:34:44PM -0500, Dave Marchevsky wrote:
> >> On 12/7/22 11:41 AM, Kumar Kartikeya Dwivedi wrote:
> >>> On Wed, Dec 07, 2022 at 04:39:48AM IST, Dave Marchevsky wrote:
> >>>> btf->struct_meta_tab is populated by btf_parse_struct_metas in btf.c.
> >>>> There, a BTF record is created for any type containing a spin_lock or
> >>>> any next-gen datastructure node/head.
> >>>>
> >>>> Currently, for non-MAP_VALUE types, reg_btf_record will only search for
> >>>> a record using struct_meta_tab if the reg->type exactly matches
> >>>> (PTR_TO_BTF_ID | MEM_ALLOC). This exact match is too strict: an
> >>>> "allocated obj" type - returned from bpf_obj_new - might pick up other
> >>>> flags while working its way through the program.
> >>>>
> >>>
> >>> Not following. Only PTR_TO_BTF_ID | MEM_ALLOC is the valid reg->type that can be
> >>> passed to helpers. reg_btf_record is used in helpers to inspect the btf_record.
> >>> Any other flag combination (the only one possible is PTR_UNTRUSTED right now)
> >>> cannot be passed to helpers in the first place. The reason to set PTR_UNTRUSTED
> >>> is to make then unpassable to helpers.
> >>>
> >>
> >> I see what you mean. If reg_btf_record is only used on regs which are args,
> >> then the exact match helps enforce PTR_UNTRUSTED not being an acceptable
> >> type flag for an arg. Most uses of reg_btf_record seem to be on arg regs,
> >> but then we have its use in reg_may_point_to_spin_lock, which is itself
> >> used in mark_ptr_or_null_reg and on BPF_REG_0 in check_kfunc_call. So I'm not
> >> sure that it's only used on arg regs currently.
> >>
> >> Regardless, if the intended use is on arg regs only, it should be renamed to
> >> arg_reg_btf_record or similar to make that clear, as current name sounds like
> >> it should be applicable to any reg, and thus not enforce constraints particular
> >> to arg regs.
> >>
> >> But I think it's better to leave it general and enforce those constraints
> >> elsewhere. For kfuncs this is already happening in check_kfunc_args, where the
> >> big switch statements for KF_ARG_* are doing exact type matching.
> >>
> >>>> Loosen the check to be exact for base_type and just use MEM_ALLOC mask
> >>>> for type_flag.
> >>>>
> >>>> This patch is marked Fixes as the original intent of reg_btf_record was
> >>>> unlikely to have been to fail finding btf_record for valid alloc obj
> >>>> types with additional flags, some of which (e.g. PTR_UNTRUSTED)
> >>>> are valid register type states for alloc obj independent of this series.
> >>>
> >>> That was the actual intent, same as how check_ptr_to_btf_access uses the exact
> >>> reg->type to allow the BPF_WRITE case.
> >>>
> >>> I think this series is the one introducing this case, passing bpf_rbtree_first's
> >>> result to bpf_rbtree_remove, which I think is not possible to make safe in the
> >>> first place. We decided to do bpf_list_pop_front instead of bpf_list_entry ->
> >>> bpf_list_del due to this exact issue. More in [0].
> >>>
> >>>  [0]: https://lore.kernel.org/bpf/CAADnVQKifhUk_HE+8qQ=AOhAssH6w9LZ082Oo53rwaS+tAGtOw@mail.gmail.com
> >>>
> >>
> >> Thanks for the link, I better understand what Alexei meant in his comment on
> >> patch 9 of this series. For the helpers added in this series, we can make
> >> bpf_rbtree_first -> bpf_rbtree_remove safe by invalidating all release_on_unlock
> >> refs after the rbtree_remove in same manner as they're invalidated after
> >> spin_unlock currently.
> >>
> >> Logic for why this is safe:
> >>
> >>   * If we have two non-owning refs to nodes in a tree, e.g. from
> >>     bpf_rbtree_add(node) and calling bpf_rbtree_first() immediately after,
> >>     we have no way of knowing if they're aliases of same node.
> >>
> >>   * If bpf_rbtree_remove takes arbitrary non-owning ref to node in the tree,
> >>     it might be removing a node that's already been removed, e.g.:
> >>
> >>         n = bpf_obj_new(...);
> >>         bpf_spin_lock(&lock);
> >>
> >>         bpf_rbtree_add(&tree, &n->node);
> >>         // n is now non-owning ref to node which was added
> >>         res = bpf_rbtree_first();
> >>         if (!m) {}
> >>         m = container_of(res, struct node_data, node);
> >>         // m is now non-owning ref to the same node
> >>         bpf_rbtree_remove(&tree, &n->node);
> >>         bpf_rbtree_remove(&tree, &m->node); // BAD
> > 
> > Let me clarify my previous email:
> > 
> > Above doesn't have to be 'BAD'.
> > Instead of
> > if (WARN_ON_ONCE(RB_EMPTY_NODE(n)))
> > 
> > we can drop WARN and simply return.
> > If node is not part of the tree -> nop.
> > 
> > Same for bpf_rbtree_add.
> > If it's already added -> nop.
> > 
> 
> These runtime checks can certainly be done, but if we can guarantee via
> verifier type system that a particular ptr-to-node is guaranteed to be in /
> not be in a tree, that's better, no?
> 
> Feels like a similar train of thought to "fail verification when correct rbtree
> lock isn't held" vs "just check if lock is held in every rbtree API kfunc".
> 
> > Then we can have bpf_rbtree_first() returning PTR_TRUSTED with acquire semantics.
> > We do all these checks under the same rbtree root lock, so it's safe.
> > 
> 
> I'll comment on PTR_TRUSTED in our discussion on patch 10.
> 
> >>         bpf_spin_unlock(&lock);
> >>
> >>   * bpf_rbtree_remove is the only "pop()" currently. Non-owning refs are at risk
> >>     of pointing to something that was already removed _only_ after a
> >>     rbtree_remove, so if we invalidate them all after rbtree_remove they can't
> >>     be inputs to subsequent remove()s
> > 
> > With above proposed run-time checks both bpf_rbtree_remove and bpf_rbtree_add
> > can have release semantics.
> > No need for special release_on_unlock hacks.
> > 
> 
> If we want to be able to interact w/ nodes after they've been added to the
> rbtree, but before critical section ends, we need to support non-owning refs,
> which are currently implemented using special release_on_unlock logic.
> 
> If we go with the runtime check suggestion from above, we'd need to implement
> 'conditional release' similarly to earlier "rbtree map" attempt:
> https://lore.kernel.org/bpf/20220830172759.4069786-14-davemarchevsky@fb.com/ .
> 
> If rbtree_add has release semantics for its node arg, but the node is already
> in some tree and runtime check fails, the reference should not be released as
> rbtree_add() was a nop.

Got it.
The conditional release is tricky. We should probably avoid it for now.

I think we can either go with Kumar's proposal and do
bpf_rbtree_pop_front() instead of bpf_rbtree_first()
that avoids all these issues...

but considering that we'll have inline iterators soon and should be able to do:

struct bpf_rbtree_iter it;
struct bpf_rb_node * node;

bpf_rbtree_iter_init(&it, rb_root); // locks the rbtree
while ((node = bpf_rbtree_iter_next(&it)) {
  if (node->field == condition) {
    struct bpf_rb_node *n;

    n = bpf_rbtree_remove(rb_root, node);
    bpf_spin_lock(another_rb_root);
    bpf_rbtree_add(another_rb_root, n);
    bpf_spin_unlock(another_rb_root);
    break;
  }
}
bpf_rbtree_iter_destroy(&it);

We can treat the 'node' returned from bpf_rbtree_iter_next() the same way
as return from bpf_rbtree_first() ->  PTR_TRUSTED | MAYBE_NULL,
but not acquired (ref_obj_id == 0).

bpf_rbtree_add -> KF_RELEASE
so we cannot pass not acquired pointers into it.

We should probably remove release_on_unlock logic as Kumar suggesting and
make bpf_list_push_front/back to be KF_RELEASE.

Then
bpf_list_pop_front/back stay KF_ACQUIRE | KF_RET_NULL
and
bpf_rbtree_remove is also KF_ACQUIRE | KF_RET_NULL.

The difference is bpf_list_pop has only 'head'
while bpf_rbtree_remove has 'root' and 'node' where 'node' has to be PTR_TRUSTED
(but not acquired).

bpf_rbtree_add will always succeed.
bpf_rbtree_remove will conditionally fail if 'node' is not linked.

Similarly we can extend link list with
n = bpf_list_remove(node)
which will have KF_ACQUIRE | KF_RET_NULL semantics.

Then everything is nicely uniform.
We'll be able to iterate rbtree and iterate link lists.

There are downsides, of course.
Like the following from your test case:
+       bpf_spin_lock(&glock);
+       bpf_rbtree_add(&groot, &n->node, less);
+       bpf_rbtree_add(&groot, &m->node, less);
+       res = bpf_rbtree_remove(&groot, &n->node);
+       bpf_spin_unlock(&glock);
will not work.
Since bpf_rbtree_add() releases 'n' and it becomes UNTRUSTED.
(assuming release_on_unlock is removed).

I think it's fine for now. I have to agree with Kumar that it's hard to come up
with realistic use case where 'n' should be accessed after it was added to link
list or rbtree. Above test case doesn't look real.

This part of your test case:
+       bpf_spin_lock(&glock);
+       bpf_rbtree_add(&groot, &n->node, less);
+       bpf_rbtree_add(&groot, &m->node, less);
+       bpf_rbtree_add(&groot, &o->node, less);
+
+       res = bpf_rbtree_first(&groot);
+       if (!res) {
+               bpf_spin_unlock(&glock);
+               return 2;
+       }
+
+       o = container_of(res, struct node_data, node);
+       res = bpf_rbtree_remove(&groot, &o->node);
+       bpf_spin_unlock(&glock);

will work, because bpf_rbtree_first returns PTR_TRUSTED | MAYBE_NULL.

> Similarly, if rbtree_remove has release semantics for its node arg and acquire
> semantics for its return value, runtime check failing should result in the
> node arg not being released. Acquire semantics for the retval are already
> conditional - if retval == NULL, mark_ptr_or_null regs will release the
> acquired ref before it can be used. So no issue with failing rbtree_remove
> messing up acquire.
> 
> For this reason rbtree_remove and rbtree_first are tagged
> KF_ACQUIRE | KF_RET_NULL. "special release_on_unlock hacks" can likely be
> refactored into a similar flag, KF_RELEASE_NON_OWN or similar.

I guess what I'm propsing above is sort-of KF_RELEASE_NON_OWN idea,
but from a different angle.
I'd like to avoid introducing new flags.
I think PTR_TRUSTED is enough.

> > I'm not sure what's an idea to return 'n' from remove...
> > Maybe it should be simple bool ?
> > 
> 
> I agree that returning node from rbtree_remove is not strictly necessary, since
> rbtree_remove can be thought of turning its non-owning ref argument into an
> owning ref, instead of taking non-owning ref and returning owning ref. But such
> an operation isn't really an 'acquire' by current verifier logic, since only
> retvals can be 'acquired'. So we'd need to add some logic to enable acquire
> semantics for args. Furthermore it's not really 'acquiring' a new ref, rather
> changing properties of node arg ref.
> 
> However, if rbtree_remove can fail, such a "turn non-owning into owning"
> operation will need to be able to fail as well, and the program will need to
> be able to check for failure. Returning 'acquire' result in retval makes
> this simple - just check for NULL. For your "return bool" proposal, we'd have
> to add verifier logic which turns the 'acquired' owning ref back into non-owning
> based on check of the bool, which will add some verifier complexity.
> 
> IIRC when doing experimentation with "rbtree map" implementation, I did
> something like this and decided that the additional complexity wasn't worth
> it when retval can just be used. 

Agree. Forget 'bool' idea.
