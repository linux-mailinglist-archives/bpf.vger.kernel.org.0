Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3345A89E1
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 02:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiIAAl6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 20:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIAAl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 20:41:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E25E0976
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 17:41:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f4so14914204pgc.12
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 17:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xcMrnCOOoU7+gG0XGR91vBIJLrcNX/poYHfJlovJZUw=;
        b=Hu0xt7s6bqjS/DXxA513x9mTurg7HjngEWGMy6t9YhFnIHRhVLQFrJ/NlDKG4kyjS1
         bDcSGryRlXTvoxaJQZ86d6lCN5Kx+OK34m5JgOuWPWgrK90tBVsNBenCKoGM4RNUGuB7
         gbPs+j39xESUW8tLXYInnf/JjSGfLbc+pyf8KYahAB918oCcAqsk6k61wYjLoYT26Cyf
         BQZ4CI8ftVvHThkz0t0PoyXto7MgGI9LZwFOs1eCSe+JvsLvdcb5sMBgdDG8Rwn1krz0
         PY8fIQm5F8rl61B/eEe3yfBsmbmYpjxTq1B0isrp7ZHeWWETAb2xI97Ad+7LcxVOFa9o
         M9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xcMrnCOOoU7+gG0XGR91vBIJLrcNX/poYHfJlovJZUw=;
        b=0I9mYm0HurLZ9ZqxAgdSRShVcg0cRHOK0B9T2sVmc6XBKNNPI4H/8TUBtZ2wkU/rB1
         EB1UuYM76gfT0KJLvb96OWFCWNP1uP/z14Ccv8mtgblPWSp2HPzXtjVRC8HKSUHpOVyF
         AYpoR+/H1DlOBxXnCiHJ/FTFGhieMCKUh/9d/d/0gWUB1Vxr1/PdSJ0z/vB4xeQUWhgk
         ib5A8bZq+uhsALSPlmgrGbdJazLcJSA/oIYTSLmr36RMXfDPDZKWKDsQOuV4sQvqw+kb
         VfGegqJ+HG2kX8CRyMnRIzxMAQkmI5kb8jIFmWyhmejpV39X3pcBmuPhNYf6U0Ld2L+X
         PetA==
X-Gm-Message-State: ACgBeo1tpvF6a/7hUz2lNFAJ5a1R/+Wmj8ABTk9RRSvWaikQpn0JaFQ4
        CfcgtosJa++/FR/4SewWp+s=
X-Google-Smtp-Source: AA6agR7aCGBlAhEgc6Vma3rJTtrOmDcot2Wk+vgYZKQHD8pJ9QfSdd2MeFndeNAs9ekI7GR7/vBBqQ==
X-Received: by 2002:a05:6a00:1a0b:b0:52f:3789:9604 with SMTP id g11-20020a056a001a0b00b0052f37899604mr29282117pfv.61.1661992916280;
        Wed, 31 Aug 2022 17:41:56 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:496b])
        by smtp.gmail.com with ESMTPSA id a15-20020a634d0f000000b0041c66a66d41sm4005066pgb.45.2022.08.31.17.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:41:55 -0700 (PDT)
Date:   Wed, 31 Aug 2022 17:41:52 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Message-ID: <20220901004152.dxwlvcyqpdbofta7@macbook-pro-4.dhcp.thefacebook.com>
References: <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com>
 <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
 <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com>
 <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com>
 <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
 <e37a3f11074245b04b086f3d9877ca08f0fef7dd.camel@fb.com>
 <CAP01T77gfP5ogEfvAgkGxfqypUtVzaPKu5pE2dYqFgp6=UL20w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77gfP5ogEfvAgkGxfqypUtVzaPKu5pE2dYqFgp6=UL20w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 01, 2022 at 12:32:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> > bpf progs are more analogous to kernel modules.
> > The modules just do kmalloc.
> > The more we discuss the more I'm leaning towards the same model as well:
> > Just one global allocator for all bpf progs.
> 
> There does seem to be one big benefit in having a global allocator
> (not per program, but actually globally in the kernel, basically a
> percpu freelist cache fronting kmalloc) usable safely in any context.
> We don't have to do any allocator lifetime tracking at all, that case
> reduces to basically how we handle kernel kptrs currently.
> 
> I am wondering if we can go with such an approach: by default, the
> global allocator in the kernel serves bpf_mem_alloc requests, which
> allows freelist sharing between all programs, it is basically kmalloc
> but safe in NMI and with reentrancy protection. 

Right. That what I was proposing.

> When determinism is
> needed, use the percpu refcount approach with option 1 from Delyan for
> the custom allocator case.

I wasn't rejecting that part. I was suggesting to table that discussion.
The best way to achieve guaranteed allocation is still an open question.
So far we've only talked about a new map type with "allocator" type...
Is this really the best design?

> Now by default you have conservative global freelist sharing (percpu),
> and when required program can use a custom allocator and prefill to
> keep the cache ready to serve requests (where that kind of control
> will be very useful for progs in NMI/hardirq context, where depletion
> of cache means NULL from unit_alloc), where its own allocator freelist
> will be unaffected by other allocations.

The custom allocator is not necessary the right answer.
It could be. Maybe it should be open coded free list of preallocated
items that bpf prog takes from global allocator and pushes them to a list?
We'll have locks and native link lists in bpf soon.
So why "allocator" concept should do a double job of allocating
and keeping a link list for prefill reasons?

> Any kptr from the bpf_mem_alloc allocator can go to any map, no problem at all.
> The only extra cost is maintaining the percpu live counts for
> non-global allocators, it is basically free for the global case.
> And it would also be allowed to probably choose and share allocators
> between maps, as proposed by Alexei before. That has no effect on
> kptrs being stored in them, as most commonly they would be from the
> global allocator.

It still feels to me that doing global allocator only for now will be good
enough. prefill use case for one element can be solved already without
any extra work (just kptr_xchg in and out).
prefill of multiple objects might get nicely solved with native link lists too.
