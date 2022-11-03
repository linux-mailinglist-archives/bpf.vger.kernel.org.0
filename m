Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC89618ABC
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiKCVmC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKCVl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B791B9DE
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23A761FEF
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D9CC43143
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667511716;
        bh=uPVjPd0sItmgKWcb/4J3iPNbrhCvC78j4JnZd3nbd0I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ULRJtokjPQ2GKq5DvEh3OyRPqVhAio8Kyu4OAfaBTlnm0rfsDAIsCajH2lXUoJtAS
         whaqhuIGNu9tv865DpSOadiD1upiBX24066iRjBkGo9Xa0fEfjnYvBDjFZC3dHZJky
         2uVqeqRq/QuVh/5BhfoX0e2K0gR4ZaZj7KfoAwk1IhTt5bYDdTtgrbzHvvVLYk47Bv
         e8PMxc2E17i1TfcSyqK+wXVXxakOPwuzff/yjWQ8O4RGFrEc3m+tU6YWUu5vkC8A0e
         8xaCHaOv/w/LrruWmdj2ai2qZMmvVifqxIHtWSHR1QZvgG5fjHMAFXPwKFYCu73sAk
         Y5k4ghGKDaVRA==
Received: by mail-ej1-f52.google.com with SMTP id b2so8799321eja.6
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 14:41:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf3iZJHxHSO88Dg8qOIBO6JlkuFth8ZO2TzYO9i7UtXoL3E3VNl3
        l4w9gWXu8+R6kyksULzf2RYkto2HEOC6h2U8JFA=
X-Google-Smtp-Source: AMsMyM4DDn//BJ3YNxX1pJr0cEile6DXy2QBs9oTdcL26TvcAWsYoPn7YIyNSIIF+3OjWXZde6/KWYhHN9kOuRwi7gc=
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id
 vl2-20020a170907b60200b007ade82c3355mr17874916ejc.3.1667511714445; Thu, 03
 Nov 2022 14:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221031222541.1773452-1-song@kernel.org> <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org> <Y2Pjnd3mxA9fTlox@kernel.org>
 <Y2QPpODzdP+2YSMN@bombadil.infradead.org> <eac58f163bd8b6829dff176e67b44c79570025f5.camel@intel.com>
In-Reply-To: <eac58f163bd8b6829dff176e67b44c79570025f5.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 3 Nov 2022 14:41:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4sYOzdkzpX5=5FBs3dF2DiXyNvRQC0jHnrMQFy5-mUhg@mail.gmail.com>
Message-ID: <CAPhsuW4sYOzdkzpX5=5FBs3dF2DiXyNvRQC0jHnrMQFy5-mUhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 2:19 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2022-11-03 at 11:59 -0700, Luis Chamberlain wrote:
> > > > Mike Rapoport had presented about the Direct map fragmentation
> > > > problem
> > > > at Plumbers 2021 [0], and clearly mentioned modules / BPF /
> > > > ftrace /
> > > > kprobes as possible sources for this. Then Xing Zhengjun's 2021
> > > > performance
> > > > evaluation on whether using 2M/1G pages aggressively for the
> > > > kernel direct map
> > > > help performance [1] ends up generally recommending huge pages.
> > > > The work by Xing
> > > > though was about using huge pages *alone*, not using a strategy
> > > > such as in the
> > > > "bpf prog pack" to share one 2 MiB huge page for *all* small eBPF
> > > > programs,
> > > > and that I think is the real golden nugget here.
> > > >
> > > > I contend therefore that the theoretical reduction of iTLB misses
> > > > by using
> > > > huge pages for "bpf prog pack" is not what gets your systems to
> > > > perform
> > > > somehow better. It should be simply that it reduces fragmentation
> > > > and
> > > > *this* generally can help with performance long term. If this is
> > > > accurate
> > > > then let's please separate the two aspects to this.
> > >
> > > The direct map fragmentation is the reason for higher TLB miss
> > > rate, both
> > > for iTLB and dTLB.
> >
> > OK so then whatever benchmark is running in tandem as eBPF JIT is
> > hammered
> > should *also* be measured with perf for iTLB and dTLB. ie, the patch
> > can
> > provide such results as a justifications.
>
> Song had done some tests on the old prog pack version that to me seemed
> to indicate most (or possibly all) of the benefit was direct map
> fragmentation reduction. This was surprised me, since 2MB kernel text
> has shown to be beneficial.
>
> Otherwise +1 to all these comments. This should be clear about what the
> benefits are. I would add, that this is also much nicer about TLB
> shootdowns than the existing way of loading text and saves some memory.
>
> So I think there are sort of four areas of improvements:
> 1. Direct map fragmentation reduction (dTLB miss improvements). This
> sort of does it as a side effect in this series, and the solution Mike
> is talking about is a more general, probably better one.
> 2. 2MB mapped JITs. This is the iTLB side. I think this is a decent
> solution for this, but surprisingly it doesn't seem to be useful for
> JITs. (modules testing TBD)
> 3. Loading text to reused allocation with per-cpu mappings. This
> reduces TLB shootdowns, which are a short term load and teardown time
> performance drag. My understanding is this is more of a problem on
> bigger systems with many CPUs. This series does a decent job at this,
> but the solution is not compatible with modules. Maybe ok since modules
> don't load as often as JITs.
> 4. Having BPF progs share pages. This saves memory. This series could
> probably easily get a number for how much.
>

Hi Luis, Rick, and Mike,

Thanks a lot for helping me organize this information. Totally agree with
all these comments. I will add more data to the next revision.

Besides the motivation improvement, could you please also share your
comments on:
1. The logic/design of the vmalloc_exec() et. al. APIs;
2. The naming of these functions. Does  execmem_[alloc|free|fill|cpy]
  (as suggested by Chritoph) sound good?

Thanks,
Song
