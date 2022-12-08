Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891186466A5
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 02:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLHBta (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 20:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLHBt3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 20:49:29 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE067207
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 17:49:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NSHBn4gS9z4f3lHN
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 09:49:21 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgBn2dagQpFjEqNhBw--.44325S2;
        Thu, 08 Dec 2022 09:49:24 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/2] bpf: Reuse freed element in free_by_rcu
 during allocation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Hou Tao <houtao1@huawei.com>
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-2-houtao@huaweicloud.com>
 <05d1f326-55cc-d327-9e0a-e93add2a29cf@meta.com>
 <86fd4485-a016-d6f6-c31b-3aa76c261e91@huaweicloud.com>
 <CAADnVQ+zWyP9Hy--RLyZ6-VUEr-D6kXoFmV2L1Y4b0H=RHQbCQ@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <8a93b9ce-9368-3700-4900-30732c3a4591@huaweicloud.com>
Date:   Thu, 8 Dec 2022 09:49:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+zWyP9Hy--RLyZ6-VUEr-D6kXoFmV2L1Y4b0H=RHQbCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgBn2dagQpFjEqNhBw--.44325S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWkGF43ZrWxtF1rArW5KFg_yoW5Wr1DpF
        s5W3W3G3Z5C34Fkw1vy34kG3sruFZ5W39xXa4xZr12yrn8XwnYqrna9w4jyFyfCw1rAa4U
        Kr1DtwnIy3WFya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 12/7/2022 10:58 AM, Alexei Starovoitov wrote:
> On Tue, Dec 6, 2022 at 6:20 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 12/7/2022 9:52 AM, Yonghong Song wrote:
>>>
>>> On 12/5/22 8:29 PM, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> When there are batched freeing operations on a specific CPU, part of
>>>> the freed elements ((high_watermark - lower_watermark) / 2 + 1) will
>>>> be moved to waiting_for_gp list and the remaining part will be left in
>>>> free_by_rcu list and waits for the expiration of RCU-tasks-trace grace
>>>> period and the next invocation of free_bulk().
>>> The change below LGTM. However, the above description seems not precise.
>>> IIUC, free_by_rcu list => waiting_for_gp is controlled by whether
>>> call_rcu_in_progress is true or not. If it is true, free_by_rcu list
>>> will remain intact and not moving into waiting_for_gp list.
>>> So it is not 'the remaining part will be left in free_by_rcu'.
>>> It is all elements in free_by_rcu to waiting_for_gp or none.
>> Thanks for the review and the suggestions. I tried to say that moving from
>> free_by_rcu to waiting_for_gp is slow, and there can be many free elements being
>> stacked on free_by_rcu list. So how about the following rephrasing or do you
>> still prefer "It is all elements in free_by_rcu to waiting_for_gp or none."  ?
>>
>> When there are batched freeing operations on a specific CPU, part of the freed
>> elements ((high_watermark - lower_watermark) / 2 + 1) will be moved to
>> waiting_for_gp list  and the remaining part will be left in free_by_rcu list.
> I agree with Yonghong.
> The above sentence is not just not precise.
> 'elements moved to waiting_for_gp list' part is not correct.
> The elements never moved into it directly.
> Only via free_by_rcu list.
Yes.
>
> All or none also matters.
I am still confused about the "All or none". Does it mean all elements in
free_by_list will be moved into waiting_for_gp or none will be moved if
call_rcu_in_progress is true, right ?

So How about the following rephrasing ?

When there are batched freeing operations on a specific CPU, part of the freed
elements ((high_watermark - lower_watermark) / 2 + 1) will be indirectly moved
into waiting_for_gp list through free_by_rcu list. After call_rcu_in_progress
becomes false again, the remaining elements in free_by_rcu list will be moved to
waiting_for_gp list by the next invocation of free_bulk(). However if the
expiration of RCU tasks trace grace period is relatively slow, none element in
free_by_rcu list will be moved.

So instead of invoking __alloc_percpu_gfp() or kmalloc_node() to allocate a new
object, in alloc_bulk() just check whether or not there is freed element in
free_by_rcu list and reuse it if available.

> .

