Return-Path: <bpf+bounces-11867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3A7C4AF4
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1CF1C20F02
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FD61642A;
	Wed, 11 Oct 2023 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194C8C19;
	Wed, 11 Oct 2023 06:48:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B7990;
	Tue, 10 Oct 2023 23:48:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S53JL4RZJz4f3jqf;
	Wed, 11 Oct 2023 14:48:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDXMVFARSZl3_MNCg--.16799S2;
	Wed, 11 Oct 2023 14:48:36 +0800 (CST)
Subject: Re: Possible kernel memory leak in bpf_timer
From: Hou Tao <houtao@huaweicloud.com>
To: Hsin-Wei Hung <hsinweih@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com>
 <8bf09dbd-670d-a666-8dcd-fc3406fa7ada@huaweicloud.com>
 <CABcoxUZU-+aaPw1VsqbYRsbCEq8R7Mb+aCCkq6M6zVoP3Oq36g@mail.gmail.com>
 <bc65ba0c-831e-779e-cbf1-69a409fc211a@huaweicloud.com>
Message-ID: <eb171bee-1b59-822f-4816-2adb7da5161f@huaweicloud.com>
Date: Wed, 11 Oct 2023 14:48:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bc65ba0c-831e-779e-cbf1-69a409fc211a@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDXMVFARSZl3_MNCg--.16799S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XryUKr17uw17Xr4DCrW7Arb_yoW7CF4Dpr
	W8Jay2krW0qr48tw1Utw1DJry5tw1UC3WUXFyrJF1UZrn2qF1qqF17Wr1j9F45Jr48Ar47
	Ar48tryavr1UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/11/2023 2:16 PM, Hou Tao wrote:
> Hi,
>
> On 10/11/2023 12:39 PM, Hsin-Wei Hung wrote:
>> On Sat, Oct 7, 2023 at 7:46 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>
>>> On 9/27/2023 1:32 PM, Hsin-Wei Hung wrote:
>>>> Hi,
>>>>
>>>> We found a potential memory leak in bpf_timer in v5.15.26 using a
>>>> customized syzkaller for fuzzing bpf runtime. It can happen when
>>>> an arraymap is being released. An entry that has been checked by
>>>> bpf_timer_cancel_and_free() can again be initialized by bpf_timer_init().
>>>> Since both paths are almost identical between v5.15 and net-next,
>>>> I suspect this problem still exists. Below are kmemleak report and
>>>> some additional printks I inserted.
>>>>
>>>> [ 1364.081694] array_map_free_timers map:0xffffc900005a9000
>>>> [ 1364.081730] ____bpf_timer_init map:0xffffc900005a9000
>>>> timer:0xffff888001ab4080
>>>>
>>>> *no bpf_timer_cancel_and_free that will kfree struct bpf_hrtimer*
>>>> at 0xffff888001ab4080 is called
>>> I think the kmemleak happened as follows:
>>>
>>> bpf_timer_init()
>>>   lock timer->lock
>>>     read timer->timer as NULL
>>>     read map->usercnt != 0
>>>
>>>                 bpf_map_put_uref()
>>>                   // map->usercnt = 0
>>>                   atomic_dec_and_test(map->usercnt)
>>>                     array_map_free_timers()
>>>                     // just return and lead to mem leak
>>>                     find timer->timer is NULL
>>>
>>>     t = bpf_map_kmalloc_node()
>>>     timer->timer = t
>>>   unlock timer->lock
>>>
>>> Could you please try the attached patch to check whether the kmemleak
>>> problem has been fixed ?
>>>
>> Hi,
>>
>> Sorry for the late reply to this thread.
>>
>> KASAN is complaining about double-free/invalid-free in the kfree after
>> applying the patch. There are some cases that jump to "out" before the
>> bpf_hrtimer is allocated or when the bpf_hrtimer is already allocated.
> My bad. Didn't carefully test the patch before posting the patch. Could
> you please apply the modification below to the patch and try it again ?
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bcbd47436a19..c72e28d0ce86 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1175,6 +1175,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern
> *, timer, struct bpf_map *, map
>         __bpf_spin_lock_irqsave(&timer->lock);
>         t = timer->timer;
>         if (t) {
> +               t = NULL;
>                 ret = -EBUSY;
>                 goto out;
>         }

Sorry again. After pressed the send button, I realize the modification
is still not right. The following modification will work.

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bcbd47436a19..2fd916e0d964 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1156,7 +1156,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern
*, timer, struct bpf_map *, map
           u64, flags)
 {
        clockid_t clockid = flags & (MAX_CLOCKS - 1);
-       struct bpf_hrtimer *t;
+       struct bpf_hrtimer *t = NULL;
        int ret = 0;

        BUILD_BUG_ON(MAX_CLOCKS != 16);
@@ -1173,8 +1173,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern
*, timer, struct bpf_map *, map
             clockid != CLOCK_BOOTTIME))
                return -EINVAL;
        __bpf_spin_lock_irqsave(&timer->lock);
-       t = timer->timer;
-       if (t) {
+       if (timer->timer) {
                ret = -EBUSY;
                goto out;
        }



>
>
>> I am still trying to have a standalone working POC. I think a key to
>> trigger this memory leak is to 1) have a large array map 2) a bpf
>> program init a timer in a small-index entry and then 3) release the
>> map.
> Yes. And I still think my guess about how the kmemleak happens is correct.
>
>> -Amery
>>
>>
>>>> [ 1383.907869] kmemleak: 1 new suspected memory leaks (see
>>>> /sys/kernel/debug/kmemleak)
>>>> BUG: memory leak
>>>> unreferenced object 0xffff888001ab4080 (size 96):
>>>>   comm "sshd", pid 279, jiffies 4295233126 (age 29.952s)
>>>>   hex dump (first 32 bytes):
>>>>     80 40 ab 01 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
>>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>   backtrace:
>>>>     [<000000009d018da0>] bpf_map_kmalloc_node+0x89/0x1a0
>>>>     [<00000000ebcb33fc>] bpf_timer_init+0x177/0x320
>>>>     [<00000000fb7e90bf>] 0xffffffffc02a0358
>>>>     [<000000000c89ec4f>] __cgroup_bpf_run_filter_skb+0xcbf/0x1110
>>>>     [<00000000fd663fc0>] ip_finish_output+0x13d/0x1f0
>>>>     [<00000000acb3205c>] ip_output+0x19b/0x310
>>>>     [<000000006b584375>] __ip_queue_xmit+0x182e/0x1ed0
>>>>     [<00000000b921b07e>] __tcp_transmit_skb+0x2b65/0x37f0
>>>>     [<0000000026104b23>] tcp_write_xmit+0xf19/0x6290
>>>>     [<000000006dc71bc5>] __tcp_push_pending_frames+0xaf/0x390
>>>>     [<00000000251b364a>] tcp_push+0x452/0x6d0
>>>>     [<000000008522b7d3>] tcp_sendmsg_locked+0x2567/0x3030
>>>>     [<0000000038c644d2>] tcp_sendmsg+0x30/0x50
>>>>     [<000000009fe3413f>] inet_sendmsg+0xba/0x140
>>>>     [<0000000034d78039>] sock_sendmsg+0x13d/0x190
>>>>     [<00000000f55b8db6>] sock_write_iter+0x296/0x3d0
>>>>
>>>>
>>>> Thanks,
>>>> Hsin-Wei (Amery)
>>>>
>>>>
>>>> .
>> .
>
>
> .


