Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B365C11A
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 14:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjACNsF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 08:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbjACNsB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 08:48:01 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAC21144E;
        Tue,  3 Jan 2023 05:47:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NmYvr6HV4z4f3v6S;
        Tue,  3 Jan 2023 21:47:52 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDn2ugCMrRj6SAPBA--.49839S2;
        Tue, 03 Jan 2023 21:47:49 +0800 (CST)
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
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
Date:   Tue, 3 Jan 2023 21:47:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDn2ugCMrRj6SAPBA--.49839S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZry7Xr1fXF47Gw48Ww4DArb_yoW5ArW3pF
        WSga15ArWkCw1I9w42vwnxGFyUKw4fGFy7Grn8A34UCrsYgrn3trWSqa15CFyUAFZ5GF1q
        qF1qq393Zw1aya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UdxhLUUUUU=
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

On 1/2/2023 2:48 AM, Yonghong Song wrote:
>
>
> On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> Hi,
>>>
>>> The patchset tries to fix the problems found when checking how htab map
>>> handles element reuse in bpf memory allocator. The immediate reuse of
>>> freed elements may lead to two problems in htab map:
>>>
>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>>>      htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>>>      flag which acquires bpf-spin-lock during value copying. The
>>>      corruption of bpf-spin-lock may result in hard lock-up.
>>> (2) lookup procedure may get incorrect map value if the found element is
>>>      freed and then reused.
>>>
>>> Because the type of htab map elements are the same, so problem #1 can be
>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
>>> these special fields in map element only when the map element is newly
>>> allocated. If it is just a reused element, there will be no
>>> reinitialization.
>>
>> Instead of adding the overhead of ctor callback let's just
>> add __GFP_ZERO to flags in __alloc().
>> That will address the issue 1 and will make bpf_mem_alloc behave just
>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
>> will behave the same way.
>
> Patch https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/
> tried to address a similar issue for lru hash table.
> Maybe we need to do similar things after bpf_mem_cache_alloc() for
> hash table?
IMO ctor or __GFP_ZERO will fix the issue. Did I miss something here ?
>
>
>>
>>> Problem #2 exists for both non-preallocated and preallocated htab map.
>>> By adding seq in htab element, doing reuse check and retrying the
>>> lookup procedure may be a feasible solution, but it will make the
>>> lookup API being hard to use, because the user needs to check whether
>>> the found element is reused or not and repeat the lookup procedure if it
>>> is reused. A simpler solution would be just disabling freed elements
>>> reuse and freeing these elements after lookup procedure ends.
>>
>> You've proposed this 'solution' twice already in qptrie thread and both
>> times the answer was 'no, we cannot do this' with reasons explained.
>> The 3rd time the answer is still the same.
>> This 'issue 2' existed in hashmap since very beginning for many years.
>> It's a known quirk. There is nothing to fix really.
>>
>> The graph apis (aka new gen data structs) with link list and rbtree are
>> in active development. Soon bpf progs will be able to implement their own
>> hash maps with explicit bpf_rcu_read_lock. At that time the progs will
>> be making the trade off between performance and lookup/delete race.
>> So please respin with just __GFP_ZERO and update the patch 6
>> to check for lockup only.

