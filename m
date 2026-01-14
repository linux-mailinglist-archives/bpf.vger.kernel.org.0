Return-Path: <bpf+bounces-78803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C0D1BF19
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DFF2303F49D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCCA29A9FA;
	Wed, 14 Jan 2026 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rSbB1UWp"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C0215077
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354411; cv=none; b=F2gnA7Oo4O0ieMjojx335wRXxvbib9M1WH11cC8yrrv4SNgGX6cePX8sC88ZAsgHwCgBhOC2aaB9mhjCXjQGv19iKkZO7fm/vm5c5eYPQ8nxCbqf7XBGCwIa39B6PMnQlSjX5K29IOdh4tfE1BIpyxGH4Kru/emVJa+1XkJn2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354411; c=relaxed/simple;
	bh=Mzwu0yuGEY3Oih8u2po/SrtMQn7Btjao4l0rTf4RMaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4Qwnx/q4QJGSSMcmpKqR4NGWs0vf8T5Singyzd+3Hzpfma8JpELtFhvDO/yl6oAnaTlJyeLEelIBD4Yq/X+wwkFGVVuE8TklQ60Su+eMdV86Tme0kT7tUITeat5MeHkz1sXy/U+I0GSR66dyijBWmNPP+Wftq+1AYF/qPmfFXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rSbB1UWp; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768354397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+4uewd1KPnTBs/goM/IP3JqjI3jybT74C8H4F8K5lM=;
	b=rSbB1UWpDoFM3UKq2zUATS8vw2iiDx88z41w83qnnkX31x//5VTQ0TI7RuFszxPTywqGaT
	XFRvZHwj/tMWvnayZyExeeOC00I8O2iUGw5wWVvl0nOck6pULqY7Ie5hdUo/3x0dykujPT
	KITxKAyExsEVz8n2cmYFXlx6+C2kIxE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Wed, 14 Jan 2026 09:33:07 +0800
Message-ID: <2396904.ElGaqSPkdT@7940hx>
In-Reply-To:
 <CAADnVQ+Q2m19+rMLXbq98uobL6Zy5yKceDiw-PAmrmCSvvjHaw@mail.gmail.com>
References:
 <20260112104529.224645-1-dongml2@chinatelecom.cn> <6230600.lOV4Wx5bFT@7940hx>
 <CAADnVQ+Q2m19+rMLXbq98uobL6Zy5yKceDiw-PAmrmCSvvjHaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 09:24 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Tue, Jan 13, 2026 at 5:19=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2026/1/14 01:50 Alexei Starovoitov <alexei.starovoitov@gmail.com> wr=
ite:
> > > On Mon, Jan 12, 2026 at 2:45=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x8=
6_64
> > > > to obtain better performance.
> > > >
> > > > In !CONFIG_SMP case, the percpu variable is just a normal variable,=
 and
> > > > we can read the current_task directly.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > ---
> > > > v4:
> > > > - handle the !CONFIG_SMP case
> > > >
> > > > v3:
> > > > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead =
of in
> > > >   x86_64 JIT.
> > > > ---
> > > >  kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
> > > >  1 file changed, 29 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 3d44c5d06623..12e99171afd8 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(st=
ruct bpf_verifier_env *env, s32 imm)
> > > >         switch (imm) {
> > > >  #ifdef CONFIG_X86_64
> > > >         case BPF_FUNC_get_smp_processor_id:
> > > > +       case BPF_FUNC_get_current_task_btf:
> > > > +       case BPF_FUNC_get_current_task:
> > > >                 return env->prog->jit_requested && bpf_jit_supports=
_percpu_insn();
> > > >  #endif
> > > >         default:
> > > > @@ -23273,6 +23275,33 @@ static int do_misc_fixups(struct bpf_verif=
ier_env *env)
> > > >                         insn      =3D new_prog->insnsi + i + delta;
> > > >                         goto next_insn;
> > > >                 }
> > > > +
> > > > +               /* Implement bpf_get_current_task() and bpf_get_cur=
rent_task_btf() inline. */
> > > > +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || =
insn->imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> > > > +                   verifier_inlines_helper_call(env, insn->imm)) {
> > >
> > > Though verifier_inlines_helper_call() gates this with CONFIG_X86_64,
> > > I think we still need explicit:
> > > #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> > >
> > > just like we did for BPF_FUNC_get_smp_processor_id.
> > > Please check. I suspect UML will break without it.
> >
> > Do you mean that we need to use
> > #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> > here?
> >
> > The whole code is already within it. You can have a look up:
> >
> > #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> >                 /* Implement bpf_get_smp_processor_id() inline. */
> >                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
> >                     verifier_inlines_helper_call(env, insn->imm)) {
> > [......]
> >                 /* Implement bpf_get_current_task() and bpf_get_current=
_task_btf() inline. */
> >                 if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn=
=2D>imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> >                     verifier_inlines_helper_call(env, insn->imm)) {
> > [......]
> > #endif
>=20
> oh. I see. I misread it as '+#endif' (with a +) and assumed
> it's part of new code.
>=20
> >
> > >
> > > > +#ifdef CONFIG_SMP
> > > > +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u=
32)(unsigned long)&current_task);
> > > > +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_RE=
G_0, BPF_REG_0);
> > > > +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG=
_0, BPF_REG_0, 0);
> > > > +#else
> > > > +                       struct bpf_insn ld_current_addr[2] =3D {
> > > > +                               BPF_LD_IMM64(BPF_REG_0, (unsigned l=
ong)&current_task)
> > > > +                       };
> > > > +                       insn_buf[0] =3D ld_current_addr[0];
> > > > +                       insn_buf[1] =3D ld_current_addr[1];
> > > > +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG=
_0, BPF_REG_0, 0);
> > > > +#endif
> > >
> > > I wouldn't bother with !SMP.
> > > If we need to add defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> > > I would add && defined(CONFIG_SMP) to it.
> >
> > OK, let's skip the !SMP case to make the code more clear.
>=20
> Similar thoughts about your other patch where you introduce
> decl_tag to deal with different configs.
> For bpf CI we don't need to do such things.
> The kernel has to be configured with selftest/bpf/config.
> So doing extra work in test_progs to recognize !SMP looks like overkill.

You are right, and that's why I removed that patch in this version
after I realized this point.

Thanks!
Menglong Dong





