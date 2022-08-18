Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93AF597BA7
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 04:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiHRCqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 22:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbiHRCqh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 22:46:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56180A284A;
        Wed, 17 Aug 2022 19:46:35 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M7Thb34zNzZflN;
        Thu, 18 Aug 2022 10:43:11 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 10:46:33 +0800
Received: from [10.67.109.184] (10.67.109.184) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 10:46:33 +0800
Subject: Re: [PATCH bpf] bpf: Fix kernel BUG in purge_effective_progs
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <stable@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        "Tadeusz Struk" <tadeusz.struk@linaro.org>,
        Song Liu <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Hao Luo" <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220813134030.1972696-1-pulehui@huawei.com>
 <CAEf4BzaciJNVP1YsuJTiS9v7wBvTpShj+kMtwkzk8ijnpL_yzw@mail.gmail.com>
From:   Pu Lehui <pulehui@huawei.com>
Message-ID: <7cbb4aa6-c576-8671-ea5e-d845a8310394@huawei.com>
Date:   Thu, 18 Aug 2022 10:46:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaciJNVP1YsuJTiS9v7wBvTpShj+kMtwkzk8ijnpL_yzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/8/17 4:39, Andrii Nakryiko wrote:
> On Sat, Aug 13, 2022 at 6:11 AM Pu Lehui <pulehui@huawei.com> wrote:
>>
>> Syzkaller reported kernel BUG as follows:
>>
>> ------------[ cut here ]------------
>> kernel BUG at kernel/bpf/cgroup.c:925!
>> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 1 PID: 194 Comm: detach Not tainted 5.19.0-14184-g69dac8e431af #8
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:__cgroup_bpf_detach+0x1f2/0x2a0
>> Code: 00 e8 92 60 30 00 84 c0 75 d8 4c 89 e0 31 f6 85 f6 74 19 42 f6 84
>> 28 48 05 00 00 02 75 0e 48 8b 80 c0 00 00 00 48 85 c0 75 e5 <0f> 0b 48
>> 8b 0c5
>> RSP: 0018:ffffc9000055bdb0 EFLAGS: 00000246
>> RAX: 0000000000000000 RBX: ffff888100ec0800 RCX: ffffc900000f1000
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888100ec4578
>> RBP: 0000000000000000 R08: ffff888100ec0800 R09: 0000000000000040
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888100ec4000
>> R13: 000000000000000d R14: ffffc90000199000 R15: ffff888100effb00
>> FS:  00007f68213d2b80(0000) GS:ffff88813bc80000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055f74a0e5850 CR3: 0000000102836000 CR4: 00000000000006e0
>> Call Trace:
>>   <TASK>
>>   cgroup_bpf_prog_detach+0xcc/0x100
>>   __sys_bpf+0x2273/0x2a00
>>   __x64_sys_bpf+0x17/0x20
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7f68214dbcb9
>> Code: 08 44 89 e0 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 48 89 f8 48 89
>> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
>> f0 ff8
>> RSP: 002b:00007ffeb487db68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>> RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f68214dbcb9
>> RDX: 0000000000000090 RSI: 00007ffeb487db70 RDI: 0000000000000009
>> RBP: 0000000000000003 R08: 0000000000000012 R09: 0000000b00000003
>> R10: 00007ffeb487db70 R11: 0000000000000246 R12: 00007ffeb487dc20
>> R13: 0000000000000004 R14: 0000000000000001 R15: 000055f74a1011b0
>>   </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>>
>> Repetition steps:
>> For the following cgroup tree,
>>
>> root
>>   |
>> cg1
>>   |
>> cg2
>>
>> 1. attach prog2 to cg2, and then attach prog1 to cg1, both bpf progs
>> attach type is NONE or OVERRIDE.
>> 2. write 1 to /proc/thread-self/fail-nth for failslab.
>> 3. detach prog1 for cg1, and then kernel BUG occur.
>>
>> Failslab injection will cause kmalloc fail and fall back to
>> purge_effective_progs. The problem is that cg2 have attached another prog,
>> so when go through cg2 layer, iteration will add pos to 1, and subsequent
>> operations will be skipped by the following condition, and cg will meet
>> NULL in the end.
>>
>> `if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))`
>>
>> The NULL cg means no link or prog match, this is as expected, and it's not
>> a bug. So here just skip the no match situation.
>>
>> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   kernel/bpf/cgroup.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 59b7eb60d5b4..4a400cd63731 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -921,8 +921,10 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
>>                                  pos++;
>>                          }
>>                  }
>> +
>> +               /* no link or prog match, skip the cgroup of this layer */
>> +               continue;
>>   found:
>> -               BUG_ON(!cg);
> 
> I don't think it's necessary to remove this BUG_ON(), but it also
> feels unnecessary for purge_effective_progs, so I don't mind it.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 

Hi,

Will this patch be accepted? I think we should CC stable.

Thanks,
Lehui

>>                  progs = rcu_dereference_protected(
>>                                  desc->bpf.effective[atype],
>>                                  lockdep_is_held(&cgroup_mutex));
>> --
>> 2.25.1
>>
> .
> 
