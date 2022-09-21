Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D45BF406
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 04:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIUCzk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 22:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUCzj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 22:55:39 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB732792E9
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 19:55:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MXNJy1KThz6TCP5
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 10:53:38 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgB3FG4kfSpjibqfBA--.22693S2;
        Wed, 21 Sep 2022 10:55:36 +0800 (CST)
Subject: Re: [PATCH bpf-next] bpf: Check whether or not node is NULL before
 free it in free_bulk
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
        Lorenz Bauer <oss@lmb.io>, Hou Tao <houtao1@huawei.com>
References: <20220919144811.3570825-1-houtao@huaweicloud.com>
 <CAADnVQJTQG3=2vMyJ6roXqOoD5dZPs7ddTwxXEcMsym1K-FeUQ@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <578432bd-2c3d-f15c-d82d-e2d3795094aa@huaweicloud.com>
Date:   Wed, 21 Sep 2022 10:55:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQJTQG3=2vMyJ6roXqOoD5dZPs7ddTwxXEcMsym1K-FeUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgB3FG4kfSpjibqfBA--.22693S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UXw13CryfCFW5Cw45ZFb_yoW8ZrWxpr
        WFyF18KF4kArn2v3Z2v3W7GF17ua17KF17WF9avrWfu3WFvrnF9r9rta4Uuayfur4kJ34j
        ya12ya1fK3s8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/20/2022 11:09 PM, Alexei Starovoitov wrote:
> On Mon, Sep 19, 2022 at 7:30 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> llnode could be NULL if there are new allocations after the checking of
>> c-free_cnt > c->high_watermark in bpf_mem_refill() and before the
>> calling of __llist_del_first() in free_bulk (e.g. a PREEMPT_RT kernel
>> or allocation in NMI context). And it will incur oops as shown below:
>>
>>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>>  #PF: supervisor write access in kernel mode
>>  #PF: error_code(0x0002) - not-present page
>>  PGD 0 P4D 0
>>  Oops: 0002 [#1] PREEMPT_RT SMP
>>  CPU: 39 PID: 373 Comm: irq_work/39 Tainted: G        W          6.0.0-rc6-rt9+ #1
>>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>>  RIP: 0010:bpf_mem_refill+0x66/0x130
>>  ......
>>  Call Trace:
>>   <TASK>
>>   irq_work_single+0x24/0x60
>>   irq_work_run_list+0x24/0x30
>>   run_irq_workd+0x18/0x20
>>   smpboot_thread_fn+0x13f/0x2c0
>>   kthread+0x121/0x140
>>   ? kthread_complete_and_exit+0x20/0x20
>>   ret_from_fork+0x1f/0x30
>>   </TASK>
>>
>> Simply fixing it by checking whether or not llnode is NULL in free_bulk().
>>
>> Fixes: 1376b7c57624 ("bpf: Introduce any context BPF specific memory allocator.")
> There is no such sha.
> Also that commit isn't buggy as-is.
> The proper fixes tag:
> Fixes: 8d5a8011b35d ("bpf: Batch call_rcu callbacks instead of
> SLAB_TYPESAFE_BY_RCU.")
The incorrect git sha-sum is due to rebase on my local branch.
You are right. In 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory
allocator."), free_bulk() calls kfree() and kmem_cache_free() directly, so there
is no such problem.  And in commit 8d5a8011b35d ("bpf: Batch call_rcu callbacks
instead of SLAB_TYPESAFE_BY_RCU."), free_one is replaced by enque_to_free() and
incurs the problem.
>
> Used that while applying.
Thanks for the update.
> Thanks for the fix !
> .

