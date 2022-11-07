Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9327A61EB3F
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 07:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKGG6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 01:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKGG6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 01:58:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14D385
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 22:58:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EBD1B808C8
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 06:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B43C433C1;
        Mon,  7 Nov 2022 06:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667804316;
        bh=/nsnjaPdz26XUOTcvh1Wl+FSv7xUUdqY1hb0BkBhvnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0ohsC7MNJPHCWuCd8UPzFCklAY4c5FqCvUnAu5N/ByDcUXyamQt8w6GvPTQyNwVl
         aRD96lgNDkqMcY7Lqsht3sn7BbsHO2yNgwm6BmgfgjpTrKgFfSHKESnb0bvxz1tvm7
         AOVDvhPKDl5OPRQh6MqIgN0Bd2GKSe11NjUGIGKi/U8S6jw9UhGINKVZ9U/G70iT7L
         WPKEnV1BLfeGcef7bQmA0vk2JVzA7BFEGLxt1humZgcl6QOgdEjHwDARC1rYGGetbT
         LlKCBbk+e3AFI3buWGAiGZzNp7IT6ISVKvZ9P/oqt45wfPwsHD3aZ0EpcfAMvhsJBz
         WrvYs31EBmhWw==
Date:   Mon, 7 Nov 2022 08:58:17 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, zhengjun.xing@linux.intel.com,
        kbusch@kernel.org, p.raghav@samsung.com, dave@stgolabs.net,
        vbabka@suse.cz, mgorman@suse.de, willy@infradead.org,
        torvalds@linux-foundation.org, a.manzanares@samsung.com
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Message-ID: <Y2isiVZcd9vA/kec@kernel.org>
References: <20221031222541.1773452-1-song@kernel.org>
 <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
 <Y2Pjnd3mxA9fTlox@kernel.org>
 <Y2QPpODzdP+2YSMN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2QPpODzdP+2YSMN@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 03, 2022 at 11:59:48AM -0700, Luis Chamberlain wrote:
> On Thu, Nov 03, 2022 at 05:51:57PM +0200, Mike Rapoport wrote:
> 
> > I had to put this project on a backburner for $VARIOUS_REASONS, but I still
> > think that we need a generic allocator for memory with non-default
> > permissions in the direct map and that code allocation should build on that
> > allocator.
> 
> It seems this generalization of the bpf prog pack to possibly be used
> for modules / kprobes / ftrace is a small step in that direction.
> 
> > All that said, the direct map fragmentation problem is currently relevant
> > only to x86 because it's the only architecture that supports splitting of
> > the large pages in the direct map.
> 
> I was thinking even more long term too, using this as a proof of concept. If
> this practice in general helps with fragmentation, could it be used for
> experimetnation with compound pages later, as a way to reduce possible
> fragmentation.

As Rick already mentioned, these patches help with the direct map
fragmentation only indirectly. With these patches memory is freed in
PMD_SIZE chunks and this makes the changes to the direct map in
vm_remove_mappings() to happen in in PMD_SIZE units and this is pretty much
the only effect of this series on the direct map layout.

A bit unrelated, but I'm wondering now if we want to have the direct map
alias of the pages allocated for code also to be read-only...

> > Whenever a large page in the direct map is split, all
> > kernel accesses via the direct map will use small pages which requires
> > dealing with 512 page table entries instead of one for 2M range.
> > 
> > Since small pages in the direct map are never collapsed back to large
> > pages, long living system that heavily uses eBPF programs will have its
> > direct map severely fragmented, higher TLB miss rate and worse overall
> > performance. 
> 
> Shouldn't compaction help with those situations?

Compaction helps to reduce fragmentation of the physical memory, it tries
to bring free physical pages next to each other to create large contiguous
chunks, but it does not change the virtual addresses the users of the
underlying data see.

Changing permissions of a small page in the direct map causes
"discontinuity" in the virtual space. E.g. if we have 2M mapped RW with a
single PMD changing several page in the middle of those 2M to R+X will
require to remap that range with 512 PTEs.
 
> Thanks!
> 
>   Luis

-- 
Sincerely yours,
Mike.
