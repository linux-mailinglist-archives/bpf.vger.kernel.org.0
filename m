Return-Path: <bpf+bounces-17686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C597811AEB
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186E01C211F6
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CCC55795;
	Wed, 13 Dec 2023 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PSpHNl+p"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC03EA
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:26:32 -0800 (PST)
Message-ID: <c32a3776-29ef-4efb-a7f1-1302643bb0ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702488391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lb/Gyz8VvXIsrBVYOUPmEJY/qD8tbwOnjvvgt/tGbqE=;
	b=PSpHNl+pykdzTffxopFXQcHv0rwLMwQtk77x2azGTPxjYM9WMdF385MKN3+PMHVTL9gFlR
	FSSccRTkd4PiMb9/Za+SIjGAJKJ/uX6onLNmS6xugHoyppxGn3f3zydB19SOVzvVvIapmQ
	Tj/WzB+1WlihcbMCaci56FG8t2TBcdY=
Date: Wed, 13 Dec 2023 09:26:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/5] bpf: Refill only one percpu element in
 memalloc
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231212223040.2135547-1-yonghong.song@linux.dev>
 <20231212223055.2138132-1-yonghong.song@linux.dev>
 <e5a58774-971f-ddcd-8f43-8dd76dda30b6@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e5a58774-971f-ddcd-8f43-8dd76dda30b6@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/13/23 3:05 AM, Hou Tao wrote:
>
> On 12/13/2023 6:30 AM, Yonghong Song wrote:
>> Typically for percpu map element or data structure, once allocated,
>> most operations are lookup or in-place update. Deletion are really
>> rare. Currently, for percpu data strcture, 4 elements will be
>> refilled if the size is <= 256. Let us just do with one element
>> for percpu data. For example, for size 256 and 128 cpus, the
>> potential saving will be 3 * 256 * 128 * 128 = 12MB.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/memalloc.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 84987e97fd0a..a1d718ee264d 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -483,11 +483,15 @@ static void init_refill_work(struct bpf_mem_cache *c)
>>   
>>   static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>>   {
>> +	int cnt = 1;
>> +
>>   	/* To avoid consuming memory assume that 1st run of bpf
>>   	 * prog won't be doing more than 4 map_update_elem from
>>   	 * irq disabled region
>>   	 */
> Please update the comments accordingly.
Ack.
>> -	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
>> +	if (!c->percpu_size && c->unit_size <= 256)
>> +		cnt = 4;
>> +	alloc_bulk(c, cnt, cpu_to_node(cpu), false);
>>   }
>>   
>>   static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)

