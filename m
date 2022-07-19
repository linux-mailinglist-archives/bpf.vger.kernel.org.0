Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB64557A6E1
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGSTCY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiGSTCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:02:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873A051400
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:02:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so14331399pgb.4
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9kSeIZZn53Yp87Z6oBIOt7NUa6s5B+KuThE33dzZK4=;
        b=aSrlg8SW4bGZN+p269Wkz+5kUe/k8a7WyTlMoautHeqrhvYiAfUumFMpHQDOTmZRjh
         fYgecn/hGsRAztaeeDrFiJuzNXDFhKSfa199jtrPZ/wLG/14HrJPWzzH7GiLbgXavag8
         Bu9Re6Mue9CrkoAXH+/BER2IF3AtWY3D/cbZ53chAyCKMDojHWT5YBgNoGoXslwH8ca+
         OxAed9c+ddgnIjX4kuxmvBBPfdUDa/+vu+B6t1DD3YLERC/htkvWxpv97ZKd+ABwztGB
         LdeVgLr9yubtoNYNYeQjiAJPsbfCnX9uKVXUmvxAp3WwQILA3vw0FI8o73iA6E8JDuvd
         92LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9kSeIZZn53Yp87Z6oBIOt7NUa6s5B+KuThE33dzZK4=;
        b=PlQAUllyLPHdo3hSBb8Tu6YaxF6TZEKqRsM2oWMJMm1IDyEoBgNGpEjbDYTRh01CmB
         qLEE0yPZiYXVjkOyQJxLEE6iwiE0i0U1yJPRyDD/bD99rv6Y9PFljHRlJ1SuEz23Qu/r
         vNBVoLt+kQfLMLWIxhOVEfZZPDqnrMcr1Gz/IAVgd7Va4EWIf+MJU//5gnbkRAiQsA2P
         F8JYeE79QCTp7zMp0Rpar0QInMoyNqDPo4xMBRvLACqoYUC4aaW5TVMPkw8xwIXHucmB
         Fpl9yXBYpelZc4oLM8mWo1Zbsye4sh653eLzy8NF0bLvQZr68lctBTRxq3ox9n6OT/ft
         VfEQ==
X-Gm-Message-State: AJIora9G+lnsW3yw86jgHpEUvZQ/xv2ipLA/eauRRSfTxDW0VJICIjP/
        5rtrTqMW9D/JDV4z2NnFTSs=
X-Google-Smtp-Source: AGRyM1tgSUTqaGxX72ooo4hbpAkAICVMhwk19jcjYVcWQcM+8xClIfv9HXAZCVanRLRcqxxVeHVc8w==
X-Received: by 2002:a63:1710:0:b0:40d:dd27:789b with SMTP id x16-20020a631710000000b0040ddd27789bmr29765283pgl.386.1658257326792;
        Tue, 19 Jul 2022 12:02:06 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::1:8aa3])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b00169c54f6d01sm12065951plf.221.2022.07.19.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:02:06 -0700 (PDT)
Date:   Tue, 19 Jul 2022 12:02:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "sdf@google.com" <sdf@google.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/3] Execution context callbacks
Message-ID: <20220719190204.vzkrfzsfkup6olfr@MacBook-Pro-3.local>
References: <cover.1657576063.git.delyank@fb.com>
 <Ys24W4RJS0BAfKzP@google.com>
 <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
 <20220715015100.p7fwr7dbjyfbjjad@MacBook-Pro-3.local>
 <8ee9f9d1a5218ab23655d3f0d754aa5634a71d89.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ee9f9d1a5218ab23655d3f0d754aa5634a71d89.camel@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 06:28:20PM +0000, Delyan Kratunov wrote:
> On Thu, 2022-07-14 at 18:51 -0700, Alexei Starovoitov wrote:
> > On Tue, Jul 12, 2022 at 06:42:52PM +0000, Delyan Kratunov wrote:
> > > 
> > > > but have you though of maybe initially supporting something like:
> > > > 
> > > > bpf_timer_init(&timer, map, SOME_NEW_DEFERRED_NMI_ONLY_FLAG);
> > > > bpf_timer_set_callback(&timer, cg);
> > > > bpf_timer_start(&timer, 0, 0);
> > > > 
> > > > If you init a timer with that special flag, I'm assuming you can have
> > > > special cases in the existing helpers to simulate the delayed work?
> > > 
> > > Potentially but I have some reservations about drawing this equivalence.
> > 
> > hrtimer api has various: flags. soft vs hard irq, pinned and not.
> > So the suggestion to treat irq_work callback as special timer flag
> > actually fits well.
> > 
> > bpf_timer_init + set_callback + start can be a static inline function
> > named bpf_work_submit() in bpf_helpers.h
> > (or some new file that will mark the beginning libc-bpf library).
> > Reusing struct bpf_timer and adding zero-delay callback could probably be
> > easier for users to learn and consume.
> 
> To clarify, we're talking about 1) making bpf_timer nmi-safe for _some_ but not all
> combinations of parameters and 2) adding new flags to specify an execution context?
> It's achievable but it's hard to see how it's the superior solution here.
> 
> > 
> > Separately:
> > +struct bpf_delayed_work {
> > +       __u64 :64;
> > +       __u64 :64;
> > +       __u64 :64;
> > +       __u64 :64;
> > +       __u64 :64;
> > +} __attribute__((aligned(8)));
> > is not extensible.
> > It would be better to add indirection to allow kernel side to grow
> > independently from amount of space consumed in a map value.
> 
> Fair point, I was wondering what to do with it - storing just a pointer sounds
> reasonable.
> 
> > Can you think of a way to make irq_work/sleepable callback independent of maps?
> > Assume bpf_mem_alloc is already available and NMI prog can allocate a typed object.
> > The usage could be:
> > struct my_work {
> >   int a;
> >   struct task_struct __kptr_ref *t;
> > };
> > void my_cb(struct my_work *w);
> > 
> > struct my_work *w = bpf_mem_alloc(allocator, bpf_core_type_id_local(*w));
> > w->t = ..;
> > bpf_submit_work(w, my_cb, SLEEPABLE | IRQ_WORK);
> > 
> > Am I day dreaming? :)
> 
> Nothing wrong with dreaming of a better future :) 
> 
> (I'm assuming you're thinking of bpf_mem_alloc being fronted by the allocator you
> recently sent to the list.)
> 
> On a first pass, here are my concerns:
> 
> A program and its maps can guarantee a certain amount of storage for work items.
> Sizing that storage is difficult but it is yours alone to use. The freelist allocator
> can be transiently drained by other programs and starve you of this utility. This is
> a new failure mode, so it's worth talking about.

That would be the issue only when progs deliberately share the allocator.
In this stmt:
struct my_work *w = bpf_mem_alloc(allocator, bpf_core_type_id_local(*w));
The 'allocator' can be unique for each prog or shared across few progs in the same .c file.
I wasn't planning to support one global allocator.
Just like one global hash map doesn't quite make sense.
The user has to create an allocator first, get it connected with memcg,
and use the explicit one in their bpf progs/maps.

> With a generic allocator mechanism, we'll have a hard time enforcing the can't-load-
> or-store-into-special-fields logic. I like that guardrail and I'm not sure how we'd
> achieve the same guarantees. (In your snippet, we don't have the llist_node on the
> work item - do we wrap my_work into something else internally? That would hide the
> fields that need protecting at the expense of an extra bpf_mem_alloc allocation.)

bpf_mem_alloc will return referenced PTR_TO_BTF_ID.
Every field in this structure is typed. So it's trivial for the verifier to make
some of them read only or not accesible at all.
'struct my_work' can have an explicit struct bpf_delayed_work field. Example:
struct my_work {
  struct bpf_delayed_work work; // not accessible by prog
  int a; // scalar read/write
  struct task_struct __kptr_ref *t;  // kptr semantics
};

> Managing the storage returned from bpf_mem_alloc is of course also a concern. We'd
> need to treat bpf_submit_work as "releasing" it (really, taking ownership). This path
> means more lifecycle analysis in the verifier and explicit and implicit free()s.

What is the actual concern?
bpf_submit_work will have clear "release" semantics. The verifier already supports it.
The 'my_cb' callback will receive reference PTR_TO_BTF_ID as well and would
have to release it with bpf_mem_free(ma, w).
Here is more complete proposal:

struct {
        __uint(type, BPF_MEM_ALLOC);
} allocator SEC(".maps");

struct my_work {
  struct bpf_delayed_work work;
  int a;
  struct task_struct __kptr_ref *t;
};

void my_cb(struct my_work *w)
{
  // access w
  bpf_mem_free(&allocator, w);
}

void bpf_prog(...)
{
  struct my_work *w = bpf_mem_alloc(&allocator, bpf_core_type_id_local(*w));
  w->t = ..;
  bpf_submit_work(w, my_cb, USE_IRQ_WORK);
}

> I'm not opposed to it overall - the developer experience is very familiar - but I am
> primarily worried that allocator failures will be in the same category of issues as
> the hash map collisions for stacks. If you want reliability, you just don't use that
> type of map - what's the alternative in this hypothetical bpf_mem_alloc future?

Reliability of allocation is certianly necessary.
bpf_mem_alloc will have an ability to _synchronously_ preallocate into freelist
from sleepable context, so bpf prog will have full control of that free list.
