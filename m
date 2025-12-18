Return-Path: <bpf+bounces-77058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A8CCDE57
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73DBE302E7DD
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062F2BD022;
	Thu, 18 Dec 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN2NDpu7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689DF155CB3
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766098964; cv=none; b=I233mg7JpkfV4wpox+zJXxnf+UoXK5UFIn5qvz3erNB79xVjLsQPrljhSrTzdfvhPEzxKkuoGizX54P4wOpfzWMj1jh2sTPQ/2Vjj047d0aDSCCkJCNechecXe2/eXDzlFDUXTuwQ74z1cj4mx19m7LDdiJHs8DkqgExibY37nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766098964; c=relaxed/simple;
	bh=golrgwC894bDUpEOnzVILcWqgZtIjjOnqsfYV4miW6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saugd0bvmMUvbmqoQoI4tv4Kk4b+qF3Fd/5fyAib4+aRfmhSzJj18eAURZFC1T5C2FviBNyE7iVGymsME1qTzFeLuX/5mR8OoMB4SaHvoIwjl2WZc20kUSiOnVTrGHepDGFR5zuM1EOhsVd1ki3D0VYIj+T06hXvYgumuyuAHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN2NDpu7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1212535b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 15:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766098962; x=1766703762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuFIl+Krj0icN4Ltpgq4z2geUho1YZykaCMeuhGGAEU=;
        b=SN2NDpu7bu3MgPQjUgDx1p2vZVmviZZgBK7djCR33lMdGLlKYgci3aodmLxC+xUg0l
         atglRv35bo1vubYxOdO1TNmdp8WMKHSFPfmFkVrZrct4oeISB6Jg7kUmRhWgDvXonUP+
         2jpQ9C5qb9+Tq596i2kvNd27RwzSQNLgAfJV+PTCxy96j7NtX1/SPP/O60T/02RElTbu
         STHfznWP0wq/Bz8qoJAziVNvyCkzK0ukz+tb84ygBNr1BGbFiW/W/vGULhu1OYCqnKUU
         hXdg4dBYzmKBmrrl6PemVREpqYnyepiI4LBdF7rbvETmCleIzj5Aqyubzz/g2/omIbhG
         LUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766098962; x=1766703762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuFIl+Krj0icN4Ltpgq4z2geUho1YZykaCMeuhGGAEU=;
        b=sGSxsLu2T1m+KlkaoXvH52J2z/rJmv+TJV0IahQcN9u8ObC85hBSbuoIU5WVUAkFTR
         9unlkc7k94iQX+GgnaurNu2Rp81tIJBFOqmQJuPjpzHTzJJyjj373BRUaLK0EnchycGy
         z/rYok9pSQxrdXn0Y+MtbuXtivluageVhkWvjGN4aQsBqxcfUe40aW0qaba/hy8ERHPj
         IVdRasxmjCvxw1Hh1Cp/OPMfdsjJW3RqmriFU09gyTKUsNJYUNZH25hu+TlkUkVPtdua
         QZESUlupjEVRTn5qQtluBXRll+yo1laEE4HmUdG0yBZsVhvQgEvbAym0+yHcHpbfsYEy
         YP2w==
X-Forwarded-Encrypted: i=1; AJvYcCXNh5OccTEd0IkJFIgNdWo0ASnXikL4aPiytzBi1apM22F067CDi1maxlLd7yof9pl3h1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0Bo5w6yO5ySX8H4fYoQPygac2p6bXXy1hgHQiLXsq9uRJ6ht
	aVNp+la3GHojQl45yUpPhP+v/d+eKZvP1UXWYyhgIv7KEuktFkuYSRwo79cPaDxjvzWwxiqa+0l
	Jmd/USO4lsOCNOeu+ASXf2Koy/5jnGQrPIXr0
X-Gm-Gg: AY/fxX7N/tsXOif8RGO91HcqoKMnTeLy+lm+1hQlAq3CD1hjcBUx9lSpiJ8cmbnJcnT
	zbdGnWqYMKk8gAHaGB3Rj5/hrh+K52Zto/N+hi9uM4+zjfNiUjnR4A6hvNvopncBwN9CchzDp/F
	tNZURLwPPqYeD1NmXXu7G/PwxPxPdNZoGxD0t8ivSFgEUl8fNCKkOy7BI48rMDqK4WkOPEo86d0
	WdLimETTb9bmOe/8UhFLKOWjs+f9BSxp6nbY0cz1Sj3GLfWkseiGX48Dk1IlTIwggcAzHtXp57u
	6uR32cxIyes=
X-Google-Smtp-Source: AGHT+IF5BqdtT0aqC6CHYpHv3iKtRcvoWhextWf5LJGp03KRgBGqvQkU7UOkfqvrKi71giMhVUCA2Q/xwLgTd6srse8=
X-Received: by 2002:a05:6a20:244f:b0:36a:d3c9:efa5 with SMTP id
 adf61e73a8af0-376aa2f47demr931104637.52.1766098961547; Thu, 18 Dec 2025
 15:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-2-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-2-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 15:02:29 -0800
X-Gm-Features: AQt7F2pmAL5PmsD6eW2HWmbPprGlolgPpSc2nQJDVgC8agSd_uA6CzpOVGtov-U
Message-ID: <CAEf4BzYJpw+yEv=g9P1z0NS8Qw8PdFf7039MT0PSv30DwkjBzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 01/13] libbpf: Add BTF permutation support
 for type reordering
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Introduce btf__permute() API to allow in-place rearrangement of BTF types=
.
> This function reorganizes BTF type order according to a provided array of
> type IDs, updating all type references to maintain consistency.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf.c      | 119 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h      |  36 ++++++++++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 156 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b136572e889a..ab204ca403dc 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5887,3 +5887,122 @@ int btf__relocate(struct btf *btf, const struct b=
tf *base_btf)
>                 btf->owns_base =3D false;
>         return libbpf_err(err);
>  }
> +
> +struct btf_permute {
> +       struct btf *btf;
> +       __u32 *id_map;
> +};
> +
> +/* Callback function to remap individual type ID references */
> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> +{
> +       struct btf_permute *p =3D ctx;
> +       __u32 new_type_id =3D *type_id;
> +
> +       /* refer to the base BTF or VOID type */
> +       if (new_type_id < p->btf->start_id)
> +               return 0;
> +
> +       if (new_type_id >=3D btf__type_cnt(p->btf))
> +               return -EINVAL;
> +
> +       *type_id =3D p->id_map[new_type_id - p->btf->start_id];
> +       return 0;
> +}
> +
> +int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
> +                const struct btf_permute_opts *opts)
> +{
> +       struct btf_permute p;
> +       struct btf_ext *btf_ext;
> +       void *nt, *new_types =3D NULL;
> +       __u32 *order_map =3D NULL;
> +       int err =3D 0, i;
> +       __u32 id;
> +
> +       if (!OPTS_VALID(opts, btf_permute_opts) || id_map_cnt !=3D btf->n=
r_types)
> +               return libbpf_err(-EINVAL);
> +
> +       /* record the sequence of types */
> +       order_map =3D calloc(id_map_cnt, sizeof(*id_map));
> +       if (!order_map) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +
> +       new_types =3D calloc(btf->hdr->type_len, 1);
> +       if (!new_types) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +
> +       if (btf_ensure_modifiable(btf)) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +
> +       for (i =3D 0; i < id_map_cnt; i++) {
> +               id =3D id_map[i];
> +               if (id < btf->start_id || id >=3D btf__type_cnt(btf)) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +               id -=3D btf->start_id;
> +               /* cannot be mapped to the same ID */
> +               if (order_map[id]) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +               order_map[id] =3D i + btf->start_id;
> +       }
> +
> +       p.btf =3D btf;
> +       p.id_map =3D id_map;
> +       nt =3D new_types;
> +       for (i =3D 0; i < id_map_cnt; i++) {
> +               struct btf_field_iter it;
> +               const struct btf_type *t;
> +               __u32 *type_id;
> +               int type_size;
> +
> +               id =3D order_map[i];
> +               t =3D btf__type_by_id(btf, id);
> +               type_size =3D btf_type_size(t);
> +               memcpy(nt, t, type_size);
> +
> +               /* fix up referenced IDs for BTF */
> +               err =3D btf_field_iter_init(&it, nt, BTF_FIELD_ITER_IDS);
> +               if (err)
> +                       goto done;
> +               while ((type_id =3D btf_field_iter_next(&it))) {
> +                       err =3D btf_permute_remap_type_id(type_id, &p);
> +                       if (err)
> +                               goto done;
> +               }
> +
> +               nt +=3D type_size;
> +       }
> +
> +       /* fix up referenced IDs for btf_ext */
> +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> +       if (btf_ext) {
> +               err =3D btf_ext_visit_type_ids(btf_ext, btf_permute_remap=
_type_id, &p);
> +               if (err)
> +                       goto done;
> +       }
> +
> +       for (nt =3D new_types, i =3D 0; i < id_map_cnt; i++) {
> +               btf->type_offs[i] =3D nt - new_types;
> +               nt +=3D btf_type_size(nt);
> +       }
> +
> +       free(order_map);
> +       free(btf->types_data);
> +       btf->types_data =3D new_types;
> +       return 0;
> +
> +done:
> +       free(order_map);
> +       free(new_types);
> +       return libbpf_err(err);
> +}
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index cc01494d6210..5d560571b1b5 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -281,6 +281,42 @@ LIBBPF_API int btf__dedup(struct btf *btf, const str=
uct btf_dedup_opts *opts);
>   */
>  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf=
);
>
> +struct btf_permute_opts {
> +       size_t sz;
> +       /* optional .BTF.ext info along the main BTF info */
> +       struct btf_ext *btf_ext;
> +       size_t :0;
> +};
> +#define btf_permute_opts__last_field btf_ext
> +
> +/**
> + * @brief **btf__permute()** performs in-place BTF type rearrangement
> + * @param btf BTF object to permute
> + * @param id_map Array mapping original type IDs to new IDs
> + * @param id_map_cnt Number of elements in @id_map
> + * @param opts Optional parameters for BTF extension updates
> + * @return 0 on success, negative error code on failure
> + *
> + * **btf__permute()** rearranges BTF types according to the specified ID=
 mapping.
> + * The @id_map array defines the new type ID for each original type ID.
> + *
> + * @id_map must include all types from ID `start_id` to `btf__type_cnt(b=
tf) - 1`.
> + * @id_map_cnt should be `btf__type_cnt(btf) - start_id`
> + * The mapping is defined as: `id_map[original_id - start_id] =3D new_id=
`

Would you mind paying attention to the feedback I left in [0]? Thank you.

The contract should be id_map[original_id] =3D new_id for base BTF and
id_map[original_id - btf__type_cnt(base_btf)] =3D new_id for split BTF.
Special BTF type #0 (VOID) is considered to be part of base BTF,
having id_map[0] =3D 0 is easy to check and enforce. And then it leaves
us with a simple and logical rule for id_map. For split BTF we make
necessary type ID shifts to avoid tons of wasted memory. But for base
BTF there is no need to shift anything. So mapping the original type
#X to #Y is id_map[X] =3D Y. Literally, "map X to Y", as simple as that.

  [0] https://lore.kernel.org/bpf/CAEf4BzY_k721TBfRSUeq5mB-7fgJhVKCeXVKO-W2=
EjQ0aS9AgA@mail.gmail.com/

> + *
> + * For base BTF, its `start_id` is fixed to 1, i.e. the VOID type can
> + * not be redefined or remapped and its ID is fixed to 0.
> + *
> + * For split BTF, its `start_id` can be retrieved by calling
> + * `btf__type_cnt(btf__base_btf(btf))`.
> + *
> + * On error, returns negative error code and sets errno:
> + *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, out-of-r=
ange)
> + *   - `-ENOMEM`: Memory allocation failure
> + */
> +LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map=
_cnt,
> +                           const struct btf_permute_opts *opts);
> +
>  struct btf_dump;
>
>  struct btf_dump_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 84fb90a016c9..d18fbcea7578 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -453,4 +453,5 @@ LIBBPF_1.7.0 {
>                 bpf_map__exclusive_program;
>                 bpf_prog_assoc_struct_ops;
>                 bpf_program__assoc_struct_ops;
> +               btf__permute;
>  } LIBBPF_1.6.0;
> --
> 2.34.1
>

