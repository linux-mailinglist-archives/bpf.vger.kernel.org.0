Return-Path: <bpf+bounces-67376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A412B42F55
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 04:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D31560309
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0346619DFA2;
	Thu,  4 Sep 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROVnzJLa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742112BCFB
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951525; cv=none; b=ljEaMXqjT+66ydeS+FQefrB8OuDqunR5/3iIojU+oSFsXeYACepfE/4hKvXpVlz+Ltgus7thOU5EdEmvhYUlhyhdIlOncTZLMoxgzNCjXnvUT801SW6v3EJF53KCHZMIdUuo+mpXcVctZcW+ussMxhTXJlZpuLphXOpUSScblho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951525; c=relaxed/simple;
	bh=EcmLyUmaJSnsZ4m7Vz+cq7ZSHtA17vgA8VpOs1nG9zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDtaahPUUi1algwZSUKAK4VvPSL5tDQ9nT5HXm4DufCOWixX94evV/lXVVqXRgqggIaqnl+ntTMX9QSsMox676fulp4lEoCbsK3nV8R1P/Q83lLcdpXxprkUPdYKPw2SmLEkuNjAyarPSXNsqU86QFpbNpXlOAKdkuXslz/GV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROVnzJLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB5C4AF0B
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756951525;
	bh=EcmLyUmaJSnsZ4m7Vz+cq7ZSHtA17vgA8VpOs1nG9zY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ROVnzJLaRC1atPN8tAbCQts19W2AgbNgKBzwWUGnyQgAsqw88kLYE9DuTEeT1IBUu
	 m1jBvr5EwVRLcV4hs+y0OEVwotDtkut4m/7keHBv1GfEqmxDz3yliqhOwrQKu7u1kR
	 TNyuLsIub7BtWqn2qjfoUy5JxinWRxGcwC3cnUjW1PP+Q8Pon5Y+yiYzvNHeVT/l/g
	 UkFU3C86DNSu/XTcf08VjTvsURLBQU57zDQUmq6qMxSbaSQrKXCi/ksvWYgA1UafaE
	 iGklxMw0Tfih4HsvxBETlqxBf/hJ1vQfAUQPET0pO6AUp6alVlCZ8LtzuxenuTQSZg
	 sDC2xO+WNqQLQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aff0365277aso262918866b.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 19:05:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg6wC8RzR5XJ1TdlK95D0897xVUy7CEKB6x9Cfftp9mLMIxxb8AliUjvFj0C/PYRtfuvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHznxKTcG0wD2pZix6ohtKxs09fhVfpsUbPYJkc4MmwKQzRQYU
	7W/fSxRAjf8QhGwORRMuxNWaoTbCMF4Y4ogpHRGeSPguBbkyfGkuWWlyukwy6Ujkpc1C06mgzg8
	lUTL5EzIUcFoKhdvmoWiXV31EhzMSVrM=
X-Google-Smtp-Source: AGHT+IHjriQlKp3GYroVH6XtP5FaVCKwBnc1pEuUukiybs7igtEwGx6wcsO7B/DcR30ckuCnFmNFLfO+GukyNyQTufY=
X-Received: by 2002:a17:906:f593:b0:b04:4579:486e with SMTP id
 a640c23a62f3a-b044579506cmr1058697466b.28.1756951523728; Wed, 03 Sep 2025
 19:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-5-hengqi.chen@gmail.com>
 <CAAhV-H4ZCM7uRB_oe__pJB_a1ei4+SPnVfT6c0JXvk4-HJg=bg@mail.gmail.com> <CAEyhmHTwEjsJp+roXOFLTEkDbVcKUU8PC=ba2JfvLZ29B2ZffA@mail.gmail.com>
In-Reply-To: <CAEyhmHTwEjsJp+roXOFLTEkDbVcKUU8PC=ba2JfvLZ29B2ZffA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Sep 2025 10:05:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ipLfK5TpoPYUCVuzmaR_a-22SG9fDFzwovOYBE8GyEQ@mail.gmail.com>
X-Gm-Features: Ac12FXwmICzE8z-tRZoeJwEXbcMEgUB9af_iG6woIqtTg2fbvE6Ur1SVDiu6Wmo
Message-ID: <CAAhV-H5ipLfK5TpoPYUCVuzmaR_a-22SG9fDFzwovOYBE8GyEQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] LoongArch: BPF: No text_poke() for kernel text
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:54=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> On Wed, Sep 3, 2025 at 10:52=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Hengqi,
> >
> > On Wed, Sep 3, 2025 at 8:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.c=
om> wrote:
> > >
> > > The current implementation of bpf_arch_text_poke() requires 5 nops
> > > at patch site which is not applicable for kernel/module functions.
> > > With CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy, this can be done
> > > by ftrace instead.
> > Does this mean BPF trampoline can only work with FTRACE enabled?
> >
>
> IIUC, with CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dn, we could still tr=
ace
> BPF progs with BPF trampoline.
I don't know, but I was confused by the commit message.

Huacai

>
> > Huacai
> >
> > >
> > > See the following commit for details:
> > >   * commit b91e014f078e ("bpf: Make BPF trampoline use register_ftrac=
e_direct() API")
> > >   * commit 9cdc3b6a299c ("LoongArch: ftrace: Add direct call support"=
)
> > >
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_ji=
t.c
> > > index 7b7e449b9ea9..35b13d91a979 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -1294,8 +1294,11 @@ int bpf_arch_text_poke(void *ip, enum bpf_text=
_poke_type poke_type,
> > >         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D =
INSN_NOP};
> > >         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D =
INSN_NOP};
> > >
> > > -       if (!is_kernel_text((unsigned long)ip) &&
> > > -               !is_bpf_text_address((unsigned long)ip))
> > > +       if (!is_bpf_text_address((unsigned long)ip))
> > > +               /* Only poking bpf text is supported. Since kernel fu=
nction
> > > +                * entry is set up by ftrace, we reply on ftrace to p=
oke kernel
> > > +                * functions.
> > > +                */
> > >                 return -ENOTSUPP;
> > >
> > >         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call);
> > > --
> > > 2.43.5
> > >

