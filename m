Return-Path: <bpf+bounces-79359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5684D38C57
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 05:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B570D302F689
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 04:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A05326930;
	Sat, 17 Jan 2026 04:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EMn2hs1g"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357122D77EA
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 04:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768625055; cv=none; b=ZtuhdsowEnu+uxCzLAZ0zhzN3yDbJP6WgRxxPT68fBhWG9PNjPsHxko+Sy4E3y5ljmEoYZVGNy6pI0IqeooXF6nCrhdnZWr/Rlaqv01ybKfKziJdwGYdtfB4/dVq8FHBJblmw76b2MCqdPO75i7jdQ5tZpPWT/6Fq8OS+CIWZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768625055; c=relaxed/simple;
	bh=7ZQia/w/2QzVxs+BWGV/6qgmtKk8eJZeY0I548cuPfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhJnG/ke9l26Lnfz0eLpSikhJ87Koa1hyfvT/oINt0KiKEJ82HVejmwpOHzWVoRzPXNyVgSycql6OOGeSngALLGmQadrsitV9NKRJhvpcJT1SbuKGR2+W19eWCs6E++xw23xIlMYh2TRgskpVSevlPvPdq1KLvQ58HfS+oRb6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EMn2hs1g; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768625042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqG9gBi1RD2iYm6CufQDxWqvQoEZs3+30Tc/xZMevJQ=;
	b=EMn2hs1gVnhsFXCJFdRYgq9HEKSq1WCSzNr7WMfnfg3UD53Zu+g6iDMFowNn4TJj5xht6M
	C5e96xErRXUqXiBCeyTnkbeEMemCmfkD1EJSfKOuWwfW5C2/CBZegae9YkM10/OxG83uZL
	rG5hTRjO/CenP4dSVfuHtlh8wCtHj3g=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Date: Sat, 17 Jan 2026 12:43:17 +0800
Message-ID: <3480448.44csPzL39Z@7950hx>
In-Reply-To:
 <CAEf4BzazwvaLVy+4SByCt0cvkOm6eNSmDmGBfUM8u9scFseGCw@mail.gmail.com>
References:
 <20260116071739.121182-1-dongml2@chinatelecom.cn>
 <20260116071739.121182-2-dongml2@chinatelecom.cn>
 <CAEf4BzazwvaLVy+4SByCt0cvkOm6eNSmDmGBfUM8u9scFseGCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/17 07:32, Andrii Nakryiko wrote:
> On Thu, Jan 15, 2026 at 11:18=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported=
 by
> > the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> > tracepoint, especially for the case that the position of the arguments =
in
> > a tracepoint can change.
> >
> > The target tracepoint BTF type id is specified during loading time,
> > therefore we can get the function argument count from the function
> > prototype instead of the stack.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - for nr_args, skip first 'void *__data' argument in btf_trace_##name
> >   typedef
> > ---
> >  kernel/bpf/verifier.c    | 36 ++++++++++++++++++++++++++++++++----
> >  kernel/trace/bpf_trace.c |  4 ++--
> >  2 files changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index faa1ecc1fe9d..422d35c100ff 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23316,8 +23316,22 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                 /* Implement bpf_get_func_arg inline. */
> >                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
> > -                       /* Load nr_args from ctx - 8 */
> > -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_1, -8);
> > +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> > +                               int nr_args;
> > +
> > +                               if (!prog->aux->attach_func_proto)
> > +                                       return -EINVAL;
>=20
> can this happen? can we have tp_btf program without attach_func_proto
> properly set?

I saw it can be NULL in some case, such as bpf2bpf. Maybe it can't
happen for tp_btf, and I'll do further analysis on this point.

Thanks!
Menglong Dong


>=20
> > +                               /*
> > +                                * skip first 'void *__data' argument i=
n btf_trace_##name
> > +                                * typedef
> > +                                */
> > +                               nr_args =3D btf_type_vlen(prog->aux->at=
tach_func_proto) - 1;
> > +                               /* Save nr_args to reg0 */
> > +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0=
, nr_args);
> > +                       } else {
> > +                               /* Load nr_args from ctx - 8 */
> > +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF=
_REG_0, BPF_REG_1, -8);
> > +                       }
> >                         insn_buf[1] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_=
2, BPF_REG_0, 6);
> >                         insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_=
2, 3);
> >                         insn_buf[3] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_=
2, BPF_REG_1);
> > @@ -23369,8 +23383,22 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                 /* Implement get_func_arg_cnt inline. */
> >                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                     insn->imm =3D=3D BPF_FUNC_get_func_arg_cnt) {
> > -                       /* Load nr_args from ctx - 8 */
> > -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_1, -8);
> > +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> > +                               int nr_args;
> > +
> > +                               if (!prog->aux->attach_func_proto)
> > +                                       return -EINVAL;
> > +                               /*
> > +                                * skip first 'void *__data' argument i=
n btf_trace_##name
> > +                                * typedef
> > +                                */
> > +                               nr_args =3D btf_type_vlen(prog->aux->at=
tach_func_proto) - 1;
> > +                               /* Save nr_args to reg0 */
> > +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0=
, nr_args);
> > +                       } else {
> > +                               /* Load nr_args from ctx - 8 */
> > +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF=
_REG_0, BPF_REG_1, -8);
> > +                       }
> >
> >                         new_prog =3D bpf_patch_insn_data(env, i + delta=
, insn_buf, 1);
> >                         if (!new_prog)
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 6e076485bf70..9b1b56851d26 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_i=
d, const struct bpf_prog *prog)
> >         case BPF_FUNC_d_path:
> >                 return &bpf_d_path_proto;
> >         case BPF_FUNC_get_func_arg:
> > -               return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ar=
g_proto : NULL;
> > +               return &bpf_get_func_arg_proto;
> >         case BPF_FUNC_get_func_ret:
> >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_re=
t_proto : NULL;
> >         case BPF_FUNC_get_func_arg_cnt:
> > -               return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ar=
g_cnt_proto : NULL;
> > +               return &bpf_get_func_arg_cnt_proto;
> >         case BPF_FUNC_get_attach_cookie:
> >                 if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                     prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> > --
> > 2.52.0
> >
>=20
>=20





