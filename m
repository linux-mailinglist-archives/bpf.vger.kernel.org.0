Return-Path: <bpf+bounces-19866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF48322C4
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC18B203A6
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059AAA59;
	Fri, 19 Jan 2024 00:51:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17507818
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625487; cv=none; b=iqanZo9vWfH347fUvr/K9b2u03Ft3Lf3+Y2mQ/otp+UiODa6kSvEFxTCaj+rc1/f0LSislnrFko/ng4e8WtpCMx3SP5FA7tTa/hJ7ahIXi0I0v4t8wykkpD5FaDu+HRl8fFvrDfrvhNS0RX4w3Fsy9DVkvve37eAYC0mINX9jEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625487; c=relaxed/simple;
	bh=C0EAIWW8wd4c5Jph2YENvHBcMFZ3SyHD9ak9ZWac4i4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Na2w6afvAAfixrZ6Np2Qfhz/DhIOQQwuhlZ3c10u6RZ/RAqoHpqDO+YgS6nliX7BBLKdzOtRJEL5Q22A5iKNHdrUCs7POdbHlDtqmf5TUUR1mE5YOZIdYIbdu921m2bPlLN1p8VfdXNX6LAtNzqHKQh1/o7nGjty+uIYnYTJx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TGLdt6G6gz4f3lVV
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 08:51:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0E5171A0A03
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 08:51:21 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXKRKFx6ll7Q4SBQ--.28524S2;
	Fri, 19 Jan 2024 08:51:20 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, tj@kernel.org, andrii@kernel.org,
 kpsingh@kernel.org, song@kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org, lkp@intel.com,
 john.fastabend@gmail.com, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20240117024823.4186-1-laoar.shao@gmail.com>
 <20240117024823.4186-2-laoar.shao@gmail.com>
 <a7699a08-827b-4433-99a8-bfbfda1d38af@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a5c077b5-5575-f1a8-9a65-b3877af56c0d@huaweicloud.com>
Date: Fri, 19 Jan 2024 08:51:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a7699a08-827b-4433-99a8-bfbfda1d38af@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXKRKFx6ll7Q4SBQ--.28524S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1DAw17GryrJry8Kr1DAwb_yoW7Wryxpr
	1xtrZ8CrW8Xws3WwnxJw1UGryak3ykJ3Wvk3Z5WFW5CrZxZw4kWF15XFnrW3W5GrWkKryI
	yr909w429ryUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/19/2024 6:27 AM, Yonghong Song wrote:
>
> On 1/16/24 6:48 PM, Yafang Shao wrote:
>> Add three new kfuncs for bpf_iter_cpumask.
>> - bpf_iter_cpumask_new
>>    It is defined with KF_RCU_PROTECTED and KF_RCU.
>>    KF_RCU_PROTECTED is defined because we must use it under the
>>    protection of RCU.
>>    KF_RCU is defined because the cpumask must be a RCU trusted pointer
>>    such as task->cpus_ptr.
>
> I am not sure whether we need both or not.
>
> KF_RCU_PROTECTED means the function call needs within the rcu cs.
> KF_RCU means the argument usage needs within the rcu cs.
> We only need one of them (preferrably KF_RCU).
>
>> - bpf_iter_cpumask_next
>> - bpf_iter_cpumask_destroy
>>
>> These new kfuncs facilitate the iteration of percpu data, such as
>> runqueues, psi_cgroup_cpu, and more.
>>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> ---
>>   kernel/bpf/cpumask.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
>> index 2e73533a3811..1840e48e6142 100644
>> --- a/kernel/bpf/cpumask.c
>> +++ b/kernel/bpf/cpumask.c
>> @@ -422,6 +422,72 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct
>> cpumask *cpumask)
>>       return cpumask_weight(cpumask);
>>   }
>>   +struct bpf_iter_cpumask {
>> +    __u64 __opaque[2];
>> +} __aligned(8);
>> +
>> +struct bpf_iter_cpumask_kern {
>> +    const struct cpumask *mask;
>> +    int cpu;
>> +} __aligned(8);
>> +
>> +/**
>> + * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a
>> specified cpumask
>> + * @it: The new bpf_iter_cpumask to be created.
>> + * @mask: The cpumask to be iterated over.
>> + *
>> + * This function initializes a new bpf_iter_cpumask structure for
>> iterating over
>> + * the specified CPU mask. It assigns the provided cpumask to the
>> newly created
>> + * bpf_iter_cpumask @it for subsequent iteration operations.
>> + *
>> + * On success, 0 is returen. On failure, ERR is returned.
>> + */
>> +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it,
>> const struct cpumask *mask)
>> +{
>> +    struct bpf_iter_cpumask_kern *kit = (void *)it;
>> +
>> +    BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) >
>> sizeof(struct bpf_iter_cpumask));
>> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=
>> +             __alignof__(struct bpf_iter_cpumask));
>> +
>> +    kit->mask = mask;
>> +    kit->cpu = -1;
>> +    return 0;
>> +}
>
> We have problem here. Let us say bpf_iter_cpumask_new() is called
> inside rcu cs.
> Once the control goes out of rcu cs, 'mask' could be freed, right?
> Or you require bpf_iter_cpumask_next() needs to be in the same rcu cs
> as bpf_iter_cpumask_new(). But such a requirement seems odd.

So the case is possible when using bpf_iter_cpumask_new() and
bpf_iter_cpumask_next() in sleepable program and these two kfuncs are
used in two different rcu_read_lock/rcu_read_unlock code blocks, right ?
>
> I think we can do things similar to bpf_iter_task_vma. You can
> allocate memory
> with bpf_mem_alloc() in bpf_iter_cpumask_new() to keep a copy of mask.
> This
> way, you do not need to worry about potential use-after-free issue.
> The memory can be freed with bpf_iter_cpumask_destroy().
>
>> +
>> +/**
>> + * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
>> + * @it: The bpf_iter_cpumask
>> + *
>> + * This function retrieves a pointer to the number of the next CPU
>> within the
>> + * specified bpf_iter_cpumask. It allows sequential access to CPUs
>> within the
>> + * cpumask. If there are no further CPUs available, it returns NULL.
>> + *
>> + * Returns a pointer to the number of the next CPU in the cpumask or
>> NULL if no
>> + * further CPUs.
>> + */
>> +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
>> +{
>> +    struct bpf_iter_cpumask_kern *kit = (void *)it;
>> +    const struct cpumask *mask = kit->mask;
>> +    int cpu;
>> +
>> +    cpu = cpumask_next(kit->cpu, mask);
>> +    if (cpu >= nr_cpu_ids)
>> +        return NULL;
>> +
>> +    kit->cpu = cpu;
>> +    return &kit->cpu;
>> +}
>> +
>> +/**
>> + * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
>> + * @it: The bpf_iter_cpumask to be destroyed.
>> + */
>> +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
>> +{
>> +}
>> +
>>   __bpf_kfunc_end_defs();
>>     BTF_SET8_START(cpumask_kfunc_btf_ids)
>> @@ -450,6 +516,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
>>   BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>>   BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>>   BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
>> +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW |
>> KF_RCU_PROTECTED | KF_RCU)
>> +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
>>   BTF_SET8_END(cpumask_kfunc_btf_ids)
>>     static const struct btf_kfunc_id_set cpumask_kfunc_set = {
>
> .


