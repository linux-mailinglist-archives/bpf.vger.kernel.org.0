Return-Path: <bpf+bounces-63208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA8BB0429D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6ED161EE3
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450625B1F4;
	Mon, 14 Jul 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tsS0eiGb"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5055246778;
	Mon, 14 Jul 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505534; cv=none; b=olpgGkrFpivlgBcYriGhCvXa6lKRhif2ygpZRMi4J9HUkBtENjsfzAKEFNrwx/D3pUuKYh8Tf0hDUgy6SHlmLGaCXbiV+kBEHVcLn3qKR3dytfsq4rXhrjalmn1q31GNzWbFoxr+0VMotLA+pCCFGhvTSdbHguDSmNXGcNZFUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505534; c=relaxed/simple;
	bh=o3QZFR7NVx2WtIo6kHDFzl3FaHL2nRIvfKHdcJi2Taw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXtRRaYCVS+sWMZDzqEgJS45mxU8zoz8jHpr+ufFderBHjF23dDvKJEnIwvrgnfqMoKjnOLs/mlchFOL/DrFqfUoFQm+ODjiVZwj/qSIk0pVa6n0jnMn366dtWxtW8U5HCfu0X6pUnryPhxqOlfIuAA05YvqUl3N4fC8bbjGbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tsS0eiGb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DgVhqJjuyg98D84vFbLshD8duU6NKh8fwC3dKljNawA=; b=tsS0eiGbG3sfuT1mwPFtEC6OwS
	Y+jZGf9uWNk/uHRtsiS2cE9zG9sAwxZ8g8vNG5VwPyUO177mHbch0NoMef7HEmP1kAIZBT7ACY1OG
	kTd/qkF/Qpt2kSV7tF+yrInGucEyOvEJD+KSQ6ZrqDipERHl0UDGyNBDiHrpbrhqOxlalhM7YEC0i
	SHYoDbgqTLVIDjhdYyTEz/sU2sgdR7DFEuc2G7+FO9Ir9SVzsxD9AcU8ls5fYQDqGnbpcJTtY5G/U
	ApU469G1VPhXHB+h8Ks6i2VkoYv2clpPsR/bL9t2zjY+AbsrDjYaq2QHixNOMzgeNoKVsP7fJQ5m6
	QRR45SPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKk1-00000007pAy-08xn;
	Mon, 14 Jul 2025 15:05:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 25434300186; Mon, 14 Jul 2025 17:05:16 +0200 (CEST)
Date: Mon, 14 Jul 2025 17:05:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250714150516.GE4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012358.831631671@kernel.org>
 <20250714132936.GB4105545@noisy.programming.kicks-ass.net>
 <20250714101919.1ea7f323@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714101919.1ea7f323@batman.local.home>

On Mon, Jul 14, 2025 at 10:19:19AM -0400, Steven Rostedt wrote:
> On Mon, 14 Jul 2025 15:29:36 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
> > +#define UNWIND_NMI_SAFE 1
> > +static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
> > +{
> > +	u32 zero = 0;
> > +	return try_cmpxchg(&info->id.cnt, &zero, cnt);
> > +}
> > +static inline bool test_and_set_pending(struct unwind_task_info *info)
> > +{
> > +	return info->pending || cmpxchg_local(&info->pending, 0, 1);
> > +}
> > +#el
> 
> Patch 10 moves the pending bit into the unwind_mask as it needs to be
> in sync with the different tracer requests. I'm not sure how this
> change will interact with that.

Urgh; so I hate reviewing code you're ripping out in the next patch :-(

Let me go stare at that.

