Return-Path: <bpf+bounces-76810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F102DCC5E89
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 04:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0A8E301FA76
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975A52D0620;
	Wed, 17 Dec 2025 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoq5yFP7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4700231A21
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765942260; cv=none; b=DBvRZZikl/UaOicjlmgTjUI0+CrE0nfQRwa0B4G7n3PuksdhfO+bJFC37uhshZRa6aBBm4/xpiO+cSDwrgV367+kiG/bsKrv2EQ/pkAygFmSVXAakgEBdydZiL+owUCfevtyTm5hlfzsnw+Uwz9fixPQiI2ZRYBIS2puoRf4Heg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765942260; c=relaxed/simple;
	bh=/zIZDCTsaf3NELZq4oO/Xu0ruJl12ikZDAALalrWin0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/CoIBs3hhLSbaiaV4whm30tqivhVh4KzA5TPzXGF+U00EuewJ8bucF1puVcg+kaEQfz2/OQXRDEQrkEHeDhEca/UPbljjHI/W/zwIlriTCMUSUf1afgKQGKoB+aWhBKsXsu8Fa8YWkBLM/sJ3W0tewXNEQBUcj+jboSdkNUoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoq5yFP7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7cee045187so30978566b.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765942257; x=1766547057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL+XOEEBLe16bMBspJIoo4oaB6QULs7AUTzRRUXe2gc=;
        b=aoq5yFP7jT/LQgVb2Wuqwc+EY+hyqU6clvGJVTzW5fBHGGO9WO3qNv+wCeXVzT51yw
         vnhwgqgmbhbrds6TYhZkEdsKpzyZjl0ku3CNKq5364jWrSz0q2QJR3njxHJRvpvapdyz
         8GmHvbmWvprIB0TU7IA/re1y4RqhkQmO4/wFqx0qC7FRKvntfF+1YHQvvoM4waKQnpPp
         eKWyFynj4hf75t8/3GwAfaVr+tYsUfXLb5nrKhnV0L9EMlT7pPLJdQo/VIYpn5WpRz+T
         2BvJ36sZJsIjJhOs0sGj24klx5mu6dR1VC2zCe+dro5JcWzkfSR50ay2wQeH65Y695cA
         hXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765942257; x=1766547057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DL+XOEEBLe16bMBspJIoo4oaB6QULs7AUTzRRUXe2gc=;
        b=MXqrgfk4xHS2cLU3+YF+jT7YcJM+CSoJDDcVc4PNXnm0dFyxwOgzjMMKUoRGe24Hdf
         jAQ3wDUEuw/G1wF0c/tRPSVALSgoTbupUSOuHap5MtHUammi5wHdM56qmkM5VhAExLmQ
         cUbl/uQ0yWKp7dNzg9qa2NMKe7Os0Zd221MabiLanPhcmnBtWqz6XDvFWdw4osX9WO3Y
         ys4d2J/6RbUihRFVOj3vymJFtJwGdyMeQ4qpbXzfBgrgv944piYFj8Njclg18IZslqD5
         KsmG6h4+SMtnIJZfFAP+1t+FpWWjIQcXU5/Zr0N+Xop+tDwd80K/aoYwOirHXv1i4uUt
         oEDg==
X-Forwarded-Encrypted: i=1; AJvYcCXiD0MopKyWy9OmWApe6reiZ0kYPsYu7XJWjR7cOQyC71dmFA91ZMxUQEmTnNpeoys9E9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTlXsq+z88nJBGJKsPfRuC/MMmFybm9VdqThaAqEZMaM1Jibta
	B9BUrFU5cVgDlBlFYW2POqle5FrQ4+Fyght7st+rQrFbxQSUzyVq8WlfBuH0OnPrI2Vn/T5q9u8
	j2NywF+elepUtvbenAdP14g7Ecb352W0=
X-Gm-Gg: AY/fxX5ayckk7q0kLFhP59BAZn2nNu/8CKU9S0y4V/jV90Amaq9Cwyd3oSHWs1XWv5M
	NUxVTRbIelReGyH5UxDvmXUAG4J9vYh5bArftLYOqQ+ANQgWjNSGBGps6Y4UkVZ6Zryq55eXqw1
	FChyzqGmeqEqOpd4YsToOE5dEfUz3KZm6jKun+rw/7fIugmg48A2Kgitu7G+JUhiLjyhJHJm6bh
	D8FqEpQhlhFnJ5kxUjtkQxYf6BDSLtirX7JIdp3ts32JmTLQfL3d65Bz4615zssvU+YPd5deRtX
	DxgfDDs=
X-Google-Smtp-Source: AGHT+IEJoY197QRIsI3XygJTZ+rdeXHCjsl0TSQ7nASlTBEcyu0X6ql6Nib1J5amhBmK1a4Z0PGtAG9FVBIDs4cbfEg=
X-Received: by 2002:a17:907:2d28:b0:b72:84bd:88f3 with SMTP id
 a640c23a62f3a-b7d216b7556mr1850423266b.11.1765942256903; Tue, 16 Dec 2025
 19:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-2-dolinux.peng@gmail.com> <3777b2f096877a9965a0fa6905fbabb06826d13f.camel@gmail.com>
In-Reply-To: <3777b2f096877a9965a0fa6905fbabb06826d13f.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 17 Dec 2025 11:30:45 +0800
X-Gm-Features: AQt7F2oB-qgvz9QGiOFD_aRqoGf_rJaTpsqzxWWBCri0X099owaKC9cnEeiSD1E
Message-ID: <CAErzpmsdkJ+GdA=GRFwQJ=U0akBZQyyEXa3+k6ZnmtNLoYxM5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 01/10] libbpf: Add BTF permutation support for
 type reordering
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 6:00=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
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
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index cc01494d6210..ba67e5457e3a 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -281,6 +281,42 @@ LIBBPF_API int btf__dedup(struct btf *btf, const s=
truct btf_dedup_opts *opts);
> >   */
> >  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_b=
tf);
> >
> > +struct btf_permute_opts {
> > +     size_t sz;
> > +     /* optional .BTF.ext info along the main BTF info */
> > +     struct btf_ext *btf_ext;
> > +     size_t :0;
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
>
> Nit: internally the rule does not have special cases:
>
>        id_map[original_id - start_id] =3D new_id
>
>      So, maybe there is no need split these cases in the docstring?
>      Otherwise it is not immediately clear that both cases are handled
>      uniformly.

Thanks, I agree and will refine the docstring.

>
> > + *
> > + * On error, returns negative error code and sets errno:
> > + *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, out-of=
-range)
> > + *   - `-ENOMEM`: Memory allocation failure
> > + */
> > +LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_m=
ap_cnt,
> > +                         const struct btf_permute_opts *opts);
> > +
> >  struct btf_dump;
> >
> >  struct btf_dump_opts {
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 8ed8749907d4..b778e5a5d0a8 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
> >       global:
> >               bpf_map__set_exclusive_program;
> >               bpf_map__exclusive_program;
> > +             btf__permute;
> >  } LIBBPF_1.6.0;

