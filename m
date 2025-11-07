Return-Path: <bpf+bounces-73944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5B2C3EBF0
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 08:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BB73A627C
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F073081D2;
	Fri,  7 Nov 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgtyt3Qh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5E23EABB
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500564; cv=none; b=IO2kKS9kMoy8CPPO8JVDz8F76O047pCZIzSmepO70BZhD9I2a4SPAoeC5tywOa9W6HCQcPCEl/dQn+THsbGNwXulLMEDBLSCYAX6pqhonM9qRDT810cijVCULKZEPRWQsQb52GNc/9LqldPnWVv9PAYvsrSu4jJRGYW3TI/keus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500564; c=relaxed/simple;
	bh=CFQM4Su+Z6JQR/FcapowlXOgnDNjrBaIqDt1QwG+ZZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGTBfyHgLaNbOYU4obRIuUssL12iEJXmDBLTG3/Xi7F3N3rnB4pkuPn77B3NYk/P4+vxdnuEiQ5cverBekQKhXZvzMnLEiZ0fBxQdyl98M+irPdHpRSjyFNkxi1AnFoJU/gYnRhe6arcmD8xlP+W2tQTxV2sfNPNjoNsiPLt+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgtyt3Qh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so62944166b.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 23:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762500561; x=1763105361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPNTNuB5ohFc6iPRI70eLoN2CCkDClAXffDkFoe9HpU=;
        b=Vgtyt3QhWrfWN7FtBX8lFl2Ga2t6uD0vrDEngy1/yO/WK68vOpThjiu64ceK3Oozkw
         713sSotpIwzymmFNNGKqJrjGo9USX83vRjLVGnF3CTjqOTTmuz/LNvP+MU2TJobNvQ6v
         HRkQk3ka8pPDi5V5+DaRVVkjoVfnChvSajc7lgyhAQAIBE0+bLHErZQUYQtqpgtlLU8p
         ExpGMrK40aqJGkCZlq9SmVCr8ZA7aG2wtVWdhhYoZI0kv+61ueEm7+LZ3wE9bf/6zir8
         i8NyWK3z4P2Ek9j5SALg9YpNuhOJYmoY35JRzrXPO6kdpgdsCJndXN2am1GlHoWuDmKe
         9bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500561; x=1763105361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPNTNuB5ohFc6iPRI70eLoN2CCkDClAXffDkFoe9HpU=;
        b=EDeEJx06EkRQBih+0Ay5nTgsCN9P2hCzW7sc/KSucgZ7P+tTh+NeeXVoWYaWnB7abd
         1aUtINqNWsBZC7RDEX6T8eNk3MD/dsKwXgtxtbryKvkxgPeR+A+my3taxXTleClGwNrF
         ewwqHlC8xDEAYU62rThI93/cB4JyfkB6e7Hd1DED+EukfZjQrJnq0UfGBYb1NduW/9Tf
         XSuwD/cN8QPA3DrRZ+l4bhVv9NieAsEjRBc1O0KdsPzHByT7T1m5tyoKL7cwJ+I758wz
         ceppIHXQrrZ9GmySznXysHuY6YLPGVJ3P5x91RTFKf6kQxste3xxT1J9sqXyshnrenEX
         eB4g==
X-Forwarded-Encrypted: i=1; AJvYcCVzgQlCsCU611XVxtfXdQMj821KBC5wdt7gDbNOIq6gc1VewR5snC9vre777tSOlPeUPeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0Qu+Dqp/Fqzd/aivB+rSC7HNnjwLVHI2ygK4k2lESCMdJ6pq
	oFGmB0cauWT8sjD0KyhyctOWA7YW5qnvdmGtmw2alKwdxm8ial+daVG/dhjnL0dW6Ug1MbQnwV4
	P2IIMi6y3Msv8IseuS+IfoxVr8LaGcx4=
X-Gm-Gg: ASbGnct203DO5vQexGiKhnoXzU3P4paoIeRgPByGry5J/pdQ2DxyuUVLyz7XGuCy2dS
	dqHbCcBgfFulgsHTq7+V00RwJzhM8altld2+dG+mu0QNqiOpAOwwEpYZKjpqKQ1cNFWm6u6ikTw
	8SdlR6w3ofZBuNWnn52VbquGwfWowTHtRUaIwF35DmLCyIJtgXcSHfLhVSTCFOzpXpgIn5mDyJO
	gUI2zZVh05ZaJOGePrXQQT8ArnQBHJfjHvpB9kxB8Lz84qXMrb3fEGMTwLR+I5CME2cm0ut
X-Google-Smtp-Source: AGHT+IGhQDbQz/Cq72U3Tkvve5B3ApTqNOV/YTm1qw/szVTnlVZ1uNqFuI8/fGMqCKXH2QBibdl7K4RAS6hkB02dJvc=
X-Received: by 2002:a17:907:3e9c:b0:b71:5079:9702 with SMTP id
 a640c23a62f3a-b72c0972fb8mr234805966b.21.1762500561069; Thu, 06 Nov 2025
 23:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-4-dolinux.peng@gmail.com> <20ace4a32dae5b4dcac499d8cb78ac5cab73d75a69b07b67113b7fbbb6e5ef45@mail.kernel.org>
In-Reply-To: <20ace4a32dae5b4dcac499d8cb78ac5cab73d75a69b07b67113b7fbbb6e5ef45@mail.kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 7 Nov 2025 15:29:09 +0800
X-Gm-Features: AWmQ_bn6kPbjcyp502WdEuUU_sUBgtmF6oDmPiVl3zZCeZPAxSpoyol6j1JQmZk
Message-ID: <CAErzpmsYWLBMvkW9eQqAfGOp23oThn=aXt4tqouah5NZus4rBA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] libbpf: Optimize type lookup with binary search
 for sorted BTF
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	alan.maguire@oracle.com, song@kernel.org, pengdonglin@xiaomi.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:40=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 97451a929..30be62ee2 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -26,6 +26,10 @@
> >
> >  #define BTF_MAX_NR_TYPES 0x7fffffffU
> >  #define BTF_MAX_STR_OFFSET 0x7fffffffU
> > +/*
> > + * sort verification occurs lazily upon first btf_find_type_by_name_ki=
nd() call
> > + */
> > +#define BTF_NEED_SORT_CHECK ((__u32)-1)
>
> [ ... ]
>
> > @@ -92,6 +96,16 @@ struct btf {
> >        *   - for split BTF counts number of types added on top of base =
BTF.
> >        */
> >       __u32 nr_types;
> > +     /* number of sorted and named types in this BTF instance:
> > +      *   - doesn't include special [0] void type;
> > +      *   - for split BTF counts number of sorted and named types adde=
d on
> > +      *     top of base BTF.
> > +      *   - BTF_NEED_SORT_CHECK value indicates sort validation will b=
e performed
> > +      *     on first call to btf_find_type_by_name_kind.
> > +      *   - zero value indicates applied sorting check with unsorted B=
TF or no
> > +      *     named types.
> > +      */
> > +     __u32 nr_sorted_types;
>
> [ ... ]
>
> > @@ -897,44 +911,126 @@ int btf__resolve_type(const struct btf *btf, __u=
32 type_id)
> >       return type_id;
> >  }
> >
> > -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> > +/* Performs binary search within specified type ID range to find the l=
eftmost
> > + * BTF type matching the given name. The search assumes types are sort=
ed by
> > + * name in lexicographical order within the specified range.
> > + *
> > + * Return: Type ID of leftmost matching type, or -ENOENT if not found
> > + */
> > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, cons=
t char *name,
> > +                                             __s32 start_id, __s32 end=
_id)
> >  {
> > -     __u32 i, nr_types =3D btf__type_cnt(btf);
> > +     const struct btf_type *t;
> > +     const char *tname;
> > +     __s32 l, r, m, lmost =3D -ENOENT;
> > +     int ret;
> > +
> > +     l =3D start_id;
> > +     r =3D end_id;
> > +     while (l <=3D r) {
> > +             m =3D l + (r - l) / 2;
> > +             t =3D btf_type_by_id(btf, m);
> > +             tname =3D btf__str_by_offset(btf, t->name_off);
> > +             ret =3D strcmp(tname, name);
> >                      ^^^^^^
>
> Can strcmp receive a NULL tname here? Anonymous types have name_off=3D0,
> and btf__str_by_offset() can return NULL for invalid offsets. The old
> btf__find_by_name() checked "if (name && !strcmp(...))" before calling
> strcmp.

The binary search is effectively disabled in this patch since
`nr_sorted_types` starts as
`BTF_NEED_SORT_CHECK`. The actual sorting validation and name verification =
will
be handled by `btf_check_sorted()` in the following patch, making this
implementation
safe.

>
> > +             if (ret < 0) {
> > +                     l =3D m + 1;
> > +             } else {
> > +                     if (ret =3D=3D 0)
> > +                             lmost =3D m;
> > +                     r =3D m - 1;
> > +             }
> > +     }
> > +
> > +     return lmost;
> > +}
> > +
> > +/* Searches for a BTF type by name and optionally by kind. The functio=
n first
> > + * checks if the search should start from the base BTF (if @start_id i=
s before
> > + * current BTF's start_id). If types are sorted, it uses binary search=
 to find
> > + * the leftmost matching type and then verifies the kind. For unsorted=
 types,
> > + * it falls back to linear search through all types.
> > + *
> > + * The function handles split BTF scenarios by recursively searching i=
n base
> > + * BTFs when necessary. When @kind is -1, only the name matching is pe=
rformed.
> > + *
> > + * Return: Type ID of matching type on success, -ENOENT if not found
> > + */
> > +static __s32 btf_find_type_by_name_kind(const struct btf *btf, int sta=
rt_id,
> > +                                const char *type_name, __u32 kind)
> > +{
> > +     const struct btf_type *t;
> > +     const char *tname;
> > +     int err =3D -ENOENT;
> > +
> > +     if (start_id < btf->start_id) {
> > +             err =3D btf_find_type_by_name_kind(btf->base_btf, start_i=
d,
> > +                     type_name, kind);
> > +             if (err > 0)
> > +                     goto out;
> > +             start_id =3D btf->start_id;
> > +     }
> > +
> > +     if (btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK) {
>
> Where is nr_sorted_types updated from BTF_NEED_SORT_CHECK? I only see
> three assignments in the entire file:
>
>   btf_new_empty():             btf->nr_sorted_types =3D BTF_NEED_SORT_CHE=
CK;
>   btf_new():                   btf->nr_sorted_types =3D BTF_NEED_SORT_CHE=
CK;
>   btf_invalidate_raw_data():   btf->nr_sorted_types =3D BTF_NEED_SORT_CHE=
CK;
>
> The comment claims "sort verification occurs lazily upon first
> btf_find_type_by_name_kind() call" but this function never updates
> nr_sorted_types. Does this mean the binary search path never executes?

Yes, at least in the current patch. However, in a subsequent patch,
the btf_check_sorted
function will be introduced and invoked during calls to
btf_find_type_by_name_kind.
If the BTF data is sorted, btf_check_sorted will return true, enabling
the execution of
binary search for improved lookup efficiency.

>
> > +             /* binary search */
> > +             __s32 end_id;
> > +             bool skip_first;
> > +             int ret;
> > +
> > +             end_id =3D btf->start_id + btf->nr_sorted_types - 1;
> > +             ret =3D btf_find_type_by_name_bsearch(btf, type_name, sta=
rt_id, end_id);
> > +             if (ret < 0)
> > +                     goto out;
> > +             if (kind =3D=3D -1)
> > +                     return ret;
> > +             skip_first =3D true;
> > +             do {
> > +                     t =3D btf_type_by_id(btf, ret);
> > +                     if (BTF_INFO_KIND(t->info) !=3D kind) {
> > +                             if (skip_first) {
> > +                                     skip_first =3D false;
> > +                                     continue;
> > +                             }
> > +                     } else if (skip_first) {
> > +                             return ret;
> > +                     }
> > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > +                     if (!strcmp(tname, type_name))
> >                              ^^^^^^
>
> Same NULL dereference concern here - tname isn't checked before strcmp.

Ditto.

>
> > +                             return ret;
> > +                     else
> > +                             break;
> > +             } while (++ret <=3D end_id);
> > +     } else {
> > +             /* linear search */
> > +             __u32 i, total;
> >
> > -     if (!strcmp(type_name, "void"))
> > -             return 0;
> > -
> > -     for (i =3D 1; i < nr_types; i++) {
> > -             const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -             const char *name =3D btf__name_by_offset(btf, t->name_off=
);
> > -
> > -             if (name && !strcmp(type_name, name))
> > -                     return i;
> > +             total =3D btf__type_cnt(btf);
> > +             for (i =3D start_id; i < total; i++) {
> > +                     t =3D btf_type_by_id(btf, i);
> > +                     if (kind !=3D -1 && btf_kind(t) !=3D kind)
> > +                             continue;
> > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > +                     if (tname && !strcmp(tname, type_name))
> > +                             return i;
> > +             }
> >       }
> >
> > -     return libbpf_err(-ENOENT);
> > +out:
> > +     return err;
> >  }
>
> [ ... ]
>
> > @@ -1006,6 +1102,7 @@ static struct btf *btf_new_empty(struct btf *base=
_btf)
> >       btf->fd =3D -1;
> >       btf->ptr_sz =3D sizeof(void *);
> >       btf->swapped_endian =3D false;
> > +     btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
> >
> >       if (base_btf) {
> >               btf->base_btf =3D base_btf;
>
> [ ... ]
>
> > @@ -1057,6 +1154,7 @@ static struct btf *btf_new(const void *data, __u3=
2 size, struct btf *base_btf, b
> >       btf->start_id =3D 1;
> >       btf->start_str_off =3D 0;
> >       btf->fd =3D -1;
> > +     btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
> >
> >       if (base_btf) {
> >               btf->base_btf =3D base_btf;
>
> [ ... ]
>
> > @@ -1715,6 +1813,7 @@ static void btf_invalidate_raw_data(struct btf *b=
tf)
> >               free(btf->raw_data_swapped);
> >               btf->raw_data_swapped =3D NULL;
> >       }
> > +     btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
> >  }
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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/191371=
95500

