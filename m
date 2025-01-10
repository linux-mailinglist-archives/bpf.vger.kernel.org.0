Return-Path: <bpf+bounces-48497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EAAA08436
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52F93A39DA
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFC2B9C6;
	Fri, 10 Jan 2025 00:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5222EEB5
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736470626; cv=none; b=CNXG3h4/UDXcPKJFFjKqLtlT9CxLGsr8qYvFumSI70nZA06b/HT3H1SXZFbPE3EmkISzVNt2F5U5X6l1WkXpP75jeJuZhLBqoc33NNtNtU17XZcNvMOogiGwkJ0tF5yhlQwLxau2tcjKU+xUg/qbX8MKjyaag1dqRlf6uKHbeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736470626; c=relaxed/simple;
	bh=r1f0FHKsJigZnA8kIV2yMDckxre7Zyzxmy+Ic02KX40=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GCFyBEvREAc2hV4aVY5NBkuv87f1k9U/fpU0Z2bBxMp8DGVyJY1805zPYA1SgwyJG0QeNUl3Gv8T9jr7dYNR4BCwkFM3fkImpMOkV7m8umQwrwTt/S4jez8wyBngibxKKzLfoRZZswJFkaHJysD/YtnspuLn42PgaF7hVLgs3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YTjsH08BBz4f3khS
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 08:56:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3FAD11A0CCC
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 08:56:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDHGcRTcIBnlQMRAg--.14330S2;
	Fri, 10 Jan 2025 08:56:55 +0800 (CST)
Subject: Re: [PATCH bpf-next 0/7] Free htab element out of bucket lock
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xukuohai@huawei.com,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
 <9b4ebbaf-dd3c-85a4-2d17-18b8805ea5fb@huaweicloud.com>
 <9685012a-1332-95a1-a8ef-dfd25f5cd072@huaweicloud.com>
 <20250108072906.chgNtc8S@linutronix.de>
 <2728739a-5c6a-acbe-2231-7dd1c52d5826@huaweicloud.com>
 <20250108091643.FjZcvyLV@linutronix.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <356137c5-283b-2c6a-564d-8985dbff9d0a@huaweicloud.com>
Date: Fri, 10 Jan 2025 08:56:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250108091643.FjZcvyLV@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDHGcRTcIBnlQMRAg--.14330S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45KF13Ww1ftw1kGF47CFg_yoW8ZF17pa
	y7ta4a9r48Xr109r1jyF4kJryYqws3GryfJ348XFW5Crn8XFn0qan29a909F429rs2yanF
	qr4Fva48ZF98ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/8/2025 5:16 PM, Sebastian Andrzej Siewior wrote:
> On 2025-01-08 17:06:06 [+0800], Hou Tao wrote:
>> Hi,
> Hi,
>
>> On 1/8/2025 3:29 PM, Sebastian Andrzej Siewior wrote:
>>> On 2025-01-08 09:24:02 [+0800], Hou Tao wrote:
>>>> @Sebastian
>>>> Is it possible that softirq_expiry_lock is changed to a raw-spin-lock
>>>> instead ?
>>> No. The point is to PI-boost the timer-task by the task that is
>>> canceling the timer. This is possible if the timer-task got preempted by
>>> the canceling task - both can't be migrated to another CPU and if the
>>> canceling task has higher priority then it will continue to spin and
>>> live lock the system.
>>> Making the expire lock raw would also force every timer to run with
>>> disabled interrupts which would not allow to acquire any spinlock_t
>>> locks.
>> Thanks for the explanation. However I still can not understand why
>> making the expire lock raw will force every timer to run with disabled
>> interrupt. 
> I'm sorry. Not disabled interrupts but preemption. hrtimer_run_softirq()
> acquires the lock via hrtimer_cpu_base_lock_expiry() and holds it while
> during __hrtimer_run_queues() -> __run_hrtimer(). Only
> hrtimer_cpu_base::lock is dropped before the timer is invoked.
> If preemption is disabled you can not acquire a spinlock_t.
>
>>            In my simple understanding, hrtimer_cpu_base_lock_expiry()
>> doesn't disable the irq. Do you mean if change the expire lock to raw,
>> it also needs to disable the irq to prevent something from happening,
>> right ? 
> No, see the above, it should clear things up.
>
>>         Also does the raw spinlock have the PI-boost functionality ?
> No. Blocking on a raw_spinlock_t means to spin until it is its turn to
> acquire the lock.
> The spinlock_t becomes a rt_mutex on PREEMPT_RT and blocking on a lock
> means: give current priority to lock owner (= Priority Inheritance) + go
> to sleep until lock becomes available.

Thanks for the detailed explanation. I got it now.
>
> Sebastian


