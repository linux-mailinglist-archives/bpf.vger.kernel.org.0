Return-Path: <bpf+bounces-45575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A79D87E4
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC7B1652DE
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB201B0F06;
	Mon, 25 Nov 2024 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vu2IE9xn"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B9F185B54;
	Mon, 25 Nov 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544826; cv=none; b=WUtG7z58Wn/WBZM88mC9kXGv6eTUz8xP0LPR1bjTCtqXM3NdAEXtY9JvCQHzgcJ4OzLSFSexu4zpddXXq9YHtvFDK7JXE0cyo1BWCUQPR8wlEdxBi1yJ3Kq/AeZOLEyHa3P0PmejYF4zFqJg581uQk5qGt+xd7ZFrjhUnmrSi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544826; c=relaxed/simple;
	bh=JHau2Y732iWdXQTVVPEYklC57H12WvD2GRRoj9Ax41Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfwrc2+Xm5ocq+LaZqslloW38MDK9rZuTJRFTH4e6BkMUrnYyyDSqRa0Nafgz27OuY6IjfExB1b3NDyNL7dunNy+tnbKTsZE5uO0Y0tajRqspYcUuAT8/Uv8Lu99uR+kXcbV6lvHDvfOBA2KQrz2VUTkxsr0W7p/r072ImUch8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vu2IE9xn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q5jGouZTRzqjfwpXO/rRFKuCsrl54WPnsJ1Vi5wJ4Hw=; b=Vu2IE9xnGQNHN4Ipww98tvO/kg
	+jeh1wPqRDtbnihND6jmdGYm136T6wDwwHk3mXUwfT7+CKFI53DR9A8u/NnENpCxzzkm1AHw2mIDQ
	0s3FPoIlyMiLIowqBAho5LJjEEZKH2/SNBdpH4QOci/5hxHa2zYUpcd9rlQOIJPEDw/6J/16wn+wn
	15hbEpytTh2grPhOQCQK+fX5abA5I2br/2TRTEA3RcZUxZOrEk54kJXshtmC47Sdo89enzCBNicLr
	TO6DbQae+BuDJWnvuEyhOzK6QCdk5PepdF4o79AQDHZrJxE9F/+OmZr/RSAzvIRrRPDuUN5pwLPqR
	g/z1imjQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFa3D-0000000By6u-129o;
	Mon, 25 Nov 2024 14:26:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1981F30026A; Mon, 25 Nov 2024 15:26:56 +0100 (CET)
Date: Mon, 25 Nov 2024 15:26:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Jeanson <mjeanson@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Jordan Rife <jrife@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] tracing: Use guard() rather than scoped_guard()
Message-ID: <20241125142656.GH38837@noisy.programming.kicks-ass.net>
References: <20241125142514.2897143-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125142514.2897143-1-mathieu.desnoyers@efficios.com>

On Mon, Nov 25, 2024 at 09:25:14AM -0500, Mathieu Desnoyers wrote:
> Using scoped_guard() in the implementation of trace_##name() adds an
> unnecessary level of indentation.
> 

> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index b2633a72e871..e398f6e43f61 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -259,8 +259,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	{								\
>  		if (static_branch_unlikely(&__tracepoint_##name.key)) { \
>  			if (cond) {					\
> -				scoped_guard(preempt_notrace)		\
> -					__DO_TRACE_CALL(name, TP_ARGS(args)); \
> +				guard(preempt_notrace)();		\
> +				__DO_TRACE_CALL(name, TP_ARGS(args));	\
>  			}						\
>  		}							\
>  		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> @@ -275,8 +275,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	{								\
>  		might_fault();						\
>  		if (static_branch_unlikely(&__tracepoint_##name.key)) {	\
> -			scoped_guard(rcu_tasks_trace)			\
> -				__DO_TRACE_CALL(name, TP_ARGS(args));	\
> +			guard(rcu_tasks_trace)();			\
> +			__DO_TRACE_CALL(name, TP_ARGS(args));		\
>  		}							\
>  		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
>  			WARN_ONCE(!rcu_is_watching(),			\

Yeah, that also works.

