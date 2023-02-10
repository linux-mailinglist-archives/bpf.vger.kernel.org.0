Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBC96924FF
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 19:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjBJSDz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 13:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjBJSDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 13:03:54 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6405268AD5
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 10:03:50 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id p26so17972883ejx.13
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 10:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmwfam9DJbnwiiG/ygCnmu0PqCcKObX3h3u43lZA4Jw=;
        b=KWHw9iTjhKNfnXKH8fkLnkmnD3pK0PMZmaIecC6cHYXAPah2UAJ/mojCSFqTp5A23G
         Nd45ChnmnZ7OpvQ7rfhx6HzhxRhyVKTacOYNXvsqs+dtVclZSN3tSmh59ddrv/r2RgAx
         JI7/7kzTIptx14Z37nQMlk9jakP7ZJtrflH9XOLZV6A4h8UxeLOeu5A/WEHV1tQ29Ysd
         An0MBLIGl/K02RTEw/6vsVMVx6B+bgK4DYKV7ZDyqOzTGTJNbkkX+RUZ0KIRilwdk+xg
         WZlGxJzSPPezLagwgLhwOE1EUs93J6MVUCmCGxL9fC0HVDSiLO2SU1OKkhm9gm5ztqOE
         lZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmwfam9DJbnwiiG/ygCnmu0PqCcKObX3h3u43lZA4Jw=;
        b=IAIW9VzVahR9r2z5EqCpdF3L0bvO9tEWgik1/dyqmtqLOCJT2csfAzB2LsJvPV6WR1
         pKElD22psl/e4HpvWLWgfDmuHOx8RIBAU8tVjuyiS8N2LZIFFCiDDyUg9fjk9walk0PB
         XM6ziMH+1nW1/zZCj1+bsrqaTn1wqdVx6dt/S4xXce0WkbSyD+U+YLE4mmUn7eGcHs0O
         4KTrGPjwocNyQwPh2rEWB9QiiZCgEMoiCDzdi4oXhp6MB4080GdNSs5BCooViuhevfvf
         ReYBU6uAR9LeovUS9KVR/2opGr+H9X6Fg3bwm8EZa5wdMyd2siO1GmlR2ZxB/pnBFNrd
         Tdmw==
X-Gm-Message-State: AO0yUKVR+COIdluRaHuNRYSL9dWDdGOEjcS/TpDnZL0kDfsdJe+RuWRD
        f8BIp5T/fkcoyX2jNidNulXKfsEU7PG/7Q==
X-Google-Smtp-Source: AK7set8jq9gFmWHDoP0Iwex1Jd6KNslMY6AHevDJJWS7EPBNEUMf8nXTFVwCX6UxBdpy2tlrVNEcBw==
X-Received: by 2002:a17:906:dc9:b0:888:33a:e359 with SMTP id p9-20020a1709060dc900b00888033ae359mr16330542eji.38.1676052228386;
        Fri, 10 Feb 2023 10:03:48 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:2d0])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b0088091cca1besm2677424ejd.134.2023.02.10.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:03:47 -0800 (PST)
Date:   Fri, 10 Feb 2023 19:03:46 +0100
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <20230210180346.ae43pl7i6zwidno7@apollo>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
 <20230210135541.xtwn6wzng7mspgrm@apollo>
 <20230210172137.jwqynnjtmjcv4dqe@MacBook-Pro-6.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210172137.jwqynnjtmjcv4dqe@MacBook-Pro-6.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 06:21:37PM CET, Alexei Starovoitov wrote:
> On Fri, Feb 10, 2023 at 02:55:41PM +0100, Kumar Kartikeya Dwivedi wrote:
> > On Thu, Feb 09, 2023 at 06:41:41PM CET, Dave Marchevsky wrote:
> > > Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
> > > that require handling in the verifier:
> > >
> > >   * both bpf_rbtree_remove and bpf_rbtree_first return the type containing
> > >     the bpf_rb_node field, with the offset set to that field's offset,
> > >     instead of a struct bpf_rb_node *
> > >     * mark_reg_graph_node helper added in previous patch generalizes
> > >       this logic, use it
> > >
> > >   * bpf_rbtree_remove's node input is a node that's been inserted
> > >     in the tree - a non-owning reference.
> > >
> > >   * bpf_rbtree_remove must invalidate non-owning references in order to
> > >     avoid aliasing issue. Use previously-added
> > >     invalidate_non_owning_refs helper to mark this function as a
> > >     non-owning ref invalidation point.
> > >
> > >   * Unlike other functions, which convert one of their input arg regs to
> > >     non-owning reference, bpf_rbtree_first takes no arguments and just
> > >     returns a non-owning reference (possibly null)
> > >     * For now verifier logic for this is special-cased instead of
> > >       adding new kfunc flag.
> > >
> > > This patch, along with the previous one, complete special verifier
> > > handling for all rbtree API functions added in this series.
> > >
> >
> > I think there are two issues with the current approach. The fundamental
> > assumption with non-owning references is that it is part of the collection. So
> > bpf_rbtree_{add,first}, bpf_list_push_{front,back} will create them, as no node
> > is being removed from collection. Marking bpf_rbtree_remove (and in the future
> > bpf_list_del) as invalidation points is also right, since once a node has been
> > removed it is going to be unclear whether existing non-owning references have
> > the same value, and thus the property of 'part of the collection' will be
> > broken.
>
> correct, but the patch set does invalidate after bpf_rbtree_remove(),
> so it's not an issue.
>
> > The first issue relates to usability. If I have non-owning references to nodes
> > inserted into both a list and an rbtree, bpf_rbtree_remove should only
> > invalidate the ones that are part of the particular rbtree. It should have no
> > effect on others. Likewise for the bpf_list_del operation in the future.
> > Therefore, we need to track the collection identity associated with each
> > non-owning reference, then only invalidate non-owning references associated with
> > the same collection.
> >
> > The case of bpf_spin_unlock is different, which should invalidate all non-owning
> > references.
> >
> > The second issue is more serious. By not tracking the collection identity, we
> > will currently allow a non-owning reference for an object inserted into a list
> > to be passed to bpf_rbtree_remove, because the verifier cannot discern between
> > 'inserted into rbtree' vs 'inserted into list'. For it, both are currently
> > equivalent in the verifier state. An object is allowed to have both
> > bpf_list_node and bpf_rb_node, but it can only be part of one collection at a
> > time (because of no shared ownership).
> >
> > 	struct obj {
> > 		bpf_list_node ln;
> > 		bpf_rb_node rn;
> > 	};
> >
> > 	bpf_list_push_front(head, &obj->ln); // node is non-own-ref
> > 	bpf_rbtree_remove(&obj->rn); // should not work, but does
>
> Also correct, but inserting the same single owner node into rbtree and link list
> is not supported. Only 'shared ownership' node can be inserted into
> two collections.

What is supported is having an object be part of a list and an rbtree one at a
time, which is what I'm talking about here. Shared ownership has nothing to do
with this.

> The check to disallow bpf_list_node and bpf_rb_node in the same obj
> can be a follow up patch to close this hole.
>

Fine, that would also 'fix' this problem, where a non-owning reference part of a
list could be passed to bpf_rbtree_remove etc. If there can only be a list node
or an rbtree node in an object, such a case cannot be constructed. But I think
it's an awkward limitation.

> > So some notion of a collection identity needs to be constructed, the amount of
> > data which needs to be remembered in each non-owning reference's register state
> > depends on our requirements.
> >
> > The first sanity check is that bpf_rbtree_remove only removes something in an
> > rbtree, so probably an enum member indicating whether collection is a list or
> > rbtree. To ensure proper scoped invalidation, we will unfortunately need more
> > than just the reg->id of the reg holding the graph root, since map values of
> > different maps may have same id (0). Hence, we need id and ptr similar to the
> > active lock case for proper matching. Even this won't be enough, as there can be
> > multiple list or rbtree roots in a particular memory region, therefore the
> > offset also needs to be part of the collection identity.
> >
> > So it seems it will amount to:
> >
> > 	struct bpf_collection_id {
> > 		enum bpf_collection_type type;
> > 		void *ptr;
> > 		int id;
> > 		int off;
> > 	};
> >
> > There might be ways to optimize the memory footprint of this struct, but I'm
> > just trying to state why we'll need to include all four, so we don't miss out on
> > a corner case again.
>
> The trade-off doesn't feel right here. Tracking collection id complexity in
> the verifier for single owner case is not worth it imo.

It was more about correctness after this set is applied than being worth it. We
could argue it's not worth it for the first issue which relates to usability.
Dave has already mentioned that point. But the second one is simply incorrect to
allow. As soon as you want an object which can be part of both a list and rbtree
at different times (e.g., an item usually part of an rbtree but which is popped
out and moved to a list for some processing), people will be able to trigger it.

Simply disallowing that (as you said above) is also an option. But whenever you
do allow it, you will need to add something like this. It has little to do with
whether shared ownership is supported or not.

> We should focus on adding support for 'shared ownership' with explicit refcount in the obj.
> Then the same obj can be inserted into two rbtrees or into rbtree and link list.
>
> Single owner rb-tree is a big step and we've been trying to make this step for the last ~6 month.
> I prefer to do it now and worry about UX, shared owner, etc in the follow ups.
> We need to start using lists and rbtree in bpf progs that do real work to get a feel
> on whether UX is right or unusable or somewhere in-between.
