Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD4698A62
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 03:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBPCLx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 21:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPCLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 21:11:53 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC5C3581;
        Wed, 15 Feb 2023 18:11:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PHJNL46qtz4f3jJH;
        Thu, 16 Feb 2023 10:11:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgCXSa3gkO1juizSDg--.1703S2;
        Thu, 16 Feb 2023 10:11:48 +0800 (CST)
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
 <7fef4ece-0982-cb43-ed39-e73791436355@huaweicloud.com>
 <2b1ddc4c-9905-899a-a903-e66a6e8b4d58@linux.dev>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <5f22c315-ed38-b677-f36b-496d89847467@huaweicloud.com>
Date:   Thu, 16 Feb 2023 10:11:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2b1ddc4c-9905-899a-a903-e66a6e8b4d58@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgCXSa3gkO1juizSDg--.1703S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryDGw17tr4rCF4rCw45Wrg_yoWrJF13pF
        WIga45Gr1kJw4Sy3srZFZ7ZFyrAwn5G3yDKrs5KF18Ars8Xr93GFWIka13ZFy5ur4kWa1j
        vr15X3WDGF4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2/15/2023 3:22 PM, Martin KaFai Lau wrote:
> On 2/14/23 8:02 PM, Hou Tao wrote:
>>> For local storage, when its owner (sk/task/inode/cgrp) is going away, the
>>> memory can be reused immediately. No rcu gp is needed.
>> Now it seems it will wait for RCU GP and i think it is still necessary, because
>> when the process exits, other processes may still access the local storage
>> through pidfd or task_struct of the exited process.
>
> When its owner (sk/task/cgrp...) is going away, its owner has reached refcnt 0
> and will be kfree immediately next. eg. bpf_sk_storage_free is called just
> before the sk is about to be kfree. No bpf prog should have a hold on this sk.
> The same should go for the task.
A bpf syscall may have already found the task local storage through a pidfd,
then the target task exits and the local storage is free immediately, then bpf
syscall starts to copy the local storage and there will be a UAF, right ? Did I
missing something here ?
>
> The current rcu gp waiting during bpf_{sk,task,cgrp...}_storage_free is
> because the racing with the map destruction bpf_local_storage_map_free().
>
>>>
>>> The local storage delete case (eg. bpf_sk_storage_delete) is the only one that
>>> needs to be freed by tasks_trace gp because another bpf prog (reader) may be
>>> under the rcu_read_lock_trace(). I think the idea (BPF_REUSE_AFTER_RCU_GP) on
>>> allowing reuse after vanilla rcu gp and free (if needed) after tasks_trace gp
>>> can be extended to the local storage delete case. I think we can extend the
>>> assumption that "sleepable progs (reader) can use explicit bpf_rcu_read_lock()
>>> when they want to avoid uaf" to bpf_{sk,task,inode,cgrp}_storage_get() also.
>>>
>> It seems bpf_rcu_read_lock() & bpf_rcu_read_unlock() will be used to protect not
>> only bpf_task_storage_get(), but also the dereferences of the returned local
>> storage ptr, right ? I think qp-trie may also need this.
>
> I think bpf_rcu_read_lock() is primarily for bpf prog.
Yes. I mean the bpf program which uses qp-trie will need bpf_rcu_read_lock().
>
> The bpf_{sk,task,...}_storage_get() internal is easier to handle and probably
> will need to do its own rcu_read_lock() instead of depending on the bpf prog
> doing the bpf_rcu_read_lock() because the bpf prog may decide uaf is fine.
>
>>> I also need the GFP_ZERO in bpf_mem_alloc, so will work on the GFP_ZERO and
>>> the BPF_REUSE_AFTER_RCU_GP idea.  Probably will get the GFP_ZERO out first.
>> I will continue work on this patchset for GFP_ZERO and reuse flag. Do you mean
>> that you want to work together to implement BPF_REUSE_AFTER_RCU_GP ? How do we
>> cooperate together to accomplish that ?
> Please submit the GFP_ZERO patch first. Kumar and I can use it immediately.
>
> I have been hacking to make bpf's memalloc safe for the
> bpf_{sk,task,cgrp..}_storage_delete() and this safe-on-reuse piece still need
> works. The whole thing is getting pretty long, so my current plan is to put
> the safe-on-reuse piece aside for now, focus back on the immediate goal and
> make the common case deadlock free first. Meaning the
> bpf_*_storage_get(BPF_*_STORAGE_GET_F_CREATE) and the bpf_*_storage_free()
> will use the bpf_mem_cache_{alloc,free}. The bpf_*_storage_delete() will stay
> as-is to go through the call_rcu_tasks_trace() for now since delete is not the
> common use case.
>
> In parallel, if you can post the BPF_REUSE_AFTER_RCU_GP, we can discuss based
> on your work. That should speed up the progress. If I finished the immediate
> goal for local storage and this piece is still pending, I will ping you
> first.  Thoughts?
I am fine with the proposal, thanks.

