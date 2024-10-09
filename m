Return-Path: <bpf+bounces-41319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E47995C98
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC541F249FB
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 00:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8C1CD2B;
	Wed,  9 Oct 2024 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="er78mva5"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C418C31;
	Wed,  9 Oct 2024 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435531; cv=none; b=M7CaheHNIFfKSgGj8CQF/erL6gFQhXWzpBHSMcwxPKOM5+qhrjS54QjvAfAIs0yXkWfIHAY8JqZiDRCQn5ns1Gk7C2RPIFnxBDm7SuNj1qIUkQ1R7Yttlhpi0UraJgLSd5x+pHC4dioFRtDIgWpe7awduzgDvDJDkYioTjRZ4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435531; c=relaxed/simple;
	bh=94+ST9p9ZEZx/gYVfmyH38elST3i1/AeA9RBXiRn/eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdv43cjn4PHwODWFpIDgTvpbr8cHJW4X2GW+9htvLYWyeM7XEGppzoYwpUEid+/OQlUY5+gZRgTm1S+ZoGIOlgCN/4MWXqy7kvTpPCF8uA5Ixd24wcvdVPL2Hk/4449USUsue/kjA71JZFLCxrOPxy+Uf9xWberr6bQU/h9rZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=er78mva5; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728435528;
	bh=94+ST9p9ZEZx/gYVfmyH38elST3i1/AeA9RBXiRn/eg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=er78mva5H84qSS+DrO+FFLZNhR6jQFx4KMWPz9soeRQZ1fLAEPm6MEUMEC4Ze/SGF
	 wUVzFJH+Xw0XxOABG7guUjARHKUWLG8MxK0tMC+WpG8Y0aZiZFSnFu3UWTSGU1uaJW
	 +ZwIsefYapDwzZjExa2ES9TDmJxWarAQBZdMM+eZ8xCWQ9juQ4+tRicjkab0ztNnQz
	 i8tg5mzqU7dlpLVuuLWEoWGLpHtUuZz+f2JEMVIFrTtSxHq+i+8aNg0dQ800EuZKJq
	 syMSJNpfB2Ul/I0lRhXff9vmXs3TT5mWlcecYo3XGHCkVIBr5Y1P2H2zZ5NKKham3b
	 G6cVapbPHUnqQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNZJm1FWfzSRw;
	Tue,  8 Oct 2024 20:58:48 -0400 (EDT)
Message-ID: <74d621a3-5b82-4831-a875-7c04e56dec7b@efficios.com>
Date: Tue, 8 Oct 2024 20:56:51 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] tracing: Allow system call tracepoints to handle
 page faults
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
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
 <20241004145818.1726671-6-mathieu.desnoyers@efficios.com>
 <20241008192334.54180520@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241008192334.54180520@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-09 01:23, Steven Rostedt wrote:
> On Fri,  4 Oct 2024 10:58:15 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Use Tasks Trace RCU to protect iteration of system call enter/exit
>> tracepoint probes to allow those probes to handle page faults.
>>
>> In preparation for this change, all tracers registering to system call
>> enter/exit tracepoints should expect those to be called with preemption
>> enabled.
>>
>> This allows tracers to fault-in userspace system call arguments such as
>> path strings within their probe callbacks.
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
>>   include/linux/tracepoint.h | 12 ++++++++++--
>>   init/Kconfig               |  1 +
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>> index 014790495ad8..cefd44b7c91f 100644
>> --- a/include/linux/tracepoint.h
>> +++ b/include/linux/tracepoint.h
>> @@ -17,6 +17,7 @@
>>   #include <linux/errno.h>
>>   #include <linux/types.h>
>>   #include <linux/rcupdate.h>
>> +#include <linux/rcupdate_trace.h>
>>   #include <linux/tracepoint-defs.h>
>>   #include <linux/static_call.h>
>>   
>> @@ -107,6 +108,7 @@ void for_each_tracepoint_in_module(struct module *mod,
>>   #ifdef CONFIG_TRACEPOINTS
>>   static inline void tracepoint_synchronize_unregister(void)
>>   {
>> +	synchronize_rcu_tasks_trace();
>>   	synchronize_rcu();
>>   }
>>   #else
>> @@ -204,11 +206,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   		if (!(cond))						\
>>   			return;						\
>>   									\
>> -		preempt_disable_notrace();				\
> 
> Should add a comment somewhere stating that the syscall version is to allow faults.

I plan to add this comment on top of __TO_TRACE:

+ *
+ * With @syscall=0, the tracepoint callback array dereference is
+ * protected by disabling preemption.
+ * With @syscall=1, the tracepoint callback array dereference is
+ * protected by Tasks Trace RCU, which allows probes to handle page
+ * faults.

Thanks,

Mathieu


> 
> -- Steve
> 
>> +		if (syscall)						\
>> +			rcu_read_lock_trace();				\
>> +		else							\
>> +			preempt_disable_notrace();			\
>>   									\
>>   		__DO_TRACE_CALL(name, TP_ARGS(args));			\
>>   									\
>> -		preempt_enable_notrace();				\
>> +		if (syscall)						\
>> +			rcu_read_unlock_trace();			\
>> +		else							\
>> +			preempt_enable_notrace();			\
>>   	} while (0)
>>   
>>   /*
>> diff --git a/init/Kconfig b/init/Kconfig
>> index fbd0cb06a50a..eedd0064fb36 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1984,6 +1984,7 @@ config BINDGEN_VERSION_TEXT
>>   #
>>   config TRACEPOINTS
>>   	bool
>> +	select TASKS_TRACE_RCU
>>   
>>   source "kernel/Kconfig.kexec"
>>   
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


