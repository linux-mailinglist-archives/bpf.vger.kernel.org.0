Return-Path: <bpf+bounces-50311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEBAA25224
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 06:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AED3A4679
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 05:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012641465BA;
	Mon,  3 Feb 2025 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="L9ukuxxH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAB339A1
	for <bpf@vger.kernel.org>; Mon,  3 Feb 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738561649; cv=none; b=t/Sa6gq9jRoUPTu/LTum7gI4xMw8Wt1w27XhZawPhu6wKwtCa6mL6z8iLk4wZoKmiNph0yIC8NULbJHPhRy6aMAz0etNuLc++QwkpUWbxHdPjUKTQoqO2eamB9+7t5pVxPcOOSmwWLjk9Llk7SOr3s6Ui6xNrGJZcZFGrVuBlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738561649; c=relaxed/simple;
	bh=8iuATC6mBwkndZhwf/Jq4v5L3igbHn7zqmcXv11SFXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r77l2MCKvG07CPwqdmc7FZr81gyPzUkhfbifboqtGF5kBCYzGln0N3xEEYsEPUqIjUxDqTnXxmVustL/ZIhY6mT2ZyJ6NA6/ctSZ0+8BEnmW97y5a86tA/k68s1wo0OYL0mf+bMLylL+CvzBrtMj61l5SQZeAU5s/9iYznuhNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=L9ukuxxH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso5036078a91.1
        for <bpf@vger.kernel.org>; Sun, 02 Feb 2025 21:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738561647; x=1739166447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zD86D1VfcMORlm//b5KGShjw5URyyiGtxp7Nsfy5qU=;
        b=L9ukuxxHUq+9BefHsnLGOcXLBb/CRMDVBKIElmhgzLRSTEq6ebkrGO44S9gIvMh3TR
         lai4nTCsB8hTCSTC0CIkaN6VsY41MxDdfJ2iQQTNx5Vd/34aAKAYuD5eAr0eIkYfEQ8f
         IkuDW/FItfHuttVpJIoUjNpZskSFGKIw8TiztGeFj3R1t/ZpwzqfKEHRr2mWxi58xt09
         1qwZWebwtDenMmWPvXEc0jlD13k4Um/khTIwU/a5/HsFooxsruF74aZ36SloGiC3UVgA
         4fBVZCuFqupuMsASS4ridvMOw9Ffka+URVGWFwC3n3gfWbdjqZH2LsS/aWjjPhTJVoXv
         jXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738561647; x=1739166447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zD86D1VfcMORlm//b5KGShjw5URyyiGtxp7Nsfy5qU=;
        b=k0hJcp5HzexX/66uWi3t7nM29grq2Fw8X23OKFN9P8P2DAROgj4QpuZHQ6UpMKE1zp
         h+MsMmhhWayyq7gkUDfqYwfBT/x4MQ90tOIT2Y6QMAp2sBEb73Iv/OpvAxBoN3cOqmV1
         YMjrerPsSdrvrU2Wz9VuydNp2sZyms0t6F7sW845N63KVu1HRSSZ+yFLnWRqyLlBBAL3
         ItqfHhRRbIxabbGP5Y6O69HMn/jyv1EetpwKC9sZDKNWWfE5T0v6o4oMnUrbbYV+Ccvi
         1cXNdTAvrRo9VNW5sjFy4d6Q7EJszv4h/X3w9ScQ+aeZVjpJgLZ97mv0LWwzO6m+K1ZV
         LaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVu45sN+ubVDWt4H+5Uc6pjhqI+Nawzd0LZUM/ZUnRKUlgIu5d2r0V6Hotox/KghmGMNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FlV8Z+/4GVePPbIM0PmRLitbAstKxmmCQk8dHa8xF8aR8Is9
	cRVY7i8D4pCp+7Qlit1U3kjPDH3Qjooj/MnkpNlKwqHlhTVmb8suFIQok0+7LLbyeb+M4EuyYj1
	cM3R3zXiiHGrTViCAvc/JcfIPWXhlRWhGQzNrPw==
X-Gm-Gg: ASbGncvUsSApKCdx3+Hn2ySneduDIAE1Hq/Q0tpaAvO3V0w2f72tHrrjpkqOiM+/S8P
	gazdZphPfVgSB7rH0lM3YEfFCa75YoWBxXBnak4S10yC+562fG6A1/YS1Zf6RNQcqMnkVwjVCqU
	JjTHyCK9RsOepwPAO25Ri6QQU8V/J5Vlg=
X-Google-Smtp-Source: AGHT+IFFJxtXD0g0LZKi4bOQIoY5kVJrYvNnq4/J9dmmZ8ZZBFZjkX4We03FuHI28jNVJLIjreKCNpf7936JKqVEUMg=
X-Received: by 2002:a05:6a00:2a09:b0:730:1da:d0e with SMTP id
 d2e1a72fcca58-73001da0d56mr12800194b3a.18.1738561646541; Sun, 02 Feb 2025
 21:47:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-5-irogers@google.com> <Z4F3qxFaYnMTtPw7@google.com>
 <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com> <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com> <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com> <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com>
In-Reply-To: <Z51RxQslsfSrW2ub@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Sun, 2 Feb 2025 21:47:15 -0800
X-Gm-Features: AWEUYZnen_hhIu5FGpUUyAAJOeLV972bIGAtyP8fXMZPlMm2eJCIDGj4aAf8-bQ
Message-ID: <CAHBxVyEMFrtEVOmehJaMLqxnNXuy-qXtmt+Mb5NT3-3NV0SbhA@mail.gmail.com>
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

On Fri, Jan 31, 2025 at 2:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 29, 2025 at 10:12:14PM -0800, Atish Kumar Patra wrote:
> > On Wed, Jan 29, 2025 at 1:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Jan 15, 2025 at 01:20:32PM -0800, Ian Rogers wrote:
> > > > On Wed, Jan 15, 2025 at 9:59=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > > On Mon, Jan 13, 2025 at 2:51=E2=80=AFPM Ian Rogers <irogers@goo=
gle.com> wrote:
> > > > > > > There was an explicit, and reviewed by Jiri and Arnaldo, inte=
nt with
> > > > > > > the hybrid work that using a legacy event with a hybrid PMU, =
even
> > > > > > > though the PMU doesn't advertise through json or sysfs the le=
gacy
> > > > > > > event, the perf tool supports it.
> > > > >
> > > > > I thought legacy events on hybrid were converted to PMU events.
> > > >
> > > > No, when BIG.little was created nothing changed in perf events but
> > > > when Intel did hybrid they wanted to make the hybrid CPUs (atom and
> > > > performance) appear as if they were one type. The PMU event encodin=
gs
> > > > vary a lot for this on Intel, ARM has standards for the encoding.
> > > > Intel extended the legacy format to take a PMU type id:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n41
> > > > "EEEEEEEE: PMU type ID"
> > > > that is in the top 32-bits of the config.
> > >
> > > Oh right, I forgot the extended type thing.  Then we can keep the leg=
acy
> > > encoding with it on hybrid systems when users give well-known names (=
w/o
> > > PMU) for legacy event.
> > >
> > > >
> > > > > > >
> > > > > > > Making it so that events without PMUs are only legacy events =
just
> > > > > > > doesn't work. There are far too many existing uses of non-leg=
acy
> > > > > > > events without PMU, the metrics contain 100s of examples.
> > > > >
> > > > > That's unfortunate.  It'd be nice if metrics were written with PM=
U
> > > > > names.
> > > >
> > > > But then we'd end up with things like on Intel:
> > > > UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD
> > > > becoming:
> > > > uncore_cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
> > > > or just:
> > > > cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
> > > > As a user the first works for me and doesn't have any ambiguity ove=
r
> > > > PMUs as the event name already encodes the PMU. AMD similarly place
> > > > the part of a pipeline into event names. Were we to break everybody=
 by
> > > > requiring the PMU we'd also need to explain which PMU to use. Sites
> > > > with event lists (like https://perfmon-events.intel.com/) don't
> > > > explain the PMU and it'd be messy as on Intel you have a CHA PMU fo=
r
> > > > server chips but a CBOX on client chips, etc.
> > >
> > > While I prefer having PMU names in the JSON events/metrics, it may no=
t
> > > be pratical to change them all.  Probably we can allow them without P=
MU
> > > and hope that they have unique prefixes.
> > >
> > > >
> > > > > I have a question.  What if an event name in a metric matches to
> > > > > multiple unrelated PMUs?
> > > >
> > > > The metric may break or we'd aggregate the unrelated counts togethe=
r.
> > >
> > > Ok, then they should use unique names.
> > >
> > >
> > > > Take a metric like IPC as "instructions/cycles", that metric should
> > > > work on a hybrid system as they have instructions and cycles. If yo=
u
> > > > used an event for instructions like inst_retired.any then maybe the
> > > > metric will fail on one kind of core that didn't have that event. N=
ow
> > >
> > > The metrics is for specific CPU model then the vendor should be
> > > responsible to provide accurate metrics using approapriate PMU/events
> > > IMHO.
> > >
> > >
> > > > if we have accelerators advertising instructions and cycles events,=
 we
> > > > should be able to compute the metric for the accelerator. What coul=
d
> > > > happen today is that the accelerator will have a cpumask of a singl=
e
> > > > CPU, we could aggregate the accelerator counter into the CPU event
> > > > with the same CPU as the cpumask, we'd end up with a weird quasi CP=
U
> > > > and accelerator IPC metric for that CPU. What should happen is that=
 we
> > > > get an IPC for the accelerator and IPC for each hybrid core
> > > > independently, but the way we handle evsels, CPUs, PMUs is not real=
ly
> > > > set up for that. Hopefully getting a set of PMUs into the evsel wil=
l
> > > > clear that up. Assuming all of that is cleared up, is it wrong if t=
he
> > > > IPC metric is computed for the accelerator if it was originally
> > > > written as a CPU metric? Not really. Could there be metrics where t=
hat
> > > > is the case?
> > >
> > > Yes, I think there should be separate metrics for the accelerators.
> > >
> > >
> > > > Probably, and specifying PMUs in the event names would be
> > > > a fix. There have also been proposals that we restrict the PMUs for
> > > > certain metrics. As event names are currently so distinct it isn't =
a
> > > > problem we've faced yet and it is not clear it is a problem other t=
han
> > > > highlighting tech debt in areas of the tool like aggregation.
> > > >
> > > > > > >
> > > > > > > Prior to switching json/sysfs to being the priority when a PM=
U is
> > > > > > > specified, it was the case that all encodings were the same, =
with or
> > > > > > > without a PMU.
> > > > > > >
> > > > > > > I don't think there is anything natural about assuming things=
 about
> > > > > > > event names. Take cycles, cpu-cycles and cpu_cycles:
> > > > > > >  - cycles on x86 is only encoded via a legacy event;
> > > > > > >  - cpu-cycles on Intel exists as a sysfs event, but cpu-cycle=
s is also
> > > > > > > a legacy event name;
> > > > > > >  - cpu_cycles exists as a sysfs event on ARM but doesn't have=
 a
> > > > > > > corresponding legacy event name.
> > > > >
> > > > > I think the behavior should be:
> > > > >
> > > > >   cycles -> PERF_COUNT_HW_CPU_CYCLES
> > > > >   cpu-cycles -> PERF_COUNT_HW_CPU_CYCLES
> > > > >   cpu_cycles -> no legacy -> sysfs or json
> > > > >   cpu/cycles/ -> sysfs or json
> > > > >   cpu/cpu-cycles/ -> sysfs or json
> > > >
> > > > So I disagree as if you add a PMU to an event name the encoding
> > > > shouldn't change:
> > > > 1) This historically was perf's behavior.
> > >
> > > Well.. I'm not sure about the history.  I believe the logic I said ab=
ove
> > > is the historic and (I think) right behavior.
> > >
> > > > 2) Different event encodings can have different behaviors (broken i=
n
> > > > some notable cases).
> > >
> > > Yep, let's make it clear.
> > >
> > > > 3) Intuitively what wildcarding does is try to open "*/event/" wher=
e *
> > > > is every possible PMU name. Having different event encodings is
> > > > breaking that intuition it could also break situations where you tr=
y
> > > > to assert equivalence based on type/config.
> > >
> > > While I don't like the wildcard matching, I think it doesn't matter a=
s
> > > long as we keep the above behavior.  If it can find a legacy name, th=
en
> > > go with it, done.  If not, try all PMUs as if it's given with PMU nam=
e
> > > in the event.
> > >
> > > > 4) The legacy encodings were (are?) broken on ARM Apple M? CPUs,
> > > > that's why the priority was changed.
> > >
> > > I guess that why they use cpu_cycles.
> > >
> > > > 5) RISC-V would like the tool tackle the legacy to config mapping
> > > > challenge, rather than the PMU driver, given the potential diversit=
y
> > > > of hardware implementations.
> > >
> > > I hope they can find a better solution. :)
> > >
> >
> > Sorry for reposing. Gmail converted it to html for some reason.
> >
> > I have posted the latest support here.
> > https://lore.kernel.org/kvm/20250127-counter_delegation-v3-12-64894d7e1=
6d5@rivosinc.com/T/
> >
> > As of now, we have adopted a hybrid approach where a vendor can decide
> > whether to encode the legacy events
> > in the json or in the driver (if this series is merged). In absence of
> > that, every vendor has to define it in the driver.
> > We will deal with the fall out of the exploding driver when the
> > situation arrives.
>
> I don't know how hard it'd be cause I'm not familiar with RISC-V.  But
> basically you only need to maintain 9 legacy encodings (PERF_COUNT_HW_*)
> and a few dozen combinations of supported cache events (PERF_COUNT_HW_
> CACHE_*) for each vendor.  All others can go to json anyway.
>
That's what I did in the series posted above.

The infrastructure:
https://lore.kernel.org/kvm/20250127-counter_delegation-v3-12-64894d7e16d5@=
rivosinc.com/T/#m2bcb3bbf267f9131c45cc55e3dffd45c31859f34

Example of qemu event encoding:
https://lore.kernel.org/kvm/20250127-counter_delegation-v3-12-64894d7e16d5@=
rivosinc.com/T/#m51985fb0c4e323bc037da32a19b7d85d92d0d864

Please let us know if you see any issues with this approach.

> I think this is what all other archs (including x86) do.
>
> Thanks,
> Namhyung
>
> >
> > If a vendor chooses to define in both places, driver encoding will
> > take precedence.
> > I have tried to describe the scheme in the cover letter. Please let me
> > know if I should clarify more.
> >
> > > >
> > > > To this end we hosted RISC-V's perf people at Google and they
> > > > expressed that their preference was what this series does, and they
> > > > expressed this directly to you.
> > > >
> > > > I don't think there would be an issue in this area if it wasn't for
> > > > Neoverse and Linus - that's why the revert happened. This change in
> > > > behavior was proposed by Arnaldo:
> > > > https://lore.kernel.org/lkml/ZlY0F_lmB37g10OK@x1/
> > > > and has tags from Intel, ARM and Rivos (RISC-V). I intend to carry =
it
> > > > in Google's tree.
> > >
> > > Maybe it's because of Linus.  But anyway it reminds me of behaviors t=
hat
> > > need to be discussed.  And we can (and should) improve things always.
> > >
> > > Thanks,
> > > Namhyung
> > >

