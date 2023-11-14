Return-Path: <bpf+bounces-15029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C973A7EA8EF
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85032281073
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE6443E;
	Tue, 14 Nov 2023 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eUbMMmlQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05767E
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 03:09:40 +0000 (UTC)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1901A1
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 19:09:35 -0800 (PST)
Message-ID: <01cfdfc4-5192-4fb6-bc86-571c871bfac4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699931373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0I9cuZlQ7rlpKKEXYamzUVBERTJY4G/WOhUdGfCSj6A=;
	b=eUbMMmlQKWgYBSjfodV5fJ3qri3Inz+wNwCJTG2/ZVdY/zc1eCRgwJYz6kcGvOLlwfCf53
	ry3zbZX010Us5d9QsbcvSWsd/phFYcu1kQrGKqwWDneGOIkDRSc79ZS/HfZf1WYq2J9XOv
	CkrrNnMvS49kFsbULiHYJklo3TiJi/A=
Date: Mon, 13 Nov 2023 22:09:23 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Add missed allocation hint for
 bpf_mem_cache_alloc_flags()
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231111043821.2258513-1-houtao@huaweicloud.com>
 <07e4414b-3347-49e4-9c19-57d101ccd009@linux.dev>
 <07cd47c4-3cd5-6a77-16a5-2057188f1e0e@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <07cd47c4-3cd5-6a77-16a5-2057188f1e0e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/12/23 7:59 PM, Hou Tao wrote:
> Hi,
>
> On 11/13/2023 10:34 AM, Yonghong Song wrote:
>> On 11/10/23 8:38 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> bpf_mem_cache_alloc_flags() may call __alloc() directly when there is no
>>> free object in free list, but it doesn't initialize the allocation hint
>>> for the returned pointer. It may lead to bad memory dereference when
>>> freeing the pointer, so fix it by initializing the allocation hint.
>>>
>>> Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> LGTM based on my reading of the code. Maybe you could explain
>> how you found this issue and whether a test case can be constructed
>> relatively easily to expose this issue?
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Thanks for the review. I found the issue through code inspection when
> trying to use c->unit_size to select the target cache in bpf_mem_free().
> I think it is hard to trigger the problem under x86-64 or arm64 when
> PREEMPT_RT is disabled. Because with disabled PREEMPT_RT, irq work is
> invoked in IPI context and free_llist will be refilled timely and
> unit_alloc() will always return a free object under normal process
> context. But when PREEMPT_RT is disabled, irq work is invoked under a

In the above 'when PREEMPT_RT is disable' => 'when PREEMPT_RT is enabled".

What you described makes sense. It is indeed hard to construct a test
case with current kernel.

> per-CPU kthread, so unit_alloc() may fail to fulfill the allocation request.
>>> ---
>>>    kernel/bpf/memalloc.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>> index 63b909d277d47..6a51cfe4c2d63 100644
>>> --- a/kernel/bpf/memalloc.c
>>> +++ b/kernel/bpf/memalloc.c
>>> @@ -978,6 +978,8 @@ void notrace *bpf_mem_cache_alloc_flags(struct
>>> bpf_mem_alloc *ma, gfp_t flags)
>>>            memcg = get_memcg(c);
>>>            old_memcg = set_active_memcg(memcg);
>>>            ret = __alloc(c, NUMA_NO_NODE, GFP_KERNEL | __GFP_NOWARN |
>>> __GFP_ACCOUNT);
>>> +        if (ret)
>>> +            *(struct bpf_mem_cache **)ret = c;
>>>            set_active_memcg(old_memcg);
>>>            mem_cgroup_put(memcg);
>>>        }
>
>> .
>

