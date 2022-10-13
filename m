Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3A5FD68C
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJMJCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMJCh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 05:02:37 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0171FFAA4C;
        Thu, 13 Oct 2022 02:02:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Mp3Ps6Yxlz6PFFl;
        Thu, 13 Oct 2022 17:00:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgD3jtMm1Edj83jNAA--.18495S2;
        Thu, 13 Oct 2022 17:02:34 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Free elements after one RCU-tasks-trace
 grace period
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org,
        houtao1@huawei.com, paulmck@kernel.org
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-2-houtao@huaweicloud.com>
 <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <d91a9536-8ed2-fc00-733d-733de34af510@huaweicloud.com>
 <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
 <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
 <20221012161103.GU4221@paulmck-ThinkPad-P17-Gen-1>
 <ca5f2973-e8b5-0d73-fd23-849f0dfc4347@huaweicloud.com>
 <32d6ebed-c93b-f2eb-184a-47bd85b1ba7a@linux.dev>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <47770f24-1c3a-66f6-a46e-896402648b1c@huaweicloud.com>
Date:   Thu, 13 Oct 2022 17:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <32d6ebed-c93b-f2eb-184a-47bd85b1ba7a@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgD3jtMm1Edj83jNAA--.18495S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryDWF18AFWDtr1fKw17ZFb_yoW8WrW8pF
        WY9FsxGrnYk3yF9rn2gw43XFWxt395GF4jq398C348C398JryUWrySyF4j9Fy5Ars5WFy2
        vF45tF9rAas8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/13/2022 1:07 PM, Martin KaFai Lau wrote:
> On 10/12/22 6:25 PM, Hou Tao wrote:
>>>>> Back to the polling API.  Are these things freed individually, or can
>>>>> they be grouped?  If they can be grouped, the storage for the grace-period
>>>>> state could be associated with the group.
>>>> As said above, for bpf memory allocator it may be OK because it frees elements
>>>> in batch, but for bpf local storage and its element these memories are freed
>>>> individually. So I think if the implication of RCU tasks trace grace period
>>>> will
>>>> not be changed in the foreseeable future, adding rcu_trace_implies_rcu_gp()
>>>> and
>>>> using it in bpf is a good idea. What do you think ?
>>> Maybe the BPF memory allocator does it one way and BPF local storage
>>> does it another way.
>> Why not. Maybe bpf expert think the space overhead is also reasonable in the BPF
>> local storage case.
>
> There is only 8 bytes hole left in 'struct bpf_local_storage_elem', so it is
> precious.  Put aside the space overhead, only deletion of a local storage
> requires call_rcu_tasks_trace().  The common use case for local storage is to
> alloc once and stay there for the whole life time of the sk/task/inode.  Thus,
> delete should happen very infrequent.
>
> It will still be nice to optimize though if it does not need extra space and
> that seems possible from reading the thread.
Understand. Yes, if using the newly added rcu_trace_implies_rcu_gp(), there will
be no space overhead. I will use the rcu_trace_implies_rcu_gp()-way in all these
cases and defer the use of RCU polling APIs to future work.

