Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B976266A3
	for <lists+bpf@lfdr.de>; Sat, 12 Nov 2022 04:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiKLDef (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 22:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLDee (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 22:34:34 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62EEFD0E
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 19:34:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N8Lm13Z4Nz4f3lXT
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 11:34:25 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgCntqI_FG9jhPpmAQ--.43828S2;
        Sat, 12 Nov 2022 11:34:28 +0800 (CST)
Subject: Re: [PATCH bpf 2/4] libbpf: Handle size overflow for ringbuf mmap
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, sdf@google.com
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221111092642.2333724-1-houtao@huaweicloud.com>
 <20221111092642.2333724-3-houtao@huaweicloud.com>
 <Y26MTygDw2PUQlFz@google.com>
 <CAEf4Bza4yPEW2wOFAFMC8nwEEqVtD-jBD2T52CQ7vJpCUWCvmA@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <251d0ed2-7767-ecfa-1ac9-d6e940ad6c54@huaweicloud.com>
Date:   Sat, 12 Nov 2022 11:34:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bza4yPEW2wOFAFMC8nwEEqVtD-jBD2T52CQ7vJpCUWCvmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgCntqI_FG9jhPpmAQ--.43828S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4UKF1rKw1kKw18Jr4xJFb_yoW5tr48pa
        1Y9FWUGFsrZr1jyw17ZwnY9r90yFZagF43Gr9rGa4rAr1qgFsxWF1Duay3urs7Zr1kGr4F
        9ryq9ayF9a45trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 11/12/2022 4:56 AM, Andrii Nakryiko wrote:
> On Fri, Nov 11, 2022 at 9:54 AM <sdf@google.com> wrote:
>> On 11/11, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>> The maximum size of ringbuf is 2GB on x86-64 host, so 2 * max_entries
>>> will overflow u32 when mapping producer page and data pages. Only
>>> casting max_entries to size_t is not enough, because for 32-bits
>>> application on 64-bits kernel the size of read-only mmap region
>>> also could overflow size_t.
>>> Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>   tools/lib/bpf/ringbuf.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
>>> index d285171d4b69..c4bdc88af672 100644
>>> --- a/tools/lib/bpf/ringbuf.c
>>> +++ b/tools/lib/bpf/ringbuf.c
>>> @@ -77,6 +77,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>>>       __u32 len = sizeof(info);
>>>       struct epoll_event *e;
>>>       struct ring *r;
>>> +     __u64 ro_size;
> I found ro_size quite a confusing name, let's call it mmap_sz?
OK.
>
>>>       void *tmp;
>>>       int err;
>>> @@ -129,8 +130,14 @@ int ring_buffer__add(struct ring_buffer *rb, int
>>> map_fd,
>>>        * data size to allow simple reading of samples that wrap around the
>>>        * end of a ring buffer. See kernel implementation for details.
>>>        * */
>>> -     tmp = mmap(NULL, rb->page_size + 2 * info.max_entries, PROT_READ,
>>> -                MAP_SHARED, map_fd, rb->page_size);
>>> +     ro_size = rb->page_size + 2 * (__u64)info.max_entries;
>> [..]
>>
>>> +     if (ro_size != (__u64)(size_t)ro_size) {
>>> +             pr_warn("ringbuf: ring buffer size (%u) is too big\n",
>>> +                     info.max_entries);
>>> +             return libbpf_err(-E2BIG);
>>> +     }
>> Why do we need this check at all? IIUC, the problem is that the expression
>> "rb->page_size + 2 * info.max_entries" is evaluated as u32 and can
>> overflow. So why doing this part only isn't enough?
>>
>> size_t mmap_size = rb->page_size + 2 * (size_t)info.max_entries;
>> mmap(NULL, mmap_size, PROT_READ, MAP_SHARED, map_fd, ...);
>>
>> sizeof(size_t) should be 8, so no overflow is possible?
> not on 32-bit arches, presumably?
Yes. For 32-bits kernel, the total size of virtual address space for user space
and kernel space is 4GB, so when map_entries is 2GB, the needed virtual address
space will be 2GB + 4GB, so the mapping of ring buffer will fail either in
kernel or in userspace. A extreme case is 32-bits userspace under 64-bits
kernel. The mapping of 2GB ring buffer in kernel is OK, but 4GB will overflow
size_t on 32-bits userspace.
>


>
>
>>
>>> +     tmp = mmap(NULL, (size_t)ro_size, PROT_READ, MAP_SHARED, map_fd,
>>> +                rb->page_size);
> should we split this mmap into two mmaps -- one for producer_pos page,
> another for data area. That will presumably allow to mmap ringbuf with
> max_entries = 1GB?
I don't understand the reason for the splitting. Even without the splitting, in
theory ring buffer with max_entries = 1GB will be OK for 32-bits kernel, despite
in practice the mapping of 1GB ring buffer on 32-bits kernel will fail because
the most common size of kernel virtual address space is 1GB (although ARM could
use VMSPLIT_1G to increase the size of kernel virtual address to 3GB).
>
>>>       if (tmp == MAP_FAILED) {
>>>               err = -errno;
>>>               ringbuf_unmap_ring(rb, r);
>>> --
>>> 2.29.2

