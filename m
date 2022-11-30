Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1533563D284
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 10:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiK3Jxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 04:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiK3Jxd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 04:53:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6773621810
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 01:53:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9FA5FCE1847
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 09:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030EEC433D6;
        Wed, 30 Nov 2022 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669802008;
        bh=8LDAH5jowxJdqYzypcXmz8TIH3y51pjOj93bPJGjblc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlIjuvV5EafTOoAIfX60xMoCjWT7vKPKVPwGMDrj8m4otGJoxz1Kbi/ZwjtxmU5Dk
         FWgtEnIY20plDJPmPBa5Ekf+owWSA9n7WD38DywXpuxpX6w+fFEq0ZT/2SUw+f8FiN
         qPDeIAZZGMBTCYgcxBZD8MlXE8azTO1maWV88badkcqZMt3nDU12Ms6bR8jPlsjiXA
         uRZhrt9w4FmKUPnXc5Odv55zVe49ozFlAiHA4/GGXDnUNSs8wey86sWdmF513BIVVE
         VIj17/Ym3L4UW4bZGuawYM/D2ALlLNGCdtC35KcYDEo05lJgxMJ0n8LriarKG0B3C/
         yB4LnfBvtinnA==
Date:   Wed, 30 Nov 2022 11:53:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tglx@linutronix.de, bpf@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, x86@kernel.org, peterz@infradead.org,
        hch@lst.de, rick.p.edgecombe@intel.com, willy@infradead.org,
        dave@stgolabs.net, a.manzanares@samsung.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        anton@ozlabs.org, colin.i.king@gmail.com
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
Message-ID: <Y4coBTe08HiZFMFC@kernel.org>
References: <20221117202322.944661-1-song@kernel.org>
 <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
 <CAPhsuW7AfwpV6G8U7VRXMcjBEUf7OCOY5eR7eagEoXVK-AmBRg@mail.gmail.com>
 <Y31ngcvzHCzWTg1f@bombadil.infradead.org>
 <CAPhsuW5g02Ahub+OX5WomzP24E74-T4K_x8pr1rkiC3uba2QBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5g02Ahub+OX5WomzP24E74-T4K_x8pr1rkiC3uba2QBw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 22, 2022 at 10:06:06PM -0700, Song Liu wrote:
> On Tue, Nov 22, 2022 at 5:21 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Nov 21, 2022 at 07:28:36PM -0700, Song Liu wrote:
> > > On Mon, Nov 21, 2022 at 1:12 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> [...]
> > > fixes a bug that splits the page table (from 2MB to 4kB) for the WHOLE kernel
> > > text. The bug stayed in the kernel for almost a year. None of all the available
> > > open source benchmark had caught it before this specific benchmark.
> >
> > That doesn't mean enterpise level testing would not have caught it, and
> > enteprise kernels run on ancient kernels so they would not catch up that
> > fast. RHEL uses even more ancient kernels than SUSE so let's consider
> > where SUSE was during this regression. The commit you mentioned the fix
> > 7af0145067bc went upstream on v5.3-rc7~4^2, and that was in August 2019.
> > The bug was introduced through commit 585948f4f695 ("x86/mm/cpa: Avoid
> > the 4k pages check completely") and that was on v4.20-rc1~159^2~41
> > around September 2018. Around September 2018, the time the regression was
> > committed, the most bleeding edge Enterprise Linux kernel in the industry was
> > that on SLE15 and so v4.12 and so there is no way in hell the performance
> > team at SUSE for instance would have even come close to evaluating code with
> > that regression. In fact, they wouldn't come accross it in testing until
> > SLE15-SP2 on the v5.3 kernel but by then the regression would have been fixed.
> 
> Can you refer me to one enterprise performance report with open source
> benchmark that shows ~1% performance regression? If it is available, I am
> more than happy to try it out. Note that, we need some BPF programs to show
> the benefit of this set. In most production hosts, network related BPF programs
> are the busiest. Therefore, single host benchmarks will not show the benefit.
> 
> Thanks,
> Song
> 
> PS: Data in [1] if full of noise:
> 
> """
> 2. For each benchmark/system combination, the 1G mapping had the highest
> performance for 45% of the tests, 2M for ~30%, and 4k for~20%.
> 
> 3. From the average delta, among 1G/2M/4K, 4K gets the lowest
> performance in all the 4 test machines, while 1G gets the best
> performance on 2 test machines and 2M gets the best performance on the
> other 2 machines.
> """

I don't think it's noise. IMO, this means that performance degradation
caused by the fragmentation of the direct map highly depends on workload
and microarchitecture.
 
> There is no way we can get consistent result of 1% performance improvement
> from experiments like those.

Experiments like those show how a change in the kernel behaviour affects
different workloads and not a single benchmark. Having a performance
improvement in a single benchmark does necessarily not mean other
benchmarks won't regress.
 
> [1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

-- 
Sincerely yours,
Mike.
