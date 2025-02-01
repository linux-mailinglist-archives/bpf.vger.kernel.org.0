Return-Path: <bpf+bounces-50270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDFEA247CB
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 09:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6116F188595E
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CB51487C5;
	Sat,  1 Feb 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAibcVf9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D6A935
	for <bpf@vger.kernel.org>; Sat,  1 Feb 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738399520; cv=none; b=oS08CAwvr2ZoRg0wnAA5kD/9a0TGq46F/+ulBpO/4OqNGU9RiLdPo7GIkuRt2O7/jiVFmUsO0t9G5qhYB4LwPAS2A/fyBofQxRTJQMP+J8j8CmPGwfqBHwKiHm7wojbGZUKR82PWHwcCaAxK+sv5cHlsfHsc8G7ZFSO1Gpwez4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738399520; c=relaxed/simple;
	bh=V+k1gyWzXQ5n+Oh8v/2qvMFY9z5h7RS31lsxRYUCdXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqKZNrwlIAHmgUlrzbfuglLCicUlu7vxebo5X8VPWGkLPceJmLwZVBtjvp9xZGMvFxrZO+ljFOEKSgjGFX0F0IOFrVYhdsGkDRuNbTEDzwvEAuHSNPF7RmOiJCmetxicqrEmJMPXX0zLQcWncyoTpTlAcaGafHoquMiVU2gUNgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QAibcVf9; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so105465ab.0
        for <bpf@vger.kernel.org>; Sat, 01 Feb 2025 00:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738399516; x=1739004316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsA3GVEXaa9oBLCbalCfE/uXqekerRN9xSiBXHuz2tU=;
        b=QAibcVf9j+NbYd/p/u3kd3Dl8fhOzDR0fbZzZVTjGM/bS6gTVzr4XVNgmDDP1bq7JZ
         qKLqzKQ3WnM3xF6YaU52o/RRy90+WA4jvmTtrkX7I08Xq2xV82sV99HM/sQnWHwdjHnv
         ei1q/E4nWnhhhOqzcsozbJueVXV/UExSIO1ysSOV7g6MJsN+OxokLwrvH4Gf1uEeEnxP
         i60DJAHRuS4rIQO3en45egAHtAQZuC3bWJ5eTy4kRxywqa/7Id129BHZfuyWpwCLjR3H
         Bebh1gHXOb5ljXctBTs3HdXQcG+QreBYRrq+zZVL7Yc2zy/vCmZZ9yOQd3PF/QODdgop
         LaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738399516; x=1739004316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsA3GVEXaa9oBLCbalCfE/uXqekerRN9xSiBXHuz2tU=;
        b=LYqwtlHLsrC4W+QfI/uZPyWIcpm5lE3KfE9OqC9llIbmCc0o4g4uf6u27T/BiAj04W
         wanFGdO12Z+EFkhYfev6lGfHxyf2G8i2YzufkgV1JrU3rICjeMDt9olXmrSF2g22AZwF
         Q/FoxZbnFiuBiWOhfyBukLQd4yW0k64qyyBZj/3zRD7NkTWGjxfbNrZig8oPIj0iXh8U
         m21KBZrpA9ET0hlPDc36eK/BmbPT1VQ05IipXulcTxLfGi1sOp6cXo6nfixKfH9BxIK/
         jfDk/lfhwczUvIp9CsyvhGCEHHOWZqA1WELhwnI7Hsh7D6dlg5SIGk4PX/Hdno3op6Ik
         YvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQkwYx7yNSYAi3mh0vWTttxU616N2XQBI2CQUfWzuMUTmchALUQ/HcdubG13cX8nUNW6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNv0Ry3ReqENM0hFYaopGxrYrp+0n4lTeSUN+X8XI8RZgocsv
	JQLdQgFwLTu3rGnpUWYUuArYHJb6qzKI6clJaGEg8c0SmmIewk3qFiavW2cV+UePn/KEwi/4nHI
	JZeHkE2EcPQv/fQfSKucACPcD/ph7+5mELHBj
X-Gm-Gg: ASbGncsUDszpCDSqnasflueu9X903CXorwX7wAZZu/d8Rkt/BDm0aJUWlU0gPr67Q7M
	G9813WbvCkbcUrcRcmS+jhzXtPITEDtEr+3EQSbU+2RRpULck7wY2ezlOkxrWCcDmgdcKa9z/KA
	==
X-Google-Smtp-Source: AGHT+IFJKQYakUQN6fE62xynibpcnE2OErVv+x1hdTZ6PnMAZS6IyC+Rlnbmg868kb3Ll3hdUyrFFlh2PEVoEedJeQk=
X-Received: by 2002:a92:ca4e:0:b0:3ce:35c8:bdf3 with SMTP id
 e9e14a558f8ab-3d020184b99mr2302095ab.2.1738399516085; Sat, 01 Feb 2025
 00:45:16 -0800 (PST)
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
From: Ian Rogers <irogers@google.com>
Date: Sat, 1 Feb 2025 00:45:04 -0800
X-Gm-Features: AWEUYZme-NQY8WkyVByRY-Yk8JOt9JeBz2xNq5MsQvqT6jIQfxM3tvHieaXBHuU
Message-ID: <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
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
> I think this is what all other archs (including x86) do.

This is well known to the people involved.

While the PMU driver needs to encode or avoid these event names, they
become special "legacy" names inside the perf tool. Magically a name
like cpu_cycles will wildcard match (match on >1 PMU) whilst a name
like cpu-cycles won't (only matching on core PMUs). This is completely
confusing to users. It is even more confusing when you are saying the
tool should intentionally use two different encodings.

The perf event enum types are limited but the tool recognizes more
event names and then uses legacy encodings. I have yet to hear a
sensible list of what are legacy event names, is cpu-cycles in there
or just cycles? Why on earth would you want to keep synonyms like LLC
meaning L2 cache?

The intention with "pmu syntax" for events is that the PMU clarifies
the type in the perf_event_attr. Previously it was assumed that the
PMU type would be raw (4), and the x86 PMUs even use that as their
type number. Pretending these days we don't now have hybrid core PMUs,
10s of uncore PMUs. Doing that work had to reinvent event parsing and
encoding.

If you look at the matching as it is today:
cpu_cycles -> tries to match on all PMUs
*/cpu_cycles/ -> tries to match on all PMUs
arm*/cpu_cycles/ -> tries matches on all PMUs that have arm at the start
armv8_pmuv3/cpu_cycles/ -> matches only the armv8_pmuv3 PMU

I don't see why it isn't obvious that the behavior of no PMU and the
PMU being * is expected to be exactly the same - it really is today
and that is what the code does, please try it. There just isn't a
notion of not having a PMU because even for legacy events we have to
reinvent the PMUs to inject the correct extended type information
otherwise we'd profile just a fraction of the cores. We add PMUs when
we display events to make the events more readable. There isn't a
notion of these events being legacy and not, they are just assumed to
be the same, PMU or not.

As I've explained to you, I plan to transition the metric code to use
event parsing and to union evlists rather than use strings and hash
tables. This is to fix tracepoints appearing incorrectly to always
have suffixes in the "metric-id" calculation. Recognizing modifiers
properly would end up reinventing event parsing, so let's just make
use of what we have and parse events early. It makes sense when
unioning evsels in an evlist to do it off of the perf_event_attr, this
will allow Intel's slots and topdown.slots to be correctly detected as
aliases in metrics, something of a pain in formulas today. Why would
the behavior of an event like cycles be different in non-hybrid
metrics (where PMUs generally aren't specified) and in hybrid metrics
(where PMUs generally are specified)? Events may not be recognized as
aliases because ones without a PMU in the metric will get a legacy
encoding. In your change:
https://lore.kernel.org/r/20221018020227.85905-16-namhyung@kernel.org
you assume all events with the same name are in fact the same event,
but that is making wild assumptions about what is placed in the evsel
name and I am trying to fix it in:
https://lore.kernel.org/lkml/20250201074320.746259-1-irogers@google.com/
You did similar with your proposal for hwmon events and I rejected it.
The fact that the name term in an event configuration clobbers an
evsel's name, its just the intent of the thing and the name was never
supposed to have some sacred legacy or whatever meaning.

I still see no sense in:
perf stat -e cpu_cycles ...
meaning:
perf stat -e */cpu_cycles/ ...
and:
perf stat -e cpu-cycles ...
trying to mean close to:
perf stat -e cpu/cpu-cycles/ ...
why one is implicitly a * and the other a core PMU, I mean it is the
definition of confusing. And in the latter cpu-cycles case you want
those two events to be encoded differently.

All of this is overlooking that we have 1 event that is a problem on 1
PMU on 1 architecture. If it weren't for that event we'd already have
this patch landed and consistent event encodings. By not taking the
patch it hurts Apple M, RISC-V users and my own work.

Please can you explain why keeping the current encoding is good and if
we like legacy events so much, can we revert the changes to prioritize
sysfs/json when a PMU name is present. I'm afraid what you are
explaining makes no sense to me, breaks existing platforms (Apple M)
and is a blockage to future work. Saying everyone should rewrite
everything, that's not a workable solution - not least because in some
situations (old PMU drivers on Apple M) we lack a time machine.

Thanks,
Ian

