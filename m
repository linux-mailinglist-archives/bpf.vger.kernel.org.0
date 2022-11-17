Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA60862D724
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 10:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiKQJhp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 04:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKQJhp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 04:37:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022A13F61
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 01:37:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEFFD62167
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 09:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5840C433C1;
        Thu, 17 Nov 2022 09:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668677863;
        bh=fI0jTTB7wOYIYQJoOVSc5UZCnbdgBK5QE0bS64cYiFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJHqrpli8gMYLJADQlc717nYlE/OIrB4da6IRxcFLTQJk7IyzujgMg/g8n3ltGqOj
         4nzve9yCsptYgqytYXRXm1fQGs9VRGaX2jIflX/reAcDmKUIiB8LQBUVR6qR5/53WA
         xF4bQGdVeVDa6Z6wgvVakrYPLuN9xo1R39JI0TM/o3oOrDPqsUEZ+0GWUuxk/gdHZ1
         0qt0Z2/bC9LqLGnPNK/iLKjIj7BCpocrgBTQzHgfYozBD6pKFGJDIJFJo12wIAfjUd
         /UtbTpdbNpX7O/D+klfi4JVhHtpxJ+lYGmhJSiNS6/GkScpbDnKG1+kfpx+Dp/r6/8
         dxicLy+pKGIvg==
Date:   Thu, 17 Nov 2022 11:37:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3YA2mRZDJkB4lmP@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
 <CAPhsuW4_aYvPJUfCBkMygKPpHx7Y3xPCV7ewLGGAhyztJq3dhA@mail.gmail.com>
 <Y3VlQcsiEi273S+n@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3VlQcsiEi273S+n@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 02:33:37PM -0800, Luis Chamberlain wrote:
> On Tue, Nov 15, 2022 at 02:48:05PM -0800, Song Liu wrote:
> > On Tue, Nov 15, 2022 at 1:09 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Nov 14, 2022 at 05:30:39PM -0800, Song Liu wrote:
> > > > On Mon, Nov 7, 2022 at 2:41 PM Song Liu <song@kernel.org> wrote:
> > >
> > > > Currently, I have got the following action items for v3:
> > > > 1. Add unify API to allocate text memory to motivation;
> > > > 2. Update Documentation/x86/x86_64/mm.rst;
> > > > 3. Allow none PMD_SIZE allocation for powerpc.
> > >
> > > - I am really exausted of asking again for real performance tests,
> > >   you keep saying you can't and I keep saying you can, you are not
> > >   trying hard enough. Stop thinking about your internal benchmark which
> > >   you cannot publish. There should be enough crap out which you can use.
> > >
> > > - A new selftest or set of selftests which demonstrates gain in
> > >   performance
> > 
> > I didn't mean to not show the result with publically available. I just
> > thought the actual benchmark was better (and we do use that to
> > demonstrate the benefit of a lot of kernel improvement).
> > 
> > For something publically available, how about the following:
> > 
> > Run 100 instances of the following benchmark from bpf selftests:
> >   tools/testing/selftests/bpf/bench -w2 -d100 -a trig-kprobe
> > which loads 7 BPF programs, and triggers one of them.
> > 
> > Then use perf to monitor TLB related counters:
> >    perf stat -e iTLB-load-misses,itlb_misses.walk_completed_4k, \
> >         itlb_misses.walk_completed_2m_4m -a
> > 
> > The following results are from a qemu VM with 32 cores.
> > 
> > Before bpf_prog_pack:
> >   iTLB-load-misses: 350k/s
> >   itlb_misses.walk_completed_4k: 90k/s
> >   itlb_misses.walk_completed_2m_4m: 0.1/s
> > 
> > With bpf_prog_pack (current upstream):
> >   iTLB-load-misses: 220k/s
> >   itlb_misses.walk_completed_4k: 68k/s
> >   itlb_misses.walk_completed_2m_4m: 0.2/s
> > 
> > With execmem_alloc (with this set):
> >   iTLB-load-misses: 185k/s
> >   itlb_misses.walk_completed_4k: 58k/s
> >   itlb_misses.walk_completed_2m_4m: 1/s
> > 
> > Do these address your questions with this?
> 
> More in lines with what I was hoping for. Can something just do
> the parallelization for you in one shot? Can bench alone do it for you?
> Is there no interest to have soemthing which generically showcases
> multithreading / hammering a system with tons of eBPF JITs? It may
> prove useful.
> 
> And also, it begs the question, what if you had another iTLB generic
> benchmark or genearl memory pressure workload running *as* you run the
> above? I as, as it was my understanding that one of the issues was the
> long term slowdown caused by the directmap fragmentation without
> bpf_prog_pack, and so such an application should crawl to its knees
> over time, and there should be numbers you could show to prove that
> too, before and after.

I'd add to that that benchmarking iTLB performance on an idle system is not
very representative. TLB is a scarce resource, so it'd be interesting to
see this benchmark on a loaded system.
 
>   Luis

-- 
Sincerely yours,
Mike.
