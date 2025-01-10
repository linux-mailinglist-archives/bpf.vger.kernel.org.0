Return-Path: <bpf+bounces-48572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8708A097B3
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 17:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB7B16A3D0
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18896212FA7;
	Fri, 10 Jan 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5a3+1QB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5347212FA9
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527338; cv=none; b=HRlCV/XUygFMbZHNuWC5bITOmTptRRujOX/Pm4DGeruhcaduoYUXbFkDdKcI/RplzGNF5kfPRVV6Q6p/FNOxl5+VRfSCxBBuo0BQQBTIPlUA3oTHUVgXIlwazd/QuE+/0/rBkAK6Wr8toaR+iwBlwxVCu6jIjzEPS/FVNhs0hLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527338; c=relaxed/simple;
	bh=fpG9mYjWeGN1KsEGzpsDn9yzWmCLJQsblcuNlqRcnEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGEwaL+79gIv0tBtVda5UeKidNFXeknFouFTclXeRhGlZ0e+4h800Xqofq01CcaVixMp8Sviv69qk/0Ol7DGm+sZl+2ommGjP8NkEkpzxQMeFv/wu+2UcdZFMxWqJqFybXlaKnL0e6JTYVjaQ5StGbL8dmXd8C8Adz6iVW/zqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5a3+1QB; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso131975ab.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 08:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736527336; x=1737132136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8CUlmfZHD6xCE4DKXkLMJVyN9iWKjNPfZ+x6jvQz7Y=;
        b=A5a3+1QBflwHGUg1gSrDqFmjBwxjUCOvjudoDy1vwPukXdgUsTtZqb1v2NpCpBfNqf
         7XcsRhI7KAkJG9au7kPk+NGcgHL/yRGe3gwnsqXJgQq5Cn2VjbnfMOw5II0KxKFE9kSM
         UiXHcfuED9REVyrpm5/FH4NuS9j9DCosVDiGkXdkb0inU4Fzkvfxv12geLOhEmHvb2kh
         dVScO6az+Nffp/5U1pgWPDlmLGEQC5v6gQuo4Wre4wstZjJNCXV1GzDKWM/Y/ijrbhdY
         8BymGR6WQpz/sBvqGRPbOigKW04iL7kpLlofssMrYq0H2aHm1voXnziox2WWDPpuak8k
         TbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736527336; x=1737132136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8CUlmfZHD6xCE4DKXkLMJVyN9iWKjNPfZ+x6jvQz7Y=;
        b=edNtQTsW+iH2sP4cyhx/UnH0v6jGgpAiubgv7VP+meiOuEAWFjdwoTiKxQvVBegHeL
         azuBBDgU2ybHKLDfdQvdtm4LdMnsS2v4cR1Aq577UkkjF0T6IoEnBw/XvZ0OUgurWY5e
         Cn9GtWwUZbmIEQ1+FLYoQaOUDwolFcE7CDlUCFMh7H4kls5rALBWsO6g51kvzcHyDAzN
         XNOBJk5a/smIdXTQEbN/Kf5CoibTIjWxcxFfSMTq7vo2O05ZfJPgbnRVdfw5oe1m7z8q
         Aye+G/nb1G8s+tqdnDnicbAFRHdGcLBp636eJ1I3zwjdC0Za2bdXA0p7Dyl4HvaiktGk
         acxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmPNwgRjdtRl3fyXtErkElO6gRQGWZAFOErQyMUQP/aiItdnZ54LR98d7f2iZAse36ix4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zGA4/vyBJx/zbyASTgri3iNPlMlQM5Bu2dNerQu17h7uc3l8
	jARPjjCGSxgVo0kZ16ZRiPnvRxntVhw/Oyw45U34y9jdnXOMjsIHxAVvqGLKi/uAmG3HMdpM74j
	5sB1wGd5gFxgBM3j5vy+mvMEVUdpYz/eVhTmt
X-Gm-Gg: ASbGncvu57zw2L15J3rioi10thbLsMSIco0m4crZL0E4nZVaHHR9YJvLjo8pBZjI4S3
	0ukRGstOoDR1lp7Wc9e2/DdV715ViWux7la3iGciQf/GvfYQWh5QMX0MHe1LLg9vUyZGcYg==
X-Google-Smtp-Source: AGHT+IEl0OYmnEh0+1wL1JM4QrN+W0twx2ridIve7Ze3M7fSXS+/60WjOd9XOM8UXL4KUhrKG5NKiRVc6D82PUbrIsE=
X-Received: by 2002:a05:6e02:1566:b0:3a7:e04b:1fe2 with SMTP id
 e9e14a558f8ab-3ce58911315mr2954305ab.7.1736527335543; Fri, 10 Jan 2025
 08:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com> <Z4EsUAtOKZUzcw2S@x1>
In-Reply-To: <Z4EsUAtOKZUzcw2S@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 Jan 2025 08:42:02 -0800
X-Gm-Features: AbW1kvYgQfziA1AHeDnI7MEkfRNc-DyzjuslayLFLDWvDZdGpnw5MJszI0n8KKM
Message-ID: <CAP-5=fV2cYjxf6jvYcKkd=2wcQrbR=58qafiSJ-qzE17EmWqGQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that don't open
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
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

On Fri, Jan 10, 2025 at 6:18=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Adding Linus to the CC list as he participated in this discussion in the
> past, so a heads up about changes in this area that are being further
> discussed.

Linus blocks my email so I'm not sure of the point.

> On Thu, Jan 09, 2025 at 05:25:03PM -0800, Namhyung Kim wrote:
> > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > Whilst for many tools it is an expected behavior that failure to open
> > > a perf event is a failure, ARM decided to name PMU events the same as
> > > legacy events and then failed to rename such events on a server uncor=
e
> > > SLC PMU. As perf's default behavior when no PMU is specified is to
> > > open the event on all PMUs that advertise/"have" the event, this
> > > yielded failures when trying to make the priority of legacy and
> > > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > > legacy event user on ARM hardware may find their event opened on an
> > > uncore PMU which for perf record will fail. Arnaldo suggested skippin=
g
> > > such events which this patch implements. Rather than have the skippin=
g
> > > conditional on running on ARM, the skipping is done on all
> > > architectures as such a fundamental behavioral difference could lead
> > > to problems with tools built/depending on perf.
> > >
> > > An example of perf record failing to open events on x86 is:
> > > ```
> > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > Error:
> > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' =
which will be removed.
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument)=
 for event (data_read).
> > > "dmesg | grep -i perf" may provide additional information.
> > >
> > > Error:
> > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' =
which will be removed.
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument)=
 for event (data_read).
> > > "dmesg | grep -i perf" may provide additional information.
> > >
> > > Error:
> > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be =
removed.
> > > The LLC-prefetch-read event is not supported.
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> >
> > I'm afraid this can be too noisy.
>
> Agreed.
>
> > > $ perf report --stats
> > > Aggregated stats:
> > >                TOTAL events:      17255
> > >                 MMAP events:        284  ( 1.6%)
> > >                 COMM events:       1961  (11.4%)
> > >                 EXIT events:          1  ( 0.0%)
> > >                 FORK events:       1960  (11.4%)
> > >               SAMPLE events:         87  ( 0.5%)
> > >                MMAP2 events:      12836  (74.4%)
> > >              KSYMBOL events:         83  ( 0.5%)
> > >            BPF_EVENT events:         36  ( 0.2%)
> > >       FINISHED_ROUND events:          2  ( 0.0%)
> > >             ID_INDEX events:          1  ( 0.0%)
> > >           THREAD_MAP events:          1  ( 0.0%)
> > >              CPU_MAP events:          1  ( 0.0%)
> > >            TIME_CONV events:          1  ( 0.0%)
> > >        FINISHED_INIT events:          1  ( 0.0%)
> > > cycles stats:
> > >               SAMPLE events:         87
> > > ```
> > >
> > > If all events fail to open then the perf record will fail:
> > > ```
> > > $ perf record -e LLC-prefetch-read true
> > > Error:
> > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be =
removed.
> > > The LLC-prefetch-read event is not supported.
> > > Error:
> > > Failure to open any events for recording
> > > ```
> > >
> > > As an evlist may have dummy events that open when all command line
> > > events fail we ignore dummy events when detecting if at least some
> > > events open. This still permits the dummy event on its own to be used
> > > as a permission check:
> > > ```
> > > $ perf record -e dummy true
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.046 MB perf.data ]
> > > ```
> > > but allows failure when a dummy event is implicilty inserted or when
> > > there are insufficient permissions to open it:
> > > ```
> > > $ perf record -e LLC-prefetch-read -a true
> > > Error:
> > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be =
removed.
> > > The LLC-prefetch-read event is not supported.
> > > Error:
> > > Failure to open any events for recording
> > > ```
> > >
> > > The issue with legacy events is that on RISC-V they want the driver t=
o
> > > not have mappings from legacy to non-legacy config encodings for each
> > > vendor/model due to size, complexity and difficulty to update. It was
> > > reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> > > was broken and the sysfs/json events should always take precedent,
> > > however, it isn't clear this is still the case. It is the case that
> > > without working around this issue a legacy event like cycles without =
a
> > > PMU can encode differently than when specified with a PMU - the
> > > non-PMU version favoring legacy encodings, the PMU one avoiding legac=
y
> > > encodings.
> > >
> > > The patch removes events and then adjusts the idx value for each
> > > evsel. This is done so that the dense xyarrays used for file
> > > descriptors, etc. don't contain broken entries. As event opening
> > > happens relatively late in the record process, use of the idx value
> > > before the open will have become corrupted, so it is expected there
> > > are latent bugs hidden behind this change - the change is best
> > > effort. As the only vendor that has broken event names is ARM, this
> > > will principally effect ARM users. They will also experience warning
> > > messages like those above because of the uncore PMU advertising legac=
y
> > > event names.
> > >
> > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > Tested-by: James Clark <james.clark@linaro.org>
> > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > Tested-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >  tools/perf/builtin-record.c | 47 ++++++++++++++++++++++++++++++++---=
--
> > >  1 file changed, 41 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.=
c
> > > index 5db1aedf48df..c0b8249a3787 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -961,7 +961,6 @@ static int record__config_tracking_events(struct =
record *rec)
> > >      */
> > >     if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
> > >         perf_pmus__num_core_pmus() > 1) {
> > > -
> > >             /*
> > >              * User space tasks can migrate between CPUs, so when tra=
cing
> > >              * selected CPUs, sideband for all CPUs is still needed.
> > > @@ -1366,6 +1365,7 @@ static int record__open(struct record *rec)
> > >     struct perf_session *session =3D rec->session;
> > >     struct record_opts *opts =3D &rec->opts;
> > >     int rc =3D 0;
> > > +   bool skipped =3D false;
> > >
> > >     evlist__for_each_entry(evlist, pos) {
> > >  try_again:
> > > @@ -1381,15 +1381,50 @@ static int record__open(struct record *rec)
> > >                             pos =3D evlist__reset_weak_group(evlist, =
pos, true);
> > >                             goto try_again;
> > >                     }
> > > -                   rc =3D -errno;
> > >                     evsel__open_strerror(pos, &opts->target, errno, m=
sg, sizeof(msg));
> > > -                   ui__error("%s\n", msg);
> > > -                   goto out;
> > > +                   ui__error("Failure to open event '%s' on PMU '%s'=
 which will be removed.\n%s\n",
> > > +                             evsel__name(pos), evsel__pmu_name(pos),=
 msg);
>
> > How about changing it to pr_debug() and add below ...
>
> That sounds better.
>
> > > +                   pos->skippable =3D true;
> > > +                   skipped =3D true;
> > > +           } else {
> > > +                   pos->supported =3D true;
> > >             }
> > > -
> > > -           pos->supported =3D true;
> > >     }
> > >
> > > +   if (skipped) {
> > > +           struct evsel *tmp;
> > > +           int idx =3D 0;
> > > +           bool evlist_empty =3D true;
> > > +
> > > +           /* Remove evsels that failed to open and update indices. =
*/
> > > +           evlist__for_each_entry_safe(evlist, tmp, pos) {
> > > +                   if (pos->skippable) {
> > > +                           evlist__remove(evlist, pos);
> > > +                           continue;
> > > +                   }
> > > +
> > > +                   /*
> > > +                    * Note, dummy events may be command line parsed =
or
> > > +                    * added by the tool. We care about supporting `p=
erf
> > > +                    * record -e dummy` which may be used as a permis=
sion
> > > +                    * check. Dummy events that are added to the comm=
and
> > > +                    * line and opened along with other events that f=
ail,
> > > +                    * will still fail as if the dummy events were to=
ol
> > > +                    * added events for the sake of code simplicity.
> > > +                    */
> > > +                   if (!evsel__is_dummy_event(pos))
> > > +                           evlist_empty =3D false;
> > > +           }
> > > +           evlist__for_each_entry(evlist, pos) {
> > > +                   pos->core.idx =3D idx++;
> > > +           }
> > > +           /* If list is empty then fail. */
> > > +           if (evlist_empty) {
> > > +                   ui__error("Failure to open any events for recordi=
ng.\n");
> > > +                   rc =3D -1;
> > > +                   goto out;
> > > +           }
>
> > ... ?
>
> >               if (!verbose)
> >                       ui__warning("Removed some unsupported events, use=
 -v for details.\n");
>
> And even this one would be best left for cases where we can determine
> that its a new situation, i.e. one that should work and not the ones we
> know that will not work already and thus so far didn't alarm the user
> into thinking something is wrong.
>
> Having the ones we know will fail as pr_debug() seems enough, I'd say.

This means that:
```
$ perf record -e data_read,LLC-prefetch-read -a sleep 0.1
```
will fail (as data_read is a memory controller event and the LLC
doesn't support sampling) with something like:
```
Error:
Failure to open any events for recording
```
Which feels a bit minimal. As I already mentioned, it is also a
behavior change and so has the potential to break scripts dependent on
the failure information.

A patch lowering the priority of error messages should be independent
of the 4 changes here. I'd be happy if someone follows this series
with a patch doing it.

Thanks,
Ian

