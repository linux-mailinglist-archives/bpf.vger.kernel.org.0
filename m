Return-Path: <bpf+bounces-78621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5CDD15677
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D2F3029C54
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5CD33065C;
	Mon, 12 Jan 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNRa4Np2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F231DD86
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252691; cv=none; b=gxs3Px3U4V1aJ9pCXpck8PiUwV/gt5pQO/uJG0ZrgxgeF7GcoiuKdiCL56V6a8lUom6tNc6FiAPZ9+mrujfeyXh9bJ1vri4KtR1n1h1+gZQQdm9iJSujFtQ5wWkGtl+O+9MiJkAC5ni6KF8ru/xcO37RFqoj3aqxpeMHizq+jrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252691; c=relaxed/simple;
	bh=s8a+gPjt7hj7oq8bF7GhHzPHaIZnBKOAxW3LtfIYHF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEODXFgWYJsAtsrSgydJejjQefIkwOSkKmuOZdCO7B+BVlBFkYhKG9+DuyO78nY5z++h71aTnPP5G6FeKUffw3lP7M1hAWlwEZXDVGyQTTrFxs63+Irl/pusZaweAmMKHbhEs1zpnskTXvHnh2dN7IojU/hqnVMFzF3O67imEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNRa4Np2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7926d5dbdf7so24660177b3.2
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 13:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252688; x=1768857488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbHArmVdLi5oRFraNTOf6NlWHgp0R/2Gx0rbO76HpjQ=;
        b=VNRa4Np2T9pzzpCJ0p9SuPnD0EpFKM+PJN0JZ/s68on1R+yxQ7+OctiHkn9LjAqipG
         fdO2qk3p37gAUtAFjww74TrIh98exiYtBcKlRIPKhkyj3xcR9f9o3NnoDYjQxj66zbJz
         nHZrJ8WNyQ8ADPHz0dHkkfSiyXcfCsitNlW8MBk5JlF0qAsIIlH8Xii0qgv1YTdikXpg
         XSXRBsYBnx3mUmKx2NjB/t8aQPiDkPnBh5qwSLMb1q0/lU8+r9UXlrcdH+IlPaO0v07J
         9ws69lcrttYWcRPuLaoelbEtOmaSk7ToL5Pd7EQqVQ4EyU3/xFwcg53SufQ8c7zI0z1E
         4xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252688; x=1768857488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rbHArmVdLi5oRFraNTOf6NlWHgp0R/2Gx0rbO76HpjQ=;
        b=bvf+WAskWSZvuGSB/GIhKdIpdV9Ox6vqhEWqF+3CC8QpipDWln2VmPhpLZuz3eiRcr
         szoaXzDDB+cPYxTj3NPIz/Widt7NZHegfNXmO7L0uaCIGF7rXOdg9uer4YFwvvvpMUfs
         dasn8dujphlJM2Bdd4NTB8jFaucHVPPJ4CGzcwVTnFjrM7nDuwCNBVVOKwRcQVlFh6J8
         odcF3u62mF2H2V7i2RwfcSG7BfgJG9estf9c4sIY5mspsPsAC2SgX16++b9AZATr8Zhl
         mts36A15A2cgxL6A2jTtVbQw5rTb0SxvMGah0VfnuS32QPvqeM0AXqYvpYftd/2WJ8/i
         90Mg==
X-Gm-Message-State: AOJu0YyB9yIoSU8BOyjyTVES/ol1ZXs723Vui7J5K+yStUNTcI5ctyvY
	kXtkzSquyDOaMs/cXq/gfI15c3SX0ZhfLJsJfRpv8VlQRwq9VZlELJOBO8AEupucrEhhz9iMxZf
	q1wFG6gvrLXPuI4xEM5P1mEgZpf+gj2g=
X-Gm-Gg: AY/fxX44VCgNUxlMsYDmuOHRGVYOyaZMUpUSU6RiqDnIyFAyXZ4lTKXBJlIQwbcCYYL
	PIJTr8HBuyPOLUgHpk6oLIFbi/D3+mMDs18nPCyzPBQHQqv1FekUvxF3zETWKRSbLdTlcjj0lJW
	e0J4GVnV7STMnLt6OMRFCq2srPyhTZ+evoX/I2b3XmNWqVZpSsJNTqrxY+mRQBa9JMa68eyygYg
	b6Lzd8a2rCmAeq4Sx+mhx3E9rwgVDB/iE1E/sl7Hmm3nETtwzvU6i9dwjl7/Y8teWcf/zzJYEjl
	pEeRe/uA
X-Google-Smtp-Source: AGHT+IEX35rUFPFBkKijOWqxkXG5A/svyj9AWmqKFF9AO1LzWStkG9KgN68mFQdyIJwLI83hyB9TTNebjP9yzozS7E0=
X-Received: by 2002:a05:690e:1699:b0:643:1ef1:9613 with SMTP id
 956f58d0204a3-64716b5f76cmr15998258d50.15.1768252687787; Mon, 12 Jan 2026
 13:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-11-ameryhung@gmail.com>
 <CAP01T77R+inOoL-f7RMovqE1rwG5YTBysEXg2Sez60LiWZu2eg@mail.gmail.com> <CAP01T77j50Mfh52zvOzg_1PqseGvoeMB8mDPTi-8dJ1EMqA2Zw@mail.gmail.com>
In-Reply-To: <CAP01T77j50Mfh52zvOzg_1PqseGvoeMB8mDPTi-8dJ1EMqA2Zw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 12 Jan 2026 13:17:56 -0800
X-Gm-Features: AZwV_QjwHv0hCHBUJUXS76ajnPqUTzvWP1TaT6SFvm3w4OEPxHFb6Ngg_Tcg5Wk
Message-ID: <CAMB2axNT04=cc7-7XaDqhVKRbHm4zivW5kmwRpLbrFTVYwmm3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:49=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 12 Jan 2026 at 16:36, Kumar Kartikeya Dwivedi <memxor@gmail.com> =
wrote:
> >
> > On Thu, 18 Dec 2025 at 18:56, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > Introduce bpf_selem_unlink_lockless() to properly handle errors retur=
ned
> > > from rqspinlock in bpf_local_storage_map_free() and
> > > bpf_local_storage_destroy() where the operation must succeeds.
> > >
> > > The idea of bpf_selem_unlink_lockless() is to allow an selem to be
> > > partially linked and use refcount to determine when and who can free =
the
> > > selem. An selem initially is fully linked to a map and a local storag=
e
> > > and therefore selem->link_cnt is set to 2. Under normal circumstances=
,
> > > bpf_selem_unlink_lockless() will be able to grab locks and unlink
> > > an selem from map and local storage in sequeunce, just like
> > > bpf_selem_unlink(), and then add it to a local tofree list provide by
> > > the caller. However, if any of the lock attempts fails, it will
> > > only clear SDATA(selem)->smap or selem->local_storage depending on th=
e
> > > caller and decrement link_cnt to signal that the corresponding data
> > > structure holding a reference to the selem is gone. Then, only when b=
oth
> > > map and local storage are gone, an selem can be free by the last call=
er
> > > that turns link_cnt to 0.
> > >
> > > To make sure bpf_obj_free_fields() is done only once and when map is
> > > still present, it is called when unlinking an selem from b->list unde=
r
> > > b->lock.
> > >
> > > To make sure uncharging memory is only done once and when owner is st=
ill
> > > present, only unlink selem from local_storage->list in
> > > bpf_local_storage_destroy() and return the amount of memory to unchar=
ge
> > > to the caller (i.e., owner) since the map associated with an selem ma=
y
> > > already be gone and map->ops->map_local_storage_uncharge can no longe=
r
> > > be referenced.
> > >
> > > Finally, access of selem, SDATA(selem)->smap and selem->local_storage
> > > are racy. Callers will protect these fields with RCU.
> > >
> > > Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  include/linux/bpf_local_storage.h |  2 +-
> > >  kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++++++++++=
--
> > >  2 files changed, 74 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_lo=
cal_storage.h
> > > index 20918c31b7e5..1fd908c44fb6 100644
> > > --- a/include/linux/bpf_local_storage.h
> > > +++ b/include/linux/bpf_local_storage.h
> > > @@ -80,9 +80,9 @@ struct bpf_local_storage_elem {
> > >                                                  * after raw_spin_unl=
ock
> > >                                                  */
> > >         };
> > > +       atomic_t link_cnt;
> > >         u16 size;
> > >         bool use_kmalloc_nolock;
> > > -       /* 4 bytes hole */
> > >         /* The data is stored in another cacheline to minimize
> > >          * the number of cachelines access during a cache hit.
> > >          */
> > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_st=
orage.c
> > > index 62201552dca6..4c682d5aef7f 100644
> > > --- a/kernel/bpf/bpf_local_storage.c
> > > +++ b/kernel/bpf/bpf_local_storage.c
> > > @@ -97,6 +97,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap,=
 void *owner,
> > >                         if (swap_uptrs)
> > >                                 bpf_obj_swap_uptrs(smap->map.record, =
SDATA(selem)->data, value);
> > >                 }
> > > +               atomic_set(&selem->link_cnt, 2);
> > >                 selem->size =3D smap->elem_size;
> > >                 selem->use_kmalloc_nolock =3D smap->use_kmalloc_noloc=
k;
> > >                 return selem;
> > > @@ -200,9 +201,11 @@ static void bpf_selem_free_rcu(struct rcu_head *=
rcu)
> > >         /* The bpf_local_storage_map_free will wait for rcu_barrier *=
/
> > >         smap =3D rcu_dereference_check(SDATA(selem)->smap, 1);
> > >
> > > -       migrate_disable();
> > > -       bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> > > -       migrate_enable();
> > > +       if (smap) {
> > > +               migrate_disable();
> > > +               bpf_obj_free_fields(smap->map.record, SDATA(selem)->d=
ata);
> > > +               migrate_enable();
> > > +       }
> > >         kfree_nolock(selem);
> > >  }
> > >
> > > @@ -227,7 +230,8 @@ void bpf_selem_free(struct bpf_local_storage_elem=
 *selem,
> > >                  * is only supported in task local storage, where
> > >                  * smap->use_kmalloc_nolock =3D=3D true.
> > >                  */
> > > -               bpf_obj_free_fields(smap->map.record, SDATA(selem)->d=
ata);
> > > +               if (smap)
> > > +                       bpf_obj_free_fields(smap->map.record, SDATA(s=
elem)->data);
> > >                 __bpf_selem_free(selem, reuse_now);
> > >                 return;
> > >         }
> > > @@ -419,6 +423,71 @@ int bpf_selem_unlink(struct bpf_local_storage_el=
em *selem, bool reuse_now)
> > >         return err;
> > >  }
> > >
> > > +/* Callers of bpf_selem_unlink_lockless() */
> > > +#define BPF_LOCAL_STORAGE_MAP_FREE     0
> > > +#define BPF_LOCAL_STORAGE_DESTROY      1
> > > +
> > > +/*
> > > + * Unlink an selem from map and local storage with lockless fallback=
 if callers
> > > + * are racing or rqspinlock returns error. It should only be called =
by
> > > + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> > > + */
> > > +static void bpf_selem_unlink_lockless(struct bpf_local_storage_elem =
*selem,
> > > +                                     struct hlist_head *to_free, int=
 caller)
> > > +{
> > > +       struct bpf_local_storage *local_storage;
> > > +       struct bpf_local_storage_map_bucket *b;
> > > +       struct bpf_local_storage_map *smap;
> > > +       unsigned long flags;
> > > +       int err, unlink =3D 0;
> > > +
> > > +       local_storage =3D rcu_dereference_check(selem->local_storage,=
 bpf_rcu_lock_held());
> > > +       smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lo=
ck_held());
> > > +
> > > +       /*
> > > +        * Free special fields immediately as SDATA(selem)->smap will=
 be cleared.
> > > +        * No BPF program should be reading the selem.
> > > +        */
> > > +       if (smap) {
> > > +               b =3D select_bucket(smap, selem);
> > > +               err =3D raw_res_spin_lock_irqsave(&b->lock, flags);
> >
> > Please correct me if I'm wrong with any of this here. I think this is
> > the only potential problem I see, i.e. if we assume that this call can
> > fail for map_free.
> > map_free fails here, goes to the bottom with unlink =3D=3D 0, and moves
> > refcnt from 2 to 1.
> > Before it restarts its loop, destroy() which was going in parallel and
> > caused the failure already succeeded in smap removal and local storage
> > removal, has unlink =3D=3D 2, so proceeds with bpf_selem_free_list.
> > It frees the selem with RCU gp.
> > Meanwhile our loop races around cond_resched_rcu(), which restarts the
> > read section so the element is freed before we restart the while loop.
> > Would we do UAF?
> >
> >   1. map_free() fails b->lock, link_cnt 2->1, map_node still linked
> >   2. destroy() succeeds (unlink =3D=3D 2), calls bpf_selem_free_list(),
> > does RCU free
>
> The ordering here is probably a bit messed up, but map_free would need
> to wrap around to the start of its loop on the other side right before
> destroy() does hlist_del_init_rcu(), and then let it free the node
> before proceeding.
> At that point I guess it would still wait for our newly started read
> section, but we'd probably still observe the refcount as 0 and end up
> underflowing.
> So we may not need any change to cond_resched_rcu() but just a
> dec_not_zero to make things safe.
>

Thanks for bringing up the corner case!

I am not sure how underflowing can happen with atomic_dec_and_test().
However, if map_free() visits the same selem twice and fails to
acquire b->lock both times, we might double free the selem as
map_free() drops the refcount twice and also tries to free it.

I think we need to be more precise about when we drop refcnt.
Something like below:

bool drop_refcnt =3D false;
...

drop_refcnt =3D (smap && caller =3D=3D BPF_LOCAL_STORAGE_MAP_FREE ||
              local_storage && caller =3D=3D BPF_LOCAL_STORAGE_DESTROY);

if (unlink =3D=3D 2 || (drop_refcnt && atomic_dec_and_test(&selem->link_cnt=
)))
                hlist_add_head(&selem->free_node, to_free);


> That said none of it feels worth it when compared to just warning on
> an error taking the bucket lock in map_free(), unless there are other
> concerns I missed.

I feel this is also same with the orignial "can we assume the lock
always succeed and use WARN_ON" discussion. So, I think it is better
to be able to handle the error than using WARN_ON. This also doesn't
add too much complexity IMO.

>
>
> >   3. map_free()'s cond_resched_rcu() releases rcu_read_lock()
> >   4. RCU grace period completes, selem is freed
> >   5. map_free() re-acquires rcu_read_lock(), hlist_first_rcu() returns
> > freed memory
> >
> > I think the fix is that we might want to unlink from map_node in
> > bpf_selem_free_list and do dec_not_zero instead, and avoid the
> > cond_resched_rcu().
> > If we race with destroy(), and end up doing another iteration on the
> > same element, we will keep our RCU gp so not access freed memory, and
> > avoid moving refcount < 0 due to dec_not_zero. By the time we restart
> > third time we will no longer see the element.
> >
> > But removing cond_resched_rcu() doesn't seem attractive (I don't think
> > there's a variant that does cond_resched() while holding the RCU read
> > lock).
> >
> > Things become much simpler if we assume map_free() cannot fail when
> > acquiring the bucket lock. It seems to me that we should make that
> > assumption, since destroy() in task context is the only racing
> > invocation.
> > If we are getting timeouts something is seriously wrong.
> > WARN_ON_ONCE(err && caller =3D=3D BPF_LOCAL_STORAGE_MAP_FREE).
> > Then remove else if branch.
> > The converse (assuming it will always succeed for destroy()) is not
> > true, since BPF programs can cause deadlocks. But the problem is only
> > around map_node unlinking.
> >
> >
> > > +               if (!err) {
> > > +                       if (likely(selem_linked_to_map(selem))) {
> > > +                               hlist_del_init_rcu(&selem->map_node);
> > > +                               bpf_obj_free_fields(smap->map.record,=
 SDATA(selem)->data);
> > > +                               RCU_INIT_POINTER(SDATA(selem)->smap, =
NULL);
> > > +                               unlink++;
> > > +                       }
> > > +                       raw_res_spin_unlock_irqrestore(&b->lock, flag=
s);
> > > +               } else if (caller =3D=3D BPF_LOCAL_STORAGE_MAP_FREE) =
{
> > > +                       RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
> > > +               }
> > > +       }
> > > +
> > > +       /*
> > > +        * Only let destroy() unlink from local_storage->list and do =
mem_uncharge
> > > +        * as owner is guaranteed to be valid in destroy().
> > > +        */
> > > +       if (local_storage && caller =3D=3D BPF_LOCAL_STORAGE_DESTROY)=
 {
> > > +               err =3D raw_res_spin_lock_irqsave(&local_storage->loc=
k, flags);
> > > +               if (!err) {
> > > +                       hlist_del_init_rcu(&selem->snode);
> > > +                       unlink++;
> > > +                       raw_res_spin_unlock_irqrestore(&local_storage=
->lock, flags);
> > > +               }
> > > +               RCU_INIT_POINTER(selem->local_storage, NULL);
> > > +       }
> > > +
> > > +       /*
> > > +        * Normally, an selem can be unlink under local_storage->lock=
 and b->lock, and
> > > +        * then added to a local to_free list. However, if destroy() =
and map_free() are
> > > +        * racing or rqspinlock returns errors in unlikely situations=
 (unlink !=3D 2), free
> > > +        * the selem only after both map_free() and destroy() drop th=
e refcnt.
> > > +        */
> > > +       if (unlink =3D=3D 2 || atomic_dec_and_test(&selem->link_cnt))
> > > +               hlist_add_head(&selem->free_node, to_free);
> > > +}
> > > +
> > >  void __bpf_local_storage_insert_cache(struct bpf_local_storage *loca=
l_storage,
> > >                                       struct bpf_local_storage_map *s=
map,
> > >                                       struct bpf_local_storage_elem *=
selem)
> > > --
> > > 2.47.3
> > >

