Return-Path: <bpf+bounces-67357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB8B42D82
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B590416CAD1
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B5427A12D;
	Wed,  3 Sep 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaB8+Zhb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358E1E3DE5
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942777; cv=none; b=bH2NXkb447Y4Obd68DxXE6qL7f/bfTIOuTyJy07pCt87LUA4RsLDythgTS5/KxIFtOuA2qL6HWESKYZl22OXLkWe9B5kfHnp7nDefozLkhpYZwOrVM9Sh5R34FLU13HHzhhNSpZeifkNLp1FGgt6Lrw6i6y4SOg0bAW8P09aUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942777; c=relaxed/simple;
	bh=/klvQJLcfSyYfchqQwNFWPTmAPJdwyP2k2E0pNDxO2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzwpuwgQ/MUlNdblMS4rKdg1S8ifkSu5C9UlxI/TrIt1NgE3z+ea0Ls0RQlsXGc4E48xFfFrQR0ziQ1YJKGksH9wfhcxQW1M47E3TK2lSkreBNd61yTwW4gA0V2B5DJ4Xt2L1o6Rfgxn/w3N0S1+y5Mn0o59g2hiq0lr9/1pSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaB8+Zhb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso444017b3a.2
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756942775; x=1757547575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu1GEUBHPSBtfQkeVnJcVeM8e7MsW0xfNj1WE53HTVA=;
        b=HaB8+ZhbdzMvg4HOFMvzQdpwG64OWMu0YywIkiAMLFBrohpU/graaccKxkpDh/75CT
         EgWIQ8smq6LPDjdObcGEpeXYaHHZKQQxPO4NQS6d8SOTxoSso8DHcOc6TdVCAkF6z8ff
         DGAvQxskGWtLlNrLeKDBD5/4qVfRQZTFZwhNR2+6euBZ59fYMy3QYnZL1VTKAcXRrDfE
         swlGLP1ZxOGu1pQ3cSLZemOO/YE5HbqZbM8c/2Q+4AD0O/8HhBe/D/PAyhezugJ4P2WO
         uA6XVVu54zNIklGzDkfdMKn75WRyn9zeIR+hpq49Ur/QFQ3PUbi22N0Yxstvss+nlCe/
         Y48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942775; x=1757547575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uu1GEUBHPSBtfQkeVnJcVeM8e7MsW0xfNj1WE53HTVA=;
        b=wZOGcCm+v2osv7oY7YxuPxnIpEXiQW7m/QZ2TfPvual/nsYTfq23U4oY5tE8Fr/P/5
         UUwMQ5sxo9dlYxVtECrti3UoTnwA1pFP8V+JQk6RjyIlseaB5kmCERjf6GyYZNgFTLn5
         d4Ql+PlT7j0ubPsSS6TgJDu61n0T0DmjRw3pguYJOtbNoDUhKsvQqjpi4o1i5tBMZjld
         grnXfB17rhCPVK2TAtrwqJCbP/y9jJ2/YElxXqQrqfEJT5TI/rofhR8kAuPRide2ZHOi
         aTP56XafO/fG2CtyzadzSImKSj6i7dfIkX//1+BuHSJ8Neq4+9MdfPzQDw3BwX0/pN/I
         jdHw==
X-Forwarded-Encrypted: i=1; AJvYcCUZr3VidLA9IuCmyksS2YfZCbEtZRoF0kFyM15nM/avfqhuFFMgRTjXS+1yEGWxiFiwArI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0XNlTWJopyNBfwd5+t55t1S7Vvt51PAVaVKvC7OJSmSt//y4
	YWA4BWwY3BkmKco1BwMz129y5RM+HpDqHtfeA2GdgQYL3kIoVmZqrp+KTVcLwLx80JMt//YAwcy
	Gn1SojU6MgV98ihfi+7r4Vr279oXUW0M=
X-Gm-Gg: ASbGnctHf1ZXjqXZPqfGYRQ6L9UcIoiGTm5tVZEBo6UVVfCc+BoZrGU9Ei+Oz6BSjaM
	qSZ2IOgMd85s4r0bLHKyZOk7M/mwABvk/0m20fFHx4u7e+7gTvZwx2mql2mcTdfshZAJm8LREqr
	i1rhqaxt60yNKF8jshNYuBvD3sdDhpy+rV13/ynm3EN9IZqR5w8bBtBkujNu7HjD4DMC4At8BpP
	wg1lSOmnCqvyF4uvB7ksrNpgV5vQK0mqw==
X-Google-Smtp-Source: AGHT+IGnRJkxxrbWi0I7T2z6RPvlhQxhR1NvmdJJrLKXcEBLbgJcqVnzAYOxoKBt+3Xmt8iIxuBihyU/VzPkTawiekg=
X-Received: by 2002:a17:903:198b:b0:248:e716:9892 with SMTP id
 d9443c01a7336-24944b22091mr214249345ad.59.1756942774471; Wed, 03 Sep 2025
 16:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903170411.69188-1-leon.hwang@linux.dev> <CAADnVQL-Zj95bfOxkxc2tf9CKvUSCt4PKdoQMZtqaiirzPLxvw@mail.gmail.com>
In-Reply-To: <CAADnVQL-Zj95bfOxkxc2tf9CKvUSCt4PKdoQMZtqaiirzPLxvw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Sep 2025 16:39:20 -0700
X-Gm-Features: Ac12FXwNL6qoN5ZVD21kIx2y6ZnXz2_nop8D5Yuntdm4c2nKr0X2ybW6Bcno9ds
Message-ID: <CAEf4BzYmX9RfOwArEAa+XW+uVzqUUy-5gjenog+ZvDjxGa80SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Generalize data copying for percpu maps
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:36=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 3, 2025 at 10:04=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
> >
> > While adding support for the BPF_F_CPU and BPF_F_ALL_CPUS flags, the da=
ta
> > copying logic of the following percpu map types needs to be updated:
> >
> > * percpu_array
> > * percpu_hash
> > * lru_percpu_hash
> > * percpu_cgroup_storage
> >
> > Following Andrii=E2=80=99s suggestion[0], this patch refactors the data=
 copying

as flattering as that is, "Andrii's suggestion" is no justification
why the patch is correct :)

> > logic by introducing two helpers:
> >
> > * `bpf_percpu_copy_to_user()`
> > * `bpf_percpu_copy_from_user()`
> >
> > This prepares the codebase for the upcoming CPU flag support.
> >
> > [0] https://lore.kernel.org/bpf/20250827164509.7401-1-leon.hwang@linux.=
dev/
> >
> > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  include/linux/bpf.h        | 29 ++++++++++++++++++++++++++++-
> >  kernel/bpf/arraymap.c      | 14 ++------------
> >  kernel/bpf/hashtab.c       | 20 +++-----------------
> >  kernel/bpf/local_storage.c | 18 ++++++------------
> >  4 files changed, 39 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 8f6e87f0f3a89..2dc0299a2da50 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -547,6 +547,34 @@ static inline void copy_map_value_long(struct bpf_=
map *map, void *dst, void *src
> >         bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
> >  }
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void _=
_percpu *pptr, void *value,
> > +                                          u32 size)
> > +{
> > +       int cpu, off =3D 0;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               copy_map_value_long(map, value + off, per_cpu_ptr(pptr,=
 cpu));
> > +               check_and_init_map_value(map, value + off);

I still maintain that this makes zero sense... value+off is memory
that we'll copy_to_user, why are we setting refcount to 1, or
rb_node/list_node to "proper empty node" is absolutely not clear... it
feels like we can drop check_and_init_map_value() altogether and be
absolutely no worse. If anything, memset(0) would be nicer, but I
guess we didn't have it to begin with, so no need to add it now.

> > +               off +=3D size;
> > +       }
> > +}
> > +
> > +void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
> > +
> > +static inline void bpf_percpu_copy_from_user(struct bpf_map *map, void=
 __percpu *pptr, void *value,
> > +                                            u32 size)
> > +{
> > +       int cpu, off =3D 0;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value =
+ off);

copy_map_value_long is generalization of bpf_long_memcpy, and so it
would be good to call this out to explain why your refactoring is
correct

> > +               bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu)=
);
> > +               off +=3D size;
> > +       }
> > +}
> > +#endif
> > +
> >  static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, vo=
id *dst, void *src)
> >  {
> >         unsigned long *src_uptr, *dst_uptr;
> > @@ -2417,7 +2445,6 @@ struct btf_record *btf_record_dup(const struct bt=
f_record *rec);
> >  bool btf_record_equal(const struct btf_record *rec_a, const struct btf=
_record *rec_b);
> >  void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
> >  void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
> > -void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
> >  void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool p=
ercpu);
> >
> >  struct bpf_map *bpf_map_get(u32 ufd);
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 3d080916faf97..6be9c54604503 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -300,7 +300,6 @@ int bpf_percpu_array_copy(struct bpf_map *map, void=
 *key, void *value)
> >         struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> >         u32 index =3D *(u32 *)key;
> >         void __percpu *pptr;
> > -       int cpu, off =3D 0;
> >         u32 size;
> >
> >         if (unlikely(index >=3D array->map.max_entries))
> > @@ -313,11 +312,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, voi=
d *key, void *value)
> >         size =3D array->elem_size;
> >         rcu_read_lock();
> >         pptr =3D array->pptrs[index & array->index_mask];
> > -       for_each_possible_cpu(cpu) {
> > -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr,=
 cpu));
> > -               check_and_init_map_value(map, value + off);
> > -               off +=3D size;
> > -       }
> > +       bpf_percpu_copy_to_user(map, pptr, value, size);
> >         rcu_read_unlock();
> >         return 0;
> >  }
> > @@ -387,7 +382,6 @@ int bpf_percpu_array_update(struct bpf_map *map, vo=
id *key, void *value,
> >         struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> >         u32 index =3D *(u32 *)key;
> >         void __percpu *pptr;
> > -       int cpu, off =3D 0;
> >         u32 size;
> >
> >         if (unlikely(map_flags > BPF_EXIST))
> > @@ -411,11 +405,7 @@ int bpf_percpu_array_update(struct bpf_map *map, v=
oid *key, void *value,
> >         size =3D array->elem_size;
> >         rcu_read_lock();
> >         pptr =3D array->pptrs[index & array->index_mask];
> > -       for_each_possible_cpu(cpu) {
> > -               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value =
+ off);
> > -               bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr=
, cpu));
> > -               off +=3D size;
> > -       }
> > +       bpf_percpu_copy_from_user(map, pptr, value, size);
> >         rcu_read_unlock();
> >         return 0;
> >  }
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 71f9931ac64cd..5f0f3c00dbb74 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -944,12 +944,8 @@ static void pcpu_copy_value(struct bpf_htab *htab,=
 void __percpu *pptr,
> >                 copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
> >         } else {
> >                 u32 size =3D round_up(htab->map.value_size, 8);
> > -               int off =3D 0, cpu;
> >
> > -               for_each_possible_cpu(cpu) {
> > -                       copy_map_value_long(&htab->map, per_cpu_ptr(ppt=
r, cpu), value + off);
> > -                       off +=3D size;
> > -               }
> > +               bpf_percpu_copy_from_user(&htab->map, pptr, value, size=
);
>
> This is not a refactor. There is a significant change in the logic.
> Why is it needed? Bug fix or introducing a bug?

this is preparation for that BPF_F_CPU/BPF_F_ALLCPUS, but I agree that
it would be better to include as preparatory patch in the actual patch
set

>
> The names to_user and from_user are wrong.
> There is no user space memory involved.

This was my suggestion because we either are copying user-supplied
data or copying data back to user. Strictly speaking it's all kernel
memory (copy_from_user/copy_to_user is done afterwards by the caller),
but that's the intent.

Maybe "copy_in" and "copy_out" would be better, I don't know. But
there is certainly a direction here w.r.t. user space provided data
(note, this is not BPF program-side logic).

>
> pw-bot: cr

