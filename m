Return-Path: <bpf+bounces-43321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D99B39EB
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5EC1F22B5A
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC4F1DFD9E;
	Mon, 28 Oct 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="D5FXZdoQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2618B03;
	Mon, 28 Oct 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142250; cv=none; b=vCjamLZPNu4wS0jO0Nr/Bi+vPFQfmroyl3Txznaaw54bdQ8aUhwI+XOFFgJxcNoFBX0VzoHar4qhUEPx65Oe4lWcSjRp+pBz0FfqSRdqmXBcLdoMK8Uy8FlBxoH0Z+DXngDjVfZo0etQ2iXJ2HzC1uTogiLRl9AwygMfJCLG+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142250; c=relaxed/simple;
	bh=q5Q8IBgjedCRqgzwvX4hN/KkdoiKiEG3yT0aFX2BRBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDh2RZgl4MWcb2KAFQUQL1B7pUuJIA0w9Z1KRAkpZET0BKN87qI7JcjfbsKUvQAKdiDUTTqj6f/KOp8fnbJz1FH+28PUFjz0YFCtZKdoqkyNfmG0WnI0c7Ei8wltp+HRjJLkxs92yHnEkM34ECud5qvwsIqAL078taslTY1FYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=D5FXZdoQ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730142246;
	bh=q5Q8IBgjedCRqgzwvX4hN/KkdoiKiEG3yT0aFX2BRBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D5FXZdoQPL0GLbRlSBPe9CplLr1NiUjEay9oOZjdKwilIPXIJm00d3SAmBhIy4BB+
	 J0/6++mk0r7mUZ2XI92aau7QCxGbPjbazBaVLB4qB13HYTtbzUYaHtCIkEcqqMzWr9
	 AIVpnknOtLBq5flTl2IvNhCLVs/mbuOSVeO+sNj6y1TQGjmwQzQk3YcnpEb7KEyOUZ
	 A4I5MfA6qqflxtLGo3wRw7T3TmHg7AZZgnrkyj8GrDhBfKM+lUXXg6xcJsYEJG6dn1
	 HwFPeYvWwQcyKUmBAmCftGhLv1rc0Pme/v5TBCBsyKifQRJI7qparCgSJ5JakECtSF
	 O9MsXgAU1HG7A==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcjVG0k1XzrvQ;
	Mon, 28 Oct 2024 15:04:06 -0400 (EDT)
Message-ID: <f6caee5c-9d4d-449c-b697-a0a27993bd33@efficios.com>
Date: Mon, 28 Oct 2024 15:02:26 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend 6/8] tracing/ftrace: Add might_fault check to
 syscall probes
To: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
 <20240930192357.1154417-7-mathieu.desnoyers@efficios.com>
 <87cyjk2kgg.ffs@tglx>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87cyjk2kgg.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-28 13:42, Thomas Gleixner wrote:
> On Mon, Sep 30 2024 at 15:23, Mathieu Desnoyers wrote:
>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
>> index a3d8ac00793e..0430890cbb42 100644
>> --- a/kernel/trace/trace_syscalls.c
>> +++ b/kernel/trace/trace_syscalls.c
>> @@ -303,6 +303,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>>   	 * Syscall probe called with preemption enabled, but the ring
>>   	 * buffer and per-cpu data require preemption to be disabled.
>>   	 */
>> +	might_fault();
>>   	guard(preempt_notrace)();
> 
> I find it odd that the might_fault() check is in all the implementations
> and not in the tracepoint itself:
> 
>      if (syscall) {
>          might_fault();
>   	rcu_read_unlock_trace();
>     } else ...
> 
> That's where I would have expected it to be.

You raise a good point: we should also add a might_fault() check in
__DO_TRACE() in the syscall case, so we can catch incorrect use of the
syscall tracepoint even if no probes are registered to it.

I've added the might_fault() in each tracer syscall probe to make sure
a tracer don't end up registering a faultable probe on a tracepoint
protected with preempt_disable by mistake. It validates that the tracers
are using the tracepoint registration as expected.

I'll prepare separate a patch adding this and will add it to this
series.

Thanks,

Mathieu

> 
> Thanks,
> 
>          tglx

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


