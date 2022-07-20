Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF957AB36
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 02:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGTAy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 20:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGTAy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 20:54:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D0F4AD7C
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 17:54:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 17so4816881pfy.0
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 17:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cyOnTwAp7Ir7QkgxAgqJi8I0C6Q1mrRCDZGyfrrSuww=;
        b=nCeg9D+iVWvwT6+iBZev+RRzi5VEF2J/HI7RE1Tw21J4eDefoxTeXvSRr7vvWDVdK3
         15fncZQc+uaxBOfWj82ZX/3kLMAgNpzaF6P0JRRIssxRZbr3lh7ka3j5XhoFJm87UWH8
         nhCInqYKgah5cysjLPvn5YzVcaYrYyPiXN9AviaT4jh2VKEh25IHgYjw6+Mhn51A/dE2
         Xqeap6p8QhtsrU6GSq9WVc9ZPnAVvbuWOKzyhqAwlCIs8cALkdWP39/+Qa+HR5zV3mUU
         YPIsnIozzh4zEVNw2RzqyR6eMiORPQxToysfAb5kbCXBhBVvZdLZD4hc6oHbKxGU29SX
         kifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cyOnTwAp7Ir7QkgxAgqJi8I0C6Q1mrRCDZGyfrrSuww=;
        b=l8Iif0MubJ5rNxVcUpyT7mLmBNVrgA+2dvA7fNNX4/jJn0cnS8p6dQGmCXpni2BeNM
         2uGX40IlRy4BGV2TXzfX1pAWvKQS5/WXfQkmAsoGJWrjHv/hpnKFElS3BziaOTUA5y38
         oSAh44bjqaOUrMOILNZkLw4X/09hgetH757DJkzPMrwF9gcl4C5xeFIzBzmBpQt6G2ha
         pFQERV//oALhfy3GBFvSEhgTkId6sHjG6461joJc/atOyyQbv9Xyv+O33bP3HdCIuUB5
         gQGRW8q1KsKYZd6fdrj8KsR3O7ZDxNfUDc/AdbOdnYiLMZjuay1ZnWxeylh+HOl1Vlmm
         RRfw==
X-Gm-Message-State: AJIora8Pcibpu//Ej/hTBA5mSDe5a6n9LSy9U32s8TM1u6m/qUK7Ckqg
        SNvdh/BoOo/mbUKpGp/eppk=
X-Google-Smtp-Source: AGRyM1u7xgxrMEWi0HhRxlvmOp6wOPDYr7vSBkJgRmJpQVaWtsWKrQs5b80HvHoAMVECX2uJw6aStg==
X-Received: by 2002:a63:455a:0:b0:412:9855:64eb with SMTP id u26-20020a63455a000000b00412985564ebmr32137991pgk.131.1658278465281;
        Tue, 19 Jul 2022 17:54:25 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:d702])
        by smtp.gmail.com with ESMTPSA id o186-20020a62cdc3000000b0050dc7628171sm12171073pfg.75.2022.07.19.17.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 17:54:24 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:54:22 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "sdf@google.com" <sdf@google.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/3] Execution context callbacks
Message-ID: <20220720005422.bfjw6yb6ofr37o4f@macbook-pro-3.dhcp.thefacebook.com>
References: <cover.1657576063.git.delyank@fb.com>
 <Ys24W4RJS0BAfKzP@google.com>
 <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
 <20220715015100.p7fwr7dbjyfbjjad@MacBook-Pro-3.local>
 <8ee9f9d1a5218ab23655d3f0d754aa5634a71d89.camel@fb.com>
 <20220719190204.vzkrfzsfkup6olfr@MacBook-Pro-3.local>
 <1ef3938729a61f2caa4cda9fe5784ea1d707f544.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ef3938729a61f2caa4cda9fe5784ea1d707f544.camel@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 10:12:57PM +0000, Delyan Kratunov wrote:
> On Tue, 2022-07-19 at 12:02 -0700, Alexei Starovoitov wrote:
> > On Fri, Jul 15, 2022 at 06:28:20PM +0000, Delyan Kratunov wrote:
> > > On Thu, 2022-07-14 at 18:51 -0700, Alexei Starovoitov wrote:
> > > > On Tue, Jul 12, 2022 at 06:42:52PM +0000, Delyan Kratunov wrote:
> > > > > 
> > > > > > but have you though of maybe initially supporting something like:
> > > > > > 
> > > > > > bpf_timer_init(&timer, map, SOME_NEW_DEFERRED_NMI_ONLY_FLAG);
> > > > > > bpf_timer_set_callback(&timer, cg);
> > > > > > bpf_timer_start(&timer, 0, 0);
> > > > > > 
> > > > > > If you init a timer with that special flag, I'm assuming you can have
> > > > > > special cases in the existing helpers to simulate the delayed work?
> > > > > 
> > > > > Potentially but I have some reservations about drawing this equivalence.
> > > > 
> > > > hrtimer api has various: flags. soft vs hard irq, pinned and not.
> > > > So the suggestion to treat irq_work callback as special timer flag
> > > > actually fits well.
> > > > 
> > > > bpf_timer_init + set_callback + start can be a static inline function
> > > > named bpf_work_submit() in bpf_helpers.h
> > > > (or some new file that will mark the beginning libc-bpf library).
> > > > Reusing struct bpf_timer and adding zero-delay callback could probably be
> > > > easier for users to learn and consume.
> > > 
> > > To clarify, we're talking about 1) making bpf_timer nmi-safe for _some_ but not all
> > > combinations of parameters and 2) adding new flags to specify an execution context?
> > > It's achievable but it's hard to see how it's the superior solution here.
> > > 
> > > > 
> > > > Separately:
> > > > +struct bpf_delayed_work {
> > > > +       __u64 :64;
> > > > +       __u64 :64;
> > > > +       __u64 :64;
> > > > +       __u64 :64;
> > > > +       __u64 :64;
> > > > +} __attribute__((aligned(8)));
> > > > is not extensible.
> > > > It would be better to add indirection to allow kernel side to grow
> > > > independently from amount of space consumed in a map value.
> > > 
> > > Fair point, I was wondering what to do with it - storing just a pointer sounds
> > > reasonable.
> > > 
> > > > Can you think of a way to make irq_work/sleepable callback independent of maps?
> > > > Assume bpf_mem_alloc is already available and NMI prog can allocate a typed object.
> > > > The usage could be:
> > > > struct my_work {
> > > >   int a;
> > > >   struct task_struct __kptr_ref *t;
> > > > };
> > > > void my_cb(struct my_work *w);
> > > > 
> > > > struct my_work *w = bpf_mem_alloc(allocator, bpf_core_type_id_local(*w));
> > > > w->t = ..;
> > > > bpf_submit_work(w, my_cb, SLEEPABLE | IRQ_WORK);
> > > > 
> > > > Am I day dreaming? :)
> > > 
> > > Nothing wrong with dreaming of a better future :) 
> > > 
> > > (I'm assuming you're thinking of bpf_mem_alloc being fronted by the allocator you
> > > recently sent to the list.)
> > > 
> > > On a first pass, here are my concerns:
> > > 
> > > A program and its maps can guarantee a certain amount of storage for work items.
> > > Sizing that storage is difficult but it is yours alone to use. The freelist allocator
> > > can be transiently drained by other programs and starve you of this utility. This is
> > > a new failure mode, so it's worth talking about.
> > 
> > That would be the issue only when progs deliberately share the allocator.
> > In this stmt:
> > struct my_work *w = bpf_mem_alloc(allocator, bpf_core_type_id_local(*w));
> > The 'allocator' can be unique for each prog or shared across few progs in the same .c file.
> > I wasn't planning to support one global allocator.
> > Just like one global hash map doesn't quite make sense.
> > The user has to create an allocator first, get it connected with memcg,
> > and use the explicit one in their bpf progs/maps.
> > 
> > > With a generic allocator mechanism, we'll have a hard time enforcing the can't-load-
> > > or-store-into-special-fields logic. I like that guardrail and I'm not sure how we'd
> > > achieve the same guarantees. (In your snippet, we don't have the llist_node on the
> > > work item - do we wrap my_work into something else internally? That would hide the
> > > fields that need protecting at the expense of an extra bpf_mem_alloc allocation.)
> > 
> > bpf_mem_alloc will return referenced PTR_TO_BTF_ID.
> > Every field in this structure is typed. So it's trivial for the verifier to make
> > some of them read only or not accesible at all.
> > 'struct my_work' can have an explicit struct bpf_delayed_work field. Example:
> > struct my_work {
> >   struct bpf_delayed_work work; // not accessible by prog
> >   int a; // scalar read/write
> >   struct task_struct __kptr_ref *t;  // kptr semantics
> > };
> 
> Sure, anything is possible, it's just more complexity and these checks are not
> exactly easy to follow right now. 
> 
> Alternatively, we could do the classic allocator thing and allocate accounting space
> before the pointer we return. Some magic flag could then expand the space enough to
> use for submit_work. Some allocations would be bumped to a higher bucket but that's
> okay because it would be conststent overhead for those allocation sites.

Technically we can, but that would be a departure from what we already do.
bpf_spin_lock, bpf_timer, __kptr are normal part of struct-s with different access
restrictions. 'struct bpf_delayed_work' shouldn't be any different.

Another approach would be to let bpf prog allocate 'struct my_work' without
any special fields. Then use nmi-safe allocator inside bpf_submit_work, hide
it completely from bpf side and auto-free after callback is done.
But extra alloc is a performance hit and overall it will be an unusual hack.

May be we can allow bpf_submit_work() to work with referenced ptr_to_btf_id
like above and with normal map value similar to what you've implemented?
We would need to somehow make sure that container_of() operation to cast from
&work either to allocated ptr_to_btf_id or to map value works in both cases.
That would be the most flexible solution and will resemble kernel programming
style the best.

> > 
> > > Managing the storage returned from bpf_mem_alloc is of course also a concern. We'd
> > > need to treat bpf_submit_work as "releasing" it (really, taking ownership). This path
> > > means more lifecycle analysis in the verifier and explicit and implicit free()s.
> > 
> > What is the actual concern?
> > bpf_submit_work will have clear "release" semantics. The verifier already supports it.
> > The 'my_cb' callback will receive reference PTR_TO_BTF_ID as well and would
> > have to release it with bpf_mem_free(ma, w).
> > Here is more complete proposal:
> > 
> > struct {
> >         __uint(type, BPF_MEM_ALLOC);
> > } allocator SEC(".maps");
> 
> I like this, so long as we pre-allocate enough to submit more sleepable work
> immediately - the first work item the program submits could then prefill more items.
> 
> For an even better experience, it would be great if we could specify in the map
> definition the number of items of size X we'll need. If we give that lever to the
> developer, they can then use it so they never have to orchestrate sleepable work to
> call bpf_mem_prealloc explicitly.

Agree. That's the idea. Will work on it.

> 
> > 
> > struct my_work {
> >   struct bpf_delayed_work work;
> >   int a;
> >   struct task_struct __kptr_ref *t;
> > };
> > 
> > void my_cb(struct my_work *w)
> > {
> >   // access w
> >   bpf_mem_free(&allocator, w);
> > }
> > 
> > void bpf_prog(...)
> > {
> >   struct my_work *w = bpf_mem_alloc(&allocator, bpf_core_type_id_local(*w));
> >   w->t = ..;
> >   bpf_submit_work(w, my_cb, USE_IRQ_WORK);
> > }
> > 
> > > I'm not opposed to it overall - the developer experience is very familiar - but I am
> > > primarily worried that allocator failures will be in the same category of issues as
> > > the hash map collisions for stacks. If you want reliability, you just don't use that
> > > type of map - what's the alternative in this hypothetical bpf_mem_alloc future?
> > 
> > Reliability of allocation is certianly necessary.
> > bpf_mem_alloc will have an ability to _synchronously_ preallocate into freelist
> > from sleepable context, so bpf prog will have full control of that free list.
> 
> I think having the map initialized and prefilled on load and having sleepable work
> from the first version of this mechanism becomes a requirement of this design. Having
> the prefill requirements (number of items and size) on the map definition removes the
> requirement to have sleepable work from day one.

I'm not sure why 'sleepable' is a requirement. irq_work will be able to do
synchronous prefill with GFP_NOWAIT. sleepable callback will be able to do
synchronous prefill with GFP_KERNEL. There is a difference, of course,
but it's not a blocker.

> How do you want to sequence this? Do you plan to do the work to expose bpf_mem_alloc
> to programs as part of the initial series or as a later followup? 

Currently thinking as a follow up.
If you have cycles maybe you can help ?
bpf_mem_alloc/free internals are tested and usable already. prefill is not implemented yet.
But the work to do bpf_mem_alloc helper and to expose allocator as a special kind of map
can start already.
