Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7865CD17
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 07:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjADGaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 01:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjADGaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 01:30:20 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B337BE8;
        Tue,  3 Jan 2023 22:30:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nn08N4zztz4f3vfC;
        Wed,  4 Jan 2023 14:30:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgCHPbHxHLVjO71KBA--.483S2;
        Wed, 04 Jan 2023 14:30:13 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Yonghong Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
Date:   Wed, 4 Jan 2023 14:30:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgCHPbHxHLVjO71KBA--.483S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4fJry5Jr1kXr13Aw17Awb_yoW7Kr47pF
        W8GF1UJryUJr18Jr1Utr1UJryUtr4UJw1UXr1UJFyUJr1qqr1Iqr48Xr4j9FyUAr48JF1U
        Jr1jqr13Zr1UArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 1/4/2023 2:10 PM, Yonghong Song wrote:
>
>
> On 1/3/23 5:47 AM, Hou Tao wrote:
>> Hi,
>>
>> On 1/2/2023 2:48 AM, Yonghong Song wrote:
>>>
>>>
>>> On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
>>>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> Hi,
>>>>>
>>>>> The patchset tries to fix the problems found when checking how htab map
>>>>> handles element reuse in bpf memory allocator. The immediate reuse of
>>>>> freed elements may lead to two problems in htab map:
>>>>>
>>>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>>>>>       htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>>>>>       flag which acquires bpf-spin-lock during value copying. The
>>>>>       corruption of bpf-spin-lock may result in hard lock-up.
>>>>> (2) lookup procedure may get incorrect map value if the found element is
>>>>>       freed and then reused.
>>>>>
>>>>> Because the type of htab map elements are the same, so problem #1 can be
>>>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
>>>>> these special fields in map element only when the map element is newly
>>>>> allocated. If it is just a reused element, there will be no
>>>>> reinitialization.
>>>>
>>>> Instead of adding the overhead of ctor callback let's just
>>>> add __GFP_ZERO to flags in __alloc().
>>>> That will address the issue 1 and will make bpf_mem_alloc behave just
>>>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
>>>> will behave the same way.
>>>
>>> Patch https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/
>>> tried to address a similar issue for lru hash table.
>>> Maybe we need to do similar things after bpf_mem_cache_alloc() for
>>> hash table?
>> IMO ctor or __GFP_ZERO will fix the issue. Did I miss something here ?
>
> The following is my understanding:
> in function alloc_htab_elem() (hashtab.c), we have
>
>                 if (is_map_full(htab))
>                         if (!old_elem)
>                                 /* when map is full and update() is replacing
>                                  * old element, it's ok to allocate, since
>                                  * old element will be freed immediately.
>                                  * Otherwise return an error
>                                  */
>                                 return ERR_PTR(-E2BIG);
>                 inc_elem_count(htab);
>                 l_new = bpf_mem_cache_alloc(&htab->ma);
>                 if (!l_new) {
>                         l_new = ERR_PTR(-ENOMEM);
>                         goto dec_count;
>                 }
>                 check_and_init_map_value(&htab->map,
>                                          l_new->key + round_up(key_size, 8));
>
> In the above check_and_init_map_value() intends to do initializing
> for an element from bpf_mem_cache_alloc (could be reused from the free list).
>
> The check_and_init_map_value() looks like below (in include/linux/bpf.h)
>
> static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
> {
>         int i;
>
>         if (!foffs)
>                 return;
>         for (i = 0; i < foffs->cnt; i++)
>                 memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
> }
>
> static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> {
>         bpf_obj_init(map->field_offs, dst);
> }
>
> IIUC, bpf_obj_init() will bzero those fields like spin_lock, timer,
> list_head, list_node, etc.
>
> This is the problem for above problem #1.
> Maybe I missed something?
Yes. It is the problem patch #1 tries to fix exactly. Patch #1 tries to fix the
problem by only calling check_and_init_map_value() once for the newly-allocated
element, so if a freed element is reused, its special fields will not be zeroed
again. Is there any other cases which are not covered by the solution or any
other similar problems in hash-tab ?
>
>>>
>>>
>>>>
>>>>> Problem #2 exists for both non-preallocated and preallocated htab map.
>>>>> By adding seq in htab element, doing reuse check and retrying the
>>>>> lookup procedure may be a feasible solution, but it will make the
>>>>> lookup API being hard to use, because the user needs to check whether
>>>>> the found element is reused or not and repeat the lookup procedure if it
>>>>> is reused. A simpler solution would be just disabling freed elements
>>>>> reuse and freeing these elements after lookup procedure ends.
>>>>
>>>> You've proposed this 'solution' twice already in qptrie thread and both
>>>> times the answer was 'no, we cannot do this' with reasons explained.
>>>> The 3rd time the answer is still the same.
>>>> This 'issue 2' existed in hashmap since very beginning for many years.
>>>> It's a known quirk. There is nothing to fix really.
>>>>
>>>> The graph apis (aka new gen data structs) with link list and rbtree are
>>>> in active development. Soon bpf progs will be able to implement their own
>>>> hash maps with explicit bpf_rcu_read_lock. At that time the progs will
>>>> be making the trade off between performance and lookup/delete race.
>>>> So please respin with just __GFP_ZERO and update the patch 6
>>>> to check for lockup only.
>>

