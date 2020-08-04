Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846AD23BD8E
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 17:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgHDPuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHDPup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Aug 2020 11:50:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465EFC061757
        for <bpf@vger.kernel.org>; Tue,  4 Aug 2020 08:50:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so37333828wro.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2020 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+kDmABO3rORHPwyb6sHqLUmmymRS95vgwyEtBMcMyg=;
        b=JFF7QVQyo4djCeIjI0TZsWKm0xy9hl4F2LYNI76B1IfQ9Q8vvUsqaU7dsKDTseMQkb
         xoH3l8HVsLIDwOyqUztd/YG4xE+0KTLgSIgLZ6VxD8vsCOEDpzBv6u2DZeu1nfki81Qk
         eXpBI2cdtpOCpByZO4hPlu0NZYiKnz70NQV9sUY2nN6bw7ZB+Eb/YRSC5emWUNQsDfTR
         sh+ay9Fs6mffL/888Br7Y4R1l337QjRxMqdLcTroxzmmfAvvMAMAB+P4OH54OtO8i1i4
         q/e5+KPxclDydu1TzLbOCekbq9Ykx1W8aVtDxHuyPPBGR3p+IZ84jMuMEkaK6pD+/98/
         vJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+kDmABO3rORHPwyb6sHqLUmmymRS95vgwyEtBMcMyg=;
        b=ErO3vMGS+fp/NvBkYOsmF5YI12S0IjYnRKN+00csDCAhZowo2yK4hgKfJM2nOJAfNj
         2LEt0g9zfjApKw57W2kef2A9PDcHgo+f6DfIc0I22oW0MJzrVxhbPAC4il5gXjr8eZBO
         KHvX1LO0d0BR7lGk+FvLSWxW+gNvbo4aUyj5xkvJnfMO2rzo8TFquC9U9PvSbFIIC5Dx
         x+7QrHkZmdWsGEIxAnOk3ag78jmF0vTx2AE93zOY2F5TnePq+2xHZzc7XwCCkGV1hjmC
         e8FzEeLrYoEcf6dkdK5rw94Re0q91V/nq129/UNVT7EyJAWHYCQ5H/FPc06gr8MarYDe
         XFBg==
X-Gm-Message-State: AOAM5332SY1Smk+ilMab+VuZ6Z3Yozk6m2KhyWjO/8wBZ4Nl9qaxLcx4
        AUyHkd2fmemST8oxXJBt/yro9ysGS9+0SwGH42X87Q==
X-Google-Smtp-Source: ABdhPJzl78nlmcwoiguIAxOzKCihxpKfHKYModWH7inw5tJRI0S8DABgAyCXprE34msfJKwMKL62DXsgABNqJDTBYtg=
X-Received: by 2002:adf:82d5:: with SMTP id 79mr19406166wrc.282.1596556243438;
 Tue, 04 Aug 2020 08:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com> <20200728085734.609930-5-irogers@google.com>
 <969ef797-59ea-69d0-24b9-33bcdff106a1@intel.com> <CAP-5=fUCnBGX0L0Tt3_gmVnt+hvaouJMx6XFErFKk72+xuw9fw@mail.gmail.com>
 <86324041-aafb-f556-eda7-6250ba678f24@intel.com>
In-Reply-To: <86324041-aafb-f556-eda7-6250ba678f24@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Aug 2020 08:50:32 -0700
Message-ID: <CAP-5=fXfBkXovaK3DuSCnwfsnxqW7ZR8-LigtGATgs4gMpZP9A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] perf record: Don't clear event's period if set by
 a term
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
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

On Tue, Aug 4, 2020 at 7:49 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 4/08/20 4:33 pm, Ian Rogers wrote:
> > On Tue, Aug 4, 2020 at 3:08 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 28/07/20 11:57 am, Ian Rogers wrote:
> >>> If events in a group explicitly set a frequency or period with leader
> >>> sampling, don't disable the samples on those events.
> >>>
> >>> Prior to 5.8:
> >>> perf record -e '{cycles/period=12345000/,instructions/period=6789000/}:S'
> >>
> >> Might be worth explaining this use-case some more.
> >> Perhaps add it to the leader sampling documentation for perf-list.
> >>
> >>> would clear the attributes then apply the config terms. In commit
> >>> 5f34278867b7 leader sampling configuration was moved to after applying the
> >>> config terms, in the example, making the instructions' event have its period
> >>> cleared.
> >>> This change makes it so that sampling is only disabled if configuration
> >>> terms aren't present.
> >>>
> >>> Fixes: 5f34278867b7 ("perf evlist: Move leader-sampling configuration")
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/util/record.c | 28 ++++++++++++++++++++--------
> >>>  1 file changed, 20 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> >>> index a4cc11592f6b..01d1c6c613f7 100644
> >>> --- a/tools/perf/util/record.c
> >>> +++ b/tools/perf/util/record.c
> >>> @@ -2,6 +2,7 @@
> >>>  #include "debug.h"
> >>>  #include "evlist.h"
> >>>  #include "evsel.h"
> >>> +#include "evsel_config.h"
> >>>  #include "parse-events.h"
> >>>  #include <errno.h>
> >>>  #include <limits.h>
> >>> @@ -38,6 +39,9 @@ static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *ev
> >>>       struct perf_event_attr *attr = &evsel->core.attr;
> >>>       struct evsel *leader = evsel->leader;
> >>>       struct evsel *read_sampler;
> >>> +     struct evsel_config_term *term;
> >>> +     struct list_head *config_terms = &evsel->config_terms;
> >>> +     int term_types, freq_mask;
> >>>
> >>>       if (!leader->sample_read)
> >>>               return;
> >>> @@ -47,16 +51,24 @@ static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *ev
> >>>       if (evsel == read_sampler)
> >>>               return;
> >>>
> >>> +     /* Determine the evsel's config term types. */
> >>> +     term_types = 0;
> >>> +     list_for_each_entry(term, config_terms, list) {
> >>> +             term_types |= 1 << term->type;
> >>> +     }
> >>>       /*
> >>> -      * Disable sampling for all group members other than the leader in
> >>> -      * case the leader 'leads' the sampling, except when the leader is an
> >>> -      * AUX area event, in which case the 2nd event in the group is the one
> >>> -      * that 'leads' the sampling.
> >>> +      * Disable sampling for all group members except those with explicit
> >>> +      * config terms or the leader. In the case of an AUX area event, the 2nd
> >>> +      * event in the group is the one that 'leads' the sampling.
> >>>        */
> >>> -     attr->freq           = 0;
> >>> -     attr->sample_freq    = 0;
> >>> -     attr->sample_period  = 0;
> >>> -     attr->write_backward = 0;
> >>> +     freq_mask = (1 << EVSEL__CONFIG_TERM_FREQ) | (1 << EVSEL__CONFIG_TERM_PERIOD);
> >>> +     if ((term_types & freq_mask) == 0) {
> >>
> >> It would be nicer to have a helper e.g.
> >>
> >>         if (!evsel__have_config_term(evsel, FREQ) &&
> >>             !evsel__have_config_term(evsel, PERIOD)) {
> >
> > Sure. The point of doing it this way was to avoid repeatedly iterating
> > over the config term list.
>
> But perhaps it is premature optimization

The alternative is more loc. I think we can bike shed on this but it's
not really changing the substance of the change. I'm keen to try to be
efficient where we can as we see issues at scale.

Thanks,
Ian

> >
> >>> +             attr->freq           = 0;
> >>> +             attr->sample_freq    = 0;
> >>> +             attr->sample_period  = 0;
> >>
> >> If we are not sampling, then maybe we should also put here:
> >>
> >>                 attr->write_backward = 0;
> >>
> >>> +     }
> >>
> >> Then, if we are sampling this evsel shouldn't the backward setting
> >> match the leader? e.g.
> >>
> >>         if (attr->sample_freq)
> >>                 attr->write_backward = leader->core.attr.write_backward;
> >
> > Perhaps that should be a follow up change? This change is trying to
> > make the behavior match the previous behavior.
>
> Sure
>
> >
> > Thanks,
> > Ian
> >
> >>> +     if ((term_types & (1 << EVSEL__CONFIG_TERM_OVERWRITE)) == 0)
> >>> +             attr->write_backward = 0;
> >>>
> >>>       /*
> >>>        * We don't get a sample for slave events, we make them when delivering
> >>>
> >>
>
