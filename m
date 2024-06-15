Return-Path: <bpf+bounces-32222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584559098BB
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA1AB2155C
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E3249634;
	Sat, 15 Jun 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVtV0BqD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B863383B1;
	Sat, 15 Jun 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718463634; cv=none; b=dQrtVR8o5WIJ6JRpwk8kKEJ0l37grPKzqQJ3luW1sxOQ6pfucfTHLV5fFyrsSOOcGxMk/2OUhJev6uWZo50n0auB7lh/Kyu/ifya1zJaJC3U6e5eaMBsIUe5Kht9X9fbcV77XqvX/KbbNlqH/kOEPAUJAF5FaZr0N/Lcyfyqn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718463634; c=relaxed/simple;
	bh=O3iuGl3+px74waJXsghtQUNjK/fdJTb8plYFzY1DvF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0505v05vSNwoqB2TnoU3U1aK9Wlyxeujtj0iyDVa0TiZUqPTyuyLFnBQd33ETM61gEt4impPEph9DvjW96xZL62f2cuHLTF6jJhaOke3YBqKVOQ6Ac2MfWv54ew5N1jzsS2rHUTP1PZ2tSCYipvruatlcbnS5yLW+Vs3iHNvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVtV0BqD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6efe62f583so308729366b.3;
        Sat, 15 Jun 2024 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718463629; x=1719068429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhQP1QnteGRcdexKLdGEI+TBHaXqjwDdr6iuda4pIlo=;
        b=ZVtV0BqDtqgr6JNCakt14yOLqr+3vNq3DNy2+p5WMTtjaOH7tqwjbS2ioiiq/HgWO8
         MORJM53vN0oBoAhnp7Ss25kdzbQzlB4/kPNKkUx7QIquMFMEvxn6Fs3bXGINzB7Qidqk
         Rtm+KpmvuYctq1kz3H9DRfwxXXHQpN0wv3Qrd05HtDtHPr/8VRN73DO0B0hesG41w5uS
         mtTUZNO6uZPEi1l08eSukWro+wk+f+sWtCE+ob0h9Wt2SNLJ9oHEITbH6oL5TNfNvuBs
         /kiSAlyAMD7tUsvqT1JXixjb7bPLv9J2uOBgLEExyu76O8T149WMYpRaAUTESoLPnDRM
         fVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718463629; x=1719068429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhQP1QnteGRcdexKLdGEI+TBHaXqjwDdr6iuda4pIlo=;
        b=EeQztljVgBh+f79SeTWEKhj0rUmSKMj5zVoRmbeK0cBWVI70G84zplxuPRQU16MTUF
         MaP4T1x8WNV2gReu/BaP5SafLiZ6ljDVnOym+vdONBX2aa4alAcfYmLmZEh8040DjtJw
         fOPJ6i8+8uuompSCgLvHQH0hzfXh/km1uD5S8NX/b3rvXr9OcwEhcMaoeb/9eQlybT+G
         mzHo/0/6afk7cYmkKxEbS//Y+LKbzDDaVaMviTwU4kmTP+/5wGbXueXNZIPQKycF2C1j
         RT6vthqVSPGvzTIWqRZlNmbwu175NFvzrbh3xRvtdWhlOkCCCYL9CKCFGUOjgI2JiCap
         DrFg==
X-Forwarded-Encrypted: i=1; AJvYcCUcn8XNpWCN63/TEPYWI+ytJpYt9o/jhTSH7M81wRTlGllEqqCkolzWp484O+KBKZ7zbkUthWs8AoYPQfa7tCG0ZpC7b/uC6XYkpDVQxC5pc/74isw490ZeqdaM0Gq4oCcq
X-Gm-Message-State: AOJu0YwxoAQJ7pjYGHtjeXYaJ5dFncoGFAMO54E24hkuFq9IITkio6yz
	oWtlbTIxect0V/3j0yYZiODqu00AD/fNI0j6EO9iU3fXklfMcAuVzEIrFlRVCEJpV0Xxoy1xcua
	Qmvr5+pfZunjfTMmfskFKWx3yXj0=
X-Google-Smtp-Source: AGHT+IHvSqLJxwTe+hhiLgHac3QRZ0NOy2f4er6eiOwqnZ37S5XRC4oS9r1O8aJnGbqFMYmvefYgZRpKc0BkrN/y4O8=
X-Received: by 2002:a17:906:40d7:b0:a6e:fe01:18cf with SMTP id
 a640c23a62f3a-a6f60d298d1mr308337466b.25.1718463629055; Sat, 15 Jun 2024
 08:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608140835.965949-1-dolinux.peng@gmail.com>
 <4f551dc5fc792936ca364ce8324c0adea38162f1.camel@gmail.com> <CAErzpmsvvi_dhiJs+Fmyy7R-gKqh3TkiuJCj4U5K6XXJyV6pJA@mail.gmail.com>
In-Reply-To: <CAErzpmsvvi_dhiJs+Fmyy7R-gKqh3TkiuJCj4U5K6XXJyV6pJA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 15 Jun 2024 22:59:56 +0800
Message-ID: <CAErzpmsBBnGNEgBzUfZyRcSeV1KLuNKvFfhuCap6NFbxG=qoKw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii <andrii@kernel.org>, alan.maguire@oracle.com, 
	acme@kernel.org, daniel@iogearbox.net, mhiramat@kernel.org, song@kernel.org, 
	haoluo@google.com, yonghong.song@linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 7:49=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Tue, Jun 11, 2024 at 6:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Sat, 2024-06-08 at 07:08 -0700, Donglin Peng wrote:
> >
> > [...]
> >
> > > Changes in RFC v3:
> > >  - Sort the btf types during the build process in order to reduce mem=
ory usage
> > >    and decrease boot time.
> > >
> > > RFC v2:
> > >  - https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sa=
ngfor.com.cn
> > > ---
> > >  include/linux/btf.h |   1 +
> > >  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++---
> >
> > I think that kernel part is in a good shape,
> > please split it as a separate commit.
>
> Okay, thanks.
>
> >
> > >  tools/lib/bpf/btf.c | 195 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 345 insertions(+), 11 deletions(-)
> >
> > [...]
> >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 2d0840ef599a..93c1ab677bfa 100644
> >
> > I'm not sure that libbpf is the best place to put this functionality,
> > as there might be different kinds of orderings
> > (e.g. see a fresh commit to bpftool to output stable vmlinux.h:
> >  94133cf24bb3 "bpftool: Introduce btf c dump sorting").
>
> Thanks, I think it would be better to put it into the libbpf. However, I =
would
> also like to hear the opinions of others.
>
> >
> > I'm curious what Andrii, Alan and Arnaldo think on libbpf vs pahole
> > for this feature.
> >
> > Also, I have a selftests build failure with this patch-set
> > (and I suspect that a bunch of dedup test cases would need an update):

Yes=EF=BC=8Cmany test cases need to be updated as the BTF layout is modifie=
d
unconditionally.

>
> I appologize for the bug in my patch that caused the issue. I will fix it=
.
>
> >
> > $ pwd
> > /home/eddy/work/bpf-next/tools/testing/selftests/bpf
> > $ make -j14 test_progs
> > ...
> >
> >   GEN-SKEL [test_progs] access_map_in_map.skel.h
> > Binary files /home/eddy/work/bpf-next/tools/testing/selftests/bpf/acces=
s_map_in_map.bpf.linked2.o and /home/eddy/work/bpf-next/tools/testing/selft=
ests/bpf/access_map_in_map.bpf.linked3.o differ
> > make: *** [Makefile:658: /home/eddy/work/bpf-next/tools/testing/selftes=
ts/bpf/access_map_in_map.skel.h] Error 1
> > make: *** Waiting for unfinished jobs....
>
> Sorry, I neglected to perform an ID remap for the btf_types in the BTF.ex=
t
> section. I will fix it.
>
> >
> > If this change remains in libbpf, I think it would be great to update
> > btf_find_by_name_kind() to work the same way as kernel one.
>
> Sounds good, we might do it later.
>
> >
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> >
> > [...]
> >
> > > +static int btf_sort_type_by_name(struct btf *btf)
> > > +{
> > > +     struct btf_type *bt;
> > > +     __u32 *new_type_offs =3D NULL, *new_type_offs_noname =3D NULL;
> > > +     __u32 *maps =3D NULL, *found_offs;
> > > +     void *new_types_data =3D NULL, *loc_data;
> > > +     int i, j, k, type_cnt, ret =3D 0, type_size;
> > > +     __u32 data_size;
> > > +
> > > +     if (btf_ensure_modifiable(btf))
> > > +             return libbpf_err(-ENOMEM);
> > > +
> > > +     type_cnt =3D btf->nr_types;
> > > +     data_size =3D btf->type_offs_cap * sizeof(*new_type_offs);
> > > +
> > > +     maps =3D (__u32 *)malloc(type_cnt * sizeof(__u32));
> > > +     if (!maps) {
> > > +             ret =3D -ENOMEM;
> > > +             goto err_out;
> > > +     }
> > > +
> > > +     new_type_offs =3D (__u32 *)malloc(data_size);
> > > +     if (!new_type_offs) {
> > > +             ret =3D -ENOMEM;
> > > +             goto err_out;
> > > +     }
> > > +
> > > +     new_type_offs_noname =3D (__u32 *)malloc(data_size);
> > > +     if (!new_type_offs_noname) {
> > > +             ret =3D -ENOMEM;
> > > +             goto err_out;
> > > +     }
> >
> > What is the point of separating offsets in new_type_offs vs
> > new_type_offs_noname? It should be possible to use a single offsets
> > array and have a comparison function that puts all named types before
> > unnamed.
>
> Great, you are right.
>
> >
> > > +
> > > +     new_types_data =3D malloc(btf->types_data_cap);
> > > +     if (!new_types_data) {
> > > +             ret =3D -ENOMEM;
> > > +             goto err_out;
> > > +     }
> > > +
> > > +     memset(new_type_offs, 0, data_size);
> > > +
> > > +     for (i =3D 0, j =3D 0, k =3D 0; i < type_cnt; i++) {
> > > +             const char *name;
> > > +
> > > +             bt =3D (struct btf_type *)(btf->types_data + btf->type_=
offs[i]);
> > > +             name =3D btf__str_by_offset(btf, bt->name_off);
> > > +             if (!name || !name[0])
> > > +                     new_type_offs_noname[k++] =3D btf->type_offs[i]=
;
> > > +             else
> > > +                     new_type_offs[j++] =3D btf->type_offs[i];
> > > +     }
> > > +
> > > +     memmove(new_type_offs + j, new_type_offs_noname, sizeof(__u32) =
* k);
> > > +
> > > +     qsort_r(new_type_offs, j, sizeof(*new_type_offs),
> > > +             btf_compare_type_name, btf);
> > > +
> > > +     for (i =3D 0; i < type_cnt; i++) {
> > > +             found_offs =3D bsearch(&new_type_offs[i], btf->type_off=
s, type_cnt,
> > > +                                     sizeof(__u32), btf_compare_offs=
);
> > > +             if (!found_offs) {
> > > +                     ret =3D -EINVAL;
> > > +                     goto err_out;
> > > +             }
> > > +             maps[found_offs - btf->type_offs] =3D i;
> > > +     }
> > > +
> > > +     loc_data =3D new_types_data;
> > > +     for (i =3D 0; i < type_cnt; i++, loc_data +=3D type_size) {
> > > +             bt =3D (struct btf_type *)(btf->types_data + new_type_o=
ffs[i]);
> > > +             type_size =3D btf_type_size(bt);
> > > +             if (type_size < 0) {
> > > +                     ret =3D type_size;
> > > +                     goto err_out;
> > > +             }
> > > +
> > > +             memcpy(loc_data, bt, type_size);
> > > +
> > > +             bt =3D (struct btf_type *)loc_data;
> > > +             switch (btf_kind(bt)) {
> >
> > Please take a look at btf_dedup_remap_types(): it uses newly added
> > iterator interface to enumerate all ID references in the type.
> > It could be used here to avoid enumerating every BTF kind.
> > Also, the d->hypot_map could be used instead of `maps`.
> > And if so, I think that it should be possible to put this pass before
> > btf_dedup_remap_types() in order for it to do the remapping.
>
> Thank you. I will revise the code.
>
> >
> > Alternatively, it might make sense to merge this pass with
> > btf_dedup_compact_types() in order to minimize number of operations,
> > e.g. as in my crude attempt:
> > https://github.com/eddyz87/bpf/tree/binsort-btf-dedup

Could you please provide me with the patch?

>
> Thank you. I would refer to your patch.
>
> > (fails with similar selftests issue).
>
> In addition to the bug in my patch, I have also identified a bug in
> linker_fixup_btf
> in the libbpf. After resolving the issue, the selftests successfully
> passed, and I will
> create a new patch to address the bug.

After fixing the bug, the "make test_progs" command passes
successfully. However,
the dedup test cases are still failing.

>
> >
> > > +             case BTF_KIND_PTR:
> > > +             case BTF_KIND_CONST:
> > > +             case BTF_KIND_VOLATILE:
> > > +             case BTF_KIND_RESTRICT:
> > > +             case BTF_KIND_TYPEDEF:
> > > +             case BTF_KIND_TYPE_TAG:
> > > +             case BTF_KIND_FUNC:
> > > +             case BTF_KIND_VAR:
> > > +             case BTF_KIND_DECL_TAG:
> > > +                     bt->type =3D btf_get_mapped_type(btf, maps, bt-=
>type);
> > > +                     break;
> >
> > [...]

