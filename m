Return-Path: <bpf+bounces-17801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B8881295F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 08:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4989AB2126A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C7912E52;
	Thu, 14 Dec 2023 07:31:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5FD66
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 23:31:18 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SrPD15y4Gz4f3jqN
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:31:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 181531A095B
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:31:15 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgC3Wkk_r3plrwXgDg--.12043S2;
	Thu, 14 Dec 2023 15:31:14 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
References: <20231214043010.3458072-1-houtao@huaweicloud.com>
 <20231214043010.3458072-2-houtao@huaweicloud.com>
 <657a9f1ea1ff4_48672208f0@john.notmuch>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ba0e18ba-f6be-ceb9-412e-48e8e41cb5b6@huaweicloud.com>
Date: Thu, 14 Dec 2023 15:31:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <657a9f1ea1ff4_48672208f0@john.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgC3Wkk_r3plrwXgDg--.12043S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4rCryxGw45ZryrtF4kXrb_yoWrCFW3pF
	WvkFyUKw1vqanxZw12va1rKrW8Aw45Xw45tF4kXayrAr1DWw1fKry7tan3ZFyYkrnrAr48
	Xa42v393C3y8ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/14/2023 2:22 PM, John Fastabend wrote:
> Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
>> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
>> callbacks.
>>
>> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
>> rcu-read-lock because array->ptrs must still be allocated. For
>> bpf_fd_htab_map_update_elem(), htab_map_update_elem() only requires
>> rcu-read-lock to be held to avoid the WARN_ON_ONCE(), so only use
>> rcu_read_lock() during the invocation of htab_map_update_elem().
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/hashtab.c | 6 ++++++
>>  kernel/bpf/syscall.c | 4 ----
>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 5b9146fa825f..ec3bdcc6a3cf 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -2523,7 +2523,13 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
>>  	if (IS_ERR(ptr))
>>  		return PTR_ERR(ptr);
>>  
>> +	/* The htab bucket lock is always held during update operations in fd
>> +	 * htab map, and the following rcu_read_lock() is only used to avoid
>> +	 * the WARN_ON_ONCE in htab_map_update_elem().
>> +	 */
>> +	rcu_read_lock();
>>  	ret = htab_map_update_elem(map, key, &ptr, map_flags);
>> +	rcu_read_unlock();
> Did we consider dropping the WARN_ON_ONCE in htab_map_update_elem()? It
> looks like there are two ways to get to htab_map_update_elem() either
> through a syscall and the path here (bpf_fd_htab_map_update_elem) or
> through a BPF program calling, bpf_update_elem()? In the BPF_CALL
> case bpf_map_update_elem() already has,
>
>    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held())
>
> The htab_map_update_elem() has an additional check for
> rcu_read_lock_trace_held(), but not sure where this is coming from
> at the moment. Can that be added to the BPF caller side if needed?
>
> Did I miss some caller path?

No. But I think the main reason for the extra WARN in
bpf_map_update_elem() is that bpf_map_update_elem() may be inlined by
verifier in do_misc_fixups(), so the WARN_ON_ONCE in
bpf_map_update_elem() will not be invoked ever. For
rcu_read_lock_trace_held(), I have added the assertion in
bpf_map_delete_elem() recently in commit 169410eba271 ("bpf: Check
rcu_read_lock_trace_held() before calling bpf map helpers").
>  
>
>>  	if (ret)
>>  		map->ops->map_fd_put_ptr(map, ptr, false);
>>  
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index d63c1ed42412..3fcf7741146a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -184,15 +184,11 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>>  		err = bpf_percpu_cgroup_storage_update(map, key, value,
>>  						       flags);
>>  	} else if (IS_FD_ARRAY(map)) {
>> -		rcu_read_lock();
>>  		err = bpf_fd_array_map_update_elem(map, map_file, key, value,
>>  						   flags);
>> -		rcu_read_unlock();
>>  	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
>> -		rcu_read_lock();
>>  		err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
>>  						  flags);
>> -		rcu_read_unlock();
>>  	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
>>  		/* rcu_read_lock() is not needed */
>>  		err = bpf_fd_reuseport_array_update_elem(map, key, value,
> Any reason to leave the last rcu_read_lock() on the 'else{}' case? If
> the rule is we have a reference to the map through the file fdget()? And
> any concurrent runners need some locking, xchg, to handle the update a
> rcu_read_lock() wont help there.
>
> I didn't audit all the update flows tonight though.

It seems it is still necessary for htab and local storage. For normal
htab, it is possible the update is done without taking the bucket lock
(in-place replace), so RCU CS is needed to guarantee the iteration is
still safe. And for local storage (e.g. cgrp local storage) it may also
do in-place update through lookup and then update. We could fold the
calling of rcu_read_lock() into .map_update_elem() if it is necessary.
>
>
>> -- 
>> 2.29.2
>>
>>


