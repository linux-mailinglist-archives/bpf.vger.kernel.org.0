Return-Path: <bpf+bounces-15038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD87EA948
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 05:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4BF1C20957
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337B8F76;
	Tue, 14 Nov 2023 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED82D8F55
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 04:03:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD753D42
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:03:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4STt275ZBpz4f3m6v
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 12:03:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BED141A0175
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 12:03:31 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3Bg2Q8VJl5dZ8Aw--.8182S2;
	Tue, 14 Nov 2023 12:03:31 +0800 (CST)
Subject: Re: [PATCH bpf-next v3] bpf: Do not allocate percpu memory at init
 stage
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231111013928.948838-1-yonghong.song@linux.dev>
 <50a70429-169f-0d44-86da-d5fe6a9d59e6@huaweicloud.com>
 <05207c41-2e2f-49d6-a8bf-a2820701242f@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <4461f435-1746-80fc-df1f-a78d34391861@huaweicloud.com>
Date: Tue, 14 Nov 2023 12:03:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <05207c41-2e2f-49d6-a8bf-a2820701242f@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3Bg2Q8VJl5dZ8Aw--.8182S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4rXrW8WF1rXF4kuw1rZwb_yoWxtF1kpF
	1kJFyUCrWUKrn7Ww17Jw4UAry0qr18Ww18Jw1UAFyUAr42qr1qgr48XrnY9Fn8Jr48Gr18
	tr1UXr17ZF45ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 11/14/2023 11:23 AM, Yonghong Song wrote:
>
> On 11/13/23 4:42 AM, Hou Tao wrote:
>> Hi,
>>
>> On 11/11/2023 9:39 AM, Yonghong Song wrote:
>>> Kirill Shutemov reported significant percpu memory consumption
>>> increase after
>>> booting in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add
>>> support for
>>> non-fix-size percpu mem allocation"). The percpu memory consumption is
>>> increased from 111MB to 969MB. The number is from /proc/meminfo.
>>>
>>> I tried to reproduce the issue with my local VM which at most
>>> supports upto
>>> 255 cpus. With 252 cpus, without the above commit, the percpu memory
>>> consumption immediately after boot is 57MB while with the above
>>> commit the
>>> percpu memory consumption is 231MB.
>>>
>>> This is not good since so far percpu memory from bpf memory
>>> allocator is not
>>> widely used yet. Let us change pre-allocation in init stage to
>>> on-demand
>>> allocation when verifier detects there is a need of percpu memory
>>> for bpf
>>> program. With this change, percpu memory consumption after boot can
>>> be reduced
>>> signicantly.
>>>
>>>    [1]
>>> https://lore.kernel.org/lkml/20231109154934.4saimljtqx625l3v@box.shutemov.name/
>>>
>>> Fixes: 41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem
>>> allocation")
>>> Reported-and-tested-by: Kirill A. Shutemov
>>> <kirill.shutemov@linux.intel.com>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   include/linux/bpf.h   |  2 +-
>>>   kernel/bpf/core.c     |  8 +++-----
>>>   kernel/bpf/verifier.c | 20 ++++++++++++++++++--
>>>   3 files changed, 22 insertions(+), 8 deletions(-)
>>>
>>> Changelog:
>>>    v2 -> v3:
>>>      - Use dedicated mutex lock (bpf_percpu_ma_lock)
>>>    v1 -> v2:
>>>      - Add proper Reported-and-tested-by tag.
>>>      - Do a check of !bpf_global_percpu_ma_set before acquiring
>>> verifier_lock.
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 35bff17396c0..6762dac3ef76 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -56,7 +56,7 @@ extern struct idr btf_idr;
>>>   extern spinlock_t btf_idr_lock;
>>>   extern struct kobject *btf_kobj;
>>>   extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
>>> -extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>>> +extern bool bpf_global_ma_set;
>>>     typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
>>>   typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 08626b519ce2..cd3afe57ece3 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -64,8 +64,8 @@
>>>   #define OFF    insn->off
>>>   #define IMM    insn->imm
>>>   -struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
>>> -bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>>> +struct bpf_mem_alloc bpf_global_ma;
>>> +bool bpf_global_ma_set;
>>>     /* No hurry in this branch
>>>    *
>>> @@ -2934,9 +2934,7 @@ static int __init bpf_global_ma_init(void)
>>>         ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>>>       bpf_global_ma_set = !ret;
>>> -    ret = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
>>> -    bpf_global_percpu_ma_set = !ret;
>>> -    return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
>>> +    return ret;
>>>   }
>>>   late_initcall(bpf_global_ma_init);
>>>   #endif
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index a2267d5ed14e..6da370a047fe 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -26,6 +26,7 @@
>>>   #include <linux/poison.h>
>>>   #include <linux/module.h>
>>>   #include <linux/cpumask.h>
>>> +#include <linux/bpf_mem_alloc.h>
>>>   #include <net/xdp.h>
>>>     #include "disasm.h"
>>> @@ -41,6 +42,9 @@ static const struct bpf_verifier_ops * const
>>> bpf_verifier_ops[] = {
>>>   #undef BPF_LINK_TYPE
>>>   };
>>>   +struct bpf_mem_alloc bpf_global_percpu_ma;
>>> +static bool bpf_global_percpu_ma_set;
>>> +
>>>   /* bpf_check() is a static code analyzer that walks eBPF program
>>>    * instruction by instruction and updates register/stack state.
>>>    * All paths of conditional branches are analyzed until 'bpf_exit'
>>> insn.
>>> @@ -336,6 +340,7 @@ struct bpf_kfunc_call_arg_meta {
>>>   struct btf *btf_vmlinux;
>>>     static DEFINE_MUTEX(bpf_verifier_lock);
>>> +static DEFINE_MUTEX(bpf_percpu_ma_lock);
>>>     static const struct bpf_line_info *
>>>   find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
>>> @@ -12091,8 +12096,19 @@ static int check_kfunc_call(struct
>>> bpf_verifier_env *env, struct bpf_insn *insn,
>>>                   if (meta.func_id ==
>>> special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>>>                       return -ENOMEM;
>>>   -                if (meta.func_id ==
>>> special_kfunc_list[KF_bpf_percpu_obj_new_impl] &&
>>> !bpf_global_percpu_ma_set)
>>> -                    return -ENOMEM;
>>> +                if (meta.func_id ==
>>> special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>>> +                    if (!bpf_global_percpu_ma_set) {
>>> +                        mutex_lock(&bpf_percpu_ma_lock);
>>> +                        if (!bpf_global_percpu_ma_set) {
>>> +                            err =
>>> bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
>>> +                            if (!err)
>>> +                                bpf_global_percpu_ma_set = true;
>>> +                        }
>> A dumb question here: do we need some memory barrier to guarantee the
>> memory order between bpf_global_percpu_ma_set and bpf_global_percpu_ma ?
>
> We should be fine. There is a control dependence on '!err' for
> 'bpf_global_percpu_ma_set = true'.

I see. Thanks for the explanation.
>
>>> +                        mutex_unlock(&bpf_percpu_ma_lock);
>>> +                        if (err)
>>> +                            return err;
>>> +                    }
>>> +                }
>>>                     if (((u64)(u32)meta.arg_constant.value) !=
>>> meta.arg_constant.value) {
>>>                       verbose(env, "local type ID argument must be
>>> in range [0, U32_MAX]\n");
>
> .


