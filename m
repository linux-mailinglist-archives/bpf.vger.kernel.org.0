Return-Path: <bpf+bounces-20604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA655840A1C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B29B1F28E37
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F1B15443C;
	Mon, 29 Jan 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jB4DDqb1"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A0153BD0;
	Mon, 29 Jan 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542394; cv=none; b=U5L95C4oXkwnFS6pG9aW7VVqWlC3TbONtK9CMTU+JIgheHHl3K7CA9b7JiqzUuCqOiV/TiIEbNH0946j4Zbd3TTgC7Vdw7l9Zyj5o7JOEOPX5tF+zTgBxlp4ACZLuCj1TUh1OVlWAPrnThs9H58tCtNe7wG2aAOAKy9zKavsZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542394; c=relaxed/simple;
	bh=KK1fR8EQlrJ6EUBT39fCtHr57DrrXCl3EaeExEW7aE4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rmUDPJ+9oVTlniZHqYR+PLOF2wJ3cP6cXVUvjQbLAdfsSTTmVUrVPANYWctleZWUNQ75DpZIg6TuyrfhP6aO5QOBvnM6mvcSSBvg8Cuk1u5ffa7yImPVBEJhAtw4Hk1ORvbPHeJCy9OnQr5U/XnGJ22orzk+Z351BpxN2ruIYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jB4DDqb1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ekJI84jz9Cz4AFQVBZBV9I87QpFYwV1HOZxh1PFt9/U=; b=jB4DDqb1cCAWQswNqcJfN7MjqC
	xaPle6dW5aS9NhxvIKcaBFRrDZUY1cQOzojKgUFRFnrGK4G5d/60OAGNloPPXCZZo+DF0OaA/8HgF
	JAt35RV4WNtk4XCCmM8mb+IkdHKTGQSbGX5XZGNc66bLlf31Wp8A1MLHtofuG2D9ZE/mr0h2fwTPs
	YA201eg9HpAW5vRtztivcKi27HIiZ9OBDSCGzP7aMOWKuExxmpdaU/JZhKcr9yZTOTGuEVJ64z47n
	fZQzOPdtWtbOKHYwgLlZ6veoXCVSkGGVRMvTWcQst431WbyLDIQ1UMzMIIvRYcdA2caVsPNcSC32s
	oWEy/eNg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rUTd0-000Dvz-HP; Mon, 29 Jan 2024 16:32:54 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rUTcz-000N5e-Ey; Mon, 29 Jan 2024 16:32:53 +0100
Subject: Re: [PATCH RESEND bpf-next v3 4/6] riscv, bpf: Add necessary Zbb
 instructions
To: Pu Lehui <pulehui@huawei.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
 <871qa2zog6.fsf@all.your.base.are.belong.to.us>
 <03ebc63f-7b96-4a70-ad10-a4ffc1d5b1cc@huawei.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0b2bb6aa-e114-157b-94d1-4acb091b48b8@iogearbox.net>
Date: Mon, 29 Jan 2024 16:32:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <03ebc63f-7b96-4a70-ad10-a4ffc1d5b1cc@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27169/Mon Jan 29 10:39:53 2024)

On 1/29/24 10:13 AM, Pu Lehui wrote:
> On 2024/1/28 1:16, Björn Töpel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Add necessary Zbb instructions introduced by [0] to reduce code size and
>>> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
>>> added to check whether the CPU supports Zbb instructions.
>>>
>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>>   arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>> index e30501b46f8f..51f6d214086f 100644
>>> --- a/arch/riscv/net/bpf_jit.h
>>> +++ b/arch/riscv/net/bpf_jit.h
>>> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>>>       return IS_ENABLED(CONFIG_RISCV_ISA_C);
>>>   }
>>> +static inline bool rvzbb_enabled(void)
>>> +{
>>> +    return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
>>
>> Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
>> for a kernel JIT compiler.
>>
>> IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
>> Should it be enough to just have the run-time check? Should a kernel
>> built w/o Zbb be able to emit Zbb from the JIT?
> 
> Not enough, because riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) is a platform capability check, and the other one is a kernel image capability check. We can pass the check riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when CONFIG_RISCV_ISA_ZBB=n. And my local test prove it.

So if I understand you correctly, only relying on the riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)
part would not work - iow, the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) is mandatory here?

Thanks,
Daniel

P.s.: Given Bjorn's review and tests I took the series into bpf-next now. Thanks everyone!

