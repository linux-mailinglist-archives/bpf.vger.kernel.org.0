Return-Path: <bpf+bounces-50109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288F7A228D1
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 07:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6B71887476
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51F19048A;
	Thu, 30 Jan 2025 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="L7RP5mcq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2718E379
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217548; cv=none; b=oKnxlv4Xl6Q2RnCivRYwjv0LsqxfVkS078IMiyw/lf72SS/7S0nRyazsbO85m+qipfeh9TdK9iuk+BJL6OKlcQmmdBQaVMKhwa0TPzqN/n/PglyIG8ny6q7HyyGCAN/aC+IAUehDW7MQW4dAEtfYtm61maxiuP/SZWIOS8yb2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217548; c=relaxed/simple;
	bh=S/NTeMlyAbCUacMsVp7UZqbtzI+r/cIlVY3VvfYXXU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT8jidmGFZ6ps8UHShI6bJkfxhajQpVqDZhKFhz+NbQ2G0T0/+L5AfjFeToZtrl9bKSZXjgHq5vvDiRbCjGAjigPpg97Xj3vA/y1n3NrxNFSrIDvSpPRmeQ8rhEW3nFJQN8K4WkY+3fs4Owyx2/DsvusYE2SvbVrz498xKZWDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=L7RP5mcq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21634338cfdso9368185ad.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 22:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738217545; x=1738822345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck4YiQJSe/CiIleYZC+p8vhI5mOkS1kJp721Y7KAM/I=;
        b=L7RP5mcqJZ4CuzqJNxpIbl8jFceB3JMUwOC0Pl14z65nQJMP4oMTOXc4JK2ItfV5+t
         /7YxIWMXfAkcLYJEbR06ZjCOF4TVC7OUnvGK4p0MEH5S9QhN4lJ+Tpljh9v2mKQQIKbq
         I4DToqC2q6T0Qhe+uYsSh69CyVDHQIcc3SftSQ8IxInlaILeTy9F/v62981ZQY/M4wWj
         UlOUVxGhoXuSy8VatoFjuRMm9Xo5CWM87KI5TabWdRvXEFKk9soKXsEKJI8G6g1og1d/
         T2axpXbxmuFw61hk5EFeOmD27XlB1OMP9JfG9rn7knAsUjsNvZLuxfMMYMS5uo1yfLVX
         VIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738217545; x=1738822345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck4YiQJSe/CiIleYZC+p8vhI5mOkS1kJp721Y7KAM/I=;
        b=DD4J6FfSmTf6qczIyZn3pQMfSoQKWEMtLVzy5OlaAD8ANBFdaMoL7lvDUAazLmLrZh
         N1nGh7Mnh+lwMsN3N3VX1mUoQWAeDgg689gBjEjhbX1x9PhI1U4sooUSRIKs4x5sHB62
         Oht0WfVhQ/zzYztDyx/qnROPAwA9bHj3UYftGL8EHItLHcmHnAEKnfYrLJkh/E3Ub+il
         MrDgCFr+z3bxMN5FX80kw7F1rbXX1i6UjFDP3fWsqghPHbZaShGQdNFQgZnlvXcSG0nU
         KnuPcOHLRQG202Mu10+FsgM0WNhq6y9f3VzS0nN7IJhc6WD70MUDf7WeYIEejDovwa4y
         IaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrUoYs4l3OKZkICwYFJM18VL58ySMzmKoD+HKFsSmPThgYGDLGIVpPGg/9QhH4yfILeuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybrR/JMUyUJF+C5GmBvOxpws7Jpy52Aq7jAJQQY3tE/V7fKVRd
	rZkokjUnyXnn3Z5njOaDteLezLnrpAEEq77yFfgglTc/pxiofGIfn+rl9+Y9aZudjvFJu+j/hlJ
	A7uZl+ZHQyupDB8rGQV3K18UDf5zk9AlHD1M67Q==
X-Gm-Gg: ASbGncsw7OZXGuC3/g7b3GsQUh3LND64vJ0DI+jDDH4qk9zOo4wjHyR9TWyUUN6Ln4K
	vxUcDZ7HnHH735naa3zvXobHvvGiRQgGVxlmCMUGnPCIvgOytKhnPS97gsuOeAcYw6wxZD4r21k
	xT0JRSVFVkm854/Exk7USBQocZTv/AFA==
X-Google-Smtp-Source: AGHT+IEWh8JLbIO2bvwIUp5R+rreTpLm9XLHfdDrsKThuDLqmksDsfExOMAt6jPcPBSDPCsLfeMfjzZWh8ZFH2As8w0=
X-Received: by 2002:a05:6a00:2406:b0:72d:9cbc:730d with SMTP id
 d2e1a72fcca58-72fd0c2246cmr8329616b3a.11.1738217545514; Wed, 29 Jan 2025
 22:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com> <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com> <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com> <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com>
In-Reply-To: <Z5qjwRG5jX9zAGtf@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 29 Jan 2025 22:12:14 -0800
X-Gm-Features: AWEUYZnK6efdcPp8zZmUSR82f5uqYNABSDrUdweCv75p4kdK2gHG_RNIRiXiTIg
Message-ID: <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 1:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 15, 2025 at 01:20:32PM -0800, Ian Rogers wrote:
> > On Wed, Jan 15, 2025 at 9:59=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > > On Mon, Jan 13, 2025 at 2:51=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > > There was an explicit, and reviewed by Jiri and Arnaldo, intent w=
ith
> > > > > the hybrid work that using a legacy event with a hybrid PMU, even
> > > > > though the PMU doesn't advertise through json or sysfs the legacy
> > > > > event, the perf tool supports it.
> > >
> > > I thought legacy events on hybrid were converted to PMU events.
> >
> > No, when BIG.little was created nothing changed in perf events but
> > when Intel did hybrid they wanted to make the hybrid CPUs (atom and
> > performance) appear as if they were one type. The PMU event encodings
> > vary a lot for this on Intel, ARM has standards for the encoding.
> > Intel extended the legacy format to take a PMU type id:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n41
> > "EEEEEEEE: PMU type ID"
> > that is in the top 32-bits of the config.
>
> Oh right, I forgot the extended type thing.  Then we can keep the legacy
> encoding with it on hybrid systems when users give well-known names (w/o
> PMU) for legacy event.
>
> >
> > > > >
> > > > > Making it so that events without PMUs are only legacy events just
> > > > > doesn't work. There are far too many existing uses of non-legacy
> > > > > events without PMU, the metrics contain 100s of examples.
> > >
> > > That's unfortunate.  It'd be nice if metrics were written with PMU
> > > names.
> >
> > But then we'd end up with things like on Intel:
> > UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD
> > becoming:
> > uncore_cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
> > or just:
> > cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
> > As a user the first works for me and doesn't have any ambiguity over
> > PMUs as the event name already encodes the PMU. AMD similarly place
> > the part of a pipeline into event names. Were we to break everybody by
> > requiring the PMU we'd also need to explain which PMU to use. Sites
> > with event lists (like https://perfmon-events.intel.com/) don't
> > explain the PMU and it'd be messy as on Intel you have a CHA PMU for
> > server chips but a CBOX on client chips, etc.
>
> While I prefer having PMU names in the JSON events/metrics, it may not
> be pratical to change them all.  Probably we can allow them without PMU
> and hope that they have unique prefixes.
>
> >
> > > I have a question.  What if an event name in a metric matches to
> > > multiple unrelated PMUs?
> >
> > The metric may break or we'd aggregate the unrelated counts together.
>
> Ok, then they should use unique names.
>
>
> > Take a metric like IPC as "instructions/cycles", that metric should
> > work on a hybrid system as they have instructions and cycles. If you
> > used an event for instructions like inst_retired.any then maybe the
> > metric will fail on one kind of core that didn't have that event. Now
>
> The metrics is for specific CPU model then the vendor should be
> responsible to provide accurate metrics using approapriate PMU/events
> IMHO.
>
>
> > if we have accelerators advertising instructions and cycles events, we
> > should be able to compute the metric for the accelerator. What could
> > happen today is that the accelerator will have a cpumask of a single
> > CPU, we could aggregate the accelerator counter into the CPU event
> > with the same CPU as the cpumask, we'd end up with a weird quasi CPU
> > and accelerator IPC metric for that CPU. What should happen is that we
> > get an IPC for the accelerator and IPC for each hybrid core
> > independently, but the way we handle evsels, CPUs, PMUs is not really
> > set up for that. Hopefully getting a set of PMUs into the evsel will
> > clear that up. Assuming all of that is cleared up, is it wrong if the
> > IPC metric is computed for the accelerator if it was originally
> > written as a CPU metric? Not really. Could there be metrics where that
> > is the case?
>
> Yes, I think there should be separate metrics for the accelerators.
>
>
> > Probably, and specifying PMUs in the event names would be
> > a fix. There have also been proposals that we restrict the PMUs for
> > certain metrics. As event names are currently so distinct it isn't a
> > problem we've faced yet and it is not clear it is a problem other than
> > highlighting tech debt in areas of the tool like aggregation.
> >
> > > > >
> > > > > Prior to switching json/sysfs to being the priority when a PMU is
> > > > > specified, it was the case that all encodings were the same, with=
 or
> > > > > without a PMU.
> > > > >
> > > > > I don't think there is anything natural about assuming things abo=
ut
> > > > > event names. Take cycles, cpu-cycles and cpu_cycles:
> > > > >  - cycles on x86 is only encoded via a legacy event;
> > > > >  - cpu-cycles on Intel exists as a sysfs event, but cpu-cycles is=
 also
> > > > > a legacy event name;
> > > > >  - cpu_cycles exists as a sysfs event on ARM but doesn't have a
> > > > > corresponding legacy event name.
> > >
> > > I think the behavior should be:
> > >
> > >   cycles -> PERF_COUNT_HW_CPU_CYCLES
> > >   cpu-cycles -> PERF_COUNT_HW_CPU_CYCLES
> > >   cpu_cycles -> no legacy -> sysfs or json
> > >   cpu/cycles/ -> sysfs or json
> > >   cpu/cpu-cycles/ -> sysfs or json
> >
> > So I disagree as if you add a PMU to an event name the encoding
> > shouldn't change:
> > 1) This historically was perf's behavior.
>
> Well.. I'm not sure about the history.  I believe the logic I said above
> is the historic and (I think) right behavior.
>
> > 2) Different event encodings can have different behaviors (broken in
> > some notable cases).
>
> Yep, let's make it clear.
>
> > 3) Intuitively what wildcarding does is try to open "*/event/" where *
> > is every possible PMU name. Having different event encodings is
> > breaking that intuition it could also break situations where you try
> > to assert equivalence based on type/config.
>
> While I don't like the wildcard matching, I think it doesn't matter as
> long as we keep the above behavior.  If it can find a legacy name, then
> go with it, done.  If not, try all PMUs as if it's given with PMU name
> in the event.
>
> > 4) The legacy encodings were (are?) broken on ARM Apple M? CPUs,
> > that's why the priority was changed.
>
> I guess that why they use cpu_cycles.
>
> > 5) RISC-V would like the tool tackle the legacy to config mapping
> > challenge, rather than the PMU driver, given the potential diversity
> > of hardware implementations.
>
> I hope they can find a better solution. :)
>

Sorry for reposing. Gmail converted it to html for some reason.

I have posted the latest support here.
https://lore.kernel.org/kvm/20250127-counter_delegation-v3-12-64894d7e16d5@=
rivosinc.com/T/

As of now, we have adopted a hybrid approach where a vendor can decide
whether to encode the legacy events
in the json or in the driver (if this series is merged). In absence of
that, every vendor has to define it in the driver.
We will deal with the fall out of the exploding driver when the
situation arrives.

If a vendor chooses to define in both places, driver encoding will
take precedence.
I have tried to describe the scheme in the cover letter. Please let me
know if I should clarify more.

> >
> > To this end we hosted RISC-V's perf people at Google and they
> > expressed that their preference was what this series does, and they
> > expressed this directly to you.
> >
> > I don't think there would be an issue in this area if it wasn't for
> > Neoverse and Linus - that's why the revert happened. This change in
> > behavior was proposed by Arnaldo:
> > https://lore.kernel.org/lkml/ZlY0F_lmB37g10OK@x1/
> > and has tags from Intel, ARM and Rivos (RISC-V). I intend to carry it
> > in Google's tree.
>
> Maybe it's because of Linus.  But anyway it reminds me of behaviors that
> need to be discussed.  And we can (and should) improve things always.
>
> Thanks,
> Namhyung
>

