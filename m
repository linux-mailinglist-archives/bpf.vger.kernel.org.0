Return-Path: <bpf+bounces-68884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84977B87AF8
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4713A1C249E3
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6724167B;
	Fri, 19 Sep 2025 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dM/y0rd8"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2B1E5B7B;
	Fri, 19 Sep 2025 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247707; cv=none; b=mfppu3j5Ss2Xt/mZ7o15haTsQUW8DbbqbrOGHRAtrVtbpc4s30kQzkDeWBPRP0Vcolw3iyshYj+5HpBuTkPxHTgONBIDEce6sBDw3ZAr7fhNMoMIabprFjVQ4i7T1rvE69rZAs8vO7Br3F7zORtUSCky3zcrhDCyYN3/HsOF7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247707; c=relaxed/simple;
	bh=5O+SIGhkMyMmuCiwUMfFEw1KmCrM/gjkalNI7yAalyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmoiG4O2P5QTO3N/PoUWApxdOJg2aWINJ9219ebYs80epl3JFizjUjW9EEgo6F0e/ugNA9J4wJ/p1Q/jY3I5I/Nvby1UVPlsyR/EEF4itx1YPjXrcT8D6In2VtnwzbRO7psmRJqv+7FfwqPtDE9jLI20PYfg1T4jwqBleB8363g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dM/y0rd8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2fd90a9-bc7d-43b8-ac5e-9d233219dcfb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758247702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tZscgbFVsEFOWM0JAk5UA5kEEjC9yHFCKayOOMGeKM=;
	b=dM/y0rd8XN5hSogJYtcmrpiytG/B6jbviWIcMucYxiDU3b1yJTlyCT0X+jucrJ/QgUed6g
	onPmGzhRRIFX9XzGqQjMMlQRv960fJ9ASYAOlp/RJWvuTzrl88Ljcnay1iuxsr2SFTZpRl
	YfT1lUxkRHP+pwD60Ooij/AclXkWdLM=
Date: Fri, 19 Sep 2025 10:08:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add lookup_and_delete_elem for
 BPF_MAP_STACK_TRACE
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250909163223.864120-1-chen.dylane@linux.dev>
 <CAEf4BzZ2Fg+AmFA-K3YODE27br+e0-rLJwn0M5XEwfEHqpPKgQ@mail.gmail.com>
 <CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com>
 <457b805f-ea5c-460e-b93f-b7b63f3358af@linux.dev>
 <CAADnVQLwV=fUkgLF3uTmevA97WX2FH4vG-7=97Px0H_WJOJieQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQLwV=fUkgLF3uTmevA97WX2FH4vG-7=97Px0H_WJOJieQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/19 10:01, Alexei Starovoitov 写道:
> On Thu, Sep 18, 2025 at 6:35 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> 在 2025/9/18 09:35, Alexei Starovoitov 写道:
>>> On Wed, Sep 17, 2025 at 3:16 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>
>>>>
>>>> P.S. It seems like a good idea to switch STACKMAP to open addressing
>>>> instead of the current kind-of-bucket-chain-but-not-really
>>>> implementation. It's fixed size and pre-allocated already, so open
>>>> addressing seems like a great approach here, IMO.
>>>
>>> That makes sense. It won't have backward compat issues.
>>> Just more reliable stack_id.
>>>
>>> Fixed value_size is another footgun there.
>>> Especially for collecting user stack traces.
>>> We can switch the whole stackmap to bpf_mem_alloc()
>>> or wait for kmalloc_nolock().
>>> But it's probably a diminishing return.
>>>
>>> bpf_get_stack() also isn't great with a copy into
>>> perf_callchain_entry, then 2nd copy into on stack/percpu buf/ringbuf,
>>> and 3rd copy of correct size into ringbuf (optional).
>>>
>>> Also, I just realized we have another nasty race there.
>>> In the past bpf progs were run in preempt disabled context,
>>> but we forgot to adjust bpf_get_stack[id]() helpers when everything
>>> switched to migrate disable.
>>>
>>> The return value from get_perf_callchain() may be reused
>>> if another task preempts and requests the stack.
>>> We have partially incorrect comment in __bpf_get_stack() too:
>>>           if (may_fault)
>>>                   rcu_read_lock(); /* need RCU for perf's callchain below */
>>>
>>> rcu can be preemptable. so rcu_read_lock() makes
>>> trace = get_perf_callchain(...)
>>> accessible, but that per-cpu trace buffer can be overwritten.
>>> It's not an issue for CONFIG_PREEMPT_NONE=y, but that doesn't
>>> give much comfort.
>>
>> Hi Alexei,
>>
>> Can we fix it like this?
>>
>> -       if (may_fault)
>> -               rcu_read_lock(); /* need RCU for perf's callchain below */
>> +       preempt_diable();
>>
>>           if (trace_in)
>>                   trace = trace_in;
>> @@ -455,8 +454,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
>> struct task_struct *task,
>>                                              crosstask, false);
>>
>>           if (unlikely(!trace) || trace->nr < skip) {
>> -               if (may_fault)
>> -                       rcu_read_unlock();
>> +               preempt_enable();
>>                   goto err_fault;
>>           }
>>
>> @@ -475,9 +473,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
>> struct task_struct *task,
>>                   memcpy(buf, ips, copy_len);
>>           }
>>
>> -       /* trace/ips should not be dereferenced after this point */
>> -       if (may_fault)
>> -               rcu_read_unlock();
>> +       preempt_enable();
> 
> That should do it. Don't see an issue at first glance.

Ok, i will send a patch later, thanks.

-- 
Best Regards
Tao Chen

