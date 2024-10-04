Return-Path: <bpf+bounces-40888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187498FB6E
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B001F239E3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA817C9;
	Fri,  4 Oct 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eBqIM/6o"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A424819;
	Fri,  4 Oct 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000855; cv=none; b=A8vEgL32p73Iq8tkdJiAy/OapUA9ZXEkP1AztSO5N2pbu2iXK/3/NxQu8MR1bOXhpNCepy5Wf+nDMheSvBrB51SIEtK0Yn2RkCKRXslhRdDl64EG4Izhgj/h27kCwm18ZtCFFAGOrDwMCjoD2jozGLGrw1ZptPerZ/zwb8DYQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000855; c=relaxed/simple;
	bh=UXhaRbYOaMta91c7QQfV1y9wIFiLHZ+klZnMfVmCt4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxLTc7DzaIMWAnq8zAYm4cbMbyAK+bt5CCSbvOJcOdu/rdLVi86l49hNHOaaTkaPoXxfzMHTXExI6mamSjjJFvlHr+VljFQQZZVU+Nj2OGlyG6in28KI3uXu09/aaeNtd6PLWypMVSz9oLIWU5ZAHH8O7WBkSXYtbRFBuoSQs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=eBqIM/6o; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728000853;
	bh=UXhaRbYOaMta91c7QQfV1y9wIFiLHZ+klZnMfVmCt4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eBqIM/6o3YuPyT4zu2URGxz34NtiiqQuv2FpiKJRTxvYwm0Ocl7zzdFMEsTf4F8ZV
	 VN+PYCTto8bshdhu/7eG7e/8xd1Or88jm7rmpCnzGpKmHg/p8BDXn+Oj6M7imFtdN6
	 KdkK+sWa6+YDjfRVvHxkBCxPHRz67C408dhGd4SW+lj02Rct3ScpYhmMGvGsGp2EcT
	 t7oVUuVjQm73u0OSi4LbStToUaozr8/e7WC85JQVYT3c/RIUl5Wcsh3xb4b6zddH8e
	 KJgwdtQ4MmxSfy62SURgkR6E3B5dK5w2MHHSjuweuZh5KZgirWmxUENyJq5+zCVPH/
	 enwIedRJh3aUQ==
Received: from [192.168.18.201] (unknown [198.16.233.254])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKTYc6nmCzBPT;
	Thu,  3 Oct 2024 20:14:12 -0400 (EDT)
Message-ID: <ee40d010-db33-476b-8af5-3cd41d2cc5f0@efficios.com>
Date: Thu, 3 Oct 2024 20:12:12 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] tracing/perf: Add might_fault check to syscall
 probes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-8-mathieu.desnoyers@efficios.com>
 <20241003183738.4ebd97f9@gandalf.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241003183738.4ebd97f9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 00:37, Steven Rostedt wrote:
> On Thu,  3 Oct 2024 11:16:37 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Add a might_fault() check to validate that the perf sys_enter/sys_exit
>> probe callbacks are indeed called from a context where page faults can
>> be handled.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Michael Jeanson <mjeanson@efficios.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Yonghong Song <yhs@fb.com>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Cc: bpf@vger.kernel.org
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> ---
>>   include/trace/perf.h          | 1 +
>>   kernel/trace/trace_syscalls.c | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/include/trace/perf.h b/include/trace/perf.h
>> index 5650c1bad088..321bfd7919f6 100644
>> --- a/include/trace/perf.h
>> +++ b/include/trace/perf.h
>> @@ -84,6 +84,7 @@ perf_trace_##call(void *__data, proto)					\
>>   	u64 __count __attribute__((unused));				\
>>   	struct task_struct *__task __attribute__((unused));		\
>>   									\
>> +	might_fault();							\
>>   	guard(preempt_notrace)();					\
>>   	do_perf_trace_##call(__data, args);				\
> 
> Same for this. This is used for all tracepoints that perf hooks to.

You're also missing the context:

#undef DECLARE_EVENT_SYSCALL_CLASS
#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print) \
__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
                       PARAMS(assign), PARAMS(print))                    \
static notrace void                                                     \
perf_trace_##call(void *__data, proto)                                  \
{                                                                       \
         u64 __count __attribute__((unused));                            \
         struct task_struct *__task __attribute__((unused));             \
                                                                         \
         might_fault();                                                  \
         guard(preempt_notrace)();                                       \
         do_perf_trace_##call(__data, args);                             \
}

Not an issue.

Thanks,

Mathieu


> 
> -- Steve
> 
>>   }
>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
>> index 89d7e4c57b5b..0d42d6f293d6 100644
>> --- a/kernel/trace/trace_syscalls.c
>> +++ b/kernel/trace/trace_syscalls.c
>> @@ -602,6 +602,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>>   	 * Syscall probe called with preemption enabled, but the ring
>>   	 * buffer and per-cpu data require preemption to be disabled.
>>   	 */
>> +	might_fault();
>>   	guard(preempt_notrace)();
>>   
>>   	syscall_nr = trace_get_syscall_nr(current, regs);
>> @@ -710,6 +711,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
>>   	 * Syscall probe called with preemption enabled, but the ring
>>   	 * buffer and per-cpu data require preemption to be disabled.
>>   	 */
>> +	might_fault();
>>   	guard(preempt_notrace)();
>>   
>>   	syscall_nr = trace_get_syscall_nr(current, regs);
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


