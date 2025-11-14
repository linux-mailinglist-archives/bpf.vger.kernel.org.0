Return-Path: <bpf+bounces-74502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDD7C5CA93
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFCFB4F4CE8
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D31314A8A;
	Fri, 14 Nov 2025 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4PFHP3F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CA3128A1
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116705; cv=none; b=evwHuuVJHeqIxW5zsacGrSnfm/qLfL5PFXjTa5A0t/rBq9OR1pDPwW12Qu4HFyy1BySJnm42UfPi6WE3eA3dxr8Hi3k46btNGZaf6JuKYxBWnyizhALhgG0guTnW/rsHeEQdj3Y3bMWo0zvdqIpHYQzXblF0IM1+zrEybl3WXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116705; c=relaxed/simple;
	bh=MZBwTfPaH6K8uMR+f6YsNvf/qYdsucd7eQtSg7C1i70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUe2mQxdZqwKekSGgogOWQ94g2cgrzuBESW44iPIWCwQrS1a6o3F0qSkgtVWuyOFgQDyG59cUrnj2YcGBHT4Va+HVozClYvTV6E3QRToRYv2iVL+2pEjNeU0F+1XrNL9iCe9JqHrfWQidvTsDhRC4z/RMy8lpcMXvb7YBwJ0q6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4PFHP3F; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so3258600a12.3
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 02:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763116701; x=1763721501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToItxOxQyGYcb51Cb8S4obpe3F9eTCyfs+gXZVEwoSI=;
        b=k4PFHP3FbicNCT540ECEQudbOAb6M2dGeNnS8OSpgCbuVGF6LKVgD7Uwm1aYER6S5/
         Q5WXQtKi06Z4fUUdcAor32HFEkKHahM26WpvVnZnAqtBCDwK2buYgAAULSUl4NUuWLX6
         eO+O2wLQ8PiLDkuHUTIxHfTE7lOAXvt5ySQ+0h7YmrJoyUyU+iMj8vZTBTfYDiAurQKJ
         OlZcWLIrkReBiV80WeaJwhOnJBPzdhBYmGjdObYtWosNBmAADdztRekjBo6bvRHfzOyT
         QbBmLGaWj7XP9bGIr3o+DyCvv0m27NRrs3oWFNzbYQ2+pN0m5MXusDvBg8XFwIuUmJjA
         vmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763116701; x=1763721501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ToItxOxQyGYcb51Cb8S4obpe3F9eTCyfs+gXZVEwoSI=;
        b=FtOr7hh4MxsA8pOZDGbKlieJs8I8fbbKbSZb1+zaqzakvfFWcWCL6Wtz/CWfinf5as
         09lZ20jL4Qgs2rZHLE31mOc9j9jHfGFkZbldgvGs+7oHug7jREG3NLn6t02xJReETM/k
         mpEzXSDyAAZfMQuT0IaGNG+yoTcJqMUohV37G6vz+4cnF919itjX0GS25Q5Vysk3MPIM
         CSi/pJSxYmPkFEPugKHfW8d+Hz2r5YaJCrAUz52dI1BmRP8w1gAeNoKKwPuU54o3SLZG
         gPhoZ2ScbzwQlHUcH8ZKQ1pn6U8iU1cP2SAK4OpXFeANs81+5NR2LxHBN3UUNGX7yuAs
         nang==
X-Forwarded-Encrypted: i=1; AJvYcCVpe2sf5baFh1LqOKunwkgtqy+AHE9S5S4mZQTEPrtAkp6Du9rcbPVCdiOH/POOmfIYz3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnwEV/Gtole2cK7BQYcoGEyvyGd6bUvVboIYmuMH5oNNOFJ8U
	4AYJSrcVvwNWJnqKCctSMeKDgf8z8UUAMU5wjl+f7oj1XVbNUKJXqXKCMRQ27Mq9LW8o8y0UmED
	uqMBlAYZdrL1RslEAmAhgxF5XYSJ9poc=
X-Gm-Gg: ASbGncsnaQCP8r+xhxx1L9asmUY6AKQ7LL5Zfp+iPPYZ5cd2euaBrpSqz1dgloGIjIa
	+8X+/ydXTg/LmWp/s0IVts2TcUkc4MXtLnKiwrVz2J0aw7ESZ7PB/UU2RRz7sOWrKBwFT0N5von
	giWMEbfh5rCLYzfZClJmv0Dz9MuOwuPOPX3IgTVXqhQ3VMUEdV7KSCf5xxTPhdoezERSdXMJGw9
	a9/uDj1wKqTbzdyrAH8Sqh9z898lOKG3IP8FRPNYBW5v+AYI9H28EoBrF3ejg==
X-Google-Smtp-Source: AGHT+IHx5P358zmypBv5IYbwpamJ7OUY229Q6XTvNRX4YcNs/sXdUkf7h9uPv3RjRcI+k7g0Mh7PWn21WvikZb4rpVY=
X-Received: by 2002:a17:906:8f8a:b0:b73:1634:6d71 with SMTP id
 a640c23a62f3a-b736780df8cmr250693066b.26.1763116700922; Fri, 14 Nov 2025
 02:38:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114090231.2786984-2-dolinux.peng@gmail.com> <8afe4009725d807dde7ec1d7734005bd9bfe44fcd2ea18178dae9be99b3759ad@mail.kernel.org>
In-Reply-To: <8afe4009725d807dde7ec1d7734005bd9bfe44fcd2ea18178dae9be99b3759ad@mail.kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 14 Nov 2025 18:38:08 +0800
X-Gm-Features: AWmQ_bn5C4dExIAkBiFEuUvwaHm1jhLGdj13snIxhK9u3Bm6TmoeS37Nc4uJ9Oo
Message-ID: <CAErzpmuWAvdbUaVD6-ZnV7aqLpD8yJ+0EVNVzu951VX9bOTb1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] libbpf: Add BTF permutation support for type reordering
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin@xiaomi.com, alan.maguire@oracle.com, song@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 9f141395c..de3aa62fd 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -5829,3 +5829,189 @@ int btf__relocate(struct btf *btf, const struct=
 btf *base_btf)
> >               btf->owns_base =3D false;
> >       return libbpf_err(err);
> >  }
> > +
> > +struct btf_permute {
> > +     struct btf *btf;
> > +     __u32 *id_map;
> > +     __u32 offs;
> > +};
> > +
> > +/* Callback function to remap individual type ID references */
> > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > +{
>
> [ ... ]
>
> > +int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
> > +              const struct btf_permute_opts *opts)
> > +{
> > +     struct btf_permute p;
> > +     struct btf_ext *btf_ext;
> > +     void *next_type, *end_type;
> > +     void *nt, *new_types =3D NULL;
> > +     int err =3D 0, n, i, new_type_len;
> > +     __u32 *order_map =3D NULL;
> > +     __u32 offs, id, new_nr_types =3D 0;
> > +
> > +     if (btf__base_btf(btf)) {
> > +             /*
> > +              * For split BTF, the number of types added on the
> > +              * top of base BTF
> > +              */
> > +             n =3D btf->nr_types;
> > +             offs =3D btf->start_id;
> > +     } else if (id_map[0] !=3D 0) {
> > +             /* id_map[0] must be 0 for base BTF */
> > +             err =3D -EINVAL;
> > +             goto done;
> > +     } else {
> > +             /* include VOID type 0 for base BTF */
> > +             n =3D btf__type_cnt(btf);
> > +             offs =3D 0;
> > +     }
> > +
> > +     if (!OPTS_VALID(opts, btf_permute_opts) || (id_map_cnt !=3D n))
> > +             return libbpf_err(-EINVAL);
> > +
> > +     /* used to record the storage sequence of types */
> > +     order_map =3D calloc(n, sizeof(*id_map));
> > +     if (!order_map) {
> > +             err =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +
> > +     new_types =3D calloc(btf->hdr->type_len, 1);
> > +     if (!new_types) {
> > +             err =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +
> > +     if (btf_ensure_modifiable(btf)) {
> > +             err =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +
> > +     for (i =3D 0; i < id_map_cnt; i++) {
> > +             id =3D id_map[i];
> > +             /*
> > +              * 0: Drop the specified type (exclude base BTF type 0).
> > +              * For base BTF, type 0 is always preserved.
> > +              */
> > +             if (id =3D=3D 0)
> > +                     continue;
> > +             /* Invalid id  */
> > +             if (id < btf->start_id || id >=3D btf__type_cnt(btf)) {
> > +                     err =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +             id -=3D offs;
> > +             /* Multiple types cannot be mapped to the same ID */
> > +             if (order_map[id]) {
> > +                     err =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +             order_map[id] =3D i + offs;
> > +             new_nr_types =3D max(id + 1, new_nr_types);
> > +     }
> > +
> > +     /* Check for missing IDs */
> > +     for (i =3D offs ? 0 : 1; i < new_nr_types; i++) {
> > +             if (order_map[i] =3D=3D 0) {
> > +                     err =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +     }
> > +
> > +     p.btf =3D btf;
> > +     p.id_map =3D id_map;
> > +     p.offs =3D offs;
> > +     nt =3D new_types;
> > +     for (i =3D offs ? 0 : 1; i < new_nr_types; i++) {
> > +             struct btf_field_iter it;
> > +             const struct btf_type *t;
> > +             __u32 *type_id;
> > +             int type_size;
> > +
> > +             id =3D order_map[i];
> > +             /* must be a valid type ID */
> > +             t =3D btf__type_by_id(btf, id);
> > +             if (!t) {
> > +                     err =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +             type_size =3D btf_type_size(t);
> > +             memcpy(nt, t, type_size);
> > +
> > +             /* Fix up referenced IDs for BTF */
> > +             err =3D btf_field_iter_init(&it, nt, BTF_FIELD_ITER_IDS);
> > +             if (err)
> > +                     goto done;
> > +             while ((type_id =3D btf_field_iter_next(&it))) {
> > +                     err =3D btf_permute_remap_type_id(type_id, &p);
> > +                     if (err)
> > +                             goto done;
> > +             }
> > +
> > +             nt +=3D type_size;
> > +     }
> > +
> > +     /* Fix up referenced IDs for btf_ext */
> > +     btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > +     if (btf_ext) {
> > +             err =3D btf_ext_visit_type_ids(btf_ext, btf_permute_remap=
_type_id, &p);
> > +             if (err)
> > +                     goto done;
> > +     }
> > +
> > +     new_type_len =3D nt - new_types;
> > +     next_type =3D new_types;
> > +     end_type =3D next_type + new_type_len;
> > +     i =3D 0;
> > +     while (next_type + sizeof(struct btf_type) <=3D end_type) {
> > +             btf->type_offs[i++] =3D next_type - new_types;
> > +             next_type +=3D btf_type_size(next_type);
> > +     }
> > +
> > +     /* Resize */
> > +     if (new_type_len < btf->hdr->type_len) {
> > +             void *tmp_types;
> > +
> > +             tmp_types =3D realloc(new_types, new_type_len);
> > +             if (new_type_len && !tmp_types) {
> > +                     err =3D -ENOMEM;
> > +                     goto done;
> > +             }
> > +             new_types =3D tmp_types;
> > +             btf->nr_types =3D new_nr_types - (offs ? 0 : 1);
> > +             btf->type_offs_cap =3D btf->nr_types;
> > +             btf->types_data_cap =3D new_type_len;
> > +             btf->hdr->type_len =3D new_type_len;
> > +             btf->hdr->str_off =3D new_type_len;
> > +             btf->raw_size =3D btf->hdr->hdr_len + btf->hdr->type_len =
+ btf->hdr->str_len;
> > +     }
> > +     free(btf->types_data);
> > +     btf->types_data =3D new_types;
> > +     return 0;
>
> Does this leak order_map on the success path? It looks like order_map is
> allocated above and freed only in the error path at the done label, but
> the success path returns here without freeing it.

Thanks, I will fix it.

>
> > +
> > +done:
> > +     free(order_map);
> > +     free(new_types);
> > +     return libbpf_err(err);
> > +}
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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/193599=
45665

