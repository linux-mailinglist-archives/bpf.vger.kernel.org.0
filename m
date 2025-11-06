Return-Path: <bpf+bounces-73884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D851AC3CC93
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D042539F
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8622DC79A;
	Thu,  6 Nov 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyXNp3Qo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07221A447
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449189; cv=none; b=LoTZYZnci/QZcBEwR3D+nEaC+gvJlgjTOvPso9Am5vIevvUF441QFyP18PPnpLzX9dDwtANfsPFid4FCmtPqte4GNtTbWCzBobNtmgl4kZjExEXD8L5YPXvjoMzaEyI43UlJ5HZgwSv32HM89UUm90ZA5n3/1XVR1847Y1opt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449189; c=relaxed/simple;
	bh=7plaZMVJBTSYCEcQOzeNYKQroEkrWNKYavtWargYKCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK31IH3asQeMR/qXzm6drBkb350x8kjpBF1TRC6wF3Ctr5Jf6Y+N5pZbii73PUd0hKUM4XpPFzTkFwBJsDNg+Wq73RZFahw1x4ilFQflNAF3o0j6fW67nlwowLCzbKQEK7sc0/K03FCfgtyS8rmssgIMPuTFnq+dO1mbki7/4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyXNp3Qo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1040864a91.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762449187; x=1763053987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQ0vS99MH51DIQEi/4lEFA0vAZuDEs4nuiBhiiP9BpQ=;
        b=XyXNp3QoO1I4nYdY7QEHywdFt+T4gymYgBJ0yTQApGP/BLjrL9jUUOBXr3mNJiGX2u
         wd3s76pmGDG6wxoCUpylcLgAXobw8dKbK/Wopw7xjGB037OPYTNt5YMx8FbZHSYiZ/6c
         ajA83IQm9SAlSTaeP2KaR+t07wirgbSkhpq7Xnz0CXbbosOsK/ZyoZK7GWX41QV+8Wt4
         VeTRishKwIkfDaHFNDfHmy+xo3TuqzwDyBeZBz+dzTXWZZXv2DUHI2FCS33g+A3IdHkX
         +vc5AlNwQK2S/9pDKBTZ5YR7jbORDuqzev/Ahj3jd0TffQxAFkSaH8mz8f4xuk2hzyj4
         i3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449187; x=1763053987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQ0vS99MH51DIQEi/4lEFA0vAZuDEs4nuiBhiiP9BpQ=;
        b=jrAV03ji40Wu9eXC9ItWZ7SjMJHwTpCvfpR5Vpj0Sy67JT/l0Gxy7ZuSvhRSLb13A8
         wMag+gv243I7ByEuHyUMw1Kf6XuKLn3ZxLpnjkwm2c51xl9KIUtkbpSBLHNAv5B+sDU6
         cYf7ARGCVWKImVeSZhAznxHpaZSoCV+s2Db50TyYejJZXVsJdJUI55UH4xJnoU/JpEXU
         xEez4VykrWz6N8YONaH0jt3363qSTMV7CLcTaCKCiaf4w5w3IDMe5NVyHme1GD+3Mn32
         GkjwhEJGnA6zUzJ4e0BW1pCtiN47L44au72SbAddKRQXPDmaeIsKe4CCa4U681hbm0l9
         5syQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhUZjHUoEWBK3srdVLJhc5+/SPKSCaWZU0mZYBYQE1bD8GppcIGr2BKCBxV8He1PSvZZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzY8Yf5u7UM4AoOgO041QHBPoGqBRrNtIYhaZfeRKDH+nyHLV
	EJgVXaAYdsMOZx9RGtzFbhDSRoLOWGv+GQL9G85yt6WJStGw14K9WlwEBFt1ta8+FPAKSXTSB4Z
	Giz+Wf1wfTjrWpd9XyjzdaMQ880zwJOk=
X-Gm-Gg: ASbGnctqtjPGNN/qMtkz5LXtAwFvEf5JRdOigq3v4dX8GmJZy7dtzqlMu08S8ERQhR9
	bj247n0S/K/EibsbSy2vDTDvQ5WYCH9+3MJCzmBH49B+rc6IIzfQdvV+XQRSuJirbiqfOFHmcJQ
	d03oM1wBMm0cyO9HNPJ2QQrjmR+AN7e1K9grMgRqEhUMi14gm+SAH3Q3w8jaLlUPjJErEobCgQL
	+Es6dNFrpZOBoXlZ1VhklZzVAlWd76J4kW6hXZ4Ugt4vAG5OubK61jId/KIuNB45H9h6xQfOmui
	rt9qPoG4HWU=
X-Google-Smtp-Source: AGHT+IF1tyXh2VMRfi+PF4mWI7B7YlqcdbDXKhyxFy/RByI/ZqqTE31LNnMKzampDG9sS9KTk0JDuqLXRRhFqE5eQSI=
X-Received: by 2002:a17:90b:5250:b0:33b:ba40:c3f with SMTP id
 98e67ed59e1d1-341a6c091cfmr8826479a91.5.1762449186714; Thu, 06 Nov 2025
 09:13:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <CAErzpmv8eBjuX-RO0nopuy8qMV7wzVxa2e+HteXfFodwbBoALg@mail.gmail.com>
 <CAEf4Bza+pHVSGTC2vcjF-DmsVxKq2Ksq321E9CJEGdyT8hQn3g@mail.gmail.com> <CAErzpmvDk0Tvr9h772EDZk_4tRtLtAZv-r4yKCxEOM+_gc+G7A@mail.gmail.com>
In-Reply-To: <CAErzpmvDk0Tvr9h772EDZk_4tRtLtAZv-r4yKCxEOM+_gc+G7A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Nov 2025 09:12:51 -0800
X-Gm-Features: AWmQ_blIHFX9GNS-rDIzgY4otEOEfAJPKsVT-KOUyJkJmjdyohuZxdJySJpqZ9w
Message-ID: <CAEf4BzbYc+2T8BAyLyvT3kRWbJ8m1qxxwO6ZBHm=fsCucoWVQw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:31=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Thu, Nov 6, 2025 at 2:29=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Nov 5, 2025 at 4:53=E2=80=AFAM Donglin Peng <dolinux.peng@gmail=
.com> wrote:
> > >
> > > On Wed, Nov 5, 2025 at 8:11=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng@g=
mail.com> wrote:
> > > > >
> > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > >
> > > > > Introduce btf__permute() API to allow in-place rearrangement of B=
TF types.
> > > > > This function reorganizes BTF type order according to a provided =
array of
> > > > > type IDs, updating all type references to maintain consistency.
> > > > >
> > > > > The permutation process involves:
> > > > > 1. Shuffling types into new order based on the provided ID mappin=
g
> > > > > 2. Remapping all type ID references to point to new locations
> > > > > 3. Handling BTF extension data if provided via options
> > > > >
> > > > > This is particularly useful for optimizing type locality after BT=
F
> > > > > deduplication or for meeting specific layout requirements in spec=
ialized
> > > > > use cases.
> > > > >
> > > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > > Cc: Song Liu <song@kernel.org>
> > > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > > > > ---
> > > > >  tools/lib/bpf/btf.c      | 161 +++++++++++++++++++++++++++++++++=
++++++
> > > > >  tools/lib/bpf/btf.h      |  34 +++++++++
> > > > >  tools/lib/bpf/libbpf.map |   1 +
> > > > >  3 files changed, 196 insertions(+)
> > > > >
> > > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > > index 5e1c09b5dce8..3bc03f7fe31f 100644
> > > > > --- a/tools/lib/bpf/btf.c
> > > > > +++ b/tools/lib/bpf/btf.c
> > > > > @@ -5830,3 +5830,164 @@ int btf__relocate(struct btf *btf, const =
struct btf *base_btf)
> > > > >                 btf->owns_base =3D false;
> > > > >         return libbpf_err(err);
> > > > >  }
> > > > > +
> > > > > +struct btf_permute {
> > > > > +       /* .BTF section to be permuted in-place */
> > > > > +       struct btf *btf;
> > > > > +       struct btf_ext *btf_ext;
> > > > > +       /* Array of type IDs used for permutation. The array leng=
th must equal
> > > >
> > > > /*
> > > >  * Use this comment style
> > > >  */
> > >
> > > Thanks.
> > >
> > > >
> > > > > +        * the number of types in the BTF being permuted, excludi=
ng the special
> > > > > +        * void type at ID 0. For split BTF, the length correspon=
ds to the
> > > > > +        * number of types added on top of the base BTF.
> > > >
> > > > many words, but what exactly ids[i] means is still not clear, actua=
lly...
> > >
> > > Thanks. I'll clarify the description. Is the following parameter
> > > explanation acceptable?
> > >
> > > @param ids Array containing original type IDs (excluding VOID type ID
> > > 0) in user-defined order.
> > >                     The array size must match btf->nr_types, which
> >
> > Users don't have access to btf->nr_types, so referring to it in API
> > description seems wrong.
> >
> > But also, this all will change if we allow removing types, because
> > then array size might be smaller. But is it intentionally smaller or
> > user made a mistake? Let's go with the ID map approach, please.
>
> Thanks. I can implement both approaches, then we can assess their
> pros and cons.
>
> >
> > > also excludes VOID type ID 0.
> > >
> > >
> > > >
> > > > > +        */
> > > > > +       __u32 *ids;
> > > > > +       /* Array of type IDs used to map from original type ID to=
 a new permuted
> > > > > +        * type ID, its length equals to the above ids */
> > > >
> > > > wrong comment style
> > >
> > > Thanks, I will fix it in the next version.
> > >
> > > >
> > > > > +       __u32 *map;
> > > >
> > > > "map" is a bit generic. What if we use s/ids/id_map/ and
> > > > s/map/id_map_rev/ (for reverse)? I'd use "id_map" naming in the pub=
lic
> > > > API to make it clear that it's a mapping of IDs, not just some arra=
y
> > > > of IDs.
> > >
> > > Thank you for the suggestion. While I agree that renaming 'map' to 'i=
d_map'
> > > makes sense for clarity, but 'ids' seems correct as it denotes a coll=
ection of
> > > IDs, not a mapping structure.
> > >
> > > >
> > > > > +};
> > > > > +
> > > > > +static int btf_permute_shuffle_types(struct btf_permute *p);
> > > > > +static int btf_permute_remap_types(struct btf_permute *p);
> > > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
> > > > > +
> > > > > +int btf__permute(struct btf *btf, __u32 *ids, const struct btf_p=
ermute_opts *opts)
> > > >
> > > > Let's require user to pass id_map_cnt in addition to id_map itself.
> > > > It's easy to get this wrong (especially with that special VOID 0 ty=
pe
> > > > that has to be excluded, which I can't even make up my mind if that=
's
> > > > a good idea or not), so having user explicitly say what they think =
is
> > > > necessary for permutation is good.
> > >
> > > Thank you for your suggestion. However, I am concerned that introduci=
ng
> > > an additional `id_map_cnt` parameter could increase complexity. Speci=
fically,
> > > if `id_map_cnt` is less than `btf->nr_types`, we might need to consid=
er whether
> > > to resize the BTF. This could lead to missing types, potential ID rem=
apping
> > > failures, or even require BTF re-deduplication if certain name string=
s are no
> > > longer referenced by any types.
> > >
> >
> > No, if the user provided a wrong id_map_cnt, it's an error and we
> > return -EINVAL. No resizing.
> >
> > > >
> > > > > +{
> > > > > +       struct btf_permute p;
> > > > > +       int i, err =3D 0;
> > > > > +       __u32 *map =3D NULL;
> > > > > +
> > > > > +       if (!OPTS_VALID(opts, btf_permute_opts) || !ids)
> > > >
> >
> > [...]
> >
> > > > > +               goto done;
> > > > > +       }
> > > > > +
> > > > > +done:
> > > > > +       free(map);
> > > > > +       return libbpf_err(err);
> > > > > +}
> > > > > +
> > > > > +/* Shuffle BTF types.
> > > > > + *
> > > > > + * Rearranges types according to the permutation map in p->ids. =
The p->map
> > > > > + * array stores the mapping from original type IDs to new shuffl=
ed IDs,
> > > > > + * which is used in the next phase to update type references.
> > > > > + *
> > > > > + * Validates that all IDs in the permutation array are valid and=
 unique.
> > > > > + */
> > > > > +static int btf_permute_shuffle_types(struct btf_permute *p)
> > > > > +{
> > > > > +       struct btf *btf =3D p->btf;
> > > > > +       const struct btf_type *t;
> > > > > +       __u32 *new_offs =3D NULL, *map;
> > > > > +       void *nt, *new_types =3D NULL;
> > > > > +       int i, id, len, err;
> > > > > +
> > > > > +       new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
> > > >
> > > > we don't really need to allocate memory and maintain this, we can j=
ust
> > > > shift types around and then do what btf_parse_type_sec() does -- ju=
st
> > > > go over types one by one and calculate offsets, and update them
> > > > in-place inside btf->type_offs
> > >
> > > Thank you for the suggestion. However, this approach is not viable be=
cause
> > > the `btf__type_by_id()` function relies critically on the integrity o=
f the
> > > `btf->type_offs` data structure. Attempting to modify `type_offs` thr=
ough
> > > in-place operations could corrupt memory and lead to segmentation fau=
lts
> > > due to invalid pointer dereferencing.
> >
> > Huh? By the time this API returns, we'll fix up type_offs, users will
> > never notice. And to recalculate new type_offs we don't need
> > type_offs. One of us is missing something important, what is it?
>
> Thanks, however the bad news is that the btf__type_by_id is indeed called
> within the API.
>
> static int btf_permute_shuffle_types(struct btf_permute *p)
> {
>         struct btf *btf =3D p->btf;
>         const struct btf_type *t;
>         __u32 *new_offs =3D NULL, *ids_map;
>         void *nt, *new_types =3D NULL;
>         int i, id, len, err;
>
>         new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
>         new_types =3D calloc(btf->hdr->type_len, 1);
>         ......
>         nt =3D new_types;
>        for (i =3D 0; i < btf->nr_types; i++) {
>                 id =3D p->ids[i];
>                 ......
>                 /* must be a valid type ID */
>                 t =3D btf__type_by_id(btf, id);  <<<<<<<<<<<<<

You are still on the old types layout and old type_offs at that point.
You are not using your new_offs here *anyways*

>                 ......
>                 len =3D btf_type_size(t);
>                 memcpy(nt, t, len);
>                 new_offs[i] =3D nt - new_types;
>                 *ids_map =3D btf->start_id + i;
>                 nt +=3D len;
>         }
> ......

... you will recalculate and update type_offs here ... well past
btf__type_by_id() usage ...

> }
>
> >
> > [...]

