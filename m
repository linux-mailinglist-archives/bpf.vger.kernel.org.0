Return-Path: <bpf+bounces-68794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C927EB84DDE
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751BD3B9845
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CCB308F31;
	Thu, 18 Sep 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uxz/gRGB"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AC308F0D
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202512; cv=none; b=fEO8sKd5qtebP7L4dt4enfAVPo8+53gWnpRPLSkfiIpXuQW/HhqFY+te0qx5LWonYNSkGhU238EXYfAOb8jATwIr1OHiJt689KfO2IIeWTaDAMJlF2b7cuxWJZIboZjjSOQgGBPn9WyS4JeE2Y/NtDDbeBGRvtPMNeVSdRFvlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202512; c=relaxed/simple;
	bh=fAwbvtxv0yxYzUyTrUPBthDj0WzMiVdnsl4hRpevSc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENwZOhknp9qjwO53sa3Ty/kMYeOxM+BVBMisPDozpaXnrCgYvpcJ6izlHgO1M07BJ68IbYQc+zC3/JGj4FO9WXmiC1JHosPXf+8TTVj2Y0d3Y44qLnYuBSlCBxIw3NKAanZnv+Y/xNWgZkuH0xO2L8tT+FO1f47rVmwNH1Rv1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uxz/gRGB; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <457b805f-ea5c-460e-b93f-b7b63f3358af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758202507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7h5hhwXpE9R2dmZ7dBQ21qFNe8mjOdRa/SiXX2IBDE=;
	b=Uxz/gRGBDZxwobYS6mlhBBRauctYIuXKvgfOWeST0WwcDqeQFHaW6tnOtRszG72tBYD1Zh
	DBTiR23NdRRWYJx2IfWis78YnfGeEBUd8cmS3JGNRs2f6xD+V9YxBn72PEtp1+Yil0OkIN
	gxh3iYv9LPPSM5Vd1yNLdMt14Jl/q78=
Date: Thu, 18 Sep 2025 21:34:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add lookup_and_delete_elem for
 BPF_MAP_STACK_TRACE
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/18 09:35, Alexei Starovoitov 写道:
> On Wed, Sep 17, 2025 at 3:16 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>>
>> P.S. It seems like a good idea to switch STACKMAP to open addressing
>> instead of the current kind-of-bucket-chain-but-not-really
>> implementation. It's fixed size and pre-allocated already, so open
>> addressing seems like a great approach here, IMO.
> 
> That makes sense. It won't have backward compat issues.
> Just more reliable stack_id.
> 
> Fixed value_size is another footgun there.
> Especially for collecting user stack traces.
> We can switch the whole stackmap to bpf_mem_alloc()
> or wait for kmalloc_nolock().
> But it's probably a diminishing return.
> 
> bpf_get_stack() also isn't great with a copy into
> perf_callchain_entry, then 2nd copy into on stack/percpu buf/ringbuf,
> and 3rd copy of correct size into ringbuf (optional).
> 
> Also, I just realized we have another nasty race there.
> In the past bpf progs were run in preempt disabled context,
> but we forgot to adjust bpf_get_stack[id]() helpers when everything
> switched to migrate disable.
> 
> The return value from get_perf_callchain() may be reused
> if another task preempts and requests the stack.
> We have partially incorrect comment in __bpf_get_stack() too:
>          if (may_fault)
>                  rcu_read_lock(); /* need RCU for perf's callchain below */
> 
> rcu can be preemptable. so rcu_read_lock() makes
> trace = get_perf_callchain(...)
> accessible, but that per-cpu trace buffer can be overwritten.
> It's not an issue for CONFIG_PREEMPT_NONE=y, but that doesn't
> give much comfort.

Hi Alexei,

Can we fix it like this?

-       if (may_fault)
-               rcu_read_lock(); /* need RCU for perf's callchain below */
+       preempt_diable();

         if (trace_in)
                 trace = trace_in;
@@ -455,8 +454,7 @@ static long __bpf_get_stack(struct pt_regs *regs, 
struct task_struct *task,
                                            crosstask, false);

         if (unlikely(!trace) || trace->nr < skip) {
-               if (may_fault)
-                       rcu_read_unlock();
+               preempt_enable();
                 goto err_fault;
         }

@@ -475,9 +473,7 @@ static long __bpf_get_stack(struct pt_regs *regs, 
struct task_struct *task,
                 memcpy(buf, ips, copy_len);
         }

-       /* trace/ips should not be dereferenced after this point */
-       if (may_fault)
-               rcu_read_unlock();
+       preempt_enable();

> 
> Modern day bpf api would probably be
> - get_callchain_entry()/put() kfuncs to expose low level mechanism
> with safe acq/rel of temp buffer.
> - then another kfuncs to perf_callchain_kernel/user into that buffer.
> 
> and with bpf_mem_alloc and hash kfuncs the bpf prog can
> implement either bpf_get_stack() equivalent or much better
> bpf_get_stackid() with variable length stack traces and so on.


-- 
Best Regards
Tao Chen

