Return-Path: <bpf+bounces-11863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684137C4A96
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994DC1C20EDB
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D415EAA;
	Wed, 11 Oct 2023 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C51798D
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 06:30:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904139D
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 23:30:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S52vv1VqTz4f3kk9
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 14:30:51 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgA3jEsYQSZlxvYMCg--.14676S2;
	Wed, 11 Oct 2023 14:30:52 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/6] mm/percpu.c: introduce alloc_size_percpu()
To: Dennis Zhou <dennis@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
 <20231007135106.3031284-2-houtao@huaweicloud.com> <ZSMt70tuBrHlI0Xa@snowbird>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3c00c6d1-da26-19fe-aa39-10c4993c475b@huaweicloud.com>
Date: Wed, 11 Oct 2023 14:30:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZSMt70tuBrHlI0Xa@snowbird>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgA3jEsYQSZlxvYMCg--.14676S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45XFW7Wry8CFW7ZFyDtrb_yoW5tF1fpF
	WkW3ZYyF4kXrnrWw1Sqw1jqw1fWws5GFyxJ343GFy5AFnIvr9Fgr1vyrW5uFyrCrn29r12
	vFZ0qFs3CFW3X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUo0eHDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/9/2023 6:32 AM, Dennis Zhou wrote:
> Hello,
>
> On Sat, Oct 07, 2023 at 09:51:01PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Introduce alloc_size_percpu() to get the size of the dynamic per-cpu
>> area. It will be used by bpf memory allocator in the following patches.
>> BPF memory allocator maintains multiple per-cpu area caches for multiple
>> area sizes and it needs the size of dynamic per-cpu area to select the
>> corresponding cache when bpf program frees the dynamic per-cpu area.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  include/linux/percpu.h |  1 +
>>  mm/percpu.c            | 29 +++++++++++++++++++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
>> index 68fac2e7cbe6..d140d9d79567 100644
>> --- a/include/linux/percpu.h
>> +++ b/include/linux/percpu.h
>> @@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
>>  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
>>  extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
>>  extern void free_percpu(void __percpu *__pdata);
>> +extern size_t alloc_size_percpu(void __percpu *__pdata);
>>  
>>  DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
>>  
>> diff --git a/mm/percpu.c b/mm/percpu.c
>> index 7b40b3963f10..f541cfc3cb2d 100644
>> --- a/mm/percpu.c
>> +++ b/mm/percpu.c
>> @@ -2244,6 +2244,35 @@ static void pcpu_balance_workfn(struct work_struct *work)
>>  	mutex_unlock(&pcpu_alloc_mutex);
>>  }
>>  
>> +/**
>> + * alloc_size_percpu - the size of the dynamic percpu area
> Can we name this pcpu_alloc_size(). A few other functions are
> exposed under pcpu_* so it's a bit easier to keep track of.

Will do in v2.
>
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
>> +	void *addr;
>> +
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	addr = __pcpu_ptr_to_addr(ptr);
>> +	/* No pcpu_lock here: ptr has not been freed, so chunk is still alive */
> Now that percpu variables are floating around more commonly, I think we
> or I need to add more validation guards so it's easier to
> debug bogus/stale pointers. Potentially like a static_key or Kconfig so
> that we take the lock and `test_bit()`.

Before the patch, it seems that free_percpu() is the only user of
__pcpu_ptr_to_addr(ptr). I can move the invocation of both
__pcpu_ptr_to_addr() and pcpu_chunk_addr_search() into a common helper
if you are OK with it. And I think it will ease the work of adding
validation guard on the per-cpu pointer.
>
>> +	chunk = pcpu_chunk_addr_search(addr);
>> +	bit_off = (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;
>> +	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk), bit_off + 1);
> Nit: can you please reflow `bit_off + 1` to the next line. I know we
> dropped the line requirement, but percpu.c almost completely still
> follows it.

Will do in v2.
>
>> +	return (end - bit_off) * PCPU_MIN_ALLOC_SIZE;
>> +}
>> +
>>  /**
>>   * free_percpu - free percpu area
>>   * @ptr: pointer to area to free
>> -- 
>> 2.29.2
>>
> Thanks,
> Dennis


