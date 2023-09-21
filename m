Return-Path: <bpf+bounces-10566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC367A9CCC
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED4CB22731
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39719BBB;
	Thu, 21 Sep 2023 18:11:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E244B235
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 18:11:15 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D6A5469;
	Thu, 21 Sep 2023 10:58:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405361bb93bso8117535e9.3;
        Thu, 21 Sep 2023 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319134; x=1695923934; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQjWGh5FJkJl0s9pvk/+A6cLo2EhA5CUtBJB0T+VZWo=;
        b=Ib6Ldlvbxu8Hcirox7qE4CqlrSzM6P1G2iKDqrI+2EvBlipW8azStxjGphQIHAITSi
         GAp0qstHzidDZsMvN99bTTvMiSAxbFUyX6zEbCvBcRFjq0Odtxq7uCuagjpUHfJCNHrb
         fVLelecX2L2wHFCFpMfLqF+29NnIzxzaTarIzyoECBm7BAksOeeenlDU/L70AhJTojaS
         PDDlKa9F6m7edlEAySUAbjVOxxn4OhNjkven0U/46TdpkeSruJIJmwV8rb4qQxQEbWku
         qhOFQcrx5K9Mz6uvlcv0T+bYlfyXuMCEgzGdnCawufiaUyYS9IoSRmCt+drp2zKGO/VP
         ovfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319134; x=1695923934;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQjWGh5FJkJl0s9pvk/+A6cLo2EhA5CUtBJB0T+VZWo=;
        b=KpTwfxSVzfmfLeTIFwu41mZzmAD0bAaIRxgo/ZgiwTqhYbCo0KIIA0TGrNJ+gVJUUl
         Zmgxjf0SlHo8KAsk5kZuGuPRnbAQGv5hk7GgvwwzoG7z7pA/SDykAaSbECB/W92Q96SB
         XazT5QicuooELGGuKireKR/GV7qGdk4P3dNUt5GIP0i+e+7bjZHfmXkMOX4T27SLgnyM
         mi3kAfRUZK4/etM0mg72t6p/3M0mGmAD/7GI+yDfgyMyLqyUjHkOp76BsCniVj0R/Z3A
         WR8l8+9mLYWl+SezFooKE5RDMfw0iqZjFt0kKTkP1GibiYSaW13HX39AGb8TgNoCazLC
         ulGg==
X-Gm-Message-State: AOJu0YxS8kZw+pyHfmd4Zv0Ut5h4NznRw20vu9laNojQX/WeKrAHW0H5
	KiPHkT8RFmOMzZIHvJGNgzjofwBsWgaU8/tGDEY=
X-Google-Smtp-Source: AGHT+IGf19k4uMXQxHLVePErL4etNMmx5eWqBe9n5W2Jow9QcPW8JD/yKoQlaELtpNjeFxHgRKlQ9g==
X-Received: by 2002:a05:600c:2186:b0:402:f54d:745 with SMTP id e6-20020a05600c218600b00402f54d0745mr5777398wme.17.1695307859542;
        Thu, 21 Sep 2023 07:50:59 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c219400b003fe1c332810sm4988805wme.33.2023.09.21.07.50.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:50:59 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] arm64: patching: Add aarch64_insn_set()
In-Reply-To: <2095a591-8f3e-318c-a390-a43a653ce6d5@huaweicloud.com>
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-3-puranjay12@gmail.com>
 <2095a591-8f3e-318c-a390-a43a653ce6d5@huaweicloud.com>
Date: Thu, 21 Sep 2023 14:50:55 +0000
Message-ID: <mb61pfs37a8c0.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 9/8/2023 10:43 PM, Puranjay Mohan wrote:
>> The BPF JIT needs to write invalid instructions to RX regions of memory
>> to invalidate removed BPF programs. This needs a function like memset()
>> that can work with RX memory.
>> 
>> Implement aarch64_insn_set() which is similar to text_poke_set() of x86.
>> 
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>   arch/arm64/include/asm/patching.h |  1 +
>>   arch/arm64/kernel/patching.c      | 40 +++++++++++++++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
>> index f78a0409cbdb..551933338739 100644
>> --- a/arch/arm64/include/asm/patching.h
>> +++ b/arch/arm64/include/asm/patching.h
>> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>>   int aarch64_insn_write(void *addr, u32 insn);
>>   
>>   int aarch64_insn_write_literal_u64(void *addr, u64 val);
>> +int aarch64_insn_set(void *dst, const u32 insn, size_t len);
>>   void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>>   
>>   int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
>> index 243d6ae8d2d8..63d9e0e77806 100644
>> --- a/arch/arm64/kernel/patching.c
>> +++ b/arch/arm64/kernel/patching.c
>> @@ -146,6 +146,46 @@ noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
>>   	return dst;
>>   }
>>   
>> +/**
>> + * aarch64_insn_set - memset for RX memory regions.
>> + * @dst: address to modify
>> + * @c: value to set
>
> insn

Thanks for catching.

>> + * @len: length of memory region.
>> + *
>> + * Useful for JITs to fill regions of RX memory with illegal instructions.
>> + */
>> +noinstr int aarch64_insn_set(void *dst, const u32 insn, size_t len)
>
> const is unnecessary
>

Will remove in next version.

>> +{
>> +	unsigned long flags;
>> +	size_t patched = 0;
>> +	size_t size;
>> +	void *waddr;
>> +	void *ptr;
>> +
>> +	/* A64 instructions must be word aligned */
>> +	if ((uintptr_t)dst & 0x3)
>> +		return -EINVAL;
>> +
>> +	raw_spin_lock_irqsave(&patch_lock, flags);
>> +
>> +	while (patched < len) {
>> +		ptr = dst + patched;
>> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
>> +			     len - patched);
>> +
>> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
>> +		memset32(waddr, insn, size / 4);
>> +		patch_unmap(FIX_TEXT_POKE0);
>> +
>> +		patched += size;
>> +	}
>> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
>> +
>> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);
>> +
>> +	return 0;
>> +}
>> +
>
> this function shares most of the code with aarch64_insn_copy(), how about
> extracting the shared code to a separate function?

I was thinking of writing it like the text_poke api of x86. Where you
can provide a function as an argument to work on a memory area.
Essentially, it will look like:

typedef int text_poke_f(void *dst, const void *src, size_t len);

static void *aarch64_insn_poke(text_poke_f func, void *addr, const void *src, size_t len)

We can call this function with a wrapper of `copy_to_kernel_nofault` for copy
and with a wrapper of memset32 for setting.

Do you think this is a good approach?

>
>>   int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>>   {
>>   	u32 *tp = addr;

Thanks,
Puranjay

