Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD85597AB3
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 02:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiHRAkE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 20:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiHRAkD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 20:40:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848B7B1E0
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 17:40:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 12so73215pga.1
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=b0WeULDIUoaSdEwpJ/ka61J17NOg91ZQ9Yyb6cQ0jPA=;
        b=gaQBRYXbabCHDL6BwAnOiQZmJzMtJdbXc5dtk0VqwmZjryXubXT0CvgOnCrenmAomM
         MzCT+Mmqrv1rjZz70JMyEgDgkYZ+5AE4ws02d6MTKEZvI2VeDsV6BCcwQ3mzRee8XLwA
         rxrvisAtQxvTA5YxWqKac0CM+JoEUJDQBVhBwD2UCac8KuKHnamtHxs5UDoK6q3psxgy
         pwCSTUCDznYM2R5G9Fu9dBJxC6VaLSIQ5f4jZE2ovIFsx3toSJwhCNUCvwm2NCvkWBnP
         Z50TqXNwJynhaWT2z2rKyoyfQMoDzD2ftKaXfqy9w9pabOLk81JNeFqMeW9OrodP9+rp
         O6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=b0WeULDIUoaSdEwpJ/ka61J17NOg91ZQ9Yyb6cQ0jPA=;
        b=2nWgZe73SO9OlAFZfjzSQJ5eHZGQphgklf2MGQiaCoVkBWrb7McpF7lDaJZfTyydk7
         LHSxWlYDp9WpAekJf8gNGAhn6KjCUrYUs3AQBzpxkvt1FAOePoL02J6LnxCwWuFtVzJ9
         sew5zST0TPcFiPCCCBw17JPuj0QCG9YSr0YVmTJ2WAB84eMUtW0tzJ0zKR1DnGuR9Ro1
         wxmrWlssg/Rg0HbU/kU1ET3Fb/3amyokmKvogLBsg9kkxZ5pcp6xlZ2UCAO6NhGtNOEp
         5FLp/z6/MVhOHeWjWDZbmckeZFyuOmEXWkmiLCsaM7JQZu3IUWHcjgWixdZbcgh+FqGP
         /F3Q==
X-Gm-Message-State: ACgBeo1sMZ8AfK+GScrovJeCsygAbgft2vcEfylA4ehSm0sv5OfS5ydl
        tKAzf6s1dGEZmS3lHzngPJ/Fdy4FWko=
X-Google-Smtp-Source: AA6agR6O6XoKrrOEFPfj2S1FJ8BXLTWawfQEtsOoZskNoApy+Lcl1KX6VQtna5FEnn/mp9zoo45EHQ==
X-Received: by 2002:a63:f34b:0:b0:429:f039:ccfc with SMTP id t11-20020a63f34b000000b00429f039ccfcmr602990pgj.95.1660783201054;
        Wed, 17 Aug 2022 17:40:01 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id t3-20020a628103000000b0052aaf7fe731sm136033pfd.45.2022.08.17.17.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 17:40:00 -0700 (PDT)
Date:   Wed, 17 Aug 2022 17:39:57 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 01/12] bpf: Introduce any context BPF
 specific memory allocator.
Message-ID: <20220818003957.t5lcp636n7we37hk@MacBook-Pro-3.local>
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
 <20220817210419.95560-2-alexei.starovoitov@gmail.com>
 <CAP01T77L6e=B6OtLcM4bToM5n4+j3S6+p+ieTPtDGUgQUZ3o1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77L6e=B6OtLcM4bToM5n4+j3S6+p+ieTPtDGUgQUZ3o1Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 01:51:39AM +0200, Kumar Kartikeya Dwivedi wrote:
> > +
> > +/* notrace is necessary here and in other functions to make sure
> > + * bpf programs cannot attach to them and cause llist corruptions.
> > + */
> > +static void notrace *unit_alloc(struct bpf_mem_cache *c)
> > +{
> > +       bool in_nmi = bpf_in_nmi();
> > +       struct llist_node *llnode;
> > +       unsigned long flags;
> > +       int cnt = 0;
> > +
> > +       if (unlikely(in_nmi)) {
> > +               llnode = llist_del_first(&c->free_llist_nmi);
> > +               if (llnode)
> > +                       cnt = atomic_dec_return(&c->free_cnt_nmi);
> 
> I am trying to understand which case this
> atomic_dec_return/atomic_inc_return protects against in the
> unit_alloc/unit_free for in_nmi branch. Is it protecting nested NMI
> BPF prog interrupting NMI prog?
> 
> In case of perf it seems we use bpf_prog_active, 

yes, but bpf_prog_active has plenty of downsides and hopefully
will be replaced eventually with cleaner mechanism.
Separate topic.

> so nested NMI prog
> won't be invoked while we are interrupted inside a BPF program in NMI
> context. Which are the other cases that might cause reentrancy in this
> branch such that we need atomics instead of c->free_cnt_nmi--? Or are
> you anticipating you might allow this in the future even if it is
> disallowed for now?
> 
> If programs are allowed to stack like this, and we try to reason about
> the safety of llist_del_first operation, the code is:
> 
> struct llist_node *llist_del_first(struct llist_head *head)
> {
>      struct llist_node *entry, *old_entry, *next;
> 
>      entry = smp_load_acquire(&head->first);
>      for (;;) {
>          if (entry == NULL)
>              return NULL;
>          old_entry = entry;
>          next = READ_ONCE(entry->next);
> >>>>>>>> Suppose nested NMI comes at this point and BPF prog is invoked.

llist_del_first is notrace.
unit_alloc() above is also notrace. See comment before it.
perf event overflow NMI can happen here, but for some other llist.
Hence we're talking about NMI issues only here. fentry progs do not apply here.

> Assume the current nmi free llist is HEAD -> A -> B -> C -> D -> ...
> For our cmpxchg, parameters are going to be cmpxchg(&head->first, A, B);
> 
> Now, nested NMI prog does unit_alloc thrice. this does llist_del_first thrice

Even double llist_del_first on the same llist is bad. That's a known fact.

> This makes nmi free llist HEAD -> D -> ...
> A, B, C are allocated in prog.
> Now it does unit_free of all three, but in order of B, C, A.
> unit_free does llist_add, nmi free llist becomes HEAD -> A -> C -> B -> D -> ...
> 
> Nested NMI prog exits.
> We continue with our cmpxchg(&head->first, A, B); It succeeds, A is
> returned, but C will be leaked.

This exact scenario cannot happen for bpf_mem_cache's freelist.
unit_alloc is doing llist_del_first on per-cpu freelist.
We can have two perf_event bpf progs. Both progs would
share the same hash map and use the same struct bpf_mem_alloc,
and both call unit_alloc() on the same cpu freelist,
but as you noticed bpf_prog_active covers that case.
bpf_prog_active is too coarse as we discussed in the other thread a
month or so ago. It prevents valid and safe execution of bpf progs, lost
events, etc. We will surely come up with a better mechanism.

Going back to your earlier question:

> Which are the other cases that might cause reentrancy in this
> branch such that we need atomics instead of c->free_cnt_nmi--?

It's the case where perf_event bpf prog happened inside bpf_mem_refill in irq_work.
bpf_mem_refill manipulates free_cnt_nmi and nmi bpf prog too through unit_alloc.
Which got me thinking that there is indeed a missing check here.
We need to protect free_bulk_nmi's llist_del_first from unit_alloc's llist_del_first.
bpf_prog_active could be used for that, but let's come up with a cleaner way.
Probably going to add atomic_t flag to bpf_mem_cache and cmpxchg it,
or lock and spin_trylock it. tbd.
