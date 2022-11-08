Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8B620F0A
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 12:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKHL1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 06:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiKHL1u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 06:27:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570212FC30
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 03:27:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C9F6150F
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 11:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10607C433D7;
        Tue,  8 Nov 2022 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667906866;
        bh=4vB3dDsBGGBe8WY5RJOdGjKO2DmDNLhaee1m4xacIUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCpRWw5/plxudf8E9fItao4aUQp+cg+RZu6iqW0cKcfVTRh/BSeVOflaJT3tdU4Ix
         6CivndC+8DWCnewzJPLddPk43COJGcWkPBWKinYpbu4o3dH0m6kwOYbmekVyiGwsB7
         ocKOJ8ewyeH/iFeKUoA0BaTDP0fly4T/cdnt+U4Q26FMWWC9m519ZhO//9xXpZYd4h
         Uu8ZsjSW0DoCqgQPUcZcPnc4Av/taD+VQwUAS1Q5jGooi6mTFXulc/zlgxMUmdbzi4
         rShr9sHIQaa1iQn08AppnV892dSRLySHEPwYvlEEbPfhT54mDjeq9dmSsreI+l1A6G
         uyCLAG9GBbNhA==
Date:   Tue, 8 Nov 2022 13:27:31 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y2o9Iz30A3Nruqs4@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107223921.3451913-1-song@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,
 
On Mon, Nov 07, 2022 at 02:39:16PM -0800, Song Liu wrote:
> This patchset tries to address the following issues:
> 
> 1. Direct map fragmentation
> 
> On x86, STRICT_*_RWX requires the direct map of any RO+X memory to be also
> RO+X. These set_memory_* calls cause 1GB page table entries to be split
> into 2MB and 4kB ones. This fragmentation in direct map results in bigger
> and slower page table, and pressure for both instruction and data TLB.
>
> Our previous work in bpf_prog_pack tries to address this issue from BPF
> program side. Based on the experiments by Aaron Lu [4], bpf_prog_pack has
> greatly reduced direct map fragmentation from BPF programs.

Usage of set_memory_* APIs with memory allocated from vmalloc/modules
virtual range does not change the direct map, but only updates the
permissions in vmalloc range. The direct map splits occur in
vm_remove_mappings() when the memory is *freed*.

That said, both bpf_prog_pack and these patches do reduce the
fragmentation, but this happens because the memory is freed to the system
in 2M chunks and there are no splits of 2M pages. Besides, since the same
2M page used for many BPF programs there should be way less vfree() calls. 
 
> 2. iTLB pressure from BPF program
> 
> Dynamic kernel text such as modules and BPF programs (even with current
> bpf_prog_pack) use 4kB pages on x86, when the total size of modules and
> BPF program is big, we can see visible performance drop caused by high
> iTLB miss rate.

Like Luis mentioned several times already, it would be nice to see numbers.
 
> 3. TLB shootdown for short-living BPF programs
> 
> Before bpf_prog_pack loading and unloading BPF programs requires global
> TLB shootdown. This patchset (and bpf_prog_pack) replaces it with a local
> TLB flush.
> 
> 4. Reduce memory usage by BPF programs (in some cases)
> 
> Most BPF programs and various trampolines are small, and they often
> occupies a whole page. From a random server in our fleet, 50% of the
> loaded BPF programs are less than 500 byte in size, and 75% of them are
> less than 2kB in size. Allowing these BPF programs to share 2MB pages
> would yield some memory saving for systems with many BPF programs. For
> systems with only small number of BPF programs, this patch may waste a
> little memory by allocating one 2MB page, but using only part of it.

I'm not convinced there are memory savings here. Unless you have hundreds
of BPF programs, most of 2M page will be wasted, won't it?
So for systems that have moderate use of BPF most of the 2M page will be
unused, right?
 
> Based on our experiments [5], we measured 0.5% performance improvement
> from bpf_prog_pack. This patchset further boosts the improvement to 0.7%.
> The difference is because bpf_prog_pack uses 512x 4kB pages instead of
> 1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.
> 
> This patchset replaces bpf_prog_pack with a better API and makes it
> available for other dynamic kernel text, such as modules, ftrace, kprobe.
 
The proposed execmem_alloc() looks to me very much tailored for x86 to be
used as a replacement for module_alloc(). Some architectures have
module_alloc() that is quite different from the default or x86 version, so
I'd expect at least some explanation how modules etc can use execmem_ APIs
without breaking !x86 architectures.
 
> This set enables bpf programs and bpf dispatchers to share huge pages with
> new API:
>   execmem_alloc()
>   execmem_alloc()
>   execmem_fill()
> 
> The idea is similar to Peter's suggestion in [1].
> 
> execmem_alloc() manages a set of PMD_SIZE RO+X memory, and allocates these
> memory to its users. execmem_alloc() is used to free memory allocated by
> execmem_alloc(). execmem_fill() is used to update memory allocated by
> execmem_alloc().
> 
> Memory allocated by execmem_alloc() is RO+X, so this doesnot violate W^X.
> The caller has to update the content with text_poke like mechanism.
> Specifically, execmem_fill() is provided to update memory allocated by
> execmem_alloc(). execmem_fill() also makes sure the update stays in the
> boundary of one chunk allocated by execmem_alloc(). Please refer to patch
> 1/5 for more details of

Unless I'm mistaken, a failure to allocate PMD_SIZE page will fail text
allocation altogether. That means that if somebody tries to load a BFP
program on a busy long lived system, they are quite likely to fail because
high order free lists might be already exhausted although there is still
plenty of free memory.

Did you consider a fallback for small pages if the high order allocation
fails?

-- 
Sincerely yours,
Mike.
