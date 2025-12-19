Return-Path: <bpf+bounces-77120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34321CCE59E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 04:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8791D305AE45
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4591F8BD6;
	Fri, 19 Dec 2025 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlzdsCsW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B584C79
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766114221; cv=none; b=Dxo3VQA1PnXGZUK8+OZ+Qg3tNVHP1WvfbT+j9v/T2quRzBG2CeRgLt/BO8Ioi8M4x0VoovhbjxW3EBbQZv3TIlpNLL+1rqBEP9wfIQNRfAJW7yVpENJZcVxvDvbDaVKPbM5a8fAWBdwKy8oOpeB2luz+V4AYmKNu+kF9MCOApw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766114221; c=relaxed/simple;
	bh=bAcnM5UnrQ6AtFk6a7ypzCtXewloiUglOILJESiZpJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeC+Qt+wE1hM1/VCaYsQncaQTBP8eucLfcJYcyowEcIXpAPMTzJdxF7foD6kXSNsklq7er6Wj6rAjmR3nljjKgBodkgXEnC2SYSTAauHa2Y+VmKJ1LLzY8w7vgUwBvq8+mjsqNswX0JwrheGPe8HXhCQHCMWwl6+8RqBP0rMZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlzdsCsW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b72b495aa81so223670366b.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766114218; x=1766719018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8gsoZkK46QB2x62MaCbG9WfgyzcgBYt446GcqpfAog=;
        b=FlzdsCsWv1AEvviV4EXC6fhnC9JSEC/3zLcxoJcKAn6z6VYYuU4pP5tV5kA2M5u44o
         68um9JCOXTcJQLIvisAr288gGxb/U2Mfh/bGzPEYsPhJ8gDb7lBfdfTeLI+VHaNkf33W
         /1Rh5Xj87yYHIZlKNTr+cuWvJqhPv+P5S0eGqcU/+pWu/lwuLynHZCvp5GF9y0zzUdkm
         Ev8CVlhy1AoNUjKlgGnPvR22EiffNF8QmVrXdGlw6ioCgRDHLV06DGES5ry+UB080AFk
         MZ6hzI/4c2LxRJj62Zu4QB4Jx1c4G9SZYYYh790UFlKD3rVYGSxbdcxMG7Bmml/WHR6l
         /Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766114218; x=1766719018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d8gsoZkK46QB2x62MaCbG9WfgyzcgBYt446GcqpfAog=;
        b=az3Fg1a6lWIL0QAOmjzFu59uc0QFuTB0hC0XhwDU/M51oNIftQrp21hgv5rV/uq3ul
         ovKL6VAQFFQX+qnCfV0oj298usRAjpkekdfTImZqsyUQ7VLLWOzLeXmZtL8DbERBwNnq
         EmJmOdUqhfBrnW7q/NLs1f9CV92sW+1u9ZH+beWMaEDA/1JQXAFnDvYhBiKckCnZUagP
         YosMYWDNg+sRX6f9yne/ZyAat0HrQthd7RhZsFT/Cyw8WJ7zgTyCz9h3KW1Blq/SkFDE
         YCi/CLDNS/SJuFg1LI6lU4cuddva34vLYl1ZW80f0bRjFnwd43eq90kxeg7k//0vwKeW
         KqIw==
X-Forwarded-Encrypted: i=1; AJvYcCVu8pcG1rHDarvVx+MLgfdTEteSjTxEOHLw8glr5zgaS468LuvgaPim3Ku3gXe/blNWH2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbb0ac8EUUJyHM9lQDaqf0FHQpchByO1kbanT3N7zJm1MKEPxy
	NNurGiXjkZ1s5G3xUix5RqtOQZfD6Wazim1j25/qW0BKxPirSSsDeGQY/9ato8TqJ/rSnrLm54i
	roC3Jikge8AIQZJROxw/amJakwMzO+sg=
X-Gm-Gg: AY/fxX6WGu8HM3MFOpRJ8muWemcs2olOYEn0ZAPLN0zjw+v+y+1qNXlCW2M0m9rQhiC
	ivr9ohRlt9QpyuXZ4vh+8Z4OOfZ06mXlM75JsNxAyascecSQzNNRfruCdTkJPlGNsWRdmSYuHbY
	jiGRkDmnaVsmzJBGy5xnyKUkl8TU/tXpbvCm3BGhyedD4t3SAhZ02Wkb1xiHKKziXRYE6z3rgLV
	KGXTfK7VQ8DN3HlqTHgyr0E6Knp5wFyZyCYSLgchPXY05iBkxX/GDVWYIt1otiBxkAFm7Vs
X-Google-Smtp-Source: AGHT+IHiG1LqzW5HekuTCyLinDSl9QYN4KFFE23BDW6zFD4Bglewr9kpm5USZikgcNdYFnApyBn4c7tJCXCqT1CMzfk=
X-Received: by 2002:a17:907:7ea4:b0:b73:5f48:6159 with SMTP id
 a640c23a62f3a-b8036f2d2a1mr152283366b.5.1766114217515; Thu, 18 Dec 2025
 19:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-2-dolinux.peng@gmail.com> <CAEf4BzYJpw+yEv=g9P1z0NS8Qw8PdFf7039MT0PSv30DwkjBzw@mail.gmail.com>
 <CAErzpmu4K3rF3JLycEYNqzNcBkSgBxijj1RAYBPuprvBU6LHmQ@mail.gmail.com>
In-Reply-To: <CAErzpmu4K3rF3JLycEYNqzNcBkSgBxijj1RAYBPuprvBU6LHmQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 11:16:45 +0800
X-Gm-Features: AQt7F2ozmDuNDZ0ZYH3DmCxZC-R-lJOjpJkPRXAf-e4kmGI8ns2r07ML0PJZ520
Message-ID: <CAErzpmt0yZ7hY-CtsLZ-b+KUbq4F6n2ED2q4P=-BLMadqbwx8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 01/13] libbpf: Add BTF permutation support
 for type reordering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 11:14=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
>
> On Fri, Dec 19, 2025 at 7:02=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > Introduce btf__permute() API to allow in-place rearrangement of BTF t=
ypes.
> > > This function reorganizes BTF type order according to a provided arra=
y of
> > > type IDs, updating all type references to maintain consistency.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  tools/lib/bpf/btf.c      | 119 +++++++++++++++++++++++++++++++++++++=
++
> > >  tools/lib/bpf/btf.h      |  36 ++++++++++++
> > >  tools/lib/bpf/libbpf.map |   1 +
> > >  3 files changed, 156 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index b136572e889a..ab204ca403dc 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -5887,3 +5887,122 @@ int btf__relocate(struct btf *btf, const stru=
ct btf *base_btf)
> > >                 btf->owns_base =3D false;
> > >         return libbpf_err(err);
> > >  }
> > > +
> > > +struct btf_permute {
> > > +       struct btf *btf;
> > > +       __u32 *id_map;
> > > +};
> > > +
> > > +/* Callback function to remap individual type ID references */
> > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > > +{
> > > +       struct btf_permute *p =3D ctx;
> > > +       __u32 new_type_id =3D *type_id;
> > > +
> > > +       /* refer to the base BTF or VOID type */
> > > +       if (new_type_id < p->btf->start_id)
> > > +               return 0;
> > > +
> > > +       if (new_type_id >=3D btf__type_cnt(p->btf))
> > > +               return -EINVAL;
> > > +
> > > +       *type_id =3D p->id_map[new_type_id - p->btf->start_id];
> > > +       return 0;
> > > +}
> > > +
> > > +int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
> > > +                const struct btf_permute_opts *opts)
> > > +{
> > > +       struct btf_permute p;
> > > +       struct btf_ext *btf_ext;
> > > +       void *nt, *new_types =3D NULL;
> > > +       __u32 *order_map =3D NULL;
> > > +       int err =3D 0, i;
> > > +       __u32 id;
> > > +
> > > +       if (!OPTS_VALID(opts, btf_permute_opts) || id_map_cnt !=3D bt=
f->nr_types)
> > > +               return libbpf_err(-EINVAL);
> > > +
> > > +       /* record the sequence of types */
> > > +       order_map =3D calloc(id_map_cnt, sizeof(*id_map));
> > > +       if (!order_map) {
> > > +               err =3D -ENOMEM;
> > > +               goto done;
> > > +       }
> > > +
> > > +       new_types =3D calloc(btf->hdr->type_len, 1);
> > > +       if (!new_types) {
> > > +               err =3D -ENOMEM;
> > > +               goto done;
> > > +       }
> > > +
> > > +       if (btf_ensure_modifiable(btf)) {
> > > +               err =3D -ENOMEM;
> > > +               goto done;
> > > +       }
> > > +
> > > +       for (i =3D 0; i < id_map_cnt; i++) {
> > > +               id =3D id_map[i];
> > > +               if (id < btf->start_id || id >=3D btf__type_cnt(btf))=
 {
> > > +                       err =3D -EINVAL;
> > > +                       goto done;
> > > +               }
> > > +               id -=3D btf->start_id;
> > > +               /* cannot be mapped to the same ID */
> > > +               if (order_map[id]) {
> > > +                       err =3D -EINVAL;
> > > +                       goto done;
> > > +               }
> > > +               order_map[id] =3D i + btf->start_id;
> > > +       }
> > > +
> > > +       p.btf =3D btf;
> > > +       p.id_map =3D id_map;
> > > +       nt =3D new_types;
> > > +       for (i =3D 0; i < id_map_cnt; i++) {
> > > +               struct btf_field_iter it;
> > > +               const struct btf_type *t;
> > > +               __u32 *type_id;
> > > +               int type_size;
> > > +
> > > +               id =3D order_map[i];
> > > +               t =3D btf__type_by_id(btf, id);
> > > +               type_size =3D btf_type_size(t);
> > > +               memcpy(nt, t, type_size);
> > > +
> > > +               /* fix up referenced IDs for BTF */
> > > +               err =3D btf_field_iter_init(&it, nt, BTF_FIELD_ITER_I=
DS);
> > > +               if (err)
> > > +                       goto done;
> > > +               while ((type_id =3D btf_field_iter_next(&it))) {
> > > +                       err =3D btf_permute_remap_type_id(type_id, &p=
);
> > > +                       if (err)
> > > +                               goto done;
> > > +               }
> > > +
> > > +               nt +=3D type_size;
> > > +       }
> > > +
> > > +       /* fix up referenced IDs for btf_ext */
> > > +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > > +       if (btf_ext) {
> > > +               err =3D btf_ext_visit_type_ids(btf_ext, btf_permute_r=
emap_type_id, &p);
> > > +               if (err)
> > > +                       goto done;
> > > +       }
> > > +
> > > +       for (nt =3D new_types, i =3D 0; i < id_map_cnt; i++) {
> > > +               btf->type_offs[i] =3D nt - new_types;
> > > +               nt +=3D btf_type_size(nt);
> > > +       }
> > > +
> > > +       free(order_map);
> > > +       free(btf->types_data);
> > > +       btf->types_data =3D new_types;
> > > +       return 0;
> > > +
> > > +done:
> > > +       free(order_map);
> > > +       free(new_types);
> > > +       return libbpf_err(err);
> > > +}
> > > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > > index cc01494d6210..5d560571b1b5 100644
> > > --- a/tools/lib/bpf/btf.h
> > > +++ b/tools/lib/bpf/btf.h
> > > @@ -281,6 +281,42 @@ LIBBPF_API int btf__dedup(struct btf *btf, const=
 struct btf_dedup_opts *opts);
> > >   */
> > >  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base=
_btf);
> > >
> > > +struct btf_permute_opts {
> > > +       size_t sz;
> > > +       /* optional .BTF.ext info along the main BTF info */
> > > +       struct btf_ext *btf_ext;
> > > +       size_t :0;
> > > +};
> > > +#define btf_permute_opts__last_field btf_ext
> > > +
> > > +/**
> > > + * @brief **btf__permute()** performs in-place BTF type rearrangemen=
t
> > > + * @param btf BTF object to permute
> > > + * @param id_map Array mapping original type IDs to new IDs
> > > + * @param id_map_cnt Number of elements in @id_map
> > > + * @param opts Optional parameters for BTF extension updates
> > > + * @return 0 on success, negative error code on failure
> > > + *
> > > + * **btf__permute()** rearranges BTF types according to the specifie=
d ID mapping.
> > > + * The @id_map array defines the new type ID for each original type =
ID.
> > > + *
> > > + * @id_map must include all types from ID `start_id` to `btf__type_c=
nt(btf) - 1`.
> > > + * @id_map_cnt should be `btf__type_cnt(btf) - start_id`
> > > + * The mapping is defined as: `id_map[original_id - start_id] =3D ne=
w_id`
> >
> > Would you mind paying attention to the feedback I left in [0]? Thank yo=
u.
>
> Apologies for the delayed response, I would like to hear if someone has a
> different idea.
>
> >
> > The contract should be id_map[original_id] =3D new_id for base BTF and
> > id_map[original_id - btf__type_cnt(base_btf)] =3D new_id for split BTF.
> > Special BTF type #0 (VOID) is considered to be part of base BTF,
> > having id_map[0] =3D 0 is easy to check and enforce. And then it leaves
> > us with a simple and logical rule for id_map. For split BTF we make
> > necessary type ID shifts to avoid tons of wasted memory. But for base
> > BTF there is no need to shift anything. So mapping the original type
> > #X to #Y is id_map[X] =3D Y. Literally, "map X to Y", as simple as that=
.
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4BzY_k721TBfRSUeq5mB-7fgJhVKCeXVK=
O-W2EjQ0aS9AgA@mail.gmail.com/
>
> Thanks. I implemented the approach in v6, but it had inconsistent interna=
l
> details for base and split BTF. It seems we prioritize external contract
> consistency over internal inconsistencies, so I=E2=80=99ll revert to the =
v6 approach
> and refine it for clarity.

Link to v6: https://lore.kernel.org/all/20251117132623.3807094-2-dolinux.pe=
ng@gmail.com/

>
> >
> > > + *
> > > + * For base BTF, its `start_id` is fixed to 1, i.e. the VOID type ca=
n
> > > + * not be redefined or remapped and its ID is fixed to 0.
> > > + *
> > > + * For split BTF, its `start_id` can be retrieved by calling
> > > + * `btf__type_cnt(btf__base_btf(btf))`.
> > > + *
> > > + * On error, returns negative error code and sets errno:
> > > + *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, out-=
of-range)
> > > + *   - `-ENOMEM`: Memory allocation failure
> > > + */
> > > +LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id=
_map_cnt,
> > > +                           const struct btf_permute_opts *opts);
> > > +
> > >  struct btf_dump;
> > >
> > >  struct btf_dump_opts {
> > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > index 84fb90a016c9..d18fbcea7578 100644
> > > --- a/tools/lib/bpf/libbpf.map
> > > +++ b/tools/lib/bpf/libbpf.map
> > > @@ -453,4 +453,5 @@ LIBBPF_1.7.0 {
> > >                 bpf_map__exclusive_program;
> > >                 bpf_prog_assoc_struct_ops;
> > >                 bpf_program__assoc_struct_ops;
> > > +               btf__permute;
> > >  } LIBBPF_1.6.0;
> > > --
> > > 2.34.1
> > >

