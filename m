Return-Path: <bpf+bounces-43332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD59B3AE6
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D93B20389
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279481DFDA6;
	Mon, 28 Oct 2024 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GX3DRS2y"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895511DF97C;
	Mon, 28 Oct 2024 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145588; cv=none; b=l5JeZIyGNdgKbNRbBEZuaTWyIJ0DyuBNPrsJvyTcY+Aazw0lD+sQ5mx1rPqG/r0XBCnsN7mhjGx6vgbNW8SWJZyKUxnRya377rB3s9E1Kw7vOzjAuvca7H87Ns8bYbhySO4m1HQUu2irh/DGcvzHSvdOlW0SZnE6FtY5nTJXHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145588; c=relaxed/simple;
	bh=lIEvAnoQaQ0IDqgug4/zfMMO0xb0rzhSucAQ+l+pJqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qW2qwBwdTxEVVmPMIbHTrWj+FYloUVHneCS5jkYoZR5W81HWplhbAdi2pM466xkpWUuDH54kBcfssnp7FXz8z87hfe1jI2xbjTLOz6cXd8R68gn3VYy1yX8JZI2IPZJO2RIeq/8vnEdbQd5jB+MZWNEtrFuoA8euReG+JKFMgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=GX3DRS2y; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730145585;
	bh=lIEvAnoQaQ0IDqgug4/zfMMO0xb0rzhSucAQ+l+pJqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GX3DRS2yMWT6J3vviUgj0mrvmwUUXByVklnuTE/yD8r12X4DgpiTgjmXccTb3MFDY
	 YausOVESED6NMzHkNLZDcD0EcGVIT0gnBLAgNYpmvTRKLJAW0K6Luzoatdc8JHD1/n
	 3Sf91TRrpQBMHTqs8Odi2z8bxnus+SUEapVoN8DywREfQpD+bvdUTGkIPYzEq1FpBt
	 Sd9x1eIeqTUoARfvu0x2DIHggXXLnAfJfonHqgu3WqUSaa6tQw6eTlFCtQ1e9BrXl+
	 nNpDlzwfc4CwercvSnq030fcMclw6DdCf7Blm8FMqQcyu4QLZS43DS1pDUSii0jzRT
	 L5m0RHuvVJUFw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XckkT1vgQzsRs;
	Mon, 28 Oct 2024 15:59:45 -0400 (EDT)
Message-ID: <e18e953b-9030-487c-bb8a-125521568e9e@efficios.com>
Date: Mon, 28 Oct 2024 15:58:06 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
 <20241028190927.648953-5-mathieu.desnoyers@efficios.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241028190927.648953-5-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-28 15:09, Mathieu Desnoyers wrote:
> Catch incorrect use of syscall tracepoints even if no probes are
> registered by adding a might_fault() check in __DO_TRACE() when
> syscall=1.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Jordan Rife <jrife@google.com>
> ---
>   include/linux/tracepoint.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 259f0ab4ece6..7bed499b7055 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -226,10 +226,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>   		if (!(cond))						\
>   			return;						\
>   									\
> -		if (syscall)						\
> +		if (syscall) {						\
>   			rcu_read_lock_trace();				\
> -		else							\
> +			might_fault();					\

Actually, __DO_TRACE() is not the best place to put this, because it's
only executed when the tracepoint is enabled.

I'll move this to __DECLARE_TRACE_SYSCALL()

#define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)    \
         __DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
         static inline void trace_##name(proto)                          \
         {                                                               \
                 might_fault();                                          \
                 if (static_branch_unlikely(&__tracepoint_##name.key))   \
                         __DO_TRACE(name,                                \
                                 TP_ARGS(args),                          \
                                 TP_CONDITION(cond), 1);                 \
[...]

instead in v5.

Thanks,

Mathieu

> +		} else {						\
>   			preempt_disable_notrace();			\
> +		}							\
>   									\
>   		__DO_TRACE_CALL(name, TP_ARGS(args));			\
>   									\

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


