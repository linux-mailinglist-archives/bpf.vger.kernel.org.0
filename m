Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3559BF3D
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 14:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiHVMHz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 08:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiHVMHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 08:07:54 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EA3A481
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 05:07:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MBB0g5gFnzmVN8
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 20:06:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgAXozuPcQNjR3iAAg--.48086S2;
        Mon, 22 Aug 2022 20:07:47 +0800 (CST)
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu
 map_locked
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com>
 <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
 <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com>
 <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <387c851f-03ae-9b34-4ec0-9667fb26ec18@huaweicloud.com>
Date:   Mon, 22 Aug 2022 20:07:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgAXozuPcQNjR3iAAg--.48086S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWxCF43tFWktFWDKr45Jrb_yoW3Ww4rpr
        W8GFyjyrWUXr10gr42qr1Ivry5tw1UK347Xr1DGa4UAryDtwnFqr18XF1j9F10vr4xJr1I
        qr4UtrW3ZryUAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/22/2022 11:21 AM, Hao Luo wrote:
> Hi, Hou Tao
>
> On Sun, Aug 21, 2022 at 6:28 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 8/22/2022 12:42 AM, Hao Luo wrote:
>>> Hi Hou Tao,
>>>
>>> On Sat, Aug 20, 2022 at 8:14 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
>>>> from both NMI and non-NMI contexts. But since 74d862b682f51 ("sched:
>>>> Make migrate_disable/enable() independent of RT"), migrations_disable()
>>>> is also preemptible under !PREEMPT_RT case, so now map_locked also
>>>> disallows concurrent updates from normal contexts (e.g. userspace
>>>> processes) unexpectedly as shown below:
>>>>
>>>> process A                      process B
>>>>
>>>> htab_map_update_elem()
>>>>   htab_lock_bucket()
>>>>     migrate_disable()
>>>>     /* return 1 */
>>>>     __this_cpu_inc_return()
>>>>     /* preempted by B */
>>>>
>>>>                                htab_map_update_elem()
>>>>                                  /* the same bucket as A */
>>>>                                  htab_lock_bucket()
>>>>                                    migrate_disable()
>>>>                                    /* return 2, so lock fails */
>>>>                                    __this_cpu_inc_return()
>>>>                                    return -EBUSY
>>>>
>>>> A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
>>>> only checking the value of map_locked for nmi context. But it will
>>>> re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
>>>> through non-tracing program (e.g. fentry program).
>>>>
>>>> So fixing it by using disable_preempt() instead of migrate_disable() when
>>>> increasing htab->map_locked. However when htab_use_raw_lock() is false,
>>>> bucket lock will be a sleepable spin-lock and it breaks disable_preempt(),
>>>> so still use migrate_disable() for spin-lock case.
>>>>
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
>>> IIUC, this patch enlarges the scope of preemption disable to cover inc
>>> map_locked. But I don't think the change is meaningful.
>> Before 74d862b682f51 ("sched: Make migrate_disable/enable() independent of
>> RT"),  the preemption is disabled before increasing map_locked for !PREEMPT_RT
>> case, so I don't think that the change is meaningless.
>>> This patch only affects the case when raw lock is used. In the case of
>>> raw lock, irq is disabled for b->raw_lock protected critical section.
>>> A raw spin lock itself doesn't block in both RT and non-RT. So, my
>>> understanding about this patch is, it just makes sure preemption
>>> doesn't happen on the exact __this_cpu_inc_return. But the window is
>>> so small that it should be really unlikely to happen.
>> No, it can be easily reproduced by running multiple htab update processes in the
>> same CPU. Will add selftest to demonstrate that.
> Can you clarify what you demonstrate?
First please enable CONFIG_PREEMPT for the running kernel and then run the
following test program as shown below.

# sudo taskset -c 2 ./update.bin
thread nr 2
wait for error
update error -16
all threads exit

If there is no "update error -16", you can try to create more map update
threads. For example running 16 update threads:

# sudo taskset -c 2 ./update.bin 16
thread nr 16
wait for error
update error -16
update error -16
update error -16
update error -16
update error -16
update error -16
update error -16
update error -16
all threads exit

The following is the source code for update.bin:

#define _GNU_SOURCE
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>

#include "bpf.h"
#include "libbpf.h"

static bool stop;
static int fd;

static void *update_fn(void *arg)
{
        while (!stop) {
                unsigned int key = 0, value = 1;
                int err;

                err = bpf_map_update_elem(fd, &key, &value, 0);
                if (err) {
                        printf("update error %d\n", err);
                        stop = true;
                        break;
                }
        }

        return NULL;
}

int main(int argc, char **argv)
{
        LIBBPF_OPTS(bpf_map_create_opts, opts);
        unsigned int i, nr;
        pthread_t *tids;

        nr = 2;
        if (argc > 1)
                nr = atoi(argv[1]);
        printf("thread nr %u\n", nr);

        libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
        fd = bpf_map_create(BPF_MAP_TYPE_HASH, "batch", 4, 4, 1, &opts);
        if (fd < 0) {
                printf("create map error %d\n", fd);
                return 1;
        }

        tids = malloc(nr * sizeof(*tids));
        for (i = 0; i < nr; i++)
                pthread_create(&tids[i], NULL, update_fn, NULL);

        printf("wait for error\n");
        for (i = 0; i < nr; i++)
                pthread_join(tids[i], NULL);

        printf("all threads exit\n");

        free(tids);
        close(fd);

        return 0;
}

>
> Here is my theory, but please correct me if I'm wrong, I haven't
> tested yet. In non-RT, I doubt preemptions are likely to happen after
> migrate_disable. That is because very soon after migrate_disable, we
> enter the critical section of b->raw_lock with irq disabled. In RT,
> preemptions can happen on acquiring b->lock, that is certainly
> possible, but this is the !use_raw_lock path, which isn't side-stepped
> by this patch.
>
>>>>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
>>>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>> index 6c530a5e560a..ad09da139589 100644
>>>> --- a/kernel/bpf/hashtab.c
>>>> +++ b/kernel/bpf/hashtab.c
>>>> @@ -162,17 +162,25 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>>>>                                    unsigned long *pflags)
>>>>  {
>>>>         unsigned long flags;
>>>> +       bool use_raw_lock;
>>>>
>>>>         hash = hash & HASHTAB_MAP_LOCK_MASK;
>>>>
>>>> -       migrate_disable();
>>>> +       use_raw_lock = htab_use_raw_lock(htab);
>>>> +       if (use_raw_lock)
>>>> +               preempt_disable();
>>>> +       else
>>>> +               migrate_disable();
>>>>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
>>>>                 __this_cpu_dec(*(htab->map_locked[hash]));
>>>> -               migrate_enable();
>>>> +               if (use_raw_lock)
>>>> +                       preempt_enable();
>>>> +               else
>>>> +                       migrate_enable();
>>>>                 return -EBUSY;
>>>>         }
>>>>
>>>> -       if (htab_use_raw_lock(htab))
>>>> +       if (use_raw_lock)
>>>>                 raw_spin_lock_irqsave(&b->raw_lock, flags);
>>>>         else
>>>>                 spin_lock_irqsave(&b->lock, flags);
>>>> @@ -185,13 +193,18 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>>>>                                       struct bucket *b, u32 hash,
>>>>                                       unsigned long flags)
>>>>  {
>>>> +       bool use_raw_lock = htab_use_raw_lock(htab);
>>>> +
>>>>         hash = hash & HASHTAB_MAP_LOCK_MASK;
>>>> -       if (htab_use_raw_lock(htab))
>>>> +       if (use_raw_lock)
>>>>                 raw_spin_unlock_irqrestore(&b->raw_lock, flags);
>>>>         else
>>>>                 spin_unlock_irqrestore(&b->lock, flags);
>>>>         __this_cpu_dec(*(htab->map_locked[hash]));
>>>> -       migrate_enable();
>>>> +       if (use_raw_lock)
>>>> +               preempt_enable();
>>>> +       else
>>>> +               migrate_enable();
>>>>  }
>>>>
>>>>  static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
>>>> --
>>>> 2.29.2
>>>>
>>> .
> .

