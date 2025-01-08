Return-Path: <bpf+bounces-48229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2267A0565B
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF533A5023
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92681F4E2F;
	Wed,  8 Jan 2025 09:06:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60351F03F1
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327177; cv=none; b=ELgcrP3IYR2wzXA81Eo1Sna8c9AVZgQ5a4QSezeGHEYsD6Ga3tGXscAL5sPzMCU7nYKlM9oo5GsoUPiHGOvao/YNAZZuNX15R8biQ6BSjtMDU+HwlePusWK1Scu9Q9g0WPh16zPwNxg0v9224Q8sadnjjOvEUA6/nSvQ2sE+J8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327177; c=relaxed/simple;
	bh=ZS29Ox+M/g/NfVlX6mCBlPnQYrqSjZsPMZJN+TwQ8tg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fY7acwicFsHrYv3JG5RKkLfB9iaOttrZ/abYNOrNozpa8Iel4+4ieSN58lKBAQLQEyq70boMuWtJhxB+V/Dq7BspUXlGnn74CI+YuB1w8wneU6X/CzS3lV1HcmlHbEyR1ltHdogYfJvROxJSX+AofEoMeUk8V+h8RqVAA8Rcx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YShph6Nkhz4f3kvt
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 17:05:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 441B51A0E55
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 17:06:10 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB33Hz+P35nKCJ5AQ--.808S2;
	Wed, 08 Jan 2025 17:06:10 +0800 (CST)
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2728739a-5c6a-acbe-2231-7dd1c52d5826@huaweicloud.com>
Date: Wed, 8 Jan 2025 17:06:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250108072906.chgNtc8S@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB33Hz+P35nKCJ5AQ--.808S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW7try3tFW7tr1DXF1UZFb_yoWkJwbEk3
	WqvF97Xw15Jrs3tr1qka1qqr98CayUXF1UXr4DWr97t34Yy398CanY9rWfAFn7GanIkas8
	ArZIyF1xZw17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/8/2025 3:29 PM, Sebastian Andrzej Siewior wrote:
> On 2025-01-08 09:24:02 [+0800], Hou Tao wrote:
>> @Sebastian
>> Is it possible that softirq_expiry_lock is changed to a raw-spin-lock
>> instead ?
> No. The point is to PI-boost the timer-task by the task that is
> canceling the timer. This is possible if the timer-task got preempted by
> the canceling task - both can't be migrated to another CPU and if the
> canceling task has higher priority then it will continue to spin and
> live lock the system.
> Making the expire lock raw would also force every timer to run with
> disabled interrupts which would not allow to acquire any spinlock_t
> locks.

Thanks for the explanation. However I still can not understand why
making the expire lock raw will force every timer to run with disabled
interrupt. In my simple understanding, hrtimer_cpu_base_lock_expiry()
doesn't disable the irq. Do you mean if change the expire lock to raw,
it also needs to disable the irq to prevent something from happening,
right ? Also does the raw spinlock have the PI-boost functionality ?
>
> Sebastian
>
> .


