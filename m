Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1206F62CD
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEDCIS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 22:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDCIR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 22:08:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B4135;
        Wed,  3 May 2023 19:08:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBcfd2cn9z4f3tPG;
        Thu,  4 May 2023 10:08:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgBHsCqGE1NkMiPHIA--.61202S2;
        Thu, 04 May 2023 10:08:10 +0800 (CST)
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
 <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <0fc99af7-fa0d-c5c7-00c4-3f446a5ad77b@linux.dev>
 <20230503230603.auijigbydnifxah5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <145d1fb6-93c7-ac5d-7818-9a9cca542dbf@linux.dev>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <0c5e6d36-30e5-cc0e-e0e2-d360045f84e1@huaweicloud.com>
Date:   Thu, 4 May 2023 10:08:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <145d1fb6-93c7-ac5d-7818-9a9cca542dbf@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgBHsCqGE1NkMiPHIA--.61202S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWfAF13Zr18Xr18CFy8Zrb_yoW5Zr18pF
        WfAF98GF95X3yIyrn2qr1IyF48Zws0vry7tr4j9r10krsxJr9xXF4jya1YgFy5Krs7XayY
        qryYq3Z3Ga9Yva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 5/4/2023 7:39 AM, Martin KaFai Lau wrote:
> On 5/3/23 4:06 PM, Alexei Starovoitov wrote:
>> On Wed, May 03, 2023 at 02:57:03PM -0700, Martin KaFai Lau wrote:
>>> On 5/3/23 11:48 AM, Alexei Starovoitov wrote:
SNIP
>>>
>>> If the bpf prog always does a bpf_rcu_read_lock() before accessing the
>>> (e.g.) task local storage, it can remove the reuse_now conditions in
>>> the
>>> bpf_local_storage and directly call the bpf_mem_cache_free().
>>>
>>> The only corner use case is when the bpf_prog or syscall does
>>> bpf_task_storage_delete() instead of having the task storage stays
>>> with the
>>> whole lifetime of the task_struct. Using REUSE_AFTER_RCU_GP will be
>>> a change
>>> of this uaf guarantee to the sleepable program but it is still safe
>>> because
>>> it is freed after tasks_trace gp. We could take this chance to align
>>> this
>>> behavior of the local storage map to the other bpf maps.
>>>
>>> For BPF_MA_FREE_AFTER_RCU_GP, there are cases that the bpf local
>>> storage
>>> knows it can be freed without waiting tasks_trace gp. However, only
>>> task/cgroup storages are in bpf ma and I don't believe this
>>> optimization
>>> matter much for them. I would rather focus on the REUSE_AFTER_RCU_GP
>>> first.
OK.
>>
>> I'm confused which REUSE_AFTER_RCU_GP you meant.
>> What I proposed above is
>> REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace
>
> Regarding REUSE_AFTER_RCU_GP, I meant
> REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace.
>
>>
>> Hou's proposals: 1. BPF_MA_REUSE_AFTER_two_RCUs_GP 2.
>> BPF_MA_FREE_AFTER_single_RCU_GP
>
> It probably is where the confusion is. I thought Hou's
> BPF_MA_REUSE_AFTER_RCU_GP is already
> REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace. From the commit
> message:
>
> " ... So introduce BPF_MA_REUSE_AFTER_RCU_GP to solve these problems. For
> BPF_MA_REUSE_AFTER_GP, the freed objects are reused only after one RCU
> grace period and may be returned back to slab system after another
> RCU-tasks-trace grace period. ..."
>
> [I assumed BPF_MA_REUSE_AFTER_GP is just a typo of
> BPF_MA_REUSE_AFTER_"RCU"_GP]
Yes. Now the implementation of BPF_MA_REUSE_AFTER_RCU_GP is already
being REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace. It moves the
free objects to reuse_ready_head list after one RCU GP, splices the
elements in reuse_ready_head to wait_for_free when reuse_ready_head is
not empty and frees these elements in wait_for_free by
call_rcu_tasks_trace().
>
>>
>> If I'm reading bpf_local_storage correctly it can remove reuse_now logic
>> in all conditions with
>> REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace.
>
> Right, for smap->bpf_ma == true (cgroup and task storage), all
> reuse_now logic can be gone and directly use the bpf_mem_cache_free().
> Potentially the sk/inode can also move to bpf_ma after running some
> benchmark. This will simplify things a lot. For sk storage, the
> reuse_now was there to avoid the unnecessary tasks_trace gp because
> performance impact was reported on sk storage where connections can be
> open-and-close very frequently.


