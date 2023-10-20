Return-Path: <bpf+bounces-12806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C767D098D
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 09:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8532B21472
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 07:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F07ED50B;
	Fri, 20 Oct 2023 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A9DDA2
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:31:28 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C6A91
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 00:31:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBbqW4Lynz4f3xsV
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 15:31:19 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXWqvDLDJlFDwYDQ--.49241S2;
	Fri, 20 Oct 2023 15:31:19 +0800 (CST)
Subject: Re: [PATCH bpf v2 1/2] bpf: Check map->usercnt again after
 timer->timer is assigned
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hsin-Wei Hung <hsinweih@uci.edu>,
 Hou Tao <houtao1@huawei.com>
References: <20231020014214.2471419-1-houtao@huaweicloud.com>
 <20231020014214.2471419-2-houtao@huaweicloud.com>
 <CAADnVQK9BzHfAwnws+XhwL_zz9wvSAUaK0HSFWHGUQeD4LWO8w@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <42756ba7-191e-37a5-ee78-849e2f1d3d50@huaweicloud.com>
Date: Fri, 20 Oct 2023 15:31:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQK9BzHfAwnws+XhwL_zz9wvSAUaK0HSFWHGUQeD4LWO8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXWqvDLDJlFDwYDQ--.49241S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48tr4DWw1UJr18tFyDtrb_yoWrXrW7pr
	s3tay2kr18Xws8Awn7JF1kW34Fv395JwnxGrn5ua4rurs7WFsakFyUtF15WFW3Ar4xJF43
	Zr409rs09r1UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi,

On 10/20/2023 10:14 AM, Alexei Starovoitov wrote:
> On Thu, Oct 19, 2023 at 6:41 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When there are concurrent uref release and bpf timer init operations,
>> the following sequence diagram is possible and it will lead to memory
>> leak:
>>
>> bpf program X
>>
>> bpf_timer_init()
>>   lock timer->lock
>>     read timer->timer as NULL
>>     read map->usercnt != 0
>>
>>                 process Y
>>
>>                 close(map_fd)
>>                   // put last uref
>>                   bpf_map_put_uref()
>>                     atomic_dec_and_test(map->usercnt)
>>                       array_map_free_timers()
>>                         bpf_timer_cancel_and_free()
>>                           // just return and lead to memory leak
>>                           read timer->timer is NULL
>>
>>     t = bpf_map_kmalloc_node()
>>     timer->timer = t
>>   unlock timer->lock
>>
>> Fix the problem by checking map->usercnt again after timer->timer is
>> assigned, so when there are concurrent uref release and bpf timer init,
>> either bpf_timer_cancel_and_free() from uref release reads a no-NULL
>> timer and the newly-added check of map->usercnt reads a zero usercnt.
>>
>> Because atomic_dec_and_test(map->usercnt) and READ_ONCE(timer->timer)
>> in bpf_timer_cancel_and_free() are not protected by a lock, so add
>> a memory barrier to guarantee the order between map->usercnt and
>> timer->timer. Also use WRITE_ONCE(timer->timer, x) to match the lockless
>> read of timer->timer.
>>
>> Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
>> Closes: https://lore.kernel.org/bpf/CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com
>> Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/helpers.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 757b99c1e613f..a7d92c3ddc3dd 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1156,7 +1156,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
>>            u64, flags)
>>  {
>>         clockid_t clockid = flags & (MAX_CLOCKS - 1);
>> -       struct bpf_hrtimer *t;
>> +       struct bpf_hrtimer *t, *to_free = NULL;
>>         int ret = 0;
>>
>>         BUILD_BUG_ON(MAX_CLOCKS != 16);
>> @@ -1197,9 +1197,21 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
>>         rcu_assign_pointer(t->callback_fn, NULL);
>>         hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
>>         t->timer.function = bpf_timer_cb;
>> -       timer->timer = t;
>> +       WRITE_ONCE(timer->timer, t);
>> +       /* Guarantee order between timer->timer and map->usercnt. So when
>> +        * there are concurrent uref release and bpf timer init, either
>> +        * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
>> +        * timer or atomic64_read() below reads a zero usercnt.
>> +        */
>> +       smp_mb();
>> +       if (!atomic64_read(&map->usercnt)) {
>> +               WRITE_ONCE(timer->timer, NULL);
>> +               to_free = t;
> just kfree(t); here.

Will do. It is a slow path, so I think doing kfree() under spin-lock is
acceptable.
>
>> +               ret = -EPERM;
>> +       }
> This will add a second atomic64_read(&map->usercnt) in the same function.
> Let's remove the first one ?

I prefer to still keep it. Because it can detect the release of map uref
early and the handle of uref release is simple compared with the second
atomic64_read(). Do you have a strong preference ?
>
>>  out:
>>         __bpf_spin_unlock_irqrestore(&timer->lock);
>> +       kfree(to_free);
>>         return ret;
>>  }
>>
>> @@ -1372,7 +1384,7 @@ void bpf_timer_cancel_and_free(void *val)
>>         /* The subsequent bpf_timer_start/cancel() helpers won't be able to use
>>          * this timer, since it won't be initialized.
>>          */
>> -       timer->timer = NULL;
>> +       WRITE_ONCE(timer->timer, NULL);
>>  out:
>>         __bpf_spin_unlock_irqrestore(&timer->lock);
>>         if (!t)
>> --
>> 2.29.2
>>
> .


