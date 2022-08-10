Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8597458F4BD
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 01:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiHJXQ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 19:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHJXQ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 19:16:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E5279EFD
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 16:16:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d187so6681382iof.4
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5nTkKdwl3VhpsGQc0Q951tVWFeGUipc4OlwaamzfkrU=;
        b=XituKCRBhfQx4imB/Xmuly3Jsy9Ql5zO35DcYUI9ZNmd5qtVeelgIipAKokqFpd7iC
         46Nr10YZL5vJkTtUdTN5xuZHKr1pwNnbaTfGSkO2D9vKlFX0gqyJDTmq3dCLRMGliOOJ
         f62cA0Fylbi4V4Tus7pjllivbbmss/0P039Ej4m4ZZkmBBHtW3aco+NDBG9wmOfWmKT3
         7F0EARCeWdCsR0Ilww+7ft5QsNnQgNXbEuf/dJqfdNhVDZutUmQOCDKjUNf6qOXkGrzd
         q72EoxWPnckExeuG/tfAWtTfPiZUh5jR3EiU0dwmSc3ebnsZKzYmSas23BpTw5CC0yET
         CTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5nTkKdwl3VhpsGQc0Q951tVWFeGUipc4OlwaamzfkrU=;
        b=oxZ8HDlNkUwrvXUKhjaN2G3LToC1oBNEyY1PaFCeiIJadXHaROfma+yqsppLruFYLK
         /Sc9MqPL0R8X60VBvKOVJfm/YkJrSeB9elZVeP0/UQJEwefXRCFbCtDJAm3xfAX51hHN
         0l8BjHHUtjOJVDDAdz3IzJNoWFymsFJZtgdEC7VkLlRVBTutX0JpWCb3EpsWxQB6kTFG
         sR5qar2WuxRQ9br7C4MoTJ7x9xAPSlfzP3/BgOPemXUSmcp2ISBKQqsVRTMEyVTP9v10
         vCCoBz6ASZb2xY8eeOFnXbq/MhlN0PXaiV7IsHpU3CxKCyiZPE4v1RR42FVV606CTsoF
         udiw==
X-Gm-Message-State: ACgBeo0PHNhxsJNYV3Dswz8rliQncPL+YpxWnc0MwSPeDV6zO/UKBnPm
        NZ8/ebstpEIyvMA380opDZa/nax4vgKm+MBsdGs=
X-Google-Smtp-Source: AA6agR4ja1lwOz20wI329KL4HAc0NT86o1FEPkoMg4BXkBmLUFMu4WvWYO+O4Ul/btdB6WzkY9dIzx7NUNtm1ZsxnVI=
X-Received: by 2002:a05:6638:210e:b0:343:1748:910 with SMTP id
 n14-20020a056638210e00b0034317480910mr7218760jaj.116.1660173414029; Wed, 10
 Aug 2022 16:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-6-davemarchevsky@fb.com> <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
 <CAP01T75nt69=jgGPGXYXHSGc5EDHejgLQpyY8TMeUy2U4Prxvg@mail.gmail.com> <CAADnVQ+1SE8EVMEuM=6fbjkA63Lv-OqzMCrgAkg5dS_mb5g6bg@mail.gmail.com>
In-Reply-To: <CAADnVQ+1SE8EVMEuM=6fbjkA63Lv-OqzMCrgAkg5dS_mb5g6bg@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 11 Aug 2022 01:16:17 +0200
Message-ID: <CAP01T76xEBcn5K4F8-4xt_TwBwtVCkyCLMJLBDG8iiAJpOzhCw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to rbtree
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Aug 2022 at 00:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 10, 2022 at 2:47 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Just to continue brainstorming: Comments on this?
> >
> > Instead of a rbtree map, you have a struct bpf_rbtree global variable
> > which works like a rbtree. To associate a lock with multiple
> > bpf_rbtree, you do clang style thread safety annotation in the bpf
> > program:
> >
> > #define __guarded_by(lock) __attribute__((btf_type_tag("guarded_by:" #lock))
> >
> > struct bpf_spin_lock shared_lock;
> > struct bpf_rbtree rbtree1 __guarded_by(shared_lock);
> > struct bpf_rbtree rbtree2 __guarded_by(shared_lock);
> >
> > guarded_by tag is mandatory for the rbtree. Verifier ensures
> > shared_lock spin lock is held whenever rbtree1 or rbtree2 is being
> > accessed, and whitelists add/remove helpers inside the critical
> > section.
>
> We've been discussing exactly btf_type_tag annotation
> to associate rbtree with a lock :)
> Thanks for bringing it up as well.
> Great that we're aligned.
>

You know how the saying goes, "Great minds think alike" ;-)

> > I don't think associating locks to rbtree dynamically is a hard
> > requirement for your use case? But if you need that, you may probably
> > also allocate sets of rbtree that are part of the same lock "class"
> > dynamically using bpf_kptr_alloc, and do similar annotation for the
> > struct being allocated.
> > struct rbtree_set {
> >   struct bpf_spin_lock lock;
> >   struct bpf_rbtree rbtree1 __guarded_by(lock);
> >   struct bpf_rbtree rbtree2 __guarded_by(lock);
> > };
> > struct rbtree_set *s = bpf_kptr_alloc(sizeof(*s), btf_local_type_id(*s));
> > // Just stash the pointer somewhere with kptr_xchg
> > On bpf_kptr_free, the verifier knows this is not a "trivial" struct,
> > so inserts destructor calls for bpf_rbtree fields during program
> > fixup.
> >
> > The main insight is that lock and rbtree are part of the same
> > allocation (map value for global case, ptr_to_btf_id for dynamic case)
> > so the locked state can be bound to the reg state in the verifier.
>
> It works nicely in the static case, but ffwd a bit.
> We might need an rbtree of rbtrees.
> Pretty much like map-in-map that we have today for hash tables.
>

True, the map in map case makes things harder. But just like
inner_map_fd, you will need to parameterize such rb_root/list_head
containers with a value type (probably type tag again) so the result
of find/remove can be known statically.
From there, we know the type of lock associated with the rbtree in the
value, _if_ we follow the convention of binding rb_root + lock + ...
in a single data item. Without that, it's pretty hard to do without
runtime checks, as you've pointed out in a previous reply.

My idea was that we should try to associate data being locked with its
lock in the same allocation, working a bit like a bpf_spin_lock<T>,
but more flexible as you can have additional unprotected data in the
struct by annotating using guarded_by style tags.

There might be some use cases where we really require dynamically
binding locks at runtime to some data structure, then we should
probably add that later when a use case comes up, and keep those sets
of APIs separate from the simpler case. As you mentioned, in the
dynamic case the add helper becomes fallible. The same will happen
with linked list helpers.

> And the rbtree_node might be a part of an rbtree while
> being chained into a separate link list.
>
> We need a lock to protect operations on both rbtree and link list.
> Then we might need to create an rbtree dynamically for each cgroup.
> And store a pointer to rb_root in cgroup local storage.
> Maybe allocating a lock + rb_root + linklist_head as one
> allocation will not be too restrictive.
>
> > Then we can also make this new rbtree API use kfuncs instead of UAPI
> > helpers, to get some field experience before baking it in.
>
> +1 to that.
>
> > Any opinions? Any brainos or deficiencies in the scheme above?
>
> It would be great if we can do the lock checks statically.
> Dynamic locks means that rbtree_add/erase and in the future
> link list insert/remove might fail which is horrible from
> programmer perspective.

+1. I'll also be happy to help with code review (for as much as I
understand) when Dave reposts the series.

> We've been thinking about the "abort" concept for such cases.
> When helpers detect an unsafe condition like correct lock is not
> taken, they can abort execution of itself, the bpf program
> and prevent the program from executing in the future.
> Conceptually it sounds great and will solve all kinds of ugliness,
> but it's not clear yet how to implement such abort mechanism
> which would mean stack unwind and calling of destructors for kptr-s,
> refcnt decrements for acquired objects like sockets, etc.

Fancy. Though it certainly looks very painful to implement (just
thinking about kptr, say the release kfunc is NMI unsafe, and
detecting such live kptr in perf prog moved out of a map, we would
probably then need to do it using irq_work_queue, but also alloc work
item for it, which might fail in NMI context unwind so mem leak).
