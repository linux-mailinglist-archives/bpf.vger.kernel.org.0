Return-Path: <bpf+bounces-32601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929791093C
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E91C20BB1
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D151AED4E;
	Thu, 20 Jun 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iVdThC4w"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A691AED46;
	Thu, 20 Jun 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895884; cv=none; b=U4c22u5BTpQdLDeZhyFnmXh8MntIpKJUBwasYirZ/Eu8bcFmhcNw2ZXmkJQf98jUtJmvo7cloH+iscYf4CeYF1IlYu01mcV9dm/KecHyTbkkIbseb/U9Z6TanCh6XjnPlclXeM1fqHbo62p/iPP0Mc7YQ2pkrYyRaZ8nx16gtpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895884; c=relaxed/simple;
	bh=LUPtel0ShUHpNwxjNiaG47yDGOxRzD0GMUdRYFQCXtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5ctFeBgeEG3x1UpKB+DJAGt9Ems+QmHqoigi11KfXLM3HsEmTMJbz0cI32Rp9Tge9iO/BHXwFA1xs8go0rYiMgahEa50R/NHEKOaFqhSJZ1Y+e4RmGf2FIm4cRLcru1MTs2XmLsL18tVQKQH2ftC2oIE6FJNg6L31qUxoVykWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iVdThC4w; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1718895881;
	bh=LUPtel0ShUHpNwxjNiaG47yDGOxRzD0GMUdRYFQCXtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iVdThC4wKi9ls35EEToxYZS7xJGS9/gUiZiqJsLLCHZAbmtGnp7ReJoJp2ASlU4lo
	 k7dcMMHap+cbUx/DdVTYtMzYTZMLRSWqaHYu73vDv+o5N+t36F1qnHdBEjJyBIXKQb
	 sQfitlGyv5zoxy/MiozmN/i+r8ug1TeFFKBGZaABWRl5lDKwc3L1ntM1Ur1I6X3FAR
	 RezQUcGvSmYAaVjxgVmkBnkjzfwz8NrColwp7liP0fX58eTPV2XBPeaHRU9rBgi1Ru
	 EkfTbZBIuejzjnI+2lm/09EGe6Ayep92bzmHRwl8j24MCHuJv6RaJoPvTcGdktMhSX
	 qjNyr5LKA4PIQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W4kL132Xmz16rR;
	Thu, 20 Jun 2024 11:04:41 -0400 (EDT)
Message-ID: <2dca3126-5bbd-4d86-a888-b532174ae6f1@efficios.com>
Date: Thu, 20 Jun 2024 11:05:42 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] tracing: convert sys_enter/exit to faultable
 tracepoints
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>, Alexei Starovoitov
 <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-6-mathieu.desnoyers@efficios.com>
 <20231120214657.GB8262@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20231120214657.GB8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-20 16:46, Peter Zijlstra wrote:
> On Mon, Nov 20, 2023 at 03:54:18PM -0500, Mathieu Desnoyers wrote:
> 
>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
>> index de753403cdaf..718a0723a0bc 100644
>> --- a/kernel/trace/trace_syscalls.c
>> +++ b/kernel/trace/trace_syscalls.c
>> @@ -299,27 +299,33 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>>   	int syscall_nr;
>>   	int size;
>>   
>> +	/*
>> +	 * Probe called with preemption enabled (may_fault), but ring buffer and
>> +	 * per-cpu data require preemption to be disabled.
>> +	 */
>> +	preempt_disable_notrace();
> 
> 	guard(preempt_notrace)();
> 
> and ditch all the goto crap.

[ more guard stuff ]

Sure, will do, thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


