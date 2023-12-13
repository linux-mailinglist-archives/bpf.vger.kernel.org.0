Return-Path: <bpf+bounces-17688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A347811AF4
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74959282970
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EBE56B7C;
	Wed, 13 Dec 2023 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TRWSfqNx"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8899
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:28:44 -0800 (PST)
Message-ID: <248e553f-7d4e-4198-aff3-6f218e2a3b69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702488523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37mmvM0kJhOMJsX6qL+VdnZpuaxihLfWGNeXmBJG0Uo=;
	b=TRWSfqNxRPPQr5Z/mmzD19jlnqYrI1RVMu4ORmVooK6mCZQ+4BwdTGyHpQ1xnbny5jZCcD
	8LTd2vU/sEosudY68DuKLk6cJT5Opmck5YBV1du63snVps1BS6QHYBWFahK1BzcWCfljNZ
	JLen73ZO5SXEI7mFvYJt8mlcC3HoYFw=
Date: Wed, 13 Dec 2023 09:28:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/5] bpf: Limit up to 512 bytes for
 bpf_global_percpu_ma allocation
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231212223040.2135547-1-yonghong.song@linux.dev>
 <20231212223100.2138537-1-yonghong.song@linux.dev>
 <d44e41c2-9c59-c7a3-87a4-bf20ce779b6a@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d44e41c2-9c59-c7a3-87a4-bf20ce779b6a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/13/23 3:09 AM, Hou Tao wrote:
> Hi,
>
> On 12/13/2023 6:31 AM, Yonghong Song wrote:
>> For percpu data structure allocation with bpf_global_percpu_ma,
>> the maximum data size is 4K. But for a system with large
>> number of cpus, bigger data size (e.g., 2K, 4K) might consume
>> a lot of memory. For example, the percpu memory consumption
>> with unit size 2K and 1024 cpus will be 2K * 1K * 1k = 2GB
>> memory.
>>
>> We should discourage such usage. Let us limit the maximum data
>> size to be 512 for bpf_global_percpu_ma allocation.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 0c55fe4451e1..e5cb6b7526b6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -43,6 +43,8 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>>   };
>>   
>>   struct bpf_mem_alloc bpf_global_percpu_ma;
>> +#define LLIST_NODE_SZ sizeof(struct llist_node)
>> +#define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  (512 - LLIST_NODE_SZ)
> It seems for per-cpu allocation the extra subtraction is not needed, we
> could use all allocated space in per-cpu pointer. Maybe we could update
> bpf_mem_alloc() firstly to use size instead of size + sizeof(void *) to
> select cache.

Good point. If this works, it can also ensure if users try to allocate
512 bytes. It will go to 512-byte bucket instead of 1024-byte buck.
Will investigate.

>>   
>>   /* bpf_check() is a static code analyzer that walks eBPF program
>>    * instruction by instruction and updates register/stack state.
>> @@ -12091,6 +12093,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   				}
>>   
>>   				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>> +					if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
>> +						verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %lu\n",
>> +							ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
>> +						return -EINVAL;
>> +					}
>>   					mutex_lock(&bpf_percpu_ma_lock);
>>   					err = bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t->size);
>>   					mutex_unlock(&bpf_percpu_ma_lock);

