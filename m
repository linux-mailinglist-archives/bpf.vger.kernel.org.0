Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A184055EA92
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiF1REA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiF1RDs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:03:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A51511824
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:03:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c4so11615587plc.8
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OU8WUB6QZv3fzXCyA8VX1te4xsGWLQRtBW2oFDLfWyA=;
        b=eVenewKW8iLFOd58gS2pf8kiu9IT31PyyWl0pIqOay7A39me1hIT/dn429X1+DGUvG
         a4XO7Uu7NawQiEuEy+Fu4WDtDcGBkEJsrqx6e+rN1RJWdjfQWsOOJ87Gw5on0mUvd9X2
         o1CUXjq7cS/9DbN9Vr2KTCQHKVGih4hN+2S6Nx/hjhb34cwcYTj/qQwAYvhe3seoA9Qr
         B+HN/qy1RyTnpSl6cQMVF6uAkuOSWLrp1k5Esb3pS6bl2Lq6Xy1De45xGNok8bDaiYXA
         RO+Dn8y90jzlMvb5XcW+Z3GJnVEcnUKrUdI4aR54B+ETduHp6t0nYtvILDAt7pWnSV/U
         DtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OU8WUB6QZv3fzXCyA8VX1te4xsGWLQRtBW2oFDLfWyA=;
        b=BRCxb94uFNPIGU/2gEm30jkO7OhLR+/f0Jzw2kyqwfpE0Rv20GedWU9fSvuiSvhz88
         19V4eKN/hcEzNjMtz84DWE7GkTV4Fp+sbp1JJDRVS9OP2xQ/WRmZ9G2pF1jjQnaS/oUa
         XTy+ZIUnTbBJYME5AZs+efxAVWij+pAVrdqZtkWso2KExlKD9NMudUL6blKwg/NaBNfv
         zHh+VjmXlfem9Un8AP5Cvcz+5fBKC4Q/w6mGVgD0SeDHxwtboMOiNNkYPhE5E8MUC2xH
         uqT3aDUcUtRlLae7QqRTb996eFZo42mvRZsAov0Ely//QTyZKrEXAxxrdfF8K63mrIZO
         uJBg==
X-Gm-Message-State: AJIora+XkIFP+sggyBsxMJNUOxZj2czqd2qsXUdII3TFHW+/YV6GeE2F
        AFIkd02WKKwMpgiMLFv2NLU=
X-Google-Smtp-Source: AGRyM1ui/q1saVihJEUNQmGeDO5B6I9PqLvtGxAYvreR9CUUZffg3O2W//t5c0Vd2JfQidUWwVszJg==
X-Received: by 2002:a17:902:6bc6:b0:16a:569d:33da with SMTP id m6-20020a1709026bc600b0016a569d33damr5737146plt.59.1656435827001;
        Tue, 28 Jun 2022 10:03:47 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::1:50])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c20900b0015e8d4eb1dfsm9607528pll.41.2022.06.28.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:03:46 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:03:43 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <20220628170343.ng46xfwi32vefiyp@MacBook-Pro-3.local>
References: <YrlWLLDdvDlH0C6J@infradead.org>
 <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de>
 <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com>
 <alpine.DEB.2.22.394.2206281550210.328950@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2206281550210.328950@gentwo.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 03:57:54PM +0200, Christoph Lameter wrote:
> On Mon, 27 Jun 2022, Alexei Starovoitov wrote:
> 
> > On Mon, Jun 27, 2022 at 5:17 PM Christoph Lameter <cl@gentwo.de> wrote:
> > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Introduce any context BPF specific memory allocator.
> > > >
> > > > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > > > run in unknown context where calling plain kmalloc() might not be safe.
> > > > Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> > > > Refill this cache asynchronously from irq_work.
> > >
> > > GFP_ATOMIC etc is not going to work for you?
> >
> > slab_alloc_node->slab_alloc->local_lock_irqsave
> > kprobe -> bpf prog -> slab_alloc_node -> deadlock.
> > In other words, the slow path of slab allocator takes locks.
> 
> That is a relatively new feature due to RT logic support. without RT this
> would be a simple irq disable.

Not just RT.
It's a slow path:
        if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
            unlikely(!object || !slab || !node_match(slab, node))) {
              local_unlock_irqrestore(&s->cpu_slab->lock,...);
and that's not the only lock in there.
new_slab->allocate_slab... alloc_pages grabbing more locks.

> Generally doing slab allocation  while debugging slab allocation is not
> something that can work. Can we exempt RT locks/irqsave or slab alloc from
> BPF tracing?

People started doing lock profiling with bpf back in 2017.
People do rcu profiling now and attaching bpf progs to all kinds of low level
kernel internals: page alloc, etc.

> I would assume that other key items of kernel logic will have similar
> issues.

We're _not_ asking for any changes from mm/slab side.
Things were working all these years. We're making them more efficient now
by getting rid of 'lets prealloc everything' approach.

> > Which makes it unsafe to use from tracing bpf progs.
> > That's why we preallocated all elements in bpf maps,
> > so there are no calls to mm or rcu logic.
> > bpf specific allocator cannot use locks at all.
> > try_lock approach could have been used in alloc path,
> > but free path cannot fail with try_lock.
> > Hence the algorithm in this patch is purely lockless.
> > bpf prog can attach to spin_unlock_irqrestore and
> > safely do bpf_mem_alloc.
> 
> That is generally safe unless you get into reetrance issues with memory
> allocation.

Right. Generic slab/mm/page_alloc/rcu are not ready for reentrance and
are not safe from NMI either.
That's why we're added all kinds of safey mechanisms in bpf layers.

> Which begs the question:
> 
> What happens if I try to use BPF to trace *your* shiny new memory

'shiny and new' is overstatement. It's a trivial lock less freelist layer
on top of kmalloc. Please read the patch.

> allocation functions in the BPF logic like bpf_mem_alloc? How do you stop
> that from happening?

here is the comment in the patch:
/* notrace is necessary here and in other functions to make sure
 * bpf programs cannot attach to them and cause llist corruptions.
 */
