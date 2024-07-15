Return-Path: <bpf+bounces-34812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F719312CE
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B1F283D66
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BDA1891A4;
	Mon, 15 Jul 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHzUjlbr"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B51465B8;
	Mon, 15 Jul 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041944; cv=none; b=tGTC3qebjM29+a24oLo/FDuJdPI6i2/U2MbWvh+RwtKuKpFp/6B/iPIv71XKU+PF6yinida2Ls96k0j+MD5fNmwiOyVdwEtIq+hXp3lh2y6du0WvmD1FMwxwvyBoEnL+4b4Mlb73ncV5xeN9ZabOO+7V4Rc8QpTkHgrzM/UiiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041944; c=relaxed/simple;
	bh=boD6DHuvEEwyMx5kkUoGvLV6Bx4Xtb7GPr27RAXcqzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upVzGYQr0tBxzOFx2MKuUOxsUtjrQdc7IDLm5DZbbMSvvQkTuD0i42RszoPlXXonG/25YVWv21vbnOd6X1YF3AoJNKk2ZYgyau7Oq9hRFjUWzNEc/b+1fdiX/uoiWWTeJpyeLe2pl2pr6KAT3vs8p7mnERpzBiey/pZim3RcG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jHzUjlbr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/9kN955l3tWnzwnWGkkfTtGN6nU/GmY6pzkTmB5KXRk=; b=jHzUjlbrIrnnOUwFV+BCvO56Dv
	NuAcHwv16kTWcBlBb8f89hGPKIaQ8ReRV7N94Qts3WgqSzGEn2eTSFEqHk6HlCfh/lstTlvl9ZTAN
	xwrbHrLIPtsDkeXhhCu/wk1/a2RhDsZKuL5/EWfjsz+GKhckuw3kc++7I2QlHk5RW63WEQuhc85od
	LAwEXxYgJCDaUvhZHO+kjmh4YNmxsIi8Uomqoj5uFW1Qh/BWbhydeaOzDFBxXy/0d1d9DZO1A+WXK
	kJ3J9hy2ebPebZgFT1Uj0W3IUC8VWEuIWMI092iwsdRYSd5HD2v96Q9FydIYwVB2HqcadVchjq+94
	Jk5kBmDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTJco-00000001mO2-2bNi;
	Mon, 15 Jul 2024 11:12:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 704D33003FF; Mon, 15 Jul 2024 13:12:08 +0200 (CEST)
Date: Mon, 15 Jul 2024 13:12:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kyle Huey <me@kylehuey.com>, khuey@kylehuey.com,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing
 events
Message-ID: <20240715111208.GB14400@noisy.programming.kicks-ass.net>
References: <20240713044645.10840-1-khuey@kylehuey.com>
 <ZpLkR2qOo0wTyfqB@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpLkR2qOo0wTyfqB@krava>

On Sat, Jul 13, 2024 at 10:32:07PM +0200, Jiri Olsa wrote:
> On Fri, Jul 12, 2024 at 09:46:45PM -0700, Kyle Huey wrote:
> > The regressing commit is new in 6.10. It assumed that anytime event->prog
> > is set bpf_overflow_handler() should be invoked to execute the attached bpf
> > program. This assumption is false for tracing events, and as a result the
> > regressing commit broke bpftrace by invoking the bpf handler with garbage
> > inputs on overflow.
> > 
> > Prior to the regression the overflow handlers formed a chain (of length 0,
> > 1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
> > bpf_overflow_handler() to that chain, while perf_event_attach_bpf_prog()
> > (the tracing case) did not. Both set event->prog. The chain of overflow
> > handlers was replaced by a single overflow handler slot and a fixed call to
> > bpf_overflow_handler() when appropriate. This modifies the condition there
> > to include !perf_event_is_tracing(), restoring the previous behavior and
> > fixing bpftrace.
> > 
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > Reported-by: Joe Damato <jdamato@fastly.com>
> > Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
> > Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
> > Tested-by: Kyle Huey <khuey@kylehuey.com> # bpf overflow handlers
> > ---
> >  kernel/events/core.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 8f908f077935..f0d7119585dc 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9666,6 +9666,8 @@ static inline void perf_event_free_bpf_handler(struct perf_event *event)
> >   * Generic event overflow handling, sampling.
> >   */
> >  
> > +static bool perf_event_is_tracing(struct perf_event *event);
> > +
> >  static int __perf_event_overflow(struct perf_event *event,
> >  				 int throttle, struct perf_sample_data *data,
> >  				 struct pt_regs *regs)
> > @@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_event *event,
> >  
> >  	ret = __perf_event_account_interrupt(event, throttle);
> >  
> > -	if (event->prog && !bpf_overflow_handler(event, data, regs))
> > +	if (event->prog &&
> > +	    !perf_event_is_tracing(event) &&
> > +	    !bpf_overflow_handler(event, data, regs))
> >  		return ret;
> 
> ok makes sense, it's better to follow the perf_event_set_bpf_prog condition
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Urgh, so wth does event_is_tracing do with event->prog? And can't we
clean this up?

That whole perf_event_is_tracing() is a pretty gross function.

Also, I think the default return value of bpf_overflow_handler() is
wrong -- note how if !event->prog we won't call bpf_overflow_handler(),
but if we do call it, but then have !event->prog on the re-read, we
still return 0.



