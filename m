Return-Path: <bpf+bounces-33980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938E929013
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 04:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FF0B20C17
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E4C156;
	Sat,  6 Jul 2024 02:28:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A71C8E1;
	Sat,  6 Jul 2024 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232915; cv=none; b=l+oIXXM3kDreNfL8sqVprEQ5IlUw2w4u/Lm8IUVtj4WNqO8yPooe4pm2iSna9ybjm/rxZxFskXvj8MXYB7vNFZzxvZDSOdN3UkIoVC0/DevwKhJZj8Ecb92+xnFNwNzSIHsexxnnILiWwhXBaBlk3ayD68gVXWzoRSduRGZojw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232915; c=relaxed/simple;
	bh=RT2skHsMbcoRSdfhjBhyS6aEvIIMn0BUIIP/ogu396Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bxxRNNf66newyUHFEaBW9dmOKPDdhXVkmbChxE4pm6TWEQiRPmiwSL/CQih/obogQfll/sELT2mvMPc6IuYJMTIjQ8Gzk49SVZ1Q4+h0xn89RMpJLfHvBypDuJnhHV+S92CFArOtOTUnvnTpJZU8X3wc3bGJWG8Jqh2yt7cYr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WGDhv3nmQzxTcV;
	Sat,  6 Jul 2024 10:23:59 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id EA93B180AA6;
	Sat,  6 Jul 2024 10:28:29 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Jul 2024 10:28:29 +0800
Message-ID: <885c2504-8f32-4936-ac6e-24fbfd07e43d@huawei.com>
Date: Sat, 6 Jul 2024 10:28:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/3] riscv, bpf: Add 12-argument support for
 RV64 bpf trampoline
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Pu Lehui <pulehui@huaweicloud.com>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>
References: <20240702121944.1091530-1-pulehui@huaweicloud.com>
 <20240702121944.1091530-2-pulehui@huaweicloud.com>
 <mb61p7ce0roh3.fsf@kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <mb61p7ce0roh3.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2024/7/5 20:51, Puranjay Mohan wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> This patch adds 12 function arguments support for riscv64 bpf
>> trampoline. The current bpf trampoline supports <= sizeof(u64) bytes
>> scalar arguments [0] and <= 16 bytes struct arguments [1]. Therefore, we
>> focus on the situation where scalars are at most XLEN bits and
>> aggregates whose total size does not exceed 2×XLEN bits in the riscv
>> calling convention [2].
[SNIP]
>> @@ -854,7 +875,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   		retval_off = stack_size;
>>   	}
>>   
>> -	stack_size += nregs * 8;
>> +	stack_size += nr_arg_slots * 8;
>>   	args_off = stack_size;
>>   
>>   	stack_size += 8;
>> @@ -871,8 +892,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   	stack_size += 8;
>>   	sreg_off = stack_size;
>>   
>> +	if (nr_arg_slots - RV_MAX_REG_ARGS > 0)
>> +		stack_size += (nr_arg_slots - RV_MAX_REG_ARGS) * 8;
> 
> Hi Pu,
> Although this is merged now, while working on this for arm64 I realised
> that the above doesn't check for BPF_TRAMP_F_CALL_ORIG and can waste
> some stack space, we should change this to:
> 
> if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nr_arg_slots - RV_MAX_REG_ARGS > 0))
>          stack_size += (nr_arg_slots - RV_MAX_REG_ARGS) * 8;
> 
> It will save some stack space when BPF_TRAMP_F_CALL_ORIG is not set?

Nice catch. It will be better. Feel free to patch it. Thanks!

> 
> I can send a patch if you think this is worth fixing.
> 
> 
> Thanks,
> Puranjay

