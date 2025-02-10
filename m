Return-Path: <bpf+bounces-50947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D25A2E89E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F373A7DCD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9651E47CC;
	Mon, 10 Feb 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K8XBpdDu"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DA1E411C;
	Mon, 10 Feb 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181805; cv=none; b=pZe5dlhcCFIZl0pYyPcF/Wk3XdItg8lXmfT72RRLtk5GwaSlcXgXLUdJkiO7wSSrU/ZHKylkCfIDGYpJhEs0oURPGNVKhN1RbszjXyss2i9J02aVA19aeKaaC7TP54HvA0iwSKTwYwJEfJAJvqrPK/oUHZqBtJBmmrfEh0Awp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181805; c=relaxed/simple;
	bh=PzxEsAIy2Y5q3RbrVB+WOxbJUD5XYZedRMncBTZPGBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUhjPt/k/FP+uBEVHHrzPRrXqPyRwqX1IyChY0h47mHgLoiPcPua3cyIwWjO+OMr1GLZE1Q2T2xavggFkMJ8GAk55bGAX7AxKgnEZazAwCUeVHws9rs9zLYZehaW9ks25NElOe7qHA3k7HBWU/wYIgWni4u2d5ZWE5Si7Pgeeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K8XBpdDu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O0wPUHmZjIrRfM0ZgTZXmcA69jfXxoml1nbssdgLHCs=; b=K8XBpdDuiRODbexqwMX9pNYznz
	hULWHzlk8AlRFXXw69F0usCa6fxq5n35WcWIqmBvZnvD8nnXC0pbvcTrsVkoM6Fb5tJZnV47Jt8EL
	AIjtl0i2cK43NSQJmJC46mDcY5SjkrPcudRVuN5oYaccBKRxEnGYAf9BEQq4VnuiCBD/Io8uiwz6e
	QCL1xbjt0O3zyEzGuInfSU6OMcPrbjEMkwl5x6Ob9WPCuw9YsjVpLIdIIEhYbheILuDu9jeqa6MoL
	BX7P4JyGddLA1BHyBEjQTE/Cpzskv75SfF2rkb5gyHcu8fMqyew4h3vTyNn7CVBYxjy0wqpSJMfS2
	Noyh+HEw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thQdI-0000000FUSp-23kB;
	Mon, 10 Feb 2025 10:03:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 173AA3002E5; Mon, 10 Feb 2025 11:03:16 +0100 (CET)
Date: Mon, 10 Feb 2025 11:03:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
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
Subject: Re: [PATCH bpf-next v2 17/26] rqspinlock: Hardcode cond_acquire
 loops to asm-generic implementation
Message-ID: <20250210100316.GD31462@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250206105435.2159977-18-memxor@gmail.com>
 <20250210095324.GG10324@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210095324.GG10324@noisy.programming.kicks-ass.net>

On Mon, Feb 10, 2025 at 10:53:25AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 02:54:25AM -0800, Kumar Kartikeya Dwivedi wrote:
> > Currently, for rqspinlock usage, the implementation of
> > smp_cond_load_acquire (and thus, atomic_cond_read_acquire) are
> > susceptible to stalls on arm64, because they do not guarantee that the
> > conditional expression will be repeatedly invoked if the address being
> > loaded from is not written to by other CPUs. When support for
> > event-streams is absent (which unblocks stuck WFE-based loops every
> > ~100us), we may end up being stuck forever.
> > 
> > This causes a problem for us, as we need to repeatedly invoke the
> > RES_CHECK_TIMEOUT in the spin loop to break out when the timeout
> > expires.
> > 
> > Hardcode the implementation to the asm-generic version in rqspinlock.c
> > until support for smp_cond_load_acquire_timewait [0] lands upstream.
> > 
> 
> *sigh*.. this patch should go *before* patch 8. As is that's still
> horribly broken and I was WTF-ing because your 0/n changelog said you
> fixed it.

And since you're doing local copies of things, why not take a lobal copy
of the smp_cond_load_acquire_timewait() thing?

