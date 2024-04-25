Return-Path: <bpf+bounces-27800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C8A8B1EE4
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65CEB29553
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FA386243;
	Thu, 25 Apr 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnmu7iQh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148682E647;
	Thu, 25 Apr 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040070; cv=none; b=F6vtE3azVk3DCO6ojz1RlM+hkL0VT2m2jYmzX2xLgaYHKl3ZZMRkEuzNmLryeH5+ftkTBhLzNfC/J7xiySeJcIoiyPZ+fMOnVUbVD/M+AuzQkmgQ7d635GmGdvnoLaaq71G/RdiVk8baAIHw4/KN2hrqoCjdECLQBu+ah8BNToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040070; c=relaxed/simple;
	bh=yzEXhICXLlf+DKeiLzF5a0M6Y4JEBguOjBtSKPO2DvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+H7IeZ0z3NaceHEd9s+6TQFyclw9QzRuK+zZa/2HaL6HiQwUj9LZuZ81rhPznnoPQfuy4VRVUdEH/S0PpcOjeVwuwnwOhOv2MCJkutBHIg/yrRL/NMwI2mLu6gc7wEscE1agAQJQKFkPHaQRPVvkiclquml2ehTW4ikZvO4ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnmu7iQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507CEC113CC;
	Thu, 25 Apr 2024 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714040069;
	bh=yzEXhICXLlf+DKeiLzF5a0M6Y4JEBguOjBtSKPO2DvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nnmu7iQhIvbXI1vZWEhJwaUmzbMwcLal9wtRhydM7LjPI0yQbA+l1eqYFzsRZlSyN
	 epdEMYSzfyxkiLiuTSy53EeEjRNcCSyuukvf+4Pu1dqwc1VXT/okoTX8wLS4JQyAFs
	 EtdDoFDtzh95YvQ+ZpaQJxm9FVJzpgOQdEg5U9dAZCPA2SgjeB1JYl/fWe8IdNxQ9y
	 MDKrqtrFINEHzfTkCw47EPx9Y8eI2XiniH32KQtUgEvCsUUP0lgr+tCdMRfxDcRBVJ
	 /+4X+HSFSn9G1ZL4LFhKZuJb7qee68aBz9kZMUZHaEa2dYPIl0xkLc/ALxjI1mwqmU
	 sSl0kAh9ryGzQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai
 <xukuohai@huawei.com>, Florent Revest <revest@chromium.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] bpf, arm64: inline
 bpf_get_smp_processor_id() helper
In-Reply-To: <CAEf4BzZOFye13KdBUKA7E=41NVNy5fOzF3bxFzaeZAzkq0kh-w@mail.gmail.com>
References: <20240424173550.16359-1-puranjay@kernel.org>
 <20240424173550.16359-3-puranjay@kernel.org>
 <CAEf4BzZOFye13KdBUKA7E=41NVNy5fOzF3bxFzaeZAzkq0kh-w@mail.gmail.com>
Date: Thu, 25 Apr 2024 10:14:26 +0000
Message-ID: <mb61pwmollpfh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Apr 24, 2024 at 10:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
>>
>> As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inline
>> bpf_get_smp_processor_id().
>>
>> ARM64 uses the per-cpu variable cpu_number to store the cpu id.
>>
>> Here is how the BPF and ARM64 JITed assembly changes after this commit:
>>
>>                                          BPF
>>                                         =3D=3D=3D=3D=3D
>>               BEFORE                                       AFTER
>>              --------                                     -------
>>
>> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_sm=
p_processor_id();
>> (85) call bpf_get_smp_processor_id#229032       (18) r0 =3D 0xffff800082=
072008
>>                                                 (bf) r0 =3D r0
>
> nit: hmm, you are probably using a bit outdated bpftool, it should be
> emitted as:
>
> (bf) r0 =3D &(void __percpu *)(r0)

Yes, I was using the bpftool shipped with the distro. I tried it again
with the latest bpftool and it emitted this as expected.

>
>>                                                 (61) r0 =3D *(u32 *)(r0 =
+0)
>>
>>                                       ARM64 JIT
>>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>               BEFORE                                       AFTER
>>              --------                                     -------
>>
>> int cpu =3D bpf_get_smp_processor_id();      int cpu =3D bpf_get_smp_pro=
cessor_id();
>> mov     x10, #0xfffffffffffff4d0           mov     x7, #0xffff8000ffffff=
ff
>> movk    x10, #0x802b, lsl #16              movk    x7, #0x8207, lsl #16
>> movk    x10, #0x8000, lsl #32              movk    x7, #0x2008
>> blr     x10                                mrs     x10, tpidr_el1
>> add     x7, x0, #0x0                       add     x7, x7, x10
>>                                            ldr     w7, [x7]
>>
>> Performance improvement using benchmark[1]
>>
>>              BEFORE                                       AFTER
>>             --------                                     -------
>>
>> glob-arr-inc   :   23.817 =C2=B1 0.019M/s      glob-arr-inc   :   24.631=
 =C2=B1 0.027M/s
>> arr-inc        :   23.253 =C2=B1 0.019M/s      arr-inc        :   23.742=
 =C2=B1 0.023M/s
>> hash-inc       :   12.258 =C2=B1 0.010M/s      hash-inc       :   12.625=
 =C2=B1 0.004M/s
>>
>> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  kernel/bpf/verifier.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>
> Besides the nits, lgtm.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9715c88cc025..3373be261889 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20205,7 +20205,7 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>>                         goto next_insn;
>>                 }
>>
>> -#ifdef CONFIG_X86_64
>> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
>
> I think you can drop this, we are protected by
> bpf_jit_supports_percpu_insn() check and newly added inner #if/#elif
> checks?

If I remove this and later add support of percpu_insn on RISCV without
inlining bpf_get_smp_processor_id() then it will cause problems here
right? because then the last 5-6 lines inside this if(){} will be
executed for RISCV.

>
>>                 /* Implement bpf_get_smp_processor_id() inline. */
>>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
>>                     prog->jit_requested && bpf_jit_supports_percpu_insn(=
)) {
>> @@ -20214,11 +20214,20 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
>>                          * changed in some incompatible and hard to supp=
ort
>>                          * way, it's fine to back out this inlining logic
>>                          */
>> +#if defined(CONFIG_X86_64)
>>                         insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(u=
nsigned long)&pcpu_hot.cpu_number);
>>                         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, =
BPF_REG_0);
>>                         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BP=
F_REG_0, 0);
>>                         cnt =3D 3;
>> +#elif defined(CONFIG_ARM64)
>> +                       struct bpf_insn cpu_number_addr[2] =3D { BPF_LD_=
IMM64(BPF_REG_0, (u64)&cpu_number) };
>>
>
> this &cpu_number offset is not guaranteed to be within 4GB on arm64?

Unfortunately, the per-cpu section is not placed in the first 4GB and
therefore the per-cpu pointers are not 32-bit on ARM64.

>
>> +                       insn_buf[0] =3D cpu_number_addr[0];
>> +                       insn_buf[1] =3D cpu_number_addr[1];
>> +                       insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, =
BPF_REG_0);
>> +                       insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BP=
F_REG_0, 0);
>> +                       cnt =3D 4;
>> +#endif
>>                         new_prog =3D bpf_patch_insn_data(env, i + delta,=
 insn_buf, cnt);
>>                         if (!new_prog)
>>                                 return -ENOMEM;
>> --
>> 2.40.1
>>

