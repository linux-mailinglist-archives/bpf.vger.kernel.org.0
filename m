Return-Path: <bpf+bounces-73830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5427CC3AE57
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867473A639A
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2213532AAAA;
	Thu,  6 Nov 2025 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="asDGkgs9"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307163B9;
	Thu,  6 Nov 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432040; cv=none; b=P/UkN4Zv46cRcyAMsJQi/0BVd/pmN8GzVTXWosrLeXWpr/Rv0V3gYaecrPPOJ8zlO2M7yZyURaMa3Ru6s1y5p2IP6EMrqrvX2/xfMGnbpz9aRTCkHsrYbqagpt34kjbPkwSosLNRFTZiM9l7cNF6RL49sBvorW315IikKP/+ijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432040; c=relaxed/simple;
	bh=SWTj0mbsCzwTsed7Aqm+2CdLnZ2XM5rxFO7KQ/si0Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1yAwU0CGlDEZhN3XUmBn3VT9MjfJKbSuaXDrdYzn+oQQ+tY3ytkwJPspdkf/m8qowh5gFdBlKZ0sONkniZSpXxuP0PXqHQF22CVqJcqYcA3NqbfX+p7BAnPcOfl9JUieSC20O6aHS1gsIMMNVGc3QjgJHGGFneH+6qMGWUTTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=asDGkgs9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6rzs3XT6ejvjGbWm6qt55/luyLuKlyYL5jzJo0xWC8Y=; b=asDGkgs92i8m0de59HN4CDPQFK
	rpN52GV9/UVKtXz+9zPDjf/PxgprCTfXLfZhwnNgE0+cZrIv4KmokCKHd4jHQmQlf4UInDAk1J8Ww
	f0ODJc0GCFHzsFPo9ItDBGyRsiqggoenGim/gikcrtW5q3xCxUd0xs8AbHSORE3ixpIC9cv3wAzZB
	l+LWTEDgfEHKUceSSKCVS/H7jaKd/vBJ9kXePNiMrCphrdhglFYSRnLwHtlaNP6AYrH1fFvPXU0W3
	lm/KGiy7jZAZ12LHCOM6u/3eclO6c8MIXum8obxgoyqf+dMby9Na6Rezul9rctNlh916MVKdP0YNL
	ngp7BSgA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGz55-00000001kRl-2GEA;
	Thu, 06 Nov 2025 12:27:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E693300230; Thu, 06 Nov 2025 13:27:11 +0100 (CET)
Date: Thu, 6 Nov 2025 13:27:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCHv2 1/4] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <20251106122711.GV4067720@noisy.programming.kicks-ass.net>
References: <20251103220924.36371-1-jolsa@kernel.org>
 <20251103220924.36371-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103220924.36371-2-jolsa@kernel.org>

On Mon, Nov 03, 2025 at 11:09:21PM +0100, Jiri Olsa wrote:
> This reverts commit 83f44ae0f8afcc9da659799db8693f74847e66b3.
> 
> Currently we store initial stacktrace entry twice for non-HW ot_regs, which
> means callers that fail perf_hw_regs(regs) condition in perf_callchain_kernel.
> 
> It's easy to reproduce this bpftrace:
> 
>   # bpftrace -e 'tracepoint:sched:sched_process_exec { print(kstack()); }'
>   Attaching 1 probe...
> 
>         bprm_execve+1767
>         bprm_execve+1767
>         do_execveat_common.isra.0+425
>         __x64_sys_execve+56
>         do_syscall_64+133
>         entry_SYSCALL_64_after_hwframe+118
> 
> When perf_callchain_kernel calls unwind_start with first_frame, AFAICS
> we do not skip regs->ip, but it's added as part of the unwind process.
> Hence reverting the extra perf_callchain_store for non-hw regs leg.
> 
> I was not able to bisect this, so I'm not really sure why this was needed
> in v5.2 and why it's not working anymore, but I could see double entries
> as far as v5.10.

Probably some ftrace/bpf glue code that doesn't adhere to the contract
set by perf_hw_regs(); as you find in the next patch.

