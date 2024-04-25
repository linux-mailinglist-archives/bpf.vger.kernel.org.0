Return-Path: <bpf+bounces-27859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C878B2A05
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 22:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E479B24BBE
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7BC153BFF;
	Thu, 25 Apr 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5ZeiFT4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56315381B;
	Thu, 25 Apr 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077825; cv=none; b=G89dwNuTNbmwGJvEvVV3OelI7f4CR9wi9JSiAV5mNw0KdTxlPXoyKKy2mVRYib/Jss5D7lnmkxILstwcrVKTvVfZBTkqBteMt0NZVaNSnFFaUi5m6nwScGAUaNa1KvIGQ1n6tcQqFO8CyT+G1A6EhMI+gWLwzRBWm63slNy4+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077825; c=relaxed/simple;
	bh=SQ00Biuzgi8ooOKmj4SDQQLUJ9vx5PPWa/yT4EKopUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJT9rP+8BSlGqU/HJTJNRKUHQWT6a27kwxgt58ULIA7AqBvcf9qMc8AkdN6S4IoPehU0kukcnbwIDmOv7LO8ulDlrn2NMhGa8p3EWq0G4emLcfSdNFL9dEbSocrb+lIDhsVSd5GNeTK+HygOpYdX32mc3q77zUS3H7UojGdPSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5ZeiFT4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5e152c757a5so973354a12.2;
        Thu, 25 Apr 2024 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714077823; x=1714682623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gI9GtX2kU2O+gI3EzYjJFlSgaBQf6k4DIS3uLiY3BU=;
        b=J5ZeiFT4KOLnAaQnP1QEHH/ltoWHfneGQLSMvzJfz7pTsV4W7ZKeIHZCznoMv5WFlU
         HPeeTBPSldcZTAA5XzggZemaEmR4adsdTbMLLqzpkY/67QXiyPwKaEMwJnxTdsvv3uNC
         JsCAvTC6h2eIv6XAN4iz2x5CXYV4yo/Qo6UjwmsAM/DBa/6bvFN6kc+dFsoC2mn/fDx2
         RuGe1NRUhdPyfZ4p47n1LWxDc6ebobJimNAclByfQCNHUNNrT7lAu802NhQbtQ0gks0Z
         y0blGYNZzvyGJNPmEYZ4SUXOi4HsEtyy/WE0u9nxugbj4Xp0Al8GqB6QMko62Nb00B/E
         OJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077823; x=1714682623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gI9GtX2kU2O+gI3EzYjJFlSgaBQf6k4DIS3uLiY3BU=;
        b=jKJEB4E2FpiiPTa7J/zFVYJK90FLi4s8GG+IEjnD89k2qdzWpTlq7NfJZBfbO4H91g
         ShHmjyFqkN2W1u+6GCf/7b+rwu/H6ZTP5jbP7A0PRVPAZDvK0Aso1ttKPJFFCVfHDcS5
         D8hpSvjBCvfOgwBx+/cyweCoHmsWnDwBSrtSEU8CkFAWhqhWAjaSJZA76vwajKeexvah
         qXJ7IXVrjXPLFVu5cgwgA/1nhFCxOUsnnxDjlyFJ8NTBwXDLoXiAoyXWARIklXbMGmeu
         IAFpyryhHmqUNHpKquTpd9vPfcU/4FJveiY5Vwi4ym8Fqjvj/KakHyzgd8XyyqgLTKBO
         VdWw==
X-Forwarded-Encrypted: i=1; AJvYcCUliVTy9cpglN4G4OJ6EEF//fTqfOJ/mYhrW5AFjKjQ3gDZoitOE41/f4MrdVAXD5px53SBo15Gg4HoAj+f+cNOxRfogsxpN4ZcNgn+fmOa8YXNvIpyVpeY5n75BmugLBWz
X-Gm-Message-State: AOJu0YxKxcOHVI4lWqmLnQNJZalrm4Z/h4vcJ86xug0bLHVw39SE27Ym
	JahX1oGxFfzajtNxNWlGduVS3N/5eyhKgYELebh/20EzYpi4Q1p6x/ZyAkiZZWOTg4uiOQ6Ptfd
	47/n/bX0J1uzJ/pZNgu2nTUfS7ok=
X-Google-Smtp-Source: AGHT+IFTFS8ouyJ8nLmy+93w5RtLBwRt63tqP78ViX1kn334RBkekxMginP1hbtj1x9tbPoLxWGu1XDSuDtNLzlHmj0=
X-Received: by 2002:a17:90a:7895:b0:2aa:e719:3901 with SMTP id
 x21-20020a17090a789500b002aae7193901mr777681pjk.20.1714077823135; Thu, 25 Apr
 2024 13:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424173550.16359-1-puranjay@kernel.org> <20240424173550.16359-3-puranjay@kernel.org>
 <CAEf4BzZOFye13KdBUKA7E=41NVNy5fOzF3bxFzaeZAzkq0kh-w@mail.gmail.com>
 <mb61pwmollpfh.fsf@kernel.org> <CAEf4BzZe-rtewAvDeNwqoud+x+fTraiLM1mzdvae_5yNrWsWyg@mail.gmail.com>
 <mb61po79x9sqr.fsf@kernel.org>
In-Reply-To: <mb61po79x9sqr.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 13:43:31 -0700
Message-ID: <CAEf4BzbxehG2_K8=xqfOdB4_FGVfdO3qaFMhQpvsc5JZg=NkUg@mail.gmail.com>
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

On Thu, Apr 25, 2024 at 11:56=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Thu, Apr 25, 2024 at 3:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Wed, Apr 24, 2024 at 10:36=E2=80=AFAM Puranjay Mohan <puranjay@ke=
rnel.org> wrote:
> >> >>
> >> >> As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inlin=
e
> >> >> bpf_get_smp_processor_id().
> >> >>
> >> >> ARM64 uses the per-cpu variable cpu_number to store the cpu id.
> >> >>
> >> >> Here is how the BPF and ARM64 JITed assembly changes after this com=
mit:
> >> >>
> >> >>                                          BPF
> >> >>                                         =3D=3D=3D=3D=3D
> >> >>               BEFORE                                       AFTER
> >> >>              --------                                     -------
> >> >>
> >> >> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_g=
et_smp_processor_id();
> >> >> (85) call bpf_get_smp_processor_id#229032       (18) r0 =3D 0xffff8=
00082072008
> >> >>                                                 (bf) r0 =3D r0
> >> >
> >> > nit: hmm, you are probably using a bit outdated bpftool, it should b=
e
> >> > emitted as:
> >> >
> >> > (bf) r0 =3D &(void __percpu *)(r0)
> >>
> >> Yes, I was using the bpftool shipped with the distro. I tried it again
> >> with the latest bpftool and it emitted this as expected.
> >
> > Cool, would be nice to update the commit message with the right syntax
> > for next revision, thanks!
> >
>
> Sure, will do.
>
> >>
> >> >
> >> >>                                                 (61) r0 =3D *(u32 *=
)(r0 +0)
> >> >>
> >> >>                                       ARM64 JIT
> >> >>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> >>
> >> >>               BEFORE                                       AFTER
> >> >>              --------                                     -------
> >> >>
> >> >> int cpu =3D bpf_get_smp_processor_id();      int cpu =3D bpf_get_sm=
p_processor_id();
> >> >> mov     x10, #0xfffffffffffff4d0           mov     x7, #0xffff8000f=
fffffff
> >> >> movk    x10, #0x802b, lsl #16              movk    x7, #0x8207, lsl=
 #16
> >> >> movk    x10, #0x8000, lsl #32              movk    x7, #0x2008
> >> >> blr     x10                                mrs     x10, tpidr_el1
> >> >> add     x7, x0, #0x0                       add     x7, x7, x10
> >> >>                                            ldr     w7, [x7]
> >> >>
> >> >> Performance improvement using benchmark[1]
> >> >>
> >> >>              BEFORE                                       AFTER
> >> >>             --------                                     -------
> >> >>
> >> >> glob-arr-inc   :   23.817 =C2=B1 0.019M/s      glob-arr-inc   :   2=
4.631 =C2=B1 0.027M/s
> >> >> arr-inc        :   23.253 =C2=B1 0.019M/s      arr-inc        :   2=
3.742 =C2=B1 0.023M/s
> >> >> hash-inc       :   12.258 =C2=B1 0.010M/s      hash-inc       :   1=
2.625 =C2=B1 0.004M/s
> >> >>
> >> >> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
> >> >>
> >> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> >> ---
> >> >>  kernel/bpf/verifier.c | 11 ++++++++++-
> >> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> >> >>
> >> >
> >> > Besides the nits, lgtm.
> >> >
> >> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >> >
> >> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> >> index 9715c88cc025..3373be261889 100644
> >> >> --- a/kernel/bpf/verifier.c
> >> >> +++ b/kernel/bpf/verifier.c
> >> >> @@ -20205,7 +20205,7 @@ static int do_misc_fixups(struct bpf_verifi=
er_env *env)
> >> >>                         goto next_insn;
> >> >>                 }
> >> >>
> >> >> -#ifdef CONFIG_X86_64
> >> >> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> >> >
> >> > I think you can drop this, we are protected by
> >> > bpf_jit_supports_percpu_insn() check and newly added inner #if/#elif
> >> > checks?
> >>
> >> If I remove this and later add support of percpu_insn on RISCV without
> >> inlining bpf_get_smp_processor_id() then it will cause problems here
> >> right? because then the last 5-6 lines inside this if(){} will be
> >> executed for RISCV.
> >
> > Just add
> >
> > #else
> > return -EFAULT;
>
> I don't think we can return.

ah, because it's not an error condition, right

>
> > #endif
> >
> > ?
> >
> > I'm trying to avoid this duplication of the defined(CONFIG_xxx) checks
> > for supported architectures.
>
> Does the following look correct?
>
> I will do it like this:
>
>                 /* Implement bpf_get_smp_processor_id() inline. */
>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
>                     prog->jit_requested && bpf_jit_supports_percpu_insn()=
) {
>                         /* BPF_FUNC_get_smp_processor_id inlining is an
>                          * optimization, so if pcpu_hot.cpu_number is eve=
r
>                          * changed in some incompatible and hard to suppo=
rt
>                          * way, it's fine to back out this inlining logic
>                          */
> #if defined(CONFIG_X86_64)
>                         insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(un=
signed long)&pcpu_hot.cpu_number);
>                         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
>                         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
>                         cnt =3D 3;
> #elif defined(CONFIG_ARM64)
>                         struct bpf_insn cpu_number_addr[2] =3D { BPF_LD_I=
MM64(BPF_REG_0, (u64)&cpu_number) };
>
>                         insn_buf[0] =3D cpu_number_addr[0];
>                         insn_buf[1] =3D cpu_number_addr[1];
>                         insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
>                         insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
>                         cnt =3D 4;
> #else
>                         goto next_insn;
> #endif

yep, I just wrote a large comment about goto next_insns above and then
saw you already proposed that :) Yep, I think this is the way.

>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
>                         if (!new_prog)
>                                 return -ENOMEM;
>
>                         delta    +=3D cnt - 1;
>                         env->prog =3D prog =3D new_prog;
>                         insn      =3D new_prog->insnsi + i + delta;
>                         goto next_insn;
>                 }
>
>
> >>
> >> >
> >> >>                 /* Implement bpf_get_smp_processor_id() inline. */
> >> >>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id =
&&
> >> >>                     prog->jit_requested && bpf_jit_supports_percpu_=
insn()) {
> >> >> @@ -20214,11 +20214,20 @@ static int do_misc_fixups(struct bpf_veri=
fier_env *env)
> >> >>                          * changed in some incompatible and hard to=
 support
> >> >>                          * way, it's fine to back out this inlining=
 logic
> >> >>                          */
> >> >> +#if defined(CONFIG_X86_64)
> >> >>                         insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u=
32)(unsigned long)&pcpu_hot.cpu_number);
> >> >>                         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_RE=
G_0, BPF_REG_0);
> >> >>                         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_=
0, BPF_REG_0, 0);
> >> >>                         cnt =3D 3;
> >> >> +#elif defined(CONFIG_ARM64)
> >> >> +                       struct bpf_insn cpu_number_addr[2] =3D { BP=
F_LD_IMM64(BPF_REG_0, (u64)&cpu_number) };
> >> >>
> >> >
> >> > this &cpu_number offset is not guaranteed to be within 4GB on arm64?
> >>
> >> Unfortunately, the per-cpu section is not placed in the first 4GB and
> >> therefore the per-cpu pointers are not 32-bit on ARM64.
> >
> > I see. It might make sense to turn x86-64 code into using MOV64_IMM as
> > well to keep more of the logic common. Then it will be just the
> > difference of an offset that's loaded. Give it a try?
>
> I think MOV64_IMM would have more overhead than MOV32_IMM and if we can
> use it in x86-64 we should keep doing it that way. Wdyt?

My assumption (which I didn't check) was that BPF JITs should optimize
such MOV64_IMM that have a constant fitting within 32-bits with a
faster and smaller instruction. But I'm fine leaving it as is, of
course.

>
> >>
> >> >
> >> >> +                       insn_buf[0] =3D cpu_number_addr[0];
> >> >> +                       insn_buf[1] =3D cpu_number_addr[1];
> >> >> +                       insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_RE=
G_0, BPF_REG_0);
> >> >> +                       insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_=
0, BPF_REG_0, 0);
> >> >> +                       cnt =3D 4;
> >> >> +#endif
> >> >>                         new_prog =3D bpf_patch_insn_data(env, i + d=
elta, insn_buf, cnt);
> >> >>                         if (!new_prog)
> >> >>                                 return -ENOMEM;
> >> >> --
> >> >> 2.40.1
> >> >>

