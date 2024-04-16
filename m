Return-Path: <bpf+bounces-26954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CB58A6D65
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400AA281A9A
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC112D741;
	Tue, 16 Apr 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuleBCGZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B012D1FA
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276547; cv=none; b=g+rP63TaZR6loczNBv+EiNfFHPCVJhnsIKS3llY5CDPuZ1ZLiAOtrVQFLhJ9NPNUtTCYlSlaI5YB9Gxd3hIOnNMiyqdjRqSvdr8AmBpOAJrt69cy3c4yhJk5oVjsQV/dybCQ36HZwYssrLkdTnsofcpDW7VU8F/mfCwyu8Uc9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276547; c=relaxed/simple;
	bh=VpiBOyduHlcT5sitsX5cm2upCEOifFlYiu20YiiyzeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DqDicG94VAfZa20RAhj9bysEAKspfRlgWdhPVcuQXEkGfRrLoMEbPWQSi7jRKA94ngBKkfAO90TQQKs911D5xw3eACRcbTlre7tByNUroXHhpG8IGwmethQs2kg7Z47keL60y4Ana0gVIagA5uA7oc2R4vzEhgG5EE1KXWiXn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuleBCGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEE9C4AF0A;
	Tue, 16 Apr 2024 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276546;
	bh=VpiBOyduHlcT5sitsX5cm2upCEOifFlYiu20YiiyzeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HuleBCGZSPRpaxRNM76UXKsEIhVSJ3o9QyrSsYfKS2opt2asaKR9YXIRiRSIUMYf0
	 FBiZNMENQ+4r88trn4DDDh3cM1F/mbJ2EUVa84+mZXHyZsUsRgDa3AJ1pgP+6AIavc
	 DJOzoBQwRd6wbl0K+SRHwgkfvU0ja4l34HeqylsrGAizNp4M7XL7GqwdJQ7VSljFUt
	 JMDL8+kirIq/v7TjPRcHzkt2VZILBaS4EzgbfX77WkTNYPbtNWiBIgLMF8uLy60LYA
	 GplMDtCvGf9lo3oy3Jrz4nwcyLLvqK5+j6wHyj3rm5OEn0lV1j1j5bhP/5gRnFanBM
	 akB9zPD7t1nCg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huawei.com>, Xu Kuohai <xukuohai@huaweicloud.com>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org
Cc: Ivan Babrou <ivan@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 2/2] riscv, bpf: Fix incorrect runtime stats
In-Reply-To: <39b55f13-69a1-401e-b87e-1040e33c9368@huawei.com>
References: <20240416064208.2919073-1-xukuohai@huaweicloud.com>
 <20240416064208.2919073-3-xukuohai@huaweicloud.com>
 <39b55f13-69a1-401e-b87e-1040e33c9368@huawei.com>
Date: Tue, 16 Apr 2024 16:09:03 +0200
Message-ID: <871q754cxs.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huawei.com> writes:

> On 2024/4/16 14:42, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>=20
>> When __bpf_prog_enter() returns zero, the s1 register is not set to zero,
>> resulting in incorrect runtime stats. Fix it by setting s1 immediately u=
pon
>> the return of __bpf_prog_enter().
>>=20
>> Fixes: 49b5e77ae3e2 ("riscv, bpf: Add bpf trampoline support for RV64")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_co=
mp64.c
>> index 15e482f2c657..e713704be837 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -730,6 +730,9 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l,=
 int args_off, int retval_of
>>   	if (ret)
>>   		return ret;
>>=20=20=20
>> +	/* store prog start time */
>> +	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
>> +
>>   	/* if (__bpf_prog_enter(prog) =3D=3D 0)
>>   	 *	goto skip_exec_of_prog;
>>   	 */
>> @@ -737,9 +740,6 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l,=
 int args_off, int retval_of
>>   	/* nop reserved for conditional jump */
>>   	emit(rv_nop(), ctx);
>>=20=20=20
>> -	/* store prog start time */
>> -	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
>> -
>>   	/* arg1: &args_off */
>>   	emit_addi(RV_REG_A0, RV_REG_FP, -args_off, ctx);
>>   	if (!p->jited)
>
> Thanks.
>
> Reviewed-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

