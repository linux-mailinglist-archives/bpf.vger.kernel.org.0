Return-Path: <bpf+bounces-65045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2D4B1B104
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 11:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C11E189E69E
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4126056C;
	Tue,  5 Aug 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrHaLIAK"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4D25F7B5
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386103; cv=none; b=PyNE5Kmg0l7e62qwsR6WHY1fd23e2yWCk/mZmiJjuUtiuMgPsDB0U/beYrR2LItWL62E8NuuIEdFD/bxqDPh4fGGfkgZrFzSROLOep6cMIm7sAi6gDZqRy2WoV4w9Zs3jbmlU9J6mQ/WAX4vuGmYWxzNuVEvTlxXKSS3Yu5Qa30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386103; c=relaxed/simple;
	bh=7+uUq409iofdj2E1aMxnCZHDona4pEtANeAruxc2xIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUxGX4PUrQUtdBEKKDYgBq7X+gmtyDFPwb9yy1TDajMTCw9KQq2K0G+9dRrb+EhlbVYU6rRrNyMrNK+SLgnlKQg7+A+4Ms8SQ+1i/xWTwLzMylPzQWD5kFL9ecq0rpwU/qvAnlY6NP+/7bjjBwcUHdx3on0j6OmwpUsXWWlP+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrHaLIAK; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a365a7ae-fee1-4148-9b5b-9593fde7f6f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754386087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GufKtQSI/m9hW3OZjr51F0H/hsgTIHHhk7SWxhmKDc=;
	b=SrHaLIAK/uStZRspzxcrw8fCE4LQ0pXWAYHIIhgZYLlZ5prbLqZKWuJJn38ExqHWfae6TB
	cHjoItHFO5izEwwLj44KSjDUBf9HbkI0ildovbH9IzY0q2dE0mf0xcs3gC7c0jnUDNiWwq
	78JbHlgs8jJ/V0cSuhblBsB1AgGTCmM=
Date: Tue, 5 Aug 2025 17:27:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Disable migrate when kprobe_multi attach to
 access bpf_prog_active
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250804121615.1843956-1-chen.dylane@linux.dev>
 <aJCvY7G-gVR8taLh@krava> <c5e66881-2fca-479b-9ef6-c9ada34e731c@linux.dev>
 <aJHJu6dOeKVIc7JV@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aJHJu6dOeKVIc7JV@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/5 17:07, Jiri Olsa 写道:
> On Mon, Aug 04, 2025 at 10:15:46PM +0800, Tao Chen wrote:
>> 在 2025/8/4 21:02, Jiri Olsa 写道:
>>> On Mon, Aug 04, 2025 at 08:16:15PM +0800, Tao Chen wrote:
>>>> The syscall link_create not protected by bpf_disable_instrumentation,
>>>> accessing percpu data bpf_prog_active should use cpu local_lock when
>>>> kprobe_multi program attach.
>>>>
>>>> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>> ---
>>>>    kernel/trace/bpf_trace.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>> index 3ae52978cae..f6762552e8e 100644
>>>> --- a/kernel/trace/bpf_trace.c
>>>> +++ b/kernel/trace/bpf_trace.c
>>>> @@ -2728,23 +2728,23 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>>>>    	struct pt_regs *regs;
>>>>    	int err;
>>>> +	migrate_disable();
>>>>    	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
>>>
>>> this is called all the way from graph tracer, which disables preemption in
>>> function_graph_enter_regs, so I think we can safely use __this_cpu_inc_return
>>>
>>>
>>>>    		bpf_prog_inc_misses_counter(link->link.prog);
>>>>    		err = 1;
>>>>    		goto out;
>>>>    	}
>>>> -	migrate_disable();
>>>
>>> hum, but now I'm not sure why we disable migration in here then
>>>
>>
>> It seems that there is a cant_migrate() check in bpf_prog_run, so it should
>> be disabled before run.
> 
> yes, but disabled preemption will take care of that
> 

I see, you are right, preempt will pass the check, thanks.

void __cant_migrate(const char *file, int line)
{
         static unsigned long prev_jiffy;

         if (irqs_disabled())
                 return;

         if (is_migration_disabled(current))
                 return;

         if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
                 return;

         if (preempt_count() > 0)
                 return;
...

> I think we can do change below plus some comment that Yonghong
> is suggesting in the other reply
> 

Yes, i will remove the migrate_disable and add some comment as you
and Yonghong suggested.

> jirka
> 
> 
> ---
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3ae52978cae6..74e8d9543c6d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2734,14 +2734,12 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>   		goto out;
>   	}
>   
> -	migrate_disable();
>   	rcu_read_lock();
>   	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
>   	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>   	err = bpf_prog_run(link->link.prog, regs);
>   	bpf_reset_run_ctx(old_run_ctx);
>   	rcu_read_unlock();
> -	migrate_enable();
>   
>    out:
>   	__this_cpu_dec(bpf_prog_active);
-- 
Best Regards
Tao Chen

