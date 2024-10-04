Return-Path: <bpf+bounces-40944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DAD9905DF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EDE2830B9
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDD217326;
	Fri,  4 Oct 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WTIZc/dA"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09DA212EF7;
	Fri,  4 Oct 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051700; cv=none; b=PxGBpmkL/tA4IDb7vurBw6MbUq0RzivKAm1bZV6IIoyypdfVP4q1g1cNuGu4s3vWX5fNZ8QpshsB2/jRbtQxd0FADTlXa4KFgtjFUsEBozhYHfxzcLeXjoBjAmbshsxfgKQu4b1M5U6TqfPonx7MaUbIkdYNqHcmHfQCrzOH6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051700; c=relaxed/simple;
	bh=wUIQxDpNC22HBgSkIzNLP3BRpMBM/W06OAMKb1RE5Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrW9QNyTLE2G0D7d+Z2Kz5/EM6DBtAj0zwGhFDDA0h871PGe83wj1uvdupnL6FNKFp8gX88jE7JOdiSaxhujhwZLm4Dehg3AzFwYezUWmb9oHhFXn6poTWzfAqjGf7+JlTLRQ4XLuJTPQBlbBd1Y4yrq4vae568Dfd7TNKg/Xac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WTIZc/dA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728051697;
	bh=wUIQxDpNC22HBgSkIzNLP3BRpMBM/W06OAMKb1RE5Q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WTIZc/dAla9V4ybecg0rwQKX5gWpWez5cnSMCBB/ZVmcorfu5BQtbRIFtVxcWwvEF
	 0QgteDqCF0LmVBSRRdd+BPcla6miC7MldOXJmX1W7GZB2YEGuQTmoyPXLO4oAu9U6f
	 SdWMNfcLa7FdojYVxjy9MW+MgXEanKykHyEtupya1Pwxt9qZn8qUx9sh/a2PX+E043
	 7s89htQwF0aJWebW1zt5h6ukjwg9wRxgH6h+JDMO07c0BAOq6MAy8keD7TqRJVyd/x
	 LmUtYG+7tsYUdWAZB8csfPvc6Jl4HmaxvA6zGQ/bBjsy2tT5Mdj7OtWtiSH9HERKQV
	 jqfhodnAlEpWA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKrMN5bcPzL76;
	Fri,  4 Oct 2024 10:21:36 -0400 (EDT)
Message-ID: <e547819a-7993-4c80-b358-6719ca420cf8@efficios.com>
Date: Fri, 4 Oct 2024 10:19:36 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
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
 <20241003151638.1608537-3-mathieu.desnoyers@efficios.com>
 <20241003182304.2b04b74a@gandalf.local.home>
 <6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
 <20241003210403.71d4aa67@gandalf.local.home>
 <90ca2fee-cdfb-4d48-ab9e-57d8d2b8b8d8@efficios.com>
 <20241004092619.0be53f90@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241004092619.0be53f90@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 15:26, Steven Rostedt wrote:
> On Thu, 3 Oct 2024 21:33:16 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-10-04 03:04, Steven Rostedt wrote:
>>> On Thu, 3 Oct 2024 20:26:29 -0400
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>

[...]

>>>> So I rest my case. The change I'm introducing for tracepoints
>>>> don't make any assumptions about whether or not each tracer require
>>>> preempt off or not: it keeps the behavior the _same_ as it was before.
>>>>
>>>> Then it's up to each tracer's developer to change the behavior of their
>>>> own callbacks as they see fit. But I'm not introducing regressions in
>>>> tracers with the "big switch" change of making syscall tracepoints
>>>> faultable. This will belong to changes that are specific to each tracer.
>>>
>>>
>>> I rather remove these dependencies at the source. So, IMHO, these places
>>> should be "fixed" first.
>>>
>>> At least for the ftrace users. But I think the same can be done for the
>>> other users as well. BPF already stated it just needs "migrate_disable()".
>>> Let's see what perf has.
>>>
>>> We can then audit all the tracepoint users to make sure they do not need
>>> preemption disabled.
>>
>> Why does it need to be a broad refactoring of the entire world ? What is
>> wrong with the simple approach of introducing this tracepoint faultable
>> syscall support as a no-op from the tracer's perspective ?
> 
> Because we want in-tree users too ;-)

This series is infrastructure work that allows all in-tree tracers to
start handling page faults for sys enter/exit events. Can we simply
do the tracer-specific work on top of this infrastructure series rather
than do everything at once ?

Regarding test coverage, this series modifies each tracer syscall probe
code to add a might_fault(), which ensures a page fault can indeed be
serviced at this point.

>>
>> Then we can build on top and figure out if we want to relax things
>> on a tracer-per-tracer basis.
> 
> Looking deeper into how ftrace can implement this, it may require some more
> work. Doing it your way may be fine for now, but we need this working for
> something in-tree instead of having it only work for LTTng.

There is nothing LTTng-specific here. LTTng only has feature branches
to test it out for now. Once we have the infrastructure in place we
can discuss how each tracer can use this. I've recently enumerated
various approaches that can be taken by tracers to handle page faults:

https://lore.kernel.org/lkml/c2a2db4b-4409-4f3c-9959-53622fd8dfa7@efficios.com/

> Note, it doesn't have to be ftrace either. It could be perf or BPF. Or
> simply the sframe code (doing stack traces at the entry of system calls).

Steven, we've been working on faultable tracepoints for four years now:

https://lore.kernel.org/lkml/20201023195352.26269-1-mjeanson@efficios.com/ [2020]
https://lore.kernel.org/lkml/20210218222125.46565-1-mjeanson@efficios.com/ [2021]
https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/ [2023]
https://lore.kernel.org/lkml/20231120205418.334172-1-mathieu.desnoyers@efficios.com/ [2023]
https://lore.kernel.org/lkml/20240626185941.68420-1-mathieu.desnoyers@efficios.com/ [2024]
https://lore.kernel.org/lkml/20240828144153.829582-1-mathieu.desnoyers@efficios.com/ [2024]
https://lore.kernel.org/lkml/20240909201652.319406-1-mathieu.desnoyers@efficios.com/ [2024]
https://lore.kernel.org/lkml/20241003151638.1608537-1-mathieu.desnoyers@efficios.com/ [2024] (current)

The eBPF people want to leverage this. When I last discussed this with
eBPF maintainers, they were open to adapt eBPF after this infrastructure
series is merged. Based on this eBPF attempt from 2022:

https://lore.kernel.org/lkml/c323bce9-a04e-b1c3-580a-783fde259d60@fb.com/

The sframe code is just getting in shape (2024), but is far from being ready.

Everyone appears to be waiting for this infrastructure work to go in
before they can build on top. Once this infrastructure is available,
multiple groups can start working on introducing use of this into their
own code in parallel.

Four years into this effort, and this is the first time we're told we need
to adapt in-tree tracers to handle the page faults before this can go in.

Could you please stop moving the goal posts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


