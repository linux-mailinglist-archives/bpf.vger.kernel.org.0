Return-Path: <bpf+bounces-48746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E7A1035B
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554237A42B3
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 09:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7003A225412;
	Tue, 14 Jan 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jBcQ0fPZ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2C24022A
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848449; cv=none; b=qUDhncQySqj5tP5RCtouCNQCMGoJZxXJuSLErGrD0q+8w1ILXulAYArvgMdaktP2fYv+D+TBRI6k+UjBMZPKBISrQx05LNmvvHJ8SLGjgtj+4Avd+wruxf/ogAny8Q3u7h+DJq/4Jgf9Nf6qnSMDq9DERBU3EqbOhfWTUmX3vOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848449; c=relaxed/simple;
	bh=yKABG963UiY0TWMZllpaziGmNrpe1e+StoVAvLqHSKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sopJhy8jiCOanpWj6m//R1kRYpsS+XNMWwmMkIlS3Ylg5n0kG9I2vp7GTXgXLBK70QXH2zr1xqdy0g8jJvvoVB68ezNSOjc0U0ANYe1BphZc7xIytGkHASJdTO7P8NLuzTL3G8yDsvcQsRmgs18dPipTSX9uR3rX1zAymSAtjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jBcQ0fPZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SZJLJLswXhcQCEtLeIEo9quwfmYnoCb4KMf+b4yGjRY=; b=jBcQ0fPZn1V1WYb2Sa/L4qcCVW
	XR9SzmpAubh4QkljK11sgqIXAL0/py4vbrF3kJJeYR3CtX0+k6Ssdvi8bsPA9oCBsBmZDvfv8IUmt
	VrbSgr3Xq8xMBSJONWJFEWLR/ypumKGqM3OnDFLz2Cl0uv995l3to69uOycsyyIPUYldZ1qwskTU+
	Is1I40b1wLwveB/eoHMkyEShDx6qx48kgXBHOEUE9VLRfQzzI2lhrrdrRv95AUqNd4mR+DwLRA7ay
	tPpSXjWWFr2c2kW5gBxCcsL1vRq0R9h24LYurycCXr1vcyUrymvCYE7BD/d8h1o9iSvpV7ndjYRNd
	FqR8dmZw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXdcR-0000000DR90-38eJ;
	Tue, 14 Jan 2025 09:53:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5678E3004DE; Tue, 14 Jan 2025 10:53:55 +0100 (CET)
Date: Tue, 14 Jan 2025 10:53:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, vbabka@suse.cz, bigeasy@linutronix.de,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <20250114095355.GM5388@noisy.programming.kicks-ass.net>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114021922.92609-2-alexei.starovoitov@gmail.com>

On Mon, Jan 13, 2025 at 06:19:17PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Tracing BPF programs execute from tracepoints and kprobes where
> running context is unknown, but they need to request additional
> memory.

> The prior workarounds were using pre-allocated memory and
> BPF specific freelists to satisfy such allocation requests.
> Instead, introduce gfpflags_allow_spinning() condition that signals
> to the allocator that running context is unknown.
> Then rely on percpu free list of pages to allocate a page.
> The rmqueue_pcplist() should be able to pop the page from.
> If it fails (due to IRQ re-entrancy or list being empty) then
> try_alloc_pages() attempts to spin_trylock zone->lock
> and refill percpu freelist as normal.

> BPF program may execute with IRQs disabled and zone->lock is
> sleeping in RT, so trylock is the only option. 

how is spin_trylock() from IRQ context not utterly broken in RT?

It can lead to try to priority boost the idle thread, among other crazy
things.



