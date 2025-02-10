Return-Path: <bpf+bounces-50959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F35A2E9F2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77858166431
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344F1DDC3F;
	Mon, 10 Feb 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mC4fAAuc"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3A1CC8AE;
	Mon, 10 Feb 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184581; cv=none; b=iB8vY/UIzJYyegvELRQbzkyODnjqGHogV7Ubwzg4LsY94nwHs9E4m3CfwN1wdqzM9BdE8/OFbcjP8Eh6U6cXeLDtKpAhPQmgKO6s11eJwynuyUrwQSpBEOgvJSwWK/AsVsvhqRK5C1grqpb/RJBxY7a0NQRT2KxHCfcF1yjzRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184581; c=relaxed/simple;
	bh=vqaPtBe2lpI01lWukY3VkenZTfW9VVESMP58mrA4fgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGMO4vEdimeSNwDabz7afJbnQZHGh7PE7GKokwjiJ6AG5bpOU5HH2iSa60Q5GfPZt67iP43rjLuCL0QaDlE6xbkBvVDy2pdQFEYKqAbWtscJuaOUSMeFcItC0tR0EbfdG6KpFDa/EZdxqF0/E47K/G9Va0PGWj2fjsmqNJhhN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mC4fAAuc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nH3pvSNUkRlhL4+G+UMDC3b1XyL6w6N3TYBSbml6HW4=; b=mC4fAAucdktIJs1dcferucyMCq
	iUodFybqvGDFlBZzy1zrhMimjKL7I0TbxG2cd8C08ej2aLQ+93uVGBNzJDRzVxPSbAwx7u9Ajj/nJ
	ZjhAhHc2iZ6jdS3v+LTGwoUx+zA/cr6kSl7uJygXyMDcnvWjjQ8F1lplnLyfwApXuNnp0l3iaWPJq
	/qKbdmAqaGV+O3vhvDBFvMbLtNyEO5KrtOH077D/qCozXqswghktIN9PdUNJKsiIRKxxz4yp2tk2N
	LN6xOwsTYMhHKwNE5WckDEVNbQcAmvBv+5cd6cJJl7DAHn1L5mcbVLqpkjVk9t8y78FR08cKAw8dN
	jcINHt5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thRM4-000000007Pm-2dgV;
	Mon, 10 Feb 2025 10:49:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2B580300318; Mon, 10 Feb 2025 11:49:31 +0100 (CET)
Date: Mon, 10 Feb 2025 11:49:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
Message-ID: <20250210104931.GE31462@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250210093840.GE10324@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210093840.GE10324@noisy.programming.kicks-ass.net>

On Mon, Feb 10, 2025 at 10:38:41AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 02:54:08AM -0800, Kumar Kartikeya Dwivedi wrote:
> 
> 
> > Deadlock Detection
> > ~~~~~~~~~~~~~~~~~~
> > We handle two cases of deadlocks: AA deadlocks (attempts to acquire the
> > same lock again), and ABBA deadlocks (attempts to acquire two locks in
> > the opposite order from two distinct threads). Variants of ABBA
> > deadlocks may be encountered with more than two locks being held in the
> > incorrect order. These are not diagnosed explicitly, as they reduce to
> > ABBA deadlocks.
> > 
> > Deadlock detection is triggered immediately when beginning the waiting
> > loop of a lock slow path.
> > 
> > While timeouts ensure that any waiting loops in the locking slow path
> > terminate and return to the caller, it can be excessively long in some
> > situations. While the default timeout is short (0.5s), a stall for this
> > duration inside the kernel can set off alerts for latency-critical
> > services with strict SLOs.  Ideally, the kernel should recover from an
> > undesired state of the lock as soon as possible.
> > 
> > A multi-step strategy is used to recover the kernel from waiting loops
> > in the locking algorithm which may fail to terminate in a bounded amount
> > of time.
> > 
> >  * Each CPU maintains a table of held locks. Entries are inserted and
> >    removed upon entry into lock, and exit from unlock, respectively.
> >  * Deadlock detection for AA locks is thus simple: we have an AA
> >    deadlock if we find a held lock entry for the lock we’re attempting
> >    to acquire on the same CPU.
> >  * During deadlock detection for ABBA, we search through the tables of
> >    all other CPUs to find situations where we are holding a lock the
> >    remote CPU is attempting to acquire, and they are holding a lock we
> >    are attempting to acquire. Upon encountering such a condition, we
> >    report an ABBA deadlock.
> >  * We divide the duration between entry time point into the waiting loop
> >    and the timeout time point into intervals of 1 ms, and perform
> >    deadlock detection until timeout happens. Upon entry into the slow
> >    path, and then completion of each 1 ms interval, we perform detection
> >    of both AA and ABBA deadlocks. In the event that deadlock detection
> >    yields a positive result, the recovery happens sooner than the
> >    timeout.  Otherwise, it happens as a last resort upon completion of
> >    the timeout.
> > 
> > Timeouts
> > ~~~~~~~~
> > Timeouts act as final line of defense against stalls for waiting loops.
> > The ‘ktime_get_mono_fast_ns’ function is used to poll for the current
> > time, and it is compared to the timestamp indicating the end time in the
> > waiter loop. Each waiting loop is instrumented to check an extra
> > condition using a macro. Internally, the macro implementation amortizes
> > the checking of the timeout to avoid sampling the clock in every
> > iteration.  Precisely, the timeout checks are invoked every 64k
> > iterations.
> > 
> > Recovery
> > ~~~~~~~~
> 
> I'm probably bad at reading, but I failed to find anything that
> explained how you recover from a deadlock.
> 
> Do you force unload the BPF program?

Even the simple AB-BA case,

  CPU0		CPU1
  lock-A	lock-B
  lock-B	lock-A <-

just having a random lock op return -ETIMO doesn't actually solve
anything. Suppose CPU1's lock-A will time out; it will have to unwind
and release lock-B before CPU0 can make progress.

Worse, if CPU1 isn't quick enough to unwind and release B, then CPU0's
lock-B will also time out.

At which point they'll both try again and you're stuck in the same
place, no?

Given you *have* to unwind to make progress; why not move the entire
thing to a wound-wait style lock? Then you also get rid of the whole
timeout mess.


