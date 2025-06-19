Return-Path: <bpf+bounces-61052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BEAE00A1
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7DB4A0B67
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606A265CA2;
	Thu, 19 Jun 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HwLrq/Pb"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264112652BD;
	Thu, 19 Jun 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323451; cv=none; b=VA/R/nRtcSE6Baao/Z0wOgCP/WbM1aXN5E4+XXOiPc9mgdFRlYxbUprVCu1JqplkzNIZaxXZ64Z4djzhJQTJ46zxwkhSNOAJO/aoPG4GnRC1eUyaDMi5MmfG70y31+MosApmL5o1voZmmZxwzMZgg0auGPrKffJsy4wC5IgFz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323451; c=relaxed/simple;
	bh=UK1RqDVts91YexE3fkSSu8jPpOdqVCSXaQ+NVRDXzQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eavxkdr2coDwRb1HmBy0Iu1TDqxh7HRg16rapiVBe31AdxiZhUKXqkjF965xCQmWEo/SnsZqoKdsphyi3r8ZTDC9XM0wYpHs8S3Y2qSxNRRZOw4SFgaCmZy1igajq7DxZ5MnfEwZamF1Ql50+4Nc8PHXOBpkQznZOl7hu5vttYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HwLrq/Pb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LMJJ+oQ9dAd5zIASaS1xeMNl5njS2eu8sDBW07HZ5Bw=; b=HwLrq/Pb0D4/GHDr1LJhjpqWiU
	fqUgypmBMtErW+esmuEP/hKwqOx4RSsknFg7qm9cuVjl9QPhCxXUds8a3ZTxC1llquoClNkIqSoci
	gf0DRwU3KgCs6TYWJxvJCre+jWqFdFrL0eyZIscR01gvsXp0PCREjU2KA1nM9lBvfXgL0rZun3fV5
	tyKSrq8DN5pG7EZTSSmKg4OxhFsvj9ohBvjRtQMqL14zqpw3ZqYDPjMo1sRFvoqMj63j2QIyYEYyQ
	2ODgKbM4oMFuTvWv+ibDK+y+j6MV0ZMvbFZDcP1otjpS2EEdtmIkxHRh0IzM7fbvEJKe6k9MQ7tdJ
	AV4e3Zwg==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSB5D-00000004OK8-2WKG;
	Thu, 19 Jun 2025 08:57:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A28D43088F2; Thu, 19 Jun 2025 10:57:17 +0200 (CEST)
Date: Thu, 19 Jun 2025 10:57:17 +0200
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
Subject: Re: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250619085717.GB1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.938845449@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:28PM -0400, Steven Rostedt wrote:

> +static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
> +{
> +	struct unwind_task_info *info = &current->unwind_info;
> +	bool inited_timestamp = false;
> +	int ret;
> +
> +	/* Always use the nmi_timestamp first */
> +	*timestamp = info->nmi_timestamp ? : info->timestamp;
> +
> +	if (!*timestamp) {
> +		/*
> +		 * This is the first unwind request since the most recent entry
> +		 * from user space. Initialize the task timestamp.
> +		 *
> +		 * Don't write to info->timestamp directly, otherwise it may race
> +		 * with an interruption of get_timestamp().
> +		 */
> +		info->nmi_timestamp = local_clock();
> +		*timestamp = info->nmi_timestamp;
> +		inited_timestamp = true;
> +	}
> +
> +	if (info->pending)
> +		return 1;
> +
> +	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
> +	if (ret < 0) {
> +		/*
> +		 * If this set nmi_timestamp and is not using it,
> +		 * there's no guarantee that it will be used.
> +		 * Set it back to zero.
> +		 */
> +		if (inited_timestamp)
> +			info->nmi_timestamp = 0;
> +		return ret;
> +	}
> +
> +	info->pending = 1;
> +
> +	return 0;
> +}
> +
>  /**
>   * unwind_deferred_request - Request a user stacktrace on task exit
>   * @work: Unwind descriptor requesting the trace
> @@ -139,31 +207,38 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
>  {
>  	struct unwind_task_info *info = &current->unwind_info;
> +	int pending;
>  	int ret;
>  
>  	*timestamp = 0;
>  
>  	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
>  	    !user_mode(task_pt_regs(current)))
>  		return -EINVAL;
>  
> +	if (in_nmi())
> +		return unwind_deferred_request_nmi(work, timestamp);

So nested NMI is a thing -- AFAICT this is broken in the face of nested
NMI.

Specifically, we mark all exceptions that can happen with IRQs disabled
as NMI like (so that they don't go about taking locks etc.).

So imagine you're in #DB, you're asking for an unwind, you do the above
dance and get hit with NMI.

Then you get the NMI setting nmi_timestamp, and #DB overwriting it with
a later value, and you're back up the creek without no paddles.


Mix that with local_clock() that is only monotonic on a single CPU. And
you ask for an unwind on CPU0, get migrated to CPU1 which for the
argument will be behind, and see a timestamp 'far' in the future.



