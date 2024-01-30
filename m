Return-Path: <bpf+bounces-20689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EDF841DA4
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 09:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78654B22066
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838AA6167F;
	Tue, 30 Jan 2024 08:20:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C558108;
	Tue, 30 Jan 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602841; cv=none; b=qIOfRO6EHzk0nIoUkAfuks8lvr7TGvY55nY4P7gTeeEdwWsQT31DBgoJIQgiGCZtTrTF3SPHqXTvNYj3xDOW4nWz55C2tmTy0pO5t5lqULSQCzR4TycUbZ2xurwGf6lSzKvLM5rZpnJOKhpDAZoSb2H4Zs7DAHS7kw7icRL5yd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602841; c=relaxed/simple;
	bh=vDR73ReSVHVlsdDGPuhQ6qlDap7CDTu2t9MBqEU5ReM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QgzgiOLv48i6DBc+h6YyTOoznZ0OR7nfHV2i6MSSpnzV0vngwFhYPzx/qey+GcorIu88Dr5Mox4AM/92CstxjxSKbfvv9ab/m1g8siX65NuXs3cYOoN2TsDDCedncM9CKiI8PF0d+6ZBuhFYzcW7k7OuNmBU8yRdy75o6QEz0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TPJ4n4ThKz1vsn4;
	Tue, 30 Jan 2024 16:20:09 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 3979B1A016B;
	Tue, 30 Jan 2024 16:20:34 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 30 Jan 2024 16:20:33 +0800
Message-ID: <b1bf2bc8-870d-40a4-9ad2-2b4ced34c43f@huawei.com>
Date: Tue, 30 Jan 2024 16:20:32 +0800
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
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Pu Lehui <pulehui@huaweicloud.com>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong
 Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>, Andrew Jones <ajones@ventanamicro.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
 <871qa2zog6.fsf@all.your.base.are.belong.to.us>
 <03ebc63f-7b96-4a70-ad10-a4ffc1d5b1cc@huawei.com>
 <0b2bb6aa-e114-157b-94d1-4acb091b48b8@iogearbox.net>
 <8734ufwdic.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <8734ufwdic.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100009.china.huawei.com (7.221.188.135)



On 2024/1/30 14:18, Björn Töpel wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
>> On 1/29/24 10:13 AM, Pu Lehui wrote:
>>> On 2024/1/28 1:16, Björn Töpel wrote:
>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>
>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>
>>>>> Add necessary Zbb instructions introduced by [0] to reduce code size and
>>>>> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
>>>>> added to check whether the CPU supports Zbb instructions.
>>>>>
>>>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>>> ---
>>>>>    arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>>>> index e30501b46f8f..51f6d214086f 100644
>>>>> --- a/arch/riscv/net/bpf_jit.h
>>>>> +++ b/arch/riscv/net/bpf_jit.h
>>>>> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>>>>>        return IS_ENABLED(CONFIG_RISCV_ISA_C);
>>>>>    }
>>>>> +static inline bool rvzbb_enabled(void)
>>>>> +{
>>>>> +    return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
>>>>
>>>> Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
>>>> for a kernel JIT compiler.
>>>>
>>>> IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
>>>> Should it be enough to just have the run-time check? Should a kernel
>>>> built w/o Zbb be able to emit Zbb from the JIT?
>>>
>>> Not enough, because riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) is
>>> a platform capability check, and the other one is a kernel image
>>> capability check. We can pass the check
>>> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when
>>> CONFIG_RISCV_ISA_ZBB=n. And my local test prove it.
> 
> What I'm trying to say (and drew as well in the other reply) is that
> "riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when
> CONFIG_RISCV_ISA_ZBB=n" should also make the JIT emit Zbb insns. The
> platform check should be sufficient.

Ooh, this is really beyond my expectation. The test_progs can pass when 
with only platform check and it can recognize the zbb instructions. Now 
I know it. Sorry for misleading.🙁

Curious if CONFIG_RISCV_ISA_ZBB is still necessary?

> 
>> So if I understand you correctly, only relying on the
>> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) part would not work -
>> iow, the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) is mandatory here?
>>
>> Thanks,
>> Daniel
>>
>> P.s.: Given Bjorn's review and tests I took the series into bpf-next
>> now. Thanks everyone!
> 
> Thanks! Yes, this is mainly a semantic discussion, and it can be further
> relaxed later with a follow up -- if applicable.
> 
> 
> Björn

