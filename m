Return-Path: <bpf+bounces-40890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C091098FB73
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA45B21EC0
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8C1876;
	Fri,  4 Oct 2024 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SVGmsUoB"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00F4D512;
	Fri,  4 Oct 2024 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001049; cv=none; b=egzb3s1DHKBGcmT1n0VWSrhV+OUtE1sRaQ7ZWqtut1DgmevBbJX0NzjS3YipjKVUv8iartH4PDozFe3eTIGzEd5Twz3z52QCs2aHsCGqXcN8O37cILj1ZlnYQidxVBDAWJW5eugXn0Mwe87KkQhgJ2TQK7SbAf8JVicyBaeDx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001049; c=relaxed/simple;
	bh=jmW2HGBbFkE17QqfiLtrCSeJqp5SHid1v0vpQMeMyRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmhEuZztt2ekLRSU9eETqEGys57z6j3VX2xHAyvUD/pPX6qeCVtxhyPd+CSTo/0G+wat+/2HpyxExoOo1xWlQzL4XNhNcKSyHDnvoZ6Hb9nV6V2GsrfP5YWM/AokjwYBO88V+RniMOXrgkWvJvK0O5nAUwcRI9Q+BObWTegxh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SVGmsUoB; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728001046;
	bh=jmW2HGBbFkE17QqfiLtrCSeJqp5SHid1v0vpQMeMyRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SVGmsUoBaJPKqwAbYfRtcjNt6EwoNCPYa40wX5c85IoTO4xit15QX7fPTwISPbk6z
	 8s0XZGHRHpHlZH/F9kga9rKXO0fTYUyvTKbCtAzC4q3Cp5fLuKp4PgiZW/BIM5WfQN
	 q9wKRZzy6rZzTfrLNdrGjMXf9eT+7RfujTejPGlitRxWcWIx7pvhiudcabStjhK6rd
	 skX154L2SlHMyUeGbM2fQsOq8EkHoWsVKOrlQ/mbgIspalNXh2IeV9bjdkQG8LL0bx
	 0/W72vOCsyj5u6R3bF59QFuBD5//TQtmm3eE9yr07jU30E/9Namq1Pywb30vKOprWt
	 nhBxh0YJlNAnw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKTdL4NR6zBcG;
	Thu,  3 Oct 2024 20:17:26 -0400 (EDT)
Message-ID: <ecd8a2fe-22f4-4340-a80b-5bf7ccd74815@efficios.com>
Date: Thu, 3 Oct 2024 20:15:25 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] tracing: Declare system call tracepoints with
 TRACE_EVENT_SYSCALL
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
 <20241003151638.1608537-2-mathieu.desnoyers@efficios.com>
 <20241003173225.7670a4f0@gandalf.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241003173225.7670a4f0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-03 23:32, Steven Rostedt wrote:
> On Thu,  3 Oct 2024 11:16:31 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> @@ -283,8 +290,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   				  "RCU not watching for tracepoint");	\
>>   		}							\
>>   	}								\
>> -	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
>> -			    PARAMS(cond))				\
>> +	static inline void trace_##name##_rcuidle(proto)		\
>> +	{								\
>> +		if (static_key_false(&__tracepoint_##name.key))		\
>> +			__DO_TRACE(name,				\
>> +				TP_ARGS(args),				\
>> +				TP_CONDITION(cond), 1);			\
>> +	}								\
>>   	static inline int						\
>>   	register_trace_##name(void (*probe)(data_proto), void *data)	\
>>   	{								\
> 
> Looking at this part of your change, I realized it's time to nuke the
> rcuidle() variant.
> 
> Feel free to rebase on top of this patch:
> 
>    https://lore.kernel.org/all/20241003173051.6b178bb3@gandalf.local.home/
> 

I will. But you realize that you could have done all this SRCU and
rcuidle nuking on top of my own series rather than pull the rug
under my feet and require me to re-do this series again ?

Grumpily,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


