Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E065AA65F
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 05:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiIBD3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 23:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiIBD31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 23:29:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7427CB2D8B
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 20:29:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so4277231pja.4
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=/zXAoKLtIvZUu2KZ8iQlEW+ic+Mo2jTdDZxWvLPonHE=;
        b=OubhX8Z6vzQTpkU3NLlkk3CS/r3iibWgsjp4kmWehssS2+jkR3UYSJccSyCdmURKSv
         HxwvvsNIlD6pY31C5pTSKxS0abV047Pg2dCmIaQ50ZxH2wjaHFCEKhh/lRx7h+SgWpRj
         gA+ar+ivyphIkaqZ1Ll6mHSeKD1G3wIpD5mZIYkOS+9epvevO8o9HC1oDmqRkLg3X217
         If9C+DhXlFG+zTJSu6CMW5/eXyM3o+aPCuBy3ncdW+575YHzVpRmHa8jqdmPyGQ8vJy9
         9fuPwPsUIm+oyH97AyGwNk46yA+fjsocIgPr3TtsIyI/hElUmJaYnjm/+nVtxXDWYPSB
         bPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/zXAoKLtIvZUu2KZ8iQlEW+ic+Mo2jTdDZxWvLPonHE=;
        b=mt3jJTAep2XLhv5G0EUBPwLMvX2fO5UO2yHm1/9jhA9SkIK4M7yO422OSVcBcY59ZJ
         gj9wnFje5Da0qR9tb687NGET8irUXIAazdML5fTDz+ogrx3NwWxWs2L3uiWOFOqaOpjK
         Aw0s51RFS4xDBhcrnfMsTHkTZvv9HZGxNqM1yqB/5YaXUshzYB2Raaz5gkFa8wwcazai
         0BtIERhqO0aBHmkYKBQv2lYLqFPfAdHmX6WXF0QkwMdOn7pR/o3BCiTBCGxPpgi0k09J
         oM+5NpgpBwJb4u+EnlrP52+YJr73kOP9naKY8KeWRyvZBhqtMGYx/44yGpGBNag0oYVI
         YO4A==
X-Gm-Message-State: ACgBeo1/3pyxLoaQXsXhdzTX7fp1KkHnWU4CUxH3BH1kHBitrVBR03vn
        kcTHTnFMxbTlmA6UqSF5Av4=
X-Google-Smtp-Source: AA6agR7VJQt26SynM8i60DDr94sRCrTRMATzrv2Na1P0pVytUSE0vJ9DYc4MoZ0E3Laj+GnHx15Jxg==
X-Received: by 2002:a17:902:ccc9:b0:174:de2b:b19a with SMTP id z9-20020a170902ccc900b00174de2bb19amr20416569ple.100.1662089355834;
        Thu, 01 Sep 2022 20:29:15 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:9551])
        by smtp.gmail.com with ESMTPSA id 190-20020a6204c7000000b00538116baa56sm399131pfe.102.2022.09.01.20.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:29:15 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:29:12 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Message-ID: <20220902032912.d2xtpsbv534yaeka@macbook-pro-4.dhcp.thefacebook.com>
References: <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com>
 <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com>
 <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
 <e37a3f11074245b04b086f3d9877ca08f0fef7dd.camel@fb.com>
 <CAADnVQJOh4qW=yrK5PsC9EH=gG8jmrQrF+e=1W1BJZ9jJQi3jA@mail.gmail.com>
 <11121127244abee0df337777367a6928d95faece.camel@fb.com>
 <20220902001211.wrgwpvquuky5wpgn@macbook-pro-4.dhcp.thefacebook.com>
 <667008debe17cf6ced894b63841670daccbe9f4c.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <667008debe17cf6ced894b63841670daccbe9f4c.camel@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 02, 2022 at 01:40:29AM +0000, Delyan Kratunov wrote:
> On Thu, 2022-09-01 at 17:12 -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 01, 2022 at 10:46:09PM +0000, Delyan Kratunov wrote:
> > > On Wed, 2022-08-31 at 20:55 -0700, Alexei Starovoitov wrote:
> > > > On Wed, Aug 31, 2022 at 2:02 PM Delyan Kratunov <delyank@fb.com> wrote:
> > > > > Given that tracing programs can't really maintain their own freelists safely (I think
> > > > > they're missing the building blocks - you can't cmpxchg kptrs),
> > > > 
> > > > Today? yes, but soon we will have link lists supported natively.
> > > > 
> > > > > I do feel like
> > > > > isolated allocators are a requirement here. Without them, allocations can fail and
> > > > > there's no way to write a reliable program.
> > > > 
> > > > Completely agree that there should be a way for programs
> > > > to guarantee availability of the element.
> > > > Inline allocation can fail regardless whether allocation pool
> > > > is shared by multiple programs or a single program owns an allocator.
> > > 
> > > I'm not sure I understand this point. 
> > > If I call bpf_mem_prefill(20, type_id(struct foo)), I would expect the next 20 allocs
> > > for struct foo to succeed. In what situations can this fail if I'm the only program
> > > using it _and_ I've calculated the prefill amount correctly?
> > > 
> > > Unless you're saying that the prefill wouldn't adjust the freelist limits, in which
> > > case, I think that's a mistake - prefill should effectively _set_ the freelist
> > > limits.
> > 
> > There is no prefill implementation today, so we're just guessing, but let's try.
> 
> Well, initial capacity was going to be part of the map API, so I always considered it
> part of the same work.
> 
> > prefill would probably have to adjust high-watermark limit.
> > That makes sense, but for how long? Should the watermark go back after time
> > or after N objects were consumed?
> 
> Neither, if you want your pool of objects to not vanish from under you.
> 
> > What prefill is going to do? Prefill on current cpu only ?
> > but it doesn't help the prog to be deterministic in consuming them.
> > Prefill on all cpu-s? That's possible,
> > but for_each_possible_cpu() {irq_work_queue_on(cpu);}
> > looks to be a significant memory and run-time overhead.
> 
> No, that's overkill imo, especially on 100+ core systems.
> I was imagining the allocator consuming the current cpu freelist first, then stealing
> from other cpus, and only if they are empty, giving up and scheduling irq_work. 

stealing from other cpus?!
That's certainly out of scope for bpf_mem_alloc as it's implemented.
Stealing from other cpus would require a redesign.

> A little complex to implement but it's possible. It does require atomics everywhere
> though.

atomic everywhere and many more weeks of thinking and debugging.
kernel/bpf/percpu_freelist.c does stealing from other cpus and it wasn't
trivial to do.

> 
> > When freelist is managed by the program it may contain just N elements
> > that progs needs.
> > 
> > > > In that sense, allowing multiple programs to create an instance
> > > > of an allocator doesn't solve this problem.
> > > > Short free list inside bpf_mem_cache is an implementation detail.
> > > > "prefill to guarantee successful alloc" is a bit out of scope
> > > > of an allocator.
> > > 
> > > I disagree that it's out of scope. This is the only access to dynamic memory from a
> > > bpf program, it makes sense that it covers the requirements of bpf programs,
> > > including prefill/freelist behavior, so all programs can safely use it.
> > > 
> > > > "allocate a set and stash it" should be a separate building block
> > > > available to bpf progs when step "allocate" can fail and
> > > > efficient "stash it" can probably be done on top of the link list.
> > > 
> > > Do you imagine a BPF object that every user has to link into their programs (yuck),
> > > or a different set of helpers? If it's helpers/kfuncs, I'm all for splitting things
> > > this way.
> > 
> > I'm assuming Kumar's proposed list api:
> > struct bpf_list_head head;
> > struct bpf_list_node node;
> > bpf_list_insert(&node, &head);
> > 
> > will work out.
> 
> Given the assumed locking in that design, I don't see how it would help nmi programs
> tbh. This is list_head, we need llist_head, relatively speaking.

Of course. bpf-native link list could be per-cpu and based on llist.
bpf_list vs bpf_llist. SMOP :)

> 
> > 
> > > If it's distributed separately, I think that's an unexpected burden on developers
> > > (I'm thinking especially of tools not writing programs in C or using libbpf/bpftool
> > > skels). There are no other bpf features that require a userspace support library like
> > > this. (USDT doesn't count, uprobes are the underlying bpf feature and that is useful
> > > without a library)
> > 
> > bpf progs must not pay for what they don't use. Hence all building blocks should be
> > small. We will have libc-like bpf libraries with bigger blocks eventually. 
> 
> I'm not sure I understand how having the mechanism in helpers and managed by the
> kernel is paying for something they don't use?

every feature adds up.. like stealing from cpus.

> > 
> > > > I think the disagreement here is that per-prog allocator based
> > > > on bpf_mem_alloc isn't going to be any more deterministic than
> > > > one global bpf_mem_alloc for all progs.
> > > > Per-prog short free list of ~64 elements vs
> > > > global free list of ~64 elements.
> > > 
> > > Right, I think I had a hidden assumption here that we've exposed. 
> > > Namely, I imagined that after a mem_prefill(1000, struct foo) call, there would be
> > > 1000 struct foos on the freelist and the freelist thresholds would be adjusted
> > > accordingly (i.e., you can free all of them and allocate them again, all from the
> > > freelist).
> > > 
> > > Ultimately, that's what nmi programs actually need but I see why that's not an
> > > obvious behavior.
> > 
> > How prefill is going to work is still to-be-designed.
> 
> That's the new part for me, though - the maps design had a mechanism to specify
> initial capacity, and it worked for nmi programs. That's why I'm pulling on this
> thread, it's the hardest thing to get right _and_ it needs to exist before deferred
> work can be useful.

Specifying initial capacity sounds great in theory, but what does it mean in practice?
N elements on each cpu or evenly distributed across all?

> 
> > In addition to current-cpu vs on-all-cpu question above...
> > Will prefill() helper just do irq_work ?
> > If so then it doesn't help nmi and irq-disabled progs at all.
> > prefill helper working asynchronously doesn't guarantee availability of objects
> > later to the program.
> > prefill() becomes a hint and probably useless as such.
> 
> Agreed.
> 
> > So it should probably be synchronous and fail when in-nmi or in-irq?
> > But bpf prog cannot know its context, so only safe synchronous prefill()
> > would be out of sleepable progs.
> 
> Initial maps capacity would've come from the syscall, so the program itself would not
> contain a prefill() call. 
> 
> We covered this in our initial discussions - I also think that requiring every
> perf_event program to setup a uprobe or syscall program to fill the object pool
> (internal or external) is also a bad design.

right. we did. prefill from user space makes sense.

> If we're going for a global allocator, I suppose we could encode these requirements
> in BTF and satisfy them on program load? .alloc map with some predefined names or
> something?

ohh. When I was saying 'global allocator' I meant an allocator that is not exposed
to bpf progs at all. It's just there for all programs. It has hidden watermarks
and prefill for it doesn't make sense. Pretty much kmalloc equivalent.

> > 
> > > > In both cases these lists will have to do irq_work and refill
> > > > out of global slabs.
> > > 
> > > If a tracing program needs irq_work to refill, then hasn't the API already failed the
> > > program writer? I'd have to remind myself how irq_work actually works but given that
> > > it's a soft/hardirq, an nmi program can trivially exhaust the entire allocator before
> > > irq_work has a chance to refill it. I don't see how you'd write reliable programs
> > > this way.
> > 
> > The only way nmi-prog can guarantee availability if it allocates and reserves
> > objects in a different non-nmi program.
> > If everything runs in nmi there is nothing can be done.
> 
> See above, we were using the map load syscall to satisfy this before. We could
> probably do the same here but it's just documenting requirements as opposed to also
> introducing ownership/lifetime problems.
> 
> > 
> > > > 
> > > > > Besides, if we punt the freelists to bpf, then we get absolutely no control over the
> > > > > memory usage, which is strictly worse for us (and worse developer experience on top).
> > > > 
> > > > I don't understand this point.
> > > > All allocations are still coming out of bpf_mem_alloc.
> > > > We can have debug mode with memleak support and other debug
> > > > mechanisms.
> > > 
> > > I mostly mean accounting here. If we segment the allocated objects by finer-grained
> > > allocators, we can attribute them to individual programs better. But, I agree, this
> > > can be implemented in other ways, it can just be counts/tables on bpf_prog.
> > 
> > mem accounting is the whole different, huge and largely unsovled topic.
> > The thread about memcg and bpf is still ongoing.
> > The fine-grained bpf_mem_alloc isn't going to magically solve it.
> > 
> > > > 
> > > > What is 'freelist determinism' ?
> > > 
> > > The property that prefill keeps all objects on the freelist, so the following
> > > sequence doesn't observe allocation failures:
> > > 
> > > bpf_mem_prefill(1000, struct foo);
> > > run_1000_times { alloc(struct foo); }
> > > run_1000_times { free(struct foo); }
> > > run_1000_times { alloc(struct foo); }
> > > alloc(struct foo) // this can observe a failure
> > 
> > we cannot evalute the above until we answer current-cpu vs on-all-cpus question
> > and whether bpf_mem_prefill is sync or async.
> > 
> > I still think designing prefill and guaranteed availability is out of scope
> > of allocator.
> 
> It was in the maps design on purpose though, I need it for deferred work to be useful
> (remember that build id EFAULT thread? only way to fix it for good requires that work
> submission never fails, which needs allocations from nmi to never fail).

iirc build_id EFAULT-ing thread the main issue was:
moving build_id collection from nmi into exit_to_user context so that build_id logic
can do copy_from_user.
In that context it can allocate with GFP_KERNEL too.
We've discussed combing kernel stack with later user+build_id, ringbufs, etc
Lots of things.

> > 
> > > > Are you talking about some other freelist on top of bpf_mem_alloc's
> > > > free lists ?
> > > 
> > > Well, that's the question, isn't it? I think it should be part of the bpf kernel
> > > ecosystem (helper/kfunc) but it doesn't have to be bpf_mem_alloc itself. And, if it's
> > > instantiated per-program, that's easiest to reason about.
> > 
> > There should be a way. For sure. Helper/kfunc or trivial stuff on top of bpf_link_list
> > is still a question. Bundling this feature together with an allocator feels artificial.
> > In user space C you wouldn't combine tcmalloc with custom free list.
> 
> Userspace doesn't have nmi or need allocators that work from signal handlers, for a
> more appropriate analogy. We actually need this to work reliably from nmi, so we can
> shift work _away_ from nmi. If we didn't have this use case, I would've folded on the
> entire issue and kicked the can down the road (plenty of helpers don't work in nmi).

Sure.
I think all the arguments against global mem_alloc come from the assumption that
run-time percpu_ref_get/put in bpf_mem_alloc/free will work.
Kumar mentioned that we have to carefully think when to do percpu_ref_exit()
since it will convert percpu_ref to atomic and performance will suffer.

Also there could be yet another solution to refcounting that will enable
per-program custom bpf_mem_alloc.
For example:
- bpf_mem_alloc is a new map type. It's added to prog->used_maps[]
- no run-time refcnt-ing
- don't store mem_alloc into hidden 8 bytes
- since __kptr __local enforces type and size we can allow:
  obj = bpf_mem_alloc(alloc_A, btf_type_id_local(struct foo));
  kptr_xchg(val, obj);
  ..
  // on different cpu in a different prog
  obj = kptr_xchg(val, NULL);
  bpf_mem_free(alloc_B, obj);
The verifier will need to make sure that alloc_A and alloc_B can service the same type.
If allocators can service any type sizes not checks are necessary.

- during hash map free we do:
  obj = xchg(val)
  bpf_mem_free(global_alloc, obj);
Where global_alloc is the global allocator I was talking about. It's always there.
Cannot get any simpler.

My main point is let's postpone the discussions about features that will happen ten steps
from now. Let's start with global allocator first and don't expose bpf_mem_alloc
as a map just yet. It will enable plenty of new use cases and unblock other works.
