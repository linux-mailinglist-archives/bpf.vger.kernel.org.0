Return-Path: <bpf+bounces-20690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89914841DC3
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 09:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144601F22C61
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C855C2D;
	Tue, 30 Jan 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvsBIDWT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758355E51;
	Tue, 30 Jan 2024 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603389; cv=none; b=P1heYE+DIu+C2NsEJjSh1vGb2JBYMCW9bj98Aebf+5HlI8F+6Drm1kp7xdu167rE/dO54xTurw9PiWBOfKTsRrmgUEDr2yhqBmeMrnFWCesaGXk62LRJcnm6IG5uTQT7dH1JG4SgEvjIOEqGRLnCjFfFdSJOn/+eCO+xUEIda7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603389; c=relaxed/simple;
	bh=T28E1Pxj46DCSwu7JVzEKI2UvDXN/idUv1SombhTsr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VkN0+V3Bbdc4TgnvE9YfkklmRGMjjVQ5cJ/gz+hjRIwPTs05P0Hd++8k9n1MIx2wV0osa6ROjozCTsfckETNERS9NQVkMPYxoxckXzjvT0QHZBKza67/R61OVAAUbtp2Ze4yRkeooLz5Xj5HhpHhNm49E57qW4VW2JPM+HE4bck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvsBIDWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803B3C433C7;
	Tue, 30 Jan 2024 08:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706603389;
	bh=T28E1Pxj46DCSwu7JVzEKI2UvDXN/idUv1SombhTsr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FvsBIDWT+Hcp03HitCmns0x4cn+TY0EQG/RSLQ3tcwa9nhhZ9j+4kNw+RPu2li1tD
	 Mfhmy7zg1DKhAryqhZzHM/Bfr8mYLXz1jN2mLroPcjcsg1Iqhq6zvOGWcnDD/mLIXM
	 52606tydRfwQ1ocJLI59tx++5Wp68cDs/gWqPxj3H8F5T22MgAqjAztldSVkuSj1di
	 npdwCy57NDDZ+UOEo0YNf7EjTmzvJiC2wh+nb9fJDvZXm+g8u/GUQENLiazKYHgZO2
	 FDk83KqV3rBM7xohcXvR5PWrWk4dK/3CG+app7IHNtYtGgbjqzpbU4u3rrJVrVm86n
	 qKswvQx8PLj+g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
In-Reply-To: <4e73b095-0c08-4a6f-b2ee-8f7a071b14ee@huaweicloud.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <87lecqobyb.fsf@all.your.base.are.belong.to.us>
 <4e73b095-0c08-4a6f-b2ee-8f7a071b14ee@huaweicloud.com>
Date: Tue, 30 Jan 2024 09:29:46 +0100
Message-ID: <87cytjusud.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2023/9/28 17:59, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>>> the TCC can be propagated from the parent process to the subprocess, but
>>> the TCC of the parent process cannot be restored when the subprocess
>>> exits. Since the RV64 TCC is initialized before saving the callee saved
>>> registers into the stack, we cannot use the callee saved register to
>>> pass the TCC, otherwise the original value of the callee saved register
>>> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>>> similar to x86_64, i.e. using a non-callee saved register to transfer
>>> the TCC between functions, and saving that register to the stack to
>>> protect the TCC value. At the same time, we also consider the scenario
>>> of mixing trampoline.
>>=20
>> Hi!
>>=20
>> The RISC-V JIT tries to minimize the stack usage, e.g. it doesn't have a
>> fixed pro/epilogue like some of the other JITs. I think we can do better
>> here, so that the pass-TCC-via-register can be used, and the additional
>> stack access can be avoided.
>>=20
>> Today, the TCC is passed via a register (a6) and can be viewed as a
>> "state" variable/transparent argument/return value. As you point out, we
>> loose this when we do a call. On (any) calls we move the TCC to a
>> callee-saved register.
>>=20
>> WDYT about the following scheme:
>>=20
>> 1 Pickup the arm64 bpf2bpf/tailmix mechanism of just clearing the TCC
>>    for the main program.
>> 2 For BPF helper calls, move TCC to s6, perform the call, and restore
>>    a6. Dito for kfunc calls (BPF_PSEUDO_KFUNC_CALL).
>> 3 For all other calls, a6 is passed transparently.
>>=20
>> For 2 bpf_jit_get_func_addr() can be used to determine if the callee is
>> a BPF helper or not.
>>=20
>> In summary; Determine in the JIT if we're leaving BPF-land, and need to
>> move the TCC to a callee-saved reg, or not, and save us a bunch of stack
>> store/loads.
>>=20
>
> Valuable scheme. But we need to consider TCC back propagation. Let me=20
> show an example of calling subprog with TCC stored in A6:
>
> prog1(TCC=3D=3D1){
>      subprog1(TCC=3D=3D1)
>          -> tailcall1(TCC=3D=3D0)
>              -> subprog2(TCC=3D=3D0)
>      subprog3(TCC=3D=3D0) <--- should be TCC=3D=3D1
>          -\-> tailcall2 <--- can't be called
> }
>
> We call prog1 and TCC is 1. prog1 has two subprogs, subprog1 and=20
> subprog3. subprog1 calls tailcall1 and TCC become to 0. tailcall1 call=20
> subprog2 and then return to prog1 with TCC is 0. At this time, subprog3=20
> cannot call tailcall2 because TCC is 0. But TCC should be 1 here.

Huh, I'm not following, and I don't see the issue. Help me out! You're
only allowed to do X tail calls "globally" for a BPF context, right? So
in the example you're outlining above, tailcall2 shouldn't be allowed to
be called.


Bj=C3=B6rn

