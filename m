Return-Path: <bpf+bounces-48992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEE7A12E5B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5941887A9B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C81DC9AE;
	Wed, 15 Jan 2025 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnWt/9xy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F31D88BE
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980850; cv=none; b=MfV7FLlvLApQueYuNNV344ewOJKFHGeqvLWm+UGVFUuxjVcMfMydWn8rMpt7++y9ku164kqzWJTOKUVKpXm+iBg7OIwx3Pfp4AEQmZemFzM5HEnqxqcqhTuUHfOvoDyFUm7wiIZE3z7aFbEVM75mKWUAy+d2P09NKxt2MYXPibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980850; c=relaxed/simple;
	bh=iRelIUbfX3hNf9OdE2ifq0NHKfwIu8jUYNMrQc1cAOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrsGBip6IN+EOCT2xM12tvJKurOSAde1/GzCIWoOs3QFdnV7CQJstHLuPSnR96KsSFoG76IBGqmKgDmyRU0KQtC+OhHtf4U/z/p8MeEXPYghWQEtvhzmb9QXg55wrDj4ed+zhopJKbg0zyARiwNYUuJ5a1l8ZJUAQD53K43HHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnWt/9xy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so41545ab.0
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736980847; x=1737585647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/uRWMmNrI+CzzONAsOwBGVmf9FI4ZKGRWoPazZOMtg=;
        b=ZnWt/9xychE+Oa7o5suZuv1/hnY/UoC74HI2ATr2tM1cn97F0tFQGLDpdWEP+vxk8I
         hiyaEcztmbe4KohC5OdCK7QqDoUAkTtNnZyT4Y3JxK6Kqz6VMWta4DIttcZGn1gCo4uO
         qLy3frpe3bIMW3g7+u8P2exTz8r6nyeZDaOD0akJ4KNG00B7c+hcmzEItqjKkzo+ZnDq
         lF8C2P0dNYj6a7UDLDSeW8nbtA5eUY66ZGhTlJWKYGO5DOxseBfHujAxvBZzqgqth5yv
         QLIz/NGGqYi5S2gvTPFtCdUxgXWnjhhq/O4t4M33PAQttY6VBkLKqgD7h3EJCfxfu+rn
         5xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980847; x=1737585647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/uRWMmNrI+CzzONAsOwBGVmf9FI4ZKGRWoPazZOMtg=;
        b=b/i35pursoIS/9f57zyxm7vLamaHoCRdXbl3fChBywY5jc1dTgk7CrgiPCs+Dr+6pK
         MBtIX2hA/NHFITGtW4GCCac92sGxofYywbdtduatGZxuKtxTlYAZvxkXsbwFWy4BGU8y
         /FpZ5R3pw+Ng1DyramcpQhcoAqBdpIOdGq+QvE1rQ8A7/4qIFNOXpnP4OQvX5zbL0N6a
         Nnr4yWMg+9tNCwRlAG3TPFJOk9ozm9x+tUITNkwpjerzQoJhD/fzpUntrNipzkMKWEuM
         ovBZuyTmowTIE+HuRKI9GsNv7vUUi6UcDHhVTkWXuoYX/LE5Ebq0YBS7m7WFb+DHBmzp
         YXfg==
X-Forwarded-Encrypted: i=1; AJvYcCVWAPM+1vlYn5q3+SvAtcy/DGS5HlUtE1RllKFkQ641O0Ey6FcLz4P93H6Iq41mZgAs6Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuzjYEUq77NIGKs7aZFujxD3V0FQL1O6TbOb8hgg8vJr91nciG
	3OjgcTt5GLiDZ3nF6DaVajB9r8kmnauIAIGdy3dr3M2DQhyrF6aoTbGHvcXUjMrqiwTbO5G+vOd
	2RDQSFcXL1NjPcTYnddXEpZPuG89lEaoc+vQk
X-Gm-Gg: ASbGnctDxKl17tNKv+Wj5L9eAtUN7yO6D3pOC0Cf+cApPKKy7onQ3PT0vc7ghvBi0j+
	27j9HoLU3jQxAAc5mDHpI+nxQa5VI/TRSbW0JENw7YRT5n0caqSY+iLCs+3JBhk2Ic0uGCg==
X-Google-Smtp-Source: AGHT+IF+nLZwVnop/dw42anH5EH5QDmiqpqMVTomjXBgTX6Hzc9vEumZX9FY8EnnZuqSxOE2ZWiFMQ4IkqK9wbJR9Ls=
X-Received: by 2002:a05:6e02:3885:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3cf420018efmr251905ab.23.1736980847016; Wed, 15 Jan 2025
 14:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com> <CAP-5=fUSfbZGNaUttM3UCzcrMzkkFAJVA8mheMKQ0nxNH_KuTg@mail.gmail.com>
 <Z4FtHGBbCEeLQhAm@google.com> <CAP-5=fVr43v8gkqi8SXVaNKnkO+cooQVqx3xUFJ-BtgxGHX90g@mail.gmail.com>
 <Z4a7DncIlP6pznW7@google.com> <CAP-5=fWZxpooqOhC_QrR2YaZVEj0UpipBCHXHZMbFfv7G15Vnw@mail.gmail.com>
 <Z4gzWDsxlSxSbBSQ@google.com>
In-Reply-To: <Z4gzWDsxlSxSbBSQ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jan 2025 14:40:35 -0800
X-Gm-Features: AbW1kvY2lBurBM5PiNSiu7ZKfP05HIal-Ya2Gwpj4lVD7yOgIi4Qf2sHZvwXP_E
Message-ID: <CAP-5=fUDHujdg-bryzMmXECEQ6zdVfQH-v99ZHfV+p3_zG2XPg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that don't open
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, 
	Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jan 14, 2025 at 03:55:47PM -0800, Ian Rogers wrote:
> > On Tue, Jan 14, 2025 at 11:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Fri, Jan 10, 2025 at 11:18:53AM -0800, Ian Rogers wrote:
> > > > On Fri, Jan 10, 2025 at 10:55=E2=80=AFAM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > >
> > > > > On Thu, Jan 09, 2025 at 08:44:38PM -0800, Ian Rogers wrote:
> > > > > > On Thu, Jan 9, 2025 at 5:25=E2=80=AFPM Namhyung Kim <namhyung@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > > > > > > Whilst for many tools it is an expected behavior that failu=
re to open
> > > > > > > > a perf event is a failure, ARM decided to name PMU events t=
he same as
> > > > > > > > legacy events and then failed to rename such events on a se=
rver uncore
> > > > > > > > SLC PMU. As perf's default behavior when no PMU is specifie=
d is to
> > > > > > > > open the event on all PMUs that advertise/"have" the event,=
 this
> > > > > > > > yielded failures when trying to make the priority of legacy=
 and
> > > > > > > > sysfs/json events uniform - something requested by RISC-V a=
nd ARM. A
> > > > > > > > legacy event user on ARM hardware may find their event open=
ed on an
> > > > > > > > uncore PMU which for perf record will fail. Arnaldo suggest=
ed skipping
> > > > > > > > such events which this patch implements. Rather than have t=
he skipping
> > > > > > > > conditional on running on ARM, the skipping is done on all
> > > > > > > > architectures as such a fundamental behavioral difference c=
ould lead
> > > > > > > > to problems with tools built/depending on perf.
> > > > > > > >
> > > > > > > > An example of perf record failing to open events on x86 is:
> > > > > > > > ```
> > > > > > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a slee=
p 0.1
> > > > > > > > Error:
> > > > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_r=
unning_0' which will be removed.
> > > > > > > > The sys_perf_event_open() syscall returned with 22 (Invalid=
 argument) for event (data_read).
> > > > > > > > "dmesg | grep -i perf" may provide additional information.
> > > > > > > >
> > > > > > > > Error:
> > > > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_r=
unning_1' which will be removed.
> > > > > > > > The sys_perf_event_open() syscall returned with 22 (Invalid=
 argument) for event (data_read).
> > > > > > > > "dmesg | grep -i perf" may provide additional information.
> > > > > > > >
> > > > > > > > Error:
> > > > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' whic=
h will be removed.
> > > > > > > > The LLC-prefetch-read event is not supported.
> > > > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 sa=
mples) ]
> > > > > > >
> > > > > > > I'm afraid this can be too noisy.
> > > > > >
> > > > > > The intention is to be noisy:
> > > > > > 1) it matches the existing behavior, anything else is potential=
ly a regression;
> > > > >
> > > > > Well.. I think you're changing the behavior. :)  Also currently i=
t just
> > > > > fails on the first event so it won't be too much noisy.
> > > > >
> > > > >   $ perf record -e data_read,data_write,LLC-prefetch-read -a slee=
p 0.1
> > > > >   event syntax error: 'data_read,data_write,LLC-prefetch-read'
> > > > >                        \___ Bad event name
> > > > >
> > > > >   Unable to find event on a PMU of 'data_read'
> > > > >   Run 'perf list' for a list of valid events
> > > > >
> > > > >    Usage: perf record [<options>] [<command>]
> > > > >       or: perf record [<options>] -- <command> [<options>]
> > > > >
> > > > >       -e, --event <event>   event selector. use 'perf list' to li=
st available events
> > > >
> > > > Fwiw, this error is an event parsing error not an event opening err=
or.
> > > > You need to select an uncore event, I was using data_read which exi=
sts
> > > > in the uncore_imc_free_running PMUs on Intel tigerlake. Here is the
> > > > existing error message:
> > > > ```
> > > > $ perf record -e data_read -a true
> > > > Error:
> > > > The sys_perf_event_open() syscall returned with 22 (Invalid argumen=
t)
> > > > for event (data_read).
> > > > "dmesg | grep -i perf" may provide additional information.
> > > > ```
> > > > and here it with the series:
> > > > ```
> > > > $ perf record -e data_read -a true
> > > > Error:
> > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0=
'
> > > > which will be removed.
> > > > The sys_perf_event_open() syscall returned with 22 (Invalid argumen=
t)
> > > > for event (data_read).
> > > > "dmesg | grep -i perf" may provide additional information.
> > > >
> > > > Error:
> > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1=
'
> > > > which will be removed.
> > > > The sys_perf_event_open() syscall returned with 22 (Invalid argumen=
t)
> > > > for event (data_read).
> > > > "dmesg | grep -i perf" may provide additional information.
> > > >
> > > > Error:
> > > > Failure to open any events for recording.
> > > > ```
> > > > and here is what it would be with pr_debug:
> > > > ```
> > > > $ perf record -e data_read -a true
> > > > Error:
> > > > Failure to open any events for recording.
> > > > ```
> > > > I believe this last output is worst because:
> > > > 1) If not all events fail to open there is no error reported unless=
 I
> > > > know to run with -v, which will also bring a bunch more noise with =
it,
> > >
> > > I suggested to add a warning if any (not all) of events failed to ope=
n.
> > >
> > >   "Removed some unsupported events, use -v for details."
> > >
> > >
> > > > 2) I don't see the PMU / event name and "Invalid argument" indicati=
ng
> > > > what has gone wrong again unless I know to run with -v and get all =
the
> > > > verbose noise with that.
> > >
> > > I don't think single -v adds a lot of noise in the output.
> > >
> > > >
> > > > Yes it is noisy on 1 platform for 1 event due to an ARM PMU event n=
ame
> > > > bug that ARM should have long ago fixed. That should be fixed rathe=
r
> > > > than hiding errors and making users think they are recording sample=
s
> > > > when silently they're not - or they need to search through verbose
> > > > output to try to find out if something broke.
> > >
> > > I'm not sure if it's a bug in the driver.  It happens because perf to=
ol
> > > changed the way it finds events - it used to look at the core PMUs on=
ly
> > > if no PMU name was given, but now it searches every PMU, right?
> >
> > So there is the ARM bug in the PMU driver that caused an issue with
> > the hybrid fixes done because of wanting to have metrics work for
> > hybrid. The bug is reported here:
> > https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marca=
n.st/
>
> I'm not sure if it's agreed to be called a PMU bug.
> My understanding is it's the change in the perf tool that break it.
>
>
> > The events are apple_icestorm_pmu/cycles/ and
> > apple_firestorm_pmu/cycles/. The issue is that prior to fixing hybrid
> > the ARM PMUs looked like uncore PMUs and couldn't open a legacy event,
> > which was fine as they has sysfs events. When hybrid was fixed in the
> > tool, the tool would then try to open apple_icestorm_pmu/cycles/ and
> > apple_firestorm_pmu/cycles/ as legacy events - legacy having priority
> > over sysfs/json back then. The legacy mapping was broken in the PMU
>
> I don't know why you want to use legacy events (PERF_TYPE_HARDWARE)
> when it has PMU in the event name and the PMU has a different type
> enconding.

Historically we used legacy then sysfs/json. When Intel did the hybrid
work they kept this priority for legacy events when the hybrid PMU was
specified. Intel change, Arnaldo and Jiri reviewing. My belief in why
it was done this way is that not every legacy event has a sysfs/json
encoding, and the priority was just inheriting an existing behavior.

> > driver. Now were everything working as intended, just the cycles event
> > would be specified on the command line and the event would be wildcard
> > opened on the apple_icestorm_pmu and apple_firestorm_pmu. I believe
> > this way would already use a legacy encoding and so to work around the
> > PMU driver bug people were specifying the PMU name to get the sysfs
> > encoding, but that only worked as the PMUs appeared to be uncore.
> >
> > > >
> > > > > > 2) it only happens if trying to record on a PMU/event that does=
n't
> > > > > > support recording, something that is currently an error and so =
we're
> > > > > > not motivated to change the behavior as no-one should be using =
it;
> > > > >
> > > > > It was caught by Linus, so we know at least one (very important) =
user.
> > > >
> > > > If they care enough then specifying the PMU with the event will avo=
id
> > > > any warning and has always been a fix for this issue. It was the fi=
rst
> > > > proposed workaround for Linus.
> > >
> > > I guess that's what Linus said regression.
> >
> > But a regression where? The tool's behavior is pretty clear, no PMU
> > the event will be tried on every PMU, give it a PMU and the event will
> > only be tried on that PMU, give it a PMU without a suffix and the
> > event will be opened on all PMUs that match the name with different
> > suffixes.
>
> It may be clear to you but may not be to others.  When did the change
> come in?  Before the change, people assume it would only try core PMU.
> And the people can still have the idea if they haven't used any affected
> events.  I guess many users would use legacy events only.

Who are these others? The only affected event is a cycles event on an
ARM SLC PMU. What gets fixed? Potentially Apple-M hardware where
legacy events have historically been broken. Rather than others
complaining I think there's a much greater number of others who will
be happy about the fix.

> > I dislike the idea of  cpu-cycles implicitly being just for
> > core PMUs, but cpu_cycles being for all PMUs as the hyphen is a legacy
> > name and the underscore not.
>
> That's because we specifically picked some names to be used as a legacy
> event.  And it worked well.  If some PMU didn't use the name, it's their
> fault and they should use PMU event with their name.

I'm not sure this is the case. If you look at the legacy event names
it was typical they included something like a PMU before the first
hyphen. What does cpu- mean for hybrid? Why does LLC mean L2 when
typical LLCs these days are L3? I think ideally we'd delete the legacy
events and fix the missing events by explicitly putting them into
sysfs/json. I don't see that happening soon.

> > I dislike the idea of specifying a PMU
> > with uncore events as uncore events often already have a PMU within
> > their event name and it also breaks the universe.
>
> Does the 'universe' mean 'metric'?

No, I mean if I do:
$ perf stat -e data_read ...
it works today. Making all non-core events require a PMU means I need to ty=
pe:
$ perf stat -e uncore_imc_free_running/data_read/ ...
This is true for all non-core events with your proposal. I've
previously advised you that the former behavior is what perf's command
line completion of event names assumes.

> Having PMU name in the event name is their choice.  Do you see this in
> sysfs or JSON?  Or both?
>
> Actually I don't like the idea of trying every PMU if no PMU name is
> given.  But you said reverting it would break metrics (I don't know if
> there are other users rely on this behavior).  Maybe can we handle
> metrics differently?
>
> I guess we can put JSON events and metrics without PMU in a global name
> space so that it can be searched (after legacy name) when users don't
> specify PMUs in the command line.  Otherwise it should have PMU name
> and sysfs event (then JSON events with PMU name) can be searched.
>
> Does that make sense?

So my intention for metrics is that the events there work as events
would work for perf stat. Not least this simplifies testing and
creating metrics.

There are things we can do with the search order of events, I'd like
to make it so users can create their own events, but this is getting
off topic.

> > When trying to find
> > out what people mean by event names being implicitly associated with
> > PMUs I get told I'm throwing out "what ifs," when all I'm doing is
> > reading the code (that I wrote and I'm trying to fix) and trying to
> > figure out what behavior people want. What I don't want is
> > inconsistencies, events behaving differently in different scenarios
> > and the perf output's use of event names being inconsistent with the
> > parsing. RISC-V and ARM have wanted the syfs/json over legacy
> > priority, so I'm trying to get that landed.
>
> I'm not sure now RISC-V and ARM want it.  Or it needs to be more
> specific what they want exactly.

In which case let's make the priority be legacy then sysfs/json, I'm
happy with that. We can revert the changes that Mark Rutland and the
Apple-M folks pushed for. We can tell RISC-V they're not being
specific enough with their need. I don't think that's as good an
alternative as the changes here, but if it works for you...

> >
> > Ultimately the original regression comes back to the ARM SLC PMU
> > advertising a cycles event when it should have been named cpu_cycles,
> > if for no other reason than uniformity with the bus_cycles name on the
> > same PMU. The change in perf's wildcard behavior exposed the latent
> > bug, that doesn't make the SLC PMU's event name not a bug. The change
> > here is to make seeing that bug non-terminal to running the program.
>
> I don't see it's a bug if uncore PMUs have an event named 'cycles' or
> whatever.  It's just because perf record wanted to use it and that's
> entirely tool's choice.

It's a bug because a wildcard match */cycles/ will match against the
SLC PMU's event and if users don't want to specify a PMU it breaks
perf record when wildcarding cycles. These changes lower the failure
to a warning, implementing the behavior proposed by Arnaldo:
https://lore.kernel.org/lkml/ZlY0F_lmB37g10OK@x1/
and has tags from Intel, ARM and Rivos (RISC-V). I intend to carry it
in Google's tree. If you want to require uncore events have PMUs in
their names, maintain all the metrics, etc. I don't plan on carrying
that but you have complete freedom to do what you see best.

Thanks,
Ian

