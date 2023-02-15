Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CE697519
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 05:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBOECa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 23:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOEC3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 23:02:29 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59622B629;
        Tue, 14 Feb 2023 20:02:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PGktQ2ZtWz4f3l7T;
        Wed, 15 Feb 2023 12:02:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgBXSOZMWexj68hkDg--.30292S2;
        Wed, 15 Feb 2023 12:02:24 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
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
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
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
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com>
 <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
 <CAADnVQJzS9MQKS2EqrdxO7rVLyjUYD6OG-Yefak62-JRNcheZg@mail.gmail.com>
 <6d48c284-42eb-9688-4259-79b7f096e294@linux.dev>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <7fef4ece-0982-cb43-ed39-e73791436355@huaweicloud.com>
Date:   Wed, 15 Feb 2023 12:02:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6d48c284-42eb-9688-4259-79b7f096e294@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgBXSOZMWexj68hkDg--.30292S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1UJFWrZw1xGr43JFyxXwb_yoWrGF17pF
        Waqas8Ar1kJw43K3s2qrs7ZFy5t3s5GrWUtr4rKr1UCr98Zr9agryxKFW5uF98Cr4fW3yj
        vry5Zas3Jw48AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2/15/2023 9:54 AM, Martin KaFai Lau wrote:
> On 2/11/23 8:34 AM, Alexei Starovoitov wrote:
>> On Sat, Feb 11, 2023 at 8:33 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Fri, Feb 10, 2023 at 5:10 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>>> Hou, are you plannning to resubmit this change? I also hit this while
>>>>>> testing my
>>>>>> changes on bpf-next.
>>>>> Are you talking about the whole patch set or just GFP_ZERO in mem_alloc?
>>>>> The former will take a long time to settle.
>>>>> The latter is trivial.
>>>>> To unblock yourself just add GFP_ZERO in an extra patch?
>>>> Sorry for the long delay. Just find find out time to do some tests to compare
>>>> the performance of bzero and ctor. After it is done, will resubmit on next
>>>> week.
>>>
>>> I still don't like ctor as a concept. In general the callbacks in the critical
>>> path are guaranteed to be slow due to retpoline overhead.
>>> Please send a patch to add GFP_ZERO.
>>>
>>> Also I realized that we can make the BPF_REUSE_AFTER_RCU_GP flag usable
>>> without risking OOM by only waiting for normal rcu GP and not rcu_tasks_trace.
>>> This approach will work for inner nodes of qptrie, since bpf progs
>>> never see pointers to them. It will work for local storage
>>> converted to bpf_mem_alloc too. It wouldn't need to use its own call_rcu.
>>> It's also safe without uaf caveat in sleepable progs and sleepable progs
>>
>> I meant 'safe with uaf caveat'.
>> Safe because we wait for rcu_task_trace later before returning to kernel memory.
For qp-trie, I had added reuse checking for qp-trie inner node by adding a
version in both child pointer and child node itself and it seemed works, but
using BPF_REUSE_AFTER_RCU_GP for inner node will be much simpler for the
implementation. And it seems for qp-trie leaf node, BPF_REUSE_AFTER_RCU_GP is
needed as well, else the value returned to caller in bpf program or syscall may
be reused just like hash-table during its usage. We can change qp-trie to act as
a set only (e.g., no value), but that will limit its usage scenario. Maybe
requiring the caller to use bpf_rcu_read_lock() is solution as well. What do you
think ?
>
> For local storage, when its owner (sk/task/inode/cgrp) is going away, the
> memory can be reused immediately. No rcu gp is needed.
Now it seems it will wait for RCU GP and i think it is still necessary, because
when the process exits, other processes may still access the local storage
through pidfd or task_struct of the exited process.
>
> The local storage delete case (eg. bpf_sk_storage_delete) is the only one that
> needs to be freed by tasks_trace gp because another bpf prog (reader) may be
> under the rcu_read_lock_trace(). I think the idea (BPF_REUSE_AFTER_RCU_GP) on
> allowing reuse after vanilla rcu gp and free (if needed) after tasks_trace gp
> can be extended to the local storage delete case. I think we can extend the
> assumption that "sleepable progs (reader) can use explicit bpf_rcu_read_lock()
> when they want to avoid uaf" to bpf_{sk,task,inode,cgrp}_storage_get() also.
>
It seems bpf_rcu_read_lock() & bpf_rcu_read_unlock() will be used to protect not
only bpf_task_storage_get(), but also the dereferences of the returned local
storage ptr, right ? I think qp-trie may also need this.
> I also need the GFP_ZERO in bpf_mem_alloc, so will work on the GFP_ZERO and
> the BPF_REUSE_AFTER_RCU_GP idea.  Probably will get the GFP_ZERO out first.
I will continue work on this patchset for GFP_ZERO and reuse flag. Do you mean
that you want to work together to implement BPF_REUSE_AFTER_RCU_GP ? How do we
cooperate together to accomplish that ?


>
>>
>>> can use explicit bpf_rcu_read_lock() when they want to avoid uaf.
>>> So please respin the set with rcu gp only and that new flag.

