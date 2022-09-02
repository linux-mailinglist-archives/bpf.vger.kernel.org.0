Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651455AA41C
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiIBAMR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIBAMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:12:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F172EF4
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:12:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 78so519024pgb.13
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=eTv5/Ybbq7rFBg7yPO9lx/kWaYwrYSlH9pBzRuMxlbc=;
        b=NslE3NQ7gdWjRQaPEZfQotSucFnOe6ChoWfYNmlh76RiQ1sQKjpalYmDdTyL67bBiK
         ogqXESBUfHmERR+9QjZ+YOj2l4eXm6sUaO9s9lO8z7OYT8wybZuQW7nyVykNFXrMuXeJ
         M/azwPb4aEeR0QvIWn8odLkIUa1KkpvITEO0Q3FXTqq5LZbAZRvSu4hOt8ESDo9DhNvE
         w0Xug95JQeadFSMOnQCP/QQLiQxOBqaGPpV+j6lbsVOtduYcl/0VpxsgiNrQfprTzG3T
         15fhQzDyPBH7gjMCrF0i+SFDWuXZRGuDvjPdX60b/graKc55UpM446afoRwJul7bJ+Xu
         uGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=eTv5/Ybbq7rFBg7yPO9lx/kWaYwrYSlH9pBzRuMxlbc=;
        b=HW++VlpcPpKmOAU5RIcrqCcYMboHIQ96CEx4yU3OBOd3kVs2IR+nqdLopJ1n8/D16s
         vpBS8gulbMLumMe7kQbYnEPLrnZuodOAn+3DrjjTx7uUfnvynwpjFUGJCbmYYD7n5QQ8
         U16j7E2HFm+6nBuGfp4Jlddhyk1V1hSLqmQmriZJvIAbKO16hebBdyLw7/da/XyUK+kQ
         QiP3LLPdQfKg6YdIgaFqlkcb1hzR2iZCraIi3X4ddbKD3hJ7rPM31rogZas8izMuWAZQ
         g90all/POmvxIk2Zo6w7k/C7tBw65ttmG0e8NjqHaQ4VyObBn1Hg8m59TvH1MP2tupNc
         ZwJw==
X-Gm-Message-State: ACgBeo3lok1ebMlOdexfNu1bWMqLn71wOVxzn0c552bVO2rAuirGzEnW
        xqlHuQR6Ff8byJTJbBD3xKU=
X-Google-Smtp-Source: AA6agR6sIfFp4dbBul5zav9Lny34nhXchclJLxhv6urNlcInuRIS2h5KwRf03be7uyEsUNAvu1AcIA==
X-Received: by 2002:a63:c59:0:b0:42b:c924:cde4 with SMTP id 25-20020a630c59000000b0042bc924cde4mr22098012pgm.279.1662077534573;
        Thu, 01 Sep 2022 17:12:14 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:9551])
        by smtp.gmail.com with ESMTPSA id z127-20020a623385000000b0053abb15b3d9sm215019pfz.19.2022.09.01.17.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:12:13 -0700 (PDT)
Date:   Thu, 1 Sep 2022 17:12:11 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        "memxor@gmail.com" <memxor@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Message-ID: <20220902001211.wrgwpvquuky5wpgn@macbook-pro-4.dhcp.thefacebook.com>
References: <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
 <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com>
 <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com>
 <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
 <e37a3f11074245b04b086f3d9877ca08f0fef7dd.camel@fb.com>
 <CAADnVQJOh4qW=yrK5PsC9EH=gG8jmrQrF+e=1W1BJZ9jJQi3jA@mail.gmail.com>
 <11121127244abee0df337777367a6928d95faece.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11121127244abee0df337777367a6928d95faece.camel@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 01, 2022 at 10:46:09PM +0000, Delyan Kratunov wrote:
> On Wed, 2022-08-31 at 20:55 -0700, Alexei Starovoitov wrote:
> > !-------------------------------------------------------------------|
> >   This Message Is From an External Sender
> > 
> > > -------------------------------------------------------------------!
> > 
> > On Wed, Aug 31, 2022 at 2:02 PM Delyan Kratunov <delyank@fb.com> wrote:
> > > Given that tracing programs can't really maintain their own freelists safely (I think
> > > they're missing the building blocks - you can't cmpxchg kptrs),
> > 
> > Today? yes, but soon we will have link lists supported natively.
> > 
> > > I do feel like
> > > isolated allocators are a requirement here. Without them, allocations can fail and
> > > there's no way to write a reliable program.
> > 
> > Completely agree that there should be a way for programs
> > to guarantee availability of the element.
> > Inline allocation can fail regardless whether allocation pool
> > is shared by multiple programs or a single program owns an allocator.
> 
> I'm not sure I understand this point. 
> If I call bpf_mem_prefill(20, type_id(struct foo)), I would expect the next 20 allocs
> for struct foo to succeed. In what situations can this fail if I'm the only program
> using it _and_ I've calculated the prefill amount correctly?
> 
> Unless you're saying that the prefill wouldn't adjust the freelist limits, in which
> case, I think that's a mistake - prefill should effectively _set_ the freelist
> limits.

There is no prefill implementation today, so we're just guessing, but let's try.
prefill would probably have to adjust high-watermark limit.
That makes sense, but for how long? Should the watermark go back after time
or after N objects were consumed?
What prefill is going to do? Prefill on current cpu only ?
but it doesn't help the prog to be deterministic in consuming them.
Prefill on all cpu-s? That's possible,
but for_each_possible_cpu() {irq_work_queue_on(cpu);}
looks to be a significant memory and run-time overhead.
When freelist is managed by the program it may contain just N elements
that progs needs.

> > In that sense, allowing multiple programs to create an instance
> > of an allocator doesn't solve this problem.
> > Short free list inside bpf_mem_cache is an implementation detail.
> > "prefill to guarantee successful alloc" is a bit out of scope
> > of an allocator.
> 
> I disagree that it's out of scope. This is the only access to dynamic memory from a
> bpf program, it makes sense that it covers the requirements of bpf programs,
> including prefill/freelist behavior, so all programs can safely use it.
> 
> > "allocate a set and stash it" should be a separate building block
> > available to bpf progs when step "allocate" can fail and
> > efficient "stash it" can probably be done on top of the link list.
> 
> Do you imagine a BPF object that every user has to link into their programs (yuck),
> or a different set of helpers? If it's helpers/kfuncs, I'm all for splitting things
> this way.

I'm assuming Kumar's proposed list api:
struct bpf_list_head head;
struct bpf_list_node node;
bpf_list_insert(&node, &head);

will work out.

> If it's distributed separately, I think that's an unexpected burden on developers
> (I'm thinking especially of tools not writing programs in C or using libbpf/bpftool
> skels). There are no other bpf features that require a userspace support library like
> this. (USDT doesn't count, uprobes are the underlying bpf feature and that is useful
> without a library)

bpf progs must not pay for what they don't use. Hence all building blocks should be
small. We will have libc-like bpf libraries with bigger blocks eventually. 

> > I think the disagreement here is that per-prog allocator based
> > on bpf_mem_alloc isn't going to be any more deterministic than
> > one global bpf_mem_alloc for all progs.
> > Per-prog short free list of ~64 elements vs
> > global free list of ~64 elements.
> 
> Right, I think I had a hidden assumption here that we've exposed. 
> Namely, I imagined that after a mem_prefill(1000, struct foo) call, there would be
> 1000 struct foos on the freelist and the freelist thresholds would be adjusted
> accordingly (i.e., you can free all of them and allocate them again, all from the
> freelist).
> 
> Ultimately, that's what nmi programs actually need but I see why that's not an
> obvious behavior.

How prefill is going to work is still to-be-designed.
In addition to current-cpu vs on-all-cpu question above...
Will prefill() helper just do irq_work ?
If so then it doesn't help nmi and irq-disabled progs at all.
prefill helper working asynchronously doesn't guarantee availability of objects
later to the program.
prefill() becomes a hint and probably useless as such.
So it should probably be synchronous and fail when in-nmi or in-irq?
But bpf prog cannot know its context, so only safe synchronous prefill()
would be out of sleepable progs.

> > In both cases these lists will have to do irq_work and refill
> > out of global slabs.
> 
> If a tracing program needs irq_work to refill, then hasn't the API already failed the
> program writer? I'd have to remind myself how irq_work actually works but given that
> it's a soft/hardirq, an nmi program can trivially exhaust the entire allocator before
> irq_work has a chance to refill it. I don't see how you'd write reliable programs
> this way.

The only way nmi-prog can guarantee availability if it allocates and reserves
objects in a different non-nmi program.
If everything runs in nmi there is nothing can be done.

> > 
> > > Besides, if we punt the freelists to bpf, then we get absolutely no control over the
> > > memory usage, which is strictly worse for us (and worse developer experience on top).
> > 
> > I don't understand this point.
> > All allocations are still coming out of bpf_mem_alloc.
> > We can have debug mode with memleak support and other debug
> > mechanisms.
> 
> I mostly mean accounting here. If we segment the allocated objects by finer-grained
> allocators, we can attribute them to individual programs better. But, I agree, this
> can be implemented in other ways, it can just be counts/tables on bpf_prog.

mem accounting is the whole different, huge and largely unsovled topic.
The thread about memcg and bpf is still ongoing.
The fine-grained bpf_mem_alloc isn't going to magically solve it.

> > 
> > What is 'freelist determinism' ?
> 
> The property that prefill keeps all objects on the freelist, so the following
> sequence doesn't observe allocation failures:
> 
> bpf_mem_prefill(1000, struct foo);
> run_1000_times { alloc(struct foo); }
> run_1000_times { free(struct foo); }
> run_1000_times { alloc(struct foo); }
> alloc(struct foo) // this can observe a failure

we cannot evalute the above until we answer current-cpu vs on-all-cpus question
and whether bpf_mem_prefill is sync or async.

I still think designing prefill and guaranteed availability is out of scope
of allocator.

> > Are you talking about some other freelist on top of bpf_mem_alloc's
> > free lists ?
> 
> Well, that's the question, isn't it? I think it should be part of the bpf kernel
> ecosystem (helper/kfunc) but it doesn't have to be bpf_mem_alloc itself. And, if it's
> instantiated per-program, that's easiest to reason about.

There should be a way. For sure. Helper/kfunc or trivial stuff on top of bpf_link_list
is still a question. Bundling this feature together with an allocator feels artificial.
In user space C you wouldn't combine tcmalloc with custom free list.
During early days of bpf bundling would totally make sense, but right now we're able to
create much smaller building blocks than in the past. I don't think we'll be adding
any more new map types. We probably won't be adding any new program types either.
