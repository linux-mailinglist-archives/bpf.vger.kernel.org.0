Return-Path: <bpf+bounces-34253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A95092BE73
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5FD1C2296B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FD9154C07;
	Tue,  9 Jul 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oj4DWZPY"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E652629D;
	Tue,  9 Jul 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539100; cv=none; b=pHic/34j5P39d+9DvpKLhBLhCJonrXwZw6evy6xGjQ+x6+zB8mOdJG+Rc61cdhDx3apY2l8keFh5aRXy53YSDb02R8vZLbhezHTM17IpVT7sa676gi15F8N8x2/cC4XmvJoCaa7hns02MeYTofI0WlivMC7Teqf++zAaa25dSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539100; c=relaxed/simple;
	bh=2OvIRzYHPqXVR/b/m0jc1BGUjTadwusMYaHSMN75cuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6cXdTdqZFN5z/RASA42b6ena4z3v8PEq4zpmvZ7aQcAcSS5I9rZSx++CKnYhHTB1EjjRShfaTIW12EGDkk2KrUANiIFD1gGFDXb1KXiPCRJ+1BvrUYFxfsiREmZRpo3J1iHNcURwOJQZ9pV5if207qqPis3zGiv1JmJS61bCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oj4DWZPY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E1R+7jPIXad3vJFym8KQnVYvqnqlBaz6UOE+8aD7j20=; b=Oj4DWZPYaR2AfqrV33ymLwuU0O
	S7WoDAk/hoJ+ju0IMofJIGqlBAViyUi+pZyjPYhbhgaXweRvIrrXOCH7FsbREwv1PCW2PPIadnmWB
	Lnrd/k/WgBOPLPJFB4lZiGSM7uVfhsLkOnzM95jkeo+l8e7Q9rln4JBnONhOV+48kvDjf9kol8yHy
	0I6jLOTRGNE/ZicdKTJGoLmwfB7ja9pxbKmEMfQN+p8RL78G0uAmUrFPHJO4mRb0/8wAOUEoGBdDO
	W7EkRuljECkBypR0D6JumAM7xalr83IVc9BBNjHcI5mINZsK9jomjGqN+vojvp4j96hKjPvjppLfn
	2/Hc3kEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCoW-00000000leH-2LTK;
	Tue, 09 Jul 2024 15:31:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E3773006B7; Tue,  9 Jul 2024 17:31:32 +0200 (CEST)
Date: Tue, 9 Jul 2024 17:31:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>, willy@infradead.org
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240709153132.GR27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <445aed81-a845-4f5d-8b20-70eced3ce4f8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445aed81-a845-4f5d-8b20-70eced3ce4f8@paulmck-laptop>

On Tue, Jul 09, 2024 at 07:36:41AM -0700, Paul E. McKenney wrote:

> > Per VMA refcounts or per VMA locks are a complete fail IMO.
> 
> Not even to allow concurrent updates of the address space by different
> threads of a process?

Well, I'm sure it helps some workloads. But for others it is just moving
the problem.

> For me, per-VMA locking's need to RCU-protect the VMA is a good step
> towards permitting RCU-protected scans of the Maple Tree, which then
> gets lockless lookup.

Right, the question is if the VMA lock is required to be stable against
splitting. If that is the case, we're hosed :/

At the time I added a seqcount for that, but I'm also remembering that's
one of the things people complained about for single threaded
performance.

