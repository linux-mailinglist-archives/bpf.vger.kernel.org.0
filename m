Return-Path: <bpf+bounces-44824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65A09C80EF
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 03:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FE11F224CC
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 02:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497471E7C0F;
	Thu, 14 Nov 2024 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dkWWRN/u"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DA18BBB6
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552241; cv=none; b=l7CkGzwWlyTHW3qlQYdWi6Mu1th+qkmOEuJ49TIHzEjskbg9jtWYzid94SWfDdhuUlG9QHYH+VsHlm/8jED0FcvhDqovTrqo0mObQva9OBkugslTlcJgGcSKCY7KzDxxly1RxpVISMuvsfGNimbiUH/Urkwj1mTV314jox4baxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552241; c=relaxed/simple;
	bh=6iJY4ltv672XaXhf4m/gfXZErkmr1WtPDKD10agsoZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3aWr3J4XItgvXportn7PZOn4ad35MjTBV7umVQJu7Z5g5P9eRV7+BwVztkowRF1MLkq0quQfiZ+LbN8A0ZTfrkH+4Rms2OoqUoM99KzuQ1SN+SXFREWlITX/mpfV+OwbC7B1xr23Yrs5NtSoEjux4yP0ZTT1tgC0ehvT7OwZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dkWWRN/u; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731552237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtMocB/TdMcBvjfzykmOTKc5Oyowa+q8EiSBYJLs9xQ=;
	b=dkWWRN/ujLHTS1d8V5Ln376KZiQmYUn4Sxtsk0JU9FAmau0zlBpIhgsDY4zsEcvKLBKECI
	mqotRk9XAh/JufM8+hoN1KD+QPLWvV+4Ya3UpVjsthCrJQzmuw9i8RyIDAqYAbyZxTOYNd
	PNKX6HAKwG7mTvRztuFcQSyx4pGGB1s=
Date: Thu, 14 Nov 2024 10:43:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Kunwu Chan <kunwu.chan@linux.dev>,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
 <87v7wsmqv4.ffs@tglx>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <87v7wsmqv4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks all for the reply.

On 2024/11/12 23:08, Thomas Gleixner wrote:
> On Fri, Nov 08 2024 at 14:32, Kunwu Chan wrote:
>> When PREEMPT_RT is enabled, 'spinlock_t' becomes preemptible
>> and bpf program has owned a raw_spinlock under a interrupt handler,
>> which results in invalid lock acquire context.
> This explanation is just wrong.
>
> The problem has nothing to do with an interrupt handler. Interrupt
> handlers on RT kernels are force threaded.
>
>>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>>   trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
>>   bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>>   bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>>   __bpf_prog_run include/linux/filter.h:701 [inline]
>>   bpf_prog_run include/linux/filter.h:708 [inline]
>>   __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
>>   bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2380
>>   trace_workqueue_activate_work+0x186/0x1f0 include/trace/events/workqueue.h:59
>>   __queue_work+0xc7b/0xf50 kernel/workqueue.c:2338
> The problematic lock nesting is the work queue pool lock, which is a raw
> spinlock.
>
>> @@ -330,7 +330,7 @@ static long trie_update_elem(struct bpf_map *map,
>>   	if (key->prefixlen > trie->max_prefixlen)
>>   		return -EINVAL;
>>   
>> -	spin_lock_irqsave(&trie->lock, irq_flags);
>> +	raw_spin_lock_irqsave(&trie->lock, irq_flags);
>>   
>>   	/* Allocate and fill a new node */
> Making this a raw spinlock moves the problem from the BPF trie code into
> the memory allocator. On RT the memory allocator cannot be invoked under
> a raw spinlock.
I'am newbiee in this field. But actually when i change it to a raw 
spinlock, the problem syzbot reported dispeared.
If don't change like this, we should do what to deal with this problem, 
if you have any good idea, pls tell me to do.
> Thanks,
>
>          tglx
>
-- 
Thanks,
   Kunwu.Chan


