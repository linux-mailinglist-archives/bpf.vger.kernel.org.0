Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970D355E2FB
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiF0HDX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 03:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiF0HDX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 03:03:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115B45F5A
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:References;
        bh=geJYwLUtZ4AXrvb8AEzXOmV/g8d678nc6SKMnLPSG1M=; b=m6b2pcf5uAViOElJV26xDPMepE
        1hBW3qL+THetwMi0IzDHfC+hMrKzWr1/XuqBbA/yprRUQwFmxd3AdB4FHuMMuFZNX9FvEOrcXuJQK
        SqBSrjZ2o2WAwlilmIi8842J5aqNElWwJZT+U5835oJK3BQ3E9Vw8BT80wwmpzaQeFnh1Y9RBxLuO
        et4NHfVnT+CCAKWhq2vmTk8BNx2gfTtSnTjl2R0tvu6FJTBHdPD3QTaYDe2c0lHC65LDpC4W7++ms
        3GgInQ2YSzp2iSDTLJ15GNmIEeUpHe0JksjrdONWpKx6BmwjWj3npSZkT3b94HlO3mHpLXpCXztQY
        YoyIy4Iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5im4-00GI72-PA; Mon, 27 Jun 2022 07:03:08 +0000
Date:   Mon, 27 Jun 2022 00:03:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, kafai@fb.com, bpf@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <YrlWLLDdvDlH0C6J@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'd suggest you discuss you needs with the slab mainainers and the mm
community firs.

On Wed, Jun 22, 2022 at 05:32:25PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce any context BPF specific memory allocator.
> 
> Tracing BPF programs can attach to kprobe and fentry. Hence they
> run in unknown context where calling plain kmalloc() might not be safe.
> Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> Refill this cache asynchronously from irq_work.
> 
> There is a lot more work ahead, but this set is useful base.
> Future work:
> - get rid of call_rcu in hash map
> - get rid of atomic_inc/dec in hash map
> - tune watermarks per allocation size
> - adopt this approach alloc_percpu_gfp
> - expose bpf_mem_alloc as uapi FD to be used in dynptr_alloc, kptr_alloc
> - add sysctl to force bpf_mem_alloc in hash map when safe even if pre-alloc
>   requested to reduce memory consumption
> - convert lru map to bpf_mem_alloc
> 
> Alexei Starovoitov (5):
>   bpf: Introduce any context BPF specific memory allocator.
>   bpf: Convert hash map to bpf_mem_alloc.
>   selftests/bpf: Improve test coverage of test_maps
>   samples/bpf: Reduce syscall overhead in map_perf_test.
>   bpf: Relax the requirement to use preallocated hash maps in tracing
>     progs.
> 
>  include/linux/bpf_mem_alloc.h           |  26 ++
>  kernel/bpf/Makefile                     |   2 +-
>  kernel/bpf/hashtab.c                    |  16 +-
>  kernel/bpf/memalloc.c                   | 512 ++++++++++++++++++++++++
>  kernel/bpf/verifier.c                   |  31 +-
>  samples/bpf/map_perf_test_kern.c        |  22 +-
>  tools/testing/selftests/bpf/test_maps.c |  38 +-
>  7 files changed, 610 insertions(+), 37 deletions(-)
>  create mode 100644 include/linux/bpf_mem_alloc.h
>  create mode 100644 kernel/bpf/memalloc.c
> 
> -- 
> 2.30.2
> 
---end quoted text---
