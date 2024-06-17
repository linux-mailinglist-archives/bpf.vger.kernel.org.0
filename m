Return-Path: <bpf+bounces-32349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7890BD11
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 23:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429ED1F22F93
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 21:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1D1991B0;
	Mon, 17 Jun 2024 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5PazUKS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF81922F0
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661065; cv=none; b=JGoSKUGW/g6N1aG3RmdXMty/BBS1ovOkYCj4JCP5Hx2Juyo/telvzoP7zB9fyPkVtf7AkR+Ju5K7jRJzBC2CUkoeJRjf6WHHt+5nWaUPGJ3xY0V5lY4nlv6n99NB5ocHJ5m5YvEwyt7212UNJ67chlHcUCH6QhrtbzQWSQ9XhSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661065; c=relaxed/simple;
	bh=dk2eEl8Ksmqr5eW5cJkMve8ev7ryQd9v+RnWAzR1PRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qc2jw90hQ2BeY/xn7fLWDYGT5mpMJv4X+OjC4f+G7gKqP+A2RlTuWF2TziPEvO/AwUbLTJj6jbDAZdRkHvSJ3a/u6MyMIPnoUSx2HgClpajzzAD/gEcn5AIJQ64lEeVyvPqiuF2e3W/WBrp14JtBJMWTF6xTtv/KK25l6psbYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5PazUKS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c327a0d4c9so4227744a91.1
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661063; x=1719265863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzSwBAgsh0ktQM3g0N1xMNJc+zovx0Yr/3j7RmPqMNM=;
        b=W5PazUKS7lXa0EChnt4XveZBckSdtuD1YqZfjD9c2bPwyTgM3aqbSmnlrekdI0tWzz
         m3g+IheJPNF2zJcGEP4Ixq9KxoX+HeYIJZIu2Rtayly2QItSW9igRCm/1ssFtY3rXIcj
         QDMIOGybb+RX27uJKPhqi5276Tjvd+haiwBvcpanNwCT6yHixpWQ2r4J52zyy3Vk9Kbn
         Zzs1qfuTJn0PgVjlCSTpMoD8RydMrn+y9ab7/3tOVkBeCW+1Ry6lkCazmvfQBfW4BHBY
         IF0u/1ucpDI3y9kkoVgRf6elEi72Y6cFL9A0hbYhQdqalqI0FGAE7YOVIl2gJ3XqqX/Q
         OKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661063; x=1719265863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzSwBAgsh0ktQM3g0N1xMNJc+zovx0Yr/3j7RmPqMNM=;
        b=qye5VCD4hbxK50BsZNaOnnOW8SRQ4dyvyjUr3lXC+BrrlPSZE+XRB+deZCubIZCHQg
         Guyq5mpZI6G5YOr2qQFR8oC/iDI+CK2Hor05Pabaf+ZRqBJDV2yUQ0+4fF3sW2p4oIUS
         MY97RWlnw09HbL8HaVtvID2uxuXcD+icPVv0b9S9wfX4z3Ia/pB3TFRgJMwKRio20lC9
         ijkF5/So4Ph/Y40yfiSglZ1NBVqoTMkN05BdFiaoPmWkUG4E+++oxX2Xk5996XjYnCjx
         MOK8lhi7MDLJ8hmVbOTnOGD+XNZVbOTLLZcT3lqbQR8/DGPFlW8zP5SaAtJFMA6DCghN
         w5jg==
X-Forwarded-Encrypted: i=1; AJvYcCWaggwnvHcYUlSraFG006Uw/UZwtgdVdMyBDj9C4U/rZjOiR3GSKRfjocGBV045q+FLYUq5Mp3FVQIBAo6zgg7LmtzY
X-Gm-Message-State: AOJu0Yzn5UMteZgzqym3/350+bb6bgYQXjHgi5Mo8MQGqxmMh1QYcIWy
	JjDtSOl88+AWV2ndor9VbrZ+c5+Q6/8bwrROtFScWzJ8zCEMfY+vI5orcS0foRnus75RFRVmBwk
	6cSqupUTmU7tT4cP0qEKhv0dNWys=
X-Google-Smtp-Source: AGHT+IFMeiyQlgEWazNxbo4dy5qRaMHMhItP2aMxNVO/llZzBFCX2Zuz7Zb9f3LEFeHBqItgsaAgDlDkzR94ULnM6YQ=
X-Received: by 2002:a17:90a:f18b:b0:2c2:d127:fbf5 with SMTP id
 98e67ed59e1d1-2c6c90174b0mr1224839a91.7.1718661063013; Mon, 17 Jun 2024
 14:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613095014.357981-1-alan.maguire@oracle.com> <20240613095014.357981-4-alan.maguire@oracle.com>
In-Reply-To: <20240613095014.357981-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Jun 2024 14:50:49 -0700
Message-ID: <CAEf4BzakBgJ2FEPP7PBuDeKODd8t6Y0j9LB==W=R7TyK9PXuyg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/9] libbpf: split BTF relocation
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 2:50=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Map distilled base BTF type ids referenced in split BTF and their
> references to the base BTF passed in, and if the mapping succeeds,
> reparent the split BTF to the base BTF.
>
> Relocation is done by first verifying that distilled base BTF
> only consists of named INT, FLOAT, ENUM, FWD, STRUCT and
> UNION kinds; then we sort these to speed lookups.  Once sorted,
> the base BTF is iterated, and for each relevant kind we check
> for an equivalent in distilled base BTF.  When found, the
> mapping from distilled -> base BTF id and string offset is recorded.
> In establishing mappings, we need to ensure we check STRUCT/UNION
> size when the STRUCT/UNION is embedded in a split BTF STRUCT/UNION,
> and when duplicate names exist for the same STRUCT/UNION.  Otherwise
> size is ignored in matching STRUCT/UNIONs.
>
> Once all mappings are established, we can update type ids
> and string offsets in split BTF and reparent it to the new base.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/Build             |   2 +-
>  tools/lib/bpf/btf.c             |  17 ++
>  tools/lib/bpf/btf.h             |  14 +
>  tools/lib/bpf/btf_relocate.c    | 506 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |   3 +
>  6 files changed, 542 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/btf_relocate.c
>

[...]

> +/* Build a map from distilled base BTF ids to base BTF ids. To do so, it=
erate
> + * through base BTF looking up distilled type (using binary search) equi=
valents.
> + */
> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
> +{
> +       struct btf_name_info *dist_base_info_sorted, *dist_base_info_sort=
ed_end;
> +       struct btf_type *base_t, *dist_t;
> +       __u8 *base_name_cnt =3D NULL;
> +       int err =3D 0;
> +       __u32 id;
> +
> +       /* generate a sort index array of name/type ids sorted by name fo=
r
> +        * distilled base BTF to speed name-based lookups.
> +        */
> +       dist_base_info_sorted =3D calloc(r->nr_dist_base_types, sizeof(*d=
ist_base_info_sorted));

s/dist_base_info_sorted/infos/. Do we have any other info here? Not
distilled base one? Not sorted? What's the point of these long verbose
variable names besides making the rest of the code longer and more
distracting?

> +       if (!dist_base_info_sorted) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +       dist_base_info_sorted_end =3D dist_base_info_sorted + r->nr_dist_=
base_types;
> +       for (id =3D 0; id < r->nr_dist_base_types; id++) {
> +               dist_t =3D btf_type_by_id(r->dist_base_btf, id);
> +               dist_base_info_sorted[id].name =3D btf__name_by_offset(r-=
>dist_base_btf,
> +                                                                    dist=
_t->name_off);
> +               dist_base_info_sorted[id].id =3D id;
> +               dist_base_info_sorted[id].size =3D dist_t->size;
> +               dist_base_info_sorted[id].needs_size =3D true;
> +       }
> +       qsort(dist_base_info_sorted, r->nr_dist_base_types, sizeof(*dist_=
base_info_sorted),
> +             cmp_btf_name_size);
> +
> +       /* Mark distilled base struct/union members of split BTF structs/=
unions
> +        * in id_map with BTF_IS_EMBEDDED; this signals that these types
> +        * need to match both name and size, otherwise embeddding the bas=
e

typo: embedding

> +        * struct/union in the split type is invalid.
> +        */
> +       for (id =3D r->nr_dist_base_types; id < r->nr_split_types; id++) =
{
> +               err =3D btf_mark_embedded_composite_type_ids(r, id);
> +               if (err)
> +                       goto done;
> +       }
> +

[...]

> +               /* iterate over all matching distilled base types */
> +               for (dist_name_info =3D search_btf_name_size(&base_name_i=
nfo, dist_base_info_sorted,
> +                                                          r->nr_dist_bas=
e_types);
> +                    dist_name_info !=3D NULL; dist_name_info =3D dist_na=
me_info_next) {
> +                       /* Are there more distilled matches to process af=
ter
> +                        * this one?
> +                        */
> +                       dist_name_info_next =3D dist_name_info + 1;
> +                       if (dist_name_info_next >=3D dist_base_info_sorte=
d_end ||
> +                           cmp_btf_name_size(&base_name_info, dist_name_=
info_next))
> +                               dist_name_info_next =3D NULL;

Goodness, does this have to be so verbose and ugly?...

First, does "dist_name_info" give us much more information than just
"info" or something like this?

Second,

for (info =3D search_btf_name_size(&.....);
     info && cmp_btf_name_size(...) =3D=3D 0;
     info++) {
   ...
}

And there is no need for dist_name_info_next and this extra if with
NULL-ing anything out.

Please send a follow up with the clean up, this loop's conditions are
hard to follow (I had to double check that we don't use
dist_name_info_next for any decision making; but I shouldn't even
care, it should be obvious if written as above)

> +
> +                       if (!dist_name_info->id || dist_name_info->id > r=
->nr_dist_base_types) {

another off by one? Valid ID is always < number of types, and so `id
>=3D nr_types` is the condition for invalid ID. Please fix in a follow
up as well.

> +                               pr_warn("base BTF id [%d] maps to invalid=
 distilled base BTF id [%d]\n",
> +                                       id, dist_name_info->id);
> +                               err =3D -EINVAL;
> +                               goto done;
> +                       }
> +                       dist_t =3D btf_type_by_id(r->dist_base_btf, dist_=
name_info->id);
> +                       dist_kind =3D btf_kind(dist_t);
> +
> +                       /* Validate that the found distilled type is comp=
atible.
> +                        * Do not error out on mismatch as another match =
may
> +                        * occur for an identically-named type.
> +                        */
> +                       switch (dist_kind) {
> +                       case BTF_KIND_FWD:
> +                               switch (base_kind) {
> +                               case BTF_KIND_FWD:
> +                                       if (btf_kflag(dist_t) !=3D btf_kf=
lag(base_t))
> +                                               continue;
> +                                       break;
> +                               case BTF_KIND_STRUCT:
> +                                       if (btf_kflag(base_t))
> +                                               continue;
> +                                       break;
> +                               case BTF_KIND_UNION:
> +                                       if (!btf_kflag(base_t))
> +                                               continue;
> +                                       break;
> +                               default:
> +                                       continue;
> +                               }
> +                               break;

I gotta say it's amazing that C allows this intermixing of breaks and
continues to work at completely different "scopes" (switch vs for).
Wonderful language :)


> +                       case BTF_KIND_INT:
> +                               if (dist_kind !=3D base_kind ||
> +                                   btf_int_encoding(base_t) !=3D btf_int=
_encoding(dist_t))
> +                                       continue;
> +                               break;

[...]

