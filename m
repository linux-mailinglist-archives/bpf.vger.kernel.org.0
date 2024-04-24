Return-Path: <bpf+bounces-27730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B88B1513
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C76E1C23AC9
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347B15699B;
	Wed, 24 Apr 2024 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX2CG3+M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229A156976;
	Wed, 24 Apr 2024 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993065; cv=none; b=C1Vng6WLRaH02dHhiJ24dTyISstrgiddEkUv9/z1w9z6vJTFZWqHGurXEg9zTgpEbPq+drXWh9E412yjVx4A8lJBpa92MlW8asZ9g3cqx5eUVVWIqnLmtJI/rH1xOiAdGCt3c9O+9XLp4GrWT0/NiaANa8hIsXqOnME0O989ikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993065; c=relaxed/simple;
	bh=ldOqrw1Va6ZZc6+oC/tGUjywY9xlTQi7kLbwUwTWTIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp3qOH/UjtCc/Hw0dHF/GC0m4P4vUPphtC1nesZQdRi4b4+2Ug6KfjDeRFgBaijPOtJrprn1x6Y6LW0G+ZnpvL3ifCxdq+bXaN+Y0sAK/rsDi7TQFwn+xUBaEduFAYIHXPuYW70tA1MDk2WFl5edLvUnohyWaXQVblNtvHnIF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX2CG3+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94628C113CD;
	Wed, 24 Apr 2024 21:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713993065;
	bh=ldOqrw1Va6ZZc6+oC/tGUjywY9xlTQi7kLbwUwTWTIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MX2CG3+M9P46wClZ/HGk/NKz5AyOqXA3CcMaw1TH/5brWuCfOE/d9rixsae7LL1Bf
	 8oftCnCahKocCRV1CksaTZ3m0ePphDD6N6V9bhCwgd3J4jC+HY/Ylzhp0GbNEIbXOV
	 KpCJalbzPZsAbB4wVH6nKUKRgs1RuihqrwO0PZmgXkUmfXqFbCpfEATqMowRWLiWm6
	 xaW0panam9mqQyu3TYcFbwSJ95g8tfwOwBmU3p1ZzB/uQV0C03H3b7/oKKgwHYnr4S
	 FwI/6TGphwm+lSR708KqnwOWxfvj/3IgrVWvCtkP8/eLWkXbXEDloEb9ylz/ZRSbK+
	 ftwwPBGs0IWDw==
Date: Wed, 24 Apr 2024 18:11:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, zegao2021@gmail.com, leo.yan@linux.dev,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Dump off-cpu samples directly
Message-ID: <Zil1ZKc7mibs6ONQ@x1>
References: <20240424024805.144759-1-howardchu95@gmail.com>
 <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com>

On Wed, Apr 24, 2024 at 12:12:26PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Apr 23, 2024 at 7:46 PM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323
> >
> > Currently, off-cpu samples are dumped when perf record is exiting. This
> > results in off-cpu samples being after the regular samples. Also, samples
> > are stored in large BPF maps which contain all the stack traces and
> > accumulated off-cpu time, but they are eventually going to fill up after
> > running for an extensive period. This patch fixes those problems by dumping
> > samples directly into perf ring buffer, and dispatching those samples to the
> > correct format.
> 
> Thanks for working on this.
> 
> But the problem of dumping all sched-switch events is that it can be
> too frequent on loaded machines.  Copying many events to the buffer
> can result in losing other records.  As perf report doesn't care about
> timing much, I decided to aggregate the result in a BPF map and dump
> them at the end of the profiling session.

Should we try to adapt when there are too many context switches, i.e.
the BPF program can notice that the interval from the last context
switch is too small and then avoid adding samples, while if the interval
is a long one then indeed this is a problem where the workload is
waiting for a long time for something and we want to know what is that,
and in that case capturing callchains is both desirable and not costly,
no?

The tool could then at the end produce one of two outputs: the most
common reasons for being off cpu, or some sort of counter stating that
there are way too many context switches?

And perhaps we should think about what is best to have as a default, not
to present just plain old cycles, but point out that the workload is
most of the time waiting for IO, etc, i.e. the default should give
interesting clues instead of expecting that the tool user knows all the
possible knobs and try them in all sorts of combinations to then reach
some conclusion.

The default should use stuff that isn't that costly, thus not getting in
the way of what is being observed, but at the same time look for common
patterns, etc.

- Arnaldo
 
> Maybe that's not a concern for you (or smaller systems).  Then I think
> we can keep the original behavior and add a new option (I'm not good
> at naming things, but maybe --off-cpu-sample?) to work differently
> instead of removing the old behavior.
> 
> Thanks,
> Namhyung
> 
> >
> > Before, off-cpu samples are after regular samples
> >
> > ```
> >          swapper       0 [000] 963432.136150:    2812933    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> >          swapper       0 [000] 963432.637911:    4932876    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> >          swapper       0 [001] 963432.798072:    6273398    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> >          swapper       0 [000] 963433.541152:    5279005    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> > sh 1410180 [000] 18446744069.414584:    2528851 offcpu-time:
> >             7837148e6e87 wait4+0x17 (/usr/lib/libc.so.6)
> >
> >
> > sh 1410185 [000] 18446744069.414584:    2314223 offcpu-time:
> >             7837148e6e87 wait4+0x17 (/usr/lib/libc.so.6)
> >
> >
> > awk 1409644 [000] 18446744069.414584:     191785 offcpu-time:
> >             702609d03681 read+0x11 (/usr/lib/libc.so.6)
> >                   4a02a4 [unknown] ([unknown])
> > ```
> >
> >
> > After, regular samples(cycles:P) and off-cpu(offcpu-time) samples are
> > collected simultaneously:
> >
> > ```
> > upowerd     741 [000] 963757.428701:     297848 offcpu-time:
> >             72b2da11e6bc read+0x4c (/usr/lib/libc.so.6)
> >
> >
> >       irq/9-acpi      56 [000] 963757.429116:    8760875    cycles:P:  ffffffffb779849f acpi_os_read_port+0x2f ([kernel.kallsyms])
> > upowerd     741 [000] 963757.429172:     459522 offcpu-time:
> >             72b2da11e6bc read+0x4c (/usr/lib/libc.so.6)
> >
> >
> >          swapper       0 [002] 963757.434529:    5759904    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> > perf 1419260 [000] 963757.434550: 1001012116 offcpu-time:
> >             7274e5d190bf __poll+0x4f (/usr/lib/libc.so.6)
> >             591acfc5daf0 perf_evlist__poll+0x24 (/root/hw/perf-tools-next/tools/perf/perf)
> >             591acfb1ca50 perf_evlist__poll_thread+0x160 (/root/hw/perf-tools-next/tools/perf/perf)
> >             7274e5ca955a [unknown] (/usr/lib/libc.so.6)
> > ```
> >
> > Here's a simple flowchart:
> >
> > [parse_event (sample type: PERF_SAMPLE_RAW)] --> [config (bind fds,
> > sample_id, sample_type)] --> [off_cpu_strip (sample type: PERF_SAMPLE_RAW)] -->
> > [record_done(hooks off_cpu_finish)] --> [prepare_parse(sample type: OFFCPU_SAMPLE_TYPES)]
> >
> > Changes in v2:
> >  - Remove unnecessary comments.
> >  - Rename function off_cpu_change_type to off_cpu_prepare_parse
> >
> > Howard Chu (4):
> >   perf record off-cpu: Parse off-cpu event, change config location
> >   perf record off-cpu: BPF perf_event_output on sched_switch
> >   perf record off-cpu: extract off-cpu sample data from raw_data
> >   perf record off-cpu: delete bound-to-fail test
> >
> >  tools/perf/builtin-record.c             |  98 +++++++++-
> >  tools/perf/tests/shell/record_offcpu.sh |  29 ---
> >  tools/perf/util/bpf_off_cpu.c           | 242 +++++++++++-------------
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 163 +++++++++++++---
> >  tools/perf/util/evsel.c                 |   8 -
> >  tools/perf/util/off_cpu.h               |  14 +-
> >  tools/perf/util/perf-hooks-list.h       |   1 +
> >  7 files changed, 344 insertions(+), 211 deletions(-)
> >
> > --
> > 2.44.0
> >

