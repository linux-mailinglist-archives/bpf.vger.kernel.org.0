Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6828064616E
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLGTEL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiLGTEE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:04:04 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B86F0F4
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:04:03 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 130so18281387pfu.8
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5K/sf0VH4OzDefUmuGyHy84NtDHz6KbIOb3vosqNllQ=;
        b=XQWGCDzAmdVo0aE4n87kMFPdM3hCTVxEaxIXbob+jC3U2wtljcJXdHiOieebyLZ8D2
         TZIb7kXuhvZs361iJxOmZR+Nk9HGYsjvJlaf5zQDsnihvCtBEclJHWMXwrrbqWLtCyKc
         3prKBvPcbZr9Lc6UDNuHFsQyZkB25tmVmmBbqs+vgD4RLjQkF0tjHd8p0KjRPt7ZHU0H
         binltkpjeAeL/rst6K8VNZxUlbSvmY5ZTivCjJdQPYtl9r6dt7j+tEPiXqPyBeZYyrvn
         S6Rb8xO/4qPuYbumEplJBHTRrUq2NZeLoiC0sBwuLwnFgTAq/nBXtbVxDQgd51pLy4TR
         G/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K/sf0VH4OzDefUmuGyHy84NtDHz6KbIOb3vosqNllQ=;
        b=1Xe/c2Y/sSiXVEHXNg5BktENMfUsiTrifpT1CjB4wa1bsRpNYepPPx579QFnKnHOlm
         arTi5I8GJbsIYu0rwRfxeul9YG7Vq/2Q7oz1OmliteOQ9JgKFC56T/nOc7tIbA6PTyB8
         57BfiqsmCIKeuT/ScpYQ2Alqmps9QvqPgDuG65gtGzTS2Azkw2c0lBjFLQ50g0klYlFY
         QxFutKPTejGqGZz9KYWRCyfWyDr48xdbRKQbFdSX9obzTl6uRolwhYElLB9SCPHn2lIm
         rZFsRIVvmzCN5GgTOfE5iZ7zHo+qtbsAdYGvPwQ/LeM4zTRn4+YNjeX/a6Cg3LFOBWIT
         EvqQ==
X-Gm-Message-State: ANoB5pm7CLZ1bfAMOkvjdaMlf49WA/8z7bsN5yQxP7lkTGm5mKZkl4Rm
        VtdsZrurMgRHknaEhflMl/g=
X-Google-Smtp-Source: AA0mqf75WWj5/2wWpOzNRmUel8wJMy/HNw+qxZpnz0APMJiYOHDkLqOlaczBOV2Ftg9YJzF3kv2hUA==
X-Received: by 2002:a05:6a00:194a:b0:56b:a795:e99c with SMTP id s10-20020a056a00194a00b0056ba795e99cmr84783400pfk.14.1670439842608;
        Wed, 07 Dec 2022 11:04:02 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056d3b8f530csm13903793pfc.34.2022.12.07.11.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:04:02 -0800 (PST)
Date:   Thu, 8 Dec 2022 00:33:59 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 01/13] bpf: Loosen alloc obj test in verifier's
 reg_btf_record
Message-ID: <20221207190359.ad22jnkmxnbj5ya3@apollo>
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

On Thu, Dec 08, 2022 at 12:04:44AM IST, Dave Marchevsky wrote:
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

Rather than doing that, you'll cut down on a lot of complexity and confusion
regarding PTR_UNTRUSTED's use in this set by removing bpf_rbtree_first and
bpf_rbtree_remove, and simply exposing bpf_rbtree_pop_front.

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
>
>         bpf_spin_unlock(&lock);
>
>   * bpf_rbtree_remove is the only "pop()" currently. Non-owning refs are at risk
>     of pointing to something that was already removed _only_ after a
>     rbtree_remove, so if we invalidate them all after rbtree_remove they can't
>     be inputs to subsequent remove()s
>
> This does conflate current "release non-owning refs because it's not safe to
> read from them" reasoning with new "release non-owning refs so they can't be
> passed to remove()". Ideally we could add some new tag to these refs that
> prevents them from being passed to remove()-type fns, but does allow them to
> be read, e.g.:
>
>   n = bpf_obj_new(...);
>   bpf_spin_lock(&lock);
>
>   bpf_rbtree_add(&tree, &n->node);
>   // n is now non-owning ref to node which was added
>   res = bpf_rbtree_first();
>   if (!m) {}
>   m = container_of(res, struct node_data, node);
>   // m is now non-owning ref to the same node
>   n = bpf_rbtree_remove(&tree, &n->node);
>   // n is now owning ref again, m is non-owning ref to same node
>   x = m->key; // this should be safe since we're still in CS
>   bpf_rbtree_remove(&tree, &m->node); // But this should be prevented
>
>   bpf_spin_unlock(&lock);
>
> But this would introduce too much addt'l complexity for now IMO. The proposal
> of just invalidating all non-owning refs prevents both the unsafe second
> remove() and the safe x = m->key.
>
> I will give it a shot, if it doesn't work can change rbtree_remove to
> rbtree_remove_first w/o node param. But per that linked convo such logic
> should be tackled eventually, might as well chip away at it now.
>

I sympathise with your goal to make it as close to kernel programming style as
possible. I was exploring the same option (as you saw in that link). But based
on multiple discussions so far and trying different approaches, I'm convinced
the additional complexity in the verifier is not worth it.

Both bpf_list_del and bpf_rbtree_remove are useful and should be added, but
should work on e.g. 'current' node in iteration callback. In that context
verifier knows that the node is part of the list/rbtree. Introducing more than
one node in that same context introduces potential aliasing which hinders the
verifier's ability to reason about safety. Then, it has to be pessimistic like
your case and invalidate everything to prevent invalid use, so that double
list_del and double rbtree_remove is not possible.

You will avoid all the problems with PTR_UNTRUSTED being passed to helpers if
you adopt such an approach. The code will become much simpler, while allowing
people to do the same thing without any loss of usability.
