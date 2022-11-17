Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7C62D0DB
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 02:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiKQBwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 20:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiKQBwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 20:52:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028956036B
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 17:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SWLJosgcIf0vVkoGa4k8mju9fQuM7WliqRBO2ZQYrgU=; b=WrRZAhfYVZc27BXTl7CY+wFCfv
        aadi8DqdxIaglejyMCzJLCfimXQgDtxx/qW7jKfjZvG3q34WGaXH8a17jb8kLUntq0QFTQiSWt3xe
        Yxgf4eWdOYPV/dc+JcP2YIGf5dLDrQn6R79kRPiDluwOA8VFu4Y9A3Wglxi+J2v8nMgivLVP+lR0w
        ksxKWpCwwFnNrZbcU4Rum350/ntYA5ZU+ZxDmTUROyjVx2WtGSERLO59v5qZvjtpKmBiqsx/8Qfgx
        uh9PPnFdRf6m4yzB4Rl2viMqaJdfviaIw3fEI4Es7xhVx+miS4ix2uLdMbf8vhpQspDoPUIg7mr64
        z3mWKOnA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovU54-009PgA-Lo; Thu, 17 Nov 2022 01:52:42 +0000
Date:   Wed, 16 Nov 2022 17:52:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v3 4/6] bpf: use execmem_alloc for bpf program
 and bpf dispatcher
Message-ID: <Y3WT6rwrM78sqkR5@bombadil.infradead.org>
References: <20221117010621.1891711-1-song@kernel.org>
 <20221117010621.1891711-5-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117010621.1891711-5-song@kernel.org>
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

On Wed, Nov 16, 2022 at 05:06:19PM -0800, Song Liu wrote:
> Use execmem_alloc, execmem_free, and execmem_fill instead of
> bpf_prog_pack_alloc, bpf_prog_pack_free, and bpf_arch_text_copy.
> 
> execmem_free doesn't require extra size information. Therefore, the free
> and error handling path can be simplified.
> 
> There are some tests that show the benefit of execmem_alloc.
> 
> Run 100 instances of the following benchmark from bpf selftests:
>   tools/testing/selftests/bpf/bench -w2 -d100 -a trig-kprobe
> which loads 7 BPF programs, and triggers one of them.
> 
> Then use perf to monitor TLB related counters:
>    perf stat -e iTLB-load-misses,itlb_misses.walk_completed_4k, \
>            itlb_misses.walk_completed_2m_4m -a
> 
> The following results are from a qemu VM with 32 cores.
> 
> Before bpf_prog_pack:
>   iTLB-load-misses: 350k/s
>   itlb_misses.walk_completed_4k: 90k/s
>   itlb_misses.walk_completed_2m_4m: 0.1/s
> 
> With bpf_prog_pack (current upstream):
>   iTLB-load-misses: 220k/s
>   itlb_misses.walk_completed_4k: 68k/s
>   itlb_misses.walk_completed_2m_4m: 0.2/s
> 
> With execmem_alloc (with this set):
>   iTLB-load-misses: 185k/s
>   itlb_misses.walk_completed_4k: 58k/s
>   itlb_misses.walk_completed_2m_4m: 1/s

Wonderful.

It would be nice to have this integrated into the bpf selftest, instead
of having to ask someone to try to repeat and decipher how to do the
above.

Completion time results would be useseful as well.

And, then after try running this + another memory intensive benchmark
as recently suggested, have it run for a while, and then re-run again
as the direct map fragmentation should reveal that anything running
at the end after execmem_alloc() should produce gravy results.

  Luis
