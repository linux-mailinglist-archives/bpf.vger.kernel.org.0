Return-Path: <bpf+bounces-78629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 106BCD15971
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 23:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A307B3038292
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43772BE64A;
	Mon, 12 Jan 2026 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHexRD3K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D99476
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257507; cv=none; b=DSarm688d6YaNx6grLsc/ZGukplS90eTRFmmDT+0fCVHaeAQt4x+zgfQdlSt/dTRxfrMhMEGpS4fziGCMuU/ow9fMv2S5NGFPhJpcTDEB7rDPzrjXGR06WrmgaXOGW9ND03cnE1Z3USUch2quI+CcnUWB9sbV5GsmwTg3dDiRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257507; c=relaxed/simple;
	bh=OGVZTY/PuzoH74vE4w+AE4tZIYw/59WseLyWGJIWX6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7Qs+OyLyH53JEBE7mffvzfFigR9BtmWKcIokvaP3woludvOA6A7tL03zpbLKvdlBN4RHErQ6j7wAZz21L2KKPho4/pyg0NEcvVLUeek2cUvHvFFwTzTecS9s0zrs01EDRQEKSDXeL6MyJfuWVPwjj1LsnP/cwFEERPwbGJ0U8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHexRD3K; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927416137dso23389707b3.0
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768257505; x=1768862305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTVbXO81dgCvnxfi3ImPomwfNu/IpWW6XLpFehoYhvI=;
        b=PHexRD3Kp78sQFtYcE+XzM5M8cpxGCqNKr2XQxZ+hQbDEpg+v7Sjqd63i4jey/jBVJ
         yRi6WxllUj+RzaKgiIi5F+OSLxSgSgwMxBSplJBqt1PrryCVFifCkgcLm0x8Kji5KhYU
         5xF1AWVAIKxcyG0Eu248IctkjTj+dGTQ1994w9H/C4NSl2eeuLfUEqzHAO81s+QmkvPe
         E9CZV14oHjJExVnHQZRQr3pPMwlG8IdLL28kpJ7UCVKEjlJGpMamskWSw8oXGDLwJQYH
         bajjoVj6Il3t2NYDg+0IrNHV/JhJj3q09VhxeXTZaAmsZ5K8evTwkLZxtvY8rm+nwBZT
         mIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768257505; x=1768862305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTVbXO81dgCvnxfi3ImPomwfNu/IpWW6XLpFehoYhvI=;
        b=wUxomQ7sMIXti7vQ4zY82xzOrmrYszp83OOBh1FjnYi+GTQGXFHrOyLVRNXzleDmvZ
         bGSS/QEM98E1iTSvzXOeSW4zOukJykZt23cYbEa39Od8Oy9Sl8S6ZSOOsTBXAv+hP4U4
         ZQgPu1dPAsirDRlQnaehCNf2dchcKFkpf9lVpT6fYzMNME/1VdthK6H7+xd6Pbast9+X
         hihrlTeG+7bagQhSqSSKpEcvdfrWtC86VLfCilVFmHGaiHurfWYKRqKR1QXqgsWkxfeZ
         gslX7nVY8eQVCydb9YV1n7oDc6lfyW1i9pbJ0L/S3T0dcxulgB0pwuSzOuVkjB+bKZq0
         IO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEBOeQuvIW7Ya93V7tkJtNnwPvpFMf63hVceLUtz0GNjGGwGscBjryzoXQ1LKUQCA7vM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5LxtOZaKi2PfvN0ufC+vHsyZKgUwe6iBNLcHhqH4CU53b0lc
	kM8awh63D7aArX/iAsM+k71zxuwiNVMFS+ngTWttcB6NXYR678O42CTJu5bcMkDhvgwal7zGFk/
	IBBxKaMNkbPovtZBoWJ+TWG8+1jzhGZA=
X-Gm-Gg: AY/fxX4cGIFi8BBBd69u5IhWyXTL/u3rkMuc/K6hKtlTvTXz5dUA7IWF4AJ382lNabT
	RDy8JSQniCRVngUY+D9unVABnmz9ldtnLoGgcHj+xcuXAZ2U+vieL26d4cjW13hWI+JpPWvfJ+I
	1JkYgfhEbnxKwj7c0MGw+FaSZUkvQBeaxSdtON9H5qmZH9yPyMlFEk7hL2XJKv+SmYyvaCnNHEb
	q7CKeeLvHnvKptJeVFAQbZoAbeDMWTmZT0GS7J2fbMDEiCCKZ+FCTqpZevtD0laAi2qo/5EypoP
	v79YbgMN
X-Google-Smtp-Source: AGHT+IFz7LUeHI+kYtuqHhalJz4XxKiTz54DHHfRUYJrYlFiWMPo8UVJTTPcvCAnVEZKigw+Czz0BHZA1ecYHf+MFgo=
X-Received: by 2002:a05:690e:1484:b0:63e:17d8:d985 with SMTP id
 956f58d0204a3-64716c58882mr15617590d50.53.1768257504487; Mon, 12 Jan 2026
 14:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-11-ameryhung@gmail.com>
 <337d8ebe-d3d4-4818-92d8-4937da835843@linux.dev> <CAMB2axNcc5yJwhXjcEcQJuLxrjB7MgVK6XXpKqO9EiFPtQH6bQ@mail.gmail.com>
 <36b3dc2d-b850-491f-bfc5-3581d5de7b82@linux.dev>
In-Reply-To: <36b3dc2d-b850-491f-bfc5-3581d5de7b82@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 12 Jan 2026 14:38:13 -0800
X-Gm-Features: AZwV_Qh3prsmXcpwsE9R963M6ST6SIysIK_USv_yzlQoy3FWcqr-ApFTAIxvSVc
Message-ID: <CAMB2axNtrFEL0x+j6M3De-ezR38cv5s7LFtpuAeN7QCf_AyHaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 1:38=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
>
>
> On 1/9/26 12:47 PM, Amery Hung wrote:
> > On Fri, Jan 9, 2026 at 12:16=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >> On 12/18/25 9:56 AM, Amery Hung wrote:
> >>> Introduce bpf_selem_unlink_lockless() to properly handle errors retur=
ned
> >>> from rqspinlock in bpf_local_storage_map_free() and
> >>> bpf_local_storage_destroy() where the operation must succeeds.
> >>>
> >>> The idea of bpf_selem_unlink_lockless() is to allow an selem to be
> >>> partially linked and use refcount to determine when and who can free =
the
> >>> selem. An selem initially is fully linked to a map and a local storag=
e
> >>> and therefore selem->link_cnt is set to 2. Under normal circumstances=
,
> >>> bpf_selem_unlink_lockless() will be able to grab locks and unlink
> >>> an selem from map and local storage in sequeunce, just like
> >>> bpf_selem_unlink(), and then add it to a local tofree list provide by
> >>> the caller. However, if any of the lock attempts fails, it will
> >>> only clear SDATA(selem)->smap or selem->local_storage depending on th=
e
> >>> caller and decrement link_cnt to signal that the corresponding data
> >>> structure holding a reference to the selem is gone. Then, only when b=
oth
> >>> map and local storage are gone, an selem can be free by the last call=
er
> >>> that turns link_cnt to 0.
> >>>
> >>> To make sure bpf_obj_free_fields() is done only once and when map is
> >>> still present, it is called when unlinking an selem from b->list unde=
r
> >>> b->lock.
> >>>
> >>> To make sure uncharging memory is only done once and when owner is st=
ill
> >>> present, only unlink selem from local_storage->list in
> >>> bpf_local_storage_destroy() and return the amount of memory to unchar=
ge
> >>> to the caller (i.e., owner) since the map associated with an selem ma=
y
> >>> already be gone and map->ops->map_local_storage_uncharge can no longe=
r
> >>> be referenced.
> >>>
> >>> Finally, access of selem, SDATA(selem)->smap and selem->local_storage
> >>> are racy. Callers will protect these fields with RCU.
> >>>
> >>> Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
> >>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> >>> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> >>> ---
> >>>    include/linux/bpf_local_storage.h |  2 +-
> >>>    kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++++++++=
++--
> >>>    2 files changed, 74 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_lo=
cal_storage.h
> >>> index 20918c31b7e5..1fd908c44fb6 100644
> >>> --- a/include/linux/bpf_local_storage.h
> >>> +++ b/include/linux/bpf_local_storage.h
> >>> @@ -80,9 +80,9 @@ struct bpf_local_storage_elem {
> >>>                                                 * after raw_spin_unlo=
ck
> >>>                                                 */
> >>>        };
> >>> +     atomic_t link_cnt;
> >>>        u16 size;
> >>>        bool use_kmalloc_nolock;
> >>> -     /* 4 bytes hole */
> >>>        /* The data is stored in another cacheline to minimize
> >>>         * the number of cachelines access during a cache hit.
> >>>         */
> >>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_st=
orage.c
> >>> index 62201552dca6..4c682d5aef7f 100644
> >>> --- a/kernel/bpf/bpf_local_storage.c
> >>> +++ b/kernel/bpf/bpf_local_storage.c
> >>> @@ -97,6 +97,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap,=
 void *owner,
> >>>                        if (swap_uptrs)
> >>>                                bpf_obj_swap_uptrs(smap->map.record, S=
DATA(selem)->data, value);
> >>>                }
> >>> +             atomic_set(&selem->link_cnt, 2);
> >>>                selem->size =3D smap->elem_size;
> >>>                selem->use_kmalloc_nolock =3D smap->use_kmalloc_nolock=
;
> >>>                return selem;
> >>> @@ -200,9 +201,11 @@ static void bpf_selem_free_rcu(struct rcu_head *=
rcu)
> >>>        /* The bpf_local_storage_map_free will wait for rcu_barrier */
> >>>        smap =3D rcu_dereference_check(SDATA(selem)->smap, 1);
> >>>
> >>> -     migrate_disable();
> >>> -     bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> >>> -     migrate_enable();
> >>> +     if (smap) {
> >>> +             migrate_disable();
> >>> +             bpf_obj_free_fields(smap->map.record, SDATA(selem)->dat=
a);
> >>> +             migrate_enable();
> >>> +     }
> >>>        kfree_nolock(selem);
> >>>    }
> >>>
> >>> @@ -227,7 +230,8 @@ void bpf_selem_free(struct bpf_local_storage_elem=
 *selem,
> >>>                 * is only supported in task local storage, where
> >>>                 * smap->use_kmalloc_nolock =3D=3D true.
> >>>                 */
> >>> -             bpf_obj_free_fields(smap->map.record, SDATA(selem)->dat=
a);
> >>> +             if (smap)
> >>> +                     bpf_obj_free_fields(smap->map.record, SDATA(sel=
em)->data);
> >>>                __bpf_selem_free(selem, reuse_now);
> >>>                return;
> >>>        }
> >>> @@ -419,6 +423,71 @@ int bpf_selem_unlink(struct bpf_local_storage_el=
em *selem, bool reuse_now)
> >>>        return err;
> >>>    }
> >>>
> >>> +/* Callers of bpf_selem_unlink_lockless() */
> >>> +#define BPF_LOCAL_STORAGE_MAP_FREE   0
> >>> +#define BPF_LOCAL_STORAGE_DESTROY    1
> >>> +
> >>> +/*
> >>> + * Unlink an selem from map and local storage with lockless fallback=
 if callers
> >>> + * are racing or rqspinlock returns error. It should only be called =
by
> >>> + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> >>> + */
> >>> +static void bpf_selem_unlink_lockless(struct bpf_local_storage_elem =
*selem,
> >>> +                                   struct hlist_head *to_free, int c=
aller)
> >>> +{
> >>> +     struct bpf_local_storage *local_storage;
> >>> +     struct bpf_local_storage_map_bucket *b;
> >>> +     struct bpf_local_storage_map *smap;
> >>> +     unsigned long flags;
> >>> +     int err, unlink =3D 0;
> >>> +
> >>> +     local_storage =3D rcu_dereference_check(selem->local_storage, b=
pf_rcu_lock_held());
> >>> +     smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock=
_held());
> >>> +
> >>> +     /*
> >>> +      * Free special fields immediately as SDATA(selem)->smap will b=
e cleared.
> >>> +      * No BPF program should be reading the selem.
> >>> +      */
> >>> +     if (smap) {
> >>> +             b =3D select_bucket(smap, selem);
> >>> +             err =3D raw_res_spin_lock_irqsave(&b->lock, flags);
> >>> +             if (!err) {
> >>> +                     if (likely(selem_linked_to_map(selem))) {
> >>> +                             hlist_del_init_rcu(&selem->map_node);
> >>> +                             bpf_obj_free_fields(smap->map.record, S=
DATA(selem)->data);
> >>> +                             RCU_INIT_POINTER(SDATA(selem)->smap, NU=
LL);
> >>> +                             unlink++;
> >>> +                     }
> >>> +                     raw_res_spin_unlock_irqrestore(&b->lock, flags)=
;
> >>> +             } else if (caller =3D=3D BPF_LOCAL_STORAGE_MAP_FREE) {
> >>> +                     RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
> >>
> >> I suspect I am missing something obvious, so it will be faster to ask =
here.
> >>
> >> I could see why init NULL can work if it could assume the map_free
> >> caller always succeeds in the b->lock, the "if (!err)" path above.
> >>
> >> If the b->lock did fail here for the map_free caller, it reset
> >> SDATA(selem)->smap to NULL here. Who can do the bpf_obj_free_fields() =
in
> >> the future?
> >
> > I think this can only mean destroy() is holding the lock, and
> > destroy() should do bpf_selem_unlink_map_nolock(). Though I am not
>
> hmm... instead of bpf_selem_unlink_map_nolock(), do you mean the "if
> (!err)" path in this bpf_selem_unlink_lockless() function? or we are
> talking different things?

Ah yes. Sorry for the confusion.

>
> [ btw, a nit, I think it can use a better function name instead of
> "lockless". This function still takes the lock if it can. ]

Does using _nofail suffix make it more clear?

>
> > sure how destroy() can hold b->lock in a way that causes map_free() to
> > fail acquiring b->lock.
>
> I recall ETIMEDOUT was mentioned to be the likely (only?) case here.
> Assume the b->lock did fail in map_free here, there are >1 selem(s)
> using the same b->lock. Is it always true that the selem that failed at
> the b->lock in map_free() here must race with the very same selem in
> destroy()?
>
> >
> >>
> >>> +             }
> >>> +     }
> >>> +
> >>> +     /*
> >>> +      * Only let destroy() unlink from local_storage->list and do me=
m_uncharge
> >>> +      * as owner is guaranteed to be valid in destroy().
> >>> +      */
> >>> +     if (local_storage && caller =3D=3D BPF_LOCAL_STORAGE_DESTROY) {
> >>
> >> If I read here correctly, only bpf_local_storage_destroy() can do the
> >> bpf_selem_free(). For example, if a bpf_sk_storage_map is going away,
> >> the selem (which is memcg charged) will stay in the sk until the sk is
> >> closed?
> >
> > You read it correctly and Yes there will be stale elements in
> > local_storage->list.
> >
> > I would hope the unlink from local_storage part is doable from
> > map_free() and destroy(), but it is hard to guarantee (1) mem_uncharge
> > is done only once (2) while the owner is still valid in a lockless
> > way.
>
> This needs to be addressed. It cannot leave the selem lingering. At
> least the selem should be freed for the common case (i.e., succeeds in
> both locks). Lingering selem is ok in case of lock failure. Many sk can
> be long-lived connections. The user space may want to recreate the map,
> and it will be limited by the memcg.

I think this is doable by maintaining a local memory charge in local storag=
e.

So, remove selem->size and have a copy of total selem memory charge in
a new local_storage->selem_size. Update will be protected by
local_storage->lock in common paths (not in bpf_selem_unlink_nofail).
More specifically, charge in bpf_selem_link_storage_nolock() when a
selem is going to be publicized. uncharge in
bpf_selem_unlink_storage_nolock() when a selem is being deleted. Then,
in destroy() we simply get the total amount to be uncharged from the
owner from local_storage->selem_size.

WDYT?

>
> >
> >>
> >>> +             err =3D raw_res_spin_lock_irqsave(&local_storage->lock,=
 flags);
> >>> +             if (!err) {
> >>> +                     hlist_del_init_rcu(&selem->snode);
> >>> +                     unlink++;
> >>> +                     raw_res_spin_unlock_irqrestore(&local_storage->=
lock, flags);
> >>> +             }
> >>> +             RCU_INIT_POINTER(selem->local_storage, NULL);
> >>> +     }
> >>> +
> >>> +     /*
> >>> +      * Normally, an selem can be unlink under local_storage->lock a=
nd b->lock, and
> >>> +      * then added to a local to_free list. However, if destroy() an=
d map_free() are
> >>> +      * racing or rqspinlock returns errors in unlikely situations (=
unlink !=3D 2), free
> >>> +      * the selem only after both map_free() and destroy() drop the =
refcnt.
> >>> +      */
> >>> +     if (unlink =3D=3D 2 || atomic_dec_and_test(&selem->link_cnt))
> >>> +             hlist_add_head(&selem->free_node, to_free);
> >>> +}
> >>> +
> >>>    void __bpf_local_storage_insert_cache(struct bpf_local_storage *lo=
cal_storage,
> >>>                                      struct bpf_local_storage_map *sm=
ap,
> >>>                                      struct bpf_local_storage_elem *s=
elem)
> >>
>

