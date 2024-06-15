Return-Path: <bpf+bounces-32220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10AB909807
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 13:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5611C211C5
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 11:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB6446DB;
	Sat, 15 Jun 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXgqHE/m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E045023;
	Sat, 15 Jun 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718452175; cv=none; b=O2kC6PaqzLd21M4oWFXMYjRQVGGOz7BWP+84eNvlhmb0txFbr+cQqQF5Dq+/7BMylocEgddkgEIuiVxKD2betmYrPHXbtn4rKk4RssPY+lVxRlBDNf/b+oXDyvgUlIAjRiZyoYNvRIlyUcDKzeatvhdY5zNvO229iLh40rD7lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718452175; c=relaxed/simple;
	bh=OxsDCVvFmZDdn4b0BWUpauwRblw62cawRbkJDq1lF+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tt/PgUO0HcIqHlWMKBXvwsz6pDiDfmzkd8+oiIwp1Teidjp/XkLfEzA56AszQeqUUPYS0g1RzSn8sux17CJ1tDQQzDUhwpXuUvJcBoHBwupF/+ws4N9ajHr8fttS4L7F/Q0wGtVjGdnHGtrQG7n7TFjKFmz7LLnvDo1NSgrczA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXgqHE/m; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso339515966b.0;
        Sat, 15 Jun 2024 04:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718452172; x=1719056972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmwpWJqTuK2KpyOhWn70TPuN3f/5XJxgMHjGCJWbC38=;
        b=FXgqHE/mvROs8pcPtueW1H80ZQ6p1KZ725fij8k7qepnl8zkV6pazNrxXjEkcom2OO
         V9+ZB/d7cg8lEgPpuoTSF+KKD0JRtayNtnL9w8Al1bdknXmIieRxT2tf0BxPUgAfEUCW
         WGRT1VsKUMqqXc6J3ZNwV4Iyo/atyNEwkd5mZwSirsS4CT0OQAC3y6/BNptOqiF1s7I8
         cUrRvT6hFqmoW/eK6schNiXOfui0IPK31+L7xfU/hXWuHQNVDLPO5LG3LJ6ec18j0SDv
         K70e8a9CKgHlMinVSrEkmU80FIaNXE5dYbrEJkdncENWXlIZEshRon4ezqoYF5lbP+lx
         CTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718452172; x=1719056972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmwpWJqTuK2KpyOhWn70TPuN3f/5XJxgMHjGCJWbC38=;
        b=NSU63cY0/Si20oDvM5RLO90K0v0/F0ODeFomMDChWvdzQLSi726ilVgNJSM29Q5UV3
         aemucE/bUlNJvNK5SKSYbb5JijReWqHL5N3FCZMzPGQidoolSVNtihOx9OXXXFaEGoGj
         YRpU//Ha92zW3JHh8q19RiTU5pyGjqTuw/sTClKrZqhfmAzIBoHb+DDhu30Ui6S8DsKf
         mi/Ly7+nuMc45rRFTKVYGwhC0f63MMXbulNa7saICN80mXYdRTaDykZEx8gZ0d6CnxKE
         8Nd5umDYFgpmjVSWkWvYT/yFi0wb1xqmBUslpfkVh6La8c+Mjzti54qWkzKzWVOC51+l
         mpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnBI3pDEhJmZ1I1SSKr3tiBQFqJdKJ67o1cVnwH5mBjHdV657keJa+WD3/7lIgmT0sXFkZdqOsBYF4YczMOEGAwiCVFEceppxCnQB8ZjAoL7+8x6w5X/AaOP95Wic+ghhz
X-Gm-Message-State: AOJu0Yw6WI53N1FpcjyNwZ1RjjMHngVIvDOJCE0OU28uPiqhzJrdvoHp
	+17UOPMgJgmIV8xBe0LHHK+JZTOJwfLwTgSRMiqxrCc1d5A/xcMEzUHUO9Et3QAsfN+PLY0ezBr
	9Nmr2n0sdYQG41oGVgAO1LV0WahY=
X-Google-Smtp-Source: AGHT+IFxR+Wzw5GJUuAJyMsGu2IVbRo0bdsH0bHXeCy0tKDMJ2ODk1f+1XyyevV5XalEw6L3dTONayV4wiwT70F2Df8=
X-Received: by 2002:a17:906:f148:b0:a68:86b9:52e8 with SMTP id
 a640c23a62f3a-a6f60de6264mr338305266b.68.1718452171866; Sat, 15 Jun 2024
 04:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608140835.965949-1-dolinux.peng@gmail.com> <4f551dc5fc792936ca364ce8324c0adea38162f1.camel@gmail.com>
In-Reply-To: <4f551dc5fc792936ca364ce8324c0adea38162f1.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 15 Jun 2024 19:49:18 +0800
Message-ID: <CAErzpmsvvi_dhiJs+Fmyy7R-gKqh3TkiuJCj4U5K6XXJyV6pJA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii <andrii@kernel.org>, alan.maguire@oracle.com, 
	acme@kernel.org, daniel@iogearbox.net, mhiramat@kernel.org, song@kernel.org, 
	haoluo@google.com, yonghong.song@linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2024-06-08 at 07:08 -0700, Donglin Peng wrote:
>
> [...]
>
> > Changes in RFC v3:
> >  - Sort the btf types during the build process in order to reduce memor=
y usage
> >    and decrease boot time.
> >
> > RFC v2:
> >  - https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sang=
for.com.cn
> > ---
> >  include/linux/btf.h |   1 +
> >  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++---
>
> I think that kernel part is in a good shape,
> please split it as a separate commit.

Okay, thanks.

>
> >  tools/lib/bpf/btf.c | 195 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 345 insertions(+), 11 deletions(-)
>
> [...]
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 2d0840ef599a..93c1ab677bfa 100644
>
> I'm not sure that libbpf is the best place to put this functionality,
> as there might be different kinds of orderings
> (e.g. see a fresh commit to bpftool to output stable vmlinux.h:
>  94133cf24bb3 "bpftool: Introduce btf c dump sorting").

Thanks, I think it would be better to put it into the libbpf. However, I wo=
uld
also like to hear the opinions of others.

>
> I'm curious what Andrii, Alan and Arnaldo think on libbpf vs pahole
> for this feature.
>
> Also, I have a selftests build failure with this patch-set
> (and I suspect that a bunch of dedup test cases would need an update):

I appologize for the bug in my patch that caused the issue. I will fix it.

>
> $ pwd
> /home/eddy/work/bpf-next/tools/testing/selftests/bpf
> $ make -j14 test_progs
> ...
>
>   GEN-SKEL [test_progs] access_map_in_map.skel.h
> Binary files /home/eddy/work/bpf-next/tools/testing/selftests/bpf/access_=
map_in_map.bpf.linked2.o and /home/eddy/work/bpf-next/tools/testing/selftes=
ts/bpf/access_map_in_map.bpf.linked3.o differ
> make: *** [Makefile:658: /home/eddy/work/bpf-next/tools/testing/selftests=
/bpf/access_map_in_map.skel.h] Error 1
> make: *** Waiting for unfinished jobs....

Sorry, I neglected to perform an ID remap for the btf_types in the BTF.ext
section. I will fix it.

>
> If this change remains in libbpf, I think it would be great to update
> btf_find_by_name_kind() to work the same way as kernel one.

Sounds good, we might do it later.

>
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [...]
>
> > +static int btf_sort_type_by_name(struct btf *btf)
> > +{
> > +     struct btf_type *bt;
> > +     __u32 *new_type_offs =3D NULL, *new_type_offs_noname =3D NULL;
> > +     __u32 *maps =3D NULL, *found_offs;
> > +     void *new_types_data =3D NULL, *loc_data;
> > +     int i, j, k, type_cnt, ret =3D 0, type_size;
> > +     __u32 data_size;
> > +
> > +     if (btf_ensure_modifiable(btf))
> > +             return libbpf_err(-ENOMEM);
> > +
> > +     type_cnt =3D btf->nr_types;
> > +     data_size =3D btf->type_offs_cap * sizeof(*new_type_offs);
> > +
> > +     maps =3D (__u32 *)malloc(type_cnt * sizeof(__u32));
> > +     if (!maps) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     new_type_offs =3D (__u32 *)malloc(data_size);
> > +     if (!new_type_offs) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     new_type_offs_noname =3D (__u32 *)malloc(data_size);
> > +     if (!new_type_offs_noname) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
>
> What is the point of separating offsets in new_type_offs vs
> new_type_offs_noname? It should be possible to use a single offsets
> array and have a comparison function that puts all named types before
> unnamed.

Great, you are right.

>
> > +
> > +     new_types_data =3D malloc(btf->types_data_cap);
> > +     if (!new_types_data) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     memset(new_type_offs, 0, data_size);
> > +
> > +     for (i =3D 0, j =3D 0, k =3D 0; i < type_cnt; i++) {
> > +             const char *name;
> > +
> > +             bt =3D (struct btf_type *)(btf->types_data + btf->type_of=
fs[i]);
> > +             name =3D btf__str_by_offset(btf, bt->name_off);
> > +             if (!name || !name[0])
> > +                     new_type_offs_noname[k++] =3D btf->type_offs[i];
> > +             else
> > +                     new_type_offs[j++] =3D btf->type_offs[i];
> > +     }
> > +
> > +     memmove(new_type_offs + j, new_type_offs_noname, sizeof(__u32) * =
k);
> > +
> > +     qsort_r(new_type_offs, j, sizeof(*new_type_offs),
> > +             btf_compare_type_name, btf);
> > +
> > +     for (i =3D 0; i < type_cnt; i++) {
> > +             found_offs =3D bsearch(&new_type_offs[i], btf->type_offs,=
 type_cnt,
> > +                                     sizeof(__u32), btf_compare_offs);
> > +             if (!found_offs) {
> > +                     ret =3D -EINVAL;
> > +                     goto err_out;
> > +             }
> > +             maps[found_offs - btf->type_offs] =3D i;
> > +     }
> > +
> > +     loc_data =3D new_types_data;
> > +     for (i =3D 0; i < type_cnt; i++, loc_data +=3D type_size) {
> > +             bt =3D (struct btf_type *)(btf->types_data + new_type_off=
s[i]);
> > +             type_size =3D btf_type_size(bt);
> > +             if (type_size < 0) {
> > +                     ret =3D type_size;
> > +                     goto err_out;
> > +             }
> > +
> > +             memcpy(loc_data, bt, type_size);
> > +
> > +             bt =3D (struct btf_type *)loc_data;
> > +             switch (btf_kind(bt)) {
>
> Please take a look at btf_dedup_remap_types(): it uses newly added
> iterator interface to enumerate all ID references in the type.
> It could be used here to avoid enumerating every BTF kind.
> Also, the d->hypot_map could be used instead of `maps`.
> And if so, I think that it should be possible to put this pass before
> btf_dedup_remap_types() in order for it to do the remapping.

Thank you. I will revise the code.

>
> Alternatively, it might make sense to merge this pass with
> btf_dedup_compact_types() in order to minimize number of operations,
> e.g. as in my crude attempt:
> https://github.com/eddyz87/bpf/tree/binsort-btf-dedup

Thank you. I would refer to your patch.

> (fails with similar selftests issue).

In addition to the bug in my patch, I have also identified a bug in
linker_fixup_btf
in the libbpf. After resolving the issue, the selftests successfully
passed, and I will
create a new patch to address the bug.

>
> > +             case BTF_KIND_PTR:
> > +             case BTF_KIND_CONST:
> > +             case BTF_KIND_VOLATILE:
> > +             case BTF_KIND_RESTRICT:
> > +             case BTF_KIND_TYPEDEF:
> > +             case BTF_KIND_TYPE_TAG:
> > +             case BTF_KIND_FUNC:
> > +             case BTF_KIND_VAR:
> > +             case BTF_KIND_DECL_TAG:
> > +                     bt->type =3D btf_get_mapped_type(btf, maps, bt->t=
ype);
> > +                     break;
>
> [...]

