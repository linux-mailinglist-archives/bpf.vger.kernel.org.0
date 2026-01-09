Return-Path: <bpf+bounces-78380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C7D0C353
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 21:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D119302036A
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C2298CB2;
	Fri,  9 Jan 2026 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiTiPnlb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31819F48D
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991649; cv=none; b=nHCW/JpesckWYF+0/40HUcqmC6tddi85kmrj64xOhFR68HiHrtQyHaHRs6lOXvAzaei5aiGwLZFdRSthhjtNmPJ12kchQ7iKUJpZTqTwYW02gSW91WSFE+tXeo04teNpsjx61eRcUPzxoNd6m0MwMiP/86jysO4ocwKiiThrOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991649; c=relaxed/simple;
	bh=PSA/k/anF7VXSVhlQjeMeflnMK59AXXHIVFTASvO4x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX63qphAxYjTzVty8ffC4Pofx7lZWTEPqZ71lI2d/qcZjVxCJD6GPEH9YcYBPbKWtduoSVt/pyWgDxIRFEFafDTnIM3sx+ol4OeH2MyTUktafMLnVmlaMicIxPsV8JeMY+HRKlrd4S5bQkYh+Erpz68CeRdklLHUn07sqaDypHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiTiPnlb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-790b7b3e594so33527837b3.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 12:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767991647; x=1768596447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/liWgO+pyxuxcoTX/hyWPb0SGyGbp3S72EOfVoL+hw=;
        b=GiTiPnlbzyESUPS6aEUeQXquK8ZAF3HmZiZwYn+/AJjhY+VDRtVloFf9sp3y63JFaB
         W+m++lm1qTGZTiXPalHmKAWF3PADHkt91Mi9I0Z9EZ3R2KDTbl3an47JgOxUTmAxrvLc
         c2o7gYTEZA4bwdBrlXuze7vPT6prAwG0kgIgEHYr17KkXkGdWzpIXhDMosEhXxmMiw0d
         wdVxWUuqhMp6AicnvaNsMQ/MCfw3nWER7FHoxXxmzQNi/kZ72915rgQwyyP/xgknK7Ef
         dVrY43rHMbnNqdMu9VjsKOlkJPufN0dsicrf0vwv8Vn03avikMRJiuvyljYDnxNp3OfR
         Ka6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767991647; x=1768596447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/liWgO+pyxuxcoTX/hyWPb0SGyGbp3S72EOfVoL+hw=;
        b=ufJsEzgDh86VIUnlxmjKOxfUVdAaT78xdJAjigQmWKL77RJG6GRNkcfODFmDrh1U9e
         vJmnQsQvm/WnE3GeXrbE/IGdGatU0IpRN04qLg1LukxZM8Quk0c+DKox83qNQ8f7E8eV
         zKYEfCCiRI+3rm+oBtcpflpIcHNkQa3CpgCElmlcY733vvWUdHdhJFuIi2sxtSBpLzHn
         24zJ0hjh4hh3TrRtFvLST8g/VirRpF2JKVpXHxTjLyUv4fGVkU2sI5bTEk60qCgMN9Kx
         AGQ+Ji3GvvDJ2vojrBocrLOitHa/B+rwb33eTQ5qhNVU5IZU/BV++yPCU4LqrXKC+nh9
         6q+w==
X-Forwarded-Encrypted: i=1; AJvYcCUlcWV0gK6umuMGmz2a8YUorBAskXDtqYS81eCB/CK15nyhqB235rh+4bUiLtd99VqjOIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPsrYJybCBwCxocBTDdZE8Clg9oJrXJN/1L+h2xZQ4kZCKDRe
	alSMHvEH1siqhSgixnURWwvObEHcDZJh4uHCpR537fbT0ercQCeAiuMMEuYXKIWfSYF6OSzO2co
	Bsoe7KwzhHxKlrSTX+0nl/DiCDBuO1zU=
X-Gm-Gg: AY/fxX5vBhEOdiM98YqnL/Wm1dNJQOkr6jD43oOwxpkjSdC2PmXwU+nLWzYm1ezuZDe
	GI8tacUxOxCtT6UTv4zRmkltwhh5naEEBpX7Q4bWILXdFbI5Ka/Xw6rfRWALkO2j6vznY0n8igu
	C0nDi0gSVkFgsrZOogHIUU1foCOGxuldgnjpNLOGWb2ohdEPEVQPxG0DQnjS+WnB3s3NfRson4Y
	sg0noYvN58uhEqR9fy9cDkX1RFhsbJQ78EWzaxY7NLgOmy2EX+IEC+t5tskPjYwD7um6bBfIr0U
	7iDpSirCadsjVszVgMvT7g==
X-Google-Smtp-Source: AGHT+IHzyx6DFZ0vBxM2v4EcbI3S+rKkluOGDtnWwejzJIK3eOgFLBBP9/k55I9qDLAPln0O5NksgfRf5YoYpuC2x5w=
X-Received: by 2002:a05:690e:e82:b0:646:7d1b:614f with SMTP id
 956f58d0204a3-64716c19ae5mr9317404d50.56.1767991646935; Fri, 09 Jan 2026
 12:47:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-11-ameryhung@gmail.com>
 <337d8ebe-d3d4-4818-92d8-4937da835843@linux.dev>
In-Reply-To: <337d8ebe-d3d4-4818-92d8-4937da835843@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 9 Jan 2026 12:47:16 -0800
X-Gm-Features: AQt7F2oEAG1V8tkwQvJ1KqQ48EFKg6MkEkbMiayQSTzscQNvsA0a-ndzIr7PrqA
Message-ID: <CAMB2axNcc5yJwhXjcEcQJuLxrjB7MgVK6XXpKqO9EiFPtQH6bQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:16=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
>
>
> On 12/18/25 9:56 AM, Amery Hung wrote:
> > Introduce bpf_selem_unlink_lockless() to properly handle errors returne=
d
> > from rqspinlock in bpf_local_storage_map_free() and
> > bpf_local_storage_destroy() where the operation must succeeds.
> >
> > The idea of bpf_selem_unlink_lockless() is to allow an selem to be
> > partially linked and use refcount to determine when and who can free th=
e
> > selem. An selem initially is fully linked to a map and a local storage
> > and therefore selem->link_cnt is set to 2. Under normal circumstances,
> > bpf_selem_unlink_lockless() will be able to grab locks and unlink
> > an selem from map and local storage in sequeunce, just like
> > bpf_selem_unlink(), and then add it to a local tofree list provide by
> > the caller. However, if any of the lock attempts fails, it will
> > only clear SDATA(selem)->smap or selem->local_storage depending on the
> > caller and decrement link_cnt to signal that the corresponding data
> > structure holding a reference to the selem is gone. Then, only when bot=
h
> > map and local storage are gone, an selem can be free by the last caller
> > that turns link_cnt to 0.
> >
> > To make sure bpf_obj_free_fields() is done only once and when map is
> > still present, it is called when unlinking an selem from b->list under
> > b->lock.
> >
> > To make sure uncharging memory is only done once and when owner is stil=
l
> > present, only unlink selem from local_storage->list in
> > bpf_local_storage_destroy() and return the amount of memory to uncharge
> > to the caller (i.e., owner) since the map associated with an selem may
> > already be gone and map->ops->map_local_storage_uncharge can no longer
> > be referenced.
> >
> > Finally, access of selem, SDATA(selem)->smap and selem->local_storage
> > are racy. Callers will protect these fields with RCU.
> >
> > Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   include/linux/bpf_local_storage.h |  2 +-
> >   kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++++++++++-=
-
> >   2 files changed, 74 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loca=
l_storage.h
> > index 20918c31b7e5..1fd908c44fb6 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -80,9 +80,9 @@ struct bpf_local_storage_elem {
> >                                                * after raw_spin_unlock
> >                                                */
> >       };
> > +     atomic_t link_cnt;
> >       u16 size;
> >       bool use_kmalloc_nolock;
> > -     /* 4 bytes hole */
> >       /* The data is stored in another cacheline to minimize
> >        * the number of cachelines access during a cache hit.
> >        */
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index 62201552dca6..4c682d5aef7f 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -97,6 +97,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, v=
oid *owner,
> >                       if (swap_uptrs)
> >                               bpf_obj_swap_uptrs(smap->map.record, SDAT=
A(selem)->data, value);
> >               }
> > +             atomic_set(&selem->link_cnt, 2);
> >               selem->size =3D smap->elem_size;
> >               selem->use_kmalloc_nolock =3D smap->use_kmalloc_nolock;
> >               return selem;
> > @@ -200,9 +201,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rc=
u)
> >       /* The bpf_local_storage_map_free will wait for rcu_barrier */
> >       smap =3D rcu_dereference_check(SDATA(selem)->smap, 1);
> >
> > -     migrate_disable();
> > -     bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> > -     migrate_enable();
> > +     if (smap) {
> > +             migrate_disable();
> > +             bpf_obj_free_fields(smap->map.record, SDATA(selem)->data)=
;
> > +             migrate_enable();
> > +     }
> >       kfree_nolock(selem);
> >   }
> >
> > @@ -227,7 +230,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *=
selem,
> >                * is only supported in task local storage, where
> >                * smap->use_kmalloc_nolock =3D=3D true.
> >                */
> > -             bpf_obj_free_fields(smap->map.record, SDATA(selem)->data)=
;
> > +             if (smap)
> > +                     bpf_obj_free_fields(smap->map.record, SDATA(selem=
)->data);
> >               __bpf_selem_free(selem, reuse_now);
> >               return;
> >       }
> > @@ -419,6 +423,71 @@ int bpf_selem_unlink(struct bpf_local_storage_elem=
 *selem, bool reuse_now)
> >       return err;
> >   }
> >
> > +/* Callers of bpf_selem_unlink_lockless() */
> > +#define BPF_LOCAL_STORAGE_MAP_FREE   0
> > +#define BPF_LOCAL_STORAGE_DESTROY    1
> > +
> > +/*
> > + * Unlink an selem from map and local storage with lockless fallback i=
f callers
> > + * are racing or rqspinlock returns error. It should only be called by
> > + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> > + */
> > +static void bpf_selem_unlink_lockless(struct bpf_local_storage_elem *s=
elem,
> > +                                   struct hlist_head *to_free, int cal=
ler)
> > +{
> > +     struct bpf_local_storage *local_storage;
> > +     struct bpf_local_storage_map_bucket *b;
> > +     struct bpf_local_storage_map *smap;
> > +     unsigned long flags;
> > +     int err, unlink =3D 0;
> > +
> > +     local_storage =3D rcu_dereference_check(selem->local_storage, bpf=
_rcu_lock_held());
> > +     smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_h=
eld());
> > +
> > +     /*
> > +      * Free special fields immediately as SDATA(selem)->smap will be =
cleared.
> > +      * No BPF program should be reading the selem.
> > +      */
> > +     if (smap) {
> > +             b =3D select_bucket(smap, selem);
> > +             err =3D raw_res_spin_lock_irqsave(&b->lock, flags);
> > +             if (!err) {
> > +                     if (likely(selem_linked_to_map(selem))) {
> > +                             hlist_del_init_rcu(&selem->map_node);
> > +                             bpf_obj_free_fields(smap->map.record, SDA=
TA(selem)->data);
> > +                             RCU_INIT_POINTER(SDATA(selem)->smap, NULL=
);
> > +                             unlink++;
> > +                     }
> > +                     raw_res_spin_unlock_irqrestore(&b->lock, flags);
> > +             } else if (caller =3D=3D BPF_LOCAL_STORAGE_MAP_FREE) {
> > +                     RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
>
> I suspect I am missing something obvious, so it will be faster to ask her=
e.
>
> I could see why init NULL can work if it could assume the map_free
> caller always succeeds in the b->lock, the "if (!err)" path above.
>
> If the b->lock did fail here for the map_free caller, it reset
> SDATA(selem)->smap to NULL here. Who can do the bpf_obj_free_fields() in
> the future?

I think this can only mean destroy() is holding the lock, and
destroy() should do bpf_selem_unlink_map_nolock(). Though I am not
sure how destroy() can hold b->lock in a way that causes map_free() to
fail acquiring b->lock.

>
> > +             }
> > +     }
> > +
> > +     /*
> > +      * Only let destroy() unlink from local_storage->list and do mem_=
uncharge
> > +      * as owner is guaranteed to be valid in destroy().
> > +      */
> > +     if (local_storage && caller =3D=3D BPF_LOCAL_STORAGE_DESTROY) {
>
> If I read here correctly, only bpf_local_storage_destroy() can do the
> bpf_selem_free(). For example, if a bpf_sk_storage_map is going away,
> the selem (which is memcg charged) will stay in the sk until the sk is
> closed?

You read it correctly and Yes there will be stale elements in
local_storage->list.

I would hope the unlink from local_storage part is doable from
map_free() and destroy(), but it is hard to guarantee (1) mem_uncharge
is done only once (2) while the owner is still valid in a lockless
way.

>
> > +             err =3D raw_res_spin_lock_irqsave(&local_storage->lock, f=
lags);
> > +             if (!err) {
> > +                     hlist_del_init_rcu(&selem->snode);
> > +                     unlink++;
> > +                     raw_res_spin_unlock_irqrestore(&local_storage->lo=
ck, flags);
> > +             }
> > +             RCU_INIT_POINTER(selem->local_storage, NULL);
> > +     }
> > +
> > +     /*
> > +      * Normally, an selem can be unlink under local_storage->lock and=
 b->lock, and
> > +      * then added to a local to_free list. However, if destroy() and =
map_free() are
> > +      * racing or rqspinlock returns errors in unlikely situations (un=
link !=3D 2), free
> > +      * the selem only after both map_free() and destroy() drop the re=
fcnt.
> > +      */
> > +     if (unlink =3D=3D 2 || atomic_dec_and_test(&selem->link_cnt))
> > +             hlist_add_head(&selem->free_node, to_free);
> > +}
> > +
> >   void __bpf_local_storage_insert_cache(struct bpf_local_storage *local=
_storage,
> >                                     struct bpf_local_storage_map *smap,
> >                                     struct bpf_local_storage_elem *sele=
m)
>

