Return-Path: <bpf+bounces-48753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5251A10474
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024453A40CE
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41322DC44;
	Tue, 14 Jan 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eE9vhp2Q"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105B229639
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851198; cv=none; b=OZTwssFZTB3Ws/Kh7tpDyG/nSNCxhThXddckV5ygdA1kjcZvAP1MYPvlE20BCdSCQR0BQIyUinnz5aglvPaO1IxoaRA/Z+y34jjLyQjw5F7XAIuxkEzKorGO0vZYkwhK+/WxG4NtUzq4RcNAo6y6Lhe0iCbNiOBFdO1r6zarQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851198; c=relaxed/simple;
	bh=wJOc4DEIyIwkAeYrL3/0Nfce2we3I1zy7nvcFkgXkb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg3/wpearRrllX/jPAFft8AHJZbzPVZBTAVkkrLi3erdRMm/5w5t3NMcXs+9d9nFsocTjnHPWXp1WIRl8oA4Wgd5/Z2tF9ccrWNFZkqGJoN9oWiXPUmBDG7cThyGbN+aj3gT3e+M+AMyVCpRi9gYBO/lnAub+yyJu1/mOMVVnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eE9vhp2Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r+w/cUtD5Y5h2ew6kp+OJi7qEEAey9zNgUW1NwUjHos=; b=eE9vhp2QryxWVJSCcHd1ild9eL
	lE9mq2O0gYqdLkmMud7HtgSg3qJ2TGwgSHaQerDPldc2noXM1B3jHvlv0drjKxfOW8KuPNRrfm8hG
	QGjE0unTtiG3GI7SLYAIuTuXTCk4cfUkq7EV3xWWOq3XLQmDQ2xsI/KkXtwCs4V1O79c2Jow4BeNL
	6Lm6Nb6HFxAKdlFszhUkh+a3DBIONk2Hl3RGLfP+767K/4Ww/yIdWBr6+Ynm3OJ04HmCxNccOTYLc
	S2Uu74MQYDtA48NvI2BLHhG464RjSe6gaXgJzgRYueSVT4VLxRCIwUJPcQYbHJcpmses/V9QBDvZE
	go+YSCgQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXeKo-0000000E2GD-35UI;
	Tue, 14 Jan 2025 10:39:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4570A3004DE; Tue, 14 Jan 2025 11:39:46 +0100 (CET)
Date: Tue, 14 Jan 2025 11:39:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	vbabka@suse.cz, bigeasy@linutronix.de, rostedt@goodmis.org,
	houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
	willy@infradead.org, tglx@linutronix.de, jannh@google.com,
	tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <20250114103946.GC8362@noisy.programming.kicks-ass.net>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com>
 <20250114095355.GM5388@noisy.programming.kicks-ass.net>
 <Z4Y6PS3Nj8EMt9Mx@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Y6PS3Nj8EMt9Mx@tiehlicka>

On Tue, Jan 14, 2025 at 11:19:41AM +0100, Michal Hocko wrote:
> On Tue 14-01-25 10:53:55, Peter Zijlstra wrote:
> > On Mon, Jan 13, 2025 at 06:19:17PM -0800, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > > 
> > > Tracing BPF programs execute from tracepoints and kprobes where
> > > running context is unknown, but they need to request additional
> > > memory.
> > 
> > > The prior workarounds were using pre-allocated memory and
> > > BPF specific freelists to satisfy such allocation requests.
> > > Instead, introduce gfpflags_allow_spinning() condition that signals
> > > to the allocator that running context is unknown.
> > > Then rely on percpu free list of pages to allocate a page.
> > > The rmqueue_pcplist() should be able to pop the page from.
> > > If it fails (due to IRQ re-entrancy or list being empty) then
> > > try_alloc_pages() attempts to spin_trylock zone->lock
> > > and refill percpu freelist as normal.
> > 
> > > BPF program may execute with IRQs disabled and zone->lock is
> > > sleeping in RT, so trylock is the only option. 
> > 
> > how is spin_trylock() from IRQ context not utterly broken in RT?
> 
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +		return NULL;
> 
> Deals with that, right?

Changelog didn't really mention that, did it? -- it seems to imply quite
the opposite :/

But maybe, I suppose any BPF program needs to expect failure due to this
being trylock. I just worry some programs will malfunction due to never
succeeding -- and RT getting blamed for this.

Maybe I worry too much.



