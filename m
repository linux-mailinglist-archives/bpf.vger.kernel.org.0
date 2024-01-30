Return-Path: <bpf+bounces-20648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26484180B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 02:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912151C21B00
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD436AE4;
	Tue, 30 Jan 2024 01:00:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28659364A3;
	Tue, 30 Jan 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576409; cv=none; b=hkGF8RiKbrcrpZhx1Pwyxe2tddraIPkoODUz+/aJtcUAwwQo/VwlUBVAgbpUBKzzfjNEmu2p+eVY84qrS3fZi+pkrjwyM8+VS+wjBx8wOLYN0XjrXhoRA9o7xnm6gDe1Wdh85LiHhb3ZCLFQRF2zRW2oMC7wbGvh3DV9vOmZ6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576409; c=relaxed/simple;
	bh=1Ad103jRN5IjsXGM1uCFmiC/X3JAoF+LzCSHFTKx/1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hqSaMPppYp0P+1adMl375jDOV6OjfSOONTUKXQ2gE2qVQMmctVe+J+0Aq6SXxbPrZldjKLQcWUSl94d18TLnKbL8wA5hRTsP+3yzHsfaUvRi1kRhGRSChYEcugQzu3TNjmd6ygYIKK3p5Tf53os8hh7zrb/gUnLakPziwBRJ6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TP6Hd3Cbzz1Q8Zl;
	Tue, 30 Jan 2024 08:58:53 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 714101402CD;
	Tue, 30 Jan 2024 09:00:03 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 30 Jan 2024 09:00:02 +0800
Message-ID: <9680b0fe-9f83-4bc3-b9ba-729778b0a802@huawei.com>
Date: Tue, 30 Jan 2024 09:00:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v3 4/6] riscv, bpf: Add necessary Zbb
 instructions
To: Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: Pu Lehui <pulehui@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke
 Nelson <luke.r.nels@gmail.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
 <871qa2zog6.fsf@all.your.base.are.belong.to.us>
 <03ebc63f-7b96-4a70-ad10-a4ffc1d5b1cc@huawei.com>
 <0b2bb6aa-e114-157b-94d1-4acb091b48b8@iogearbox.net>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <0b2bb6aa-e114-157b-94d1-4acb091b48b8@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100009.china.huawei.com (7.221.188.135)



On 2024/1/29 23:32, Daniel Borkmann wrote:
> On 1/29/24 10:13 AM, Pu Lehui wrote:
>> On 2024/1/28 1:16, Björn Töpel wrote:
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> Add necessary Zbb instructions introduced by [0] to reduce code size 
>>>> and
>>>> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
>>>> added to check whether the CPU supports Zbb instructions.
>>>>
>>>> Link: 
>>>> https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>> ---
>>>>   arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++++
>>>>   1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>>> index e30501b46f8f..51f6d214086f 100644
>>>> --- a/arch/riscv/net/bpf_jit.h
>>>> +++ b/arch/riscv/net/bpf_jit.h
>>>> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>>>>       return IS_ENABLED(CONFIG_RISCV_ISA_C);
>>>>   }
>>>> +static inline bool rvzbb_enabled(void)
>>>> +{
>>>> +    return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && 
>>>> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
>>>
>>> Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
>>> for a kernel JIT compiler.
>>>
>>> IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
>>> Should it be enough to just have the run-time check? Should a kernel
>>> built w/o Zbb be able to emit Zbb from the JIT?
>>
>> Not enough, because riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) is a 
>> platform capability check, and the other one is a kernel image 
>> capability check. We can pass the check 
>> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when 
>> CONFIG_RISCV_ISA_ZBB=n. And my local test prove it.
> 
> So if I understand you correctly, only relying on the 
> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)
> part would not work - iow, the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) is 
> mandatory here?
> 

Yes, it should be IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && 
riscv_has_extension_likely(RISCV_ISA_EXT_ZBB).

> Thanks,
> Daniel
> 
> P.s.: Given Bjorn's review and tests I took the series into bpf-next 
> now. Thanks everyone!

Thanks Daniel and Björn

