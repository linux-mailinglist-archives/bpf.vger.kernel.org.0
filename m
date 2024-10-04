Return-Path: <bpf+bounces-40907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB4198FBEE
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B7DBB2272A
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D652D51E;
	Fri,  4 Oct 2024 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IH5sXD9n"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158B1849;
	Fri,  4 Oct 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728005439; cv=none; b=mfnI5/CfN5WymXc3jdOVLB40rxtVuL3dJydkCf6g0TdC6vErVrzberv1mKhVfPkyFrB3/wzAlJD+9DHThV7j5lMyeyIb6PHOpQoUC2iRBN8ThO3jJfi0LEbOI1+8tHPdhES9k+k6bNjM4HGsG0jWBFeuKlVEUXiekC9sHHtXAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728005439; c=relaxed/simple;
	bh=P6ex8Debaul8vK1jvcUxJ5+5iOw5yl+2HAOGL16CizI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qoaO3ORKtQ32OzwRdc5NSjTi71nX2wAaFKWY97d0q6NQbFcc16NfT4d314DRaVHVPORnhky6ghbiAfQsxyGEnHILqbENCRz9cY4TF1OLBrKTc8YWVEGrdEKwngtKw8xm43x3TNSnceEOe4wh/DWO2zcA867w9BN5bj2wOB7VsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=IH5sXD9n; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728005436;
	bh=P6ex8Debaul8vK1jvcUxJ5+5iOw5yl+2HAOGL16CizI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IH5sXD9nBGCs/adERnQdNDV2D4ldsys1aEhIJsWMVFWhALpThuYaXKm3DiIwOOjz+
	 3idamjpl/I5yvO2l878deyFGYMDhJl6cC0tVZeNyFhLcVsHd809D4sLwdTzM9iZb3X
	 qc1eGdF9AEJvDV/BQkUAEPkCnZsuwdTjyQOuEnuPPjdTuOih6Iv6oTjCbhPVTS337R
	 EBRbwg8PhvOTm4LP62nSj+UlgBJv5+sSxW8bI1LAv8DVsgYsfakSd4n1c0XfuwZ0Bh
	 wMnYAiAkMC7Gf7CuiUDU4gQ5AnOxZok16tBjWOL+1THLac7OqXS8qeAxMJ9xjDB20G
	 rwCfa04LNPDJA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKWFm41bNzBr4;
	Thu,  3 Oct 2024 21:30:36 -0400 (EDT)
Message-ID: <dcfc5e10-1056-4ffe-ac68-dcdb1d370cc9@efficios.com>
Date: Thu, 3 Oct 2024 21:28:35 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] tracing/bpf: guard syscall probe with
 preempt_notrace
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Michael Jeanson <mjeanson@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-5-mathieu.desnoyers@efficios.com>
 <20241003182604.09e4851d@gandalf.local.home>
 <CAADnVQJf535hwud5XtQKStOge9=pYVYWSiq_8Q2YAvN5rba==A@mail.gmail.com>
 <2d841991-5cae-4de4-9f10-2b65d1b0715e@efficios.com>
Content-Language: en-US
In-Reply-To: <2d841991-5cae-4de4-9f10-2b65d1b0715e@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-04 02:30, Mathieu Desnoyers wrote:
> On 2024-10-04 01:05, Alexei Starovoitov wrote:
>> On Thu, Oct 3, 2024 at 3:25 PM Steven Rostedt <rostedt@goodmis.org> 
>> wrote:
>>>
>>> On Thu,  3 Oct 2024 11:16:34 -0400
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>
>>>> In preparation for allowing system call enter/exit instrumentation to
>>>> handle page faults, make sure that bpf can handle this change by
>>>> explicitly disabling preemption within the bpf system call tracepoint
>>>> probes to respect the current expectations within bpf tracing code.
>>>>
>>>> This change does not yet allow bpf to take page faults per se within 
>>>> its
>>>> probe, but allows its existing probes to adapt to the upcoming change.
>>>>
>>>
>>> I guess the BPF folks should state if this is needed or not?
>>>
>>> Does the BPF hooks into the tracepoints expect preemption to be disabled
>>> when called?
>>
>> Andrii pointed it out already.
>> bpf doesn't need preemption to be disabled.
>> Only migration needs to be disabled.
> 
> I'm well aware of this. Feel free to relax those constraints in
> follow up patches in your own tracers. I'm simply not introducing
> any behavior change in the "big switch" patch introducing faultable
> syscall tracepoints. It's just too easy to overlook a dependency on
> preempt off deep inside some tracer code for me to make assumptions
> at the tracepoint level.
> 
> If a regression happens, it will be caused by the tracer-specific
> patch that relaxes the constraints, not by the tracepoint change
> that affects multiple tracers at once.

I also notice that the bpf verifier checks a "active_preempt_lock"
state to make sure sleepable functions are not called while within
preempt off region. So I would expect that the verifier has some
knowledge about the fact that tracepoint probes are called with
preempt off already.

Likewise in reverse for functions which deal with per-cpu data: those
would expect to be used with preempt off if multiple functions need to
touch the same cpu's data.

So if we make the syscall tracepoint constraints more relax (migrate
off rather than preempt off), I suspect we may have to update the
verifier.

This contributes to my uneasiness towards introducing this kind of
side-effect in a tracepoint change that affects all tracers.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


