Return-Path: <bpf+bounces-64584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DA2B14642
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 04:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3461AA22C9
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EED20FAB2;
	Tue, 29 Jul 2025 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy7hg/7M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BD20B7FB;
	Tue, 29 Jul 2025 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756348; cv=none; b=E5uqd0moinBrXfi5I2IfH5UpGNCSCWwDY+fSAArGfpICZniK8UX+/GLJVjkBIF61dAXxy8KfbWZDD/whaH/k0z5KG1AnyvoinJ5mpfKyoH+TaUC3eJb9k8KQaYIwCxv36PMCx1Gh1N+aex/NKyzMIUfmeotHnCzMoCbvzHC2kIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756348; c=relaxed/simple;
	bh=214Vu1ffBPktU4zJw5q/QLdFJzJeBpd2SMM/1kZ9pWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4aFaZ0mZ2PXL7qV5AbxSVsMjLiPpHCdM/RCj8mkAd7SYZMfXddKR3xtSIc2m5ga744YO9ZWAubwX5DiBP//RLfhXWTg2pVMJSjeO6D4LKPbtxtx2JwOW7tGnXB7XJbFgP/S7vGiJ/ktsMAnlwVaWW28fpnjqqrNe8xa7KdqMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy7hg/7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5158C4AF09;
	Tue, 29 Jul 2025 02:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753756347;
	bh=214Vu1ffBPktU4zJw5q/QLdFJzJeBpd2SMM/1kZ9pWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fy7hg/7Mm7/J/YtYfwuifdrBycJz/UpxBygCZf96Y4jheBIOERyB2ScM+kvwDbG8O
	 33cJdivo4K7u1AF5p56STlkhgpPb3R44GDUpF5EtHzNjKDmnj486bXm1D589JxYyN2
	 1x6ruENy3/6qFfewjAsQmqKsJ9yfzsggYfnCdxpzUXOTj9VWoJ75/hX7vQ6JcenEsN
	 dMvxgcqPSX/F9kNTepcdQSzUXatveEQMwNQAu0i5r07bOvuFBAd3hzwFC/zA5gR3D/
	 6DI8Ih5rZTNBTw36mZDgCZlt4iP7uQFEH0fGrx6tcPPDyfge1TBPxQxXGMs5FxSJyx
	 gW/uuT5KK21kg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso815161a12.3;
        Mon, 28 Jul 2025 19:32:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMpzVwGEfpCzgXhB2JD6olIAyIPU3wLP3naw6XjNT2+UdXBuEzzRPoMVRNmLZaiNouNOE=@vger.kernel.org, AJvYcCWXOGZ/iL/ZdzQV2JfvwbFTuVuhQz8bVdCsIMiHE2dPLI8LG1s6WQhr/rcQ3ybS8q3Bpl/B+uh30TlyUFQJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTIRC3XDmA9CAIPDhahnly4XVQYu04ChSX1HAQefwTcmCMfks
	WnKKmhKBQkbu7mByAyEuuBUXN+efY/9BkXEdKNEsknIew6lmKKLDkd0QkTqiEia0XXvK4EJNmDh
	TCqkwNfzvcYIzhOqJL4YHEqCP8cYfVi8=
X-Google-Smtp-Source: AGHT+IEyEgYXOlcJ/KxzsomCUTVUYXaylTxijnzLbrmtPgJGNNZcU+mGa2UAU09R42mZXbpSQUNxyFdtL6I7QjIU1ww=
X-Received: by 2002:a05:6402:4602:20b0:608:f493:871c with SMTP id
 4fb4d7f45d1cf-614f1d1feccmr9538648a12.14.1753756346458; Mon, 28 Jul 2025
 19:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724141929.691853-1-duanchenghao@kylinos.cn>
 <20250724141929.691853-6-duanchenghao@kylinos.cn> <CAEyhmHQKBQbidX_SpUF1ZPv7vkkhSR_UuRvxznyb6y5GYQS3qw@mail.gmail.com>
 <20250728133418.GC1439240@chenghao-pc>
In-Reply-To: <20250728133418.GC1439240@chenghao-pc>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 29 Jul 2025 10:32:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H40rAPvVRMMQTkxmOsT3yu6V+CL3MC2gi3jvsXZtOzdkw@mail.gmail.com>
X-Gm-Features: Ac12FXy7VhLUHjowAVkwszWoXXaUHctXHhAGiZ_PSv1z0L7OmXLEW1lwXO_c9K4
Message-ID: <CAAhV-H40rAPvVRMMQTkxmOsT3yu6V+CL3MC2gi3jvsXZtOzdkw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] LoongArch: BPF: Add struct ops support for trampoline
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yangtiezhu@loongson.cn, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:34=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> On Mon, Jul 28, 2025 at 06:55:52PM +0800, Hengqi Chen wrote:
> > On Thu, Jul 24, 2025 at 10:22=E2=80=AFPM Chenghao Duan <duanchenghao@ky=
linos.cn> wrote:
> > >
> > > From: Tiezhu Yang <yangtiezhu@loongson.cn>
> > >
> > > Use BPF_TRAMP_F_INDIRECT flag to detect struct ops and emit proper
> > > prologue and epilogue for this case.
> > >
> > > With this patch, all of the struct_ops related testcases (except
> > > struct_ops_multi_pages) passed on LoongArch.
> > >
> > > The testcase struct_ops_multi_pages failed is because the actual
> > > image_pages_cnt is 40 which is bigger than MAX_TRAMP_IMAGE_PAGES.
> > >
> > > Before:
> > >
> > >   $ sudo ./test_progs -t struct_ops -d struct_ops_multi_pages
> > >   ...
> > >   WATCHDOG: test case struct_ops_module/struct_ops_load executes for =
10 seconds...
> > >
> > > After:
> > >
> > >   $ sudo ./test_progs -t struct_ops -d struct_ops_multi_pages
> > >   ...
> > >   #15      bad_struct_ops:OK
> > >   ...
> > >   #399     struct_ops_autocreate:OK
> > >   ...
> > >   #400     struct_ops_kptr_return:OK
> > >   ...
> > >   #401     struct_ops_maybe_null:OK
> > >   ...
> > >   #402     struct_ops_module:OK
> > >   ...
> > >   #404     struct_ops_no_cfi:OK
> > >   ...
> > >   #405     struct_ops_private_stack:SKIP
> > >   ...
> > >   #406     struct_ops_refcounted:OK
> > >   Summary: 8/25 PASSED, 3 SKIPPED, 0 FAILED
> > >
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 71 ++++++++++++++++++++++++----------=
--
> > >  1 file changed, 47 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_ji=
t.c
> > > index ac5ce3a28..6a84fb104 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -1603,6 +1603,7 @@ static int __arch_prepare_bpf_trampoline(struct=
 jit_ctx *ctx, struct bpf_tramp_i
> > >         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> > >         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> > >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY=
_RETURN];
> > > +       bool is_struct_ops =3D flags & BPF_TRAMP_F_INDIRECT;
> > >         int ret, save_ret;
> > >         void *orig_call =3D func_addr;
> > >         u32 **branches =3D NULL;
> > > @@ -1678,18 +1679,31 @@ static int __arch_prepare_bpf_trampoline(stru=
ct jit_ctx *ctx, struct bpf_tramp_i
> > >
> > >         stack_size =3D round_up(stack_size, 16);
> > >
> > > -       /* For the trampoline called from function entry */
> > > -       /* RA and FP for parent function*/
> > > -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16=
);
> > > -       emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > > -       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > > -       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16)=
;
> > > -
> > > -       /* RA and FP for traced function*/
> > > -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -st=
ack_size);
> > > -       emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack=
_size - 8);
> > > -       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack=
_size - 16);
> > > -       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, sta=
ck_size);
> > > +       if (!is_struct_ops) {
> > > +               /*
> > > +                * For the trampoline called from function entry,
> > > +                * the frame of traced function and the frame of
> > > +                * trampoline need to be considered.
> > > +                */
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR=
_SP, -16);
> > > +               emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_S=
P, 8);
> > > +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_S=
P, 0);
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR=
_SP, 16);
> > > +
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR=
_SP, -stack_size);
> > > +               emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_S=
P, stack_size - 8);
> > > +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_S=
P, stack_size - 16);
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR=
_SP, stack_size);
> > > +       } else {
> > > +               /*
> > > +                * For the trampoline called directly, just handle
> > > +                * the frame of trampoline.
> > > +                */
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR=
_SP, -stack_size);
> > > +               emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_S=
P, stack_size - 8);
> > > +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_S=
P, stack_size - 16);
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR=
_SP, stack_size);
> > > +       }
> > >
> >
> > The diff removes code added in patch 4/5, this should be squashed to
> > the trampoline patch if possible.
>
> This patch was provided by Tiezhu Yang, and there was a discussion about
> it at the time.
> https://lore.kernel.org/all/cd190c8a-a7b9-53de-d363-c3d695fe3191@loongson=
.cn/
From my opinion I also prefer to squash.

Huacai

>
> >
> > >         /* callee saved register S1 to pass start time */
> > >         emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg=
_off);
> > > @@ -1779,21 +1793,30 @@ static int __arch_prepare_bpf_trampoline(stru=
ct jit_ctx *ctx, struct bpf_tramp_i
> > >
> > >         emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg=
_off);
> > >
> > > -       /* trampoline called from function entry */
> > > -       emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack=
_size - 8);
> > > -       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack=
_size - 16);
> > > -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, sta=
ck_size);
> > > +       if (!is_struct_ops) {
> > > +               /* trampoline called from function entry */
> > > +               emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_S=
P, stack_size - 8);
> > > +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_S=
P, stack_size - 16);
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR=
_SP, stack_size);
> > > +
> > > +               emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_S=
P, 8);
> > > +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_S=
P, 0);
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR=
_SP, 16);
> > >
> > > -       emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > > -       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > > -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16)=
;
> > > +               if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > > +                       /* return to parent function */
> > > +                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOON=
GARCH_GPR_RA, 0);
> > > +               else
> > > +                       /* return to traced function */
> > > +                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOON=
GARCH_GPR_T0, 0);
> > > +       } else {
> > > +               /* trampoline called directly */
> > > +               emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_S=
P, stack_size - 8);
> > > +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_S=
P, stack_size - 16);
> > > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR=
_SP, stack_size);
> > >
> > > -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > > -               /* return to parent function */
> > >                 emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GP=
R_RA, 0);
> > > -       else
> > > -               /* return to traced function */
> > > -               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GP=
R_T0, 0);
> > > +       }
> > >
> > >         ret =3D ctx->idx;
> > >  out:
> > > --
> > > 2.25.1
> > >

