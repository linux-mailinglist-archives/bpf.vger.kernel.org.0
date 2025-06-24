Return-Path: <bpf+bounces-61368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B134DAE643F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580387AA76B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 12:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393E28ECD8;
	Tue, 24 Jun 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjKp9ENB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516CE1F5617;
	Tue, 24 Jun 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766956; cv=none; b=IjiQt8QPQ6y+SUPdm+0ge6kmYnL73pZz03mDFrSygeZjphsJI4yKEFabji3AQFiqcajUZWgBz0qxsi5qkT6cGl7/Ms0e2b6ChgDlkKJb8Id17ffeGhkBFwXMyfunLilOdOqvUPXnHdsu9gOKM1Pa9xid/nShOdy9La0tolgpGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766956; c=relaxed/simple;
	bh=/vAqvIEqJPIi0Da0SxWzNOxYlkISJ45iZrs1A/XX4sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXdW+TPOYXtw8kspudmQwsATXLvLVogBSTMN7N37mLg4NZfYxRYJcRg8s+dK5eUmCBVynw2k8Mh76g6XfgNoeIII3bp3iFD1pmuF2UdxmgNHnLklhBQa5/iC2VVNCaOrrPkdxZS/fWc3PAO7oWpp126tarmdzvOUhWAhbYI1wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjKp9ENB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231BEC4CEE3;
	Tue, 24 Jun 2025 12:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750766956;
	bh=/vAqvIEqJPIi0Da0SxWzNOxYlkISJ45iZrs1A/XX4sQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YjKp9ENB80dSE47uAe2UMoR15d4+qFJrSpCmManquFuhtQabx4Jj37DnElEFqDyF7
	 pQ3/Q+2vfinH5iCyatHNsenznD07gKqCF5gEeyaV5PZ2ELgrhy5cxp5H7fGB44VBSA
	 SfUKRSU3+pWkKYnNv1d12BKx1VbBQGp/0iZaST6vN2wT6vnu2R0EEPdvS6aznCYPAO
	 v6BArlObt8uwaXxYaiHjzNzS63MFz1APnx9CNjEhPI5saCaGW3hLfAACsMN4ArFYzY
	 RNSuGu0R0MOK6mvoAxmgHnUxUfgjOIgdEp1TF3HDvWX2M9vogpRnmA5g3CueU/WUC1
	 8ODFhjq4xEGFQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso9713828a12.0;
        Tue, 24 Jun 2025 05:09:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7kePAmvlz+KH+a1ZY4hA7sUKV7mJL8CJwsVIWL4InDEOSX4POpyMqhwuPlVmybpr2/cesAM9/Lvera4dB@vger.kernel.org, AJvYcCVtsbWrUTVQ9g9uZ/1+vnjndT6M6wKhJmYlfc+l5PSBebNrGU5jkpL3gOFjXWQ3YU4KHMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxckzj/0ZoOs+aNBtx2REWpUy2U4XdoBOwNLbXXmh7VEOHXcQa2
	v1lYx9253M0H5svXZlvmsTLLYFCJCO9GHbEtJ2rNKMDFXqZaLJJoeTxiLyZcQFmE4QWS1l4g6PX
	BQQyrNoyQMmgmLR75cgoz9KVWI73BT8k=
X-Google-Smtp-Source: AGHT+IEveyCryxR0Z96AZhwmOCgZi8eKVX7D3TPLzSH1SnTfi0MTzrer7b/f9zklQ8gZxs+eyrySxOrrhUkPfF0fehU=
X-Received: by 2002:a05:6402:1eca:b0:60c:3c23:2950 with SMTP id
 4fb4d7f45d1cf-60c3c232b00mr1090202a12.8.1750766954698; Tue, 24 Jun 2025
 05:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528104032.1237415-1-jianghaoran@kylinos.cn>
 <CAEyhmHTg3xNMBrSxXQj96pvfD83t6_RHRT_GGtbBzOpAKztDpw@mail.gmail.com> <68ec5a7f3cc63dc19397b3ce0649716e0fac8d49.camel@kylinos.cn>
In-Reply-To: <68ec5a7f3cc63dc19397b3ce0649716e0fac8d49.camel@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 24 Jun 2025 20:09:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5NrGb9ofaKdqUQ3Qc6RK3c=Ngy6KsxX2GaOqUb0SQRdw@mail.gmail.com>
X-Gm-Features: AX0GCFtD9EvAyNu7eh4iPlep1b-5L2uW3s302vwNzQO9z7kJzBC_8U1UEiAYI6I
Message-ID: <CAAhV-H5NrGb9ofaKdqUQ3Qc6RK3c=Ngy6KsxX2GaOqUb0SQRdw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Optimize the calculation method of
 jmp_offset in the emit_bpf_tail_call function
To: jianghaoran <jianghaoran@kylinos.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@xen0n.name, yangtiezhu@loongson.cn, 
	haoluo@google.com, jolsa@kernel.org, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Haoran,

On Fri, May 30, 2025 at 9:22=E2=80=AFAM jianghaoran <jianghaoran@kylinos.cn=
> wrote:
>
>
>
>
>
> =E5=9C=A8 2025-05-29=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 10:02 +0800=EF=
=BC=8CHengqi Chen=E5=86=99=E9=81=93=EF=BC=9A
> > Hi Haoran,
> >
> > On Wed, May 28, 2025 at 6:40=E2=80=AFPM Haoran Jiang <
> > jianghaoran@kylinos.cn
> > > wrote:
> > > For a ebpf subprog JIT=EF=BC=8Cthe last call bpf_int_jit_compile
> > > function will
> > > directly enter the skip_init_ctx process. At this point,
> > > out_offset =3D -1,
> > > the jmp_offset in emit_bpf_tail_call is calculated
> > > by #define jmp_offset (out_offset - (cur_offset)) is a negative
> > > number,
> > > which does not meet expectations.The final generated assembly
> > > as follow.
> > >
> > > 54:     bgeu            $a2, $t1, -8        # 0x0000004c
> > > 58:     addi.d          $a6, $s5, -1
> > > 5c:     bltz            $a6, -16            # 0x0000004c
> > > 60:     alsl.d          $t2, $a2, $a1, 0x3
> > > 64:     ld.d            $t2, $t2, 264
> > > 68:     beq             $t2, $zero, -28     # 0x0000004c
> > >
> > > Before apply this patch, the follow test case will reveal soft
> > > lock issues.
> > >
> > > cd tools/testing/selftests/bpf/
> > > ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_1
> > >
> > > dmesg:
> > > watchdog: BUG: soft lockup - CPU#2 stuck for 26s!
> > > [test_progs:25056]
> > >
> >
> > This is a known issue. Does this change pass all tailcall tests ?
> > If not, please refer to the tailcall hierarchy patchset([1]).
> > We should address it once and for all. Thanks.
Do you mean you will update this patch?

Huacai

> >
> >   [1]:
> > https://lore.kernel.org/bpf/20240714123902.32305-1-hffilwlqm@gmail.com/
> >
> > Thanks,I'll keep looking into these patches.
> > > Signed-off-by: Haoran Jiang <
> > > jianghaoran@kylinos.cn
> > > >
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 28 +++++++++-------------------
> > >  1 file changed, 9 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c
> > > b/arch/loongarch/net/bpf_jit.c
> > > index fa1500d4aa3e..d85490e7de89 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -208,9 +208,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
> > >         return true;
> > >  }
> > >
> > > -/* initialized on the first pass of build_body() */
> > > -static int out_offset =3D -1;
> > > -static int emit_bpf_tail_call(struct jit_ctx *ctx)
> > > +static int emit_bpf_tail_call(int insn, struct jit_ctx *ctx)
> > >  {
> > >         int off;
> > >         u8 tcc =3D tail_call_reg(ctx);
> > > @@ -220,9 +218,8 @@ static int emit_bpf_tail_call(struct
> > > jit_ctx *ctx)
> > >         u8 t2 =3D LOONGARCH_GPR_T2;
> > >         u8 t3 =3D LOONGARCH_GPR_T3;
> > >         const int idx0 =3D ctx->idx;
> > > -
> > > -#define cur_offset (ctx->idx - idx0)
> > > -#define jmp_offset (out_offset - (cur_offset))
> > > +       int tc_ninsn =3D 0;
> > > +       int jmp_offset =3D 0;
> > >
> > >         /*
> > >          * a0: &ctx
> > > @@ -232,8 +229,11 @@ static int emit_bpf_tail_call(struct
> > > jit_ctx *ctx)
> > >          * if (index >=3D array->map.max_entries)
> > >          *       goto out;
> > >          */
> > > +       tc_ninsn =3D insn ? ctx->offset[insn+1] - ctx-
> > > >offset[insn] :
> > > +               ctx->offset[0];
> > >         off =3D offsetof(struct bpf_array, map.max_entries);
> > >         emit_insn(ctx, ldwu, t1, a1, off);
> > > +       jmp_offset =3D tc_ninsn - (ctx->idx - idx0);
> > >         /* bgeu $a2, $t1, jmp_offset */
> > >         if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset)
> > > < 0)
> > >                 goto toofar;
> > > @@ -243,6 +243,7 @@ static int emit_bpf_tail_call(struct
> > > jit_ctx *ctx)
> > >          *       goto out;
> > >          */
> > >         emit_insn(ctx, addid, REG_TCC, tcc, -1);
> > > +       jmp_offset =3D tc_ninsn - (ctx->idx - idx0);
> > >         if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC,
> > > LOONGARCH_GPR_ZERO, jmp_offset) < 0)
> > >                 goto toofar;
> > >
> > > @@ -254,6 +255,7 @@ static int emit_bpf_tail_call(struct
> > > jit_ctx *ctx)
> > >         emit_insn(ctx, alsld, t2, a2, a1, 2);
> > >         off =3D offsetof(struct bpf_array, ptrs);
> > >         emit_insn(ctx, ldd, t2, t2, off);
> > > +       jmp_offset =3D tc_ninsn - (ctx->idx - idx0);
> > >         /* beq $t2, $zero, jmp_offset */
> > >         if (emit_tailcall_jmp(ctx, BPF_JEQ, t2,
> > > LOONGARCH_GPR_ZERO, jmp_offset) < 0)
> > >                 goto toofar;
> > > @@ -263,22 +265,11 @@ static int emit_bpf_tail_call(struct
> > > jit_ctx *ctx)
> > >         emit_insn(ctx, ldd, t3, t2, off);
> > >         __build_epilogue(ctx, true);
> > >
> > > -       /* out: */
> > > -       if (out_offset =3D=3D -1)
> > > -               out_offset =3D cur_offset;
> > > -       if (cur_offset !=3D out_offset) {
> > > -               pr_err_once("tail_call out_offset =3D %d,
> > > expected %d!\n",
> > > -                           cur_offset, out_offset);
> > > -               return -1;
> > > -       }
> > > -
> > >         return 0;
> > >
> > >  toofar:
> > >         pr_info_once("tail_call: jump too far\n");
> > >         return -1;
> > > -#undef cur_offset
> > > -#undef jmp_offset
> > >  }
> > >
> > >  static void emit_atomic(const struct bpf_insn *insn, struct
> > > jit_ctx *ctx)
> > > @@ -916,7 +907,7 @@ static int build_insn(const struct bpf_insn
> > > *insn, struct jit_ctx *ctx, bool ext
> > >         /* tail call */
> > >         case BPF_JMP | BPF_TAIL_CALL:
> > >                 mark_tail_call(ctx);
> > > -               if (emit_bpf_tail_call(ctx) < 0)
> > > +               if (emit_bpf_tail_call(i, ctx) < 0)
> > >                         return -EINVAL;
> > >                 break;
> > >
> > > @@ -1342,7 +1333,6 @@ struct bpf_prog
> > > *bpf_int_jit_compile(struct bpf_prog *prog)
> > >         if (tmp_blinded)
> > >                 bpf_jit_prog_release_other(prog, prog =3D=3D
> > > orig_prog ? tmp : orig_prog);
> > >
> > > -       out_offset =3D -1;
> > >
> > >         return prog;
> > >
> > > --
> > > 2.43.0
> > >
>
>

