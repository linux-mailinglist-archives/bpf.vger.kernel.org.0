Return-Path: <bpf+bounces-48622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA117A0A0BE
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 05:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0173AAE75
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 04:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AB114A635;
	Sat, 11 Jan 2025 04:07:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD71CFBC
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 04:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736568468; cv=none; b=XjrOHpQAuc3XmVJet5qQWY4tHOnIpjmTzOAUrNfpmqdSc850ypqazX7+o2XhcoNEf3VrfwD9aQIsdp5ckSRF2lbaU5RJU8bH7VC0i94/rZ4TIPO2yqg6SzgkdlsAXH9Pq3dqHBsBV8Hcu6pKT1k4BXjgbz6yTi1qVnH4Ek6cs34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736568468; c=relaxed/simple;
	bh=9ycOKiilFfLm3S8tAZW8o0XhN4AQOOJ70AgvyAw6Rpo=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ek8u9fQMJiv/MdYV7jTCUvHSQPfqlVYWF9d+dVpvWcQCT3dL1KA/Z7jDrQP0OeKPdGDkkNbooJk6s3ZQtmjNHkHgBjObDanKWjX9O7YDkSTSfB5MUFis6oZXGCmaTlRIjgTjJpLY8+lcwUsgCgDPtWCjOLAmz3fAI01V72wK1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YVQ2p0ML4z4f3jHh
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 12:07:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 50DBD1A018C
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 12:07:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgC3wmWB7oFnShOCAg--.46013S2;
	Sat, 11 Jan 2025 12:07:32 +0800 (CST)
Subject: Re: status of BPF in conjunction with PREEMPT_RT for the 6.6 kernel?
To: Chris Friesen <chris.friesen@windriver.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <48d18ecf-41eb-4025-9bec-1dc606f343c3@windriver.com>
 <d39cfb84-7b0e-e73b-f2ba-bee32e883a48@huawei.com>
 <94a4475f-51a8-4113-b16f-c2239eb01537@windriver.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <272e073f-01e4-7b73-7404-8fe93297df1e@huaweicloud.com>
Date: Sat, 11 Jan 2025 12:07:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <94a4475f-51a8-4113-b16f-c2239eb01537@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgC3wmWB7oFnShOCAg--.46013S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4ruw1xGr45tFyUWrWkXrb_yoW5GFyxpF
	40kF4Yqr4qvwnFywsFyw48uFyjkw4fJF4Y9r95JrW8Zw4jgF9Ygw4FgFWa9FZ0vrs5Gw40
	vr4jva4xX395Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/10/2025 11:05 PM, Chris Friesen wrote:
>
> Thanks for the info.
>
> Our system is mostly used for DPDK applications, which are basically
> latency-sensitive busy-looping CPU hogs that rarely make syscalls, so
> they want to run on the RT kernel to minimize interruptions.   There
> are various BPF-based tools and optimizations that I have been hearing
> about, and I was just wondering if they could now be used on RT
> kernels and if so whether there are any potential problems.
>

I see.
>
>
> I did have one additional question...some time back (on the 5.10
> kernel with RT patches) we noted that when net.core.bpf_jit_enable was
> enabled, merely restarting some systemd services would be enough to
> cause function call inter-processor interrupts on all CPUs, even
> isolated ones.  (Thus interrupting the RT tasks.)   Is that still the
> case?
>

I think the IPI may be due to kernel TLB flush. When bpf jit is enabled,
the memory allocated for the bpf program will be marked as executable,
and during the free of bpf program, the exec permission needs to be
cleared. The clearing of permission bit involves the update of kernel
page table, therefore, TLB flush is needed. I think the TLB flush will
still be there, however, the introduction of pack allocator in v5.18 in
bpf may alleviate it.
>
> Thanks,
>
> Chris
>
>
> On 1/9/2025 8:06 PM, Hou Tao wrote:
>> Hi,
>>
>> On 1/10/2025 6:21 AM, Chris Friesen wrote:
>>> Hi,
>>>
>>> Back in 2019 there were some concerns raised
>>> (https://lwn.net/ml/bpf/20191017090500.ienqyium2phkxpdo@linutronix.de/#t)
>>> around using BPF in conjunction with PREEMPT_RT.
>>>
>>> In the context of the 6.6 kernel and the corresponding PREEMPT_RT
>>> patchset, are those concerns still valid or have they been sorted out?
>>>
>>> Please CC me on replies, I'm not subscribed to the list.
>> Do you have any use case for BPF + PREEMPT_RT ?  I am not a RT expert,
>> however, In my understanding, BPF + PREEMPT_RT in the vanilla kernel
>> basically can work togerther basically. The memory allocation concern is
>> partially resolved and there is still undergoing effort trying to
>> resolve it [1]. The up_read_non_owner problem has been avoided
>> explicitly and the non-preemptible context for bpf prog has also been
>> fixed. Although the running of test_maps and test_progs under PREEMPT_RT
>> report some problems, I think these problem could be fixed. As for v6.6,
>> I think it may be OK for BPF + PREEMPT_RT case.
>>
>> [1]:
>> https://lore.kernel.org/bpf/20241210023936.46871-1-alexei.starovoitov@gmail.com/
>>> Thanks,
>>> Chris Friesen
>>>
>>>
>>> .
>
>


