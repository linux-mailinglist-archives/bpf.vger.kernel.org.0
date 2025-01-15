Return-Path: <bpf+bounces-48983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D8A12D9B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285D71887825
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1651DB15C;
	Wed, 15 Jan 2025 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTBPd0SZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD81D6DB9
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976047; cv=none; b=bqfz1wpRy6kRLdAQ+qo0ZFLKogobaApvpA/uGvtdwXlJbHmENDXLkYRoHKceZFR/zWO0WoRqJXSt3ShfpXHgwcoEnAnuLHVYgO9tR9RP0c5wVBuesyMQ/rLGsb27s/YarwKukE0g8Dh6DgvjPJ3i7yegu/uaX10ufhhbSmcZb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976047; c=relaxed/simple;
	bh=RFQGnF82QQKEbPHmfAURW3WE2od1aVQDJNiwGyvFllE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIll513HRzik66qvwvhHAIYCsghfboJSVdeneN7Pm1TgD9OzfulT+K9fhd87ZnXnzyom7PotBjh0e33k9aEt4s0Q5stCy9fX58NSUjg0+hse6T6+5+WbyMQEfIG3Jegup64atzint02Pwr3hvW39+NAdKgZWRXyquZNEU5GRunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eTBPd0SZ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a814c54742so7025ab.1
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736976044; x=1737580844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeZMzdoAZOaC7hUZA2ynOD6FiOeCO3Zdi0LI3tDnsEQ=;
        b=eTBPd0SZBFKe/dxyjXJsrP4KMoUpKvomEuY3XRS1J3qAOnazgdHGM0MYXu722OCHsy
         8QnwGU+UgoWnkKaRgQQubgorvEU2Fn14pj9VqnneG25xSRGNcti437frMSEKAVBAc9sM
         zqCQJjg4DpSERFqr6kViXbqEm8hnGTvw70eWdqNp/I6kwNN3EMzf0qG7VniWv58t+7I8
         V+taB1LcqGlX7SKBLjCJuXdxxE2QYaDZ8rxNM1FJNDGZDKEE91VoQePTB7XOkc338DY6
         iiXT4tFg0NcLYWqUsA3X0ormxkoINHJQwCh/BW2u6TCBhBsdDpyErLLxdkn/GQH3JS0o
         peuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736976044; x=1737580844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeZMzdoAZOaC7hUZA2ynOD6FiOeCO3Zdi0LI3tDnsEQ=;
        b=azloB+RRGL37PgMy/yjVAyJg1FdKYxk8oK6fHuo+IsMXIdy093c9mGlrVqjnBI6KNU
         b6T1mxX3o8doEsIOky04roJDnAMHzWAJ5KRO/KcCO5je7dFCrJcHnJG8aljRIifP9REe
         QsD/KASdqjKMl64G5Gcpc/Gzq+8zjRD9BJQtpuyTw/ZvgZ+T1bPi5cj/Rbv/6Oc56tjH
         +mP6bpjucI6Y/Ska/pPvFEZvFYJBNwirLmdZA23epNUDqAYshDKNYrll04F5iJMO04Th
         znR71HV79gCNMhpmJ82/YeIaqsaFBnY5tybxeDYWF7f/r86VioKAJCCP5BWhtpduJCvJ
         k/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhZiKSMyq4aB1iH+xjHuzJUMASb4MGbhp8QnsE2hG0aWAzEJrUd5nyGO0T/ZzwCeQYASs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlA2/mbbKKw/xvemTX9gwe6RifA6M7EvL8nH5oR7J6H1FYm1Hy
	uOMX7AnhIi8adN+CR7AwwY63/pY/Paf7s2SRoSN7G5VcBIFSTjhQHS+GnPZKj3omTEn6Tli8peJ
	IkV721KQM0BwXKNYNQuv3u8y/Ddo2TsuFruU8
X-Gm-Gg: ASbGncvlMk4d2pd2x2CtDCNhJHE7ZO4iWQToYduU5ANmu21Wi6hDrrrKl4zcjxxubzR
	kq0NJlF8UO7XavgKELfnmXCzi79Ah9RpekrZ+W5VuVo0+OjZ5YJRjo8pFh3z7XRy4zrACJw==
X-Google-Smtp-Source: AGHT+IFdY3EdK0RlcaqR7XkhN3TwPfkXvTLWVLDZLyVErZSKQhkg++eul6BWJ+ye5pTMy/Cw/yGmyMYIs/WijFhs82g=
X-Received: by 2002:a05:6e02:13af:b0:3a7:e616:8d36 with SMTP id
 e9e14a558f8ab-3cee99d21f9mr659135ab.9.1736976043998; Wed, 15 Jan 2025
 13:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com> <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com> <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com> <Z4f3fDXemAMpBNMS@google.com>
In-Reply-To: <Z4f3fDXemAMpBNMS@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jan 2025 13:20:32 -0800
X-Gm-Features: AbW1kvYyQa9lv756_leTn8rvCmcqj4_u0BB6bMWojLD8QesTDfLByWCEv88e_84
Message-ID: <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
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

On Wed, Jan 15, 2025 at 9:59=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> > On Mon, Jan 13, 2025 at 2:51=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > > There was an explicit, and reviewed by Jiri and Arnaldo, intent with
> > > the hybrid work that using a legacy event with a hybrid PMU, even
> > > though the PMU doesn't advertise through json or sysfs the legacy
> > > event, the perf tool supports it.
>
> I thought legacy events on hybrid were converted to PMU events.

No, when BIG.little was created nothing changed in perf events but
when Intel did hybrid they wanted to make the hybrid CPUs (atom and
performance) appear as if they were one type. The PMU event encodings
vary a lot for this on Intel, ARM has standards for the encoding.
Intel extended the legacy format to take a PMU type id:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n41
"EEEEEEEE: PMU type ID"
that is in the top 32-bits of the config.

> > >
> > > Making it so that events without PMUs are only legacy events just
> > > doesn't work. There are far too many existing uses of non-legacy
> > > events without PMU, the metrics contain 100s of examples.
>
> That's unfortunate.  It'd be nice if metrics were written with PMU
> names.

But then we'd end up with things like on Intel:
UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD
becoming:
uncore_cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
or just:
cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
As a user the first works for me and doesn't have any ambiguity over
PMUs as the event name already encodes the PMU. AMD similarly place
the part of a pipeline into event names. Were we to break everybody by
requiring the PMU we'd also need to explain which PMU to use. Sites
with event lists (like https://perfmon-events.intel.com/) don't
explain the PMU and it'd be messy as on Intel you have a CHA PMU for
server chips but a CBOX on client chips, etc.

> I have a question.  What if an event name in a metric matches to
> multiple unrelated PMUs?

The metric may break or we'd aggregate the unrelated counts together.
Take a metric like IPC as "instructions/cycles", that metric should
work on a hybrid system as they have instructions and cycles. If you
used an event for instructions like inst_retired.any then maybe the
metric will fail on one kind of core that didn't have that event. Now
if we have accelerators advertising instructions and cycles events, we
should be able to compute the metric for the accelerator. What could
happen today is that the accelerator will have a cpumask of a single
CPU, we could aggregate the accelerator counter into the CPU event
with the same CPU as the cpumask, we'd end up with a weird quasi CPU
and accelerator IPC metric for that CPU. What should happen is that we
get an IPC for the accelerator and IPC for each hybrid core
independently, but the way we handle evsels, CPUs, PMUs is not really
set up for that. Hopefully getting a set of PMUs into the evsel will
clear that up. Assuming all of that is cleared up, is it wrong if the
IPC metric is computed for the accelerator if it was originally
written as a CPU metric? Not really. Could there be metrics where that
is the case? Probably, and specifying PMUs in the event names would be
a fix. There have also been proposals that we restrict the PMUs for
certain metrics. As event names are currently so distinct it isn't a
problem we've faced yet and it is not clear it is a problem other than
highlighting tech debt in areas of the tool like aggregation.

> > >
> > > Prior to switching json/sysfs to being the priority when a PMU is
> > > specified, it was the case that all encodings were the same, with or
> > > without a PMU.
> > >
> > > I don't think there is anything natural about assuming things about
> > > event names. Take cycles, cpu-cycles and cpu_cycles:
> > >  - cycles on x86 is only encoded via a legacy event;
> > >  - cpu-cycles on Intel exists as a sysfs event, but cpu-cycles is als=
o
> > > a legacy event name;
> > >  - cpu_cycles exists as a sysfs event on ARM but doesn't have a
> > > corresponding legacy event name.
>
> I think the behavior should be:
>
>   cycles -> PERF_COUNT_HW_CPU_CYCLES
>   cpu-cycles -> PERF_COUNT_HW_CPU_CYCLES
>   cpu_cycles -> no legacy -> sysfs or json
>   cpu/cycles/ -> sysfs or json
>   cpu/cpu-cycles/ -> sysfs or json

So I disagree as if you add a PMU to an event name the encoding
shouldn't change:
1) This historically was perf's behavior.
2) Different event encodings can have different behaviors (broken in
some notable cases).
3) Intuitively what wildcarding does is try to open "*/event/" where *
is every possible PMU name. Having different event encodings is
breaking that intuition it could also break situations where you try
to assert equivalence based on type/config.
4) The legacy encodings were (are?) broken on ARM Apple M? CPUs,
that's why the priority was changed.
5) RISC-V would like the tool tackle the legacy to config mapping
challenge, rather than the PMU driver, given the potential diversity
of hardware implementations.

To this end we hosted RISC-V's perf people at Google and they
expressed that their preference was what this series does, and they
expressed this directly to you.

I don't think there would be an issue in this area if it wasn't for
Neoverse and Linus - that's why the revert happened. This change in
behavior was proposed by Arnaldo:
https://lore.kernel.org/lkml/ZlY0F_lmB37g10OK@x1/
and has tags from Intel, ARM and Rivos (RISC-V). I intend to carry it
in Google's tree.

Thanks,
Ian

