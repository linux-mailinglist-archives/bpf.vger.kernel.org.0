Return-Path: <bpf+bounces-27954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174DD8B3E43
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C320328801E
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475F16D329;
	Fri, 26 Apr 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd8OAebf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473314AD38;
	Fri, 26 Apr 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152717; cv=none; b=OzYtrXQeYXP/Ivtl4qU3TO8Mbfbr9cRv5am1swcpYquPtUclmaXoYGC3NSy/2FT30y+PWky07S9R440yX2g9fH4EqcJqwkZzZBG+5PCZUvwWmZYjH34qct8048RJjk/7488zur0zzHaGDc561nurj+u2wF8F4llfUHJNodf8bh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152717; c=relaxed/simple;
	bh=x9t1f9uu8hkMcKJtXS3SpXR4y2fJU0AKXJw3M/YJcQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nux0ICt2Vt46OIpcPIGHIzvcmS+fY65JDDLRy8LP1lc2tQ7ZlebT32dXbJaDHIcDh1x1zoI9L0TZnGV3p1i43VgiqMr19cU09NTZ69Hwoteqs4ize5gYzND+yDMBK1CffxYDsZv3AMJJAQhYOq6Z756Njrh2vA8K+BUglAfsmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd8OAebf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so2359140b3a.0;
        Fri, 26 Apr 2024 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714152715; x=1714757515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEAPQcanaPDOn5S3ENkhU/MG1hr6xNnXUr2ClYVvEZ8=;
        b=kd8OAebf9DjpN0kSbT6U/KPZ4BPHYUPfOkfsuXFgJjPBzmOxXuZCrR6e6ltI5rFaI1
         HzeJB0AteEGCuatRH/VLco2uDpMrP+b+zesQ5PxMjrEUHZRY2PjbJK3XTdRenfKBwB55
         RJsN8tRN8MdEyvowWl+2WYlgnHVSrjKygFY/whdHvvemXlNIn9WrynfOqMZAswOwG40p
         1KiHqifpBogkUQs/u55jKPihwJ2B0aOc0tUflZYdTzkln8uRL5+Ws0xItBOP+6KTWTWG
         19dRTL1hX724F13IT9jlKgCdmUyWKyWzjFojjNPPU2MEMgDMn+2fJLZ5DzrRGFQTT4W3
         Oe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152715; x=1714757515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEAPQcanaPDOn5S3ENkhU/MG1hr6xNnXUr2ClYVvEZ8=;
        b=NLRX+5TfVKQLQlG53UGoP52hj3Sx83LbGhqI85TmMixRHiQnOANwnU/At+AR4ACrxz
         LnGfm6j3rVlNDujCg74hiCf+jz0cVcTbOLSkZSaEFRXIOJ8ID9wuHKIDJjRemOtq0+mZ
         a2UB0X7iT5nEzr69g4SQO0fki3XyMwu/dNwl9d78bBJYwdRgioGhYZNz0/JkstduNQbz
         LqDk8jXK7nt36x9xRsVATbJKZoLOB3E7aaSMvARXCqRuK93NyOXb2cXxOX0j9nxteIG1
         jyDGbvAWN2sPt/MklnPgWIgpeSHqg7IX5D25bHmW8m1vsr46XVdnRg1uY2sasi10YCGk
         0OFA==
X-Forwarded-Encrypted: i=1; AJvYcCVErKLlQq6XpAaq1XnljkHflDxlUNKKuTevAmT8LfIUgfylWh03uv4Uo2pZ18Hv6EHSJyASjZcTzQc8fxixPLEIVXowgeVYjlKhepitvvFsD2rKq23mLmqLa7KVGT+2PMRV
X-Gm-Message-State: AOJu0YzSP2CqgV5AVXOnzO7nIgA+uKbRmpnET7OBjLeRk4vxODQX4jTV
	7+MmYaqQaC1UVHyrR/cOQpAYQTpqpqs1PyXibTo6hsitZJk6H6pk/j4U8V4Lz1cDuCACfRsdzXy
	lxqmIWDwuIveX75W1bWPp3CiFr1U=
X-Google-Smtp-Source: AGHT+IFvWL+JOUV8ctu/BNDjw0mfEM/s1UnKMgRhvWfVsmC1vA12D7VNXNkLpT3MTdiMZaeCNDFByDgY8wuL2SktV8g=
X-Received: by 2002:a17:902:ea11:b0:1e3:e093:b5f0 with SMTP id
 s17-20020a170902ea1100b001e3e093b5f0mr3957263plg.8.1714152715525; Fri, 26 Apr
 2024 10:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426121349.97651-1-puranjay@kernel.org> <20240426121349.97651-3-puranjay@kernel.org>
 <CAEf4BzaNM5H3Ad2=Syhhq1cbfuB5FrtuFTZHPTdQP3QME3naKA@mail.gmail.com> <mb61pplucvys4.fsf@kernel.org>
In-Reply-To: <mb61pplucvys4.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 10:31:43 -0700
Message-ID: <CAEf4BzYMqG4KFpjUpEoMQfyWBB3vZ-VcHp9n2=_rhZh9YdrVdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf, arm64: inline bpf_get_smp_processor_id()
 helper
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:06=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Apr 26, 2024 at 5:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inline
> >> bpf_get_smp_processor_id().
> >>
> >> ARM64 uses the per-cpu variable cpu_number to store the cpu id.
> >>
> >> Here is how the BPF and ARM64 JITed assembly changes after this commit=
:
> >>
> >>                                          BPF
> >>                                         =3D=3D=3D=3D=3D
> >>               BEFORE                                       AFTER
> >>              --------                                     -------
> >>
> >> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_=
smp_processor_id();
> >> (85) call bpf_get_smp_processor_id#229032       (18) r0 =3D 0xffff8000=
82072008
> >>                                                 (bf) r0 =3D &(void __p=
ercpu *)(r0)
> >>                                                 (61) r0 =3D *(u32 *)(r=
0 +0)
> >>
> >>                                       ARM64 JIT
> >>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>               BEFORE                                       AFTER
> >>              --------                                     -------
> >>
> >> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_=
smp_processor_id();
> >> mov     x10, #0xfffffffffffff4d0                mov     x7, #0xffff800=
0ffffffff
> >> movk    x10, #0x802b, lsl #16                   movk    x7, #0x8207, l=
sl #16
> >> movk    x10, #0x8000, lsl #32                   movk    x7, #0x2008
> >> blr     x10                                     mrs     x10, tpidr_el1
> >> add     x7, x0, #0x0                            add     x7, x7, x10
> >>                                                 ldr     w7, [x7]
> >>
> >> Performance improvement using benchmark[1]
> >>
> >>              BEFORE                                       AFTER
> >>             --------                                     -------
> >>
> >> glob-arr-inc   :   23.817 =C2=B1 0.019M/s      glob-arr-inc   :   24.6=
31 =C2=B1 0.027M/s
> >> arr-inc        :   23.253 =C2=B1 0.019M/s      arr-inc        :   23.7=
42 =C2=B1 0.023M/s
> >> hash-inc       :   12.258 =C2=B1 0.010M/s      hash-inc       :   12.6=
25 =C2=B1 0.004M/s
> >>
> >> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >> ---
> >>  kernel/bpf/verifier.c | 24 +++++++++++++++++-------
> >>  1 file changed, 17 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 4e474ef44e9c..6ff4e63b2ef2 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -20273,20 +20273,31 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> >>                         goto next_insn;
> >>                 }
> >>
> >> -#ifdef CONFIG_X86_64
> >>                 /* Implement bpf_get_smp_processor_id() inline. */
> >>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
> >>                     prog->jit_requested && bpf_jit_supports_percpu_ins=
n()) {
> >>                         /* BPF_FUNC_get_smp_processor_id inlining is a=
n
> >> -                        * optimization, so if pcpu_hot.cpu_number is =
ever
> >> +                        * optimization, so if cpu_number_addr is ever
> >>                          * changed in some incompatible and hard to su=
pport
> >>                          * way, it's fine to back out this inlining lo=
gic
> >>                          */
> >> -                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)=
(unsigned long)&pcpu_hot.cpu_number);
> >> -                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0=
, BPF_REG_0);
> >> -                       insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, =
BPF_REG_0, 0);
> >> -                       cnt =3D 3;
> >> +                       u64 cpu_number_addr;
> >>
> >> +#if defined(CONFIG_X86_64)
> >> +                       cpu_number_addr =3D (u64)&pcpu_hot.cpu_number;
> >> +#elif defined(CONFIG_ARM64)
> >> +                       cpu_number_addr =3D (u64)&cpu_number;
> >> +#else
> >> +                       goto next_insn;
> >> +#endif
> >> +                       struct bpf_insn ld_cpu_number_addr[2] =3D {
> >> +                               BPF_LD_IMM64(BPF_REG_0, cpu_number_add=
r)
> >> +                       };
> >
> > here we are violating C89 requirement to have a single block of
> > variable declarations by mixing variables and statements. I'm
> > surprised this is not triggering any build errors on !arm64 &&
> > !x86_64.
> >
> > I think we can declare this BPF_LD_IMM64 instruction with zero "addr".
> > And then update
> >
> > ld_cpu_number_addr[0].imm =3D (u32)cpu_number_addr;
> > ld_cpu_number_addr[1].imm =3D (u32)(cpu_number_addr >> 32);
> >
> > WDYT?
> >
> > nit: I'd rename ld_cpu_number_addr to ld_insn or something short like t=
hat
>
> I agree with you,
> What do you think about the following diff:

yep, that's what I had in mind, ack

>
> --- 8< ---
>
> -#ifdef CONFIG_X86_64
>                 /* Implement bpf_get_smp_processor_id() inline. */
>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
>                     prog->jit_requested && bpf_jit_supports_percpu_insn()=
) {
>                         /* BPF_FUNC_get_smp_processor_id inlining is an
> -                        * optimization, so if pcpu_hot.cpu_number is eve=
r
> +                        * optimization, so if cpu_number_addr is ever
>                          * changed in some incompatible and hard to suppo=
rt
>                          * way, it's fine to back out this inlining logic
>                          */
> -                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(un=
signed long)&pcpu_hot.cpu_number);
> -                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> -                       insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
> -                       cnt =3D 3;
> +                       u64 cpu_number_addr;
> +                       struct bpf_insn ld_insn[2] =3D {
> +                               BPF_LD_IMM64(BPF_REG_0, 0)
> +                       };
> +
> +#if defined(CONFIG_X86_64)
> +                       cpu_number_addr =3D (u64)&pcpu_hot.cpu_number;
> +#elif defined(CONFIG_ARM64)
> +                       cpu_number_addr =3D (u64)&cpu_number;
> +#else
> +                       goto next_insn;
> +#endif
> +                       ld_insn[0].imm =3D (u32)cpu_number_addr;
> +                       ld_insn[1].imm =3D (u32)(cpu_number_addr >> 32);
> +                       insn_buf[0] =3D ld_insn[0];
> +                       insn_buf[1] =3D ld_insn[1];
> +                       insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> +                       insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
> +                       cnt =3D 4;
>
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
>                         if (!new_prog)
> @@ -20296,7 +20310,6 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                         insn      =3D new_prog->insnsi + i + delta;
>                         goto next_insn;
>                 }
> -#endif
>                 /* Implement bpf_get_func_arg inline. */
>
> --- >8---
>
> Thanks,
> Puranjay

