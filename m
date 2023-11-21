Return-Path: <bpf+bounces-15538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFC7F32FC
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A301C21CD7
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760859150;
	Tue, 21 Nov 2023 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PJG2hlpy"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98561AA;
	Tue, 21 Nov 2023 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700582394;
	bh=JmZEJf5RAneAxfKkhrBenzkWIsFalBZLR+8PE1XQg7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PJG2hlpytqC9RlLooQ1aDWebO4kuIGaVMyp0oIIq+80TqrSaTtSN1zlDjDrSEILL6
	 gU4ff5QwK08MqH7DWPr7x0dCap5zPI1h6qCwPGXku1E2F1oeTgjPbY0LRPTzU1H4ks
	 MDRVTN3oFBKLEA7HaPCNqxTmQFHbJkWp96r9Dy0olReM2f3dK5iGae3EM2ygzlbK60
	 3chDYLSJvcKTmDPPZJtk4VGX6me9oriIzTzpTLVyKQz/24W/7JmFPBSgC6/32f0qzq
	 +k12r35XGo+wKbxppocMVfys5fm+UYr0SYU6S5hUMRdiBJP6JRgnUlTYPMxLeZSmtL
	 9CaymuEZD5YwA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZTbZ2wrQz1cv5;
	Tue, 21 Nov 2023 10:59:54 -0500 (EST)
Message-ID: <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
Date: Tue, 21 Nov 2023 11:00:13 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231121155256.GN4779@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-21 10:52, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 03:46:43PM +0100, Peter Zijlstra wrote:
> 
>> Why is this such a hard question?
> 
> Anyway, recapping from IRC:
> 
> preemptible, SRCU:
>    counter-array based, GP advances by increasing array index
>    and waiting for previous index to drop to 0.
> 
>    notably, a GP can pass while a task is preempted but not within a
>    critical section.
> 
>    SRCU has smp_mb() in the critical sections to improve GP.

Also:

preemptible only allows blocking when priority inheritance is
guarantees, which excludes doing I/O, and thus page faults.
Otherwise a long I/O could cause the system to OOM.

SRCU allows all kind of blocking, as long as the entire SRCU
domain does not mind waiting for a while before readers complete.

> 
> tasks:
>    waits for every task to pass schedule()
> 
>    ensures that any pieces of text rendered unreachable before, is
>    actually unused after.
> 
> tasks-rude:
>    like tasks, but different? build to handle tracing while rcu-idle,
>    even though that was already deemed bad?
> 
> tasks-tracing-rcu:
>    extention of tasks to have critical-sections ? Should this simply be
>    tasks?

tasks-trace-rcu is meant to allow tasks to block/take a page fault 
within the read-side. It is specialized for tracing and has a single 
domain. It does not need the smp_mb on the read-side, which makes it 
lower-overhead than SRCU.

Thanks,

Mathieu

> 
> 
> Can someone complete, please?
> 
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


