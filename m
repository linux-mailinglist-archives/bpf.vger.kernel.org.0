Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27519626679
	for <lists+bpf@lfdr.de>; Sat, 12 Nov 2022 03:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiKLCcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 21:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiKLCcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 21:32:05 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AED391E4
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 18:32:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N8KMw5JdTz4f3jZb
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 10:31:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgC3zLecBW9jJ2SCAQ--.45293S2;
        Sat, 12 Nov 2022 10:31:59 +0800 (CST)
Subject: Re: [PATCH bpf 1/4] libbpf: Adjust ring buffer size when probing ring
 buffer map
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221111092642.2333724-1-houtao@huaweicloud.com>
 <20221111092642.2333724-2-houtao@huaweicloud.com>
 <Y26KsQfOLGYeJJoo@google.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <bfbd2605-ea42-34d2-5b1d-701efe5030b1@huaweicloud.com>
Date:   Sat, 12 Nov 2022 10:31:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y26KsQfOLGYeJJoo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgC3zLecBW9jJ2SCAQ--.45293S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryUuw15uF1xZw47Cw4fGrg_yoW8AF4xpF
        Z5try5GryY9r18Jr1DWr1FqryUtr4UWa18Gry8X3WYyF4UXFsFgr17uF4agr1fXw4kGw15
        GrW5KryxZryUJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 11/12/2022 1:47 AM, sdf@google.com wrote:
> On 11/11, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>
>> Adjusting the size of ring buffer when probing ring buffer map, else
>> the probe may fail on host with 64KB page size (e.g., an ARM64 host).
>
>> After the fix, the output of "bpftool feature" on above host will be
>> correct.
>
>> Before :
>>      eBPF map_type ringbuf is NOT available
>>      eBPF map_type user_ringbuf is NOT available
>
>> After :
>>      eBPF map_type ringbuf is available
>>      eBPF map_type user_ringbuf is available
>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   tools/lib/bpf/libbpf.c          | 2 +-
>>   tools/lib/bpf/libbpf_internal.h | 2 ++
>>   tools/lib/bpf/libbpf_probes.c   | 2 +-
>>   3 files changed, 4 insertions(+), 2 deletions(-)
SNIP
>
>>   #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index f3a8e8e74eb8..29a1db2645fd 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -234,7 +234,7 @@ static int probe_map_create(enum bpf_map_type map_type)
>>       case BPF_MAP_TYPE_USER_RINGBUF:
>>           key_size = 0;
>>           value_size = 0;
>> -        max_entries = 4096;
>> +        max_entries = adjust_ringbuf_sz(4096);
>
> Why not pass PAGE_SIZE directly here? Something like:
>
> max_entries = sysconf(_SC_PAGE_SIZE);
>
> ?
Good idea. Will do that in v2.
>
>>           break;
>>       case BPF_MAP_TYPE_STRUCT_OPS:
>>           /* we'll get -ENOTSUPP for invalid BTF type ID for struct_ops */
>> -- 
>> 2.29.2

