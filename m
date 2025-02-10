Return-Path: <bpf+bounces-50939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1665A2E7FC
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A617A2582
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAE1C4A24;
	Mon, 10 Feb 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IKNsHnYk"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46649185935;
	Mon, 10 Feb 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180330; cv=none; b=Iw1HeFSX4kqSbeEw6AX9rr3ts6v0mxPpa330hKmRwa7i6fjsQ+rmX/Q6Coz9idQHBztH6F2xMZ7oHugs9uCN7Bmqclf5hZcTCfUcrFXlulrzRDLmNrSHvTdcnOQEIHzybylGiW+FLOLaqewg6Q58UWOoS9Ot+pjYA2drHP0bfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180330; c=relaxed/simple;
	bh=z52zvEobRJUlOWr9DFGCVpLkW9YsEo+4XFuz2bFnK7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7bdtwC3sUqU/m4Q48CWWUzE+JZkb9QbO3ACvAaoGkbUF8Mf9+sKDb/25ZklYT5QDvkSgykScwE4reE2gHTddlLuASENM98KXQxnNcbv1GHmxKJxqLLup8/REQRko7lvY0wdt6SKKWvZ5jbvVTwGHsPYD301WTxc3nZJyfEU/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IKNsHnYk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aZNdFppSlq0cDLZO+YTLuS4/G5kJ54IvtSQ5XE5HyYA=; b=IKNsHnYk54bczXBjOiiK9KSuXo
	AQCUEK5sXuRJHiCBU9ZDN3bT7ZDR+dwAYsH/ce5Wn008Y4hP5JZdWqZm18pUsmWDYomEWD1qJ5yJ5
	vr7krXy/ofteyNpbO4iNynYF8zi5JMMSg3opptUM63fvNrYK1MpNQBPEhZRHbisGumtLLFqMCmO9f
	OQAbwUTRRjXNaBrigqDwf0A7Xavhq2ReqjiGLIKFfUw4rfcN3bayXUgt4W8lfzcieKymyGAlwLoXT
	8xTaupf92LzLGIudZ9imJzPV3NTtim5ESHKPdltnK/mrOpVex8nepOSmuXAEafCkzVUjXHroBWtUT
	YrgrW/5g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thQFV-000000006oP-46d0;
	Mon, 10 Feb 2025 09:38:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2424B300318; Mon, 10 Feb 2025 10:38:41 +0100 (CET)
Date: Mon, 10 Feb 2025 10:38:40 +0100
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
Message-ID: <20250210093840.GE10324@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>

On Thu, Feb 06, 2025 at 02:54:08AM -0800, Kumar Kartikeya Dwivedi wrote:


> Deadlock Detection
> ~~~~~~~~~~~~~~~~~~
> We handle two cases of deadlocks: AA deadlocks (attempts to acquire the
> same lock again), and ABBA deadlocks (attempts to acquire two locks in
> the opposite order from two distinct threads). Variants of ABBA
> deadlocks may be encountered with more than two locks being held in the
> incorrect order. These are not diagnosed explicitly, as they reduce to
> ABBA deadlocks.
> 
> Deadlock detection is triggered immediately when beginning the waiting
> loop of a lock slow path.
> 
> While timeouts ensure that any waiting loops in the locking slow path
> terminate and return to the caller, it can be excessively long in some
> situations. While the default timeout is short (0.5s), a stall for this
> duration inside the kernel can set off alerts for latency-critical
> services with strict SLOs.  Ideally, the kernel should recover from an
> undesired state of the lock as soon as possible.
> 
> A multi-step strategy is used to recover the kernel from waiting loops
> in the locking algorithm which may fail to terminate in a bounded amount
> of time.
> 
>  * Each CPU maintains a table of held locks. Entries are inserted and
>    removed upon entry into lock, and exit from unlock, respectively.
>  * Deadlock detection for AA locks is thus simple: we have an AA
>    deadlock if we find a held lock entry for the lock we’re attempting
>    to acquire on the same CPU.
>  * During deadlock detection for ABBA, we search through the tables of
>    all other CPUs to find situations where we are holding a lock the
>    remote CPU is attempting to acquire, and they are holding a lock we
>    are attempting to acquire. Upon encountering such a condition, we
>    report an ABBA deadlock.
>  * We divide the duration between entry time point into the waiting loop
>    and the timeout time point into intervals of 1 ms, and perform
>    deadlock detection until timeout happens. Upon entry into the slow
>    path, and then completion of each 1 ms interval, we perform detection
>    of both AA and ABBA deadlocks. In the event that deadlock detection
>    yields a positive result, the recovery happens sooner than the
>    timeout.  Otherwise, it happens as a last resort upon completion of
>    the timeout.
> 
> Timeouts
> ~~~~~~~~
> Timeouts act as final line of defense against stalls for waiting loops.
> The ‘ktime_get_mono_fast_ns’ function is used to poll for the current
> time, and it is compared to the timestamp indicating the end time in the
> waiter loop. Each waiting loop is instrumented to check an extra
> condition using a macro. Internally, the macro implementation amortizes
> the checking of the timeout to avoid sampling the clock in every
> iteration.  Precisely, the timeout checks are invoked every 64k
> iterations.
> 
> Recovery
> ~~~~~~~~

I'm probably bad at reading, but I failed to find anything that
explained how you recover from a deadlock.

Do you force unload the BPF program?

