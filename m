Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3D626ED5
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 10:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiKMJ7W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 04:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMJ7V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 04:59:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACDAFCE0
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 01:59:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06C34B80B31
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 09:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03585C433C1;
        Sun, 13 Nov 2022 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668333557;
        bh=O3yETtGeGX1jXQk1imu9r0bAXCQw4m/qx6KHAyirX7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLR2KEH946GsaHHxApKhdzx4zp0mZ82jCxNkvSS+QRSf0DTkv+SiyI2Ns4PZtjqoJ
         qLgWEPCyGwKP4ef/5QX3G6qjjM2JkbzsVL9uQM+KQl2x/lCUg+T8SQzIWmQouJ0rSr
         XVZVlIbZS1EX3rRKoOWwbKT5/E3hfKGZw4ZZgbkVBkIT1Q57SZrNA3cRRrJ7VXrQZ4
         m/2RQTwOQFhKJ4eTDC7+t1erqCytC7OjHW/0pO413IfZJM4cLTNodop58GoVbqDgOd
         lxsWYlt5R1paQCInVvtx5OZ0TazER7Geiu+zcJyueJx/tw9a6HC9PdpNbbU0ji+1EQ
         B2WFPWJM0iQYA==
Date:   Sun, 13 Nov 2022 11:58:57 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3C/4Y5bt5eXadzJ@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <CAPhsuW7xtUKb7ovjLFDPap-_t1TzPZ0Td+kHparOniZf7cBCSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7xtUKb7ovjLFDPap-_t1TzPZ0Td+kHparOniZf7cBCSQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 10:41:53AM -0800, Song Liu wrote:
> On Tue, Nov 8, 2022 at 3:27 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Song,
> >
> > On Mon, Nov 07, 2022 at 02:39:16PM -0800, Song Liu wrote:
> > > This patchset tries to address the following issues:
> > >
> > > 1. Direct map fragmentation
> > >
> > > On x86, STRICT_*_RWX requires the direct map of any RO+X memory to be also
> > > RO+X. These set_memory_* calls cause 1GB page table entries to be split
> > > into 2MB and 4kB ones. This fragmentation in direct map results in bigger
> > > and slower page table, and pressure for both instruction and data TLB.
> > >
> > > Our previous work in bpf_prog_pack tries to address this issue from BPF
> > > program side. Based on the experiments by Aaron Lu [4], bpf_prog_pack has
> > > greatly reduced direct map fragmentation from BPF programs.
> >
> > Usage of set_memory_* APIs with memory allocated from vmalloc/modules
> > virtual range does not change the direct map, but only updates the
> > permissions in vmalloc range. The direct map splits occur in
> > vm_remove_mappings() when the memory is *freed*.
> >
> > That said, both bpf_prog_pack and these patches do reduce the
> > fragmentation, but this happens because the memory is freed to the system
> > in 2M chunks and there are no splits of 2M pages. Besides, since the same
> > 2M page used for many BPF programs there should be way less vfree() calls.
> >
> > > 2. iTLB pressure from BPF program
> > >
> > > Dynamic kernel text such as modules and BPF programs (even with current
> > > bpf_prog_pack) use 4kB pages on x86, when the total size of modules and
> > > BPF program is big, we can see visible performance drop caused by high
> > > iTLB miss rate.
> >
> > Like Luis mentioned several times already, it would be nice to see numbers.
> >
> > > 3. TLB shootdown for short-living BPF programs
> > >
> > > Before bpf_prog_pack loading and unloading BPF programs requires global
> > > TLB shootdown. This patchset (and bpf_prog_pack) replaces it with a local
> > > TLB flush.
> > >
> > > 4. Reduce memory usage by BPF programs (in some cases)
> > >
> > > Most BPF programs and various trampolines are small, and they often
> > > occupies a whole page. From a random server in our fleet, 50% of the
> > > loaded BPF programs are less than 500 byte in size, and 75% of them are
> > > less than 2kB in size. Allowing these BPF programs to share 2MB pages
> > > would yield some memory saving for systems with many BPF programs. For
> > > systems with only small number of BPF programs, this patch may waste a
> > > little memory by allocating one 2MB page, but using only part of it.
> >
> > I'm not convinced there are memory savings here. Unless you have hundreds
> > of BPF programs, most of 2M page will be wasted, won't it?
> > So for systems that have moderate use of BPF most of the 2M page will be
> > unused, right?
> 
> There will be some memory waste in such cases. But it will get better with:
> 1) With 4/5 and 5/5, BPF programs will share this 2MB page with kernel .text
> section (_stext to _etext);
> 2) modules, ftrace, kprobe will also share this 2MB page;

Unless I'm missing something, what will be shared is the virtual space, the
actual physical pages will be still allocated the same way as any vmalloc()
allocation.

> 3) There are bigger BPF programs in many use cases.
 
With statistics you provided above one will need hundreds if not thousands
of BPF programs to fill a 2M page. I didn't do the math, but it seems that
to see memory savings there should be several hundreds of BPF programs.

> Thanks,
> Song

-- 
Sincerely yours,
Mike.
