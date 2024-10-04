Return-Path: <bpf+bounces-40894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A9B98FB96
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A797F1C220FF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D262CAB;
	Fri,  4 Oct 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ejep0vLv"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690117C9;
	Fri,  4 Oct 2024 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002226; cv=none; b=DBDVT6SrXUY8/A6noub/4z2RQ/Iu2id/zARRXZ6qswFtzo6rOyfB8PO2HYMGo0ICN9JMGJBPH6HWkEAYTDCIcBehGusMbV/Cw/gSk+IxpFrLPMT5ei+dmT3mJg5XzsC5w5W5gHffo7arx/fv6H85ErygcvBzUfiYrPhGrdHhGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002226; c=relaxed/simple;
	bh=b+T0GavuEgonWkN9KQGnzy0sD6wxRSye5VsSYv2S4Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqwuVkzPDf6AQfeUovYIyU8V12faVdfYu9ocpzQXOVGp5KvQvy3tJKc7EHuHdQQD/fsnw6L/wN/sQDKkSbEITQX9Fzbk8x6I5SoL0W+AbxZiC4m1l4APr6fcooKP0pV3h6HaPMjMTRijb29b5rFIqhn4xVUSt6aHME/qO/hxnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ejep0vLv; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728002224;
	bh=b+T0GavuEgonWkN9KQGnzy0sD6wxRSye5VsSYv2S4Uk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ejep0vLvMlpJqsbdHbFAxrycztrGOJGuCIpviKKc9K5c2OWby6ClttRE8jYxbNug5
	 gtZuPtAhgI6BQtD/dPhmX6xKioYDitWb8D9lHaNMmVJW4WGIGRTIpmhTytttZgXjbX
	 Rmg3viZ0JycfWqCh4inj71Xg6rvSY4ZyG3J7uGv6wKIJun4fM/Cqc7Aj7RcJchryFm
	 OK+OkPXplhhqefc7UPqTbRt/oix7JAAFd9GAmI5DsUwPLl9PAlyjEM/Sihn0fGuMef
	 ircm3yr2zbKr4z5QYBUm7MhBcw6e8eLTed0Nn1zyUlnhGYswZrg9NiLMedsoBI1KtA
	 Pof1u8lsYHpcg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKV400vzGzB6y;
	Thu,  3 Oct 2024 20:37:04 -0400 (EDT)
Message-ID: <eacb18fc-7066-40f3-9d83-4602e946c225@efficios.com>
Date: Thu, 3 Oct 2024 20:35:03 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/8] tracing: Allow system call tracepoints to handle
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
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-6-mathieu.desnoyers@efficios.com>
 <20241003182934.0a027919@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241003182934.0a027919@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 00:29, Steven Rostedt wrote:
> On Thu,  3 Oct 2024 11:16:35 -0400
[...[
>> -#define __DO_TRACE(name, args, cond, rcuidle)				\
>> +#define __DO_TRACE(name, args, cond, rcuidle, syscall)			\
>>   	do {								\
>>   		int __maybe_unused __idx = 0;				\
>>   									\
>> @@ -222,8 +224,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   			      "Bad RCU usage for tracepoint"))		\
>>   			return;						\
>>   									\
>> -		/* keep srcu and sched-rcu usage consistent */		\
>> -		preempt_disable_notrace();				\
>> +		if (syscall) {						\
>> +			rcu_read_lock_trace();				\
>> +		} else {						\
>> +			/* keep srcu and sched-rcu usage consistent */	\
>> +			preempt_disable_notrace();			\
>> +		}							\
>>   									\
> 
> I'm thinking we just use rcu_read_lock_trace() and get rid of the
> preempt_disable and srcu locks for all tracepoints. Oh crap! I should get
> rid of srcu locking too, as it was only needed for the rcuidle code :-p

How about we do it one step at a time ? First introduce use of the
(lightly tested) rcu_read_lock_trace() (at least in comparison with
preempt disable RCU) only for syscalls, and if this works well,
then eventually consider moving the preempt off users to
rcu_read_lock_trace as well ?

Of course it should all work well, in theory. But considering the
vast number of tracepoints we have in the kernel, I am reluctant
to change too many things at once in that area. We may very well
be bitten by unforeseen corner-cases.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


