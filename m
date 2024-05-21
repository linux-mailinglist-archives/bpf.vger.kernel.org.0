Return-Path: <bpf+bounces-30169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38178CB605
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76A41C21A84
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA24149C7B;
	Tue, 21 May 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8dea5a2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B12AE6C
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330893; cv=none; b=XERcAGxxXwPn3QhN9nobo6cF/mXH0opxKeBQnY8gOaYtISbya+Brm2yVoD4iNwy2gg4RsqViaUHcSnRyK7hYK1lnqXk1/es1/i0yoAmXjd9gEkLEuFOB7KY3SJ+HtN/CB1vTPyNMDbbqQkpAuQvsxgpJzAnPlZsePh68Ar8jvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330893; c=relaxed/simple;
	bh=BNPIdBRT7CM8MGpsUcziIKRCbXR9Gz0G76U8XgmV0G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNPNLnyWXYjprW++Xhp4ObqIjmY9c1ilrP8CEqgEAUHt8+SfRVkPyH0hySzfQWEaSGPFC0Yl1WYM5tOyJfyudUC01VlTPb3hGIp6k99wkFu7zX2jYRncvt7k+A/rFvh1d3JR1rFCCPCrELcgVncFgMD2oPJCXNzVzIJ8cqJIVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8dea5a2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57824fa0a8fso1383728a12.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716330890; x=1716935690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s+orqL1cRMgmsLBRjW2HlgarXg9BzQeix48Sp86qm0=;
        b=S8dea5a2JtmHhob+AzcefkmVnMJS9rShhADlLJbARm7yI0qVcxO6+qASXz7cJ2ZIc1
         B88Q+yJl4+zPUxOncDTShTyUA9oU80n4obj0rSl63z7mDZy9uEIZYU2Wiw2P3r8XNAGP
         NIRJSD+7m+80FUI5Vkoqy/g6eNihgC1hE0Cl4UIttEGJRKWGn8S2z5Dl9kZvFbNnBW+2
         HAO351PHAUHFmoqN8tVhX863pwxknVxrd8+ghMnbsqnShNcQcO4gqfO+DBsyGLD80+2v
         1ZNhsix/uVsf4C6xd2gX3O0cXEbu3NV6qjErm4bum74C3Ive1SX30sK/CNvs+c7h6Qpe
         ASKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330890; x=1716935690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s+orqL1cRMgmsLBRjW2HlgarXg9BzQeix48Sp86qm0=;
        b=RrGWp+Y9XOD6bPQhKJJTWat6KGgIiKiSaU2Bihy+wJ4GyNryMPb4cPxxstY3N9iybF
         mi0Iq3kmGkBDmQ+ZaKAgmuzwTgwYGUFJy2t/0rt9gdcMTFxe8MMbC6p1mNBjulRllcms
         crH8MZprIgW0FDRtJ67UiSGU3uVhTW96t4IJEH4JEBIF08HMsy4ZInhUr/VpOvlbM7ym
         0fvoAtPMbsbyFPatlEtghjI8DSQFpzBT965X67pQfnr4sEzjWeS8BSa1qfWY/TL0hccm
         uKytRIIqEddjWEaEDpMLQW4Zx2GdPVVR0qg93DjhQZ2/ObgMWnYm//u8nd/vZtZkYBbd
         t3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWo1hwMzUc4u5qZaoh6EfRzUnuH3m8XgQTPYt3fTzOyY9PbymjEiol+TmAeJ+UJx6XbC7k0Y6qAAjc3TT56Ov1mOhgc
X-Gm-Message-State: AOJu0YzcMHu+a0lVBeQJLa9ZqFAe4tMcLojDZWnDetqGQHv8Nr9V/Mrd
	kDgdA6rZz32eO2D30z8dLGqgPiGvtS3ngyZ14LJmZ8vl1Wrs39fsnnVY/UDf1ka6OGHTqNmoc9i
	+mLUmxtPK5t7SRTqg/Xzi8MaJkrE=
X-Google-Smtp-Source: AGHT+IFGKNrUD/VRyrD+T//JESyNzTKVzD0YwhwAhOImvmotYawlFRjQNVgp/bBoaZNvjmgQqNTUP7XTISfDU2ad+3A=
X-Received: by 2002:a17:906:a93:b0:a59:bfab:b25a with SMTP id
 a640c23a62f3a-a622818a40bmr7520366b.63.1716330889798; Tue, 21 May 2024
 15:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517102246.4070184-1-alan.maguire@oracle.com> <20240517102246.4070184-8-alan.maguire@oracle.com>
In-Reply-To: <20240517102246.4070184-8-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 15:34:30 -0700
Message-ID: <CAEf4BzYhESTek=DTJsKz9bmydUFjXK5M9JqVj3bBU9v5xr4HiQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/11] libbpf: split BTF relocation
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 3:23=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
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
>
> Once all mappings are established, we can update type ids
> and string offsets in split BTF and reparent it to the new base.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/Build             |   2 +-
>  tools/lib/bpf/btf.c             |  17 ++
>  tools/lib/bpf/btf.h             |   8 +
>  tools/lib/bpf/btf_relocate.c    | 318 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |   3 +
>  6 files changed, 348 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/btf_relocate.c

[...]

>  LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *=
opts);
>
> +/**
> + * @brief **btf__relocate()** will check the split BTF *btf* for referen=
ces
> + * to base BTF kinds, and verify those references are compatible with
> + * *base_btf*; if they are, *btf* is adjusted such that is re-parented t=
o
> + * *base_btf* and type ids and strings are adjusted to accommodate this.
> + */

add boilerplate regarding return results?..

> +LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf=
);
> +
>  struct btf_dump;
>
>  struct btf_dump_opts {
> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> new file mode 100644
> index 000000000000..c06851f05472
> --- /dev/null
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024, Oracle and/or its affiliates. */
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include "btf.h"
> +#include "bpf.h"
> +#include "libbpf.h"
> +#include "libbpf_internal.h"
> +
> +struct btf;
> +
> +struct btf_relocate {
> +       __u32 search_id;                                /* must be first =
field; see search below */

just put that comment before the field, why this horizontal placement?

[...]

> +
> +/* Comparison between base BTF type (search type) and distilled base typ=
es (target).
> + * Because there is no bsearch_r() we need to use the search key - which=
 also is
> + * the first element of struct btf_relocate * - as a means to retrieve t=
he
> + * struct btf_relocate *.
> + */
> +static int cmp_base_and_distilled_btf_types(const void *idbase, const vo=
id *iddist)
> +{
> +       struct btf_relocate *r =3D (struct btf_relocate *)idbase;
> +       const struct btf_type *tbase =3D btf_type_by_id(r->base_btf, *(__=
u32 *)idbase);
> +       const struct btf_type *tdist =3D btf_type_by_id(r->dist_base_btf,=
 *(__u32 *)iddist);

boo, id_base or base_id, id_dist or dist_id, we went through such
naming already, I believe :)

I'd also use base_t and dist_t, like you do below with dist_t already

> +
> +       return strcmp(btf__name_by_offset(r->base_btf, tbase->name_off),
> +                     btf__name_by_offset(r->dist_base_btf, tdist->name_o=
ff));
> +}
> +
> +/* Build a map from distilled base BTF ids to base BTF ids. To do so, it=
erate
> + * through base BTF looking up distilled type (using binary search) equi=
valents.
> + */
> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
> +{
> +       struct btf_type *t;
> +       const char *name;
> +       __u32 id;
> +
> +       /* generate a sort index array of type ids sorted by name for dis=
tilled
> +        * base BTF to speed lookups.
> +        */
> +       for (id =3D 1; id < r->nr_dist_base_types; id++)
> +               r->dist_base_index[id] =3D id;
> +       qsort_r(r->dist_base_index, r->nr_dist_base_types, sizeof(__u32),=
 cmp_btf_types,
> +               (struct btf *)r->dist_base_btf);

Is qsort_r() supported in musl and in Android'd libc implementation?
I'd rather not have to scramble to fix the build for them after
release.

> +

[...]

> +               r->search_id =3D id;
> +               dist_id =3D bsearch(&r->search_id, r->dist_base_index, r-=
>nr_dist_base_types,
> +                                 sizeof(__u32), cmp_base_and_distilled_b=
tf_types);
> +               if (!dist_id)
> +                       continue;
> +               if (!*dist_id || *dist_id > r->nr_dist_base_types) {

>=3D

> +                       pr_warn("base BTF id [%d] maps to invalid distill=
ed base BTF id [%d]\n",
> +                               id, *dist_id);
> +                       return -EINVAL;
> +               }
> +               /* validate that kinds are compatible */
> +               dist_t =3D btf_type_by_id(r->dist_base_btf, *dist_id);
> +               dist_kind =3D btf_kind(dist_t);
> +               name =3D btf__name_by_offset(r->dist_base_btf, dist_t->na=
me_off);
> +               compat_kind =3D dist_kind =3D=3D kind;
> +               if (!compat_kind) {
> +                       switch (dist_kind) {
> +                       case BTF_KIND_FWD:
> +                               compat_kind =3D kind =3D=3D BTF_KIND_STRU=
CT || kind =3D=3D BTF_KIND_UNION;

well, not quite. If we have FWD with kflag, then we should match it to
BTF_KIND_UNION, and otherwise to STRUCT. We shouldn't fix them.

also do we match FWD in *base BTF* with FWD in *distilled base BTF*?
That seems a bit wrong, no?


> +                               break;
> +                       case BTF_KIND_ENUM:
> +                               compat_kind =3D kind =3D=3D BTF_KIND_ENUM=
64;
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +                       if (!compat_kind) {
> +                               pr_warn("kind incompatibility (%d !=3D %d=
) between distilled base type '%s'[%d] and base type [%d]\n",
> +                                       dist_kind, kind, name, *dist_id, =
id);
> +                               return -EINVAL;
> +                       }
> +               }

umm, what if we are !compat_kind here? go to next or error out, but
there has to be a check


> +               /* validate that int, float struct, union sizes are compa=
tible;
> +                * distilled base BTF encodes an empty STRUCT/UNION with
> +                * specific size for cases where a type is embedded in a =
split
> +                * type (so has to preserve size info).  Do not error out
> +                * on mismatch as another size match may occur for an
> +                * identically-named type.
> +                */
> +               switch (btf_kind(dist_t)) {
> +               case BTF_KIND_INT:
> +                       if (*(__u32 *)(t + 1) !=3D *(__u32 *)(dist_t + 1)=
)
> +                               continue;
> +                       if (t->size !=3D dist_t->size)
> +                               continue;
> +                       break;
> +               case BTF_KIND_FLOAT:
> +               case BTF_KIND_STRUCT:
> +               case BTF_KIND_UNION:
> +                       if (t->size !=3D dist_t->size)
> +                               continue;
> +                       break;
> +               default:
> +                       break;
> +               }

I don't know, I feel like all these compatibility checks would be
cleaner to handle as part of single switch based on btf_kind(dist_t).
This split between that big if and switch is error-prone and hard to
follow

> +               /* map id and name */
> +               r->map[*dist_id] =3D id;
> +               r->str_map[dist_t->name_off] =3D t->name_off;
> +       }
> +       /* ensure all distilled BTF ids have a mapping... */
> +       for (id =3D 1; id < r->nr_dist_base_types; id++) {
> +               if (r->map[id])
> +                       continue;
> +               t =3D btf_type_by_id(r->dist_base_btf, id);
> +               name =3D btf__name_by_offset(r->dist_base_btf, t->name_of=
f);
> +               pr_warn("distilled base BTF type '%s' [%d] is not mapped =
to base BTF id\n",
> +                       name, id);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +

[...]

> +static int btf_rewrite_strs(__u32 *str_off, void *ctx)
> +{
> +       struct btf_relocate *r =3D ctx;
> +       int off;
> +
> +       if (!*str_off)
> +               return 0;
> +       if (*str_off >=3D r->str_start) {
> +               *str_off +=3D r->str_diff;
> +       } else {
> +               off =3D r->str_map[*str_off];
> +               if (!off) {
> +                       pr_warn("string '%s' [offset %d] is not mapped to=
 base BTF",
> +                               btf__str_by_offset(r->btf, off), *str_off=
);

str_off is __u32, but you are using %d

> +                       return -ENOENT;
> +               }
> +               *str_off =3D off;
> +       }
> +       return 0;
> +}
> +
> +static int btf_relocate_finalize(struct btf_relocate *r)
> +{
> +       const struct btf_header *dist_base_hdr;
> +       const struct btf_header *base_hdr;
> +       struct btf_type *t;
> +       int i, err;
> +
> +       dist_base_hdr =3D btf_header(r->dist_base_btf);
> +       base_hdr =3D btf_header(r->base_btf);
> +       r->str_start =3D dist_base_hdr->str_len;
> +       r->str_diff =3D base_hdr->str_len - dist_base_hdr->str_len;

it's subjective, but I find str_diff a bit harder to follow compared
to just storing str_old_start and str_new_start, and then doing
obvious translation

str_off =3D str_off - str_old_start + str_new_start;

This is obvious and will work for any condition, whether old_start is
smaller or bigger than new_start. Same idea for ID translation.

Not a big deal, but I thought I'd call this out.

> +       for (i =3D 0; i < r->nr_split_types; i++) {
> +               t =3D btf_type_by_id(r->btf, i + r->nr_dist_base_types);
> +               err =3D btf_type_visit_str_offs(t, btf_rewrite_strs, r);
> +               if (err)
> +                       break;

return err? Why do we want to set btf_set_base_btf() in case of an error?

> +       }
> +       btf_set_base_btf(r->btf, r->base_btf);
> +
> +       return err;
> +}
> +
> +/* If successful, output of relocation is updated BTF with base BTF poin=
ting
> + * at base_btf, and type ids, strings adjusted accordingly
> + */
> +int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **ma=
p_ids)
> +{
> +       unsigned int nr_types =3D btf__type_cnt(btf);
> +       struct btf_relocate r =3D {};
> +       struct btf_type *t;
> +       int diff_id, err =3D 0;
> +       __u32 id, i;
> +
> +       r.dist_base_btf =3D btf__base_btf(btf);
> +       if (!base_btf || r.dist_base_btf =3D=3D base_btf)
> +               return 0;

Why is this not an error condition? Users shouldn't be calling
relocate on something that shouldn't be relocated.

> +
> +       r.nr_dist_base_types =3D btf__type_cnt(r.dist_base_btf);
> +       r.nr_base_types =3D btf__type_cnt(base_btf);
> +       r.nr_split_types =3D nr_types - r.nr_dist_base_types;
> +       r.btf =3D btf;
> +       r.base_btf =3D base_btf;
> +
> +       r.map =3D calloc(nr_types, sizeof(*r.map));

Is this an ID map? Then maybe call it id_map to be symmetrical to str_map?

> +       r.str_map =3D calloc(btf_header(r.dist_base_btf)->str_len, sizeof=
(*r.str_map));
> +       r.dist_base_index =3D calloc(r.nr_dist_base_types, sizeof(*r.dist=
_base_index));
> +       if (!r.map || !r.str_map || !r.dist_base_index) {
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +
> +       err =3D btf_relocate_validate_distilled_base(&r);
> +       if (err)
> +               goto err_out;
> +
> +       diff_id =3D r.nr_base_types - r.nr_dist_base_types;
> +       /* Split BTF ids will start from after last base BTF id. */
> +       for (id =3D r.nr_dist_base_types; id < nr_types; id++)
> +               r.map[id] =3D id + diff_id;
> +
> +       /* Build a map from distilled base ids to actual base BTF ids; it=
 is used
> +        * to update split BTF id references.
> +        */
> +       err =3D btf_relocate_map_distilled_base(&r);
> +       if (err)
> +               goto err_out;
> +
> +       /* Next, rewrite type ids in split BTF, replacing split ids with =
updated
> +        * ids based on number of types in base BTF, and base ids with
> +        * relocated ids from base_btf.
> +        */
> +       for (i =3D 0, id =3D r.nr_dist_base_types; i < r.nr_split_types; =
i++, id++) {
> +               t =3D btf_type_by_id(btf, id);
> +               err =3D btf_type_visit_type_ids(t, btf_relocate_rewrite_t=
ype_id, &r);
> +               if (err)
> +                       goto err_out;
> +       }
> +       /* Finally reset base BTF to base_btf; as part of this operation,=
 string
> +        * offsets are also updated, and we are done.
> +        */
> +       err =3D btf_relocate_finalize(&r);
> +err_out:
> +       if (!err && map_ids)
> +               *map_ids =3D r.map;
> +       else
> +               free(r.map);

this is a bit convoluted. maybe something like


    err =3D btf_relocate_finalize(&r);
    if (err)
        goto err_out;

    if (map_ids) {
        *map_ids =3D r.map;
        r.map =3D NULL;
    }

err_out:
    ... all the free()s unconditionally ...


(even just doing only error case for err_out and duplicating a few
free()'s in success path seems nicer)

> +       free(r.str_map);
> +       free(r.dist_base_index);
> +       return err;
> +}

[...]

