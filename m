Return-Path: <bpf+bounces-27992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6458B4264
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A78282763
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC8A38FA1;
	Fri, 26 Apr 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NswKI1aH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694242C6B7
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172238; cv=none; b=f7M73enoKX1gk9k57azPjAItVGa0OGsYBVkZ74hlKWVR1tfvLOxZX5KrRQ3x1Rv65/edd+U8DyLZwV2vTN0VDE5dVvKj2Ga+IFNJ773QkxeIL2L+nFQAS+ZDW9svAD1F6oqv1b6JzUHHYIUlhLFcwJob1SdCPJMmxr+P/SCcZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172238; c=relaxed/simple;
	bh=+VSzLoEREZSnFPvpTcSWclQRDVOLp/cteBARYt4cB6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBojJ/qOkAEbqbmCFTVPPvtwmXEnL0WbvmsXmhIeDN6UtBwFr930sT2UpHpKdfjAwXyKhvrqR2CNhUTVcS7a1xTIq9eAHRZlW3LxFThbVJXLcf7ovTbHY5b63wJTiO7ItMsS9L9/HNZKKQJI5q9Bs+P+ZBNsPDJnf7FCF3p0bmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NswKI1aH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so2245486a12.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714172235; x=1714777035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcVnBLNuhKAMhg7pcm6qMWQryKC0lzJ3xR/fX4SKA5Q=;
        b=NswKI1aHsclrozJ10Xx1qbpti59rbPEbNpk4E59T4R3vNC4ST/sLVRK9UuqOrILZ7S
         xzOY5w5hqnJlsCVQq/2ay3GKSn99YB2tlESiFeeBO/FfYnMgKgwJeliEArB2NuSyyNBa
         +R7a2GAYWALOUEj6sh4NvEfIXLekE4GXGFSNhL4ehJLeHa7hwNRS1pPPGpXhnyJH0tci
         8rcOI7L2/xPsLFkFUOpBKvBzhL3YrmVpWTshitgJc2rl28iJpGXP8/VkowL2OB57fg6Y
         Yk3wAz9M83vlCiV/7O0/LP5CKVjld6xz54+4IdGVg3sIWHbnN3/01lEOLXxnUTzgPmvd
         YJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714172235; x=1714777035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcVnBLNuhKAMhg7pcm6qMWQryKC0lzJ3xR/fX4SKA5Q=;
        b=KR0BzDULeXF4y8ptAhUZvsrD5mlP67Esu7NsV+nV8y4o9+IKUndhi71dEvcdCIOtl2
         awdTe8tQKgfdFlcrbYKFKYujYXEr/I4mwVMLZfAmIPACW9X1TUiBDNoNQuDUZaKmHzpg
         Oa0N58Ep/mWkXiznr0Fo4ovCRqc5s+ov11fZ7CBJ53DxxoXWZlpZBayuRvGaEBjK0xta
         Gcu0lIkbfx/ObStgLvCm4uj7rl08EWBNTZBguLnyLKPAYdkKyVtGO1Iyyja1nIGx8n3h
         TLf3GKsoWVIv72KHiLsFpgh+nQVUst41Dwiqz3Oas7vLu1K5gGTqHuL3cDXUaHs5mSJq
         PqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmvMuNalkyllJG/nPU2tQYFUvz7TwRfcaacNLJYz+aUxsQbcqZsguqO6x++bHvz7q+zIWVtJaltkWKEzDnM1Nh3Srm
X-Gm-Message-State: AOJu0Yx5jFZ3n2vA2G3Zv2KYRgMPaBt6jxQkv3K/lIiR5XivczxRaUWe
	p7SnQa0tolo4ENOpdHuG87rOBCq6JK20TufdhxOEjzLK5SKjvReJVjmyV7rtGmPVrQeTi1lFvlP
	nBpjxcILBR4SALbv6dF2spUWft3M=
X-Google-Smtp-Source: AGHT+IF6w6/DepnTpMMH8HGJndbv7YgISHRqdScRmldxUfAUk7tv26ExatL2Eb5pbQSZS9J16b2yVfm90jPSo09JYyM=
X-Received: by 2002:a17:90b:23c3:b0:29c:7566:a1d6 with SMTP id
 md3-20020a17090b23c300b0029c7566a1d6mr4134394pjb.25.1714172235490; Fri, 26
 Apr 2024 15:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com> <20240424154806.3417662-3-alan.maguire@oracle.com>
In-Reply-To: <20240424154806.3417662-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 15:57:02 -0700
Message-ID: <CAEf4BzaPHdLmFeJhCWrUPOaODuGYtVESjMT9M-kVkACE3rFrQA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/13] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:48=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> To support more robust split BTF, adding supplemental context for the
> base BTF type ids that split BTF refers to is required.  Without such
> references, a simple shuffling of base BTF type ids (without any other
> significant change) invalidates the split BTF.  Here the attempt is made
> to store additional context to make split BTF more robust.
>
> This context comes in the form of distilled base BTF - this base BTF
> constitutes the minimal BTF representation needed to disambiguate split B=
TF
> references to base BTF.  The rules are as follows:
>
> - INT, FLOAT are recorded in full.
> - if a named base BTF STRUCT or UNION is referred to from split BTF, it
>   will be encoded either as a zero-member sized STRUCT/UNION (preserving
>   size for later relocation checks) or as a named FWD.  Only base BTF
>   STRUCT/UNIONs that are embedded in split BTF STRUCT/UNIONs need to
>   preserve size information, so a FWD representation will be used in
>   most cases.
> - if an ENUM[64] is named, a ENUM[64] forward representation (an ENUM[64]
>   with no values) is used.
> - if a STRUCT, UNION, ENUM or ENUM64 is not named, it is recorded in full=
.
> - base BTF reference types like CONST, RESTRICT, TYPEDEF, PTR are recorde=
d
>   as-is.
>
> Avoiding struct/union/enum/enum64 expansion is important to keep the
> distilled base BTF representation to a minimum size; however anonymous
> struct, union and enum[64] types are represented in full since type detai=
ls
> are needed to disambiguate the reference - the name is not enough in thos=
e
> cases since there is no name.  In practice these are rare; in sample
> cases where reference base BTF was generated for in-tree kernel modules,
> only a few were needed in distilled base BTF.  These represent the
> anonymous struct/unions that are used by the module but were de-duplicate=
d
> to use base vmlinux BTF ids instead.
>
> When successful, new representations of the distilled base BTF and new
> split BTF that refers to it are returned.  Both need to be freed by the
> caller.
>
> So to take a simple example, with split BTF with a type referring
> to "struct sk_buff", we will generate base reference BTF with a
> FWD struct sk_buff, and the split BTF will refer to it instead.
>
> Tools like pahole can utilize such split BTF to popuate the .BTF section

typo: populate

> (split BTF) and an additional .BTF.base section.
> Then when the split BTF is loaded, the distilled base BTF can be used
> to relocate split BTF to reference the current - and possibly changed -
> base BTF.
>
> So for example if "struct sk_buff" was id 502 when the split BTF was
> originally generated,  we can use the distilled base BTF to see that
> id 502 refers to a "struct sk_buff" and replace instances of id 502
> with the current (relocated) base BTF sk_buff type id.
>
> Distilled base BTF is small; when building a kernel with all modules
> using distilled base BTF as a test, the average size for module
> distilled base BTF is 1555 bytes (standard deviation 1563).  The
> maximum distilled base BTF size across ~2700 modules was 37895 bytes.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 316 ++++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/btf.h      |  20 +++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 331 insertions(+), 6 deletions(-)
>

So, a few high-level notes.

1. I still think we should not add *anything* besides named
structs/unions/enums into distilled base BTF. Unless proven otherwise,
I don't see why we'd need them and complicate kernel-side. It's also
not a big complication for libbpf and your code below is like 95%
there anyways. See below about id map

2. I don't think we need to init id map to -1. 0 is always an
"invalid" ID in the sense that no valid type has such ID. It's
reserved for VOID and in this context could mean "not yet mapped"
right after calloc().

3. Please double-check the handling of all possible kinds (TYPE_TAG
and DECL_TAG are notoriously missing, if I'm not missing anything
myself)

4. we can use the same id map to remap those anonymous/copied types
from original base BTF into new split BTF. We just map them to higher
IDs (and append them to split BTF at the end). So we'll have a few
interesting cases (for id map):

  a) id =3D=3D 0, not yet mapped/visited/irrelevant
  b) id < btf__type_cnt(base_btf) -- remapped base BTF type in distilled BT=
F
  c) id >=3D btf__type_cnt(base_btf) -- remapped base BTF type appended
to new split BTF (because anonymous or can't existing in distilled
base BTF)

remapping is trivial in this case.

5. it's minor, but it feel wasteful to waste 4 bytes per each type
just to record "embedded" flag, we can just set highest bit to 1 for
such IDs and account for that in the logic I described above and
remapping overall. Again, it's minor, but feels wrong to allocate half
a megabyte (my kernel has 130K types) just for those few bits.

So, I think you are really close, let's try to iterate on this (both
discussion and implementation) quickly and get it over the finish
line.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 44afae098369..419cc4fa2e86 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1771,9 +1771,8 @@ static int btf_rewrite_str(__u32 *str_off, void *ct=
x)
>         return 0;
>  }
>

[...]

>  static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
> @@ -5217,3 +5223,301 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ex=
t, str_off_visit_fn visit, void
>
>         return 0;
>  }
> +
> +struct btf_distill_id {
> +       int id;
> +       bool embedded;          /* true if id refers to a struct/union in=
 base BTF
> +                                * that is embedded in a split BTF struct=
/union.
> +                                */

nit: add this multi-line comment before `bool embedded;` line

> +};
> +

[...]

> +               case BTF_KIND_STRUCT:
> +               case BTF_KIND_UNION:
> +                       dist->ids[next_id].embedded =3D next_id > 0 &&
> +                                                     next_id <=3D dist->=
nr_base_types;

hm... if next_id >=3D dist->nr_base_types, you are still overwriting
some memory in dist->ids[next_id], no? And again, you are doing wrong
< vs <=3D comparisons in nr_base_types (I think, please prove me wrong).

> +                       return 0;
> +               default:
> +                       return 0;
> +               }
> +
> +       } while (next_id !=3D 0);
> +
> +       return 0;
> +}
> +
> +static bool btf_is_eligible_named_fwd(const struct btf_type *t)
> +{
> +       return (btf_is_composite(t) || btf_is_any_enum(t)) && t->name_off=
 !=3D 0;
> +}
> +
> +static int btf_add_distilled_type_ids(__u32 *id, void *ctx)
> +{
> +       struct btf_distill *dist =3D ctx;
> +       struct btf_type *t =3D btf_type_by_id(dist->pipe.src, *id);
> +       int ret;
> +
> +       /* split BTF id, not needed */
> +       if (*id > dist->nr_base_types)

>=3D, no? otherwise we have access out of bounds of dist->ids array, I thin=
k

> +               return 0;
> +       /* already added ? */
> +       if (dist->ids[*id].id >=3D 0)

let's use > 0 to make very clear that zero is never a valid (mapped) ID

> +               return 0;
> +       dist->ids[*id].id =3D *id;
> +

[...]

> +/* All split BTF ids will be shifted downwards since there are less base=
 BTF
> + * in distilled base BTF, and for those that refer to base BTF, we use t=
he
> + * reference map to map from original base BTF to distilled base BTF id.
> + */
> +static int btf_update_distilled_type_ids(__u32 *id, void *ctx)
> +{
> +       struct btf_distill *dist =3D ctx;
> +
> +       if (*id >=3D dist->nr_base_types)
> +               *id -=3D dist->diff_id;
> +       else
> +               *id =3D dist->ids[*id].id;
> +       return 0;
> +}
> +
> +/* Create updated /split BTF with distilled base BTF; distilled base BTF

/split -- was it supposed to be an emphasis, like "/split/" ?

> + * consists of BTF information required to clarify the types that split
> + * BTF refers to, omitting unneeded details.  Specifically it will conta=
in
> + * base types and forward declarations of structs, unions and enumerated
> + * types, along with associated reference types like pointers, arrays et=
c.
> + *
> + * The only case where structs, unions or enumerated types are fully rep=
resented
> + * is when they are anonymous; in such cases, info about type content is=
 needed
> + * to clarify type references.
> + *
> + * We return newly-created split BTF where the split BTf refers to a new=
ly-created

BTf -> BTF

> + * distilled base BTF. Both must be freed separately by the caller.
> + *
> + * When creating the BTF representation for a module and provided with t=
he
> + * distilled_base option, pahole will create split BTF using this API, a=
nd store
> + * the distilled base BTF in the .BTF.base.distilled section.

.BTF.base.distilled is outdated, update?

It's also kind of unusual to explain specific .BTF.base and pahole
convention. I guess it's fine to refer to pahole and .BTF.base, but
more like an example (this is minor)?

> + */
> +int btf__distill_base(const struct btf *src_btf, struct btf **new_base_b=
tf,
> +                     struct btf **new_split_btf)
> +{
> +       struct btf *new_base =3D NULL, *new_split =3D NULL;
> +       unsigned int n =3D btf__type_cnt(src_btf);
> +       struct btf_distill dist =3D {};
> +       struct btf_type *t;
> +       __u32 i, id =3D 0;
> +       int ret =3D 0;
> +
> +       /* src BTF must be split BTF. */
> +       if (!new_base_btf || !new_split_btf || !btf__base_btf(src_btf)) {
> +               errno =3D EINVAL;
> +               return -EINVAL;

use `return libbpf_err(-EINVAL);` here?

> +       }
> +       new_base =3D btf__new_empty();
> +       if (!new_base)
> +               return -ENOMEM;

libbpf_err()

> +       dist.ids =3D calloc(n, sizeof(*dist.ids));
> +       if (!dist.ids) {
> +               ret =3D -ENOMEM;
> +               goto err_out;
> +       }
> +       for (i =3D 1; i < n; i++)
> +               dist.ids[i].id =3D -1;
> +       dist.pipe.src =3D src_btf;
> +       dist.pipe.dst =3D new_base;
> +       dist.pipe.str_off_map =3D hashmap__new(btf_dedup_identity_hash_fn=
, btf_dedup_equal_fn, NULL);
> +       if (IS_ERR(dist.pipe.str_off_map)) {
> +               ret =3D -ENOMEM;
> +               goto err_out;
> +       }
> +       dist.nr_base_types =3D btf__type_cnt(btf__base_btf(src_btf));
> +
> +       /* Pass over src split BTF; generate the list of base BTF
> +        * type ids it references; these will constitute our distilled
> +        * base BTF set.
> +        */
> +       for (i =3D src_btf->start_id; i < n; i++) {
> +               t =3D (struct btf_type *)btf__type_by_id(src_btf, i);

btf_type_by_id() exists (as internal helper) exactly to not do these casts

> +
> +               /* check if members of struct/union in split BTF refer to=
 base BTF
> +                * struct/union; if so, we will use an empty sized struct=
 to represent
> +                * it rather than a FWD because its size must match on la=
ter BTF
> +                * relocation.
> +                */
> +               if (btf_is_composite(t)) {
> +                       ret =3D btf_type_visit_type_ids(t, btf_find_embed=
ded_composite_type_ids,
> +                                                     &dist);
> +                       if (ret < 0)
> +                               goto err_out;
> +               }
> +               ret =3D btf_type_visit_type_ids(t,  btf_add_distilled_typ=
e_ids, &dist);
> +               if (ret < 0)
> +                       goto err_out;
> +       }
> +       /* Next add types for each of the required references. */
> +       for (i =3D 1; i < src_btf->start_id; i++) {

I think you have dist.nr_base_types, let's use that as it's more explicit?

> +               if (dist.ids[i].id < 0)
> +                       continue;
> +               t =3D btf_type_by_id(src_btf, i);
> +
> +               if (dist.ids[i].embedded) {
> +                       /* If a named struct/union in base BTF is referen=
ced as a type
> +                        * in split BTF without use of a pointer - i.e. a=
s an embedded
> +                        * struct/union - add an empty struct/union prese=
rving size
> +                        * since size must be consistent when relocating =
split and
> +                        * possibly changed base BTF.
> +                        */
> +                       ret =3D btf_add_composite(new_base, btf_kind(t),
> +                                               btf__name_by_offset(src_b=
tf, t->name_off),

nit: look up name ahead of time (it's fine to pass zero to
btf__name_by_offset()), and use it below for btf__add_fwd() as well

> +                                               t->size);
> +               } else if (btf_is_eligible_named_fwd(t)) {
> +                       enum btf_fwd_kind fwd_kind;
> +
> +                       /* If not embedded, use a fwd for named struct/un=
ions since we
> +                        * can match via name without any other details.
> +                        */
> +                       switch (btf_kind(t)) {
> +                       case BTF_KIND_STRUCT:
> +                               fwd_kind =3D BTF_FWD_STRUCT;
> +                               break;
> +                       case BTF_KIND_UNION:
> +                               fwd_kind =3D BTF_FWD_UNION;
> +                               break;
> +                       case BTF_KIND_ENUM:
> +                               fwd_kind =3D BTF_FWD_ENUM;
> +                               break;
> +                       case BTF_KIND_ENUM64:
> +                               fwd_kind =3D BTF_FWD_ENUM64;
> +                               break;

it feels like if you just have

case BTF_KIND_ENUM:
case BTF_KIND_ENUM64:
    fwd_kind =3D BTF_FWD_ENUM;
    break;

we wouldn't lose anything and wouldn't need patch #1

> +                       default:
> +                               pr_warn("unexpected kind [%u] when creati=
ng distilled base BTF.\n",
> +                                       btf_kind(t));
> +                               goto err_out;
> +                       }
> +                       ret =3D btf__add_fwd(new_base, btf__name_by_offse=
t(src_btf, t->name_off),
> +                                          fwd_kind);
> +               } else {
> +                       ret =3D btf_add_type(&dist.pipe, t);
> +               }
> +               if (ret < 0)
> +                       goto err_out;
> +               dist.ids[i].id =3D ++id;
> +       }
> +       /* now create new split BTF with distilled base BTF as its base; =
we end up with
> +        * split BTF that has base BTF that represents enough about its b=
ase references
> +        * to allow it to be relocated with the base BTF available.
> +        */
> +       new_split =3D btf__new_empty_split(new_base);
> +       if (!new_split_btf) {
> +               ret =3D libbpf_get_error(new_split);

please don't add new uses of libbpf_get_error(), `ret =3D -errno`

> +               goto err_out;
> +       }
> +
> +       dist.pipe.dst =3D new_split;
> +       /* all split BTF ids will be shifted downwards since there are le=
ss base BTF ids
> +        * in distilled base BTF.
> +        */
> +       dist.diff_id =3D dist.nr_base_types - btf__type_cnt(new_base);
> +
> +       /* First add all split types */
> +       for (i =3D src_btf->start_id; i < n; i++) {
> +               t =3D btf_type_by_id(src_btf, i);
> +               ret =3D btf_add_type(&dist.pipe, t);
> +               if (ret < 0)
> +                       goto err_out;
> +       }
> +       n =3D btf__type_cnt(new_split);
> +       /* Now update base/split BTF ids. */
> +       for (i =3D 1; i < n; i++) {
> +               t =3D btf_type_by_id(new_split, i);
> +
> +               ret =3D btf_type_visit_type_ids(t,  btf_update_distilled_=
type_ids, &dist);
> +               if (ret < 0)
> +                       goto err_out;
> +       }
> +       free(dist.ids);
> +       hashmap__free(dist.pipe.str_off_map);
> +       *new_base_btf =3D new_base;
> +       *new_split_btf =3D new_split;
> +       return 0;
> +err_out:
> +       free(dist.ids);
> +       hashmap__free(dist.pipe.str_off_map);
> +       btf__free(new_split);
> +       btf__free(new_base);
> +       errno =3D -ret;
> +       return ret;

libbpf_err(ret), but also s/ret/err/, it is literally error value or
zero (for success)

> +}
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 47d3e00b25c7..025ed28b7fe8 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -107,6 +107,26 @@ LIBBPF_API struct btf *btf__new_empty(void);
>   */
>  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
>
> +/**
> + * @brief **btf__distill_base()** creates new versions of the split BTF
> + * *src_btf* and its base BTF.  The new base BTF will only contain the t=
ypes

nit: extra spaces after '.'

> + * needed to improve robustness of the split BTF to small changes in bas=
e BTF.
> + * When that split BTF is loaded against a (possibly changed) base, this
> + * distilled base BTF will help update references to that (possibly chan=
ged)
> + * base BTF.
> + *
> + * Both the new split and its associated new base BTF must be freed by
> + * the caller.
> + *
> + * If successful, 0 is returned and **new_base_btf** and **new_split_btf=
**
> + * will point at new base/split BTF.  Both the new split and its associa=
ted

nit: extra spaces after '.'

> + * new base BTF must be freed by the caller.
> + *
> + * A negative value is returned on error.
> + */
> +LIBBPF_API int btf__distill_base(const struct btf *src_btf, struct btf *=
*new_base_btf,
> +                                struct btf **new_split_btf);
> +
>  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf=
_ext);
>  LIBBPF_API struct btf *btf__parse_split(const char *path, struct btf *ba=
se_btf);
>  LIBBPF_API struct btf *btf__parse_elf(const char *path, struct btf_ext *=
*btf_ext);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c1ce8aa3520b..c4d9bd7d3220 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -420,6 +420,7 @@ LIBBPF_1.4.0 {
>  LIBBPF_1.5.0 {
>         global:
>                 bpf_program__attach_sockmap;
> +               btf__distill_base;

nit: '_' orders before 'p'


>                 ring__consume_n;
>                 ring_buffer__consume_n;
>  } LIBBPF_1.4.0;
> --
> 2.31.1
>

