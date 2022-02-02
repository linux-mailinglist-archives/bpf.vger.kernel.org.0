Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE104A6E61
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 11:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiBBKIs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 05:08:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37764 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiBBKIs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 05:08:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32A21B8306A;
        Wed,  2 Feb 2022 10:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA298C004E1;
        Wed,  2 Feb 2022 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643796526;
        bh=IIDVZd6xhg6IbKtZ7hn0mo9CpKwGO0GZzXu6zIWWUuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXyTvIbeQus088m8DJUWfdrOTMtXiau/N40xSfaraPhhbzauYgkC30Ne383DsiAaI
         Zt7WEywKQrPxDAY3C2U9miaKco+9rQ3ANN6gsUkxJWCNlP6PWwlo0BdtLfSLGNvwjY
         ud0Y5njlfGiOYk8HnNN4cwOu5EVf1KHAmM3XkYCvSVzkHXacSsWYVQJfJcGlA4YUUm
         vysLI7zvZn2d2kAGY6BUFJJoKLeymJcMF27n3UIsBymrRu8hWTw9wV1aABQ/eDUqwc
         RkG59IPjpWmDj2U7qUA4yGptkANS5z++URAqdc5IFpavY+X226xnSiq8IAOUSdJSwC
         u5Md2OlKe69mg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ECA8A40466; Wed,  2 Feb 2022 07:08:42 -0300 (-03)
Date:   Wed, 2 Feb 2022 07:08:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
Message-ID: <YfpYKri5i+Go9DlU@kernel.org>
References: <20220123221932.537060-1-jolsa@kernel.org>
 <CAEf4BzZj7awfwi-JoAB=aahxVF8p6FKhgu4OKpyY_pjePy75ig@mail.gmail.com>
 <CAEf4BzZrggU7Ym7bucvjG7K+AmtxhD8UGCMPqXdpL3stUhpOEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZrggU7Ym7bucvjG7K+AmtxhD8UGCMPqXdpL3stUhpOEg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Feb 01, 2022 at 05:01:38PM -0800, Andrii Nakryiko escreveu:
> On Mon, Jan 24, 2022 at 12:24 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Jan 23, 2022 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > Removing code for ebpf program prologue generation.
> > >
> > > The prologue code was used to get data for extra arguments specified
> > > in program section name, like:
> > >
> > >   SEC("lock_page=__lock_page page->flags")
> > >   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
> > >   {
> > >          return 1;
> > >   }
> > >
> > > This code is using deprecated libbpf API and blocks its removal.
> > >
> > > This feature was not documented and broken for some time without
> > > anyone complaining, also original authors are not responding,
> > > so I'm removing it.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/Makefile.config     |  11 -
> > >  tools/perf/builtin-record.c    |  14 -
> > >  tools/perf/util/bpf-loader.c   | 242 +---------------
> > >  tools/perf/util/bpf-prologue.c | 508 ---------------------------------
> > >  tools/perf/util/bpf-prologue.h |  37 ---
> > >  5 files changed, 1 insertion(+), 811 deletions(-)
> >
> > Love the stats! Thanks for taking this on!
> >
> 
> Hi,
> 
> Was this ever applied? If not, are there any blockers? I assume this
> will go through the perf tree, right?

I'll go thru it today.
 
> > >  delete mode 100644 tools/perf/util/bpf-prologue.c
> > >  delete mode 100644 tools/perf/util/bpf-prologue.h
> > >
> >
> > [...]

-- 

- Arnaldo
