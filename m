Return-Path: <bpf+bounces-78800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B402D1BEB6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2DB9306160B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716FF28EA72;
	Wed, 14 Jan 2026 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3VJKkeL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986412BD5A7
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353866; cv=none; b=Yp+vbFPrvAbh3/nuoJ8ZdNHXHpf1wqLinysgFY/h2QaRAawvjLBOCS/364kpL92YJu+48lLhnNkFhPuqzfCP787r0i8lD61i0ULrZ0iI8sSDpWrtl9ciHuXIH7ZaLB2R0YqoIqp0cjAxwRvdjRfanIqk8oQ8HSrrrJnP1FvXBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353866; c=relaxed/simple;
	bh=/zWsdug1fBavB00oph/P1AII7s0pYd/AVXyAuiplNRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngp4NFFOMB9DwoY7qOa5OY5fFLgouxCZk3pjkKqfxU1groL4zTACcM/BmteYiK29sPXomvqL4x5b7Sq7g6GALfSoTBd69Z2XaAkax7fLfFAy/xKEbwijDSB5SAErnugxvJqr1RJBqKLInGGaDxegDEhU5H07yQXN31MT7UQObT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3VJKkeL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47796a837c7so56012285e9.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353863; x=1768958663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSARoeQjyo1U185exiltI8GsYM32CJJw0Wb0JV4NKog=;
        b=D3VJKkeL5daGuvPD7+mtb4FQ/ELnI8Zwq1g4mIH4LXavtAkjOVLwHgrPkmc8YXzlO6
         P1NatiKuNU/EFIzLFOVcy7oqrYCSIM85LH1mcjD0DNkcLDMRSgXN67R5JbMYhAu426op
         N+dg22GYOlSt69kWPpuuPG5BacJ5CbJsWHdILkI8/clyjbmbAK2BXFf3iZKQtYXh26eP
         WRP1ofJ5Y6kAP41JjlBNj0LSwmwELkqp4zDMgFFoqCv1szRyqJFr4h872VS528rRM7Cj
         V3b1/l+6qqxjl11hf3csclrtAxcoh4va/BXnQ5LutjfIhRfd0l0ZLbgD1WAg8c459WF8
         pToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353863; x=1768958663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSARoeQjyo1U185exiltI8GsYM32CJJw0Wb0JV4NKog=;
        b=KhSdoBigbi4uPqtzKsxGjtaVVzfv3ednId8M4KAgaDcw1pbMRYX5vtECDSSqsfcDi6
         uMdW5hqkpNwWzlt1T9uTE2mDyM17il7M8Gn7p4s9jNkcH6/b75i3Jd+jNmI6PPP+WcUk
         BJxyQ0NzZd1NEmbgRT7LdF8AQhqQN9tRSg1w5RoRFiR5h9tHRJzOPQ5Aimqb0Tcl/xEj
         4EZeghbzHoRoE5x7/Et0zCR+qtDt4C+c/97xP/UiskgM0E6fERaH4B/YXTXhvEr2ibg+
         0EK+x/SHPwxblqbNKhOzqi+oi4RmRRw76ZfeW6XsQ2tTZhwVkD7fABfGPtPHR6l3gVBR
         hJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVA3KlApxvtYYH3eRPSpLcQCG6xzL0ZdNIL6M7WEuTN9BjgjKBC1nA7n0J8zBuBVXLioI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1Bgz/nqbtSKd7YKfF+cm2RwxEg32S0tk8Sz39nLfXy3/iTcY
	DpoRUPpgrEEsrcnApbQJVWOI/hQe8U0XU49nZlfjsWG/+0aACb1T/vfwnB8ey11+EZAwlRGDsxc
	Hf5BRslPv6JdB9e7U+FvyZxn9IOTZtdo=
X-Gm-Gg: AY/fxX5O/PLccW7Jx15hg1eCoqC/TZSJUW6XSwktlT0a3sRYvgOiivDniZBzx31cKtq
	EvTonxlY5y0CBhPTPKJMSU4slp/YxWnpaKJVDDTZ3g8tLDRHjSUd5jsusS8lF7XaW7aGbQy160Z
	vWoWwj8RLwSuobeYUJLfYFEQbqeJBAV6+FGI0hr3RbHESK0G8HffnsfreKfiKel6FCh8dD4jh72
	tWH00az9kmr+YFd72w4raQmEqI8+suFgJd5D98kgeZ8wAWUGTDcm7c8vq3ICzhyU+HdZhF5oV3Z
	bOu86rk9U17JtSoMSvJyP33vJZfpcBJ427lgLfA=
X-Received: by 2002:a05:600c:500d:b0:47d:3ffb:16c9 with SMTP id
 5b1f17b1804b1-47ee33917d1mr8583715e9.23.1768353862672; Tue, 13 Jan 2026
 17:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112104529.224645-1-dongml2@chinatelecom.cn>
 <20260112104529.224645-2-dongml2@chinatelecom.cn> <CAADnVQLMztSfxCSxak900PVN+CtiN0FF=hkRcB8cHKiHipd4Dg@mail.gmail.com>
 <6230600.lOV4Wx5bFT@7940hx>
In-Reply-To: <6230600.lOV4Wx5bFT@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 17:24:11 -0800
X-Gm-Features: AZwV_QhkdNpSg20FO7gA_s9HtIa2cISsoaHdla5dHg11lLJTtz5j4DMlN4S4JXM
Message-ID: <CAADnVQ+Q2m19+rMLXbq98uobL6Zy5yKceDiw-PAmrmCSvvjHaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:19=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/1/14 01:50 Alexei Starovoitov <alexei.starovoitov@gmail.com> writ=
e:
> > On Mon, Jan 12, 2026 at 2:45=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_=
64
> > > to obtain better performance.
> > >
> > > In !CONFIG_SMP case, the percpu variable is just a normal variable, a=
nd
> > > we can read the current_task directly.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > > v4:
> > > - handle the !CONFIG_SMP case
> > >
> > > v3:
> > > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of=
 in
> > >   x86_64 JIT.
> > > ---
> > >  kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 3d44c5d06623..12e99171afd8 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(stru=
ct bpf_verifier_env *env, s32 imm)
> > >         switch (imm) {
> > >  #ifdef CONFIG_X86_64
> > >         case BPF_FUNC_get_smp_processor_id:
> > > +       case BPF_FUNC_get_current_task_btf:
> > > +       case BPF_FUNC_get_current_task:
> > >                 return env->prog->jit_requested && bpf_jit_supports_p=
ercpu_insn();
> > >  #endif
> > >         default:
> > > @@ -23273,6 +23275,33 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> > >                         insn      =3D new_prog->insnsi + i + delta;
> > >                         goto next_insn;
> > >                 }
> > > +
> > > +               /* Implement bpf_get_current_task() and bpf_get_curre=
nt_task_btf() inline. */
> > > +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || in=
sn->imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> > > +                   verifier_inlines_helper_call(env, insn->imm)) {
> >
> > Though verifier_inlines_helper_call() gates this with CONFIG_X86_64,
> > I think we still need explicit:
> > #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> >
> > just like we did for BPF_FUNC_get_smp_processor_id.
> > Please check. I suspect UML will break without it.
>
> Do you mean that we need to use
> #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> here?
>
> The whole code is already within it. You can have a look up:
>
> #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>                 /* Implement bpf_get_smp_processor_id() inline. */
>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
>                     verifier_inlines_helper_call(env, insn->imm)) {
> [......]
>                 /* Implement bpf_get_current_task() and bpf_get_current_t=
ask_btf() inline. */
>                 if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn->=
imm =3D=3D BPF_FUNC_get_current_task_btf) &&
>                     verifier_inlines_helper_call(env, insn->imm)) {
> [......]
> #endif

oh. I see. I misread it as '+#endif' (with a +) and assumed
it's part of new code.

>
> >
> > > +#ifdef CONFIG_SMP
> > > +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32=
)(unsigned long)&current_task);
> > > +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_=
0, BPF_REG_0);
> > > +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0=
, BPF_REG_0, 0);
> > > +#else
> > > +                       struct bpf_insn ld_current_addr[2] =3D {
> > > +                               BPF_LD_IMM64(BPF_REG_0, (unsigned lon=
g)&current_task)
> > > +                       };
> > > +                       insn_buf[0] =3D ld_current_addr[0];
> > > +                       insn_buf[1] =3D ld_current_addr[1];
> > > +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0=
, BPF_REG_0, 0);
> > > +#endif
> >
> > I wouldn't bother with !SMP.
> > If we need to add defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> > I would add && defined(CONFIG_SMP) to it.
>
> OK, let's skip the !SMP case to make the code more clear.

Similar thoughts about your other patch where you introduce
decl_tag to deal with different configs.
For bpf CI we don't need to do such things.
The kernel has to be configured with selftest/bpf/config.
So doing extra work in test_progs to recognize !SMP looks like overkill.

