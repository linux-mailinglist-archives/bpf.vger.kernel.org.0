Return-Path: <bpf+bounces-48434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5323A0800E
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39693A3828
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AFF1AB6C8;
	Thu,  9 Jan 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5tzXhX0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BE18CBE1;
	Thu,  9 Jan 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448309; cv=none; b=tlzTIaemaRweniGpNMp8WqyVXKGu8zPdXf+HCLuSFII8ZqvmYigsleUQg/ITlps149/59b9n98HjCocRHZJaZy2wZDe1vZPdZSdm0f6MF3njTuVA1pkvLgGK1Em3Y91TtsaNm+6grYYzCiWmpcMx53ODC9HRZv+H8W72kjC133E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448309; c=relaxed/simple;
	bh=xMtdIVXuTlSNA+8qR6PqQCUpxqbur8IJvKK3MAzxGt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6FSAALbtwGgPyCf7JkeAt+yikimMOcUaC2P0HQMR4eZfLm54IleJSapxIhUlMiVbAfVuw4+GNuQaNXi2lErlldIKtXIFHoUVRVuJNVJ+jogsPglW18C9wtQQCxOT1uOjdO66YXFXe3lR8MKa9RuLiUzUI93k4/XFzf6u3+ToMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5tzXhX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956C2C4CED2;
	Thu,  9 Jan 2025 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736448309;
	bh=xMtdIVXuTlSNA+8qR6PqQCUpxqbur8IJvKK3MAzxGt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5tzXhX0e0HIGA2Xmb/WqOwGwZMep51IsaYOZC9mq/N1Orb9A7JeKJQ2m/xdlFOQa
	 awV+gwzeyn6IYq6xsa/ywEaoqR2ltmmybjUNcSlMh3k3uKk3Ft5x2JCwch2ye52/d9
	 8nXJwCtUJ2Bx36ErXCnE/cDwo5GH64RFR3QQW1unkI9bNWY590iieK1ShMDo52W0Qd
	 FvPsCmztBSssit13F12xIWotrDPHxVs0rKz30cibySkPZzfEJ61BY8/nPe7yhancux
	 spKdhReTKBfRLCNZnoJQIQDvXdakk7LKNImuZCSwsKeLxPhLpLBXt/eW5FeioQjLqn
	 SpbUJMxF+YOjw==
Date: Thu, 9 Jan 2025 10:45:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v4 3/4] perf record: Skip don't fail for events that
 don't open
Message-ID: <Z4AZM4QS3Y5FkxoD@google.com>
References: <20250107180854.770470-1-irogers@google.com>
 <20250107180854.770470-4-irogers@google.com>
 <Z32CeUuxt4ASJeRe@google.com>
 <CAP-5=fUqbPX4RLSLzw1UJ9NycOh8r5o4TxLfu2RRxooPG0gUtA@mail.gmail.com>
 <Z33DSLHzCpEVrAdy@google.com>
 <CAP-5=fUxiGhXs55KHnQgXHbOy46Z_16VEgpfJ0ha8UcUXxqvOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUxiGhXs55KHnQgXHbOy46Z_16VEgpfJ0ha8UcUXxqvOw@mail.gmail.com>

On Tue, Jan 07, 2025 at 09:55:51PM -0800, Ian Rogers wrote:
> On Tue, Jan 7, 2025 at 4:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Jan 07, 2025 at 12:34:25PM -0800, Ian Rogers wrote:
> > > On Tue, Jan 7, 2025 at 11:37 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Tue, Jan 07, 2025 at 10:08:53AM -0800, Ian Rogers wrote:
> > > > > Whilst for many tools it is an expected behavior that failure to open
> > > > > a perf event is a failure, ARM decided to name PMU events the same as
> > > > > legacy events and then failed to rename such events on a server uncore
> > > > > SLC PMU. As perf's default behavior when no PMU is specified is to
> > > > > open the event on all PMUs that advertise/"have" the event, this
> > > > > yielded failures when trying to make the priority of legacy and
> > > > > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > > > > legacy event user on ARM hardware may find their event opened on an
> > > > > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > > > > such events which this patch implements. Rather than have the skipping
> > > > > conditional on running on ARM, the skipping is done on all
> > > > > architectures as such a fundamental behavioral difference could lead
> > > > > to problems with tools built/depending on perf.
> > > > >
> > > > > An example of perf record failing to open events on x86 is:
> > > > > ```
> > > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > > > Error:
> > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > > "dmesg | grep -i perf" may provide additional information.
> > > > >
> > > > > Error:
> > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > > "dmesg | grep -i perf" may provide additional information.
> > > > >
> > > > > Error:
> > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > > The LLC-prefetch-read event is not supported.
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> > > > >
> > > > > $ perf report --stats
> > > > > Aggregated stats:
> > > > >                TOTAL events:      17255
> > > > >                 MMAP events:        284  ( 1.6%)
> > > > >                 COMM events:       1961  (11.4%)
> > > > >                 EXIT events:          1  ( 0.0%)
> > > > >                 FORK events:       1960  (11.4%)
> > > > >               SAMPLE events:         87  ( 0.5%)
> > > > >                MMAP2 events:      12836  (74.4%)
> > > > >              KSYMBOL events:         83  ( 0.5%)
> > > > >            BPF_EVENT events:         36  ( 0.2%)
> > > > >       FINISHED_ROUND events:          2  ( 0.0%)
> > > > >             ID_INDEX events:          1  ( 0.0%)
> > > > >           THREAD_MAP events:          1  ( 0.0%)
> > > > >              CPU_MAP events:          1  ( 0.0%)
> > > > >            TIME_CONV events:          1  ( 0.0%)
> > > > >        FINISHED_INIT events:          1  ( 0.0%)
> > > > > cycles stats:
> > > > >               SAMPLE events:         87
> > > > > ```
> > > > >
> > > > > If all events fail to open then the perf record will fail:
> > > > > ```
> > > > > $ perf record -e LLC-prefetch-read true
> > > > > Error:
> > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > > The LLC-prefetch-read event is not supported.
> > > > > Error:
> > > > > Failure to open any events for recording
> > > > > ```
> > > > >
> > > > > This is done by detecting if dummy events were implicitly added by
> > > > > perf and seeing if the evlist is empty without them. This allows the
> > > > > dummy event still to be recorded:
> > > > > ```
> > > > > $ perf record -e dummy true
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 0.046 MB perf.data ]
> > > > > ```
> > > > > but fail when inserted:
> > > > > ```
> > > > > $ perf record -e LLC-prefetch-read -a true
> > > > > Error:
> > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > > The LLC-prefetch-read event is not supported.
> > > > > Error:
> > > > > Failure to open any events for recording
> > > > > ```
> > > > >
> > > > > The issue with legacy events is that on RISC-V they want the driver to
> > > > > not have mappings from legacy to non-legacy config encodings for each
> > > > > vendor/model due to size, complexity and difficulty to update. It was
> > > > > reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> > > > > was broken and the sysfs/json events should always take precedent,
> > > > > however, it isn't clear this is still the case. It is the case that
> > > > > without working around this issue a legacy event like cycles without a
> > > > > PMU can encode differently than when specified with a PMU - the
> > > > > non-PMU version favoring legacy encodings, the PMU one avoiding legacy
> > > > > encodings.
> > > > >
> > > > > The patch removes events and then adjusts the idx value for each
> > > > > evsel. This is done so that the dense xyarrays used for file
> > > > > descriptors, etc. don't contain broken entries. As event opening
> > > > > happens relatively late in the record process, use of the idx value
> > > > > before the open will have become corrupted, so it is expected there
> > > > > are latent bugs hidden behind this change - the change is best
> > > > > effort. As the only vendor that has broken event names is ARM, this
> > > > > will principally effect ARM users. They will also experience warning
> > > > > messages like those above because of the uncore PMU advertising legacy
> > > > > event names.
> > > > >
> > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > Tested-by: James Clark <james.clark@linaro.org>
> > > > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > > > Tested-by: Atish Patra <atishp@rivosinc.com>
> > > > > ---
> > > > >  tools/perf/builtin-record.c | 54 ++++++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 48 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > > > index 5db1aedf48df..b3f06638f3c6 100644
> > > > > --- a/tools/perf/builtin-record.c
> > > > > +++ b/tools/perf/builtin-record.c
> > > > > @@ -161,6 +161,7 @@ struct record {
> > > > >       struct evlist           *sb_evlist;
> > > > >       pthread_t               thread_id;
> > > > >       int                     realtime_prio;
> > > > > +     int                     num_parsed_dummy_events;
> > > > >       bool                    switch_output_event_set;
> > > > >       bool                    no_buildid;
> > > > >       bool                    no_buildid_set;
> > > > > @@ -961,7 +962,6 @@ static int record__config_tracking_events(struct record *rec)
> > > > >        */
> > > > >       if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
> > > > >           perf_pmus__num_core_pmus() > 1) {
> > > > > -
> > > > >               /*
> > > > >                * User space tasks can migrate between CPUs, so when tracing
> > > > >                * selected CPUs, sideband for all CPUs is still needed.
> > > > > @@ -1366,6 +1366,7 @@ static int record__open(struct record *rec)
> > > > >       struct perf_session *session = rec->session;
> > > > >       struct record_opts *opts = &rec->opts;
> > > > >       int rc = 0;
> > > > > +     bool skipped = false;
> > > > >
> > > > >       evlist__for_each_entry(evlist, pos) {
> > > > >  try_again:
> > > > > @@ -1381,15 +1382,50 @@ static int record__open(struct record *rec)
> > > > >                               pos = evlist__reset_weak_group(evlist, pos, true);
> > > > >                               goto try_again;
> > > > >                       }
> > > > > -                     rc = -errno;
> > > > >                       evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
> > > > > -                     ui__error("%s\n", msg);
> > > > > -                     goto out;
> > > > > +                     ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
> > > > > +                               evsel__name(pos), evsel__pmu_name(pos), msg);
> > > > > +                     pos->skippable = true;
> > > > > +                     skipped = true;
> > > > > +             } else {
> > > > > +                     pos->supported = true;
> > > > >               }
> > > > > -
> > > > > -             pos->supported = true;
> > > > >       }
> > > > >
> > > > > +     if (skipped) {
> > > > > +             struct evsel *tmp;
> > > > > +             int idx = 0, num_dummy = 0, num_non_dummy = 0,
> > > > > +                 removed_dummy = 0, removed_non_dummy = 0;
> > > > > +
> > > > > +             /* Remove evsels that failed to open and update indices. */
> > > > > +             evlist__for_each_entry_safe(evlist, tmp, pos) {
> > > > > +                     if (evsel__is_dummy_event(pos))
> > > > > +                             num_dummy++;
> > > > > +                     else
> > > > > +                             num_non_dummy++;
> > > > > +
> > > > > +                     if (!pos->skippable)
> > > > > +                             continue;
> > > > > +
> > > > > +                     if (evsel__is_dummy_event(pos))
> > > > > +                             removed_dummy++;
> > > > > +                     else
> > > > > +                             removed_non_dummy++;
> > > > > +
> > > > > +                     evlist__remove(evlist, pos);
> > > > > +             }
> > > > > +             evlist__for_each_entry(evlist, pos) {
> > > > > +                     pos->core.idx = idx++;
> > > > > +             }
> > > > > +             /* If list is empty except implicitly added dummy events then fail. */
> > > > > +             if ((num_non_dummy == removed_non_dummy) &&
> > > > > +                 ((rec->num_parsed_dummy_events == 0) ||
> > > > > +                  (removed_dummy >= (num_dummy - rec->num_parsed_dummy_events)))) {
> > > > > +                     ui__error("Failure to open any events for recording.\n");
> > > > > +                     rc = -1;
> > > > > +                     goto out;
> > > > > +             }
> > > > > +     }
> > > >
> > > > Instead of couting dummy events, I wonder if it could check any
> > > > supported non-dummy events in the evlist.
> > > >
> > > >         if (skipped) {
> > > >                 bool found = false;
> > > >
> > > >                 evlist__for_each_entry_safe(evlist, tmp, pos) {
> > > >                         if (pos->skippable) {
> > > >                                 evlist__remove(evlist, pos);
> > > >                                 continue;
> > > >                         }
> > > >                         if (evsel__is_dummy_event(pos))
> > > >                                 continue;
> > > >                         found = true;
> > > >                 }
> > > >                 if (!found) {
> > > >                         ui__error("...");
> > > >                         rc = -1;
> > > >                         goto out;
> > > >                 }
> > > >                 /* recalculate the index */
> > > >         }
> > > >
> > > > Then it should do the same, no?  The corner case would be when users
> > > > specify dummy events in the command line (maybe to check permissions
> > > > by the exit code).
> > > >
> > > >   $ perf record -a -e dummy true
> > > >
> > > > If it fails to open, then 'skipped' set and 'found' not set so the
> > > > command will fail.  It it succeeds, then it doesn't set 'skipped'
> > > > and the command will exit with 0.
> > > >
> > > > Do I miss something?
> > >
> > > Yep, but it depends on what we want the behavior to be. Consider an
> > > event that doesn't support record and the dummy event which for the
> > > sake of argument will open here:
> > >
> > > $ perf record -a -e LLC-prefetch-read,dummy true
> > >
> > > In this case initially found is false, we then process
> > > LLC-prefetch-read which didn't open and remove it from the evlist.
> > > Next we process the dummy event that did open but because it was a
> > > dummy event found won't be set to true. The code will then proceed to
> > > fail (found == false) even though the dummy event did open. Were this
> > > cycles and not dummy:
> > >
> > > $ perf record -a -e LLC-prefetch-read,cycles true
> > >
> > > Then the expectation would be for this to proceed with a warning on
> > > LLC-prefetch-read and to record cycles. With your code dummy will
> > > behave differently to cycles as it will terminate perf record early.
> > > Does this matter? I'm not sure, but I was trying to make the events
> > > (dummy vs non-dummy) consistent.
> >
> > I'm not sure too.  Anyway it won't get any samples if all other
> > non-dummy events failed.  Then there are not much points to run the
> > perf record IMHO.  I think dummy event is special as you counted it
> > specifically so we don't need to worry about the special case too much.
> 
> So the two use-cases for dummy I can think of are:
> 1) deliberately recording/sampling sideband data as you don't care
> about any real samples,

Then it doesn't have other events and should not fail (or you don't
have the permission anyway).

> 2) a permission check.

Also it can be only with a dummy event and the check would work, right?

> My preference was for dummy to behave as close as possible to other
> "regular" events like cycles. This could matter when we script and
> test all events like with "perf all PMU test":
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat_all_pmu.sh?h=perf-tools-next

Do you think it'd fail with the above change?

> If my preference isn't wanted in favor of the simpler code I can make
> the change. The part of the series I want to land is making wildcarded
> and non-wildcarded event configurations consistent.

I prefer simpler code and we can fix it later if it ends up having any
failing real use cases.

Thanks,
Namhyung


