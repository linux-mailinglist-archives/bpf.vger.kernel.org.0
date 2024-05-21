Return-Path: <bpf+bounces-30164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DE08CB57F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 23:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB01282B87
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328D1494C7;
	Tue, 21 May 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwbQMuNC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073D487B0
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328104; cv=none; b=fqjxwBQW5+wni2HsTy8zCK9qunyP8TAxWH2GkHMfPwbbflqOU+9HbIXVpZg0joVS3KmOOOXql3JuFRqJinj5xALOrxXHQhFcctz5E3n1XQArxHaPYJY6LJ/Ubk9hmXJtNWGtrRq2p8IFvKqNcY7LrWgmV2n1mNTqib/ckL9nytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328104; c=relaxed/simple;
	bh=WURF0AIaqvdT5LX9drCFCDzZdEECLHWS5UhQChnwwuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl5gv/CZ6f5iO7sjqstUhzbysjHQD7EBj9WojTZTY/cPDQmikuUhtfCGBRO7yS8PbiexBtRwfaT6zxKHj8AE9Asmr3W6FykyfxX7c6+cdp4MNMG5DLLqDnqJtu3S9jDu0JIcNa1NuaqROARwc2YI+2Qi76tqUneUU3cILu7s5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwbQMuNC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ba0cb1ea68so739849a91.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716328102; x=1716932902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgKU9oO+PFDoBMycJO3rdrRVnW8zB4lIoCbFEzE5nR4=;
        b=mwbQMuNCCVhgHWdaEKh9xqlc1Rxvk9pEU/FM7mPTaJ+BQMUpDnth5jml2L8th/Up8B
         S3Zi+QZ18qz4sonmFw4IHK6rL6xyyr/q3eCKJhxOiTpDsJ60K2kDmJNDAUc5HEhYlGRF
         Q/wVvV2kt+hF9AVJgssdSLTx887B1iy2eRIajwdyh5ovqaxiXX7Nxqj7NVCRzpNxSuvu
         uaHjuFQvh49EIipJ0l9KG3BelCzCnGBZzgo3/4xV0cBSGOfABoW40tzZfEdJfwZ41BAb
         6GiDSxzmjZ6zCdk/dpVfPcil+NNYnf636FdKHo9SqKJfPEP3Z8efM+Ep1FxCeqnV1N7/
         O4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716328102; x=1716932902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgKU9oO+PFDoBMycJO3rdrRVnW8zB4lIoCbFEzE5nR4=;
        b=Oq2T+rrTjqPJ0OxpFflrb+fml+AU+hIaIFC7674hgbmjfsPxXi0dTsikuuMirdFF8J
         3r61eudf6IOa8IKpNFW1JAEscsrvCdgwhbkQL/9KKyVa50BmxF2ErpOEnm4hu1gUYSsI
         oZd0IpyGBfK7YUYHohORgrFajzMF+0Lgw4wbPn7cdwW3GjBQ7WypoXhn7w22MHkQ6ReD
         0DdLgGKTKKAEEW7SW/tfM0CaPdkz6BkV9OO5Cp+KRavvC12BVT5G8bEIamQ8JnQXL6iU
         n2OY0TJzzYIC+Cv7Kd7D7R6asUhJ3mMRsOieQrC7mY170k4+BvL7tQEFeoytFx4Up+L6
         /9GA==
X-Forwarded-Encrypted: i=1; AJvYcCVH+0sxANiRnZ9prfoDyQ7vveB1xSeM4y6xfZ+CHlAAEKV4p3UsYrfZN8y/FVuKCjNIP8wOjTo3u8mev062oCuLFYkP
X-Gm-Message-State: AOJu0Yx8YYoTzPB9NSMJj6K2L77TMUAqv9rYmirMDjATxCsal3H9WTSM
	fr26uLmnpRGM/qcwZP8SNAPjrBdfAebvo2ZEfjq01pzyePB7FSmYuMqrfsHxs5IjHYM9/seGqa4
	TL99jUK2he8I11P2HkhTuCeMjbnw=
X-Google-Smtp-Source: AGHT+IE10vNThdrVJWyHZHOQA531GF/e5LIyeJqjjkNEoqTgCYOlBpmI2LWiKjLCBFeRTYoOO+bE9N7RiRvMYVLW0oY=
X-Received: by 2002:a17:90a:d90b:b0:2bd:92d9:65ee with SMTP id
 98e67ed59e1d1-2bd9f5c0ef4mr321934a91.45.1716328101780; Tue, 21 May 2024
 14:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517102246.4070184-1-alan.maguire@oracle.com> <20240517102246.4070184-2-alan.maguire@oracle.com>
In-Reply-To: <20240517102246.4070184-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 14:48:08 -0700
Message-ID: <CAEf4Bzao+YSk9LfyDFVbWY-BKzExrvoAHn_5D37J7Mi2Rna06w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/11] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
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
> To support more robust split BTF, adding supplemental context for the
> base BTF type ids that split BTF refers to is required.  Without such
> references, a simple shuffling of base BTF type ids (without any other
> significant change) invalidates the split BTF.  Here the attempt is made
> to store additional context to make split BTF more robust.
>
> This context comes in the form of distilled base BTF providing minimal
> information (name and - in some cases - size) for base INTs, FLOATs,
> STRUCTs, UNIONs, ENUMs and ENUM64s along with modified split BTF that
> points at that base and contains any additional types needed (such as
> TYPEDEF, PTR and anonymous STRUCT/UNION declarations).  This
> information constitutes the minimal BTF representation needed to
> disambiguate or remove split BTF references to base BTF.  The rules
> are as follows:
>
> - INT, FLOAT are recorded in full.
> - if a named base BTF STRUCT or UNION is referred to from split BTF, it
>   will be encoded either as a zero-member sized STRUCT/UNION (preserving
>   size for later relocation checks) or as a named FWD.  Only base BTF
>   STRUCT/UNIONs that are either embedded in split BTF STRUCT/UNIONs or
>   that have multiple STRUCT/UNION instances of the same name need to
>   preserve size information, so a FWD representation will be used in
>   most cases.
> - if an ENUM[64] is named, a ENUM forward representation (an ENUM
>   with no values) is used.
> - in all other cases, the type is added to the new split BTF.
>
> Avoiding struct/union/enum/enum64 expansion is important to keep the
> distilled base BTF representation to a minimum size.
>
> When successful, new representations of the distilled base BTF and new
> split BTF that refers to it are returned.  Both need to be freed by the
> caller.
>
> So to take a simple example, with split BTF with a type referring
> to "struct sk_buff", we will generate distilled base BTF with a
> FWD struct sk_buff, and the split BTF will refer to it instead.
>
> Tools like pahole can utilize such split BTF to populate the .BTF
> section (split BTF) and an additional .BTF.base section.  Then
> when the split BTF is loaded, the distilled base BTF can be used
> to relocate split BTF to reference the current (and possibly changed)
> base BTF.
>
> So for example if "struct sk_buff" was id 502 when the split BTF was
> originally generated,  we can use the distilled base BTF to see that
> id 502 refers to a "struct sk_buff" and replace instances of id 502
> with the current (relocated) base BTF sk_buff type id.
>
> Distilled base BTF is small; when building a kernel with all modules
> using distilled base BTF as a test, ovreall module size grew by only

typo: overall

> 5.3Mb total across ~2700 modules.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 409 ++++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/btf.h      |  20 ++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 424 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..953929d196c3 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1771,9 +1771,8 @@ static int btf_rewrite_str(__u32 *str_off, void *ct=
x)
>         return 0;
>  }
>
> -int btf__add_type(struct btf *btf, const struct btf *src_btf, const stru=
ct btf_type *src_type)
> +static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_t=
ype)
>  {
> -       struct btf_pipe p =3D { .src =3D src_btf, .dst =3D btf };
>         struct btf_type *t;
>         int sz, err;
>
> @@ -1782,20 +1781,27 @@ int btf__add_type(struct btf *btf, const struct b=
tf *src_btf, const struct btf_t
>                 return libbpf_err(sz);
>
>         /* deconstruct BTF, if necessary, and invalidate raw_data */
> -       if (btf_ensure_modifiable(btf))
> +       if (btf_ensure_modifiable(p->dst))
>                 return libbpf_err(-ENOMEM);
>
> -       t =3D btf_add_type_mem(btf, sz);
> +       t =3D btf_add_type_mem(p->dst, sz);
>         if (!t)
>                 return libbpf_err(-ENOMEM);
>
>         memcpy(t, src_type, sz);
>
> -       err =3D btf_type_visit_str_offs(t, btf_rewrite_str, &p);
> +       err =3D btf_type_visit_str_offs(t, btf_rewrite_str, p);
>         if (err)
>                 return libbpf_err(err);
>
> -       return btf_commit_type(btf, sz);
> +       return btf_commit_type(p->dst, sz);
> +}
> +
> +int btf__add_type(struct btf *btf, const struct btf *src_btf, const stru=
ct btf_type *src_type)
> +{
> +       struct btf_pipe p =3D { .src =3D src_btf, .dst =3D btf };
> +
> +       return btf_add_type(&p, src_type);
>  }
>
>  static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
> @@ -5212,3 +5218,394 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ex=
t, str_off_visit_fn visit, void
>
>         return 0;
>  }
> +
> +#define BTF_NEEDS_SIZE (1 << 31)       /* flag set if either struct/unio=
n is
> +                                        * embedded - and thus size info =
must
> +                                        * be preserved - or if there are
> +                                        * multiple instances of the same
> +                                        * struct/union - where size can =
be
> +                                        * used to clarify which is wante=
d.
> +                                        */

please use full line comment in front of #define

> +#define BTF_ID(id)             (id & ~BTF_NEEDS_SIZE)
> +
> +struct btf_distill {
> +       struct btf_pipe pipe;
> +       int *ids;

reading the rest of the code, this BTF_NEEDS_SIZE and BTF_ID() macro
use was quite distracting. I'm wondering if it would be better to use
a simple struct with bitfields here, e.g.,

struct type_state {
    int id: 31;
    bool needs_size;
};

struct dist_state *states;

Same memory usage, same efficiency, but more readable code. WDYT?

> +       unsigned int split_start_id;
> +       unsigned int split_start_str;
> +       unsigned int diff_id;
> +};
> +
> +/* Check if a member of a split BTF struct/union refers to a base BTF

nit: comments uses "check" terminology, function name uses "find",
while really it "marks" some time as embedded... Let's use consistent
terminology (where mark seems like the most fitting, IMO)

> + * struct/union.  Members can be const/restrict/volatile/typedef
> + * reference types, but if a pointer is encountered, type is no longer
> + * considered embedded.
> + */
> +static int btf_find_embedded_composite_type_ids(__u32 *id, void *ctx)
> +{
> +       struct btf_distill *dist =3D ctx;
> +       const struct btf_type *t;
> +       __u32 next_id =3D *id;
> +
> +       do {
> +               if (next_id =3D=3D 0)
> +                       return 0;
> +               t =3D btf_type_by_id(dist->pipe.src, next_id);
> +               switch (btf_kind(t)) {
> +               case BTF_KIND_CONST:
> +               case BTF_KIND_RESTRICT:
> +               case BTF_KIND_VOLATILE:
> +               case BTF_KIND_TYPEDEF:
> +               case BTF_KIND_TYPE_TAG:
> +                       next_id =3D t->type;
> +                       break;
> +               case BTF_KIND_ARRAY: {
> +                       struct btf_array *a =3D btf_array(t);
> +
> +                       next_id =3D a->type;
> +                       break;
> +               }
> +               case BTF_KIND_STRUCT:
> +               case BTF_KIND_UNION:
> +                       dist->ids[next_id] |=3D BTF_NEEDS_SIZE;
> +                       return 0;
> +               default:
> +                       return 0;
> +               }
> +
> +       } while (1);

nit: while (true)

> +
> +       return 0;
> +}
> +
> +/* Check if composite type has a duplicate-named type; if it does, retai=
n

see above about check vs mark, here at least the function name uses "mark" =
:)

> + * size information to help guide later relocation towards the correct t=
ype.
> + * For example there are duplicate 'dma_chan' structs in vmlinux BTF;
> + * one is size 112, the other 16.  Having size information allows reloca=
tion
> + * to choose the right one.

re: this dma_chan and similar cases. Is it ever a problem where a
module actually needs two dma_chan in distilled base BTF? Name
conflicts do happen, but intuitively I'd expect this to happen between
some vmlinux-internal (so to speak, i.e., not the type used in
exported functions/types) and kernel module-specific types. It would
be awkward for the same module to use two different types that are
named the same.

Have you seen this as a problem in practice? What if for now we just
error out if there are two conflicting types required in distilled
BTF?

> + */
> +static int btf_mark_composite_dups(struct btf_distill *dist, __u32 id)
> +{
> +       __u8 *cnt =3D calloc(dist->split_start_str, sizeof(__u8));

nit: we generally follow that initialization of variable shouldn't be
doing non-trivial operations. So let's do calloc() as a separate
statement outside of variable declaration.

> +       struct btf_type *t;
> +       int i;
> +
> +       if (!cnt)
> +               return -ENOMEM;
> +
> +       /* First pass; collect name counts for composite types. */
> +       for (i =3D 1; i < dist->split_start_id; i++) {
> +               t =3D btf_type_by_id(dist->pipe.src, i);
> +               if (!btf_is_composite(t) || !t->name_off)
> +                       continue;
> +               if (cnt[t->name_off] < 255)
> +                       cnt[t->name_off]++;
> +       }
> +       /* Second pass; mark composite types with multiple instances of t=
he
> +        * same name as needing size information.
> +        */
> +       for (i =3D 1; i < dist->split_start_id; i++) {
> +               /* id not needed or is already preserving size informatio=
n */
> +               if (!dist->ids[i] || (dist->ids[i] & BTF_NEEDS_SIZE))
> +                       continue;
> +               t =3D btf_type_by_id(dist->pipe.src, i);
> +               if (!btf_is_composite(t) || !t->name_off)
> +                       continue;
> +               if (cnt[t->name_off] > 1)
> +                       dist->ids[i] |=3D BTF_NEEDS_SIZE;
> +       }
> +       free(cnt);
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
> +       int err;
> +
> +       if (!*id)
> +               return 0;
> +       /* split BTF id, not needed */
> +       if (*id >=3D dist->split_start_id)
> +               return 0;
> +       /* already added ? */
> +       if (BTF_ID(dist->ids[*id]) > 0)
> +               return 0;
> +
> +       /* only a subset of base BTF types should be referenced from spli=
t
> +        * BTF; ensure nothing unexpected is referenced.
> +        */
> +       switch (btf_kind(t)) {
> +       case BTF_KIND_INT:
> +       case BTF_KIND_FLOAT:
> +       case BTF_KIND_FWD:
> +       case BTF_KIND_ARRAY:
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION:
> +       case BTF_KIND_TYPEDEF:
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
> +       case BTF_KIND_PTR:
> +       case BTF_KIND_CONST:
> +       case BTF_KIND_RESTRICT:
> +       case BTF_KIND_VOLATILE:
> +       case BTF_KIND_FUNC_PROTO:
> +       case BTF_KIND_TYPE_TAG:
> +               dist->ids[*id] |=3D *id;
> +               break;
> +       default:
> +               pr_warn("unexpected reference to base type[%u] of kind [%=
u] when creating distilled base BTF.\n",
> +                       *id, btf_kind(t));
> +               return -EINVAL;
> +       }
> +
> +       /* struct/union members not needed, except for anonymous structs
> +        * and unions, which we need since name won't help us determine
> +        * matches; so if a named struct/union, no need to recurse
> +        * into members.
> +        */

is this an outdated comment? we shouldn't have anonymous types in the
distilled base, right?

> +       if (btf_is_eligible_named_fwd(t))
> +               return 0;
> +
> +       /* ensure references in type are added also. */
> +       err =3D btf_type_visit_type_ids(t, btf_add_distilled_type_ids, ct=
x);
> +       if (err < 0)
> +               return err;
> +       return 0;

nit: could be just `return btf_type_visit_type_ids(...);`?

> +}
> +
> +static int btf_add_distilled_types(struct btf_distill *dist)
> +{
> +       bool adding_to_base =3D dist->pipe.dst->start_id =3D=3D 1;
> +       int id =3D btf__type_cnt(dist->pipe.dst);
> +       struct btf_type *t;
> +       int i, err =3D 0;
> +
> +       /* Add types for each of the required references to either distil=
led
> +        * base or split BTF, depending on type characteristics.
> +        */
> +       for (i =3D 1; i < dist->split_start_id; i++) {
> +               const char *name;
> +               int kind;
> +
> +               if (!BTF_ID(dist->ids[i]))
> +                       continue;
> +               t =3D btf_type_by_id(dist->pipe.src, i);
> +               kind =3D btf_kind(t);
> +               name =3D btf__name_by_offset(dist->pipe.src, t->name_off)=
;
> +
> +               /* Named int, float, fwd struct, union, enum[64] are adde=
d to
> +                * base; everything else is added to split BTF.
> +                */
> +               switch (kind) {
> +               case BTF_KIND_INT:
> +               case BTF_KIND_FLOAT:
> +               case BTF_KIND_FWD:
> +               case BTF_KIND_STRUCT:
> +               case BTF_KIND_UNION:
> +               case BTF_KIND_ENUM:
> +               case BTF_KIND_ENUM64:
> +                       if ((adding_to_base && !t->name_off) || (!adding_=
to_base && t->name_off))
> +                               continue;
> +                       break;
> +               default:
> +                       if (adding_to_base)
> +                               continue;
> +                       break;
> +               }
> +               if (dist->ids[i] & BTF_NEEDS_SIZE) {
> +                       /* If a named struct/union in base BTF is referen=
ced as a type
> +                        * in split BTF without use of a pointer - i.e. a=
s an embedded
> +                        * struct/union - add an empty struct/union prese=
rving size
> +                        * since size must be consistent when relocating =
split and
> +                        * possibly changed base BTF.  Similarly, when a =
struct/union
> +                        * has multiple instances of the same name in the=
 original
> +                        * base BTF, retain size to help relocation later=
 pick the
> +                        * right struct/union.
> +                        */
> +                       err =3D btf_add_composite(dist->pipe.dst, kind, n=
ame, t->size);
> +               } else if (btf_is_eligible_named_fwd(t)) {
> +                       /* If not embedded, use a fwd for named struct/un=
ions since we
> +                        * can match via name without any other details.
> +                        */
> +                       switch (kind) {
> +                       case BTF_KIND_STRUCT:
> +                               err =3D btf__add_fwd(dist->pipe.dst, name=
, BTF_FWD_STRUCT);
> +                               break;
> +                       case BTF_KIND_UNION:
> +                               err =3D btf__add_fwd(dist->pipe.dst, name=
, BTF_FWD_UNION);
> +                               break;
> +                       case BTF_KIND_ENUM:
> +                               err =3D btf__add_enum(dist->pipe.dst, nam=
e, t->size);
> +                               break;
> +                       case BTF_KIND_ENUM64:

nit: combine ENUM/ENUM64 cases?

> +                               err =3D btf__add_enum(dist->pipe.dst, nam=
e, t->size);
> +                               break;
> +                       default:
> +                               pr_warn("unexpected kind [%u] when creati=
ng distilled base BTF.\n",
> +                                       btf_kind(t));
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       err =3D btf_add_type(&dist->pipe, t);

So this should never happen if adding_to_base =3D=3D true, is that right?
Can we check this? Or am I missing something as usual?

> +               }
> +               if (err < 0)
> +                       break;
> +               dist->ids[i] =3D id++;
> +       }
> +       return err;
> +}
> +

[...]

> +       n =3D btf__type_cnt(new_split);
> +       /* Now update base/split BTF ids. */
> +       for (i =3D 1; i < n; i++) {
> +               t =3D btf_type_by_id(new_split, i);
> +
> +               err =3D btf_type_visit_type_ids(t, btf_update_distilled_t=
ype_ids, &dist);
> +               if (err < 0)
> +                       goto err_out;
> +       }
> +       free(dist.ids);
> +       hashmap__free(dist.pipe.str_off_map);
> +       *new_base_btf =3D new_base;
> +       *new_split_btf =3D new_split;
> +       return 0;
> +err_out:
> +       free(dist.ids);
> +       if (!IS_ERR(dist.pipe.str_off_map))

you don't need to check this, hashmap__free() works for IS_ERR()
pointers as well

> +               hashmap__free(dist.pipe.str_off_map);
> +       btf__free(new_split);
> +       btf__free(new_base);
> +       return libbpf_err(err);
> +}

[...]

