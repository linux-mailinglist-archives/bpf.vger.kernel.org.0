Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BFD61FB49
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiKGR0y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 12:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiKGR0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 12:26:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF82124D
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aLI+4wjhcQmAlu+Gn5bISv4vWpUWkAnzhvT5WsWZyPs=; b=IeEGQ3fgr586+CYhOV5y4IFBIJ
        XPxBM0Rca6JHVxak18bq7Ml6Iuka7K+DnJAgjwKXOo0DuoqusIDphybfKTbjtu0/rBoFssTe3ZZ2S
        N/mJXOm84q7sowtj3hyqyVCd6m3uFoHVXir4YfmS+62wFYSmqYi/o2pahmUFameYyv5khNmOcbask
        nDpYm04ePoq4ipkiw4mxt1HVSwvYmJCFszbAwHeLLKB+p96K2Qs6jNFlLqkuy8FmBiXxR7V2oePgf
        lnQAfejAYSEOMKv+BsKnkrv0Twi93RQC98noKKIhMBaIoGy5QgmeD27AZVSal8dJ8uIe9Yj9TnfoJ
        CLDbGYLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1os5tT-00GfW6-NJ; Mon, 07 Nov 2022 17:26:43 +0000
Date:   Mon, 7 Nov 2022 09:26:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, zhengjun.xing@linux.intel.com,
        kbusch@kernel.org, p.raghav@samsung.com, dave@stgolabs.net,
        vbabka@suse.cz, mgorman@suse.de, willy@infradead.org,
        torvalds@linux-foundation.org, a.manzanares@samsung.com
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Message-ID: <Y2k/0yIQ+iECMdaO@bombadil.infradead.org>
References: <20221031222541.1773452-1-song@kernel.org>
 <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
 <Y2Pjnd3mxA9fTlox@kernel.org>
 <Y2QPpODzdP+2YSMN@bombadil.infradead.org>
 <Y2isiVZcd9vA/kec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2isiVZcd9vA/kec@kernel.org>
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

On Mon, Nov 07, 2022 at 08:58:17AM +0200, Mike Rapoport wrote:
> On Thu, Nov 03, 2022 at 11:59:48AM -0700, Luis Chamberlain wrote:
> > On Thu, Nov 03, 2022 at 05:51:57PM +0200, Mike Rapoport wrote:
> > 
> > > I had to put this project on a backburner for $VARIOUS_REASONS, but I still
> > > think that we need a generic allocator for memory with non-default
> > > permissions in the direct map and that code allocation should build on that
> > > allocator.
> > 
> > It seems this generalization of the bpf prog pack to possibly be used
> > for modules / kprobes / ftrace is a small step in that direction.
> > 
> > > All that said, the direct map fragmentation problem is currently relevant
> > > only to x86 because it's the only architecture that supports splitting of
> > > the large pages in the direct map.
> > 
> > I was thinking even more long term too, using this as a proof of concept. If
> > this practice in general helps with fragmentation, could it be used for
> > experimetnation with compound pages later, as a way to reduce possible
> > fragmentation.
> 
> As Rick already mentioned, these patches help with the direct map
> fragmentation only indirectly. With these patches memory is freed in
> PMD_SIZE chunks and this makes the changes to the direct map in
> vm_remove_mappings() to happen in in PMD_SIZE units and this is pretty much
> the only effect of this series on the direct map layout.

I understand that is what *this* series does. I was wondering is similar
scheme may be useful to study to see if it helps with aggregating say
something like 32 x 64 kb for compound page allocations of order 16 (64 Kib)
to see if it may help with possible fragmentation concerns for that world
where that may be useful in the future (completely unrelated to page
permissions).

> A bit unrelated, but I'm wondering now if we want to have the direct map
> alias of the pages allocated for code also to be read-only...
> 
> > > Whenever a large page in the direct map is split, all
> > > kernel accesses via the direct map will use small pages which requires
> > > dealing with 512 page table entries instead of one for 2M range.
> > > 
> > > Since small pages in the direct map are never collapsed back to large
> > > pages, long living system that heavily uses eBPF programs will have its
> > > direct map severely fragmented, higher TLB miss rate and worse overall
> > > performance. 
> > 
> > Shouldn't compaction help with those situations?
> 
> Compaction helps to reduce fragmentation of the physical memory, it tries
> to bring free physical pages next to each other to create large contiguous
> chunks, but it does not change the virtual addresses the users of the
> underlying data see.

Sorry I understood that 'bpf prog pack' only only used *one* 2 MiB huge
page for *all* eBPF JIT programs, and so the fragmentation issue prior
to 'bpf prog pack' I thought was the fact that as eBPF programs are
still alive, we have fragmentation. In the world without 'bpf prog pack'
I thought no huge pages were used.

> Changing permissions of a small page in the direct map causes
> "discontinuity" in the virtual space. E.g. if we have 2M mapped RW with a
> single PMD changing several page in the middle of those 2M to R+X will
> require to remap that range with 512 PTEs.

Makes sense, thanks.

  Luis
