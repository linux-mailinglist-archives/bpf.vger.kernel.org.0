Return-Path: <bpf+bounces-48039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE5FA0349A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 02:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE391886098
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0F4C97;
	Tue,  7 Jan 2025 01:40:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7D5FDA7;
	Tue,  7 Jan 2025 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736214020; cv=none; b=RlIOcEn9Dr2RJ80XeMiKr+soZm9G+HBdtANzICHL/Xtz9HsOFsIbytCrikOJUknr2DvhiGRATYA0477+HKLKswRVqAa3un0rlSPe0wFsbu8jKgTD6D99U351q6z5RUoGvODrn605LYRtU0+5t6/V81NxvVaeUgn+Ht6tAQ8xqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736214020; c=relaxed/simple;
	bh=1rx2u0PI5pysIH2/1k0zntVcu0S0KUGDGqVTsGQKfMc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qBM31NxrPrjGvN5NE7IyPIy3K2doK7Po7XnAZ5jbT6jx/OsKnzSKKDDbUk+uhCU0H/Kn1axQgsXsp5sUwQh7c83387en0XB15qAs1wZj4ofdTvLOJff11QtNwz2nBHQ4oaqdF849RwmZPTPragbh68rsU2he06LYMFhMoOg1rR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRtyj6PYFz4f3jks;
	Tue,  7 Jan 2025 09:39:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D3C9F1A1486;
	Tue,  7 Jan 2025 09:40:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBncWT4hXxnqoQBAQ--.16535S2;
	Tue, 07 Jan 2025 09:40:12 +0800 (CST)
Subject: Re: [PATCH bpf-next 15/19] bpf: Disable migration before calling
 ops->map_free()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
 <20250106081900.1665573-16-houtao@huaweicloud.com>
 <CAADnVQJzQ9ADqpCb7mcsQCU1enTdPH7XtZKkTHyY739sg62CzA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a467b9ac-3785-7c5d-577c-c2f4a43c6923@huaweicloud.com>
Date: Tue, 7 Jan 2025 09:40:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJzQ9ADqpCb7mcsQCU1enTdPH7XtZKkTHyY739sg62CzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBncWT4hXxnqoQBAQ--.16535S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyUKr1DAFyrAryrKw15Jwb_yoW7uF4kpF
	4kKF1jka10qF12kws3Xa1xC34Yvw45K3ySka98G34FyrZxXr9aqr1IyF15XFyY9r1Utr4S
	vF1qg34Yv3y8ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/7/2025 6:24 AM, Alexei Starovoitov wrote:
> On Mon, Jan 6, 2025 at 12:07 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Disabling migration before calling ops->map_free() to simplify the
>> freeing of map values or special fields allocated from bpf memory
>> allocator.
>>
>> After disabling migration in bpf_map_free(), there is no need for
>> additional migration_{disable|enable} pairs in the ->map_free()
>> callbacks. Remove these redundant invocations.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/arraymap.c          | 2 --
>>  kernel/bpf/bpf_local_storage.c | 2 --
>>  kernel/bpf/hashtab.c           | 2 --
>>  kernel/bpf/range_tree.c        | 2 --
>>  kernel/bpf/syscall.c           | 8 +++++++-
>>  5 files changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 451737493b17..eb28c0f219ee 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -455,7 +455,6 @@ static void array_map_free(struct bpf_map *map)
>>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>>         int i;
>>
>> -       migrate_disable();
>>         if (!IS_ERR_OR_NULL(map->record)) {
>>                 if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
>>                         for (i = 0; i < array->map.max_entries; i++) {
>> @@ -472,7 +471,6 @@ static void array_map_free(struct bpf_map *map)
>>                                 bpf_obj_free_fields(map->record, array_map_elem_ptr(array, i));
>>                 }
>>         }
>> -       migrate_enable();
>>
>>         if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
>>                 bpf_array_free_percpu(array);
>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index b649cf736438..12cf6382175e 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
>> @@ -905,13 +905,11 @@ void bpf_local_storage_map_free(struct bpf_map *map,
>>                 while ((selem = hlist_entry_safe(
>>                                 rcu_dereference_raw(hlist_first_rcu(&b->list)),
>>                                 struct bpf_local_storage_elem, map_node))) {
>> -                       migrate_disable();
>>                         if (busy_counter)
>>                                 this_cpu_inc(*busy_counter);
>>                         bpf_selem_unlink(selem, true);
>>                         if (busy_counter)
>>                                 this_cpu_dec(*busy_counter);
>> -                       migrate_enable();
>>                         cond_resched_rcu();
>>                 }
>>                 rcu_read_unlock();
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 8bf1ad326e02..6051f8a39fec 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1570,14 +1570,12 @@ static void htab_map_free(struct bpf_map *map)
>>          * underneath and is responsible for waiting for callbacks to finish
>>          * during bpf_mem_alloc_destroy().
>>          */
>> -       migrate_disable();
>>         if (!htab_is_prealloc(htab)) {
>>                 delete_all_elements(htab);
>>         } else {
>>                 htab_free_prealloced_fields(htab);
>>                 prealloc_destroy(htab);
>>         }
>> -       migrate_enable();
>>
>>         bpf_map_free_elem_count(map);
>>         free_percpu(htab->extra_elems);
>> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
>> index 5bdf9aadca3a..37b80a23ae1a 100644
>> --- a/kernel/bpf/range_tree.c
>> +++ b/kernel/bpf/range_tree.c
>> @@ -259,9 +259,7 @@ void range_tree_destroy(struct range_tree *rt)
>>
>>         while ((rn = range_it_iter_first(rt, 0, -1U))) {
>>                 range_it_remove(rn, rt);
>> -               migrate_disable();
>>                 bpf_mem_free(&bpf_global_ma, rn);
>> -               migrate_enable();
>>         }
>>  }
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 0503ce1916b6..e7a41abe4809 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -835,8 +835,14 @@ static void bpf_map_free(struct bpf_map *map)
>>         struct btf_record *rec = map->record;
>>         struct btf *btf = map->btf;
>>
>> -       /* implementation dependent freeing */
>> +       /* implementation dependent freeing. Disabling migration to simplify
>> +        * the free of values or special fields allocated from bpf memory
>> +        * allocator.
>> +        */
>> +       migrate_disable();
>>         map->ops->map_free(map);
>> +       migrate_enable();
>> +
> I was about to comment on patches 10-13 that it's
> better to do it in bpf_map_free(), but then I got to this patch.
> All makes sense, but the patch breakdown is too fine grain.
> Patches 10-13 introduce migrate pairs only to be deleted
> in patch 15. Please squash them into one patch.

OK. However I need to argue for the fine grained break down. The
original though is that if disabling migration for ->map_free callback
for all maps introduces some problems, we could revert the patch #15
separately instead of reverting the squashed patch and moving the
migrate_{disable|enable}() pair to maps which are OK with that change
again.  What do you think ?
>
> Also you mention in the cover letter:
>
>> Considering the bpf-next CI is broken
> What is this about?

Er, I said it wrong. It is my local bpf-next setup. A few days ago, when
I tried to verify the patch by using bpf_next/for-next treee, the
running of test_maps and test_progs failed. Will check today that
whether it is OK.
>
> The cant_migrate() additions throughout looks
> a bit out of place. All that code doesn't care about migrations.
> Only bpf_ma code does. Let's add it there instead?
> The stack trace will tell us the caller anyway,
> so no information lost.

OK. However bpf_ma is not the only one which needs disabled migration.
The reason that bpf_ma needs migrate_disable() is the use of
this_cpu_ptr(). However, there are many places in bpf which use
this_cpu_ptr() (e.g., bpf_for_each_array_elem) and this_cpu_{in|del}
pair (e.g., bpf_cgrp_storage_lock).  I will check the cant_migrate which
can be removed in v2.
>
> Overall it looks great.

Thanks for these suggestions.
>
> pw-bot: cr
> .


