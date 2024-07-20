Return-Path: <bpf+bounces-35174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE69381F8
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 18:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F167281B81
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228E145B00;
	Sat, 20 Jul 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1aE1Ttm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768731E489;
	Sat, 20 Jul 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491391; cv=none; b=Hf5pNj2IBHw+fxssbtO+3njKAJ5WvK3mY/JVIT9tdnJ4p4ybPN1AL+gqD45K+oW8K1l1+c2jRzeQHryjAi7BxaLe2pJRVtYDuTLpewuGujDSPc+C2Vw5pawA1zrcMeCUBmNVy2I1OsUKCCkK49HwBsjDqRVykSIF3rhLaN5vESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491391; c=relaxed/simple;
	bh=UUVoIiP42smxBol1WkzTulJoMUngByIqlMyMaAyVVtU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UNAt8vNbsLJazWmvHm/sLPdkbaAbtCYvPKDUQO1dnOfAFOELbZmaC3vD25c3JeHIvxOm0RqApr77OmPipoUi8QwlBjZlydbXyjJxM45v2m6tHooXfQGTzbo9YcMd+KN+SZwmHpVLlyIov6uwGdp9mM2LOtGPoollx1vaSdh4TPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1aE1Ttm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698A3C2BD10;
	Sat, 20 Jul 2024 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491391;
	bh=UUVoIiP42smxBol1WkzTulJoMUngByIqlMyMaAyVVtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r1aE1Ttm0PzVD8pANyLWUD6IFi5ThtxP9SXOhh4no9Qm9TQEJ0PPQ4Bz9w5n/N/JU
	 prBX0+BDmsWD01/wMhksk6Gwa/GLOz9OGp+TJXlgF9ycTe+uqKxv4ZkUsBgvxSGLiD
	 1JWItzrM3mn8QRsukXKgp9JC9Vl9nM7PoJLNgtNJDLIPUnmtNex3Dh9i3dgK0SqWQm
	 NlFLVvIy8y8416Ba2dKTLlZ1QLCQzG2/lpgvrRmK6zx0DsX4/47ciOM1YbbIlx8V5G
	 tkw5swAVdI2WFycHI+A+GXSCnX57CR8q3LpowKNaboZuVbj+pBNeY1ncAkLYuuOi0/
	 z+fYRV00Gcg1Q==
Date: Sun, 21 Jul 2024 01:03:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kyle Huey <me@kylehuey.com>, Peter Zijlstra <peterz@infradead.org>,
 khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>, Namhyung Kim
 <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 robert@ocallahan.org, Joe Damato <jdamato@fastly.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan"
 <kan.liang@linux.intel.com>, Andrii Nakryiko <andrii@kernel.org>, Song Liu
 <song@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing
 events
Message-Id: <20240721010304.bf426eafee8e3745ce21f6c3@kernel.org>
In-Reply-To: <ZpYgYaKKbw3FPUpv@krava>
References: <20240713044645.10840-1-khuey@kylehuey.com>
	<ZpLkR2qOo0wTyfqB@krava>
	<20240715111208.GB14400@noisy.programming.kicks-ass.net>
	<CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
	<20240715150410.GJ14400@noisy.programming.kicks-ass.net>
	<CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
	<20240715163003.GK14400@noisy.programming.kicks-ass.net>
	<CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
	<ZpYgYaKKbw3FPUpv@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 16 Jul 2024 09:25:21 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > On Mon, Jul 15, 2024 at 9:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> > >
> > > > I think this would probably work but stealing the bit seems far more
> > > > complicated than just gating on perf_event_is_tracing().
> > >
> > > perf_event_is_tracing() is something like 3 branches. It is not a simple
> > > conditional. Combined with that re-load and the wrong return value, this
> > > all wants a cleanup.
> > >
> > > Using that LSB works, it's just that the code aint pretty.
> > 
> > Maybe we could gate on !event->tp_event instead. Somebody who is more
> > familiar with this code than me should probably confirm that tp_event
> > being non-null and perf_event_is_tracing() being true are equivalent
> > though.
> > 
> 
> it looks like that's the case, AFAICS tracepoint/kprobe/uprobe events
> are the only ones having the tp_event pointer set, Masami?

Hmm, I think any dynamic_events has tp_event (is struct trace_event_call *)
because it represents the event itself. But yes, if the event is working
like a trace-event, it should have tp_event. So you can use it instead
perf_event_is_tracing().

Thank you,

> 
> fwiw I tried to run bpf selftests with that and it's fine
> 
> jirka
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

