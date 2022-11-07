Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0446B6202CC
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 23:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiKGW46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 17:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiKGW4n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 17:56:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344BD303D5
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 14:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fJcfgxXmL+GKcXUyKfPyWxmmj0zZYYjlCkHwiQsbtvQ=; b=aYlFGfCyqs4VEApNYDQshl9gdT
        1G6JUKI3EY+kbMzXNOlW5V1oHr1l6glDcDR5myrSfpNmPuKCrt+vpRWvURttBUURjAvZQTyYKCE8k
        wGTn6oDx7m1NUz2/39wP5UP46k18DHYUiJk6++0fQrJL+zbZGNgVB7zRP+60JIbF27TfDiF+phUXH
        eWE5kjn8wkfeO5183iSAJAIz/Q7RUpH+WbJU8kPsBwmXvCNiEiQ6tt593VQeaJ9V/1l2jrkFWuSSS
        DBN/ZC5QLoCtRmfzNmOefGKKR3s/1MRLGMcmuJQI6lkNqD19QHFcxh9/4XED1Kl2HDtS0AvvyVyir
        /C3vBIfQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osB1Z-001A3Y-Ay; Mon, 07 Nov 2022 22:55:25 +0000
Date:   Mon, 7 Nov 2022 14:55:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        dave@stgolabs.net, torvalds@linux-foundation.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y2mM3eElIBmAyLko@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107223921.3451913-1-song@kernel.org>
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

You should be able to past the results there into the respecite commit
from non-bpf-prog-pack to the new generalized solution here.

> 2. iTLB pressure from BPF program
> 
> Dynamic kernel text such as modules and BPF programs (even with current
> bpf_prog_pack) use 4kB pages on x86, when the total size of modules and
> BPF program is big, we can see visible performance drop caused by high
> iTLB miss rate.

This is arbitrary, please provide some real stat and in the commit with
some reproducible benchmark.

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

Should be easy to provide some real numbers with at least selftests and
onto the commit as well.

> Based on our experiments [5], we measured 0.5% performance improvement
> from bpf_prog_pack. This patchset further boosts the improvement to 0.7%.
> The difference is because bpf_prog_pack uses 512x 4kB pages instead of
> 1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.
> 
> This patchset replaces bpf_prog_pack with a better API and makes it
> available for other dynamic kernel text, such as modules, ftrace, kprobe.

And likewise here, please no arbitrary internal benchmark, real numbers.

  Luis
