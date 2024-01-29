Return-Path: <bpf+bounces-20553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D084010E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 10:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7991F2202D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744654F98;
	Mon, 29 Jan 2024 09:13:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EE54F8A;
	Mon, 29 Jan 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519595; cv=none; b=IuTrb4sEhLjpVKsQX29kUy9kKVLK8i25cAx1ytEqKhi/thP7vBR+6G0nIBR15vPA2KUydqUEbkRtE2Q2Ght4ev2BkPax3KDQhZN0FlhkHTi2YV+cglYBZ7PgwsHHWt06wK3mFIr6BB+Tvjbpe2MVfdezPfSa+cAjq/LwVwHp9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519595; c=relaxed/simple;
	bh=fUwawlo+6mog1liGVL6Imvc8CtK/LPifYJCNZrjGVdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XWYuZgm682WrXodWnoLehwPJNLuuMLr88zjdwnCqEle8eZ1i7B//p1m4K4BrJfr3JgzA7e5Mdyl4+012zNBkog1LS+UtQlkKGhuM4bVuKDNfkO0/3/sCWdgASaBtSWlW6jAJZXQyxT8Jx54YLT1+Ar2nvhe5EW5LFy0IYWAcMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TNjGJ63hCz1gy0l;
	Mon, 29 Jan 2024 17:11:20 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 4393E14011D;
	Mon, 29 Jan 2024 17:13:09 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 29 Jan 2024 17:13:08 +0800
Message-ID: <03ebc63f-7b96-4a70-ad10-a4ffc1d5b1cc@huawei.com>
Date: Mon, 29 Jan 2024 17:13:07 +0800
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
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu Lehui
	<pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
 <871qa2zog6.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <871qa2zog6.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)



On 2024/1/28 1:16, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Add necessary Zbb instructions introduced by [0] to reduce code size and
>> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
>> added to check whether the CPU supports Zbb instructions.
>>
>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index e30501b46f8f..51f6d214086f 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>>   	return IS_ENABLED(CONFIG_RISCV_ISA_C);
>>   }
>>   
>> +static inline bool rvzbb_enabled(void)
>> +{
>> +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
> 
> Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
> for a kernel JIT compiler.
> 
> IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
> Should it be enough to just have the run-time check? Should a kernel
> built w/o Zbb be able to emit Zbb from the JIT?
> 

Not enough, because riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) is a 
platform capability check, and the other one is a kernel image 
capability check. We can pass the check 
riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when 
CONFIG_RISCV_ISA_ZBB=n. And my local test prove it.

> 
> Björn

