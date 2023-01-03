Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2711465C0FE
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 14:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjACNkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 08:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjACNkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 08:40:42 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8610FE8;
        Tue,  3 Jan 2023 05:40:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NmYlP0J09z4f3s6S;
        Tue,  3 Jan 2023 21:40:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDXyuhPMLRjw9QOBA--.36969S2;
        Tue, 03 Jan 2023 21:40:35 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <2f875cf9-88ac-1406-4ad0-f7647fb92883@huaweicloud.com>
Date:   Tue, 3 Jan 2023 21:40:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDXyuhPMLRjw9QOBA--.36969S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryxCF13XryDWFyrtF1UJrb_yoW5tr47pF
        WSg3W3Ar4kG34I9rsrXw4DWF17Jws3GFy7Jry5tryUur4rWrnayFyfta1rCFW5AFWkGFyq
        qF1qv393Zwn0937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        9x07UWE__UUUUU=
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

On 1/1/2023 9:26 AM, Alexei Starovoitov wrote:
> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> The patchset tries to fix the problems found when checking how htab map
>> handles element reuse in bpf memory allocator. The immediate reuse of
>> freed elements may lead to two problems in htab map:
>>
>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>>     htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>>     flag which acquires bpf-spin-lock during value copying. The
>>     corruption of bpf-spin-lock may result in hard lock-up.
>> (2) lookup procedure may get incorrect map value if the found element is
>>     freed and then reused.
>>
>> Because the type of htab map elements are the same, so problem #1 can be
>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
>> these special fields in map element only when the map element is newly
>> allocated. If it is just a reused element, there will be no
>> reinitialization.
> Instead of adding the overhead of ctor callback let's just
> add __GFP_ZERO to flags in __alloc().
> That will address the issue 1 and will make bpf_mem_alloc behave just
> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
> will behave the same way.
Use __GPF_ZERO will be simpler, but the overhead of memset() for every allocated
object may be bigger than ctor callback when the size of allocated object is
large. And it also introduces unnecessary memory zeroing if there is no special
field in the map value.

>> Problem #2 exists for both non-preallocated and preallocated htab map.
>> By adding seq in htab element, doing reuse check and retrying the
>> lookup procedure may be a feasible solution, but it will make the
>> lookup API being hard to use, because the user needs to check whether
>> the found element is reused or not and repeat the lookup procedure if it
>> is reused. A simpler solution would be just disabling freed elements
>> reuse and freeing these elements after lookup procedure ends.
> You've proposed this 'solution' twice already in qptrie thread and both
> times the answer was 'no, we cannot do this' with reasons explained.
> The 3rd time the answer is still the same.
This time a workable demo which calls call_rcu_task_trace() in batch is provided
:) Also because I can not find a better solution for the reuse problem. But you
are right, although don't reuse the freed element will make the implementation
of map simpler, the potential OOM problem is hard to solve specially when RCU
tasks trace grace period is slow. Hope Paul can provide some insight about the
problem.
> This 'issue 2' existed in hashmap since very beginning for many years.
> It's a known quirk. There is nothing to fix really.
Do we need to document the unexpected behavior somewhere, because I really don't
know nothing about the quirk ?
>
> The graph apis (aka new gen data structs) with link list and rbtree are
> in active development. Soon bpf progs will be able to implement their own
> hash maps with explicit bpf_rcu_read_lock. At that time the progs will
> be making the trade off between performance and lookup/delete race.
It seems these new gen data struct also need to solve the reuse problem because
a global bpf memory allocator is used.
> So please respin with just __GFP_ZERO and update the patch 6
> to check for lockup only.
> .

