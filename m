Return-Path: <bpf+bounces-63217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D2B044CA
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928B216D939
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31B25A645;
	Mon, 14 Jul 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sNhrcmVO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CenooRRU"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC025C827
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508449; cv=none; b=oPflptlzzYmTim43/O8z9mgFQZJXt6J1xVMXp3bLZ/g8LEjx5s5DlFAfah3XKbcrSJ7SgM6R42TYAoHoBDORKxQhVlBP1/9+IEfPReUQj8Fv/qn49VCChqt6g0LRGtpDpsjij24Ahgq6vk06hZ5x1J8ESnsY1razXkwBut6yyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508449; c=relaxed/simple;
	bh=dvqUnWP2LRuFOzHaCp4zLAitEfC6uBl72qA0knFTIbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6uAixepd4KXSpsE+GoFMS7Qjg5tbZXF6UoiBb8AIJtGgYMykjbtjmTqwTyzYcCXSKUsL8FPuo4gSBF5LSm7hPZpUNK8uHh/dnuYjVv0ZjCyZ6f1AKxtKqWHp/hQTwVoZgwK7rJbjkYP8K8xZsby/EU6OjBnBSKrkfvt7GZc7EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sNhrcmVO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CenooRRU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 17:54:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752508445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfxgbpirDG/4DqKWuHPV06tdlywV5pB/yCvyThpPMno=;
	b=sNhrcmVOgz80smjkuLUzhvppTnv3o5XUYKyohdjm8U31CP154qpajIJkYe3omyHoSvsRsG
	NPRk/mJN4a4U7/VJ6HlXLaFSEiA/JgTp5Se9Yg3fpdVsr7yk05WBOT9buIkCEMuwCUck0E
	voDcUiDyDiNiZqtzH1nXxD4RpTSa6QqoYPEV0xLBwfYZxuNL8qekdb7Vicv8uZOQBBNLJy
	MtWMT7Aq9SjOkEeh3NEC+7yzEWr9f2uZYEHsPdwPvStDx3AVrxewXWKVFesbrgSNgU30K3
	kGKma6mi9f+6ND4N5YdCDq6nAqYGvNLaNW53+Asg7c6g7VsoEunARwMBydU8CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752508445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfxgbpirDG/4DqKWuHPV06tdlywV5pB/yCvyThpPMno=;
	b=CenooRRUExsHoe0h+kQOvwmW9ugEXXe3M2iA4eq7a2wG5JN64grZv+mfWHdc60OMPwO9ET
	u5YNQOGlEuVmGADg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Harry Yoo <harry.yoo@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
Message-ID: <20250714155403.ThZUBUzH@linutronix.de>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
 <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
 <20250714110639.uOaKJEfL@linutronix.de>
 <12615023-1762-49fc-9c86-2e1d9f5997f3@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12615023-1762-49fc-9c86-2e1d9f5997f3@suse.cz>

On 2025-07-14 17:35:52 [+0200], Vlastimil Babka wrote:
> If we go with this, then I think the better approach would be simply:
> 
> if (unlikely(!local_trylock_irqsave(&s->cpu_slab->lock, *flags))
> 	local_lock_irqsave(&s->cpu_slab->lock, *flags);
> 
> - no branches before the likely to succeed local_trylock_irqsave()
> - the unlikely local_lock_irqsave() fallback exists to handle the PREEMPT_RT
> case / provide lockdep checks in case of screwing up
> - we don't really need to evaluate allow_spin or add BUG_ON() (which is
> actively disallowed to add these days anyway) - if we screw up, either
> lockdep will splat, or we deadlock

Some people added BUG_ON() in cases were a warning would be more
applicable and recovery would be still be possible. I don't see how to
recover from this (unless you want return NULL) plus it should not
happen.
The only downside would that you don't evaluate the spinning part but
this only matters on RT since !RT should always succeed. So why not.

> Also I'm thinking on !PREEMPT_RT && !LOCKDEP we don't even need the fallback
> local_lock_irqsave part? The trylock is supposed to always succeed, right?
> Either we allow spinning and that means we're not under kmalloc_nolock() and
> should not be interrupting the locked section (as before this series). Or
> it's the opposite and then the earlier local_lock_is_locked() check should
> have prevented us from going here. So I guess we could just trylock without
> checking the return value - any screw up should blow up quickly even without
> the BUG_ON().

As explained above, under normal circumstances the trylock will always
succeed on !RT. But ignoring the return value here does not feel right
and the API might get extended to warn if the return error is ignored.

Sebastian

