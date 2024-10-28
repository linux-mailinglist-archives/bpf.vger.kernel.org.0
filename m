Return-Path: <bpf+bounces-43337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD79B3BA8
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 21:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EE61F22DBD
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E61E0DE4;
	Mon, 28 Oct 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="J/z9iVP/"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DEE1E0080;
	Mon, 28 Oct 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147175; cv=none; b=ItyMhe+EWWJV5izLRv29H3JGgXeKJDb/7NahXYYdNFidJ3TXWQJUVrVRcMoXNuf2Fjmlw8+4pU2X9TsnJrLfw4ntmHifIXH+ThL3ZKWw9T2/XqiNiuVIn6L6mQNQ9p8hD4CtXmH6ZX9M+1nbum/aEIuUlYa6BoddesegzNDTmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147175; c=relaxed/simple;
	bh=J2DcfBdWy45uJItdWiguW3idrp9CeNy/8d4dmAE9PTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gINK2YSRW4HdOQwKfSNnqcEC9nKqaHn7O8YQewVgSCsiWXC6y0l97HiUq5oHX0qDRfbtJhha44eaJ0cGQhiSAWfsJjbL28bcDO5XXjA+/m1pqSMN5eiYF+FcCE1gDI4cR/Neh99SuCJNbg80nk31DMsQRhZtjId5fG79j+k6m88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=J/z9iVP/; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730147171;
	bh=J2DcfBdWy45uJItdWiguW3idrp9CeNy/8d4dmAE9PTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J/z9iVP/Y6RPeDMdI5MNRoGDml6fNQxfZR+pU6ZwxpeXMjd6TZQpBUqwwAaXsPmko
	 prHP+ObPRwOIpi2rz2MHqsnQLzrpjIIE8NvoY4YKpasH1nrORDrjr92rqAIIlPJr4s
	 xzFpsDLefLueJ39WLOBzexPANTmY7n2Rj2IeravhgB/yG8uihwRknnnpuoH4zY5TRp
	 dgqMV6VRzAKT/mrcyEi1XP/rAGECrJ5LPIPRxeja6LFkhIWOQ86X/z1BxdQHlAcL3R
	 pJ1y1MJCHqNq1y0TRltZsymOJ97MJMchwsWLJhaM77ZirS3EWDZ+VE+jHAAvaaQd9G
	 8dhYZTqHtXWWA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XclJz40dTzsZx;
	Mon, 28 Oct 2024 16:26:11 -0400 (EDT)
Message-ID: <89947c86-a8fa-425f-8e86-d80bb5220280@efficios.com>
Date: Mon, 28 Oct 2024 16:24:32 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/4] tracing: Introduce tracepoint_is_faultable()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Michael Jeanson
 <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
 <20241028190927.648953-3-mathieu.desnoyers@efficios.com>
 <CAEf4BzZA30dEOxqtwWcMsGLLU0na77rmRANMMYQaNJ8D8o5-bQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzZA30dEOxqtwWcMsGLLU0na77rmRANMMYQaNJ8D8o5-bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-28 16:19, Andrii Nakryiko wrote:
> On Mon, Oct 28, 2024 at 12:11 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Introduce a "faultable" flag within the extended structure to know
>> whether a tracepoint needs rcu tasks trace grace period before reclaim.
>> This can be queried using tracepoint_is_faultable().
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Michael Jeanson <mjeanson@efficios.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
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
>> Cc: Jordan Rife <jrife@google.com>
>> ---
>>   include/linux/tracepoint-defs.h |  2 ++
>>   include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
>>   include/trace/define_trace.h    |  2 +-
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>
> 
> LGTM

FYI I'm still missing the "static" here:


>> +#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)       \
>> +       struct tracepoint_ext __tracepoint_ext_##_name = {              \
>> +               .regfunc = _reg,                                        \
>> +               .unregfunc = _unreg,                                    \
>> +               .faultable = true,                                      \
>>          };      

Will fix in v5.

Acked-by noted, thanks!

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


