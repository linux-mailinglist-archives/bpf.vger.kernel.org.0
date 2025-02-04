Return-Path: <bpf+bounces-50335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB1A26861
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62B23A47D2
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41FF5228;
	Tue,  4 Feb 2025 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQvJXSQK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE710E4;
	Tue,  4 Feb 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628127; cv=none; b=Ne05WCNNxJlT8B8O9mIqQQaigNwlo2mTL6mOmUwRPzgI5blhQVk8IF3k31Zde2ZKo9GO8qzQ3cRxRxEUry/YOuHzILTP18sqTJMUWtLTj7e9QCv2GTYARRfZqqvxu2E4fh3YMxXFAabtcTh2bmsjKeDZlMAvDSHetY5vw2W87+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628127; c=relaxed/simple;
	bh=HSBBPHSRySft93VMDFAlm5Nh2uxXqHIGgDGqpVBNikI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEMf8BJ9FUFSF7c/ooCsOEfLIzUkdis3z8ODZgvFHxqb8DELuILOzElzjHAD5Mek1S+viCoTlXgMTRsae19HgkPIgm2mnub3JfmujivTIk9Xt3UdWp2QWwnwRyDlNNTtBeABH7JpP/x4epiY1kvxPs7h8sEWWZ3zW/OO4O9T39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQvJXSQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD784C4CEE0;
	Tue,  4 Feb 2025 00:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738628126;
	bh=HSBBPHSRySft93VMDFAlm5Nh2uxXqHIGgDGqpVBNikI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQvJXSQKkHtaOqErh8m/Mk12HBTBJQL3vFiuySM54vIoeUdg+OURN9nGIGFtsyk8v
	 4FOmAxm3fwtVecQcgF/AvuiBXDIbTlCQ1rd8miY5/ma9hEy7sHT2KdJemj+DM5YtwS
	 M1SB+B/hDLu92YY/XxZAsB45rHhiEapv6j/3Qy5Bu+l/mVzU6B3BmpNEKm9l7CRluI
	 QykUEgzjTWOrjKd0H3WzEWv4c6EsKCJsEQe/VLvctriRckXbMK3IjIHQAb0mA/uTJP
	 SWQVxr2QOXj+JeKE91xqup/jzRdbHwtCBO2SWaY1j92HPbk11oh8oEdi6q3JSBDKlt
	 9IcRON4SP2CQw==
Date: Mon, 3 Feb 2025 16:15:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Atish Kumar Patra <atishp@rivosinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>,
	Beeman Strong <beeman@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
Message-ID: <Z6FcHJFYGc7HzSna@google.com>
References: <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com>
 <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com>
 <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com>
 <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com>
 <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>

On Sat, Feb 01, 2025 at 12:45:04AM -0800, Ian Rogers wrote:
> On Fri, Jan 31, 2025 at 2:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Jan 29, 2025 at 10:12:14PM -0800, Atish Kumar Patra wrote:
> > > On Wed, Jan 29, 2025 at 1:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 15, 2025 at 01:20:32PM -0800, Ian Rogers wrote:
> > > > > On Wed, Jan 15, 2025 at 9:59 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > > On Mon, Jan 13, 2025 at 2:51 PM Ian Rogers <irogers@google.com> wrote:
> > > > > > > > There was an explicit, and reviewed by Jiri and Arnaldo, intent with
> > > > > > > > the hybrid work that using a legacy event with a hybrid PMU, even
> > > > > > > > though the PMU doesn't advertise through json or sysfs the legacy
> > > > > > > > event, the perf tool supports it.
> > > > > >
> > > > > > I thought legacy events on hybrid were converted to PMU events.
> > > > >
> > > > > No, when BIG.little was created nothing changed in perf events but
> > > > > when Intel did hybrid they wanted to make the hybrid CPUs (atom and
> > > > > performance) appear as if they were one type. The PMU event encodings
> > > > > vary a lot for this on Intel, ARM has standards for the encoding.
> > > > > Intel extended the legacy format to take a PMU type id:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/include/uapi/linux/perf_event.h?h=perf-tools-next#n41
> > > > > "EEEEEEEE: PMU type ID"
> > > > > that is in the top 32-bits of the config.
> > > >
> > > > Oh right, I forgot the extended type thing.  Then we can keep the legacy
> > > > encoding with it on hybrid systems when users give well-known names (w/o
> > > > PMU) for legacy event.
> > > >
> > > > >
> > > > > > > >
> > > > > > > > Making it so that events without PMUs are only legacy events just
> > > > > > > > doesn't work. There are far too many existing uses of non-legacy
> > > > > > > > events without PMU, the metrics contain 100s of examples.
> > > > > >
> > > > > > That's unfortunate.  It'd be nice if metrics were written with PMU
> > > > > > names.
> > > > >
> > > > > But then we'd end up with things like on Intel:
> > > > > UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD
> > > > > becoming:
> > > > > uncore_cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
> > > > > or just:
> > > > > cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
> > > > > As a user the first works for me and doesn't have any ambiguity over
> > > > > PMUs as the event name already encodes the PMU. AMD similarly place
> > > > > the part of a pipeline into event names. Were we to break everybody by
> > > > > requiring the PMU we'd also need to explain which PMU to use. Sites
> > > > > with event lists (like https://perfmon-events.intel.com/) don't
> > > > > explain the PMU and it'd be messy as on Intel you have a CHA PMU for
> > > > > server chips but a CBOX on client chips, etc.
> > > >
> > > > While I prefer having PMU names in the JSON events/metrics, it may not
> > > > be pratical to change them all.  Probably we can allow them without PMU
> > > > and hope that they have unique prefixes.
> > > >
> > > > >
> > > > > > I have a question.  What if an event name in a metric matches to
> > > > > > multiple unrelated PMUs?
> > > > >
> > > > > The metric may break or we'd aggregate the unrelated counts together.
> > > >
> > > > Ok, then they should use unique names.
> > > >
> > > >
> > > > > Take a metric like IPC as "instructions/cycles", that metric should
> > > > > work on a hybrid system as they have instructions and cycles. If you
> > > > > used an event for instructions like inst_retired.any then maybe the
> > > > > metric will fail on one kind of core that didn't have that event. Now
> > > >
> > > > The metrics is for specific CPU model then the vendor should be
> > > > responsible to provide accurate metrics using approapriate PMU/events
> > > > IMHO.
> > > >
> > > >
> > > > > if we have accelerators advertising instructions and cycles events, we
> > > > > should be able to compute the metric for the accelerator. What could
> > > > > happen today is that the accelerator will have a cpumask of a single
> > > > > CPU, we could aggregate the accelerator counter into the CPU event
> > > > > with the same CPU as the cpumask, we'd end up with a weird quasi CPU
> > > > > and accelerator IPC metric for that CPU. What should happen is that we
> > > > > get an IPC for the accelerator and IPC for each hybrid core
> > > > > independently, but the way we handle evsels, CPUs, PMUs is not really
> > > > > set up for that. Hopefully getting a set of PMUs into the evsel will
> > > > > clear that up. Assuming all of that is cleared up, is it wrong if the
> > > > > IPC metric is computed for the accelerator if it was originally
> > > > > written as a CPU metric? Not really. Could there be metrics where that
> > > > > is the case?
> > > >
> > > > Yes, I think there should be separate metrics for the accelerators.
> > > >
> > > >
> > > > > Probably, and specifying PMUs in the event names would be
> > > > > a fix. There have also been proposals that we restrict the PMUs for
> > > > > certain metrics. As event names are currently so distinct it isn't a
> > > > > problem we've faced yet and it is not clear it is a problem other than
> > > > > highlighting tech debt in areas of the tool like aggregation.
> > > > >
> > > > > > > >
> > > > > > > > Prior to switching json/sysfs to being the priority when a PMU is
> > > > > > > > specified, it was the case that all encodings were the same, with or
> > > > > > > > without a PMU.
> > > > > > > >
> > > > > > > > I don't think there is anything natural about assuming things about
> > > > > > > > event names. Take cycles, cpu-cycles and cpu_cycles:
> > > > > > > >  - cycles on x86 is only encoded via a legacy event;
> > > > > > > >  - cpu-cycles on Intel exists as a sysfs event, but cpu-cycles is also
> > > > > > > > a legacy event name;
> > > > > > > >  - cpu_cycles exists as a sysfs event on ARM but doesn't have a
> > > > > > > > corresponding legacy event name.
> > > > > >
> > > > > > I think the behavior should be:
> > > > > >
> > > > > >   cycles -> PERF_COUNT_HW_CPU_CYCLES
> > > > > >   cpu-cycles -> PERF_COUNT_HW_CPU_CYCLES
> > > > > >   cpu_cycles -> no legacy -> sysfs or json
> > > > > >   cpu/cycles/ -> sysfs or json
> > > > > >   cpu/cpu-cycles/ -> sysfs or json
> > > > >
> > > > > So I disagree as if you add a PMU to an event name the encoding
> > > > > shouldn't change:
> > > > > 1) This historically was perf's behavior.
> > > >
> > > > Well.. I'm not sure about the history.  I believe the logic I said above
> > > > is the historic and (I think) right behavior.
> > > >
> > > > > 2) Different event encodings can have different behaviors (broken in
> > > > > some notable cases).
> > > >
> > > > Yep, let's make it clear.
> > > >
> > > > > 3) Intuitively what wildcarding does is try to open "*/event/" where *
> > > > > is every possible PMU name. Having different event encodings is
> > > > > breaking that intuition it could also break situations where you try
> > > > > to assert equivalence based on type/config.
> > > >
> > > > While I don't like the wildcard matching, I think it doesn't matter as
> > > > long as we keep the above behavior.  If it can find a legacy name, then
> > > > go with it, done.  If not, try all PMUs as if it's given with PMU name
> > > > in the event.
> > > >
> > > > > 4) The legacy encodings were (are?) broken on ARM Apple M? CPUs,
> > > > > that's why the priority was changed.
> > > >
> > > > I guess that why they use cpu_cycles.
> > > >
> > > > > 5) RISC-V would like the tool tackle the legacy to config mapping
> > > > > challenge, rather than the PMU driver, given the potential diversity
> > > > > of hardware implementations.
> > > >
> > > > I hope they can find a better solution. :)
> > > >
> > >
> > > Sorry for reposing. Gmail converted it to html for some reason.
> > >
> > > I have posted the latest support here.
> > > https://lore.kernel.org/kvm/20250127-counter_delegation-v3-12-64894d7e16d5@rivosinc.com/T/
> > >
> > > As of now, we have adopted a hybrid approach where a vendor can decide
> > > whether to encode the legacy events
> > > in the json or in the driver (if this series is merged). In absence of
> > > that, every vendor has to define it in the driver.
> > > We will deal with the fall out of the exploding driver when the
> > > situation arrives.
> >
> > I don't know how hard it'd be cause I'm not familiar with RISC-V.  But
> > basically you only need to maintain 9 legacy encodings (PERF_COUNT_HW_*)
> > and a few dozen combinations of supported cache events (PERF_COUNT_HW_
> > CACHE_*) for each vendor.  All others can go to json anyway.
> >
> > I think this is what all other archs (including x86) do.
> 
> This is well known to the people involved.
> 
> While the PMU driver needs to encode or avoid these event names, they
> become special "legacy" names inside the perf tool. Magically a name
> like cpu_cycles will wildcard match (match on >1 PMU) whilst a name
> like cpu-cycles won't (only matching on core PMUs). This is completely
> confusing to users. It is even more confusing when you are saying the
> tool should intentionally use two different encodings.

The legacy encoding is a part of the ABI, and it's natural to use it.
We historically used 'cycles' and 'cpu-cycles' as legacy events and it
should remain as is IMHO.  I'm not sure why ARM uses 'cpu_cycles', but
I guess they don't want to use the legacy encoding for some reason.

> 
> The perf event enum types are limited but the tool recognizes more
> event names and then uses legacy encodings. I have yet to hear a
> sensible list of what are legacy event names, is cpu-cycles in there
> or just cycles? Why on earth would you want to keep synonyms like LLC
> meaning L2 cache?

I think it's clear what are legacy events: `perf list hw`.

In fact, it doesn't matter for tools what LLC means.  I think it's the
drivers' respensibility to match sensible events to legacy encoding.
We only need to use the event as they prepared.

> 
> The intention with "pmu syntax" for events is that the PMU clarifies
> the type in the perf_event_attr. Previously it was assumed that the
> PMU type would be raw (4), and the x86 PMUs even use that as their
> type number. Pretending these days we don't now have hybrid core PMUs,
> 10s of uncore PMUs. Doing that work had to reinvent event parsing and
> encoding.
> 
> If you look at the matching as it is today:
> cpu_cycles -> tries to match on all PMUs
> */cpu_cycles/ -> tries to match on all PMUs
> arm*/cpu_cycles/ -> tries matches on all PMUs that have arm at the start
> armv8_pmuv3/cpu_cycles/ -> matches only the armv8_pmuv3 PMU

I didn't realize we can use '*'.  Then I guess we can disable the
default wildcard match.  Users can add '*/.../' easily if they really
want it, right?  I still think all of this problem comes from the
wildcard behavior.

Probably we need to do these for events without PMU name:
1. use legacy event if it's the well-known name, if not
2. check core PMU (cpu) for sysfs events, if not
3. search all JSON events (not to break metrics)

> 
> I don't see why it isn't obvious that the behavior of no PMU and the
> PMU being * is expected to be exactly the same - it really is today
> and that is what the code does, please try it. There just isn't a
> notion of not having a PMU because even for legacy events we have to
> reinvent the PMUs to inject the correct extended type information
> otherwise we'd profile just a fraction of the cores. We add PMUs when
> we display events to make the events more readable. There isn't a
> notion of these events being legacy and not, they are just assumed to
> be the same, PMU or not.

Yes, it's confusing.  So I think we'd better make cycles != */cycles/.

> 
> As I've explained to you, I plan to transition the metric code to use
> event parsing and to union evlists rather than use strings and hash
> tables. This is to fix tracepoints appearing incorrectly to always
> have suffixes in the "metric-id" calculation. Recognizing modifiers
> properly would end up reinventing event parsing, so let's just make
> use of what we have and parse events early. It makes sense when
> unioning evsels in an evlist to do it off of the perf_event_attr, this
> will allow Intel's slots and topdown.slots to be correctly detected as
> aliases in metrics, something of a pain in formulas today. Why would
> the behavior of an event like cycles be different in non-hybrid
> metrics (where PMUs generally aren't specified) and in hybrid metrics
> (where PMUs generally are specified)? Events may not be recognized as
> aliases because ones without a PMU in the metric will get a legacy
> encoding. In your change:
> https://lore.kernel.org/r/20221018020227.85905-16-namhyung@kernel.org
> you assume all events with the same name are in fact the same event,
> but that is making wild assumptions about what is placed in the evsel
> name and I am trying to fix it in:
> https://lore.kernel.org/lkml/20250201074320.746259-1-irogers@google.com/
> You did similar with your proposal for hwmon events and I rejected it.
> The fact that the name term in an event configuration clobbers an
> evsel's name, its just the intent of the thing and the name was never
> supposed to have some sacred legacy or whatever meaning.

Thanks for the fix!

> 
> I still see no sense in:
> perf stat -e cpu_cycles ...
> meaning:
> perf stat -e */cpu_cycles/ ...
> and:
> perf stat -e cpu-cycles ...
> trying to mean close to:
> perf stat -e cpu/cpu-cycles/ ...
> why one is implicitly a * and the other a core PMU, I mean it is the
> definition of confusing. And in the latter cpu-cycles case you want
> those two events to be encoded differently.

Yep, I agree it's confusing.  So my opinion is to use legacy encoding
and no default wildcard. :)

> 
> All of this is overlooking that we have 1 event that is a problem on 1
> PMU on 1 architecture. If it weren't for that event we'd already have
> this patch landed and consistent event encodings. By not taking the
> patch it hurts Apple M, RISC-V users and my own work.

Well, I'm not talking about the specific event or an architecture.  What
I'm focusing on is what the sensible behavior is.

> 
> Please can you explain why keeping the current encoding is good and if
> we like legacy events so much, can we revert the changes to prioritize
> sysfs/json when a PMU name is present. I'm afraid what you are
> explaining makes no sense to me, breaks existing platforms (Apple M)
> and is a blockage to future work. Saying everyone should rewrite
> everything, that's not a workable solution - not least because in some
> situations (old PMU drivers on Apple M) we lack a time machine.

It's not clear to me if we have a problem on Apple M as of now.

And I don't have a problem with 'pmu/event/' case.  I hope to find a way
to support what I described without rewriting all metrics.

Thanks,
Namhyung


