Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D86F104A
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 04:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjD1CYY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 22:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjD1CYX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 22:24:23 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2239A2137;
        Thu, 27 Apr 2023 19:24:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q6xJ11ZR7z4f3nRJ;
        Fri, 28 Apr 2023 10:24:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDXKxZQLktkOO01Hw--.49818S2;
        Fri, 28 Apr 2023 10:24:18 +0800 (CST)
Subject: Re: [RFC bpf-next v2 4/4] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
 <20230408141846.1878768-5-houtao@huaweicloud.com>
 <20230422031213.ubhzng67qf7axt7x@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <d8608bed-57de-ae92-f8c2-45df998123e5@huaweicloud.com>
 <20230427042401.iavewtqx2x3yjepq@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <03285a01-3a57-bb8b-e454-5fbfc2037791@huaweicloud.com>
Date:   Fri, 28 Apr 2023 10:24:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230427042401.iavewtqx2x3yjepq@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDXKxZQLktkOO01Hw--.49818S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF48Xr4DJr45ur47CF1fXrb_yoW5Wr4rpa
        yfKa4xAr4vyrsrZrn2qw1xJFyUZws5Kw45Jry0g3s8u3s5XrsFkryIkFWYvr98ZFy8Cw1j
        vr4DA347Z3Z8A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On 4/27/2023 12:24 PM, Alexei Starovoitov wrote:
> On Sun, Apr 23, 2023 at 03:41:05PM +0800, Hou Tao wrote:
>>>> (3) reuse-after-rcu-gp bpf memory allocator
>>> that's the one you're implementing below, right?
>> Right.
>>>> | name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
>>>> | --                  | --         | --                   | --                |
>>>> | no_op               | 1276       | 0.96                 | 1.00              |
>>>> | overwrite           | 15.66      | 25.00                | 33.07             |
>>>> | batch_add_batch_del | 10.32      | 18.84                | 22.64             |
>>>> | add_del_on_diff_cpu | 13.00      | 550.50               | 748.74            |
>>>>
>>>> (4) free-after-rcu-gp bpf memory allocator (free directly through call_rcu)
>>> What do you mean? htab uses bpf_ma, but does call_rcu before doing bpf_mem_free ?
>> No, there is no call_rcu() before bpf_mem_free(). bpf_mem_free() in
>> free-after-rcu-gp flavor will do call_rcu() in batch to free these elements back
>> to slab subsystem directly. The elements in this flavor of bpf_ma is not safe
>> for access from sleepable program except bpf_rcu_read_{lock,unlock}() are used.
>>
>> But I think using call_rcu() to call bpf_mem_free() is good candidate for
>> comparison and I saw bpf_cpumask does that, so I modify bpf hash table to do the
>> similar thing and paste the benchmark result. As we can seen from the result,
>> the memory usage for such flavor is much bigger than reuse-after-rcu-gp and
>> free-after-rcu-gp:
> I don't follow what exactly you're doing and what you're measuring.
> Please provide patches for both reuse-after-rcu-gp and free-after-rcu-gp to
> have meaningful conversation.
OK. Will add a new flavor of FREE_AFTER_RCU_GP bpf memory allocator in v3.
> Rigth now we're stuck at what bench tool is actually measuring.
>
>>>> +		if (try_queue_work && !work_pending(&c->reuse_work)) {
>>>> +			/* Use reuse_cb_in_progress to indicate there is
>>>> +			 * inflight reuse kworker or reuse RCU callback.
>>>> +			 */
>>>> +			atomic_inc(&c->reuse_cb_in_progress);
>>>> +			/* Already queued */
>>>> +			if (!queue_work(bpf_ma_wq, &c->reuse_work))
>>> how many kthreads are spawned by wq in the peak?
>> I think it depends on the number of bpf_ma. Because bpf_ma_wq is per-CPU
>> workqueue, so for each bpf_ma, there is at most one worker for each CPU. And now
>> the limit for the number of active workers on each CPU is 256, but it is
>> customizable through alloc_workqueue() API.
> Which means that on 8 cpu system there will be 8 * 256 kthreads ?
> That's a lot. Please provide num_of_all_threads before/after/at_peak during bench.
Yes, 8 * 256 is a lot, but there are at most 8 kworkers during
benchmark, because there is only one bpf_memory_allocator is used.
>
> Pls trim your replies. Mailers like mutt have a hard time navigating.
Do you mean the email content didn't wrap automatically ? or the wrap
length is too lengthy (my current setting is 80) ?

