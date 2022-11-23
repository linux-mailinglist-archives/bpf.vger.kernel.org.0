Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26223634F58
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 06:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiKWFG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 00:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiKWFGZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 00:06:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A46EC0B0
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 21:06:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41F65B81DDC
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 05:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE35C433D7
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 05:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669179980;
        bh=O4jIPKjX8zO2QrLdMksoGMkyroHs39gxJnL57+Leomc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VviiLUdtsfwu9SVookseXwMECfGrNZ64QR51KpttsIsf7F/8Iy7e28gz9w59OKIgs
         crKXKBb+c30S95rO+A0t3UvT/Xx0PoKFKdYlsHXeR0vJDdLOxPVmMXBNU7GfvnIjtQ
         TSVXzRtFfBEVTwjYYOQtlr7ANA8FPEk2M219TlWwLcjbQ/tOG47w6eOCxfNmHa4u48
         I9LZLWrOnGSkfWOjcNAXyz/WiOF6L8eOluq8phOX4eR18CTnugaXe/2ke920qUjTSY
         CYyIkYV8zV0F62lbzb6HbZkVcIhehYRS2/gmD+GAWt0HLXdLTWyVEOw9v+C4L0hZir
         KlPuk93n4WKAg==
Received: by mail-ed1-f50.google.com with SMTP id z18so23369556edb.9
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 21:06:20 -0800 (PST)
X-Gm-Message-State: ANoB5pmLPcJr+d3IfkT8GJsXHGtZkeaSnPyzV5w4K6lEU2J2mUgiXsLB
        8pBBvjBw0UdHu8Y+QYY9SyvpJLkhikkhKq/G8HA=
X-Google-Smtp-Source: AA0mqf7qL32TgGBOgG2llkn1dXwMX1gnwrTepydbLcHeer3fdtpVADebyuZXuRTg94IPlrluO+C94wXx4GwYxJpHpc0=
X-Received: by 2002:a05:6402:184b:b0:46a:2692:76e7 with SMTP id
 v11-20020a056402184b00b0046a269276e7mr1747367edy.387.1669179979029; Tue, 22
 Nov 2022 21:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20221117202322.944661-1-song@kernel.org> <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
 <CAPhsuW7AfwpV6G8U7VRXMcjBEUf7OCOY5eR7eagEoXVK-AmBRg@mail.gmail.com> <Y31ngcvzHCzWTg1f@bombadil.infradead.org>
In-Reply-To: <Y31ngcvzHCzWTg1f@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 22 Nov 2022 22:06:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5g02Ahub+OX5WomzP24E74-T4K_x8pr1rkiC3uba2QBw@mail.gmail.com>
Message-ID: <CAPhsuW5g02Ahub+OX5WomzP24E74-T4K_x8pr1rkiC3uba2QBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tglx@linutronix.de, bpf@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, x86@kernel.org, peterz@infradead.org,
        hch@lst.de, rick.p.edgecombe@intel.com, rppt@kernel.org,
        willy@infradead.org, dave@stgolabs.net, a.manzanares@samsung.com,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        anton@ozlabs.org, colin.i.king@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 22, 2022 at 5:21 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Nov 21, 2022 at 07:28:36PM -0700, Song Liu wrote:
> > On Mon, Nov 21, 2022 at 1:12 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
[...]
> > fixes a bug that splits the page table (from 2MB to 4kB) for the WHOLE kernel
> > text. The bug stayed in the kernel for almost a year. None of all the available
> > open source benchmark had caught it before this specific benchmark.
>
> That doesn't mean enterpise level testing would not have caught it, and
> enteprise kernels run on ancient kernels so they would not catch up that
> fast. RHEL uses even more ancient kernels than SUSE so let's consider
> where SUSE was during this regression. The commit you mentioned the fix
> 7af0145067bc went upstream on v5.3-rc7~4^2, and that was in August 2019.
> The bug was introduced through commit 585948f4f695 ("x86/mm/cpa: Avoid
> the 4k pages check completely") and that was on v4.20-rc1~159^2~41
> around September 2018. Around September 2018, the time the regression was
> committed, the most bleeding edge Enterprise Linux kernel in the industry was
> that on SLE15 and so v4.12 and so there is no way in hell the performance
> team at SUSE for instance would have even come close to evaluating code with
> that regression. In fact, they wouldn't come accross it in testing until
> SLE15-SP2 on the v5.3 kernel but by then the regression would have been fixed.

Can you refer me to one enterprise performance report with open source
benchmark that shows ~1% performance regression? If it is available, I am
more than happy to try it out. Note that, we need some BPF programs to show
the benefit of this set. In most production hosts, network related BPF programs
are the busiest. Therefore, single host benchmarks will not show the benefit.

Thanks,
Song

PS: Data in [1] if full of noise:

"""
2. For each benchmark/system combination, the 1G mapping had the highest
performance for 45% of the tests, 2M for ~30%, and 4k for~20%.

3. From the average delta, among 1G/2M/4K, 4K gets the lowest
performance in all the 4 test machines, while 1G gets the best
performance on 2 test machines and 2M gets the best performance on the
other 2 machines.
"""

There is no way we can get consistent result of 1% performance improvement
from experiments like those.


[1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/
