Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B798362D082
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 02:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiKQBRi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 20:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQBRh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 20:17:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2FFDFB1
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 17:17:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D9F62076
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 01:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE862C433B5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 01:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668647855;
        bh=FrsXWqBu4gvIaKhys8LdfsPVwjs8dNFipmoB3pcYAKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BawOxuM2Rn6fTJjYIN1eebmiWe2wwephtklSgC8aV+oj4TRKqjFwwAM5RC0A9gSiP
         U10PdtCNMecSQiSg9TtQpjthvQFlzcrrFah2ZTiLdo/Zmg+GxkpY6Bxt2r+hbyKRaT
         EfBTcrx6yECo77fWZjroePxiCP80fpwORxviTf16lULvA7XUdSlA3+2zyCfFC3SRBE
         /AlqmraEIDc5N5DE5ElHLl+6TjA80VVDRljIiEQAENHk6Ft+BWPut7284yMEmFZJ2V
         qe0KbFNKiI7r2C5HBYu6ONmDiSTh1diDFWM1MTudRWuQtr4njgb+VxADUUb7l/atfb
         o5JV6z8l6A/+A==
Received: by mail-ej1-f48.google.com with SMTP id kt23so1415170ejc.7
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 17:17:35 -0800 (PST)
X-Gm-Message-State: ANoB5plsOrgJHzXkSFYxQizCS6MrIdgY7zBqHj25wZnjkaKW8D2FCwYp
        et1BPyiSj5zaY7lSFeRuT4zoz6haX8BnUY5ZhkU=
X-Google-Smtp-Source: AA0mqf64Y/3xCK9ojAqXcEj6NWPB4yTgygC4UpuRixkfqaiAwD5GI6/j8AfFzMSBzcbg9jjxEIRkyQmX6TUMy2POgBo=
X-Received: by 2002:a17:906:fa06:b0:7ae:72ae:264b with SMTP id
 lo6-20020a170906fa0600b007ae72ae264bmr333150ejb.301.1668647854027; Wed, 16
 Nov 2022 17:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <Y3P/9DXAjKhmoIvm@bombadil.infradead.org> <CAPhsuW4_aYvPJUfCBkMygKPpHx7Y3xPCV7ewLGGAhyztJq3dhA@mail.gmail.com>
 <Y3VlQcsiEi273S+n@bombadil.infradead.org> <cea2f9f81db0a5db9cdc1ed9089454ddbd28541b.camel@intel.com>
 <Y3V4DEUeICDBYt62@bombadil.infradead.org>
In-Reply-To: <Y3V4DEUeICDBYt62@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Nov 2022 17:17:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6KyuQNim4O81WiAeVNsBrtFF9TT9595pP1UsShWFZXLw@mail.gmail.com>
Message-ID: <CAPhsuW6KyuQNim4O81WiAeVNsBrtFF9TT9595pP1UsShWFZXLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 3:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 10:47:04PM +0000, Edgecombe, Rick P wrote:
> > On Wed, 2022-11-16 at 14:33 -0800, Luis Chamberlain wrote:
> > > More in lines with what I was hoping for. Can something just do
> > > the parallelization for you in one shot? Can bench alone do it for
> > > you?
> > > Is there no interest to have soemthing which generically showcases
> > > multithreading / hammering a system with tons of eBPF JITs? It may
> > > prove useful.
> > >
> > > And also, it begs the question, what if you had another iTLB generic
> > > benchmark or genearl memory pressure workload running *as* you run
> > > the
> > > above? I as, as it was my understanding that one of the issues was
> > > the
> > > long term slowdown caused by the directmap fragmentation without
> > > bpf_prog_pack, and so such an application should crawl to its knees
> > > over time, and there should be numbers you could show to prove that
> > > too, before and after.
> >
> > We did have some benchmarks that showed if your direct map was totally
> > fragmented (started from boot at 4k page size) what the regression was:
> >
> >
> > https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/
>
> Oh yes that is a good example of effort, but I'm suggesting taking for
> instance will-it-scale and run it in tandem with bpg prog pack
> and measure on *both* iTLB differences, before / after, *and* doing
> this again after a period of expected deterioation of the direct
> map fragmentation (say after non-bpf-prog-pack shows high direct
> map fragmetnation).
>
> This is the sort of thing which easily go into a commit log.

To be honest, I don't see experimental results with artificial benchmarks
would help this set. I don't think a real workload would see 10% speed
up from this set (we can see large % improvements in TLB miss rate
though). However, 1% or even 0.5% improvement matters a lot for
large scale workload.

Thanks,
Song
