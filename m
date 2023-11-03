Return-Path: <bpf+bounces-14118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 142207E0A6A
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A72BB2148A
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 20:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F01D557;
	Fri,  3 Nov 2023 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2U8ShQR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56DD18E1F
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 20:39:51 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B10D58
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 13:39:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-540fb78363bso4186394a12.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699043987; x=1699648787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/SfifdV4f8YuBpCp7f6VLD5a+Y8KBCTINmAkZ6bus=;
        b=h2U8ShQReJnRd6TFpEzBmgY1z/smRLmvsltrrG3s3T8tIFgYYqJdJknwhd21DoFfoJ
         WU/1t0cB7ViVzhOx+xE/wV6W1lK3pPv9syHydIb9u4sWiH+UgJOYWX9ReaXXzlSoMClp
         P8F2JoNHz+AEUBjbkv3NDBkJ0g1IQAupM4NG0ax2g3/73NKUNdt7im12wueeZSzDRSGB
         j4FlYPcEUffafAakHvMCrkfJ5uIXoeXpxzC6fXfYYFicILM5OpKPiwTnM6Q95hT1oAt+
         NFMj5TguaweHBlkQ3WoDb6oVMq2Mb+VsH5pw2qoIt2QirxfoRYHLo+3+a4Zjmqigolw1
         hmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699043987; x=1699648787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX/SfifdV4f8YuBpCp7f6VLD5a+Y8KBCTINmAkZ6bus=;
        b=IuewbkwJLV2r8bjAclf0yPQpNF0Kg7B5T+/w0o/WiEgRLejNhw/dvc+KfFzTELHli4
         rr1SmtZKUlhpV14R5p9kIGmqXdkkyROMrlgVlB42tL/eKRP3SAfW0R8+RXc6WxRYznxt
         KFnNKkWshMhOm9r1w5HnR0ud1P7tFRJ8Zi76CP+0SQA35mo5zMBxLKq6t4XkCLB5SCul
         ueX6skGbm+CaRn4hOsxfWCZ9sqXHHO3N4rfTqwPZupfqcGfbVbyU5HxV4XvArS4DUWnd
         i5Gn3Wk5Ep2rxjBy4y6INlT14pVvKLfIkx0fVPu7exDU8RqGCXlLmHQGk3vH2tV1DWjh
         6dzQ==
X-Gm-Message-State: AOJu0YyVG0tgVLj/QjM3PyLyW7rx94lOqXclxFS+RuOpCGzN5heYvfzp
	ZUg8emCrshKwoY8R4zj+7dLCH7/CVPkXa2k6ryJOEaYHBUM=
X-Google-Smtp-Source: AGHT+IGPDIgY1g9JWA0+7Y1yiBtJLWb1VgdwY6RB8HgsMabn+2HrYHMMi4/VZvAArbmz6NRyRVOrC8qNUlGGC03pUMg=
X-Received: by 2002:a17:907:3ea7:b0:9d3:afe1:b3e5 with SMTP id
 hs39-20020a1709073ea700b009d3afe1b3e5mr7996889ejc.75.1699043987186; Fri, 03
 Nov 2023 13:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-2-andrii@kernel.org>
 <b99914bb8d6eb723b473a4a9400382dbb7a468a0.camel@gmail.com>
In-Reply-To: <b99914bb8d6eb723b473a4a9400382dbb7a468a0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 13:39:35 -0700
Message-ID: <CAEf4Bzb=1nObyBQJWcfm6J2fOXGtjHmoeOz_eBMkmGgtx9Uj_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/13] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 9:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> > Generalize bounds adjustment logic of reg_set_min_max() to handle not
> > just register vs constant case, but in general any register vs any
> > register cases. For most of the operations it's trivial extension based
> > on range vs range comparison logic, we just need to properly pick
> > min/max of a range to compare against min/max of the other range.
> >
> > For BPF_JSET we keep the original capabilities, just make sure JSET is
> > integrated in the common framework. This is manifested in the
> > internal-only BPF_KSET + BPF_X "opcode" to allow for simpler and more
> > uniform rev_opcode() handling. See the code for details. This allows to
> > reuse the same code exactly both for TRUE and FALSE branches without
> > explicitly handling both conditions with custom code.
> >
> > Note also that now we don't need a special handling of BPF_JEQ/BPF_JNE
> > case none of the registers are constants. This is now just a normal
> > generic case handled by reg_set_min_max().
> >
> > To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> > that's a common operator when dealing with 32-bit subregister bounds.
> > This keeps the overall logic much less noisy when it comes to tnums.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> (With one bit of a bikeshedding below).
>
> > ---
> >  include/linux/tnum.h  |   4 +
> >  kernel/bpf/tnum.c     |   7 +-
> >  kernel/bpf/verifier.c | 327 ++++++++++++++++++++----------------------
> >  3 files changed, 165 insertions(+), 173 deletions(-)
> >

please trim irrelevant parts

[...]

> >       case BPF_JSGE:
> > +             if (is_jmp32) {
> > +                     reg1->s32_min_value =3D max(reg1->s32_min_value, =
reg2->s32_min_value);
> > +                     reg2->s32_max_value =3D min(reg1->s32_max_value, =
reg2->s32_max_value);
> > +             } else {
> > +                     reg1->smin_value =3D max(reg1->smin_value, reg2->=
smin_value);
> > +                     reg2->smax_value =3D min(reg1->smax_value, reg2->=
smax_value);
> > +             }
> > +             break;
> >       case BPF_JSGT:
>
> It is possible to spare some code by swapping arguments here:
>
>         case BPF_JLE:
>         case BPF_JLT:
>         case BPF_JSLE:
>         case BPF_JSLT:
>                 return regs_refine_cond_op(reg2, reg1, flip_opcode(opcode=
), is_jmp32);

yep, math is nice like that :) I'm a bit hesitant to add
recursive-looking calls (even though it's not recursion), so maybe
I'll just do:

case BPF_JLE:
case BPF_JLT:
case BPF_JSLE:
case BPF_JSLT:
    opcode =3D flip_opcode(opcode);
    swap(reg1, reg2);
    goto again;


and goto again will just jump to the beginning of this function?

Oh, and I more naturally think about LT/LE as "base conditions", so
I'll do the above for GE/GT operations.


>
>
> > -     {
> >               if (is_jmp32) {
> > -                     s32 false_smax =3D opcode =3D=3D BPF_JSGT ? sval3=
2    : sval32 - 1;
> > -                     s32 true_smin =3D opcode =3D=3D BPF_JSGT ? sval32=
 + 1 : sval32;
> > -
> > -                     false_reg1->s32_max_value =3D min(false_reg1->s32=
_max_value, false_smax);
> > -                     true_reg1->s32_min_value =3D max(true_reg1->s32_m=
in_value, true_smin);
> > +                     reg1->s32_min_value =3D max(reg1->s32_min_value, =
reg2->s32_min_value + 1);
> > +                     reg2->s32_max_value =3D min(reg1->s32_max_value -=
 1, reg2->s32_max_value);

[...]

