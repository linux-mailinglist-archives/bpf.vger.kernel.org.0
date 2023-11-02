Return-Path: <bpf+bounces-13967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929067DF780
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1ADAB2126F
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F81DA32;
	Thu,  2 Nov 2023 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V84qIqJe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EDA1CF86
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:17:48 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89C5E3
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:17:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d465d1c86bso176679966b.3
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698941865; x=1699546665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49qVOxo7kMNUOg/8B4OPZT3JVkHLpAZ2Q9Jr3+Ry4OM=;
        b=V84qIqJeZWG0sxkeeIXmQ1xqJRd9JGAdBaE8yvrCbrj0SIKi+iaNTNbyJUzl6A0csq
         a2dEPihJmXV5n8q+yeNzx9C1mwYLz7EijaYzkGCT8aQ8BBlmiBzaoRNOJJb2zeiGbG74
         uzhLXC55toGOjC0PWHOPl0jiZYA+7muwYUOGT4DQ/CV9FwiHnp10SE1p/vEo8EIkCCfH
         MPHWWIVRPyPCHZNegZmLh6iuJwP5rDwxSJUfEwor/nSGwKIg/1nj5afeK67KR35To6bX
         8a6ZoWnaTyNcx4Bir7hoJrtZZexcpoZVojchGw54rDjPlnXU70gVCS0NaAbyupRbl5iW
         eiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698941865; x=1699546665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49qVOxo7kMNUOg/8B4OPZT3JVkHLpAZ2Q9Jr3+Ry4OM=;
        b=ODWxfUqSILIJjXokTAdmlqYR/+c7JYZyzPkC/zgg88WpNckXJTsbyQjB5k80kiChc2
         Rrev8iwYYhV+6Loyhe8UlOZ3cR1JgepIo4FU7Uz8VCpCJ4gzF3Fkh1+gr/XpOp6Byp99
         uHzcsv1s+mMGObyRSpnzxgjFrLoSYXLirSel4+P7ODws/TMD4TysrND7sKG4K0vLftKl
         Hwbqlge9L9+B5mZJllY1OTqEfJUiz0eu6OZabEjn+r6FvK+/8MKzfU2Eaha6nCDgJYgH
         ikntujQT2q5XCc84U+4LjIMF2AhLtFFLW4djLebOa5wdboJ6I/fH99DmCkKIy4+YgUB4
         iqag==
X-Gm-Message-State: AOJu0Yxd12YIkSe2B/iDmY8lW/TcUZYRH6pykboAoghXMAUF9KUOkjhP
	PM2WPRZP9cW/5jrrFgqoxA/t3+cnP9dzo/WLDpQZnEUB
X-Google-Smtp-Source: AGHT+IFdET5oOBOx/5D7I4zNXHIBNReLeZd4Yz3v/38DLD9IxSMYM+37wftAcQqH8zb+lkNIn9UwmFlzQ6fBlVsHfRA=
X-Received: by 2002:a17:906:eece:b0:9d3:f436:6806 with SMTP id
 wu14-20020a170906eece00b009d3f4366806mr4294198ejb.47.1698941864911; Thu, 02
 Nov 2023 09:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102033759.2541186-1-andrii@kernel.org> <20231102033759.2541186-8-andrii@kernel.org>
 <ZUO0rzR3O0Ib5hwR@u94a>
In-Reply-To: <ZUO0rzR3O0Ib5hwR@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 09:17:33 -0700
Message-ID: <CAEf4BzZZnPMO1z66vFWtxt=jQH4AFFSDkONwNLS6OSM9EZ_eZg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 07/17] bpf: improve deduction of 64-bit bounds
 from 32-bit bounds
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 7:40=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> On Wed, Nov 01, 2023 at 08:37:49PM -0700, Andrii Nakryiko wrote:
> > Add a few interesting cases in which we can tighten 64-bit bounds based
> > on newly learnt information about 32-bit bounds. E.g., when full u64/s6=
4
> > registers are used in BPF program, and then eventually compared as
> > u32/s32. The latter comparison doesn't change the value of full
> > register, but it does impose new restrictions on possible lower 32 bits
> > of such full registers. And we can use that to derive additional full
> > register bounds information.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>
> One question below
>
> > ---
> >  kernel/bpf/verifier.c | 44 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 08888784cbc8..d0d0a1a1b662 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2536,10 +2536,54 @@ static void __reg64_deduce_bounds(struct bpf_re=
g_state *reg)
> >       }
> >  }
> >
> > +static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
> > +{
> > +     /* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-b=
it
> > +      * values on both sides of 64-bit range in hope to have tigher ra=
nge.
> > +      * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
> > +      * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fff=
ffff].
> > +      * With this, we can substitute 1 as low 32-bits of _low_ 64-bit =
bound
> > +      * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
> > +      * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at=
 a
> > +      * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
> > +      * We just need to make sure that derived bounds we are intersect=
ing
> > +      * with are well-formed ranges in respecitve s64 or u64 domain, j=
ust
> > +      * like we do with similar kinds of 32-to-64 or 64-to-32 adjustme=
nts.
> > +      */
> > +     __u64 new_umin, new_umax;
> > +     __s64 new_smin, new_smax;
> > +
> > +     /* u32 -> u64 tightening, it's always well-formed */
> > +     new_umin =3D (reg->umin_value & ~0xffffffffULL) | reg->u32_min_va=
lue;
> > +     new_umax =3D (reg->umax_value & ~0xffffffffULL) | reg->u32_max_va=
lue;
> > +     reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
> > +     reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
> > +     /* u32 -> s64 tightening, u32 range embedded into s64 preserves r=
ange validity */
> > +     new_smin =3D (reg->smin_value & ~0xffffffffULL) | reg->u32_min_va=
lue;
> > +     new_smax =3D (reg->smax_value & ~0xffffffffULL) | reg->u32_max_va=
lue;
> > +     reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
> > +     reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
> > +
> > +     /* if s32 can be treated as valid u32 range, we can use it as wel=
l */
> > +     if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
> > +             /* s32 -> u64 tightening */
> > +             new_umin =3D (reg->umin_value & ~0xffffffffULL) | (u32)re=
g->s32_min_value;
> > +             new_umax =3D (reg->umax_value & ~0xffffffffULL) | (u32)re=
g->s32_max_value;
> > +             reg->umin_value =3D max_t(u64, reg->umin_value, new_umin)=
;
> > +             reg->umax_value =3D min_t(u64, reg->umax_value, new_umax)=
;
> > +             /* s32 -> s64 tightening */
> > +             new_smin =3D (reg->smin_value & ~0xffffffffULL) | (u32)re=
g->s32_min_value;
> > +             new_smax =3D (reg->smax_value & ~0xffffffffULL) | (u32)re=
g->s32_max_value;
> > +             reg->smin_value =3D max_t(s64, reg->smin_value, new_smin)=
;
> > +             reg->smax_value =3D min_t(s64, reg->smax_value, new_smax)=
;
> > +     }
> > +}
> > +
>
> Guess this might be something you've considered already, but I think it
> won't hurt to ask:
>
> All verifier.c patches up to till this point all use a lot of
>
>         reg->min_value =3D max_t(typeof(reg->min_value), reg->min_value, =
new_min);
>         reg->max_value =3D min_t(typeof(reg->max_value), reg->max_value, =
new_max);
>
> where min_value/max_value is one of umin, smin, u32, or s32. Could we
> refactor those out with some form of
>
>         reg_bounds_intersect(reg, new_min, new_max)
>
> The point of this is not really about reducing the line of code, but to
> reduce the cognitive load of juggling all the min_t and max_t. With
> something reg_bounds_intersect() we only need to check that
> new_min/new_max pair is valid and trust the macro/function itself to
> handle the rest correctly.

Yes, I thought about that. And it should be doable with macro and a
bunch of refactoring. I decided to leave it to future follow ups, as
there is already plenty of refactoring happing.

>
> >  static void __reg_deduce_bounds(struct bpf_reg_state *reg)
> >  {
> >       __reg32_deduce_bounds(reg);
> >       __reg64_deduce_bounds(reg);
> > +     __reg_deduce_mixed_bounds(reg);
> >  }
> >
> >  /* Attempts to improve var_off based on unsigned min/max information *=
/
> > --
> > 2.34.1
> >

