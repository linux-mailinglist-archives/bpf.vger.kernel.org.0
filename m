Return-Path: <bpf+bounces-60940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E8ADEEF1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FAA3A6B67
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1122EAB93;
	Wed, 18 Jun 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oY6OFomG"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AB22EAB8F;
	Wed, 18 Jun 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256036; cv=none; b=aHBXgXbG2KuSGgjqMqzmcux4qH5meyhDc7WoT+B9jRLKhnRk641va9WabYFJ73lQ///Oul9t3eP0NzXIm+EjgPx+sZCdd6oa+1t0M5giE/kJ5jkeS5IwkMqgQblqiylligWpuQWReHplKbSJrarRlA6Or5QbZ6xhbP6rGWnb/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256036; c=relaxed/simple;
	bh=4TiigqAE51zyUMzIqQn/1g27Ko5Pj9WtJibrAQ03VQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2wpDykOkinnv98phLgxUuxIpN0ClHxWJOZ+P+McY+FPMsmbOcsAY52j7UIENYQnbWU1tatIcUAEJn/ihmySyZL/3Za2E6DTZtMkYBC4KJON6n7wgSFzUjxWSt/jZlu9bapmv0Thip2h7BlgaUDmCNqEmVF5RuBvygkfNki0APA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oY6OFomG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mXlLRdpy5yvdh809KrU+L3v1z0vHDXr12xF8/KTaF00=; b=oY6OFomGWLMk6wAUWYWS7DCJ27
	4M3Tqg7tweI2C6Mdp4D1Xzt2Hmh6mfd2Y91lejMHqPEim6fy+zTZaxPzI1K+GKcq60dW8gE4aYb2b
	gtZcQGl/8QOmQ4hf8CVcfKreSE1vnFysmqQWMoBlSsEzKrQDQSExo5dvNLgWAeruGBdyzwN+v1bak
	Xmp7523EbxhSOoqGjQgzR9Q88/6Z318LVdsipLTOM1lR37urCCmv7/NNn2DYaXOEwaTaOnSkrHOp0
	RztiLABf7WEqm4VTyELA1UGIJpciHh1W2Q9PVrrH+Z7p7LvurZNDdlLHsjPyNu8GMGtmTf2ogFq6P
	Cipe49QQ==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRtXu-00000003qpz-1ZRv;
	Wed, 18 Jun 2025 14:13:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E56A7307FB7; Wed, 18 Jun 2025 16:13:45 +0200 (CEST)
Date: Wed, 18 Jun 2025 16:13:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 05/14] unwind_user/deferred: Add unwind cache
Message-ID: <20250618141345.GR1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.603778772@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.603778772@goodmis.org>

> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index f94f3fdf15fc..6e850c9d3f0c 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -12,6 +12,7 @@
>  #include <linux/resume_user_mode.h>
>  #include <linux/tick.h>
>  #include <linux/kmsan.h>
> +#include <linux/unwind_deferred.h>
>  
>  #include <asm/entry-common.h>
>  #include <asm/syscall.h>
> @@ -362,6 +363,7 @@ static __always_inline void exit_to_user_mode(void)
>  	lockdep_hardirqs_on_prepare();
>  	instrumentation_end();
>  
> +	unwind_exit_to_user_mode();

So I was expecting this to do the actual unwind, and was about to go
yell this is the wrong place for that.

But this is not that. Perhaps find a better name like:
unwind_clear_cache() or so?

>  	user_enter_irqoff();
>  	arch_exit_to_user_mode();
>  	lockdep_hardirqs_on(CALLER_ADDR0);


> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index aa32db574e43..db5b54b18828 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -2,8 +2,13 @@
>  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  
> +struct unwind_cache {
> +	unsigned int		nr_entries;
> +	unsigned long		entries[];
> +};
> +
>  struct unwind_task_info {
> -	unsigned long		*entries;
> +	struct unwind_cache	*cache;
>  };
>  
>  #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index 0bafb95e6336..e3913781c8c6 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -24,6 +24,7 @@
>  int unwind_deferred_trace(struct unwind_stacktrace *trace)
>  {
>  	struct unwind_task_info *info = &current->unwind_info;
> +	struct unwind_cache *cache;
>  
>  	/* Should always be called from faultable context */
>  	might_fault();
> @@ -31,17 +32,30 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
>  	if (current->flags & PF_EXITING)
>  		return -EINVAL;
>  
> -	if (!info->entries) {
> -		info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> -					      GFP_KERNEL);
> -		if (!info->entries)
> +	if (!info->cache) {
> +		info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES),
> +				      GFP_KERNEL);

And now you're one 'long' larger than a page. Surely that's a crap size
for an allocator?

