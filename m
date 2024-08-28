Return-Path: <bpf+bounces-38324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD374963555
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9629E285310
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 23:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E632B1AD9C6;
	Wed, 28 Aug 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elAqAUul"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD51AB528
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887458; cv=none; b=K/HNeVr+7EJovXnpfKrTvP1caotwTmbsb3laX0Q2ZtadiTNH514CosLg/bLMHv9pSp7PtOtoJFqYmYvEMaCqiaqRftWqAMRwBwj+7uqin4fRVv2MSljdOnRQxYpIfZh3WYUt61lqHJIeOOcF6Sihw7+AbKHtmga2hGTwv/2QbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887458; c=relaxed/simple;
	bh=n4urhs33vNQtS/c2Vk6lVH5gsuHH4/9So8Tz9CQfU2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcJEyGZx6hbrGZhp4P/8KL0NBBmJyaqW196THPVGW/BXZD0prGT8lgxM+lhrzA9n+lkWhMH3Njx1BPYN5nKzSdgja/lTj3y+23LHBHs0iZeKKB/9xNjoaW4D6ev5/S6fZPv27Zrdx1AkUdLHQuDCt1R9gcn6S1god5D/RprF4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elAqAUul; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3719896b7c8so12066f8f.3
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724887454; x=1725492254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trarO2D+WhOG/1FODiu0H1+N/EBXsnY6Iddn+m6eXJE=;
        b=elAqAUulRZVj8Dr0OJh5NPQ50mdutMEtaGYvG28YCpnLoc/xitCfUtxpAURkpAnOh+
         TJ9qN/r25/0Sksifrt4V/h8mtFI6EijHV9EvH4Szo0Vm/cCkwFjF7XWd+HzU7wQBKVEA
         skMkJ+4Qkoe28FeCV8eXIxl2Rq8ImJ3pU58LYA4LQ/SAJwBr9MXO5C1NI1h53spnZ4rf
         MCIT9++xeLIvXoZ9ceflnzsT1NXymGSkbEZr7wUqzQNkMqyekplDP+W4w0hECyLf9wgb
         d1HeKsWs/vX8TWrMV/FxffbTVoR8aEeUpfl9RQeV/+4Gp/S/SaSIJPF3sy3paJh6IxiR
         3IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887454; x=1725492254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trarO2D+WhOG/1FODiu0H1+N/EBXsnY6Iddn+m6eXJE=;
        b=ah8wqaWa4BcENiHmzHZaDmxtYHyIB2WK/H3YaVU60qrOhZ6ZgzUopwQRprIxP09Qet
         6lhBntTXGZUa8fNFu/l/PuDbB5Xpeb94WbqWaZJseOCnSg2rL3ggMyA4M62SB0iZHtSD
         xNMbrpBXpE4oV+AyqPf0xavQILMiX5NgreGPDWCAhg+Ihh4n8f0t1bGZZsw9KKGMHyW2
         LUsl79y273LBTKmI10ry17qB4CN3/ZHl46ptxH6v7rpf8EQARQtXs1f6L2mrTHXk8ght
         KtT7sgmTLd8J4Dt18bzEllX3S8qbtt+Ik5lyOGNesmW17qaqe1n/b/VVFWV0qNHT2jO4
         R5xg==
X-Gm-Message-State: AOJu0YwfQ3ruvmJAiifOpCQI5SZ71B2AmP+q7px1/hqIm6J8it2rR6Ro
	QFiwjXw+iNP+NE/PZj6X7AzVqLsgS70ibC3onRbtBwt1dkiFfNpF6znAcCYB0Fprw5okuhAaxGh
	3eS/vk1dIutGSwDBZ6/idft62PBc=
X-Google-Smtp-Source: AGHT+IFnf3iZ4NwGyASZzLpyqkxJSDHUkBJwrs3Ibc2ESithpYGmesOutE6cCviKJ21WPIbmiWGbvq+4ltpwgsqR5ic=
X-Received: by 2002:a5d:4309:0:b0:368:37e3:dff7 with SMTP id
 ffacd0b85a97d-3749b552b2fmr648381f8f.34.1724887454190; Wed, 28 Aug 2024
 16:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816191213.35573-1-thinker.li@gmail.com> <20240816191213.35573-5-thinker.li@gmail.com>
In-Reply-To: <20240816191213.35573-5-thinker.li@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 16:24:03 -0700
Message-ID: <CAADnVQLUN1XLzV0kVbXWm5TaQyH5pN4M3agha-uZoWP3Dkcw8Q@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 4/6] bpf: pin, translate, and unpin __uptr from syscalls.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:12=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com=
> wrote:
>
> When a user program updates a map value, every uptr will be pinned and
> translated to an address in the kernel. This process is initiated by
> calling bpf_map_update_elem() from user programs.
>
> To access uptrs in BPF programs, they are pinned using
> pin_user_pages_fast(), but the conversion to kernel addresses is actually
> done by page_address(). The uptrs can be unpinned using unpin_user_pages(=
).
>
> Currently, the memory block pointed to by a uptr must reside in a single
> memory page, as crossing multiple pages is not supported. uptr is only
> supported by task storage maps and can only be set by user programs throu=
gh
> syscalls.
>
> When the value of an uptr is overwritten or destroyed, the memory pointed
> to by the old value must be unpinned. This is ensured by calling
> bpf_obj_uptrcpy() and copy_map_uptr_locked()

Doesn't look like there is a test for it, but more importantly
unpin shouldn't be called from bpf prog, since
we cannot guarantee that the execution context is safe enough to do unpin.
More on this below.

> when updating map value and by
> bpf_obj_free_fields() when destroying map value.
>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/linux/bpf.h            |  30 ++++++
>  kernel/bpf/bpf_local_storage.c |  23 ++++-
>  kernel/bpf/helpers.c           |  20 ++++
>  kernel/bpf/syscall.c           | 172 ++++++++++++++++++++++++++++++++-
>  4 files changed, 237 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 954e476b5605..886c818ff555 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -477,6 +477,8 @@ static inline void bpf_long_memcpy(void *dst, const v=
oid *src, u32 size)
>                 data_race(*ldst++ =3D *lsrc++);
>  }
>
> +void bpf_obj_unpin_uptr(const struct btf_field *field, void *addr);
> +
>  /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could =
be one of each. */
>  static inline void bpf_obj_memcpy(struct btf_record *rec,
>                                   void *dst, void *src, u32 size,
> @@ -503,6 +505,34 @@ static inline void bpf_obj_memcpy(struct btf_record =
*rec,
>         memcpy(dst + curr_off, src + curr_off, size - curr_off);
>  }
>
> +static inline void bpf_obj_uptrcpy(struct btf_record *rec,
> +                                  void *dst, void *src)
> +{
> +       int i;
> +
> +       if (IS_ERR_OR_NULL(rec))
> +               return;
> +
> +       for (i =3D 0; i < rec->cnt; i++) {
> +               u32 next_off =3D rec->fields[i].offset;
> +               void *addr;
> +
> +               if (rec->fields[i].type =3D=3D BPF_UPTR) {
> +                       /* Unpin old address.
> +                        *
> +                        * Alignments are guaranteed by btf_find_field_on=
e().
> +                        */
> +                       addr =3D *(void **)(dst + next_off);
> +                       if (addr)
> +                               bpf_obj_unpin_uptr(&rec->fields[i], addr)=
;
> +
> +                       *(void **)(dst + next_off) =3D *(void **)(src + n=
ext_off);
> +               }
> +       }
> +}

The whole helper can be removed. See below.

> +
> +void copy_map_uptr_locked(struct bpf_map *map, void *dst, void *src, boo=
l lock_src);
> +
>  static inline void copy_map_value(struct bpf_map *map, void *dst, void *=
src)
>  {
>         bpf_obj_memcpy(map->record, dst, src, map->value_size, false);
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index c938dea5ddbf..2fafad53b9d9 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -99,8 +99,11 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, vo=
id *owner,
>         }
>
>         if (selem) {
> -               if (value)
> +               if (value) {
>                         copy_map_value(&smap->map, SDATA(selem)->data, va=
lue);
> +                       if (smap->map.map_type =3D=3D BPF_MAP_TYPE_TASK_S=
TORAGE)
> +                               bpf_obj_uptrcpy(smap->map.record, SDATA(s=
elem)->data, value);

This part should be dropped.
bpf prog should not be able to call unpin on uptr.
It cannot supply new uptr in value anyway.
On the other side the user space should be able to
bpf_map_update_elem() with one value->udata and
then call it again with a different value->udata.
Old one should be unpinned and the new udata pinned,
but that shouldn't be done from the guts of bpf_selem_alloc().
Instead, all of pin/unpin must be done while handling sys_bpf command.
More below.


> +               }
>                 /* No need to call check_and_init_map_value as memory is =
zero init */
>                 return selem;
>         }
> @@ -575,8 +578,13 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
>                 if (err)
>                         return ERR_PTR(err);
>                 if (old_sdata && selem_linked_to_storage_lockless(SELEM(o=
ld_sdata))) {
> -                       copy_map_value_locked(&smap->map, old_sdata->data=
,
> -                                             value, false);
> +                       if (smap->map.map_type =3D=3D BPF_MAP_TYPE_TASK_S=
TORAGE &&
> +                           btf_record_has_field(smap->map.record, BPF_UP=
TR))
> +                               copy_map_uptr_locked(&smap->map, old_sdat=
a->data,
> +                                                    value, false);
> +                       else
> +                               copy_map_value_locked(&smap->map, old_sda=
ta->data,
> +                                                     value, false);

Similar. unpin here is dangerous.
Since the combination of bpf_spin_lock and uptr in map element
causing this complexity we should simply disable this combination
until the actual use case comes up.
Then above hunk won't be needed.

>                         return old_sdata;
>                 }
>         }
> @@ -607,8 +615,13 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
>                 goto unlock;
>
>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> -               copy_map_value_locked(&smap->map, old_sdata->data, value,
> -                                     false);
> +               if (smap->map.map_type =3D=3D BPF_MAP_TYPE_TASK_STORAGE &=
&
> +                   btf_record_has_field(smap->map.record, BPF_UPTR))
> +                       copy_map_uptr_locked(&smap->map, old_sdata->data,
> +                                            value, false);
> +               else
> +                       copy_map_value_locked(&smap->map, old_sdata->data=
,
> +                                             value, false);

This one won't be needed either.

>                 selem =3D SELEM(old_sdata);
>                 goto unlock;
>         }
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..d588b52605b9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -388,6 +388,26 @@ void copy_map_value_locked(struct bpf_map *map, void=
 *dst, void *src,
>         preempt_enable();
>  }
>
> +/* Copy map value and uptr from src to dst, with lock_src indicating
> + * whether src or dst is locked.
> + */
> +void copy_map_uptr_locked(struct bpf_map *map, void *src, void *dst,
> +                         bool lock_src)
> +{
> +       struct bpf_spin_lock *lock;
> +
> +       if (lock_src)
> +               lock =3D src + map->record->spin_lock_off;
> +       else
> +               lock =3D dst + map->record->spin_lock_off;
> +       preempt_disable();
> +       __bpf_spin_lock_irqsave(lock);
> +       copy_map_value(map, dst, src);
> +       bpf_obj_uptrcpy(map->record, dst, src);
> +       __bpf_spin_unlock_irqrestore(lock);
> +       preempt_enable();
> +}

This one has to be removed too.
Just think of the consequences of the above.
It may do unpin with irqs disabled.
It's asking for trouble depending on where the udata pointer originates.

> +void bpf_obj_unpin_uptr(const struct btf_field *field, void *addr)
> +{
> +       struct page *pages[1];
> +       u32 size, type_id;
> +       int npages;
> +       void *ptr;
> +
> +       type_id =3D field->kptr.btf_id;
> +       btf_type_id_size(field->kptr.btf, &type_id, &size);
> +       if (size =3D=3D 0)
> +               return;
> +
> +       ptr =3D (void *)((intptr_t)addr & PAGE_MASK);
> +
> +       npages =3D (((intptr_t)addr + size + ~PAGE_MASK) - (intptr_t)ptr)=
 >> PAGE_SHIFT;
> +       if (WARN_ON_ONCE(npages > 1))
> +               return;

This check is unnecessary. We check that there is only one page
during the pin. No need to repeat during unpin.

> +
> +       pages[0] =3D virt_to_page(ptr);
> +       unpin_user_pages(pages, 1);

The whole helper can be just above two lines.

> +}
> +
> +/* Unpin uptr fields in the record up to cnt */
> +static void bpf_obj_unpin_uptrs_cnt(struct btf_record *rec, int cnt, voi=
d *src)
> +{
> +       u32 next_off;
> +       void **kaddr_ptr;
> +       int i;
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               if (rec->fields[i].type !=3D BPF_UPTR)
> +                       continue;
> +
> +               next_off =3D rec->fields[i].offset;
> +               kaddr_ptr =3D src + next_off;
> +               if (*kaddr_ptr) {
> +                       bpf_obj_unpin_uptr(&rec->fields[i], *kaddr_ptr);
> +                       *kaddr_ptr =3D NULL;
> +               }
> +       }
> +}
> +
> +/* Find all BPF_UPTR fields in the record, pin the user memory, map it
> + * to kernel space, and update the addresses in the source memory.
> + *
> + * The map value passing from userspace may contain user kptrs pointing =
to
> + * user memory. This function pins the user memory and maps it to kernel
> + * memory so that BPF programs can access it.
> + */
> +static int bpf_obj_trans_pin_uptrs(struct btf_record *rec, void *src, u3=
2 size)
> +{
> +       u32 type_id, tsz, npages, next_off;
> +       void *uaddr, *kaddr, **uaddr_ptr;
> +       const struct btf_type *t;
> +       struct page *pages[1];
> +       int i, err;
> +
> +       if (IS_ERR_OR_NULL(rec))
> +               return 0;
> +
> +       if (!btf_record_has_field(rec, BPF_UPTR))
> +               return 0;
> +
> +       for (i =3D 0; i < rec->cnt; i++) {
> +               if (rec->fields[i].type !=3D BPF_UPTR)
> +                       continue;
> +
> +               next_off =3D rec->fields[i].offset;
> +               if (next_off + sizeof(void *) > size) {
> +                       err =3D -EFAULT;
> +                       goto rollback;
> +               }

size argument and above check are unnecessary.
btf_record has to be correct at this point.

> +               uaddr_ptr =3D src + next_off;
> +               uaddr =3D *uaddr_ptr;
> +               if (!uaddr)
> +                       continue;
> +
> +               /* Make sure the user memory takes up at most one page */
> +               type_id =3D rec->fields[i].kptr.btf_id;
> +               t =3D btf_type_id_size(rec->fields[i].kptr.btf, &type_id,=
 &tsz);
> +               if (!t) {
> +                       err =3D -EFAULT;
> +                       goto rollback;
> +               }
> +               if (tsz =3D=3D 0) {
> +                       *uaddr_ptr =3D NULL;
> +                       continue;
> +               }

tsz=3D=3D0 ? are you sure this can happen?
If so there has to be a test for this.
And we probably should reject it earlier in the verifier.
zero sized struct as uptr makes no practical use case.

> +               npages =3D (((intptr_t)uaddr + tsz + ~PAGE_MASK) -
> +                         ((intptr_t)uaddr & PAGE_MASK)) >> PAGE_SHIFT;
> +               if (npages > 1) {
> +                       /* Allow only one page */
> +                       err =3D -EFAULT;

E2BIG would be a better error in such a case.

> +                       goto rollback;
> +               }
> +
> +               /* Pin the user memory */
> +               err =3D pin_user_pages_fast((intptr_t)uaddr, 1, FOLL_LONG=
TERM | FOLL_WRITE, pages);
> +               if (err < 0)
> +                       goto rollback;

since it's "_fast" version it can return 0 too.
In this case it's a case of rollback as well.
It's better to change this check to if (err !=3D 1)
which is a more canonical way.

> +
> +               /* Map to kernel space */
> +               kaddr =3D page_address(pages[0]);
> +               if (unlikely(!kaddr)) {
> +                       WARN_ON_ONCE(1);

Since the page was pinned the above cannot fail.
No reason for this check.

> +                       unpin_user_pages(pages, 1);
> +                       err =3D -EFAULT;
> +                       goto rollback;
> +               }
> +               *uaddr_ptr =3D kaddr + ((intptr_t)uaddr & ~PAGE_MASK);
> +       }
> +
> +       return 0;
> +
> +rollback:
> +       /* Unpin the user memory of earlier fields */
> +       bpf_obj_unpin_uptrs_cnt(rec, i, src);
> +
> +       return err;
> +}
> +
> +static void bpf_obj_unpin_uptrs(struct btf_record *rec, void *src)
> +{
> +       if (IS_ERR_OR_NULL(rec))
> +               return;
> +
> +       if (!btf_record_has_field(rec, BPF_UPTR))
> +               return;
> +
> +       bpf_obj_unpin_uptrs_cnt(rec, rec->cnt, src);
> +}
> +
> +static int bpf_map_update_value_inner(struct bpf_map *map, struct file *=
map_file,
> +                                     void *key, void *value, __u64 flags=
)
>  {
>         int err;
>
> @@ -208,6 +340,29 @@ static int bpf_map_update_value(struct bpf_map *map,=
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
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_TASK_STORAGE) {
> +               /* Pin user memory can lead to context switch, so we need
> +                * to do it before potential RCU lock.
> +                */
> +               err =3D bpf_obj_trans_pin_uptrs(map->record, value,
> +                                             bpf_map_value_size(map));
> +               if (err)
> +                       return err;
> +       }
> +
> +       err =3D bpf_map_update_value_inner(map, map_file, key, value, fla=
gs);
> +
> +       if (err && map->map_type =3D=3D BPF_MAP_TYPE_TASK_STORAGE)
> +               bpf_obj_unpin_uptrs(map->record, value);

Pls don't rename bpf_map_update_value_inner.
Instead add "if (map->map_type =3D=3D BPF_MAP_TYPE_TASK_STORAGE)" case
inside bpf_map_update_value() and
do all of unpin/pin calls from there.

> +
> +       return err;
> +}
> +
>  static int bpf_map_copy_value(struct bpf_map *map, void *key, void *valu=
e,
>                               __u64 flags)
>  {
> @@ -714,6 +869,11 @@ void bpf_obj_free_fields(const struct btf_record *re=
c, void *obj)
>                                 field->kptr.dtor(xchgd_field);
>                         }
>                         break;
> +               case BPF_UPTR:
> +                       if (*(void **)field_ptr)
> +                               bpf_obj_unpin_uptr(field, *(void **)field=
_ptr);
> +                       *(void **)field_ptr =3D NULL;

This one will be called from
 task_storage_delete->bpf_selem_free->bpf_obj_free_fields

and even if upin was safe to do from that context
we cannot just do:
*(void **)field_ptr =3D NULL;

since bpf prog might be running in parallel,
it could have just read that addr and now is using it.

The first thought of a way to fix this was to split
bpf_obj_free_fields() into the current one plus
bpf_obj_free_fields_after_gp()
that will do the above unpin bit.
and call the later one from bpf_selem_free_rcu()
while bpf_obj_free_fields() from bpf_selem_free()
will not touch uptr.

But after digging further I realized that task_storage
already switched to use bpf_ma, so the above won't work.

So we need something similar to BPF_KPTR_REF logic:
xchgd_field =3D (void *)xchg((unsigned long *)field_ptr, 0);
and then delay of uptr unpin for that address into call_rcu.

Any better ideas?

> +                       break;
>                 case BPF_LIST_HEAD:
>                         if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>                                 continue;
> @@ -1099,7 +1259,7 @@ static int map_check_btf(struct bpf_map *map, struc=
t bpf_token *token,
>
>         map->record =3D btf_parse_fields(btf, value_type,
>                                        BPF_SPIN_LOCK | BPF_TIMER | BPF_KP=
TR | BPF_LIST_HEAD |
> -                                      BPF_RB_ROOT | BPF_REFCOUNT | BPF_W=
ORKQUEUE,
> +                                      BPF_RB_ROOT | BPF_REFCOUNT | BPF_W=
ORKQUEUE | BPF_UPTR,
>                                        map->value_size);
>         if (!IS_ERR_OR_NULL(map->record)) {
>                 int i;
> @@ -1155,6 +1315,12 @@ static int map_check_btf(struct bpf_map *map, stru=
ct bpf_token *token,
>                                         goto free_map_tab;
>                                 }
>                                 break;
> +                       case BPF_UPTR:
> +                               if (map->map_type !=3D BPF_MAP_TYPE_TASK_=
STORAGE) {
> +                                       ret =3D -EOPNOTSUPP;
> +                                       goto free_map_tab;
> +                               }
> +                               break;

I was thinking whether we need an additional check that bpf_obj_new()
cannot be used to allocate a prog supplied struct with uptr in it,
but we're good here, since we only allow
__btf_type_is_scalar_struct() for bpf_obj_new.

