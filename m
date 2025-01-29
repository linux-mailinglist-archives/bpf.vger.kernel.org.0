Return-Path: <bpf+bounces-50070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F349A2260E
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 23:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795361632E3
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532FB1E2613;
	Wed, 29 Jan 2025 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3SjYOI6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4182195985;
	Wed, 29 Jan 2025 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738188320; cv=none; b=ResFmH8kpYzJr151YludDO8U6hfsfQ3TvldwRfe3ApwMxadZi26KjZy29h5hZMj++9F4t3Euhl06YcANl9oFj7CrrRY4e8dLusFiUY4/uRO7r16CnY1ark/pnTKCqGMb/VbQ2Q8ivZEjZiv58c+n+jdOBvOrDSvGTUmzxEd28XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738188320; c=relaxed/simple;
	bh=ZoHRd/c9DGhcJ71YthU/emJ11QVF7kVh/YZEWzTLGUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrjlHZRbDIEP1UcJRRAhjiDOwQKejwVhLlFiWNet731fzbFkgdV/aMco1Mf/kUKCpY+gNHV9g5yy08VlUcpdV0X7xczdTfu0DYn/PlCFJG86my9Adpl1nBPdIXUTcENIOTnymo9b/XtKiHNbT7iquRmMYFexzz/7Pqm8o2dt7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3SjYOI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F0AC4CED1;
	Wed, 29 Jan 2025 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738188319;
	bh=ZoHRd/c9DGhcJ71YthU/emJ11QVF7kVh/YZEWzTLGUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3SjYOI6UMWfHbx6IToPJDWN10ZAdjISdPT38WiCCG0/gVgqoInuL8JlGHLi7Ut6Y
	 jotXHRHzgP/65xcNTn8RKiOSRxpCpwzWE/H2tyYVvgGXJuS6/dt9S86zYO3RxO+EV2
	 EP88vV446b8JjJb4IuJ6DgSI9EBvK9qI+OrNCGggdp1x5aPidpZFUCp1qOn7qV2N7e
	 yS6HIWsfq45IszpDhLROCdohCJ2E7LSVn4DQ5aq7ZgPc/LYAnRm7fJATF6LXQqq4nD
	 /EmGMQ8a3bDdfAgbH/AOjir3/1YDiB5ngLx2ALOFxjpYFPHMWIcDY95dPi5jD/0q8V
	 M0VGhoeHJkH+Q==
Date: Wed, 29 Jan 2025 14:05:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Subject: Re: [PATCH v5 0/4] Prefer sysfs/JSON events also when no PMU is
 provided
Message-ID: <Z5qmHaHRtWKnG4vT@google.com>
References: <20250109222109.567031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109222109.567031-1-irogers@google.com>

On Thu, Jan 09, 2025 at 02:21:05PM -0800, Ian Rogers wrote:
> At the RISC-V summit the topic of avoiding event data being in the
> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> events being the priority when no PMU is provided so that legacy
> events maybe supported via json. Originally Mark Rutland also
> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> M? processors, but James Clark more recently tested this and believes
> the driver issues there may not have existed or have been resolved. In
> any case, it is inconsistent that with a PMU event names avoid legacy
> encodings, but when wildcarding PMUs (ie without a PMU with the event
> name) the legacy encodings have priority.
> 
> The patch doing this work was reverted in a v6.10 release candidate
> as, even though the patch was posted for weeks and had been on
> linux-next for weeks without issue, Linus was in the habit of using
> explicit legacy events with unsupported precision options on his
> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> where ARM decided to call the events bus_cycles and cycles, the latter
> being also a legacy event name. ARM haven't renamed the cycles event
> to a more consistent cpu_cycles and avoided the problem. With these
> changes the problematic event will now be skipped, a large warning
> produced, and perf record will continue for the other PMU events. This
> solution was proposed by Arnaldo.
> 
> Two minor changes have been added to help with the error message and
> to work around issues occurring with "perf stat metrics (shadow stat)
> test".
> 
> The patches have only been tested on my x86 non-hybrid laptop.
> 
> v5: Follow Namhyung's suggestion and ignore the case where command
>     line dummy events fail to open alongside other events that all
>     fail to open. Note, the Tested-by tags are left on the series as
>     v4 and v5 were changing an error case that doesn't occur in
>     testing but was manually tested by myself.
> 
> v4: Rework the no events opening change from v3 to make it handle
>     multiple dummy events. Sadly an evlist isn't empty if it just
>     contains dummy events as the dummy event may be used with "perf
>     record -e dummy .." as a way to determine whether permission
>     issues exist. Other software events like cpu-clock would suffice
>     for this, but the using dummy genie has left the bottle.
> 
>     Another problem is that we appear to have an excessive number of
>     dummy events added, for example, we can likely avoid a dummy event
>     and add sideband data to the original event. For auxtrace more
>     dummy events may be opened too. Anyway, this has led to the
>     approach taken in patch 3 where the number of dummy parsed events
>     is computed. If the number of removed/failing-to-open non-dummy
>     events matches the number of non-dummy events then we want to
>     fail, but only if there are no parsed dummy events or if there was
>     one then it must have opened. The math here is hard to read, but
>     passes my manual testing.
> 
> v3: Make no events opening for perf record a failure as suggested by
>     James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
>     rebase.
> 
> v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
>     Patra who have tested on RISC-V and ARM CPUs, including the
>     problem case from before.
> 
> Ian Rogers (4):
>   perf evsel: Add pmu_name helper
>   perf stat: Fix find_stat for mixed legacy/non-legacy events

I think the first two are quite independent.  I'll take them first.

Thanks,
Namhyung


>   perf record: Skip don't fail for events that don't open
>   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>     legacy"
> 
>  tools/perf/builtin-record.c    | 47 ++++++++++++++++++---
>  tools/perf/util/evsel.c        | 10 +++++
>  tools/perf/util/evsel.h        |  1 +
>  tools/perf/util/parse-events.c | 26 +++++++++---
>  tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
>  tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
>  tools/perf/util/pmus.c         | 20 +++++++--
>  tools/perf/util/stat-shadow.c  |  3 +-
>  8 files changed, 169 insertions(+), 74 deletions(-)
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

