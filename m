Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD41F55E7E4
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiF1N6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347180AbiF1N56 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 09:57:58 -0400
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A96344F0
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 06:57:56 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 85421B00288; Tue, 28 Jun 2022 15:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1656424674; bh=VT8t4+mQig9OHwaOUo8PSDyy3DkhSeEak6r67HuPmB8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ihddj4pHEl8O1YbhCY63nb3i7cS1+j1fP6ZlwqcOkp2nypfaq8UBPWY7gE1sktLWD
         wt8KhDYmklnczDFwKbGaRfxbDgkKcMVz3zq0hh5JEhYEPRqIgNLS8Tw+R+2jgCT3QX
         FpNwHYmmFNxwh67WbnZsD3vynoQUlhxajKyDzI70oDTYxXcntP1VUvtuydTlFAVjnC
         cQsNPMyY9aS+vxLkJECNXgpR/TxSxPzRIfCNHJcrIbe21DKBn2SMfPNRvQI9ODIC28
         BhNauNbGMs92yX+I7JAa+OYnDspvlBk320AqxKqApexIw4TOul6gdu9yGD4oUxXhgp
         Eo645rgeTyQZw==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 82930B00132;
        Tue, 28 Jun 2022 15:57:54 +0200 (CEST)
Date:   Tue, 28 Jun 2022 15:57:54 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc:     Christoph Hellwig <hch@infradead.org>,
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
In-Reply-To: <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206281550210.328950@gentwo.de>
References: <YrlWLLDdvDlH0C6J@infradead.org> <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de> <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Jun 2022, Alexei Starovoitov wrote:

> On Mon, Jun 27, 2022 at 5:17 PM Christoph Lameter <cl@gentwo.de> wrote:
> >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Introduce any context BPF specific memory allocator.
> > >
> > > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > > run in unknown context where calling plain kmalloc() might not be safe.
> > > Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> > > Refill this cache asynchronously from irq_work.
> >
> > GFP_ATOMIC etc is not going to work for you?
>
> slab_alloc_node->slab_alloc->local_lock_irqsave
> kprobe -> bpf prog -> slab_alloc_node -> deadlock.
> In other words, the slow path of slab allocator takes locks.

That is a relatively new feature due to RT logic support. without RT this
would be a simple irq disable.

Generally doing slab allocation  while debugging slab allocation is not
something that can work. Can we exempt RT locks/irqsave or slab alloc from
BPF tracing?

I would assume that other key items of kernel logic will have similar
issues.

> Which makes it unsafe to use from tracing bpf progs.
> That's why we preallocated all elements in bpf maps,
> so there are no calls to mm or rcu logic.
> bpf specific allocator cannot use locks at all.
> try_lock approach could have been used in alloc path,
> but free path cannot fail with try_lock.
> Hence the algorithm in this patch is purely lockless.
> bpf prog can attach to spin_unlock_irqrestore and
> safely do bpf_mem_alloc.

That is generally safe unless you get into reetrance issues with memory
allocation.

Which begs the question:

What happens if I try to use BPF to trace *your* shiny new memory
allocation functions in the BPF logic like bpf_mem_alloc? How do you stop
that from happening?

