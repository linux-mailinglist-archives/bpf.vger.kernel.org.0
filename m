Return-Path: <bpf+bounces-66145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C42B2EB07
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 03:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E3E5C7336
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 01:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C33296BC3;
	Thu, 21 Aug 2025 01:58:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54013223708;
	Thu, 21 Aug 2025 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741507; cv=none; b=nhyUkKnMvTZF+aYeE/2IPZG6631giKkLdR+c7Be6AeIZwkelfb+LKynMS7dpI3nNdE5gIx4wD6hBcjnXX9BvifaJ0paZX95fnl2ufLvKuvTnob9VkharaojYHzZvErE9izESIV+tsXwSjpzRin+BmA35ByK1y8DylInES8mNk8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741507; c=relaxed/simple;
	bh=K2AcjJV7qdbGxHlJRZpcZQl1H7ZWHNMo8atQSbIRip8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G/VxvRaEdqbZbGCQpD/MU6D6PucUEy4W5ZroNuuCG5xfpxvXBY2eu9p+4P6n4q3Ay6sdknt4rQR+X2jU/blnzeX3XJ0gA228HYS5tXiDN4B8B4zbZwXINsJY6m63rkW6uFkbRjMVQOMb5J1bG2UXZfmn6eqwjqbEqNdh5Mw15o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c6mZb2hNYz2CgSl;
	Thu, 21 Aug 2025 09:53:59 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BA0F180044;
	Thu, 21 Aug 2025 09:58:22 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 09:58:21 +0800
Message-ID: <9cbdefd6-a757-44b3-a1db-69ca8117aacb@huawei.com>
Date: Thu, 21 Aug 2025 09:58:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: bpf: Fix uninitialized symbol 'retval_off'
Content-Language: en-US
To: Chenghao Duan <duanchenghao@kylinos.cn>
CC: <ast@kernel.org>, <bjorn@kernel.org>, <puranjay@kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>, <alex@ghiti.fr>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250820062520.846720-1-duanchenghao@kylinos.cn>
 <8b836b6e-103a-41c2-b111-0417d8db4dce@huawei.com>
 <20250820092628.GA1289807@chenghao-pc>
 <239193b7-7dab-45b0-ab13-06bfe3f96f22@huawei.com>
 <20250820103530.GA1475460@chenghao-pc>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250820103530.GA1475460@chenghao-pc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/8/20 18:35, Chenghao Duan wrote:
> On Wed, Aug 20, 2025 at 06:10:07PM +0800, Pu Lehui wrote:
>>
>>
>> On 2025/8/20 17:26, Chenghao Duan wrote:
>>> On Wed, Aug 20, 2025 at 02:52:01PM +0800, Pu Lehui wrote:
>>>>
>>>>
>>>> On 2025/8/20 14:25, Chenghao Duan wrote:
>>>>> In __arch_prepare_bpf_trampoline(), retval_off is only meaningful when
>>>>> save_ret is true, so the current logic is correct. However, in the

OK, I think we should make commit msg more explicit. Such like the 
follow. wdyt?

`However, in the fmod_ret logic, the compiler is not aware that the 
flags of the fmod_ret prog have set BPF_TRAMP_F_CALL_ORIG, resulting in 
an uninitialized symbol compilation warning.`

>>>>
>>>> lgtm, and same for `ip_off`, pls patch it together.
>>>
>>> I also checked at the time that ip_off is only initialized and assigned
>>> when flags & BPF_TRAMP_F_IP_ARG is true. However, I noticed that the use
>>> of ip_off also requires this condition, so the compiler did not issue a
>>> warning.
>>>
>>> Chenghao
>>>
>>>>
>>>>> original logic, retval_off is only initialized under certain
>>
>> Can you show how to replay this warning? I guess the warning path is as
>> follow. Compiler didn't know fmod_ret prog need BPF_TRAMP_F_CALL_ORIG.
>>
>> ```
>> if (fmod_ret->nr_links) {
>> 	...
>> 	emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
>> }
>> ```
>>
> 
> Exactly, the compiler sees the unconditional use of retval_off.
> 
> Chenghao
> 
>>>>> conditions, which may cause a build warning.
>>>>>
>>>>> So initialize retval_off unconditionally to fix it.
>>>>>
>>>>> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
>>>>> ---
>>>>>     arch/riscv/net/bpf_jit_comp64.c | 5 ++---
>>>>>     1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>>>>> index 10e01ff06312..49bbda8372b0 100644
>>>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>>>> @@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>>>>     	stack_size += 16;
>>>>>     	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
>>>>> -	if (save_ret) {
>>>>> +	if (save_ret)
>>>>>     		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
>>>>> -		retval_off = stack_size;
>>>>> -	}
>>>>> +	retval_off = stack_size;
>>>>>     	stack_size += nr_arg_slots * 8;
>>>>>     	args_off = stack_size;

