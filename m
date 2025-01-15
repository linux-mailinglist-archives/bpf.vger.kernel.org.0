Return-Path: <bpf+bounces-48988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C215BA12E21
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13F918896A0
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF541DC747;
	Wed, 15 Jan 2025 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8bF/pgP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6814B959;
	Wed, 15 Jan 2025 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979290; cv=none; b=jFuwsV4IhP2A1vqGQ+6hqjYO510yF17wBtNPobkJ/9qIMgTRIIlU+8gv0gT9LsrPZvrbcJPOY7eF80r252LE1EnL+lHPB3CXZ94vpdf7FIOyy8NQUlAWFkyvI4i2vVXHAxXiSI3knn9Aey1qI7AfyAaYW+qWiylY4zCDG7Swzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979290; c=relaxed/simple;
	bh=rnfEp8aPrsy1U2N3FvE2RQXmcPtwzwGxPuJGGt5uU0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnAmkdcemGUa/vIt8IJHkpcwkG9lklB4cN9WJ8o0Ycr6FAQh/zjunUQxssqbIYRwnzkjdouwy3oGe9YEHm9NCOqTBX3KYKDxtYYdNXHznHe7+vY0m9bxeeT/pGeoGnZW9BkJieIpppOGTdP3yqF00lkcdjVebi2LBG7EIvttcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8bF/pgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F73CC4CED1;
	Wed, 15 Jan 2025 22:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736979290;
	bh=rnfEp8aPrsy1U2N3FvE2RQXmcPtwzwGxPuJGGt5uU0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8bF/pgPbF+iC/2yY1YSZGqpiaJ1iA7bekq7/IZRveuFaIY7TepsqFNZw1VzhP1hZ
	 HcV9deiQzwNgAqP3C4RO9qiPxmQ3VA/LA+J7WqDcoI7+3IH4SQXfwIibjgQGOo7+4f
	 W7ZWDDIsdYSz4UOa2roWlYkepZsXmoAjyRIFHkrO35zU+nmyXJCPz8ETvFfh9QXoea
	 Ifnn0gs9akd92/LRCzHVGW7AanWwbdGlE5dCxG1XCM6TE5iRwpRZYX+4hZ+2TDzwvx
	 UhjLD0ToOAlE3SxuPhKZHqrhdJIsbIZLFIyx9znM3TkXGpRNIRaqrFSUWGVr68x9Es
	 ZcJKBbMIPG9IQ==
Date: Wed, 15 Jan 2025 14:14:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that
 don't open
Message-ID: <Z4gzWDsxlSxSbBSQ@google.com>
References: <20250109222109.567031-1-irogers@google.com>
 <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com>
 <CAP-5=fUSfbZGNaUttM3UCzcrMzkkFAJVA8mheMKQ0nxNH_KuTg@mail.gmail.com>
 <Z4FtHGBbCEeLQhAm@google.com>
 <CAP-5=fVr43v8gkqi8SXVaNKnkO+cooQVqx3xUFJ-BtgxGHX90g@mail.gmail.com>
 <Z4a7DncIlP6pznW7@google.com>
 <CAP-5=fWZxpooqOhC_QrR2YaZVEj0UpipBCHXHZMbFfv7G15Vnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWZxpooqOhC_QrR2YaZVEj0UpipBCHXHZMbFfv7G15Vnw@mail.gmail.com>

On Tue, Jan 14, 2025 at 03:55:47PM -0800, Ian Rogers wrote:
> On Tue, Jan 14, 2025 at 11:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Jan 10, 2025 at 11:18:53AM -0800, Ian Rogers wrote:
> > > On Fri, Jan 10, 2025 at 10:55 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 08:44:38PM -0800, Ian Rogers wrote:
> > > > > On Thu, Jan 9, 2025 at 5:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > > > > > Whilst for many tools it is an expected behavior that failure to open
> > > > > > > a perf event is a failure, ARM decided to name PMU events the same as
> > > > > > > legacy events and then failed to rename such events on a server uncore
> > > > > > > SLC PMU. As perf's default behavior when no PMU is specified is to
> > > > > > > open the event on all PMUs that advertise/"have" the event, this
> > > > > > > yielded failures when trying to make the priority of legacy and
> > > > > > > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > > > > > > legacy event user on ARM hardware may find their event opened on an
> > > > > > > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > > > > > > such events which this patch implements. Rather than have the skipping
> > > > > > > conditional on running on ARM, the skipping is done on all
> > > > > > > architectures as such a fundamental behavioral difference could lead
> > > > > > > to problems with tools built/depending on perf.
> > > > > > >
> > > > > > > An example of perf record failing to open events on x86 is:
> > > > > > > ```
> > > > > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > > > > > Error:
> > > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> > > > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > > > > "dmesg | grep -i perf" may provide additional information.
> > > > > > >
> > > > > > > Error:
> > > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> > > > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > > > > "dmesg | grep -i perf" may provide additional information.
> > > > > > >
> > > > > > > Error:
> > > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > > > > The LLC-prefetch-read event is not supported.
> > > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> > > > > >
> > > > > > I'm afraid this can be too noisy.
> > > > >
> > > > > The intention is to be noisy:
> > > > > 1) it matches the existing behavior, anything else is potentially a regression;
> > > >
> > > > Well.. I think you're changing the behavior. :)  Also currently it just
> > > > fails on the first event so it won't be too much noisy.
> > > >
> > > >   $ perf record -e data_read,data_write,LLC-prefetch-read -a sleep 0.1
> > > >   event syntax error: 'data_read,data_write,LLC-prefetch-read'
> > > >                        \___ Bad event name
> > > >
> > > >   Unable to find event on a PMU of 'data_read'
> > > >   Run 'perf list' for a list of valid events
> > > >
> > > >    Usage: perf record [<options>] [<command>]
> > > >       or: perf record [<options>] -- <command> [<options>]
> > > >
> > > >       -e, --event <event>   event selector. use 'perf list' to list available events
> > >
> > > Fwiw, this error is an event parsing error not an event opening error.
> > > You need to select an uncore event, I was using data_read which exists
> > > in the uncore_imc_free_running PMUs on Intel tigerlake. Here is the
> > > existing error message:
> > > ```
> > > $ perf record -e data_read -a true
> > > Error:
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> > > for event (data_read).
> > > "dmesg | grep -i perf" may provide additional information.
> > > ```
> > > and here it with the series:
> > > ```
> > > $ perf record -e data_read -a true
> > > Error:
> > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0'
> > > which will be removed.
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> > > for event (data_read).
> > > "dmesg | grep -i perf" may provide additional information.
> > >
> > > Error:
> > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1'
> > > which will be removed.
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> > > for event (data_read).
> > > "dmesg | grep -i perf" may provide additional information.
> > >
> > > Error:
> > > Failure to open any events for recording.
> > > ```
> > > and here is what it would be with pr_debug:
> > > ```
> > > $ perf record -e data_read -a true
> > > Error:
> > > Failure to open any events for recording.
> > > ```
> > > I believe this last output is worst because:
> > > 1) If not all events fail to open there is no error reported unless I
> > > know to run with -v, which will also bring a bunch more noise with it,
> >
> > I suggested to add a warning if any (not all) of events failed to open.
> >
> >   "Removed some unsupported events, use -v for details."
> >
> >
> > > 2) I don't see the PMU / event name and "Invalid argument" indicating
> > > what has gone wrong again unless I know to run with -v and get all the
> > > verbose noise with that.
> >
> > I don't think single -v adds a lot of noise in the output.
> >
> > >
> > > Yes it is noisy on 1 platform for 1 event due to an ARM PMU event name
> > > bug that ARM should have long ago fixed. That should be fixed rather
> > > than hiding errors and making users think they are recording samples
> > > when silently they're not - or they need to search through verbose
> > > output to try to find out if something broke.
> >
> > I'm not sure if it's a bug in the driver.  It happens because perf tool
> > changed the way it finds events - it used to look at the core PMUs only
> > if no PMU name was given, but now it searches every PMU, right?
> 
> So there is the ARM bug in the PMU driver that caused an issue with
> the hybrid fixes done because of wanting to have metrics work for
> hybrid. The bug is reported here:
> https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st/

I'm not sure if it's agreed to be called a PMU bug.
My understanding is it's the change in the perf tool that break it.


> The events are apple_icestorm_pmu/cycles/ and
> apple_firestorm_pmu/cycles/. The issue is that prior to fixing hybrid
> the ARM PMUs looked like uncore PMUs and couldn't open a legacy event,
> which was fine as they has sysfs events. When hybrid was fixed in the
> tool, the tool would then try to open apple_icestorm_pmu/cycles/ and
> apple_firestorm_pmu/cycles/ as legacy events - legacy having priority
> over sysfs/json back then. The legacy mapping was broken in the PMU

I don't know why you want to use legacy events (PERF_TYPE_HARDWARE)
when it has PMU in the event name and the PMU has a different type
enconding.


> driver. Now were everything working as intended, just the cycles event
> would be specified on the command line and the event would be wildcard
> opened on the apple_icestorm_pmu and apple_firestorm_pmu. I believe
> this way would already use a legacy encoding and so to work around the
> PMU driver bug people were specifying the PMU name to get the sysfs
> encoding, but that only worked as the PMUs appeared to be uncore.
> 
> > >
> > > > > 2) it only happens if trying to record on a PMU/event that doesn't
> > > > > support recording, something that is currently an error and so we're
> > > > > not motivated to change the behavior as no-one should be using it;
> > > >
> > > > It was caught by Linus, so we know at least one (very important) user.
> > >
> > > If they care enough then specifying the PMU with the event will avoid
> > > any warning and has always been a fix for this issue. It was the first
> > > proposed workaround for Linus.
> >
> > I guess that's what Linus said regression.
> 
> But a regression where? The tool's behavior is pretty clear, no PMU
> the event will be tried on every PMU, give it a PMU and the event will
> only be tried on that PMU, give it a PMU without a suffix and the
> event will be opened on all PMUs that match the name with different
> suffixes.

It may be clear to you but may not be to others.  When did the change
come in?  Before the change, people assume it would only try core PMU.
And the people can still have the idea if they haven't used any affected
events.  I guess many users would use legacy events only.


> I dislike the idea of  cpu-cycles implicitly being just for
> core PMUs, but cpu_cycles being for all PMUs as the hyphen is a legacy
> name and the underscore not.

That's because we specifically picked some names to be used as a legacy
event.  And it worked well.  If some PMU didn't use the name, it's their
fault and they should use PMU event with their name.


> I dislike the idea of specifying a PMU
> with uncore events as uncore events often already have a PMU within
> their event name and it also breaks the universe. 

Does the 'universe' mean 'metric'?

Having PMU name in the event name is their choice.  Do you see this in
sysfs or JSON?  Or both?

Actually I don't like the idea of trying every PMU if no PMU name is
given.  But you said reverting it would break metrics (I don't know if
there are other users rely on this behavior).  Maybe can we handle
metrics differently?

I guess we can put JSON events and metrics without PMU in a global name
space so that it can be searched (after legacy name) when users don't
specify PMUs in the command line.  Otherwise it should have PMU name
and sysfs event (then JSON events with PMU name) can be searched.

Does that make sense?


> When trying to find
> out what people mean by event names being implicitly associated with
> PMUs I get told I'm throwing out "what ifs," when all I'm doing is
> reading the code (that I wrote and I'm trying to fix) and trying to
> figure out what behavior people want. What I don't want is
> inconsistencies, events behaving differently in different scenarios
> and the perf output's use of event names being inconsistent with the
> parsing. RISC-V and ARM have wanted the syfs/json over legacy
> priority, so I'm trying to get that landed.

I'm not sure now RISC-V and ARM want it.  Or it needs to be more
specific what they want exactly.

> 
> Ultimately the original regression comes back to the ARM SLC PMU
> advertising a cycles event when it should have been named cpu_cycles,
> if for no other reason than uniformity with the bus_cycles name on the
> same PMU. The change in perf's wildcard behavior exposed the latent
> bug, that doesn't make the SLC PMU's event name not a bug. The change
> here is to make seeing that bug non-terminal to running the program.

I don't see it's a bug if uncore PMUs have an event named 'cycles' or
whatever.  It's just because perf record wanted to use it and that's
entirely tool's choice.

Thanks,
Namhyung

> 
> > >
> > > > > 3) for the wildcard case the only offender is ARM's SLC PMU and the
> > > > > appropriate fix there has always been to make the CPU cycle's event
> > > > > name match the bus_cycles event name by calling it cpu_cycles -
> > > > > something that doesn't conflict with a core PMU event name, the thing
> > > > > that has introduced all these problems, patches, long email exchanges,
> > > > > unfixed inconsistencies, etc.. If the errors aren't noisy then there
> > > > > is little motivation for the ARM SLC PMU's event name to be fixed.
> > > >
> > > > I understand your concern but I'm not sure it's the best way to fix the
> > > > issue.
> > >
> > > Right, I'm similarly concerned about hiding legitimate warning/error
> > > messages because of 1 event on 1 PMU on 1 architecture because of how
> > > perf gets driven by 1 user. Yes, when you break you can wade through
> > > the verbose output but imo the verbose output was never intended to be
> > > used in that way.
> >
> > Well, the verbose output is to debug when something doesn't go well, no?
> 
> The output isn't currently only enabled in verbose mode, so is this
> wrong? You will only get extra warnings with this change if you do
> anything wrong. For a hybrid system maybe you've gone from 1 warning
> to 2, I fail to see a big deal. Yes if you try to do perf record on an
> uncore server PMU with many instances you will potentially get many
> warnings, but the behavior before and after is to fail and the user is
> likely to figure out what the fix is in both cases, with more errors
> they may appreciate better that the event was getting opened on many
> PMUs. The trend for event parsing errors is to have more error
> messages. We went from 1 to 2 in commit
> a910e4666d61712840c78de33cc7f89de8affa78 and from 2 to many in commit
> fd7b8e8fb20f51d60dfee7792806548f3c6a4c2c. The trend isn't to try to
> move things into verbose only output and for things to silently (or
> with little detail) fail for the user.
> 
> Thanks,
> Ian

