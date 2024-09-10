Return-Path: <bpf+bounces-39476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31A973BB1
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A320CB25896
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604719ABAA;
	Tue, 10 Sep 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dqur1/aw"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8952187FFF
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981819; cv=none; b=t8TfC3WHsMxU6FkNYaE18Y44LU4gVc4q3wYTF9k75a4Oy84DbpbzXTpc0xOdsmvSwLwPIoXosiX/VRoAHIToi741atPNK1+65KA4ct41JKvC81nmukr2W6h1dJxx+3aEhArXrCPYQ8P1DDn8xSfvChY9ddgiBfreBDpCC1rGfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981819; c=relaxed/simple;
	bh=eZUJsMLE3iDS2vws1t17oUIa9XAqv3kQof3NfwWLbeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLTUJk1BWQplpBjYbdCuaiY6TIygRjlNAPl3rkxYM9FETYhtSN2m7j+NScNG6WLqqik7cgUYqtFLKbkH9rDMyNO2N4OC7q78yFpfCPgPZHidcbD/PO05munP7xq1yAZcK6TG0HDmBbyw5FIA3hbc7ajxPv0a+409YLM/gGVuD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dqur1/aw; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab9d0432-7d71-4510-bd2f-5fb5834f9772@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725981814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGQoWTniyOrKbwT8qCwNHaLdQIHtdUxOMxjpx3UIINE=;
	b=dqur1/awnWbwqgjGpD5M0iUIt+UEvHopvtkc199oHWzM2alvrsma3rrCPnbL3GeaIKqjla
	q/bA+2jKxzGqbEnaIr5eLoMXJnuIqxj+0eyNrNEEBChp2UqxiUnn/J2kt1DbEAQQBt6+8b
	vSzJGF3b9Nrv+8x1Bc+6oPgmJG8OIe4=
Date: Tue, 10 Sep 2024 08:23:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Use fake pt_regs when doing bpf syscall
 tracepoint tracing
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Salvatore Benedetto <salvabenedetto@meta.com>
References: <20240910034306.3122378-1-yonghong.song@linux.dev>
 <CAEf4BzbsYn-b7YiKZ0MPW9_VLzDq38Jv8UkocfMLVje_SAmENA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbsYn-b7YiKZ0MPW9_VLzDq38Jv8UkocfMLVje_SAmENA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/9/24 10:34 PM, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 8:43 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Salvatore Benedetto reported an issue that when doing syscall tracepoint
>> tracing the kernel stack is empty. For example, using the following
>> command line
>>    bpftrace -e 'tracepoint:syscalls:sys_enter_read { print("Kernel Stack\n"); print(kstack()); }'
>> the output will be
>> ===
>>    Kernel Stack
>> ===
>>
>> Further analysis shows that pt_regs used for bpf syscall tracepoint
>> tracing is from the one constructed during user->kernel transition.
>> The call stack looks like
>>    perf_syscall_enter+0x88/0x7c0
>>    trace_sys_enter+0x41/0x80
>>    syscall_trace_enter+0x100/0x160
>>    do_syscall_64+0x38/0xf0
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> The ip address stored in pt_regs is from user space hence no kernel
>> stack is printed.
>>
>> To fix the issue, we need to use kernel address from pt_regs.
>> In kernel repo, there are already a few cases like this. For example,
>> in kernel/trace/bpf_trace.c, several perf_fetch_caller_regs(fake_regs_ptr)
>> instances are used to supply ip address or use ip address to construct
>> call stack.
>>
>> The patch follows the above example by using a fake pt_regs.
>> The pt_regs is stored in local stack since the syscall tracepoint
>> tracing is in process context and there are no possibility that
>> different concurrent syscall tracepoint tracing could mess up with each
>> other. This is similar to a perf_fetch_caller_regs() use case in
>> kernel/trace/trace_event_perf.c with function perf_ftrace_function_call()
>> where a local pt_regs is used.
>>
>> With this patch, for the above bpftrace script, I got the following output
>> ===
>>    Kernel Stack
>>
>>          syscall_trace_enter+407
>>          syscall_trace_enter+407
>>          do_syscall_64+74
>>          entry_SYSCALL_64_after_hwframe+75
>> ===
>>
>> Reported-by: Salvatore Benedetto <salvabenedetto@meta.com>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/trace/trace_syscalls.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
> Note, we need to solve the same for perf_call_bpf_exit().

Sorry, missed this one! Will add in the next revision.

>
> pw-bot: cr
>
>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
>> index 9c581d6da843..063f51952d49 100644
>> --- a/kernel/trace/trace_syscalls.c
>> +++ b/kernel/trace/trace_syscalls.c
>> @@ -559,12 +559,15 @@ static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *re
> let's also drop struct pt_regs * argument into
> perf_call_bpf_{enter,exit}(), they are not actually used anymore

Ack.

>
>>                  int syscall_nr;
>>                  unsigned long args[SYSCALL_DEFINE_MAXARGS];
>>          } __aligned(8) param;
>> +       struct pt_regs fake_regs;
>>          int i;
>>
>>          BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
>>
>>          /* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &param) */
>> -       *(struct pt_regs **)&param = regs;
>> +       memset(&fake_regs, 0, sizeof(fake_regs));
> sizeof(struct pt_regs) == 168 on x86-64, and on arm64 it's a whopping
> 336 bytes, so these memset(0) calls are not free for sure.

I calculated size on x86-64 and feels it might be acceptable.
But not aware that arm64 has much larger size like 336. Indeed
336 bytes on the stack is quite large.

>
> But we don't need to do this unnecessary work all the time.
>
> I initially was going to suggest to use get_bpf_raw_tp_regs() from
> kernel/trace/bpf_trace.c to get a temporary pt_regs that was already
> memset(0) and used to initialize these minimal "fake regs".
>
> But, it turns out we don't need to do even that. Note
> perf_trace_buf_alloc(), it has `struct pt_regs **` second argument,
> and if you pass a valid pointer there, it will return "fake regs"
> struct to be used. We already use that functionality in
> perf_trace_##call in include/trace/perf.h (i.e., non-syscall
> tracepoints), so this seems to be a perfect fit.

I double checked and perf_call_bpf_enter() call is in atomic
process context (preempt disabled), so we are safe to use
perf_trace_buf_alloc() which uses per-cpu variables.

>
>> +       perf_fetch_caller_regs(&fake_regs);
>> +       *(struct pt_regs **)&param = &fake_regs;
>>          param.syscall_nr = rec->nr;
>>          for (i = 0; i < sys_data->nb_args; i++)
>>                  param.args[i] = rec->args[i];
>> --
>> 2.43.5
>>

