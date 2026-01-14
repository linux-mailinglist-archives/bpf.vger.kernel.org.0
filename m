Return-Path: <bpf+bounces-78793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E888BD1BE6B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34DCB301A706
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA5D277818;
	Wed, 14 Jan 2026 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R8EzpI0W"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532F2773CC
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353613; cv=none; b=u+5mR+r0pBoif+qmSkzWjim42txG5J/MdpHtmnerQxOpaRqyMkEiexiMd2RJ+nbF/1GXh6vKsk1lnhtQDGuFr0z/8XyVUatjCzi3h0gtePneCI/ro3ck1rnQYp/zqxWrO3gvmmscwKpNpBEbOIyyOVD6haRSpjVY7x45S8kwY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353613; c=relaxed/simple;
	bh=xvbKq9zqlpBjnEIRtAY20uDnvE5UPV3rPcBBEwe44bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mnb3UqxRgafjCdaoWffTIlsmndanas5G2IqvXihH/LYwXwaNqTPXPoJwOhlakuQGAS2S4cLElKRoXxvqhL3qz3jagzOktQrz4HT4HkpHU8p5pWaZBaW7nVPdF2X+yMDWAwxF/g1MlkyjC241lyUQti4/qXGGd5vCTfwQht3hViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8EzpI0W; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768353597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOB+NzAkfLhov2uWWfojDz0WXKClIy7D8snDIsUOI1o=;
	b=R8EzpI0W1XgdFiP/VNcTHIt90f2GugzBDaTaD18RxkSTQwdsRxrMiMUPJtQohkiNG5vfEp
	WlBfpOOSpiezA3oABAotFgQGvk8DRvqzPdSFr96H29XFiz4D1SoGbbbx4R0LPKQVXSo1F7
	NwNgTvRX5BiCEXJihjU4jYtygO9nk/k=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Wed, 14 Jan 2026 09:19:46 +0800
Message-ID: <6230600.lOV4Wx5bFT@7940hx>
In-Reply-To:
 <CAADnVQLMztSfxCSxak900PVN+CtiN0FF=hkRcB8cHKiHipd4Dg@mail.gmail.com>
References:
 <20260112104529.224645-1-dongml2@chinatelecom.cn>
 <20260112104529.224645-2-dongml2@chinatelecom.cn>
 <CAADnVQLMztSfxCSxak900PVN+CtiN0FF=hkRcB8cHKiHipd4Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 01:50 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Mon, Jan 12, 2026 at 2:45=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> > to obtain better performance.
> >
> > In !CONFIG_SMP case, the percpu variable is just a normal variable, and
> > we can read the current_task directly.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v4:
> > - handle the !CONFIG_SMP case
> >
> > v3:
> > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
> >   x86_64 JIT.
> > ---
> >  kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3d44c5d06623..12e99171afd8 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(struct=
 bpf_verifier_env *env, s32 imm)
> >         switch (imm) {
> >  #ifdef CONFIG_X86_64
> >         case BPF_FUNC_get_smp_processor_id:
> > +       case BPF_FUNC_get_current_task_btf:
> > +       case BPF_FUNC_get_current_task:
> >                 return env->prog->jit_requested && bpf_jit_supports_per=
cpu_insn();
> >  #endif
> >         default:
> > @@ -23273,6 +23275,33 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                         insn      =3D new_prog->insnsi + i + delta;
> >                         goto next_insn;
> >                 }
> > +
> > +               /* Implement bpf_get_current_task() and bpf_get_current=
_task_btf() inline. */
> > +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn=
=2D>imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> > +                   verifier_inlines_helper_call(env, insn->imm)) {
>=20
> Though verifier_inlines_helper_call() gates this with CONFIG_X86_64,
> I think we still need explicit:
> #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>=20
> just like we did for BPF_FUNC_get_smp_processor_id.
> Please check. I suspect UML will break without it.

Do you mean that we need to use
#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
here?

The whole code is already within it. You can have a look up:

#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
		/* Implement bpf_get_smp_processor_id() inline. */
		if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
		    verifier_inlines_helper_call(env, insn->imm)) {
[......]
		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline=
=2E */
		if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn->imm =3D=3D BPF_F=
UNC_get_current_task_btf) &&
		    verifier_inlines_helper_call(env, insn->imm)) {
[......]
#endif

>=20
> > +#ifdef CONFIG_SMP
> > +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(=
unsigned long)&current_task);
> > +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0,=
 BPF_REG_0);
> > +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_0, 0);
> > +#else
> > +                       struct bpf_insn ld_current_addr[2] =3D {
> > +                               BPF_LD_IMM64(BPF_REG_0, (unsigned long)=
&current_task)
> > +                       };
> > +                       insn_buf[0] =3D ld_current_addr[0];
> > +                       insn_buf[1] =3D ld_current_addr[1];
> > +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_0, 0);
> > +#endif
>=20
> I wouldn't bother with !SMP.
> If we need to add defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> I would add && defined(CONFIG_SMP) to it.

OK, let's skip the !SMP case to make the code more clear.

Thanks!
Menglong Dong

>=20
> pw-bot: cr
>=20





