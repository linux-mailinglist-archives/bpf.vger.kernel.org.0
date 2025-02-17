Return-Path: <bpf+bounces-51708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF41EA379AE
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1B018870C5
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370713EFE3;
	Mon, 17 Feb 2025 02:20:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5121F16B;
	Mon, 17 Feb 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739758804; cv=none; b=pofXbhFQqVK06e56vP2gSBuHU5ZOGXFDc/EnLTfHMyoUEHqwZPK6qPf/nq5CYv/bBb381BA7oWe6pLH5N/k/KoFLKPGvYFKdfHEQ/7JvORjYFKGJExx2Lel73cAiAMMI2RU57dD1GcYcOEgjaHIUkfo1R4IoNoHI56Kod/5XOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739758804; c=relaxed/simple;
	bh=ZUsQx3FLLGpbppYk3otRvAy3SQ/yJjCZs/Y4imeQb24=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AzFkrvRhbv3lKKNrTcznslZETYn7OUnW+e0qcZEGnmZcLOp2r5jPnaws4Zd7cCkn4MNw2hidxR5NbKo6mJJbu2HKLMOyi9tyBg+mgLC15xsS/Rg5YvPm5mdXpvyrRlwJ/a8b/wnRit8AbyeB1kYjpeMtO9WFyYCuD2LYnm/UT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yx5vX3JWXz4f3jR5;
	Mon, 17 Feb 2025 10:19:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id F02E61A058E;
	Mon, 17 Feb 2025 10:19:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgD3lsHJnLJnaPALEA--.55493S2;
	Mon, 17 Feb 2025 10:19:57 +0800 (CST)
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Changwoo Min <changwoo@igalia.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Tejun Heo <tj@kernel.org>,
 Andrea Righi <arighi@nvidia.com>, kernel-dev@igalia.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250212084851.150169-1-changwoo@igalia.com>
 <CAADnVQLRrhyOHGPb1O0Ju=7YVCNexdhwtoJaGYrfU9Vh2cBbgw@mail.gmail.com>
 <4fd39e4b-f2dc-4b7d-a3be-ec3eae8d592a@igalia.com>
 <CAADnVQL5dt7_S-zFSh-ps7uPfL2ofYs0vo1fFuFBwiz0=DV2Vw@mail.gmail.com>
 <6632e26d-996c-432e-956f-5be178722e5b@igalia.com>
 <7ea1165d-d399-4d40-ad5b-fab44e2148ca@igalia.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a08493a4-632f-d66e-db26-727c9cf9e6c6@huaweicloud.com>
Date: Mon, 17 Feb 2025 10:19:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7ea1165d-d399-4d40-ad5b-fab44e2148ca@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgD3lsHJnLJnaPALEA--.55493S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4DKF4DJrWkuFWxCw4xCrg_yoW5KF1rpw
	n5KFWUJrWDCF4vgrn2qw17WFyYyay8Xw1kJrykAFyxJFsFqr1agr1UXrnIg3ZxGrs5Cr47
	tFZ0qa43Za15X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/17/2025 12:04 AM, Changwoo Min wrote:
> Hello,
>
> >  > What is sizeof(struct bpf_cpumask) in your system?
> >
> > In my system, sizeof(struct bpf_cpumask) is 1032.
> It was a wrong number. sizeof(struct bpf_cpumask) is actually 16.
>
> On 25. 2. 16. 00:16, Changwoo Min wrote:
>> Hello,
>>
>> On 25. 2. 15. 12:51, Alexei Starovoitov wrote:
>>  > On Fri, Feb 14, 2025 at 1:24 AM Changwoo Min <changwoo@igalia.com>
>> wrote:
>>  >>
>>  >> Hello Alexei,
>>  >>
>>  >> Thank you for the comments! I reordered your comments for ease of
>>  >> explanation.
>>  >>
>>  >> On 25. 2. 14. 02:45, Alexei Starovoitov wrote:
>>  >>> On Wed, Feb 12, 2025 at 12:49 AM Changwoo Min
>> <changwoo@igalia.com> wrote:
>>  >>
>>  >>> The commit log is too terse to understand what exactly is going on.
>>  >>> Pls share the call stack. What is the allocation size?
>>  >>> How many do you do in a sequence?
>>  >>
>>  >> The symptom is that an scx scheduler (scx_lavd) fails to load on
>>  >> an ARM64 platform on its first try. The second try succeeds. In
>>  >> the failure case, the kernel spits the following messages:
>>  >>
>>  >> [   27.431380] sched_ext: BPF scheduler "lavd" disabled (runtime
>> error)
>>  >> [   27.431396] sched_ext: lavd: ops.init() failed (-12)
>>  >> [   27.431401]    scx_ops_enable.isra.0+0x838/0xe48
>>  >> [   27.431413]    bpf_scx_reg+0x18/0x30
>>  >> [   27.431418]    bpf_struct_ops_link_create+0x144/0x1a0
>>  >> [   27.431427]    __sys_bpf+0x1560/0x1f98
>>  >> [   27.431433]    __arm64_sys_bpf+0x2c/0x80
>>  >> [   27.431439]    do_el0_svc+0x74/0x120
>>  >> [   27.431446]    el0_svc+0x80/0xb0
>>  >> [   27.431454]    el0t_64_sync_handler+0x120/0x138
>>  >> [   27.431460]    el0t_64_sync+0x174/0x178
>>  >>
>>  >> The ops.init() failed because the 5th bpf_cpumask_create() calls
>>  >> failed during the initialization of the BPF scheduler. The exact
>>  >> point where bpf_cpumask_create() failed is here [1]. That scx
>>  >> scheduler allocates 5 CPU masks to aid its scheduling decision.
>>  >
>>  > ...
>>  >
>>  >> In this particular scenario, the IRQ is not disabled. I just
>>  >
>>  > since irq-s are not disabled the unit_alloc() should have done:
>>  >          if (cnt < c->low_watermark)
>>  >                  irq_work_raise(c);
>>  >
>>  > and alloc_bulk() should have started executing after the first
>>  > calloc_cpumask(&active_cpumask);
>>  > to refill it from 3 to 64
>>
>> Is there any possibility that irq_work is not scheduled right away on
>> aarch64?

It is a IPI. I think its priority is higher than the current process.
>>
>>  >
>>  > What is sizeof(struct bpf_cpumask) in your system?
>>
>> In my system, sizeof(struct bpf_cpumask) is 1032.
>It was a wrong number. sizeof(struct bpf_cpumask) is actually 16.

It is indeed strange. The former guess is that bpf_cpumask may be
greater than 4K, so the refill in irq work may fail due to memory
fragment, but the allocation size is tiny.
>>
>>  >
>>  > Something doesn't add up. irq_work_queue() should be
>>  > instant when irq-s are not disabled.
>>  > This is not IRQ_WORK_LAZY.> Are you running PREEMPT_RT ?
>>
>> No, CONFIG_PREEMPT_RT is not set.

Could you please share the kernel .config file and the kernel version
for the problem ? And if you are running the test in a QEMU, please also
share the command line to run the qemu.
>>
>> Regards,
>> Changwoo Min
>>
>>
>
>
> .


