Return-Path: <bpf+bounces-75102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6520EC709FC
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 19:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2005429239
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D463148C9;
	Wed, 19 Nov 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPKyLB9+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A836E54C
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576533; cv=none; b=VT+VAXBK0IXUDQNjeEaBcHV41v4UaN43NYexXL9CSwSquBoZsrfn7buixwDiZUE3eV56vE1p51GvO4d9i4i2RCq41Rbp2WeQ4Ux+dpbT4cKAk9MtaBpl9ZCS4JmyThp0CRa2cksw7/8aeM+MpXWnTuaWpFV06BE1cvoZi7yNR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576533; c=relaxed/simple;
	bh=sBI8JocT/i2WV7Ui0E2C52lirqJT0ntir6ykeEWGk7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0SZklwyIV0XQMNd0O76AQEItWLW4pS7LNARkcZgWf8wPFI33TkFov0eWZ2C2ITjwBTgdEN9XxeRnHdf6LZH4vh8xP7dA3m8PbzhxKuJDa3gQvzyf3ebW5matqhzPDsFEcLiO/d07RdNH0p3hC86MScB7hwO9fjBUOnYcIJc6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPKyLB9+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298144fb9bcso559215ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 10:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763576525; x=1764181325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lDHlhdpQhiIwAGWSFrEd7dKFlBvPPkrLRcdPHfgaK4=;
        b=HPKyLB9+/I9hWNXHa6sytquycXcNf3CiUq/LVY/0sOcLkUvymkybCaIBm52AqybQlT
         09I9NXLcktH0AZ/JnkaPIKK0A4dfERh7Kjrs3QN6pLQhGI0oDyjPFqR3J/yYSQqr1S47
         37S+pq4BVk+XidhtnfXNv1VDxj4sAUw1lnY725oUvIIUYWmEjSN3OU/gOUXEJgop7mRB
         9rCwCo2EutoUv+1Er118u7Xrhw6239qKPd03KDxWhoCnb/ytz5cF6lh/fWMYypKam6J2
         nhrkbotGPZkcC1FNuxqGKBblVPLkXnf0f4zZI1JzULmYZQqh9FunqHkOtJHyqZHtztLC
         88ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763576525; x=1764181325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lDHlhdpQhiIwAGWSFrEd7dKFlBvPPkrLRcdPHfgaK4=;
        b=gedgxviB9P289NmejKUj9N5gPyn9nV5n8oAKMYfk99mfLV1yR6EaD7yK/Eo24wHeer
         14bmhqIgE9PZBuddP6YVE6vmBjSCCig+nRC5/4MXOUul2gX5d8OnZ856XvaPlljltojY
         8S7LK3JqOhd0CEhEG11Fv1ORlvX/SUvqm8wmuh0rzul9p1cc559/6xQjHf60qjPgdamE
         p+G7xu6CA1KDNkXCRkB/AYo4OToAC3kR2olX1kKZmqCASx6y8vrkt20pxzX2SBktz4hw
         sphfOdNRHH5ZyJOBxH/NiwkL4aFNRGPc6CW60+k0ORGF6qMFBB71ztWUdDgRu3fbAvOa
         Dcdw==
X-Forwarded-Encrypted: i=1; AJvYcCV28xLdAQVX4uPSJXvPizZADrwCc3kFgRELii2iiTuqPNCJL+Q7WFeK0IILhYYMFDch15k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvWWX2GvnIZwVKEG2e5EO4ZszehHXSbCnCD49ZvNXRxYxdddZ
	QRb4xicF5hfdx8Nwu2ESJHKpe9d7fun302VS2PyKgskaaTIdav+uTklXm87fksVrUKynzopAoHy
	/ktCAiTwBHidCpDNOTYasu49R5pdSZDpuX9aZC14=
X-Gm-Gg: ASbGncvadkI4B/giYTtGj7Vytd1eTzqbpkS3szuF3qPUeUhHfeYxq8tBBMOLskx7STR
	3fUjXW5Vxq1pvFCt4bRCJjbzLzOqUtELNYKFuWs2xi0Atm2yn5bQxm16VgZmHwJ1Sc3SDOjueZi
	srwte2R1L+QreL6FGn0aOYDDK+NJfpqItxCCSMFdBxWaRgLkgKkw848+mLx1kAFWoWQG1JV0kzd
	sXwq8pxJA4Iyvrtz/jX5i/oRUfRGl/VfW8kaeuutODDqJ1bNodXdBYc/L6eRnrAYAfj+kNn68vh
	sDEn79jjI54=
X-Google-Smtp-Source: AGHT+IFBHdUMPkrgvLcK54E3ETeMG2mor0sNi/h3IPdvoEmgUpK91UGrLsWQkw+qfXXSfS4yBAX57M+wEUOF+MwSfAY=
X-Received: by 2002:a17:902:e785:b0:295:5d0b:e119 with SMTP id
 d9443c01a7336-29b5b07dddbmr3824315ad.26.1763576524568; Wed, 19 Nov 2025
 10:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com> <20251119031531.1817099-2-dolinux.peng@gmail.com>
In-Reply-To: <20251119031531.1817099-2-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Nov 2025 10:21:50 -0800
X-Gm-Features: AWmQ_bnxQf8Tsmh3Cs2kFZiU9pPSCiIF9wU9L6AMBdtruwnVbZQ0QTAIQNnbC4U
Message-ID: <CAEf4Bzb76SfWfNtxP2WVJ44hsVU-GrePmeKKxH25Q8KOn_Mkfw@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/7] libbpf: Add BTF permutation support for type reordering
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
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
> Cc: Song Liu <song@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c      | 166 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h      |  43 ++++++++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 210 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fcf9f..ab95ff19fde3 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5829,3 +5829,169 @@ int btf__relocate(struct btf *btf, const struct b=
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
> +       /* skip references that point into the base BTF or VOID */
> +       if (new_type_id < p->btf->start_id)
> +               return 0;
> +
> +       /* invalid reference id */
> +       if (new_type_id >=3D btf__type_cnt(p->btf))
> +               return -EINVAL;
> +
> +       new_type_id =3D p->id_map[new_type_id - p->btf->start_id];
> +       /* reference a dropped type is not allowed */
> +       if (new_type_id =3D=3D 0)
> +               return -EINVAL;

see below, this shouldn't happen, let's drop redundant check

> +
> +       *type_id =3D new_type_id;
> +       return 0;
> +}
> +
> +int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
> +                const struct btf_permute_opts *opts)
> +{
> +       struct btf_permute p;
> +       struct btf_ext *btf_ext;
> +       void *next_type, *end_type;
> +       void *nt, *new_types =3D NULL;
> +       int err =3D 0, i, new_type_len;
> +       __u32 *order_map =3D NULL;
> +       __u32 id, new_nr_types =3D 0;
> +
> +       if (!OPTS_VALID(opts, btf_permute_opts) || id_map_cnt !=3D btf->n=
r_types)
> +               return libbpf_err(-EINVAL);
> +
> +       /* used to record the storage sequence of types */
> +       order_map =3D calloc(btf->nr_types, sizeof(*id_map));
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
> +               /* Drop the specified type */
> +               if (id =3D=3D 0)
> +                       continue;

if we don't allow this (no support for deletion, I wouldn't rush to
add that right now)...

pw-bot: cr


> +               /* Invalid id  */

obvious statement, IMO, please drop the comment

> +               if (id < btf->start_id || id >=3D btf__type_cnt(btf)) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +               id -=3D btf->start_id;
> +               /* Multiple types cannot be mapped to the same ID */
> +               if (order_map[id]) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +               order_map[id] =3D i + btf->start_id;
> +               new_nr_types =3D max(id + 1, new_nr_types);
> +       }
> +
> +       /* Check for missing IDs */
> +       for (i =3D 0; i < new_nr_types; i++) {
> +               if (order_map[i] =3D=3D 0) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +       }

... then you won't need this check at all, because we enforced that
each remapped ID is different and we have exactly nr_types of them.
Same for new_nr_types calculation above, seems redundant

> +
> +       p.btf =3D btf;
> +       p.id_map =3D id_map;
> +       nt =3D new_types;
> +       for (i =3D 0; i < new_nr_types; i++) {
> +               struct btf_field_iter it;
> +               const struct btf_type *t;
> +               __u32 *type_id;
> +               int type_size;
> +
> +               id =3D order_map[i];
> +               /* must be a valid type ID */

redundant comment, please drop

> +               t =3D btf__type_by_id(btf, id);
> +               if (!t) {

no need to check this, we already validated that all types are valid earlie=
r

> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +               type_size =3D btf_type_size(t);
> +               memcpy(nt, t, type_size);
> +
> +               /* Fix up referenced IDs for BTF */
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
> +       /* Fix up referenced IDs for btf_ext */
> +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> +       if (btf_ext) {
> +               err =3D btf_ext_visit_type_ids(btf_ext, btf_permute_remap=
_type_id, &p);
> +               if (err)
> +                       goto done;
> +       }
> +
> +       new_type_len =3D nt - new_types;


new_type_len has to be exactly the same as the old size, this is redundant

> +       next_type =3D new_types;
> +       end_type =3D next_type + new_type_len;
> +       i =3D 0;
> +       while (next_type + sizeof(struct btf_type) <=3D end_type) {

while (next_type < end_type)?

Reference to struct btf_type is confusing, as generally type is bigger
than just sizeof(struct btf_type). But there is no need for this, with
correct code next_type < end_type is sufficient check

But really, this can also be written cleanly as a simple for loop

for (i =3D 0; i < nr_types; i++) {
    btf->type_offs[i] =3D next_type - new_types;
    next_type +=3D btf_type_size(next_type);
}

> +               btf->type_offs[i++] =3D next_type - new_types;
> +               next_type +=3D btf_type_size(next_type);
> +       }
> +
> +       /* Resize */

there cannot be any resizing, drop this, you only need to reassign
btf->types_data, that's all

> +       if (new_type_len < btf->hdr->type_len) {
> +               void *tmp_types;
> +
> +               tmp_types =3D realloc(new_types, new_type_len);
> +               if (new_type_len && !tmp_types) {
> +                       err =3D -ENOMEM;
> +                       goto done;
> +               }
> +               new_types =3D tmp_types;
> +               btf->nr_types =3D new_nr_types;
> +               btf->type_offs_cap =3D btf->nr_types;
> +               btf->types_data_cap =3D new_type_len;
> +               btf->hdr->type_len =3D new_type_len;
> +               btf->hdr->str_off =3D new_type_len;
> +               btf->raw_size =3D btf->hdr->hdr_len + btf->hdr->type_len =
+ btf->hdr->str_len;
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
> index ccfd905f03df..e63dcce531b3 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -273,6 +273,49 @@ LIBBPF_API int btf__dedup(struct btf *btf, const str=
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
> + * For **base BTF**:
> + * - @id_map must include all types from ID 1 to `btf__type_cnt(btf)-1`
> + * - @id_map_cnt should be `btf__type_cnt(btf) - 1`
> + * - Mapping uses `id_map[original_id - 1] =3D new_id`
> + *
> + * For **split BTF**:
> + * - @id_map should cover only split types
> + * - @id_map_cnt should be `btf__type_cnt(btf) - btf__type_cnt(btf__base=
_btf(btf))`
> + * - Mapping uses `id_map[original_id - btf__type_cnt(btf__base_btf(btf)=
)] =3D new_id`
> + *
> + * Setting @id_map element to 0 drops the corresponding type. Dropped ty=
pes must not
> + * be referenced by any retained types. After permutation, type referenc=
es in BTF
> + * data and optional extension are updated automatically.

let's not add deletion support just yet

> + *
> + * Note: Dropping types may orphan some strings, requiring subsequent **=
btf__dedup()**
> + * to clean up unreferenced strings.

one more reason to not add deletion just yet. It's good to have an API
that can express this, but we don't have to support deletion just yet.

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
> index 8ed8749907d4..b778e5a5d0a8 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
>         global:
>                 bpf_map__set_exclusive_program;
>                 bpf_map__exclusive_program;
> +               btf__permute;
>  } LIBBPF_1.6.0;
> --
> 2.34.1
>

