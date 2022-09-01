Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8D5A8C1D
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 05:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiIAD4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 23:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIAD4H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 23:56:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765DAACA3C
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 20:56:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p16so28996016ejb.9
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 20:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lageO1Fc698aHwK/+Fo7PBlBzOyZ9Wez8u8tpKNOAS8=;
        b=PCCP4+OdZvyawHcxlPAVECWZ1N4l5pWvzrUQnMKjxNsyUNReiHpF6k6ZpzMCCzUm8R
         d53ZYeSLIiHthLTz9v7QYQT66Vyv/c9EePQvVAbDwxCxIATdtrWRq5F71+vwB3PzznSx
         wvc5owpMM2YLWQ1uiAYBybCpVlCsCbMbZt2ZyoGp1ZR8xlAcdSHaTofQGMHxNlki7CKd
         uWQ+/F1ZLRor8slxAnfUOpIdMnlxwe8xe0Sn96zZKaaBU2SfjnfMRt7sepi+UBfXZiiD
         Jk7QHtgu1T+B2d9/Z0+HZBTYQv/15egJ8hkDADKFVCubTf0ZuYxWlx2ZYLOPCPnUVkky
         Cw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lageO1Fc698aHwK/+Fo7PBlBzOyZ9Wez8u8tpKNOAS8=;
        b=aOXTYDxOfeKato2xB0qhjHrCIDL7yhcun2q19kmtmVl57kUMFS4woog3o1MVrQUo5c
         pOwQ1FoF/G+PV17tGbDuhfeVW4qF7hoQRwMuvuIiwaMwU4YSmXqxG406Jy0wwhBL70Pt
         C/3rer7vZTAPzXwIVb/lkXSLLAOKmmm/fzCobZRIhnrY/jqlMjZUWdYyA4Qr+2X4egx7
         o5iQRDV6YGGMnvYiN/bZCCUs350BCdlHfSTri09prfYnMNnXfaFhdWOkjj9G1ozmcq7x
         VZwq3Tj+MCk5FmN5nMnPeqaHfteC8e0FGnPiK/84z5tSZz+VwJrFwI7IfkwJ8EqUEM6Y
         dSaA==
X-Gm-Message-State: ACgBeo1v9J/DZFq9PCDdPy9SUCQgCJXxjqmX9hwia7PyNtv/CiYMvXYD
        geuq7IgF7MpfYTRRVB+v3bf1R2K6bC97Q7PE85s=
X-Google-Smtp-Source: AA6agR7+WMkiEMrdKI2AZe4qf/6xsHxLTxjDX2pmGfacDOY0+Lq8XBLJgy8/tGEIKrcwX8N8GLRs6M8oKwemDSJVHHM=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr23565934ejy.708.1662004562784; Wed, 31
 Aug 2022 20:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
 <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
 <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
 <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com> <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
 <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com> <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com> <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
 <e37a3f11074245b04b086f3d9877ca08f0fef7dd.camel@fb.com>
In-Reply-To: <e37a3f11074245b04b086f3d9877ca08f0fef7dd.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 31 Aug 2022 20:55:51 -0700
Message-ID: <CAADnVQJOh4qW=yrK5PsC9EH=gG8jmrQrF+e=1W1BJZ9jJQi3jA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        "memxor@gmail.com" <memxor@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, Aug 31, 2022 at 2:02 PM Delyan Kratunov <delyank@fb.com> wrote:
> Given that tracing programs can't really maintain their own freelists safely (I think
> they're missing the building blocks - you can't cmpxchg kptrs),

Today? yes, but soon we will have link lists supported natively.

> I do feel like
> isolated allocators are a requirement here. Without them, allocations can fail and
> there's no way to write a reliable program.

Completely agree that there should be a way for programs
to guarantee availability of the element.
Inline allocation can fail regardless whether allocation pool
is shared by multiple programs or a single program owns an allocator.
In that sense, allowing multiple programs to create an instance
of an allocator doesn't solve this problem.
Short free list inside bpf_mem_cache is an implementation detail.
"prefill to guarantee successful alloc" is a bit out of scope
of an allocator.
"allocate a set and stash it" should be a separate building block
available to bpf progs when step "allocate" can fail and
efficient "stash it" can probably be done on top of the link list.

> *If* we ensure that you can build a usable freelist out of allocator-backed memory
> for (a set of) nmi programs, then I can maybe get behind this (but there's other
> reasons not to do this).

Agree that nmi adds another quirk to "stash it" step.
If native link list is not going to work then something
else would have to be designed.

> > So option 3 doesn't feel less flexible to me. imo the whole-map-allocator is
> > more than we need. Ideally it would be easy to specifiy one single
> > allocator for all maps and progs in a set of .c files. Sort-of a bpf package.
> > In other words one bpf allocator per bpf "namespace" is more than enough.
>
> _Potentially_. Programs need to know that when they reserved X objects, they'll have
> them available at a later time and any sharing with other programs can remove this
> property.

Agree.

> A _set_ of programs can in theory determine the right prefill levels, but
> this is certainly easier to reason about on a per-program basis, given that programs
> will run at different rates.

Agree as well.

> Why does it require a global allocator? For example, you can have each program have
> its own internal allocator and with runtime live counts, this API is very achievable.
> Once the program unloads, you can drain the freelists, so most allocator memory does
> not have to live as long as the longest-lived object from that allocator. In
> addition, all allocators can share a global freelist too, so chunks released after
> the program unloads get a chance to be reused.

All makes sense to me except that the kernel can provide that
global allocator and per-program "allocators" can hopefully be
implemented as native bpf code.

> How is having one allocator per program different from having one allocator per set
> of programs, with per-program bpf-side freelists? The requirement that some (most?)
> programs need deterministic access to their freelists is still there, no matter the
> number of allocators. If we fear that the default freelist behavior will waste
> memory, then the defaults need to be aggressively conservative, with programs being
> able to adjust them.

I think the disagreement here is that per-prog allocator based
on bpf_mem_alloc isn't going to be any more deterministic than
one global bpf_mem_alloc for all progs.
Per-prog short free list of ~64 elements vs
global free list of ~64 elements.
In both cases these lists will have to do irq_work and refill
out of global slabs.

> Besides, if we punt the freelists to bpf, then we get absolutely no control over the
> memory usage, which is strictly worse for us (and worse developer experience on top).

I don't understand this point.
All allocations are still coming out of bpf_mem_alloc.
We can have debug mode with memleak support and other debug
mechanisms.

> > (The profileration of kmem_cache-s in the past
> > forced merging of them). By restricting bpf program choices with allocator-per-map
> > (this option 3) we're not only making the kernel side to do less work
> > (no run-time ref counts, no merging is required today), we're also pushing
> > bpf progs to use memory concious choices.
>
> This is conflating "there needs to be a limit on memory stuck in freelists" with "you
> can only store kptrs from one allocator in each map." The former practically
> advocates for freelists to _not_ be hand-rolled inside bpf progs. I still disagree
> with the latter - it's coming strictly from the desire to have static mappings
> between object storage and allocators; it's not coming from a memory usage need, it
> only avoids runtime live object counts.
>
> > Having said all that maybe one global allocator is not such a bad idea.
>
> It _is_ a bad idea because it doesn't have freelist usage determinism. I do, however,
> think there is value in having precise and conservative freelist policies, along with
> a global freelist for overflow and draining after program unload. The latter would
> allow us to share memory between allocators without sacrificing per-allocator
> freelist determinism, especially if paired with very static (but configurable)
> freelist thresholds.

What is 'freelist determinism' ?
Are you talking about some other freelist on top of bpf_mem_alloc's
free lists ?
