Return-Path: <bpf+bounces-48964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63772A12A51
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC83161D66
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A11D5AA0;
	Wed, 15 Jan 2025 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="15CGV7VK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED31D54F4
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963835; cv=none; b=bDiTuJh2ho4npDK36Wezg+zqj0J0XF5uZxzu26PnvWWMDTTGBDDDrbij7iTq1lp9NVgge4TzEBXR6P17SJCQ+C5CiltH3JgBK04oAUjJBXrhR7HGL0oukMvz7/lLynq/33XBqROFBbyZfIMZb5j6ylYkZGY+MKSwDxWFAwO3X4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963835; c=relaxed/simple;
	bh=pZWu44X+MbAIPZKXqptgcSJDVzlWA6ylvQTrBdJM0DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4tYMLxA1vSZROiePAVxjUzVnenKLqF1wxB2JtAoFW5L3H0OyjPs/qap1rIdC1WVaGaVmM0zYwdNEdFaLGq9HhBxJ6bScGWBnQjDm3b5CSoak3nmt53GsxSr1ffNxvW+7lDoAiYqqpNQtgOwKB3G9HdQJoDWQF8QDBzdRi3vboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=15CGV7VK; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a814c54742so1455ab.1
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 09:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736963831; x=1737568631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0P87f/nohS+qbyRd2Pf0/vjw2dfyqlfrKbFQ/xx3Ok=;
        b=15CGV7VKbrCguDfnxjpY+gtyKn1700IKKBoFOLdaDpXmZpoMI2T+scV02jawigBx0n
         hPDrPamFm59LNf55x36LiEBGJSjW6Q4YoDsxGPGshcRDaMXLaI13SpRuVTOGFEvE3hdy
         9pSA5w2Vp+m9w/ZxWdGrYvhJKKmuxUnrPSKWlcs60GNOnaE3eacPceYS8b/iytd/WbTu
         7Dytl1r8sR+Et8/5+1IyZF/Ip7LiUpBW/2xi3tXo6t5ft/hIqWUgiAGxqOlAYqZP/u96
         5L/A0ebNaQyRaDvhXqLD64vYJtfqUW/QP2skT4YrTHQntwLsLSp5/8WN1GUUam44lQHM
         ZT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963831; x=1737568631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0P87f/nohS+qbyRd2Pf0/vjw2dfyqlfrKbFQ/xx3Ok=;
        b=GCT+kD9qNkyts85vCiU+mo44PWtrKS2nPS48D8m++Tx/6CIYETI+2qeKo7h98mDssz
         9OpezF05To7W2aYEkKWMFICH+SiUoyq0t8CbnI9gra0NIimjdGOm76tFP/p8UGZWA2Aw
         bvAIPQ7Lp6S2Lir87XsOMazVxpd66PMfuW4w1DVLCkMMZ95TqQiAl+NJYNfGXsc+ickR
         EeM/V2vJTD5jF/ps/oBY0izHIvT6YYb3eY6B6BOn5NtnltqhntHHo9v4TcExNPJN3cPs
         3370kamRthj/HrmYU3ktzN/XSRIpp8BIFB4il9YeIhb73W+jyfNr0pn6z7eu5unoxCZK
         mArA==
X-Forwarded-Encrypted: i=1; AJvYcCWDj858qPoBN4Ugsbp3cpSfLvnZojiO/CusCOcaYuEm49qJhV3nlUOu2ECN5XT1KgMsaQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaM9Hp4Aw36hAUVNYB2TPylGiVpvX4LosLtJSXCq6pEYRb86Jp
	ssVJtE7S/d/cVcwJtKcKsrndlSQuwX4cjzFt4IzXTLSeEu5Qh4oRx/qbhaqgQ82EpVlU6kMGWsp
	4HUWWMZcD6tHMSX5KjW4yHp3fZ1tUYghbhkBG
X-Gm-Gg: ASbGncsTcK7MJ1JGqVi8UDkNOHiSwOHJnivG5Nv1VnnFUoZiX2ksz5/tgnuZpDZavbn
	PgZlIVkw8sCINVSrN/tZ9sRNK1qcNMJSk0/XcXVPW1X8UGYB0g4gt17qjwykiRa/DAMDdBA==
X-Google-Smtp-Source: AGHT+IHPpkEkEWCNHk0rmjcg49AYml8meab4Zw7+8k0BHhFKyVhtjQ3bmcYHxqWL6Em902B1aHzzbkp92mQz+lhulR4=
X-Received: by 2002:a05:6e02:1566:b0:3ce:464a:fd2d with SMTP id
 e9e14a558f8ab-3ce84a8d60dmr4578095ab.28.1736963830918; Wed, 15 Jan 2025
 09:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com> <Z4EsUAtOKZUzcw2S@x1> <CAP-5=fV2cYjxf6jvYcKkd=2wcQrbR=58qafiSJ-qzE17EmWqGQ@mail.gmail.com>
 <Z4F0bKnCHCaqdvFw@google.com> <CAP-5=fVn=0n=gN6ngMmBTry3A+US3z=bX5SzVP6Zs0J0t2HLuA@mail.gmail.com>
 <Z4V8ykyHErC89iYj@google.com> <CAP-5=fXSjLWd4j08Um7deqB3dHbk+1DpTpddr7wkYOUJTeScrg@mail.gmail.com>
 <Z4fxAQAHZ9JtdHiL@google.com>
In-Reply-To: <Z4fxAQAHZ9JtdHiL@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jan 2025 09:56:59 -0800
X-Gm-Features: AbW1kvZ6RMtj_xFpkqhgWTolKcb5feDKvTRqbKjTWUPP0I25LCxWnR4MXLm-hZM
Message-ID: <CAP-5=fUz6Nkj+iRuAjjTGXib==jYCvqopa4Zg7TK2MAT7Ns+iA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that don't open
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
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

On Wed, Jan 15, 2025 at 9:31=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jan 13, 2025 at 03:04:26PM -0800, Ian Rogers wrote:
> > On Mon, Jan 13, 2025 at 12:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Fri, Jan 10, 2025 at 01:33:57PM -0800, Ian Rogers wrote:
> > > > On Fri, Jan 10, 2025 at 11:26=E2=80=AFAM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > >
> > > > > On Fri, Jan 10, 2025 at 08:42:02AM -0800, Ian Rogers wrote:
> > > > > > On Fri, Jan 10, 2025 at 6:18=E2=80=AFAM Arnaldo Carvalho de Mel=
o
> > > > > > <acme@kernel.org> wrote:
> > > > > > >
> > > > > > > Adding Linus to the CC list as he participated in this discus=
sion in the
> > > > > > > past, so a heads up about changes in this area that are being=
 further
> > > > > > > discussed.
> > > > > >
> > > > > > Linus blocks my email so I'm not sure of the point.
> > > > >
> > > > > That's unfortunate, but he should be able to see others' reply.
> > > > >
> > > > > >
> > > > > > > On Thu, Jan 09, 2025 at 05:25:03PM -0800, Namhyung Kim wrote:
> > > > > > > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > > > > > > > Whilst for many tools it is an expected behavior that fai=
lure to open
> > > > > > > > > a perf event is a failure, ARM decided to name PMU events=
 the same as
> > > > > > > > > legacy events and then failed to rename such events on a =
server uncore
> > > > > > > > > SLC PMU. As perf's default behavior when no PMU is specif=
ied is to
> > > > > > > > > open the event on all PMUs that advertise/"have" the even=
t, this
> > > > > > > > > yielded failures when trying to make the priority of lega=
cy and
> > > > > > > > > sysfs/json events uniform - something requested by RISC-V=
 and ARM. A
> > > > > > > > > legacy event user on ARM hardware may find their event op=
ened on an
> > > > > > > > > uncore PMU which for perf record will fail. Arnaldo sugge=
sted skipping
> > > > > > > > > such events which this patch implements. Rather than have=
 the skipping
> > > > > > > > > conditional on running on ARM, the skipping is done on al=
l
> > > > > > > > > architectures as such a fundamental behavioral difference=
 could lead
> > > > > > > > > to problems with tools built/depending on perf.
> > > > > > > > >
> > > > > > > > > An example of perf record failing to open events on x86 i=
s:
> > > > > > > > > ```
> > > > > > > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sl=
eep 0.1
> > > > > > > > > Error:
> > > > > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free=
_running_0' which will be removed.
> > > > > > > > > The sys_perf_event_open() syscall returned with 22 (Inval=
id argument) for event (data_read).
> > > > > > > > > "dmesg | grep -i perf" may provide additional information=
.
> > > > > > > > >
> > > > > > > > > Error:
> > > > > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free=
_running_1' which will be removed.
> > > > > > > > > The sys_perf_event_open() syscall returned with 22 (Inval=
id argument) for event (data_read).
> > > > > > > > > "dmesg | grep -i perf" may provide additional information=
.
> > > > > > > > >
> > > > > > > > > Error:
> > > > > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' wh=
ich will be removed.
> > > > > > > > > The LLC-prefetch-read event is not supported.
> > > > > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 =
samples) ]
> > > > > > > >
> > > > > > > > I'm afraid this can be too noisy.
> > > > > > >
> > > > > > > Agreed.
> > > > > > >
> > > > > > > > > $ perf report --stats
> > > > > > > > > Aggregated stats:
> > > > > > > > >                TOTAL events:      17255
> > > > > > > > >                 MMAP events:        284  ( 1.6%)
> > > > > > > > >                 COMM events:       1961  (11.4%)
> > > > > > > > >                 EXIT events:          1  ( 0.0%)
> > > > > > > > >                 FORK events:       1960  (11.4%)
> > > > > > > > >               SAMPLE events:         87  ( 0.5%)
> > > > > > > > >                MMAP2 events:      12836  (74.4%)
> > > > > > > > >              KSYMBOL events:         83  ( 0.5%)
> > > > > > > > >            BPF_EVENT events:         36  ( 0.2%)
> > > > > > > > >       FINISHED_ROUND events:          2  ( 0.0%)
> > > > > > > > >             ID_INDEX events:          1  ( 0.0%)
> > > > > > > > >           THREAD_MAP events:          1  ( 0.0%)
> > > > > > > > >              CPU_MAP events:          1  ( 0.0%)
> > > > > > > > >            TIME_CONV events:          1  ( 0.0%)
> > > > > > > > >        FINISHED_INIT events:          1  ( 0.0%)
> > > > > > > > > cycles stats:
> > > > > > > > >               SAMPLE events:         87
> > > > > > > > > ```
> > > > > > > > >
> > > > > > > > > If all events fail to open then the perf record will fail=
:
> > > > > > > > > ```
> > > > > > > > > $ perf record -e LLC-prefetch-read true
> > > > > > > > > Error:
> > > > > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' wh=
ich will be removed.
> > > > > > > > > The LLC-prefetch-read event is not supported.
> > > > > > > > > Error:
> > > > > > > > > Failure to open any events for recording
> > > > > > > > > ```
> > > > > > > > >
> > > > > > > > > As an evlist may have dummy events that open when all com=
mand line
> > > > > > > > > events fail we ignore dummy events when detecting if at l=
east some
> > > > > > > > > events open. This still permits the dummy event on its ow=
n to be used
> > > > > > > > > as a permission check:
> > > > > > > > > ```
> > > > > > > > > $ perf record -e dummy true
> > > > > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > > > > [ perf record: Captured and wrote 0.046 MB perf.data ]
> > > > > > > > > ```
> > > > > > > > > but allows failure when a dummy event is implicilty inser=
ted or when
> > > > > > > > > there are insufficient permissions to open it:
> > > > > > > > > ```
> > > > > > > > > $ perf record -e LLC-prefetch-read -a true
> > > > > > > > > Error:
> > > > > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' wh=
ich will be removed.
> > > > > > > > > The LLC-prefetch-read event is not supported.
> > > > > > > > > Error:
> > > > > > > > > Failure to open any events for recording
> > > > > > > > > ```
> > > > > > > > >
> > > > > > > > > The issue with legacy events is that on RISC-V they want =
the driver to
> > > > > > > > > not have mappings from legacy to non-legacy config encodi=
ngs for each
> > > > > > > > > vendor/model due to size, complexity and difficulty to up=
date. It was
> > > > > > > > > reported that on ARM Apple-M? CPUs the legacy mapping in =
the driver
> > > > > > > > > was broken and the sysfs/json events should always take p=
recedent,
> > > > > > > > > however, it isn't clear this is still the case. It is the=
 case that
> > > > > > > > > without working around this issue a legacy event like cyc=
les without a
> > > > > > > > > PMU can encode differently than when specified with a PMU=
 - the
> > > > > > > > > non-PMU version favoring legacy encodings, the PMU one av=
oiding legacy
> > > > > > > > > encodings.
> > > > > > > > >
> > > > > > > > > The patch removes events and then adjusts the idx value f=
or each
> > > > > > > > > evsel. This is done so that the dense xyarrays used for f=
ile
> > > > > > > > > descriptors, etc. don't contain broken entries. As event =
opening
> > > > > > > > > happens relatively late in the record process, use of the=
 idx value
> > > > > > > > > before the open will have become corrupted, so it is expe=
cted there
> > > > > > > > > are latent bugs hidden behind this change - the change is=
 best
> > > > > > > > > effort. As the only vendor that has broken event names is=
 ARM, this
> > > > > > > > > will principally effect ARM users. They will also experie=
nce warning
> > > > > > > > > messages like those above because of the uncore PMU adver=
tising legacy
> > > > > > > > > event names.
> > > > > > > > >
> > > > > > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > > > > Tested-by: James Clark <james.clark@linaro.org>
> > > > > > > > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > > > > > > > Tested-by: Atish Patra <atishp@rivosinc.com>
> > > > > > > > > ---
> > > > > > > > >  tools/perf/builtin-record.c | 47 +++++++++++++++++++++++=
+++++++++-----
> > > > > > > > >  1 file changed, 41 insertions(+), 6 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/bui=
ltin-record.c
> > > > > > > > > index 5db1aedf48df..c0b8249a3787 100644
> > > > > > > > > --- a/tools/perf/builtin-record.c
> > > > > > > > > +++ b/tools/perf/builtin-record.c
> > > > > > > > > @@ -961,7 +961,6 @@ static int record__config_tracking_ev=
ents(struct record *rec)
> > > > > > > > >      */
> > > > > > > > >     if (opts->target.initial_delay || target__has_cpu(&op=
ts->target) ||
> > > > > > > > >         perf_pmus__num_core_pmus() > 1) {
> > > > > > > > > -
> > > > > > > > >             /*
> > > > > > > > >              * User space tasks can migrate between CPUs,=
 so when tracing
> > > > > > > > >              * selected CPUs, sideband for all CPUs is st=
ill needed.
> > > > > > > > > @@ -1366,6 +1365,7 @@ static int record__open(struct reco=
rd *rec)
> > > > > > > > >     struct perf_session *session =3D rec->session;
> > > > > > > > >     struct record_opts *opts =3D &rec->opts;
> > > > > > > > >     int rc =3D 0;
> > > > > > > > > +   bool skipped =3D false;
> > > > > > > > >
> > > > > > > > >     evlist__for_each_entry(evlist, pos) {
> > > > > > > > >  try_again:
> > > > > > > > > @@ -1381,15 +1381,50 @@ static int record__open(struct re=
cord *rec)
> > > > > > > > >                             pos =3D evlist__reset_weak_gr=
oup(evlist, pos, true);
> > > > > > > > >                             goto try_again;
> > > > > > > > >                     }
> > > > > > > > > -                   rc =3D -errno;
> > > > > > > > >                     evsel__open_strerror(pos, &opts->targ=
et, errno, msg, sizeof(msg));
> > > > > > > > > -                   ui__error("%s\n", msg);
> > > > > > > > > -                   goto out;
> > > > > > > > > +                   ui__error("Failure to open event '%s'=
 on PMU '%s' which will be removed.\n%s\n",
> > > > > > > > > +                             evsel__name(pos), evsel__pm=
u_name(pos), msg);
> > > > > > >
> > > > > > > > How about changing it to pr_debug() and add below ...
> > > > > > >
> > > > > > > That sounds better.
> > > > > > >
> > > > > > > > > +                   pos->skippable =3D true;
> > > > > > > > > +                   skipped =3D true;
> > > > > > > > > +           } else {
> > > > > > > > > +                   pos->supported =3D true;
> > > > > > > > >             }
> > > > > > > > > -
> > > > > > > > > -           pos->supported =3D true;
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > > > +   if (skipped) {
> > > > > > > > > +           struct evsel *tmp;
> > > > > > > > > +           int idx =3D 0;
> > > > > > > > > +           bool evlist_empty =3D true;
> > > > > > > > > +
> > > > > > > > > +           /* Remove evsels that failed to open and upda=
te indices. */
> > > > > > > > > +           evlist__for_each_entry_safe(evlist, tmp, pos)=
 {
> > > > > > > > > +                   if (pos->skippable) {
> > > > > > > > > +                           evlist__remove(evlist, pos);
> > > > > > > > > +                           continue;
> > > > > > > > > +                   }
> > > > > > > > > +
> > > > > > > > > +                   /*
> > > > > > > > > +                    * Note, dummy events may be command =
line parsed or
> > > > > > > > > +                    * added by the tool. We care about s=
upporting `perf
> > > > > > > > > +                    * record -e dummy` which may be used=
 as a permission
> > > > > > > > > +                    * check. Dummy events that are added=
 to the command
> > > > > > > > > +                    * line and opened along with other e=
vents that fail,
> > > > > > > > > +                    * will still fail as if the dummy ev=
ents were tool
> > > > > > > > > +                    * added events for the sake of code =
simplicity.
> > > > > > > > > +                    */
> > > > > > > > > +                   if (!evsel__is_dummy_event(pos))
> > > > > > > > > +                           evlist_empty =3D false;
> > > > > > > > > +           }
> > > > > > > > > +           evlist__for_each_entry(evlist, pos) {
> > > > > > > > > +                   pos->core.idx =3D idx++;
> > > > > > > > > +           }
> > > > > > > > > +           /* If list is empty then fail. */
> > > > > > > > > +           if (evlist_empty) {
> > > > > > > > > +                   ui__error("Failure to open any events=
 for recording.\n");
> > > > > > > > > +                   rc =3D -1;
> > > > > > > > > +                   goto out;
> > > > > > > > > +           }
> > > > > > >
> > > > > > > > ... ?
> > > > > > >
> > > > > > > >               if (!verbose)
> > > > > > > >                       ui__warning("Removed some unsupported=
 events, use -v for details.\n");
> > > > > > >
> > > > > > > And even this one would be best left for cases where we can d=
etermine
> > > > > > > that its a new situation, i.e. one that should work and not t=
he ones we
> > > > > > > know that will not work already and thus so far didn't alarm =
the user
> > > > > > > into thinking something is wrong.
> > > > > > >
> > > > > > > Having the ones we know will fail as pr_debug() seems enough,=
 I'd say.
> > > > > >
> > > > > > This means that:
> > > > > > ```
> > > > > > $ perf record -e data_read,LLC-prefetch-read -a sleep 0.1
> > > > > > ```
> > > > > > will fail (as data_read is a memory controller event and the LL=
C
> > > > > > doesn't support sampling) with something like:
> > > > > > ```
> > > > > > Error:
> > > > > > Failure to open any events for recording
> > > > > > ```
> > > > > > Which feels a bit minimal. As I already mentioned, it is also a
> > > > > > behavior change and so has the potential to break scripts depen=
dent on
> > > > > > the failure information.
> > > > >
> > > > > I don't think it's about failure behavior, the concern is the err=
or
> > > > > messages.  It can take too much screen space when users give a lo=
ng list
> > > > > of invalid events.  And unfortunately the current error message f=
or
> > > > > checking dmesg is not very helpful.
> > > >
> > > > Making the dmesg message more useful is a separate issue. The error
> > >
> > > Sure.
> > >
> > > > message only happens when things are broken and I think having an
> > > > error message is better than none, or somehow having to know to wad=
e
> > > > through verbose output. I think this is very clear in:
> > > > https://lore.kernel.org/lkml/CAP-5=3DfVr43v8gkqi8SXVaNKnkO+cooQVqx3=
xUFJ-BtgxGHX90g@mail.gmail.com/
> > > >
> > > > > Anyway you can add this line too: "Use -v to see the details."
> > > >
> > > > So silently failing and then expecting users to scrape verbose outp=
ut
> > > > is a fairly significant behavior change for the tool.
> > >
> > > I'm not saying I want silent failures.  It should say it fails to par=
se
> > > or open some events.  But I think it needs to care about repeating
> > > failure messages.
> > >
> > > >
> > > > > >
> > > > > > A patch lowering the priority of error messages should be indep=
endent
> > > > > > of the 4 changes here. I'd be happy if someone follows this ser=
ies
> > > > > > with a patch doing it.
> > > > >
> > > > > I think the error behavior is a part of this change.
> > > >
> > > > I disagree with it, so I think you need to address my comments.
> > >
> > > You are changing the error behavior by skipping failed events then th=
e
> > > relevant error messages should be handled properly in this patchset.
> >
> > I'm not sure what you are asking and I'm not sure why it matters?
> > Previously you'd asked for all the output to be moved under verbose.
> >
> > If I specify an event that doesn't work with perf record today then it
> > fails. With this patch it fails too. If that event is a core PMU event
> > then there will be an error message for each core PMU that doesn't
> > support the event. So I get 2 error messages on hybrid. This doesn't
> > feel egregious or warrant a new error message mechanism. I would like
> > it so that evsels supported 1 or more PMUs, in which case this would
> > be 1 error message.
> >
> > If I specify perf record today on an uncore event then perf record
> > fails and I get 1 error message for the uncore PMU. The new behavior
> > will be to get 1 error message per uncore PMU. If I'm on a server with
> > 10s of uncore PMUs then maybe the message is spammy, but the command
> > fails today and will continue to fail with this series. I don't see a
> > motivation to change or optimize for this case and again, evsels that
> > support >1 PMU would be the most appropriate fix.
> >
> > The only case where there is no message today but would be with this
> > patch series is for cycles on ARM's neoverse. There will be one
> > warning for the evsel on the SLC PMU. That's one warning and not many.
> >
> > As I've said, if you want a more elaborate error reporting system then
> > take these patches and add it to them. There's a larger refactor to
> > make evsels support >1 PMU that would clean up the many events on
> > server uncore PMUs issue, but that shouldn't be part of this series
> > nor gate it. If you are trying to perf record on uncore PMUs then you
> > already have problems and optimizing the error messages for your
> > mistake, I don't get why it matters?
>
> What about with multiple events in the command line - one of them
> failing with >1 PMUs and the command now succeeds?

So this would be something like:
```
$ perf record -e cycles,instructions,data_read -a sleep 1
```
where data_read is an uncore PMU event. The current behavior is:
```
$ perf record -e cycles,instructions,data_read -a sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (data_read).
"dmesg | grep -i perf" may provide additional information.
```
The new behavior is:
```
$ perf record -e cycles,instructions,data_read -a sleep 1
Error:
Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0'
which will be removed.
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (data_read).
"dmesg | grep -i perf" may provide additional information.

Error:
Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1'
which will be removed.
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (data_read).
"dmesg | grep -i perf" may provide additional information.

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 3.138 MB perf.data (11670 samples) ]
```

We know nobody does this, as the command currently fails. It succeeds
with this change, because that's the whole point of the change. I'm
not offended by seeing the event was being opened on >1 PMU. For the
only currently succeeding situation where this will now warn, the
cycles case on Neoverse because of the buggy event name in ARM's SLC
PMU, there will be 1 warning. For my example the appropriate fix is to
remove the data_read event. For the Neoverse case, specifying the PMU
resolves the issue until ARM fixes their driver.

Thanks,
Ian

