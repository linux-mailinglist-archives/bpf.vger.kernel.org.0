Return-Path: <bpf+bounces-27834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA88B27E6
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B7D1F21964
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1607314EC78;
	Thu, 25 Apr 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQd1vIFv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3824C14EC41;
	Thu, 25 Apr 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068577; cv=none; b=Y1I7VYoy+on2i4s0xzWLa0sDcnnZjJQpF6xjFu0YQro8EOVoJ8ZAe1ZtRIgeiCfbVS+6a1hFdfSiCaWqcF2M8vuW2AMwAUbtnoTThQMGATVDnTew32CXKU5ASW9L163mQbkCp8w9LzHOhHtpLvSTFYGWqT8QBQXubk5aajVuxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068577; c=relaxed/simple;
	bh=FhVxwyldaMWlZYLBUnistSextrhu2pSDcd1+kY++dfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwIOu10gWKwtBTSvQA7MxrRkno+CPA7NNYAMUvyxxCB06FVxVdEl8Xn4ECbonXhMLTrkpAQM6TWyn5sX5uq/iMvg+88eGZWHu4B4eN/NkqsXP/AUvvGJMYM0gOnhTlS+uktO41IyLT0OcpMEb1Zept56RQiAC7Z2JKt/wXdmHOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQd1vIFv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-60c49bdbcd3so232988a12.0;
        Thu, 25 Apr 2024 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068575; x=1714673375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUfRY8/TaMSQGOdro4l4cqF/rmzCcmj41uoC+1ic+Ok=;
        b=EQd1vIFvHmDKphKqo6Mcf2rZu2Kq9RYgDs7mEby49ACFOltugioj7WWBZhM7T8WK1n
         /PJaZ6Bmmxi7UtqAf0PFO2Ww0Ye1nX0bjsvRR+5FCbCTdXBhWQiCVzEYgC4g6MFVICXi
         ETywf4dAb8fllVeDUQ0gt5yDtIFSi4D3E/dJzVHIPYTk75SYdMEWnN5fsKB2gMWw1aMl
         8qaqA7egIqrvWemGaAzxaMdXuzkgPXmVeDEyrGb85iUTfU0ANumYUr/ksO5qgB1KoNMZ
         9rXJ1w8AWxIEybBkaO/7UK8y4TomhAHTElgxLRQaBqB2IT3QxMVep9HbJhyPRhrG6UXM
         qg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068575; x=1714673375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUfRY8/TaMSQGOdro4l4cqF/rmzCcmj41uoC+1ic+Ok=;
        b=V2LB3DAdL1Oe8z6sjh+53wx2RRbHZfpQyKUjMd1AxKqaOV2IK6zOksTxLN/e6fPMuO
         Vh+cgBjNbeiENhiBG/DYYlbEzlI0Nnpvk07r/c5wPLgv0HP9jImZQS/4MGfE5x/p+ioG
         Kgku/A63DCzBtFb6Cm85InHt3LhSMMghRxlPE1vUHs9TeqMfpGq6SYrxVWQp42ZmYreT
         WcNiphPbYV05L0wTnKTmU6ab3/9cgugNKh4kf+f8DX+QDYfsnoKl+yBl12F4SFlNVAAf
         HT2boEEzt14Z6n4ckUXebYgtlzS4USvOrdWIYCLN2X58L+AAw5+ISjkY73/9D6afpFmC
         hc0g==
X-Forwarded-Encrypted: i=1; AJvYcCVrsw7a5xQFixIBCTRP+RhW7Gu8IQsSNkDLjX2Vm9DkuRmwvwvX3Ku6ictBekGJaw2Rw4L6lyi7N+VBsgCZJgHHIzjwJdI/9pTDtttHEEg2py2MXz1cGefsU3QRiRcuCgjX
X-Gm-Message-State: AOJu0YxE+tgO8WOQ74lSldlpRouoQZ94sIiiBPL8rlirGDwFuM6S/sm4
	bFdtUVzIvFypcyEZub9glkdH3r2OZDGV8umIVkG9mVsMo4bv1lzZFyyZ6J5MYu2Fdfa6h/HWBzY
	sRuf0/wImPzor8VxfEeJVnaCDg+Y=
X-Google-Smtp-Source: AGHT+IERtmVp/J4RZmIh0Y0EeCkMv13DDFY63xTjl+xUm6xUiLeDA8FsZ0Plm8JxhWGCdEhGBrYOwKlABEDs5M0jJCs=
X-Received: by 2002:a17:90b:3446:b0:2ad:be01:6bb9 with SMTP id
 lj6-20020a17090b344600b002adbe016bb9mr324227pjb.48.1714068575425; Thu, 25 Apr
 2024 11:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424173550.16359-1-puranjay@kernel.org> <20240424173550.16359-3-puranjay@kernel.org>
 <CAEf4BzZOFye13KdBUKA7E=41NVNy5fOzF3bxFzaeZAzkq0kh-w@mail.gmail.com> <mb61pwmollpfh.fsf@kernel.org>
In-Reply-To: <mb61pwmollpfh.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 11:09:22 -0700
Message-ID: <CAEf4BzZe-rtewAvDeNwqoud+x+fTraiLM1mzdvae_5yNrWsWyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, arm64: inline bpf_get_smp_processor_id()
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

On Thu, Apr 25, 2024 at 3:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Wed, Apr 24, 2024 at 10:36=E2=80=AFAM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
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
> >>                                                 (bf) r0 =3D r0
> >
> > nit: hmm, you are probably using a bit outdated bpftool, it should be
> > emitted as:
> >
> > (bf) r0 =3D &(void __percpu *)(r0)
>
> Yes, I was using the bpftool shipped with the distro. I tried it again
> with the latest bpftool and it emitted this as expected.

Cool, would be nice to update the commit message with the right syntax
for next revision, thanks!

>
> >
> >>                                                 (61) r0 =3D *(u32 *)(r=
0 +0)
> >>
> >>                                       ARM64 JIT
> >>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>               BEFORE                                       AFTER
> >>              --------                                     -------
> >>
> >> int cpu =3D bpf_get_smp_processor_id();      int cpu =3D bpf_get_smp_p=
rocessor_id();
> >> mov     x10, #0xfffffffffffff4d0           mov     x7, #0xffff8000ffff=
ffff
> >> movk    x10, #0x802b, lsl #16              movk    x7, #0x8207, lsl #1=
6
> >> movk    x10, #0x8000, lsl #32              movk    x7, #0x2008
> >> blr     x10                                mrs     x10, tpidr_el1
> >> add     x7, x0, #0x0                       add     x7, x7, x10
> >>                                            ldr     w7, [x7]
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
> >> ---
> >>  kernel/bpf/verifier.c | 11 ++++++++++-
> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >
> > Besides the nits, lgtm.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 9715c88cc025..3373be261889 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -20205,7 +20205,7 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >>                         goto next_insn;
> >>                 }
> >>
> >> -#ifdef CONFIG_X86_64
> >> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> >
> > I think you can drop this, we are protected by
> > bpf_jit_supports_percpu_insn() check and newly added inner #if/#elif
> > checks?
>
> If I remove this and later add support of percpu_insn on RISCV without
> inlining bpf_get_smp_processor_id() then it will cause problems here
> right? because then the last 5-6 lines inside this if(){} will be
> executed for RISCV.

Just add

#else
return -EFAULT;
#endif

?

I'm trying to avoid this duplication of the defined(CONFIG_xxx) checks
for supported architectures.

>
> >
> >>                 /* Implement bpf_get_smp_processor_id() inline. */
> >>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
> >>                     prog->jit_requested && bpf_jit_supports_percpu_ins=
n()) {
> >> @@ -20214,11 +20214,20 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> >>                          * changed in some incompatible and hard to su=
pport
> >>                          * way, it's fine to back out this inlining lo=
gic
> >>                          */
> >> +#if defined(CONFIG_X86_64)
> >>                         insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)=
(unsigned long)&pcpu_hot.cpu_number);
> >>                         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0=
, BPF_REG_0);
> >>                         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, =
BPF_REG_0, 0);
> >>                         cnt =3D 3;
> >> +#elif defined(CONFIG_ARM64)
> >> +                       struct bpf_insn cpu_number_addr[2] =3D { BPF_L=
D_IMM64(BPF_REG_0, (u64)&cpu_number) };
> >>
> >
> > this &cpu_number offset is not guaranteed to be within 4GB on arm64?
>
> Unfortunately, the per-cpu section is not placed in the first 4GB and
> therefore the per-cpu pointers are not 32-bit on ARM64.

I see. It might make sense to turn x86-64 code into using MOV64_IMM as
well to keep more of the logic common. Then it will be just the
difference of an offset that's loaded. Give it a try?

>
> >
> >> +                       insn_buf[0] =3D cpu_number_addr[0];
> >> +                       insn_buf[1] =3D cpu_number_addr[1];
> >> +                       insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0=
, BPF_REG_0);
> >> +                       insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, =
BPF_REG_0, 0);
> >> +                       cnt =3D 4;
> >> +#endif
> >>                         new_prog =3D bpf_patch_insn_data(env, i + delt=
a, insn_buf, cnt);
> >>                         if (!new_prog)
> >>                                 return -ENOMEM;
> >> --
> >> 2.40.1
> >>

