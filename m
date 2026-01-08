Return-Path: <bpf+bounces-78205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD4D01082
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 06:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC5B305434A
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 05:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C22D47E9;
	Thu,  8 Jan 2026 05:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8T3YZNe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2082D0C7A
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848525; cv=none; b=bfux3hmhsktp28P3kMfc2bMzE43FKDDY2NUJ+vjtzM7OQIeZk8d/KjO9hxRd20MyO12MH4x6ljnrgBNof1NvGt+VB8SczrFo+ndwmgInGVGOU9GsZZ1Vb82SWSQLNutTWGjbN903Lqr1SnfCPWO8yW/dwirYPdFYpK3Y7TsbUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848525; c=relaxed/simple;
	bh=83i9ng7melyxu/eH0gDpFW8zSe+vkg7Ryxy2htLfT/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duR21XYnjB+hacrwrVgpNCE77OHozJsymEHOYcuNa8vYLPHBmusAxZ8mDELF6HaCBFR4+a7B+eWnIJVeUg2dGGNs7iWq8GkJt/t+N4L8cimWro9BdlqvgMv1wv7jQX82BCOovoE8R2dtR8UVvLS9aQjJXExQ9AduVh/nbJqM2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8T3YZNe; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b832c65124cso442189866b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 21:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767848522; x=1768453322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XoDHzlnmgcuM3t1WqrVetanHaGsF0PfOhnvM7qVnlw=;
        b=m8T3YZNePtqVZxHuito8AHTPSVDJUtxyhDfSnYXIV/2naq1mcjuidBjmvzRzEiQNLA
         SjJ5faDugCmX01tTQRg4YG1DtTTNMDjIwEL6sD3fiU1kELx5X1XW8FWQGHa02u7HweSD
         I87eoytZLRH8lMXinugfHrs9XSvEN+ilwYL1vNPElks09ak1kpfpLf67NFsBxJsp9/V1
         IIB/Ke0K5dpPLj7i1xNfZ9YXDehNzkBWAzSTKsFF9S0xK6dOR22d9YoieoZzGovh1Ypb
         4lA4z5zbWAYA2MjzBQKKsV9/CkhmORpkAqYPUpGWhOrQteihX4W8BZ4RjMa2HUmmygMm
         2f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767848522; x=1768453322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XoDHzlnmgcuM3t1WqrVetanHaGsF0PfOhnvM7qVnlw=;
        b=iHKvlD/M03dIDb8DSi2BinA/N8dgU9LVCRMBfeibx34Yn/U1JBEfDXkVpJBZt7P4vS
         dCzIaR6zC1lxWyrEne0EnBITWNdX/++di6B9oBVchYPoMttHYSFaWgnGEbFl4G2rmRlr
         JCAaoyM2NwZagYgNVQrOHP6X29twFBcjN3h9jjr3Y48BsCORMDB/2r1h3KBCGTox4FNP
         olXEfj+GQ/IIHo8CB1wMeJVHOQ+nq/4DEHDg83dY9UbODZyLfGv4VlnHKF06Vz1c85GP
         Rkd6rtBiCFX2vDk798ASa75Zqt0GbEFLtkfpP5tn40ac8uHhmGY7xpwbETWuPooYkxQG
         V8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXp+FA1VVBgnVq74xrwWFRMwG6+yTph3puVZ0EpPjo3GigsmqpS6T8zPxiY/U8jJpQkcOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAp8y+ldSRwRT0LQja2ok5SX983oJEJcnNnXQDY33KzN1LDKto
	pFCcOo9qIBzK6Xd88IIUYC+ucf8eDMMfbqcuT9fPxzaQaTkh+QsA3oCryU15qK6gVLhgcj9QzZy
	iWKfSmF4k3GgnMKwV+aC2sX0mgYKNTjU=
X-Gm-Gg: AY/fxX5vkM1Ct56Mc0pwcMq9n4fu11nTo+SdKo+5ROpujeCmf3884wRLeYzY1zs4rP8
	fsP96RAm4gKiKHbvxFyOqQ27T7Q8GavObz0UUFWg6hXo0kiuI2jSVQWuHdD8sDKaXLcjw+3wAze
	2lI0yghld+iF0dh2po4eYC8iEpWZst2KGKMxsSQlIikkMLh0QdRnMlz3DezW3C+48GhK4ayb5qz
	SBxHhwNh+5Z+FLNLCcUplCtF0KLqu3Xk5dCeZtRLo0OMPkcBPAj+FBNblM8MGckuYfZilHLlyGg
	ab/EIeo=
X-Google-Smtp-Source: AGHT+IHti7l5akJzlBdlZx5keUUCa3jYPLyujJzHjAsWaU6HwSF1GKtgk5oFc0wTt0mtF/9J8XQ9hwPMKcM5IcQEC88=
X-Received: by 2002:a17:907:6d10:b0:b84:40e1:c1c8 with SMTP id
 a640c23a62f3a-b8444f4afb5mr544049366b.33.1767848521892; Wed, 07 Jan 2026
 21:02:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108031645.1350069-5-dolinux.peng@gmail.com> <4741560dd9cff0cf2643b9ea291154e91a2ce3e57370f020d0b346230a98efb1@mail.kernel.org>
In-Reply-To: <4741560dd9cff0cf2643b9ea291154e91a2ce3e57370f020d0b346230a98efb1@mail.kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 8 Jan 2026 13:01:50 +0800
X-Gm-Features: AQt7F2rL_oqoQ0tsol_-epX5RYmb_L3MkK-CDF274SvbvNH7dXcHK6uxtZH63PM
Message-ID: <CAErzpmu1-BwS29mBfsZ75wYh+8uveHA82dUQz+AzkLUFKKBn-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 04/11] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com, 
	zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin@xiaomi.com, 
	alan.maguire@oracle.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:46=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index bf75f770d29a..60ff8eafea83 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> > @@ -897,46 +899,83 @@ int btf__resolve_type(const struct btf *btf, __u3=
2 type_id)
> >       return type_id;
> >  }
> >
> > -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> > -{
> > -     __u32 i, nr_types =3D btf__type_cnt(btf);
> > -
> > -     if (!strcmp(type_name, "void"))
> > -             return 0;
> > -
> > -     for (i =3D 1; i < nr_types; i++) {
>                   ^
> The original btf__find_by_name() started iteration from ID 1, which meant
> it would search through ALL types including those in base BTF for split
> BTF scenarios. The btf__type_by_id() call would transparently access
> base BTF types when i < btf->start_id.
>
> > -             const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -             const char *name =3D btf__name_by_offset(btf, t->name_off=
);
> > -
> > -             if (name && !strcmp(type_name, name))
> > -                     return i;
> > -     }
> > -
> > -     return libbpf_err(-ENOENT);
> > -}
>
> [ ... ]
>
> > +/* the kind value of -1 indicates that kind matching should be skipped=
 */
> > +__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> > +{
> > +     return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
>                                         ^^^^^^^^^^^^^^^
> Is this intended to change the split BTF lookup behavior? The new

Thanks, my bad. We should pass 1, not btf->start_id.

> implementation passes btf->start_id as the start_id parameter, which
> means for split BTF the search will only cover types in the current BTF
> instance, not the base BTF.
>
> In btf_find_by_name_kind(), the base BTF is only searched when
> start_id < btf->start_id, but here start_id =3D=3D btf->start_id so that
> condition is never true.
>
> Compare with btf__find_by_name_kind() which still passes 1 as start_id:
>
>   __s32 btf__find_by_name_kind(const struct btf *btf, ...)
>   {
>       return btf_find_by_name_kind(btf, 1, type_name, kind);
>   }
>
> This creates an inconsistency where btf__find_by_name_kind() searches
> base BTF but btf__find_by_name() does not. Was this behavior change
> intentional? If so, perhaps the commit message should mention it.
>
> > +}
> > +
> >  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *ty=
pe_name,
> >                                __u32 kind)
> >  {
> >       return btf_find_by_name_kind(btf, btf->start_id, type_name, kind)=
;
> >  }
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/208044=
42135

