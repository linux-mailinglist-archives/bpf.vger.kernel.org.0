Return-Path: <bpf+bounces-17115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D07809E21
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2501C20C0F
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B2111B0;
	Fri,  8 Dec 2023 08:30:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C784171C
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 00:30:35 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SmkqC06Lvz4f3jHt
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:30:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 217721A09FF
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:30:32 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDX5UUi1HJl3HmfDA--.4496S2;
	Fri, 08 Dec 2023 16:30:29 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next v4] bpf: Fix a race condition between btf_put()
 and map_free()
To: Yonghong Song <yonghong.song@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20231206210959.1035724-1-yonghong.song@linux.dev>
 <d1c0232c-a41c-4cce-9bdf-3a1e8850ed05@linux.dev>
 <969852f3-34f8-45d9-bf2d-f6a4d5167e55@linux.dev>
 <ad71a99d-8b5f-44b4-99ee-5afb31c60bff@linux.dev>
Message-ID: <0b3a96bd-4dfc-6d23-d473-f4351fbe84c2@huaweicloud.com>
Date: Fri, 8 Dec 2023 16:30:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ad71a99d-8b5f-44b4-99ee-5afb31c60bff@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDX5UUi1HJl3HmfDA--.4496S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KF13KF1DAF1Utr43Xr15XFb_yoWDWF4UpF
	18JF1UCrW8Jr18Ar1Dtr1UuryUtryUJw1UXr18Ja4Utr1Utr1qqF1UWryjgr15Gr48Jr4U
	Ar1jqry7Zr1UJFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 12/8/2023 12:02 PM, Yonghong Song wrote:
>
> On 12/7/23 7:59 PM, Yonghong Song wrote:
>>
>> On 12/7/23 5:23 PM, Martin KaFai Lau wrote:
>>> On 12/6/23 1:09 PM, Yonghong Song wrote:
>>>> When running `./test_progs -j` in my local vm with latest kernel,
>>>> I once hit a kasan error like below:
>>>>
>>>>  

SNIP
>>>> Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with
>>>> following code:
>>>>
>>>>    meta = btf_find_struct_meta(btf, btf_id);
>>>>    if (!meta)
>>>>      return -EFAULT;
>>>>    rec->fields[i].graph_root.value_rec = meta->record;
>>>>
>>>> So basically, 'value_rec' is a pointer to the record in
>>>> struct_metas_tab.
>>>> And it is possible that that particular record has been freed by
>>>> btf_struct_metas_free() and hence we have a kasan error here.
>>>>
>>>> Actually it is very hard to reproduce the failure with current
>>>> bpf/bpf-next
>>>> code, I only got the above error once. To increase reproducibility,
>>>> I added
>>>> a delay in bpf_map_free_deferred() to delay map->ops->map_free(),
>>>> which
>>>> significantly increased reproducibility.
>>>>
>>>>    diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>>    index 5e43ddd1b83f..aae5b5213e93 100644
>>>>    --- a/kernel/bpf/syscall.c
>>>>    +++ b/kernel/bpf/syscall.c
>>>>    @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct
>>>> work_struct *work)
>>>>          struct bpf_map *map = container_of(work, struct bpf_map,
>>>> work);
>>>>          struct btf_record *rec = map->record;
>>>>
>>>>    +     mdelay(100);
>>>>          security_bpf_map_free(map);
>>>>          bpf_map_release_memcg(map);
>>>>          /* implementation dependent freeing */
>>>>
>>>> To fix the problem, we need to have a reference on btf in order to
>>>> safeguard accessing field->graph_root.value_rec in
>>>> map->ops->map_free().
>>>> The function btf_parse_graph_root() is the place to get a btf
>>>> reference.
>>>> The following are rough call stacks reaching bpf_parse_graph_root():
>>>>
>>>>     btf_parse
>>>>       ...
>>>>         btf_parse_fields
>>>>           ...
>>>>             btf_parse_graph_root
>>>>
>>>>     map_check_btf
>>>>       btf_parse_fields
>>>>         ...
>>>>           btf_parse_graph_root
>>>>
>>>> Looking at the above call stack, the btf_parse_graph_root() is
>>>> indirectly
>>>> called from btf_parse() or map_check_btf().
>>>>
>>>> We cannot take a reference in btf_parse() case since at that moment,
>>>> btf is still in the middle to self-validation and initial reference
>>>> (refcount_set(&btf->refcnt, 1)) has not been triggered yet.
>>>
>>> Thanks for the details analysis and clear explanation. It helps a lot.
>>>
>>> Sorry for jumping in late.
>>>
>>> I am trying to avoid making a special case for "bool has_btf_ref;"
>>> and "bool from_map_check". It seems to a bit too much to deal with
>>> the error path for btf_parse().

Maybe we could move the common btf used by kptr and graph_root into
bpf_record and let the callers of btf_parse_fields()  and
btf_record_free() to decide the life cycle of btf in btf_record, so
there will be less intrusive and less special case. The following is the
code snippets for the idea (only simply tested):

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ad0ed623f50..a0c4d696a231 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -230,6 +230,7 @@ struct btf_record {
        int spin_lock_off;
        int timer_off;
        int refcount_off;
+       struct btf *btf;
        struct btf_field fields[];
 };

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 966dace27fae..08b4a2784ee4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3598,7 +3598,6 @@ static int btf_parse_kptr(struct btf *btf, struct
btf_field *field,
                field->kptr.dtor = NULL;
                id = info->kptr.type_id;
                kptr_btf = btf;
-               btf_get(kptr_btf);
                goto found_dtor;
        }
        if (id < 0)
@@ -3753,6 +3752,7 @@ struct btf_record *btf_parse_fields(struct btf
*btf, const struct btf_type *t,
        if (!rec)
                return ERR_PTR(-ENOMEM);

+       rec->btf = btf;
        rec->spin_lock_off = -EINVAL;
        rec->timer_off = -EINVAL;
        rec->refcount_off = -EINVAL;
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 8ef269e66ba5..d9f4198158b6 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -56,6 +56,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
                ret = PTR_ERR(inner_map_meta->record);
                goto free;
        }
+       if (inner_map_meta->record)
+               btf_get(inner_map_meta->record->btf);
+
        /* Note: We must use the same BTF, as we also used
btf_record_dup above
         * which relies on BTF being same for both maps, as some members
like
         * record->fields.list_head have pointers like value_rec
pointing into
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 30ed7756fc71..d2641e51a1a7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -516,7 +516,8 @@ void btf_record_free(struct btf_record *rec)
                case BPF_KPTR_PERCPU:
                        if (rec->fields[i].kptr.module)
                                module_put(rec->fields[i].kptr.module);
-                       btf_put(rec->fields[i].kptr.btf);
+                       if (rec->fields[i].kptr.btf != rec->btf)
+                               btf_put(rec->fields[i].kptr.btf);
                        break;
                case BPF_LIST_HEAD:
                case BPF_LIST_NODE:
@@ -537,8 +538,13 @@ void btf_record_free(struct btf_record *rec)

 void bpf_map_free_record(struct bpf_map *map)
 {
+       struct btf *btf = NULL;
+
+       if (!IS_ERR_OR_NULL(map->record))
+               btf = map->record->btf;
        btf_record_free(map->record);
        map->record = NULL;
+       btf_put(btf);
 }

 struct btf_record *btf_record_dup(const struct btf_record *rec)
@@ -561,7 +567,8 @@ struct btf_record *btf_record_dup(const struct
btf_record *rec)
                case BPF_KPTR_UNREF:
                case BPF_KPTR_REF:
                case BPF_KPTR_PERCPU:
-                       btf_get(fields[i].kptr.btf);
+                       if (fields[i].kptr.btf != rec->btf)
+                               btf_get(fields[i].kptr.btf);
                        if (fields[i].kptr.module &&
!try_module_get(fields[i].kptr.module)) {
                                ret = -ENXIO;
                                goto free;
@@ -692,7 +699,10 @@ static void bpf_map_free_deferred(struct
work_struct *work)
 {
        struct bpf_map *map = container_of(work, struct bpf_map, work);
        struct btf_record *rec = map->record;
+       struct btf *btf = NULL;

+       if (!IS_ERR_OR_NULL(rec))
+               btf = rec->btf;
        security_bpf_map_free(map);
        bpf_map_release_memcg(map);
        /* implementation dependent freeing */
@@ -707,6 +717,7 @@ static void bpf_map_free_deferred(struct work_struct
*work)
         * template bpf_map struct used during verification.
         */
        btf_record_free(rec);
+       btf_put(btf);
 }

 static void bpf_map_put_uref(struct bpf_map *map)
@@ -1036,6 +1047,8 @@ static int map_check_btf(struct bpf_map *map,
struct btf *btf,
        if (!IS_ERR_OR_NULL(map->record)) {
                int i;

+               btf_get(map->record->btf);
+
                if (!bpf_capable()) {
                        ret = -EPERM;
                        goto free_map_tab;



WDYT ?

>>>
>>> Would doing the refcount_set(&btf->refcnt, 1) earlier in btf_parse
>>> help?
>>
>> No, it does not. The core reason is what Hao is mentioned in
>> https://lore.kernel.org/bpf/47ee3265-23f7-2130-ff28-27bfaf3f7877@huaweicloud.com/
>>
>> We simply cannot take btf reference if called from btf_parse().
>> Let us say we move refcount_set(&btf->refcnt, 1) earlier in btf_parse()
>> so we take ref for btf during btf_parse_fields(), then we have
>>      btf_put <=== expect refcount == 0 to start the destruction process
>>        ...
>>          btf_record_free <=== in which if graph_root, a btf reference
>> will be hold
>> so btf_put will never be able to actually free btf data.
>> Yes, the kasan problem will be resolved but we leak memory.
> Let me send another version with better commit message.


>
> [...]


