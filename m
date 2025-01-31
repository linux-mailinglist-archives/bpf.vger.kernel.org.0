Return-Path: <bpf+bounces-50244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7FA2453A
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 23:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503353A6C05
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91A1F3FF0;
	Fri, 31 Jan 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp4lt9zU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502A1547E4;
	Fri, 31 Jan 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738362483; cv=none; b=PwFWeyG/Yzpo8HFLZ6UYZov575GfMpYAk1Mk2XaNok1j4DKJQrjHT3IKlD0x1vX8p4W3+XUTIm4gftVm73eltJfE8pOTcGOoiO0qUvEcbLG6wv4F4y5HENeN+u1EtmmCKKHm37UqofBDUEEyZ4pHlG7BxB1TA06zRcKTh2wswiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738362483; c=relaxed/simple;
	bh=i7+bLb+rCCdd+YKdkCnY41uP05Vh5IhTSwJdJW0hLgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0oGf/xuufSQR+bXJilD3Qy1fN1xgyObVGcrZbyMlICqj6FOp4Y3yULe+0b0HJI26aRRKIGg/70Wgoha+qzNAjqRbQhHwABMcWgGKpcrRQx6ljqWRhzIxszQuXEmlPM2NlGQ6POfhoPV99QyJQwCCWqcOsCxapTNsx+2fpOGuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp4lt9zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05A7C4CED1;
	Fri, 31 Jan 2025 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738362483;
	bh=i7+bLb+rCCdd+YKdkCnY41uP05Vh5IhTSwJdJW0hLgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zp4lt9zUoqnrBEraF8mA6/1azCHnS/4nOJYF+ME/EHzK6WgAWnaBQoR4SHE0itkl6
	 WrZ6ciKI7j9cTR7rXXhjROtCi2JxfSgoCVC2p/G4ONPko2zvy9TXSiFlP+CU8eIkbE
	 bs49RDvztblmdtPDEjGYHaazoyel4z2BZ/pVNOft41cfLVMdi9/qNT2/6wbYyBM03b
	 AO/g8Tb6SkwT6TzOKYbrqOi6Pv8r6wLjXnTPQk9bBAjRb+HrCRTe477ynSuU6Vzc1R
	 XL8kaxnpp5nZKiZE37Gvtq1XF6L57vI2MCEwKukLBxOttteRq+wSl3J45N20ImcNaX
	 cXYQOnfK4xZvA==
Date: Fri, 31 Jan 2025 14:28:01 -0800
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
Message-ID: <Z51OcYYDuZLw1Yqo@google.com>
References: <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com>
 <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com>
 <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com>
 <CAP-5=fV4Q-J+Coybk5Uw=Xpx9sm5MG=2b-fvRLX14K+ZJcmz5Q@mail.gmail.com>
 <Z5sLIiU7D6GwpWY1@google.com>
 <CAP-5=fXHuR37Q-1qhZx_wLeSTh6k-T1DrV0EquDuLEpwnHa21A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXHuR37Q-1qhZx_wLeSTh6k-T1DrV0EquDuLEpwnHa21A@mail.gmail.com>

On Wed, Jan 29, 2025 at 10:03:03PM -0800, Ian Rogers wrote:
> On Wed, Jan 29, 2025 at 9:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Jan 29, 2025 at 05:16:58PM -0800, Ian Rogers wrote:
> > > On Wed, Jan 29, 2025 at 1:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > On Wed, Jan 15, 2025 at 01:20:32PM -0800, Ian Rogers wrote:
> > > > > On Wed, Jan 15, 2025 at 9:59 AM Namhyung Kim <namhyung@kernel.org> wrote:
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
> > >
> > > You're wrong as you are describing the behavior post:
> > > https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
> > > commit a24d9d9dc096fc0d0bd85302c9a4fe4fe3b1107b from Nov 2022, but
> > > somehow without legacy event fall backs which Intel added with a PMU
> > > for hybrid.
> > >
> > > The behavior in this patch series is best for RISC-V, presumably ARM
> > > (particularly for Apple M? CPUs), carries ARM and Intel's tags,
> > > implements the behavior Arnaldo asked for, and solves the
> > > inconsistency that I think is fundamentally wrong in the tool that PMU
> > > names shouldn't matter on an event name (an inconsistency my past
> > > fixes introduced). It is also part of solving other problems:
> > > https://lore.kernel.org/linux-perf-users/20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com/
> >
> > So you think the below behavior is preferred, right?
> >
> >   cycles -> cpu/cycles/ (or whatever PMU name) -> sysfs or json
> >
> > And there's no way to use legacy event encodings anymore?
> 
> This is absolutely the right thing to do! If sysfs/json knows better
> than to allow a legacy event named cycles, advertises it, then perf
> should select it. Not doing this was the cause of the ARM Apple M?
> breakage - because their PMUs looked uncore before hybrid fixes and so
> weren't known previously to accept legacy events and always used the
> sysfs/json encodings in preference. Why would or not having the PMU in
> the event name imply a different and sometimes known broken encoding?

Because I think 'event' and 'pmu/event/' are different and it's natural
that 'event' (w/o PMU) to use the legacy encoding.  Maybe ARM Apple M?
has broken implementation, but then they should fix it.

IIRC what they wanted was to pick sysfs encoding when they use the
'pmu/event/' format.  And that's perfectly fine.


> And then in the perf stat uniquification we can rename the event to be
> the version with a different encoding. It is madness to me.

Right, so it should use full 'pmu/event/' format.

> 
> If a user wants to force a legacy event, even though most typically
> the driver is saying it knows better, they can use a raw event
> encoding or in the case of cycles its alias cpu-cycles. If there
> really is a use-case for using legacy encodings, we could introduce
> new legacy-cpu and legacy-cache PMUs that advertise the events, but
> then the wildcard behavior would be weird.

I don't think raw event accepts legacy encoding.  Also I don't want the
additional legacy-* PMUs.  Maybe what I want is to remove surprises -
it'd be confusing if I have two events (w/o PMU) and one is using legacy
encoding and the other is using sysfs because (core?) PMU has an alias.

> 
> To be clear, I do not know of a single use-case where the legacy
> encodings are actually wanted when sysfs/json have an encoding. The
> opposite is very much true, that legacy encodings are not wanted -
> hence wanting the lowering of their priority everywhere originally by
> ARM to fix Apple M? and then by RISC-V.

Is Apple M* currently broken?  I'm not sure if we won't ever want the
legacy encoding.

> 
> > >
> > > You've not pointed at anything wrong in the scheme that these patches
> > > introduce, and are supported by vendors, except that it is a behavior
> > > change. I can, and have, pointed at many issues with your proposal
> > > above and the current behavior. The behavior change came about to work
> > > around PMU bugs over 2 years ago but only partially did so. It makes
> > > sense to remedy this and for the clean, consistent behavior this
> > > series achieves. It is unfortunate that it is a behavior change, but
> > > the first step for that was made 2 years ago. I think it also makes
> > > sense that something self described as legacy is a lower priority and
> > > of the past (wrt event naming moving forward).
> >
> > I want to clarify the event parsing behavior and to find the right way
> > to deal with various cases.  I haven't followed the activities in this
> > area closely so I missed some changes in the past.  Maybe the problem
> > is that the behavior is complex and not clarified.  Hopefully we can
> > write it down in a doc.
> 
> I think what is typical in the kernel is the source is the best
> documentation. By simplifying event parsing, for example,
> parse-events.y has been reduced from 952 lines (in v5.10) to 762 lines
> - so we're about 25% simpler whilst being more correct (I've fixed all
> the memory leaks, etc.) and avoiding expensive start-up costs, lazy
> initialization, etc.

That's great!

> 
> Having a single priority for which events are preferred, legacy vs
> sysfs/json with or without PMU, will further make the code base
> simpler and easy to understand.

I cannot agree.  I think 'event' and 'pmu/event/' are different.  And we
need to clarify how to handle 'event' case correctly.  And I hope we can
disable the wildcard behavior.

Thanks,
Namhyung


