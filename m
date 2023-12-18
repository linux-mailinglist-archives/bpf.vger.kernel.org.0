Return-Path: <bpf+bounces-18224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAF881786B
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26D41C2340C
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A285B1E6;
	Mon, 18 Dec 2023 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA9lV8xv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968EF4FF6D
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5534d8fcf7bso1536994a12.3
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 09:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702919930; x=1703524730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGX02alCJL6O0Acjxvn4MP5hclERZRb08FfwMLncJmw=;
        b=aA9lV8xv25axt4MAd48ALKQ8m8tC3prH887vujq2rU6MBahc4kfhhl7Sm0c8T48M8g
         BknkQ0YCphJ20mgy+FyzUC6eNWU3nLMXL3FidLnTafgrEzTlrB5/E+BEVySEqO17h867
         Gvnk9AHrCG99GaEJrhMh6qMu2yIef69WC2RjbyoDzj8ntu7hnHY8kwrEqGHEc5Qz/Wl9
         5x15jcBS8juwVehoOh5NiP8OodLxlSqqarTy2fZQMj0RYt6xnod2QJVfKPoUcfZzZmtI
         M7VGOvGBgf0n/1e84mrcc0a8J13IjHbHWeynC4+xDJc2iK+A/d6pWfuhTb0L7PO1hXhQ
         H3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919930; x=1703524730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGX02alCJL6O0Acjxvn4MP5hclERZRb08FfwMLncJmw=;
        b=b57Jo16nHH+SAVerbVkmgndWeyajdoOU20Af+f/c7Q0SY7+cN1haavZ90rIpM+CR0V
         SX1I+Dgyy9pIyfo9H7h5YsAQxJjQMwOpQW1CsZK1Pnr5V+1mxXDOYC8Kz+YnIp6Ez5sG
         +S+yZ1CFUmqkrRUSv+BCGui2AWictGJhV30U+LJ8XW1nNsVMY5WGpb3V/GpWVpaVbo3S
         1Hdrh+6z2z7e7pSoEbEcHXrDcw/ghfyKTV4HGlWxnkn1M8IhLpLHe2jS0h/EvT8jND4v
         07AviTaCnAocpXiMh3qwt5QahJ8YcYOJr+tcjogCepntEtTORovf3uiXDRGXSCmQkwZ8
         SD5A==
X-Gm-Message-State: AOJu0Yz0dTO5/eVjV84rmK/yqUQJfZs5bsJ3/KMJgair2n5eomkcYv/6
	uBb2eDQSgefNDU++xGlVAbo7cktFl5QMVmRa4Pk=
X-Google-Smtp-Source: AGHT+IGtu/uEC6lqZmrRVDqhvJoMBcCoRjjFKtvZIyNIygNLlk1/AqUZzUD5TZ0hNtRItzaU4kgy0Ed3Bj/o1wmVG8c=
X-Received: by 2002:a50:96c2:0:b0:553:6543:438e with SMTP id
 z2-20020a5096c2000000b005536543438emr621024eda.54.1702919929479; Mon, 18 Dec
 2023 09:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215235822.908223-1-andrii@kernel.org> <f1161484-c38c-4178-1163-ac9b14c20715@iogearbox.net>
In-Reply-To: <f1161484-c38c-4178-1163-ac9b14c20715@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 09:18:36 -0800
Message-ID: <CAEf4Bza7YzwWzwmTxGo6uBayLB3c7ybx1nU=c6=kwckjLh0ZjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: ensure precise is reset to false in __mark_reg_const_zero()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, kernel-team@meta.com, 
	Maxim Mikityanskiy <maxtram95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:46=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 12/16/23 12:58 AM, Andrii Nakryiko wrote:
> > It is safe to always start with imprecise SCALAR_VALUE register.
> > Previously __mark_reg_const_zero() relied on caller to reset precise
> > mark, but it's very error prone and we already missed it in a few
> > places. So instead make __mark_reg_const_zero() reset precision always,
> > as it's a safe default for SCALAR_VALUE. Explanation is basically the
> > same as for why we are resetting (or rather not setting) precision in
> > current state. If necessary, precision propagation will set it to
> > precise correctly.
> >
> > As such, also remove a big comment about forward precision propagation
> > in mark_reg_stack_read() and avoid unnecessarily setting precision to
> > true after reading from STACK_ZERO stack. Again, precision propagation
> > will correctly handle this, if that SCALAR_VALUE register will ever be
> > needed to be precise.
> >
> > Reported-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   kernel/bpf/verifier.c                            | 16 +++------------=
-
> >   .../selftests/bpf/progs/verifier_spill_fill.c    | 10 ++++++++--
> >   2 files changed, 11 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1863826a4ac3..3009d1faec86 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1781,6 +1781,7 @@ static void __mark_reg_const_zero(struct bpf_reg_=
state *reg)
> >   {
> >       __mark_reg_known(reg, 0);
> >       reg->type =3D SCALAR_VALUE;
> > +     reg->precise =3D false; /* all scalars are assumed imprecise init=
ially */
>
> Could you elaborate on why it is safe to set it to false instead of using=
:
>
>    reg->precise =3D !env->bpf_capable;
>
> For !cap_bpf we typically always set precise requirement to true, see als=
o
> __mark_reg_unknown().

Oh, you are right, I forgot about unpriv. I'll send v2 taking unpriv
into account, thanks!

Let's also try this new fancy thing:

pw-bot: cr

>
> >   }
> >
> >   static void mark_reg_known_zero(struct bpf_verifier_env *env,
> > @@ -4706,21 +4707,10 @@ static void mark_reg_stack_read(struct bpf_veri=
fier_env *env,
> >               zeros++;
> >       }
> >       if (zeros =3D=3D max_off - min_off) {
> > -             /* any access_size read into register is zero extended,
> > -              * so the whole register =3D=3D const_zero
> > +             /* Any access_size read into register is zero extended,
> > +              * so the whole register =3D=3D const_zero.
> >                */
> >               __mark_reg_const_zero(&state->regs[dst_regno]);
> > -             /* backtracking doesn't support STACK_ZERO yet,
> > -              * so mark it precise here, so that later
> > -              * backtracking can stop here.
> > -              * Backtracking may not need this if this register
> > -              * doesn't participate in pointer adjustment.
> > -              * Forward propagation of precise flag is not
> > -              * necessary either. This mark is only to stop
> > -              * backtracking. Any register that contributed
> > -              * to const 0 was marked precise before spill.
> > -              */
> > -             state->regs[dst_regno].precise =3D true;
> >       } else {
> >               /* have read misc data from the stack */
> >               mark_reg_unknown(env, state->regs, dst_regno);
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/=
tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > index 508f5d6c7347..39fe3372e0e0 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > @@ -499,8 +499,14 @@ __success
> >   __msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0=
0000000")
> >   /* but fp-16 is spilled IMPRECISE zero const reg */
> >   __msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 f=
p-16_w=3D0")
> > -/* and now check that precision propagation works even for such tricky=
 case */
> > -__msg("10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3DP0 R10=3Dfp0 f=
p-16_w=3D0")
> > +/* validate that assigning R2 from STACK_ZERO doesn't mark register
> > + * precise immediately; if necessary, it will be marked precise later
> > + */
> > +__msg("6: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp=
-8_w=3D00000000")
> > +/* similarly, when R2 is assigned from spilled register, it is initial=
ly
> > + * imprecise, but will be marked precise later once it is used in prec=
ise context
> > + */
> > +__msg("10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3D0 R10=3Dfp0 fp=
-16_w=3D0")
> >   __msg("11: (0f) r1 +=3D r2")
> >   __msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
> >   __msg("mark_precise: frame0: regs=3Dr2 stack=3D before 10: (71) r2 =
=3D *(u8 *)(r10 -9)")
> >
>

