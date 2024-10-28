Return-Path: <bpf+bounces-43319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A625C9B39C1
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889421C20CEE
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879321DFDA4;
	Mon, 28 Oct 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFK76Ip4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF33A268;
	Mon, 28 Oct 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141816; cv=none; b=nJcC6/RTckP6T2eQmBPyHGqkhSkj2vLEMZzZ4I15uJ3omOxLd5dJXuRx/U//9d/ahcsGB2cQlb2StPCmeNcugoBL8U68wAgzeo09DzUSaDABbsP56iUWXc5m4l321i1IYGqyOBEvTeSkCX84yzoDgfJd5k0ORYHlP2hMB4uMTLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141816; c=relaxed/simple;
	bh=DzqTH/F7xkgSwjOwuDWBbb3HKeSlzJH/LxB/SMMRAPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNtBSFBRleChAj2oXZFEnt2iIlJ8Vt+R5yOW7EJCR8HKN65JvHTxCyAgdlusrDOhMcAjxE1/fxrOvEI8ivZrVcJBPodWcaB4YaPNDXD+uuZXTpQdRjKxlL05VBeP9+3o+1LaFnqMLNYXcfZNTj8eX1qeF+b63/XYFmXe15ilZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFK76Ip4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96956C4CEC3;
	Mon, 28 Oct 2024 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730141815;
	bh=DzqTH/F7xkgSwjOwuDWBbb3HKeSlzJH/LxB/SMMRAPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFK76Ip4ETXcw+kZbl5GWB0K/gADTflM3IyLq9M/2VzOn0gVFM4nYXYPoaVjeFvrz
	 IbFO3Ua6TCrm7yUMLnyTbTzHWOR4s5RDAMsblY1lt0QR7/+ZEaT+/HOSeY+O+Z+YH4
	 WporHJBgGUw9gR8liosduPZpmlUVDXV4Boze21dc1kQ9+Y9qPkAJLLpIRDYf1F4Et/
	 mLumOlsIshbHk6zej0YxqPXAZxOqBbXpPDTzlnhoQ3GBqa9UO2E6WQt0RvTae5MCFP
	 T9nGETW6P+i5n+2xY2yxwMimEWxSZpVzZDcfHCPIvARFm774IcRvvqx2pLLQFaF0e1
	 1803GaCR4TIyA==
Date: Mon, 28 Oct 2024 11:56:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>, Kyle Huey <me@kylehuey.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 3/5] perf/core: Account dropped samples from BPF
Message-ID: <Zx_edd5mPUQSHwor@google.com>
References: <20241023000928.957077-1-namhyung@kernel.org>
 <20241023000928.957077-4-namhyung@kernel.org>
 <CAEf4BzaoWnUdO0OrmztT1NK62eVzYhFsUiD_E-hY5=oY3E-VeA@mail.gmail.com>
 <ZxlE2jEUzpt0WcFJ@google.com>
 <CAEf4BzaTGSK3ftjuN9sDA7KrBfWsjj7PcGYaJy55X9cHYQT9TQ@mail.gmail.com>
 <ZxldYfiWJQxu3MfN@google.com>
 <CAEf4BzZgsvsqwJsLbPgmVrqPnwx4XPUOQgL10+eb=snTDrrRjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZgsvsqwJsLbPgmVrqPnwx4XPUOQgL10+eb=snTDrrRjw@mail.gmail.com>

On Wed, Oct 23, 2024 at 02:24:13PM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 23, 2024 at 1:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Oct 23, 2024 at 12:13:31PM -0700, Andrii Nakryiko wrote:
> > > On Wed, Oct 23, 2024 at 11:47 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Wed, Oct 23, 2024 at 09:12:52AM -0700, Andrii Nakryiko wrote:
> > > > > On Tue, Oct 22, 2024 at 5:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > Like in the software events, the BPF overflow handler can drop samples
> > > > > > by returning 0.  Let's count the dropped samples here too.
> > > > > >
> > > > > > Acked-by: Kyle Huey <me@kylehuey.com>
> > > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > > > Cc: Song Liu <song@kernel.org>
> > > > > > Cc: bpf@vger.kernel.org
> > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > ---
> > > > > >  kernel/events/core.c | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > > > index 5d24597180dec167..b41c17a0bc19f7c2 100644
> > > > > > --- a/kernel/events/core.c
> > > > > > +++ b/kernel/events/core.c
> > > > > > @@ -9831,8 +9831,10 @@ static int __perf_event_overflow(struct perf_event *event,
> > > > > >         ret = __perf_event_account_interrupt(event, throttle);
> > > > > >
> > > > > >         if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > > > > > -           !bpf_overflow_handler(event, data, regs))
> > > > > > +           !bpf_overflow_handler(event, data, regs)) {
> > > > > > +               atomic64_inc(&event->dropped_samples);
> > > > >
> > > > > I don't see the full patch set (please cc relevant people and mailing
> > > > > list on each patch in the patch set), but do we really want to pay the
> > > >
> > > > Sorry, you can find the whole series here.
> > > >
> > > > https://lore.kernel.org/lkml/20241023000928.957077-1-namhyung@kernel.org
> > > >
> > > > I thought it's mostly for the perf part so I didn't CC bpf folks but
> > > > I'll do in the next version.
> > > >
> > > >
> > > > > price of atomic increment on what's the very typical situation of a
> > > > > BPF program returning 0?
> > > >
> > > > Is it typical for BPF_PROG_TYPE_PERF_EVENT?  I guess TRACING programs
> > > > usually return 0 but PERF_EVENT should care about the return values.
> > > >
> > >
> > > Yeah, it's pretty much always `return 0;` for perf_event-based BPF
> > > profilers. It's rather unusual to return non-zero, actually.
> >
> > Ok, then it may be local_t or plain unsigned long.  It should be
> > updated on overflow only.  Read can be racy but I think it's ok to
> > miss some numbers.  If someone really needs a precise count, they can
> > read it after disabling the event IMHO.
> >
> > What do you think?
> >
> 
> See [0] for unsynchronized increment absolutely killing the
> performance due to cache line bouncing between CPUs. If the event is
> high-frequency and can be triggered across multiple CPUs in short
> succession, even an imprecise counter might be harmful.

Ok.

> 
> In general, I'd say that if BPF attachment is involved, we probably
> should avoid maintaining unnecessary statistics. Things like this
> event->dropped_samples increment can be done very efficiently and
> trivially from inside the BPF program, if at all necessary.

Right, we can do that in the BPF too.

> 
> Having said that, if it's unlikely to have perf_event bouncing between
> multiple CPUs, it's probably not that big of a deal.

Yeah, perf_event is dedicated to a CPU or a task and the counter is
updated only in the overflow handler.  So I don't think it'd cause cache
line bouncing between CPUs.

Thanks,
Namhyung

> 
> 
>   [0] https://lore.kernel.org/linux-trace-kernel/20240813203409.3985398-1-andrii@kernel.org/
> 
> > Thanks,
> > Namhyung
> >

