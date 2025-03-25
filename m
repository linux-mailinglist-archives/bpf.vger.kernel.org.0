Return-Path: <bpf+bounces-54627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B6A6EDBD
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86EED17256D
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10BF253F38;
	Tue, 25 Mar 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gfFaiqWZ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAC1F09B4;
	Tue, 25 Mar 2025 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898671; cv=none; b=C+AsEL6L9cgHgwOgGghUeU9hJeQLuryt7ptvmqWapRa2zyrQqjDsa+FGST7cuhML7VnDNsx95xrT5Ls5cyj806tvJaynl+eoeaemN9zVEYRsNbQDiXuy70D4+WFoCB8amkFIhHKAtWyhGukjDQdjOguejJkS35HbBShVljOjvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898671; c=relaxed/simple;
	bh=iUVRNoX1Knz7Y6rUE7hxKfH2OvC8R/1+8cUIgp2bKnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZbTcFsGmtYGweVBFzbvOID243R7GSiGAw1v57UjbTbzTd0ngFV41dBgsysrwN7LdZpSWcllBN2hpDbi+92E1T6x3oUfSU9DeUiqPUH8TzTkiYmmaqn9uLNaBNCdisXR+UtN8GZixk18LJovLOoKSnz/j5jnb/XGh03/vUj+jhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gfFaiqWZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/kcNSHKt+p7xj8Bd8AiTv8+l1qAYvdxpi++1IEtteso=; b=gfFaiqWZoPHPtFfYrf3Z/e/vJj
	gUrLZg/FV2zYzWXh7k0otAW57zDJ3F81RJMrj3f9jdnEWW9wz7dRze0kKx6p4uXNtcreAchaJeOEA
	QcnE/ccvmOZxXFQpytN9KZ9eZX4QPrZccuh4HtgjKHt3Pd7dUg8DdsVCptXfQmVjHGlwj8rBV1OdG
	XNAfhVHXAs6necQ4vvePPSmVf01mN4lGqmuTKAoMHOsxrMI5EBrE6Oove3ulQjDPbxqVUzWbx4Olc
	Q1dfGMSi5+wSeYDhdh67b1lVfYkgwSjyy+WvhU3RIXRXxVRnjeN9ZQ+bYfJTqTFC9XjVog2vi6OO8
	X4kJVCKA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tx1YV-00000003nQ3-3Mco;
	Tue, 25 Mar 2025 10:30:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28D7E3004AF; Tue, 25 Mar 2025 11:30:47 +0100 (CET)
Date: Tue, 25 Mar 2025 11:30:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <20250325103047.GH36322@noisy.programming.kicks-ass.net>
References: <20250323072511.2353342-1-edumazet@google.com>
 <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com>
 <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
 <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
 <20250324113304.GB14944@noisy.programming.kicks-ass.net>
 <Z-JsJruueRgLQ8st@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-JsJruueRgLQ8st@gmail.com>

On Tue, Mar 25, 2025 at 09:41:10AM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Mar 24, 2025 at 08:53:31AM +0100, Eric Dumazet wrote:
> > 
> > > BTW the atomic_cond_read_acquire() part is never called even during my
> > > stress test.
> > 
> > Yes, IIRC this is due to text_poke_sync() serializing the state, as that
> > does a synchronous IPI broadcast, which by necessity requires all
> > previous INT3 handlers to complete.
> > 
> > You can only hit that case if the INT3 remains after step-3 (IOW you're
> > actively writing INT3 into the text). This is exceedingly rare.
> 
> Might make sense to add a comment for that.

Sure, find below.

> Also, any strong objections against doing this in the namespace:
> 
>   s/bp_/int3_
> 
> ?
> 
> Half of the code already calls it a variant of 'int3', half of it 'bp', 
> which I had to think for a couple of seconds goes for breakpoint, not 
> base pointer ... ;-)

It actually is breakpoint, as in INT3 raises #BP. For complete confusion
the things that are commonly known as debug breakpoints, those things in
DR7, they raise #DB or debug exceptions.

> Might as well standardize on int3_ and call it a day?

Yeah, perhaps. At some point you've got to know that INT3->#BP and
DR7->#DB and it all sorta makes sense, but *shrug* :-)


---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index bf82c6f7d690..01e94603e767 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2749,6 +2749,13 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 
 	/*
 	 * Remove and wait for refs to be zero.
+	 *
+	 * Notably, if after step-3 above the INT3 got removed, then the
+	 * text_poke_sync() will have serialized against any running INT3
+	 * handlers and the below spin-wait will not happen.
+	 *
+	 * IOW. unless the replacement instruction is INT3, this case goes
+	 * unused.
 	 */
 	if (!atomic_dec_and_test(&bp_desc.refs))
 		atomic_cond_read_acquire(&bp_desc.refs, !VAL);

