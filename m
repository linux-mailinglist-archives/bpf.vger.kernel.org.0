Return-Path: <bpf+bounces-29750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F67E8C63AC
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 11:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBE31F23988
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7A5914C;
	Wed, 15 May 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LVbp1mOv"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F075A10B;
	Wed, 15 May 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765428; cv=none; b=dx5cw02aL3w0aEFDKhctsSEUYHbojWY40kOocCFNFmV8puPjlf6OD0qE/q7SkUlWREQ6xVqby/7d0QAjAvx2T3dvfdrltjn3X5bnVb8MZ882w+49/AFW9dDCWUgG5DLRNMX3lX4yGeRSgtkxF6oI1CJDDLLfxzlpAqynwvyFuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765428; c=relaxed/simple;
	bh=Tj66QOsws4IxvrdU0JpgRnLKVnNodYuHADUzYQg+66M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq1ODJgG0XEEEmXPwqrPO2b3QtfCXVoKZjrpdGtHzHSSo4s9dCJM+wnx/pKORnZhzdkLF0iePEN5LXf6duVLiDrMi7ZVlr3Ck9DQGzqK52D62PyoRzw3FGLoPufPYCoCGJCev1BzWq9yoeOYiD0AbVqccxHXO99vNYkYKfgBQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LVbp1mOv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0MPcX7Q/1GrJVBzBdzSF5faPHH2cy5MpHUFiB4Qhi+0=; b=LVbp1mOvPldd7Y47Jf81MpXL1t
	4sF0IfM4NyulIId7t/h2d8yWSUd+479sMHyOUB7v4wAv4JvCSjfpxorNG/0DzSx03ZSipHz+L33ND
	mBEloOzhXE2aYyl/pAC87+PaL7fF6X4bKlDR+rT40G4CR/8ag60cCwDDpkWty/40PgkdT+g5NVVcp
	GWaov18XSvLmWiT5v5OmirGZgobiToFQI+dyVD9gEPQyXl5l+EQY+i/f+WNNBYICNfN92oyCr5HMW
	KDGNUMsGg/BSuWtRHOUNLrXE7lH3doW+ZT+DRnSNJtNmJrr1kvCXc1D2ezBP1H4JvWlNhaeC9RdKQ
	+fO1iicQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Axk-000000053HL-1HvO;
	Wed, 15 May 2024 09:30:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7ED5230068B; Wed, 15 May 2024 11:30:13 +0200 (CEST)
Date: Wed, 15 May 2024 11:30:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com,
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org, Riham Selim <rihams@meta.com>
Subject: Re: [PATCH 2/4] perf,uprobes: fix user stack traces in the presence
 of pending uretprobes
Message-ID: <20240515093013.GE40213@noisy.programming.kicks-ass.net>
References: <20240508212605.4012172-1-andrii@kernel.org>
 <20240508212605.4012172-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508212605.4012172-3-andrii@kernel.org>

On Wed, May 08, 2024 at 02:26:03PM -0700, Andrii Nakryiko wrote:

> +static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entry,
> +					       int start_entry_idx)
> +{
> +#ifdef CONFIG_UPROBES
> +	struct uprobe_task *utask = current->utask;
> +	struct return_instance *ri;
> +	__u64 *cur_ip, *last_ip, tramp_addr;
> +
> +	if (likely(!utask || !utask->return_instances))
> +		return;
> +
> +	cur_ip = &entry->ip[start_entry_idx];
> +	last_ip = &entry->ip[entry->nr - 1];
> +	ri = utask->return_instances;
> +	tramp_addr = uprobe_get_trampoline_vaddr();
> +
> +	/* If there are pending uretprobes for current thread, they are

Comment style fail. Also 'for *the* current thread'.

> +	 * recorded in a list inside utask->return_instances; each such
> +	 * pending uretprobe replaces traced user function's return address on
> +	 * the stack, so when stack trace is captured, instead of seeing
> +	 * actual function's return address, we'll have one or many uretprobe
> +	 * trampoline addresses in the stack trace, which are not helpful and
> +	 * misleading to users.

I would beg to differ, what if the uprobe is causing the performance
issue?

While I do think it makes sense to fix the unwind in the sense that we
should be able to continue the unwind, I don't think it makes sense to
completely hide the presence of uprobes.

> +	 * So here we go over the pending list of uretprobes, and each
> +	 * encountered trampoline address is replaced with actual return
> +	 * address.
> +	 */
> +	while (ri && cur_ip <= last_ip) {
> +		if (*cur_ip == tramp_addr) {
> +			*cur_ip = ri->orig_ret_vaddr;
> +			ri = ri->next;
> +		}
> +		cur_ip++;
> +	}
> +#endif
> +}

