Return-Path: <bpf+bounces-50948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE4A2E8E1
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C2F1887C5F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A91C68B6;
	Mon, 10 Feb 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uIlOErQU"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64C1C5F10;
	Mon, 10 Feb 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182657; cv=none; b=LyreaE6au40nrPv43+l2VNElWkZ00YGN0egnXN6zdCWXzjIVczM7QWn6wjAWQXgQF/11ezOsUz7kJT4lAl708ABP31U3T0+tki3sQTN3omxQXbnDlRP3/72YvdEynNChj1dchAe7BGjCQv79lJLJgxnp8bU65r70E8zi2ogE7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182657; c=relaxed/simple;
	bh=chcLcB8hz8GUsz1gFUvwiKFZFNUYY3DArotzQhXQtmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0wbQiMdFfL0A0/zeaa4TB11CpJi5y5nKutXbZ/lUKJfjzCc8x73MbfPq3upnaN6pvgjSzeFifwG+HFchjQBH2RmpVJvL7NU8U1M1bItvcYtXm3lwOYALTp4fT3FBXBkCm17SwPkrL3zoMBlIprI4so5fTIIRUHogzHPA8QczyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uIlOErQU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hhiCR0AgFIOeF4HS1CGKAOPDrkDo1F+m8u6AqUimqbQ=; b=uIlOErQUY2LA378P/b/PjPuCU6
	eBtpaJwVQemWIrRTzDEZa2HvMYuGsObheoeeoV/VTHEvLinm9P8vrqY2kdzlYKZ0QLuL0fMaknLTp
	YsIUtz50FTonOihHSFcLSSrrS7emKN9ATUu1G1g6mJMk3OEY/268GHKDwqxru2cgTt2blqIQdSbHE
	2sJL9+f7qXT9jEQr1tIeN95XMKhBEapQiUAdVo/HU5tqwrFNGhwlsrNMnZPSm+ksf1wakZ69nV96j
	1iRIFZmmC52W5dW8stnEHgMXq4Bw2uR9iKPilcWVLryWA6gb+shYWcQSYxb6HC8zHHaFaCJJyB81G
	lWHTLsKg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thQr5-0000000FWDr-05HJ;
	Mon, 10 Feb 2025 10:17:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9079E300318; Mon, 10 Feb 2025 11:17:30 +0100 (CET)
Date: Mon, 10 Feb 2025 11:17:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 09/26] rqspinlock: Protect waiters in queue
 from stalls
Message-ID: <20250210101730.GI10324@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250206105435.2159977-10-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105435.2159977-10-memxor@gmail.com>

On Thu, Feb 06, 2025 at 02:54:17AM -0800, Kumar Kartikeya Dwivedi wrote:
> Implement the wait queue cleanup algorithm for rqspinlock. There are
> three forms of waiters in the original queued spin lock algorithm. The
> first is the waiter which acquires the pending bit and spins on the lock
> word without forming a wait queue. The second is the head waiter that is
> the first waiter heading the wait queue. The third form is of all the
> non-head waiters queued behind the head, waiting to be signalled through
> their MCS node to overtake the responsibility of the head.
> 
> In this commit, we are concerned with the second and third kind. First,
> we augment the waiting loop of the head of the wait queue with a
> timeout. When this timeout happens, all waiters part of the wait queue
> will abort their lock acquisition attempts. 

Why? Why terminate the whole wait-queue?

I *think* I understand, but it would be good to spell out. Also, in the
comment.

