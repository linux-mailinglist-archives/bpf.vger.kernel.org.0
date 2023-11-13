Return-Path: <bpf+bounces-14968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D367E95CB
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 04:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7361F1C20A26
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 03:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FB8BE7F;
	Mon, 13 Nov 2023 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA407882A
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 03:59:32 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC19109
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 19:59:30 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4STFzv6qmFz4f3n60
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 11:59:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF6721A0173
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 11:59:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3EUIcn1FluOo8Aw--.8762S2;
	Mon, 13 Nov 2023 11:59:27 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Add missed allocation hint for
 bpf_mem_cache_alloc_flags()
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231111043821.2258513-1-houtao@huaweicloud.com>
 <07e4414b-3347-49e4-9c19-57d101ccd009@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <07cd47c4-3cd5-6a77-16a5-2057188f1e0e@huaweicloud.com>
Date: Mon, 13 Nov 2023 11:59:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <07e4414b-3347-49e4-9c19-57d101ccd009@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3EUIcn1FluOo8Aw--.8762S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kGw4UGFW3JFWxJw1kKrg_yoW8uw47pF
	Z7JFy8GrWrZF18Aw47W34kury5Aw48G3W3GF40qa4UZr43Xryqgr4kWry2gFyjkr40kFWU
	tF1qqr1FvFWUZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi,

On 11/13/2023 10:34 AM, Yonghong Song wrote:
>
> On 11/10/23 8:38 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> bpf_mem_cache_alloc_flags() may call __alloc() directly when there is no
>> free object in free list, but it doesn't initialize the allocation hint
>> for the returned pointer. It may lead to bad memory dereference when
>> freeing the pointer, so fix it by initializing the allocation hint.
>>
>> Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> LGTM based on my reading of the code. Maybe you could explain
> how you found this issue and whether a test case can be constructed
> relatively easily to expose this issue?
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thanks for the review. I found the issue through code inspection when
trying to use c->unit_size to select the target cache in bpf_mem_free().
I think it is hard to trigger the problem under x86-64 or arm64 when
PREEMPT_RT is disabled. Because with disabled PREEMPT_RT, irq work is
invoked in IPI context and free_llist will be refilled timely and
unit_alloc() will always return a free object under normal process
context. But when PREEMPT_RT is disabled, irq work is invoked under a
per-CPU kthread, so unit_alloc() may fail to fulfill the allocation request.
>
>> ---
>>   kernel/bpf/memalloc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 63b909d277d47..6a51cfe4c2d63 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -978,6 +978,8 @@ void notrace *bpf_mem_cache_alloc_flags(struct
>> bpf_mem_alloc *ma, gfp_t flags)
>>           memcg = get_memcg(c);
>>           old_memcg = set_active_memcg(memcg);
>>           ret = __alloc(c, NUMA_NO_NODE, GFP_KERNEL | __GFP_NOWARN |
>> __GFP_ACCOUNT);
>> +        if (ret)
>> +            *(struct bpf_mem_cache **)ret = c;
>>           set_active_memcg(old_memcg);
>>           mem_cgroup_put(memcg);
>>       }


>
> .


