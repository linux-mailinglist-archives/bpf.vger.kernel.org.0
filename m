Return-Path: <bpf+bounces-78812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B52AD1C1D3
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB35D30206A7
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1D2F49E3;
	Wed, 14 Jan 2026 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q9xR/LCX"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A392E401;
	Wed, 14 Jan 2026 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357161; cv=none; b=WnqeVrKUatNSTmaPr+3qVMNpU2q3GDHkFyzo5OECDlecRCdL755lcIBCHH7M2WDzDcw8pGl+RLaZUU+6m6Z+LJFyMUr5GwotjYrjmnSMtm/6E5QFzoWCT7eqCy4JN5dDGuEw72wKGDQekqMd3J6TVK+q8ACXXIQfpCHPCQSNj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357161; c=relaxed/simple;
	bh=iOIUGrjLauqCHcU73tQ7hy1GSvZ7AvDxzTtU1N0+QxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az6oogCd5HmZLAYSNZpYCsd0vgGaoBNCxhrBpMg09tfnlbYlcqQS9FNg+BF+PxD9YsxTK5OHX4oUNG0J8/RiQmiJXctYM+ZmGMX+9S1+3JoqjEj+RL9KDtxVBHHDkjANZVHIOdz775uVo6HL6LwoWKSbe3y78Mr/JzvvPoow3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q9xR/LCX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768357157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axlGY3BJbV4WcxqnqV85RerlHDSYuLCYqJ+66mzdzCc=;
	b=Q9xR/LCXVJK6lE1UNxB4s8M0kP/OytfrnsQTiYCDJAyE7khjQxtQTe6lA4ObXL9FbplJyT
	VEdWKfgFRMbrWhGyHK140SFfD4qwISxgFK7sYhAj4ftKzrd+q78owN754eJ9nWawMaxxXe
	xE0uK41T0z1fUcsClKodTcNX9+F7mwA=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v9 02/11] bpf: use last 8-bits for the nr_args in
 trampoline
Date: Wed, 14 Jan 2026 10:19:02 +0800
Message-ID: <2336927.iZASKD2KPV@7940hx>
In-Reply-To:
 <CAEf4BzZKn8B_8T+ET7+cK90AfE_p918zwOKhi+iQOo5RkV8dNQ@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-3-dongml2@chinatelecom.cn>
 <CAEf4BzZKn8B_8T+ET7+cK90AfE_p918zwOKhi+iQOo5RkV8dNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > For now, ctx[-1] is used to store the nr_args in the trampoline. Howeve=
r,
> > 1-byte is enough to store such information. Therefore, we use only the
> > last byte of ctx[-1] to store the nr_args, and reserve the rest for oth=
er
>=20
> Looking at the assembly below I think you are extracting the least
> significant byte, right? I'd definitely not call it "last" byte...
> Let's be precise and unambiguous here.

Yeah, the "last 8-bits", "lat byte" is ambiguous. So let's describe it as
"the least significant byte" here instead :)

Thanks!
Menglong Dong

>=20
> > usages.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v8:
> > - fix the missed get_func_arg_cnt
> > ---
> >  kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
> >  kernel/trace/bpf_trace.c |  6 +++---
> >  2 files changed, 22 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 774c9b0aafa3..bfff3f84fd91 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23277,15 +23277,16 @@ static int do_misc_fixups(struct bpf_verifier=
_env *env)
> >                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
> >                         /* Load nr_args from ctx - 8 */
> >                         insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_1, -8);
> > -                       insn_buf[1] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_=
2, BPF_REG_0, 6);
> > -                       insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_=
2, 3);
> > -                       insn_buf[3] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_=
2, BPF_REG_1);
> > -                       insn_buf[4] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_2, 0);
> > -                       insn_buf[5] =3D BPF_STX_MEM(BPF_DW, BPF_REG_3, =
BPF_REG_0, 0);
> > -                       insn_buf[6] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> > -                       insn_buf[7] =3D BPF_JMP_A(1);
> > -                       insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVA=
L);
> > -                       cnt =3D 9;
> > +                       insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, BPF_REG_=
0, 0xFF);
> > +                       insn_buf[2] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_=
2, BPF_REG_0, 6);
> > +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_=
2, 3);
> > +                       insn_buf[4] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_=
2, BPF_REG_1);
> > +                       insn_buf[5] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_2, 0);
> > +                       insn_buf[6] =3D BPF_STX_MEM(BPF_DW, BPF_REG_3, =
BPF_REG_0, 0);
> > +                       insn_buf[7] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> > +                       insn_buf[8] =3D BPF_JMP_A(1);
> > +                       insn_buf[9] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVA=
L);
> > +                       cnt =3D 10;
> >
>=20
> [...]
>=20





