Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C512662038A
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiKGXOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiKGXOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:14:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C88DFB2
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:14:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47E5DB816D6
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E785AC43145
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667862853;
        bh=79RwBsf+liOXUM9sIosBoswMDbRU4hjhAJG3pkLWJeM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YlOWY7d96XMq4nU+vbGWKoxDQU4m5Z76hyEVn0BtMZDUJ/NyPwu1rrN+y3v2sdyeF
         QJ4Yel7TzjxGAxFAb3dzM8R6n5ju7oGTAGiETmHMihlBbp7MXJTlNBmlWAJowGUjJE
         9OH9iwO4JkPox5SYYpSvhlzlvFM37jfyFyqiUsqBoEh6afb+zVPU1aFZTh1aVJ8QXr
         8ToP5PytXe9+SyJrYrzrW8LiKKPpZTSU6KNKyuojBcvDSVagK8YLr+gSBamvytqtOq
         /RIs/HPdibfnC6ZoOQkHsxmS7GamovTd6FkVLbsSmv56TXVrb8RAGFwOl7WzhFZz2f
         krZoDd4VB3SEQ==
Received: by mail-ej1-f46.google.com with SMTP id kt23so34167818ejc.7
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:14:13 -0800 (PST)
X-Gm-Message-State: ACrzQf36uj2aF/rSct/KHCG/6QcWWFCezfjqlMgJtE5rODf1UYfJHoWq
        CCE10ryRqNbAztSy9xWLoN5Cz1EQRribU/sCIVw=
X-Google-Smtp-Source: AMsMyM4H2tiSkcbmvp2nK8FEhFQKgKHlB4x3iMT4NuR20+rXJNAlZACVo2CnqUt74munkzvFTgXNR4n/qb7UaDkb2Es=
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id
 vl2-20020a170907b60200b007ade82c3355mr37021198ejc.3.1667862852037; Mon, 07
 Nov 2022 15:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2mM3eElIBmAyLko@bombadil.infradead.org>
In-Reply-To: <Y2mM3eElIBmAyLko@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 7 Nov 2022 15:13:59 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4fyx+Doy8gWG1x20v7FHtQ0OeMT_XOHrneAS8aXdrjuw@mail.gmail.com>
Message-ID: <CAPhsuW4fyx+Doy8gWG1x20v7FHtQ0OeMT_XOHrneAS8aXdrjuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        dave@stgolabs.net, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Luis,

On Mon, Nov 7, 2022 at 2:55 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Nov 07, 2022 at 02:39:16PM -0800, Song Liu wrote:
> > This patchset tries to address the following issues:
> >
> > 1. Direct map fragmentation
> >
> > On x86, STRICT_*_RWX requires the direct map of any RO+X memory to be also
> > RO+X. These set_memory_* calls cause 1GB page table entries to be split
> > into 2MB and 4kB ones. This fragmentation in direct map results in bigger
> > and slower page table, and pressure for both instruction and data TLB.
> >
> > Our previous work in bpf_prog_pack tries to address this issue from BPF
> > program side. Based on the experiments by Aaron Lu [4], bpf_prog_pack has
> > greatly reduced direct map fragmentation from BPF programs.
>
> You should be able to past the results there into the respecite commit
> from non-bpf-prog-pack to the new generalized solution here.
>
> > 2. iTLB pressure from BPF program
> >
> > Dynamic kernel text such as modules and BPF programs (even with current
> > bpf_prog_pack) use 4kB pages on x86, when the total size of modules and
> > BPF program is big, we can see visible performance drop caused by high
> > iTLB miss rate.
>
> This is arbitrary, please provide some real stat and in the commit with
> some reproducible benchmark.
>
> > 3. TLB shootdown for short-living BPF programs
> >
> > Before bpf_prog_pack loading and unloading BPF programs requires global
> > TLB shootdown. This patchset (and bpf_prog_pack) replaces it with a local
> > TLB flush.
> >
> > 4. Reduce memory usage by BPF programs (in some cases)
> >
> > Most BPF programs and various trampolines are small, and they often
> > occupies a whole page. From a random server in our fleet, 50% of the
> > loaded BPF programs are less than 500 byte in size, and 75% of them are
> > less than 2kB in size. Allowing these BPF programs to share 2MB pages
> > would yield some memory saving for systems with many BPF programs. For
> > systems with only small number of BPF programs, this patch may waste a
> > little memory by allocating one 2MB page, but using only part of it.
>
> Should be easy to provide some real numbers with at least selftests and
> onto the commit as well.
>
> > Based on our experiments [5], we measured 0.5% performance improvement
> > from bpf_prog_pack. This patchset further boosts the improvement to 0.7%.
> > The difference is because bpf_prog_pack uses 512x 4kB pages instead of
> > 1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.
> >
> > This patchset replaces bpf_prog_pack with a better API and makes it
> > available for other dynamic kernel text, such as modules, ftrace, kprobe.
>
> And likewise here, please no arbitrary internal benchmark, real numbers.

The benchmark used here is identical on our web service, which runs on
many many servers, so it represents the workload that we care a lot.
Unfortunately, it is not possible to run it out of our data centers.

We can build some artificial workloads and probably get much higher
performance improvements. But these workload may not represent real
world use cases.

Thanks,
Song
