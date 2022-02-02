Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7F24A76BB
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 18:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbiBBRVv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 12:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiBBRVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 12:21:50 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB4C061714;
        Wed,  2 Feb 2022 09:21:50 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c188so26341724iof.6;
        Wed, 02 Feb 2022 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2sPZoZLZM5UNrXAdt0vEGZKUq7ufDiPN15k+FUCD3A=;
        b=VLTC/554KF+q9bgKU1U6wDk+hmnzrF6ZoVq4Bf7ZlndAgARDnL2c8QzETPocCT4PN1
         UjuwQc0vi3MAzFCrIu7LTq/y52x7QUE2iYFmW1Es3s1jfqJK3Dktso9FuyiicOsiSkyR
         9hQrNQ97lvJ9n0KZ4aiOs7pTqwsIUTfxMI82C/LvFYfibkttKGHoGumYINRKhwOJFF1o
         PCmoqdFudQF/VaiciXZiQGUvsUdUPcFFDvO+6OD891ceTiw+DBodl1/Z+2rUzyxlAil9
         KoYEF6OAqjUP0/tcERKZ+w/jy5FDRQ8FXZADM1K0nM5PgMdD2VRfHnOE03wF4nXJYa1S
         LpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2sPZoZLZM5UNrXAdt0vEGZKUq7ufDiPN15k+FUCD3A=;
        b=1EX6JIeLPqrOVS8GGXpHee384ZQenG8BEWcC5w9uIeFyhsi6eVCHYZ5ClLdXyCoAj6
         2gC7ej1oqs2nADPEyWMMQV5xL7juIL+FrU5CezD/ul+KeajRgnpbWXnCTHNK8vUOagiK
         I9ob5jIaR7tD2scnCstK6LFbax4D4LI2EgovBdPKT6y16mmkU7DoOY5ytpVFa/OfBX+I
         tt0QDBZ6qnpApYdcgPYUSUbje/iEIJ7+nenLKJdOu3GNFfyi36vG0Ms75mtBbUHYXGA7
         S2cU7HtaPEk92tLQtwkfTaOlTu1Npj3gMj7GR30NBOwoxKvHomkTvCsl0SLnK/UJNv3Q
         frlg==
X-Gm-Message-State: AOAM533zmLeWkLqSaNKDc+TjzmJnKKc0TuGFLa2f8ynE0svj+DaZfkiF
        OZECF2lwDE3D3OZwOXDx/2dW5iuGXbJiWs5W2pM=
X-Google-Smtp-Source: ABdhPJxDSFxnMdpWOtS6mzv79l9BNzJJ311pt8zNnyjheH9nSQ9ORXSdhmSd3Fo7+5H34nAslT/8RCwWsVfRw4vblEQ=
X-Received: by 2002:a5d:88c1:: with SMTP id i1mr7185749iol.154.1643822510158;
 Wed, 02 Feb 2022 09:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20220123221932.537060-1-jolsa@kernel.org> <CAEf4BzZj7awfwi-JoAB=aahxVF8p6FKhgu4OKpyY_pjePy75ig@mail.gmail.com>
 <CAEf4BzZrggU7Ym7bucvjG7K+AmtxhD8UGCMPqXdpL3stUhpOEg@mail.gmail.com> <YfpYKri5i+Go9DlU@kernel.org>
In-Reply-To: <YfpYKri5i+Go9DlU@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Feb 2022 09:21:38 -0800
Message-ID: <CAEf4BzZCOF535S=xiYuUdRbahrQ_C7knetu0_ZrRS6-gyvvYpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 2, 2022 at 2:08 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Feb 01, 2022 at 05:01:38PM -0800, Andrii Nakryiko escreveu:
> > On Mon, Jan 24, 2022 at 12:24 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, Jan 23, 2022 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > Removing code for ebpf program prologue generation.
> > > >
> > > > The prologue code was used to get data for extra arguments specified
> > > > in program section name, like:
> > > >
> > > >   SEC("lock_page=__lock_page page->flags")
> > > >   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
> > > >   {
> > > >          return 1;
> > > >   }
> > > >
> > > > This code is using deprecated libbpf API and blocks its removal.
> > > >
> > > > This feature was not documented and broken for some time without
> > > > anyone complaining, also original authors are not responding,
> > > > so I'm removing it.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/perf/Makefile.config     |  11 -
> > > >  tools/perf/builtin-record.c    |  14 -
> > > >  tools/perf/util/bpf-loader.c   | 242 +---------------
> > > >  tools/perf/util/bpf-prologue.c | 508 ---------------------------------
> > > >  tools/perf/util/bpf-prologue.h |  37 ---
> > > >  5 files changed, 1 insertion(+), 811 deletions(-)
> > >
> > > Love the stats! Thanks for taking this on!
> > >
> >
> > Hi,
> >
> > Was this ever applied? If not, are there any blockers? I assume this
> > will go through the perf tree, right?
>
> I'll go thru it today.

Great, thank you!

>
> > > >  delete mode 100644 tools/perf/util/bpf-prologue.c
> > > >  delete mode 100644 tools/perf/util/bpf-prologue.h
> > > >
> > >
> > > [...]
>
> --
>
> - Arnaldo
