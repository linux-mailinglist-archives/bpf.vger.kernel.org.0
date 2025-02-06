Return-Path: <bpf+bounces-50663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1432A2A71C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B843A06CE
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72E227572;
	Thu,  6 Feb 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1UkMgayv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9pOss34t"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AD1F60A
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738840440; cv=none; b=jlqk59VA1BYWWT9mi5ZqUrr/2673ZFftzaI4O2fOYqM3leTdJQZyerrup6rMKsmAhDpZDBpw+zvY92xS5zF/zJX079hMW6oWDqi5WIFExwMK1YFZSKFnQKZHopmnre2pjF1IB/ZZUrSIZRffoLdFrTPu0vPmHkcY/XR8zurKEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738840440; c=relaxed/simple;
	bh=k9j+zI5u4w1yO+Zr2IWFkqv+pfhibIvhx8vYbGsZ0YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8lfScHTrAlq2PJuz/UkLYwsYygO3DrRfG33x86/N89F04bpDlsMD4lhigR8ursSeon9u3DJyfulALeLeCWTwusKzzzaVklAWqYJ9wM2TB7bww17ZKw0Zmv4YN+YFAUU5no+vRMjsvAH+mZCx34TC6p/7AMsxcJXC0DsEYKFOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1UkMgayv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9pOss34t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Feb 2025 12:13:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738840436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9j+zI5u4w1yO+Zr2IWFkqv+pfhibIvhx8vYbGsZ0YI=;
	b=1UkMgayvE9/Uc/cTrqPZLBa3AXgAQ3Ite0PVStS+LL8VnifaskilXmsZDAKdIDvdaBpwj7
	UqV1JornFItriB8rWHixQQJdfJMi7M4MhehCfaYxDDOPpbo6wBjwIzXMW4XXRm0VRRCLZ1
	WXOXVsoqu/RxltzXwfa6FVH/MiDW1qfey3meNkALwQk+Hthiju8FplerxbNYq14HLkB3kI
	aHJEd11+Ch2MmP1EdUYAwEA6FbheZLLR0lUmObvd4BTBPjVkV48UTC3KV8OaP19PpvaYjh
	E5Rdd1jlKG60j25WHrKvMeKoCdgOgbRJzGuzi8GG6KrvFItK8wJ1W846gPVeBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738840436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9j+zI5u4w1yO+Zr2IWFkqv+pfhibIvhx8vYbGsZ0YI=;
	b=9pOss34tKYuVPVoOmNb4GRsnuGq5rszVBrP0hnFLTKrthSvsrNjGfqs1zpCckHxUOYLlrr
	/APTmqJXDebMGMAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v6 3/6] locking/local_lock: Introduce
 local_trylock_t and local_trylock_irqsave()
Message-ID: <20250206111355.9KHYSvQ3@linutronix.de>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <20250124035655.78899-4-alexei.starovoitov@gmail.com>
 <20250128172137.bLPGqHth@linutronix.de>
 <CAADnVQ+6YD=jzx08ynUDo=ptFbD62o17ozymFfycF5WbPb9GbA@mail.gmail.com>
 <20250129081726.vGHs_2kD@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129081726.vGHs_2kD@linutronix.de>

On 2025-01-29 09:17:27 [+0100], To Alexei Starovoitov wrote:
> PeterZ, may I summon you.
PeterZ, may I summon you.

Sebastian

