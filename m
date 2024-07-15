Return-Path: <bpf+bounces-34826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB1931752
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 17:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8591F212CD
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F18F18F2D4;
	Mon, 15 Jul 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bMOwPyAK"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75D3A1A0;
	Mon, 15 Jul 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055864; cv=none; b=X/LhYC6Rwaq5YUoMX6FYH/yUVYKFZJZ1eqCWwY20he7wx97MCGjvU4SaFm5IwqPaLqVNYKhO3zdDPyUXsVDZV1Wb8BFcDugigT9NcAeFfuc4BSBRRg9nJzLJG2trGEngtt10wYPafBGsAsAwztPWe0t86Wz2OyWd3LZGuXM3Snk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055864; c=relaxed/simple;
	bh=n0/nzvmy11GDxc0//hJH2Q4gITDLZFYHxulbApnYveI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIPKey+jYeO8mHtNsvflSXf8KTggst9uit6wgH4Mu/fMGM8vruuZZXh/7ZXTBthS5DpFnY8UHHR1yjByvzv6CnttVMFci9B38IzB45trvGpst1kfuulYOA0+0vwiZPteIuVckX4zyL7j5PlAoxjUR0FCUinmhI8jCIeMIgQajug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bMOwPyAK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HiqN+6KfDIV0u+YAv0hb3ocgTFc77Zw+YIvRtt0igsQ=; b=bMOwPyAKH+/O9lEPjP3jTcnOdh
	+pWFMxAzfvP9tlqqB18yNcLn8bAT8QZ0Zu4OvewR/im+ZGPQJWGFPTI71HmiYBD2pTlcT8E1zniWa
	w/i9sPRekUTkrq+TAL03PSjjoUPd97oJrgo7iZXjUXDuTI9he8bEe86IfktxaFH6yenVL2SayoUDh
	mYY61czDEp1mDy+q8amHKXxRuM2d1w5LbOBbNP155jpi2rVBC20xInwPzKGPjv7XepEbrz6BoeX5s
	RLrItXUw33E2wJlnivE+FevHBJLgblbGlrxfl5tJeh3Bx2SQxETOI5cns2dJZEGtPoQ61+lHn4rEq
	bRTc567Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTNFL-0000000FwB3-3OFl;
	Mon, 15 Jul 2024 15:04:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 176E73003FF; Mon, 15 Jul 2024 17:04:11 +0200 (CEST)
Date: Mon, 15 Jul 2024 17:04:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kyle Huey <me@kylehuey.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, khuey@kylehuey.com,
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
Message-ID: <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
References: <20240713044645.10840-1-khuey@kylehuey.com>
 <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net>
 <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>

On Mon, Jul 15, 2024 at 07:33:57AM -0700, Kyle Huey wrote:
> On Mon, Jul 15, 2024 at 4:12 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > Urgh, so wth does event_is_tracing do with event->prog? And can't we
> > clean this up?
> 
> Tracing events keep track of the bpf program in event->prog solely for
> cleanup. The bpf programs are stored in and invoked from
> event->tp_event->prog_array, but when the event is destroyed it needs
> to know which bpf program to remove from that array.

Yeah, figured it out eventually.. Does look like it needs event->prog
and we can't easily remedy this dual use :/

> > That whole perf_event_is_tracing() is a pretty gross function.
> >
> > Also, I think the default return value of bpf_overflow_handler() is
> > wrong -- note how if !event->prog we won't call bpf_overflow_handler(),
> > but if we do call it, but then have !event->prog on the re-read, we
> > still return 0.
> 
> The synchronization model here isn't quite clear to me but I don't
> think this matters in practice. Once event->prog is set the only
> allowed change is for it to be cleared when the perf event is freed.
> Anything else is refused by perf_event_set_bpf_handler() with EEXIST.
> Can that free race with an overflow handler? I'm not sure, but even if
> it can, dropping an overflow for an event that's being freed seems
> fine to me. If it can't race then we could remove the condition on the
> re-read entirely.

Right, also rcu_read_lock() is cheap enough to unconditionally do I'm
thinking.

So since we have two distinct users of event->prog, I figured we could
distinguish them from one of the LSB in the pointer value, which then
got me the below.

But now that I see the end result I'm not at all sure this is sane.

But I figure it ought to work... 

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ab6c4c942f79..5ec78346c2a1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9594,6 +9594,13 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+
+static inline struct bpf_prog *event_prog(struct perf_event *event)
+{
+	unsigned long _prog = (unsigned long)READ_ONCE(event->prog);
+	return (void *)(_prog & ~1);
+}
+
 static int bpf_overflow_handler(struct perf_event *event,
 				struct perf_sample_data *data,
 				struct pt_regs *regs)
@@ -9603,19 +9610,21 @@ static int bpf_overflow_handler(struct perf_event *event,
 		.event = event,
 	};
 	struct bpf_prog *prog;
-	int ret = 0;
+	int ret = 1;
+
+	guard(rcu)();
 
-	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
-	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
-		goto out;
-	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
-	if (prog) {
+	if (!((unsigned long)prog & 1))
+		return ret;
+
+	prog = (void *)((unsigned long)prog & ~1);
+
+	if (unlikely(__this_cpu_inc_return(bpf_prog_active) == 1)) {
 		perf_prepare_sample(data, event, regs);
+		ctx.regs = perf_arch_bpf_user_pt_regs(regs);
 		ret = bpf_prog_run(prog, &ctx);
 	}
-	rcu_read_unlock();
-out:
 	__this_cpu_dec(bpf_prog_active);
 
 	return ret;
@@ -9652,14 +9661,14 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
 		return -EPROTO;
 	}
 
-	event->prog = prog;
+	event->prog = (void *)((unsigned long)prog | 1);
 	event->bpf_cookie = bpf_cookie;
 	return 0;
 }
 
 static inline void perf_event_free_bpf_handler(struct perf_event *event)
 {
-	struct bpf_prog *prog = event->prog;
+	struct bpf_prog *prog = event_prog(event);
 
 	if (!prog)
 		return;
@@ -9707,7 +9716,7 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
-	if (event->prog && !bpf_overflow_handler(event, data, regs))
+	if (!bpf_overflow_handler(event, data, regs))
 		return ret;
 
 	/*
@@ -12026,10 +12035,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
 		if (parent_event->prog) {
-			struct bpf_prog *prog = parent_event->prog;
+			struct bpf_prog *prog = event_prog(parent_event);
 
 			bpf_prog_inc(prog);
-			event->prog = prog;
+			event->prog = parent_event->prog;
 		}
 #endif
 	}

