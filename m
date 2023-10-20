Return-Path: <bpf+bounces-12804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4A7D0935
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2792823D1
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F3D2E0;
	Fri, 20 Oct 2023 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94418CA6C
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:09:21 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB69F
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 00:09:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SBbKx0V9zz4f3s6D
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 15:09:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3NaaWJzJlDukWDQ--.46806S2;
	Fri, 20 Oct 2023 15:09:14 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 2/7] mm/percpu.c: introduce pcpu_alloc_size()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dennis Zhou <dennis@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20231018113343.2446300-1-houtao@huaweicloud.com>
 <20231018113343.2446300-3-houtao@huaweicloud.com> <ZTH9c2kj2jpP0SDD@snowbird>
 <CAADnVQJ10m1N0zQL-u2UYYnn9yL+RZz4QQgjXxkNrOcBLHu4XA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3b502d3e-db22-f3d8-94de-f6294afcde5c@huaweicloud.com>
Date: Fri, 20 Oct 2023 15:09:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ10m1N0zQL-u2UYYnn9yL+RZz4QQgjXxkNrOcBLHu4XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3NaaWJzJlDukWDQ--.46806S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr13CryUtr4UCF1UCF1kGrg_yoW8tw4fpr
	40gF1FyF4kAr9rGw1Sq3Wjvw1aqw4kJF4xG347WF1UAr9Ivr92gr1qvrW5uFy5Crn29r17
	tFZ0qFZakFy5J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

Hi,

On 10/20/2023 12:16 PM, Alexei Starovoitov wrote:
> On Thu, Oct 19, 2023 at 9:09 PM Dennis Zhou <dennis@kernel.org> wrote:
>> On Wed, Oct 18, 2023 at 07:33:38PM +0800, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> Introduce pcpu_alloc_size() to get the size of the dynamic per-cpu
>>> area. It will be used by bpf memory allocator in the following patches.
>>> BPF memory allocator maintains per-cpu area caches for multiple area
>>> sizes and its free API only has the to-be-freed per-cpu pointer, so it
>>> needs the size of dynamic per-cpu area to select the corresponding cache
>>> when bpf program frees the dynamic per-cpu pointer.
>>>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  include/linux/percpu.h |  1 +
>>>  mm/percpu.c            | 30 ++++++++++++++++++++++++++++++
>>>  2 files changed, 31 insertions(+)
>>>
>>> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
>>> index 68fac2e7cbe6..8c677f185901 100644
>>> --- a/include/linux/percpu.h
>>> +++ b/include/linux/percpu.h
>>> @@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
>>>  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
>>>  extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
>>>  extern void free_percpu(void __percpu *__pdata);
>>> +extern size_t pcpu_alloc_size(void __percpu *__pdata);
>>>
>>>  DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
>>>
>>> diff --git a/mm/percpu.c b/mm/percpu.c
>>> index 76b9c5e63c56..b0cea2dc16a9 100644
>>> --- a/mm/percpu.c
>>> +++ b/mm/percpu.c
>>> @@ -2244,6 +2244,36 @@ static void pcpu_balance_workfn(struct work_struct *work)
>>>       mutex_unlock(&pcpu_alloc_mutex);
>>>  }
>>>
>>> +/**
>>> + * pcpu_alloc_size - the size of the dynamic percpu area
>>> + * @ptr: pointer to the dynamic percpu area
>>> + *
>>> + * Return the size of the dynamic percpu area @ptr.
>>> + *
>> Alexei, can you modify the above comment to:
>>
>> Returns the size of the @ptr allocation.  This is undefined for statically
>> defined percpu variables as there is no corresponding chunk->bound_map.
> Good point! Will do.

I will post v3 to update the API document.

>
> Thanks for the quick review!
>
> .


