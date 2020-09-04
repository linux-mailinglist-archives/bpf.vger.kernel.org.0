Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2025D0E9
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgIDFjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 01:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgIDFjS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 01:39:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48558C061245
        for <bpf@vger.kernel.org>; Thu,  3 Sep 2020 22:39:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so4900623wmk.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Olcgjo2cp3SzbVgj9VEdIW4pjN91mBbsvBxdvxCRLJo=;
        b=f15p0Ep32YArP4LXBLiAkExie0hAem2FPAH0okI/cr+oL76ljWPQYqXHjM5IpBpPUl
         zbtS1hPYSEFeBReM1bLva9wCyscIzoTN8U6jRZ/CT3zvnfy0njGa5v9OwP+Nrg2Ltc1h
         b5FZa89xEwj/zhdrZ9gf6CSsfF1DkYInPJi4pFlD+bTRmiHybV/jooIHz1DWQ4rEdqiF
         cu/RYQXhUHTm2lcqze04jfkA6rt3eeZMqlPVnESfnl8wypve67LNYwy2WajnUZHrOoiB
         R5HFIzEzjPmkz2eNVIPLvOu+WCShfm/DgumDzFTockUEVofDevhr6CgHkt8j0d3euYkC
         PCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Olcgjo2cp3SzbVgj9VEdIW4pjN91mBbsvBxdvxCRLJo=;
        b=TXOQ0PbXd1+wvGlWozIUgkwvCmDiv6SZswXv9eI4U26S+BKFMYYck+SjZPg5AmumqC
         /uV5z8Lafhei3OlBGvFuIKbymu5ecI9av/xPfBmm7OcWoox1lvRhrBMYflGAAxHoE3Tu
         s1RCUgVzVn5mLcnfvBnzuqjCYfgrMjhX5WgKA4HzkSKNOVLahDkk4mR89ZFOiDrBrHsE
         514uRG4oECAxm9zMdOlcjEG6YIkUrjvbGXH8WvK4OhWyIcIL3np0R5QOquVhaO4vNr73
         t8suDsV8pywK6Tm6Srdghk0KEdiSX2ZclV1BKodyj+Cj6KjifCJD0bTdZ3N26hsarxni
         J1kQ==
X-Gm-Message-State: AOAM5310IfGqIUQl34R8rbvn9QK4J5EpgZCeuy2cpTwa+9xYMJG+JUtC
        OVOnZ/g6FHwcsAemTjXRWOQOku3fpJUbm4lEnR4MzA==
X-Google-Smtp-Source: ABdhPJziswYikgl/jGPR1gjMEEpxF6fEBNmx3b/HSs5t0TXQ0QsMijI6ieW+i4mlSTk97QvH5RD9z7lrELtjMYBaBHo=
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr1793416wmg.58.1599197952693;
 Thu, 03 Sep 2020 22:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com> <20200728085734.609930-2-irogers@google.com>
 <20200729185212.GB433799@kernel.org> <CAP-5=fUJW+UkL-jZkzkCKqTLh7DC0XnFx06kdfYiu2CK85Wq1w@mail.gmail.com>
In-Reply-To: <CAP-5=fUJW+UkL-jZkzkCKqTLh7DC0XnFx06kdfYiu2CK85Wq1w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Sep 2020 22:39:01 -0700
Message-ID: <CAP-5=fXbLtiX5Syji7X=-tV8r=PbbTw7X63h4PfggT-XvUemtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] perf record: Set PERF_RECORD_PERIOD if attr->freq
 is set.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Wed, Jul 29, 2020 at 2:43 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jul 29, 2020 at 11:52 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Jul 28, 2020 at 01:57:30AM -0700, Ian Rogers escreveu:
> > > From: David Sharp <dhsharp@google.com>
> > >
> > > evsel__config() would only set PERF_RECORD_PERIOD if it set attr->freq
> >
> > There is no such thing as 'PERF_RECORD_PERIOD', its PERF_SAMPLE_PERIOD,
> > also...
> >
> > > from perf record options. When it is set by libpfm events, it would not
> > > get set. This changes evsel__config to see if attr->freq is set outside of
> > > whether or not it changes attr->freq itself.
> > >
> > > Signed-off-by: David Sharp <dhsharp@google.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evsel.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index ef802f6d40c1..811f538f7d77 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -979,13 +979,18 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
> > >       if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
> > >                                    opts->user_interval != ULLONG_MAX)) {
> > >               if (opts->freq) {
> > > -                     evsel__set_sample_bit(evsel, PERIOD);
> > >                       attr->freq              = 1;
> > >                       attr->sample_freq       = opts->freq;
> > >               } else {
> > >                       attr->sample_period = opts->default_interval;
> > >               }
> > >       }
> > > +     /*
> > > +      * If attr->freq was set (here or earlier), ask for period
> > > +      * to be sampled.
> > > +      */
> > > +     if (attr->freq)
> > > +             evsel__set_sample_bit(evsel, PERIOD);
> >
> > Why can't the libpfm code set opts?
> >
> > With this patch we will end up calling evsel__set_sample_bit(evsel,
> > PERIOD) twice, which isn't a problem but looks strange.
>
> Thanks Arnaldo! The case I was looking at was something like:
> perf record --pfm-events cycles:freq=1000
>
> For regular events this would be:
> perf record -e cycles/freq=1000/
>
> With libpfm4 events the perf_event_attr is set up (a public API in
> linux/perf_event.h) and then parse_events__add_event is used (an
> internal API) to make the evsel and this added to the evlist
> (parse_libpfm_events_option). This is similar to the parse_events
> function except rather than set up a perf_event_attr the regular
> parsing sets up config terms that are then applied to evsel and attr
> later in evsel__config, via evsel__apply_config_terms.
>
> I think we can  update this change so that in pfm.c after
> parse_events__add_event we do:
> if (attr.freq)
>   evsel__set_sample_bit(evsel, PERIOD);
>
> This code could also be part of parse_events__add_event. I think the
> intent in placing this code here was that it is close to the similar
> evsel__apply_config_terms and setting of sample bits in the evsel. The
> logic here is already dependent on reading the attr->sample_period.
>
> I'm not sure I follow the double setting case - I think that is only
> possible with a config term or with period_set (-P).
>
> Thanks,
> Ian

Polite ping. Thanks,
Ian

>
> > - Arnaldo
> >
> > >
> > >       if (opts->no_samples)
> > >               attr->sample_freq = 0;
> > > --
> > > 2.28.0.163.g6104cc2f0b6-goog
> > >
> >
> > --
> >
> > - Arnaldo
