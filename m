Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7853647035
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 13:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiLHM5h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 07:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLHM5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 07:57:36 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE73DBE
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 04:57:34 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d7so1415022pll.9
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 04:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrJj6qt1yikZx/LX3hrKfQHjB/1aLwuGHnceNNgYNWE=;
        b=Ut/yv5Lc/6tATWWjq6b94suq1sMgIKoQdl0e3gmbmK93Vk/3aTRqH2ajDFkl3W6v8C
         YdP4/FNrivIZnLbEu2q1jJAw9IuZD72UMY8tzPpYZuoc3/X9t1mqxNQ1hm1PZQtpWnlh
         agdOJLKu9R/Qf1hNXd3CBzKDRSaP/wjytZveRiBOvt09L6EJzLfMiSZDLcEq4ElsxMMI
         ZIthMBsEMvTgyPRBR6TNYwDGl6EaiS2x3QRNGP6JvSkQmZEEH/raQGmdF1m4jKCMWQnI
         +f69ykaW/1euQb630dt4qBZnvTxGZ0ZYwM8VRr5hQp1yP6wPPE61UrXGm2xSkOU1sGQz
         k67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrJj6qt1yikZx/LX3hrKfQHjB/1aLwuGHnceNNgYNWE=;
        b=5R3gqWqTZkobVe8Sq6pqJ3wSEym+6AlvRN7csOHLX4i0Er7yJUlMLhTKuLW4qI/EF4
         ocrvc+WEjVaCfHJ+pDU3AZbI8Kmrv0taVC2oaZDKYOR0RwWxSizKjbtm57gdGwTCEl8x
         VXsUIls4UTQFRKxZh8ShyZGvhSE0FW1mY7pQQku8OgH9pViG8F8iYbjNmCpw5OfnFUSg
         4MRErWnZgumA69COKemZRPi/QRbuI6JrUZXPSROOMTiW4z/MJXe7/PBuY1zNsMzqsNi4
         Brh/fJJRhpsZk0tlDLw6eWePJUoJs3fesrVB+5ZV9E8dHOoV4K85R430HsOawQGASGlC
         9d5w==
X-Gm-Message-State: ANoB5pltifUQeNCULR/vfOvf7JS25DlZu2BIz31K0AIb2c+cLSoa5n2w
        VhMcNqWbow5uFuJMK4FHdeY=
X-Google-Smtp-Source: AA0mqf7Ko06k2DCiC9TGy8Y7TeRzFLyYhaK1Kdqs2DETtrl9sQ8PDsMTgFHLd9dxu8AnnsVykFEVhA==
X-Received: by 2002:a17:903:22cd:b0:189:e16f:c268 with SMTP id y13-20020a17090322cd00b00189e16fc268mr3079726plg.20.1670504253346;
        Thu, 08 Dec 2022 04:57:33 -0800 (PST)
Received: from localhost ([2409:40e3:1035:9dc4:9d6e:d615:2a6e:5513])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709026e0f00b00189667acf15sm16561545plk.162.2022.12.08.04.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:57:33 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:27:29 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Message-ID: <20221208125729.73qr3glbyd7p6buq@apollo>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
 <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
 <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
 <33b0c075-3551-b57a-76e4-bc40452b3253@meta.com>
 <20221208035140.skuadnybf5aqb4o5@macbook-pro-6.dhcp.thefacebook.com>
 <4dc1def4-74a1-d1a6-386a-32e84962a55a@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc1def4-74a1-d1a6-386a-32e84962a55a@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 08, 2022 at 01:58:44PM IST, Dave Marchevsky wrote:
> On 12/7/22 10:51 PM, Alexei Starovoitov wrote:
> > On Wed, Dec 07, 2022 at 08:18:25PM -0500, Dave Marchevsky wrote:
> >>
> >> Before replying to specific things in this email, I think it would be useful
> >> to have a subthread clearing up definitions and semantics, as I think we're
> >> talking past each other a bit.
> >
> > Yeah. We were not on the same page.
> > The concepts of 'owning ref' and 'non-owning ref' appeared 'new' to me.
> > I remember discussing 'conditional release' and OBJ_NON_OWNING_REF long ago
> > and I thought we agreed that both are not necessary and with that
> > I assumed that anything 'non-owning' as a concept is gone too.
> > So the only thing left (in my mind) was the 'owning' concept.
> > Which I mapped as ref_obj_id > 0. In other words 'owning' meant 'acquired'.
> >
>
> Whereas in my mind the release_on_unlock logic was specifically added to
> implement the mass invalidation part of non-owning reference semantics, and it
> being accepted implied that we weren't getting rid of the concept :).
>
> > Please have this detailed explanation in the commit log next time to
> > avoid this back and forth.
> > Now to the fun part...
> >
>
> I will add a documentation commit explaining 'owning' and 'non-owning' ref
> as they pertain to these datastructures, after we agree about the semantics.
>
> Speaking of which, although I have a few questions / clarifications, I think
> we're more in agreement after your reply. After one more round of clarification
> I will summarize conclusions to see if we agree on enough to move forward.
>
> >>
> >> On a conceptual level I've still been using "owning reference" and "non-owning
> >> reference" to understand rbtree operations. I'll use those here and try to map
> >> them to actual verifier concepts later.
> >>
> >> owning reference
> >>
> >>   * This reference controls the lifetime of the pointee
> >>   * Ownership of pointee must be 'released' by passing it to some rbtree
> >>     API kfunc - rbtree_add in our case -  or via bpf_obj_drop, which free's
> >>     * If not released before program ends, verifier considers prog invalid
> >>   * Access to the memory ref is pointing at will not page fault
> >
> > agree.
> >
> >> non-owning reference
> >>
> >>   * No ownership of pointee so can't pass ownership via rbtree_add, not allowed
> >>     to bpf_obj_drop
> >>   * No control of lifetime, but can infer memory safety based on context
> >>     (see explanation below)
> >>   * Access to the memory ref is pointing at will not page fault
> >>     (see explanation below)
> >
> > agree with addition that both read and write should be allowed into this
> > 'non-owning' ptr.
> > Which breaks if you map this to something that ORs with PTR_UNTRUSTED.
> >
>
> Agree re: read/write allowed. PTR_UNTRUSTED was an implementation detail.
> Sounds like we agree on general purpose of owning, non-owning. Looks like
> we're in agreement about above semantics.
>

Yes, PTR_UNTRUSTED is not appropriate for this. My opposition was also more to
the idea of mapping PTR_UNTRUSTED to non-owning references.
If we do PTR_TO_BTF_ID | MEM_ALLOC for them with ref_obj_id == 0, it SGTM.

> >> 2) From verifier's perspective non-owning references can only exist
> >> between spin_lock and spin_unlock. Why? After spin_unlock another program
> >> can do arbitrary operations on the rbtree like removing and free-ing
> >> via bpf_obj_drop. A non-owning ref to some chunk of memory that was remove'd,
> >> free'd, and reused via bpf_obj_new would point to an entirely different thing.
> >> Or the memory could go away.
> >
> > agree that spin_unlock needs to clean up 'non-owning'.
>
> Another point of agreement.
>

+1

> >
> >> To prevent this logic violation all non-owning references are invalidated by
> >> verifier after critical section ends. This is necessary to ensure "will
> >> not page fault" property of non-owning reference. So if verifier hasn't
> >> invalidated a non-owning ref, accessing it will not page fault.
> >>
> >> Currently bpf_obj_drop is not allowed in the critical section, so similarly,
> >> if there's a valid non-owning ref, we must be in critical section, and can
> >> conclude that the ref's memory hasn't been dropped-and-free'd or dropped-
> >> and-reused.
> >
> > I don't understand why is that a problem.
> >
> >> 1) Any reference to a node that is in a rbtree _must_ be non-owning, since
> >> the tree has control of pointee lifetime. Similarly, any ref to a node
> >> that isn't in rbtree _must_ be owning. (let's ignore raw read from kptr_xchg'd
> >> node in map_val for now)

The last case is going to be marked PTR_UNTRUSTED.

> >
> > Also not clear why such restriction is necessary.
> >
>
> If we have this restriction and bpf_rbtree_release also mass invalidates
> non-owning refs, the type system will ensure that only nodes that are in a tree
> will be passed to bpf_rbtree_release, and we can avoid the runtime check.
>

I like this property. This was also how I proposed implementing it for lists.
e.g. Any bpf_list_del would invalidate the result of prior bpf_list_first_entry
and bpf_list_last_entry to ensure safety.

It's a bit similar to aliasing XOR mutability guarantees that Rust has. We're
trying to implement a simple borrow checking mechanism.

Once the collection is mutated, any prior non-owning references become
invalidated. It can be further refined (e.g. bpf_rbtree_add won't do
invalidation on mutation) based on the properties of the data structure.

> But below you mention preferring the runtime check, mostly noting here to
> refer back when continuing reply below.
>
> >> Moving on to rbtree API:
> >>
> >> bpf_rbtree_add(&tree, &node);
> >>   'node' is an owning ref, becomes a non-owning ref.
> >>
> >> bpf_rbtree_first(&tree);
> >>   retval is a non-owning ref, since first() node is still in tree
> >>
> >> bpf_rbtree_remove(&tree, &node);
> >>   'node' is a non-owning ref, retval is an owning ref
> >
> > agree on the above definition.
> > >> All of the above can only be called when rbtree's lock is held, so invalidation
> >> of all non-owning refs on spin_unlock is fine for rbtree_remove.
> >>
> >> Nice property of paragraph marked with 1) above is the ability to use the
> >> type system to prevent rbtree_add of node that's already in rbtree and
> >> rbtree_remove of node that's not in one. So we can forego runtime
> >> checking of "already in tree", "already not in tree".
> >
> > I think it's easier to add runtime check inside bpf_rbtree_remove()
> > since it already returns MAYBE_NULL. No 'conditional release' necessary.
> > And with that we don't need to worry about aliases.
> >
>
> To clarify: You're proposing that we don't worry about solving the aliasing
> problem at verification time. Instead rbtree_{add,remove} will deal with it
> at runtime. Corollary of this is that my restriction tagged 1) above ("ref
> to node in tree _must_ be non-owning, to node not in tree must be owning")
> isn't something we're guaranteeing, due to possibility of aliasing.
>
> So bpf_rbtree_remove might get a node that's not in tree, and
> bpf_rbtree_add might get a node that's already in tree. Runtime behavior
> of both should be 'nop'.
>
>
> If that is an accurate restatement of your proposal, the verifier
> logic will need to be changed:
>
> For bpf_rbtree_remove(&tree, &node), if node is already not in a tree,
> retval will be NULL, effectively not acquiring an owning ref due to
> mark_ptr_or_null_reg's logic.
>
> In this case, do we want to invalidate
> arg 'node' as well? Or just leave it as a non-owning ref that points
> to node not in tree? I think the latter requires fewer verifier changes,
> but can see the argument for the former if we want restriction 1) to
> mostly be true, unless aliasing.
>
> The above scenario is the only case where bpf_rbtree_remove fails and
> returns NULL.
>
> (In this series it can fail and RET_NULL for this reason, but my earlier comment
> about type system + invalidate all-non owning after remove as discussed below
> was my original intent. So I shouldn't have been allowing RET_NULL for my
> version of these semantics.)
>

I agree with Dave to rely on the invariant that non-owning refs to nodes are
part of the collection. Then bpf_rbtree_remove is simply KF_ACQUIRE.

>
> For bpf_rbtree_add(&tree, &node, less), if arg is already in tree, then
> 'node' isn't really an owning ref, and we need to tag it as non-owning,
> and program then won't need to bpf_obj_drop it before exiting. If node
> wasn't already in tree and rbtree_add actually added it, 'node' would
> also be tagged as non-owning, since tree now owns it.
>
> Do we need some way to indicate whether 'already in tree' case happened?
> If so, would need to change retval from void to bool or struct bpf_rb_node *.
>
> Above scenario is only case where bpf_rbtree_add fails and returns
> NULL / false.
>

Why should we allow node that is not acquired to be passed to bpf_rbtree_add?

> >> But, as you and Kumar talked about in the past and referenced in patch 1's
> >> thread, non-owning refs may alias each other, or an owning ref, and have no
> >> way of knowing whether this is the case. So if X and Y are two non-owning refs
> >> that alias each other, and bpf_rbtree_remove(tree, X) is called, a subsequent
> >> call to bpf_rbtree_remove(tree, Y) would be removing node from tree which
> >> already isn't in any tree (since prog has an owning ref to it). But verifier
> >> doesn't know X and Y alias each other. So previous paragraph's "forego
> >> runtime checks" statement can only hold if we invalidate all non-owning refs
> >> after 'destructive' rbtree_remove operation.
> >
> > right. we either invalidate all non-owning after bpf_rbtree_remove
> > or do run-time check in bpf_rbtree_remove.
> > Consider the following:
> > bpf_spin_lock
> > n = bpf_rbtree_first(root);
> > m = bpf_rbtree_first(root);
> > x = bpf_rbtree_remove(root, n)
> > y = bpf_rbtree_remove(root, m)
> > bpf_spin_unlock
> > if (x)
> >    bpf_obj_drop(x)
> > if (y)
> >    bpf_obj_drop(y)
> >
> > If we invalidate after bpf_rbtree_remove() the above will be rejected by the verifier.
> > If we do run-time check the above will be accepted and will work without crashing.
> >
>
> Agreed, although the above example's invalid double-remove of same node is
> the kind of thing I'd like to be prevented at verification time instead of
> runtime. Regardless, continuing with your runtime check idea.
>

I agree with Dave, it seems better to invalidate non-owning refs after first
remove rather than allowing this to work.

> > The problem with release_on_unlock is that it marks 'n' after 1st remove
> > as UNTRUSTED which means 'no write' and 'read via probe_read'.
> > That's not good imo.
> >
>
> Based on your response to paragraph below this one, I think we're in agreement
> that using PTR_UNTRUSTED for non-owning ref gives non-owning ref bunch of traits
> it doesn't need, when I just wanted "can't pass ownership". So agreed that
> PTR_UNTRUSTED is too blunt an instrument here.
>

I think this is the part of the confusion which has left me wondering so far.
The discussion in this thread is making things more clear.

PTR_UNTRUSTED was never meant to be the kind of non-owning reference you want to
be returned from bpf_rbtree_first. PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id == 0
is the right choice.

> Regarding "marks 'n' after 1st remove", the series isn't currently doing this,
> I proposed it as a way to prevent aliasing problem, but I think your proposal
> is explicitly not trying to prevent aliasing problem at verification time. So
> for your semantics we would only have non-owning cleanup after spin_unlock.
> And such cleanup might just mark refs PTR_UNTRUSTED instead of invalidating
> entirely.
>

I would prefer proper invalidation using mark_reg_unknown.

> >>
> >> It doesn't matter to me which combination of type flags, ref_obj_id, other
> >> reg state stuff, and special-casing is used to implement owning and non-owning
> >> refs. Specific ones chosen in this series for rbtree node:
> >>
> >> owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ type that contains bpf_rb_node)
> >>             ref_obj_id > 0
> >>
> >> non-owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ type that contains bpf_rb_node)
> >>                 PTR_UNTRUSTED
> >>                   - used for "can't pass ownership", not PROBE_MEM
> >>                   - this is why I mentioned "decomposing UNTRUSTED into more
> >>                     granular reg traits" in another thread
> >
> > Now I undestand, but that was very hard to grasp.
> > UNTRUSTED means 'no write' and 'read via probe_read'.
> > ref_set_release_on_unlock() also keeps ref_obj_id > 0 as you're correctly
> > pointing out below:
> >>                 ref_obj_id > 0
> >>                 release_on_unlock = true
> >>                   - used due to paragraphs starting with 2) above
> >
> > but the problem with ref_set_release_on_unlock() that it mixes real ref-d
> > pointers with ref_obj_id > 0 with UNTRUSTED && ref_obj_id > 0.
> > And the latter is a quite confusing combination in my mind,
> > since we consider everything with ref_obj_id > 0 as good for KF_TRUSTED_ARGS.
> >
>
> I think I understand your desire to get rid of release_on_unlock now. It's not
> due to disliking the concept of "clean up non-owning refs after spin_unlock",
> which you earlier agreed was necessary, but rather the specifics of
> release_on_unlock mechanism used to achieve this.
>
> If so, I think I agree with your reasoning for why the mechanism is bad in
> light of how you want owning/non-owning implemented. To summarize your
> statements about release_on_unlock mechanism from the rest of your reply:
>
>   * 'ref_obj_id > 0' already has a specific meaning wrt. is_trusted_reg,
>     and we may want to support both TRUSTED and UNTRUSTED non-owning refs
>
>     * My comment: Currently is_trusted_reg is only used for
>       KF_ARG_PTR_TO_BTF_ID, while rbtree and list types are assigned special
>       KF_ARGs. So hypothetically could have different 'is_trusted_reg' logic.
>       I don't actually think that's a good idea, though, especially since
>       rbtree / list types are really specializations of PTR_TO_BTF_ID anyways.
>       So agreed.
>
>   * Instead of using 'acquire' and (modified) 'release', we can achieve
>     "clean-up non-owning after spin_unlock" by associating non-owning
>     refs with active_lock.id when they're created. We can store this in
>     reg.id, which is currently unused for PTR_TO_BTF_ID (afaict).
>

I don't mind using active_lock.id for invalidation, but using reg->id to
associate it with reg is a bad idea IMO, it's already preserved and set when the
object has bpf_spin_lock in it, and it's going to allow doing bpf_spin_unlock
with that non-owing ref if it has a spin lock, essentially unlocking different
spin lock if the reg->btf of already locked spin lock reg is same due to same
active_lock.id.

Even if you prevent it somehow it's more confusing to overload reg->id again for
this purpose.

It makes more sense to introduce a new nonref_obj_id instead dedicated for this
purpose, to associate it back to the reg->id of the collection it is coming from.

Also, there are two cases of invalidation, one is on remove from rbtree, which
should only invalidate non-owning references into the rbtree, and one is on
unlock, which should invalidate all non-owning references.

bpf_rbtree_remove shouldn't invalidate non-owning into list protected by same
lock, but unlocking should do it for both rbtree and list non-owning refs it is
protecting.

So it seems you will have to maintain two IDs for non-owning referneces, one for
the collection it comes from, and one for the lock region it is obtained in.

>     * This will solve issue raised by previous point, allowing us to have
>       non-owning refs which are truly 'untrusted' according to is_trusted_reg.
>
>     * My comment: This all sounds reasonable. On spin_unlock we have
>       active_lock.id, so can do bpf_for_each_reg_in_vstate to look for
>       PTR_TO_BTF_IDs matching the id and do 'cleanup' for them.
>
> >> Any other combination of type and reg state that gives me the semantics def'd
> >> above works4me.
> >>
> >>
> >> Based on this reply and others from today, I think you're saying that these
> >> concepts should be implemented using:
> >>
> >> owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
> >>             PTR_TRUSTED
> >>             ref_obj_id > 0
> >
> > Almost.
> > I propose:
> > PTR_TO_BTF_ID | MEM_ALLOC  && ref_obj_id > 0
> >
> > See the definition of is_trusted_reg().
> > It's ref_obj_id > 0 || flag == (MEM_ALLOC | PTR_TRUSTED)
> >
> > I was saying 'trusted' because of is_trusted_reg() definition.
> > Sorry for confusion.
> >
>
> I see. Sounds reasonable.
>
> >> non-owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
> >>                 PTR_TRUSTED
> >>                 ref_obj_id == 0
> >>                  - used for "can't pass ownership", since funcs that expect
> >>                    owning ref need ref_obj_id > 0
> >
> > I propose:
> > PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
> >
>
> Also sounds reasonable, perhaps with the addition of id > 0 to account for
> your desired changes to release_on_unlock mechanism?
>
> > Both 'owning' and 'non-owning' will fit for KF_TRUSTED_ARGS kfuncs.
> >
> > And we will be able to pass 'non-owning' under spin_lock into other kfuncs
> > and owning outside of spin_lock into other kfuncs.
> > Which is a good thing.
> >
>
> Allowing passing of owning ref outside of spin_lock sounds reasonable to me.
> 'non-owning' under spinlock will have the same "what if this touches __key"
> issue I brought up in another thread. But you mentioned not preventing that
> and I don't necessarily disagree, so just noting here.
>

Yeah, I agree with Alexei that writing to key is a non-issue. 'Less' cb may not
actually do the correct thing at all, so in that sense writing to key is a small
issue. In any case violating the 'sorted' property is not something we should be
trying to prevent.

> >> And you're also adding 'untrusted' here, mainly as a result of
> >> bpf_rbtree_add(tree, node) - 'node' becoming untrusted after it's added,
> >> instead of becoming a non-owning ref. 'untrusted' would have state like:
> >>
> >> PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
> >> PTR_UNTRUSTED
> >> ref_obj_id == 0?
> >
> > I'm not sure whether we really need full untrusted after going through bpf_rbtree_add()
> > or doing 'non-owning' is enough.
> > If it's full untrusted it will be:
> > PTR_TO_BTF_ID | PTR_UNTRUSTED && ref_obj_id == 0
> >
>
> Yeah, I don't see what this "full untrusted" is giving us either. Let's have
> "cleanup non-owning refs on spin_unlock" just invalidate the regs for now,
> instead of converting to "full untrusted"?
>

+1, I prefer invalidating completely on unlock.

> Adding "full untrusted" later won't make any valid programs written with
> "just invalidate the regs" in mind fail the verifier. So painless to add later.
>

+1

> > tbh I don't remember why we even have 'MEM_ALLOC | PTR_UNTRUSTED'.
> >

Eventually it will also be used for alloc obj kptr loaded from maps.

>
> I think such type combo was only added to implement non-owning refs. If it's
> rewritten to use your type combos I don't think there'll be any uses of
> MEM_ALLOC | PTR_UNTRUSTED remaining.
>

To be clear I was not intending to use PTR_UNTRUSTED to do such non-owning refs.

> >> I think your "non-owning ref" definition also differs from mine, specifically
> >> yours doesn't seem to have "will not page fault". For this reason, you don't
> >> see the need for release_on_unlock logic, since that's used to prevent refs
> >> escaping critical section and potentially referring to free'd memory.
> >
> > Not quite.
> > We should be able to read/write directly through
> > PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
> > and we need to convert it to __mark_reg_unknown() after bpf_spin_unlock
> > the way release_reference() is doing.
> > I'm just not happy with using acquire_reference/release_reference() logic
> > (as release_on_unlock is doing) for cleaning after unlock.
> > Since we need to clean 'non-owning' ptrs in unlock it's confusing
> > to call the process 'release'.
> > I was hoping we can search through all states and __mark_reg_unknown() (or UNTRUSTED)
> > every reg where
> > reg->id == cur_state->active_lock.id &&
> > flag == PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
> >
> > By deleting relase_on_unlock I meant delete release_on_unlock flag
> > and remove ref_set_release_on_unlock.
> >
>
> Summarized above, but: agreed, and thanks for clarifying what you meant by
> "delete release_on_unlock".
>
> >> This is where I start to get confused. Some questions:
> >>
> >>   * If we get rid of release_on_unlock, and with mass invalidation of
> >>     non-owning refs entirely, shouldn't non-owning refs be marked PTR_UNTRUSTED?
> >
> > Since we'll be cleaning all
> > PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
> > it shouldn't affect ptrs with ref_obj_id > 0 that came from bpf_obj_new.
> >
> > The verifier already enforces that bpf_spin_unlock will be present
> > at the right place in bpf prog.
> > When the verifier sees it it will clean all non-owning refs with this spinlock 'id'.
> > So no concerns of leaking 'non-owning' outside.
> >
>
> Sounds like we don't want "full untrusted" or any PTR_UNTRUSTED non-owning ref.
>
> > While processing bpf_rbtree_first we need to:
> > regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> > regs[BPF_REG_0].id = active_lock.id;
> > regs[BPF_REG_0].ref_obj_id = 0;
> >
>
> Agreed.
>

I'm a bit concerned about putting active_lock.id in reg->id. Don't object to the
idea but the implementation, since we take PTR_TO_BTF_ID | MEM_ALLOC in
bpf_spin_lock/bpf_spin_unlock. It will lead to confusion. Currently this exact
reg->type never has reg->ref_obj_id as 0. Maybe that needs to be checked for
those helper calls.

Just thinking out loud, maybe it's fine but we need to be careful, reg->id
changes meaning with ref_obj_id == 0.

> >>   * Since refs can alias each other, how to deal with bpf_obj_drop-and-reuse
> >>     in this scheme, since non-owning ref can escape spin_unlock b/c no mass
> >>     invalidation? PTR_UNTRUSTED isn't sufficient here
> >
> > run-time check in bpf_rbtree_remove (and in the future bpf_list_remove)
> > should address it, no?
> >
>
> If we don't do "full untrusted" and cleanup non-owning refs by invalidating,
> _and_ don't allow bpf_obj_{new,drop} in critical section, then I don't think
> this is an issue.
>

bpf_obj_drop if/when enabled can also do invalidation. But let's table that
discussion until we introduce it. We most likely may not need it inside the CS.

> But to elaborate on the issue, if we instead cleaned up non-owning by marking
> untrusted:
>
> struct node_data *n = bpf_obj_new(typeof(*n));
> struct node_data *m, *o;
> struct some_other_type *t;
>
> bpf_spin_lock(&lock);
>
> bpf_rbtree_add(&tree, n);
> m = bpf_rbtree_first();
> o = bpf_rbtree_first(); // m and o are non-owning, point to same node
>
> m = bpf_rbtree_remove(&tree, m); // m is owning
>
> bpf_spin_unlock(&lock); // o is "full untrusted", marked PTR_UNTRUSTED
>
> bpf_obj_drop(m);
> t = bpf_obj_new(typeof(*t)); // pretend that exact chunk of memory that was
>                              // dropped in previous statement is returned here
>
> data = o->some_data_field;   // PROBE_MEM, but no page fault, so load will
>                              // succeed, but will read garbage from another type
>                              // while verifier thinks it's reading from node_data
>
>
> If we clean up by invalidating, but eventually enable bpf_obj_{new,drop} inside
> critical section, we'll have similar issue.
>
> It's not necessarily "crash the kernel" dangerous, but it may anger program
> writers since they can't be sure they're not reading garbage in this scenario.
>

I think it's better to clean by invalidating. We have better tools to form
untrusted pointers (like bpf_rdonly_cast) now if the BPF program writer needs
such an escape hatch for some reason. It's also easier to review where an
untrusted pointer is being used in a program, and has zero cost at runtime.

> >>   * If non-owning ref can live past spin_unlock, do we expect read from
> >>     such ref after _unlock to go through bpf_probe_read()? Otherwise direct
> >>     read might fault and silently write 0.
> >
> > unlock has to clean them.
> >
>
> Ack.
>
> >>   * For your 'untrusted', but not non-owning ref concept, I'm not sure
> >>     what this gives us that's better than just invalidating the ref which
> >>     gets in this state (rbtree_{add,remove} 'node' arg, bpf_obj_drop node)
> >
> > Whether to mark unknown or untrusted or non-owning after bpf_rbtree_add() is a difficult one.
> > Untrusted will allow prog to do read only access (via probe_read) into the node
> > but might hide bugs.
> > The cleanup after bpf_spin_unlock of non-owning and clean up after
> > bpf_rbtree_add() does not have to be the same.
>
> This is a good point.
>

So far I'm leaning towards:

bpf_rbtree_add(node) : node becomes non-owned ref
bpf_spin_unlock(lock) : node is invalidated

> > Currently I'm leaning towards PTR_UNTRUSTED for cleanup after bpf_spin_unlock
> > and non-owning after bpf_rbtree_add.
> >
> > Walking the example from previous email:
> >
> > struct bpf_rbtree_iter it;
> > struct bpf_rb_node * node;
> > struct bpf_rb_node *n, *m;
> >
> > bpf_rbtree_iter_init(&it, rb_root); // locks the rbtree works as bpf_spin_lock
> > while ((node = bpf_rbtree_iter_next(&it)) {
> >   // node -> PTR_TO_BTF_ID | MEM_ALLOC | MAYBE_NULL && ref_obj_id == 0
> >   if (node && node->field == condition) {
> >
> >     n = bpf_rbtree_remove(rb_root, node);
> >     if (!n) ...;
> >     // n -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == X
> >     m = bpf_rbtree_remove(rb_root, node); // ok, but fails in run-time
> >     if (!m) ...;
> >     // m -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == Y
> >

This second remove I would simply disallow as Dave is suggesting during
verification, by invalidating non-owning refs for rb_root.

> >     // node is still:
> >     // node -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[0].id
> >
> >     // assume we allow double locks one day
> >     bpf_spin_lock(another_rb_root);
> >     bpf_rbtree_add(another_rb_root, n);
> >     // n -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[1].id
> >     bpf_spin_unlock(another_rb_root);
> >     // n -> PTR_TO_BTF_ID | PTR_UNTRUSTED && ref_obj_id == 0
> >     break;
> >   }
> > }
> > // node -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[0].id
> > bpf_rbtree_iter_destroy(&it); // does unlock
> > // node -> PTR_TO_BTF_ID | PTR_UNTRUSTED
> > // n -> PTR_TO_BTF_ID | PTR_UNTRUSTED
> > // m -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == Y
> > bpf_obj_drop(m);
>
> This seems like a departure from other statements in your reply, where you're
> leaning towards "non-owning and trusted" -> "full untrusted" after unlock
> being unnecessary. I think the combo of reference aliases + bpf_obj_drop-and-
> reuse make everything hard to reason about.
>
> Regardless, your comments annotating reg state look correct to me.

I think it's much more clear in this thread wrt what you wanted to do. It would
be good after the thread concludes to eventually summarize how you're going to
finally implement all this before respinning.
