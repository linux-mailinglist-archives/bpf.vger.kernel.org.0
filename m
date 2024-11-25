Return-Path: <bpf+bounces-45574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F809D87DD
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 15:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245B6165D43
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74B1AF0CB;
	Mon, 25 Nov 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TfkcZDm2"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2214184520;
	Mon, 25 Nov 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544781; cv=none; b=Q9PmlLp4o2r2WlZRkjrdlVoQ7a/63/vmtHubOpwf9dE9KgMcsglMB/XjvWKQjd6vFJ+4ZG7ovvXJDtYBQYfN/vmatAR1HYGuLSjzNwM1szpRQyx+A3J/KsowBdq7Q0+sXou6hG4nBD05B/slH9bTPB+AFS5p95NHQx67zgt9B9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544781; c=relaxed/simple;
	bh=uJpnyCV7RajOpIn54Taq2doO+IaopMIDaGzlTpIgHRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulxpeAAh0749yr5H0R89WS02ubIyfrOWLyz2eiyfk81YwpHqSi8clTscluXNXSNTYT9EHfWJufOgsRFQ7KDbRDrkUfqmyuu/fL7ser7wHvK5DgG56h3vHIZ2W1RNCaNL7Sso4MUHoaoTLKmhc+BmUMrLNu8g88p48tT0a85UKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TfkcZDm2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UB9zyFQDU5SRk8IcB43JiYanjQ7KGWab6mju0XOrIOI=; b=TfkcZDm2N+WD4iuvPRjmxTimE3
	JL/q+C8yGH5uJY7kE6I1oY4X2vTYTx3m/WUVEFdIOC6ruKpNuJFOkTV/Kl5jM4+yDpxEBam0tAhjE
	BQzmFH9caaf7DFEI9WwxuLrI4tLwFLupNDtIkv2zlI1S97ZS6LXwxoR8xOOLPu/jM+Jfs1KVPg1Wa
	Tvw/YCZLGmfXJM/JS1m+HUmFPw6B9Dr5ycvcndgEOLGDVF148nVSr2+cPuejeTtlsp9/hOGBQPdtI
	SN8MAlkq+gl8mH9y7uVFHbpgeelZS9O7kcx+pVxZ6Zpa1i6MAuS7QBCIWhYXZQN1eVUm8eat0x6u7
	PKlFzsNg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFa2Q-000000016A5-35bv;
	Mon, 25 Nov 2024 14:26:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F52D30026A; Mon, 25 Nov 2024 15:26:06 +0100 (CET)
Date: Mon, 25 Nov 2024 15:26:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from
 __DO_TRACE()
Message-ID: <20241125142606.GG38837@noisy.programming.kicks-ass.net>
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
 <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com>

On Mon, Nov 25, 2024 at 09:18:18AM -0500, Mathieu Desnoyers wrote:
> On 2024-11-23 12:38, Linus Torvalds wrote:

> I tried the following alteration to the code, which triggers an
> unexpected compiler warning on master, but not on v6.12. I suspect
> this is something worth discussing:
> 
>         static inline void trace_##name(proto)                          \
>         {                                                               \
>                 if (static_branch_unlikely(&__tracepoint_##name.key)) { \
>                         if (cond)                                       \
>                                 scoped_guard(preempt_notrace)           \
>                                         __DO_TRACE_CALL(name, TP_ARGS(args)); \

So coding style would like braces here for it being multi-line. As
opposed to C that only mandates it for multi-statement. And then the
problem doesn't occur.

>                 }                                                       \
>                 if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
>                         WARN_ONCE(!rcu_is_watching(),                   \
>                                   "RCU not watching for tracepoint");   \
>                 }                                                       \
>         }
> 

> I suspect this is caused by the "else" at the end of the __scoped_guard() macro:
> 
> #define __scoped_guard(_name, _label, args...)                          \
>         for (CLASS(_name, scope)(args);                                 \
>              __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);       \
>              ({ goto _label; }))                                        \
>                 if (0) {                                                \
> _label:                                                                 \
>                         break;                                          \
>                 } else
> 
> #define scoped_guard(_name, args...)    \
>         __scoped_guard(_name, __UNIQUE_ID(label), args)
> 
> AFAIU this is a new warning introduced by
> 
> commit fcc22ac5baf ("cleanup: Adjust scoped_guard() macros to avoid potential warning")

Yeah,.. So strictly speaking the code is fine, but the various compilers
don't like it when that else dangles :/

