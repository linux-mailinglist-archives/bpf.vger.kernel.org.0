Return-Path: <bpf+bounces-53959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E38A5FB0B
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22136883A69
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4503426B2A7;
	Thu, 13 Mar 2025 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZKZaty+c"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4226AAAD
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881781; cv=none; b=O4jG32pEui+2OOR/wlFii/NLyYBKVDOEktY/0958aiTLkb8vM2nJc/5v9R4qMjzwwAcwuVLXxr6VwYQMMZ/2D7lS1cuvkHyB44lCSBsha0oaGlyMLLmsHV8NbmzK5Mg9oHYuw42dzcTRXlZnkvzaShtVfPH0PQp0/laPm6SZWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881781; c=relaxed/simple;
	bh=i0BkVoqE4BQnj/1Tm+eHz+8RgOurg9mlaJpEj+j9oII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHEGikSLgAY5O0b01QGu2txMeyGGqrWXeRP8i8GUQDYhXBh8nPvN9F1w9Dn6YQ1m/aSDqVfmNY5V59PMDIVlkveN3AjBXs1NQ2VP5TVnrtKrpCWHsTZZusKMM/tooTOXp50wwAmpDWw0faJeJRc3DzvTOp7r4FPr87lxYeUJYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZKZaty+c; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Mar 2025 09:02:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741881776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3r0gScSjGUNLpT31yPSgFl/qaMZq0at7tX/2n+LnKbM=;
	b=ZKZaty+cgmIT3ieapCVA8qqh1HlnCRPq3iTzfP3PtL/wSEp+zi8QA7PbkOjWxCzu1Ga6l0
	jLhdrg++mdqCrtHzhZnB9r/vBBImtEvY/Nr2+/bQ2Q8NjSxYP5peisny3rdvua6b9XI6Yn
	7LQ0rWSCPNZDBg3jCeJHUsfcvep+wlM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <laynlq5ach6rljd2sajdk32svmm2laxjhig63kxuulhcaujofh@5ybguhcijnyl>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com>
 <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
 <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
 <igjisv7v3o2efey3qkhcrqjchlqvjn54c4dneo2atmown6pweq@jwohzvtldfzf>
 <Z9KbAZJh5uENfQtn@tiehlicka>
 <4a52db5b-f5fe-4a60-ba17-a634a2d0b7af@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a52db5b-f5fe-4a60-ba17-a634a2d0b7af@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 13, 2025 at 03:21:48PM +0100, Vlastimil Babka wrote:
> On 3/13/25 09:44, Michal Hocko wrote:
> > On Wed 12-03-25 12:06:10, Shakeel Butt wrote:
> >> On Wed, Mar 12, 2025 at 11:00:20AM +0100, Vlastimil Babka wrote:
> >> [...]
> >> > 
> >> > But if we can achieve the same without such reserved objects, I think it's
> >> > even better. Performance and maintainability doesn't need to necessarily
> >> > suffer. Maybe it can even improve in the process. E.g. if we build upon
> >> > patches 1+4 and swith memcg stock locking to the non-irqsave variant, we
> >> > should avoid some overhead there (something similar was tried there in the
> >> > past but reverted when making it RT compatible).
> >> 
> >> In hindsight that revert was the bad decision. We accepted so much
> >> complexity in memcg code for RT without questioning about a real world
> >> use-case. Are there really RT users who want memcg or are using memcg? I
> >> can not think of some RT user fine with memcg limits enforcement
> >> (reclaim and throttling).
> > 
> > I do not think that there is any reasonable RT workload that would use
> > memcg limits or other memcg features. On the other hand it is not
> > unusual to have RT and non-RT workloads mixed on the same machine. They
> > usually use some sort of CPU isolation to prevent from CPU contention
> > but that doesn't help much if there are other resources they need to
> > contend for (like shared locks). 
> > 
> >> I am on the path to bypass per-cpu memcg stocks for RT kernels.
> > 
> > That would cause regressions for non-RT tasks running on PREEMPT_RT
> > kernels, right?

I would say more predictable for RT-kernel users but anyways I am in the
process in the prototying and will share how it looks like.

> 
> For the context, this is about commit 559271146efc ("mm/memcg: optimize user
> context object stock access")
> 
> reverted in fead2b869764 ("mm/memcg: revert ("mm/memcg: optimize user
> context object stock access")")
> 
> I think at this point we don't have to recreate the full approach of the
> first commit and introduce separate in_task() and in-interrupt stocks again.
> 
> The localtry_lock itself should make it possible to avoid the
> irqsave/restore overhead (which was the main performance benefit of
> 559271146efc [1]) and only end up bypassing the stock when an allocation
> from irq context actually interrupts an allocation from task context - which
> would be very rare. And it should be already RT compatible. Let me see how
> hard it would be on top of patch 4/6 "memcg: Use trylock to access memcg
> stock_lock" to switch to the variant without _irqsave...

I am already changing stuff in this area, I will also give this idea a
try as well.

> 
> [1] the revert cites benchmarks that irqsave/restore can be actually cheaper
> than preempt disable/enable, but I believe those were flawed

