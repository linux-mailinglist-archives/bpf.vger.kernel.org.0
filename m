Return-Path: <bpf+bounces-16681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF00C804413
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F8B20BE9
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E517D4;
	Tue,  5 Dec 2023 01:31:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D43A4
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 17:31:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Skjfh0PF9z4f3lgS
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 09:31:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B63211A017F
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 09:31:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCnCLddfW5l9TjmCg--.32717S2;
	Tue, 05 Dec 2023 09:31:12 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Fix a race condition between btf_put() and
 map_free()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231204173946.3066377-1-yonghong.song@linux.dev>
 <CAEf4BzbPtSZxJ16E+gQnw7sgfqwJVYsnkUZaxdk=c+65KWgnTg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <81d00866-7824-18e5-af71-e0a15a03e84f@huaweicloud.com>
Date: Tue, 5 Dec 2023 09:31:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbPtSZxJ16E+gQnw7sgfqwJVYsnkUZaxdk=c+65KWgnTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCnCLddfW5l9TjmCg--.32717S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWfZr18Wr1Duw45ZrW7twb_yoW7XF43pF
	WfJa12kr4kXr1UursIqay8WrySyrW5t34UGwn5Ka4F9ry5WrykKr109FW5uFW5Ars5Gw4I
	vw4qga45u34kZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/5/2023 8:42 AM, Andrii Nakryiko wrote:
> On Mon, Dec 4, 2023 at 9:40 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> When running `./test_progs -j` in my local vm with latest kernel,
>> I once hit a kasan error like below:

SNIP
>>
>>
>> So the problem is at rec->refcount_off in the above.
>>
>> I did some source code analysis and find the reason.
>>                                   CPU A                        CPU B
>>   bpf_map_put:
>>     ...
>>     btf_put with rcu callback
>>     ...
>>     bpf_map_free_deferred
>>       with system_unbound_wq
>>     ...                          ...                           ...
>>     ...                          btf_free_rcu:                 ...
>>     ...                          ...                           bpf_map_free_deferred:
>>     ...                          ...
>>     ...         --------->       btf_struct_metas_free()
>>     ...         | race condition ...
>>     ...         --------->                                     map->ops->map_free()
>>     ...
>>     ...                          btf->struct_meta_tab = NULL
>>
>> In the above, map_free() corresponds to array_map_free() and eventually
>> calling bpf_rb_root_free() which calls:
>>   ...
>>   __bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
>>   ...
>>
>> Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with following code:
>>
>>   meta = btf_find_struct_meta(btf, btf_id);
>>   if (!meta)
>>     return -EFAULT;
>>   rec->fields[i].graph_root.value_rec = meta->record;
>>
>> So basically, 'value_rec' is a pointer to the record in struct_metas_tab.
>> And it is possible that that particular record has been freed by
>> btf_struct_metas_free() and hence we have a kasan error here.
>>
>> Actually it is very hard to reproduce the failure with current bpf/bpf-next
>> code, I only got the above error once. To increase reproducibility, I added
>> a delay in bpf_map_free_deferred() to delay map->ops->map_free(), which
>> significantly increased reproducibility.

Also found the problem when developing the "fix the release of inner
map" patch-set. I have written a selftest which could reliably reproduce
the problem by using map-in-map + bpf_list_head. The reason of using
map-in-map is to delay the release of inner map by using call_rcu() as
well, so the free of bpf_map happens after the release of btf. Will post
it later.
>>
>>   diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>   index 5e43ddd1b83f..aae5b5213e93 100644
>>   --- a/kernel/bpf/syscall.c
>>   +++ b/kernel/bpf/syscall.c
>>   @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
>>         struct bpf_map *map = container_of(work, struct bpf_map, work);
>>         struct btf_record *rec = map->record;
>>
>>   +     mdelay(100);
>>         security_bpf_map_free(map);
>>         bpf_map_release_memcg(map);
>>         /* implementation dependent freeing */
>>
>> To fix the problem, I moved btf_put() after map->ops->map_free() to ensure
>> struct_metas available during map_free(). Rerun './test_progs -j' with the
>> above mdelay() hack for a couple of times and didn't observe the error.
>>
>> Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>  kernel/bpf/syscall.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 0ed286b8a0f0..9c6c3738adfe 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -694,11 +694,16 @@ static void bpf_map_free_deferred(struct work_struct *work)
>>  {
>>         struct bpf_map *map = container_of(work, struct bpf_map, work);
>>         struct btf_record *rec = map->record;
>> +       struct btf *btf = map->btf;
>>
>>         security_bpf_map_free(map);
>>         bpf_map_release_memcg(map);
>>         /* implementation dependent freeing */
>>         map->ops->map_free(map);
>> +       /* Delay freeing of btf for maps, as map_free callback may need
>> +        * struct_meta info which will be freed with btf_put().
>> +        */
>> +       btf_put(btf);
> The change makes sense to me, but logically I'd put it after
> btf_record_free(rec), just in case if some of btf records ever refer
> back to map's BTF or something (and just in general to keep it the
> very last thing that's happening).
>
>
> But it also seems like CI is not happy ([0]), please take a look, thanks!
>
>   [0] https://github.com/kernel-patches/bpf/actions/runs/7090474333/job/19297672532

The patch delays the release of BTF id of bpf map, so test_btf_id
failed. Can we fix the problem by optionally pinning the btf in
btf_field_graph_root just like btf_field_kptr, so the map BTF will still
be alive before the invocation of btf_record_free() ? We need to do the
pinning optionally, because btf_record may be contained in btf directly
(namely btf->struct_meta_tab) and is freed through btf_free().
>
>
>>         /* Delay freeing of btf_record for maps, as map_free
>>          * callback usually needs access to them. It is better to do it here
>>          * than require each callback to do the free itself manually.
>> @@ -727,7 +732,6 @@ void bpf_map_put(struct bpf_map *map)
>>         if (atomic64_dec_and_test(&map->refcnt)) {
>>                 /* bpf_map_free_id() must be called first */
>>                 bpf_map_free_id(map);
>> -               btf_put(map->btf);
>>                 INIT_WORK(&map->work, bpf_map_free_deferred);
>>                 /* Avoid spawning kworkers, since they all might contend
>>                  * for the same mutex like slab_mutex.
>> --
>> 2.34.1
>>
> .


