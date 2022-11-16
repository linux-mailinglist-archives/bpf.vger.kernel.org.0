Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CE62CDBB
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 23:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiKPWdn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 17:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiKPWdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 17:33:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC29FDD
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 14:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wJuzf5aIsw3Ynd1qAMEVEjPKFsMlYthemldWJg46Gso=; b=Ffrl4uoQKCHOHAzz2U99t1itqk
        tpGztGsq3REtLKCgG4BohhAHZfm/dIinPj0L9N6TQdSHwwuFrU3xXAPqEyQ9F27fqr5HSa3kaHkEW
        AwS/mOVzEFDBHID3YoX9RzTi7nEAwNQSmBGijNGlUhx9lXkCmyzT+Mbj/4r67Mc/BK1EY6LyomTlP
        XGR2f8Js1dwYAtAvBQ21IK2zeNilY7lRJz0QFuB7kTNHA4J9F9hd4aWu8Ad4Q755OGMvvRy6N3064
        xVKc8L5gWaERzPlVR4BnKOJAQ8iLRBOfzuYtdN2eurcgsEnm9qmnOc7YEkOLgPbDShYI4ahSCIS3x
        rLLz2cJw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovQyP-008PI1-F2; Wed, 16 Nov 2022 22:33:37 +0000
Date:   Wed, 16 Nov 2022 14:33:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3VlQcsiEi273S+n@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
 <CAPhsuW4_aYvPJUfCBkMygKPpHx7Y3xPCV7ewLGGAhyztJq3dhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4_aYvPJUfCBkMygKPpHx7Y3xPCV7ewLGGAhyztJq3dhA@mail.gmail.com>
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

On Tue, Nov 15, 2022 at 02:48:05PM -0800, Song Liu wrote:
> On Tue, Nov 15, 2022 at 1:09 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Nov 14, 2022 at 05:30:39PM -0800, Song Liu wrote:
> > > On Mon, Nov 7, 2022 at 2:41 PM Song Liu <song@kernel.org> wrote:
> > > >
> > >
> > > [...]
> > >
> > > >
> > > >
> > > > This set enables bpf programs and bpf dispatchers to share huge pages with
> > > > new API:
> > > >   execmem_alloc()
> > > >   execmem_alloc()
> > > >   execmem_fill()
> > > >
> > > > The idea is similar to Peter's suggestion in [1].
> > > >
> > > > execmem_alloc() manages a set of PMD_SIZE RO+X memory, and allocates these
> > > > memory to its users. execmem_alloc() is used to free memory allocated by
> > > > execmem_alloc(). execmem_fill() is used to update memory allocated by
> > > > execmem_alloc().
> > >
> > > Sigh, I just realized this thread made through linux-mm@kvack.org, but got
> > > dropped by bpf@vger.kernel.org, so I guess I will have to resend v3.
> >
> > I don't know what is going on with the bpf list but whatever it is, is silly.
> > You should Cc the right folks to ensure proper review if the bpf list is
> > the issue.
> >
> > > Currently, I have got the following action items for v3:
> > > 1. Add unify API to allocate text memory to motivation;
> > > 2. Update Documentation/x86/x86_64/mm.rst;
> > > 3. Allow none PMD_SIZE allocation for powerpc.
> >
> > - I am really exausted of asking again for real performance tests,
> >   you keep saying you can't and I keep saying you can, you are not
> >   trying hard enough. Stop thinking about your internal benchmark which
> >   you cannot publish. There should be enough crap out which you can use.
> >
> > - A new selftest or set of selftests which demonstrates gain in
> >   performance
> 
> I didn't mean to not show the result with publically available. I just
> thought the actual benchmark was better (and we do use that to
> demonstrate the benefit of a lot of kernel improvement).
> 
> For something publically available, how about the following:
> 
> Run 100 instances of the following benchmark from bpf selftests:
>   tools/testing/selftests/bpf/bench -w2 -d100 -a trig-kprobe
> which loads 7 BPF programs, and triggers one of them.
> 
> Then use perf to monitor TLB related counters:
>    perf stat -e iTLB-load-misses,itlb_misses.walk_completed_4k, \
>         itlb_misses.walk_completed_2m_4m -a
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
> 
> Do these address your questions with this?

More in lines with what I was hoping for. Can something just do
the parallelization for you in one shot? Can bench alone do it for you?
Is there no interest to have soemthing which generically showcases
multithreading / hammering a system with tons of eBPF JITs? It may
prove useful.

And also, it begs the question, what if you had another iTLB generic
benchmark or genearl memory pressure workload running *as* you run the
above? I as, as it was my understanding that one of the issues was the
long term slowdown caused by the directmap fragmentation without
bpf_prog_pack, and so such an application should crawl to its knees
over time, and there should be numbers you could show to prove that
too, before and after.

  Luis
