Return-Path: <bpf+bounces-71661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B73BF9C6C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 05:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C4D467D32
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770EBA3F;
	Wed, 22 Oct 2025 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPRo6UIT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26D220F5C
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102143; cv=none; b=h1UWSsnvuTgwnZs/ekBekhDF5gxVh755CDooh6up4w5pbHELQz0oS9/tc2qK/L+x2l3cfeNckt4im3MU3M7USJrHa7qq8PiQrD6ebzC+NAdCnWmoefhWhw8N+VhWUc2jTwqZkgBNfCVC9dy+CGQNftn8O98rzA1EZkv+txVgbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102143; c=relaxed/simple;
	bh=zLVBu/+AMKlMtlB/bEZt72G9qc/KIcx/E7Osk59nw64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt2gMCW/DiHsRJH76B0ranVRwtKN6oQ60fOFi9r2oownqOSFvDfxBZgvrRrI+S/nj5f0tILPnTNi9NkKM3CzIcKjNeM7QuZfi3+JER2bA11cjN0BI7zRagiFUz8hUdBlkDcfDGQBQ/z2pWMkweABMAiPRzE8FvCMqMbvqxpdwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPRo6UIT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b50206773adso118288466b.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761102140; x=1761706940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzMUf6QRLk6HWgUGF9SsuDOm+/wNiddte8xrTsUO7/g=;
        b=nPRo6UITW6Ll3dM6BF1Do0eCr8w8JRLvXdSl+GZADupRXAPCS1y+XoCo7QQ4GvvvGN
         pa5GmWMB7TV4tCEAmZJ9N/yUIn4rFLVYhe/ZpggQyd8KrQBNzvv7VVp7tft3nqKq3zG3
         DTz6nxG+ETrazMnQ8vzrbdS6/bMtS3Gov3JsExBRVnmL8RzO1ae466PcuzhcMp6kJSZw
         MwSfwjhUpn0IAv6VdSy9qZHWTMYryqPZ5/ArFSx4S96tF/z9w0ogVtLsZ3owVnCvF1Ic
         WzGopy+zHeSg+uJwD4LEtaZIra+tLP9SZuIkJbMr6fB6mjxdApYAU5eeOAtbcwzA+PzM
         84PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761102140; x=1761706940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzMUf6QRLk6HWgUGF9SsuDOm+/wNiddte8xrTsUO7/g=;
        b=ZO6SDwPdZ9VBR65KCQIj2J1kWbU0trwYx5L9SDkSKiiGQWROzC6+2pxatJIx5KB9vn
         Zy179ulIEnrHa5SAEr4A1BQ4C6s01SDGJq0YvIYb8/r8CEBE28xaINTospvYR53Buwzy
         t9UPKbWvtkfu2RCWZxHhPMKRtFz4TRJgeeWiiq6NJTumlG296aPwLDEPgwaNAVK53ayc
         CGqPLfYqLnQ7aaUq+M18BOq1nWMFILHOaZpllcsGpzxl6FgpmcTgrSyVwXnf5W2hUviQ
         HeMyb4F4x6iCuxCzzsno+geo+YKiGB8iOHuy/H9rsiv2rj/KAK2Fjo2PccGEhmunKPWA
         c0lw==
X-Forwarded-Encrypted: i=1; AJvYcCWxS64Lt0qV0gBB7IfAMQ7w5DyIe6JMmGaRYSPHhJxjg5sOJ3KQyudn3dP9+iuodSW8jyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBK2VVvPXEHpvYv7IHeQZPvG0hXu3lKJXxamIvuHy3Kff88tmi
	Kcldr/dl0Ww6fm814r/IQnI8DeMVXY0WGTam58gT0oKMDCFJ68FraAFHSXeEeiOH4GsNxSvEHys
	ZBeSDUqA0Xa7LsDNzlD5aGIsEP7Br3vE=
X-Gm-Gg: ASbGncsQWpwzbX3tb+giongL5ZYLJ5vyKTuEgOB00Va7dS+EBLcrtjA0AkRroWEKZMC
	sX27r5c0FwNHyqKo8hGv4/xhSuoun3sM8guBz1+e/ZnnsXz6p+Q5YFQcoclccs1yYAwir5WMbbT
	gzhZzJH45aKkseLkmNWnHud2msrjVNjhtStx9gsmk3B5os9YSWHY9BBPyMCXnkkLInWKIV96Ois
	9DoyZ0o2/bxeCJ5QAeqkZ20mxIcDGOMl/EoNjRSV11idsqKlJh3pleb9FkH76NgpUtPiN1msJxJ
	73MwzT4=
X-Google-Smtp-Source: AGHT+IGXiOBvEdzf4B7QXYil7PlHFvUamyVfsJceB+za+fvQwqtEn7f3PQXBCs8Ga2lZSx7wbG1NoXSh34ERnd9giWU=
X-Received: by 2002:a17:907:84d:b0:b33:821f:156e with SMTP id
 a640c23a62f3a-b6d2c005772mr5752166b.12.1761102139380; Tue, 21 Oct 2025
 20:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
In-Reply-To: <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 22 Oct 2025 11:02:07 +0800
X-Gm-Features: AS18NWC4nWxQjoF-Vfg8-cJwp-0zaphXSSSqY80gm2YPuIdEVXmO8bEHMMuBObw
Message-ID: <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:59=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > This patch implements sorting of BTF types by their kind and name,
> > enabling the use of binary search for type lookups.
> >
> > To share logic between kernel and libbpf, a new btf_sort.c file is
> > introduced containing common sorting functionality.
> >
> > The sorting is performed during btf__dedup() when the new
> > sort_by_kind_name option in btf_dedup_opts is enabled.
>
> Do we really need this option?  Dedup is free to rearrange btf types
> anyway, so why not sort always?  Is execution time a concern?

The issue is that sorting changes the layout of BTF. Many existing selftest=
s
rely on the current, non-sorted order for their validation checks. Introduc=
ing
this as an optional feature first allows us to run it without immediately
breaking the tests, giving us time to fix them incrementally.

>
> > For vmlinux and kernel module BTF, btf_check_sorted() verifies
> > whether the types are sorted and binary search can be used.
>
> [...]
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index c414cf37e1bd..11b05f4eb07d 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -259,6 +259,7 @@ struct btf {
> >       void *nohdr_data;
> >       struct btf_header hdr;
> >       u32 nr_types; /* includes VOID for base BTF */
> > +     u32 nr_sorted_types;
> >       u32 types_size;
> >       u32 data_size;
> >       refcount_t refcnt;
> > @@ -544,33 +545,29 @@ u32 btf_nr_types(const struct btf *btf)
> >       return total;
> >  }
> >
> > -u32 btf_type_cnt(const struct btf *btf)
> > +u32 btf_start_id(const struct btf *btf)
> >  {
> > -     return btf->start_id + btf->nr_types;
> > +     return btf->start_id;
> >  }
> >
> > -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 =
kind)
> > +u32 btf_nr_sorted_types(const struct btf *btf)
> >  {
> > -     const struct btf_type *t;
> > -     const char *tname;
> > -     u32 i, total;
> > -
> > -     do {
> > -             total =3D btf_type_cnt(btf);
> > -             for (i =3D btf->start_id; i < total; i++) {
> > -                     t =3D btf_type_by_id(btf, i);
> > -                     if (BTF_INFO_KIND(t->info) !=3D kind)
> > -                             continue;
> > +     return btf->nr_sorted_types;
> > +}
> >
> > -                     tname =3D btf_name_by_offset(btf, t->name_off);
> > -                     if (!strcmp(tname, name))
> > -                             return i;
> > -             }
> > +void btf_set_nr_sorted_types(struct btf *btf, u32 nr)
> > +{
> > +     btf->nr_sorted_types =3D nr;
> > +}
> >
> > -             btf =3D btf->base_btf;
> > -     } while (btf);
> > +u32 btf_type_cnt(const struct btf *btf)
> > +{
> > +     return btf->start_id + btf->nr_types;
> > +}
> >
> > -     return -ENOENT;
> > +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 =
kind)
> > +{
> > +     return find_btf_by_name_kind(btf, 1, name, kind);
>                                          ^^^
>                 nit: this will make it impossible to find "void" w/o a sp=
ecial case
>                      in the find_btf_by_name_kind(), why not start from 0=
?

Thanks. I referred to btf__find_by_name_kind in libbpf. In
btf_find_by_name_kind,
there is a special check for "void". Consequently, I've added a
similar special check
for "void" in find_btf_by_name_kind as well.

> >  }
> >
> >  s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
>
> [...]
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 18907f0fcf9f..87e47f0b78ba 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [...]
>
> > +/*
> > + * Compact and sort BTF types.
> > + *
> > + * Similar to btf_dedup_compact_types, but additionally sorts the btf_=
types.
> > + */
> > +static int btf__dedup_compact_and_sort_types(struct btf_dedup *d)
> > +{
>
> And this function will become btf__dedup_compact_types(),
> if BTF will be always sorted. Thus removing some code duplication.

Thanks for the suggestion. I think we can keep just
btf__dedup_compact_and_sort_types and add a feature check before
sorting, like this:

if (d->sort_by_kind_name)
    qsort_r(sorted_ids, types_cnt, sizeof(*sorted_ids),
            btf_compare_type_kinds_names, d->btf);

>
> [...]
>
> > diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> > new file mode 100644
> > index 000000000000..2ad4a56f1c08
> > --- /dev/null
> > +++ b/tools/lib/bpf/btf_sort.c
>
> [...]
>
> > +/*
> > + * Sort BTF types by kind and name in ascending order, placing named t=
ypes
> > + * before anonymous ones.
> > + */
> > +int btf_compare_type_kinds_names(const void *a, const void *b, void *p=
riv)
> > +{
> > +     struct btf *btf =3D (struct btf *)priv;
> > +     struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > +     struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > +     const char *na, *nb;
> > +     int ka, kb;
> > +
> > +     /* ta w/o name is greater than tb */
> > +     if (!ta->name_off && tb->name_off)
> > +             return 1;
> > +     /* tb w/o name is smaller than ta */
> > +     if (ta->name_off && !tb->name_off)
> > +             return -1;
> > +
> > +     ka =3D btf_kind(ta);
> > +     kb =3D btf_kind(tb);
> > +     na =3D btf__str_by_offset(btf, ta->name_off);
> > +     nb =3D btf__str_by_offset(btf, tb->name_off);
> > +
> > +     return cmp_btf_kind_name(ka, na, kb, nb);
>
> If both types are anonymous and have the same kind, this will lead to
> strcmp(NULL, NULL). On kernel side that would lead to null pointer
> dereference.

Thanks, I've confirmed that for anonymous types, name_off is 0,
so btf__str_by_offset returns a pointer to btf->strs_data (which
contains a '\0' at index 0) rather than NULL. However, when name_off
is invalid, btf__str_by_offset does return NULL. Using str_is_empty
will correctly handle both scenarios. Unnamed types of the same kind
shall be considered equal. I will fix it in the next version.

>
> > +}
> > +
> > +__s32 find_btf_by_name_kind(const struct btf *btf, int start_id,
> > +                                const char *type_name, __u32 kind)
>
> Nit: having functions with names btf_find_by_name_kind and
>                                  find_btf_by_name_kind
>      is very confusing.
>      Usually we use names like __<func> for auxiliary functions
>      like this.

Agreed. The function will be updated to __btf_find_by_name_kind
in the next version.

>
> > +{
> > +     const struct btf_type *t;
> > +     const char *tname;
> > +     __u32 i, total;
> > +
> > +     if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > +             return 0;
> > +
> > +     do {
> > +             if (btf__nr_sorted_types(btf)) {
> > +                     /* binary search */
> > +                     __s32 start, end, mid, found =3D -1;
> > +                     int ret;
> > +
> > +                     start =3D btf__start_id(btf);
> > +                     end =3D start + btf__nr_sorted_types(btf) - 1;
> > +                     /* found the leftmost btf_type that matches */
> > +                     while(start <=3D end) {
> > +                             mid =3D start + (end - start) / 2;
> > +                             t =3D btf_type_by_id(btf, mid);
> > +                             tname =3D btf__name_by_offset(btf, t->nam=
e_off);
> > +                             ret =3D cmp_btf_kind_name(BTF_INFO_KIND(t=
->info), tname,
> > +                                                     kind, type_name);
> > +                             if (ret =3D=3D 0)
> > +                                     found =3D mid;
> > +                             if (ret < 0)
> > +                                     start =3D mid + 1;
> > +                             else if (ret >=3D 0)
> > +                                     end =3D mid - 1;
> > +                     }
> > +
> > +                     if (found !=3D -1)
> > +                             return found;
> > +             } else {
> > +                     /* linear search */
> > +                     total =3D btf__type_cnt(btf);
> > +                     for (i =3D btf__start_id(btf); i < total; i++) {
> > +                             t =3D btf_type_by_id(btf, i);
> > +                             if (btf_kind(t) !=3D kind)
> > +                                     continue;
> > +
> > +                             tname =3D btf__name_by_offset(btf, t->nam=
e_off);
> > +                             if (tname && !strcmp(tname, type_name))
> > +                                     return i;
> > +                     }
> > +             }
> > +
> > +             btf =3D btf__base_btf(btf);
> > +     } while (btf && btf__start_id(btf) >=3D start_id);
> > +
> > +     return libbpf_err(-ENOENT);
> > +}
> > +
> > +void btf_check_sorted(struct btf *btf, int start_id)
> > +{
> > +     const struct btf_type *t;
> > +     int i, n, nr_sorted_types;
> > +
> > +     n =3D btf__type_cnt(btf);
> > +     if ((n - start_id) < BTF_CHECK_SORT_THRESHOLD)
> > +             return;
>
> Are there any measurable performance benefits from having this special ca=
se?

Sorry, I haven't run performance tests. The number 8 comes from the theoret=
ical
equivalence point where n/2 =E2=89=88 log2(n).

>
> > +
> > +     n--;
> > +     nr_sorted_types =3D 0;
> > +     for (i =3D start_id; i < n; i++) {
> > +             int k =3D i + 1;
> > +
> > +             t =3D btf_type_by_id(btf, i);
> > +             if (!btf__str_by_offset(btf, t->name_off))
> > +                     return;
>
> I am confused.
> This effectively bans BTFs with anonymous types,
> as btf__set_nr_sorted_types() wont be called if such types are found.
> Anonymous types are very common, e.g. all FUNC_PROTO are anonymous.

Thanks, I thought that for anonymous types, name_off would be 0,
and btf__str_by_offset would not return NULL. However if the name_off is
invalid, it will return NULL. So I plan to modify btf_compare_type_kinds_na=
mes
to cover both scenarios.


>
> > +
> > +             t =3D btf_type_by_id(btf, k);
> > +             if (!btf__str_by_offset(btf, t->name_off))
> > +                     return;
> > +
> > +             if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
> > +                     return;
> > +
> > +             if (t->name_off)
> > +                     nr_sorted_types++;
> > +     }
> > +
> > +     t =3D btf_type_by_id(btf, start_id);
> > +     if (t->name_off)
> > +             nr_sorted_types++;
> > +     if (nr_sorted_types >=3D BTF_CHECK_SORT_THRESHOLD)
> > +             btf__set_nr_sorted_types(btf, nr_sorted_types);
> > +}
> > +
>
> [...]

