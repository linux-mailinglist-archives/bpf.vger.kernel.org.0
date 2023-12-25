Return-Path: <bpf+bounces-18661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE6781E0BA
	for <lists+bpf@lfdr.de>; Mon, 25 Dec 2023 14:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE2AB21315
	for <lists+bpf@lfdr.de>; Mon, 25 Dec 2023 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA551C49;
	Mon, 25 Dec 2023 13:06:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A785026B;
	Mon, 25 Dec 2023 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SzJ7m6WHWz4f3jrt;
	Mon, 25 Dec 2023 21:06:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D75BB1A0215;
	Mon, 25 Dec 2023 21:06:31 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCnCbhRfollzA4VEg--.9464S2;
	Mon, 25 Dec 2023 21:06:29 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: implement relay map basis
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, hengqi@linux.alibaba.com, shung-hsi.yu@suse.com
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
 <20231222122146.65519-2-lulie@linux.alibaba.com>
 <35f5a5bf-7059-a177-cd94-b60ed8dbff03@huaweicloud.com>
 <87b4f7fc-cc98-496c-bbff-6e3890278e35@linux.alibaba.com>
 <6a8538dc-d05c-41c9-bab5-6fbb5c6eea2f@linux.alibaba.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <625a77ae-113d-bae1-9e76-7f6de8cbf859@huaweicloud.com>
Date: Mon, 25 Dec 2023 21:06:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a8538dc-d05c-41c9-bab5-6fbb5c6eea2f@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCnCbhRfollzA4VEg--.9464S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF13AF1rCw4DXryUurWrAFb_yoW5Ar18pF
	WrKFWjkr4kJF98uayxK3Z5X34Fqr98Jw1jgasYg3yrZF98Zrn3Xr1rKayY9ry7Crs7Cw1j
	9340vryxZryjvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi,

On 12/25/2023 7:36 PM, Philo Lu wrote:
> On 2023/12/23 21:02, Philo Lu wrote:
>>
>>
>> On 2023/12/23 19:22, Hou Tao wrote:
>>> Hi,
>>>
>>> On 12/22/2023 8:21 PM, Philo Lu wrote:
>>>> BPF_MAP_TYPE_RELAY is implemented based on relay interface, which
>>>> creates per-cpu buffer to transfer data. Each buffer is essentially a
>>>> list of fix-sized sub-buffers, and is exposed to user space as
>>>> files in
>>>> debugfs. attr->max_entries is used as subbuf size and
>>>> attr->map_extra is
>>>> used as subbuf num. Currently, the default value of subbuf num is 8.
>>>>
>>>> The data can be accessed by read or mmap via these files. For example,
>>>> if there are 2 cpus, files could be `/sys/kernel/debug/mydir/my_rmap0`
>>>> and `/sys/kernel/debug/mydir/my_rmap1`.
>>>>
>>>> Buffer-only mode is used to create the relay map, which just allocates
>>>> the buffer without creating user-space files. Then user can setup the
>>>> files with map_update_elem, thus allowing user to define the directory
>>>> name in debugfs. map_update_elem is implemented in the following
>>>> patch.
>>>>
>>>> A new map flag named BPF_F_OVERWRITE is introduced to set overwrite
>>>> mode
>>>> of relay map.
>>>
>>> Beside adding a new map type, could we consider only use kfuncs to
>>> support the creation of rchan and the write of rchan ? I think
>>> bpf_cpumask will be a good reference.
>>
>> This is a good question. TBH, I have thought of implement it with
>> helpers (I'm not very familiar with kfuncs, but I think they could be
>> similar?), but I was stumped by how to close the channel. We can
>> create a relay channel, hold it with a map, but it could be difficult
>> for the bpf program to close the channel with relay_close(). And I
>> think it could be the difference compared with bpf_cpumask.
>
> I've learned more about kfunc and kptr, and find that kptr can be
> automatically released with a given map. Then, it is technically
> feasible to use relay interface with kfuncs. Specificially, creating a
> relay channel and getting the pointer with kfunc, transferring it as a
> kptr into a map, and then it lives with the map.

Yes. kptr of bpf_cpumask can be destroyed by the freeing of map or doing
it explicitly through bpf_kptr_xchg() and release kfunc.
>
> Though I'm not sure if this is better than map-based implementation,
> as mostly it will be used with a map (I haven't thought of a case
> without a map yet). And with kfunc, it will be a little more complex
> to create a relay channel.
>

The motivation for requesting to implement BPF_MAP_TYPE_REPLAY through
kfunc is that Alexei had expressed the tendency to freeze the stable map
type [1] and to implement new map type through kfunc. However we can let
the maintainers to decide which way is better and more acceptable.

[1]
https://lore.kernel.org/bpf/CAEf4BzZTYcGNVWL7gSPHCqao_Ehx_3P7YK6r+p_-hrvpE8fEvA@mail.gmail.com/T/
> Thanks.


