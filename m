Return-Path: <bpf+bounces-18419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8481A76C
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 20:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CE21C22A03
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03848795;
	Wed, 20 Dec 2023 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CP7ZFM1H"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2B495C1
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5eb0959-288c-4932-a1f1-d8192aa7edbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703102112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szxA6H2c9cQ26VilUI1BxDHv6dxAh2yxxLF/t1wam8U=;
	b=CP7ZFM1HUnjfGfbo4q9KJQTTRB1RqmfJ5+pgnY2i2n5qT59960hAGfbfcMEqUnsJjImH49
	Yg1uds2BB1GeISSqvENGNrvWDa5n6e/Q6zv72/BZqO8oGUEDGqblcDmvKuDyRT1wNNdEeD
	CPCwJAMq4xviaZAPLycx1jhNBGuBy14=
Date: Wed, 20 Dec 2023 11:55:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 4/7] bpf: Refill only one percpu element in
 memalloc
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231218063031.3037929-1-yonghong.song@linux.dev>
 <20231218063052.3040932-1-yonghong.song@linux.dev>
 <2b92dfac-1ce1-4981-c2ec-a432e4dd24a5@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2b92dfac-1ce1-4981-c2ec-a432e4dd24a5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/19/23 3:31 AM, Hou Tao wrote:
> Hi,
>
> On 12/18/2023 2:30 PM, Yonghong Song wrote:
>> Typically for percpu map element or data structure, once allocated,
>> most operations are lookup or in-place update. Deletion are really
>> rare. Currently, for percpu data strcture, 4 elements will be
>> refilled if the size is <= 256. Let us just do with one element
>> for percpu data. For example, for size 256 and 128 cpus, the
>> potential saving will be 3 * 256 * 128 * 128 = 12MB.
>>
>> Acked-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/memalloc.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 50ab2fecc005..f37998662146 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -485,11 +485,16 @@ static void init_refill_work(struct bpf_mem_cache *c)
>>   
>>   static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>>   {
>> -	/* To avoid consuming memory assume that 1st run of bpf
>> -	 * prog won't be doing more than 4 map_update_elem from
>> -	 * irq disabled region
>> +	int cnt = 1;
>> +
>> +	/* To avoid consuming memory, for non-percpu allocation, assume that
>> +	 * 1st run of bpf prog won't be doing more than 4 map_update_elem from
>> +	 * irq disabled region if unit size is less than or equal to 256.
>> +	 * For all other cases, let us just do one allocation.
>>   	 */
>> -	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
>> +	if (!c->percpu_size && c->unit_size <= 256)
>> +		cnt = 4;
>> +	alloc_bulk(c, cnt, cpu_to_node(cpu), false);
>>   }
> Another thought about this patch. When the prefilled element is
> allocated by the invocation of bpf_percpu_obj_new(), the prefill will
> trigger again and this time it will allocate c->batch elements. For
> 256-bytes unit_size, c->batch will be 64, so the maximal memory
> consumption under 128-cpus host will be: 64 * 256 * 128 * 128 = 256MB

Actually, it should be 48 * 256 * 128 * 128 in the worst case, due to
   c->batch = max((c->high_watermark - c->low_watermark) / 4 * 3, 1);

But in reality, for percpu allocation, we probably won't have allocation
for all 128 cpus.

But your point is taken, for percpu allocation, we will have much less
allocations, so we should not use current lower_watermark/upper_watermark used
for non-percpu allocations. So for percpu allocation, I suggest to do
   lower_watermark = 1;
   upper_watermark = 3;
   c->batch = 1;

Thanks!

> when there is one allocation of bpf_percpu_obj_new() on each CPU. And my
> question is that should we adjust the low_watermark and high_watermark
> accordingly for per-cpu allocation to reduce the memory consumption ?
>>   
>>   static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)

