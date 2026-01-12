Return-Path: <bpf+bounces-78592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8BAD13CB0
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 320D93058170
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F2361655;
	Mon, 12 Jan 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY+xgpMK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D43612C5
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232231; cv=none; b=j0XLVe2aXsopphLHaTTEPZ0X6pQtGjt0gJHmImpbOEaMV6O6rH4iKz91tNbvEiwkHImg2Nkw6QiF7iUFgy7qfzn0wdi0c8yBByNOvAGpcUkEuUbmZ7QFqNW6EOcxn2nwiNaP0pmhTUAOsWX0PGSEp20kG6B2jwWCrqvp2VV2Zqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232231; c=relaxed/simple;
	bh=n+Dg+KzPvb/r7hEMNmOehERgMf7Fyb87bwnsLcHLJdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWlkAnxkxhXmbtJDJoue2gxoTejDe2Hbs0gCFSiRW84gsp3kPSkkuGFtfjwRaSFwMruq8tzi0IQoU2ByxRhOVyHSj0c6iQsfUwUESXXJPDLIIj9Qs/0TfGjglyb+06tWHcBfuU9lhAut9HGx//LB5I4DyZADq6nJ4oU9xjeLwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY+xgpMK; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-65f6f9d84d6so1235876eaf.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768232228; x=1768837028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEIVUXaPFIderMGdJFmz2WNJUbhy4IuvTb9rGw59PzI=;
        b=TY+xgpMKM93aYCmtyBcpyuGS29cueCiIrR+rpz8NrW6Kk7rkGeS+j2JUL59gxjO+Xs
         YUO579Yv7h+T493NUDt7KgVdJ+mMGWQstcMyk1rW7rc2DZHwOIwSwgSkj1fJuTFHg8LM
         AayN+6qck7ua8QerDGpT5Ga0UClTBZuebE8qRsFl8x/MmwOSDtP3nKc38nmYBi37Nk+u
         cNT5XIr9mNsUZ7qM8Mn2MgRE9gMwdgEorxPXUAMbsQ0MD7KlNmDhw183AIxCbnSD2zh+
         9Wwms3bzkj6tAEO5b7Hbjy5TMRcPJIdTPUM8fHA2nBhgzLUJSSMaRfp+pdaA3nQhYGRy
         MrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232228; x=1768837028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEIVUXaPFIderMGdJFmz2WNJUbhy4IuvTb9rGw59PzI=;
        b=gk9NaXoOxLuLuzRR+aQHCuHstd9EwvQc6nZOZmqmgncRTTqousfR4JECmR0GTLAVXK
         NrUhSioHFT/ZnGdmShtKmT1UP0frLeNZcCmOQfWsYoo1s6oCnTCCLbGOE4boenqAy5QF
         KbI8cyCQNMswy9wPOpc8stuGK5agj7XhvcMVKCP3b4DcmjJYPYPjUtmc+USfTb45J/Kn
         Ue+5dNWMifLfwwYtMOcKjSQnf7pfqNOii2HznwRraEnFRoc+tDIqQRzyuDp4rTDPzo/F
         MlSP/tx2aIJLpAqlCur5vCxj0Rmn4N0LlI1/8pYCUycY03sEc/U19f3fOKEeblj6yFUN
         xwgQ==
X-Gm-Message-State: AOJu0YyhLzkcUUbOZYnGhiumQqSEY6BjTkOm/ERPQK83IjnCus9D9LgB
	fZWsFsd37ohpSAOy8wSxvI/+i0TPybbRl9s/7QDEhjz2zuvLgSoRQtv28GaYX8EFsjF4ShS2Rc7
	iiiJr0Wa4OYKLNko4VnenfpqtbAinWxc=
X-Gm-Gg: AY/fxX4TooiDFECLu4oJqRYYu8FoIw40ndWqvBaVvSpqUn50CTpOuYAt+bgB3sN35iY
	yrDK7/LN2q6Jm32QzXYoiRWh2yLkex3TSmUYmaCBZpK5s5QPxGkbVqTzWXEDfHQywVv6vYCqHyi
	3UVOUSDUzlvjenW3XLgNxq2GR9h9OYwsUCfF35OGCjiw5JeQKPkOR1B9X8G5Vdwp8SRwzppPE/e
	FVnlqJ0vMfAaUK08/1cifs0e2BnDDEQCRYweT8oE+E5fXEvyG3uoQsgn98YiZ8/3uykC7kSs65T
	+qkavgporRIEIwOFFOdjSXJ8CcBUtNOB6X/aLGRs
X-Google-Smtp-Source: AGHT+IGZuGyGAxx3SKkd4x6JWgt9zJmw9k4Ch6jw0XyDS4VjF2EvPwfilN5NNiHA0S8IgQUyM4KM+WmZfWV+AvpOLvg=
X-Received: by 2002:a05:6820:6e81:b0:659:9a49:8ece with SMTP id
 006d021491bc7-65f550a6b58mr6011451eaf.82.1768232228432; Mon, 12 Jan 2026
 07:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-11-ameryhung@gmail.com>
In-Reply-To: <20251218175628.1460321-11-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Jan 2026 16:36:31 +0100
X-Gm-Features: AZwV_Qg00i6ACjDBHBWS2sXfaStb9fk-05zKWzt7S_Um5wqMWl8WR2Ow8L2ZsgU
Message-ID: <CAP01T77R+inOoL-f7RMovqE1rwG5YTBysEXg2Sez60LiWZu2eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Dec 2025 at 18:56, Amery Hung <ameryhung@gmail.com> wrote:
>
> Introduce bpf_selem_unlink_lockless() to properly handle errors returned
> from rqspinlock in bpf_local_storage_map_free() and
> bpf_local_storage_destroy() where the operation must succeeds.
>
> The idea of bpf_selem_unlink_lockless() is to allow an selem to be
> partially linked and use refcount to determine when and who can free the
> selem. An selem initially is fully linked to a map and a local storage
> and therefore selem->link_cnt is set to 2. Under normal circumstances,
> bpf_selem_unlink_lockless() will be able to grab locks and unlink
> an selem from map and local storage in sequeunce, just like
> bpf_selem_unlink(), and then add it to a local tofree list provide by
> the caller. However, if any of the lock attempts fails, it will
> only clear SDATA(selem)->smap or selem->local_storage depending on the
> caller and decrement link_cnt to signal that the corresponding data
> structure holding a reference to the selem is gone. Then, only when both
> map and local storage are gone, an selem can be free by the last caller
> that turns link_cnt to 0.
>
> To make sure bpf_obj_free_fields() is done only once and when map is
> still present, it is called when unlinking an selem from b->list under
> b->lock.
>
> To make sure uncharging memory is only done once and when owner is still
> present, only unlink selem from local_storage->list in
> bpf_local_storage_destroy() and return the amount of memory to uncharge
> to the caller (i.e., owner) since the map associated with an selem may
> already be gone and map->ops->map_local_storage_uncharge can no longer
> be referenced.
>
> Finally, access of selem, SDATA(selem)->smap and selem->local_storage
> are racy. Callers will protect these fields with RCU.
>
> Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf_local_storage.h |  2 +-
>  kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++++++++++--
>  2 files changed, 74 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 20918c31b7e5..1fd908c44fb6 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -80,9 +80,9 @@ struct bpf_local_storage_elem {
>                                                  * after raw_spin_unlock
>                                                  */
>         };
> +       atomic_t link_cnt;
>         u16 size;
>         bool use_kmalloc_nolock;
> -       /* 4 bytes hole */
>         /* The data is stored in another cacheline to minimize
>          * the number of cachelines access during a cache hit.
>          */
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 62201552dca6..4c682d5aef7f 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -97,6 +97,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>                         if (swap_uptrs)
>                                 bpf_obj_swap_uptrs(smap->map.record, SDATA(selem)->data, value);
>                 }
> +               atomic_set(&selem->link_cnt, 2);
>                 selem->size = smap->elem_size;
>                 selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
>                 return selem;
> @@ -200,9 +201,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
>         /* The bpf_local_storage_map_free will wait for rcu_barrier */
>         smap = rcu_dereference_check(SDATA(selem)->smap, 1);
>
> -       migrate_disable();
> -       bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> -       migrate_enable();
> +       if (smap) {
> +               migrate_disable();
> +               bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> +               migrate_enable();
> +       }
>         kfree_nolock(selem);
>  }
>
> @@ -227,7 +230,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
>                  * is only supported in task local storage, where
>                  * smap->use_kmalloc_nolock == true.
>                  */
> -               bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> +               if (smap)
> +                       bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
>                 __bpf_selem_free(selem, reuse_now);
>                 return;
>         }
> @@ -419,6 +423,71 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>         return err;
>  }
>
> +/* Callers of bpf_selem_unlink_lockless() */
> +#define BPF_LOCAL_STORAGE_MAP_FREE     0
> +#define BPF_LOCAL_STORAGE_DESTROY      1
> +
> +/*
> + * Unlink an selem from map and local storage with lockless fallback if callers
> + * are racing or rqspinlock returns error. It should only be called by
> + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> + */
> +static void bpf_selem_unlink_lockless(struct bpf_local_storage_elem *selem,
> +                                     struct hlist_head *to_free, int caller)
> +{
> +       struct bpf_local_storage *local_storage;
> +       struct bpf_local_storage_map_bucket *b;
> +       struct bpf_local_storage_map *smap;
> +       unsigned long flags;
> +       int err, unlink = 0;
> +
> +       local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
> +       smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
> +
> +       /*
> +        * Free special fields immediately as SDATA(selem)->smap will be cleared.
> +        * No BPF program should be reading the selem.
> +        */
> +       if (smap) {
> +               b = select_bucket(smap, selem);
> +               err = raw_res_spin_lock_irqsave(&b->lock, flags);

Please correct me if I'm wrong with any of this here. I think this is
the only potential problem I see, i.e. if we assume that this call can
fail for map_free.
map_free fails here, goes to the bottom with unlink == 0, and moves
refcnt from 2 to 1.
Before it restarts its loop, destroy() which was going in parallel and
caused the failure already succeeded in smap removal and local storage
removal, has unlink == 2, so proceeds with bpf_selem_free_list.
It frees the selem with RCU gp.
Meanwhile our loop races around cond_resched_rcu(), which restarts the
read section so the element is freed before we restart the while loop.
Would we do UAF?

  1. map_free() fails b->lock, link_cnt 2->1, map_node still linked
  2. destroy() succeeds (unlink == 2), calls bpf_selem_free_list(),
does RCU free
  3. map_free()'s cond_resched_rcu() releases rcu_read_lock()
  4. RCU grace period completes, selem is freed
  5. map_free() re-acquires rcu_read_lock(), hlist_first_rcu() returns
freed memory

I think the fix is that we might want to unlink from map_node in
bpf_selem_free_list and do dec_not_zero instead, and avoid the
cond_resched_rcu().
If we race with destroy(), and end up doing another iteration on the
same element, we will keep our RCU gp so not access freed memory, and
avoid moving refcount < 0 due to dec_not_zero. By the time we restart
third time we will no longer see the element.

But removing cond_resched_rcu() doesn't seem attractive (I don't think
there's a variant that does cond_resched() while holding the RCU read
lock).

Things become much simpler if we assume map_free() cannot fail when
acquiring the bucket lock. It seems to me that we should make that
assumption, since destroy() in task context is the only racing
invocation.
If we are getting timeouts something is seriously wrong.
WARN_ON_ONCE(err && caller == BPF_LOCAL_STORAGE_MAP_FREE).
Then remove else if branch.
The converse (assuming it will always succeed for destroy()) is not
true, since BPF programs can cause deadlocks. But the problem is only
around map_node unlinking.


> +               if (!err) {
> +                       if (likely(selem_linked_to_map(selem))) {
> +                               hlist_del_init_rcu(&selem->map_node);
> +                               bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> +                               RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
> +                               unlink++;
> +                       }
> +                       raw_res_spin_unlock_irqrestore(&b->lock, flags);
> +               } else if (caller == BPF_LOCAL_STORAGE_MAP_FREE) {
> +                       RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
> +               }
> +       }
> +
> +       /*
> +        * Only let destroy() unlink from local_storage->list and do mem_uncharge
> +        * as owner is guaranteed to be valid in destroy().
> +        */
> +       if (local_storage && caller == BPF_LOCAL_STORAGE_DESTROY) {
> +               err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> +               if (!err) {
> +                       hlist_del_init_rcu(&selem->snode);
> +                       unlink++;
> +                       raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
> +               }
> +               RCU_INIT_POINTER(selem->local_storage, NULL);
> +       }
> +
> +       /*
> +        * Normally, an selem can be unlink under local_storage->lock and b->lock, and
> +        * then added to a local to_free list. However, if destroy() and map_free() are
> +        * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
> +        * the selem only after both map_free() and destroy() drop the refcnt.
> +        */
> +       if (unlink == 2 || atomic_dec_and_test(&selem->link_cnt))
> +               hlist_add_head(&selem->free_node, to_free);
> +}
> +
>  void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
>                                       struct bpf_local_storage_map *smap,
>                                       struct bpf_local_storage_elem *selem)
> --
> 2.47.3
>

