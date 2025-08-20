Return-Path: <bpf+bounces-66072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF453B2D9C5
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8FA1654D8
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19AF2E03F9;
	Wed, 20 Aug 2025 10:10:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762842D9EC8;
	Wed, 20 Aug 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684613; cv=none; b=KOg7QF9WqBaioOVrQnRjwV6AFukhB4P8QRMsCPppMq6fFFqEE3jKdBr0Soz6YXLeJ9UWWhKEblg7zlB0UsUDaungyFNvglRgGEkTkWvzUH/LnqyZZIkre21MicPE0VgXUfE5wKfVvC1U5k0KULvvjz7WiTbZrNk1hv4sm7qgImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684613; c=relaxed/simple;
	bh=3VZJAWVT2ZlOtPTm8k6zpzkymgEDbsaX7suXN3GO5Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R7vFQH8voXqQl1drI0tkHFgDA6c1VqK+/c/inkOpuw3MxffNg2HDwuXESFP1M7L1V5ZQzIo7J7tAYKRxyI0NOWFj8uSsDqULCJcpiUN7NYusXlkHcnUerMTva03rI0AGeJIkAVf0anoInTVNfBachHBb0xeF4L+lv0XLqwfwpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c6MZD0GyLz2gL95;
	Wed, 20 Aug 2025 18:07:16 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 236CE1A0171;
	Wed, 20 Aug 2025 18:10:09 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 18:10:07 +0800
Message-ID: <239193b7-7dab-45b0-ab13-06bfe3f96f22@huawei.com>
Date: Wed, 20 Aug 2025 18:10:07 +0800
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
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250820092628.GA1289807@chenghao-pc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/8/20 17:26, Chenghao Duan wrote:
> On Wed, Aug 20, 2025 at 02:52:01PM +0800, Pu Lehui wrote:
>>
>>
>> On 2025/8/20 14:25, Chenghao Duan wrote:
>>> In __arch_prepare_bpf_trampoline(), retval_off is only meaningful when
>>> save_ret is true, so the current logic is correct. However, in the
>>
>> lgtm, and same for `ip_off`, pls patch it together.
> 
> I also checked at the time that ip_off is only initialized and assigned
> when flags & BPF_TRAMP_F_IP_ARG is true. However, I noticed that the use
> of ip_off also requires this condition, so the compiler did not issue a
> warning.
> 
> Chenghao
> 
>>
>>> original logic, retval_off is only initialized under certain

Can you show how to replay this warning? I guess the warning path is as 
follow. Compiler didn't know fmod_ret prog need BPF_TRAMP_F_CALL_ORIG.

```
if (fmod_ret->nr_links) {
	...
	emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
}
```

>>> conditions, which may cause a build warning.
>>>
>>> So initialize retval_off unconditionally to fix it.
>>>
>>> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
>>> ---
>>>    arch/riscv/net/bpf_jit_comp64.c | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>>> index 10e01ff06312..49bbda8372b0 100644
>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>> @@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>>    	stack_size += 16;
>>>    	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
>>> -	if (save_ret) {
>>> +	if (save_ret)
>>>    		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
>>> -		retval_off = stack_size;
>>> -	}
>>> +	retval_off = stack_size;
>>>    	stack_size += nr_arg_slots * 8;
>>>    	args_off = stack_size;

