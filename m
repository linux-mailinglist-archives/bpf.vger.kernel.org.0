Return-Path: <bpf+bounces-73623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B23C35B54
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 13:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B80C434E626
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179DE316191;
	Wed,  5 Nov 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM+EZYio"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A9313E04
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347185; cv=none; b=IrSGrpA9lQUA0ohZ01yLD2Voy2QI6ZjfjWyz9G9+LTt6kfPpSXVgxU8BJ9mchhROwxcVQvw3liaocVuhD5YquCOWaPItitrDfVxRrd7I3iKUwJ0O5MM2I1HXcoOHr8U0EE8AJ8ASxpWW1kQK83bEdeR5v3T34EsXo+JLMroufZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347185; c=relaxed/simple;
	bh=KDUo2S+wV3je/mEBjDdf3a0eVJcMpNvDfs5S1+YIOLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF1k4rEkWQgeooMAvHC0ZW0aX2Hlj6VTc1FTOWFVUuvKj6XUcKj5BWSiKDcPalyd6w9KGcGOCCn1TvhL0PJu97sQ48LVsWmQ8/fXsbS/Y63R2yfqnbKqOlS0g7AEzIrBGcP95kn1sbC3KuEdHWFIMfDiPt29wO0AZSf1dD3KvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM+EZYio; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4f323cf89bso441291566b.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762347182; x=1762951982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mxqp66ZkcwxIO/c3hu9GOf0dpU+u/99eY4xOlRBgl+A=;
        b=kM+EZYiogSdEcQFb9xFwGyjV++h5flmwk3TnQhSRSLEgGpRqArbE41+BNfFh7QAKdl
         TWyDhL3wkmXVc6S/5T5sgyyVEUAtMguNJ9qwTwjQVW7hKi6I6AuHEfMOslvo6nzBFwl2
         oElD4fPNPcQBofYvsCt8OrfYu/sZuiXjO8VfFjvz0CV7fqS+HB6HIUzd84jtjLTk0GIr
         6yoaTzVBckdYmMs+S8N/oTAQpmj0Wortda95CV4EvFJV+MAwDqOHw/7maJ3nS/qvNo4V
         UH5h81eYqvSX7WC8Aqhtfel28qK7lKdSs3YlDq+oU/Kt3Fvqymi1tQ3eiwLJtQ34ZJHn
         sksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347182; x=1762951982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mxqp66ZkcwxIO/c3hu9GOf0dpU+u/99eY4xOlRBgl+A=;
        b=OyzinswwUS3lyHPZxHSyEVPY0TXEejnMgTIzM1K/B0WhNQ183/K+D2XQuPFfq9vFpL
         Cs/cGwVw2W3wjWVAbe8c8OaX/fX6O/Tsk+hzlBr8BoiTC3jVxDcGVsS2aipWaxpae7Oy
         n5b9UmwZ/CADYxp/bLZOg/k7oLPkXe1He4Uq6lvJmEopocKXu736W3sg+Y3eyhb5ICZU
         ZRuOVvpan8LWf8VeG1qYfhyPGN62KoXCFauvhEkn2zZvgDgso9oPJFpe0RskbJD1UEB9
         BknmqomgUNWo9t9txQlFwu8s0X+/uMyrxXElno4HodWo29DYOF66U3OSnXoUXotC32Dy
         zb+g==
X-Forwarded-Encrypted: i=1; AJvYcCVioImDW6dY7E/JcqgZJzHaiSh+ywGIqmz55yxYDTe4NApvP6A0zJZbyWogiUzGCxMv6m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKydLg73NM20amZL9013bHySjf01OX9S/O41PMQcUeBwfR1QLj
	CAr0jCnZxUIhA/04wtVpfRF0FSoW6v4HHw1LimcEcbnRFwLkruYQIdLwMYzqtoMZwUfEuZr3qdt
	CrhL3zvRor1mF05B4BaKjZJ1/euF5Da8=
X-Gm-Gg: ASbGncvfLstmG7QD7s9t+mzgHSBVizLAapuAjxpTd2rm61g63oxdEe9fIp5pUPClTqf
	/RdIDJ9fsgn3PVtpbi6VtrMbzUL3YgrpwyU22O5+mqoLHSPPyRdEd61uBru4Q7Fv/tkNv6HACma
	/tROejtCgUsyC6EPJ5VPswMpQKcqFfyVznAiOQb1DZ/2TjjWffz3DoqgYH0uR7m/fYUq+16xhDR
	zzMTvUoD7NlFhU5nil/jHF2jvFQDuoxTRlJYymnpJJR7gFQMIFRQ+Hg7uUX+EUHE5jdRX7p
X-Google-Smtp-Source: AGHT+IFT5Kpy3N8aR/TqVFWzHojzqYFaPqw920YE6GZbOAZyLupT8gHhsrJV8Gbod/H9nadPar2irg0Ud+/pNlahgnY=
X-Received: by 2002:a17:907:1c2a:b0:b70:b248:6a90 with SMTP id
 a640c23a62f3a-b72655870bemr308568166b.30.1762347181653; Wed, 05 Nov 2025
 04:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
In-Reply-To: <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 5 Nov 2025 20:52:49 +0800
X-Gm-Features: AWmQ_bmP81SOgRrHMXCPtAsrBq9mTMgmcWqak22dV_Z-y2bh_AF5l7SGxeCzwr8
Message-ID: <CAErzpmv8eBjuX-RO0nopuy8qMV7wzVxa2e+HteXfFodwbBoALg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:11=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Introduce btf__permute() API to allow in-place rearrangement of BTF typ=
es.
> > This function reorganizes BTF type order according to a provided array =
of
> > type IDs, updating all type references to maintain consistency.
> >
> > The permutation process involves:
> > 1. Shuffling types into new order based on the provided ID mapping
> > 2. Remapping all type ID references to point to new locations
> > 3. Handling BTF extension data if provided via options
> >
> > This is particularly useful for optimizing type locality after BTF
> > deduplication or for meeting specific layout requirements in specialize=
d
> > use cases.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c      | 161 +++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/btf.h      |  34 +++++++++
> >  tools/lib/bpf/libbpf.map |   1 +
> >  3 files changed, 196 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 5e1c09b5dce8..3bc03f7fe31f 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -5830,3 +5830,164 @@ int btf__relocate(struct btf *btf, const struct=
 btf *base_btf)
> >                 btf->owns_base =3D false;
> >         return libbpf_err(err);
> >  }
> > +
> > +struct btf_permute {
> > +       /* .BTF section to be permuted in-place */
> > +       struct btf *btf;
> > +       struct btf_ext *btf_ext;
> > +       /* Array of type IDs used for permutation. The array length mus=
t equal
>
> /*
>  * Use this comment style
>  */

Thanks.

>
> > +        * the number of types in the BTF being permuted, excluding the=
 special
> > +        * void type at ID 0. For split BTF, the length corresponds to =
the
> > +        * number of types added on top of the base BTF.
>
> many words, but what exactly ids[i] means is still not clear, actually...

Thanks. I'll clarify the description. Is the following parameter
explanation acceptable?

@param ids Array containing original type IDs (excluding VOID type ID
0) in user-defined order.
                    The array size must match btf->nr_types, which
also excludes VOID type ID 0.


>
> > +        */
> > +       __u32 *ids;
> > +       /* Array of type IDs used to map from original type ID to a new=
 permuted
> > +        * type ID, its length equals to the above ids */
>
> wrong comment style

Thanks, I will fix it in the next version.

>
> > +       __u32 *map;
>
> "map" is a bit generic. What if we use s/ids/id_map/ and
> s/map/id_map_rev/ (for reverse)? I'd use "id_map" naming in the public
> API to make it clear that it's a mapping of IDs, not just some array
> of IDs.

Thank you for the suggestion. While I agree that renaming 'map' to 'id_map'
makes sense for clarity, but 'ids' seems correct as it denotes a collection=
 of
IDs, not a mapping structure.

>
> > +};
> > +
> > +static int btf_permute_shuffle_types(struct btf_permute *p);
> > +static int btf_permute_remap_types(struct btf_permute *p);
> > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
> > +
> > +int btf__permute(struct btf *btf, __u32 *ids, const struct btf_permute=
_opts *opts)
>
> Let's require user to pass id_map_cnt in addition to id_map itself.
> It's easy to get this wrong (especially with that special VOID 0 type
> that has to be excluded, which I can't even make up my mind if that's
> a good idea or not), so having user explicitly say what they think is
> necessary for permutation is good.

Thank you for your suggestion. However, I am concerned that introducing
an additional `id_map_cnt` parameter could increase complexity. Specificall=
y,
if `id_map_cnt` is less than `btf->nr_types`, we might need to consider whe=
ther
to resize the BTF. This could lead to missing types, potential ID remapping
failures, or even require BTF re-deduplication if certain name strings are =
no
longer referenced by any types.

>
> > +{
> > +       struct btf_permute p;
> > +       int i, err =3D 0;
> > +       __u32 *map =3D NULL;
> > +
> > +       if (!OPTS_VALID(opts, btf_permute_opts) || !ids)
>
> libbpf doesn't protect against NULL passed for mandatory parameters,
> please drop !ids check

Thanks, I will fix it.

>
> > +               return libbpf_err(-EINVAL);
> > +
> > +       map =3D calloc(btf->nr_types, sizeof(*map));
> > +       if (!map) {
> > +               err =3D -ENOMEM;
> > +               goto done;
> > +       }
> > +
> > +       for (i =3D 0; i < btf->nr_types; i++)
> > +               map[i] =3D BTF_UNPROCESSED_ID;
> > +
> > +       p.btf =3D btf;
> > +       p.btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > +       p.ids =3D ids;
> > +       p.map =3D map;
> > +
> > +       if (btf_ensure_modifiable(btf)) {
> > +               err =3D -ENOMEM;
> > +               goto done;
> > +       }
> > +       err =3D btf_permute_shuffle_types(&p);
> > +       if (err < 0) {
> > +               pr_debug("btf_permute_shuffle_types failed: %s\n", errs=
tr(err));
>
> let's drop these pr_debug(), I don't think it's something we expect to ev=
er see

Thanks, I will remove it.

>
> > +               goto done;
> > +       }
> > +       err =3D btf_permute_remap_types(&p);
> > +       if (err < 0) {
> > +               pr_debug("btf_permute_remap_types failed: %s\n", errstr=
(err));
>
> ditto

Thanks, I will remove it.

>
> > +               goto done;
> > +       }
> > +
> > +done:
> > +       free(map);
> > +       return libbpf_err(err);
> > +}
> > +
> > +/* Shuffle BTF types.
> > + *
> > + * Rearranges types according to the permutation map in p->ids. The p-=
>map
> > + * array stores the mapping from original type IDs to new shuffled IDs=
,
> > + * which is used in the next phase to update type references.
> > + *
> > + * Validates that all IDs in the permutation array are valid and uniqu=
e.
> > + */
> > +static int btf_permute_shuffle_types(struct btf_permute *p)
> > +{
> > +       struct btf *btf =3D p->btf;
> > +       const struct btf_type *t;
> > +       __u32 *new_offs =3D NULL, *map;
> > +       void *nt, *new_types =3D NULL;
> > +       int i, id, len, err;
> > +
> > +       new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
>
> we don't really need to allocate memory and maintain this, we can just
> shift types around and then do what btf_parse_type_sec() does -- just
> go over types one by one and calculate offsets, and update them
> in-place inside btf->type_offs

Thank you for the suggestion. However, this approach is not viable because
the `btf__type_by_id()` function relies critically on the integrity of the
`btf->type_offs` data structure. Attempting to modify `type_offs` through
in-place operations could corrupt memory and lead to segmentation faults
due to invalid pointer dereferencing.

>
> > +       new_types =3D calloc(btf->hdr->type_len, 1);
> > +       if (!new_offs || !new_types) {
> > +               err =3D -ENOMEM;
> > +               goto out_err;
> > +       }
> > +
> > +       nt =3D new_types;
> > +       for (i =3D 0; i < btf->nr_types; i++) {
> > +               id =3D p->ids[i];
> > +               /* type IDs from base_btf and the VOID type are not all=
owed */
> > +               if (id < btf->start_id) {
> > +                       err =3D -EINVAL;
> > +                       goto out_err;
> > +               }
> > +               /* must be a valid type ID */
> > +               t =3D btf__type_by_id(btf, id);
> > +               if (!t) {
> > +                       err =3D -EINVAL;
> > +                       goto out_err;
> > +               }
> > +               map =3D &p->map[id - btf->start_id];
> > +               /* duplicate type IDs are not allowed */
> > +               if (*map !=3D BTF_UNPROCESSED_ID) {
>
> there is no need for BTF_UNPROCESSED_ID, zero is a perfectly valid
> value to use as "not yet set" value, as we don't allow remapping VOID
> 0 to anything anyways.

Thanks, I will fix it.

>
> > +                       err =3D -EINVAL;
> > +                       goto out_err;
> > +               }
> > +               len =3D btf_type_size(t);
> > +               memcpy(nt, t, len);
>
> once you memcpy() data, you can use that btf_field_iter_init +
> btf_field_iter_next to *trivially* remap all IDs, no need for patch 1
> refactoring, IMO. And no need for two-phase approach either.
>
> > +               new_offs[i] =3D nt - new_types;
> > +               *map =3D btf->start_id + i;
> > +               nt +=3D len;
> > +       }
> > +
> > +       free(btf->types_data);
> > +       free(btf->type_offs);
> > +       btf->types_data =3D new_types;
> > +       btf->type_offs =3D new_offs;
> > +       return 0;
> > +
> > +out_err:
> > +       free(new_offs);
> > +       free(new_types);
> > +       return err;
> > +}
> > +
> > +/* Callback function to remap individual type ID references
> > + *
> > + * This callback is invoked by btf_remap_types() for each type ID refe=
rence
> > + * found in the BTF data. It updates the reference to point to the new
> > + * permuted type ID using the mapping table.
> > + */
> > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > +{
> > +       struct btf_permute *p =3D ctx;
> > +       __u32 new_type_id =3D *type_id;
> > +
> > +       /* skip references that point into the base BTF */
> > +       if (new_type_id < p->btf->start_id)
> > +               return 0;
> > +
> > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
>
> I'm actually confused, I thought p->ids would be the mapping from
> original type ID (minus start_id, of course) to a new desired ID, but
> it looks to be the other way? ids is a desired resulting *sequence* of
> types identified by their original ID. I find it quite confusing. I
> think about permutation as a mapping from original type ID to a new
> type ID, am I confused?
>
>
> > +       if (new_type_id > BTF_MAX_NR_TYPES)
> > +               return -EINVAL;
> > +
> > +       *type_id =3D new_type_id;
> > +       return 0;
> > +}
>
> [...]

