Return-Path: <bpf+bounces-39324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15B971DA6
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C0D1C22F81
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B91C68F;
	Mon,  9 Sep 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Sc/IMzhX"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC81C683;
	Mon,  9 Sep 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894725; cv=none; b=EOswOc9siYnk1tNLiCagJGH2HNtrJ6nVzVBeecZAycuPn2p7WgHql5eA1JAgOlzr6J/ZPWC/czLZXQ+8X7RgGoAAtSH6qy02ctfoxK0UjX1kK2Sx5/3py1rKngQ8HQtCYerEUpJ23LxF8J+Ad9leWeauEm+nno6qiTMFHPloTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894725; c=relaxed/simple;
	bh=c7YvUH84AlumiDtIrio1hThdvteHMEAg8VTnwNP3vHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xuk+KOp8PeZYwDMxJiSodXy/EBZmP+jpCxwYEdQlalNj+G+X+lHRh75DwzPa9yWHo/IuNx8hu+4dPdNyeUZYHLU3h/vOxElHweNk4yrrXwvOZj+37IzO2JL2jd/U+hi3eEb3fuX7pw9B0R2/ivR1DxRcEOtSnCA4YWic4IGOB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Sc/IMzhX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725894714;
	bh=c7YvUH84AlumiDtIrio1hThdvteHMEAg8VTnwNP3vHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sc/IMzhXLu36YaYhkAE3zpwxZxsmgRydJSMBgXazLABBcFdivkUQcX/Nky1m9Okst
	 2cPsii6n9FN5ymmfrlOZ6FmTdZvBmD9+eReLdo396pjv8WMvPAmkStNH/pNWehd9Gl
	 K7ibQ1yB2kUfmhK1E3d7uphByCYfVooQWr7qmIM9soWZnkOaE/oD6e3CErp6CZFjb2
	 xGffIACes2q1NoEm0Yn9iZCFh70omRIpJpWB1ShoZ4ToC0FkUPnlqRUjamtiqt24c+
	 aC7vWHqojzbsw5uudYx9+/iz/GuvSakBt5tRX5IvUm3fus3SUx38BGoyxuZMo6oQ6g
	 TNRzodG4zDgeg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2Vfx67y3z1KWR;
	Mon,  9 Sep 2024 11:11:53 -0400 (EDT)
Message-ID: <1f442f99-92cd-41d6-8dd2-1f4780f2e556@efficios.com>
Date: Mon, 9 Sep 2024 11:11:39 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] tracing/bpf-trace: Add support for faultable
 tracepoints
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
 <20240828144153.829582-4-mathieu.desnoyers@efficios.com>
 <CAEf4BzZERq7qwf0TWYFaXzE6d+L+Y6UY+ahteikro_eugJGxWw@mail.gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAEf4BzZERq7qwf0TWYFaXzE6d+L+Y6UY+ahteikro_eugJGxWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-04 21:21, Andrii Nakryiko wrote:
> On Wed, Aug 28, 2024 at 7:42 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> In preparation for converting system call enter/exit instrumentation
>> into faultable tracepoints, make sure that bpf can handle registering to
>> such tracepoints by explicitly disabling preemption within the bpf
>> tracepoint probes to respect the current expectations within bpf tracing
>> code.
>>
>> This change does not yet allow bpf to take page faults per se within its
>> probe, but allows its existing probes to connect to faultable
>> tracepoints.
>>
>> Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
>> Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
>> Cc: bpf@vger.kernel.org
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> ---
>> Changes since v4:
>> - Use DEFINE_INACTIVE_GUARD.
>> - Add brackets to multiline 'if' statements.
>> Changes since v5:
>> - Rebased on v6.11-rc5.
>> - Pass the TRACEPOINT_MAY_FAULT flag directly to tracepoint_probe_register_prio_flags.
>> ---
>>   include/trace/bpf_probe.h | 21 ++++++++++++++++-----
>>   kernel/trace/bpf_trace.c  |  2 +-
>>   2 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
>> index a2ea11cc912e..cc96dd1e7c3d 100644
>> --- a/include/trace/bpf_probe.h
>> +++ b/include/trace/bpf_probe.h
>> @@ -42,16 +42,27 @@
>>   /* tracepoints with more than 12 arguments will hit build error */
>>   #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
>>
>> -#define __BPF_DECLARE_TRACE(call, proto, args)                         \
>> +#define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)               \
>>   static notrace void                                                    \
>>   __bpf_trace_##call(void *__data, proto)                                        \
>>   {                                                                      \
>> -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));        \
>> +       DEFINE_INACTIVE_GUARD(preempt_notrace, bpf_trace_guard);        \
>> +                                                                       \
>> +       if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                        \
>> +               might_fault();                                          \
>> +               activate_guard(preempt_notrace, bpf_trace_guard)();     \
>> +       }                                                               \
>> +                                                                       \
>> +       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args)); \
>>   }
>>
>>   #undef DECLARE_EVENT_CLASS
>>   #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
>> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
>> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)
>> +
>> +#undef DECLARE_EVENT_CLASS_MAY_FAULT
>> +#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
>> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), TRACEPOINT_MAY_FAULT)
>>
>>   /*
>>    * This part is compiled out, it is only here as a build time check
>> @@ -105,13 +116,13 @@ static inline void bpf_test_buffer_##call(void)                           \
>>
>>   #undef DECLARE_TRACE
>>   #define DECLARE_TRACE(call, proto, args)                               \
>> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))          \
>> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)       \
>>          __DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
>>
>>   #undef DECLARE_TRACE_WRITABLE
>>   #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
>>          __CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
>> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
>> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0) \
>>          __DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
>>
>>   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index c77eb80cbd7f..ed07283d505b 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2473,7 +2473,7 @@ int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *li
>>
>>          return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
>>                                                      link, TRACEPOINT_DEFAULT_PRIO,
>> -                                                   TRACEPOINT_MAY_EXIST);
>> +                                                   TRACEPOINT_MAY_EXIST | (tp->flags & TRACEPOINT_MAY_FAULT));
>>   }
>>
>>   int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
>> --
>> 2.39.2
>>
>>
> 
> I wonder if it would be better to just do this, instead of that
> preempt guard. I think we don't strictly need preemption to be
> disabled, we just need to stay on the same CPU, just like we do that
> for many other program types.

I'm worried about introducing any kind of subtle synchronization
change in this series, and moving from preempt-off to migrate-disable
definitely falls under that umbrella.

I would recommend auditing all uses of this_cpu_*() APIs to make sure
accesses to per-cpu data structures are using atomics and not just using
operations that expect use of preempt-off to prevent concurrent threads
from updating to the per-cpu data concurrently.

So what you are suggesting may be a good idea, but I prefer to leave
this kind of change to a separate bpf-specific series, and I would
leave this work to someone who knows more about ebpf than me.

Thanks,

Mathieu

> 
> We'll need some more BPF-specific plumbing to fully support faultable
> (sleepable) tracepoints, but this should unblock your work, unless I'm
> missing something. And we can take it from there, once your patches
> land, to take advantage of faultable tracepoints in the BPF ecosystem.
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b69a39316c0c..415639b7c7a4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2302,7 +2302,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link
> *link, u64 *args)
>          struct bpf_run_ctx *old_run_ctx;
>          struct bpf_trace_run_ctx run_ctx;
> 
> -       cant_sleep();
> +       migrate_disable();
> +
>          if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
>                  bpf_prog_inc_misses_counter(prog);
>                  goto out;
> @@ -2318,6 +2319,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link
> *link, u64 *args)
>          bpf_reset_run_ctx(old_run_ctx);
>   out:
>          this_cpu_dec(*(prog->active));
> +
> +       migrate_enable();
>   }

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


