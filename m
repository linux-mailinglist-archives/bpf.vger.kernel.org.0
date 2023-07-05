Return-Path: <bpf+bounces-4017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE9747BA8
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 05:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D025C280FCF
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D0A48;
	Wed,  5 Jul 2023 03:03:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B279381D
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 03:03:34 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA3DE72
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 20:03:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qwkxq2CXMz4f3q2j
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 11:03:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB30hx93aRk34sUMg--.1702S2;
	Wed, 05 Jul 2023 11:03:29 +0800 (CST)
Subject: Re: [v3 PATCH bpf-next 5/6] selftests/bpf: test map percpu stats
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-6-aspsk@isovalent.com>
 <3e761472-051d-4e46-8a66-79926493e5db@huawei.com>
 <ZKQ0iF+8fMND5Qmg@zh-lab-node-5>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <525f2690-f367-6296-8dde-0138ba8aa42f@huaweicloud.com>
Date: Wed, 5 Jul 2023 11:03:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKQ0iF+8fMND5Qmg@zh-lab-node-5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB30hx93aRk34sUMg--.1702S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw45uw1rCF17CFyfWrykXwb_yoW8Kw15pa
	4FyF4DKFs7Z347t34vva4fWFn2qrs8Ar1UZr1DJr1UArsxKr1Sqr1xAayqkF9a9rW2vwnY
	v3y29ryfCws5W3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/4/2023 11:02 PM, Anton Protopopov wrote:
> On Tue, Jul 04, 2023 at 10:41:10PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 6/30/2023 4:25 PM, Anton Protopopov wrote:
>>> Add a new map test, map_percpu_stats.c, which is checking the correctness of
>>> map's percpu elements counters.  For supported maps the test upserts a number
>>> of elements, checks the correctness of the counters, then deletes all the
>>> elements and checks again that the counters sum drops down to zero.
>>>
>>> The following map types are tested:
>>>
>>>     * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
>>>     * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
>>>     * BPF_MAP_TYPE_HASH,
>>>     * BPF_MAP_TYPE_PERCPU_HASH,
>>>     * BPF_MAP_TYPE_LRU_HASH
>>>     * BPF_MAP_TYPE_LRU_PERCPU_HASH
>> A test for BPF_MAP_TYPE_HASH_OF_MAPS is also needed.
We could also exercise the test for LRU map with BPF_F_NO_COMMON_LRU.
>
SNIP
>>> diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
>>> new file mode 100644
>>> index 000000000000..5b45af230368
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
>>> @@ -0,0 +1,336 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2023 Isovalent */
>>> +
>>> +#include <errno.h>
>>> +#include <unistd.h>
>>> +#include <pthread.h>
>>> +
>>> +#include <bpf/bpf.h>
>>> +#include <bpf/libbpf.h>
>>> +
>>> +#include <bpf_util.h>
>>> +#include <test_maps.h>
>>> +
>>> +#include "map_percpu_stats.skel.h"
>>> +
>>> +#define MAX_ENTRIES 16384
>>> +#define N_THREADS 37
>> Why 37 thread is needed here ? Does a small number of threads work as well ?
> This was used to evict more elements from LRU maps when they are full.

I see. But in my understanding, for the global LRU list, the eviction
(the invocation of htab_lru_map_delete_node) will be possible if the
free element is less than LOCAL_FREE_TARGET(128) * nr_running_cpus. Now
the number of free elements is 1000 as defined in __test(), the number
of vCPU is 8 in my local VM setup (BPF CI also uses 8 vCPUs) and it is
hard to trigger the eviction because 8 * 128 is roughly equal with 1000.
So I suggest to decrease the number of free elements to 512 and the
number of threads to 8, or adjust the number of running thread and free
elements according to the number of online CPUs.


