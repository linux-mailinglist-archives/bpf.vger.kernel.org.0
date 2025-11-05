Return-Path: <bpf+bounces-73557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9652C33A9C
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 02:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77C44647B2
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31BC22127A;
	Wed,  5 Nov 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GPSrMHuv"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5A11CA0
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306241; cv=none; b=QU4KOMuMGIgw//sOYGewrOnkZL7MCzJV3WQP+Mlo6p7GoFwta1XzelUPJMol8HN2qg9vibIQ8067txTNopTm+TvLj9yFEuVrtsBnVrzM3QXyDxTgwhW63X8GlaNzd0Z+45eTVLKRoFjle6BIiv7kHTOQwJZwnH02qjNiS3JK/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306241; c=relaxed/simple;
	bh=DG60yIXuoS/JK2Rk6WVbsnmzXYFCfAiP+7wZk2TghFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8Oty63pqUVuOF9CxtcEOuUHq9HflcUoLmOfk2KW8PzC0MDzSIQH4fEpzaBHTihUEX8vlmP0qjV//xckt4Di/ZRbicxiizpNXD28mVIbMNLXyT1GJ8j+FTbn1bG5qc4ofY8WEqXzV034vmBRz2bRFzqoycMqcs3Qo6h/VX53G2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GPSrMHuv; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762306232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBeeftk6Pzzwy1nouNj0uXxW2ZCHDcZqmGF8qKbAxoI=;
	b=GPSrMHuvEftwHZF0gi7UZQnAlsvOAFbQUmql05NmrUixYoy+ieUqf52H3VD81yeS7SYUKc
	7RG5zQ4IQ/U05bRv1zeaTB53nSRKth1jkFq7j5nkcE4mTmxZc+aJcfwKOkg2J/1W7W4Zyr
	CVhbpCQpIjjq9LQQ0qUukgNKNuLhjCs=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
Date: Wed, 05 Nov 2025 09:30:16 +0800
Message-ID: <5029485.GXAFRqVoOG@7950hx>
In-Reply-To:
 <CAADnVQJTOFjXe5=01KfOnBD86YU_Vy1YGezLQum3LnhFHAD+gg@mail.gmail.com>
References:
 <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <CAADnVQJTOFjXe5=01KfOnBD86YU_Vy1YGezLQum3LnhFHAD+gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/5 02:56, Alexei Starovoitov wrote:
> On Tue, Nov 4, 2025 at 2:49=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > In origin call case, we skip the "rip" directly before we return, which
> > break the RSB, as we have twice "call", but only once "ret".
>=20
> RSB meaning return stack buffer?
>=20
> and by "breaks RSB" you mean it makes the cpu less efficient?

Yeah, I mean it makes the cpu less efficient. The RSB is used
for the branch predicting, and it will push the "rip" to its hardware
stack on "call", and pop it from the stack on "ret". In the origin
call case, there are twice "call" but once "ret", will break its
balance.

Similar things happen in "return_to_handler" in ftrace_64.S,
which has once "call", but twice "ret". And it pretend a "call"
to make it balance.

I were wandering why the overhead of fexit is much higher
than fentry. I added the percup-ref-get-and-put stuff to the
fentry, and the performance of it still can be 130M/s. However,
the fexit only has 76M/s. And the only difference is the origin
call.

The RSB balancing mitigate it, but there are still gap. I
suspect it's still the branch predicting things.

> Or you mean call depth accounting that is done in sw ?
>=20
> > Do the RSB balance by pseudo a "ret". Instead of skipping the "rip", we
> > modify it to the address of a "ret" insn that we generate.
> >
> > The performance of "fexit" increases from 76M/s to 84M/s. Before this
> > optimize, the bench resulting of fexit is:
> >
> > fexit          :   76.494 =C2=B1 0.216M/s
> > fexit          :   76.319 =C2=B1 0.097M/s
> > fexit          :   70.680 =C2=B1 0.060M/s
> > fexit          :   75.509 =C2=B1 0.039M/s
> > fexit          :   76.392 =C2=B1 0.049M/s
> >
> > After this optimize:
> >
> > fexit          :   86.023 =C2=B1 0.518M/s
> > fexit          :   83.388 =C2=B1 0.021M/s
> > fexit          :   85.146 =C2=B1 0.058M/s
> > fexit          :   85.646 =C2=B1 0.136M/s
> > fexit          :   84.040 =C2=B1 0.045M/s
>=20
> This is with or without calldepth accounting?

The CONFIG_MITIGATION_CALL_DEPTH_TRACKING is enabled, but
I did the testing with "mitigations=3Doff" in the cmdline, so I guess
"without"?

>=20
> > Things become a little more complex, not sure if the benefits worth it =
:/
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 32 +++++++++++++++++++++++++++++---
> >  1 file changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index d4c93d9e73e4..a9c2142a84d0 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3185,6 +3185,7 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_R=
ETURN];
> >         void *orig_call =3D func_addr;
> >         u8 **branches =3D NULL;
> > +       u8 *rsb_pos;
> >         u8 *prog;
> >         bool save_ret;
> >
> > @@ -3431,17 +3432,42 @@ static int __arch_prepare_bpf_trampoline(struct=
 bpf_tramp_image *im, void *rw_im
> >                 LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
> >         }
> >
> > +       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> > +               u64 ret_addr =3D (u64)(image + (prog - (u8 *)rw_image));
> > +
> > +               rsb_pos =3D prog;
> > +               /*
> > +                * reserve the room to save the return address to rax:
> > +                *   movabs rax, imm64
> > +                *
> > +                * this is used to do the RSB balance. For the SKIP_FRA=
ME
> > +                * case, we do the "call" twice, but only have one "ret=
",
> > +                * which can break the RSB.
> > +                *
> > +                * Therefore, instead of skipping the "rip", we make it=
 as
> > +                * a pseudo return: modify the "rip" in the stack to the
> > +                * second "ret" address that we build bellow.
> > +                */
> > +               emit_mov_imm64(&prog, BPF_REG_0, ret_addr >> 32, (u32)r=
et_addr);
> > +               /* mov [rbp + 8], rax */
> > +               EMIT4(0x48, 0x89, 0x45, 0x08);
> > +       }
> > +
> >         /* restore return value of orig_call or fentry prog back into R=
AX */
> >         if (save_ret)
> >                 emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
> >
> >         emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
> >         EMIT1(0xC9); /* leave */
> > +       emit_return(&prog, image + (prog - (u8 *)rw_image));
> >         if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> > -               /* skip our return address and return to parent */
> > -               EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
> > +               u64 ret_addr =3D (u64)(image + (prog - (u8 *)rw_image));
> > +
> > +               /* fix the return address to second return address */
> > +               emit_mov_imm64(&rsb_pos, BPF_REG_0, ret_addr >> 32, (u3=
2)ret_addr);
>=20
> So the first "movabs rax, imm64" is not needed ?
> Why compute ret_addr there and everything ?
> I mean it could have been prog +=3D sizeof(movabs), right?

I did it before, but the thing is that the "sizeof(movabs)" in not
fixed according to the definition of emit_mov_imm64():

static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
			   const u32 imm32_hi, const u32 imm32_lo)
{
	u64 imm64 =3D ((u64)imm32_hi << 32) | (u32)imm32_lo;
	u8 *prog =3D *pprog;

	if (is_uimm32(imm64)) {
		/*
		 * For emitting plain u32, where sign bit must not be
		 * propagated LLVM tends to load imm64 over mov32
		 * directly, so save couple of bytes by just doing
		 * 'mov %eax, imm32' instead.
		 */
		emit_mov_imm32(&prog, false, dst_reg, imm32_lo);
	} else if (is_simm32(imm64)) {
		emit_mov_imm32(&prog, true, dst_reg, imm32_lo);
	} else {
		/* movabsq rax, imm64 */
		EMIT2(add_1mod(0x48, dst_reg), add_1reg(0xB8, dst_reg));
		EMIT(imm32_lo, 4);
		EMIT(imm32_hi, 4);
	}

	*pprog =3D prog;
}

I used "emit_mov_imm64(&prog, BPF_REG_0, 0, 0)" to take the placeholder,
but I failed, as the insn length is total different with
"emit_mov_imm64(&rsb_pos, BPF_REG_0, ret_addr >> 32, (u32)ret_addr);".

It's a little confusing here, I have not figure out a better way :/

Thanks!
Menglong Dong

>=20
> > +               /* this is the second(real) return */
> > +               emit_return(&prog, image + (prog - (u8 *)rw_image));
> >         }
> > -       emit_return(&prog, image + (prog - (u8 *)rw_image));
>=20





