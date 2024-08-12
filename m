Return-Path: <bpf+bounces-36905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7594F528
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1031C2106B
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6E187321;
	Mon, 12 Aug 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFhqp2pQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFA4317C
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481148; cv=none; b=mz2S6Il1e3ZLVQMG+mjtiEhQBunoQwn8qXEXT3EAwzhPD3p4SnOa1G5jWc30DS9mhNAzT4mAwyYvfd4RoKUFklVCQHcc+kRV/BfZx/GA+OGyvWwDdlnLrhZiMtXokvzsQAvdXTMaRyejuiitWSN9bHWkkUS1DjbOwY41ijpkpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481148; c=relaxed/simple;
	bh=FBZ4vBj3Bubq+j+84cjMCXWWemcptPkXS/1R1DYQlRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ0tEy293UjjcKJH3fyRMtIYus2KFAjRx/WrkYN1HA0Et+PkkmVddZWZ31rc/dwUb8VSVnuirwxfdC6fZfW0BId4jnBFC92swK3u0+agUzNYgMj+v6OKoVv2yhW/xXZNq/jfBU3pr7yV7uFCcoMwT1fbtloY91s16GZiMm4zquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFhqp2pQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368712acb8dso2664191f8f.2
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481145; x=1724085945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDSh7HWa6Wv++fzHTJQyE5CBvTgAhbZRE+9qKgj+uJk=;
        b=BFhqp2pQm02LQgDFHIiQqqCBqz8g1kTMob1oSET0O1IvrmigikAwtSafVViBUEDHPm
         0zJk6m+EIvV+Y+4L6LLmucDpzpFZvO674JXNadtDmoTHXL5FtWdfKXqC23FlskxS7zmK
         ZE91JSD9gJv6PdKBczCo1dkHS+xxqHK4phhmij3yW7UC/HaG8Yre2GzJpuddp0A6s9pz
         UNjdHDIZDyZwhwnIJeEaFy/s1CjZzzGdwXh1MrsqhT2n6wqCK+4q3/v/uhe34glABqST
         MSFPSiEXItvo1CnBC+zojnm2VtgTA0p7dBfywffrI+GMeWzi9B/mlBpSqgBFkTr4YNS6
         nQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481145; x=1724085945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDSh7HWa6Wv++fzHTJQyE5CBvTgAhbZRE+9qKgj+uJk=;
        b=I3IKBTZJ/SzmkSdEnKRMJXI5YrYaBApwrb9NOz6iiYvLb9gYSiVt4c1EIvuZlF/+t8
         X70E9U85fe39YRc7LyjFhGsp5aZDtidulG4DKxcLOzEZLeC55gucfbq9iMuHGLPZNEqh
         kQ0WAyyDO53ZHWb8aePn7LwF7CGw2KH5bevCOuXZ8PmVkLhXnZVUg8s33TiUlIXxTdyc
         rad07SKtDcin/eYag6tjXK1Br9bG4L5IAdoZZMyeY6TeO0f6+Rx/2toSq5mQUKsmmVnk
         8hhfrL8FYpvG5L4QuJMoK9CMD+YfYCYBXMJO7QzLIjtU+f2or7cJoVI7HwRjyz61x8GB
         xP2g==
X-Gm-Message-State: AOJu0Yyx7c4r4j+4lxy/9+vOl61pvqgtBABBGXLytsF5Ic9tORNWrBMA
	3sosGvXiCzDOwYJreJnYA6vlmGHdJVA+GDDCmxI5Td2Pe3DChpsiRfGhVoS+VMYVLoACAcORSxm
	kWHpOBY0LAOVt1z8iS+WuqITmato=
X-Google-Smtp-Source: AGHT+IGR3kNZOfHnJGMV7dUY173YStutjVXKU2l9whoTyEGDuoOTodhLhRf3xPjhUvODY1Bk6m5L7tQtpgd3pyzQGYk=
X-Received: by 2002:adf:f950:0:b0:368:420e:b790 with SMTP id
 ffacd0b85a97d-3716ccf5185mr683946f8f.14.1723481144077; Mon, 12 Aug 2024
 09:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807235755.1435806-1-thinker.li@gmail.com> <20240807235755.1435806-4-thinker.li@gmail.com>
In-Reply-To: <20240807235755.1435806-4-thinker.li@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 09:45:32 -0700
Message-ID: <CAADnVQLs8nZGmyJSdgb11NSsSe_ZH1Qbcu7dcb=60-+0p+k9fw@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/5] bpf: pin, translate, and unpin __kptr_user
 from syscalls.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 4:58=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com> =
wrote:
>
> User kptrs are pinned, by pin_user_pages_fast(), and translated to an
> address in the kernel when the value is updated by user programs. (Call
> bpf_map_update_elem() from user programs.) And, the pinned pages are
> unpinned if the value of user kptrs are overritten or if the values of ma=
ps
> are deleted/destroyed.
>
> The pages are mapped through vmap() in order to get a continuous space in
> the kernel if the memory pointed by a user kptr resides in two or more
> pages. For the case of single page, page_address() is called to get the
> address of a page in the kernel.
>
> User kptr is only supported by task storage maps.
>
> One user kptr can pin at most KPTR_USER_MAX_PAGES(16) physical pages. Thi=
s
> is a random picked number for safety. We actually can remove this
> restriction totally.
>
> User kptrs could only be set by user programs through syscalls.  Any
> attempts of updating the value of a map with __kptr_user in it should
> ignore the values of user kptrs from BPF programs. The values of user kpt=
rs
> will keep as they were if the new values are from BPF programs, not from
> user programs.
>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/linux/bpf.h               |  35 +++++-
>  include/linux/bpf_local_storage.h |   2 +-
>  kernel/bpf/bpf_local_storage.c    |  18 +--
>  kernel/bpf/helpers.c              |  12 +-
>  kernel/bpf/local_storage.c        |   2 +-
>  kernel/bpf/syscall.c              | 177 +++++++++++++++++++++++++++++-
>  net/core/bpf_sk_storage.c         |   2 +-
>  7 files changed, 227 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 87d5f98249e2..f4ad0bc183cb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -30,6 +30,7 @@
>  #include <linux/static_call.h>
>  #include <linux/memcontrol.h>
>  #include <linux/cfi.h>
> +#include <linux/mm.h>
>
>  struct bpf_verifier_env;
>  struct bpf_verifier_log;
> @@ -477,10 +478,12 @@ static inline void bpf_long_memcpy(void *dst, const=
 void *src, u32 size)
>                 data_race(*ldst++ =3D *lsrc++);
>  }
>
> +void bpf_obj_unpin_uaddr(const struct btf_field *field, void *addr);
> +
>  /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could =
be one of each. */
>  static inline void bpf_obj_memcpy(struct btf_record *rec,
>                                   void *dst, void *src, u32 size,
> -                                 bool long_memcpy)
> +                                 bool long_memcpy, bool from_user)
>  {
>         u32 curr_off =3D 0;
>         int i;
> @@ -496,21 +499,40 @@ static inline void bpf_obj_memcpy(struct btf_record=
 *rec,
>         for (i =3D 0; i < rec->cnt; i++) {
>                 u32 next_off =3D rec->fields[i].offset;
>                 u32 sz =3D next_off - curr_off;
> +               void *addr;
>
>                 memcpy(dst + curr_off, src + curr_off, sz);
> +               if (from_user && rec->fields[i].type =3D=3D BPF_KPTR_USER=
) {


Do not add this to bpf_obj_memcpy() which is a critical path
for various map operations.
This has to be standalone for task storage only.

> +                       /* Unpin old address.
> +                        *
> +                        * Alignments are guaranteed by btf_find_field_on=
e().
> +                        */
> +                       addr =3D *(void **)(dst + next_off);
> +                       if (virt_addr_valid(addr))
> +                               bpf_obj_unpin_uaddr(&rec->fields[i], addr=
);
> +                       else if (addr)
> +                               WARN_ON_ONCE(1);
> +
> +                       *(void **)(dst + next_off) =3D *(void **)(src + n=
ext_off);
> +               }
>                 curr_off +=3D rec->fields[i].size + sz;
>         }
>         memcpy(dst + curr_off, src + curr_off, size - curr_off);
>  }
>
> +static inline void copy_map_value_user(struct bpf_map *map, void *dst, v=
oid *src, bool from_user)

No need for these helpers either.

> +{
> +       bpf_obj_memcpy(map->record, dst, src, map->value_size, false, fro=
m_user);
> +}
> +
>  static inline void copy_map_value(struct bpf_map *map, void *dst, void *=
src)
>  {
> -       bpf_obj_memcpy(map->record, dst, src, map->value_size, false);
> +       bpf_obj_memcpy(map->record, dst, src, map->value_size, false, fal=
se);
>  }
>
>  static inline void copy_map_value_long(struct bpf_map *map, void *dst, v=
oid *src)
>  {
> -       bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
> +       bpf_obj_memcpy(map->record, dst, src, map->value_size, true, fals=
e);
>  }
>
>  static inline void bpf_obj_memzero(struct btf_record *rec, void *dst, u3=
2 size)
> @@ -538,6 +560,8 @@ static inline void zero_map_value(struct bpf_map *map=
, void *dst)
>         bpf_obj_memzero(map->record, dst, map->value_size);
>  }
>
> +void copy_map_value_locked_user(struct bpf_map *map, void *dst, void *sr=
c,
> +                               bool lock_src, bool from_user);
>  void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
>                            bool lock_src);
>  void bpf_timer_cancel_and_free(void *timer);
> @@ -775,6 +799,11 @@ enum bpf_arg_type {
>  };
>  static_assert(__BPF_ARG_TYPE_MAX <=3D BPF_BASE_TYPE_LIMIT);
>
> +#define BPF_MAP_UPDATE_FLAG_BITS 3
> +enum bpf_map_update_flag {
> +       BPF_FROM_USER =3D BIT(0 + BPF_MAP_UPDATE_FLAG_BITS)
> +};
> +
>  /* type of values returned from helper functions */
>  enum bpf_return_type {
>         RET_INTEGER,                    /* function returns integer */
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index dcddb0aef7d8..d337df68fa23 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -181,7 +181,7 @@ void bpf_selem_link_map(struct bpf_local_storage_map =
*smap,
>
>  struct bpf_local_storage_elem *
>  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *v=
alue,
> -               bool charge_mem, gfp_t gfp_flags);
> +               bool charge_mem, gfp_t gfp_flags, bool from_user);
>
>  void bpf_selem_free(struct bpf_local_storage_elem *selem,
>                     struct bpf_local_storage_map *smap,
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index c938dea5ddbf..c4cf09e27a19 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -73,7 +73,7 @@ static bool selem_linked_to_map(const struct bpf_local_=
storage_elem *selem)
>
>  struct bpf_local_storage_elem *
>  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> -               void *value, bool charge_mem, gfp_t gfp_flags)
> +               void *value, bool charge_mem, gfp_t gfp_flags, bool from_=
user)
>  {
>         struct bpf_local_storage_elem *selem;
>
> @@ -100,7 +100,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, v=
oid *owner,
>
>         if (selem) {
>                 if (value)
> -                       copy_map_value(&smap->map, SDATA(selem)->data, va=
lue);
> +                       copy_map_value_user(&smap->map, SDATA(selem)->dat=
a, value, from_user);
>                 /* No need to call check_and_init_map_value as memory is =
zero init */
>                 return selem;
>         }
> @@ -530,9 +530,11 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
>         struct bpf_local_storage_elem *alloc_selem, *selem =3D NULL;
>         struct bpf_local_storage *local_storage;
>         unsigned long flags;
> +       bool from_user =3D map_flags & BPF_FROM_USER;
>         int err;
>
>         /* BPF_EXIST and BPF_NOEXIST cannot be both set */
> +       map_flags &=3D ~BPF_FROM_USER;
>         if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
>             /* BPF_F_LOCK can only be used in a value with spin_lock */
>             unlikely((map_flags & BPF_F_LOCK) &&
> @@ -550,7 +552,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>                 if (err)
>                         return ERR_PTR(err);
>
> -               selem =3D bpf_selem_alloc(smap, owner, value, true, gfp_f=
lags);
> +               selem =3D bpf_selem_alloc(smap, owner, value, true, gfp_f=
lags, from_user);
>                 if (!selem)
>                         return ERR_PTR(-ENOMEM);
>
> @@ -575,8 +577,8 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>                 if (err)
>                         return ERR_PTR(err);
>                 if (old_sdata && selem_linked_to_storage_lockless(SELEM(o=
ld_sdata))) {
> -                       copy_map_value_locked(&smap->map, old_sdata->data=
,
> -                                             value, false);
> +                       copy_map_value_locked_user(&smap->map, old_sdata-=
>data,
> +                                                  value, false, from_use=
r);
>                         return old_sdata;
>                 }
>         }
> @@ -584,7 +586,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>         /* A lookup has just been done before and concluded a new selem i=
s
>          * needed. The chance of an unnecessary alloc is unlikely.
>          */
> -       alloc_selem =3D selem =3D bpf_selem_alloc(smap, owner, value, tru=
e, gfp_flags);
> +       alloc_selem =3D selem =3D bpf_selem_alloc(smap, owner, value, tru=
e, gfp_flags, from_user);
>         if (!alloc_selem)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -607,8 +609,8 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>                 goto unlock;
>
>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> -               copy_map_value_locked(&smap->map, old_sdata->data, value,
> -                                     false);
> +               copy_map_value_locked_user(&smap->map, old_sdata->data, v=
alue,
> +                                          false, from_user);
>                 selem =3D SELEM(old_sdata);
>                 goto unlock;
>         }
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..4aef86209fdd 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -372,8 +372,8 @@ const struct bpf_func_proto bpf_spin_unlock_proto =3D=
 {
>         .arg1_btf_id    =3D BPF_PTR_POISON,
>  };
>
> -void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
> -                          bool lock_src)
> +void copy_map_value_locked_user(struct bpf_map *map, void *dst, void *sr=
c,
> +                               bool lock_src, bool from_user)
>  {
>         struct bpf_spin_lock *lock;
>
> @@ -383,11 +383,17 @@ void copy_map_value_locked(struct bpf_map *map, voi=
d *dst, void *src,
>                 lock =3D dst + map->record->spin_lock_off;
>         preempt_disable();
>         __bpf_spin_lock_irqsave(lock);
> -       copy_map_value(map, dst, src);
> +       copy_map_value_user(map, dst, src, from_user);
>         __bpf_spin_unlock_irqrestore(lock);
>         preempt_enable();
>  }
>
> +void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
> +                          bool lock_src)
> +{
> +       copy_map_value_locked_user(map, dst, src, lock_src, false);
> +}
> +
>  BPF_CALL_0(bpf_jiffies64)
>  {
>         return get_jiffies_64();
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 3969eb0382af..62a12fa8ce9e 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -147,7 +147,7 @@ static long cgroup_storage_update_elem(struct bpf_map=
 *map, void *key,
>         struct bpf_cgroup_storage *storage;
>         struct bpf_storage_buffer *new;
>
> -       if (unlikely(flags & ~(BPF_F_LOCK | BPF_EXIST)))
> +       if (unlikely(flags & ~BPF_F_LOCK))
>                 return -EINVAL;
>
>         if (unlikely((flags & BPF_F_LOCK) &&
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 90a25307480e..eaa2a9d13265 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -155,8 +155,134 @@ static void maybe_wait_bpf_programs(struct bpf_map =
*map)
>                 synchronize_rcu();
>  }
>
> -static int bpf_map_update_value(struct bpf_map *map, struct file *map_fi=
le,
> -                               void *key, void *value, __u64 flags)
> +static void *trans_addr_pages(struct page **pages, int npages)
> +{
> +       if (npages =3D=3D 1)
> +               return page_address(pages[0]);
> +       /* For multiple pages, we need to use vmap() to get a contiguous
> +        * virtual address range.
> +        */
> +       return vmap(pages, npages, VM_MAP, PAGE_KERNEL);
> +}

Don't quite see a need for trans_addr_pages() helper when it's used
once.

> +
> +#define KPTR_USER_MAX_PAGES 16
> +
> +static int bpf_obj_trans_pin_uaddr(struct btf_field *field, void **addr)
> +{
> +       const struct btf_type *t;
> +       struct page *pages[KPTR_USER_MAX_PAGES];
> +       void *ptr, *kern_addr;
> +       u32 type_id, tsz;
> +       int r, npages;
> +
> +       ptr =3D *addr;
> +       type_id =3D field->kptr.btf_id;
> +       t =3D btf_type_id_size(field->kptr.btf, &type_id, &tsz);
> +       if (!t)
> +               return -EINVAL;
> +       if (tsz =3D=3D 0) {
> +               *addr =3D NULL;
> +               return 0;
> +       }
> +
> +       npages =3D (((intptr_t)ptr + tsz + ~PAGE_MASK) -
> +                 ((intptr_t)ptr & PAGE_MASK)) >> PAGE_SHIFT;
> +       if (npages > KPTR_USER_MAX_PAGES)
> +               return -E2BIG;
> +       r =3D pin_user_pages_fast((intptr_t)ptr & PAGE_MASK, npages, 0, p=
ages);

No need to apply the mask on ptr. See pin_user_pages_fast() internals.

It probably should be FOLL_WRITE | FOLL_LONGTERM instead of 0.

> +       if (r !=3D npages)
> +               return -EINVAL;
> +       kern_addr =3D trans_addr_pages(pages, npages);
> +       if (!kern_addr)
> +               return -ENOMEM;
> +       *addr =3D kern_addr + ((intptr_t)ptr & ~PAGE_MASK);
> +       return 0;
> +}
> +
> +void bpf_obj_unpin_uaddr(const struct btf_field *field, void *addr)
> +{
> +       struct page *pages[KPTR_USER_MAX_PAGES];
> +       int npages, i;
> +       u32 size, type_id;
> +       void *ptr;
> +
> +       type_id =3D field->kptr.btf_id;
> +       btf_type_id_size(field->kptr.btf, &type_id, &size);
> +       if (size =3D=3D 0)
> +               return;
> +
> +       ptr =3D (void *)((intptr_t)addr & PAGE_MASK);
> +       npages =3D (((intptr_t)addr + size + ~PAGE_MASK) - (intptr_t)ptr)=
 >> PAGE_SHIFT;
> +       for (i =3D 0; i < npages; i++) {
> +               pages[i] =3D virt_to_page(ptr);
> +               ptr +=3D PAGE_SIZE;
> +       }
> +       if (npages > 1)
> +               /* Paired with vmap() in trans_addr_pages() */
> +               vunmap((void *)((intptr_t)addr & PAGE_MASK));
> +       unpin_user_pages(pages, npages);
> +}
> +
> +static int bpf_obj_trans_pin_uaddrs(struct btf_record *rec, void *src, u=
32 size)
> +{
> +       u32 next_off;
> +       int i, err;
> +
> +       if (IS_ERR_OR_NULL(rec))
> +               return 0;
> +
> +       if (!btf_record_has_field(rec, BPF_KPTR_USER))
> +               return 0;

imo kptr_user doesn't quite fit as a name.
'kptr' means 'kernel pointer'. Here it's user addr.
Maybe just "uptr" ?

> +
> +       for (i =3D 0; i < rec->cnt; i++) {
> +               if (rec->fields[i].type !=3D BPF_KPTR_USER)
> +                       continue;
> +
> +               next_off =3D rec->fields[i].offset;
> +               if (next_off + sizeof(void *) > size)
> +                       return -EINVAL;
> +               err =3D bpf_obj_trans_pin_uaddr(&rec->fields[i], src + ne=
xt_off);
> +               if (!err)
> +                       continue;
> +
> +               /* Rollback */
> +               for (i--; i >=3D 0; i--) {
> +                       if (rec->fields[i].type !=3D BPF_KPTR_USER)
> +                               continue;
> +                       next_off =3D rec->fields[i].offset;
> +                       bpf_obj_unpin_uaddr(&rec->fields[i], *(void **)(s=
rc + next_off));
> +                       *(void **)(src + next_off) =3D NULL;
> +               }
> +
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static void bpf_obj_unpin_uaddrs(struct btf_record *rec, void *src)
> +{
> +       u32 next_off;
> +       int i;
> +
> +       if (IS_ERR_OR_NULL(rec))
> +               return;
> +
> +       if (!btf_record_has_field(rec, BPF_KPTR_USER))
> +               return;
> +
> +       for (i =3D 0; i < rec->cnt; i++) {
> +               if (rec->fields[i].type !=3D BPF_KPTR_USER)
> +                       continue;
> +
> +               next_off =3D rec->fields[i].offset;
> +               bpf_obj_unpin_uaddr(&rec->fields[i], *(void **)(src + nex=
t_off));
> +               *(void **)(src + next_off) =3D NULL;

This part is pretty much the same as the undo part in
bpf_obj_trans_pin_uaddrs() and the common helper is warranted.

> +       }
> +}
> +
> +static int bpf_map_update_value_inner(struct bpf_map *map, struct file *=
map_file,
> +                                     void *key, void *value, __u64 flags=
)
>  {
>         int err;
>
> @@ -208,6 +334,29 @@ static int bpf_map_update_value(struct bpf_map *map,=
 struct file *map_file,
>         return err;
>  }
>
> +static int bpf_map_update_value(struct bpf_map *map, struct file *map_fi=
le,
> +                               void *key, void *value, __u64 flags)
> +{
> +       int err;
> +
> +       if (flags & BPF_FROM_USER) {

there shouldn't be a need for this extra flag.
map->record has the info whether uptr is present or not.

> +               /* Pin user memory can lead to context switch, so we need
> +                * to do it before potential RCU lock.
> +                */
> +               err =3D bpf_obj_trans_pin_uaddrs(map->record, value,
> +                                              bpf_map_value_size(map));
> +               if (err)
> +                       return err;
> +       }
> +
> +       err =3D bpf_map_update_value_inner(map, map_file, key, value, fla=
gs);
> +
> +       if (err && (flags & BPF_FROM_USER))
> +               bpf_obj_unpin_uaddrs(map->record, value);
> +
> +       return err;
> +}
> +
>  static int bpf_map_copy_value(struct bpf_map *map, void *key, void *valu=
e,
>                               __u64 flags)
>  {
> @@ -714,6 +863,11 @@ void bpf_obj_free_fields(const struct btf_record *re=
c, void *obj)
>                                 field->kptr.dtor(xchgd_field);
>                         }
>                         break;
> +               case BPF_KPTR_USER:
> +                       if (virt_addr_valid(*(void **)field_ptr))
> +                               bpf_obj_unpin_uaddr(field, *(void **)fiel=
d_ptr);
> +                       *(void **)field_ptr =3D NULL;
> +                       break;
>                 case BPF_LIST_HEAD:
>                         if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>                                 continue;
> @@ -1155,6 +1309,12 @@ static int map_check_btf(struct bpf_map *map, stru=
ct bpf_token *token,
>                                         goto free_map_tab;
>                                 }
>                                 break;
> +                       case BPF_KPTR_USER:
> +                               if (map->map_type !=3D BPF_MAP_TYPE_TASK_=
STORAGE) {
> +                                       ret =3D -EOPNOTSUPP;
> +                                       goto free_map_tab;
> +                               }
> +                               break;
>                         case BPF_LIST_HEAD:
>                         case BPF_RB_ROOT:
>                                 if (map->map_type !=3D BPF_MAP_TYPE_HASH =
&&
> @@ -1618,11 +1778,15 @@ static int map_update_elem(union bpf_attr *attr, =
bpfptr_t uattr)
>         struct bpf_map *map;
>         void *key, *value;
>         u32 value_size;
> +       u64 extra_flags =3D 0;
>         struct fd f;
>         int err;
>
>         if (CHECK_ATTR(BPF_MAP_UPDATE_ELEM))
>                 return -EINVAL;
> +       /* Prevent userspace from setting any internal flags */
> +       if (attr->flags & ~(BIT(BPF_MAP_UPDATE_FLAG_BITS) - 1))
> +               return -EINVAL;
>
>         f =3D fdget(ufd);
>         map =3D __bpf_map_get(f);
> @@ -1653,7 +1817,9 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>                 goto free_key;
>         }
>
> -       err =3D bpf_map_update_value(map, f.file, key, value, attr->flags=
);
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_TASK_STORAGE)
> +               extra_flags |=3D BPF_FROM_USER;
> +       err =3D bpf_map_update_value(map, f.file, key, value, attr->flags=
 | extra_flags);
>         if (!err)
>                 maybe_wait_bpf_programs(map);
>
> @@ -1852,6 +2018,7 @@ int generic_map_update_batch(struct bpf_map *map, s=
truct file *map_file,
>         void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
>         u32 value_size, cp, max_count;
>         void *key, *value;
> +       u64 extra_flags =3D 0;
>         int err =3D 0;
>
>         if (attr->batch.elem_flags & ~BPF_F_LOCK)
> @@ -1881,6 +2048,8 @@ int generic_map_update_batch(struct bpf_map *map, s=
truct file *map_file,
>                 return -ENOMEM;
>         }
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_TASK_STORAGE)
> +               extra_flags |=3D BPF_FROM_USER;
>         for (cp =3D 0; cp < max_count; cp++) {
>                 err =3D -EFAULT;
>                 if (copy_from_user(key, keys + cp * map->key_size,
> @@ -1889,7 +2058,7 @@ int generic_map_update_batch(struct bpf_map *map, s=
truct file *map_file,
>                         break;
>
>                 err =3D bpf_map_update_value(map, map_file, key, value,
> -                                          attr->batch.elem_flags);
> +                                          attr->batch.elem_flags | extra=
_flags);
>
>                 if (err)
>                         break;
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index bc01b3aa6b0f..db5281384e6a 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -137,7 +137,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
>  {
>         struct bpf_local_storage_elem *copy_selem;
>
> -       copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, true, GFP_ATOMI=
C);
> +       copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, true, GFP_ATOMI=
C, false);
>         if (!copy_selem)
>                 return NULL;
>
> --
> 2.34.1
>

