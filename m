Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59B6203DC
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKGXjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKGXjT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:39:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F325140C6
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZhGQGK629QHloWEgRMKC1tpDaWWHwkr9b2asHkWWxVw=; b=d+uCyRTCpDpGrCosQPHehTiGZE
        vd+mIota8rBrAnV0HfGfLjO1nCyDGBJq3KIbmhtjM1J7H7J6ssMxSzuLKGNtFg6N0Xf5a1FJ9mWK1
        t2SEjqxJvaO7LJXZK2kdyyJOazsDDFw3c9DH7KVyRadcfyWFf5zs1CGWtVUlAAWLgWvIlOAHECCXt
        Xw9cc7PTt3hCJr7rS8jsx222bwFiOyzUn6EEVpjYQBdk26pMSNt5zaLUwgzbL0rZexjTrVrX9bv8P
        VYCXRmEIdbb6C+yEYbY80UVM1UmmESK8GKrcZf8VSxCWvQXL05V841oQ6qKmkQwAmyIcLXs8jxKP3
        9IAbe4UQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osBhz-001Dts-QQ; Mon, 07 Nov 2022 23:39:15 +0000
Date:   Mon, 7 Nov 2022 15:39:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        dave@stgolabs.net, torvalds@linux-foundation.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y2mXI1WHuhRW7Jt+@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2mM3eElIBmAyLko@bombadil.infradead.org>
 <CAPhsuW4fyx+Doy8gWG1x20v7FHtQ0OeMT_XOHrneAS8aXdrjuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4fyx+Doy8gWG1x20v7FHtQ0OeMT_XOHrneAS8aXdrjuw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 07, 2022 at 03:13:59PM -0800, Song Liu wrote:
> The benchmark used here is identical on our web service, which runs on
> many many servers, so it represents the workload that we care a lot.
> Unfortunately, it is not possible to run it out of our data centers.

I am not asking for that, I am asking for you to pick any similar
benchark which can run in paralellel which may yield similar results.

> We can build some artificial workloads and probably get much higher
> performance improvements. But these workload may not represent real
> world use cases.

You can very likely use some existing benchmark.

The direct map fragmentation stuff doesn't require much effort, as
was demonstrated by Aaron, you can easily do that or more by
running all selftests or just the test_bpf. This I buy.

I'm not buying the iTLB gains as I can't even reproduce them myself for
eBPF JIT, but I tested against iTLB when using eBPF JIT, perhaps you
mean iTLB gains for other memory intensive applications running in
tandem?

And none of your patches mentions the gains of this effort helping
with the long term advantage of centralizing the semantics for
permissions on memory.

  Luis
