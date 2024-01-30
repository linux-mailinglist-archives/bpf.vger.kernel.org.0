Return-Path: <bpf+bounces-20685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37617841BDD
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 07:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB0DB230A1
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB838DE6;
	Tue, 30 Jan 2024 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk+OnDuW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717F57864;
	Tue, 30 Jan 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595487; cv=none; b=s+7S0E/XO0sjGe2f1/ru6XLbqDrBCoV6Q4bgB+xJESwuxKYDRlDc5/v1yIHZ27/bYYjbNXRwdLw2YyCnES0ypamSLUEm4UyoxO3CnQxCZNJJQGRAIbXi7O+XrVYU332zHpvm8Xa+b21hNZ2/JMax5jdrWUxZrdYTCUb8Ltx79us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595487; c=relaxed/simple;
	bh=uC/25PJLPO0KFx/aHGxXZaji9fO699iLqEIMG/M6pDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgWPklqVJSuPoOIugIqRs/2cwT4NVcCmfqOybSpf56s+C5e+dar1jhpLE9fRlQbFv/Wg0XkWNv6G2P9E+nWuzkdPEz1+RKVeKoccQJzyDCt3iECYA1QKfPGiZb0CCpB7dkFFJWR2d5XCoX942YdRrnCvfNL5OnmD/PP8ORyp/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk+OnDuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DB9C433C7;
	Tue, 30 Jan 2024 06:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706595486;
	bh=uC/25PJLPO0KFx/aHGxXZaji9fO699iLqEIMG/M6pDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Uk+OnDuWzZfYI+lWmR+aAiq/v7hw++v1we3wgr4v9BHIHs0RvTU4Iz9QgL3cg2PPo
	 18guaJhjsagoto29T5vhYdRLGpt9XSt1B3Wc3td9lkNIRre4M4bVnpa9OPY2XT19+v
	 LVhL4FqSmWPkKgVh51zPqCbY10K3FGyY/2aVpi5Dmi5Wd59YR/1tbQn+k5XZOq6v0m
	 dSbu2hSqqnNCuT19vOTK2NwPLW1nHtNyvp8Q/1GQBw1HK+VyIvDnV3LkhqJKUNgJNm
	 SGgW5ZZMJQLzDRlursS//ANB/fufYTtjkT4AaNdDKNZaKb9dScTxMzjondoDPBkgvb
	 pvU+rid6/K4qw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, Pu Lehui <pulehui@huawei.com>,
 Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley
 <conor@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH RESEND bpf-next v3 4/6] riscv, bpf: Add necessary Zbb
 instructions
In-Reply-To: <0b2bb6aa-e114-157b-94d1-4acb091b48b8@iogearbox.net>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
 <871qa2zog6.fsf@all.your.base.are.belong.to.us>
 <03ebc63f-7b96-4a70-ad10-a4ffc1d5b1cc@huawei.com>
 <0b2bb6aa-e114-157b-94d1-4acb091b48b8@iogearbox.net>
Date: Tue, 30 Jan 2024 07:18:03 +0100
Message-ID: <8734ufwdic.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 1/29/24 10:13 AM, Pu Lehui wrote:
>> On 2024/1/28 1:16, Bj=C3=B6rn T=C3=B6pel wrote:
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> Add necessary Zbb instructions introduced by [0] to reduce code size a=
nd
>>>> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
>>>> added to check whether the CPU supports Zbb instructions.
>>>>
>>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/=
bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>> ---
>>>> =C2=A0 arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>>> index e30501b46f8f..51f6d214086f 100644
>>>> --- a/arch/riscv/net/bpf_jit.h
>>>> +++ b/arch/riscv/net/bpf_jit.h
>>>> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IS_ENABLED(CONFIG_RISCV_ISA_C);
>>>> =C2=A0 }
>>>> +static inline bool rvzbb_enabled(void)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_h=
as_extension_likely(RISCV_ISA_EXT_ZBB);
>>>
>>> Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
>>> for a kernel JIT compiler.
>>>
>>> IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
>>> Should it be enough to just have the run-time check? Should a kernel
>>> built w/o Zbb be able to emit Zbb from the JIT?
>>=20
>> Not enough, because riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) is
>> a platform capability check, and the other one is a kernel image
>> capability check. We can pass the check
>> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when
>> CONFIG_RISCV_ISA_ZBB=3Dn. And my local test prove it.

What I'm trying to say (and drew as well in the other reply) is that
"riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) when
CONFIG_RISCV_ISA_ZBB=3Dn" should also make the JIT emit Zbb insns. The
platform check should be sufficient.

> So if I understand you correctly, only relying on the
> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) part would not work -
> iow, the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) is mandatory here?
>
> Thanks,
> Daniel
>
> P.s.: Given Bjorn's review and tests I took the series into bpf-next
> now. Thanks everyone!

Thanks! Yes, this is mainly a semantic discussion, and it can be further
relaxed later with a follow up -- if applicable.


Bj=C3=B6rn

