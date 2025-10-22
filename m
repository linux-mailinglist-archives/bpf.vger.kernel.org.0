Return-Path: <bpf+bounces-71667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A1CBF9FDC
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 06:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 467AD4F8506
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 04:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91852DCF7C;
	Wed, 22 Oct 2025 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDfxuhR3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FE2D8774
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108439; cv=none; b=da94RFJTIVx4yxtTm8VEX56fu5b65TbOESv9Exp/UJ8UV2Tbs6UTvv1lY4DF08oxF/jeKbfRKsOagu0AlP7VpXsoMs/PWpv///X9P/0yaVU8EFAtfVFDDCbSzeUjZP6Ti8FmDKA08GU2qkL0b1NRVNeORXeLH78Mem/EbGiNSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108439; c=relaxed/simple;
	bh=+9yndkcis78f9w1XyQuFstKZvV0zZnIcdQNej7dvRww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAnqOI8IuWrn3oTLxuqGaXN2jyOzdLpc3EooV0F2rPlokMUxKECvDSlL29NC3WuUSDBsqkp6c7Yqmiv9WZBGzWM7856LIlBdIdZmd9212TrK1iqe4FZgasMP5gVgJeWW9SlyxX1fX9ENeZ6o0O2I/NksrUQVDXGV/ok5kKUJRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDfxuhR3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63e18829aa7so785783a12.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761108434; x=1761713234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KlBXvr97rmb9rqrS6zWQpB5Pxp/vP2yK2iTZxO07ZM=;
        b=GDfxuhR300B1cP6g/9RSC8K5HQUceuJZW1PVJzdz9TPYKVaa6kD32cvGSDelyThaZU
         okT34I6sCc6F/cDPWxhk3dYPvFrGeTFNFuPoUdLHmeyNIiBQZe2263TaGSRuoVxWuulk
         v5nLoC8tNvKkm+mCDu4Bcsi4o53dvv+5nQevc1Pv7U2lO+JvXoDaXacOfPtWSvC2hSaV
         54oNgFJ2xiFInUVs/INX7QJfNLA22AUbRNBRwGY2wB3nGM5xTJY6EeqRXr9jiitASuK+
         iYhhJtoOzWKvVGT39EghRAR+IPNUj0mMZTQPAy8NBNEzmO98CoqcEAFEEoWMZHhW0Run
         cm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761108434; x=1761713234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KlBXvr97rmb9rqrS6zWQpB5Pxp/vP2yK2iTZxO07ZM=;
        b=BPlqa5saVH7bdbj6DHI6MNOwfY0MUuOtSJC18Z9bJTs1yZdp92zAV/02iKc5O2BrmL
         DhhUkhj/JMeusZPbVVT9ZJ9VzXcbXZz4KXTXEO+6Ixqj0gmK/2nUE7SGphkPTM8rVFTJ
         jyFc455+gEj+rieNhtMtsOGnvYNgCAdNj3NrlrZCBsoxj5aJlah3f/ypHmAInMuU+bHl
         V4czLBkJ2OIM0XsEfvh7Y7ytkndVcQYtymrh1aGe7JNS4vjKOpojaMX3IeHY+0V6XCQU
         KsHlkcybfQfSHpu2ihBXLrl+Yk1B3y/g8yR2xxRbVv7ys0sRzgPX8pUuhngXARpRtopa
         3Atg==
X-Forwarded-Encrypted: i=1; AJvYcCUyOZKok6uZgf39AQJSvOyT2r+BLiBLPxwU0+gbqusW1UJeh2WUDcNumrUMSehLpk16W6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHU38lHxTWr1ort7N9Mc+cpQsjoiZ1hy/c4aeUx91CQZColAXN
	pGmS89FzP6VHPFuTif5eL1Td3+G0RRaj+Oq2A2n9pGcRR5vchNgUekSk5TRGWCbEyxHGdj6vF/b
	cRvsSLgA7Nn/YriuY2loeV11d4OP1VEg=
X-Gm-Gg: ASbGnculhmA2Qqu1z9qqhJUBNFt2xp0pGlMrTi0OO3fgrO1NV4UC6XUq+oE8r7XVSne
	tjXU4WKxGqB1Dda1ZPxdj4bc4oc7n1YD99qxOX3ntghiOnIo8T8yJ/9XUl8OBgo6yftr1Pt4pBr
	q/c8xzV33qPJvxNtBLVuLXiwK7migXUKfY1BDY18n13mbyuL4rL6YuxMw6Hs4KLbY/OTI4kVisy
	nk4qhQ6oSugkxBMrfIrmRf/VXPu/gM8vrzxjtFqjIfqeqD9+9+AYBB9tNxk5Q==
X-Google-Smtp-Source: AGHT+IHBnhMSU5mRb3TPO05V7/xYT70/RxXzLxW2OGoE5plHhztumdCUQKKvOEp1VDaXKIZZ9tXmmBNX12u95wC2ifc=
X-Received: by 2002:a05:6402:2686:b0:63c:1a7b:b3bb with SMTP id
 4fb4d7f45d1cf-63c1f631befmr19183886a12.1.1761108433545; Tue, 21 Oct 2025
 21:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <34a168e2-204d-47e2-9923-82d8ad645273@oracle.com>
In-Reply-To: <34a168e2-204d-47e2-9923-82d8ad645273@oracle.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 22 Oct 2025 12:47:00 +0800
X-Gm-Features: AS18NWBCI1jbEqx_cnB9CFvrdliurRtXQO8Nf34OFm4CFvwwjgCIu0-0Tu8BgzU
Message-ID: <CAErzpmuVM4p3AxB5OTEOTNrtuv+BM+kFVXQ2w6qmBCwFky466Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 20/10/2025 10:39, Donglin Peng wrote:
> > This patch implements sorting of BTF types by their kind and name,
> > enabling the use of binary search for type lookups.
> >
> > To share logic between kernel and libbpf, a new btf_sort.c file is
> > introduced containing common sorting functionality.
> >
> > The sorting is performed during btf__dedup() when the new
> > sort_by_kind_name option in btf_dedup_opts is enabled.
> >
> > For vmlinux and kernel module BTF, btf_check_sorted() verifies
> > whether the types are sorted and binary search can be used.
> >
>
> this looks great! one thing that might make libbpf integration easier
> though (and Andrii can probably best answer if it's actually a problem)
> - would it be possible to separate the libbpf and non-libbpf parts here;
> i.e have a patch that adds the libbpf stuff first, then re-use it in a
> separate patch for kernel sorting?

Thanks for the suggestion, I will split it in the next version.

>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> >  include/linux/btf.h             |  20 +++-
> >  kernel/bpf/Makefile             |   1 +
> >  kernel/bpf/btf.c                |  39 ++++----
> >  kernel/bpf/btf_sort.c           |   2 +
> >  tools/lib/bpf/Build             |   2 +-
> >  tools/lib/bpf/btf.c             | 163 +++++++++++++++++++++++++++-----
> >  tools/lib/bpf/btf.h             |   2 +
> >  tools/lib/bpf/btf_sort.c        | 159 +++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf_internal.h |   6 ++
> >  9 files changed, 347 insertions(+), 47 deletions(-)
> >  create mode 100644 kernel/bpf/btf_sort.c
> >  create mode 100644 tools/lib/bpf/btf_sort.c
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index ddc53a7ac7cd..c6fe5e689ab9 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -221,7 +221,10 @@ bool btf_is_vmlinux(const struct btf *btf);
> >  struct module *btf_try_get_module(const struct btf *btf);
> >  u32 btf_nr_types(const struct btf *btf);
> >  u32 btf_type_cnt(const struct btf *btf);
> > -struct btf *btf_base_btf(const struct btf *btf);
> > +u32 btf_start_id(const struct btf *btf);
> > +u32 btf_nr_sorted_types(const struct btf *btf);
> > +void btf_set_nr_sorted_types(struct btf *btf, u32 nr);
> > +struct btf* btf_base_btf(const struct btf *btf);
> >  bool btf_type_is_i32(const struct btf_type *t);
> >  bool btf_type_is_i64(const struct btf_type *t);
> >  bool btf_type_is_primitive(const struct btf_type *t);
> > @@ -595,6 +598,10 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *l=
og, enum bpf_prog_type prog_ty
> >  bool btf_types_are_same(const struct btf *btf1, u32 id1,
> >                       const struct btf *btf2, u32 id2);
> >  int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, i=
nt arg_idx);
> > +int btf_compare_type_kinds_names(const void *a, const void *b, void *p=
riv);
> > +s32 find_btf_by_name_kind(const struct btf *btf, int start_id, const c=
har *type_name,
> > +                       u32 kind);
> > +void btf_check_sorted(struct btf *btf, int start_id);
> >
> >  static inline bool btf_type_is_struct_ptr(struct btf *btf, const struc=
t btf_type *t)
> >  {
> > @@ -683,5 +690,16 @@ static inline int btf_check_iter_arg(struct btf *b=
tf, const struct btf_type *fun
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > +static inline int btf_compare_type_kinds_names(const void *a, const vo=
id *b, void *priv)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +static inline s32 find_btf_by_name_kind(const struct btf *btf, int sta=
rt_id, const char *type_name,
> > +                       u32 kind)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +static inline void btf_check_sorted(struct btf *btf, int start_id);
> > +{}
> >  #endif
> >  #endif
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 7fd0badfacb1..c9d8f986c7e1 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> >  ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> >  endif
> > +obj-$(CONFIG_BPF_SYSCALL) +=3D btf_sort.o
> >
> >  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
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
> >  }
> >
> >  s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
> > @@ -6239,6 +6236,7 @@ static struct btf *btf_parse_base(struct btf_veri=
fier_env *env, const char *name
> >       if (err)
> >               goto errout;
> >
> > +     btf_check_sorted(btf, 1);
> >       refcount_set(&btf->refcnt, 1);
> >
> >       return btf;
> > @@ -6371,6 +6369,7 @@ static struct btf *btf_parse_module(const char *m=
odule_name, const void *data,
> >               base_btf =3D vmlinux_btf;
> >       }
> >
> > +     btf_check_sorted(btf, btf_nr_types(base_btf));
> >       btf_verifier_env_free(env);
> >       refcount_set(&btf->refcnt, 1);
> >       return btf;
> > diff --git a/kernel/bpf/btf_sort.c b/kernel/bpf/btf_sort.c
> > new file mode 100644
> > index 000000000000..898f9189952c
> > --- /dev/null
> > +++ b/kernel/bpf/btf_sort.c
> > @@ -0,0 +1,2 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +#include "../../tools/lib/bpf/btf_sort.c"
> > diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> > index c80204bb72a2..ed7c2506e22d 100644
> > --- a/tools/lib/bpf/Build
> > +++ b/tools/lib/bpf/Build
> > @@ -1,4 +1,4 @@
> >  libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_utils.o \
> >           netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
> >           btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core=
.o \
> > -         usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
> > +         usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o btf_s=
ort.o
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 18907f0fcf9f..87e47f0b78ba 100644
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
> > @@ -92,6 +95,9 @@ struct btf {
> >        *   - for split BTF counts number of types added on top of base =
BTF.
> >        */
> >       __u32 nr_types;
> > +     /* number of named types in this BTF instance for binary search
> > +      */
> > +     __u32 nr_sorted_types;
> >       /* if not NULL, points to the base BTF on top of which the curren=
t
> >        * split BTF is based
> >        */
> > @@ -619,6 +625,21 @@ __u32 btf__type_cnt(const struct btf *btf)
> >       return btf->start_id + btf->nr_types;
> >  }
> >
> > +__u32 btf__start_id(const struct btf *btf)
> > +{
> > +     return btf->start_id;
> > +}
> > +
> > +__u32 btf__nr_sorted_types(const struct btf *btf)
> > +{
> > +     return btf->nr_sorted_types;
> > +}
> > +
> > +void btf__set_nr_sorted_types(struct btf *btf, __u32 nr)
> > +{
> > +     btf->nr_sorted_types =3D nr;
> > +}
> > +
> >  const struct btf *btf__base_btf(const struct btf *btf)
> >  {
> >       return btf->base_btf;
> > @@ -915,38 +936,16 @@ __s32 btf__find_by_name(const struct btf *btf, co=
nst char *type_name)
> >       return libbpf_err(-ENOENT);
> >  }
> >
> > -static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id=
,
> > -                                const char *type_name, __u32 kind)
> > -{
> > -     __u32 i, nr_types =3D btf__type_cnt(btf);
> > -
> > -     if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > -             return 0;
> > -
> > -     for (i =3D start_id; i < nr_types; i++) {
> > -             const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -             const char *name;
> > -
> > -             if (btf_kind(t) !=3D kind)
> > -                     continue;
> > -             name =3D btf__name_by_offset(btf, t->name_off);
> > -             if (name && !strcmp(type_name, name))
> > -                     return i;
> > -     }
> > -
> > -     return libbpf_err(-ENOENT);
> > -}
> > -
> >  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *ty=
pe_name,
> >                                __u32 kind)
> >  {
> > -     return btf_find_by_name_kind(btf, btf->start_id, type_name, kind)=
;
> > +     return find_btf_by_name_kind(btf, btf->start_id, type_name, kind)=
;
> >  }
> >
> >  __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_n=
ame,
> >                            __u32 kind)
> >  {
> > -     return btf_find_by_name_kind(btf, 1, type_name, kind);
> > +     return find_btf_by_name_kind(btf, 1, type_name, kind);
> >  }
> >
> >  static bool btf_is_modifiable(const struct btf *btf)
> > @@ -3411,6 +3410,7 @@ static int btf_dedup_struct_types(struct btf_dedu=
p *d);
> >  static int btf_dedup_ref_types(struct btf_dedup *d);
> >  static int btf_dedup_resolve_fwds(struct btf_dedup *d);
> >  static int btf_dedup_compact_types(struct btf_dedup *d);
> > +static int btf_dedup_compact_and_sort_types(struct btf_dedup *d);
> >  static int btf_dedup_remap_types(struct btf_dedup *d);
> >
> >  /*
> > @@ -3600,7 +3600,7 @@ int btf__dedup(struct btf *btf, const struct btf_=
dedup_opts *opts)
> >               pr_debug("btf_dedup_ref_types failed: %s\n", errstr(err))=
;
> >               goto done;
> >       }
> > -     err =3D btf_dedup_compact_types(d);
> > +     err =3D btf_dedup_compact_and_sort_types(d);
> >       if (err < 0) {
> >               pr_debug("btf_dedup_compact_types failed: %s\n", errstr(e=
rr));
> >               goto done;
> > @@ -3649,6 +3649,8 @@ struct btf_dedup {
> >        * BTF is considered to be immutable.
> >        */
> >       bool hypot_adjust_canon;
> > +     /* Sort btf_types by kind and time */
> > +     bool sort_by_kind_name;
> >       /* Various option modifying behavior of algorithm */
> >       struct btf_dedup_opts opts;
> >       /* temporary strings deduplication state */
> > @@ -3741,6 +3743,7 @@ static struct btf_dedup *btf_dedup_new(struct btf=
 *btf, const struct btf_dedup_o
> >
> >       d->btf =3D btf;
> >       d->btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > +     d->sort_by_kind_name =3D OPTS_GET(opts, sort_by_kind_name, false)=
;
> >
> >       d->dedup_table =3D hashmap__new(hash_fn, btf_dedup_equal_fn, NULL=
);
> >       if (IS_ERR(d->dedup_table)) {
> > @@ -5288,6 +5291,116 @@ static int btf_dedup_compact_types(struct btf_d=
edup *d)
> >       return 0;
> >  }
> >
> > +static __u32 *get_sorted_canon_types(struct btf_dedup *d, __u32 *cnt)
> > +{
> > +     int i, j, id, types_cnt =3D 0;
> > +     __u32 *sorted_ids;
> > +
> > +     for (i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_types; i++,=
 id++)
> > +             if (d->map[id] =3D=3D id)
> > +                     ++types_cnt;
> > +
> > +     sorted_ids =3D calloc(types_cnt, sizeof(*sorted_ids));
> > +     if (!sorted_ids)
> > +             return NULL;
> > +
> > +     for (j =3D 0, i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_ty=
pes; i++, id++)
> > +             if (d->map[id] =3D=3D id)
> > +                     sorted_ids[j++] =3D id;
> > +
> > +     qsort_r(sorted_ids, types_cnt, sizeof(*sorted_ids),
> > +             btf_compare_type_kinds_names, d->btf);
> > +
> > +     *cnt =3D types_cnt;
> > +
> > +     return sorted_ids;
> > +}
> > +
> > +/*
> > + * Compact and sort BTF types.
> > + *
> > + * Similar to btf_dedup_compact_types, but additionally sorts the btf_=
types.
> > + */
> > +static int btf__dedup_compact_and_sort_types(struct btf_dedup *d)
> > +{
> > +     __u32 canon_types_cnt =3D 0, canon_types_len =3D 0;
> > +     __u32 *new_offs =3D NULL, *canon_types =3D NULL;
> > +     const struct btf_type *t;
> > +     void *p, *new_types =3D NULL;
> > +     int i, id, len, err;
> > +
> > +     /* we are going to reuse hypot_map to store compaction remapping =
*/
> > +     d->hypot_map[0] =3D 0;
> > +     /* base BTF types are not renumbered */
> > +     for (id =3D 1; id < d->btf->start_id; id++)
> > +             d->hypot_map[id] =3D id;
> > +     for (i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_types; i++,=
 id++)
> > +             d->hypot_map[id] =3D BTF_UNPROCESSED_ID;
> > +
> > +     canon_types =3D get_sorted_canon_types(d, &canon_types_cnt);
> > +     if (!canon_types) {
> > +             err =3D -ENOMEM;
> > +             goto out_err;
> > +     }
> > +
> > +     for (i =3D 0; i < canon_types_cnt; i++) {
> > +             id =3D canon_types[i];
> > +             t =3D btf__type_by_id(d->btf, id);
> > +             len =3D btf_type_size(t);
> > +             if (len < 0) {
> > +                     err =3D len;
> > +                     goto out_err;
> > +             }
> > +             canon_types_len +=3D len;
> > +     }
> > +
> > +     new_offs =3D calloc(canon_types_cnt, sizeof(*new_offs));
> > +     new_types =3D calloc(canon_types_len, 1);
> > +     if (!new_types || !new_offs) {
> > +             err =3D -ENOMEM;
> > +             goto out_err;
> > +     }
> > +
> > +     p =3D new_types;
> > +
> > +     for (i =3D 0; i < canon_types_cnt; i++) {
> > +             id =3D canon_types[i];
> > +             t =3D btf__type_by_id(d->btf, id);
> > +             len =3D btf_type_size(t);
> > +             memcpy(p, t, len);
> > +             d->hypot_map[id] =3D d->btf->start_id + i;
> > +             new_offs[i] =3D p - new_types;
> > +             p +=3D len;
> > +     }
> > +
> > +     /* shrink struct btf's internal types index and update btf_header=
 */
> > +     free(d->btf->types_data);
> > +     free(d->btf->type_offs);
> > +     d->btf->types_data =3D new_types;
> > +     d->btf->type_offs =3D new_offs;
> > +     d->btf->types_data_cap =3D canon_types_len;
> > +     d->btf->type_offs_cap =3D canon_types_cnt;
> > +     d->btf->nr_types =3D canon_types_cnt;
> > +     d->btf->hdr->type_len =3D canon_types_len;
> > +     d->btf->hdr->str_off =3D d->btf->hdr->type_len;
> > +     d->btf->raw_size =3D d->btf->hdr->hdr_len + d->btf->hdr->type_len=
 + d->btf->hdr->str_len;
> > +     free(canon_types);
> > +     return 0;
> > +
> > +out_err:
> > +     free(canon_types);
> > +     free(new_types);
> > +     free(new_offs);
> > +     return err;
> > +}
> > +
> > +static int btf_dedup_compact_and_sort_types(struct btf_dedup *d)
> > +{
> > +     if (d->sort_by_kind_name)
> > +             return btf__dedup_compact_and_sort_types(d);
> > +     return btf_dedup_compact_types(d);
> > +}
> > +
> >  /*
> >   * Figure out final (deduplicated and compacted) type ID for provided =
original
> >   * `type_id` by first resolving it into corresponding canonical type I=
D and
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index ccfd905f03df..9a7cfe6b4bb3 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -251,6 +251,8 @@ struct btf_dedup_opts {
> >       size_t sz;
> >       /* optional .BTF.ext info to dedup along the main BTF info */
> >       struct btf_ext *btf_ext;
> > +     /* Sort btf_types by kind and name */
> > +     bool sort_by_kind_name;
> >       /* force hash collisions (used for testing) */
> >       bool force_collisions;
> >       size_t :0;
> > diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> > new file mode 100644
> > index 000000000000..2ad4a56f1c08
> > --- /dev/null
> > +++ b/tools/lib/bpf/btf_sort.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#ifdef __KERNEL__
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/string.h>
> > +
> > +#define btf_type_by_id                               (struct btf_type =
*)btf_type_by_id
> > +#define btf__str_by_offset                   btf_str_by_offset
> > +#define btf__name_by_offset                  btf_name_by_offset
> > +#define btf__type_cnt                                btf_nr_types
> > +#define btf__start_id                                btf_start_id
> > +#define btf__nr_sorted_types                 btf_nr_sorted_types
> > +#define btf__set_nr_sorted_types             btf_set_nr_sorted_types
> > +#define btf__base_btf                                btf_base_btf
> > +#define libbpf_err(x)                                x
> > +
> > +#else
> > +
> > +#include "btf.h"
> > +#include "bpf.h"
> > +#include "libbpf.h"
> > +#include "libbpf_internal.h"
> > +
> > +#endif /* __KERNEL__ */
> > +
> > +/* Skip the sorted check if number of btf_types is below threshold
> > + */
> > +#define BTF_CHECK_SORT_THRESHOLD  8
> > +
> > +struct btf;
> > +
> > +static int cmp_btf_kind_name(int ka, const char *na, int kb, const cha=
r *nb)
> > +{
> > +     return (ka - kb) ?: strcmp(na, nb);
> > +}
> > +
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
> > +}
> > +
> > +__s32 find_btf_by_name_kind(const struct btf *btf, int start_id,
> > +                                const char *type_name, __u32 kind)
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
> > +
> > +     n--;
> > +     nr_sorted_types =3D 0;
> > +     for (i =3D start_id; i < n; i++) {
> > +             int k =3D i + 1;
> > +
> > +             t =3D btf_type_by_id(btf, i);
> > +             if (!btf__str_by_offset(btf, t->name_off))
> > +                     return;
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
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index 35b2527bedec..f71f3e70c51c 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -248,6 +248,12 @@ const struct btf_type *skip_mods_and_typedefs(cons=
t struct btf *btf, __u32 id, _
> >  const struct btf_header *btf_header(const struct btf *btf);
> >  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
> >  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **=
id_map);
> > +int btf_compare_type_kinds_names(const void *a, const void *b, void *p=
riv);
> > +__s32 find_btf_by_name_kind(const struct btf *btf, int start_id, const=
 char *type_name, __u32 kind);
> > +void btf_check_sorted(struct btf *btf, int start_id);
> > +__u32 btf__start_id(const struct btf *btf);
> > +__u32 btf__nr_sorted_types(const struct btf *btf);
> > +void btf__set_nr_sorted_types(struct btf *btf, __u32 nr);
> >
> >  static inline enum btf_func_linkage btf_func_linkage(const struct btf_=
type *t)
> >  {
>

