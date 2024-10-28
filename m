Return-Path: <bpf+bounces-43300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84609B31CF
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 14:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE440284A8C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030C71DBB24;
	Mon, 28 Oct 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VrouR1He"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE3191F82;
	Mon, 28 Oct 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122641; cv=none; b=W/aXslBjMw3bIqJzGV40Qlqv2zIzvyyw0UdF5zH2UayTAdTMy/1aoRaAGmghYjjU/i0udGjPGOOWhM7NokFf+0ZseXZXoCJv9nf6RW0YGve0BjJO9D2PbUczyT5gUqxj8P1NOgV3yTysaRNkrf4LDniyctky5zOtk22MQ25EdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122641; c=relaxed/simple;
	bh=y2WNLzk+y8tyPyQZDwh342N+ZiOB+lOrNQ9Gaw7aQKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gv5SGvanDIgsvl5MDUr2UZ3+9nZQEspInc7+vbju45J4NRtDX8j9rFN6CPjbF4WkJD+WvfyaXjROV4EaOeGDYniD8mf3kkYnu8JsuYoA4kFL8bGR1ocW/zvsdnQU/+SXtoBV9Q2pyItCIeu0TR19dylVVtAKVQdeqWZnPsqQb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VrouR1He; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730122631;
	bh=y2WNLzk+y8tyPyQZDwh342N+ZiOB+lOrNQ9Gaw7aQKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VrouR1HeZdD7JVENkNi6D+emgnm5tggHHouWyUL7T+v5vDYvpN7mD/46I2+6VKkvd
	 hjntmof3JEBhdBwj8owLFl8AqLCxo7aE/qIlf1P3nQczEebyRBWgFYunxNm8OIMT2i
	 0lrqTSs6TRqrOIBu2Mh0fdF9//h1h3qDctWh7pDO0t9nspqIIAlIcNhwASrDtQl/hW
	 CWNoGWk61W3puQff4nOjhAVes7TR9NNcKZH2C6iVeHMaQGtjMVIuQe3BnHnvcNEI5u
	 yF+9LVsF4UW1FRQAsuh3bIwvxgw8cOHvIhI5fptYTx96/GSMfLKg8UhB7lmJZSmBsh
	 Nnp6AiRMvsrAQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcZF252xrzq0y;
	Mon, 28 Oct 2024 09:37:10 -0400 (EDT)
Message-ID: <9e9c37d6-3fa8-4f58-9d27-a629b4a817f5@efficios.com>
Date: Mon, 28 Oct 2024 09:35:31 -0400
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
 <933ab148-2a28-4912-9bca-150a0643eecd@efficios.com>
 <20241028010647.38f4847f@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241028010647.38f4847f@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-28 01:06, Steven Rostedt wrote:
> On Sun, 27 Oct 2024 08:30:54 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> I wonder if we should call it "sleepable" instead? For this patch set
>>> do we really care if it's a system call or not? It's really if the
>>> tracepoint is sleepable or not that's the issue. System calls are just
>>> one user of it, there may be more in the future, and the changes to BPF
>>> will still be needed.
>>
>> Remember that syscall tracepoint probes are allowed to handle page
>> faults, but should not generally block, otherwise it would postpone the
>> grace periods of all RCU tasks trace users.
>>
>> So naming this "sleepable" would be misleading, because probes are
>> not allowed general blocking, just to handle page faults.
> 
> I'm fine with "faultable" too.
> 
>>
>> If we look at the history of this tracepoint feature, we went with
>> the following naming over the various versions of the patch series:
>>
>> 1) Sleepable tracepoints: until we understood that we just want to
>>      allow page fault, not general sleeping, so we needed to change
>>      the name,
>>
>> 2) Faultable tracepoints: until Linus requested that we aim for
>>      something that is specific to system calls, rather than a generic
>>      thing.
>>
>>      https://lore.kernel.org/lkml/CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com/
> 
> Reading that thread again, I believe that Linus was talking more about
> all the infrastructure going around to make a special "faultable"
> tracepoint (I could be wrong, and Linus may correct me here). When in
> fact, the only user is system calls. But from the BPF POV, it doesn't
> care if it's a system call, it cares that it is faultable, and the
> check should be on that. Having BPF check if it's a system call is
> requiring that BPF knows the implementation details of system call
> tracepoints. But if it knows it is faultable, then it needs to do
> something special.

It might just be that, indeed. Considering the overwhelming preference
for something a little more general (sleepable/faultable vs syscall),
I am tempted to go for "tracepoint_is_faultable()".

> 
>>
>> 3) Syscall tracepoints: This is what we currently have.
>>
>>> Other than that, I think this could work.
>>
>> Calling this field "sleepable" would be misleading. Calling it "faultable"
>> would be a better fit, but based on Linus' request, I'm tempted to stick
>> with "syscall" for now.
>>
>> Your concern is to name this in a way that is general and future-proof.
>> Linus' point was to make it syscall-specific rather than general. My
>> position is that we should wait until we face other use-cases (if we
>> even do) before consider changing the naming from "syscall" to something
>> more generic.
> 
> Yes, but that was for the infrastructure itself. It really doesnt' make
> sense that BPF needs to know which type of tracepoint can fault. That's
> telling BPF, you need to know the implementation of this type of
> tracepoint.

OK, I'll use tracepoint_is_faultable() and a "faultable" field name, and
see how people react. I really prefer "faultable" to "sleepable" here,
because I envision that in the future we may introduce tracepoints
which are really able to sleep (general blocking), for instance though
use of hazard pointers to protect a list iteration. (if there is ever
a need for it)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


