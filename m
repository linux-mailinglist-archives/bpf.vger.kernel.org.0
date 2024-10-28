Return-Path: <bpf+bounces-43316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C69B381C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71ABB1F22E9C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC811DFE11;
	Mon, 28 Oct 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1R2qiggT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4MFMQ9x"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D7186616;
	Mon, 28 Oct 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137332; cv=none; b=dUU+2k+z2dpa/c2gwcXXEW80tzD9DrkTth6zhW14LMHYeMK40qawMT3bRje2EbZWWsse6gtrngpOcNeJEreq6/ft6opFTe9vjW4zl6Zp/rUIZV7LDJoJZOyCqJ6asYqnr8xLNavIK1ZhOk/XEU/ZXLyGErqwzqVmQOp6/4FWdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137332; c=relaxed/simple;
	bh=glA+JPEaVGO1hKacPJYq1E1o3qO3vOwzBRB9hb82TiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jjqqUCROs1L8MMrcbtdVjXfnGVaxZI90qMiVksALHlEfM7+BPU9ZbfEPkI0Fr1LFXHGzIwb7vKv4noG77SDfCay5hRmFDdhmna80/6ZcL4GkvKK4Zke4WZXAhuqMEtFzkh8puwaxkCwCIy6lqKOOV0zVxexTD5P8ClMHv2prGE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1R2qiggT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4MFMQ9x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730137328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unQuhEbs1pQABVEQli39gY3dv4aJsDAK0nlho680oQI=;
	b=1R2qiggTXVfaKFhchHKvPVgtEGNihEWZXTxEzeQFQifRhbilap60uS8XezYvl1+/bqM5cQ
	V0iJr95PkY08qYMnLRhMCP+DmxXt+S4e1ewNZyh0uqMZWN8zVeln/jENQf7WQpf/lcI8T+
	tsKCWlT2JfB2ILsqnac1VeHT6GJJTOKEWpJ9DJ57ynFWyfpilLeG0EFzVEhSQ9tcdWD3lS
	v0lcabn0YWthV4zCOgoh9if/L4y4ngpEW+SXjHfWc1Shb8feOyHETW+aBrENIX9hyRIm99
	bexWEzccufHSlMHjM9aqxbjo1mhGwcJy+uLqTXONwsOxd5q4XBpjmSSE0A4ErA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730137328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unQuhEbs1pQABVEQli39gY3dv4aJsDAK0nlho680oQI=;
	b=q4MFMQ9xjj2p0ba0z4lJ3JqipBgQVFpnUV0+h+1olfRvxK59RyYLPHSZFPjp16/8cjzZL8
	pZpKa52t6gdLxlCg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E .
 McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim
 <namhyung@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
 linux-trace-kernel@vger.kernel.org, Michael Jeanson
 <mjeanson@efficios.com>
Subject: Re: [PATCH resend 6/8] tracing/ftrace: Add might_fault check to
 syscall probes
In-Reply-To: <20240930192357.1154417-7-mathieu.desnoyers@efficios.com>
References: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
 <20240930192357.1154417-7-mathieu.desnoyers@efficios.com>
Date: Mon, 28 Oct 2024 18:42:07 +0100
Message-ID: <87cyjk2kgg.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 30 2024 at 15:23, Mathieu Desnoyers wrote:
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index a3d8ac00793e..0430890cbb42 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -303,6 +303,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>  	 * Syscall probe called with preemption enabled, but the ring
>  	 * buffer and per-cpu data require preemption to be disabled.
>  	 */
> +	might_fault();
>  	guard(preempt_notrace)();

I find it odd that the might_fault() check is in all the implementations
and not in the tracepoint itself:

    if (syscall) {
        might_fault();
 	rcu_read_unlock_trace();
   } else ...     

That's where I would have expected it to be.

Thanks,

        tglx

