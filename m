Return-Path: <bpf+bounces-48716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C043A0C4E2
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 23:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A6C1883793
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 22:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C161F9A8A;
	Mon, 13 Jan 2025 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kj7TseRX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653961BFE05
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736808686; cv=none; b=d63CqZvmPCqmZVwq0DwjzDqrilvWam+SUCpzoNoG7Kq/wbVvp15W+N+HU9C3z0rAOwCPVVg8/a6kUBx87CC6Zof/ZZdZb/wY5xtonHJ2se6ej2kpCj4Aq3EkR6YLBhevyKxbkoEhD95Zcds0qzkkb+0M/cfg6Y5g8lnAgTFzcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736808686; c=relaxed/simple;
	bh=wKG2DcqZSnpLUKRoUJUZS4Xyzs50QvQ37fDpzoaMQT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6rFW3v9qhjx70Ay2ZMk168mraqfPVZ6OAO+6ds7QvYopXTwrtdXczIu6a3YYSxTZL6xBgfodIKxXGkPHu2DAAa0ompIr4z+edqa/UhDo1FyZQW7b9EBWtNY7PN6pEFbORFO4HfwIk0Y0wndDPt9AoYEuM+zQj/nMbPYh5hhOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kj7TseRX; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a814c54742so15375ab.1
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 14:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736808683; x=1737413483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mud/NLpIFFSGNqZ9NLEZIqQ+lfcjRPT0gc3XwEmzXrQ=;
        b=Kj7TseRXFwSxaAUZBe/SDcfYvdRcljPXYfzSVZGDhyR6jkjZ4zNJSGNLd0SNDzxxqN
         BUZbrF33K/rCl9u+bfZif/INKe4/ZqYlyJnYYBNzsAL0abCHXw2L3sm+EJSBpqJj4saL
         UUaQltTBjLCa5K0f/hdSN5DohwkVPY0s1SRXg+CDJBTM0u1lCLyvfd4WXrI4q7jOA3KW
         tvXJa/y7mQJKJd2iALKKcOKOCOL7UZDCtHr06ZSNDiVkrY7ZxIqhkC16vz3p99E4O5iP
         bEjH5S/WE+V1fZ8PVQUzwplADBz2a+204Jn5328fsqLFAXtemRyNFlyH02GpXQ4yRY+K
         4GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736808683; x=1737413483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mud/NLpIFFSGNqZ9NLEZIqQ+lfcjRPT0gc3XwEmzXrQ=;
        b=Daiwdy8OTuhjLVwcEDBtg9Frmksypq1cvZrSsXfvxwbH0lz4518fmmL8BUeUFG/oAf
         Gig6QfIq3G3U5sY2TXh050pANMBUykZnTMl30ToXF+MzGNhkJV3PLUmni3tCxd020/S7
         HbKrrmjFZuRFzwEnWwECojhfhUXNtzxaGVN65v9p+jY5C8DIOf+cmBC6V5O5ZPP/6D9h
         3KQ434W0iKf7ZxWuBcpDgRp6E73PaJlz24XKApvMFFQWxooreXfqIBz2Pd3dU6nFUXM2
         sKblILjAkySUheMCZ2Q6y3QxwY4Tx7xfqZ0N+3wO0B/Bb/80KlI8/GXlz60fYD5EzIQA
         zxxA==
X-Forwarded-Encrypted: i=1; AJvYcCUFoSbmNZvere+qHbMubd8PM1EVijQUAdA/Txdryv1CEXsI3oQgkF4KCF0gOA63Rn7KcY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjNC2/EqjywNEilXMQpLqkFePj8vnOekpS9x2bT7i2lzTRZeN
	xcZ29WI7lLU0MbSFTAEOu2yHhdtQ0bzXU8+gnuN04CAV8YZXhvDe3udFlnLhnjUD9dI/tpQvqcp
	7KEliY0SRFqU60megN3aYRwlFJ16FUeQ8lZH+
X-Gm-Gg: ASbGncu+skaCbBRUmPziTC7oOs1xwD0CDrkVhvxSHSvg4HZyDaktX2KmalQPZoVSXdv
	rw8UnjvdUYs4ti0QInFq8SMu0pq6Mjrrrnmk58jMIn0OD6eD9WKg1+iS1R7MVjCiMSdS0pg==
X-Google-Smtp-Source: AGHT+IFgMCkgiR9ufNTKatMbQpKINcTTjsfj6mOTK7cAoM96jzFzu5h84BeeOiSklgWl2iqQnPWciiFps2Bsk9fsKLY=
X-Received: by 2002:a05:6e02:1a4c:b0:3a0:a459:8eca with SMTP id
 e9e14a558f8ab-3ce7ac56a98mr1010485ab.10.1736808683323; Mon, 13 Jan 2025
 14:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com> <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com>
In-Reply-To: <Z4WNT_UX9eMD_txf@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Jan 2025 14:51:11 -0800
X-Gm-Features: AbW1kvbqW30NhOQaqj3o9EnapMdlfjm88aPqHrE2JMDnBMGggJMNHyB5FMWZnvo
Message-ID: <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 2:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Jan 10, 2025 at 02:15:18PM -0800, Ian Rogers wrote:
> > On Fri, Jan 10, 2025 at 11:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 02:21:09PM -0800, Ian Rogers wrote:
> > > > Originally posted and merged from:
> > > > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.c=
om
> > > > This reverts commit 4f1b067359ac8364cdb7f9fda41085fa85789d0f althou=
gh
> > > > the patch is now smaller due to related fixes being applied in comm=
it
> > > > 22a4db3c3603 ("perf evsel: Add alternate_hw_config and use in
> > > > evsel__match").
> > > > The original commit message was:
> > > >
> > > > It was requested that RISC-V be able to add events to the perf tool=
 so
> > > > the PMU driver didn't need to map legacy events to config encodings=
:
> > > > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosi=
nc.com/
> > > >
> > > > This change makes the priority of events specified without a PMU th=
e
> > > > same as those specified with a PMU, namely sysfs and JSON events ar=
e
> > > > checked first before using the legacy encoding.
> > >
> > > I'm still not convinced why we need this change despite of these
> > > troubles.  If it's because RISC-V cannot define the lagacy hardware
> > > events in the kernel driver, why not using a different name in JSON a=
nd
> > > ask users to use the name specifically?  Something like:
> > >
> > >   $ perf record -e riscv-cycles ...
> >
> > So ARM and RISC-V are more than able to speak for themselves and have
> > their tags on the series, but let's recap why I'm motivated to do this
> > change:
> >
> > 1) perf supported legacy events;
> > 2) perf supported sysfs and json events, but at a lower priority than
> > legacy events;
> > 3) hybrid support was added but in a way where all the hybrid PMUs
> > needed to be known, assumptions about PMU were implicit and baked into
> > the tool;
> > 4) metric support for hybrid was going in a similar implicit direction
> > and I objected, what would cycles mean in a metric if the core PMU was
>
> If the legacy cycles event in a metric is a problem, can we change the
> metric to be more specific?
>
>
> > implicit? Rather than pursue this the hybrid code was overhauled, PMUs
> > became more of a thing and we added a notion of a "core" PMU which
> > would support legacy events;
> > 5) ARM core PMUs differ in naming, etc. than just about every other
> > platform. Their core events had been being programmed as if they were
> > uncore events - ie without the legacy priority. Fixing hybrid, and
> > fixing ARM PMUs to know they supported legacy events, broke perf on
> > Apple-M? series due to a PMU driver issue with legacy events:
> > https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marca=
n.st/
> > "Perf broke on all Apple ARM64 systems (tested almost everything), and
> > according to maz also on Juno (so, probably all big.LITTLE) since
> > v6.5."
> > 6) sysfs/json events were made the priority over legacy to unbreak
> > perf on Apple-M? CPUs, but only if the PMU is specified:
> > https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
> >    Reported-by: Hector Martin <marcan@marcan.st>
> >    Signed-off-by: Ian Rogers <irogers@google.com>
> >    Tested-by: Hector Martin <marcan@marcan.st>
> >    Tested-by: Marc Zyngier <maz@kernel.org>
> >    Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> I think ARM/Apple-Mx is fine without this change, right?
>
> >
> > This gets us to the current code where I can trivially get an
> > inconsistency. Here on Intel with no PMU in the event name:
> > ```
> > $ perf stat -vv -e cpu-cycles true
> > Using CPUID GenuineIntel-6-8D-1
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 752915  cpu -1  group_fd -1  flags 0x8 =3D 3
> > cpu-cycles: -1: 1293076 273429 273429
> > cpu-cycles: 1293076 273429 273429
> >
> >  Performance counter stats for 'true':
> >
> >          1,293,076      cpu-cycles
> >
> >        0.000809752 seconds time elapsed
> >
> >        0.000841000 seconds user
> >        0.000000000 seconds sys
> > ```
> >
> > Here with a PMU event name:
> > ```
> > $ sudo perf stat -vv -e cpu/cpu-cycles/ true
> > Using CPUID GenuineIntel-6-8D-1
> > Attempt to add: cpu/cpu-cycles=3D0/
> > ..after resolving event: cpu/event=3D0x3c/
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             4 (cpu)
> >   size                             136
> >   config                           0x3c (cpu-cycles)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 752839  cpu -1  group_fd -1  flags 0x8 =3D 3
> > cpu/cpu-cycles/: -1: 1421235 531150 531150
> > cpu/cpu-cycles/: 1421235 531150 531150
> >
> >  Performance counter stats for 'true':
> >
> >          1,421,235      cpu/cpu-cycles/
> >
> >        0.001292908 seconds time elapsed
> >
> >        0.001340000 seconds user
> >        0.000000000 seconds sys
> > ```
> >
> > That is the no PMU event is opened as type=3D0/config=3D0 (legacy) whil=
e
> > the PMU event is opened as type=3D4/config=3D0x3c (sysfs encoding). Now
>
> I'm not sure it's a problem.  I think it works as expected...?
>
>
> > let's cross our fingers and hope that in the driver they are really
> > the same thing. I take objection to the idea that there should be two
> > different priorities for sysfs/json and legacy depending on whether a
> > PMU is or isn't specified in the event name. The priority could be
> > legacy then sysfs/json, or it could be sysfs/json then legacy, but it
> > should be the same regardless of whether the PMU is put in the event
>
> Well, I think having PMU name in the event is a big difference.  Legacy
> events were there since Day 1, I guess it's natural to think that an
> event without PMU name means a legacy event and others should come with
> PMU names explicitly.

So then we're breaking the event names by inserting a PMU name in
uniquify in the stat output:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-display.c?h=3Dperf-tools-next#n932

There was an explicit, and reviewed by Jiri and Arnaldo, intent with
the hybrid work that using a legacy event with a hybrid PMU, even
though the PMU doesn't advertise through json or sysfs the legacy
event, the perf tool supports it.

Making it so that events without PMUs are only legacy events just
doesn't work. There are far too many existing uses of non-legacy
events without PMU, the metrics contain 100s of examples.

Prior to switching json/sysfs to being the priority when a PMU is
specified, it was the case that all encodings were the same, with or
without a PMU.

I don't think there is anything natural about assuming things about
event names. Take cycles, cpu-cycles and cpu_cycles:
 - cycles on x86 is only encoded via a legacy event;
 - cpu-cycles on Intel exists as a sysfs event, but cpu-cycles is also
a legacy event name;
 - cpu_cycles exists as a sysfs event on ARM but doesn't have a
corresponding legacy event name.

The difference in meaning of an event name can be as subtle as the
difference between a hyphen and an underscore. Given that we can't
break everybody's `perf <command> -e <event name> ..` command name nor
should we break all the metrics, I think the most intuitive thing is
cycles behave the same with or without a PMU. For example, there may
be differences in accuracy between a fixed and generic counter and the
legacy event may only work with one counter because of this while the
sysfs/json event uses all the counters, or vice versa. As explained,
in output code the tool will or will not insert PMU names treating
them as not mattering. Currently they do matter as the parsing will
give different perf_event_attr and those can have differing kernel
behaviors. This patch fixes this.

Thanks,
Ian

