Return-Path: <bpf+bounces-73922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D290C3E257
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 02:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC943AE4CB
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53232F746F;
	Fri,  7 Nov 2025 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6hSO4zb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EB2F6929
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479575; cv=none; b=Y0uNzuliJsksLMIB9aQy5r5YAFZcTD/IAy+aH8ISuB7aXSG2oLIO69ObUwGkyLaoo/FpC+fGEESoM0t/0ymopZ9igbYCbJd3GCsEAPazFVvDXpdCNspijrdR65CHeqEC1ldy/YDsjSU2oYdoXbT+7wXdOsxHtfbfGOMCjiKDOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479575; c=relaxed/simple;
	bh=M01wkyOb9FzkQm4Lzp5/+nSeqaI8EEeWqov0YfEb9Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvyjC+L5KlWK2GtuLNqdj+jvTFoGZMs8Jq66KnE3D3YQTPIgiOTM19aDgPSGj2B0kGnYPUK/MKm7b770c5tH4v/ewhp3oLn4gi55JOBeODJap0BtVK/GmA9E8mJTg8r6/2hS9CTjT2YtdyMclKv5BqK7sEJ07dGyHWe6DQ1MWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6hSO4zb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640c3940649so327725a12.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 17:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762479572; x=1763084372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIpITV5yEZrESiQ2Z+qYNEuXuM9HjJI30TVH+Lhv/e8=;
        b=T6hSO4zb0Ey5nRDnEiH2qZVDi4wBs73CiOzbGBj+6TihNL4597KZfFmBd1hqWRr6YF
         +6Ud1Z5RugqK8hrddL6zWKrR45TZT6ZOlUemvBlPazDFjZPt4HZ33PCyawk2/s+LRNaE
         rMSQWEVYwh/S97sarCdjTDkfe3wAb1gL6Tosz6ssyyobKbVCwwg6vF3Ue7obkBgcCxCj
         Sn0p5jgOm5hV8pIk2ycgffEFuL1LQjlSlk2YymFf+IpHt+N0Zjnpv8A0UvYdvz23Nb6k
         5Kx2RlGANCUrAY3pEat9NRIIXT0vErvpP3Ryy2Tz/XIDniSHlsSagfexeUGjjhNyC0zC
         2+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762479572; x=1763084372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIpITV5yEZrESiQ2Z+qYNEuXuM9HjJI30TVH+Lhv/e8=;
        b=S2tIyT4Tp/H/ffvSTWO5PHLL1LAPw+Vk0jadCaMhi6bKYOw85xEAZRHUnKRd4MVI5o
         Ry53kIuQGKuYjaykzukBfnbj/ck6cLnpzHCIU7L38rg/lU17iAkpBIhoHf2cpSxTdsZW
         ebnVcvSEan3d14KZvyGeh2hH/S2NuGa2gpHsJndRACmEQ3soxHIkS2cInJ+SMyqySK4F
         Hyk/v+8cKaxH79ZiHIzXJIzJ2mEdDCuaKeewZYAmY+QhdA5Li35IuRRqdUgbSehMQuSN
         4WufkSNq9PhFOlpA8ixVJaXqf8b2mCKQyyuAUItFL/BvBoiNj0SyIOIrPjJXRuoZgpP8
         w0cA==
X-Forwarded-Encrypted: i=1; AJvYcCVQlWHwxLj9+KEDxJFDsfmNOSOMtU2me2RwbXHcnrnpwiiPESFkA+ysUnBTi5+McrlhClM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZKqpSDAyVxw3vjbtOMREaPU6KnJoX+BzMDUNPz7b+jVPicfV
	CBX6mIWI9TOvju2Bhm74UP0YC2HqIiXscUS9OxbE3Nq28up4ZvA7Ood7TeL55GmnwFcTrV/AsuA
	SSODVgGl6F/FhnuVu9DhFFqjyRzDNC0E=
X-Gm-Gg: ASbGncuOAuYrPLccbMkXvw4L0weywEQ/c44rRe4DE7uwZTuXuVi9ThHh72AYyfFBB/1
	K8XCIq9VHLPsFWM5Cox1exicd5dUsQ8Rhe1imE49vf8vo8TA53aBLiLiYL81xyWGOXig2qjnOXC
	P7n8XY4Ia+l89kLE0ZvEn7qdo6F0RLRO1qX9Jvvm4qOjTSLdFs/E3dajiRgHT1CMzBmgQpFMpne
	697owq1KGzeif/wZ0scAAb5c7JkpVEgMAvJl3cRvfLG8Ds562im7B4qrV6DuN0X3xIlBrkU
X-Google-Smtp-Source: AGHT+IErykCug47DPG+pbRzVCLvgs3mgf39hQlr89bm6GLJnz/NPKiMSuO7mrmXHMF3FKPpf6RYEtJAUqbjLG8fIFH0=
X-Received: by 2002:a17:907:d644:b0:b71:88eb:e60c with SMTP id
 a640c23a62f3a-b72c0cfe237mr124818366b.44.1762479571452; Thu, 06 Nov 2025
 17:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <CAErzpmv8eBjuX-RO0nopuy8qMV7wzVxa2e+HteXfFodwbBoALg@mail.gmail.com>
 <CAEf4Bza+pHVSGTC2vcjF-DmsVxKq2Ksq321E9CJEGdyT8hQn3g@mail.gmail.com>
 <CAErzpmvDk0Tvr9h772EDZk_4tRtLtAZv-r4yKCxEOM+_gc+G7A@mail.gmail.com> <CAEf4BzbYc+2T8BAyLyvT3kRWbJ8m1qxxwO6ZBHm=fsCucoWVQw@mail.gmail.com>
In-Reply-To: <CAEf4BzbYc+2T8BAyLyvT3kRWbJ8m1qxxwO6ZBHm=fsCucoWVQw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 7 Nov 2025 09:39:19 +0800
X-Gm-Features: AWmQ_bmAxgZi5GdkV1bT-nnjE-9J8IE-njxXsmD0kpR1sb0XXV68cJuNHuVTveM
Message-ID: <CAErzpmvZTc+jn4Xwp7pc_x9Xgduk+NW_5FNFzrDCT+EGeLOoig@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 1:13=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 5, 2025 at 11:31=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Thu, Nov 6, 2025 at 2:29=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Nov 5, 2025 at 4:53=E2=80=AFAM Donglin Peng <dolinux.peng@gma=
il.com> wrote:
> > > >
> > > > On Wed, Nov 5, 2025 at 8:11=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng=
@gmail.com> wrote:
> > > > > >
> > > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > > >
> > > > > > Introduce btf__permute() API to allow in-place rearrangement of=
 BTF types.
> > > > > > This function reorganizes BTF type order according to a provide=
d array of
> > > > > > type IDs, updating all type references to maintain consistency.
> > > > > >
> > > > > > The permutation process involves:
> > > > > > 1. Shuffling types into new order based on the provided ID mapp=
ing
> > > > > > 2. Remapping all type ID references to point to new locations
> > > > > > 3. Handling BTF extension data if provided via options
> > > > > >
> > > > > > This is particularly useful for optimizing type locality after =
BTF
> > > > > > deduplication or for meeting specific layout requirements in sp=
ecialized
> > > > > > use cases.
> > > > > >
> > > > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > > > Cc: Song Liu <song@kernel.org>
> > > > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > > > > > ---
> > > > > >  tools/lib/bpf/btf.c      | 161 +++++++++++++++++++++++++++++++=
++++++++
> > > > > >  tools/lib/bpf/btf.h      |  34 +++++++++
> > > > > >  tools/lib/bpf/libbpf.map |   1 +
> > > > > >  3 files changed, 196 insertions(+)
> > > > > >
> > > > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > > > index 5e1c09b5dce8..3bc03f7fe31f 100644
> > > > > > --- a/tools/lib/bpf/btf.c
> > > > > > +++ b/tools/lib/bpf/btf.c
> > > > > > @@ -5830,3 +5830,164 @@ int btf__relocate(struct btf *btf, cons=
t struct btf *base_btf)
> > > > > >                 btf->owns_base =3D false;
> > > > > >         return libbpf_err(err);
> > > > > >  }
> > > > > > +
> > > > > > +struct btf_permute {
> > > > > > +       /* .BTF section to be permuted in-place */
> > > > > > +       struct btf *btf;
> > > > > > +       struct btf_ext *btf_ext;
> > > > > > +       /* Array of type IDs used for permutation. The array le=
ngth must equal
> > > > >
> > > > > /*
> > > > >  * Use this comment style
> > > > >  */
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > > +        * the number of types in the BTF being permuted, exclu=
ding the special
> > > > > > +        * void type at ID 0. For split BTF, the length corresp=
onds to the
> > > > > > +        * number of types added on top of the base BTF.
> > > > >
> > > > > many words, but what exactly ids[i] means is still not clear, act=
ually...
> > > >
> > > > Thanks. I'll clarify the description. Is the following parameter
> > > > explanation acceptable?
> > > >
> > > > @param ids Array containing original type IDs (excluding VOID type =
ID
> > > > 0) in user-defined order.
> > > >                     The array size must match btf->nr_types, which
> > >
> > > Users don't have access to btf->nr_types, so referring to it in API
> > > description seems wrong.
> > >
> > > But also, this all will change if we allow removing types, because
> > > then array size might be smaller. But is it intentionally smaller or
> > > user made a mistake? Let's go with the ID map approach, please.
> >
> > Thanks. I can implement both approaches, then we can assess their
> > pros and cons.
> >
> > >
> > > > also excludes VOID type ID 0.
> > > >
> > > >
> > > > >
> > > > > > +        */
> > > > > > +       __u32 *ids;
> > > > > > +       /* Array of type IDs used to map from original type ID =
to a new permuted
> > > > > > +        * type ID, its length equals to the above ids */
> > > > >
> > > > > wrong comment style
> > > >
> > > > Thanks, I will fix it in the next version.
> > > >
> > > > >
> > > > > > +       __u32 *map;
> > > > >
> > > > > "map" is a bit generic. What if we use s/ids/id_map/ and
> > > > > s/map/id_map_rev/ (for reverse)? I'd use "id_map" naming in the p=
ublic
> > > > > API to make it clear that it's a mapping of IDs, not just some ar=
ray
> > > > > of IDs.
> > > >
> > > > Thank you for the suggestion. While I agree that renaming 'map' to =
'id_map'
> > > > makes sense for clarity, but 'ids' seems correct as it denotes a co=
llection of
> > > > IDs, not a mapping structure.
> > > >
> > > > >
> > > > > > +};
> > > > > > +
> > > > > > +static int btf_permute_shuffle_types(struct btf_permute *p);
> > > > > > +static int btf_permute_remap_types(struct btf_permute *p);
> > > > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx=
);
> > > > > > +
> > > > > > +int btf__permute(struct btf *btf, __u32 *ids, const struct btf=
_permute_opts *opts)
> > > > >
> > > > > Let's require user to pass id_map_cnt in addition to id_map itsel=
f.
> > > > > It's easy to get this wrong (especially with that special VOID 0 =
type
> > > > > that has to be excluded, which I can't even make up my mind if th=
at's
> > > > > a good idea or not), so having user explicitly say what they thin=
k is
> > > > > necessary for permutation is good.
> > > >
> > > > Thank you for your suggestion. However, I am concerned that introdu=
cing
> > > > an additional `id_map_cnt` parameter could increase complexity. Spe=
cifically,
> > > > if `id_map_cnt` is less than `btf->nr_types`, we might need to cons=
ider whether
> > > > to resize the BTF. This could lead to missing types, potential ID r=
emapping
> > > > failures, or even require BTF re-deduplication if certain name stri=
ngs are no
> > > > longer referenced by any types.
> > > >
> > >
> > > No, if the user provided a wrong id_map_cnt, it's an error and we
> > > return -EINVAL. No resizing.
> > >
> > > > >
> > > > > > +{
> > > > > > +       struct btf_permute p;
> > > > > > +       int i, err =3D 0;
> > > > > > +       __u32 *map =3D NULL;
> > > > > > +
> > > > > > +       if (!OPTS_VALID(opts, btf_permute_opts) || !ids)
> > > > >
> > >
> > > [...]
> > >
> > > > > > +               goto done;
> > > > > > +       }
> > > > > > +
> > > > > > +done:
> > > > > > +       free(map);
> > > > > > +       return libbpf_err(err);
> > > > > > +}
> > > > > > +
> > > > > > +/* Shuffle BTF types.
> > > > > > + *
> > > > > > + * Rearranges types according to the permutation map in p->ids=
. The p->map
> > > > > > + * array stores the mapping from original type IDs to new shuf=
fled IDs,
> > > > > > + * which is used in the next phase to update type references.
> > > > > > + *
> > > > > > + * Validates that all IDs in the permutation array are valid a=
nd unique.
> > > > > > + */
> > > > > > +static int btf_permute_shuffle_types(struct btf_permute *p)
> > > > > > +{
> > > > > > +       struct btf *btf =3D p->btf;
> > > > > > +       const struct btf_type *t;
> > > > > > +       __u32 *new_offs =3D NULL, *map;
> > > > > > +       void *nt, *new_types =3D NULL;
> > > > > > +       int i, id, len, err;
> > > > > > +
> > > > > > +       new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
> > > > >
> > > > > we don't really need to allocate memory and maintain this, we can=
 just
> > > > > shift types around and then do what btf_parse_type_sec() does -- =
just
> > > > > go over types one by one and calculate offsets, and update them
> > > > > in-place inside btf->type_offs
> > > >
> > > > Thank you for the suggestion. However, this approach is not viable =
because
> > > > the `btf__type_by_id()` function relies critically on the integrity=
 of the
> > > > `btf->type_offs` data structure. Attempting to modify `type_offs` t=
hrough
> > > > in-place operations could corrupt memory and lead to segmentation f=
aults
> > > > due to invalid pointer dereferencing.
> > >
> > > Huh? By the time this API returns, we'll fix up type_offs, users will
> > > never notice. And to recalculate new type_offs we don't need
> > > type_offs. One of us is missing something important, what is it?
> >
> > Thanks, however the bad news is that the btf__type_by_id is indeed call=
ed
> > within the API.
> >
> > static int btf_permute_shuffle_types(struct btf_permute *p)
> > {
> >         struct btf *btf =3D p->btf;
> >         const struct btf_type *t;
> >         __u32 *new_offs =3D NULL, *ids_map;
> >         void *nt, *new_types =3D NULL;
> >         int i, id, len, err;
> >
> >         new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
> >         new_types =3D calloc(btf->hdr->type_len, 1);
> >         ......
> >         nt =3D new_types;
> >        for (i =3D 0; i < btf->nr_types; i++) {
> >                 id =3D p->ids[i];
> >                 ......
> >                 /* must be a valid type ID */
> >                 t =3D btf__type_by_id(btf, id);  <<<<<<<<<<<<<
>
> You are still on the old types layout and old type_offs at that point.
> You are not using your new_offs here *anyways*
>
> >                 ......
> >                 len =3D btf_type_size(t);
> >                 memcpy(nt, t, len);
> >                 new_offs[i] =3D nt - new_types;
> >                 *ids_map =3D btf->start_id + i;
> >                 nt +=3D len;
> >         }
> > ......
>
> ... you will recalculate and update type_offs here ... well past
> btf__type_by_id() usage ...

Thanks, I see. We need to add another for loop for this update, but
the cost is minimal compared to the memory savings. I will fix it in
v6.

>
> > }
> >
> > >
> > > [...]

