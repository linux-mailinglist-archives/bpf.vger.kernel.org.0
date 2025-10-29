Return-Path: <bpf+bounces-72682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D4C18458
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 06:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88075189060F
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 05:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62152F5A31;
	Wed, 29 Oct 2025 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIlxOBWP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A3286D7E
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761714276; cv=none; b=q0vSULYYcqO6XaR/UtX0MLhfWtIQC7gtHIFC59u4HxscFhg9vZqTbifLusvzogVsazgDndrOdZRV46HHFYm58TrTef5Fhv/Ew/PlnRLNbpQ3dKPmJvQhU7Xv3Wc/igZ6vuTVI1F8nXx3OSgURED+zJNQAB85+KTN/jSuOt8JSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761714276; c=relaxed/simple;
	bh=uUMjKQd1nrUi8O/tjDJIsP49/XT1Fe5H5AwXoJVbfjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBLQ8VaeIyhfojuTtVBgRjUNb8tGm872c2xLVo5mwFG15c3GOIDFB0s0jjFOm407LAGiWVDH9yv8YlQNVSLeWpjL0DagGno0YnBakh1/mnh2o6GcyHgBZXzs9V1OaOHKomNqksZRlKrXG6SrBehWNIkH5ceFPLpFG0mSbcvMtMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIlxOBWP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b70406feed3so83429466b.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 22:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761714272; x=1762319072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgfDUzdG5W6T8jK17/beJCx0BfwfHWG0x2BFbH1rXQA=;
        b=IIlxOBWPIC3uF3werTbV6j1JiPNv6t+HMPQkcoC9BZ4AhGeOSv6KOuLuiAb9ZUh1+M
         eqedQW5vu2u07Een26vSfEZCnTHI+LF/nkkRwDG1yXsgDPvpRdniEu+Dhw22y2tAgqp/
         CxUf3rHlQ58pMBwQxMHvtAn7qJucShQdRBkEnCigS9hX4VQBfmF6y75elS74ZSy2TR1k
         kuCxu867l0gNbj64VIA223ZGf+Pfki2LprFUPpnzS7Mfs3i+z5s4j+6bSGkyUD9LGwS/
         v9cHajMnv4zmGguZgCQjRWmbpf7RuFRS9bYJWljvsgPDyeQo+4ccHRdKWRX45SlfwdYi
         piPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761714272; x=1762319072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgfDUzdG5W6T8jK17/beJCx0BfwfHWG0x2BFbH1rXQA=;
        b=YmKHvhsT43rjAVi3oHpU9/8rZhxmPfxdWC0YYU/jD54mZyMfBO6KVr8ufEXkFCZkTk
         3nedOECMFKNItVd0Rvb+BJw1XQoPJPvDQIfIirx9EKkQY2AIeUgh92mJEMiuyVoemHMW
         tzgJyEstqOuA3Pf4/vss3T3zeAc2Rx97MAHqfMd0pTMTCJNyGw8taiy1cUg97KavGLDM
         Hx5TSM6HpWD2g/gW2RnD9mLV2hyEi+8jKs+oDueOZ8N5QRK5XRysJ18rOGqSp9zd8PLj
         CIAJxtRtaOJ6jhEb1FVO76EFDdrT+p3lH3maPRYF2SYCEWS/cDS0mu0XPsA+ipYwM3Fb
         6cJg==
X-Forwarded-Encrypted: i=1; AJvYcCWKu/oS1uSKS6vItuTG/TVRxcnRWIDh/GXIXdTC4tEJ2Vg1CAbkKmCLoxDGv7zliS9kDYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTNdHXLopovRGjLgutbUdU5AIKmOMh/0i11oCd0r7u7EM9f3+
	BaPtUA0pV1+eEqTScGXAOWuwXbU7Aan1WqlievkJlMvQtkI8hFuKTHL9WVTD+z4VLP4938E9OYu
	6ref0G6NwiLdzM8yH5OuzaMM0uhkjPDo=
X-Gm-Gg: ASbGnctE4n1cszAJHOAeSYz8Rjs539fb2tKm68XjRHniPEP7WHqWcr5wB7E0ygukqjU
	0fT+J/+ssyUKWJS/yW3x0ygmqsreRaRdHdiG9EhHkDRdXWnRizRJR8frRwAKjlkhTuu4iaGbIUa
	JA0id6hD7tBa5xCY5+5e2SjMffoAKthnD2M8jT52KgkIfYLRtE7wP3ub0v/ssnIjTP6n01epifR
	TvlD36A+nxVPF3w5ghGadkNTClj8K/sgWNBjWIJi5wCMI3dUzXpalHXxteQ2g==
X-Google-Smtp-Source: AGHT+IGtf2mvPt1zHXOCTQN2kA6uPHYPIk/PSDkri1uGTVEGlimrmvlhMVnvFMqkX4sof8I3CnxNW3z7Fhubf5cXBJk=
X-Received: by 2002:a05:6402:2347:b0:63b:ed9c:dd0e with SMTP id
 4fb4d7f45d1cf-64044380ee1mr1085214a12.33.1761714272173; Tue, 28 Oct 2025
 22:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-2-dolinux.peng@gmail.com> <CAEf4BzZXVARn5_-3eMmPupU-gun7p3VX-VuCVOuHBC0o0L-Pjg@mail.gmail.com>
In-Reply-To: <CAEf4BzZXVARn5_-3eMmPupU-gun7p3VX-VuCVOuHBC0o0L-Pjg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 29 Oct 2025 13:04:20 +0800
X-Gm-Features: AWmQ_bk235WkiUHpG6Ys6yUj08lpcXzcjhrRTYwKLTDr-3l7gRegbj6yb63Y_nE
Message-ID: <CAErzpms3cyc0urFkZ3dPYR9UwL=3393qLh0PTZvcGhF2GXSrww@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] btf: implement BTF type sorting for
 accelerated lookups
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > This patch introduces a new libbpf interface btf__permute() to reorgani=
ze
> > BTF types according to a provided mapping. The BTF lookup mechanism is
> > enhanced with binary search capability, significantly improving lookup
> > performance for large type sets.
> >
> > The pahole tool can invoke this interface with a sorted type ID array,
> > enabling binary search in both user space and kernel. To share core log=
ic
> > between kernel and libbpf, common sorting functionality is implemented
> > in a new btf_sort.c source file.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> > v2->v3:
> > - Remove sorting logic from libbpf and provide a generic btf__permute()=
 interface
> > - Remove the search direction patch since sorted lookup provides suffic=
ient performance
> >   and changing search order could cause conflicts between BTF and base =
BTF
> > - Include btf_sort.c directly in btf.c to reduce function call overhead
> > ---
> >  tools/lib/bpf/btf.c            | 262 ++++++++++++++++++++++++++++++---
> >  tools/lib/bpf/btf.h            |  17 +++
> >  tools/lib/bpf/btf_sort.c       | 174 ++++++++++++++++++++++
> >  tools/lib/bpf/btf_sort.h       |  11 ++
> >  tools/lib/bpf/libbpf.map       |   6 +
> >  tools/lib/bpf/libbpf_version.h |   2 +-
> >  6 files changed, 447 insertions(+), 25 deletions(-)
> >  create mode 100644 tools/lib/bpf/btf_sort.c
> >  create mode 100644 tools/lib/bpf/btf_sort.h
> >
>
> This looks a bit over-engineered, let's try to simplify and have more
> succinct implementation

Thanks, I will simplify it.

>
> pw-bot: cr
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 18907f0fcf9f..d20bf81a21ce 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -23,6 +23,7 @@
> >  #include "libbpf_internal.h"
> >  #include "hashmap.h"
> >  #include "strset.h"
> > +#include "btf_sort.h"
> >
> >  #define BTF_MAX_NR_TYPES 0x7fffffffU
> >  #define BTF_MAX_STR_OFFSET 0x7fffffffU
> > @@ -92,6 +93,12 @@ struct btf {
> >          *   - for split BTF counts number of types added on top of bas=
e BTF.
> >          */
> >         __u32 nr_types;
> > +       /* number of sorted and named types in this BTF instance:
> > +        *   - doesn't include special [0] void type;
> > +        *   - for split BTF counts number of sorted and named types ad=
ded on
> > +        *     top of base BTF.
> > +        */
> > +       __u32 nr_sorted_types;
> >         /* if not NULL, points to the base BTF on top of which the curr=
ent
> >          * split BTF is based
> >          */
> > @@ -624,6 +631,11 @@ const struct btf *btf__base_btf(const struct btf *=
btf)
> >         return btf->base_btf;
> >  }
> >
> > +__u32 btf__start_id(const struct btf *btf)
> > +{
> > +       return btf->start_id;
> > +}
>
> this can already be determined using btf__base_btf() (and then getting
> its btf__type_cnt()), but I guess I don't mind having a small

Yes, you're right. The calculation is sufficient:
- If base_btf is NULL, start_id =3D 1
- If base_btf is not NULL, start_id =3D btf__type_cnt(base_btf)

> dedicated API for this. But please add it as a separate patch
>
> > +
> >  /* internal helper returning non-const pointer to a type */
> >  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
> >  {
> > @@ -915,38 +927,16 @@ __s32 btf__find_by_name(const struct btf *btf, co=
nst char *type_name)
> >         return libbpf_err(-ENOENT);
> >  }
> >
> > -static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id=
,
> > -                                  const char *type_name, __u32 kind)
> > -{
> > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > -
> > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > -               return 0;
> > -
> > -       for (i =3D start_id; i < nr_types; i++) {
> > -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -               const char *name;
> > -
> > -               if (btf_kind(t) !=3D kind)
> > -                       continue;
> > -               name =3D btf__name_by_offset(btf, t->name_off);
> > -               if (name && !strcmp(type_name, name))
> > -                       return i;
> > -       }
> > -
> > -       return libbpf_err(-ENOENT);
> > -}
> > -
> >  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *ty=
pe_name,
> >                                  __u32 kind)
> >  {
> > -       return btf_find_by_name_kind(btf, btf->start_id, type_name, kin=
d);
> > +       return _btf_find_by_name_kind(btf, btf->start_id, type_name, ki=
nd);
> >  }
> >
> >  __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_n=
ame,
> >                              __u32 kind)
> >  {
> > -       return btf_find_by_name_kind(btf, 1, type_name, kind);
> > +       return _btf_find_by_name_kind(btf, 1, type_name, kind);
>
> nit: please avoid using underscore-prefixed names

Thanks. I will fix it in the next version.

>
> >  }
> >
> >  static bool btf_is_modifiable(const struct btf *btf)
> > @@ -1091,6 +1081,7 @@ static struct btf *btf_new(const void *data, __u3=
2 size, struct btf *base_btf, b
> >         err =3D err ?: btf_sanity_check(btf);
> >         if (err)
> >                 goto done;
> > +       btf_check_sorted(btf, btf->start_id);
>
> let's do this lazily when we actually need to search by name, that
> will also work better with invalidation (currently you don't recheck
> sortedness after invalidation)

Thanks. I'll defer the call to btf_check_sorted until the first invocation =
of
btf__find_by_name_kind.

>
> [...]
>
> > +/*
> > + * Permute BTF types in-place using the ID mapping from btf_permute_op=
ts->ids.
> > + * After permutation, all type ID references are updated to reflect th=
e new
> > + * ordering. If a struct btf_ext (representing '.BTF.ext' section) is =
provided,
> > + * type ID references within the BTF extension data are also updated.
> > + */
>
> See how we provide doc comment for public APIs and do the same with btf__=
permute

Thanks, I will fix it in the next version.

>
> > +int btf__permute(struct btf *btf, const struct btf_permute_opts *opts)
>
> id map array is mandatory parameter which will always be specified,
> make it a fixed argument. We use opts for something that's optional
> and/or infrequently used. btf_ext being part of opts makes total
> sense, though.

Thanks, I will fix it in the next version, like:

int btf__permute(struct btf *btf, __u32 *id_map, const struct
btf_permute_opts *opts)

>
> > +{
> > +       struct btf_permute *p;
> > +       int err =3D 0;
> > +
> > +       if (!OPTS_VALID(opts, btf_permute_opts))
> > +               return libbpf_err(-EINVAL);
> > +
> > +       p =3D btf_permute_new(btf, opts);
> > +       if (!p) {
> > +               pr_debug("btf_permute_new failed: %ld\n", PTR_ERR(p));
> > +               return libbpf_err(-EINVAL);
> > +       }
> > +
> > +       if (btf_ensure_modifiable(btf)) {
> > +               err =3D -ENOMEM;
> > +               goto done;
> > +       }
> > +
> > +       err =3D btf_permute_shuffle_types(p);
> > +       if (err < 0) {
> > +               pr_debug("btf_permute_shuffle_types failed: %s\n", errs=
tr(err));
> > +               goto done;
> > +       }
> > +       err =3D btf_permute_remap_types(p);
>
> can't we remap IDs as we shuffle and move types around? I'm not sure

This approach appears infeasible, as it necessitates first generating a
complete type ID mapping (similar to btf_dedup's hypot_map) to translate
original IDs to new IDs for all referenced types, followed by executing the
remapping phase.

> we need entire struct btf_permute to keep track of all of this, this
> can be a local state in a single function

Thank you. I think that a btf_permute function may be necessary. As Eduard
suggested, we can generalize btf_dedup_remap_types into a reusable function=
,
which would require a dedicated structure to encapsulate all necessary
parameters.

>
> > +       if (err) {
> > +               pr_debug("btf_permute_remap_types failed: %s\n", errstr=
(err));
> > +               goto done;
> > +       }
> > +
> > +done:
> > +       btf_permute_free(p);
> > +       return libbpf_err(err);
> > +}
> > +
>
> [...]
>
> > +/*
> > + * Shuffle BTF types.
> > + *
> > + * Rearranges types according to the permutation map in p->ids. The p-=
>map
> > + * array stores the mapping from original type IDs to new shuffled IDs=
,
> > + * which is used in the next phase to update type references.
> > + */
> > +static int btf_permute_shuffle_types(struct btf_permute *p)
> > +{
> > +       struct btf *btf =3D p->btf;
> > +       const struct btf_type *t;
> > +       __u32 *new_offs =3D NULL;
> > +       void *l, *new_types =3D NULL;
> > +       int i, id, len, err;
> > +
> > +       new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
> > +       new_types =3D calloc(btf->hdr->type_len, 1);
> > +       if (!new_types || !new_offs) {
> > +               err =3D -ENOMEM;
> > +               goto out_err;
> > +       }
> > +
> > +       l =3D new_types;
>
> What does "l" refer to in this name? It rings no bells for me...

Would the name "nt" be acceptable?

>
> > +       for (i =3D 0; i < btf->nr_types; i++) {
>
> this won't work with split BTF, no?

The `ids` array in `btf_permute` stores type IDs for split BTF.
Local testing confirms that kernel module BTF is properly
pre-sorted during build using a patched pahole version.

Example usage in pahole:

static int btf_encoder__sort(struct btf *btf)
{
       LIBBPF_OPTS(btf_permute_opts, opts);
       int start_id =3D btf__start_id(btf);
       int nr_types =3D btf__type_cnt(btf) - start_id;
       __u32 *permute_ids;
       int i, id, err =3D 0;

       if (nr_types < 2)
               return 0;

       permute_ids =3D calloc(nr_types, sizeof(*permute_ids));
       if (!permute_ids) {
               err =3D -ENOMEM;
               goto out_free;
       }

       for (i =3D 0, id =3D start_id; i < nr_types; i++, id++)
               permute_ids[i] =3D id;

       qsort_r(permute_ids, nr_types, sizeof(*permute_ids),
               cmp_types_kinds_names, btf);

       opts.ids =3D permute_ids;
       err =3D btf__permute(btf, &opts);
       if (err)
               goto out_free;

out_free:
       if (permute_ids)
               free(permute_ids);
       return err;
}

>
> > +               id =3D p->ids[i];
> > +               t =3D btf__type_by_id(btf, id);
> > +               len =3D btf_type_size(t);
> > +               memcpy(l, t, len);
> > +               new_offs[i] =3D l - new_types;
> > +               p->map[id - btf->start_id] =3D btf->start_id + i;
> > +               l +=3D len;
> > +       }
> > +
> > +       free(btf->types_data);
> > +       free(btf->type_offs);
> > +       btf->types_data =3D new_types;
> > +       btf->type_offs =3D new_offs;
> > +       return 0;
> > +
>
> [...]
>
> > diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> > new file mode 100644
> > index 000000000000..553c5f5e61bd
> > --- /dev/null
> > +++ b/tools/lib/bpf/btf_sort.c
>
> why does this have to be a separate file? can't it be part of btf.c?

Thanks. The kernel can leverage existing common infrastructure, similar to
the approach used in bpf_relocate.c. If this shared approach isn't acceptab=
le,
I'm prepared to implement separate versions for both libbpf and the kernel.

https://lore.kernel.org/all/34a168e2-204d-47e2-9923-82d8ad645273@oracle.com=
/#t
https://lore.kernel.org/all/7f770a27-6ca6-463f-9145-5c795e0b3f40@oracle.com=
/

>
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +/* Copyright (c) 2025 Xiaomi */
> > +
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#ifdef __KERNEL__
> > +
> > +#define btf_type_by_id                         (struct btf_type *)btf_=
type_by_id
> > +#define btf__str_by_offset                     btf_str_by_offset
> > +#define btf__type_cnt                          btf_nr_types
> > +#define btf__start_id                          btf_start_id
> > +#define libbpf_err(x)                          x
> > +
> > +#else
> > +
> > +#define notrace
> > +
> > +#endif /* __KERNEL__ */
> > +
> > +/*
> > + * Skip the sorted check if the number of BTF types is below this thre=
shold.
> > + * The value 4 is chosen based on the theoretical break-even point whe=
re
> > + * linear search (N/2) and binary search (LOG2(N)) require approximate=
ly
> > + * the same number of comparisons.
> > + */
> > +#define BTF_CHECK_SORT_THRESHOLD  4
>
> I agree with Eduard, it seems like an overkill. For small BTFs this
> all doesn't matter anyways.

Thanks, I will remove it in the next  version.

>
> > +
> > +struct btf;
> > +
> > +static int cmp_btf_kind_name(int ka, const char *na, int kb, const cha=
r *nb)
> > +{
> > +       return (ka - kb) ?: strcmp(na, nb);
> > +}
> > +
> > +/*
> > + * Sort BTF types by kind and name in ascending order, placing named t=
ypes
> > + * before anonymous ones.
> > + */
> > +static int btf_compare_type_kinds_names(const void *a, const void *b, =
void *priv)
> > +{
> > +       struct btf *btf =3D (struct btf *)priv;
> > +       struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > +       struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > +       const char *na, *nb;
> > +       bool anon_a, anon_b;
> > +       int ka, kb;
> > +
> > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > +       anon_a =3D str_is_empty(na);
> > +       anon_b =3D str_is_empty(nb);
> > +
> > +       /* ta w/o name is greater than tb */
> > +       if (anon_a && !anon_b)
> > +               return 1;
> > +       /* tb w/o name is smaller than ta */
> > +       if (!anon_a && anon_b)
> > +               return -1;
> > +
> > +       ka =3D btf_kind(ta);
> > +       kb =3D btf_kind(tb);
> > +
> > +       if (anon_a && anon_b)
> > +               return ka - kb;
> > +
> > +       return cmp_btf_kind_name(ka, na, kb, nb);
> > +}
>
> I think we should keep it simple and only use sorted-by-name property.
> Within the same name, we can just search linearly for necessary kind.

This approach is feasible, though it may introduce some overhead in the sea=
rch
function. I previously implemented a hybrid method that first sorts
types by name
and then combines binary search with linear search for handling collisions.

https://lore.kernel.org/all/20240608140835.965949-1-dolinux.peng@gmail.com/

id =3D btf_find_by_name_bsearch(btf, name, &start, &end);
if (id > 0) {
    while (start <=3D end) {
        t =3D btf_type_by_id(btf, start);
        if (BTF_INFO_KIND(t->info) =3D=3D kind)
            return start;
        start++;
        }
}

Could this be acceptable?

>
> > +
> > +static __s32 notrace __btf_find_by_name_kind(const struct btf *btf, in=
t start_id,
> > +                                  const char *type_name, __u32 kind)
> > +{
> > +       const struct btf_type *t;
> > +       const char *tname;
> > +       int err =3D -ENOENT;
> > +
> > +       if (!btf)
> > +               goto out;
> > +
> > +       if (start_id < btf__start_id(btf)) {
> > +               err =3D __btf_find_by_name_kind(btf->base_btf, start_id=
, type_name, kind);
> > +               if (err =3D=3D -ENOENT)
> > +                       start_id =3D btf__start_id(btf);
> > +       }
> > +
> > +       if (err =3D=3D -ENOENT) {
> > +               if (btf->nr_sorted_types) {
> > +                       /* binary search */
> > +                       __s32 start, end, mid, found =3D -1;
> > +                       int ret;
> > +
> > +                       start =3D start_id;
> > +                       end =3D start + btf->nr_sorted_types - 1;
> > +                       /* found the leftmost btf_type that matches */
> > +                       while(start <=3D end) {
> > +                               mid =3D start + (end - start) / 2;
>
> nit: binary search is, IMO, where succinct names like "l", "r", "m"
> are good and actually help keeping algorithm code more succinct
> without making it more obscure

Thanks, I will fix it in the next version.

>
> > +                               t =3D btf_type_by_id(btf, mid);
> > +                               tname =3D btf__str_by_offset(btf, t->na=
me_off);
> > +                               ret =3D cmp_btf_kind_name(BTF_INFO_KIND=
(t->info), tname,
> > +                                                       kind, type_name=
);
> > +                               if (ret < 0)
> > +                                       start =3D mid + 1;
> > +                               else {
> > +                                       if (ret =3D=3D 0)
> > +                                               found =3D mid;
> > +                                       end =3D mid - 1;
> > +                               }
> > +                       }
> > +
> > +                       if (found !=3D -1)
> > +                               return found;
>
> please check find_linfo() in kernel/bpf/log.c for a very succinct
> implementation of binary search where we look not for exact match, but
> rather leftmost or rightmost element satisfying some condition.
> find_linfo() is actually looking for leftmost element (despite what
> comment says :) ), so I think can be followed very closely.

Thank you for the suggestion. If we sort types solely by name as proposed,
we would need to first identify the leftmost and rightmost bounds of the
matching name range (similar to find_linfo's approach), then perform a
linear search within that range to find the first type with a matching kind=
.

>
> > +               } else {
> > +                       /* linear search */
> > +                       __u32 i, total;
> > +
> > +                       total =3D btf__type_cnt(btf);
> > +                       for (i =3D start_id; i < total; i++) {
> > +                               t =3D btf_type_by_id(btf, i);
> > +                               if (btf_kind(t) !=3D kind)
> > +                                       continue;
> > +
> > +                               tname =3D btf__str_by_offset(btf, t->na=
me_off);
> > +                               if (tname && !strcmp(tname, type_name))
> > +                                       return i;
> > +                       }
> > +               }
> > +       }
> > +
>
> [...]

