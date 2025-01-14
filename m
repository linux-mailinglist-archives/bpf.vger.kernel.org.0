Return-Path: <bpf+bounces-48842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF9A1112E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B25D1605DD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4990F2063C3;
	Tue, 14 Jan 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1OZqUwt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8491D5143;
	Tue, 14 Jan 2025 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882961; cv=none; b=k82yypDWqlgyoMUZYeW/Jiub6VbRVGJBkgSL7WKzViPf5g7xwhIXgrTSRWSsqFFGFWRTpqrdjyaGgR9dOOe2AaYlKCPcp9RyD+2331Pvd1VpvkcuYmL2Gr5ySKrxXOnWttAprGpqW3rs9oF8LqVHo79LbHTpd3OdRniXHA+3/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882961; c=relaxed/simple;
	bh=Y1rD7ysLA8nt9WcqL1WGfLyNFUqZH0Q1EzD/3syv2m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtYbmdCosFwQFtwXrNqZXHI+BGzZi/i6RDtLpdyH+DlOEJyGEZwuia6jbFAuM/WBy1vRfdzR4ucp0ZTNiMFhac1Yo1z5S2TvsHYPdGYMX/T9cLAgKfTYIm68M9zhg561+Eyv7BGSuJjPLxDg7jLwWMou2w48W2F/Njn/WoGV42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1OZqUwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59644C4CEDD;
	Tue, 14 Jan 2025 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736882961;
	bh=Y1rD7ysLA8nt9WcqL1WGfLyNFUqZH0Q1EzD/3syv2m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1OZqUwtq98ldpwv2P3EcvYZ4/E7vUT/O31/nfukOmu6sXSmpN3GcMqfF6u7+Q9KB
	 ZOJt9kiP9Kf4diBuCt8Lj5u6h0RSaghbNS/QHmVQjoDpAw83ZqgCO4XhO0aFfuZWjy
	 rRPl0M2bDlWRgP07wmSoNa5YPNaZdkr+f5yaHS/sxtn+C0wtYXGs9Dd8cm/u6+zfOm
	 2aATjkRrmib3ErXMUCd8kBMbol6vIFaNRAxo6lKBfnocOL0epZ41Dk3rKHdg9AmFLP
	 +4CqmWn2/itjDhQFR+yd+wQyzXPFLygCkxeFPN0nfK4AIBYsqtzMAJoIkaB6zg/rj1
	 96WjAR4J2JiDQ==
Date: Tue, 14 Jan 2025 11:29:18 -0800
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
Message-ID: <Z4a7DncIlP6pznW7@google.com>
References: <20250109222109.567031-1-irogers@google.com>
 <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com>
 <CAP-5=fUSfbZGNaUttM3UCzcrMzkkFAJVA8mheMKQ0nxNH_KuTg@mail.gmail.com>
 <Z4FtHGBbCEeLQhAm@google.com>
 <CAP-5=fVr43v8gkqi8SXVaNKnkO+cooQVqx3xUFJ-BtgxGHX90g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVr43v8gkqi8SXVaNKnkO+cooQVqx3xUFJ-BtgxGHX90g@mail.gmail.com>

On Fri, Jan 10, 2025 at 11:18:53AM -0800, Ian Rogers wrote:
> On Fri, Jan 10, 2025 at 10:55 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Jan 09, 2025 at 08:44:38PM -0800, Ian Rogers wrote:
> > > On Thu, Jan 9, 2025 at 5:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > > > Whilst for many tools it is an expected behavior that failure to open
> > > > > a perf event is a failure, ARM decided to name PMU events the same as
> > > > > legacy events and then failed to rename such events on a server uncore
> > > > > SLC PMU. As perf's default behavior when no PMU is specified is to
> > > > > open the event on all PMUs that advertise/"have" the event, this
> > > > > yielded failures when trying to make the priority of legacy and
> > > > > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > > > > legacy event user on ARM hardware may find their event opened on an
> > > > > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > > > > such events which this patch implements. Rather than have the skipping
> > > > > conditional on running on ARM, the skipping is done on all
> > > > > architectures as such a fundamental behavioral difference could lead
> > > > > to problems with tools built/depending on perf.
> > > > >
> > > > > An example of perf record failing to open events on x86 is:
> > > > > ```
> > > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > > > Error:
> > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > > "dmesg | grep -i perf" may provide additional information.
> > > > >
> > > > > Error:
> > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > > > "dmesg | grep -i perf" may provide additional information.
> > > > >
> > > > > Error:
> > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > > > The LLC-prefetch-read event is not supported.
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> > > >
> > > > I'm afraid this can be too noisy.
> > >
> > > The intention is to be noisy:
> > > 1) it matches the existing behavior, anything else is potentially a regression;
> >
> > Well.. I think you're changing the behavior. :)  Also currently it just
> > fails on the first event so it won't be too much noisy.
> >
> >   $ perf record -e data_read,data_write,LLC-prefetch-read -a sleep 0.1
> >   event syntax error: 'data_read,data_write,LLC-prefetch-read'
> >                        \___ Bad event name
> >
> >   Unable to find event on a PMU of 'data_read'
> >   Run 'perf list' for a list of valid events
> >
> >    Usage: perf record [<options>] [<command>]
> >       or: perf record [<options>] -- <command> [<options>]
> >
> >       -e, --event <event>   event selector. use 'perf list' to list available events
> 
> Fwiw, this error is an event parsing error not an event opening error.
> You need to select an uncore event, I was using data_read which exists
> in the uncore_imc_free_running PMUs on Intel tigerlake. Here is the
> existing error message:
> ```
> $ perf record -e data_read -a true
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> ```
> and here it with the series:
> ```
> $ perf record -e data_read -a true
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0'
> which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1'
> which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> Error:
> Failure to open any events for recording.
> ```
> and here is what it would be with pr_debug:
> ```
> $ perf record -e data_read -a true
> Error:
> Failure to open any events for recording.
> ```
> I believe this last output is worst because:
> 1) If not all events fail to open there is no error reported unless I
> know to run with -v, which will also bring a bunch more noise with it,

I suggested to add a warning if any (not all) of events failed to open.

  "Removed some unsupported events, use -v for details."


> 2) I don't see the PMU / event name and "Invalid argument" indicating
> what has gone wrong again unless I know to run with -v and get all the
> verbose noise with that.

I don't think single -v adds a lot of noise in the output.

> 
> Yes it is noisy on 1 platform for 1 event due to an ARM PMU event name
> bug that ARM should have long ago fixed. That should be fixed rather
> than hiding errors and making users think they are recording samples
> when silently they're not - or they need to search through verbose
> output to try to find out if something broke.

I'm not sure if it's a bug in the driver.  It happens because perf tool
changed the way it finds events - it used to look at the core PMUs only
if no PMU name was given, but now it searches every PMU, right?

> 
> > > 2) it only happens if trying to record on a PMU/event that doesn't
> > > support recording, something that is currently an error and so we're
> > > not motivated to change the behavior as no-one should be using it;
> >
> > It was caught by Linus, so we know at least one (very important) user.
> 
> If they care enough then specifying the PMU with the event will avoid
> any warning and has always been a fix for this issue. It was the first
> proposed workaround for Linus.

I guess that's what Linus said regression.

> 
> > > 3) for the wildcard case the only offender is ARM's SLC PMU and the
> > > appropriate fix there has always been to make the CPU cycle's event
> > > name match the bus_cycles event name by calling it cpu_cycles -
> > > something that doesn't conflict with a core PMU event name, the thing
> > > that has introduced all these problems, patches, long email exchanges,
> > > unfixed inconsistencies, etc.. If the errors aren't noisy then there
> > > is little motivation for the ARM SLC PMU's event name to be fixed.
> >
> > I understand your concern but I'm not sure it's the best way to fix the
> > issue.
> 
> Right, I'm similarly concerned about hiding legitimate warning/error
> messages because of 1 event on 1 PMU on 1 architecture because of how
> perf gets driven by 1 user. Yes, when you break you can wade through
> the verbose output but imo the verbose output was never intended to be
> used in that way.

Well, the verbose output is to debug when something doesn't go well, no?

Thanks,
Namhyung



