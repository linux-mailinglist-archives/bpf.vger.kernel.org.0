Return-Path: <bpf+bounces-10606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E77AA675
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 03:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 98C52281D25
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC6393;
	Fri, 22 Sep 2023 01:25:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B42377
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 01:25:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A3FCE;
	Thu, 21 Sep 2023 18:25:05 -0700 (PDT)
Received: from kwepemd100003.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RsDyL3LlJzVl4r;
	Fri, 22 Sep 2023 09:22:02 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100003.china.huawei.com (7.221.188.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Fri, 22 Sep 2023 09:25:02 +0800
Message-ID: <8e31490d-1a7b-7bf8-6a72-23e8955e2ecb@huawei.com>
Date: Fri, 22 Sep 2023 09:25:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v5 2/3] arm64: patching: Add aarch64_insn_set()
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
	<bpf@vger.kernel.org>, <kpsingh@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-3-puranjay12@gmail.com>
 <2095a591-8f3e-318c-a390-a43a653ce6d5@huaweicloud.com>
 <mb61pfs37a8c0.fsf@gmail.com>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <mb61pfs37a8c0.fsf@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100003.china.huawei.com (7.221.188.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/2023 10:50 PM, Puranjay Mohan wrote:
> Xu Kuohai <xukuohai@huaweicloud.com> writes:
> 
>> On 9/8/2023 10:43 PM, Puranjay Mohan wrote:
>>> The BPF JIT needs to write invalid instructions to RX regions of memory
>>> to invalidate removed BPF programs. This needs a function like memset()
>>> that can work with RX memory.
>>>
>>> Implement aarch64_insn_set() which is similar to text_poke_set() of x86.
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>>> ---
>>>    arch/arm64/include/asm/patching.h |  1 +
>>>    arch/arm64/kernel/patching.c      | 40 +++++++++++++++++++++++++++++++
>>>    2 files changed, 41 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
>>> index f78a0409cbdb..551933338739 100644
>>> --- a/arch/arm64/include/asm/patching.h
>>> +++ b/arch/arm64/include/asm/patching.h
>>> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>>>    int aarch64_insn_write(void *addr, u32 insn);
>>>    
>>>    int aarch64_insn_write_literal_u64(void *addr, u64 val);
>>> +int aarch64_insn_set(void *dst, const u32 insn, size_t len);
>>>    void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>>>    
>>>    int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>>> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
>>> index 243d6ae8d2d8..63d9e0e77806 100644
>>> --- a/arch/arm64/kernel/patching.c
>>> +++ b/arch/arm64/kernel/patching.c
>>> @@ -146,6 +146,46 @@ noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
>>>    	return dst;
>>>    }
>>>    
>>> +/**
>>> + * aarch64_insn_set - memset for RX memory regions.
>>> + * @dst: address to modify
>>> + * @c: value to set
>>
>> insn
> 
> Thanks for catching.
> 
>>> + * @len: length of memory region.
>>> + *
>>> + * Useful for JITs to fill regions of RX memory with illegal instructions.
>>> + */
>>> +noinstr int aarch64_insn_set(void *dst, const u32 insn, size_t len)
>>
>> const is unnecessary
>>
> 
> Will remove in next version.
> 
>>> +{
>>> +	unsigned long flags;
>>> +	size_t patched = 0;
>>> +	size_t size;
>>> +	void *waddr;
>>> +	void *ptr;
>>> +
>>> +	/* A64 instructions must be word aligned */
>>> +	if ((uintptr_t)dst & 0x3)
>>> +		return -EINVAL;
>>> +
>>> +	raw_spin_lock_irqsave(&patch_lock, flags);
>>> +
>>> +	while (patched < len) {
>>> +		ptr = dst + patched;
>>> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
>>> +			     len - patched);
>>> +
>>> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
>>> +		memset32(waddr, insn, size / 4);
>>> +		patch_unmap(FIX_TEXT_POKE0);
>>> +
>>> +		patched += size;
>>> +	}
>>> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
>>> +
>>> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>> this function shares most of the code with aarch64_insn_copy(), how about
>> extracting the shared code to a separate function?
> 
> I was thinking of writing it like the text_poke api of x86. Where you
> can provide a function as an argument to work on a memory area.
> Essentially, it will look like:
> 
> typedef int text_poke_f(void *dst, const void *src, size_t len);
> 
> static void *aarch64_insn_poke(text_poke_f func, void *addr, const void *src, size_t len)
> 
> We can call this function with a wrapper of `copy_to_kernel_nofault` for copy
> and with a wrapper of memset32 for setting.
> 
> Do you think this is a good approach?
>
Sounds great, thanks.

>>
>>>    int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>>>    {
>>>    	u32 *tp = addr;
> 
> Thanks,
> Puranjay


