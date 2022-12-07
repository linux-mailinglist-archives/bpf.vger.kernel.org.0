Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C15646159
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 19:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLGS7i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 13:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGS7g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 13:59:36 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6AF5C77E
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 10:59:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2341707pjt.0
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUg4N/xZgAVhPlwJ6Pkag17j80dwA8rzwDhT0TYgkAM=;
        b=oHVMVzOG2/RikH5eBpxz9UObzCh+7jTYoCf0mYQDlSSM8I/cX0iw0HeLZdrizNhmYt
         NF7DEGv0UE7gY1noD4PU65Fc3ayTghln/y+tMbtXP7o8S3J3NhIiqV4PoOqMLebU/+m8
         z/1iidROTsjzPX0oqnbxFwuRLV7PLxbWbPa/mKMzBYcRXmArsBkj+LQwttglDMQDaZ9P
         s8Avqoga36WrBdBtLUaPICu2NvpKKVz9YzIaW4xIwVuVXaIGe9MrEJiv8+WtEp5ZS0Kw
         gf+w8qZMJnmdDBnRGRjATPEn0FzA4d0m0LG8AYt+U6QigxtDpBzOGAJXdNv8es/Mwa7E
         mT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUg4N/xZgAVhPlwJ6Pkag17j80dwA8rzwDhT0TYgkAM=;
        b=FpXKAH8B6ZSDbm1LNK3znl5AXk/n7P0T/Z9a9diY4VqkC6ttA740xdDyfj3MqyM2Nr
         Z0wgJZHCRD1/OalTN86nQmVUcHxWZ5Coog4BZ+Q3vcg8+BFz6CaYgr9bKMTC71Fe7KUk
         WnZY14LIJnLippOmo2dDFp63EaYaOTFgowMhrUjxRBA/osjjTEZnvXRVZ+pc1R3dtq09
         OkjuXtVU32aWK5yA16xXSlIV/6YeqJnsWyx9qgzfnUD7cZhejRcFcPkUZ43Ygx5Wdfwu
         Hf9pGMt5rjnmVIJEIdzn2FXl/Smwb4jlPcgTc6k0E7n8+zKI2d+ZJoltbqwEkI2lKFG6
         7V4w==
X-Gm-Message-State: ANoB5pkO7t8N/ejEhnsz/Bldm+K/h9ecK6m3QLNCO7Q9hQBVnLkhE4BL
        90Tl6Y2pzGo+EBO7i5ebtofRqFJKY28=
X-Google-Smtp-Source: AA0mqf6HSVcZVy261TFFg/4s1M0UVoRsyce36M+PeILVJ/uaVzosKCncS0/nU/6Ye+TPJE+wn5/hbA==
X-Received: by 2002:a17:90a:8914:b0:219:3f82:90fc with SMTP id u20-20020a17090a891400b002193f8290fcmr951193pjn.17.1670439575225;
        Wed, 07 Dec 2022 10:59:35 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id q2-20020a635c02000000b004768b74f208sm11801715pgb.4.2022.12.07.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 10:59:34 -0800 (PST)
Date:   Wed, 7 Dec 2022 10:59:31 -0800
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
Message-ID: <20221207185931.hvte3vutd4y4qfh4@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-2-davemarchevsky@fb.com>
 <20221207164121.h6wm5crfhhvekqvd@apollo>
 <a8079b93-15d5-147d-226b-13bbebfda75e@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8079b93-15d5-147d-226b-13bbebfda75e@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 01:34:44PM -0500, Dave Marchevsky wrote:
> On 12/7/22 11:41 AM, Kumar Kartikeya Dwivedi wrote:
> > On Wed, Dec 07, 2022 at 04:39:48AM IST, Dave Marchevsky wrote:
> >> btf->struct_meta_tab is populated by btf_parse_struct_metas in btf.c.
> >> There, a BTF record is created for any type containing a spin_lock or
> >> any next-gen datastructure node/head.
> >>
> >> Currently, for non-MAP_VALUE types, reg_btf_record will only search for
> >> a record using struct_meta_tab if the reg->type exactly matches
> >> (PTR_TO_BTF_ID | MEM_ALLOC). This exact match is too strict: an
> >> "allocated obj" type - returned from bpf_obj_new - might pick up other
> >> flags while working its way through the program.
> >>
> > 
> > Not following. Only PTR_TO_BTF_ID | MEM_ALLOC is the valid reg->type that can be
> > passed to helpers. reg_btf_record is used in helpers to inspect the btf_record.
> > Any other flag combination (the only one possible is PTR_UNTRUSTED right now)
> > cannot be passed to helpers in the first place. The reason to set PTR_UNTRUSTED
> > is to make then unpassable to helpers.
> > 
> 
> I see what you mean. If reg_btf_record is only used on regs which are args,
> then the exact match helps enforce PTR_UNTRUSTED not being an acceptable
> type flag for an arg. Most uses of reg_btf_record seem to be on arg regs,
> but then we have its use in reg_may_point_to_spin_lock, which is itself
> used in mark_ptr_or_null_reg and on BPF_REG_0 in check_kfunc_call. So I'm not
> sure that it's only used on arg regs currently.
> 
> Regardless, if the intended use is on arg regs only, it should be renamed to
> arg_reg_btf_record or similar to make that clear, as current name sounds like
> it should be applicable to any reg, and thus not enforce constraints particular
> to arg regs.
> 
> But I think it's better to leave it general and enforce those constraints
> elsewhere. For kfuncs this is already happening in check_kfunc_args, where the
> big switch statements for KF_ARG_* are doing exact type matching.
> 
> >> Loosen the check to be exact for base_type and just use MEM_ALLOC mask
> >> for type_flag.
> >>
> >> This patch is marked Fixes as the original intent of reg_btf_record was
> >> unlikely to have been to fail finding btf_record for valid alloc obj
> >> types with additional flags, some of which (e.g. PTR_UNTRUSTED)
> >> are valid register type states for alloc obj independent of this series.
> > 
> > That was the actual intent, same as how check_ptr_to_btf_access uses the exact
> > reg->type to allow the BPF_WRITE case.
> > 
> > I think this series is the one introducing this case, passing bpf_rbtree_first's
> > result to bpf_rbtree_remove, which I think is not possible to make safe in the
> > first place. We decided to do bpf_list_pop_front instead of bpf_list_entry ->
> > bpf_list_del due to this exact issue. More in [0].
> > 
> >  [0]: https://lore.kernel.org/bpf/CAADnVQKifhUk_HE+8qQ=AOhAssH6w9LZ082Oo53rwaS+tAGtOw@mail.gmail.com
> > 
> 
> Thanks for the link, I better understand what Alexei meant in his comment on
> patch 9 of this series. For the helpers added in this series, we can make
> bpf_rbtree_first -> bpf_rbtree_remove safe by invalidating all release_on_unlock
> refs after the rbtree_remove in same manner as they're invalidated after
> spin_unlock currently.
> 
> Logic for why this is safe:
> 
>   * If we have two non-owning refs to nodes in a tree, e.g. from
>     bpf_rbtree_add(node) and calling bpf_rbtree_first() immediately after,
>     we have no way of knowing if they're aliases of same node.
> 
>   * If bpf_rbtree_remove takes arbitrary non-owning ref to node in the tree,
>     it might be removing a node that's already been removed, e.g.:
> 
>         n = bpf_obj_new(...);
>         bpf_spin_lock(&lock);
> 
>         bpf_rbtree_add(&tree, &n->node);
>         // n is now non-owning ref to node which was added
>         res = bpf_rbtree_first();
>         if (!m) {}
>         m = container_of(res, struct node_data, node);
>         // m is now non-owning ref to the same node
>         bpf_rbtree_remove(&tree, &n->node);
>         bpf_rbtree_remove(&tree, &m->node); // BAD

Let me clarify my previous email:

Above doesn't have to be 'BAD'.
Instead of
if (WARN_ON_ONCE(RB_EMPTY_NODE(n)))

we can drop WARN and simply return.
If node is not part of the tree -> nop.

Same for bpf_rbtree_add.
If it's already added -> nop.

Then we can have bpf_rbtree_first() returning PTR_TRUSTED with acquire semantics.
We do all these checks under the same rbtree root lock, so it's safe.

>         bpf_spin_unlock(&lock);
> 
>   * bpf_rbtree_remove is the only "pop()" currently. Non-owning refs are at risk
>     of pointing to something that was already removed _only_ after a
>     rbtree_remove, so if we invalidate them all after rbtree_remove they can't
>     be inputs to subsequent remove()s

With above proposed run-time checks both bpf_rbtree_remove and bpf_rbtree_add
can have release semantics.
No need for special release_on_unlock hacks.

> This does conflate current "release non-owning refs because it's not safe to
> read from them" reasoning with new "release non-owning refs so they can't be
> passed to remove()". Ideally we could add some new tag to these refs that
> prevents them from being passed to remove()-type fns, but does allow them to
> be read, e.g.:
> 
>   n = bpf_obj_new(...);

'n' is acquired.

>   bpf_spin_lock(&lock);
> 
>   bpf_rbtree_add(&tree, &n->node);
>   // n is now non-owning ref to node which was added

since bpf_rbtree_add does release on 'n'...

>   res = bpf_rbtree_first();
>   if (!m) {}
>   m = container_of(res, struct node_data, node);
>   // m is now non-owning ref to the same node

... below is not allowed by the verifier.
>   n = bpf_rbtree_remove(&tree, &n->node);

I'm not sure what's an idea to return 'n' from remove...
Maybe it should be simple bool ?

>   // n is now owning ref again, m is non-owning ref to same node
>   x = m->key; // this should be safe since we're still in CS

below works because 'm' cames from bpf_rbtree_first that acquired 'res'.

>   bpf_rbtree_remove(&tree, &m->node); // But this should be prevented
> 
>   bpf_spin_unlock(&lock);
> 
