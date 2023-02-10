Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06B692457
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjBJRVm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 12:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjBJRVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 12:21:41 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7406D61A
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 09:21:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so6147605pjw.2
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 09:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=reEF9Lvznpgd0LeoufTTHDfe9Y6R8lp7su8bXLtKyVo=;
        b=FIPz9gHLO5BDs/lPOAimik7BG4467Kq8uRlzx+QTtyU0bHL9dRXhHqeIDS2Pr/JvqF
         CKrFH86D/eRxsguo1anTEg/O2dLlCTJ1lJLvqKyD8kZI0IPiQWB4ffclOLArggsPIR6i
         MAy5GM/zURCgSF/bLxsjwK9nkrALR953ED3qwFGiwR+PbmWK+kJJVuCUamOFE735FMxu
         iPMfhuKOM8TSD7efT1ztTZ4dbUUWx8s0iWtZ3klkWtfWU5VxLEiqhv+C2MuUba7I4z1v
         O4K+CUSYMqIkwcdn2hd2i7n3QMBLGfQ3UVGJiIENiaSmMWpFHJUe/xmdaTd5/sRfe8Vm
         9vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reEF9Lvznpgd0LeoufTTHDfe9Y6R8lp7su8bXLtKyVo=;
        b=QJHgXrmMM3tkRNNEp+WCjojLMCvD8Mm46irJIqHjSQI36OicSHy8yg1llTnbtXRw30
         NC/BbTJwdY3aQUCuDxDTiZVVRKuxthS5UraPGSvDgj0KTlMydBTso9SHZrQZ9niSTgYU
         YkAZDoIkVRrSZ5ligS0zk/Ouy+zP/jVUs6OfbZht0S/UG5bzzSTuuFeiI1ySFBwY1SAJ
         anfLj/JLknUQVbR0qtoSF22+c/cBD4Wj/Gt7ed6z9WKG2G1ZJNYk6tceWsf58QfSDBF0
         R/ttDaqxXFxZt0Mtsg7JHYN0dHBgoTPFprqlz/d9FWFAqLfa7v4/1+16pl/C2J5Idxoa
         xG9A==
X-Gm-Message-State: AO0yUKVAYxLTSHPIykh8nj8aFMw3klq/T6BQyUepvz/XoH5ClIOsgs2g
        kAX+Yd4CNYcWLyIGVWyGKTw=
X-Google-Smtp-Source: AK7set8WIy7zr6tIcBHpOsEpFzjuUjVAtCKwL0h7lWHsboTudttirL0nrn1Ix8CruUbI4Fc4ngM5xA==
X-Received: by 2002:a17:902:7c11:b0:198:e7f3:169a with SMTP id x17-20020a1709027c1100b00198e7f3169amr11340528pll.44.1676049700110;
        Fri, 10 Feb 2023 09:21:40 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:c6db])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0017f5ad327casm3638806plb.103.2023.02.10.09.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:21:39 -0800 (PST)
Date:   Fri, 10 Feb 2023 09:21:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <20230210172137.jwqynnjtmjcv4dqe@MacBook-Pro-6.local>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
 <20230210135541.xtwn6wzng7mspgrm@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210135541.xtwn6wzng7mspgrm@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 02:55:41PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Thu, Feb 09, 2023 at 06:41:41PM CET, Dave Marchevsky wrote:
> > Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
> > that require handling in the verifier:
> >
> >   * both bpf_rbtree_remove and bpf_rbtree_first return the type containing
> >     the bpf_rb_node field, with the offset set to that field's offset,
> >     instead of a struct bpf_rb_node *
> >     * mark_reg_graph_node helper added in previous patch generalizes
> >       this logic, use it
> >
> >   * bpf_rbtree_remove's node input is a node that's been inserted
> >     in the tree - a non-owning reference.
> >
> >   * bpf_rbtree_remove must invalidate non-owning references in order to
> >     avoid aliasing issue. Use previously-added
> >     invalidate_non_owning_refs helper to mark this function as a
> >     non-owning ref invalidation point.
> >
> >   * Unlike other functions, which convert one of their input arg regs to
> >     non-owning reference, bpf_rbtree_first takes no arguments and just
> >     returns a non-owning reference (possibly null)
> >     * For now verifier logic for this is special-cased instead of
> >       adding new kfunc flag.
> >
> > This patch, along with the previous one, complete special verifier
> > handling for all rbtree API functions added in this series.
> >
> 
> I think there are two issues with the current approach. The fundamental
> assumption with non-owning references is that it is part of the collection. So
> bpf_rbtree_{add,first}, bpf_list_push_{front,back} will create them, as no node
> is being removed from collection. Marking bpf_rbtree_remove (and in the future
> bpf_list_del) as invalidation points is also right, since once a node has been
> removed it is going to be unclear whether existing non-owning references have
> the same value, and thus the property of 'part of the collection' will be
> broken.

correct, but the patch set does invalidate after bpf_rbtree_remove(),
so it's not an issue.

> The first issue relates to usability. If I have non-owning references to nodes
> inserted into both a list and an rbtree, bpf_rbtree_remove should only
> invalidate the ones that are part of the particular rbtree. It should have no
> effect on others. Likewise for the bpf_list_del operation in the future.
> Therefore, we need to track the collection identity associated with each
> non-owning reference, then only invalidate non-owning references associated with
> the same collection.
> 
> The case of bpf_spin_unlock is different, which should invalidate all non-owning
> references.
> 
> The second issue is more serious. By not tracking the collection identity, we
> will currently allow a non-owning reference for an object inserted into a list
> to be passed to bpf_rbtree_remove, because the verifier cannot discern between
> 'inserted into rbtree' vs 'inserted into list'. For it, both are currently
> equivalent in the verifier state. An object is allowed to have both
> bpf_list_node and bpf_rb_node, but it can only be part of one collection at a
> time (because of no shared ownership).
> 
> 	struct obj {
> 		bpf_list_node ln;
> 		bpf_rb_node rn;
> 	};
> 
> 	bpf_list_push_front(head, &obj->ln); // node is non-own-ref
> 	bpf_rbtree_remove(&obj->rn); // should not work, but does

Also correct, but inserting the same single owner node into rbtree and link list
is not supported. Only 'shared ownership' node can be inserted into
two collections.
The check to disallow bpf_list_node and bpf_rb_node in the same obj
can be a follow up patch to close this hole.

> So some notion of a collection identity needs to be constructed, the amount of
> data which needs to be remembered in each non-owning reference's register state
> depends on our requirements.
> 
> The first sanity check is that bpf_rbtree_remove only removes something in an
> rbtree, so probably an enum member indicating whether collection is a list or
> rbtree. To ensure proper scoped invalidation, we will unfortunately need more
> than just the reg->id of the reg holding the graph root, since map values of
> different maps may have same id (0). Hence, we need id and ptr similar to the
> active lock case for proper matching. Even this won't be enough, as there can be
> multiple list or rbtree roots in a particular memory region, therefore the
> offset also needs to be part of the collection identity.
> 
> So it seems it will amount to:
> 
> 	struct bpf_collection_id {
> 		enum bpf_collection_type type;
> 		void *ptr;
> 		int id;
> 		int off;
> 	};
> 
> There might be ways to optimize the memory footprint of this struct, but I'm
> just trying to state why we'll need to include all four, so we don't miss out on
> a corner case again.

The trade-off doesn't feel right here. Tracking collection id complexity in
the verifier for single owner case is not worth it imo.
We should focus on adding support for 'shared ownership' with explicit refcount in the obj.
Then the same obj can be inserted into two rbtrees or into rbtree and link list.

Single owner rb-tree is a big step and we've been trying to make this step for the last ~6 month.
I prefer to do it now and worry about UX, shared owner, etc in the follow ups.
We need to start using lists and rbtree in bpf progs that do real work to get a feel
on whether UX is right or unusable or somewhere in-between.
