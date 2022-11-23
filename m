Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9662E634B9C
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 01:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiKWAVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 19:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiKWAVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 19:21:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3C657C7
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 16:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pd+25MOcEBa6BTLcWKHKe4c3vNBvKTJUSLm+Yoc6U3Q=; b=zeczRMfIiC88MKOSQAQW7sPODk
        yE2NSHy9RAH8XciZMhU0uGCN6eueFzwqeDRWR8jnr/zUYCgQnHf+bQEX7wAYfjfn74g+MszhIU9eh
        sTwnRPN7pKcCJCqX9E+ukPjT6m1LkPdlWILRdI+jEBOjRs5t3Fh8CPcy2rRSfLZbitPDqGQK62QU9
        IuRYLN7sEvhjyixWvj6rBxUF0UEYUfh2RHUFjy4AHzrIPpM8ACaSViPxBKGAZIZSiTsOtOmKxS0CJ
        TuOxk46xLnnLDVcxdsopGm3Kw/2EN0S4hUCXewm0VkgIIZgcK0G6smBbREJd9QFdsYKv74n871Z3B
        lYqw9Stw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxdVx-00CRG1-RF; Wed, 23 Nov 2022 00:21:21 +0000
Date:   Tue, 22 Nov 2022 16:21:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tglx@linutronix.de
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, rppt@kernel.org, willy@infradead.org,
        dave@stgolabs.net, a.manzanares@samsung.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        anton@ozlabs.org, colin.i.king@gmail.com
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
Message-ID: <Y31ngcvzHCzWTg1f@bombadil.infradead.org>
References: <20221117202322.944661-1-song@kernel.org>
 <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
 <CAPhsuW7AfwpV6G8U7VRXMcjBEUf7OCOY5eR7eagEoXVK-AmBRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7AfwpV6G8U7VRXMcjBEUf7OCOY5eR7eagEoXVK-AmBRg@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 07:28:36PM -0700, Song Liu wrote:
> On Mon, Nov 21, 2022 at 1:12 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Thu, Nov 17, 2022 at 12:23:16PM -0800, Song Liu wrote:
> > > This patchset tries to address the following issues:
> > >
> > > Based on our experiments [5], we measured ~0.6% performance improvement
> > > from bpf_prog_pack. This patchset further boosts the improvement to ~0.8%.
> >
> > I'd prefer we leave out arbitrary performance data, as it does not help much.
> 
> This really bothers me. With real workload, we are talking about performance
> difference of ~1%. I don't think there is any open source benchmark that can
> show this level of performance difference.

I *highly* doubt that.

> In our case, we used A/B test with 80 hosts (40 vs. 40) and runs for
> many hours to confidently show 1% performance difference. This exact
> benchmark has a very good record of reporting smallish performance
> regression.

As per wikipedia, "A/B tests are useful for understanding user
engagement and satisfaction of online features like a new feature or
product". Let us disregards what is going on with user experience and
consider evaluating the performance instead of what goes on behind the
scenes.

> For example, this commit
> 
>   commit 7af0145067bc ("x86/mm/cpa: Avoid the 4k pages check completely")
> 
> fixes a bug that splits the page table (from 2MB to 4kB) for the WHOLE kernel
> text. The bug stayed in the kernel for almost a year. None of all the available
> open source benchmark had caught it before this specific benchmark.

That doesn't mean enterpise level testing would not have caught it, and
enteprise kernels run on ancient kernels so they would not catch up that
fast. RHEL uses even more ancient kernels than SUSE so let's consider
where SUSE was during this regression. The commit you mentioned the fix
7af0145067bc went upstream on v5.3-rc7~4^2, and that was in August 2019.
The bug was introduced through commit 585948f4f695 ("x86/mm/cpa: Avoid
the 4k pages check completely") and that was on v4.20-rc1~159^2~41
around September 2018. Around September 2018, the time the regression was
committed, the most bleeding edge Enterprise Linux kernel in the industry was
that on SLE15 and so v4.12 and so there is no way in hell the performance
team at SUSE for instance would have even come close to evaluating code with
that regression. In fact, they wouldn't come accross it in testing until
SLE15-SP2 on the v5.3 kernel but by then the regression would have been fixed.

Yes, 0-day does *some* performance testing, but it does not do any
justice the monumental effort that goes into performance testing at
Enterprise Linux distributions. The gap that leaves perhaps should be
solved in the community long term however that that's a separate problem.

But to suggest that there is *nothing* like what you have, is probably
pretty innacurate.

> We have used this benchmark to demonstrate performance benefits of many
> optimizations. I don't understand why it suddenly becomes "arbitrary
> performance data".

It's because typically you'd want a benchmark you can reproduce something with,
and some "A/B testing" reference really doesn't help future developers who are
evaluating performance regressions, or who would want to provide critical
feedback to you on things you may have overlooked when selling a generic
performance improvement into the kernel.

  Luis
