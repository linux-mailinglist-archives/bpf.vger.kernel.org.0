Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF0569136
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiGFRzz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiGFRzx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 13:55:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372DD2A963
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pElM16asE/8kobagivFhEnyEoB+5zrvT4JPDEdv7s7k=; b=Ig2PKkFZYKESdYdGxhdJVLffQn
        JObi3ixHlQul2s2k6EwDWRSOSr08OhSgh1WLF2MtGB4SSRcefqWtnpbUIgBznyT8tWX9EGiPWfN1j
        Ny8EaWctSNYRJr33PDbUPblThM0BDHvECM2IRids8bSM31n2Csy7oU8z2qyDfw68gagq+WQaSGvk9
        lYAjf6CvCt5FCDrzGCB40NgF+KGQhIgfoaRUDTVvDfQNGuVJT9rozPWa6tlFdjuGKfalj20Lq5/Ow
        zEMrj0yKvMP/i41iakboGt+cq/mX0N2JRyaSvbZRdJnTbVq0t/L5m2M8cytYJQ4zhrQftkArG7vVR
        j5COvtjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o99FQ-001qgB-ET; Wed, 06 Jul 2022 17:55:36 +0000
Date:   Wed, 6 Jul 2022 18:55:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <YsXMmBf9Xsp61I0m@casper.infradead.org>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 10:50:34AM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 04, 2022 at 09:34:23PM +0100, Matthew Wilcox wrote:
> > On Mon, Jun 27, 2022 at 12:03:08AM -0700, Christoph Hellwig wrote:
> > > I'd suggest you discuss you needs with the slab mainainers and the mm
> > > community firs.
> > > 
> > > On Wed, Jun 22, 2022 at 05:32:25PM -0700, Alexei Starovoitov wrote:
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > 
> > > > Introduce any context BPF specific memory allocator.
> > > > 
> > > > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > > > run in unknown context where calling plain kmalloc() might not be safe.
> > > > Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> > > > Refill this cache asynchronously from irq_work.
> > 
> > I can't tell from your description whether a bump allocator would work
> > for you.  That is, can you tell which allocations need to persist past
> > program execution (and use kmalloc for them) and which can be freed as
> > soon as the program has finished (and can use the bump allocator)?
> > 
> > If so, we already have one for you, the page_frag allocator
> > (Documentation/vm/page_frags.rst).  It might need to be extended to meet
> > your needs, but it's certainly faster than the kmalloc allocator.
> 
> Already looked at it, and into mempool, and everything we could find.
> All 'normal' allocators sooner or later synchornously call into page_alloc,

Today it does, yes.  But it might be adaptable to your needs if only I
knew what those needs were.  For example, I assume that a BPF program
has a fairly tight limit on how much memory it can cause to be allocated.
Right?

