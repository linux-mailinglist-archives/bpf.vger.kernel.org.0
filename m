Return-Path: <bpf+bounces-65055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 665DDB1B36A
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 14:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5306B18809BC
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEBA271471;
	Tue,  5 Aug 2025 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="guaEMK7+"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7A271458
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396948; cv=none; b=YYFVrPtnhPRbPtHiOTMwKoVnyG5clZOwHzqdCn4erQZHmv7hfpDln81fZ8CJZzyMnJuTYb2Y4ekQg5Go29JSULl88b+gqPUkHxeSUEqR3LlgbS3Kp0EJOJp8Pz9l8UkAfEbZKWRYr8wk9hNZaEBorNNAT2+TO4B4Pp65bi7tY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396948; c=relaxed/simple;
	bh=jQI3r5EcHpVmvb0kE+VVHZ2s5vS4vaedPS/qBJTjkJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzIejFBc6E+kDX2QaWEl79rYtMSOFg49Hc01nofB1iK01mNQbq36Uzs3hlEISaKLwO7vl6Fh/zhxlDHtSlxg5l3b8l1lmGUm249EEZ0S5Hye7epUZNcSv0iIXtImOp2T0iD9WRO/eXtQDTi1d/8HcR5AoCStgdC0H8erQQyyufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=guaEMK7+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a931aca-1aad-41e4-8449-89f48121abba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754396943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckYT6H+4ykVzg0eOUxMZqle5eJFuVeA2UGYUlhfYHG4=;
	b=guaEMK7+1o0ANEzCQZ+8hTcY+qFUMroxIncUJG7XG6DOuqpSI56dNDuudGOyDJCUxv1yZk
	zSWOKeYN3X4BQ9ow/3vxvK+uhpgQ5CcgRN2k3Hfj7Fxil3vRPZUihC4nhwTzKpHpxADjdQ
	7ia33uIK8AZ3GorOkgqc3INtLWjjd6M=
Date: Tue, 5 Aug 2025 20:28:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Disable migrate when kprobe_multi attach to
 access bpf_prog_active
To: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250804121615.1843956-1-chen.dylane@linux.dev>
 <aJCvY7G-gVR8taLh@krava> <3cf22505-e338-4cc1-ab76-896bfc336b40@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <3cf22505-e338-4cc1-ab76-896bfc336b40@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/5 12:05, Yonghong Song 写道:
> 
> 
> On 8/4/25 6:02 AM, Jiri Olsa wrote:
>> On Mon, Aug 04, 2025 at 08:16:15PM +0800, Tao Chen wrote:
>>> The syscall link_create not protected by bpf_disable_instrumentation,
>>> accessing percpu data bpf_prog_active should use cpu local_lock when
>>> kprobe_multi program attach.
>>>
>>> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>> ---
>>>   kernel/trace/bpf_trace.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index 3ae52978cae..f6762552e8e 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -2728,23 +2728,23 @@ kprobe_multi_link_prog_run(struct 
>>> bpf_kprobe_multi_link *link,
>>>       struct pt_regs *regs;
>>>       int err;
>>> +    migrate_disable();
>>>       if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
>> this is called all the way from graph tracer, which disables 
>> preemption in
>> function_graph_enter_regs, so I think we can safely use 
>> __this_cpu_inc_return
> 
> Agree. migrate_disable() is not needed here. But it would be great to 
> add some
> comments here since for most other prog_run, they typically have 
> migrate_disable/enable.
> 
>>
>>
>>>           bpf_prog_inc_misses_counter(link->link.prog);
>>>           err = 1;
>>>           goto out;
>>>       }
>>> -    migrate_disable();
>> hum, but now I'm not sure why we disable migration in here then
> 
> Probably a oversight.
> 
>>
>> jirka
>>
>>>       rcu_read_lock();
>>>       regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
>>>       old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>>>       err = bpf_prog_run(link->link.prog, regs);
>>>       bpf_reset_run_ctx(old_run_ctx);
>>>       rcu_read_unlock();
>>> -    migrate_enable();
>>>    out:
>>>       __this_cpu_dec(bpf_prog_active);
>>> +    migrate_enable();
>>>       return err;
>>>   }
>>> -- 
>>> 2.48.1
>>>
> 

Hi Jiri, Yonghong,

I send another patch as you suggested, pls review it, thanks.

https://lore.kernel.org/bpf/20250805122312.1890951-1-chen.dylane@linux.dev

-- 
Best Regards
Tao Chen

