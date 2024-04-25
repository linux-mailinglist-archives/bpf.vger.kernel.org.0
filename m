Return-Path: <bpf+bounces-27844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C08B288F
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CBA286275
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A7814F116;
	Thu, 25 Apr 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe1J7qyi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769414E2CC;
	Thu, 25 Apr 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071361; cv=none; b=OUiSpoquanK9MtcAPAZrZnzMx2DTEhrZ8Zv/8PlgXYo4NvCjkTYL28ATengC5Ht3e+6gIcYYZJK4NdS+EAQ6Qm+X/aXYAjdIZR0hUla75P0iQKk+jKpgoVdsThqBpNWPqowQ3TvX8SGd08LMZC4llp1ULzFNvy6G+BMX+ywb+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071361; c=relaxed/simple;
	bh=gvIDnW7fKA4/z8SLEzwxKjbQ9fFnFV+k80e9QAEvWGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lABSdxKyMDZQ8VeK2cNf6oSHanc98OVAdRwcvEm/VQgikYQVb3stTf0XpDdV5PL0xtSkauAh6Gaaie5bEyzGDZ+ihN1VqikAncEdUWpA3GzpoloTM1f23EnKPMqo2B3rD0qqs5edwoPkMGh/dMGf45eI3ncpsx7M3MXEtjY7raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe1J7qyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B7FC113CC;
	Thu, 25 Apr 2024 18:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714071361;
	bh=gvIDnW7fKA4/z8SLEzwxKjbQ9fFnFV+k80e9QAEvWGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Xe1J7qyi6penA0+QjEJfPnHXZtcAtYz5H/gGP9JX3jQzpnm9EeogB2YXxHB7ad6kv
	 sGq0ya2XMskzTwrT4gF+wcKE8ZLHr42r2a71TfTKWXyT77rV2233mgMBT9Q3L0DL05
	 6CrKXi9k612/HZHQ2uksL2a+FrzzxYtW9W/Mkx8w+TmpIXwzgMOS/0SpgGnQeyjW+H
	 i3bNTxjIFYrUYVvYyShDeRSw1PNqywS0u9TtXn6kLgUPBkETi9Ec8ZfDrr8G/GNWRh
	 Vg6eSpBZNf+jYmxDXxSYDbDqwzXEY0YVspYYRMZcfJpwMN7YUiG8YmZu9LgafGws/o
	 auDGF8endPQCA==
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
In-Reply-To: <CAEf4BzZe-rtewAvDeNwqoud+x+fTraiLM1mzdvae_5yNrWsWyg@mail.gmail.com>
References: <20240424173550.16359-1-puranjay@kernel.org>
 <20240424173550.16359-3-puranjay@kernel.org>
 <CAEf4BzZOFye13KdBUKA7E=41NVNy5fOzF3bxFzaeZAzkq0kh-w@mail.gmail.com>
 <mb61pwmollpfh.fsf@kernel.org>
 <CAEf4BzZe-rtewAvDeNwqoud+x+fTraiLM1mzdvae_5yNrWsWyg@mail.gmail.com>
Date: Thu, 25 Apr 2024 18:55:56 +0000
Message-ID: <mb61po79x9sqr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Apr 25, 2024 at 3:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Wed, Apr 24, 2024 at 10:36=E2=80=AFAM Puranjay Mohan <puranjay@kern=
el.org> wrote:
>> >>
>> >> As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inline
>> >> bpf_get_smp_processor_id().
>> >>
>> >> ARM64 uses the per-cpu variable cpu_number to store the cpu id.
>> >>
>> >> Here is how the BPF and ARM64 JITed assembly changes after this commi=
t:
>> >>
>> >>                                          BPF
>> >>                                         =3D=3D=3D=3D=3D
>> >>               BEFORE                                       AFTER
>> >>              --------                                     -------
>> >>
>> >> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get=
_smp_processor_id();
>> >> (85) call bpf_get_smp_processor_id#229032       (18) r0 =3D 0xffff800=
082072008
>> >>                                                 (bf) r0 =3D r0
>> >
>> > nit: hmm, you are probably using a bit outdated bpftool, it should be
>> > emitted as:
>> >
>> > (bf) r0 =3D &(void __percpu *)(r0)
>>
>> Yes, I was using the bpftool shipped with the distro. I tried it again
>> with the latest bpftool and it emitted this as expected.
>
> Cool, would be nice to update the commit message with the right syntax
> for next revision, thanks!
>

Sure, will do.

>>
>> >
>> >>                                                 (61) r0 =3D *(u32 *)(=
r0 +0)
>> >>
>> >>                                       ARM64 JIT
>> >>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>
>> >>               BEFORE                                       AFTER
>> >>              --------                                     -------
>> >>
>> >> int cpu =3D bpf_get_smp_processor_id();      int cpu =3D bpf_get_smp_=
processor_id();
>> >> mov     x10, #0xfffffffffffff4d0           mov     x7, #0xffff8000fff=
fffff
>> >> movk    x10, #0x802b, lsl #16              movk    x7, #0x8207, lsl #=
16
>> >> movk    x10, #0x8000, lsl #32              movk    x7, #0x2008
>> >> blr     x10                                mrs     x10, tpidr_el1
>> >> add     x7, x0, #0x0                       add     x7, x7, x10
>> >>                                            ldr     w7, [x7]
>> >>
>> >> Performance improvement using benchmark[1]
>> >>
>> >>              BEFORE                                       AFTER
>> >>             --------                                     -------
>> >>
>> >> glob-arr-inc   :   23.817 =C2=B1 0.019M/s      glob-arr-inc   :   24.=
631 =C2=B1 0.027M/s
>> >> arr-inc        :   23.253 =C2=B1 0.019M/s      arr-inc        :   23.=
742 =C2=B1 0.023M/s
>> >> hash-inc       :   12.258 =C2=B1 0.010M/s      hash-inc       :   12.=
625 =C2=B1 0.004M/s
>> >>
>> >> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>> >>
>> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> >> ---
>> >>  kernel/bpf/verifier.c | 11 ++++++++++-
>> >>  1 file changed, 10 insertions(+), 1 deletion(-)
>> >>
>> >
>> > Besides the nits, lgtm.
>> >
>> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> >
>> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> >> index 9715c88cc025..3373be261889 100644
>> >> --- a/kernel/bpf/verifier.c
>> >> +++ b/kernel/bpf/verifier.c
>> >> @@ -20205,7 +20205,7 @@ static int do_misc_fixups(struct bpf_verifier=
_env *env)
>> >>                         goto next_insn;
>> >>                 }
>> >>
>> >> -#ifdef CONFIG_X86_64
>> >> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
>> >
>> > I think you can drop this, we are protected by
>> > bpf_jit_supports_percpu_insn() check and newly added inner #if/#elif
>> > checks?
>>
>> If I remove this and later add support of percpu_insn on RISCV without
>> inlining bpf_get_smp_processor_id() then it will cause problems here
>> right? because then the last 5-6 lines inside this if(){} will be
>> executed for RISCV.
>
> Just add
>
> #else
> return -EFAULT;

I don't think we can return.

> #endif
>
> ?
>
> I'm trying to avoid this duplication of the defined(CONFIG_xxx) checks
> for supported architectures.

Does the following look correct?

I will do it like this:

                /* Implement bpf_get_smp_processor_id() inline. */
                if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
                    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
                        /* BPF_FUNC_get_smp_processor_id inlining is an
                         * optimization, so if pcpu_hot.cpu_number is ever
                         * changed in some incompatible and hard to support
                         * way, it's fine to back out this inlining logic
                         */
#if defined(CONFIG_X86_64)
                        insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(unsi=
gned long)&pcpu_hot.cpu_number);
                        insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF=
_REG_0);
                        insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_R=
EG_0, 0);
                        cnt =3D 3;
#elif defined(CONFIG_ARM64)
                        struct bpf_insn cpu_number_addr[2] =3D { BPF_LD_IMM=
64(BPF_REG_0, (u64)&cpu_number) };

                        insn_buf[0] =3D cpu_number_addr[0];
                        insn_buf[1] =3D cpu_number_addr[1];
                        insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF=
_REG_0);
                        insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_R=
EG_0, 0);
                        cnt =3D 4;
#else
                        goto next_insn;
#endif
                        new_prog =3D bpf_patch_insn_data(env, i + delta, in=
sn_buf, cnt);
                        if (!new_prog)
                                return -ENOMEM;

                        delta    +=3D cnt - 1;
                        env->prog =3D prog =3D new_prog;
                        insn      =3D new_prog->insnsi + i + delta;
                        goto next_insn;
                }


>>
>> >
>> >>                 /* Implement bpf_get_smp_processor_id() inline. */
>> >>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
>> >>                     prog->jit_requested && bpf_jit_supports_percpu_in=
sn()) {
>> >> @@ -20214,11 +20214,20 @@ static int do_misc_fixups(struct bpf_verifi=
er_env *env)
>> >>                          * changed in some incompatible and hard to s=
upport
>> >>                          * way, it's fine to back out this inlining l=
ogic
>> >>                          */
>> >> +#if defined(CONFIG_X86_64)
>> >>                         insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32=
)(unsigned long)&pcpu_hot.cpu_number);
>> >>                         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_=
0, BPF_REG_0);
>> >>                         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0,=
 BPF_REG_0, 0);
>> >>                         cnt =3D 3;
>> >> +#elif defined(CONFIG_ARM64)
>> >> +                       struct bpf_insn cpu_number_addr[2] =3D { BPF_=
LD_IMM64(BPF_REG_0, (u64)&cpu_number) };
>> >>
>> >
>> > this &cpu_number offset is not guaranteed to be within 4GB on arm64?
>>
>> Unfortunately, the per-cpu section is not placed in the first 4GB and
>> therefore the per-cpu pointers are not 32-bit on ARM64.
>
> I see. It might make sense to turn x86-64 code into using MOV64_IMM as
> well to keep more of the logic common. Then it will be just the
> difference of an offset that's loaded. Give it a try?

I think MOV64_IMM would have more overhead than MOV32_IMM and if we can
use it in x86-64 we should keep doing it that way. Wdyt?=20

>>
>> >
>> >> +                       insn_buf[0] =3D cpu_number_addr[0];
>> >> +                       insn_buf[1] =3D cpu_number_addr[1];
>> >> +                       insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_=
0, BPF_REG_0);
>> >> +                       insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0,=
 BPF_REG_0, 0);
>> >> +                       cnt =3D 4;
>> >> +#endif
>> >>                         new_prog =3D bpf_patch_insn_data(env, i + del=
ta, insn_buf, cnt);
>> >>                         if (!new_prog)
>> >>                                 return -ENOMEM;
>> >> --
>> >> 2.40.1
>> >>

