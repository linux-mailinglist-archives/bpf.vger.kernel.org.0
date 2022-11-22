Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E553633355
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiKVC3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiKVC3a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:29:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6215EF92
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C745B81910
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6ABC43148
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669084130;
        bh=JrZtrjEHuLa5/88wHl53LnA/5Ds0/h21PXHg62YsdHI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kKkVw1zqCjxH5cEIVmbR5RwHAvZ/46Izq2J73/WcWTbnk3oeBrM1MhrnZ6nIMJ2VN
         EFz4X+NCJ+8NBLiorMwJMK0HZTNP8NKTRnHPgFsUY5VQ+OTTrSr11WwkUoyhp5OYlk
         KlZWUdmxlQkmnk4rB/C8mZAHUK4LwRTQW7NLy6klLDYXgZMoJgCoV7scDUG9+P4m+h
         PqURLFjTYbvZGkqhY8YD4SrC8YYXU8fVeK8G5w99ZgAITqgdN10j3IQwU1R5lorWyH
         N8GEcZL9uYkLWTRS35g0by0Q+2etwWoqTV6v7o7C9QhCql1d0cjLmajXR54TZ10Ejl
         OUKPyXYssyq9Q==
Received: by mail-ed1-f51.google.com with SMTP id b8so7973938edf.11
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:28:50 -0800 (PST)
X-Gm-Message-State: ANoB5pnDEz9a1V2x1jdaASM2mnkNjKDphP7JoFvOU3VLcqpBrS/ctjWg
        Il0PldhRRa4EfceZE04dwTUO2duGHaPHku9hKzA=
X-Google-Smtp-Source: AA0mqf7dr8eaagiMOnVJVTFErGeCoLAY82SbBfvX0Kp7s0ATQtqIWurGVUydWjcYHeq2R0J/vR9UbCaJ+iOaydRgR/Q=
X-Received: by 2002:aa7:cd91:0:b0:469:2f36:fd with SMTP id x17-20020aa7cd91000000b004692f3600fdmr4876417edv.385.1669084129032;
 Mon, 21 Nov 2022 18:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20221117202322.944661-1-song@kernel.org> <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
In-Reply-To: <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Nov 2022 19:28:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7AfwpV6G8U7VRXMcjBEUf7OCOY5eR7eagEoXVK-AmBRg@mail.gmail.com>
Message-ID: <CAPhsuW7AfwpV6G8U7VRXMcjBEUf7OCOY5eR7eagEoXVK-AmBRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, rppt@kernel.org, willy@infradead.org,
        dave@stgolabs.net, a.manzanares@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 1:12 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Nov 17, 2022 at 12:23:16PM -0800, Song Liu wrote:
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
> This value is clear, but I'd like to see at least another new user and
> the respective commit log show the gains as Aaron Lu showed.
>
> > 2. iTLB pressure from BPF program
> >
> > Dynamic kernel text such as modules and BPF programs (even with current
> > bpf_prog_pack) use 4kB pages on x86, when the total size of modules and
> > BPF program is big, we can see visible performance drop caused by high
> > iTLB miss rate.
>
> As suggested by Mike Rapoport, "benchmarking iTLB performance on an idle
> system is not very representative. TLB is a scarce resource, so it'd be
> interesting to see this benchmark on a loaded system."
>
> This would also help pave the way to measure this for more possible
> future callers like modules. There in lies true value to this
> consideration.
>
> Also, you mention your perf stats are run on a VM, I am curious what
> things you need to get TLB to be properly measured on the VM and if
> this is really reliable data Vs bare metal. I haven't yet been sucessful
> on getting perf stat for TBL to work on a VM and based on what I've read
> have been catious about the results.

To make these perf counters work on VM, we need a newer host kernel
(my system is running 5.6 based kernel, but I am not sure what is the
minimum required version). Then we need to run qemu with option
"-cpu host" (both host and guest are x86_64).

>
> So curious if you'd see something different on bare metal.

Once the above all worked out, VM runs the same as bare metal from
perf counter's point of view.

>
> [0] https://lkml.kernel.org/r/Y3YA2mRZDJkB4lmP@kernel.org
>
> > 3. TLB shootdown for short-living BPF programs
> >
> > Before bpf_prog_pack loading and unloading BPF programs requires global
> > TLB shootdown. This patchset (and bpf_prog_pack) replaces it with a local
> > TLB flush.
>
> If this is all done on the bpf code replacement then the commit log
> should clarify that in the commit log, as then it allows future users
> to not be surprised if they don't see these gains as this is specific
> to the way bpf code used bpf_prog_pag. Also, you can measure the
> shootdowns and show the differences with perf stat tlb:tlb_flush.
>
> > 4. Reduce memory usage by BPF programs (in some cases)
> >
> > Most BPF programs and various trampolines are small, and they often
> > occupies a whole page. From a random server in our fleet, 50% of the
> > loaded BPF programs are less than 500 byte in size, and 75% of them are
> > less than 2kB in size. Allowing these BPF programs to share 2MB pages
> > would yield some memory saving for systems with many BPF programs. For
> > systems with only small number of BPF programs, this patch may waste a
> > little memory by allocating one 2MB page, but using only part of it.
> >
> > 5. Introduce a unified API to allocate memory with special permissions.
> >
> > This will help get rid of set_vm_flush_reset_perms calls from users of
> > vmalloc, module_alloc, etc.
>
> And *this* is one of the reasons I'm so eager to see a proper solution
> drawn up. This would be a huge win for modules, however since some of
> the complexities in special permissions with modules lies in all the
> cross architecture hanky panky, I'd prefer to see this through merged
> *iff* we have modules converted as well as it would give us a clearer
> picture if the solution covers the bases. And we'd get proper testing
> on this. Rather than it being a special thing for BPF.
>
> > Based on our experiments [5], we measured ~0.6% performance improvement
> > from bpf_prog_pack. This patchset further boosts the improvement to ~0.8%.
>
> I'd prefer we leave out arbitrary performance data, as it does not help much.

This really bothers me. With real workload, we are talking about performance
difference of ~1%. I don't think there is any open source benchmark that can
show this level of performance difference. In our case, we used A/B test with
80 hosts (40 vs. 40) and runs for many hours to confidently show 1%
performance difference.

This exact benchmark has a very good record of reporting smallish
performance regression. For example, this commit

  commit 7af0145067bc ("x86/mm/cpa: Avoid the 4k pages check completely")

fixes a bug that splits the page table (from 2MB to 4kB) for the WHOLE kernel
text. The bug stayed in the kernel for almost a year. None of all the available
open source benchmark had caught it before this specific benchmark.

We have used this benchmark to demonstrate performance benefits of many
optimizations. I don't understand why it suddenly becomes "arbitrary
performance data".

Song

>
> > The difference is because bpf_prog_pack uses 512x 4kB pages instead of
> > 1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.
> >
> > This patchset replaces bpf_prog_pack with a better API and makes it
> > available for other dynamic kernel text, such as modules, ftrace, kprobe.
>
> Let's see that through, then I think the series builds confidence in
> implementation.
