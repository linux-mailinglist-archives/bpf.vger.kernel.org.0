Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161E3232807
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 01:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgG2XYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 19:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgG2XYm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 19:24:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F6C0619D4
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 16:24:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so3126296wmc.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 16:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Vid/bDwyKAx4BwcecnBtz+573/IH5tF8O95k6nel7Q=;
        b=wGuLColHUeEnR/+pnRTEHr+CehDViADj2T/7m0JQzD4OJ25qpDd0Frb0QO7pXd+4MU
         oR8iEDFQravsltjXVqqQgfGLvIkBjls1WV1pB9dSo0qloTLnQ7M9lhTTF905On1xmQcw
         Z4khFbpFIW+8sEpWGmbWDSYlxTtlEGBHqQL4SvKVGjt8bQWmDVT6vRHpulidLrsrChMg
         3ON13gdAKqV96e3I7vUrspej3hskaAOvJYiCqEzBik+XeWWcge5IqPz2OBWzl9drgseE
         RNXiYCZRrSu9tVGJNJgnqSTVe7CBzvV/Tqgxd0DfeQw/mWAj7r6++2taGt2rBI8TOgbj
         e+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Vid/bDwyKAx4BwcecnBtz+573/IH5tF8O95k6nel7Q=;
        b=KqoBlbfZdV8Q7M+DiLDN+FS2DNhXIAslTqNubP6+51gMfruDD50mtYBH/fFzWqUWSW
         4QfvGpZdPQBBdYGyPO+TPWHrZP5BaefJNKe2zdXCU4Bvbra88kontI6J3kOWb5mxF2ZD
         6Uk179YWktBSQJuVT2nwfmJflhPmy72dtn5bN29e8NGYRFjsEZqQ/TFivKdQMjnTt3y+
         n2DfQ9yVxHd7smcWxAYDOjNvOloA1DY3zRul9UEPgTxOlsJwjYZqSZyl7VnsUaxU15DS
         Ya3yqxqJm2ov9mqixRWq632Oa8/SPVMpm/5kA4lBdyemfqzyq0lxthLaq2D+x8C1p3qg
         Wltw==
X-Gm-Message-State: AOAM531QWrb8R+W48cVzhJ4E84gM35NnDq9hCpXZu57DimWnjVo6YyA/
        IhdlfUOuyFPJdo1iEIIlsDh1365GB6N2hJTE652uyA==
X-Google-Smtp-Source: ABdhPJyOuua7jlIFxpN/h+EHbIiE+S3oPLKPPuDHHT6GbYoawNV8FbDgzCDPHGbBm+BMUS9rJoIcmqcspMYdpR7fDGU=
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr10474653wme.58.1596065080650;
 Wed, 29 Jul 2020 16:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com> <20200728085734.609930-3-irogers@google.com>
 <20200728155940.GC1319041@krava> <20200728160954.GD1319041@krava>
In-Reply-To: <20200728160954.GD1319041@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jul 2020 16:24:28 -0700
Message-ID: <CAP-5=fVqto0LrwgW6dHQupp7jFA3wToRBonBaXXQW4wwYcTreg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] perf record: Prevent override of
 attr->sample_period for libpfm4 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 9:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jul 28, 2020 at 05:59:46PM +0200, Jiri Olsa wrote:
> > On Tue, Jul 28, 2020 at 01:57:31AM -0700, Ian Rogers wrote:
> > > From: Stephane Eranian <eranian@google.com>
> > >
> > > Before:
> > > $ perf record -c 10000 --pfm-events=cycles:period=77777
> > >
> > > Would yield a cycles event with period=10000, instead of 77777.
> > >
> > > This was due to an ordering issue between libpfm4 parsing
> > > the event string and perf record initializing the event.
> > >
> > > This patch fixes the problem by preventing override for
> > > events with attr->sample_period != 0 by the time
> > > perf_evsel__config() is invoked. This seems to have been the
> > > intent of the author.
> > >
> > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evsel.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 811f538f7d77..8afc24e2ec52 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -976,8 +976,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
> > >      * We default some events to have a default interval. But keep
> > >      * it a weak assumption overridable by the user.
> > >      */
> > > -   if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
> > > -                                opts->user_interval != ULLONG_MAX)) {
> > > +   if (!attr->sample_period) {
> >
> > I was wondering why this wouldn't break record/top
> > but we take care of the via record_opts__config
> >
> > as long as 'perf test attr' works it looks ok to me
>
> hum ;-)
>
> [jolsa@krava perf]$ sudo ./perf test 17 -v
> 17: Setup struct perf_event_attr                          :
> ...
> running './tests/attr/test-record-C0'
> expected sample_period=4000, got 3000
> FAILED './tests/attr/test-record-C0' - match failure

I'm not able to reproduce this. Do you have a build configuration or
something else to look at? The test doesn't seem obviously connected
with this patch.

Thanks,
Ian

> jirka
>
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > thanks,
> > jirka
>
