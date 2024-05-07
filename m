Return-Path: <bpf+bounces-28876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46E8BE63D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A87B28850
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84A15FA6D;
	Tue,  7 May 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="lF29aSwl"
X-Original-To: bpf@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2015ECE2;
	Tue,  7 May 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092623; cv=none; b=sqj4My9w5+4/MVC14NrckpcNIU27twCwp2shPUjFhvKXPr9Hj6/7rpyfvK6iZ3InC4WXirvmhF/18lJdY8xAkf3jMHQ5qiA4O8KVNpixnyWhgVQJyBOxFK/oWdeaMaTY3t8x6V97IS7ok2xQwi3ABiLWLfHZR8VEOk4daTgjngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092623; c=relaxed/simple;
	bh=8lBxj7OlkdnR3Nw99USWXlYjj/eD13fDPsd3mf0Jpz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvdxLnCtoP3FzGcOKxRQbK6g90aXYTO2b6lpEKAqbd8Xc85orAcvMePGHPCmnjajrCCTJKpYUtD0Ph1FwiTvUdoqgYq6OovxowgNGAPxCm50TghNcMi8/kp+nHGe2UMuvistQHtET8PTfziAoNI7bPOhP+yMiCmS4Wx3+xH4bjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=lF29aSwl; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bE7QxHBl23SqmkvQImsRLD5Ew8sdZ2Sh0oNk8KX8UXI=; b=lF29aSwlz7rdbvZlOKsenoLRqj
	WPB0gv4x5crFU+bqbBAuOVDDVwlxMWUqxkLYMqTigGdwilcGQOdG31W7ChRV00vDImXw9ktfgN2OX
	r/02MyS0yrCoGE1Cz5ctBUr8GdVEkoHYzFUvAy6CXQhvghOyLmRR3WO0vNeCbr48AV33D/mRKEXOd
	Nt5oSU7qQvtojXW4qyTc10bq8fvakg3LaRuuFtOfvSD4Me0QcFHERYeahgWuxk6ea89VOlQ9BH5b4
	NylfnD0+nDTd6MryDtsvcy5lZQJcxNa3lYx8taKNzSWBXk/2zlWKhTlTC/irXHHLQcO13Z0Kl0jXg
	PlInHUHg==;
Received: from [217.161.79.54] (helo=[172.16.0.144])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s4LMT-008sEA-Fx; Tue, 07 May 2024 15:00:05 +0100
Message-ID: <b7421822-4c07-40e2-b2a4-3599ba6b39da@codethink.co.uk>
Date: Tue, 7 May 2024 15:00:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
To: Pu Lehui <pulehui@huawei.com>, Xiao Wang <xiao.w.wang@intel.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, haicheng.li@intel.com
References: <20240507104528.435980-1-xiao.w.wang@intel.com>
 <6836eb5c-f135-4e58-987b-987ab446b27c@huawei.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <6836eb5c-f135-4e58-987b-987ab446b27c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 07/05/2024 13:47, Pu Lehui wrote:
> 
> On 2024/5/7 18:45, Xiao Wang wrote:
>> The Zba extension provides add.uw insn which can be used to implement
>> zext.w with rs2 set as ZERO.
>>
>> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
>> ---
>>   arch/riscv/Kconfig       | 19 +++++++++++++++++++
>>   arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 6bec1bce6586..0679127cc0ea 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
>>         preemption. Enabling this config will result in higher memory
>>         consumption due to the allocation of per-task's kernel Vector 
>> context.
>> +config TOOLCHAIN_HAS_ZBA
>> +    bool
>> +    default y
>> +    depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
>> +    depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
>> +    depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
>> +    depends on AS_HAS_OPTION_ARCH
>> +
>>   config TOOLCHAIN_HAS_ZBB

At this point would it be easier to ask the toolchain what's enabled
and put into kconfig via some sort of script?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


