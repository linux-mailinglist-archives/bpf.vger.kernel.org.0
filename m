Return-Path: <bpf+bounces-17353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A580BEB3
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 02:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E5B1C208F5
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198279CC;
	Mon, 11 Dec 2023 01:17:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6411DE4
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 17:17:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SpP3n3wt9z4f3jrn
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:17:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EFD671A04AA
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:17:11 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAHY0MVY3ZlRRyhDQ--.23706S2;
	Mon, 11 Dec 2023 09:17:11 +0800 (CST)
Subject: Re: [PATCH bpf-next 7/7] bpf: Wait for sleepable BPF program in
 maybe_wait_bpf_programs()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
 <20231208102355.2628918-8-houtao@huaweicloud.com>
 <CAEf4BzbS5DaarFp6LqwLLLPj=MjkOtQVFUBKganQjXpTgNe0gg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2c88ac6b-5a50-7260-3aa2-120a04dbb589@huaweicloud.com>
Date: Mon, 11 Dec 2023 09:17:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbS5DaarFp6LqwLLLPj=MjkOtQVFUBKganQjXpTgNe0gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAHY0MVY3ZlRRyhDQ--.23706S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15uF1xGw1fXF4fZrWUurg_yoWrCFWkpF
	90ka4UKFs0qrsrKwsFvw4UZ348tr4vgw17Gr4rKryFy343Xr9IgryFga98uF1avr4xKrW0
	vryjyr93Gw45ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrcTmDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/9/2023 6:30 AM, Andrii Nakryiko wrote:
> On Fri, Dec 8, 2023 at 2:23 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Since commit 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in
>> sleepable programs"), sleepable BPF program can use map-in-map, but
>> maybe_wait_bpf_programs() doesn't consider it accordingly.
>>
>> So checking the value of sleepable_refcnt in maybe_wait_bpf_programs(),
>> if the value is not zero, use synchronize_rcu_mult() to wait for both
>> sleepable and non-sleepable BPF programs. But bpf syscall from syscall
>> program is special, because the bpf syscall is called with
>> rcu_read_lock_trace() being held, and there will be dead-lock if
>> synchronize_rcu_mult() is used to wait for the exit of sleepable BPF
>> program, so just skip the waiting of sleepable BPF program for bpf
>> syscall which comes from syscall program.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/syscall.c | 28 +++++++++++++++++++---------
>>  1 file changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index d2641e51a1a7..6b9d7990d95f 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/rcupdate_trace.h>
>>  #include <linux/memcontrol.h>
>>  #include <linux/trace_events.h>
>> +#include <linux/rcupdate_wait.h>
>>
>>  #include <net/netfilter/nf_bpf_link.h>
>>  #include <net/netkit.h>
>> @@ -140,15 +141,24 @@ static u32 bpf_map_value_size(const struct bpf_map *map)
>>                 return  map->value_size;
>>  }
>>
>> -static void maybe_wait_bpf_programs(struct bpf_map *map)
>> +static void maybe_wait_bpf_programs(struct bpf_map *map, bool rcu_trace_lock_held)
>>  {
>> -       /* Wait for any running BPF programs to complete so that
>> -        * userspace, when we return to it, knows that all programs
>> -        * that could be running use the new map value.
>> +       /* Wait for any running non-sleepable and sleepable BPF programs to
>> +        * complete, so that userspace, when we return to it, knows that all
>> +        * programs that could be running use the new map value. However
>> +        * syscall program can also use bpf syscall to update or delete inner
>> +        * map in outer map, and it holds rcu_read_lock_trace() before doing
>> +        * the bpf syscall. If use synchronize_rcu_mult(call_rcu_tasks_trace)
>> +        * to wait for the exit of running sleepable BPF programs, there will
>> +        * be dead-lock, so skip the waiting for syscall program.
>>          */
>>         if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
>> -           map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
>> -               synchronize_rcu();
>> +           map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS) {
>> +               if (atomic64_read(&map->sleepable_refcnt) && !rcu_trace_lock_held)
> why is this correct and non-racy without holding used_maps_mutex under
> which this sleepable_refcnt is incremented?

Do you mean bpf_prog_bind_map(), right ? The program which binds with
the map doesn't access it, so if the atomic64_inc() is missed, there
will still be OK. But if the implementation is changed afterwards, there
will be a problem.
>
>> +                       synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
>> +               else
>> +                       synchronize_rcu();
>> +       }
>>  }
>>
>>  static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>> @@ -1561,7 +1571,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>>
>>         err = bpf_map_update_value(map, f.file, key, value, attr->flags);
>>         if (!err)
>> -               maybe_wait_bpf_programs(map);
>> +               maybe_wait_bpf_programs(map, bpfptr_is_kernel(uattr));
>>
>>         kvfree(value);
>>  free_key:
>> @@ -1618,7 +1628,7 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
>>         rcu_read_unlock();
>>         bpf_enable_instrumentation();
>>         if (!err)
>> -               maybe_wait_bpf_programs(map);
>> +               maybe_wait_bpf_programs(map, bpfptr_is_kernel(uattr));
>>  out:
>>         kvfree(key);
>>  err_put:
>> @@ -4973,7 +4983,7 @@ static int bpf_map_do_batch(union bpf_attr *attr,
>>  err_put:
>>         if (has_write) {
>>                 if (attr->batch.count)
>> -                       maybe_wait_bpf_programs(map);
>> +                       maybe_wait_bpf_programs(map, false);
>>                 bpf_map_write_active_dec(map);
>>         }
>>         fdput(f);
>> --
>> 2.29.2
>>


