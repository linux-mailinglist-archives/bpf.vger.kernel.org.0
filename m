Return-Path: <bpf+bounces-48579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF00A09BBB
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 20:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9381697C5
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7C0212FB9;
	Fri, 10 Jan 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DS9G3RMk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9724B248
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536747; cv=none; b=rSHzSnkX7ZdVllt+MVDQwQpeyFhlKg7VcJZozHqdzbY5fQsb6vd+qb9xVB3BQqJZQ4sP2ArV9o0QuUSXT5n8umVTlUTO2SObPy1cwaX5/wCl3kCRu9B5Kvzm6Rjio417Zi7CgMtas/OxD7sYYrRgSzOgJx8SYuSJqfPMpKL6nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536747; c=relaxed/simple;
	bh=yG8cn+rlT4mJx2CGjggy3Vw116PeKyAjm80uSrq9TiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEknHPrEQAZQP8yGht7GSrXGtnQcXNhuhk6+Sftd3JZAlzqkFmf2YDFLrxm9wfofYF96hGToh70GDowGLXEOsAbCtXRCMzgWlDP1CPeGuivMItDX0+4FIYliwbJWwJl5goyR1KJZqp6Lwv52c3XWtWITUarNV5zRH3gXNfqtzA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DS9G3RMk; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a814c54742so16955ab.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736536745; x=1737141545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/IZzFSioIrSy+wqZhaDKTjkHT7gnYg5AkzEa2OW8Vc=;
        b=DS9G3RMktALTEbXiUfMiS8Bea4VPiPipzWdeLrselfgQuIvftA9Cvkw/N2ehm/WHTi
         5FQ/oqEuTgOAamBhhz8dTREn4oGbzOZhlGI/HQTe7SzLBh32SPx//hSyKusIZCsfYddy
         dPuH2NqeXGmcW0bKt3Q13TvWAA0D9QbLLzUkLLJ/pLb4+eSszIZ3aqE3dMDy82L/wMaO
         B1hyjx7qXw0s9wybFM0uMZOxEOAkputBtuqIJWGlw0N7W149ADWBJ7+6UC29D6Kz/ifa
         asHzHQ5SL2manPwfhBe1qNcL1DH5k2pYC1fKrtwWaMYInZJqjEpqNEi/qsk1Noi3Ykyw
         y9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536745; x=1737141545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/IZzFSioIrSy+wqZhaDKTjkHT7gnYg5AkzEa2OW8Vc=;
        b=ePNwOgsRBNtKAxTa7o3r9TUOBOeSgjV4sgy9hOr0OwASah0qnLob8jdZfd/xnWWson
         AWUV2htv063DANoW1kknijMnrlj8TrEoblxupC/fqB83Mc/roBj2CS0EepfgrouRihn7
         vdOZE07/EtvUjEy0Xyvi4fBhSzYFFIOps1pPsTGTE0Y1NXLKBrjH77YQLXZ8nyE7yJ/s
         ZeVbHJPFqElQRsRx9pL27whv4uRlSD98exTCqtPfMh2HlU5jlK2wblxt3U0qR5qQ9p9I
         XsPtWS1F8hjgnVA9V++ma5dqipBd5MS2PIaC1TP23J2h5hkzAPw33Us4XEAfKRBt081C
         F8kg==
X-Forwarded-Encrypted: i=1; AJvYcCXwcWhPesOJNZoBPfuTGtJoJmR4sERrtXAjMnm1wQeDrDJM5Z+7DAezITdpmPbt1YsTkO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8M/6FJt0JaRNETaq7C7RXT+J8IbzMnu1lopxJ2ZEiQgxEBDs
	k3lsL+c/g4A5z9QbkjnvDK9KPWVZGTCWLJRgni2nfLEOvpqQ0u9/MEwa5A1Jacut5mWZ8ZQ6Gz5
	q9awy2OghFXg3JZNIgTZv9FrHs1c9x2qUtLxE
X-Gm-Gg: ASbGncs4ZBgSpWIJbsovdlz3+KRUFJUdJR7aQC3192lmRiWqOVtY1TYOg+SOv1wPEsX
	Ncw9KeTZf7SkzSjIrWHgyARw3ivY4L5ZfEVW5MB19wYFtUD6gLO7jIVSEqKc5S6cP5GtkkQ==
X-Google-Smtp-Source: AGHT+IHrAyjXgQ5TQnnWjxzBkKH3NZs4bwEFwXevauwhRCakjJvFsgLTlzBkcn0KGTcODeDRMzrsYfIQMYQEKBrP6RA=
X-Received: by 2002:a05:6e02:1ca5:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3ce588776edmr3974725ab.5.1736536745080; Fri, 10 Jan 2025
 11:19:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com> <CAP-5=fUSfbZGNaUttM3UCzcrMzkkFAJVA8mheMKQ0nxNH_KuTg@mail.gmail.com>
 <Z4FtHGBbCEeLQhAm@google.com>
In-Reply-To: <Z4FtHGBbCEeLQhAm@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 Jan 2025 11:18:53 -0800
X-Gm-Features: AbW1kvbJ6U9hkyf0tp-HJptWJERErVa0XIhAf4Px8kkRW5SmRpzzkjIoEQdl3Pw
Message-ID: <CAP-5=fVr43v8gkqi8SXVaNKnkO+cooQVqx3xUFJ-BtgxGHX90g@mail.gmail.com>
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

On Fri, Jan 10, 2025 at 10:55=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Jan 09, 2025 at 08:44:38PM -0800, Ian Rogers wrote:
> > On Thu, Jan 9, 2025 at 5:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
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
> > >
> > > I'm afraid this can be too noisy.
> >
> > The intention is to be noisy:
> > 1) it matches the existing behavior, anything else is potentially a reg=
ression;
>
> Well.. I think you're changing the behavior. :)  Also currently it just
> fails on the first event so it won't be too much noisy.
>
>   $ perf record -e data_read,data_write,LLC-prefetch-read -a sleep 0.1
>   event syntax error: 'data_read,data_write,LLC-prefetch-read'
>                        \___ Bad event name
>
>   Unable to find event on a PMU of 'data_read'
>   Run 'perf list' for a list of valid events
>
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
>
>       -e, --event <event>   event selector. use 'perf list' to list avail=
able events

Fwiw, this error is an event parsing error not an event opening error.
You need to select an uncore event, I was using data_read which exists
in the uncore_imc_free_running PMUs on Intel tigerlake. Here is the
existing error message:
```
$ perf record -e data_read -a true
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (data_read).
"dmesg | grep -i perf" may provide additional information.
```
and here it with the series:
```
$ perf record -e data_read -a true
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

Error:
Failure to open any events for recording.
```
and here is what it would be with pr_debug:
```
$ perf record -e data_read -a true
Error:
Failure to open any events for recording.
```
I believe this last output is worst because:
1) If not all events fail to open there is no error reported unless I
know to run with -v, which will also bring a bunch more noise with it,
2) I don't see the PMU / event name and "Invalid argument" indicating
what has gone wrong again unless I know to run with -v and get all the
verbose noise with that.

Yes it is noisy on 1 platform for 1 event due to an ARM PMU event name
bug that ARM should have long ago fixed. That should be fixed rather
than hiding errors and making users think they are recording samples
when silently they're not - or they need to search through verbose
output to try to find out if something broke.

> > 2) it only happens if trying to record on a PMU/event that doesn't
> > support recording, something that is currently an error and so we're
> > not motivated to change the behavior as no-one should be using it;
>
> It was caught by Linus, so we know at least one (very important) user.

If they care enough then specifying the PMU with the event will avoid
any warning and has always been a fix for this issue. It was the first
proposed workaround for Linus.

> > 3) for the wildcard case the only offender is ARM's SLC PMU and the
> > appropriate fix there has always been to make the CPU cycle's event
> > name match the bus_cycles event name by calling it cpu_cycles -
> > something that doesn't conflict with a core PMU event name, the thing
> > that has introduced all these problems, patches, long email exchanges,
> > unfixed inconsistencies, etc.. If the errors aren't noisy then there
> > is little motivation for the ARM SLC PMU's event name to be fixed.
>
> I understand your concern but I'm not sure it's the best way to fix the
> issue.

Right, I'm similarly concerned about hiding legitimate warning/error
messages because of 1 event on 1 PMU on 1 architecture because of how
perf gets driven by 1 user. Yes, when you break you can wade through
the verbose output but imo the verbose output was never intended to be
used in that way.

Thanks,
Ian

