Return-Path: <bpf+bounces-39388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A99972633
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 02:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B541F24B4F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9120DC4;
	Tue, 10 Sep 2024 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y6pp0l5E"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1532901;
	Tue, 10 Sep 2024 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928604; cv=none; b=tzxS8mb+O4Gfe+Y145DrQ9wSIBuKGi2sWZYf6j/TBuOvy84LILQeKRc0GIoh7kh6LUDDG0s9a69U7r0WWqqTzGxvkIn1ox1appBG+zFHePC3KJ9n4ILpr86j5B4wSqA+r8rtSgpGRafaRBMzpUEqaSDTRAk1vcBVBUGxkIR900c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928604; c=relaxed/simple;
	bh=eUCunfSWfN2ENwYuQvWdMHndyx9nT4U0OV0u2pdZrbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8D0AgsoA9TezHG02wNAR7mKtT4jsgSKXtl2OIHK8cfVqPFJrIpkm81QUq4P3YXnrJcpd2lhN7uxVx7qsBGyltMmN1kGfHzNbUHX+ePJdH0kh6tMSjaffUNLJDATwF2z6ibL5ti4Vlj06Z1WaohNFdxKh1kI2N0ORHYQgyPADbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Y6pp0l5E; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725928600;
	bh=eUCunfSWfN2ENwYuQvWdMHndyx9nT4U0OV0u2pdZrbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y6pp0l5E51Ns4ACifeXVQlaa5hlNukLRdhrgUd14FXGda3eXK52CFUWsNA9bwtLL6
	 tlmHy0n9KNrmEaHHsJ5NDlrNVFaxgIeCRinYVKDfEhrBINibK6zirfAgqRlThML6Su
	 VDcFy0twrG99j0zRR1joa6CgrEoFqzIJJ3iVTg6w+U/sTCZ/GvQPQS0XJ2THx1+E7x
	 4duYOyBFDZcWDCnOUZCFyAFjls0krEGwqXOBHAZx9ez1tOIx7ijG2BFv4MTC3S/8cn
	 aYa1+AXvhuK7TGAxM8CotlOhmp4D4GhSeUT7mKN87QehHZ5wXN935iqyLjWlkHiT67
	 F6p3sLQWYd72g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2lBc2y0dz1Kfh;
	Mon,  9 Sep 2024 20:36:40 -0400 (EDT)
Message-ID: <d294fc4c-45c1-49ec-98e3-5b42b7ab3b4b@efficios.com>
Date: Mon, 9 Sep 2024 20:36:21 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] tracing: Allow system call tracepoints to handle page
 faults
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
 <CAEf4BzaOh6+G3qkPjW7HYkMBhys+=WU=d3cErnm8ykTt2W3y5g@mail.gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAEf4BzaOh6+G3qkPjW7HYkMBhys+=WU=d3cErnm8ykTt2W3y5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-09 19:53, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 1:17 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Wire up the system call tracepoints with Tasks Trace RCU to allow
>> the ftrace, perf, and eBPF tracers to handle page faults.
>>
>> This series does the initial wire-up allowing tracers to handle page
>> faults, but leaves out the actual handling of said page faults as future
>> work.
>>
>> This series was compile and runtime tested with ftrace and perf syscall
>> tracing and raw syscall tracing, adding a WARN_ON_ONCE() in the
>> generated code to validate that the intended probes are used for raw
>> syscall tracing. The might_fault() added within those probes validate
>> that they are called from a context where handling a page fault is OK.
>>
>> For ebpf, this series is compile-tested only.
> 
> What tree/branch was this based on? I can't apply it cleanly anywhere I tried...

This series was based on tag v6.10.6

Sorry I should have included this information in patch 0.

Thanks,

Mathieu

> 
>>
>> This series replaces the "Faultable Tracepoints v6" series found at [1].
>>
>> Thanks,
>>
>> Mathieu
>>
>> Link: https://lore.kernel.org/lkml/20240828144153.829582-1-mathieu.desnoyers@efficios.com/ # [1]
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
>> Cc: linux-trace-kernel@vger.kernel.org
>>
>> Mathieu Desnoyers (8):
>>    tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
>>    tracing/ftrace: guard syscall probe with preempt_notrace
>>    tracing/perf: guard syscall probe with preempt_notrace
>>    tracing/bpf: guard syscall probe with preempt_notrace
>>    tracing: Allow system call tracepoints to handle page faults
>>    tracing/ftrace: Add might_fault check to syscall probes
>>    tracing/perf: Add might_fault check to syscall probes
>>    tracing/bpf: Add might_fault check to syscall probes
>>
>>   include/linux/tracepoint.h      | 87 +++++++++++++++++++++++++--------
>>   include/trace/bpf_probe.h       | 13 +++++
>>   include/trace/define_trace.h    |  5 ++
>>   include/trace/events/syscalls.h |  4 +-
>>   include/trace/perf.h            | 43 ++++++++++++++--
>>   include/trace/trace_events.h    | 61 +++++++++++++++++++++--
>>   init/Kconfig                    |  1 +
>>   kernel/entry/common.c           |  4 +-
>>   kernel/trace/trace_syscalls.c   | 36 ++++++++++++--
>>   9 files changed, 218 insertions(+), 36 deletions(-)
>>
>> --
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


