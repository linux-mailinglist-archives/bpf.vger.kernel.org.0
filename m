Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93A565E88
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 22:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiGDUeo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 16:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDUen (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 16:34:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCCBE1F
        for <bpf@vger.kernel.org>; Mon,  4 Jul 2022 13:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KhZLsdjNJwqTmp88ps2zeJpnsRuT5FoHdMFz9vEVRgg=; b=sB1rdYGO1L1ZeDjR6sSTw8ZEw2
        mRwfnP+6T+ZFFVrLxRnrkwGQo5diBirgFsy50bJGgiNi4ZK8vVudvG4Mv57ZScEhzHXWt549g+dDI
        T5KfoWyDG0fLCMKe+61xej6OTrTGh6RhY9bPxri5R5Z22GrhDWcQvar8d6uJy+hZZsBg/e4Cu9UYv
        td74VEzB8St4G4p3vHd/rFVKajqiF8M9duRD8iZDGC62RLlkcq2Oqf5mCsNjujZxlyrgQKOZTa52d
        D+YoSINfnVxJK3tpdjtKdG99+PBQ7N4oQvEV2VVqFOjmd8vpq350s+Bzz1lA52uuDOAjKtBvVmivg
        Qo35ut7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Slz-00HZql-SG; Mon, 04 Jul 2022 20:34:24 +0000
Date:   Mon, 4 Jul 2022 21:34:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, kafai@fb.com, bpf@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <YsNOzwNztBsBcv7Q@casper.infradead.org>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrlWLLDdvDlH0C6J@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 27, 2022 at 12:03:08AM -0700, Christoph Hellwig wrote:
> I'd suggest you discuss you needs with the slab mainainers and the mm
> community firs.
> 
> On Wed, Jun 22, 2022 at 05:32:25PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > Introduce any context BPF specific memory allocator.
> > 
> > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > run in unknown context where calling plain kmalloc() might not be safe.
> > Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> > Refill this cache asynchronously from irq_work.

I can't tell from your description whether a bump allocator would work
for you.  That is, can you tell which allocations need to persist past
program execution (and use kmalloc for them) and which can be freed as
soon as the program has finished (and can use the bump allocator)?

If so, we already have one for you, the page_frag allocator
(Documentation/vm/page_frags.rst).  It might need to be extended to meet
your needs, but it's certainly faster than the kmalloc allocator.

> > There is a lot more work ahead, but this set is useful base.
> > Future work:
> > - get rid of call_rcu in hash map
> > - get rid of atomic_inc/dec in hash map
> > - tune watermarks per allocation size
> > - adopt this approach alloc_percpu_gfp
> > - expose bpf_mem_alloc as uapi FD to be used in dynptr_alloc, kptr_alloc
> > - add sysctl to force bpf_mem_alloc in hash map when safe even if pre-alloc
> >   requested to reduce memory consumption
> > - convert lru map to bpf_mem_alloc
> > 
> > Alexei Starovoitov (5):
> >   bpf: Introduce any context BPF specific memory allocator.
> >   bpf: Convert hash map to bpf_mem_alloc.
> >   selftests/bpf: Improve test coverage of test_maps
> >   samples/bpf: Reduce syscall overhead in map_perf_test.
> >   bpf: Relax the requirement to use preallocated hash maps in tracing
> >     progs.
> > 
> >  include/linux/bpf_mem_alloc.h           |  26 ++
> >  kernel/bpf/Makefile                     |   2 +-
> >  kernel/bpf/hashtab.c                    |  16 +-
> >  kernel/bpf/memalloc.c                   | 512 ++++++++++++++++++++++++
> >  kernel/bpf/verifier.c                   |  31 +-
> >  samples/bpf/map_perf_test_kern.c        |  22 +-
> >  tools/testing/selftests/bpf/test_maps.c |  38 +-
> >  7 files changed, 610 insertions(+), 37 deletions(-)
> >  create mode 100644 include/linux/bpf_mem_alloc.h
> >  create mode 100644 kernel/bpf/memalloc.c
> > 
> > -- 
> > 2.30.2
> > 
> ---end quoted text---
> 
