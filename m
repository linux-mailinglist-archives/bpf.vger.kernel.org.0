Return-Path: <bpf+bounces-49400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43935A18229
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5B23AB449
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C4B1F4E5A;
	Tue, 21 Jan 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0pNOEi0+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JkLD9WFo"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B21F428C
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477786; cv=none; b=ZEi70Ra4xAIyq7K9GBK4Xzl8pSdzbxhMb1iOwD9LJ+C9QYH2FATPzkiX6QYawFKEXyucvKGsqfLOJPF/ajZZT4ec6I3WebyuU+DZnyGg3LBvuamSd7pc0X/Y9kpZOx/WkceNgfz05PryTP4EzE9Z+1E2/fb21mNgg3DZiNDK5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477786; c=relaxed/simple;
	bh=6iF9+4PSPas6AGZlhiGH0DoQwYjk5yeBNuz2kypAuBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKVM470XVIuh5sxKxnOQxtDJiCl5bMHOnbflsWpXAqDmCTjUQsePCQyOiK2EoStSOsLeHO8aBlgf7VbUyamuNuGKYIK2Dm0XjQtxwWEZ+i0kilFgTORsvnfK6pA/uEfoS+z3fDhFVEugc0MAA+NeOd3TDfHcEQ2HA12sUxxYmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0pNOEi0+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JkLD9WFo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Jan 2025 17:43:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737477781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iF9+4PSPas6AGZlhiGH0DoQwYjk5yeBNuz2kypAuBQ=;
	b=0pNOEi0+WnZXIMR6vQDnNNs1C5ecjaVowjhM8Vxyu5LcHl1c35ckhBl3u0XvM7sgcS/fT5
	13JSs0ssg7XX2tO1Xh3OUwmUefw+3so545ponpX9qMsyjmlNyWU5ZiHF+uQZmvQzDc3N2X
	Axeezh61WWEzpoPs7YyrkpFtM2lP7pqWCZ52Xel6w3wkA7aijOfGhRZKlx7Y5Axty8YFck
	akaq2vHZ1IZJ3JaskKwc8oUFJqELU9tId81d4Ghx5lXhV0gM5CRG+TQozwpxKXwQnChGvT
	+BBFpF0PmOExGlhXnD/vu3lecEvLqlUa8xkUmrRmrXQkNitHrbrDRmP+10GuOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737477781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iF9+4PSPas6AGZlhiGH0DoQwYjk5yeBNuz2kypAuBQ=;
	b=JkLD9WFoPvABvjfZH8kULDIzO/ydFq85QsQRvThIkYH7rziVEcl68sXsa+7Kycvy3S9VuC
	izOcM03XO7MW4CBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@suse.com,
	willy@infradead.org, tglx@linutronix.de, jannh@google.com,
	tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce
 local_trylock_irqsave()
Message-ID: <20250121164300.NOAtoArV@linutronix.de>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-4-alexei.starovoitov@gmail.com>
 <20250117203315.FWviQT38@linutronix.de>
 <cec11348-a55f-40b4-9011-0e83113ade63@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cec11348-a55f-40b4-9011-0e83113ade63@suse.cz>

On 2025-01-21 16:59:40 [+0100], Vlastimil Babka wrote:
> I don't think it would work, or am I missing something? The goal is to
> allow the operation (alloc, free) to opportunistically succeed in e.g.
> nmi context, but only if we didn't interrupt anything that holds the
> lock. Otherwise we must allow for failure - hence trylock.
> (a possible extension that I mentioned is to also stop doing irqsave to
> avoid its overhead and thus also operations from an irq context would be
> oportunistic)
> But if we detect the "trylock must fail" cases only using lockdep, we'll
> deadlock without lockdep. So e.g. the "active" flag has to be there?

You are right. I noticed that myself but didn't get to reply=E2=80=A6

> So yes this goes beyond the original purpose of local_lock. Do you think
> it should be a different lock type then, which would mean the other
> users of current local_lock that don't want the opportunistic nesting
> via trylock, would not inflict the "active" flag overhead?
>=20
> AFAICS the RT implementation of local_lock could then be shared for both
> of these types, but I might be missing some nuance there.

I was thinking about this over the weekend and this implementation
extends the data structure by 4 bytes and has this mandatory read/ write
on every lock/ unlock operation. This is what makes it a bit different
than the original.

If the local_lock_t is replaced with spinlock_t then the data structure
is still extended by four bytes (assuming no lockdep) and we have a
mandatory read/ write operation. The whole thing still does not work on
PREEMPT_RT but it isn't much different from what we have now. This is
kind of my favorite. This could be further optimized to avoid the atomic
operation given it is always local per-CPU memory. Maybe a
local_spinlock_t :)

Sebastian

