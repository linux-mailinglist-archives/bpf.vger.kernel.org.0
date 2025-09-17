Return-Path: <bpf+bounces-68631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DEDB7D4B5
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CDE166E95
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 06:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04992BE050;
	Wed, 17 Sep 2025 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+o1iOm6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74329ACC6;
	Wed, 17 Sep 2025 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090192; cv=none; b=Gj7KhiXdhxm+gmjCKrwGm39tZvvlSv8htC4TYFBdBPkLsulTphdsz1Z8n/gh4N7yRWmmOVb3x/j2nGObhE/avMhkeXFsSZCk157QMVvIyXX8HmNRziiGlzvqXNiROoerSCwtAT4TOifslbLzwM9pLqUxnBbm7K1N+9dNxySb9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090192; c=relaxed/simple;
	bh=uQCMAUc4qo1hnaJg0PGbdHj+6FZ7krxrxXX4VFkaiqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju5j+TcxMmjAl8O2/WQ3KXMbQthaq+TI+W49b/MJIoIjjpMRHhLzKSYdzDNLQk9INCM1jvLsbrqIbyJeVyI0iNnDtiHIcGn3rpffqc8EWh/1wUyvXHg/WIW5SfrJwWKm4LW0HJDj5YdgMhetsVpgUAA1Z/QbPjr7z9TQHK9dcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+o1iOm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C23C4CEF0;
	Wed, 17 Sep 2025 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758090191;
	bh=uQCMAUc4qo1hnaJg0PGbdHj+6FZ7krxrxXX4VFkaiqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+o1iOm6yYNilA7paGQwcFpdpOg9adIKe8VfnV4VmSqHbx+HAZIc3UAN/cqpy5+XN
	 YXgwE1lKkgLFGZ0EMNMVW0MiNwDx1+4g8si59LtS6wCgm0bw7XTe8BD8XmhEZoPncK
	 p/wx8IGMV0tKw9eGYVCMfpa25fmKQQFSELjFBuyxyqRNdeVmkWsdMukC7nz4L0DNJ1
	 MEXMCKbRR87FNriUj5Ra6UIumeNWWsx8KeXu3siI5xnPRdx6GhepyupL3yYZKGnZ+I
	 YnZYCY8Q+KUvLkzWKUi77RKkgaFraba1342bJ26MkHpch/TDqnz0aSPsJbmxpd2urh
	 +u35NZgY35Nmw==
Date: Tue, 16 Sep 2025 23:23:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>,
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
	Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH v4 20/21] perf parse-events: Add HW_CYCLES_STR as default
 cycles event string
Message-ID: <aMpTzWhifwzVlOoD@z2>
References: <20250914181121.1952748-1-irogers@google.com>
 <20250914181121.1952748-21-irogers@google.com>
 <aMljsNZxTw5ZPfeb@J2N7QTR9R3.cambridge.arm.com>
 <CAP-5=fUx5oyCBtp2NO-h1mTC+ANt=uTOp9tS3rVN=CQFuXo00g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUx5oyCBtp2NO-h1mTC+ANt=uTOp9tS3rVN=CQFuXo00g@mail.gmail.com>

Hello,

On Tue, Sep 16, 2025 at 08:49:48AM -0700, Ian Rogers wrote:
> On Tue, Sep 16, 2025 at 6:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Sun, Sep 14, 2025 at 11:11:20AM -0700, Ian Rogers wrote:
> > > ARM managed to significantly overload the meaning of the "cycles"
> > > event in their PMU kernel drivers through sysfs.
> >
> > Ian, please stop phrasing this as if Arm have done something wrong here.
> >
> > It's true that some system PMU drivers have events named 'cycles'.
> >
> > It's not true that this is "overloading" the meaning of 'cycles'; those
> > PMU-specific events were never intended to be conflated with the
> > PERF_TYPE_HARDWARE events which have the same name.
> >
> > This was never a problem until the perf tool was changed to handle
> > events such that it blindly assumed all events were in the same
> > namespace. I have repeatedly explained that this was a bad idea.
> >
> > There is no reason that this should be handled in an ARM-specific way;
> > if you want the bare 'cycles' event (withj no explcit PMU) to mean
> > PERF_TYPE_HARDWARE:PERF_COUNT_HW_CPU_CYCLES, then *don't* match that
> > with other PMU types. We cna specifically identify CPU PMUs which
> > support that with the extended type ID if necessary.
> 
> Is the "cycles" event meaning uncore events a problem on anything
> other than ARM, no.
> Is having more than one event of the same name overloading the name,
> by my definition yes.
> Am I implying ARM has done something wrong? Well other than in fixing
> a problem created by ARM's drivers..

Well.. at least we agreed that there's a problem. :)  Let's move on to
talking about solutions.  Please see below.

> 
> Firstly, let's not pretend ARM has always elegantly supported the
> legacy cycles event. When BIG.little came out, as you explained to me,
> the legacy events would be opened on the first PMU registered with the
> kernel. You would get legacy events on some fraction of the CPU cores.
> ARM was reliant on a lot of seemingly correct behavior by having its
> core PMU drivers appear as uncore ones. I am very much still in the
> process of trying to clean up the tech debt and mess that falls out
> from BIG.little and Intel's hybrid.
> 
> The behavior of legacy events with extended types and wildcarding.
> This was introduced by Intel. The right moment to complain would have
> been when Intel added the extended type and wildcarding support in the
> kernel and perf tool. I wasn't even a reviewer on those patches.

In the perf tools, we want to support extended type and wildcarding
for usability and maintenance reasons.  Right now, IIUC the problem
happens when it expands the default 'cycles' event for perf record
where some events from a PMU that doesn't support sampling.  I think
Ian changed perf record not to fail by the supported events.

(To me, it'd be great if we can get the info whether the PMU supports
sampling or not from the kernel.  But that's a different story.)

And perf stat can handle unsupported events already.  Then the problem
sovled?  Almost?

While 'cycles' happens to be found only in some ARM machines, other
hardware events can have the same problem in other platforms
theoretically.  So I don't like to add a specicial rule for cycles and
ARMs.

Maybe we should use 'cpu-cycles' instead (as it's the same event), if
you really don't want to expand it with wildcard.  I'm not sure how
many people care about name of the default event.  Probably we can try
cpu-cycles for all platforms and see if someone screams..

Or, we can keep the original name and update the test code to handle
multiple events (if that's the only concern).  Maybe you just pick a
correct one after parsing and before running the tests rather than
dealing with multilple events.

Thanks,
Namhyung

> 
> Do ARM do things in their drivers that seem unthought through? Yes,
> when hex suffixes of physical addresses were added to uncore PMU
> drivers it was missed that a53 and a57 would also match this wildcard
> suffix as ARM has unconventional core PMU names and the suffix on
> those match as hex. We've worked around the issue by saying a hex
> suffix must be longer than 3 characters but when ARM bumps up its CPU
> names that will be broken. It seems there is some ambition to reinvent
> rules when ARM drivers do things and the fallout has all too often had
> to be fixed and addressed by me, with emails like this for thanks.
> 
> I'm sorry that you think I'm targeting ARM by fixing the issues your
> drivers have introduced. It would have been better if ARM's drivers
> didn't keep introducing issues. I'd repeat my call here that ARM add
> support for the parse-events test for their PMUs. I don't understand
> your last paragraph, in the context of the patch series it makes
> little to no sense as the patch series is very much doing this.
> 
> Finally, doing things this way was prompted by James Clark's concerns
> and I posted about this exact patch here:
> https://lore.kernel.org/lkml/CAP-5=fUsZCz8Li1noKMODKXTLYFH9FsDCpXqCUxfu1h+s4c6Vw@mail.gmail.com/
> ie I only added this patch at someone from Linaro's request and
> received 0 feedback that doing so would be wrong. I don't think it is
> and recommend this patch series for review.
> 
> Thanks,
> Ian
> 
> > Mark.
> >
> > > In the tool use
> > > "cpu-cycles" on ARM to avoid wildcard matching on different PMUS. This
> > > is most commonly done in test code.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-stat.c           |   4 +-
> > >  tools/perf/tests/code-reading.c     |   4 +-
> > >  tools/perf/tests/keep-tracking.c    |   2 +-
> > >  tools/perf/tests/parse-events.c     | 100 ++++++++++++++--------------
> > >  tools/perf/tests/perf-time-to-tsc.c |   2 +-
> > >  tools/perf/tests/switch-tracking.c  |   2 +-
> > >  tools/perf/util/evlist.c            |   2 +-
> > >  tools/perf/util/parse-events.h      |  10 +++
> > >  tools/perf/util/perf_api_probe.c    |   4 +-
> > >  9 files changed, 71 insertions(+), 59 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 2c38dd98f6ca..9f522b787ad5 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -1957,7 +1957,7 @@ static int add_default_events(void)
> > >                               "cpu-migrations,"
> > >                               "page-faults,"
> > >                               "instructions,"
> > > -                             "cycles,"
> > > +                             HW_CYCLES_STR ","
> > >                               "stalled-cycles-frontend,"
> > >                               "stalled-cycles-backend,"
> > >                               "branches,"
> > > @@ -2043,7 +2043,7 @@ static int add_default_events(void)
> > >                        * Make at least one event non-skippable so fatal errors are visible.
> > >                        * 'cycles' always used to be default and non-skippable, so use that.
> > >                        */
> > > -                     if (strcmp("cycles", evsel__name(evsel)))
> > > +                     if (strcmp(HW_CYCLES_STR, evsel__name(evsel)))
> > >                               evsel->skippable = true;
> > >               }
> > >       }
> > > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> > > index 9c2091310191..baa44918f555 100644
> > > --- a/tools/perf/tests/code-reading.c
> > > +++ b/tools/perf/tests/code-reading.c
> > > @@ -649,7 +649,9 @@ static int do_test_code_reading(bool try_kcore)
> > >       struct map *map;
> > >       bool have_vmlinux, have_kcore;
> > >       struct dso *dso;
> > > -     const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
> > > +     const char *events[] = {
> > > +             HW_CYCLES_STR, HW_CYCLES_STR ":u", "cpu-clock", "cpu-clock:u", NULL
> > > +     };
> > >       int evidx = 0;
> > >       struct perf_env host_env;
> > >
> > > diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
> > > index eafb49eb0b56..d54ddb4db47b 100644
> > > --- a/tools/perf/tests/keep-tracking.c
> > > +++ b/tools/perf/tests/keep-tracking.c
> > > @@ -90,7 +90,7 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
> > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > >
> > >       CHECK__(parse_event(evlist, "dummy:u"));
> > > -     CHECK__(parse_event(evlist, "cycles:u"));
> > > +     CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
> > >
> > >       evlist__config(evlist, &opts, NULL);
> > >
> > > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > > index 4e55b0d295bd..7d59648a0591 100644
> > > --- a/tools/perf/tests/parse-events.c
> > > +++ b/tools/perf/tests/parse-events.c
> > > @@ -198,7 +198,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
> > >       TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
> > >
> > >       perf_evlist__for_each_evsel(&evlist->core, evsel) {
> > > -             int ret = assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             int ret = assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >
> > >               if (ret)
> > >                       return ret;
> > > @@ -884,7 +884,7 @@ static int test__group1(struct evlist *evlist)
> > >
> > >               /* cycles:upp */
> > >               evsel = evsel__next(evsel);
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -948,7 +948,7 @@ static int test__group2(struct evlist *evlist)
> > >                       continue;
> > >               }
> > >               /* cycles:k */
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1085,7 +1085,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
> > >
> > >               /* cycles:u + p */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1133,7 +1133,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
> > >       for (int i = 0; i < num_core_entries(); i++) {
> > >               /* cycles + G */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1168,7 +1168,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
> > >       for (int i = 0; i < num_core_entries(); i++) {
> > >               /* cycles:G */
> > >               evsel = leader = evsel__next(evsel);
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1202,7 +1202,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
> > >       for (int i = 0; i < num_core_entries(); i++) {
> > >               /* cycles */
> > >               evsel = evsel__next(evsel);
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1231,7 +1231,7 @@ static int test__group_gh1(struct evlist *evlist)
> > >
> > >               /* cycles + :H group modifier */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1278,7 +1278,7 @@ static int test__group_gh2(struct evlist *evlist)
> > >
> > >               /* cycles + :G group modifier */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1325,7 +1325,7 @@ static int test__group_gh3(struct evlist *evlist)
> > >
> > >               /* cycles:G + :u group modifier */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1372,7 +1372,7 @@ static int test__group_gh4(struct evlist *evlist)
> > >
> > >               /* cycles:G + :uG group modifier */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1417,7 +1417,7 @@ static int test__leader_sample1(struct evlist *evlist)
> > >
> > >               /* cycles - sampling group leader */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1540,7 +1540,7 @@ static int test__pinned_group(struct evlist *evlist)
> > >
> > >               /* cycles - group leader */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1594,7 +1594,7 @@ static int test__exclusive_group(struct evlist *evlist)
> > >
> > >               /* cycles - group leader */
> > >               evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
> > > -             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +             ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1759,7 +1759,7 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
> > >  static int test__sym_event_slash(struct evlist *evlist)
> > >  {
> > >       struct evsel *evsel = evlist__first(evlist);
> > > -     int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +     int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >
> > >       if (ret)
> > >               return ret;
> > > @@ -1771,7 +1771,7 @@ static int test__sym_event_slash(struct evlist *evlist)
> > >  static int test__sym_event_dc(struct evlist *evlist)
> > >  {
> > >       struct evsel *evsel = evlist__first(evlist);
> > > -     int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +     int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >
> > >       if (ret)
> > >               return ret;
> > > @@ -1783,7 +1783,7 @@ static int test__sym_event_dc(struct evlist *evlist)
> > >  static int test__term_equal_term(struct evlist *evlist)
> > >  {
> > >       struct evsel *evsel = evlist__first(evlist);
> > > -     int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +     int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >
> > >       if (ret)
> > >               return ret;
> > > @@ -1795,7 +1795,7 @@ static int test__term_equal_term(struct evlist *evlist)
> > >  static int test__term_equal_legacy(struct evlist *evlist)
> > >  {
> > >       struct evsel *evsel = evlist__first(evlist);
> > > -     int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
> > > +     int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
> > >
> > >       if (ret)
> > >               return ret;
> > > @@ -2006,27 +2006,27 @@ static const struct evlist_test test__events[] = {
> > >               /* 7 */
> > >       },
> > >       {
> > > -             .name  = "{instructions:k,cycles:upp}",
> > > +             .name  = "{instructions:k," HW_CYCLES_STR ":upp}",
> > >               .check = test__group1,
> > >               /* 8 */
> > >       },
> > >       {
> > > -             .name  = "{faults:k,branches}:u,cycles:k",
> > > +             .name  = "{faults:k,branches}:u," HW_CYCLES_STR ":k",
> > >               .check = test__group2,
> > >               /* 9 */
> > >       },
> > >       {
> > > -             .name  = "group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u",
> > > +             .name  = "group1{syscalls:sys_enter_openat:H," HW_CYCLES_STR ":kppp},group2{" HW_CYCLES_STR ",1:3}:G,instructions:u",
> > >               .check = test__group3,
> > >               /* 0 */
> > >       },
> > >       {
> > > -             .name  = "{cycles:u,instructions:kp}:p",
> > > +             .name  = "{" HW_CYCLES_STR ":u,instructions:kp}:p",
> > >               .check = test__group4,
> > >               /* 1 */
> > >       },
> > >       {
> > > -             .name  = "{cycles,instructions}:G,{cycles:G,instructions:G},cycles",
> > > +             .name  = "{" HW_CYCLES_STR ",instructions}:G,{" HW_CYCLES_STR ":G,instructions:G}," HW_CYCLES_STR,
> > >               .check = test__group5,
> > >               /* 2 */
> > >       },
> > > @@ -2036,27 +2036,27 @@ static const struct evlist_test test__events[] = {
> > >               /* 3 */
> > >       },
> > >       {
> > > -             .name  = "{cycles,cache-misses:G}:H",
> > > +             .name  = "{" HW_CYCLES_STR ",cache-misses:G}:H",
> > >               .check = test__group_gh1,
> > >               /* 4 */
> > >       },
> > >       {
> > > -             .name  = "{cycles,cache-misses:H}:G",
> > > +             .name  = "{" HW_CYCLES_STR ",cache-misses:H}:G",
> > >               .check = test__group_gh2,
> > >               /* 5 */
> > >       },
> > >       {
> > > -             .name  = "{cycles:G,cache-misses:H}:u",
> > > +             .name  = "{" HW_CYCLES_STR ":G,cache-misses:H}:u",
> > >               .check = test__group_gh3,
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  = "{cycles:G,cache-misses:H}:uG",
> > > +             .name  = "{" HW_CYCLES_STR ":G,cache-misses:H}:uG",
> > >               .check = test__group_gh4,
> > >               /* 7 */
> > >       },
> > >       {
> > > -             .name  = "{cycles,cache-misses,branch-misses}:S",
> > > +             .name  = "{" HW_CYCLES_STR ",cache-misses,branch-misses}:S",
> > >               .check = test__leader_sample1,
> > >               /* 8 */
> > >       },
> > > @@ -2071,7 +2071,7 @@ static const struct evlist_test test__events[] = {
> > >               /* 0 */
> > >       },
> > >       {
> > > -             .name  = "{cycles,cache-misses,branch-misses}:D",
> > > +             .name  = "{" HW_CYCLES_STR ",cache-misses,branch-misses}:D",
> > >               .check = test__pinned_group,
> > >               /* 1 */
> > >       },
> > > @@ -2109,7 +2109,7 @@ static const struct evlist_test test__events[] = {
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  = "task-clock:P,cycles",
> > > +             .name  = "task-clock:P," HW_CYCLES_STR,
> > >               .check = test__checkevent_precise_max_modifier,
> > >               /* 7 */
> > >       },
> > > @@ -2140,17 +2140,17 @@ static const struct evlist_test test__events[] = {
> > >               /* 2 */
> > >       },
> > >       {
> > > -             .name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
> > > +             .name  = HW_CYCLES_STR "/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
> > >               .check = test__checkevent_complex_name,
> > >               /* 3 */
> > >       },
> > >       {
> > > -             .name  = "cycles//u",
> > > +             .name  = HW_CYCLES_STR "//u",
> > >               .check = test__sym_event_slash,
> > >               /* 4 */
> > >       },
> > >       {
> > > -             .name  = "cycles:k",
> > > +             .name  = HW_CYCLES_STR ":k",
> > >               .check = test__sym_event_dc,
> > >               /* 5 */
> > >       },
> > > @@ -2160,17 +2160,17 @@ static const struct evlist_test test__events[] = {
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  = "{cycles,cache-misses,branch-misses}:e",
> > > +             .name  = "{" HW_CYCLES_STR ",cache-misses,branch-misses}:e",
> > >               .check = test__exclusive_group,
> > >               /* 7 */
> > >       },
> > >       {
> > > -             .name  = "cycles/name=name/",
> > > +             .name  = HW_CYCLES_STR "/name=name/",
> > >               .check = test__term_equal_term,
> > >               /* 8 */
> > >       },
> > >       {
> > > -             .name  = "cycles/name=l1d/",
> > > +             .name  = HW_CYCLES_STR "/name=l1d/",
> > >               .check = test__term_equal_legacy,
> > >               /* 9 */
> > >       },
> > > @@ -2311,7 +2311,7 @@ static const struct evlist_test test__events_pmu[] = {
> > >               /* 9 */
> > >       },
> > >       {
> > > -             .name  = "cpu/cycles,period=100000,config2/",
> > > +             .name  = "cpu/" HW_CYCLES_STR ",period=100000,config2/",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__checkevent_symbolic_name_config,
> > >               /* 0 */
> > > @@ -2335,43 +2335,43 @@ static const struct evlist_test test__events_pmu[] = {
> > >               /* 3 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/instructions/k,cpu/cycles/upp}",
> > > +             .name  = "{cpu/instructions/k,cpu/" HW_CYCLES_STR "/upp}",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__group1,
> > >               /* 4 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/cycles/u,cpu/instructions/kp}:p",
> > > +             .name  = "{cpu/" HW_CYCLES_STR "/u,cpu/instructions/kp}:p",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__group4,
> > >               /* 5 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/cycles/,cpu/cache-misses/G}:H",
> > > +             .name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/G}:H",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__group_gh1,
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/cycles/,cpu/cache-misses/H}:G",
> > > +             .name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/H}:G",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__group_gh2,
> > >               /* 7 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/cycles/G,cpu/cache-misses/H}:u",
> > > +             .name  = "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses/H}:u",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__group_gh3,
> > >               /* 8 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/cycles/G,cpu/cache-misses/H}:uG",
> > > +             .name  = "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses/H}:uG",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__group_gh4,
> > >               /* 9 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:S",
> > > +             .name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu/branch-misses/}:S",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__leader_sample1,
> > >               /* 0 */
> > > @@ -2389,7 +2389,7 @@ static const struct evlist_test test__events_pmu[] = {
> > >               /* 2 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:D",
> > > +             .name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu/branch-misses/}:D",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__pinned_group,
> > >               /* 3 */
> > > @@ -2407,13 +2407,13 @@ static const struct evlist_test test__events_pmu[] = {
> > >               /* 5 */
> > >       },
> > >       {
> > > -             .name  = "cpu/cycles/u",
> > > +             .name  = "cpu/" HW_CYCLES_STR "/u",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__sym_event_slash,
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  = "cpu/cycles/k",
> > > +             .name  = "cpu/" HW_CYCLES_STR "/k",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__sym_event_dc,
> > >               /* 7 */
> > > @@ -2425,19 +2425,19 @@ static const struct evlist_test test__events_pmu[] = {
> > >               /* 8 */
> > >       },
> > >       {
> > > -             .name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:e",
> > > +             .name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu/branch-misses/}:e",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__exclusive_group,
> > >               /* 9 */
> > >       },
> > >       {
> > > -             .name  = "cpu/cycles,name=name/",
> > > +             .name  = "cpu/" HW_CYCLES_STR ",name=name/",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__term_equal_term,
> > >               /* 0 */
> > >       },
> > >       {
> > > -             .name  = "cpu/cycles,name=l1d/",
> > > +             .name  = "cpu/" HW_CYCLES_STR ",name=l1d/",
> > >               .valid = test__pmu_cpu_valid,
> > >               .check = test__term_equal_legacy,
> > >               /* 1 */
> > > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> > > index d4437410c99f..7ebcb1f004b2 100644
> > > --- a/tools/perf/tests/perf-time-to-tsc.c
> > > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > > @@ -101,7 +101,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> > >
> > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > >
> > > -     CHECK__(parse_event(evlist, "cycles:u"));
> > > +     CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
> > >
> > >       evlist__config(evlist, &opts, NULL);
> > >
> > > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> > > index 5be294014d3b..ad3a87978c0d 100644
> > > --- a/tools/perf/tests/switch-tracking.c
> > > +++ b/tools/perf/tests/switch-tracking.c
> > > @@ -332,7 +332,7 @@ static int process_events(struct evlist *evlist,
> > >  static int test__switch_tracking(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> > >  {
> > >       const char *sched_switch = "sched:sched_switch";
> > > -     const char *cycles = "cycles:u";
> > > +     const char *cycles = HW_CYCLES_STR ":u";
> > >       struct switch_tracking switch_tracking = { .tids = NULL, };
> > >       struct record_opts opts = {
> > >               .mmap_pages          = UINT_MAX,
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index e8217efdda53..d7e935faeda0 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -112,7 +112,7 @@ struct evlist *evlist__new_default(void)
> > >               char buf[256];
> > >               int err;
> > >
> > > -             snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
> > > +             snprintf(buf, sizeof(buf), "%s/%s/%s", pmu->name, HW_CYCLES_STR,
> > >                        can_profile_kernel ? "P" : "Pu");
> > >               err = parse_event(evlist, buf);
> > >               if (err) {
> > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > > index db92cd67bc0f..304676bf32dd 100644
> > > --- a/tools/perf/util/parse-events.h
> > > +++ b/tools/perf/util/parse-events.h
> > > @@ -20,6 +20,16 @@ struct option;
> > >  struct perf_pmu;
> > >  struct strbuf;
> > >
> > > +/*
> > > + * The name used for the "cycles" event. A different event name is used on ARM
> > > + * as many ARM PMUs define a "cycles" event.
> > > + */
> > > +#if defined(__aarch64__) || defined(__arm__)
> > > +#define HW_CYCLES_STR "cpu-cycles"
> > > +#else
> > > +#define HW_CYCLES_STR "cycles"
> > > +#endif
> > > +
> > >  const char *event_type(size_t type);
> > >
> > >  /* Arguments encoded in opt->value. */
> > > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
> > > index 6ecf38314f01..693bb5891bc4 100644
> > > --- a/tools/perf/util/perf_api_probe.c
> > > +++ b/tools/perf/util/perf_api_probe.c
> > > @@ -74,9 +74,9 @@ static bool perf_probe_api(setup_probe_fn_t fn)
> > >       if (!ret)
> > >               return true;
> > >
> > > -     pmu = perf_pmus__scan_core(/*pmu=*/NULL);
> > > +     pmu = perf_pmus__find_core_pmu();
> > >       if (pmu) {
> > > -             const char *try[] = {"cycles", "instructions", NULL};
> > > +             const char *try[] = {HW_CYCLES_STR, "instructions", NULL};
> > >               char buf[256];
> > >               int i = 0;
> > >
> > > --
> > > 2.51.0.384.g4c02a37b29-goog
> > >

