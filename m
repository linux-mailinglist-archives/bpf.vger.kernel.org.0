Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA15B21AD
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIHPLS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiIHPLQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 11:11:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58697114A7B
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 08:11:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z8so24857375edb.6
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IkWBUE+ZmiEZ4lFaHoyHmXiZ0gjpiR+qUtWSrrpXTlE=;
        b=U/CboLDM/kwi7BFptaMxv3gl7VxbZKrzs9wga01tAvLAXisyJp7gJrp/Mdf7/8Zivx
         wCSs4lbFiNbl1eIH4/FmsZMm5dUpdnHcjLb25zUJyTkkXR5dlaJ0U+YnLEPSxBKYMh9B
         Pr51c2zzvyXBaz8BfftT9c/6H+CSeo8oqxS5tq7f2jOhwQTG/l835DdmV/gYbv8mNipq
         5mNEDY0tE6Y+1M6Bp/bRSVDRiVihLyQbeS6oYaMA2amGcElLT7dPZlFOzQGZfWuHZpYp
         CfnHZgowzAplkPzBGwwQ1xjAdA2ijjm74fi/4XYmH4SrWcS6TU1p7qLjZY5uE8nJYHii
         cnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IkWBUE+ZmiEZ4lFaHoyHmXiZ0gjpiR+qUtWSrrpXTlE=;
        b=NVv8N30/aEXaIZouG+BzWbCxT/CEmv3k1JgGpsJnJFYGb1KgcIqsf8CO85EK7md12x
         +7ID94azu5WNQNA50Aa7igfYtqrkr2iQ3UClMFss7fo0gDTdsnaNzMhcMW3D7Lc6Fjff
         VfHkni3mLKBGbz6QlqLfhi1QwjyudWh9lRmHXhvauItuFWYG0xLS9gvYnADPbbx/Qs6S
         +9APDtIxeGTt9CeJneYPQFOS1ArhYfEuN9YEwMDL1Md7UP8Z7Mme+wT2Ke7nHacBubIV
         mK+O1AYhMmCCDoRRIyTGS6bMYxenuy/Eexd4u52FxmKoae/9oi4QraXQtX0ENFCIWimL
         PtPg==
X-Gm-Message-State: ACgBeo3h2fbyVNT4cF6o/qsU5TguxfmrSoLB1JeSm2YcLs2e4RFXNicu
        CoSmOfzVirFJ+7Uho0G0KX44sYYKiBHWkkF5ua4=
X-Google-Smtp-Source: AA6agR4rd8zdTHRM7YRAiXRaQO1+r7cssnG+i+CpChd3/nm0wT1rdHAmT6Rtu/c3Y8D7EAqbj9K+EqIEh4MIeuficmU=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr7706638edb.333.1662649873806; Thu, 08
 Sep 2022 08:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-17-memxor@gmail.com>
 <20220908003429.wsucvsdcxnkipcja@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T77-ygt+MvvwzRwo+3kDrk_8sCv-ASGT8qL2PvPjL_11jw@mail.gmail.com>
 <20220908033741.l6zhopfhnfrpi72y@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T76YqSKUMFCVz-WqQQL29SFFn4DG6wqwm0HVpN2-DqJuFA@mail.gmail.com>
 <CAADnVQ+hgprNMCSk0bjZnRveEzv=t8zoZXH44Gy8tVPJKoPt_A@mail.gmail.com> <CAP01T74cHVp4SNfyS+XERU-51z+Sr2L=HMRKaQWRHn5ZKREpzg@mail.gmail.com>
In-Reply-To: <CAP01T74cHVp4SNfyS+XERU-51z+Sr2L=HMRKaQWRHn5ZKREpzg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Sep 2022 08:11:02 -0700
Message-ID: <CAADnVQLc6bWuyknq_ZqLqEyMmkgg3nia6VW7+9MvgDPTOvJ=kQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 16/32] bpf: Introduce BPF memory object model
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
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

On Thu, Sep 8, 2022 at 7:46 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, 8 Sept 2022 at 16:18, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 8, 2022 at 4:50 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > I slept over this. I think I can get behind this idea of implicit
> > > ctor/dtor. We might have open coded construction/destruction later if
> > > we want.
> > >
> > > I am however thinking of naming these helpers:
> > > bpf_kptr_new
> > > bpf_kptr_delete
> > > to make it clear it does a little more than just allocating the type.
> > > The open coded cases can later derive their allocation from the more
> > > bare bones bpf_kptr_alloc instead in the future.
> >
> > New names make complete sense. Good idea.
> >
> > > The main reason to have open coded-ness was being able to 'manage'
> > > resources once visibility reduces to current CPU (bpf_refcount_put,
> > > single ownership after xchg, etc.). Even with RCU, we won't allow
> > > touching the BPF special fields without refcount. bpf_spin_lock is
> > > different, as it protects more than just bpf special fields.
> > >
> > > But one can still splice or kptr_xchg before passing to bpf_kptr_free
> > > to do that. bpf_kptr_free is basically cleaning up whatever is left by
> > > then, forcefully. In the future, we might even be able to do elision
> > > of implicit dtors based on the seen data flow (splicing in single
> > > ownership implies list is empty, any other op will undo that, etc.) if
> > > there are big structs with too many fields. Can also support that in
> > > open coded cases.
> >
> > Right.
> >
> > >
> > > What I want to think about more is whether we should still force
> > > calling bpf_refcount_set vs always setting it to 1.
> > >
> > > I know we don't agree about whether list_add in shared mode should
> > > take ref vs transfer ref. I'm leaning towards transfer since that will
> > > be most intuitive. It then works the same way in both cases, single
> > > ownership only transfers the sole reference you have, so you lose
> > > access, but in shared you may have more than one. If you have just one
> > > you will still lose access.
> > >
> > > It will be odd for list_add to consume it in one case and not the
> > > other. People should already be fully conscious of how they are
> > > managing the lifetime of their object.
> > >
> > > It then seems better to require users to set the initial refcount
> > > themselves. When doing the initial linking it can be very cheap.
> > > Later get/put/inc are always available.
> > >
> > > But forcing it to be called is going to be much simpler than this patch.
> >
> > I'm not convinced yet :)
> > Pls hold on implementing one way or another.
> > Let's land the single ownership case for locks, lists,
> > rbtrees, allocators. That's plenty of patches.
> > Then we can start a deeper discussion into the shared case.
> > Whether it will be different in terms of 'lose access after list_add'
> > is not critical to decide now. It can change in the future too.
> >
>
> Right, I'm not implementing it yet. There's a lot of work left to even
> finish single ownership structures, then lots of testing.
> But it's helpful to keep thinking about future use cases while working
> on the current stuff, just to make sure we're not
> digging ourselves into a design hole.
>
> We have the option to undo damage here, since this is all
> experimental, but there's still an expectation that the API is not
> broken at whim. That wouldn't be very useful for users.

imo this part is minor.
The whole lock + list_or_rbtree in a single allocation
restriction bothers me a lot more.
We will find out for sure only when wwe have a prototype
of lock + list + rbtree and let folks who requested it
actually code things.

> > The other reason to do implicit inits and ref count sets is to
>
> I am not contesting implicit construction.
> Other lists already work with zero initialization so list_head seems
> more of an exception.
> But it's done for good reasons to avoid extra NULL checks
> unnecessarily, and make the implementation of list helpers more
> efficient and simple at the same time.
>
> > avoid fighting llvm.
> > obj = bpf_kptr_new();
> > obj->var1 = 1;
> > some_func(&obj->var2);
> > In many cases the compiler is allowed to sink stores.
> > If there are two calls that "init" two different fields
> > the compiler is allowed to change the order as well
> > even if it doesn't see the body of the function and the function is
> > marked as __pure. Technically initializers as pure functions.
>
> But bpf_refcount_set won't be marked __pure, neither am I proposing to
> allow direct stores to 'set' it.
> I'm not a compiler expert by any means, but AFAIK it should not be
> doing such reordering for functions otherwise.
> What if the function inside has a memory barrier? That would
> completely screw up things.
> It's going to have external linkage, so I don't think it can assume
> anything about side effects or not. So IMO this is not a good point.

The pure attribute tells the compiler that the function doesn't
have side effects. We even use it in the kernel code base.
Sooner or later we'll start using it in bpf too.
Things like memcmp is a primary example.
I have to correct myself though. refcount_set shouldn't be
considered pure.

> Unless you're talking about some new way of inlining such helpers from
> the compiler side that doesn't exist yet.
>
> > The verifier and llvm already "fight" a lot.
> > We gotta be very careful in the verifier and not assume
> > that the code stays as written in C.
>
> So will these implicit zero stores be done when we enter != NULL
> branch, or lazily on first access (helper arg, load, store)?

Whichever way is faster and still safe.
I assumed that we'd have to zero them after successful alloc.

> This is the flip side: rewritings insns to add stores to local kptr
> can only happen after the NULL check, in the != NULL branch, at that
> point we cannot assume R1-R5 are free for use, so complicated field
> initialization will be uglier to do implicitly (e.g. if it involves
> calling functions etc.).
> There are pros and cons for both.

Are you expecting the verifier to insert zero inits
as actual insns after 'call bpf_kptr_new' insn ?
Hmm. I imagined bpf_kptr_new helper will do it.
Just a simple loop that is inverse of zero_map_value().
Not the fastest thing, but good enough to start and can be
optimized later.
The verifier can insert ST insn too in !null branch,
since that insn only needs one register and it's known
in that branch.
It's questionable that a bunch of ST insns will be faster
than a zero_map_value-like loop.
