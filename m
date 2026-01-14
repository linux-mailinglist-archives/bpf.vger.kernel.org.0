Return-Path: <bpf+bounces-78926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B539D1F9EF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BC8E3031798
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B61258CCC;
	Wed, 14 Jan 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DpI+2DhX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVZv71+I"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D4314D0E;
	Wed, 14 Jan 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403273; cv=none; b=f6vAlEsvTO9heixP60tyGSYMXQ5ar1r2OZpyC9cuOzPwemkAKqCYlpUmB/QKw/fNkNx79tkes8pb/T51oWmdcD3BFioe7l3GFhnhBVywFUOwRlaAX6aO8IvwwuxiKwebak5rii4AkZH38ehlbd9O9SX7SKEO42BId3bzr2B1/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403273; c=relaxed/simple;
	bh=ijoxmLcpYK8TmrtRBiqA3q93MmpkarK1JAhh1J+Mtr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMb+b3n+BpT7nDJqCzX94x0Dan9DMcxQ6YTkItB5f0ZAYPYSLOa/NrG2Gy8m+B0Fac5njWH7bK92Oh9rQGca1cEswo4Whjmo4cJuLtJhPSFd0sShZNMGMMHAON+42cPxiTkILHVI8ZqDNESasKtORQQKVAXQsqB2Rdgml4EZfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DpI+2DhX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVZv71+I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 16:07:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768403269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4C72mCKj6g75hWi4SDABu63k1LKvcFbsA+RvmMJke0I=;
	b=DpI+2DhXGNoB3K9LoI1svHbcKbv3kxb2YyFFdspbE5qXTTBPF+9h8s+FkerT3INURZk5p/
	kBC4L+PoGogVnYmWhgwtvG9+TCDDITAdJYtste182B6otosAomrdWroG5Tbv5B6Yc2uTQ+
	GJQFj6T9tnxuLbW1XUpoqfqjq0CpAV1W4jvu1ogkvswQPrE/c+QHamLYa+ZiRKeKtc294b
	psHNbgTT91lHQklnZcMYINuG1AtadMiWoojmUNN/TJd4ET2c0Qy5/mfpwRF+3VCRm8rnCG
	VZmF0F8rXveRojhDwnXI4kf8N6X2BFd5voVKrZT9HMRi3bv38Q+SGQg7TlZtLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768403269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4C72mCKj6g75hWi4SDABu63k1LKvcFbsA+RvmMJke0I=;
	b=XVZv71+IElwl1uhi03hZmyhqfq9kC8+MP1iK9rfNstyKTMmeHAzHgb7zHvRiRzgdQqo5vQ
	AO99yxFvYK6TmyBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH RFC v2 06/20] slab: make percpu sheaves compatible with
 kmalloc_nolock()/kfree_nolock()
Message-ID: <20260114150747.ziWhVVQM@linutronix.de>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-6-98225cfb50cf@suse.cz>
 <20260113183604.ykHFYvV2@linutronix.de>
 <CAADnVQK0Y2ha--EndLUfk_7n8na9CfnTpvqPMYbH07+MTJ9UpA@mail.gmail.com>
 <596a5461-eb50-40e5-88ca-d5dbe1fc6a67@suse.cz>
 <d8d25eb3-63c4-4449-ae9c-a7e4f207a2bc@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8d25eb3-63c4-4449-ae9c-a7e4f207a2bc@suse.cz>

On 2026-01-14 15:05:34 [+0100], Vlastimil Babka wrote:
> > Yes IIRC Hao Li pointed that out before. We'll be able to remove that
> > !preemptible() check that we area about to add by the patch above.
> > 
> > But I'm not sure we can remove (or "not put back") the "in_nmi() ||
> > in_hardirq()" too, because as you said it was added with different reasoning
> > initially?
> 
> Ah right, it was "copied" from alloc_frozen_pages_nolock_noprof() where it's
> explained more, and AFAICS will be still applicable with sheaves. We should
> add a comment to kmalloc_nolock() referring to the
> alloc_frozen_pages_nolock_noprof() comment...

Right. This looks halfway what I remember. And this was works in atomic
context on RT because of rmqueue_pcplist()/ pcp_spin_trylock() usage.

Sebastian

