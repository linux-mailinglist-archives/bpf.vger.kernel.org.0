Return-Path: <bpf+bounces-15524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60347F3045
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 15:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3602CB21AAF
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D1254F97;
	Tue, 21 Nov 2023 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="thxzknEY"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0D2D79;
	Tue, 21 Nov 2023 06:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700575556;
	bh=Rjo+GzhBLOQg08qfzJaOOas6LcnZO+kRHO1x7xhCg5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=thxzknEYOsX54Uxq75EVE8gsqAuZckze9eVbdjGrqWhnAxFJd2zTUYbp3rlwsvm8L
	 RvifiE+dNS7ZSLgO1vz/2iuBA+vxTg+gon+T9GxUfPeiqu1Cn1B3IDL+Ia+I3b2tn4
	 DUC/TT7rpYPd1WMR/O9eiC1zLaBkDDg/AWBX5uFU9AIA2HzYKaNAjYt0BqP2t5Mj4i
	 ACdF1uP7Z+1r36tCdmelBH4eidFpnqjDGiDmFd1pe/d61iNtSmMAHFrsJwhHlsYXim
	 cg2WHeKtjYA2VqeCjjb3bN4HawXXVIVV8MT8V9NjvagkHshjx+GeLlz0QRrCqOkWhL
	 ZBJqug52ltvkw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZR442Pzhz1dBP;
	Tue, 21 Nov 2023 09:05:56 -0500 (EST)
Message-ID: <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
Date: Tue, 21 Nov 2023 09:06:18 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>, Alexei Starovoitov
 <ast@kernel.org>, Yonghong Song <yhs@fb.com>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231121084706.GF8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-21 03:47, Peter Zijlstra wrote:
> On Mon, Nov 20, 2023 at 03:56:30PM -0800, Paul E. McKenney wrote:
>> On Mon, Nov 20, 2023 at 11:23:11PM +0100, Peter Zijlstra wrote:
>>> On Mon, Nov 20, 2023 at 02:18:29PM -0800, Paul E. McKenney wrote:
>>>> On Mon, Nov 20, 2023 at 10:47:42PM +0100, Peter Zijlstra wrote:
>>>>> On Mon, Nov 20, 2023 at 03:54:14PM -0500, Mathieu Desnoyers wrote:
>>>>>> When invoked from system call enter/exit instrumentation, accessing
>>>>>> user-space data is a common use-case for tracers. However, tracepoints
>>>>>> currently disable preemption around iteration on the registered
>>>>>> tracepoint probes and invocation of the probe callbacks, which prevents
>>>>>> tracers from handling page faults.
>>>>>>
>>>>>> Extend the tracepoint and trace event APIs to allow defining a faultable
>>>>>> tracepoint which invokes its callback with preemption enabled.
>>>>>>
>>>>>> Also extend the tracepoint API to allow tracers to request specific
>>>>>> probes to be connected to those faultable tracepoints. When the
>>>>>> TRACEPOINT_MAY_FAULT flag is provided on registration, the probe
>>>>>> callback will be called with preemption enabled, and is allowed to take
>>>>>> page faults. Faultable probes can only be registered on faultable
>>>>>> tracepoints and non-faultable probes on non-faultable tracepoints.
>>>>>>
>>>>>> The tasks trace rcu mechanism is used to synchronize read-side
>>>>>> marshalling of the registered probes with respect to faultable probes
>>>>>> unregistration and teardown.
>>>>>
>>>>> What is trace-trace rcu and why is it needed here? What's wrong with
>>>>> SRCU ?
>>>>
>>>> Tasks Trace RCU avoids SRCU's full barriers and the array accesses in the
>>>> read-side primitives.  This can be important when tracing low-overhead
>>>> components of fast paths.
>>>
>>> So why wasn't SRCU improved? That is, the above doesn't much explain.
>>>
>>> What is the trade-off made to justify adding yet another RCU flavour?
>>
>> We didn't think you would be all that happy about having each and
>> every context switch iterating through many tens or even hundreds of
>> srcu_struct structures.  For that matter, we didn't think that anyone
>> else would be all that happy either.  Us included.
> 
> So again, what is task-trace RCU ? How does it differ from say
> preemptible rcu, which AFAICT could be used here too, no?

Task trace RCU fits a niche that has the following set of requirements/tradeoffs:

- Allow page faults within RCU read-side (like SRCU),
- Has a low-overhead read lock-unlock (without the memory barrier overhead of SRCU),
- The tradeoff: Has a rather slow synchronize_rcu(), but tracers should not care about
   that. Hence, this is not meant to be a generic replacement for SRCU.

Based on my reading of https://lwn.net/Articles/253651/ , preemptible RCU is not a good
fit for the following reasons:

- It disallows blocking within a RCU read-side on non-CONFIG_PREEMPT kernels,
- AFAIU the mmap_sem used within the page fault handler does not have priority inheritance.

Please let me know if I'm missing something.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


