Return-Path: <bpf+bounces-43562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E09B6712
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF95E281984
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFD2139B1;
	Wed, 30 Oct 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKj/TqcA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CED1F4737;
	Wed, 30 Oct 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301194; cv=none; b=aHE7bib3imqG0pZl5JAzaUrAyRYz6HXQQOKdi8GO1w2/MGUI3jBArEujs9acVVt6Xzshjci38XchM1ghhN7Vvs6Jw8h5X34cLQMveaoxSG9AFMct2zo/URGppWti1DwnNR5g4pb6P1yqAXGhhThrz4QDKquIBof979mnCgiQQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301194; c=relaxed/simple;
	bh=/EXAojOsMFDxFHGVCb9V9dr13qlVFq842UaVIepIFgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5dvE8bTHChc33QSm894fTwqZSkuVcdVSeotKRMB8NMiZG60sinbtcmry+jqn2HpKogzYon2P+Vk5NgJ4DnpuZzZJGL9rr0inaSz5Azd2ssiy0GySd8E+jlI45E/L4vBJQnHYa24xoY+KqPZrfhjVTllLCOHxm3rAGQl3XVbjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKj/TqcA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0472306cso936641666b.3;
        Wed, 30 Oct 2024 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730301188; x=1730905988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wZ/3rIgc0PMl9M8+kiyq2kg47wkj2TCg61zPukoFaE=;
        b=fKj/TqcA9dIZBgSJW8/NpHbko4AGXUQKEl5COEyO17UW6HQH7DVc1DCSKuOljdWSNS
         B/oqrcSYbHq7FG6J/cBgqB7DAS/vVCWpG3TzdVSu0m/iJtc755mwTW75VVYhU4XO0NYs
         yEoQc3dWALGIyrPZ1TZtF8ImV06Jo4b2AW58iktvYEgJx7kGa6RNiLotuUmAyPzNVqiy
         ELsyS3IwwKT5SbuDuHrZ6kRGXfsJ8brJ8QD57ppXKzM0859VNNTPr4DWT02M5yA+K9Yc
         45XGxJn1ozVZiC/8n0C0oUJ+w5S5SBluxjZX0vvdTca7Wm5ScFUO/MBZA7byieRLuXg1
         wU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301188; x=1730905988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wZ/3rIgc0PMl9M8+kiyq2kg47wkj2TCg61zPukoFaE=;
        b=wmmXHOJ69If6aAbvY1S2SLD13fpn2WfU1SgK05KT/kktAGN3WQNwJjj97h4d4JlzQO
         eCDgGs1TF1um08XmL/k6Fk1FqbB+0mmHzftSZBk+FZFYmzvsBL792lZOCghndGFqsQ3n
         b4ZhrHsI4ESanZhlccqW/euFNeB63IImVhB8Estl/qBVCbTJOwNZt42OLNKQ8K3wLZGT
         KJyPKsyIAJB7k44uZn996g9vnFVec9NsYioyHEXg8fPLD1P+DQ2o4kDqer9ctq5ZMAFi
         oNjniHoQ6cvh5MC1Iw8EPjsYQChuwLdbSV+DxF1exVsi9YL8F1n9X6j1OJmKq0NGGMae
         2ziQ==
X-Forwarded-Encrypted: i=1; AJvYcCUus340N0OSCXBZ6jaTNRU/qWYreVh+gRZ9oXSh49XLdGeDG+Pyiwx7FY2Pd/EUt8PaITRBeWzx70wtXKEulvx3TQUC@vger.kernel.org, AJvYcCV0D8zP59US5bC8ToI+SPxBOZbrce+5/mtTTRRRKBoSSfKVtRQDSi4pmE8IR9RJdWMYG3uNBi2Jd9HOCn+tVCz5@vger.kernel.org, AJvYcCVL3Davkaj8IBM+LXp88gz48nYpuIlmIeep15YluxyhpJp59ZY6at+1uIhzcf/UZQwObn4P2RPd1WZGhgHw@vger.kernel.org, AJvYcCXfhMtDWTYA1hUeiGyPG3TFx2wQBoOMr91houD4NvzbXJ1T+dl/vnrW6IaiUBiV3VxIsis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw6WAq9Jjkh1XUHta3G5RZlEHSgoeDoyG9dHxfPrT9LVyB8kYc
	XpOdngGd9mRV0m1VSCNJ/aAefKqOxRK8x6PNLI5zFu9XElymCjYCt9StTXLhCKVkwyFXk87lgpk
	pguaMtyyHaDeifpR6JQN+J1IY6JBOMMxGO/4=
X-Google-Smtp-Source: AGHT+IExSwvzpH3UJEGvMMF0eVClqGUl9tjdHwJYj/Q6xYoipsn3UsNXXAm9m4Rvk63/xxxzi3p8yz1TbfpstcQHOKc=
X-Received: by 2002:a17:907:9608:b0:a9a:835:b4eb with SMTP id
 a640c23a62f3a-a9de5fa6071mr1427036066b.38.1730301187484; Wed, 30 Oct 2024
 08:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002208.1947947-1-dolinux.peng@gmail.com>
 <20241029002208.1947947-2-dolinux.peng@gmail.com> <CAEf4BzbVjkhtQPcsDOLX_aR_vvB1nCQj357EQ5xwey8486=Niw@mail.gmail.com>
In-Reply-To: <CAEf4BzbVjkhtQPcsDOLX_aR_vvB1nCQj357EQ5xwey8486=Niw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 30 Oct 2024 23:12:55 +0800
Message-ID: <CAErzpmuHJ-qZqzS11GPK5_=UsuxtPk1gbexbhJ7nj59M-NzSHA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] libbpf: Sort btf_types in ascending order by name
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:58=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 28, 2024 at 5:22=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > To enhance the searching performance of btf_find_by_name_kind, we
> > can sort the btf_types in ascending order based on their names.
> > This allows us to implement a binary search method.
> >
> > Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> > v4:
> >  - Divide the patch into two parts: kernel and libbpf
> >  - Use Eduard's code to sort btf_types in the btf__dedup function
> >  - Correct some btf testcases due to modifications of the order of btf_=
types.
> > ---
> >  tools/lib/bpf/btf.c                           | 115 +++++--
> >  tools/testing/selftests/bpf/prog_tests/btf.c  | 296 +++++++++---------
> >  .../bpf/prog_tests/btf_dedup_split.c          |  64 ++--
> >  3 files changed, 268 insertions(+), 207 deletions(-)
> >
>
> I don't think we should do any extra sorting by default. Maybe we need
> some extra API to explicitly re-sort underlying types. But then again,

How do you feel about adding a new feature to the '--btf_features' option,
which could be used to control sorting?

> why just by type name? What if type names are equal, what do we use to
> disambiguate. None of this is considered in this patch.

If there are multiple btf_types with identical names in a btf file,
they will have different kinds. These btf_types will be grouped
together after being sorted according to their names. We can
determine the range of the group and verify the btf_types within
that range by their kind to obtain the appropriate btf_type.

>
> pw-bot: cr
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 3c131039c523..5290e9d59997 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1,6 +1,9 @@
> >  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  /* Copyright (c) 2018 Facebook */
> >
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> >  #include <byteswap.h>
> >  #include <endian.h>
> >  #include <stdio.h>
> > @@ -4902,6 +4905,49 @@ static int btf_dedup_resolve_fwds(struct btf_ded=
up *d)
> >         return err;
> >  }
> >
> > +/* compare btf types by name, consider named < anonymous */
> > +static int btf_compare_type_names(const void *a, const void *b, void *=
priv)
> > +{
> > +       struct btf *btf =3D (struct btf *)priv;
> > +       struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > +       struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > +       const char *na, *nb;
> > +
> > +       /* ta w/o name is greater than tb */
> > +       if (!ta->name_off && tb->name_off)
> > +               return 1;
> > +       /* tb w/o name is smaller than ta */
> > +       if (ta->name_off && !tb->name_off)
> > +               return -1;
> > +
> > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > +       return strcmp(na, nb);
> > +}
> > +
> > +static __u32 *get_sorted_canon_types(struct btf_dedup *d, __u32 *cnt)
> > +{
> > +       int i, j, id, types_cnt =3D 0;
> > +       __u32 *sorted_ids;
> > +
> > +       for (i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_types; i+=
+, id++)
> > +               if (d->map[id] =3D=3D id)
> > +                       ++types_cnt;
> > +
> > +       sorted_ids =3D calloc(types_cnt, sizeof(*sorted_ids));
> > +       if (!sorted_ids)
> > +               return NULL;
> > +
> > +       for (j =3D 0, i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_=
types; i++, id++)
> > +               if (d->map[id] =3D=3D id)
> > +                       sorted_ids[j++] =3D id;
> > +       qsort_r(sorted_ids, types_cnt, sizeof(*sorted_ids),
> > +               btf_compare_type_names, d->btf);
> > +       *cnt =3D types_cnt;
> > +
> > +       return sorted_ids;
> > +}
> > +
> >  /*
> >   * Compact types.
> >   *
> > @@ -4915,11 +4961,11 @@ static int btf_dedup_resolve_fwds(struct btf_de=
dup *d)
> >   */
> >  static int btf_dedup_compact_types(struct btf_dedup *d)
> >  {
> > -       __u32 *new_offs;
> > -       __u32 next_type_id =3D d->btf->start_id;
> > +       __u32 canon_types_cnt =3D 0, canon_types_len =3D 0;
> > +       __u32 *new_offs =3D NULL, *canon_types =3D NULL;
> >         const struct btf_type *t;
> > -       void *p;
> > -       int i, id, len;
> > +       void *p, *new_types =3D NULL;
> > +       int i, id, len, err;
> >
> >         /* we are going to reuse hypot_map to store compaction remappin=
g */
> >         d->hypot_map[0] =3D 0;
> > @@ -4929,36 +4975,61 @@ static int btf_dedup_compact_types(struct btf_d=
edup *d)
> >         for (i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_types; i+=
+, id++)
> >                 d->hypot_map[id] =3D BTF_UNPROCESSED_ID;
> >
> > -       p =3D d->btf->types_data;
> > -
> > -       for (i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_types; i+=
+, id++) {
> > -               if (d->map[id] !=3D id)
> > -                       continue;
> > +       canon_types =3D get_sorted_canon_types(d, &canon_types_cnt);
> > +       if (!canon_types) {
> > +               err =3D -ENOMEM;
> > +               goto out_err;
> > +       }
> >
> > +       for (i =3D 0; i < canon_types_cnt; i++) {
> > +               id =3D canon_types[i];
> >                 t =3D btf__type_by_id(d->btf, id);
> >                 len =3D btf_type_size(t);
> > -               if (len < 0)
> > -                       return len;
> > +               if (len < 0) {
> > +                       err =3D len;
> > +                       goto out_err;
> > +               }
> > +               canon_types_len +=3D len;
> > +       }
> > +
> > +       new_offs =3D calloc(canon_types_cnt, sizeof(*new_offs));
> > +       new_types =3D calloc(canon_types_len, 1);
> > +       if (!new_types || !new_offs) {
> > +               err =3D -ENOMEM;
> > +               goto out_err;
> > +       }
> >
> > -               memmove(p, t, len);
> > -               d->hypot_map[id] =3D next_type_id;
> > -               d->btf->type_offs[next_type_id - d->btf->start_id] =3D =
p - d->btf->types_data;
> > +       p =3D new_types;
> > +
> > +       for (i =3D 0; i < canon_types_cnt; i++) {
> > +               id =3D canon_types[i];
> > +               t =3D btf__type_by_id(d->btf, id);
> > +               len =3D btf_type_size(t);
> > +               memcpy(p, t, len);
> > +               d->hypot_map[id] =3D d->btf->start_id + i;
> > +               new_offs[i] =3D p - new_types;
> >                 p +=3D len;
> > -               next_type_id++;
> >         }
> >
> >         /* shrink struct btf's internal types index and update btf_head=
er */
> > -       d->btf->nr_types =3D next_type_id - d->btf->start_id;
> > -       d->btf->type_offs_cap =3D d->btf->nr_types;
> > -       d->btf->hdr->type_len =3D p - d->btf->types_data;
> > -       new_offs =3D libbpf_reallocarray(d->btf->type_offs, d->btf->typ=
e_offs_cap,
> > -                                      sizeof(*new_offs));
> > -       if (d->btf->type_offs_cap && !new_offs)
> > -               return -ENOMEM;
> > +       free(d->btf->types_data);
> > +       free(d->btf->type_offs);
> > +       d->btf->types_data =3D new_types;
> >         d->btf->type_offs =3D new_offs;
> > +       d->btf->types_data_cap =3D canon_types_len;
> > +       d->btf->type_offs_cap =3D canon_types_cnt;
> > +       d->btf->nr_types =3D canon_types_cnt;
> > +       d->btf->hdr->type_len =3D canon_types_len;
> >         d->btf->hdr->str_off =3D d->btf->hdr->type_len;
> >         d->btf->raw_size =3D d->btf->hdr->hdr_len + d->btf->hdr->type_l=
en + d->btf->hdr->str_len;
> > +       free(canon_types);
> >         return 0;
> > +
> > +out_err:
> > +       free(canon_types);
> > +       free(new_types);
> > +       free(new_offs);
> > +       return err;
> >  }
> >
> >  /*
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testi=
ng/selftests/bpf/prog_tests/btf.c
> > index e63d74ce046f..4dc1e2bfacbb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> > @@ -7025,26 +7025,26 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),            =
                 /* [1] */
> >                         /* int */
> > -                       BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0=
, 32, 4),        /* [1] */
> > -                       /* int[16] */
> > -                       BTF_TYPE_ARRAY_ENC(1, 1, 16),                  =
                 /* [2] */
> > +                       BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0=
, 32, 4),        /* [2] */
> >                         /* struct s { */
> >                         BTF_STRUCT_ENC(NAME_NTH(8), 5, 88),            =
                 /* [3] */
> > -                               BTF_MEMBER_ENC(NAME_NTH(7), 4, 0),     =
 /* struct s *next;      */
> > -                               BTF_MEMBER_ENC(NAME_NTH(1), 5, 64),    =
 /* const int *a;        */
> > -                               BTF_MEMBER_ENC(NAME_NTH(2), 2, 128),   =
 /* int b[16];           */
> > -                               BTF_MEMBER_ENC(NAME_NTH(3), 1, 640),   =
 /* int c;               */
> > -                               BTF_MEMBER_ENC(NAME_NTH(4), 9, 672),   =
 /* float d;             */
> > +                               BTF_MEMBER_ENC(NAME_NTH(7), 7, 0),     =
 /* struct s *next;      */
> > +                               BTF_MEMBER_ENC(NAME_NTH(1), 8, 64),    =
 /* const int *a;        */
> > +                               BTF_MEMBER_ENC(NAME_NTH(2), 6, 128),   =
 /* int b[16];           */
> > +                               BTF_MEMBER_ENC(NAME_NTH(3), 2, 640),   =
 /* int c;               */
> > +                               BTF_MEMBER_ENC(NAME_NTH(4), 1, 672),   =
 /* float d;             */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),          =
                 /* [4] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(2), 3, 1),           =
                 /* [5] */
> > +                       /* int[16] */
> > +                       BTF_TYPE_ARRAY_ENC(1, 2, 16),                  =
                 /* [6] */
> >                         /* ptr -> [3] struct s */
> > -                       BTF_PTR_ENC(3),                                =
                 /* [4] */
> > +                       BTF_PTR_ENC(3),                                =
                 /* [7] */
> >                         /* ptr -> [6] const int */
> > -                       BTF_PTR_ENC(6),                                =
                 /* [5] */
> > +                       BTF_PTR_ENC(9),                                =
                 /* [8] */
> >                         /* const -> [1] int */
> > -                       BTF_CONST_ENC(1),                              =
                 /* [6] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),          =
                 /* [7] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(2), 3, 1),           =
                 /* [8] */
> > -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),            =
                 /* [9] */
> > +                       BTF_CONST_ENC(2),                              =
                 /* [9] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0a\0b\0c\0d\0int\0float\0next\0s"),
> > @@ -7082,10 +7082,10 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       BTF_PTR_ENC(3),                                =
 /* [1] ptr -> [3] */
> > -                       BTF_STRUCT_ENC(NAME_TBD, 1, 8),                =
 /* [2] struct s   */
> > -                               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> > -                       BTF_STRUCT_ENC(NAME_NTH(2), 0, 0),             =
 /* [3] struct x   */
> > +                       BTF_STRUCT_ENC(NAME_TBD, 1, 8),                =
 /* [1] struct s   */
> > +                               BTF_MEMBER_ENC(NAME_TBD, 3, 0),
> > +                       BTF_STRUCT_ENC(NAME_NTH(2), 0, 0),             =
 /* [2] struct x   */
> > +                       BTF_PTR_ENC(2),                                =
 /* [3] ptr -> [3] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0s\0x"),
> > @@ -7123,15 +7123,13 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       /* CU 1 */
> > -                       BTF_STRUCT_ENC(0, 0, 1),                       =
         /* [1] struct {}  */
> > -                       BTF_PTR_ENC(1),                                =
         /* [2] ptr -> [1] */
> > -                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),             =
         /* [3] struct s   */
> > -                               BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> > -                       /* CU 2 */
> > -                       BTF_PTR_ENC(0),                                =
         /* [4] ptr -> void */
> > -                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),             =
         /* [5] struct s   */
> > +                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),             =
         /* [1] struct s   */
> >                                 BTF_MEMBER_ENC(NAME_NTH(2), 4, 0),
> > +                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),             =
         /* [2] struct s   */
> > +                               BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
> > +                       BTF_STRUCT_ENC(0, 0, 1),                       =
         /* [3] struct {}  */
> > +                       BTF_PTR_ENC(3),                                =
         /* [5] ptr -> [1] */
> > +                       BTF_PTR_ENC(0),                                =
         /* [4] ptr -> void */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0s\0x"),
> > @@ -7182,28 +7180,28 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >                                 BTF_ENUM_ENC(NAME_TBD, 0),
> >                                 BTF_ENUM_ENC(NAME_TBD, 1),
> >                         BTF_FWD_ENC(NAME_TBD, 1 /* union kind_flag */),=
                 /* [3] fwd */
> > -                       BTF_TYPE_ARRAY_ENC(2, 1, 7),                   =
                 /* [4] array */
> > -                       BTF_STRUCT_ENC(NAME_TBD, 1, 4),                =
                 /* [5] struct */
> > +                       BTF_STRUCT_ENC(NAME_TBD, 1, 4),                =
                 /* [4] struct */
> >                                 BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> > -                       BTF_UNION_ENC(NAME_TBD, 1, 4),                 =
                 /* [6] union */
> > +                       BTF_UNION_ENC(NAME_TBD, 1, 4),                 =
                 /* [5] union */
> >                                 BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> > -                       BTF_TYPEDEF_ENC(NAME_TBD, 1),                  =
                 /* [7] typedef */
> > -                       BTF_PTR_ENC(0),                                =
                 /* [8] ptr */
> > -                       BTF_CONST_ENC(8),                              =
                 /* [9] const */
> > -                       BTF_VOLATILE_ENC(8),                           =
                 /* [10] volatile */
> > -                       BTF_RESTRICT_ENC(8),                           =
                 /* [11] restrict */
> > -                       BTF_FUNC_PROTO_ENC(1, 2),                      =
                 /* [12] func_proto */
> > -                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> > -                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
> > -                       BTF_FUNC_ENC(NAME_TBD, 12),                    =
                 /* [13] func */
> > -                       BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),               =
                 /* [14] float */
> > -                       BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),            =
                 /* [15] decl_tag */
> > -                       BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),             =
                 /* [16] decl_tag */
> > -                       BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),             =
                 /* [17] decl_tag */
> > -                       BTF_TYPE_TAG_ENC(NAME_TBD, 8),                 =
                 /* [18] type_tag */
> > -                       BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_EN=
UM64, 0, 2), 8), /* [19] enum64 */
> > +                       BTF_TYPEDEF_ENC(NAME_TBD, 1),                  =
                 /* [6] typedef */
> > +                       BTF_FUNC_ENC(NAME_TBD, 19),                    =
                 /* [7] func */
> > +                       BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),               =
                 /* [8] float */
> > +                       BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),             =
                 /* [9] decl_tag */
> > +                       BTF_DECL_TAG_ENC(NAME_TBD, 7, 1),              =
                 /* [10] decl_tag */
> > +                       BTF_DECL_TAG_ENC(NAME_TBD, 6, -1),             =
                 /* [11] decl_tag */
> > +                       BTF_TYPE_TAG_ENC(NAME_TBD, 15),                =
                 /* [12] type_tag */
> > +                       BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_EN=
UM64, 0, 2), 8), /* [13] enum64 */
> >                                 BTF_ENUM64_ENC(NAME_TBD, 0, 0),
> >                                 BTF_ENUM64_ENC(NAME_TBD, 1, 1),
> > +                       BTF_TYPE_ARRAY_ENC(2, 2, 7),                   =
                 /* [14] array */
> > +                       BTF_PTR_ENC(0),                                =
                 /* [15] ptr */
> > +                       BTF_CONST_ENC(15),                             =
                 /* [16] const */
> > +                       BTF_VOLATILE_ENC(15),                          =
                 /* [17] volatile */
> > +                       BTF_RESTRICT_ENC(15),                          =
                 /* [18] restrict */
> > +                       BTF_FUNC_PROTO_ENC(1, 2),                      =
                 /* [19] func_proto */
> > +                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> > +                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 12),
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N=
\0O\0P\0Q\0R\0S\0T\0U"),
> > @@ -7237,9 +7235,14 @@ static struct btf_dedup_test dedup_tests[] =3D {
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > +                       /* all allowed sizes */
> > +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 2),
> > +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 4),
> > +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 8),
> > +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 12),
> > +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 16),
> > +
> >                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0=
, 32, 8),
> > -                       /* different name */
> > -                       BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0=
, 32, 8),
> >                         /* different encoding */
> >                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_CHAR, 0, =
32, 8),
> >                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_BOOL, 0, =
32, 8),
> > @@ -7249,12 +7252,8 @@ static struct btf_dedup_test dedup_tests[] =3D {
> >                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0=
, 27, 8),
> >                         /* different byte size */
> >                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0=
, 32, 4),
> > -                       /* all allowed sizes */
> > -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 2),
> > -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 4),
> > -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 8),
> > -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 12),
> > -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 16),
> > +                       /* different name */
> > +                       BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0=
, 32, 8),
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0int\0some other int\0float"),
> > @@ -7323,18 +7322,18 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       /* int */
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       /* static int t */
> > -                       BTF_VAR_ENC(NAME_NTH(2), 1, 0),                =
 /* [2] */
> > -                       /* .bss section */                             =
 /* [3] */
> > +                       /* .bss section */                             =
 /* [1] */
> >                         BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND=
_DATASEC, 0, 1), 4),
> > -                       BTF_VAR_SECINFO_ENC(2, 0, 4),
> > -                       /* another static int t */
> > -                       BTF_VAR_ENC(NAME_NTH(2), 1, 0),                =
 /* [4] */
> > -                       /* another .bss section */                     =
 /* [5] */
> > +                       BTF_VAR_SECINFO_ENC(3, 0, 4),
> > +                       /* another .bss section */                     =
 /* [2] */
> >                         BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND=
_DATASEC, 0, 1), 4),
> >                         BTF_VAR_SECINFO_ENC(4, 0, 4),
> > +                       /* static int t */
> > +                       BTF_VAR_ENC(NAME_NTH(2), 5, 0),                =
 /* [3] */
> > +                       /* another static int t */
> > +                       BTF_VAR_ENC(NAME_NTH(2), 5, 0),                =
 /* [4] */
> > +                       /* int */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [5] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0.bss\0t"),
> > @@ -7371,15 +7370,15 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       BTF_VAR_ENC(NAME_NTH(1), 1, 0),                =
 /* [2] */
> > -                       BTF_FUNC_PROTO_ENC(0, 2),                      =
 /* [3] */
> > -                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
> > -                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
> > -                       BTF_FUNC_ENC(NAME_NTH(4), 3),                  =
 /* [4] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),          =
 /* [5] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),          =
 /* [6] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),           =
 /* [7] */
> > +                       BTF_FUNC_ENC(NAME_NTH(4), 7),                  =
 /* [1] */
> > +                       BTF_VAR_ENC(NAME_NTH(1), 6, 0),                =
 /* [2] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),          =
 /* [3] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),          =
 /* [4] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),           =
 /* [5] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [6] */
> > +                       BTF_FUNC_PROTO_ENC(0, 2),                      =
 /* [7] */
> > +                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 6),
> > +                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 6),
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
> > @@ -7419,17 +7418,17 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       BTF_FUNC_PROTO_ENC(0, 2),                      =
 /* [2] */
> > -                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
> > -                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
> > -                       BTF_FUNC_ENC(NAME_NTH(3), 2),                  =
 /* [3] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),          =
 /* [4] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 3, -1),          =
 /* [5] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(6), 3, -1),          =
 /* [6] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 3, 1),           =
 /* [7] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 3, 1),           =
 /* [8] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(6), 3, 1),           =
 /* [9] */
> > +                       BTF_FUNC_ENC(NAME_NTH(3), 9),                  =
 /* [1] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),          =
 /* [2] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, 1),           =
 /* [3] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),          =
 /* [4] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),           =
 /* [5] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(6), 1, -1),          =
 /* [6] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(6), 1, 1),           =
 /* [7] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [8] */
> > +                       BTF_FUNC_PROTO_ENC(0, 2),                      =
 /* [9] */
> > +                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 8),
> > +                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 8),
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
> > @@ -7465,16 +7464,16 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             =
 /* [2] */
> > -                               BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
> > -                               BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),          =
 /* [3] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),          =
 /* [4] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(6), 2, -1),          =
 /* [5] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 2, 1),           =
 /* [6] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 2, 1),           =
 /* [7] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(6), 2, 1),           =
 /* [8] */
> > +                       BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             =
 /* [1] */
> > +                               BTF_MEMBER_ENC(NAME_NTH(2), 8, 0),
> > +                               BTF_MEMBER_ENC(NAME_NTH(3), 8, 32),
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),          =
 /* [2] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, 1),           =
 /* [3] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),          =
 /* [4] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),           =
 /* [5] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(6), 1, -1),          =
 /* [6] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(6), 1, 1),           =
 /* [7] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [8] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
> > @@ -7500,11 +7499,11 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       BTF_TYPEDEF_ENC(NAME_NTH(1), 1),               =
 /* [2] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(2), 2, -1),          =
 /* [3] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(3), 2, -1),          =
 /* [4] */
> > -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),          =
 /* [5] */
> > +                       BTF_TYPEDEF_ENC(NAME_NTH(1), 5),               =
 /* [1] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(2), 1, -1),          =
 /* [2] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(3), 1, -1),          =
 /* [3] */
> > +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),          =
 /* [4] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [5] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0t\0tag1\0tag2\0tag3"),
> > @@ -7533,12 +7532,12 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         .expect =3D {
> >                 .raw_types =3D {
> >                         /* ptr -> tag2 -> tag1 -> int */
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),              =
 /* [2] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),              =
 /* [3] */
> > -                       BTF_PTR_ENC(3),                                =
 /* [4] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),              =
 /* [1] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),              =
 /* [2] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [3] */
> > +                       BTF_PTR_ENC(2),                                =
 /* [4] */
> >                         /* ptr -> tag1 -> int */
> > -                       BTF_PTR_ENC(2),                                =
 /* [5] */
> > +                       BTF_PTR_ENC(1),                                =
 /* [5] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0tag1\0tag2"),
> > @@ -7563,13 +7562,13 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         .expect =3D {
> >                 .raw_types =3D {
> >                         /* ptr -> tag2 -> tag1 -> int */
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),              =
 /* [2] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),              =
 /* [3] */
> > -                       BTF_PTR_ENC(3),                                =
 /* [4] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),              =
 /* [1] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),              =
 /* [2] */
> >                         /* ptr -> tag2 -> int */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),              =
 /* [5] */
> > -                       BTF_PTR_ENC(5),                                =
 /* [6] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 4),              =
 /* [3] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [4] */
> > +                       BTF_PTR_ENC(2),                                =
 /* [5] */
> > +                       BTF_PTR_ENC(3),                                =
 /* [6] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0tag1\0tag2"),
> > @@ -7594,15 +7593,13 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       /* ptr -> tag2 -> tag1 -> int */
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),              =
 /* [2] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),              =
 /* [3] */
> > -                       BTF_PTR_ENC(3),                                =
 /* [4] */
> > -                       /* ptr -> tag1 -> tag2 -> int */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),              =
 /* [5] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),              =
 /* [6] */
> > -                       BTF_PTR_ENC(6),                                =
 /* [7] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),              =
 /* [1] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),              =
 /* [2] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),              =
 /* [3] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 5),              =
 /* [4] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [5] */
> > +                       BTF_PTR_ENC(3),                                =
 /* [6] */
> > +                       BTF_PTR_ENC(2),                                =
 /* [7] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0tag1\0tag2"),
> > @@ -7626,14 +7623,12 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       /* ptr -> tag1 -> int */
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [1] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),              =
 /* [2] */
> > -                       BTF_PTR_ENC(2),                                =
 /* [3] */
> > -                       /* ptr -> tag1 -> long */
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8), =
 /* [4] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),              =
 /* [5] */
> > -                       BTF_PTR_ENC(5),                                =
 /* [6] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),              =
 /* [1] */
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),              =
 /* [2] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
 /* [3] */
> > +                       BTF_PTR_ENC(1),                                =
 /* [4] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8), =
 /* [5] */
> > +                       BTF_PTR_ENC(2),                                =
 /* [6] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0tag1"),
> > @@ -7656,10 +7651,10 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
                         /* [1] */
> > -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),              =
                         /* [2] */
> > -                       BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND=
_STRUCT, 1, 1), 4),      /* [3] */
> > +                       BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND=
_STRUCT, 1, 1), 4),      /* [1] */
> >                         BTF_MEMBER_ENC(NAME_NTH(3), 2, BTF_MEMBER_OFFSE=
T(0, 0)),
> > +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),              =
                         /* [2] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
                         /* [3] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0tag1\0t\0m"),
> > @@ -7861,10 +7856,10 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         .expect =3D {
> >                 .raw_types =3D {
> >                         BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             =
/* [1] */
> > -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
/* [2] */
> > -                       BTF_PTR_ENC(1),                                =
/* [3] */
> > -                       BTF_TYPEDEF_ENC(NAME_NTH(3), 3),               =
/* [4] */
> > +                       BTF_MEMBER_ENC(NAME_NTH(2), 3, 0),
> > +                       BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               =
/* [2] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
/* [3] */
> > +                       BTF_PTR_ENC(1),                                =
/* [4] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0foo\0x\0foo_ptr"),
> > @@ -7901,10 +7896,10 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         .expect =3D {
> >                 .raw_types =3D {
> >                         BTF_UNION_ENC(NAME_NTH(1), 1, 4),              =
/* [1] */
> > -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
/* [2] */
> > -                       BTF_PTR_ENC(1),                                =
/* [3] */
> > -                       BTF_TYPEDEF_ENC(NAME_NTH(3), 3),               =
/* [4] */
> > +                       BTF_MEMBER_ENC(NAME_NTH(2), 3, 0),
> > +                       BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               =
/* [2] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
/* [3] */
> > +                       BTF_PTR_ENC(1),                                =
/* [4] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0foo\0x\0foo_ptr"),
> > @@ -7940,14 +7935,12 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       /* CU 1 */
> >                         BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             =
/* [1] */
> > -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
/* [2] */
> > -                       /* CU 2 */
> > -                       BTF_FWD_ENC(NAME_NTH(3), 1),                   =
/* [3] */
> > -                       BTF_PTR_ENC(3),                                =
/* [4] */
> > -                       BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               =
/* [5] */
> > +                       BTF_MEMBER_ENC(NAME_NTH(2), 4, 0),
> > +                       BTF_FWD_ENC(NAME_NTH(3), 1),                   =
/* [2] */
> > +                       BTF_TYPEDEF_ENC(NAME_NTH(3), 5),               =
/* [3] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
/* [4] */
> > +                       BTF_PTR_ENC(2),                                =
/* [5] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0foo\0x\0foo_ptr"),
> > @@ -7990,18 +7983,15 @@ static struct btf_dedup_test dedup_tests[] =3D =
{
> >         },
> >         .expect =3D {
> >                 .raw_types =3D {
> > -                       /* CU 1 */
> >                         BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             =
/* [1] */
> > -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> > -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
/* [2] */
> > -                       /* CU 2 */
> > -                       BTF_FWD_ENC(NAME_NTH(1), 0),                   =
/* [3] */
> > -                       BTF_PTR_ENC(3),                                =
/* [4] */
> > -                       BTF_TYPEDEF_ENC(NAME_NTH(4), 4),               =
/* [5] */
> > -                       /* CU 3 */
> > -                       BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             =
/* [6] */
> > -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> > -                       BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
> > +                       BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
> > +                       BTF_FWD_ENC(NAME_NTH(1), 0),                   =
/* [2] */
> > +                       BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             =
/* [3] */
> > +                       BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
> > +                       BTF_MEMBER_ENC(NAME_NTH(3), 5, 0),
> > +                       BTF_TYPEDEF_ENC(NAME_NTH(4), 6),               =
/* [4] */
> > +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), =
/* [5] */
> > +                       BTF_PTR_ENC(2),                                =
/* [6] */
> >                         BTF_END_RAW,
> >                 },
> >                 BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b=
/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> > index d9024c7a892a..e50c290b2d8c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> > @@ -311,18 +311,18 @@ static void test_split_struct_duped() {
> >                 "[5] STRUCT 's1' size=3D16 vlen=3D2\n"
> >                 "\t'f1' type_id=3D2 bits_offset=3D0\n"
> >                 "\t'f2' type_id=3D4 bits_offset=3D64",
> > -               "[6] PTR '(anon)' type_id=3D8",
> > -               "[7] PTR '(anon)' type_id=3D9",
> > -               "[8] STRUCT 's1' size=3D16 vlen=3D2\n"
> > -               "\t'f1' type_id=3D6 bits_offset=3D0\n"
> > -               "\t'f2' type_id=3D7 bits_offset=3D64",
> > -               "[9] STRUCT 's2' size=3D40 vlen=3D4\n"
> > -               "\t'f1' type_id=3D6 bits_offset=3D0\n"
> > -               "\t'f2' type_id=3D7 bits_offset=3D64\n"
> > +               "[6] STRUCT 's1' size=3D16 vlen=3D2\n"
> > +               "\t'f1' type_id=3D9 bits_offset=3D0\n"
> > +               "\t'f2' type_id=3D10 bits_offset=3D64",
> > +               "[7] STRUCT 's2' size=3D40 vlen=3D4\n"
> > +               "\t'f1' type_id=3D9 bits_offset=3D0\n"
> > +               "\t'f2' type_id=3D10 bits_offset=3D64\n"
> >                 "\t'f3' type_id=3D1 bits_offset=3D128\n"
> > -               "\t'f4' type_id=3D8 bits_offset=3D192",
> > -               "[10] STRUCT 's3' size=3D8 vlen=3D1\n"
> > -               "\t'f1' type_id=3D7 bits_offset=3D0");
> > +               "\t'f4' type_id=3D6 bits_offset=3D192",
> > +               "[8] STRUCT 's3' size=3D8 vlen=3D1\n"
> > +               "\t'f1' type_id=3D10 bits_offset=3D0",
> > +               "[9] PTR '(anon)' type_id=3D6",
> > +               "[10] PTR '(anon)' type_id=3D7");
> >
> >  cleanup:
> >         btf__free(btf2);
> > @@ -385,13 +385,13 @@ static void test_split_dup_struct_in_cu()
> >
> >         VALIDATE_RAW_BTF(
> >                         btf1,
> > -                       "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> > -                       "[2] STRUCT 's' size=3D8 vlen=3D2\n"
> > -                       "\t'a' type_id=3D3 bits_offset=3D0\n"
> > -                       "\t'b' type_id=3D3 bits_offset=3D0",
> > -                       "[3] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> > -                       "\t'f1' type_id=3D1 bits_offset=3D0\n"
> > -                       "\t'f2' type_id=3D1 bits_offset=3D32");
> > +                       "[1] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> > +                       "\t'f1' type_id=3D2 bits_offset=3D0\n"
> > +                       "\t'f2' type_id=3D2 bits_offset=3D32",
> > +                       "[2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> > +                       "[3] STRUCT 's' size=3D8 vlen=3D2\n"
> > +                       "\t'a' type_id=3D1 bits_offset=3D0\n"
> > +                       "\t'b' type_id=3D1 bits_offset=3D0");
> >
> >         /* and add the same data on top of it */
> >         btf2 =3D btf__new_empty_split(btf1);
> > @@ -402,13 +402,13 @@ static void test_split_dup_struct_in_cu()
> >
> >         VALIDATE_RAW_BTF(
> >                         btf2,
> > -                       "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> > -                       "[2] STRUCT 's' size=3D8 vlen=3D2\n"
> > -                       "\t'a' type_id=3D3 bits_offset=3D0\n"
> > -                       "\t'b' type_id=3D3 bits_offset=3D0",
> > -                       "[3] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> > -                       "\t'f1' type_id=3D1 bits_offset=3D0\n"
> > -                       "\t'f2' type_id=3D1 bits_offset=3D32",
> > +                       "[1] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> > +                       "\t'f1' type_id=3D2 bits_offset=3D0\n"
> > +                       "\t'f2' type_id=3D2 bits_offset=3D32",
> > +                       "[2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> > +                       "[3] STRUCT 's' size=3D8 vlen=3D2\n"
> > +                       "\t'a' type_id=3D1 bits_offset=3D0\n"
> > +                       "\t'b' type_id=3D1 bits_offset=3D0",
> >                         "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> >                         "[5] STRUCT 's' size=3D8 vlen=3D2\n"
> >                         "\t'a' type_id=3D6 bits_offset=3D0\n"
> > @@ -427,13 +427,13 @@ static void test_split_dup_struct_in_cu()
> >         /* after dedup it should match the original data */
> >         VALIDATE_RAW_BTF(
> >                         btf2,
> > -                       "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> > -                       "[2] STRUCT 's' size=3D8 vlen=3D2\n"
> > -                       "\t'a' type_id=3D3 bits_offset=3D0\n"
> > -                       "\t'b' type_id=3D3 bits_offset=3D0",
> > -                       "[3] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> > -                       "\t'f1' type_id=3D1 bits_offset=3D0\n"
> > -                       "\t'f2' type_id=3D1 bits_offset=3D32");
> > +                       "[1] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> > +                       "\t'f1' type_id=3D2 bits_offset=3D0\n"
> > +                       "\t'f2' type_id=3D2 bits_offset=3D32",
> > +                       "[2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> > +                       "[3] STRUCT 's' size=3D8 vlen=3D2\n"
> > +                       "\t'a' type_id=3D1 bits_offset=3D0\n"
> > +                       "\t'b' type_id=3D1 bits_offset=3D0");
> >
> >  cleanup:
> >         btf__free(btf2);
> > --
> > 2.34.1
> >

