Return-Path: <bpf+bounces-48956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8575DA129DF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE920188A070
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EDA1ADC6D;
	Wed, 15 Jan 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL+PuYkW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9B24A7ED;
	Wed, 15 Jan 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962308; cv=none; b=q3/iTf2IfXQCXpTd46vs9zoBsMTEM2fQNNKFOXp4IN5vGcI7+b+ThKysP9Izm5XsJaQoy0VlrRgaJdKZqhU59aEm3lfQJ0cS/4CZNPYL8TCdfZjJFdMuufi2Pd2em67cxcTr3D7XH/CnoVyGQTDFbskRPY599uZ9oBTn8KxQytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962308; c=relaxed/simple;
	bh=iYIeW7YKjgII85WDaAsAvZllWglZDH68LUkt7B2Zrcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm43FBuuCn54MHgSJe3BkWCl0WDiboYME6uP5ZkmjSMZUGj3lXJQdDIRYanSXnBPZWXqN9VBJsQ0EHIvfxD/RWp74H1Kae+/wJXpRfLQBG/+NAwGrOBtPzJCRyHMSw28sVRW3V5HbanD5GGF1hnbJgQA+R4QX3+16j/8aS+lP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL+PuYkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4797AC4CED1;
	Wed, 15 Jan 2025 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736962308;
	bh=iYIeW7YKjgII85WDaAsAvZllWglZDH68LUkt7B2Zrcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vL+PuYkWNGBO9zZt6LGYIjUihIsykd0WOrQQHLog5haAmtF3phPTitrM7pHRDytO9
	 CwBa+y6XXd3aFQ21jthxNHotkJPM0izcshsraSWdi5P7gv/L/eTVkIN8YH/VwcJ4JJ
	 HBYjLd7bJnz+yrkb5/mFJv2Lfm2HJx1+/kdYsVUgIINBqn4q5F7pifdn+CbMKbuPXO
	 Rryw3SqPoZJGIgqrOw891oWQay5Gx/JmAho9F6DlvxDYtcX272rhLXQCA+BqVAP44j
	 /RBvplQJxB4aHw4QgopwLeFIhUUarjWeax4PiYkdWFXCKGcyu02+9whw6kqYRrCJJw
	 m8m0NDuXH5+sg==
Date: Wed, 15 Jan 2025 09:31:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that
 don't open
Message-ID: <Z4fxAQAHZ9JtdHiL@google.com>
References: <20250109222109.567031-1-irogers@google.com>
 <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com>
 <Z4EsUAtOKZUzcw2S@x1>
 <CAP-5=fV2cYjxf6jvYcKkd=2wcQrbR=58qafiSJ-qzE17EmWqGQ@mail.gmail.com>
 <Z4F0bKnCHCaqdvFw@google.com>
 <CAP-5=fVn=0n=gN6ngMmBTry3A+US3z=bX5SzVP6Zs0J0t2HLuA@mail.gmail.com>
 <Z4V8ykyHErC89iYj@google.com>
 <CAP-5=fXSjLWd4j08Um7deqB3dHbk+1DpTpddr7wkYOUJTeScrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXSjLWd4j08Um7deqB3dHbk+1DpTpddr7wkYOUJTeScrg@mail.gmail.com>

On Mon, Jan 13, 2025 at 03:04:26PM -0800, Ian Rogers wrote:
> On Mon, Jan 13, 2025 at 12:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Fri, Jan 10, 2025 at 01:33:57PM -0800, Ian Rogers wrote:
> > > On Fri, Jan 10, 2025 at 11:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 10, 2025 at 08:42:02AM -0800, Ian Rogers wrote:
> > > > > On Fri, Jan 10, 2025 at 6:18 AM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > Adding Linus to the CC list as he participated in this discussion in the
> > > > > > past, so a heads up about changes in this area that are being further
> > > > > > discussed.
> > > > >
> > > > > Linus blocks my email so I'm not sure of the point.
> > > >
> > > > That's unfortunate, but he should be able to see others' reply.
> > > >
> > > > >
> > > > > > On Thu, Jan 09, 2025 at 05:25:03PM -0800, Namhyung Kim wrote:
> > > > > > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > > > > > > Whilst for many tools it is an expected behavior that failure to open
> > > > > > > > a perf event is a failure, ARM decided to name PMU events the same as
> > > > > > > > legacy events and then failed to rename such events on a server uncore
> > > > > > > > SLC PMU. As perf's default behavior when no PMU is specified is to
> > > > > > > > open the event on all PMUs that advertise/"have" the event, this
> > > > > > > > yielded failures when trying to make the priority of legacy and
> > > > > > > > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > > > > > > > legacy event user on ARM hardware may find their event opened on an
> > > > > > > > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > > > > > > > such events which this patch implements. Rather than have the skipping
> > > > > > > > conditional on running on ARM, the skipping is done on all
> > > > > > > > architectures as such a fundamental behavioral difference could lead
> > > > > > > > to problems with tools built/depending on perf.
> > > > > > > >
> > > > > > > > An example of perf record failing to open events on x86 is:
> > > > > > > > ```
> > > > > > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > > > > > > Error:
> > > > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> > > > > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > > > > > "dmesg | grep -i perf" may provide additional information.
> > > > > > > >
> > > > > > > > Error:
> > > > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> > > > > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > > > > > "dmesg | grep -i perf" may provide additional information.
> > > > > > > >
> > > > > > > > Error:
> > > > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > > > > > The LLC-prefetch-read event is not supported.
> > > > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> > > > > > >
> > > > > > > I'm afraid this can be too noisy.
> > > > > >
> > > > > > Agreed.
> > > > > >
> > > > > > > > $ perf report --stats
> > > > > > > > Aggregated stats:
> > > > > > > >                TOTAL events:      17255
> > > > > > > >                 MMAP events:        284  ( 1.6%)
> > > > > > > >                 COMM events:       1961  (11.4%)
> > > > > > > >                 EXIT events:          1  ( 0.0%)
> > > > > > > >                 FORK events:       1960  (11.4%)
> > > > > > > >               SAMPLE events:         87  ( 0.5%)
> > > > > > > >                MMAP2 events:      12836  (74.4%)
> > > > > > > >              KSYMBOL events:         83  ( 0.5%)
> > > > > > > >            BPF_EVENT events:         36  ( 0.2%)
> > > > > > > >       FINISHED_ROUND events:          2  ( 0.0%)
> > > > > > > >             ID_INDEX events:          1  ( 0.0%)
> > > > > > > >           THREAD_MAP events:          1  ( 0.0%)
> > > > > > > >              CPU_MAP events:          1  ( 0.0%)
> > > > > > > >            TIME_CONV events:          1  ( 0.0%)
> > > > > > > >        FINISHED_INIT events:          1  ( 0.0%)
> > > > > > > > cycles stats:
> > > > > > > >               SAMPLE events:         87
> > > > > > > > ```
> > > > > > > >
> > > > > > > > If all events fail to open then the perf record will fail:
> > > > > > > > ```
> > > > > > > > $ perf record -e LLC-prefetch-read true
> > > > > > > > Error:
> > > > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > > > > > The LLC-prefetch-read event is not supported.
> > > > > > > > Error:
> > > > > > > > Failure to open any events for recording
> > > > > > > > ```
> > > > > > > >
> > > > > > > > As an evlist may have dummy events that open when all command line
> > > > > > > > events fail we ignore dummy events when detecting if at least some
> > > > > > > > events open. This still permits the dummy event on its own to be used
> > > > > > > > as a permission check:
> > > > > > > > ```
> > > > > > > > $ perf record -e dummy true
> > > > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > > > [ perf record: Captured and wrote 0.046 MB perf.data ]
> > > > > > > > ```
> > > > > > > > but allows failure when a dummy event is implicilty inserted or when
> > > > > > > > there are insufficient permissions to open it:
> > > > > > > > ```
> > > > > > > > $ perf record -e LLC-prefetch-read -a true
> > > > > > > > Error:
> > > > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > > > > > The LLC-prefetch-read event is not supported.
> > > > > > > > Error:
> > > > > > > > Failure to open any events for recording
> > > > > > > > ```
> > > > > > > >
> > > > > > > > The issue with legacy events is that on RISC-V they want the driver to
> > > > > > > > not have mappings from legacy to non-legacy config encodings for each
> > > > > > > > vendor/model due to size, complexity and difficulty to update. It was
> > > > > > > > reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> > > > > > > > was broken and the sysfs/json events should always take precedent,
> > > > > > > > however, it isn't clear this is still the case. It is the case that
> > > > > > > > without working around this issue a legacy event like cycles without a
> > > > > > > > PMU can encode differently than when specified with a PMU - the
> > > > > > > > non-PMU version favoring legacy encodings, the PMU one avoiding legacy
> > > > > > > > encodings.
> > > > > > > >
> > > > > > > > The patch removes events and then adjusts the idx value for each
> > > > > > > > evsel. This is done so that the dense xyarrays used for file
> > > > > > > > descriptors, etc. don't contain broken entries. As event opening
> > > > > > > > happens relatively late in the record process, use of the idx value
> > > > > > > > before the open will have become corrupted, so it is expected there
> > > > > > > > are latent bugs hidden behind this change - the change is best
> > > > > > > > effort. As the only vendor that has broken event names is ARM, this
> > > > > > > > will principally effect ARM users. They will also experience warning
> > > > > > > > messages like those above because of the uncore PMU advertising legacy
> > > > > > > > event names.
> > > > > > > >
> > > > > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > > > Tested-by: James Clark <james.clark@linaro.org>
> > > > > > > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > > > > > > Tested-by: Atish Patra <atishp@rivosinc.com>
> > > > > > > > ---
> > > > > > > >  tools/perf/builtin-record.c | 47 ++++++++++++++++++++++++++++++++-----
> > > > > > > >  1 file changed, 41 insertions(+), 6 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > > > > > > index 5db1aedf48df..c0b8249a3787 100644
> > > > > > > > --- a/tools/perf/builtin-record.c
> > > > > > > > +++ b/tools/perf/builtin-record.c
> > > > > > > > @@ -961,7 +961,6 @@ static int record__config_tracking_events(struct record *rec)
> > > > > > > >      */
> > > > > > > >     if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
> > > > > > > >         perf_pmus__num_core_pmus() > 1) {
> > > > > > > > -
> > > > > > > >             /*
> > > > > > > >              * User space tasks can migrate between CPUs, so when tracing
> > > > > > > >              * selected CPUs, sideband for all CPUs is still needed.
> > > > > > > > @@ -1366,6 +1365,7 @@ static int record__open(struct record *rec)
> > > > > > > >     struct perf_session *session = rec->session;
> > > > > > > >     struct record_opts *opts = &rec->opts;
> > > > > > > >     int rc = 0;
> > > > > > > > +   bool skipped = false;
> > > > > > > >
> > > > > > > >     evlist__for_each_entry(evlist, pos) {
> > > > > > > >  try_again:
> > > > > > > > @@ -1381,15 +1381,50 @@ static int record__open(struct record *rec)
> > > > > > > >                             pos = evlist__reset_weak_group(evlist, pos, true);
> > > > > > > >                             goto try_again;
> > > > > > > >                     }
> > > > > > > > -                   rc = -errno;
> > > > > > > >                     evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
> > > > > > > > -                   ui__error("%s\n", msg);
> > > > > > > > -                   goto out;
> > > > > > > > +                   ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
> > > > > > > > +                             evsel__name(pos), evsel__pmu_name(pos), msg);
> > > > > >
> > > > > > > How about changing it to pr_debug() and add below ...
> > > > > >
> > > > > > That sounds better.
> > > > > >
> > > > > > > > +                   pos->skippable = true;
> > > > > > > > +                   skipped = true;
> > > > > > > > +           } else {
> > > > > > > > +                   pos->supported = true;
> > > > > > > >             }
> > > > > > > > -
> > > > > > > > -           pos->supported = true;
> > > > > > > >     }
> > > > > > > >
> > > > > > > > +   if (skipped) {
> > > > > > > > +           struct evsel *tmp;
> > > > > > > > +           int idx = 0;
> > > > > > > > +           bool evlist_empty = true;
> > > > > > > > +
> > > > > > > > +           /* Remove evsels that failed to open and update indices. */
> > > > > > > > +           evlist__for_each_entry_safe(evlist, tmp, pos) {
> > > > > > > > +                   if (pos->skippable) {
> > > > > > > > +                           evlist__remove(evlist, pos);
> > > > > > > > +                           continue;
> > > > > > > > +                   }
> > > > > > > > +
> > > > > > > > +                   /*
> > > > > > > > +                    * Note, dummy events may be command line parsed or
> > > > > > > > +                    * added by the tool. We care about supporting `perf
> > > > > > > > +                    * record -e dummy` which may be used as a permission
> > > > > > > > +                    * check. Dummy events that are added to the command
> > > > > > > > +                    * line and opened along with other events that fail,
> > > > > > > > +                    * will still fail as if the dummy events were tool
> > > > > > > > +                    * added events for the sake of code simplicity.
> > > > > > > > +                    */
> > > > > > > > +                   if (!evsel__is_dummy_event(pos))
> > > > > > > > +                           evlist_empty = false;
> > > > > > > > +           }
> > > > > > > > +           evlist__for_each_entry(evlist, pos) {
> > > > > > > > +                   pos->core.idx = idx++;
> > > > > > > > +           }
> > > > > > > > +           /* If list is empty then fail. */
> > > > > > > > +           if (evlist_empty) {
> > > > > > > > +                   ui__error("Failure to open any events for recording.\n");
> > > > > > > > +                   rc = -1;
> > > > > > > > +                   goto out;
> > > > > > > > +           }
> > > > > >
> > > > > > > ... ?
> > > > > >
> > > > > > >               if (!verbose)
> > > > > > >                       ui__warning("Removed some unsupported events, use -v for details.\n");
> > > > > >
> > > > > > And even this one would be best left for cases where we can determine
> > > > > > that its a new situation, i.e. one that should work and not the ones we
> > > > > > know that will not work already and thus so far didn't alarm the user
> > > > > > into thinking something is wrong.
> > > > > >
> > > > > > Having the ones we know will fail as pr_debug() seems enough, I'd say.
> > > > >
> > > > > This means that:
> > > > > ```
> > > > > $ perf record -e data_read,LLC-prefetch-read -a sleep 0.1
> > > > > ```
> > > > > will fail (as data_read is a memory controller event and the LLC
> > > > > doesn't support sampling) with something like:
> > > > > ```
> > > > > Error:
> > > > > Failure to open any events for recording
> > > > > ```
> > > > > Which feels a bit minimal. As I already mentioned, it is also a
> > > > > behavior change and so has the potential to break scripts dependent on
> > > > > the failure information.
> > > >
> > > > I don't think it's about failure behavior, the concern is the error
> > > > messages.  It can take too much screen space when users give a long list
> > > > of invalid events.  And unfortunately the current error message for
> > > > checking dmesg is not very helpful.
> > >
> > > Making the dmesg message more useful is a separate issue. The error
> >
> > Sure.
> >
> > > message only happens when things are broken and I think having an
> > > error message is better than none, or somehow having to know to wade
> > > through verbose output. I think this is very clear in:
> > > https://lore.kernel.org/lkml/CAP-5=fVr43v8gkqi8SXVaNKnkO+cooQVqx3xUFJ-BtgxGHX90g@mail.gmail.com/
> > >
> > > > Anyway you can add this line too: "Use -v to see the details."
> > >
> > > So silently failing and then expecting users to scrape verbose output
> > > is a fairly significant behavior change for the tool.
> >
> > I'm not saying I want silent failures.  It should say it fails to parse
> > or open some events.  But I think it needs to care about repeating
> > failure messages.
> >
> > >
> > > > >
> > > > > A patch lowering the priority of error messages should be independent
> > > > > of the 4 changes here. I'd be happy if someone follows this series
> > > > > with a patch doing it.
> > > >
> > > > I think the error behavior is a part of this change.
> > >
> > > I disagree with it, so I think you need to address my comments.
> >
> > You are changing the error behavior by skipping failed events then the
> > relevant error messages should be handled properly in this patchset.
> 
> I'm not sure what you are asking and I'm not sure why it matters?
> Previously you'd asked for all the output to be moved under verbose.
> 
> If I specify an event that doesn't work with perf record today then it
> fails. With this patch it fails too. If that event is a core PMU event
> then there will be an error message for each core PMU that doesn't
> support the event. So I get 2 error messages on hybrid. This doesn't
> feel egregious or warrant a new error message mechanism. I would like
> it so that evsels supported 1 or more PMUs, in which case this would
> be 1 error message.
> 
> If I specify perf record today on an uncore event then perf record
> fails and I get 1 error message for the uncore PMU. The new behavior
> will be to get 1 error message per uncore PMU. If I'm on a server with
> 10s of uncore PMUs then maybe the message is spammy, but the command
> fails today and will continue to fail with this series. I don't see a
> motivation to change or optimize for this case and again, evsels that
> support >1 PMU would be the most appropriate fix.
> 
> The only case where there is no message today but would be with this
> patch series is for cycles on ARM's neoverse. There will be one
> warning for the evsel on the SLC PMU. That's one warning and not many.
> 
> As I've said, if you want a more elaborate error reporting system then
> take these patches and add it to them. There's a larger refactor to
> make evsels support >1 PMU that would clean up the many events on
> server uncore PMUs issue, but that shouldn't be part of this series
> nor gate it. If you are trying to perf record on uncore PMUs then you
> already have problems and optimizing the error messages for your
> mistake, I don't get why it matters?

What about with multiple events in the command line - one of them
failing with >1 PMUs and the command now succeeds?

Thanks,
Namhyung


