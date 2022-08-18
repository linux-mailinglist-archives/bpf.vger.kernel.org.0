Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD2598334
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiHRMit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 08:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiHRMir (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 08:38:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D4E2C642
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 05:38:44 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b142so953938iof.10
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Fgd8UDxkf8qmGmKuzwov66oSmEMNYS8i42IEeAx2rJI=;
        b=KCBRlrOKvoSMG2xA9+BzdSKjnhBrRHGAjZmJzTAacklILtiCvrw0A94TsKS/24UJxS
         Zn4gIR1yMAX7guvT/aZQsEwxHNOnr8FUUPAGPPMNix/s/P9TasWBA1eMEXnWSX1Njhqg
         z6z1oc4gyUvkFvm1s/A2igU99GtUPtakC91T+95A0Tt85kTbIjjV2czmpujrNPTxECs4
         79TiAiELDnQXtRTZeArf1dOf8V2P09nyr3Uit6hdtM5oZKbfxgTRmfkzAUaI+xT089oP
         yH0a6VGseN5ZOI35ZSXK/T9BnL9/K+csnbsbmiSLEjuzb8D2+/9/XYjXlKXTh3yOajox
         AtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Fgd8UDxkf8qmGmKuzwov66oSmEMNYS8i42IEeAx2rJI=;
        b=uSWC5VhUNreqAczJOMpRENHF6TCDaN1TUV8OaV1ie65ewfLD5EeTTtzdTTGDPkA23M
         nC87qwCfXBInh/sF2bOmACIYWmikaDxb67OuoH3BCMmM3258Tu1uQSzu7v2YpMvNq9Ur
         XYUu6STZ1oG0tZwHEucU++3pRhDzud9rqlncODSskKoXLYwL9iJZm7I4Z8OFYKKUN5qa
         zfN7TS7y2CaG+IwAAS/FzbhqgNDrROXf6N62jgcuDD627CBTbjoge7qCHjjkggD8sDjJ
         c8y8kE7aJiIOJ5eVsE71oAsh1OlVlM23b4YCSkn3JU355JYH9kROjzn8DW0oRtcKjmNu
         1Ozg==
X-Gm-Message-State: ACgBeo0TQS9g0LYLtoDB6n3yErSsZm6g0coNy45jmzKYTXGf9TTck7v9
        nDq4wPF3bxb1zQ1ixma+j5vTBzO2GqgvtZQNyC0=
X-Google-Smtp-Source: AA6agR4kpRMHH6yhU6LbDrgvl0ohs0TaZA8BXOpl8byKvQRHBOmZ2R2ZKcMCutLb+YbgKffV0saCQ4DI9ezskMQN1bY=
X-Received: by 2002:a05:6638:2110:b0:346:d1b7:6a86 with SMTP id
 n16-20020a056638211000b00346d1b76a86mr1332359jaj.116.1660826324248; Thu, 18
 Aug 2022 05:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
 <20220817210419.95560-2-alexei.starovoitov@gmail.com> <CAP01T77L6e=B6OtLcM4bToM5n4+j3S6+p+ieTPtDGUgQUZ3o1Q@mail.gmail.com>
 <20220818003957.t5lcp636n7we37hk@MacBook-Pro-3.local>
In-Reply-To: <20220818003957.t5lcp636n7we37hk@MacBook-Pro-3.local>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 18 Aug 2022 14:38:06 +0200
Message-ID: <CAP01T74gcYpXXoafBAEaL5a_7FaDdfAwzmoE86pOctzmeeVhmw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/12] bpf: Introduce any context BPF specific
 memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
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

On Thu, 18 Aug 2022 at 02:40, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 18, 2022 at 01:51:39AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > +
> > > +/* notrace is necessary here and in other functions to make sure
> > > + * bpf programs cannot attach to them and cause llist corruptions.
> > > + */
> > > +static void notrace *unit_alloc(struct bpf_mem_cache *c)
> > > +{
> > > +       bool in_nmi = bpf_in_nmi();
> > > +       struct llist_node *llnode;
> > > +       unsigned long flags;
> > > +       int cnt = 0;
> > > +
> > > +       if (unlikely(in_nmi)) {
> > > +               llnode = llist_del_first(&c->free_llist_nmi);
> > > +               if (llnode)
> > > +                       cnt = atomic_dec_return(&c->free_cnt_nmi);
> >
> > I am trying to understand which case this
> > atomic_dec_return/atomic_inc_return protects against in the
> > unit_alloc/unit_free for in_nmi branch. Is it protecting nested NMI
> > BPF prog interrupting NMI prog?
> >
> > In case of perf it seems we use bpf_prog_active,
>
> yes, but bpf_prog_active has plenty of downsides and hopefully
> will be replaced eventually with cleaner mechanism.
> Separate topic.

I see.

>
> > so nested NMI prog
> > won't be invoked while we are interrupted inside a BPF program in NMI
> > context. Which are the other cases that might cause reentrancy in this
> > branch such that we need atomics instead of c->free_cnt_nmi--? Or are
> > you anticipating you might allow this in the future even if it is
> > disallowed for now?
> >
> > If programs are allowed to stack like this, and we try to reason about
> > the safety of llist_del_first operation, the code is:
> >
> > struct llist_node *llist_del_first(struct llist_head *head)
> > {
> >      struct llist_node *entry, *old_entry, *next;
> >
> >      entry = smp_load_acquire(&head->first);
> >      for (;;) {
> >          if (entry == NULL)
> >              return NULL;
> >          old_entry = entry;
> >          next = READ_ONCE(entry->next);
> > >>>>>>>> Suppose nested NMI comes at this point and BPF prog is invoked.
>
> llist_del_first is notrace.
> unit_alloc() above is also notrace. See comment before it.
> perf event overflow NMI can happen here, but for some other llist.
> Hence we're talking about NMI issues only here. fentry progs do not apply here.

I was not thinking about fentry progs either. I saw perf overflow
progs can't nest, so I was wondering whether there were any other
cases. But you mentioned bpf_mem_refill in IRQ and perf in NMI can't
touch the same lockless list, so the scenario is still possible.

>
> > Assume the current nmi free llist is HEAD -> A -> B -> C -> D -> ...
> > For our cmpxchg, parameters are going to be cmpxchg(&head->first, A, B);
> >
> > Now, nested NMI prog does unit_alloc thrice. this does llist_del_first thrice
>
> Even double llist_del_first on the same llist is bad. That's a known fact.

Well, if you think about it (correct me if I'm wrong), at least in
this kind of nesting scenario on the same CPU, just doing
llist_del_first in NMI prog which interrupts llist_del_first of
bpf_mem_refill isn't a problem. The cmpxchg will fail as head->first
changed. The problem occurs when you combine it with llist_add between
the READ_ONCE(entry->next) and cmpxchg of the interrupted
llist_del_first. The main invariant of llist_del_first is that
entry->next should not change between READ_ONCE and cmpxchg, but if we
construct an ABA scenario like I did in my previous reply, _then_ we
have a problem. Otherwise it will just retry loop on exit if we e.g.
llist_del_first and kptr_xchg the ptr (which won't do llist_add).

>
> > This makes nmi free llist HEAD -> D -> ...
> > A, B, C are allocated in prog.
> > Now it does unit_free of all three, but in order of B, C, A.
> > unit_free does llist_add, nmi free llist becomes HEAD -> A -> C -> B -> D -> ...
> >
> > Nested NMI prog exits.
> > We continue with our cmpxchg(&head->first, A, B); It succeeds, A is
> > returned, but C will be leaked.
>
> This exact scenario cannot happen for bpf_mem_cache's freelist.
> unit_alloc is doing llist_del_first on per-cpu freelist.
> We can have two perf_event bpf progs. Both progs would
> share the same hash map and use the same struct bpf_mem_alloc,
> and both call unit_alloc() on the same cpu freelist,
> but as you noticed bpf_prog_active covers that case.
> bpf_prog_active is too coarse as we discussed in the other thread a
> month or so ago. It prevents valid and safe execution of bpf progs, lost
> events, etc. We will surely come up with a better mechanism.
>
> Going back to your earlier question:
>
> > Which are the other cases that might cause reentrancy in this
> > branch such that we need atomics instead of c->free_cnt_nmi--?
>
> It's the case where perf_event bpf prog happened inside bpf_mem_refill in irq_work.
> bpf_mem_refill manipulates free_cnt_nmi and nmi bpf prog too through unit_alloc.
> Which got me thinking that there is indeed a missing check here.

Aaah, ok, so this is what you wanted to prevent. Makes sense, even
though NMI nesting won't happen in progs (atleast for now), this
irq_work refilling can be interrupted by some perf NMI prog, or raw_tp
tracing prog in NMI context.

> We need to protect free_bulk_nmi's llist_del_first from unit_alloc's llist_del_first.
> bpf_prog_active could be used for that, but let's come up with a cleaner way.
> Probably going to add atomic_t flag to bpf_mem_cache and cmpxchg it,
> or lock and spin_trylock it. tbd.

Hm, can you explain why an atomic flag or lock would be needed, and
not just having a small busy counter like bpf_prog_active for the NMI
free llist will work? bpf_mem_cache is already per-CPU so it can just
be int alongside the llist. You inc it before llist_del_first, and
then assuming inc is atomic across interrupt boundary (which I think
this_cpu_inc_return for bpf_prog_active is already assuming), NMI prog
will see llist as busy and will fail its llist_del_first.
llist_add should still be fine to allow.

Technically we can fail llist_add instead, since doing multiple
llist_del_first won't be an issue, but you can't fail bpf_mem_free,
though you can fail bpf_mem_alloc, so it makes sense to protect only
llist_del_first using the counter.

PS: Also, it would be great if you could add a few words about this
around this code, i.e. which contexts would nest and those are what
this atomic_inc/dec and llist_del_first protection prevents problems
in.
