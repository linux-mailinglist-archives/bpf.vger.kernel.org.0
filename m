Return-Path: <bpf+bounces-78351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD3D0BF10
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A271D3028D8F
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E42DC770;
	Fri,  9 Jan 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZAN2mYY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79964287517
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984562; cv=none; b=nuCgZCv7a5Ejr3jNRPUp53XxDbQwbCYXat25neqFmtv0u9vjt7qjgpHjPo3ugX59devmQ9QPNBPF1HY1bpY4i+5Mci7lP3aU7pm4kml5CsuV6wkNULV8C9f9kMRHjCX9hcwfdusYvCFkKt7vofVJsjX7wZUXp5avCo+2ooHjxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984562; c=relaxed/simple;
	bh=cea/jBoz183HEWKevZXAVeN2tukuCTeVkchAgeDk1p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmW+BXIGj/HnUx+e/axXRBgDVzQkZYZF7EMWEp+CAHDu7Hq4aVWSImVm225pRDMgTTrDdgzf1XERp+5CyLr7X7ZYOYKuD8XNt9DpGeNpq3Gpf7TL9Ws6FghZqzBu90gmuU4/kV/dzMGgkCG5so324xnp7oAO1cI26TMm1yMIkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZAN2mYY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78fc4425b6bso47435787b3.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767984558; x=1768589358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqDx/WwbS7s7bCB9aUzXGkDKoCWy97MxMS16p2/TFpk=;
        b=dZAN2mYY+pyXEC7WGmzUqEnU3ZXY/B7Bhn1lm+CPmKhDzNpU65aGr3XQQk3GfrKlTW
         3NT3DO1HtnYHoTALrFe1Neew4ib+ltu1lWbaO4Ls9wLJKOnxEGbFdua9sGltSTna2M1e
         CMDNRI3lGKVILcgfB6o5UqjoDxS09DM/Mye9gnwOlqXRGqc2IWmgEL08tdf7tJzJm3fd
         8OqI3zDUPzW7rA96n66RHijPCOA+UoOo7K1ZD8+2iS2VazOCv+sRjZUBoFNUyBHKKBjB
         /R/LU9XyQ+L7gcXsJu5jLxbgNWnqf7H8TxTCoWJFSeUzNEdNKaemOFNzw1LwGmixTVxM
         B8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984558; x=1768589358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TqDx/WwbS7s7bCB9aUzXGkDKoCWy97MxMS16p2/TFpk=;
        b=NNIu7r45ruAGmd8ZakKUKmnLz5YldJm1Uo28+rXk8XbNeiGSghP6CVrOxd0tElHgyK
         jb2MDBfuhodSk0MiOVbJ4JjeSk9ipWiIqSWHCiaJaeOuCxYnLbMv7HQVEp2Kj+7h5uxY
         5IIN0Hs+INnGCCOgGBfXfMKAWle2KIhwc5GBvSfpsCpuXkcF/fkoBVSG8GXy3dk0zStt
         P0nOn1ApgwFam/+ByG0uDrjOm6ZIMWy0Qdb5X/38hqDpSMROrU5oSFQbjIDwwVTJaS7c
         U1osg4xd9OM0SBGmGTOH7oYNAYsux7R3IaTv3wKIvbWhvqXji+wZ8Pt8DzxgNxoNufz7
         HdUA==
X-Forwarded-Encrypted: i=1; AJvYcCVle4SwfuXvq+dERb72OvoBsxpA9xq3wJ/BK5l0MIRJ/RqlUtka9DbpJAiRlmx/Pfe0G08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fRzgcUjuEVrUvCcyP9piKzC1EYZgBjr49a3VawbEE9EE66aw
	BaLWN0awzPbf9Y5kTvjZD7IUVrhkIfWDg0CoSOWX49wYT6/ydLhdTqLwj05kMUPvnpj5776Hf7L
	DLWOwAjFK0BHeIxLsR5qxqcb1DyhLTVc=
X-Gm-Gg: AY/fxX7JD+wJT+vUNr6kAeDmOVNDOtO/aeuf/2etJlTC+bEX4HCoMEpk899ohzahGne
	XnjA9I+gtc4IAv1U05Zu4/OaPM9DPZKVM+KpVgRx6c87U06UT0B0As1f34ZWfCw3SXnqF75lWzI
	8NueX6cYihaKJMXD/+mAGbF6T0dH+ZQlM0GRGMiz7kXvskfWkFztbjzu/Qyb+JhNoJx+sDVAUOa
	//bi7eCQ5INre5AtSm7+jf0hx/8drT/L6RzhRMoATv/rXThqE/Om2UG1L9W1kBstP03LwlGuyWW
	UXvk6o9zP969419p3gAG1Q==
X-Google-Smtp-Source: AGHT+IH+K7zjhzTzVA3xQIjj81j3Q+c/ug3Q9xivvzDNTWxXBZJlY/HcFS0iyTl2KaikeAe2XGoJVUS1zcAOBt0tYZQ=
X-Received: by 2002:a05:690e:4195:b0:640:e5e1:190e with SMTP id
 956f58d0204a3-64716c6818emr8753397d50.57.1767984558537; Fri, 09 Jan 2026
 10:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-5-ameryhung@gmail.com>
 <71c80294-9602-4302-a823-00a0fe7ed7c7@linux.dev>
In-Reply-To: <71c80294-9602-4302-a823-00a0fe7ed7c7@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 9 Jan 2026 10:49:06 -0800
X-Gm-Features: AQt7F2p32oMerr8tt8taAxJiJZvS-7P28fIC3L5YGub9BeP5iU4grQgiubx90HM
Message-ID: <CAMB2axOFqAUZooWNe2euQ-N3A0P83=PGj1p6_LtngN6PW9uQcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/16] bpf: Convert bpf_selem_unlink to failable
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:16=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
>
>
> On 12/18/25 9:56 AM, Amery Hung wrote:
> > To prepare changing both bpf_local_storage_map_bucket::lock and
> > bpf_local_storage::lock to rqspinlock, convert bpf_selem_unlink() to
> > failable. It still always succeeds and returns 0 until the change
> > happens. No functional change.
> >
> > For bpf_local_storage_map_free(), WARN_ON() for now as no real error
> > will happen until we switch to rqspinlock.
> >
> > __must_check is added to the function declaration locally to make sure
> > all callers are accounted for during the conversion.
>
> I don't see __must_check. The same for patch 2.

I only added it locally. I will follow your suggestion to include it
in the patchset.

Per your suggestion:
Ignore the warning instead of WARN_ON for now. Add __must_check to
functions when everything is ready.

>
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   include/linux/bpf_local_storage.h | 2 +-
> >   kernel/bpf/bpf_cgrp_storage.c     | 3 +--
> >   kernel/bpf/bpf_inode_storage.c    | 4 +---
> >   kernel/bpf/bpf_local_storage.c    | 8 +++++---
> >   kernel/bpf/bpf_task_storage.c     | 4 +---
> >   net/core/bpf_sk_storage.c         | 4 +---
> >   6 files changed, 10 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loca=
l_storage.h
> > index 6cabf5154cf6..a94e12ddd83d 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -176,7 +176,7 @@ int bpf_local_storage_map_check_btf(const struct bp=
f_map *map,
> >   void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_st=
orage,
> >                                  struct bpf_local_storage_elem *selem);
> >
> > -void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse=
_now);
> > +int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_=
now);
> >
> >   int bpf_selem_link_map(struct bpf_local_storage_map *smap,
> >                      struct bpf_local_storage_elem *selem);
> > diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storag=
e.c
> > index 0687a760974a..8fef24fcac68 100644
> > --- a/kernel/bpf/bpf_cgrp_storage.c
> > +++ b/kernel/bpf/bpf_cgrp_storage.c
> > @@ -118,8 +118,7 @@ static int cgroup_storage_delete(struct cgroup *cgr=
oup, struct bpf_map *map)
> >       if (!sdata)
> >               return -ENOENT;
> >
> > -     bpf_selem_unlink(SELEM(sdata), false);
> > -     return 0;
> > +     return bpf_selem_unlink(SELEM(sdata), false);
> >   }
> >
> >   static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *k=
ey)
> > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_stor=
age.c
> > index e54cce2b9175..cedc99184dad 100644
> > --- a/kernel/bpf/bpf_inode_storage.c
> > +++ b/kernel/bpf/bpf_inode_storage.c
> > @@ -110,9 +110,7 @@ static int inode_storage_delete(struct inode *inode=
, struct bpf_map *map)
> >       if (!sdata)
> >               return -ENOENT;
> >
> > -     bpf_selem_unlink(SELEM(sdata), false);
> > -
> > -     return 0;
> > +     return bpf_selem_unlink(SELEM(sdata), false);
> >   }
> >
> >   static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, voi=
d *key)
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index 0e3fa5fbaaf3..fa629a180e9e 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -367,7 +367,7 @@ static void bpf_selem_link_map_nolock(struct bpf_lo=
cal_storage_map *smap,
> >       hlist_add_head_rcu(&selem->map_node, &b->list);
> >   }
> >
> > -void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse=
_now)
> > +int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_=
now)
> >   {
> >       struct bpf_local_storage *local_storage;
> >       bool free_local_storage =3D false;
> > @@ -377,7 +377,7 @@ void bpf_selem_unlink(struct bpf_local_storage_elem=
 *selem, bool reuse_now)
> >
> >       if (unlikely(!selem_linked_to_storage_lockless(selem)))
> >               /* selem has already been unlinked from sk */
> > -             return;
> > +             return 0;
> >
> >       local_storage =3D rcu_dereference_check(selem->local_storage,
> >                                             bpf_rcu_lock_held());
> > @@ -402,6 +402,8 @@ void bpf_selem_unlink(struct bpf_local_storage_elem=
 *selem, bool reuse_now)
> >
> >       if (free_local_storage)
> >               bpf_local_storage_free(local_storage, reuse_now);
> > +
> > +     return err;
>
> err is not used in patch 3 and then becomes useful in patch 4. The
> ai-review discovered issue on err also. Squash patch 4 into patch 3. It
> will be easier to read.

Got it. Will squash patch 3 and 4.

>
> >   }
> >
> >   void __bpf_local_storage_insert_cache(struct bpf_local_storage *local=
_storage,
> > @@ -837,7 +839,7 @@ void bpf_local_storage_map_free(struct bpf_map *map=
,
> >                               struct bpf_local_storage_elem, map_node))=
) {
> >                       if (busy_counter)
> >                               this_cpu_inc(*busy_counter);
> > -                     bpf_selem_unlink(selem, true);
> > +                     WARN_ON(bpf_selem_unlink(selem, true));
>
> nit. I would add __must_check to the needed functions in a single patch
> when everything is ready instead of having an intermediate WARN_ON here
> and then removed it later.
>

