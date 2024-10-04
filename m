Return-Path: <bpf+bounces-40887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2182498FB6C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8B1282770
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D14139E;
	Fri,  4 Oct 2024 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="J1A4bD9R"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103631849;
	Fri,  4 Oct 2024 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000792; cv=none; b=GxMI0Aif3ke4IGA7Oem3/+jlbDGN1UDwr6GV/wMKgcOZZmNvgjbtzuqcMHOGOlC49lV5eEHMpawUR57xs44eF3ixtg7nqTFKfc/9QPuDGxCs2KnEzr6NUGOPkNeTKNLhy8lk/WwYvucmEfKsLFnIBzQQVF69G5NNk3ggg+PxyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000792; c=relaxed/simple;
	bh=Uf2DyIAPcgBpMm6RGTIKd696N0dyton8J3Ol+EHVsp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abgaQ3zPB/ALuRUGNzHu4q4N0elZABvyDuLJ0mDTGbmVsMSbsgc9PUdA+qWOe7gg0Wll/W5CM50qn/iy7EZUzoOeH/qqk1iHgCP22vy2f0XpGYVakr6VoNFjavAEhkhHP6jcveMbB5evQwOtsR0OOp7HuaFkp5eaQJAYWUzpNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=J1A4bD9R; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728000788;
	bh=Uf2DyIAPcgBpMm6RGTIKd696N0dyton8J3Ol+EHVsp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J1A4bD9RdfZCJjWdfHXeAs/sHyhCzm1THQfI5PbXzaWU5J+qwWVy2cP/j63UBgJ0S
	 4s8AiyZaFnmXN0a6XVfQg8gClp7xZDkGv1n8ZAP79o9T2ODHxEBcTi/Mk9NaKb+97D
	 NWNAvl8PM5SStMkwBtEqpimu5oRjJsoE4vrO4mRWRrJPqxb0aH/XHyXSfhrK+4EvEl
	 HdRVZdyeIrLrJzVTFeQgjYogvhKd4Jf+aCpcTzk5oWYKL6/11Wrg1i9yLe4ZbjMqyf
	 JnSXT4nHLdzaeWyG8cZeSAaUqj6Pax6t/71UR9meBny54BVBoWiulwtK9ysTUw935K
	 y6nO4IEAEbzXw==
Received: from [192.168.18.201] (unknown [198.16.233.254])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKTXN3vqDzBPL;
	Thu,  3 Oct 2024 20:13:08 -0400 (EDT)
Message-ID: <a5c1160f-79a4-42ba-97b9-bb7f10ffcb21@efficios.com>
Date: Thu, 3 Oct 2024 20:11:06 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] tracing/ftrace: Add might_fault check to syscall
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
 <20241003151638.1608537-7-mathieu.desnoyers@efficios.com>
 <20241003183649.0290f0d1@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241003183649.0290f0d1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 00:36, Steven Rostedt wrote:
> On Thu,  3 Oct 2024 11:16:36 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
>> index 0228d9ed94a3..e0d4850b0d77 100644
>> --- a/include/trace/trace_events.h
>> +++ b/include/trace/trace_events.h
>> @@ -446,6 +446,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
>>   static notrace void							\
>>   trace_event_raw_event_##call(void *__data, proto)			\
>>   {									\
>> +	might_fault();							\
> 
> I don't think we want "might_fault()" here, as this is called for every
> tracepoint that is created by the TRACE_EVENT() macro. That means, there's
> going to be plenty of locations this gets called at that do not allow faults.

Here is the full context where this line applies:

#undef DECLARE_EVENT_SYSCALL_CLASS
#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print) \
__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
                       PARAMS(assign), PARAMS(print))                    \
static notrace void                                                     \
trace_event_raw_event_##call(void *__data, proto)                       \
{                                                                       \
         might_fault();                                                  \
         guard(preempt_notrace)();                                       \
         do_trace_event_raw_event_##call(__data, args);                  \
}

Not an issue, since it's only for syscall tracepoints.

Thanks,

Mathieu

> 
> -- Steve
> 
> 
>>   	guard(preempt_notrace)();					\
>>   	do_trace_event_raw_event_##call(__data, args);			\
>>   }

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


