Return-Path: <bpf+bounces-48225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC8A052EA
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 06:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1C166D9E
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 05:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DF21A0BED;
	Wed,  8 Jan 2025 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxqf/sNy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F819CC37
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736315766; cv=none; b=DlaUAkvxjrQqlOEv+yM7rA2WPUUyKx1CKSEgNmof8dpIfmnOFMLnJzLyKsSbczLsfladUqin5KNJcYS6+dxZJy8HxTDtXGm08qCikPJObTP/7Hj6NToS1zY0XOOUgNldO+ZyGFzFqFXqxh9M15BIVhH4tT4iJvFojl2PUE6FyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736315766; c=relaxed/simple;
	bh=4Dk4sjDEmA4bvhqhaaZNUppThZV/mWq0rf1crxz2BZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJPkMBJ/q/ncT/pL2VA3rQNvIvFwOJ7I4h6mnKWDCfj7RPpSQQfMDHW1eTqUjsLataaW04fJHVPJ2b0/t+cTlm5sueVmuuHL4KmOHbweUr0CmTuiqMF+3xFu+vlfyNiz4as1M70FufWaa4LFqtzx7qshI+ot5X22tEw9ldXIeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxqf/sNy; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so74905ab.0
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 21:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736315763; x=1736920563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZOzw29TbOcaTenvicUmtZiH45KvH8RJU1bc5tPWnZ0=;
        b=fxqf/sNy591xxeTrj6PMLOvOYBKxPkoqdzc36jgAPoLlXPHbHNHUBScT2UCMDdGz29
         hCLayx3A3JMJysByFXF56is8lIc7P72Y2JUO9bbn7AQ/kdA/sV00IE9TqrW+7A2OmRIn
         +qm8shvQpxJDgZ9ct1y5jazTczxbPs5UI5lC1rNv0w/On3bQFpQevj0mFP2ko8qjHR3I
         gAXDSuAUYV/ClXfWmUTH/UjQQ7Wsm5ct0McN8+Gc5XL2UfDwCm4wVpPa0h+IX9LMApyL
         sE8ff+zdYDzRmPDzN2inX+UuJEMFiO/1K2CgDLzBEj2GzREnVVXA9hHex9d6mcI4RfRK
         Xxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736315763; x=1736920563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZOzw29TbOcaTenvicUmtZiH45KvH8RJU1bc5tPWnZ0=;
        b=diRK/MYt1H1wFx1LWNLbcKaSPc4VLDKbtKdHLB/EGbq/lAGbOoI9CvBwsPIIhAtvzB
         ioliVr89dWPKQb6hXCwantW9dWGLVLakhP/+LldLnrD9Slt5AKEdKFha8hgYMqWowkBE
         20xAUpt4Iky8W8+KL8umSKujTcTniA5BrNCBezGwQt5A+6s0DjqeP+UzF6oBUMJuQ/1x
         GdEkdGyFJil6+h8RHPm6JTSJl7ha9SdC0kTomr6A5WZa9PI4U0AnZCdvIBKkms2FsLFh
         ek916jPlFeC4H1xehJpNAY2Ewg/4NVo+9vZiwmk+EZEkdXx8YGGzXJ7DS8nrBZdGj7w6
         WAUA==
X-Forwarded-Encrypted: i=1; AJvYcCUygaHvVipU6jfi+vkElnHPgBB5AOA/4RxCrwEhvqDIpV2zdfmNitHBA8nfMv0R9jZvK3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YQYPCRYqrksGh/UUaRGghZIGo+kkH1Wn/kt6ZWyFc1Ek2SX9
	CdKPX2nh6KuLqwkztjEdjdaW+UVKBTmx93H8rb1eFum8qqp6UIr8XvMCgWo6KVeF9XY1ZVzm3SS
	usrVsBAJS7UeiUejuVVyhc/Blhd9pa1KAETxh
X-Gm-Gg: ASbGncs5c6PmnohEpD6ZvW6XZw49p4IuyyHWTIRgI5a8B9zhUw3mmQdF5vIv70YCzkN
	rMmD+x94sD6zPUVP2Xh4DUD3INiVdk5DqSi/k9sA=
X-Google-Smtp-Source: AGHT+IFeXsBTqNdLx5CxN3UeHgpJoZQda1EiWT5aDNM3jyLdNUBhg2g9KCFltdbrL8jveDztpDPfl2/ovpOAoFN41XI=
X-Received: by 2002:a05:6e02:1d8c:b0:3ce:3a03:3e9c with SMTP id
 e9e14a558f8ab-3ce3af47b94mr2014295ab.2.1736315763197; Tue, 07 Jan 2025
 21:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107180854.770470-1-irogers@google.com> <20250107180854.770470-4-irogers@google.com>
 <Z32CeUuxt4ASJeRe@google.com> <CAP-5=fUqbPX4RLSLzw1UJ9NycOh8r5o4TxLfu2RRxooPG0gUtA@mail.gmail.com>
 <Z33DSLHzCpEVrAdy@google.com>
In-Reply-To: <Z33DSLHzCpEVrAdy@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 21:55:51 -0800
X-Gm-Features: AbW1kvaZ0Fq1DV03fBBaRq_KS8VYMm_PgG0ejhaZ2brbuszj9BQAAWcZBxFeGjI
Message-ID: <CAP-5=fUxiGhXs55KHnQgXHbOy46Z_16VEgpfJ0ha8UcUXxqvOw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] perf record: Skip don't fail for events that don't open
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jan 07, 2025 at 12:34:25PM -0800, Ian Rogers wrote:
> > On Tue, Jan 7, 2025 at 11:37=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, Jan 07, 2025 at 10:08:53AM -0800, Ian Rogers wrote:
> > > > Whilst for many tools it is an expected behavior that failure to op=
en
> > > > a perf event is a failure, ARM decided to name PMU events the same =
as
> > > > legacy events and then failed to rename such events on a server unc=
ore
> > > > SLC PMU. As perf's default behavior when no PMU is specified is to
> > > > open the event on all PMUs that advertise/"have" the event, this
> > > > yielded failures when trying to make the priority of legacy and
> > > > sysfs/json events uniform - something requested by RISC-V and ARM. =
A
> > > > legacy event user on ARM hardware may find their event opened on an
> > > > uncore PMU which for perf record will fail. Arnaldo suggested skipp=
ing
> > > > such events which this patch implements. Rather than have the skipp=
ing
> > > > conditional on running on ARM, the skipping is done on all
> > > > architectures as such a fundamental behavioral difference could lea=
d
> > > > to problems with tools built/depending on perf.
> > > >
> > > > An example of perf record failing to open events on x86 is:
> > > > ```
> > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > > Error:
> > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0=
' which will be removed.
> > > > The sys_perf_event_open() syscall returned with 22 (Invalid argumen=
t) for event (data_read).
> > > > "dmesg | grep -i perf" may provide additional information.
> > > >
> > > > Error:
> > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1=
' which will be removed.
> > > > The sys_perf_event_open() syscall returned with 22 (Invalid argumen=
t) for event (data_read).
> > > > "dmesg | grep -i perf" may provide additional information.
> > > >
> > > > Error:
> > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will b=
e removed.
> > > > The LLC-prefetch-read event is not supported.
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> > > >
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
> > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will b=
e removed.
> > > > The LLC-prefetch-read event is not supported.
> > > > Error:
> > > > Failure to open any events for recording
> > > > ```
> > > >
> > > > This is done by detecting if dummy events were implicitly added by
> > > > perf and seeing if the evlist is empty without them. This allows th=
e
> > > > dummy event still to be recorded:
> > > > ```
> > > > $ perf record -e dummy true
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.046 MB perf.data ]
> > > > ```
> > > > but fail when inserted:
> > > > ```
> > > > $ perf record -e LLC-prefetch-read -a true
> > > > Error:
> > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will b=
e removed.
> > > > The LLC-prefetch-read event is not supported.
> > > > Error:
> > > > Failure to open any events for recording
> > > > ```
> > > >
> > > > The issue with legacy events is that on RISC-V they want the driver=
 to
> > > > not have mappings from legacy to non-legacy config encodings for ea=
ch
> > > > vendor/model due to size, complexity and difficulty to update. It w=
as
> > > > reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> > > > was broken and the sysfs/json events should always take precedent,
> > > > however, it isn't clear this is still the case. It is the case that
> > > > without working around this issue a legacy event like cycles withou=
t a
> > > > PMU can encode differently than when specified with a PMU - the
> > > > non-PMU version favoring legacy encodings, the PMU one avoiding leg=
acy
> > > > encodings.
> > > >
> > > > The patch removes events and then adjusts the idx value for each
> > > > evsel. This is done so that the dense xyarrays used for file
> > > > descriptors, etc. don't contain broken entries. As event opening
> > > > happens relatively late in the record process, use of the idx value
> > > > before the open will have become corrupted, so it is expected there
> > > > are latent bugs hidden behind this change - the change is best
> > > > effort. As the only vendor that has broken event names is ARM, this
> > > > will principally effect ARM users. They will also experience warnin=
g
> > > > messages like those above because of the uncore PMU advertising leg=
acy
> > > > event names.
> > > >
> > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > Tested-by: James Clark <james.clark@linaro.org>
> > > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > > Tested-by: Atish Patra <atishp@rivosinc.com>
> > > > ---
> > > >  tools/perf/builtin-record.c | 54 ++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 48 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-recor=
d.c
> > > > index 5db1aedf48df..b3f06638f3c6 100644
> > > > --- a/tools/perf/builtin-record.c
> > > > +++ b/tools/perf/builtin-record.c
> > > > @@ -161,6 +161,7 @@ struct record {
> > > >       struct evlist           *sb_evlist;
> > > >       pthread_t               thread_id;
> > > >       int                     realtime_prio;
> > > > +     int                     num_parsed_dummy_events;
> > > >       bool                    switch_output_event_set;
> > > >       bool                    no_buildid;
> > > >       bool                    no_buildid_set;
> > > > @@ -961,7 +962,6 @@ static int record__config_tracking_events(struc=
t record *rec)
> > > >        */
> > > >       if (opts->target.initial_delay || target__has_cpu(&opts->targ=
et) ||
> > > >           perf_pmus__num_core_pmus() > 1) {
> > > > -
> > > >               /*
> > > >                * User space tasks can migrate between CPUs, so when=
 tracing
> > > >                * selected CPUs, sideband for all CPUs is still need=
ed.
> > > > @@ -1366,6 +1366,7 @@ static int record__open(struct record *rec)
> > > >       struct perf_session *session =3D rec->session;
> > > >       struct record_opts *opts =3D &rec->opts;
> > > >       int rc =3D 0;
> > > > +     bool skipped =3D false;
> > > >
> > > >       evlist__for_each_entry(evlist, pos) {
> > > >  try_again:
> > > > @@ -1381,15 +1382,50 @@ static int record__open(struct record *rec)
> > > >                               pos =3D evlist__reset_weak_group(evli=
st, pos, true);
> > > >                               goto try_again;
> > > >                       }
> > > > -                     rc =3D -errno;
> > > >                       evsel__open_strerror(pos, &opts->target, errn=
o, msg, sizeof(msg));
> > > > -                     ui__error("%s\n", msg);
> > > > -                     goto out;
> > > > +                     ui__error("Failure to open event '%s' on PMU =
'%s' which will be removed.\n%s\n",
> > > > +                               evsel__name(pos), evsel__pmu_name(p=
os), msg);
> > > > +                     pos->skippable =3D true;
> > > > +                     skipped =3D true;
> > > > +             } else {
> > > > +                     pos->supported =3D true;
> > > >               }
> > > > -
> > > > -             pos->supported =3D true;
> > > >       }
> > > >
> > > > +     if (skipped) {
> > > > +             struct evsel *tmp;
> > > > +             int idx =3D 0, num_dummy =3D 0, num_non_dummy =3D 0,
> > > > +                 removed_dummy =3D 0, removed_non_dummy =3D 0;
> > > > +
> > > > +             /* Remove evsels that failed to open and update indic=
es. */
> > > > +             evlist__for_each_entry_safe(evlist, tmp, pos) {
> > > > +                     if (evsel__is_dummy_event(pos))
> > > > +                             num_dummy++;
> > > > +                     else
> > > > +                             num_non_dummy++;
> > > > +
> > > > +                     if (!pos->skippable)
> > > > +                             continue;
> > > > +
> > > > +                     if (evsel__is_dummy_event(pos))
> > > > +                             removed_dummy++;
> > > > +                     else
> > > > +                             removed_non_dummy++;
> > > > +
> > > > +                     evlist__remove(evlist, pos);
> > > > +             }
> > > > +             evlist__for_each_entry(evlist, pos) {
> > > > +                     pos->core.idx =3D idx++;
> > > > +             }
> > > > +             /* If list is empty except implicitly added dummy eve=
nts then fail. */
> > > > +             if ((num_non_dummy =3D=3D removed_non_dummy) &&
> > > > +                 ((rec->num_parsed_dummy_events =3D=3D 0) ||
> > > > +                  (removed_dummy >=3D (num_dummy - rec->num_parsed=
_dummy_events)))) {
> > > > +                     ui__error("Failure to open any events for rec=
ording.\n");
> > > > +                     rc =3D -1;
> > > > +                     goto out;
> > > > +             }
> > > > +     }
> > >
> > > Instead of couting dummy events, I wonder if it could check any
> > > supported non-dummy events in the evlist.
> > >
> > >         if (skipped) {
> > >                 bool found =3D false;
> > >
> > >                 evlist__for_each_entry_safe(evlist, tmp, pos) {
> > >                         if (pos->skippable) {
> > >                                 evlist__remove(evlist, pos);
> > >                                 continue;
> > >                         }
> > >                         if (evsel__is_dummy_event(pos))
> > >                                 continue;
> > >                         found =3D true;
> > >                 }
> > >                 if (!found) {
> > >                         ui__error("...");
> > >                         rc =3D -1;
> > >                         goto out;
> > >                 }
> > >                 /* recalculate the index */
> > >         }
> > >
> > > Then it should do the same, no?  The corner case would be when users
> > > specify dummy events in the command line (maybe to check permissions
> > > by the exit code).
> > >
> > >   $ perf record -a -e dummy true
> > >
> > > If it fails to open, then 'skipped' set and 'found' not set so the
> > > command will fail.  It it succeeds, then it doesn't set 'skipped'
> > > and the command will exit with 0.
> > >
> > > Do I miss something?
> >
> > Yep, but it depends on what we want the behavior to be. Consider an
> > event that doesn't support record and the dummy event which for the
> > sake of argument will open here:
> >
> > $ perf record -a -e LLC-prefetch-read,dummy true
> >
> > In this case initially found is false, we then process
> > LLC-prefetch-read which didn't open and remove it from the evlist.
> > Next we process the dummy event that did open but because it was a
> > dummy event found won't be set to true. The code will then proceed to
> > fail (found =3D=3D false) even though the dummy event did open. Were th=
is
> > cycles and not dummy:
> >
> > $ perf record -a -e LLC-prefetch-read,cycles true
> >
> > Then the expectation would be for this to proceed with a warning on
> > LLC-prefetch-read and to record cycles. With your code dummy will
> > behave differently to cycles as it will terminate perf record early.
> > Does this matter? I'm not sure, but I was trying to make the events
> > (dummy vs non-dummy) consistent.
>
> I'm not sure too.  Anyway it won't get any samples if all other
> non-dummy events failed.  Then there are not much points to run the
> perf record IMHO.  I think dummy event is special as you counted it
> specifically so we don't need to worry about the special case too much.

So the two use-cases for dummy I can think of are:
1) deliberately recording/sampling sideband data as you don't care
about any real samples,
2) a permission check.
My preference was for dummy to behave as close as possible to other
"regular" events like cycles. This could matter when we script and
test all events like with "perf all PMU test":
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat_all_pmu.sh?h=3Dperf-tools-next
If my preference isn't wanted in favor of the simpler code I can make
the change. The part of the series I want to land is making wildcarded
and non-wildcarded event configurations consistent.

Thanks,
Ian

