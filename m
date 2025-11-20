Return-Path: <bpf+bounces-75138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80098C7238C
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 06:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 074A24E04D3
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 05:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF01263F2D;
	Thu, 20 Nov 2025 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0Ra2FYb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CF2356C7
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763614967; cv=none; b=eu6Cf/dSV3xE45u7iyScMbjO9sBPPk5OK/rxpG15ZY35uVSQnQeTAP7ETf0wovgOoyTUyUVG7tpDQH8hU/7R+iUDPNuwgXb1FSyxkafMFREqG1djKKPtEFFjtAKshyxRgrCHUvT1IUApzdwwbB2/LIO7O9qmxHwtFDRsULKcuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763614967; c=relaxed/simple;
	bh=2EPcLVKiQeUeTYOuVwZU37/gdWpcfb5OtWdrm4Y90N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjqYi3Rp/DqJp96wRbTAUZO692SRSXnDhCnnQKCpXVSySCfjFk33Xahld7F2fTp5qymJ0i7DZ+PHYpsMhrKR9zgr9BrpRiLirW8qOm7YO1iCJ81kYUKptZuVnNs3AaRbeB4t584cXGmpzASvqkFlnLcesRPUH3eAgjqaIxiePzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0Ra2FYb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b739ef3f739so95030666b.1
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 21:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763614963; x=1764219763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6s60zgTjflE49DAX9PTA4XOLe9Ruh7oIUyi2/ShA9Y=;
        b=Q0Ra2FYbpMFi9bgJiyQjP00QAQYg5LTyzjrwzXSSEHKYBDQiAhKoTndyH1kMAcWxKv
         Fu5+qxeTedJ3OBjdwelsUWBTGK8eBSbeLcuIltVPr1AF5nIop00owNaPVormFbeaEPX4
         vzpgePAO2YAqoG7BUm5/wnJ8+F8T/oqNFTX8o20D6L0sisoiP/MYQpmdP7A2kFpUfNnf
         CbHcjfGbBcCScWzb6NbfhfvptjBPtTzOzHDRHF6iyQy/wTkP8b3Rb/sfJy4LQtqn4zXe
         PtUINM6nNbVJBSvUq+nC00DLYLU6okkglGZCqnprTUGcec5B9D+DrIq1/ndNilphyU28
         Cd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763614963; x=1764219763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6s60zgTjflE49DAX9PTA4XOLe9Ruh7oIUyi2/ShA9Y=;
        b=X3L0QIHyIDpgzS4kpp2uCNzAit0V5IKZYdGIMak9hofzLnFT5OInnGu7mTSc6qTcWL
         8l/XKHMjb5SryaD9I7O1uXzNi/L/9YPGngHxF/tbHH5yG07g//c2JZ7nt19wcKHA1P88
         dHDRLT6tbDFyBRwRi/mTme9EQQwCsCB5uNIWGHESykRVCThAVY54CzW3+lC3S6T0AC5R
         +L1EWXODFheEC1KzMFgRLdmvrpSfPQ5Gtarg8AIh/gsoJLNNCfXpPvatfEAJXE9OZrAM
         sNl28Br0AmLup80y3hCL6LvH/nrox1CB2gtDDOyfVNbKwZIlFen3Qu9wus8bSPXfZq0s
         rScg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Yg1jIzj3VTvKm1CMJthMxK9NN5T3/jV4nFCqhxdgVSrqrt/xVdDK7K97EIc3DNFenTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xfattxr0xyVLIG0uy1k1DAwz6pTgIhn5NYfT/Xb6ge4/0oK6
	CLaHB6wfbL+KZgUYMNcnUHtaR8x62mNmho2oFeNytOmyPQHmXFppp0v6gL6f9EoCxgQnrjGKnkK
	2XQsep0ZkctFQMMr3dogFe6eb9wVKc4I=
X-Gm-Gg: ASbGncv0YGOw+XZ7llGsk6jzI6xRUTwcvhk+lFabfgrY2v/oebyWai5lYSxlrbA8huS
	Jt/HQ2qcUntRjjDLKVRqKe/AQEPIxeSJCLqTr4+nCGyKrsALYmdOhK1IDndSu6679JfEMc1GnSL
	ven8bR4EI7rZYWCk/HOxG+N9t6DGEBbyK6u+yERmBp8YTgmkcDV7e83+2Ft4cCQg6pnmoMh/Wrp
	Ap0UVqelQ7jhx0hT5G3nEyyH9P498O/n5g3xQeMaLZNl8IEztyebdQCpWJm+vjUNPPLcs79
X-Google-Smtp-Source: AGHT+IFgpAxguYf4qd9kkZeGlVNOKZ/RSz2+u4b7Bhfk0hFKVs+N6LAng3AiVtwE0q8CvwNX71mxvcpEzfJfRzD8jY4=
X-Received: by 2002:a17:907:3da3:b0:b73:870f:fa32 with SMTP id
 a640c23a62f3a-b7654fe9b58mr224526566b.43.1763614963083; Wed, 19 Nov 2025
 21:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-2-dolinux.peng@gmail.com> <CAEf4Bzb76SfWfNtxP2WVJ44hsVU-GrePmeKKxH25Q8KOn_Mkfw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb76SfWfNtxP2WVJ44hsVU-GrePmeKKxH25Q8KOn_Mkfw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 20 Nov 2025 13:02:31 +0800
X-Gm-Features: AWmQ_blHE5ppjRSuF57ofxr9EJ-306Izhp32BAawZP2LKQtrfNWs2g6ZaJmrXrs
Message-ID: <CAErzpmuNav=jVZPYmrJ4-NZ6PApGgJNBGwiQnWe40Rkr6SvYcg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/7] libbpf: Add BTF permutation support for type reordering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:22=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > Introduce btf__permute() API to allow in-place rearrangement of BTF typ=
es.
> > This function reorganizes BTF type order according to a provided array =
of
> > type IDs, updating all type references to maintain consistency.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c      | 166 +++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/btf.h      |  43 ++++++++++
> >  tools/lib/bpf/libbpf.map |   1 +
> >  3 files changed, 210 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 18907f0fcf9f..ab95ff19fde3 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -5829,3 +5829,169 @@ int btf__relocate(struct btf *btf, const struct=
 btf *base_btf)
> >                 btf->owns_base =3D false;
> >         return libbpf_err(err);
> >  }
> > +
> > +struct btf_permute {
> > +       struct btf *btf;
> > +       __u32 *id_map;
> > +};
> > +
> > +/* Callback function to remap individual type ID references */
> > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > +{
> > +       struct btf_permute *p =3D ctx;
> > +       __u32 new_type_id =3D *type_id;
> > +
> > +       /* skip references that point into the base BTF or VOID */
> > +       if (new_type_id < p->btf->start_id)
> > +               return 0;
> > +
> > +       /* invalid reference id */
> > +       if (new_type_id >=3D btf__type_cnt(p->btf))
> > +               return -EINVAL;
> > +
> > +       new_type_id =3D p->id_map[new_type_id - p->btf->start_id];
> > +       /* reference a dropped type is not allowed */
> > +       if (new_type_id =3D=3D 0)
> > +               return -EINVAL;
>
> see below, this shouldn't happen, let's drop redundant check

Thanks, I will remove it.

>
> > +
> > +       *type_id =3D new_type_id;
> > +       return 0;
> > +}
> > +
> > +int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
> > +                const struct btf_permute_opts *opts)
> > +{
> > +       struct btf_permute p;
> > +       struct btf_ext *btf_ext;
> > +       void *next_type, *end_type;
> > +       void *nt, *new_types =3D NULL;
> > +       int err =3D 0, i, new_type_len;
> > +       __u32 *order_map =3D NULL;
> > +       __u32 id, new_nr_types =3D 0;
> > +
> > +       if (!OPTS_VALID(opts, btf_permute_opts) || id_map_cnt !=3D btf-=
>nr_types)
> > +               return libbpf_err(-EINVAL);
> > +
> > +       /* used to record the storage sequence of types */
> > +       order_map =3D calloc(btf->nr_types, sizeof(*id_map));
> > +       if (!order_map) {
> > +               err =3D -ENOMEM;
> > +               goto done;
> > +       }
> > +
> > +       new_types =3D calloc(btf->hdr->type_len, 1);
> > +       if (!new_types) {
> > +               err =3D -ENOMEM;
> > +               goto done;
> > +       }
> > +
> > +       if (btf_ensure_modifiable(btf)) {
> > +               err =3D -ENOMEM;
> > +               goto done;
> > +       }
> > +
> > +       for (i =3D 0; i < id_map_cnt; i++) {
> > +               id =3D id_map[i];
> > +               /* Drop the specified type */
> > +               if (id =3D=3D 0)
> > +                       continue;
>
> if we don't allow this (no support for deletion, I wouldn't rush to
> add that right now)...

Thanks, I will remove it.

>
> pw-bot: cr
>
>
> > +               /* Invalid id  */
>
> obvious statement, IMO, please drop the comment

Thanks, I will remove it.

>
> > +               if (id < btf->start_id || id >=3D btf__type_cnt(btf)) {
> > +                       err =3D -EINVAL;
> > +                       goto done;
> > +               }
> > +               id -=3D btf->start_id;
> > +               /* Multiple types cannot be mapped to the same ID */
> > +               if (order_map[id]) {
> > +                       err =3D -EINVAL;
> > +                       goto done;
> > +               }
> > +               order_map[id] =3D i + btf->start_id;
> > +               new_nr_types =3D max(id + 1, new_nr_types);
> > +       }
> > +
> > +       /* Check for missing IDs */
> > +       for (i =3D 0; i < new_nr_types; i++) {
> > +               if (order_map[i] =3D=3D 0) {
> > +                       err =3D -EINVAL;
> > +                       goto done;
> > +               }
> > +       }
>
> ... then you won't need this check at all, because we enforced that
> each remapped ID is different and we have exactly nr_types of them.
> Same for new_nr_types calculation above, seems redundant

Yes, if we don't support the dropping feature, there's no need to do
this. I'll remove it.

>
> > +
> > +       p.btf =3D btf;
> > +       p.id_map =3D id_map;
> > +       nt =3D new_types;
> > +       for (i =3D 0; i < new_nr_types; i++) {
> > +               struct btf_field_iter it;
> > +               const struct btf_type *t;
> > +               __u32 *type_id;
> > +               int type_size;
> > +
> > +               id =3D order_map[i];
> > +               /* must be a valid type ID */
>
> redundant comment, please drop

Thanks, I will remove it.

>
> > +               t =3D btf__type_by_id(btf, id);
> > +               if (!t) {
>
> no need to check this, we already validated that all types are valid earl=
ier

Thanks, I will remove it.

>
> > +                       err =3D -EINVAL;
> > +                       goto done;
> > +               }
> > +               type_size =3D btf_type_size(t);
> > +               memcpy(nt, t, type_size);
> > +
> > +               /* Fix up referenced IDs for BTF */
> > +               err =3D btf_field_iter_init(&it, nt, BTF_FIELD_ITER_IDS=
);
> > +               if (err)
> > +                       goto done;
> > +               while ((type_id =3D btf_field_iter_next(&it))) {
> > +                       err =3D btf_permute_remap_type_id(type_id, &p);
> > +                       if (err)
> > +                               goto done;
> > +               }
> > +
> > +               nt +=3D type_size;
> > +       }
> > +
> > +       /* Fix up referenced IDs for btf_ext */
> > +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > +       if (btf_ext) {
> > +               err =3D btf_ext_visit_type_ids(btf_ext, btf_permute_rem=
ap_type_id, &p);
> > +               if (err)
> > +                       goto done;
> > +       }
> > +
> > +       new_type_len =3D nt - new_types;
>
>
> new_type_len has to be exactly the same as the old size, this is redundan=
t

Yes, if we don't support the dropping feature, there's no need to do
this. I'll remove it.

>
> > +       next_type =3D new_types;
> > +       end_type =3D next_type + new_type_len;
> > +       i =3D 0;
> > +       while (next_type + sizeof(struct btf_type) <=3D end_type) {
>
> while (next_type < end_type)?
>
> Reference to struct btf_type is confusing, as generally type is bigger
> than just sizeof(struct btf_type). But there is no need for this, with
> correct code next_type < end_type is sufficient check
>
> But really, this can also be written cleanly as a simple for loop
>
> for (i =3D 0; i < nr_types; i++) {
>     btf->type_offs[i] =3D next_type - new_types;
>     next_type +=3D btf_type_size(next_type);
> }

Great, thanks.

>
> > +               btf->type_offs[i++] =3D next_type - new_types;
> > +               next_type +=3D btf_type_size(next_type);
> > +       }
> > +
> > +       /* Resize */
>
> there cannot be any resizing, drop this, you only need to reassign
> btf->types_data, that's all

Okay, I will do it.

>
> > +       if (new_type_len < btf->hdr->type_len) {
> > +               void *tmp_types;
> > +
> > +               tmp_types =3D realloc(new_types, new_type_len);
> > +               if (new_type_len && !tmp_types) {
> > +                       err =3D -ENOMEM;
> > +                       goto done;
> > +               }
> > +               new_types =3D tmp_types;
> > +               btf->nr_types =3D new_nr_types;
> > +               btf->type_offs_cap =3D btf->nr_types;
> > +               btf->types_data_cap =3D new_type_len;
> > +               btf->hdr->type_len =3D new_type_len;
> > +               btf->hdr->str_off =3D new_type_len;
> > +               btf->raw_size =3D btf->hdr->hdr_len + btf->hdr->type_le=
n + btf->hdr->str_len;
> > +       }
> > +
> > +       free(order_map);
> > +       free(btf->types_data);
> > +       btf->types_data =3D new_types;
> > +       return 0;
> > +
> > +done:
> > +       free(order_map);
> > +       free(new_types);
> > +       return libbpf_err(err);
> > +}
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index ccfd905f03df..e63dcce531b3 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -273,6 +273,49 @@ LIBBPF_API int btf__dedup(struct btf *btf, const s=
truct btf_dedup_opts *opts);
> >   */
> >  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_b=
tf);
> >
> > +struct btf_permute_opts {
> > +       size_t sz;
> > +       /* optional .BTF.ext info along the main BTF info */
> > +       struct btf_ext *btf_ext;
> > +       size_t :0;
> > +};
> > +#define btf_permute_opts__last_field btf_ext
> > +
> > +/**
> > + * @brief **btf__permute()** performs in-place BTF type rearrangement
> > + * @param btf BTF object to permute
> > + * @param id_map Array mapping original type IDs to new IDs
> > + * @param id_map_cnt Number of elements in @id_map
> > + * @param opts Optional parameters for BTF extension updates
> > + * @return 0 on success, negative error code on failure
> > + *
> > + * **btf__permute()** rearranges BTF types according to the specified =
ID mapping.
> > + * The @id_map array defines the new type ID for each original type ID=
.
> > + *
> > + * For **base BTF**:
> > + * - @id_map must include all types from ID 1 to `btf__type_cnt(btf)-1=
`
> > + * - @id_map_cnt should be `btf__type_cnt(btf) - 1`
> > + * - Mapping uses `id_map[original_id - 1] =3D new_id`
> > + *
> > + * For **split BTF**:
> > + * - @id_map should cover only split types
> > + * - @id_map_cnt should be `btf__type_cnt(btf) - btf__type_cnt(btf__ba=
se_btf(btf))`
> > + * - Mapping uses `id_map[original_id - btf__type_cnt(btf__base_btf(bt=
f))] =3D new_id`
> > + *
> > + * Setting @id_map element to 0 drops the corresponding type. Dropped =
types must not
> > + * be referenced by any retained types. After permutation, type refere=
nces in BTF
> > + * data and optional extension are updated automatically.
>
> let's not add deletion support just yet

Thanks, I will modify the annotations.

>
> > + *
> > + * Note: Dropping types may orphan some strings, requiring subsequent =
**btf__dedup()**
> > + * to clean up unreferenced strings.
>
> one more reason to not add deletion just yet. It's good to have an API
> that can express this, but we don't have to support deletion just yet.

Thanks, I will remove it.

>
> > + *
> > + * On error, returns negative error code and sets errno:
> > + *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, out-of=
-range)
> > + *   - `-ENOMEM`: Memory allocation failure
> > + */
> > +LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_m=
ap_cnt,
> > +                           const struct btf_permute_opts *opts);
> > +
> >  struct btf_dump;
> >
> >  struct btf_dump_opts {
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 8ed8749907d4..b778e5a5d0a8 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
> >         global:
> >                 bpf_map__set_exclusive_program;
> >                 bpf_map__exclusive_program;
> > +               btf__permute;
> >  } LIBBPF_1.6.0;
> > --
> > 2.34.1
> >

