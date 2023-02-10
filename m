Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A2E69278C
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 21:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjBJUBS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 15:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBJUBS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 15:01:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71573954
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 12:01:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id pj3so6336629pjb.1
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 12:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXtoS+RFcRexLPh3iMg60ABvSeHKu5MI1KXPccYl3vU=;
        b=F3pa1ssovB7UEaFIUc9C6ZjMU6eVUz3iHGChl/S98ff6+zPqaiFHBcBvwgVVFgOIIa
         YR83LN0nShD2JQOXN60p2/uQXUnY4R1Njej2AsqIj7nAM14KH5P5bjhsvDjzI8gJqZqN
         Lvu036pfcIkCOwX7bt+r+KZ4MBj4/5i4qJ8KEwJvxGVFfr5b2o3zwwp5K7qObt9hg+2i
         vbT47nHjFReMN81xHtON9uSU1fd/4tKRHhmy5TpMwcJyZ+gKf1VQ1YGVP1nZ7xtrdqfK
         a2SX6+o5O+q86K5tnxLCPTZ3aovT4v6vJ142lwDxMTIrP0Tr3n21DpdO67KHIyU/L5yW
         ZbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXtoS+RFcRexLPh3iMg60ABvSeHKu5MI1KXPccYl3vU=;
        b=XrdxeElLHye27ANAHYU5bwdmc1a54lXDkpGU2mC+FNrz0GKn9/OYAJVJf1pxS+zH1g
         gEl5YLc3ZISxvZ8hkbaAYlkH2nyWWY5Xdus23NZm9MwrAKIFhpI+HBRSPdMbUo0DHvA+
         p9XZPk7WsU/QRzi/mGt2PjcKXfbfIwaWfNSSHyPLzHyf3iVof9kXAX/htWsPQ05RrQro
         aIZMIVzjspVC3Mbwiu2SvCgRU3k9Sy9ddYuwPBCwmIdSoq3fInCWq+HTYeID5jW4KZ7y
         PMx1Nx52iV+KMv64XeZv4dacJqkSnA/LxQ/59bWne6o5rmBs6koOsy0ekwGES+bYw49h
         7lzw==
X-Gm-Message-State: AO0yUKVwGuU9uApnPfLGhiHDj5psM0d+QpXCJtsEJcbVYjpDqbb42EjA
        oS5Zr/4/b7p4dJE8Z13FEGXKKkYpz6E=
X-Google-Smtp-Source: AK7set8U2CZhRWMHRLBktPUCdlEaKq1W6r4+LZ8FvGZBYMgwmqYLvbs2R+5uj70o7lNQHLL4FGWovg==
X-Received: by 2002:a17:90a:7f98:b0:230:f874:3600 with SMTP id m24-20020a17090a7f9800b00230f8743600mr15700288pjl.28.1676059275573;
        Fri, 10 Feb 2023 12:01:15 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:c6db])
        by smtp.gmail.com with ESMTPSA id k14-20020a17090a39ce00b00231156a7da1sm3214515pjf.4.2023.02.10.12.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 12:01:15 -0800 (PST)
Date:   Fri, 10 Feb 2023 12:01:12 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <20230210200112.ol26czyensd446km@MacBook-Pro-6.local>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
 <20230210135541.xtwn6wzng7mspgrm@apollo>
 <20230210172137.jwqynnjtmjcv4dqe@MacBook-Pro-6.local>
 <20230210180346.ae43pl7i6zwidno7@apollo>
 <20230210185854.ndjrd6kbcu3mfo2o@MacBook-Pro-6.local>
 <20230210193847.rkudlbahuvutks2o@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210193847.rkudlbahuvutks2o@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 08:38:47PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Fri, Feb 10, 2023 at 07:58:54PM CET, Alexei Starovoitov wrote:
> > On Fri, Feb 10, 2023 at 07:03:46PM +0100, Kumar Kartikeya Dwivedi wrote:
> > > On Fri, Feb 10, 2023 at 06:21:37PM CET, Alexei Starovoitov wrote:
> > > > On Fri, Feb 10, 2023 at 02:55:41PM +0100, Kumar Kartikeya Dwivedi wrote:
> > > > > On Thu, Feb 09, 2023 at 06:41:41PM CET, Dave Marchevsky wrote:
> > > > > > Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
> > > > > > that require handling in the verifier:
> > > > > >
> > > > > >   * both bpf_rbtree_remove and bpf_rbtree_first return the type containing
> > > > > >     the bpf_rb_node field, with the offset set to that field's offset,
> > > > > >     instead of a struct bpf_rb_node *
> > > > > >     * mark_reg_graph_node helper added in previous patch generalizes
> > > > > >       this logic, use it
> > > > > >
> > > > > >   * bpf_rbtree_remove's node input is a node that's been inserted
> > > > > >     in the tree - a non-owning reference.
> > > > > >
> > > > > >   * bpf_rbtree_remove must invalidate non-owning references in order to
> > > > > >     avoid aliasing issue. Use previously-added
> > > > > >     invalidate_non_owning_refs helper to mark this function as a
> > > > > >     non-owning ref invalidation point.
> > > > > >
> > > > > >   * Unlike other functions, which convert one of their input arg regs to
> > > > > >     non-owning reference, bpf_rbtree_first takes no arguments and just
> > > > > >     returns a non-owning reference (possibly null)
> > > > > >     * For now verifier logic for this is special-cased instead of
> > > > > >       adding new kfunc flag.
> > > > > >
> > > > > > This patch, along with the previous one, complete special verifier
> > > > > > handling for all rbtree API functions added in this series.
> > > > > >
> > > > >
> > > > > I think there are two issues with the current approach. The fundamental
> > > > > assumption with non-owning references is that it is part of the collection. So
> > > > > bpf_rbtree_{add,first}, bpf_list_push_{front,back} will create them, as no node
> > > > > is being removed from collection. Marking bpf_rbtree_remove (and in the future
> > > > > bpf_list_del) as invalidation points is also right, since once a node has been
> > > > > removed it is going to be unclear whether existing non-owning references have
> > > > > the same value, and thus the property of 'part of the collection' will be
> > > > > broken.
> > > >
> > > > correct, but the patch set does invalidate after bpf_rbtree_remove(),
> > > > so it's not an issue.
> > > >
> > > > > The first issue relates to usability. If I have non-owning references to nodes
> > > > > inserted into both a list and an rbtree, bpf_rbtree_remove should only
> > > > > invalidate the ones that are part of the particular rbtree. It should have no
> > > > > effect on others. Likewise for the bpf_list_del operation in the future.
> > > > > Therefore, we need to track the collection identity associated with each
> > > > > non-owning reference, then only invalidate non-owning references associated with
> > > > > the same collection.
> > > > >
> > > > > The case of bpf_spin_unlock is different, which should invalidate all non-owning
> > > > > references.
> > > > >
> > > > > The second issue is more serious. By not tracking the collection identity, we
> > > > > will currently allow a non-owning reference for an object inserted into a list
> > > > > to be passed to bpf_rbtree_remove, because the verifier cannot discern between
> > > > > 'inserted into rbtree' vs 'inserted into list'. For it, both are currently
> > > > > equivalent in the verifier state. An object is allowed to have both
> > > > > bpf_list_node and bpf_rb_node, but it can only be part of one collection at a
> > > > > time (because of no shared ownership).
> > > > >
> > > > > 	struct obj {
> > > > > 		bpf_list_node ln;
> > > > > 		bpf_rb_node rn;
> > > > > 	};
> > > > >
> > > > > 	bpf_list_push_front(head, &obj->ln); // node is non-own-ref
> > > > > 	bpf_rbtree_remove(&obj->rn); // should not work, but does
> > > >
> > > > Also correct, but inserting the same single owner node into rbtree and link list
> > > > is not supported. Only 'shared ownership' node can be inserted into
> > > > two collections.
> > >
> > > What is supported is having an object be part of a list and an rbtree one at a
> > > time, which is what I'm talking about here. Shared ownership has nothing to do
> > > with this.
> >
> > I wouldn't call it "supported".
> > btf_parse_struct_metas() doesn't error on structs with bpf_list_node and bpf_rb_node in them.
> > It allows two bpf_list_node-s as well.
> > list_node+rb_node is broken as you said.
> > I'm not sure two list_node-s is correct either. For the same reasons.
> 
> You mean it's incorrect before or after this series? If before, can you
> elaborate? The node isn't usable with kfuncs after push before this series.

I meant once we add non-own-refs and bpf_list_del. Something like:
struct obj {
	bpf_list_node ln;
	bpf_list_node ln2;
};

bpf_list_push_front(head, &obj->ln); // obj is non-own-ref
bpf_list_del(&obj->ln2); // should not work, but does

...details to fill in...
I'm arguing that bpf_list_node x 2 is the same danger zone as bpf_list_node + bpf_rb_node.
It's safe today only because link list is so limited.
I'm looking at full featured rb tree and link list with similar ops allowed in both.

> 
> > So it's an omission rather than support.
> >
> > > > The check to disallow bpf_list_node and bpf_rb_node in the same obj
> > > > can be a follow up patch to close this hole.
> > > >
> > >
> > > Fine, that would also 'fix' this problem, where a non-owning reference part of a
> > > list could be passed to bpf_rbtree_remove etc. If there can only be a list node
> > > or an rbtree node in an object, such a case cannot be constructed. But I think
> > > it's an awkward limitation.
> >
> > Regardless whether non-own refs exist or not. Two list_node-s are unusable
> > with single owner model.
> > struct obj {
> > 	bpf_list_node ln;
> > 	bpf_list_node ln2;
> > };
> >
> > bpf_list_push_front(head, &obj->ln); // doesn't matter what we do with obj here
> > bpf_list_push_front(head2, &obj->ln2); // cannot be made to work correctly
> > The only way to actually support this case is to have refcount in obj.
> >
> 
> Yes, I think we all agree it's not possible currently.
> 
> > It can "work" when obj is a part of only one list at a time, but one can reasonably
> > argue that a requirement to have two 'bpf_list_node'-s in a obj just two insert obj
> > in one list, pop it, and then insert into another list through a different list_node
> > is nothing but a waste of memory.
> 
> I didn't get this. Unless I'm mistaken, you should be able to move objects
> around from one list to another using the same single bpf_list_node. You don't
> need two. Just that the list_head needs correct __contains annotation.
> 
> > The user should be able to use the same 'bpf_list_node' to insert into one
> > list_head, remove it from there, and then insert into another list_head.
> >
> 
> I think this already works.

It could be. We don't have tests for it, so it's a guess.

> 
> > > > > So some notion of a collection identity needs to be constructed, the amount of
> > > > > data which needs to be remembered in each non-owning reference's register state
> > > > > depends on our requirements.
> > > > >
> > > > > The first sanity check is that bpf_rbtree_remove only removes something in an
> > > > > rbtree, so probably an enum member indicating whether collection is a list or
> > > > > rbtree. To ensure proper scoped invalidation, we will unfortunately need more
> > > > > than just the reg->id of the reg holding the graph root, since map values of
> > > > > different maps may have same id (0). Hence, we need id and ptr similar to the
> > > > > active lock case for proper matching. Even this won't be enough, as there can be
> > > > > multiple list or rbtree roots in a particular memory region, therefore the
> > > > > offset also needs to be part of the collection identity.
> > > > >
> > > > > So it seems it will amount to:
> > > > >
> > > > > 	struct bpf_collection_id {
> > > > > 		enum bpf_collection_type type;
> > > > > 		void *ptr;
> > > > > 		int id;
> > > > > 		int off;
> > > > > 	};
> > > > >
> > > > > There might be ways to optimize the memory footprint of this struct, but I'm
> > > > > just trying to state why we'll need to include all four, so we don't miss out on
> > > > > a corner case again.
> > > >
> > > > The trade-off doesn't feel right here. Tracking collection id complexity in
> > > > the verifier for single owner case is not worth it imo.
> > >
> > > It was more about correctness after this set is applied than being worth it. We
> > > could argue it's not worth it for the first issue which relates to usability.
> > > Dave has already mentioned that point. But the second one is simply incorrect to
> > > allow. As soon as you want an object which can be part of both a list and rbtree
> > > at different times (e.g., an item usually part of an rbtree but which is popped
> > > out and moved to a list for some processing), people will be able to trigger it.
> >
> > obj-in-a-list or obj-in-a-rbtree is technically possible, but I argue it's equally
> > weird corner case to support. See above why two list_node-s for head-at-a-time are awkward.
> >
> > > Simply disallowing that (as you said above) is also an option. But whenever you
> > > do allow it, you will need to add something like this. It has little to do with
> > > whether shared ownership is supported or not.
> >
> > I think we will allow two list_nodes or list_node+rb_node or ten rb_nodes
> > only when refcount is present as well and that would be 'shared ownership' case.
> 
> I get that you just want to punt it for now until someone has a use case, and
> move forward.
> 
> But saying that people will have to use a refcount in their object just to be
> able to have single unique ownership while allowing it to be part of multiple
> data structures at different times is weird. It's like forcing someone to use a
> shared_ptr in C++ (when they can use a unique_ptr) just because they want to
> std::move it from one place to another.
> 
> I thought the whole point was building composable building blocks and letting
> people choose their tradeoffs.

That's exactly what we're doing. rb-tree, link lists are building blocks.
If we can improve their UX we will certainly do it. I'm arguing that we don't
have a real user yet, so whether UX is good or bad is subjective.

For example in this thread and never before we looked critically at kptrs
and kptr_xchg. The first time people tried to use for real they said it sucks.
That's a feedback that we should listen to instead of our own believes.
We try to strike a balance between feature being useful while keeping the verifier
complexity to the minimum. Then deliver the feature into the hands of users and
iterate based on their feedback.
