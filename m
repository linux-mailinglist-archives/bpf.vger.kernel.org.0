Return-Path: <bpf+bounces-41308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773C995B91
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF71F256CD
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329121790B;
	Tue,  8 Oct 2024 23:21:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC7213ECE;
	Tue,  8 Oct 2024 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429674; cv=none; b=EVnijG0Da/7aCGEyi4WvdqFj23ricPgWVtFZEyKOA5/2voZUIac4xERIPgjbsJkjFiv2kLLzCsoZUPnLlS2C5tGFL8mLvTp/dl7+fmN1hl5H7sw0BcNV+EV5HiWAxEDyJtlg4JuV1gny+KB3PZiiZTxLFFLJBj/hbr7NfhyuxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429674; c=relaxed/simple;
	bh=ARoI2IPOpeQHRuQSJjkYsQ+9lpdI/AcID6hBuFtn2t0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zrlk3tR7DGkyvHPpbfZSc9OB9kAe+F4SZ9Vm4JHxmTuUUZNr4rUcDYT1xpNbI+ww4EWDsnyf+Gd37odzOqKjx4Clol4LDHDE0GPHDerjymkNx96zYmNcKPrizO2JjLB8lOLwbGNai6/YNooHaZRC8EKJ+M8lj559K71hdzO2K4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9BEC4CEC7;
	Tue,  8 Oct 2024 23:21:11 +0000 (UTC)
Date: Tue, 8 Oct 2024 19:21:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v3 3/8] tracing/perf: guard syscall probe with
 preempt_notrace
Message-ID: <20241008192115.72cabba4@gandalf.local.home>
In-Reply-To: <20241004145818.1726671-4-mathieu.desnoyers@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
	<20241004145818.1726671-4-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 10:58:13 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

>  #undef DECLARE_EVENT_SYSCALL_CLASS
> -#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
> +#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print) \
> +__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> +		      PARAMS(assign), PARAMS(print))			\
> +static notrace void							\
> +perf_trace_##call(void *__data, proto)					\
> +{									\
> +	u64 __count __attribute__((unused));				\
> +	struct task_struct *__task __attribute__((unused));		\
> +									\
> +	guard(preempt_notrace)();					\
> +	do_perf_trace_##call(__data, args);				\
> +}
>  

Same here. The new guard() interface is really nice for complex functions,
but looks a bit overkill to cover a single line.

-- Steve

