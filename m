Return-Path: <bpf+bounces-17485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D787C80E305
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 04:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D623B218C7
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 03:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CBBE62;
	Tue, 12 Dec 2023 03:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldrVlpko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6460DA9;
	Mon, 11 Dec 2023 19:51:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c4846847eso15732305e9.1;
        Mon, 11 Dec 2023 19:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702353111; x=1702957911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9t8Uh8nCCzyBLBlXBQ6+uw2FgST0ZLpI7SAIJDg4Lo=;
        b=ldrVlpkoBM0CL6nHJM0sxg6+7ZqliGKSiNfbuuYPYJ6oOkXPnYq36Dt/dvpK6gk6Cs
         78WIVAX7qqI2XP5fxeAZBLGJuu2Nx1JbnH6GaShfCoFB7XrAqZH3srjms/nlX7MOUniC
         qeBwIcN4nz+K2KtIUvJZpsLCoAl0UZwT9IhDsHSQ3eGz0n1sQ/xt8jJnS7yEz586+df6
         CgCJCCBzQw0ECQ37lrXUKEgJjZX3eXbxeLTjLYXUMUCTjHzFtPX60oRoQVzc/dRFkOf3
         ecQcT5Gp4ppUtZwtq8NtoMwOxTOxctJAQIAUSoFmmydDdXRExZ/lZlflj24BGrzICTbC
         KLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702353111; x=1702957911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9t8Uh8nCCzyBLBlXBQ6+uw2FgST0ZLpI7SAIJDg4Lo=;
        b=RIr4+b7Iojpx3sLQ7XhQVfTHBz9SFcbKj9x7gyNw6rUg2xtUFePPlmvWYrdi98XmkV
         aE336eThoZy4AiGqjrh6gVto1DWrgfTEGOwCb7C34gO40/ahXPS2JP6G6ikhEs/Kh6lk
         3C+GM013pvPT13nvLyDryM8j6VpEz+C47z4POGdBVEwMdAmmCLtgziA71DXlmSG+DfCQ
         xvzTXW1eicq+LD3RKg7E4GuFg6yJipgwLmf3TAbXJh0XGDaAcq+oXILWriFdUlp32eY/
         sfAwrNStEQSJBLF8i/rkXqXhcOHgXS9k1u5cRzGCRIVNUwcz2UUKrg5JfCo+Znqq1bGF
         cXpg==
X-Gm-Message-State: AOJu0YzKN3EdEJCdqIOE/iGD3tGbYei8Z2YmuEYvh7r+pKz436odtYRT
	GIAaE3u6WWAnNv10hI5lRsddYcBzT9NdXdxuWVlkm8r+
X-Google-Smtp-Source: AGHT+IHoSS1ppqRYRCHhpxPQ4k/4M1aBgx8BJW4a9Aqyho4e4R7nz4hNfw2kGXiLzsjOlB+tgvCMBlDRbtTLl6FAstQ=
X-Received: by 2002:a05:600c:228c:b0:40c:f4d:60a6 with SMTP id
 12-20020a05600c228c00b0040c0f4d60a6mr2735018wmf.44.1702353110492; Mon, 11 Dec
 2023 19:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210130001.2050847-1-menglong8.dong@gmail.com>
 <CAEf4BzYUKkpFa5dp4Ye7jzK1RhYtS6Yv55GH18U21Qi6xxQetg@mail.gmail.com> <CADxym3ZZ2uV45Ra_vKSEK68qdnAiL-6XpNO2hSfUtyj3OeypwA@mail.gmail.com>
In-Reply-To: <CADxym3ZZ2uV45Ra_vKSEK68qdnAiL-6XpNO2hSfUtyj3OeypwA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Dec 2023 19:51:38 -0800
Message-ID: <CAEf4BzbLs7YRVYycTwE8aQH_vnaypDvO4W1a7gy1P20SmquC+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make the verifier trace the "not qeual" for regs
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 6:16=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Tue, Dec 12, 2023 at 3:16=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Dec 10, 2023 at 5:00=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > We can derive some new information for BPF_JNE in regs_refine_cond_op=
().
> > > Take following code for example:
> > >
> > >   /* The type of "a" is u16 */
> > >   if (a > 0 && a < 100) {
> > >     /* the range of the register for a is [0, 99], not [1, 99],
> > >      * and will cause the following error:
> > >      *
> > >      *   invalid zero-sized read
> > >      *
> > >      * as a can be 0.
> > >      */
> > >     bpf_skb_store_bytes(skb, xx, xx, a, 0);
> > >   }
> > >
> > > In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0=
". In the
> > > TRUE branch, the dst_reg will be marked as known to 0. However, in th=
e
> > > fallthrough(FALSE) branch, the dst_reg will not be handled, which mak=
es
> > > the [min, max] for a is [0, 99], not [1, 99].
> > >
> > > For BPF_JNE, we can reduce the range of the dst reg if the src reg is=
 a
> > > const and is exactly the edge of the dst reg.
> > >
> > > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 45 +++++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 44 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 727a59e4a647..7b074ac93190 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -1764,6 +1764,40 @@ static void __mark_reg_const_zero(struct bpf_r=
eg_state *reg)
> > >         reg->type =3D SCALAR_VALUE;
> > >  }
> > >
> > > +#define CHECK_REG_MIN(value)                   \
> > > +do {                                           \
> > > +       if ((value) =3D=3D (typeof(value))imm)      \
> > > +               value++;                        \
> > > +} while (0)
> > > +
> > > +#define CHECK_REG_MAX(value)                   \
> > > +do {                                           \
> > > +       if ((value) =3D=3D (typeof(value))imm)      \
> > > +               value--;                        \
> > > +} while (0)
> > > +
> > > +static void mark_reg32_not_equal(struct bpf_reg_state *reg, u64 imm)
> > > +{
> > > +               CHECK_REG_MIN(reg->s32_min_value);
> > > +               CHECK_REG_MAX(reg->s32_max_value);
> > > +               CHECK_REG_MIN(reg->u32_min_value);
> > > +               CHECK_REG_MAX(reg->u32_max_value);
> > > +}
> > > +
> > > +static void mark_reg_not_equal(struct bpf_reg_state *reg, u64 imm)
> > > +{
> > > +               CHECK_REG_MIN(reg->smin_value);
> > > +               CHECK_REG_MAX(reg->smax_value);
> > > +
> > > +               CHECK_REG_MIN(reg->umin_value);
> > > +               CHECK_REG_MAX(reg->umax_value);
> > > +
> > > +               CHECK_REG_MIN(reg->s32_min_value);
> > > +               CHECK_REG_MAX(reg->s32_max_value);
> > > +               CHECK_REG_MIN(reg->u32_min_value);
> > > +               CHECK_REG_MAX(reg->u32_max_value);
> > > +}
> >
> > please don't use macros for this, this code is tricky enough without
> > having to jump around double-checking what exactly macros are doing.
> > Just code it explicitly.
> >
>
> Okay!
>
> > Also I don't see the need for mark_reg32_not_equal() and
> > mark_reg_not_equal() helper functions, there is just one place where
> > this logic is going to be called from, so let's add code right there.
> >
>
> Yeah, you are right. And I just found that you have already
> implemented the test case for this logic in reg_bounds.c/range_cond().
> I wonder why this logic is not implemented in the verifier yet?
> Am I missing something?

No, I just didn't want to add yet more verifier changes in my original
patch set on extending reg bounds logic.

>
> Thanks!
> Menglong Dong
>
> > > +
> > >  static void mark_reg_known_zero(struct bpf_verifier_env *env,
> > >                                 struct bpf_reg_state *regs, u32 regno=
)
> > >  {
> > > @@ -14332,7 +14366,16 @@ static void regs_refine_cond_op(struct bpf_r=
eg_state *reg1, struct bpf_reg_state
> > >                 }
> > >                 break;
> > >         case BPF_JNE:
> > > -               /* we don't derive any new information for inequality=
 yet */
> > > +               /* try to recompute the bound of reg1 if reg2 is a co=
nst and
> > > +                * is exactly the edge of reg1.
> > > +                */
> > > +               if (is_reg_const(reg2, is_jmp32)) {
> > > +                       val =3D reg_const_value(reg2, is_jmp32);
> > > +                       if (is_jmp32)
> > > +                               mark_reg32_not_equal(reg1, val);
> > > +                       else
> > > +                               mark_reg_not_equal(reg1, val);
> > > +               }
> > >                 break;
> > >         case BPF_JSET:
> > >                 if (!is_reg_const(reg2, is_jmp32))
> > > --
> > > 2.39.2
> > >

