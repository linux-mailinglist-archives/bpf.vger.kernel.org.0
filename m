Return-Path: <bpf+bounces-20804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A61843AFD
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B10A2974A7
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D264CC8;
	Wed, 31 Jan 2024 09:22:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566960DCC;
	Wed, 31 Jan 2024 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692969; cv=none; b=UwJA+ZHBWAwutUBEr0jASHM8y573RbFXp31pYLK04tscH9erWk2rKD6+X56K6WvwVP/BLeLwq/llgrB8QHtGhSc/WXxt5uE2zdSd/VNPudSN2m2YRFzndp+mH9qGw2ZcSILgv2AYGo169I7IiUwBiva8rmlAiL2+sPOP9RXkT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692969; c=relaxed/simple;
	bh=oIAtk8+T7I6m6qJx6qWhQtum8UwSrV6A6S3zpxDPDJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OY2PpTjaGxpQ0FmgyjZtG8dCdNFM/ihJ5Febhey9HavITjii0fvxlFwEXZJt/OTIhsa+O3S0lD3xxKdaJN9Z+7wWrt2WgJitmGlMX3e3zgxOKlYYmxBF77yN8zN073q0GMbnoDrq0xg5SXP+XmRnAzHwPoaQ9Dn74WeenX+x5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TPxQR0NcXz4f3kj9;
	Wed, 31 Jan 2024 17:22:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 372A81A0171;
	Wed, 31 Jan 2024 17:22:43 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgB3RxBiEbplO4QjCg--.58547S2;
	Wed, 31 Jan 2024 17:22:42 +0800 (CST)
Message-ID: <050c301e-dfd0-4488-bc3c-0287da838981@huaweicloud.com>
Date: Wed, 31 Jan 2024 17:22:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v3 4/6] riscv, bpf: Add necessary Zbb
 instructions
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Andrew Jones <ajones@ventanamicro.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
 <871qa2zog6.fsf@all.your.base.are.belong.to.us>
 <03ebc63f-7b96-4a70-ad10-a4ffc1d5b1cc@huawei.com>
 <0b2bb6aa-e114-157b-94d1-4acb091b48b8@iogearbox.net>
 <8734ufwdic.fsf@all.your.base.are.belong.to.us>
 <b1bf2bc8-870d-40a4-9ad2-2b4ced34c43f@huawei.com>
 <87o7d2ohdi.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87o7d2ohdi.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3RxBiEbplO4QjCg--.58547S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15Ww1fKr43ur4UKw1rZwb_yoW5Ar4fpr
	48JFWYkw4kGF17Krn7tF18WrW5tr4rJw13WrnrXFWUJFWq9w17Krs5J3Wj9F1kXryxKr10
	vFW3Xw1fua1jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWwZcUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/1/31 1:34, Björn Töpel wrote:
> Pu Lehui <pulehui@huawei.com> writes:
> 
>> On 2024/1/30 14:18, Björn Töpel wrote:
>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>
>>>> On 1/29/24 10:13 AM, Pu Lehui wrote:
>>>>> On 2024/1/28 1:16, Björn Töpel wrote:
>>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>>
>>>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>>>
>>>>>>> Add necessary Zbb instructions introduced by [0] to reduce code size and
>>>>>>> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
>>>>>>> added to check whether the CPU supports Zbb instructions.
>>>>>>>
>>>>>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>>>>> ---
>>>>>>>     arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 32 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>>>>>> index e30501b46f8f..51f6d214086f 100644
>>>>>>> --- a/arch/riscv/net/bpf_jit.h
>>>>>>> +++ b/arch/riscv/net/bpf_jit.h
>>>>>>> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>>>>>>>         return IS_ENABLED(CONFIG_RISCV_ISA_C);
>>>>>>>     }
>>>>>>> +static inline bool rvzbb_enabled(void)
>>>>>>> +{
>>>>>>> +    return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
>>>>>>
>>>>>> Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
>>>>>> for a kernel JIT compiler.
>>>>>>
>>>>>> IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
>>>>>> Should it be enough to just have the run-time check? Should a kernel
>>>>>> built w/o Zbb be able to emit Zbb from the JIT?
>>>>>
>>>>> Not enough, because riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) is
>>>>> a platform capability check, and the other one is a kernel image
>>>>> capability check. We can pass the check
>>>>> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when
>>>>> CONFIG_RISCV_ISA_ZBB=n. And my local test prove it.
>>>
>>> What I'm trying to say (and drew as well in the other reply) is that
>>> "riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when
>>> CONFIG_RISCV_ISA_ZBB=n" should also make the JIT emit Zbb insns. The
>>> platform check should be sufficient.
>>
>> Ooh, this is really beyond my expectation. The test_progs can pass when
>> with only platform check and it can recognize the zbb instructions. Now
>> I know it. Sorry for misleading.🙁
>>
>> Curious if CONFIG_RISCV_ISA_ZBB is still necessary?
> 
> You don't need IS_ENABLED(CONFIG_RISCV_ISA_ZBB) for the JIT, but the
> kernel needs it.
> 
> Feel free to follow up with a patch to remove it.
> 

Maybe we can implement more extensions about bitmanip.

> 
> Cheers,
> Björn


