Return-Path: <bpf+bounces-65073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB4B1B86C
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1837F18A0FC9
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6D291C39;
	Tue,  5 Aug 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FczdpzMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAC72630;
	Tue,  5 Aug 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411122; cv=none; b=VnuoZS2SyP+7AaM7aLMwsgJfE9vxvV2WEZ1CS+Vyad0GHmCUw7qtCb1F6TJRLJOQ2SznrPassfNUZ2YvbLy+7mVh/dr67S7CAs2K321mK1g/3BqQmr/u3KXYJYuFwbWaT8alSauJp3gecl/TeTkNdpl/Wt0YjtxJy1NRKDuZ/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411122; c=relaxed/simple;
	bh=9hrpuYEUBnOYCWg4yf6BWb1szk1cTso0DQLX/Wm3qnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LE+8IegtcJlC6dsIj3p7kfpHYiCNdbb0XVWq0qoC49m60TuQDGfESWtp18nUQUZZUNieGxjtvxi5teXFcdQlo9fEDxMSRw4oeRsDjE59mp4gBMC3C/bmdmge9S6bzlzzhREBbkZkgfeWxuBD/8qzi6XO41yj6UhiciPE3xSDYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FczdpzMH; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71a4742d81aso42817447b3.2;
        Tue, 05 Aug 2025 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754411120; x=1755015920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D236wdOqTlqVNzbn3FgDduS8gC99cQZrkCBqlYfp7bU=;
        b=FczdpzMHJ7hu9+jkIhhpOd2Sp/PuC/cuXk6FxtHsD1XZY8MDQXufJLT3PandRNYNOs
         aTBawm6mgbxFMoFueb/BsrXK40u5SZeCGaFxDmGdu1XOD0BhfH3hYnJSAkxKoUGKnBKL
         /8zOM7JU2hxxQLE9KVVR1coLzgVIsO+oXms8b4EJZqZDzpXFzakzhEAhfoUnr5CQSLj0
         nPXTld9YepjY0Oye2eg3GHPywSpXz/F1aRF7ibiIkAhwhhJKCLvoTGEw/I4av4PxAMIs
         569QvgyJRAX4Zmf/uJFypo8VwAaXarSimY7wBTIz8ZBgQx0XwiDYlbHDotETiueV4Zr2
         NdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754411120; x=1755015920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D236wdOqTlqVNzbn3FgDduS8gC99cQZrkCBqlYfp7bU=;
        b=TR8K8XtQrWGFROOcDOeiCyt9bdKEF5U4Y0CQdEBZO0L8u/lgdprDizo/RVXsZ0B3kG
         8e45NMzJwgYT7H/UILDHAtp1KWcNq7B2IqskVC17ah9fwdJSs9hszFeu2o61solX7l9z
         rploEVat1Myp+dzqxhijjGjOByV1uyjOQGfZCuEWc7MJLlswGMdUFh4+AtJMyKowa5RJ
         SyTEZQJ8D1rNuHck2vYnACA2CtPf/dBoaxz86oTd72dILnJoZNM8oLKCoO45rVOancr2
         4pMoVDXOC1nyDHc9eQl75gv3P9VIkDojqTXv+qCAGR3YRbwXzz0B9AIfx1jKfNa3a4Qd
         MSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiQ2AvwEM91SoOv6tJfm6VsU84L2CVAO+rLp/K12jWhryE8U67as7XP7KRW5fEqpqvqpusZ9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WIintZ/pjubQD8vbC+kM46csE8+V0uOL/1q915/BYpSaYFFN
	dCQTUSC7ZDgasaq48O4CbDnM5L088tamnCYcw3AO90NcIZN5+ST2KrdTZqlgOvpDsh5NSqygjl5
	nZGfMHLiWMoHI0t2d66++vvHm5j1t8ZE=
X-Gm-Gg: ASbGncs84TMj/4oxY1dxcpd8zhY/kkAhTAhax0iShtk2CsdOHvETB8PjBBznEmCo0lK
	k9l/52c9oiv8c6N8oAZOVgKXE2DZRSTzkbQSHRAzWmEwz0v92E5JPPWPA/n30MlH/A+IVLc5Plq
	VwMCXDDvzKA2nPvbUQxyp/a8HPDIyavAi3Xl65Dv3fw8t8MJlPc8fMDq0FABK6AqkE+V4KyqLJB
	St0d2/pyw==
X-Google-Smtp-Source: AGHT+IHZLec7575PSZOET/bFzyVAENXmdNoNPjRRVM4DSb4SxqyeX++NiOB/fqSaozyGdtxcjaotFh2Xvvp7S8H9xUE=
X-Received: by 2002:a05:690c:6707:b0:71a:51f:81a7 with SMTP id
 00721157ae682-71b7f3f89cdmr174526917b3.26.1754411120093; Tue, 05 Aug 2025
 09:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729182550.185356-1-ameryhung@gmail.com> <20250729182550.185356-4-ameryhung@gmail.com>
 <8e21c788-5187-4fee-baec-22b8e80be383@linux.dev>
In-Reply-To: <8e21c788-5187-4fee-baec-22b8e80be383@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 5 Aug 2025 09:25:09 -0700
X-Gm-Features: Ac12FXx0AjfTAeStFJ9HBFme514ZV9-KAgVvbtXCfKCXHzjw_2BQukgiGgjsIOc
Message-ID: <CAMB2axPTU+HsJ_6nKDaq8xnGhcoXZCgy=X2wiODYNbZMdRkSHg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 03/11] bpf: Open code bpf_selem_unlink_storage
 in bpf_selem_unlink
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, kpsingh@kernel.org, 
	martin.lau@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 5:58=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 7/29/25 11:25 AM, Amery Hung wrote:
> >   void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reus=
e_now)
> >   {
> > +     struct bpf_local_storage_map *storage_smap;
> > +     struct bpf_local_storage *local_storage =3D NULL;
> > +     bool bpf_ma, free_local_storage =3D false;
> > +     HLIST_HEAD(selem_free_list);
> >       struct bpf_local_storage_map_bucket *b;
> > -     struct bpf_local_storage_map *smap;
> > -     unsigned long flags;
> > +     struct bpf_local_storage_map *smap =3D NULL;
> > +     unsigned long flags, b_flags;
> >
> >       if (likely(selem_linked_to_map_lockless(selem))) {
>
> Can we simplify the bpf_selem_unlink() function by skipping this map_lock=
less
> check,
>
> >               smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rc=
u_lock_held());
> >               b =3D select_bucket(smap, selem);
> > -             raw_spin_lock_irqsave(&b->lock, flags);
> > +     }
> >
> > -             /* Always unlink from map before unlinking from local_sto=
rage
> > -              * because selem will be freed after successfully unlinke=
d from
> > -              * the local_storage.
> > -              */
> > -             bpf_selem_unlink_map_nolock(selem);
> > -             raw_spin_unlock_irqrestore(&b->lock, flags);
> > +     if (likely(selem_linked_to_storage_lockless(selem))) {
>
> only depends on this and then proceed to take the lock_storage->lock. The=
n
> recheck selem_linked_to_storage(selem), bpf_selem_unlink_map(selem) first=
, and
> then bpf_selem_unlink_storage_nolock(selem) last.

Thanks for the suggestion. I think it will simplify the function. Just
making sure I am getting you right, you mean instead of open code both
unlink_map and unlink_storage, only open code unlink_storage. First,
grab local_storage->lock and call bpf_selem_unlink_map(). Then, only
proceed to unlink_storage only If bpf_selem_unlink_map() succeeds.

>
> Then bpf_selem_unlink_map can use selem->local_storage->owner to select_b=
ucket().

Not sure what this part mean. Could you elaborate?

>
> > +             local_storage =3D rcu_dereference_check(selem->local_stor=
age,
> > +                                                   bpf_rcu_lock_held()=
);
> > +             storage_smap =3D rcu_dereference_check(local_storage->sma=
p,
> > +                                                  bpf_rcu_lock_held())=
;
> > +             bpf_ma =3D check_storage_bpf_ma(local_storage, storage_sm=
ap, selem);
> >       }
> >
> > -     bpf_selem_unlink_storage(selem, reuse_now);
> > +     if (local_storage)
> > +             raw_spin_lock_irqsave(&local_storage->lock, flags);
> > +     if (smap)
> > +             raw_spin_lock_irqsave(&b->lock, b_flags);
> > +
> > +     /* Always unlink from map before unlinking from local_storage
> > +      * because selem will be freed after successfully unlinked from
> > +      * the local_storage.
> > +      */
> > +     if (smap)
> > +             bpf_selem_unlink_map_nolock(selem);
> > +     if (local_storage && likely(selem_linked_to_storage(selem)))
> > +             free_local_storage =3D bpf_selem_unlink_storage_nolock(
> > +                     local_storage, selem, true, &selem_free_list);
> > +
> > +     if (smap)
> > +             raw_spin_unlock_irqrestore(&b->lock, b_flags);
> > +     if (local_storage)
> > +             raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > +
> > +     bpf_selem_free_list(&selem_free_list, reuse_now);
> > +
> > +     if (free_local_storage)
> > +             bpf_local_storage_free(local_storage, storage_smap, bpf_m=
a, reuse_now);
> >   }
> >
> >   void __bpf_local_storage_insert_cache(struct bpf_local_storage *local=
_storage,
>

