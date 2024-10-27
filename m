Return-Path: <bpf+bounces-43257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9849B1DAF
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 13:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD6B1C20A57
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4EB1428E0;
	Sun, 27 Oct 2024 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uyzf40vf"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306B1EA91;
	Sun, 27 Oct 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730032367; cv=none; b=YiIv8Mx9Hny1fDxRbCbVXg54KTCtdmVBt8HvqWBCdxi0poxoZ12DWgCxax0KqSz/SStaMVNDRau5itamcRPLR3V+mY8uy6/JlXov1paETmI8EoHXMeKu8ixOxy1Q1cZ8LxqVS1chRkZ7mcI0oNPiHljA3XvWpuLNDJLaS+NBMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730032367; c=relaxed/simple;
	bh=sVmL3dOzJG1VJevmLjQJuw0YzidFod/EcbjojbSJdE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1MmzV2qINLqaMuJZbSaRzXpPWo0pJbs0PscmkyIQ1BwH1lRPA6VHbH5rrvK4iMFaX4uU+tOLvq7Zx7RSY8+Us57oDAcjbvhYJFpaIQN+mFTLfzZdJPrGjqHQcQYQH36a+VBLzLcVVQGVUO7+1O1FNIWRCIcAqhlUrqUF7ZnSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uyzf40vf; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730032355;
	bh=sVmL3dOzJG1VJevmLjQJuw0YzidFod/EcbjojbSJdE0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uyzf40vfmkwMfx+ggbDRs3yzu8bcBmWES2rj9JUgYeZUgCchidqtLMsSfb9zvOpDd
	 dUDqjgHtISIjuFSkatB7cY2xcrHUcTJOhpqrhsQWHDhUW6fD6xIWZrHqAyoc86LNjI
	 MT0BuMrpH6Q1kGKYF3fAqP0GEi42KRbf+B/+xFxP/Xj2zsG7jTxlLYSSMr3ijrEL0N
	 WtVSu4pyMBfFi8FuKBDrTDebl0qcSrKNqZO2E4MsrDqUGf3srLZy3rfHvS9xpTSQzQ
	 zMKK5sMhCih2ZdSpFu/Cv8li8S01RU8XEs2Fov5QBJHLJ8LqYZcGOkKo6U9fxYMlqn
	 NXn6dW0KrQ84A==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xbwrz1J5qzZgH;
	Sun, 27 Oct 2024 08:32:35 -0400 (EDT)
Message-ID: <933ab148-2a28-4912-9bca-150a0643eecd@efficios.com>
Date: Sun, 27 Oct 2024 08:30:54 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/3] tracing: Introduce tracepoint_is_syscall()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
 <20241026154629.593041-2-mathieu.desnoyers@efficios.com>
 <20241026200840.17171eb2@rorschach.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241026200840.17171eb2@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-26 20:08, Steven Rostedt wrote:
> On Sat, 26 Oct 2024 11:46:28 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Introduce a "syscall" flag within the extended structure to know whether
>> a tracepoint needs rcu tasks trace grace period before reclaim.
>> This can be queried using tracepoint_is_syscall().
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
>> Cc: Jordan Rife <jrife@google.com>
>> ---
>>   include/linux/tracepoint-defs.h |  2 ++
>>   include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
>>   include/trace/define_trace.h    |  2 +-
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
>> index 967c08d9da84..53119e074c87 100644
>> --- a/include/linux/tracepoint-defs.h
>> +++ b/include/linux/tracepoint-defs.h
>> @@ -32,6 +32,8 @@ struct tracepoint_func {
>>   struct tracepoint_ext {
>>   	int (*regfunc)(void);
>>   	void (*unregfunc)(void);
>> +	/* Flags. */
>> +	unsigned int syscall:1;
> 
> I wonder if we should call it "sleepable" instead? For this patch set
> do we really care if it's a system call or not? It's really if the
> tracepoint is sleepable or not that's the issue. System calls are just
> one user of it, there may be more in the future, and the changes to BPF
> will still be needed.

Remember that syscall tracepoint probes are allowed to handle page
faults, but should not generally block, otherwise it would postpone the
grace periods of all RCU tasks trace users.

So naming this "sleepable" would be misleading, because probes are
not allowed general blocking, just to handle page faults.

If we look at the history of this tracepoint feature, we went with
the following naming over the various versions of the patch series:

1) Sleepable tracepoints: until we understood that we just want to
    allow page fault, not general sleeping, so we needed to change
    the name,

2) Faultable tracepoints: until Linus requested that we aim for
    something that is specific to system calls, rather than a generic
    thing.

    https://lore.kernel.org/lkml/CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com/

3) Syscall tracepoints: This is what we currently have.

> Other than that, I think this could work.

Calling this field "sleepable" would be misleading. Calling it "faultable"
would be a better fit, but based on Linus' request, I'm tempted to stick
with "syscall" for now.

Your concern is to name this in a way that is general and future-proof.
Linus' point was to make it syscall-specific rather than general. My
position is that we should wait until we face other use-cases (if we
even do) before consider changing the naming from "syscall" to something
more generic.

Thanks,

Mathieu

> 
> -- Steve
> 
> 
>>   };
>>   
>>   struct tracepoint {
>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>> index 83dc24ee8b13..93e70bc64533 100644
>> --- a/include/linux/tracepoint.h
>> +++ b/include/linux/tracepoint.h
>> @@ -104,6 +104,12 @@ void for_each_tracepoint_in_module(struct module *mod,
>>    * tracepoint_synchronize_unregister must be called between the last tracepoint
>>    * probe unregistration and the end of module exit to make sure there is no
>>    * caller executing a probe when it is freed.
>> + *
>> + * An alternative is to use the following for batch reclaim associated
>> + * with a given tracepoint:
>> + *
>> + * - tracepoint_is_syscall() == false: call_rcu()
>> + * - tracepoint_is_syscall() == true:  call_rcu_tasks_trace()
>>    */
>>   #ifdef CONFIG_TRACEPOINTS
>>   static inline void tracepoint_synchronize_unregister(void)
>> @@ -111,9 +117,17 @@ static inline void tracepoint_synchronize_unregister(void)
>>   	synchronize_rcu_tasks_trace();
>>   	synchronize_rcu();
>>   }
>> +static inline bool tracepoint_is_syscall(struct tracepoint *tp)
>> +{
>> +	return tp->ext && tp->ext->syscall;
>> +}
>>   #else
>>   static inline void tracepoint_synchronize_unregister(void)
>>   { }
>> +static inline bool tracepoint_is_syscall(struct tracepoint *tp)
>> +{
>> +	return false;
>> +}
>>   #endif
>>   
>>   #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
>> @@ -345,6 +359,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   	struct tracepoint_ext __tracepoint_ext_##_name = {		\
>>   		.regfunc = _reg,					\
>>   		.unregfunc = _unreg,					\
>> +		.syscall = false,					\
>> +	};								\
>> +	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
>> +
>> +#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)	\
>> +	struct tracepoint_ext __tracepoint_ext_##_name = {		\
>> +		.regfunc = _reg,					\
>> +		.unregfunc = _unreg,					\
>> +		.syscall = true,					\
>>   	};								\
>>   	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
>>   
>> @@ -389,6 +412,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   #define __DECLARE_TRACE_SYSCALL	__DECLARE_TRACE
>>   
>>   #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
>> +#define DEFINE_TRACE_SYSCALL(name, reg, unreg, proto, args)
>>   #define DEFINE_TRACE(name, proto, args)
>>   #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
>>   #define EXPORT_TRACEPOINT_SYMBOL(name)
>> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
>> index ff5fa17a6259..63fea2218afa 100644
>> --- a/include/trace/define_trace.h
>> +++ b/include/trace/define_trace.h
>> @@ -48,7 +48,7 @@
>>   
>>   #undef TRACE_EVENT_SYSCALL
>>   #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign, print, reg, unreg) \
>> -	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
>> +	DEFINE_TRACE_SYSCALL(name, reg, unreg, PARAMS(proto), PARAMS(args))
>>   
>>   #undef TRACE_EVENT_NOP
>>   #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


