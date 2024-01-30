Return-Path: <bpf+bounces-20756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D0842B16
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3ED28C55F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDE14E2F6;
	Tue, 30 Jan 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFUO+/VM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2641F14E2E8;
	Tue, 30 Jan 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636045; cv=none; b=T4zVY2xZR4+KFWKopQUwgpkp/LMU9WZdH2XcNfc23Gm9F4PgAdcQq/iyYT2sYpejHLe69gbRizqVebB0I/r2u0P3pAQIfvdPjcAiyE/kmIu26AX7Gi75RHUeJiWaLJLisCRuZriExBAZduVjtjadWEO7AhC7qdfRRp70Ff3WNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636045; c=relaxed/simple;
	bh=s+uGeMFk7/OILlMudrkwvEoRpuM0V4ZOhDV+SZXg1g8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=thoQ/59bAGMTYkYLWMPTn2dubosUbxxPQIwI7XqanVNFkihZd5EBljsPvYaTr3d65BuWNrxA55jc4dfEA05YDnYcXSWjkcFOWlTAQe3ASMamWuQ/qJQIL4p8RZd/Vp31VDsGpt8GvKkEX0W99a4ftwGLNaKsajVn3YzCmqdeG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFUO+/VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F812C43390;
	Tue, 30 Jan 2024 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706636044;
	bh=s+uGeMFk7/OILlMudrkwvEoRpuM0V4ZOhDV+SZXg1g8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cFUO+/VMhG3RC9Ka0Gh3nWa0amhgUiQukJoILGFPB2A+OfsbZeimcRiaZDCoeXfCU
	 ZMkmhAtmLVm7i6cL80TaJxnpFraWLvTUBqnD8Ah9fB1qiF5k2xCxLWS9Jtz9U9D+rR
	 EgaJQD/PKxnHjuAv8Gt/eefcdxfoDOYb8lMWXZVAP57XQe41FonRBiLyzs9bgD6Diz
	 lbZ/B2tI7JaoaII9Y/CSTNXeEmEq3p5+7rpA3o5Y/XI1nfgTF6Ic+ipep8nFk3zTD0
	 Aj7Alw6s1bFYdN/jxL1R69WS4OAxOO0Q/goQAUA3QZIlj+5wfKJdWCEtZr/xw6i/pg
	 pxBMcsO5Wv10A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong
 Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH RESEND bpf-next v3 4/6] riscv, bpf: Add necessary Zbb
 instructions
In-Reply-To: <b1bf2bc8-870d-40a4-9ad2-2b4ced34c43f@huawei.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
 <871qa2zog6.fsf@all.your.base.are.belong.to.us>
 <03ebc63f-7b96-4a70-ad10-a4ffc1d5b1cc@huawei.com>
 <0b2bb6aa-e114-157b-94d1-4acb091b48b8@iogearbox.net>
 <8734ufwdic.fsf@all.your.base.are.belong.to.us>
 <b1bf2bc8-870d-40a4-9ad2-2b4ced34c43f@huawei.com>
Date: Tue, 30 Jan 2024 18:34:01 +0100
Message-ID: <87o7d2ohdi.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huawei.com> writes:

> On 2024/1/30 14:18, Bj=C3=B6rn T=C3=B6pel wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>=20
>>> On 1/29/24 10:13 AM, Pu Lehui wrote:
>>>> On 2024/1/28 1:16, Bj=C3=B6rn T=C3=B6pel wrote:
>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>
>>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>>
>>>>>> Add necessary Zbb instructions introduced by [0] to reduce code size=
 and
>>>>>> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper=
 is
>>>>>> added to check whether the CPU supports Zbb instructions.
>>>>>>
>>>>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.=
0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>>>> ---
>>>>>>  =C2=A0 arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++=
++
>>>>>>  =C2=A0 1 file changed, 32 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>>>>> index e30501b46f8f..51f6d214086f 100644
>>>>>> --- a/arch/riscv/net/bpf_jit.h
>>>>>> +++ b/arch/riscv/net/bpf_jit.h
>>>>>> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IS_ENABLED(CONFIG_RISCV_ISA_C=
);
>>>>>>  =C2=A0 }
>>>>>> +static inline bool rvzbb_enabled(void)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv=
_has_extension_likely(RISCV_ISA_EXT_ZBB);
>>>>>
>>>>> Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
>>>>> for a kernel JIT compiler.
>>>>>
>>>>> IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
>>>>> Should it be enough to just have the run-time check? Should a kernel
>>>>> built w/o Zbb be able to emit Zbb from the JIT?
>>>>
>>>> Not enough, because riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) is
>>>> a platform capability check, and the other one is a kernel image
>>>> capability check. We can pass the check
>>>> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when
>>>> CONFIG_RISCV_ISA_ZBB=3Dn. And my local test prove it.
>>=20
>> What I'm trying to say (and drew as well in the other reply) is that
>> "riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when
>> CONFIG_RISCV_ISA_ZBB=3Dn" should also make the JIT emit Zbb insns. The
>> platform check should be sufficient.
>
> Ooh, this is really beyond my expectation. The test_progs can pass when=20
> with only platform check and it can recognize the zbb instructions. Now=20
> I know it. Sorry for misleading.=F0=9F=99=81
>
> Curious if CONFIG_RISCV_ISA_ZBB is still necessary?

You don't need IS_ENABLED(CONFIG_RISCV_ISA_ZBB) for the JIT, but the
kernel needs it.

Feel free to follow up with a patch to remove it.


Cheers,
Bj=C3=B6rn

