Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8502E692C72
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBKBJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 20:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBKBJ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 20:09:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5574F6FEAD;
        Fri, 10 Feb 2023 17:09:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PDCF95crtz4f3jYp;
        Sat, 11 Feb 2023 09:09:49 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgAHuq3a6uZjMh+QDQ--.52692S2;
        Sat, 11 Feb 2023 09:09:50 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
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
        Hou Tao <houtao1@huawei.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
 <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
 <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo>
 <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com>
Date:   Sat, 11 Feb 2023 09:09:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgAHuq3a6uZjMh+QDQ--.52692S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar43KrWrur1xGw15Wr1xXwb_yoW7ury3pF
        WxGF1UGF4UJr1UArsFqwn8tr1UtrW5Jr1UWr1UKr1Uurn0vrn3Gr1rJa1UCFyUAr48KF1U
        Jr4jq343Z34UA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/11/2023 5:06 AM, Alexei Starovoitov wrote:
> On Fri, Feb 10, 2023 at 8:33 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Wed, Jan 04, 2023 at 07:26:12PM CET, Alexei Starovoitov wrote:
>>> On Tue, Jan 3, 2023 at 11:14 PM Yonghong Song <yhs@meta.com> wrote:
>>>>
>>>>
>>>> On 1/3/23 10:30 PM, Hou Tao wrote:
>>>>> Hi,
>>>>>
>>>>> On 1/4/2023 2:10 PM, Yonghong Song wrote:
>>>>>>
>>>>>> On 1/3/23 5:47 AM, Hou Tao wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 1/2/2023 2:48 AM, Yonghong Song wrote:
>>>>>>>>
>>>>>>>> On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
>>>>>>>>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
>>>>>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> The patchset tries to fix the problems found when checking how htab map
>>>>>>>>>> handles element reuse in bpf memory allocator. The immediate reuse of
>>>>>>>>>> freed elements may lead to two problems in htab map:
>>>>>>>>>>
>>>>>>>>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>>>>>>>>>>        htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>>>>>>>>>>        flag which acquires bpf-spin-lock during value copying. The
>>>>>>>>>>        corruption of bpf-spin-lock may result in hard lock-up.
>>>>>>>>>> (2) lookup procedure may get incorrect map value if the found element is
>>>>>>>>>>        freed and then reused.
>>>>>>>>>>
>>>>>>>>>> Because the type of htab map elements are the same, so problem #1 can be
>>>>>>>>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
>>>>>>>>>> these special fields in map element only when the map element is newly
>>>>>>>>>> allocated. If it is just a reused element, there will be no
>>>>>>>>>> reinitialization.
>>>>>>>>> Instead of adding the overhead of ctor callback let's just
>>>>>>>>> add __GFP_ZERO to flags in __alloc().
>>>>>>>>> That will address the issue 1 and will make bpf_mem_alloc behave just
>>>>>>>>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
>>>>>>>>> will behave the same way.
>>>>>>>> Patch https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/
>>>>>>>> tried to address a similar issue for lru hash table.
>>>>>>>> Maybe we need to do similar things after bpf_mem_cache_alloc() for
>>>>>>>> hash table?
>>>>>>> IMO ctor or __GFP_ZERO will fix the issue. Did I miss something here ?
>>>>>> The following is my understanding:
>>>>>> in function alloc_htab_elem() (hashtab.c), we have
>>>>>>
>>>>>>                  if (is_map_full(htab))
>>>>>>                          if (!old_elem)
>>>>>>                                  /* when map is full and update() is replacing
>>>>>>                                   * old element, it's ok to allocate, since
>>>>>>                                   * old element will be freed immediately.
>>>>>>                                   * Otherwise return an error
>>>>>>                                   */
>>>>>>                                  return ERR_PTR(-E2BIG);
>>>>>>                  inc_elem_count(htab);
>>>>>>                  l_new = bpf_mem_cache_alloc(&htab->ma);
>>>>>>                  if (!l_new) {
>>>>>>                          l_new = ERR_PTR(-ENOMEM);
>>>>>>                          goto dec_count;
>>>>>>                  }
>>>>>>                  check_and_init_map_value(&htab->map,
>>>>>>                                           l_new->key + round_up(key_size, 8));
>>>>>>
>>>>>> In the above check_and_init_map_value() intends to do initializing
>>>>>> for an element from bpf_mem_cache_alloc (could be reused from the free list).
>>>>>>
>>>>>> The check_and_init_map_value() looks like below (in include/linux/bpf.h)
>>>>>>
>>>>>> static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
>>>>>> {
>>>>>>          int i;
>>>>>>
>>>>>>          if (!foffs)
>>>>>>                  return;
>>>>>>          for (i = 0; i < foffs->cnt; i++)
>>>>>>                  memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
>>>>>> }
>>>>>>
>>>>>> static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
>>>>>> {
>>>>>>          bpf_obj_init(map->field_offs, dst);
>>>>>> }
>>>>>>
>>>>>> IIUC, bpf_obj_init() will bzero those fields like spin_lock, timer,
>>>>>> list_head, list_node, etc.
>>>>>>
>>>>>> This is the problem for above problem #1.
>>>>>> Maybe I missed something?
>>>>> Yes. It is the problem patch #1 tries to fix exactly. Patch #1 tries to fix the
>>>>> problem by only calling check_and_init_map_value() once for the newly-allocated
>>>>> element, so if a freed element is reused, its special fields will not be zeroed
>>>>> again. Is there any other cases which are not covered by the solution or any
>>>>> other similar problems in hash-tab ?
>>>> No, I checked all cases of check_and_init_map_value() and didn't find
>>>> any other instances.
>>> check_and_init_map_value() is called in two other cases:
>>> lookup_and_delete[_batch].
>>> There the zeroing of the fields is necessary because the 'value'
>>> is a temp buffer that is going to be copied to user space.
>>> I think the way forward is to add GFP_ZERO to mem_alloc
>>> (to make it equivalent to prealloc), remove one case
>>> of check_and_init_map_value from hashmap, add short comments
>>> to two other cases and add a big comment to check_and_init_map_value()
>>> that should say that 'dst' must be a temp buffer and should not
>>> point to memory that could be used in parallel by a bpf prog.
>>> It feels like we've dealt with this issue a couple times already
>>> and keep repeating this mistake, so the more comments the better.
>> Hou, are you plannning to resubmit this change? I also hit this while testing my
>> changes on bpf-next.
> Are you talking about the whole patch set or just GFP_ZERO in mem_alloc?
> The former will take a long time to settle.
> The latter is trivial.
> To unblock yourself just add GFP_ZERO in an extra patch?
Sorry for the long delay. Just find find out time to do some tests to compare
the performance of bzero and ctor. After it is done, will resubmit on next week.
> .

