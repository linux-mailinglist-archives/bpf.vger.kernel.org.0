Return-Path: <bpf+bounces-17477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7037180E149
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 03:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2982D1F21C36
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 02:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20C3138E;
	Tue, 12 Dec 2023 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYQYOlBD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFBEDC;
	Mon, 11 Dec 2023 18:16:01 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5d4f71f7e9fso50692207b3.0;
        Mon, 11 Dec 2023 18:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702347360; x=1702952160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bAjE3baVrRo4/1Vx4v8GLgpMDVpdz7g2ycdmGyOX1k=;
        b=PYQYOlBDCHM/ElKH0G50fytd4R/0Ddb7DyaQzTR2BlyqthO0dgVE/Nd0NOdUB6nlWn
         mXVK/lTEeAqBYfsVYEs5oe2thvun4Gl5MR7CcfCiaiTp2P3p2R2zmcLSVFw9MtO701x/
         pPaC62FgrtzTA+pdry3WfMUdITiS/JK6aXMC/lhn0HBQHE5bQjsoQ+p2mqL4Vfr3p7MG
         bUJ1bAWuRbdA2F3UOd3893J9q6WqhJJvtMEKkzv2B7kPuSIpZ1h2cgE0QuX+0eSNTsbb
         Lky261q6QI9h29K8JSpFgcIOXQyqi1GdGyOzZQPlCRf2qyFGHkN4kD/TL261aItFnNCt
         qK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702347360; x=1702952160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bAjE3baVrRo4/1Vx4v8GLgpMDVpdz7g2ycdmGyOX1k=;
        b=xKZuobtLM+eovlqvxmkSO1fmbSKUsjqpx+y4ibDKoY6Zc8gn2d48usGtwM4MAT3AKT
         +4SwNHAhFsXv7LBteWt4wekOPi4wnPzJTgitsCS5ZhRnJLizcwrxL94k1l/ioVkru6e0
         V05seHwfxxC90qn1B91ftUxkeM6yMgNprlnkm3FFBfPcIeYtyXBL2LQIhj38ld03UTfA
         H+AY4AA9wFnsJFrag5ciC9X6WZKHVXMY6Cz1eXcYcDVHERwmpEHdMeIKvnFQj75CZj4r
         9ZDofcRvKil51sHmHSnpUp8gKPtfP9bqVqSvsSUoBqAKCYHeiPcbxSx0IkJEasYLxCia
         RZPA==
X-Gm-Message-State: AOJu0YwEjMnhjxaNNXOF4yVo1pXpa10qgJ0nQv8FZ53T7WRXILOFLubM
	PSN9NgREtFHrobs05kc1VQqjT5ATEIBSPsvymT0=
X-Google-Smtp-Source: AGHT+IEYUyLvw9c+mHMwkLxM1UZ1Jw8iW1DGz6JnOYejP7gOCE/U6/M00nWkyQ9EsA/C1gEI/7B9mclagQ+lcOUQcJ0=
X-Received: by 2002:a25:aa01:0:b0:db7:dacf:6211 with SMTP id
 s1-20020a25aa01000000b00db7dacf6211mr3149791ybi.99.1702347360532; Mon, 11 Dec
 2023 18:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210130001.2050847-1-menglong8.dong@gmail.com> <CAEf4BzYUKkpFa5dp4Ye7jzK1RhYtS6Yv55GH18U21Qi6xxQetg@mail.gmail.com>
In-Reply-To: <CAEf4BzYUKkpFa5dp4Ye7jzK1RhYtS6Yv55GH18U21Qi6xxQetg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 12 Dec 2023 10:15:49 +0800
Message-ID: <CADxym3ZZ2uV45Ra_vKSEK68qdnAiL-6XpNO2hSfUtyj3OeypwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make the verifier trace the "not qeual" for regs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:16=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Dec 10, 2023 at 5:00=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > We can derive some new information for BPF_JNE in regs_refine_cond_op()=
.
> > Take following code for example:
> >
> >   /* The type of "a" is u16 */
> >   if (a > 0 && a < 100) {
> >     /* the range of the register for a is [0, 99], not [1, 99],
> >      * and will cause the following error:
> >      *
> >      *   invalid zero-sized read
> >      *
> >      * as a can be 0.
> >      */
> >     bpf_skb_store_bytes(skb, xx, xx, a, 0);
> >   }
> >
> > In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0".=
 In the
> > TRUE branch, the dst_reg will be marked as known to 0. However, in the
> > fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> > the [min, max] for a is [0, 99], not [1, 99].
> >
> > For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> > const and is exactly the edge of the dst reg.
> >
> > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 727a59e4a647..7b074ac93190 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1764,6 +1764,40 @@ static void __mark_reg_const_zero(struct bpf_reg=
_state *reg)
> >         reg->type =3D SCALAR_VALUE;
> >  }
> >
> > +#define CHECK_REG_MIN(value)                   \
> > +do {                                           \
> > +       if ((value) =3D=3D (typeof(value))imm)      \
> > +               value++;                        \
> > +} while (0)
> > +
> > +#define CHECK_REG_MAX(value)                   \
> > +do {                                           \
> > +       if ((value) =3D=3D (typeof(value))imm)      \
> > +               value--;                        \
> > +} while (0)
> > +
> > +static void mark_reg32_not_equal(struct bpf_reg_state *reg, u64 imm)
> > +{
> > +               CHECK_REG_MIN(reg->s32_min_value);
> > +               CHECK_REG_MAX(reg->s32_max_value);
> > +               CHECK_REG_MIN(reg->u32_min_value);
> > +               CHECK_REG_MAX(reg->u32_max_value);
> > +}
> > +
> > +static void mark_reg_not_equal(struct bpf_reg_state *reg, u64 imm)
> > +{
> > +               CHECK_REG_MIN(reg->smin_value);
> > +               CHECK_REG_MAX(reg->smax_value);
> > +
> > +               CHECK_REG_MIN(reg->umin_value);
> > +               CHECK_REG_MAX(reg->umax_value);
> > +
> > +               CHECK_REG_MIN(reg->s32_min_value);
> > +               CHECK_REG_MAX(reg->s32_max_value);
> > +               CHECK_REG_MIN(reg->u32_min_value);
> > +               CHECK_REG_MAX(reg->u32_max_value);
> > +}
>
> please don't use macros for this, this code is tricky enough without
> having to jump around double-checking what exactly macros are doing.
> Just code it explicitly.
>

Okay!

> Also I don't see the need for mark_reg32_not_equal() and
> mark_reg_not_equal() helper functions, there is just one place where
> this logic is going to be called from, so let's add code right there.
>

Yeah, you are right. And I just found that you have already
implemented the test case for this logic in reg_bounds.c/range_cond().
I wonder why this logic is not implemented in the verifier yet?
Am I missing something?

Thanks!
Menglong Dong

> > +
> >  static void mark_reg_known_zero(struct bpf_verifier_env *env,
> >                                 struct bpf_reg_state *regs, u32 regno)
> >  {
> > @@ -14332,7 +14366,16 @@ static void regs_refine_cond_op(struct bpf_reg=
_state *reg1, struct bpf_reg_state
> >                 }
> >                 break;
> >         case BPF_JNE:
> > -               /* we don't derive any new information for inequality y=
et */
> > +               /* try to recompute the bound of reg1 if reg2 is a cons=
t and
> > +                * is exactly the edge of reg1.
> > +                */
> > +               if (is_reg_const(reg2, is_jmp32)) {
> > +                       val =3D reg_const_value(reg2, is_jmp32);
> > +                       if (is_jmp32)
> > +                               mark_reg32_not_equal(reg1, val);
> > +                       else
> > +                               mark_reg_not_equal(reg1, val);
> > +               }
> >                 break;
> >         case BPF_JSET:
> >                 if (!is_reg_const(reg2, is_jmp32))
> > --
> > 2.39.2
> >

