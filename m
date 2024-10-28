Return-Path: <bpf+bounces-43338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E269B3BCD
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 21:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338BD1C22319
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97411F4293;
	Mon, 28 Oct 2024 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gCA0o8iF"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F81EE00C;
	Mon, 28 Oct 2024 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147256; cv=none; b=p7ats6x+qoXJI61rUd0I/TwZ7g1U/sUwkgDtvrO2BJ4D/GuAdXuaB8E9+Sa6TBsXwPv/UMnme79bQb6pI397uMG6Ln9KgeEM9cthXmoBm/YCcsYnET+XLivKmEkQy8c36wovdXJlxjBA1eAbUBpo8Y9XRf9b9qOlilsrP05dLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147256; c=relaxed/simple;
	bh=XDAZhSYAaVkmM4dFq8nal7tVXdbanH7syiZOM+auQxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPpsXwDT7BFF3Lq9g+VFeM2UahhxR6VODvdMCHfmc95iJkihuCLjwNxnplG/dWHo87em5LwqGjOjygTtTG2IwgOwcHkHK9OHG8CIfynUhLFqUcKR5+NWIa1yd+qvsUxh0dHv/6faSOzo+DU4T7RPDE2HapMgez1VMBZRX2gkb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gCA0o8iF; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730147253;
	bh=XDAZhSYAaVkmM4dFq8nal7tVXdbanH7syiZOM+auQxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gCA0o8iFNotPHu8YJdQ0zgNyNddjKrHOyPHkS6d9zzTRQz5Q1SCYa0bMXEkcKbeIi
	 OZhocwgEgC0ajHj8oGg7IUU3x97Std4QUSTxP0zzqIIcGwrKoVZBpt5Tiqzapxxwud
	 mH7eD2HAtr+VeC/6U2fNQbyeUnoR2MEqcIiY1O1O2baVSHUmA//dQMwNBAE3gz37Wj
	 PQfzXlfdLD5BgMNs11HMkz3NUVd1bc9/zJPgHXpjq/Fog6NUidwJahkD87XPcm+p2W
	 Lerc1xiM2ekLyfsQ/8G0zvIxL7YzysPx5eCujNwA7qlnJQ4nfpL2tybvvmuI9wGBAo
	 e/jd3fgcxHT5g==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XclLX62mRzsb2;
	Mon, 28 Oct 2024 16:27:32 -0400 (EDT)
Message-ID: <588eb8e1-5035-499f-b19b-8b40a9877433@efficios.com>
Date: Mon, 28 Oct 2024 16:25:53 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jordan Rife <jrife@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Michael Jeanson
 <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
 <20241028190927.648953-5-mathieu.desnoyers@efficios.com>
 <e18e953b-9030-487c-bb8a-125521568e9e@efficios.com>
 <CAEf4BzZgSPXyvtBZuB+W3fp=C8QYSHsd0TduxWE3Le+9e80-UA@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzZgSPXyvtBZuB+W3fp=C8QYSHsd0TduxWE3Le+9e80-UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-28 16:20, Andrii Nakryiko wrote:
> On Mon, Oct 28, 2024 at 12:59 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2024-10-28 15:09, Mathieu Desnoyers wrote:
>>> Catch incorrect use of syscall tracepoints even if no probes are
>>> registered by adding a might_fault() check in __DO_TRACE() when
>>> syscall=1.
>>>
>>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Michael Jeanson <mjeanson@efficios.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Yonghong Song <yhs@fb.com>
>>> Cc: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>> Cc: bpf@vger.kernel.org
>>> Cc: Joel Fernandes <joel@joelfernandes.org>
>>> Cc: Jordan Rife <jrife@google.com>
>>> ---
>>>    include/linux/tracepoint.h | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>>> index 259f0ab4ece6..7bed499b7055 100644
>>> --- a/include/linux/tracepoint.h
>>> +++ b/include/linux/tracepoint.h
>>> @@ -226,10 +226,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>>                if (!(cond))                                            \
>>>                        return;                                         \
>>>                                                                        \
>>> -             if (syscall)                                            \
>>> +             if (syscall) {                                          \
>>>                        rcu_read_lock_trace();                          \
>>> -             else                                                    \
>>> +                     might_fault();                                  \
>>
>> Actually, __DO_TRACE() is not the best place to put this, because it's
>> only executed when the tracepoint is enabled.
>>
>> I'll move this to __DECLARE_TRACE_SYSCALL()
>>
>> #define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)    \
>>           __DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
>>           static inline void trace_##name(proto)                          \
>>           {                                                               \
>>                   might_fault();                                          \
>>                   if (static_branch_unlikely(&__tracepoint_##name.key))   \
>>                           __DO_TRACE(name,                                \
>>                                   TP_ARGS(args),                          \
>>                                   TP_CONDITION(cond), 1);                 \
>> [...]
>>
>> instead in v5.
> 
> please drop the RFC tag while at it

I'm still awaiting for Jordan (or someone else) to come back with
testing results before I feel confident dropping the RFC tag.

Thanks,

Mathieu

> 
>>
>> Thanks,
>>
>> Mathieu
>>
>>> +             } else {                                                \
>>>                        preempt_disable_notrace();                      \
>>> +             }                                                       \
>>>                                                                        \
>>>                __DO_TRACE_CALL(name, TP_ARGS(args));                   \
>>>                                                                        \
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


