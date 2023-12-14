Return-Path: <bpf+bounces-17765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F998124DC
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208B2282AC8
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FEA80D;
	Thu, 14 Dec 2023 01:57:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A93E4
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:57:26 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SrFpp4fwlz4f3jM7
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:57:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF7941A09D3
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:57:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAHY0P_YHplLxDBDg--.8573S2;
	Thu, 14 Dec 2023 09:57:23 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231211073843.1888058-1-houtao@huaweicloud.com>
 <20231211073843.1888058-2-houtao@huaweicloud.com>
 <CAADnVQ+Tb9btofrgp41E+2RBEtpp_s5D2rPZjYx34XX=XY3BFw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c4ff43a8-b2a1-16e9-d8a8-1ea8c629b4f6@huaweicloud.com>
Date: Thu, 14 Dec 2023 09:57:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+Tb9btofrgp41E+2RBEtpp_s5D2rPZjYx34XX=XY3BFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAHY0P_YHplLxDBDg--.8573S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DZw4DGry3ArykCr17Jrb_yoWrGr15pa
	ykKFyjkw40qr47uw17Z3Wv9rW5Aw1UXF4UKan5t3yFyryDXrn2gr1UGan3XF90yrnrAr40
	qa4Y9rZYkayUZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/14/2023 9:10 AM, Alexei Starovoitov wrote:
> On Sun, Dec 10, 2023 at 11:37 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
>> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
>> callbacks and only uses rcu-read-lock for the underlying update
>> operations in bpf_fd_{array,htab}_map_update_elem().
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/arraymap.c | 2 ++
>>  kernel/bpf/hashtab.c  | 2 ++
>>  kernel/bpf/syscall.c  | 4 ----
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 8d365bda9a8b..6cf47bcb7b83 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -863,7 +863,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
>>                 map->ops->map_poke_run(map, index, old_ptr, new_ptr);
>>                 mutex_unlock(&array->aux->poke_mutex);
>>         } else {
>> +               rcu_read_lock();
>>                 old_ptr = xchg(array->ptrs + index, new_ptr);
>> +               rcu_read_unlock();
>>         }
>>
>>         if (old_ptr)
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 5b9146fa825f..4c28fd51ac01 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -2523,7 +2523,9 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
>>         if (IS_ERR(ptr))
>>                 return PTR_ERR(ptr);
>>
>> +       rcu_read_lock();
>>         ret = htab_map_update_elem(map, key, &ptr, map_flags);
>> +       rcu_read_unlock();
>>         if (ret)
>>                 map->ops->map_fd_put_ptr(map, ptr, false);
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index a76467fda558..019d18d33d63 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -183,15 +183,11 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>>                 err = bpf_percpu_cgroup_storage_update(map, key, value,
>>                                                        flags);
>>         } else if (IS_FD_ARRAY(map)) {
>> -               rcu_read_lock();
>>                 err = bpf_fd_array_map_update_elem(map, map_file, key, value,
>>                                                    flags);
>> -               rcu_read_unlock();
>>         } else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
>> -               rcu_read_lock();
>>                 err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
>>                                                   flags);
>> -               rcu_read_unlock();
> Sorry. I misunderstood the previous diff.
> Dropping rcu_read_lock() around bpf_fd_array_map_update_elem()
> is actually mandatory, since it may do mutex_lock
> which will splat under rcu CS.

Acquiring mutex_lock is only possible for program fd array, but
bpf_fd_array_map_update_elem() has already been called above to handle
program fd array and there is no rcu_read_lock() being acquired.
>
> Adding rcu_read_lock() to bpf_fd_htab_map_update_elem()
> is necessary just to avoid the WARN.
> The RCU CS doesn't provide any protection to any pointer.
> It's worth adding a comment.

Yes. There is no spin-lock support in fd htab, the update operation for
fd htab is taken under bucket lock. So the RCU CS is only to make the
WARN_ON_ONCE() in htab_map_update_elem() happy.

To ensure I fully understand what you mean, let me rephrase the things
that need to done:
1) Repost v3 based on v1
2) In v3, add comments in bpf_fd_htab_map_update_elem() to explain why
the RCU CS is needed. Is that correct ?

>
> And
>  +               rcu_read_lock();
>                  old_ptr = xchg(array->ptrs + index, new_ptr);
>  +               rcu_read_unlock();
> is wrong and unnecessary.
> Neither old_ptr nor new_ptr are rcu protected.
> This rcu_read_lock() only causes confusion.

OK. Will remove.
>
> pw-bot: cr


