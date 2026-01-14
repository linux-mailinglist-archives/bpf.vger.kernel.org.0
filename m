Return-Path: <bpf+bounces-78817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC43DD1C239
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D916F3019B4B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F92F99A8;
	Wed, 14 Jan 2026 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9WqKmyI"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8F2FBDE0
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357908; cv=none; b=D9LMYj2T82O8Ng8wEtrI8hr/OBR8trkpskUIZHaBsrXW+RkZTs8p5kZ1vxio5am5xBAvh3Q45DGtqvZAHGgg/hoCyoe5e4SSOZqnyLwV33K9eEFVfR5jS86su3RL7uVulp2TsU0l9Lcmz6O2A8m+j1MHewa8HnPcXFz0XVYvrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357908; c=relaxed/simple;
	bh=/RvDX4PI6L79Hw9/iVCqfMK2N/byBZJWAJQJ4w51ptI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8h5AGeSefAE/WrpRDuQD/uw1uJzmYy/eSwf4+ixiueJkVRhFZ4657p3dcVzf7+KSE9FgeLQxHmOcnwGW9XfyjTRZJF487+B92G1sLaufarKw0DE9UMlipoe8TlExuF1+kV4GgBPsFXCG+pswASS8AmQtddEwCGKgNkvSWc/HvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9WqKmyI; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768357895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyue6jPEhQF/o9AZ7DaJGY9Nx3eVeeJQ8DKHUFRQtI8=;
	b=g9WqKmyIQHPV4OXjwgmrcon3hBoOR3JC7ptNPX4PqAXHfrRmRFMBA6Xa5Lf0tIyLn01eNN
	lOV92xmKF0CQUSrcLKTizZ6m7m7PycQDFRiJ8T9IDO9ntNEz4Y1GV6gyxNGyRGSHcSn9aO
	MoEXknNn+shrCVtu0dR5QXs4fTJ6Sro=
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
 Re: [PATCH bpf-next v9 06/11] bpf,x86: introduce emit_store_stack_imm64() for
 trampoline
Date: Wed, 14 Jan 2026 10:31:22 +0800
Message-ID: <8672423.NyiUUSuA9g@7940hx>
In-Reply-To:
 <CAEf4BzbKKmNnqQP0g8OVSgwqb2DTidBpKBjyi-QQJBRJ+-6SWg@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-7-dongml2@chinatelecom.cn>
 <CAEf4BzbKKmNnqQP0g8OVSgwqb2DTidBpKBjyi-QQJBRJ+-6SWg@mail.gmail.com>
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
> On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Introduce the helper emit_store_stack_imm64(), which is used to store a
> > imm64 to the stack with the help of r0.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v9:
> > - rename emit_st_r0_imm64() to emit_store_stack_imm64()
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index e3b1c4b1d550..d94f7038c441 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u3=
2 dst_reg, int off, int imm)
> >         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
> >  }
> >
> > +static void emit_store_stack_imm64(u8 **pprog, int stack_off, u64 imm6=
4)
> > +{
> > +       /* mov rax, imm64
> > +        * mov QWORD PTR [rbp - stack_off], rax
> > +        */
> > +       emit_mov_imm64(pprog, BPF_REG_0, imm64 >> 32, (u32) imm64);
>=20
> maybe make the caller pass BPF_REG_0 explicitly, it will be more
> generic but also more explicit that BPF_REG_0 is used as temporary
> register?

OK! I were worried about that it wasn't explicit that BPF_REG_0 is
used too.

>=20
> > +       emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -stack_off);
>=20
> why are you negating stack offset here and not in the caller?..
>=20
> > +}
> > +
> >  static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
> >                            u32 dst_reg, u32 src_reg, s16 off, u8 bpf_si=
ze)
> >  {
> > @@ -3352,16 +3361,14 @@ static int __arch_prepare_bpf_trampoline(struct=
 bpf_tramp_image *im, void *rw_im
> >          *   mov rax, nr_regs
> >          *   mov QWORD PTR [rbp - nregs_off], rax
> >          */
> > -       emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
> > -       emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
> > +       emit_store_stack_imm64(&prog, nregs_off, nr_regs);
> >
> >         if (flags & BPF_TRAMP_F_IP_ARG) {
> >                 /* Store IP address of the traced function:
> >                  * movabsq rax, func_addr
> >                  * mov QWORD PTR [rbp - ip_off], rax
> >                  */
> > -               emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32=
, (u32) (long) func_addr);
> > -               emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
> > +               emit_store_stack_imm64(&prog, ip_off, (long)func_addr);
>=20
> see above, I'd pass BPF_REG_0 and -ip_off (and -nregs_off) explicitly,
> too many small transformations are hidden inside
> emit_store_stack_imm64(), IMO

ACK. The negating offset in emit_store_stack_imm64() indeed implicit.
I'll use this way in the next version.

Thanks!
Menglong Dong

>=20
>=20
> >         }
> >
> >         save_args(m, &prog, regs_off, false, flags);
> > --
> > 2.52.0
> >
>=20





