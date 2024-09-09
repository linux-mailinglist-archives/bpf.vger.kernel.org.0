Return-Path: <bpf+bounces-39334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78997205A
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 19:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B077B229C2
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC5178378;
	Mon,  9 Sep 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="o6X76bNb"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DE170A1B;
	Mon,  9 Sep 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902539; cv=none; b=aRyFcZPLB+DYj656TC2s73u/MpAce19Qc14JohO7QBDg71cX5JJqC55Ho7W5J0iBhqLa0AAK10AwQDUYph7PynuEIdQEH8/VJdbqPtXzp8rMU2cp0iDvPmun9weqnQCXhOiOGKpiYydWBMyKGPDYWognx+eOqHTdcPSLDBe5rcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902539; c=relaxed/simple;
	bh=10DxOvSkp46qzAR/VG9MNEapEr6I90jKHri7LSTULfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anQolSozwzZ5muK/NVwVqPDeSSrOrE+1+99QdJUTxs95lUS83PS/ua30vPgdZuynfQcf1Lf+to9V1oJeOOo+LgaQlwpsyjHarUf71imPKRK9NVvA8ghJ0JwTGQYo2F55KhaJzlc0bC/i85NMVC2PDrsELqU5Au75A1vdECDok/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=o6X76bNb; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725902535;
	bh=10DxOvSkp46qzAR/VG9MNEapEr6I90jKHri7LSTULfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o6X76bNbCxjpRXMqnzFoJ7fUCQeHkUkBi4bjIRGtiWwjELMpDOa4CZoFUdcYdr3ww
	 LenLZ1yPrteE9+pm2YzdQiaQrljA3GN44y7J9a2SAPnUdHyjodo7y9UXO7NGzvun1B
	 7moWRc2z2OxBC475VfU5+oQNWjRD8CT9M+YcSt9JrR2hyfg4GPt66iQa15Q4roQyVr
	 sjyqBpnHnZOK6nVGUPuml64hSZIxPmn5WnOUL+KJtRh+TDCI0BztDKeAf73kMiB1m0
	 29SPaDURyZvS/zCMty3ALdyfKpk9cJHTujfuv35ehn6ICJ1ON30GJjfmlslDoK0N3C
	 /dc+cPJ6B1GBg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2YYM1fx4z1KhF;
	Mon,  9 Sep 2024 13:22:15 -0400 (EDT)
Message-ID: <279860b4-2f42-463f-bee2-c6c60ec72f29@efficios.com>
Date: Mon, 9 Sep 2024 13:22:00 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] tracing/bpf-trace: Add support for faultable
 tracepoints
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
 <20240828144153.829582-4-mathieu.desnoyers@efficios.com>
 <CAEf4BzZERq7qwf0TWYFaXzE6d+L+Y6UY+ahteikro_eugJGxWw@mail.gmail.com>
 <1f442f99-92cd-41d6-8dd2-1f4780f2e556@efficios.com>
 <CAEf4BzbS0TRN1vPzPtSZj+XN7oVUUwyoxHr5p7igH8X-nhZhGw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzbS0TRN1vPzPtSZj+XN7oVUUwyoxHr5p7igH8X-nhZhGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-09 12:53, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 8:11 AM Mathieu Desnoyers
[...]
>>>
>>> I wonder if it would be better to just do this, instead of that
>>> preempt guard. I think we don't strictly need preemption to be
>>> disabled, we just need to stay on the same CPU, just like we do that
>>> for many other program types.
>>
>> I'm worried about introducing any kind of subtle synchronization
>> change in this series, and moving from preempt-off to migrate-disable
>> definitely falls under that umbrella.
>>
>> I would recommend auditing all uses of this_cpu_*() APIs to make sure
>> accesses to per-cpu data structures are using atomics and not just using
>> operations that expect use of preempt-off to prevent concurrent threads
>> from updating to the per-cpu data concurrently.
>>
>> So what you are suggesting may be a good idea, but I prefer to leave
>> this kind of change to a separate bpf-specific series, and I would
>> leave this work to someone who knows more about ebpf than me.
>>
> 
> Yeah, that's ok. migrate_disable() switch is probably going a bit too
> far too fast, but I think we should just add
> preempt_disable/preempt_enable inside __bpf_trace_run() instead of
> leaving it inside those hard to find and follow tracepoint macros. So
> maybe you can just pass a bool into __bpf_trace_run() and do preempt
> guard (or explicit disable/enable) there?
> 

Passing an extra boolean to __bpf_trace_run would impact all tracepoints
calling into ebpf, adding an extra function argument and extra tests for
all of those. The impact may be small, but it is non-zero in both code size
and overhead, so it would not be my preferred approach.

I have modified the macros to add the guard within __bpf_trace_##call
following suggestions from Linus:

   https://lore.kernel.org/lkml/CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com/

I'll Cc you on that version of the series.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


