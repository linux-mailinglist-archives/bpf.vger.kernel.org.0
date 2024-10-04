Return-Path: <bpf+bounces-40893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B415D98FB90
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65DD1C222A7
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3361D5AA4;
	Fri,  4 Oct 2024 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xzs47SUN"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1561D5AC2;
	Fri,  4 Oct 2024 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001937; cv=none; b=L/w8OY07z+914Sfggj+GEmnZA0EpFJayrsDPf3whMRP/CGRHO8X2XRft4Fa+911pU8i1oORs5RaNsvDOztwFj5ellB77VxBbYDyw2JRPjRPO7BAFcPGIu5D0jnyWjdnOtJ2EkfF1OYSQHgE8/oSRlcdX+sEIA3gImjH0wEbToKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001937; c=relaxed/simple;
	bh=O2H3vc11MgBRrINpzG1oDmNKYI4OvzcH5leqfi8lxLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMR0DttMkYQvU7r4p6bO5DGhZHZ0285+nl4YTxPo+y1T4LcZE/vNK3qB3Ne5ArgKxgb8sCcB2lZm4V+Vb7RUya+998/uXfBStw+MJopwp33iJ65HYnrp555kP8XuI97HZXq5lVeQNQrBPv1EIVL9/sekPcJPjhdyw3QYCjk1Hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=xzs47SUN; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728001934;
	bh=O2H3vc11MgBRrINpzG1oDmNKYI4OvzcH5leqfi8lxLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xzs47SUNK5Qi/EJALn0fKLBW0nJOHh3dr8N6yEB9YNXBgTfgyd2MPEzkNwEJkV/Qz
	 Hz/M2pH0Ww8cFJzJcM/TPLJMUAPhKEBOXCLvjl3B15JSA+ZlHwKgdDTQGGrNVyOwcB
	 J1wihdqZQjwaz3knqxsAZx4wN8ivvdh3pznfnw7gdVEwL/T6KpQghUZGpM0PpUGOsb
	 4NmKixF/FhZ1GgPdfLjPPMSUtx81Zfp2LTAxVv14QFRShMObvfhJBjU9tYW7kFySly
	 HjBuI+3ef54DQEgwXLDKRot0jajGYrG2x/NpJMFNNQo5HSrFCqukiPpQ2hmjTEetRW
	 cWhE6YFx1ehCA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKTyQ3wBFzB6q;
	Thu,  3 Oct 2024 20:32:14 -0400 (EDT)
Message-ID: <2d841991-5cae-4de4-9f10-2b65d1b0715e@efficios.com>
Date: Thu, 3 Oct 2024 20:30:13 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] tracing/bpf: guard syscall probe with
 preempt_notrace
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
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAADnVQJf535hwud5XtQKStOge9=pYVYWSiq_8Q2YAvN5rba==A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-04 01:05, Alexei Starovoitov wrote:
> On Thu, Oct 3, 2024 at 3:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Thu,  3 Oct 2024 11:16:34 -0400
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>>> In preparation for allowing system call enter/exit instrumentation to
>>> handle page faults, make sure that bpf can handle this change by
>>> explicitly disabling preemption within the bpf system call tracepoint
>>> probes to respect the current expectations within bpf tracing code.
>>>
>>> This change does not yet allow bpf to take page faults per se within its
>>> probe, but allows its existing probes to adapt to the upcoming change.
>>>
>>
>> I guess the BPF folks should state if this is needed or not?
>>
>> Does the BPF hooks into the tracepoints expect preemption to be disabled
>> when called?
> 
> Andrii pointed it out already.
> bpf doesn't need preemption to be disabled.
> Only migration needs to be disabled.

I'm well aware of this. Feel free to relax those constraints in
follow up patches in your own tracers. I'm simply not introducing
any behavior change in the "big switch" patch introducing faultable
syscall tracepoints. It's just too easy to overlook a dependency on
preempt off deep inside some tracer code for me to make assumptions
at the tracepoint level.

If a regression happens, it will be caused by the tracer-specific
patch that relaxes the constraints, not by the tracepoint change
that affects multiple tracers at once.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


