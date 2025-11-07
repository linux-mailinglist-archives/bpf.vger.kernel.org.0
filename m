Return-Path: <bpf+bounces-73943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50763C3EB68
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 08:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2214E4EA89B
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 07:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90119307AC8;
	Fri,  7 Nov 2025 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2QffX2q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3852C325F
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499584; cv=none; b=e8nNtT3NHXY+SxucdtT//JmXPrJin2A0QPdSAZHYSzIQ82oAqniOXg7XQrY0bVmCLlKtkVLRrMbj9jA84fzMFU/MiOjqvQoO116QF2qLjhZazN3GguYdIZUoOove458JyFR9W1tlXflHBDiZeNol0bmoZp/+6QUVuECGeUJNxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499584; c=relaxed/simple;
	bh=AnHNniu0pCdXghvw2Pl/euA5eGN8u2vE4cvHIahrfxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4S0kyObVX0l0I23bTkOQgj3xc1U77FXwq9+vmslJ5FZkZbYaYyAl6lndwx71vn+46ocZ677FRtW7KG2ReKYPH7Fqjxtipcxlz1c1lYEwKcyP+IGTTa2wJsKm6V1NwVNaOnf0ixf0G8XT1GOiNcPSBT5ASbxAzU6jNT2Vc2WdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2QffX2q; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso751811a12.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 23:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762499581; x=1763104381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgSLZZs6Fwc/5qGJ5Q4UyqQtiAlwyxjSUqJRm3a25hI=;
        b=m2QffX2qNvUr45YO660hHZrSdER8K5+la03cZ75bpvJow1E9CJl3e+vSCb8T0oO7Fb
         rHtJaKL9NLlDOhAELRC8jiWuAO3XRyetLPZtKwQjpLLK/TyqFnEs2mWKhNk6jT928yx1
         k3lsr9k/SLbf6bRuloZOf+z0ziNTNns2+BJtxetCjj7FLWG/XO+Np47YS9rNIS1pDuD6
         3eH8aYKny8+h7FsQU5RBsIJf8rVP882g10hDEiaz7pKqJ8RNtyaHuw55K5N/0lqM72k9
         bKltN6BE3Ohe68Q9CMM0Zn+3Sl4exbL31h5vjEMlEbXkHxd8O9J/MN4V3iLgURb9pDPZ
         df8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499581; x=1763104381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgSLZZs6Fwc/5qGJ5Q4UyqQtiAlwyxjSUqJRm3a25hI=;
        b=nzP7bTQ0AokSJJh96F7ENExykqN3BHtBDTo0mQKxJn82LAD45BJ6RtLaiDIkGhhkha
         +0Pssh6ly92nQcSqFiIJ3Ipr/hFNgdMiuVr1rpxOU0Kv6+BhLpjaG6Bk3e+tMBNcNXw/
         cwsprUAg1UJea+mVS0zovsrE1lUqqhflFj5+r+EYcWlWLfjfy//P4AE86qi1VwzUDGjl
         BlwB2pZda38QCNNVm8+TgtSD8nTyCMNl40D/x4NtqvLKN3gDqQKZSsBgjvsT9K/UvIzp
         KqkA4Pmq1PGWdi+sxUbeJClvaQYDBvnLvmfFkvVqSUlIBVQm3E6U/ntFYdfzoNIneBIK
         2rnA==
X-Forwarded-Encrypted: i=1; AJvYcCWNWJUH4mNToWV6yCVRsAVobxTtbwrsymcm56AJpD42TVjK4hD4dIsyRfcuYDZfWFsFrI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwldOA95/8pZQtm+i82MEhwqy4MlJnoE3MDhM1Hqe/aJacflXBb
	3Twv12tP+hsu9ekAabDj97LC4q8IGeHC2u9156uV2v+iNamGOFqCnYkfsddo+q2nwjO2mCPFcf0
	cFlra8GFIgOMtdLOnSvI0AWbRqPOmhfE=
X-Gm-Gg: ASbGnctnStI1c9oWTWLn+zjBcQR2GeCZVhlERGYxbBhb7PaJEyZiHdgKYog+i3Vgd1R
	8MBC6EgAvAAgdW6dU+HN92zEmGpaPvsIsg3dWdo5nI/8bAoJ6Dpw3zHrx72y4Zz9/qUf/YEWC64
	W16Y8BVITGb4BsEPHX+4z0kTqwH2t5eIh6jyLEm7hzRL6SZTKMA1vEQwVw7CcKLEACLdGwChVVp
	/8sqfpaUD+Qe85Wz8GhNLhpDWw3Qay53C3+STMDxw7xPPQblr6gh6gIt3S7aHvwID0vR86F
X-Google-Smtp-Source: AGHT+IEuqvDGcde7z9yd376iwgyGimO6uoR69Fkm1BPx7nWXVFk+h9CgdUcqdihT6jI1cgO1zJBBkUlHmIDIBoLM8Ok=
X-Received: by 2002:a17:907:1c18:b0:b71:1420:334a with SMTP id
 a640c23a62f3a-b72c0932a0dmr203114466b.13.1762499580592; Thu, 06 Nov 2025
 23:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-3-dolinux.peng@gmail.com> <36cd75fea9d630152704e29bd21054aba72dcb459a7b9d40b5d979313b1fe3a5@mail.kernel.org>
In-Reply-To: <36cd75fea9d630152704e29bd21054aba72dcb459a7b9d40b5d979313b1fe3a5@mail.kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 7 Nov 2025 15:12:48 +0800
X-Gm-Features: AWmQ_blNvN-Ihf8AbmrgtyJ2vjtFsUEMSGGxRnE8kPrZNs0IA_vnsSz-wxumv3M
Message-ID: <CAErzpmt0L6hS8W0xXznrVY8dLJN_opS8ZyyorT3m7yyANLQ9Cw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] libbpf: Add BTF permutation support for type reordering
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	alan.maguire@oracle.com, song@kernel.org, pengdonglin@xiaomi.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 9c389b2c8..97451a929 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> > +int btf__permute(struct btf *btf, __u32 *ids, __u32 ids_sz, const stru=
ct btf_permute_opts *opts)
> > +{
> > +     struct btf_permute p;
> > +     int err =3D 0;
> > +     __u32 *ids_map =3D NULL;
> > +
> > +     if (!OPTS_VALID(opts, btf_permute_opts) || (ids_sz > btf->nr_type=
s))
> > +             return libbpf_err(-EINVAL);
> > +
> > +     ids_map =3D calloc(ids_sz, sizeof(*ids_map));
>
> Can ids_map overflow here in btf_permute_shuffle_types()?
>
> The ids_map array is allocated with ids_sz elements, giving valid
> indices from 0 to ids_sz-1. However, in btf_permute_shuffle_types()
> the code accesses:
>
>     ids_map =3D &p->ids_map[id - btf->start_id]
>
> where 'id' is validated only to be in range [btf->start_id,
> btf->start_id + btf->nr_types). When ids_sz < btf->nr_types
> (truncation case) and a user provides a type ID where
> (id - btf->start_id) >=3D ids_sz, this results in an out-of-bounds
> write to ids_map.
>
> For example, with start_id=3D1, nr_types=3D100, and ids_sz=3D50:
> - ids_map has 50 elements (indices 0-49)
> - If user includes type ID 75 in the ids array
> - btf__type_by_id(btf, 75) succeeds (75 < 101)
> - ids_map[75-1] =3D ids_map[74] writes beyond the array
>

Thanks, I will fix it.

> The same issue occurs in btf_permute_remap_type_id() where the code
> reads from ids_map without validating the index is within ids_sz:
>
>     new_type_id =3D p->ids_map[*type_id - p->btf->start_id]
>
> If any included type references a type ID beyond ids_sz, this reads
> uninitialized memory (or out-of-bounds if the ID is >=3D ids_sz +
> start_id).

Thanks, I will fix it.

>
> > +     if (!ids_map) {
> > +             err =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +
> > +     p.btf =3D btf;
> > +     p.btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > +     p.ids =3D ids;
> > +     p.ids_map =3D ids_map;
> > +     p.ids_sz =3D ids_sz;
> > +
> > +     if (btf_ensure_modifiable(btf)) {
> > +             err =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +     err =3D btf_permute_shuffle_types(&p);
> > +     if (err < 0) {
> > +             goto done;
> > +     }
> > +     err =3D btf_permute_remap_types(&p);
> > +     if (err < 0) {
> > +             goto done;
> > +     }
> > +
> > +done:
> > +     free(ids_map);
> > +     return libbpf_err(err);
> > +}
>
> [ ... ]
>
> > +static int btf_permute_shuffle_types(struct btf_permute *p)
> > +{
> > +     struct btf *btf =3D p->btf;
> > +     const struct btf_type *t;
> > +     __u32 *new_offs =3D NULL, *ids_map;
> > +     void *nt, *new_types =3D NULL;
> > +     int i, id, len, err;
> > +
> > +     new_offs =3D calloc(p->ids_sz, sizeof(*new_offs));
> > +     new_types =3D calloc(btf->hdr->type_len, 1);
> > +     if (!new_offs || !new_types) {
> > +             err =3D -ENOMEM;
> > +             goto out_err;
> > +     }
> > +
> > +     nt =3D new_types;
> > +     for (i =3D 0; i < p->ids_sz; i++) {
> > +             id =3D p->ids[i];
> > +             /* type IDs from base_btf and the VOID type are not allow=
ed */
> > +             if (id < btf->start_id) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> > +             /* must be a valid type ID */
> > +             t =3D btf__type_by_id(btf, id);
> > +             if (!t) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> > +             ids_map =3D &p->ids_map[id - btf->start_id];
> > +             /* duplicate type IDs are not allowed */
> > +             if (*ids_map) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> > +             len =3D btf_type_size(t);
> > +             memcpy(nt, t, len);
> > +             new_offs[i] =3D nt - new_types;
> > +             *ids_map =3D btf->start_id + i;
> > +             nt +=3D len;
> > +     }
>
> [ ... ]
>
> > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > +{
> > +     struct btf_permute *p =3D ctx;
> > +     __u32 new_type_id =3D *type_id;
> > +
> > +     /* skip references that point into the base BTF */
> > +     if (new_type_id < p->btf->start_id)
> > +             return 0;
> > +
> > +     new_type_id =3D p->ids_map[*type_id - p->btf->start_id];
> > +     if (new_type_id > BTF_MAX_NR_TYPES)
> > +             return -EINVAL;
> > +
> > +     *type_id =3D new_type_id;
> > +     return 0;
> > +}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/191371=
95500

