Return-Path: <bpf+bounces-65509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68351B248E0
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 13:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C07626DEA
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE72580FF;
	Wed, 13 Aug 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vsPo1o3C"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4C2F3C05
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086115; cv=none; b=reJMxFSpx/0auj4ZD7KYlLNjpfP+CxEjAwXIL7PNUYoys1Ob1BdFPNy5XHd3aVZBkcxtGKEdLw3hsoQrYSFGXQyCNubO8BlV6quLHw9J4lwxGGvteNg6WabvElyTVcFeyInvyXIpni7C8+5NLgZqXV0bq27fk8RQXpEbU9qv3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086115; c=relaxed/simple;
	bh=4zgPSyly5j+2ic+v/OEjd+JLtCPbpHrod1cPnZveUck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUffoCDAuDuPknuLabjj2/+NDlmWxIBWBH6bOZL5rY0WTyaSaBDdxs+FymecPKkcT1PgfMuB9sdkQTdU6mDsSdGx7pmVU9/o5wAT9wIxMvGfh7oCYebPHLLCsAbzTUZqKaNmreBKLrlXuyw/Ii2KS6C1s3rz3gZB0S6M3RAmkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vsPo1o3C; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4233d7e9-b563-4c48-beda-b00ac5b4c643@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755086110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYpkFazY9ZxpdLr2rax5brD6HKsU3F4bNK5sjQtebPs=;
	b=vsPo1o3CtAXTJ4hAtFzoFmP5dVRt3poeUDkc/+dwCT+D5Jhbb+SJUsBWYBBgYOBQZ6dU+h
	XohG+JW4D0XvovWnQljBb67f2HJsTcsQINK0UQBY3RaOAPRZlM8fJLoXvRp600X3Psp2AB
	VP+wVSHIBuAa+UM7jxlUQg58og662JM=
Date: Wed, 13 Aug 2025 19:54:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Remove migrate_disable in
 kprobe_multi_link_prog_run
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250805162732.1896687-1-chen.dylane@linux.dev>
 <CAEf4BzZduEdBCzm56zwgrHpzV=CsMbzfVi5oR9w3H4vUQL6FYw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzZduEdBCzm56zwgrHpzV=CsMbzfVi5oR9w3H4vUQL6FYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/13 06:05, Andrii Nakryiko 写道:
> On Tue, Aug 5, 2025 at 9:28 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> bpf program should run under migration disabled, kprobe_multi_link_prog_run
>> called all the way from graph tracer, which disables preemption in
>> function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
>> need to use migrate_disable. As a result, some overhead maybe will be
>> reduced.
>>
>> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> Change list:
>>   v1 -> v2:
>>    - s/called the way/called all the way/.(Jiri)
>>   v1: https://lore.kernel.org/bpf/f7acfd22-bcf3-4dff-9a87-7c1e6f84ce9c@linux.dev
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 3ae52978cae..5701791e3cb 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2734,14 +2734,19 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> 
> even though bpf_prog_run() eventually calls cant_migrate(), we should
> add it before that __this_cpu_inc_return() call as well, because that
> one is relying on that non-migration independently from bpf_prog_run()
> 

Hi Andrii,

There is __this_cpu_preempt_check in __this_cpu_inc_return, and the 
judgment criteria are similar to cant_migrate, and I'm not sure if it
is enough.

>>                  goto out;
>>          }
>>
>> -       migrate_disable();
>> +       /*
>> +        * bpf program should run under migration disabled, kprobe_multi_link_prog_run
>> +        * called all the way from graph tracer, which disables preemption in
>> +        * function_graph_enter_regs, so there is no need to use migrate_disable.
>> +        * Accessing the above percpu data bpf_prog_active is also safe for the same
>> +        * reason.
>> +        */
> 
> let's shorten this a bit to something like:
> 
> /* graph tracer framework ensures we won't migrate */
will change it in v3.

> cant_migrate();
> 
> all the other stuff in the comment can become outdated way too easily
> and/or is sort of general BPF implementation knowledge
> 
> pw-bot: cr
> 
> 
>>          rcu_read_lock();
>>          regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
>>          old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>>          err = bpf_prog_run(link->link.prog, regs);
>>          bpf_reset_run_ctx(old_run_ctx);
>>          rcu_read_unlock();
>> -       migrate_enable();
>>
>>    out:
>>          __this_cpu_dec(bpf_prog_active);
>> --
>> 2.48.1
>>
-- 
Best Regards
Tao Chen

