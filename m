Return-Path: <bpf+bounces-11649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF757BCBC5
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 04:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36100281C24
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 02:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F7D15CC;
	Sun,  8 Oct 2023 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2548188
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 02:47:21 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2B6BA
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 19:47:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S365D3Y7Vz4f3jXS
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 10:47:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB3_84yGCJlYSWkCQ--.61102S2;
	Sun, 08 Oct 2023 10:47:17 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/6] mm/percpu.c: introduce alloc_size_percpu()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
 <20231007135106.3031284-2-houtao@huaweicloud.com>
 <20231007070458.dcd3dbc7ebb63d1a89d09325@linux-foundation.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3e6c42e6-c663-8242-8bfa-050008b40495@huaweicloud.com>
Date: Sun, 8 Oct 2023 10:47:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231007070458.dcd3dbc7ebb63d1a89d09325@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB3_84yGCJlYSWkCQ--.61102S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1fJw4DCrW3WFyftFy8uFg_yoW8Cr45pF
	W0ga4qkr40qr18Gw1Fvw1UXw4I9rs7GF4xJ3W5JF15CF9Ivr9xKFyvvrW5uFyrCr12vr12
	vFZ0qan3AFZ8t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbG2NtUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/7/2023 10:04 PM, Andrew Morton wrote:
> On Sat,  7 Oct 2023 21:51:01 +0800 Hou Tao <houtao@huaweicloud.com> wrote:
>
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Introduce alloc_size_percpu() to get the size of the dynamic per-cpu
>> area. It will be used by bpf memory allocator in the following patches.
>> BPF memory allocator maintains multiple per-cpu area caches for multiple
>> area sizes and it needs the size of dynamic per-cpu area to select the
>> corresponding cache when bpf program frees the dynamic per-cpu area.
>>
>> --- a/mm/percpu.c
>> +++ b/mm/percpu.c
>> @@ -2244,6 +2244,35 @@ static void pcpu_balance_workfn(struct work_struct *work)
>>  	mutex_unlock(&pcpu_alloc_mutex);
>>  }
>>  
>> +/**
>> + * alloc_size_percpu - the size of the dynamic percpu area
>> + * @ptr: pointer to the dynamic percpu area
>> + *
>> + * Return the size of the dynamic percpu area @ptr.
>> + *
>> + * RETURNS:
>> + * The size of the dynamic percpu area.
>> + *
>> + * CONTEXT:
>> + * Can be called from atomic context.
>> + */
>> +size_t alloc_size_percpu(void __percpu *ptr)
>> +{
>> +	struct pcpu_chunk *chunk;
>> +	int bit_off, end;
> It's minor, but I'd suggest unsigned long for both.

Thanks for this and all following suggestions. Will do in v2.
>
>> +	void *addr;
>> +
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	addr = __pcpu_ptr_to_addr(ptr);
>> +	/* No pcpu_lock here: ptr has not been freed, so chunk is still alive */
>> +	chunk = pcpu_chunk_addr_search(addr);
>> +	bit_off = (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;
> void* - void* is a ptrdiff_t, which is long or int.
>
>> +	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk), bit_off + 1);
> find_next_bit takes an unsigned long
>
>> +	return (end - bit_off) * PCPU_MIN_ALLOC_SIZE;
> And then we don't need to worry about signedness issues.
>
>> +}
>> +


