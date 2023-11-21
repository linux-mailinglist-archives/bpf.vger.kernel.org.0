Return-Path: <bpf+bounces-15541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5457F3351
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C161F22F26
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284D5A0E0;
	Tue, 21 Nov 2023 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="b04vGaVk"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B52194;
	Tue, 21 Nov 2023 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700583099;
	bh=DmMeP04wWvVJ9Ig1UHO9FEjPRaZJhRzoI9mQxgdM5yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b04vGaVkAFuqvUyKimip1PQQQ2lSohFtEsRhADtFH6XYosHXu+5Qhy7+E7ImM082b
	 Zl+KRIX8Ra+60eI0lQDe3ezXLq0/kf8qR1yUhweS+0xFzPtEekT9J5e08jovOpbHg9
	 DaXb24JPyAwbzqhEmYV6/cKp0JYNwATJAT3ci9PgPrhYTnqPMwrLECly610kdfgp6l
	 6uQe1seqFnZV1Ku2eBwOa7Rwn62y8XF+G2h8coEvNsM0iFfjbfjhtJAFjhQhZv/PXq
	 50MO23aEX5NozfES6R4Yo6YvV+zWOfOlHVfPGMbAuCUTLT/O9YwLMfzgreJC5n21N2
	 74qDXj8kqY4sQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZTs7040Zz1cmd;
	Tue, 21 Nov 2023 11:11:38 -0500 (EST)
Message-ID: <e1d33ff6-bf8d-465f-8626-f692ce4debe5@efficios.com>
Date: Tue, 21 Nov 2023 11:11:57 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>, Alexei Starovoitov
 <ast@kernel.org>, Yonghong Song <yhs@fb.com>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
References: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
 <20231121155256.GN4779@noisy.programming.kicks-ass.net>
 <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
 <20231121110753.41dc5603@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231121110753.41dc5603@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-21 11:07, Steven Rostedt wrote:
> On Tue, 21 Nov 2023 11:00:13 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> tasks-tracing-rcu:
>>>     extention of tasks to have critical-sections ? Should this simply be
>>>     tasks?
>>
>> tasks-trace-rcu is meant to allow tasks to block/take a page fault
>> within the read-side. It is specialized for tracing and has a single
>> domain. It does not need the smp_mb on the read-side, which makes it
>> lower-overhead than SRCU.
> 
> IOW, task-trace-rcu allows the call to schedule in its critical section,
> whereas task-rcu does not?

Correct.

And unlike preemptible rcu, tasks-trace-rcu allows calls to schedule 
which do not provide priority inheritance guarantees (such as I/O 
triggered by page faults).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


