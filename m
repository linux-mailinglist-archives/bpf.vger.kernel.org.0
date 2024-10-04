Return-Path: <bpf+bounces-40889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A998FB70
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45511C2250A
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F201FAA;
	Fri,  4 Oct 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="da/jEu04"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FE17C9;
	Fri,  4 Oct 2024 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000928; cv=none; b=SC/LcES2cleM8JIXRB8fYhMgzBZrtK4qmcmAC0CXtmrV3+i0lqyhDY9iPKrC764QXaxrCbrJVq1VNosqw6BVbo8/uDMaXHL1EuNqLYURaPlw+1ntk+80IZ+w8QpRuAmbC1EwjHi0SuyxzP88+oUBa1ryjtvpIC6h1YsGpUQkwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000928; c=relaxed/simple;
	bh=3jSFz7c2u+BVuDUzuX2l191wlBdqbFeF6vgLmDNrH1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjcpdPL2PaN+pONXQoMrJ+5Yz5Jnb2bBuNQYDQfWkclikO1TPISlLosLo5EaarhBzKngozHliOgrEpSCdNsXoPO57Ri0HPc9+Amh8Z1DIEH6/IWZfsPlVgufcj1sQDFYpi2OkIw7+CiDe42YZ5cck5U4TkJhtccChKHB8jmpplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=da/jEu04; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728000925;
	bh=3jSFz7c2u+BVuDUzuX2l191wlBdqbFeF6vgLmDNrH1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=da/jEu04AmDI8oXT/Kku/BkuMKxV1VArd+h+ODCI0aAyUBxy30HjUTjUCOebPwOU+
	 JX2acUS2/4ly5/0Fd9cb0/Drwrq8kM8D+/hzkneMo7Ajba7aIyciqZ+UNYXFpRNpuY
	 fBpDAOQt0TJRFYQhDv5+azq6kGWFuzy3WpK/IEL3Eze1TsWVKKsw10BxUzOySCgCg1
	 cOusr6p0qJerYevUK6/h5quPHOgUyTAl1zy4jNgQaC1MG+PnMulYwha5r7zd11Zlek
	 BBMDCHpFbspNp0yl30FaqKu9yBsdbzuLzq2F9eeepj664sMURRoBrF89uuB3TAlT7O
	 1ftXomVfnrwKw==
Received: from [192.168.18.201] (unknown [198.16.233.254])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKTb1118nzBcB;
	Thu,  3 Oct 2024 20:15:25 -0400 (EDT)
Message-ID: <822ba601-700f-4b6a-b300-77423d943410@efficios.com>
Date: Thu, 3 Oct 2024 20:13:24 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] tracing/bpf: Add might_fault check to syscall
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
 Andrii Nakryiko <andrii@kernel.org>, Michael Jeanson <mjeanson@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-9-mathieu.desnoyers@efficios.com>
 <20241003183830.16155ec3@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241003183830.16155ec3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 00:38, Steven Rostedt wrote:
> On Thu,  3 Oct 2024 11:16:38 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Add a might_fault() check to validate that the bpf sys_enter/sys_exit
>> probe callbacks are indeed called from a context where page faults can
>> be handled.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Tested-by: Andrii Nakryiko <andrii@kernel.org> # BPF parts
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
>>   include/trace/bpf_probe.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
>> index 211b98d45fc6..099df5c3e38a 100644
>> --- a/include/trace/bpf_probe.h
>> +++ b/include/trace/bpf_probe.h
>> @@ -57,6 +57,7 @@ __bpf_trace_##call(void *__data, proto)					\
>>   static notrace void							\
>>   __bpf_trace_##call(void *__data, proto)					\
>>   {									\
>> +	might_fault();							\
> 
> And I think this gets called at places that do not allow faults.

Context matters:

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
>>   	guard(preempt_notrace)();					\
>>   	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
>>   }
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


