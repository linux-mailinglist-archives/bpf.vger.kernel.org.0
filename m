Return-Path: <bpf+bounces-48715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E2A0C450
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 23:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02E87A11D9
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 22:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF81EE7C1;
	Mon, 13 Jan 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdM4ab+4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FE1BDCF;
	Mon, 13 Jan 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805713; cv=none; b=EqiPFzjPMY0XSKs3qoPQfrjXHDdClB9SG44Rn4v2qx8bLcuokBRNzbxx0i88bIutQswEk+KwxPfRwbPw6A/Gpp3p7TvmeOM9BX5BV3bkfvyrwYvr12vfOcl/FCEsM49inbL3XpI7Af0doz4BULE5PnBkeQCRUNH+xtz/BeENkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805713; c=relaxed/simple;
	bh=+ChA+qskueJu5f9ta3GCXKiySrTK7ztAasN61SrKD6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw03qFM1+fRYhQ5LJf6RpFKB7quGVU4Uu8A83aYs9EUVFL1YW5uRWCsqjYgh7JIGZzJ+mUb3QU7DOh4wk6Wq38YyvfgC4uAS2HZonr2Acm9P4Zbcj+vceFkb0uD+u4M5r6qElxCaRDPleNCuukgLhrdqnHqUR7Poj7TM98CmU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdM4ab+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799B8C4CED6;
	Mon, 13 Jan 2025 22:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736805713;
	bh=+ChA+qskueJu5f9ta3GCXKiySrTK7ztAasN61SrKD6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdM4ab+4gr4XOXih/n8PSmHGlXz02fZujke25fxyQJfSeUltaZEC1G7yuqUbQBybD
	 GnCCkhlgTtnIdpml9K0SrdtEwlCkOc9md+O0kU8LEzbi1uww5e3+jEpzhTvALQLBhP
	 iU1jpf0LkBtM1uZh4z+4aJ7fmOLPX0jzDXWVmHrI4N9syVmgnR42UEpVlFhdSVj73t
	 bZMFj+OoWYXVbLik8WrTKfVZINpcBU7BsY8IkCbF/SOVO7hzuMTtjOe/pt228ry7Kn
	 Nx/YAS63DF8UrdETvA39wJP6jucVMV+hcUSfhLmTWb1tvrLgr6KfIJIJyfmY76fYJJ
	 itme7cy7iGiwQ==
Date: Mon, 13 Jan 2025 14:01:51 -0800
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
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>,
	Atish Patra <atishp@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
	Beeman Strong <beeman@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
Message-ID: <Z4WNT_UX9eMD_txf@google.com>
References: <20250109222109.567031-1-irogers@google.com>
 <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com>
 <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>

On Fri, Jan 10, 2025 at 02:15:18PM -0800, Ian Rogers wrote:
> On Fri, Jan 10, 2025 at 11:40 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Jan 09, 2025 at 02:21:09PM -0800, Ian Rogers wrote:
> > > Originally posted and merged from:
> > > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > > This reverts commit 4f1b067359ac8364cdb7f9fda41085fa85789d0f although
> > > the patch is now smaller due to related fixes being applied in commit
> > > 22a4db3c3603 ("perf evsel: Add alternate_hw_config and use in
> > > evsel__match").
> > > The original commit message was:
> > >
> > > It was requested that RISC-V be able to add events to the perf tool so
> > > the PMU driver didn't need to map legacy events to config encodings:
> > > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
> > >
> > > This change makes the priority of events specified without a PMU the
> > > same as those specified with a PMU, namely sysfs and JSON events are
> > > checked first before using the legacy encoding.
> >
> > I'm still not convinced why we need this change despite of these
> > troubles.  If it's because RISC-V cannot define the lagacy hardware
> > events in the kernel driver, why not using a different name in JSON and
> > ask users to use the name specifically?  Something like:
> >
> >   $ perf record -e riscv-cycles ...
> 
> So ARM and RISC-V are more than able to speak for themselves and have
> their tags on the series, but let's recap why I'm motivated to do this
> change:
> 
> 1) perf supported legacy events;
> 2) perf supported sysfs and json events, but at a lower priority than
> legacy events;
> 3) hybrid support was added but in a way where all the hybrid PMUs
> needed to be known, assumptions about PMU were implicit and baked into
> the tool;
> 4) metric support for hybrid was going in a similar implicit direction
> and I objected, what would cycles mean in a metric if the core PMU was

If the legacy cycles event in a metric is a problem, can we change the
metric to be more specific?


> implicit? Rather than pursue this the hybrid code was overhauled, PMUs
> became more of a thing and we added a notion of a "core" PMU which
> would support legacy events;
> 5) ARM core PMUs differ in naming, etc. than just about every other
> platform. Their core events had been being programmed as if they were
> uncore events - ie without the legacy priority. Fixing hybrid, and
> fixing ARM PMUs to know they supported legacy events, broke perf on
> Apple-M? series due to a PMU driver issue with legacy events:
> https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st/
> "Perf broke on all Apple ARM64 systems (tested almost everything), and
> according to maz also on Juno (so, probably all big.LITTLE) since
> v6.5."
> 6) sysfs/json events were made the priority over legacy to unbreak
> perf on Apple-M? CPUs, but only if the PMU is specified:
> https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
>    Reported-by: Hector Martin <marcan@marcan.st>
>    Signed-off-by: Ian Rogers <irogers@google.com>
>    Tested-by: Hector Martin <marcan@marcan.st>
>    Tested-by: Marc Zyngier <maz@kernel.org>
>    Acked-by: Mark Rutland <mark.rutland@arm.com>

I think ARM/Apple-Mx is fine without this change, right?

> 
> This gets us to the current code where I can trivially get an
> inconsistency. Here on Intel with no PMU in the event name:
> ```
> $ perf stat -vv -e cpu-cycles true
> Using CPUID GenuineIntel-6-8D-1
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 752915  cpu -1  group_fd -1  flags 0x8 = 3
> cpu-cycles: -1: 1293076 273429 273429
> cpu-cycles: 1293076 273429 273429
> 
>  Performance counter stats for 'true':
> 
>          1,293,076      cpu-cycles
> 
>        0.000809752 seconds time elapsed
> 
>        0.000841000 seconds user
>        0.000000000 seconds sys
> ```
> 
> Here with a PMU event name:
> ```
> $ sudo perf stat -vv -e cpu/cpu-cycles/ true
> Using CPUID GenuineIntel-6-8D-1
> Attempt to add: cpu/cpu-cycles=0/
> ..after resolving event: cpu/event=0x3c/
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             136
>   config                           0x3c (cpu-cycles)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 752839  cpu -1  group_fd -1  flags 0x8 = 3
> cpu/cpu-cycles/: -1: 1421235 531150 531150
> cpu/cpu-cycles/: 1421235 531150 531150
> 
>  Performance counter stats for 'true':
> 
>          1,421,235      cpu/cpu-cycles/
> 
>        0.001292908 seconds time elapsed
> 
>        0.001340000 seconds user
>        0.000000000 seconds sys
> ```
> 
> That is the no PMU event is opened as type=0/config=0 (legacy) while
> the PMU event is opened as type=4/config=0x3c (sysfs encoding). Now

I'm not sure it's a problem.  I think it works as expected...?


> let's cross our fingers and hope that in the driver they are really
> the same thing. I take objection to the idea that there should be two
> different priorities for sysfs/json and legacy depending on whether a
> PMU is or isn't specified in the event name. The priority could be
> legacy then sysfs/json, or it could be sysfs/json then legacy, but it
> should be the same regardless of whether the PMU is put in the event

Well, I think having PMU name in the event is a big difference.  Legacy
events were there since Day 1, I guess it's natural to think that an
event without PMU name means a legacy event and others should come with
PMU names explicitly.

Thanks,
Namhyung


> name. The PMU in the event name should be optional, for example we may
> or may not show it in the stat output. The encoding being consistent
> was the case prior to the Apple-M? fix and this patch aims to make it
> consistent once more. Given the ARM bug mentioned above it should also
> fix specifying or not the PMU on Apple-M? CPUs as it will avoid the
> same legacy event issue that may only exist on old kernels. RISC-V is
> motivated because of not wanting hard coded legacy events in the
> driver for all potential vendors and models.
> 
> Thanks,
> Ian

