Return-Path: <bpf+bounces-78349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D5D0BE2F
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64188305A206
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3529C1FBEB0;
	Fri,  9 Jan 2026 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmBzmseP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3DA500960
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983988; cv=none; b=eTBjiiZx6A2W/gGew+dVGnMVJMDHV5OLcHpZ4aKmrbPtLFhApgqKuvw8JLwBaU+VzRoSVjgcUTIRQI3Q9ZNu2F9uE0UJaIE+QSRTrwdsCoTtTqSWq0RUn6pjkxN1BKDq4amN8I0ZxE1r7GCYcJqqe6xao87bPiicjFui3OBBNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983988; c=relaxed/simple;
	bh=0thPSSAt6iGN6qIIoVDgFEDM1RmwR2vjdkx/LsGdBzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyaaubARawlAYVunjWPqJa8w572i/tml5nRkz6Itb4R8+/SwsgwIPUCl9QgyHVVaoU8DPTjTTUHwdbBngCmoLxFmTnkG8ibx3moVDQN1jZpwUIsg/wyqUMpjpdu4TVlkPZbVXTzln0WcU86oIn+8DDuCqZ7WQ4SgeWh2lqQz9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmBzmseP; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6446d7a8eadso4077974d50.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 10:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767983984; x=1768588784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0MzdrVzYLJ6Sbyf1X9bAK4sVlGZYheMiqhPnsL5Nag=;
        b=RmBzmsePL7Yz9zbioKWsQMHUvZkdUtAdC+cJrAf0q4Tj11MvCRrGABknNkGrZGNybC
         LpcCKTCzD0CEbW0I45ob45vnx6aKCL84bd16SmUIvWY52Q6N7n0t8t4G/KBS0q3TYPqa
         nvN5ajhmSMJRyqoE5sdtU5MFMF4d/CYmkSp6O36hEaYhREtFGId02OTktZJy3Eiqlr46
         H2uZEHEeukuMwdjoqqLfvPSwZ3O6liI1QLPFCh50CiKC+qGR2WMqtrCzcBTn2F2RS/FY
         0GuqR2R+t/7i1mjs1rpzuUhponu3L2aQyawUicl9LyxcDThcPy1XFMfWa+IgymRIYas9
         cVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767983984; x=1768588784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0MzdrVzYLJ6Sbyf1X9bAK4sVlGZYheMiqhPnsL5Nag=;
        b=dfDNgz4VJQ6erxIe71Gk1u/HupYh00YQCEW4RLXrNaif/ZQH2lwLV/25wU/GYTJpmH
         2feXVxEN6WwidFyN5YJnWcLr1ykNinUNp63jSRYmSFoKU69C3FpesbCSunoLcru25TIb
         yTuvPTbm+8lfRHVyDHYq9vusfdHbETT5oeXFjQEjB+WQm50ozofN0un3S2NEyggaiqqW
         YqNrVrReYD5Pxh54TPLyEOVSzoj9Y3/YABLpxx/y7NpSGyAkP7fZSD4pxTfTYH85UpC4
         XOuPUZWCxvF8Wu2zEWjnU1ixniwX3gzIQzf+gjYmy1f4JHHvdAyHDfRaLWmZhh+YxduW
         zGnQ==
X-Gm-Message-State: AOJu0Yzp5LXpfTWxcs2yPk+jp8JgfJubtYDmCBzslXRNLrVkOdOv1MyT
	31OpGJWH5ledzgS1hYSBm4h3PCTxgcrufKG2YfTqLD0axnTiSrF0Et+/CGt9m3Pm087E54RwDd6
	k41YHAlzKboOpCzbUfp23qacwfUzzVT4=
X-Gm-Gg: AY/fxX5esQAI1FZm/ntqBCR68vq9Dpwcn2oI0QEoanKExw8/xnRXEBVuPVQZ3uG4O92
	VX0XXfp6u/LEQ6lVQFi+5rGqecF9q36Se2c7++nElpFqHbR5pS2Tv25EpddYeAjLhzn9HknyiAR
	CVovh0mC6s1lH93y4NumtWuikfX0rCi9o8kzi3MFS6pnYLMrSiJiIaD3Wc+4uGiszAg/2yIGO/r
	GLUSYPWr0wwR9BES8Ir9aS+LWlUbSq47aoRnNTunRBn7sCYGSKcmxKvONrg1kO5x/0l1Z3NNAYn
	j+Wt7dfb0tY=
X-Google-Smtp-Source: AGHT+IFz8uJOxgMQYoQ9UkpvXTtzp7NP0Ci6dhYvdN7HuiLsejwnnQCvITbOBe66Z6eXMJX5KzhBjyLE3xpgCXkzro0=
X-Received: by 2002:a05:690e:c49:b0:640:e352:4e37 with SMTP id
 956f58d0204a3-64716b37ff1mr9005521d50.20.1767983984036; Fri, 09 Jan 2026
 10:39:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-2-ameryhung@gmail.com>
 <74fa8337-b0cb-42fb-af8a-fdf6877e558d@linux.dev>
In-Reply-To: <74fa8337-b0cb-42fb-af8a-fdf6877e558d@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 9 Jan 2026 10:39:32 -0800
X-Gm-Features: AQt7F2qDYhRm4xZwC_DghkoWKzs0ibEMqCGzRAN17csiANoJZt0OPhbISE9qYxU
Message-ID: <CAMB2axP5OvZKhHDnW9UD95S+2nTYaR4xLRHdg+oeXtpRJOfKrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to failable
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:29=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/18/25 9:56 AM, Amery Hung wrote:
> > To prepare for changing bpf_local_storage_map_bucket::lock to rqspinloc=
k,
> > convert bpf_selem_unlink_map() to failable. It still always succeeds an=
d
> > returns 0 for now.
> >
> > Since some operations updating local storage cannot fail in the middle,
> > open-code bpf_selem_unlink_map() to take the b->lock before the
> > operation. There are two such locations:
> >
> > - bpf_local_storage_alloc()
> >
> >    The first selem will be unlinked from smap if cmpxchg owner_storage_=
ptr
> >    fails, which should not fail. Therefore, hold b->lock when linking
> >    until allocation complete. Helpers that assume b->lock is held by
> >    callers are introduced: bpf_selem_link_map_nolock() and
> >    bpf_selem_unlink_map_nolock().
> >
> > - bpf_local_storage_update()
> >
> >    The three step update process: link_map(new_selem),
> >    link_storage(new_selem), and unlink_map(old_selem) should not fail i=
n
> >    the middle.
> >
> > In bpf_selem_unlink(), bpf_selem_unlink_map() and
> > bpf_selem_unlink_storage() should either all succeed or fail as a whole
> > instead of failing in the middle. So, return if unlink_map() failed.
> >
> > In bpf_local_storage_destroy(), since it cannot deadlock with itself or
> > bpf_local_storage_map_free() who the function might be racing with,
> > retry if bpf_selem_unlink_map() fails due to rqspinlock returning
> > errors.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   kernel/bpf/bpf_local_storage.c | 64 +++++++++++++++++++++++++++++----=
-
> >   1 file changed, 55 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index e2fe6c32822b..4e3f227fd634 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -347,7 +347,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local=
_storage *local_storage,
> >       hlist_add_head_rcu(&selem->snode, &local_storage->list);
> >   }
> >
> > -static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
> > +static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
>
> This will end up only be used by bpf_selem_unlink(). It may as well
> remove this function and open code in the bpf_selem_unlink(). I think it
> may depend on how patch 10 goes and also if it makes sense to remove
> bpf_selem_"link"_map and bpf_selem_unlink_map_nolock also, so treat it
> as a nit note for now.

Noted

>
> >   {
> >       struct bpf_local_storage_map *smap;
> >       struct bpf_local_storage_map_bucket *b;
> > @@ -355,7 +355,7 @@ static void bpf_selem_unlink_map(struct bpf_local_s=
torage_elem *selem)
> >
> >       if (unlikely(!selem_linked_to_map_lockless(selem)))
>
> In the later patch where both local_storage's and map-bucket's locks
> must be acquired, will this check still be needed if there is an earlier
> check that ensures the selem is still linked to the local_storage? It
> does not matter in terms of perf, but I think it will help code reading
> in the future for the common code path (i.e. the code paths other than
> bpf_local_storage_destroy and bpf_local_storage_map_free).

Makes sense to remove it. Common code path still follow the unlink
order and do not partial unlink.

>
> >               /* selem has already be unlinked from smap */
> > -             return;
> > +             return 0;
> >
> >       smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_h=
eld());
> >       b =3D select_bucket(smap, selem);
> > @@ -363,6 +363,14 @@ static void bpf_selem_unlink_map(struct bpf_local_=
storage_elem *selem)
> >       if (likely(selem_linked_to_map(selem)))
> >               hlist_del_init_rcu(&selem->map_node);
> >       raw_spin_unlock_irqrestore(&b->lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem =
*selem)
> > +{
> > +     if (likely(selem_linked_to_map(selem)))
>
> Take this chance to remove the selem_linked_to_map() check.
> hlist_del_init_rcu has the same check.

Noted

>
> > +             hlist_del_init_rcu(&selem->map_node);
> >   }
> >
> >   void bpf_selem_link_map(struct bpf_local_storage_map *smap,
> > @@ -376,13 +384,26 @@ void bpf_selem_link_map(struct bpf_local_storage_=
map *smap,
> >       raw_spin_unlock_irqrestore(&b->lock, flags);
> >   }
> >
> > +static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *sm=
ap,
> > +                                   struct bpf_local_storage_elem *sele=
m,
> > +                                   struct bpf_local_storage_map_bucket=
 *b)
> > +{
> > +     RCU_INIT_POINTER(SDATA(selem)->smap, smap);
>
> Is it needed? bpf_selem_alloc should have init the SDATA(selem)->smap.

Good catch. Forgot to remove it when rebasing. This is redundant as we
already do it in bpf_selem_alloc()

>
> > +     hlist_add_head_rcu(&selem->map_node, &b->list);
> > +}
> > +
>
> [ ... ]
>
> > @@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bpf_=
local_storage_map *smap,
> >               goto unlock;
> >       }
> >
> > +     b =3D select_bucket(smap, selem);
> > +
> > +     if (old_sdata) {
> > +             old_b =3D select_bucket(smap, SELEM(old_sdata));
> > +             old_b =3D old_b =3D=3D b ? NULL : old_b;
> > +     }
> > +
> > +     raw_spin_lock_irqsave(&b->lock, b_flags);
> > +
> > +     if (old_b)
> > +             raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
>
> This will deadlock because of the lock ordering of b and old_b.
> Replacing it with res_spin_lock in the later patch can detect it and
> break it more gracefully. imo, we should not introduce a known deadlock
> logic in the kernel code in the syscall code path and ask the current
> user to retry the map_update_elem syscall.
>
> What happened to the patch in the earlier revision that uses the
> local_storage (or owner) for select_bucket?

Thanks for reviewing!

I decided to revert it because this introduces the dependency of selem
to local_storage when unlinking. bpf_selem_unlink_lockless() cannot
assume map or local_storage associated with a selem to be alive. In
the case where local_storage is already destroyed, we won't be able to
figure out the bucket if select_bucket() uses local_storage for
hashing.

A middle ground is to use local_storage for hashing, but save the
bucket index in selem so that local_storage pointer won't be needed
later. WDYT?

>
> [ will continue with the rest of the patches a bit later ]
>
> > +
> >       alloc_selem =3D NULL;
> >       /* First, link the new selem to the map */
> > -     bpf_selem_link_map(smap, selem);
> > +     bpf_selem_link_map_nolock(smap, selem, b);
> >
> >       /* Second, link (and publish) the new selem to local_storage */
> >       bpf_selem_link_storage_nolock(local_storage, selem);
> >
> >       /* Third, remove old selem, SELEM(old_sdata) */
> >       if (old_sdata) {
> > -             bpf_selem_unlink_map(SELEM(old_sdata));
> > +             bpf_selem_unlink_map_nolock(SELEM(old_sdata));
> >               bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_=
sdata),
> >                                               &old_selem_free_list);
> >       }
> >
> > +     if (old_b)
> > +             raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
> > +
> > +     raw_spin_unlock_irqrestore(&b->lock, b_flags);
> > +
> >   unlock:
> >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> >       bpf_selem_free_list(&old_selem_free_list, false);
> > @@ -679,7 +725,7 @@ void bpf_local_storage_destroy(struct bpf_local_sto=
rage *local_storage)
> >               /* Always unlink from map before unlinking from
> >                * local_storage.
> >                */
> > -             bpf_selem_unlink_map(selem);
> > +             WARN_ON(bpf_selem_unlink_map(selem));
> >               /* If local_storage list has only one element, the
> >                * bpf_selem_unlink_storage_nolock() will return true.
> >                * Otherwise, it will return false. The current loop iter=
ation
>

