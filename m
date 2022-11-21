Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12F2632DAD
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 21:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKUUMy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 15:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKUUMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 15:12:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA0BC0F
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 12:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uyrODJijh/Kf+wZfiEYlcrVS42GTgPn4cizoH6ul7r8=; b=Ac5mFgj6e6G5LJ8fPQnpC/yvSY
        mJnVFKaEDw3nQn8oVazuFxadNIe15qFFjgu/Xvb2jms+JQmccFBn6edrf6M+AqAorANre+XMchYHk
        wVCk2xry50tn83TWEWHBxDbNDBIb0STM9sYLnzpgOaHWWauo5z6se3qexxL72HiftLvU2TYUl+g52
        Q8KJw9U+9Dra/kRH/qcvyLY3Ndi742v5LwKWMvYPGGBZvQ324uXI6bicLxze9vP3VsjgX6wnTGxVE
        siR/CFNv1RV1rAkBAKfLK7z1T0RkfBfhlGK2MV8eR4foQTr5eIsu2UP2gLdodOg9m/R925fKzKlBn
        BThftF7g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxD9t-00HV2c-13; Mon, 21 Nov 2022 20:12:49 +0000
Date:   Mon, 21 Nov 2022 12:12:48 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, rppt@kernel.org, willy@infradead.org,
        dave@stgolabs.net, a.manzanares@samsung.com
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
Message-ID: <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
References: <20221117202322.944661-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117202322.944661-1-song@kernel.org>
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

On Thu, Nov 17, 2022 at 12:23:16PM -0800, Song Liu wrote:
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

This value is clear, but I'd like to see at least another new user and
the respective commit log show the gains as Aaron Lu showed.

> 2. iTLB pressure from BPF program
> 
> Dynamic kernel text such as modules and BPF programs (even with current
> bpf_prog_pack) use 4kB pages on x86, when the total size of modules and
> BPF program is big, we can see visible performance drop caused by high
> iTLB miss rate.

As suggested by Mike Rapoport, "benchmarking iTLB performance on an idle
system is not very representative. TLB is a scarce resource, so it'd be
interesting to see this benchmark on a loaded system."

This would also help pave the way to measure this for more possible
future callers like modules. There in lies true value to this
consideration.

Also, you mention your perf stats are run on a VM, I am curious what
things you need to get TLB to be properly measured on the VM and if
this is really reliable data Vs bare metal. I haven't yet been sucessful
on getting perf stat for TBL to work on a VM and based on what I've read
have been catious about the results.

So curious if you'd see something different on bare metal.

[0] https://lkml.kernel.org/r/Y3YA2mRZDJkB4lmP@kernel.org

> 3. TLB shootdown for short-living BPF programs
> 
> Before bpf_prog_pack loading and unloading BPF programs requires global
> TLB shootdown. This patchset (and bpf_prog_pack) replaces it with a local
> TLB flush.

If this is all done on the bpf code replacement then the commit log
should clarify that in the commit log, as then it allows future users
to not be surprised if they don't see these gains as this is specific
to the way bpf code used bpf_prog_pag. Also, you can measure the
shootdowns and show the differences with perf stat tlb:tlb_flush.

> 4. Reduce memory usage by BPF programs (in some cases)
> 
> Most BPF programs and various trampolines are small, and they often
> occupies a whole page. From a random server in our fleet, 50% of the
> loaded BPF programs are less than 500 byte in size, and 75% of them are
> less than 2kB in size. Allowing these BPF programs to share 2MB pages
> would yield some memory saving for systems with many BPF programs. For
> systems with only small number of BPF programs, this patch may waste a
> little memory by allocating one 2MB page, but using only part of it.
> 
> 5. Introduce a unified API to allocate memory with special permissions.
> 
> This will help get rid of set_vm_flush_reset_perms calls from users of
> vmalloc, module_alloc, etc.

And *this* is one of the reasons I'm so eager to see a proper solution
drawn up. This would be a huge win for modules, however since some of
the complexities in special permissions with modules lies in all the
cross architecture hanky panky, I'd prefer to see this through merged
*iff* we have modules converted as well as it would give us a clearer
picture if the solution covers the bases. And we'd get proper testing
on this. Rather than it being a special thing for BPF.

> Based on our experiments [5], we measured ~0.6% performance improvement
> from bpf_prog_pack. This patchset further boosts the improvement to ~0.8%.

I'd prefer we leave out arbitrary performance data, as it does not help much.

> The difference is because bpf_prog_pack uses 512x 4kB pages instead of
> 1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.
> 
> This patchset replaces bpf_prog_pack with a better API and makes it
> available for other dynamic kernel text, such as modules, ftrace, kprobe.

Let's see that through, then I think the series builds confidence in
implementation.

  Luis
