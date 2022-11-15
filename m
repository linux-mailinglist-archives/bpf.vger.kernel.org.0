Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9387B62AE97
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiKOWtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiKOWso (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:48:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDFD1EC4E
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:48:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61FC5B81B8E
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 22:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AADC433B5
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668552500;
        bh=wQL+xHNCPKSUFwCdVx1cMXkXXK9eEwbzs4XS2WDmu18=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OUZ1hFQqxemfvGC/Y++tHo/zhL4a9JbeqDi4IK5KekndFpWHw3XEz0p8e1Pj3htE0
         nrpNpFyG3XzCyfpvMSS87w/d8CbnfalYsrxnLOBdOunCMg0R3fieGFNmYxcfttjc2N
         LipCZ/Vx0cTZoYHultkkA4MP+ew46kqRQwJG5tCRfmB8L0nQhKsLhm2e5eZPjO2yvn
         LXmkhHXOJ+tfBXmZmtErexfvKb5rZiqecN5vru0Y+6ZqZjgibnMGL0rJ4Xpy7qYhuB
         1GZ6HIFtaeWkn1GXjw2uqjFTl8juOW/h/p6SrJddFBf9upKaKC5rx0r7bZu2o4+o8C
         3Pkik1y91rVSA==
Received: by mail-ej1-f45.google.com with SMTP id f18so6876259ejz.5
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:48:19 -0800 (PST)
X-Gm-Message-State: ANoB5pkw/vBkFVM/LOucs9bOeeVExXHg8hyBt+iWaEH+FJMrBz+O/Nt8
        op6vbziSth8juyYd8dS6Quv9QCXedxfqv7eqgCc=
X-Google-Smtp-Source: AA0mqf5itU5yMzDGNj0IZlY//SCl9lKN9pPcDJZXZ+RL9AYOiWjStFmK2GvbGS0LSSCv+wKJFwyY8DyuUP5yKVPQcU0=
X-Received: by 2002:a17:907:9618:b0:78e:17ad:ba62 with SMTP id
 gb24-20020a170907961800b0078e17adba62mr15611407ejc.719.1668552498267; Tue, 15
 Nov 2022 14:48:18 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
In-Reply-To: <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 15 Nov 2022 14:48:05 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4_aYvPJUfCBkMygKPpHx7Y3xPCV7ewLGGAhyztJq3dhA@mail.gmail.com>
Message-ID: <CAPhsuW4_aYvPJUfCBkMygKPpHx7Y3xPCV7ewLGGAhyztJq3dhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 1:09 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Nov 14, 2022 at 05:30:39PM -0800, Song Liu wrote:
> > On Mon, Nov 7, 2022 at 2:41 PM Song Liu <song@kernel.org> wrote:
> > >
> >
> > [...]
> >
> > >
> > >
> > > This set enables bpf programs and bpf dispatchers to share huge pages with
> > > new API:
> > >   execmem_alloc()
> > >   execmem_alloc()
> > >   execmem_fill()
> > >
> > > The idea is similar to Peter's suggestion in [1].
> > >
> > > execmem_alloc() manages a set of PMD_SIZE RO+X memory, and allocates these
> > > memory to its users. execmem_alloc() is used to free memory allocated by
> > > execmem_alloc(). execmem_fill() is used to update memory allocated by
> > > execmem_alloc().
> >
> > Sigh, I just realized this thread made through linux-mm@kvack.org, but got
> > dropped by bpf@vger.kernel.org, so I guess I will have to resend v3.
>
> I don't know what is going on with the bpf list but whatever it is, is silly.
> You should Cc the right folks to ensure proper review if the bpf list is
> the issue.
>
> > Currently, I have got the following action items for v3:
> > 1. Add unify API to allocate text memory to motivation;
> > 2. Update Documentation/x86/x86_64/mm.rst;
> > 3. Allow none PMD_SIZE allocation for powerpc.
>
> - I am really exausted of asking again for real performance tests,
>   you keep saying you can't and I keep saying you can, you are not
>   trying hard enough. Stop thinking about your internal benchmark which
>   you cannot publish. There should be enough crap out which you can use.
>
> - A new selftest or set of selftests which demonstrates gain in
>   performance

I didn't mean to not show the result with publically available. I just
thought the actual benchmark was better (and we do use that to
demonstrate the benefit of a lot of kernel improvement).

For something publically available, how about the following:

Run 100 instances of the following benchmark from bpf selftests:
  tools/testing/selftests/bpf/bench -w2 -d100 -a trig-kprobe
which loads 7 BPF programs, and triggers one of them.

Then use perf to monitor TLB related counters:
   perf stat -e iTLB-load-misses,itlb_misses.walk_completed_4k, \
        itlb_misses.walk_completed_2m_4m -a

The following results are from a qemu VM with 32 cores.

Before bpf_prog_pack:
  iTLB-load-misses: 350k/s
  itlb_misses.walk_completed_4k: 90k/s
  itlb_misses.walk_completed_2m_4m: 0.1/s

With bpf_prog_pack (current upstream):
  iTLB-load-misses: 220k/s
  itlb_misses.walk_completed_4k: 68k/s
  itlb_misses.walk_completed_2m_4m: 0.2/s

With execmem_alloc (with this set):
  iTLB-load-misses: 185k/s
  itlb_misses.walk_completed_4k: 58k/s
  itlb_misses.walk_completed_2m_4m: 1/s

Do these address your questions with this?

>
> - Extensions maybe of lib/test_vmalloc.c or whatever is appropriate to
>   test correctness

I will look into this.

>
> - Enhance commit logs to justify the *why*, one of which to hightight is
>   providing an API for memory semantics for special memory pages

And this.

Thanks,
Song
