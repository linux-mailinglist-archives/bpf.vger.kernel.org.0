Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B58E465D2B
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 04:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbhLBD4v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 22:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhLBD4v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 22:56:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98918C061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 19:53:29 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g19so26658485pfb.8
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 19:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfATiCaQNQE+6cHoVUlKpACzm2Fsj0Ijevr5gTg2aXw=;
        b=dO8fcsgYh3CIL2LIbmltlxtNEtzmX0gMkxlegstnZdGC1DO/lwJG9ZFwWVZE1b63/t
         bOAqUhFOKafIrjF63p1kiqkTUokU3lzqy7cDTMD/M1HTv8i8diShCP4MoMdRF0uvKAhJ
         wcnv+ovluekhlegUZxkSKuAmZTElIK5qyNbAy8a4uyFHfU2Vq2rRmO17R/D4D3BkoUv2
         FvoIwlWVOCd/8F9WwoY8GR0Yd1XyxxAVrcO0B97KtlOc4M6AivmGqBMhiJnMh2Iy582t
         M2NpvdOOx4bjS/cGqAosogrQCnOaTFSRXAM2746GvxZAVKuUHIggCm4MCNi1QRn91x3d
         EEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfATiCaQNQE+6cHoVUlKpACzm2Fsj0Ijevr5gTg2aXw=;
        b=UdDV8ZXG8BJGWgw2n390j06DQ7rm07/Wwrm1rfa8y0OwXkHkuKvsjRsV1VjPNS8pE1
         vxSwSqOET2A+o4ZDRMjn2nlclh6Y63bPep9MeGXznzYQLexJmnDvuB7OAwrgnRUNrIL1
         wmJcouGopeoQXaZMfGnaCMiZH/aPNRDgk+V+wF0GtJeavPum2dq6h+/bIOeHq/qsOhT0
         Lyl7OS16G3aiZ2HRFvc7q62q0TWzo88p/s2keKJCMnNKNrevcwG6/rNMjbmQmL5V9iKw
         hFErRDGzGrTljB2xTvxfZlK5g9LvdWuLMz9MaTfYtLiQHfZIclKDruIpftncz9veforT
         1OOQ==
X-Gm-Message-State: AOAM53117EqQvZlnoWUspQ1oePF3l/lZawvH9MZW5rt/OWbhsjoic9ja
        NL0AWNehmEhpwvnGfrIBNPbdnAG2BPT514LOonhz2DD3
X-Google-Smtp-Source: ABdhPJzhcHiGFdBsFh/VAGaEXMGGMjxrmHjgPysKQPt487jDYMganmppDYM+57rO1m5TyY/ib6fUBfiTdpyYfIDww9w=
X-Received: by 2002:a63:6881:: with SMTP id d123mr7572575pgc.497.1638417209110;
 Wed, 01 Dec 2021 19:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com> <20211130012948.380602-9-haoluo@google.com>
 <20211201203433.ioj3jsksaw3aoie2@ast-mbp.dhcp.thefacebook.com> <CA+khW7ggwH-kwZYk48xnb1akYcTjK5itWu1eLCjmpb36=NLBbA@mail.gmail.com>
In-Reply-To: <CA+khW7ggwH-kwZYk48xnb1akYcTjK5itWu1eLCjmpb36=NLBbA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Dec 2021 19:53:18 -0800
Message-ID: <CAADnVQLy9XTP6A5kaEu0eKmmR0mAmFe1JyC4QrfQmLxNBoTjFw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 8/9] bpf: Add MEM_RDONLY for helper args
 that are pointers to rdonly mem.
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 2:21 PM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Dec 1, 2021 at 12:34 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 29, 2021 at 05:29:47PM -0800, Hao Luo wrote:
> > >
> > > +
> > >  struct bpf_reg_types {
> > >       const enum bpf_reg_type types[10];
> > >       u32 *btf_id;
> > > +
> > > +     /* Certain types require customized type matching function. */
> > > +     bool (*type_match_fn)(enum bpf_arg_type arg_type,
> > > +                           enum bpf_reg_type type,
> > > +                           enum bpf_reg_type expected);
> > >  };
> > >
> > >  static const struct bpf_reg_types map_key_value_types = {
> > > @@ -5013,6 +5019,19 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
> > >  };
> > >  #endif
> > >
> > > +static bool mem_type_match(enum bpf_arg_type arg_type,
> > > +                        enum bpf_reg_type type, enum bpf_reg_type expected)
> > > +{
> > > +     /* If arg_type is tagged with MEM_RDONLY, type is compatible with both
> > > +      * RDONLY and RDWR mem, fold the MEM_RDONLY flag in 'type' before
> > > +      * comparison.
> > > +      */
> > > +     if ((arg_type & MEM_RDONLY) != 0)
> > > +             type &= ~MEM_RDONLY;
> > > +
> > > +     return type == expected;
> > > +}
> > > +
> > >  static const struct bpf_reg_types mem_types = {
> > >       .types = {
> > >               PTR_TO_STACK,
> > > @@ -5022,8 +5041,8 @@ static const struct bpf_reg_types mem_types = {
> > >               PTR_TO_MAP_VALUE,
> > >               PTR_TO_MEM,
> > >               PTR_TO_BUF,
> > > -             PTR_TO_BUF | MEM_RDONLY,
> > >       },
> > > +     .type_match_fn = mem_type_match,
> >
> > why add a callback for this logic?
> > Isn't it a universal rule for MEM_RDONLY?
>
> Ah, good point, I didn't realize that. Maybe, not only MEM_RDONLY, but
> all flags can be checked in the same way? Like the following
>
>  static const struct bpf_reg_types int_ptr_types = {
> @@ -5097,6 +5116,13 @@ static int check_reg_type(struct
> bpf_verifier_env *env, u32 regno,
>                 if (expected == NOT_INIT)
>                         break;
>
> +               flag = bpf_type_flag(arg_type);
>
> -               if (type == expected)
> +               if ((type & ~flag) == expected)
>                         goto found;
>         }

I think for MAYBE_NULL and MEM_RDONLY that would be correct,
but not necessarily apply to future flags.
I would open code it for these specific flags.
Also what do you think about dropping bpf_ prefix from type_flag()?
It won't conflict with anything and less verbose.
