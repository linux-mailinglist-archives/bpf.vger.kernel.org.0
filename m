Return-Path: <bpf+bounces-48580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB9A09BE0
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 20:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E037A328E
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F94E214A95;
	Fri, 10 Jan 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdPkI3hx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196A222572;
	Fri, 10 Jan 2025 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736537199; cv=none; b=SJDiGPMtjMCrkYJCerhzeLSh8PUSaYwM6TauxdLDUNM1QAbezh5wbjeI+uPp2ZWyT/xEpKCJ0fGL+W0PSWEyaABsWmGnP+Oc5mupeoOmArjafPebpYRjlcaOUkQzThwv7YUiv1XPi4+5gVsi/Q9ejR8SaogIY3CjKSN35ImYQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736537199; c=relaxed/simple;
	bh=nykxuUtW5cZb8mQZt95vsTUg17pjlFd01Ue3uzqjE+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu3eFImMKxLtk0abz1kF5hiHZTtrI5qPJ4gW0gF3HDX+kh1KfV210fqtkC/jiXHp4g7QnfQWikvWCeyhGf0tcio783IUDDGaSwEtYn4h1hohOhk4MxE0weOHMJ218Gu4s9YgKbKiktdiakzfOV1ZspQsgJULEXjy215DF5ToQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdPkI3hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9693C4CEE7;
	Fri, 10 Jan 2025 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736537198;
	bh=nykxuUtW5cZb8mQZt95vsTUg17pjlFd01Ue3uzqjE+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdPkI3hxggWc7OXwOL0tiDlQ51BOp3vLXgOcRojceLGLuXfTb5gb2po8ChN4SYJmK
	 9CIvhaX/w1DQVl8xdDTLbAVzEk8ej5ZpuhAi7Ej3wxdZbZVgtlmA5oElgF/h9tByy8
	 8xcpAQMXbG9dgfJE3zOCiQle3jX16Xqf1W9coy6+E4I0s/NiqJ/RgIP0VW14kjwOO+
	 c3CfcaEv4pXegJmYh/MLCt/Lm8nToAhShSWX7I4eSawLo4Jb4ZKhdrEp27GtAY9p6K
	 Mkpy4U7hDiup6R1A8tMEtTAkQzeU3kfij7HoaNV/DjDfCVe4K0yndqQ0HFYH4k2fe9
	 6o5gdQdbQZ1qg==
Date: Fri, 10 Jan 2025 11:26:36 -0800
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
Message-ID: <Z4F0bKnCHCaqdvFw@google.com>
References: <20250109222109.567031-1-irogers@google.com>
 <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com>
 <Z4EsUAtOKZUzcw2S@x1>
 <CAP-5=fV2cYjxf6jvYcKkd=2wcQrbR=58qafiSJ-qzE17EmWqGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV2cYjxf6jvYcKkd=2wcQrbR=58qafiSJ-qzE17EmWqGQ@mail.gmail.com>

On Fri, Jan 10, 2025 at 08:42:02AM -0800, Ian Rogers wrote:
> On Fri, Jan 10, 2025 at 6:18 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Adding Linus to the CC list as he participated in this discussion in the
> > past, so a heads up about changes in this area that are being further
> > discussed.
> 
> Linus blocks my email so I'm not sure of the point.

That's unfortunate, but he should be able to see others' reply.

> 
> > On Thu, Jan 09, 2025 at 05:25:03PM -0800, Namhyung Kim wrote:
> > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > > Whilst for many tools it is an expected behavior that failure to open
> > > > a perf event is a failure, ARM decided to name PMU events the same as
> > > > legacy events and then failed to rename such events on a server uncore
> > > > SLC PMU. As perf's default behavior when no PMU is specified is to
> > > > open the event on all PMUs that advertise/"have" the event, this
> > > > yielded failures when trying to make the priority of legacy and
> > > > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > > > legacy event user on ARM hardware may find their event opened on an
> > > > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > > > such events which this patch implements. Rather than have the skipping
> > > > conditional on running on ARM, the skipping is done on all
> > > > architectures as such a fundamental behavioral difference could lead
> > > > to problems with tools built/depending on perf.
> > > >
> > > > An example of perf record failing to open events on x86 is:
> > > > ```
> > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > > Error:
> > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > "dmesg | grep -i perf" may provide additional information.
> > > >
> > > > Error:
> > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > "dmesg | grep -i perf" may provide additional information.
> > > >
> > > > Error:
> > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > The LLC-prefetch-read event is not supported.
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> > >
> > > I'm afraid this can be too noisy.
> >
> > Agreed.
> >
> > > > $ perf report --stats
> > > > Aggregated stats:
> > > >                TOTAL events:      17255
> > > >                 MMAP events:        284  ( 1.6%)
> > > >                 COMM events:       1961  (11.4%)
> > > >                 EXIT events:          1  ( 0.0%)
> > > >                 FORK events:       1960  (11.4%)
> > > >               SAMPLE events:         87  ( 0.5%)
> > > >                MMAP2 events:      12836  (74.4%)
> > > >              KSYMBOL events:         83  ( 0.5%)
> > > >            BPF_EVENT events:         36  ( 0.2%)
> > > >       FINISHED_ROUND events:          2  ( 0.0%)
> > > >             ID_INDEX events:          1  ( 0.0%)
> > > >           THREAD_MAP events:          1  ( 0.0%)
> > > >              CPU_MAP events:          1  ( 0.0%)
> > > >            TIME_CONV events:          1  ( 0.0%)
> > > >        FINISHED_INIT events:          1  ( 0.0%)
> > > > cycles stats:
> > > >               SAMPLE events:         87
> > > > ```
> > > >
> > > > If all events fail to open then the perf record will fail:
> > > > ```
> > > > $ perf record -e LLC-prefetch-read true
> > > > Error:
> > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > The LLC-prefetch-read event is not supported.
> > > > Error:
> > > > Failure to open any events for recording
> > > > ```
> > > >
> > > > As an evlist may have dummy events that open when all command line
> > > > events fail we ignore dummy events when detecting if at least some
> > > > events open. This still permits the dummy event on its own to be used
> > > > as a permission check:
> > > > ```
> > > > $ perf record -e dummy true
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.046 MB perf.data ]
> > > > ```
> > > > but allows failure when a dummy event is implicilty inserted or when
> > > > there are insufficient permissions to open it:
> > > > ```
> > > > $ perf record -e LLC-prefetch-read -a true
> > > > Error:
> > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > The LLC-prefetch-read event is not supported.
> > > > Error:
> > > > Failure to open any events for recording
> > > > ```
> > > >
> > > > The issue with legacy events is that on RISC-V they want the driver to
> > > > not have mappings from legacy to non-legacy config encodings for each
> > > > vendor/model due to size, complexity and difficulty to update. It was
> > > > reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> > > > was broken and the sysfs/json events should always take precedent,
> > > > however, it isn't clear this is still the case. It is the case that
> > > > without working around this issue a legacy event like cycles without a
> > > > PMU can encode differently than when specified with a PMU - the
> > > > non-PMU version favoring legacy encodings, the PMU one avoiding legacy
> > > > encodings.
> > > >
> > > > The patch removes events and then adjusts the idx value for each
> > > > evsel. This is done so that the dense xyarrays used for file
> > > > descriptors, etc. don't contain broken entries. As event opening
> > > > happens relatively late in the record process, use of the idx value
> > > > before the open will have become corrupted, so it is expected there
> > > > are latent bugs hidden behind this change - the change is best
> > > > effort. As the only vendor that has broken event names is ARM, this
> > > > will principally effect ARM users. They will also experience warning
> > > > messages like those above because of the uncore PMU advertising legacy
> > > > event names.
> > > >
> > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > Tested-by: James Clark <james.clark@linaro.org>
> > > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > > Tested-by: Atish Patra <atishp@rivosinc.com>
> > > > ---
> > > >  tools/perf/builtin-record.c | 47 ++++++++++++++++++++++++++++++++-----
> > > >  1 file changed, 41 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > > index 5db1aedf48df..c0b8249a3787 100644
> > > > --- a/tools/perf/builtin-record.c
> > > > +++ b/tools/perf/builtin-record.c
> > > > @@ -961,7 +961,6 @@ static int record__config_tracking_events(struct record *rec)
> > > >      */
> > > >     if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
> > > >         perf_pmus__num_core_pmus() > 1) {
> > > > -
> > > >             /*
> > > >              * User space tasks can migrate between CPUs, so when tracing
> > > >              * selected CPUs, sideband for all CPUs is still needed.
> > > > @@ -1366,6 +1365,7 @@ static int record__open(struct record *rec)
> > > >     struct perf_session *session = rec->session;
> > > >     struct record_opts *opts = &rec->opts;
> > > >     int rc = 0;
> > > > +   bool skipped = false;
> > > >
> > > >     evlist__for_each_entry(evlist, pos) {
> > > >  try_again:
> > > > @@ -1381,15 +1381,50 @@ static int record__open(struct record *rec)
> > > >                             pos = evlist__reset_weak_group(evlist, pos, true);
> > > >                             goto try_again;
> > > >                     }
> > > > -                   rc = -errno;
> > > >                     evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
> > > > -                   ui__error("%s\n", msg);
> > > > -                   goto out;
> > > > +                   ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
> > > > +                             evsel__name(pos), evsel__pmu_name(pos), msg);
> >
> > > How about changing it to pr_debug() and add below ...
> >
> > That sounds better.
> >
> > > > +                   pos->skippable = true;
> > > > +                   skipped = true;
> > > > +           } else {
> > > > +                   pos->supported = true;
> > > >             }
> > > > -
> > > > -           pos->supported = true;
> > > >     }
> > > >
> > > > +   if (skipped) {
> > > > +           struct evsel *tmp;
> > > > +           int idx = 0;
> > > > +           bool evlist_empty = true;
> > > > +
> > > > +           /* Remove evsels that failed to open and update indices. */
> > > > +           evlist__for_each_entry_safe(evlist, tmp, pos) {
> > > > +                   if (pos->skippable) {
> > > > +                           evlist__remove(evlist, pos);
> > > > +                           continue;
> > > > +                   }
> > > > +
> > > > +                   /*
> > > > +                    * Note, dummy events may be command line parsed or
> > > > +                    * added by the tool. We care about supporting `perf
> > > > +                    * record -e dummy` which may be used as a permission
> > > > +                    * check. Dummy events that are added to the command
> > > > +                    * line and opened along with other events that fail,
> > > > +                    * will still fail as if the dummy events were tool
> > > > +                    * added events for the sake of code simplicity.
> > > > +                    */
> > > > +                   if (!evsel__is_dummy_event(pos))
> > > > +                           evlist_empty = false;
> > > > +           }
> > > > +           evlist__for_each_entry(evlist, pos) {
> > > > +                   pos->core.idx = idx++;
> > > > +           }
> > > > +           /* If list is empty then fail. */
> > > > +           if (evlist_empty) {
> > > > +                   ui__error("Failure to open any events for recording.\n");
> > > > +                   rc = -1;
> > > > +                   goto out;
> > > > +           }
> >
> > > ... ?
> >
> > >               if (!verbose)
> > >                       ui__warning("Removed some unsupported events, use -v for details.\n");
> >
> > And even this one would be best left for cases where we can determine
> > that its a new situation, i.e. one that should work and not the ones we
> > know that will not work already and thus so far didn't alarm the user
> > into thinking something is wrong.
> >
> > Having the ones we know will fail as pr_debug() seems enough, I'd say.
> 
> This means that:
> ```
> $ perf record -e data_read,LLC-prefetch-read -a sleep 0.1
> ```
> will fail (as data_read is a memory controller event and the LLC
> doesn't support sampling) with something like:
> ```
> Error:
> Failure to open any events for recording
> ```
> Which feels a bit minimal. As I already mentioned, it is also a
> behavior change and so has the potential to break scripts dependent on
> the failure information.

I don't think it's about failure behavior, the concern is the error
messages.  It can take too much screen space when users give a long list
of invalid events.  And unfortunately the current error message for
checking dmesg is not very helpful.

Anyway you can add this line too: "Use -v to see the details."

> 
> A patch lowering the priority of error messages should be independent
> of the 4 changes here. I'd be happy if someone follows this series
> with a patch doing it.

I think the error behavior is a part of this change.

Thanks,
Namhyung


