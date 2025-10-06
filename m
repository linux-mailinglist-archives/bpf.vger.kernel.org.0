Return-Path: <bpf+bounces-70428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0265BBEDE2
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8DE189B1B3
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242D2D5925;
	Mon,  6 Oct 2025 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZpwPKNe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF52C235E
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773507; cv=none; b=KYTY3Dig3NFEvygWhqQVeFZi3KAeCScXBAyoYn9juBsD8mX5tjsMMFTeH+FOvH4cCIBX/IgW0pZZ+s8/XYuZQvqd0DXu9US1qPeZ3vahGirf/mdNn7LD99WcXE2Ey97Yx7v3UL/yaUiV8Bhw6D3ywSSV/9y2xBtth37Wpz/RVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773507; c=relaxed/simple;
	bh=2s6Vu9HptHi8brHsjOwU+GMEtg9JzaHeZrmyolZdHTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rkjj0iqIYkIf/S10rMhGu+AesVtIDP+Y3QIdZGsjjdoLtMlndvqJOe6ElwHu0RddHgGKlrfv7Wh8p9K9IfwMlM3SxYHVA+QSwu/hpkEUHz5rzrnjY22l9k4EycKA/nWI6iepLNaLbzg622t2uRo4h+HeGMqgp7RbyvD14I8rM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZpwPKNe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4257aafab98so1220948f8f.3
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759773504; x=1760378304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKxK+k9ZFezA+8toT2ywb+Xvx0zuZRB0gEIi60pQ7VA=;
        b=iZpwPKNe78itT4K6u4fVSo45Govxcj1vKKc/UZUQ7229KcbuG9SrOvjFn0jQO2/5lc
         jwPgwe6t4hbAOK8xE+gzjdfKKMObKU6O+fuIsmq2+KlzikhfnzSxhAGiefKcYo40h+PB
         xEvZmxbCZlAH1FAxVZwsuLbOn+l3SQZ+4W15wtDTBsHpUSUAaGdVY9Xy1JZSMqr2OVYN
         ekjI+QftQNs+sYnA0Myyi8ju5dnE1B9+MVFVETFAp+zHMFyW8LVBkv5w5SaGiAgFqeVe
         TES8sX0skb73GIBpc6Sj8Cvtnmv8oHTxEVu42fPlYv9Kb7bI/AL8IXjSQnkls6vMmwFd
         uvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773504; x=1760378304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKxK+k9ZFezA+8toT2ywb+Xvx0zuZRB0gEIi60pQ7VA=;
        b=M1vRvicXDrdy5ZYgg5yWC9FrSvUPxU+8qTbOtZ0U04GWgAuXMot5A+O3JBxwZz1nok
         mDJ0d7Sll/Q7mIaq2m+86Mw9EfQlgtW1m+LXtJwgybywUW9p/POhyWJS7oGesD45lqQa
         LtKLB7clSVfxRycXL2W0eJM1k4CaGvC/t16RhSaceiWBNKXk8BYG4IndbRcQDzrEWShv
         MsBv/ZaGIy2XJYrTIr8THlKtfOWe3wzgPr9Hvc02akSZbYlhkHwdSTaTptB9Y1hagn/g
         ogXdDQ1LjFDDGv0FS/NsjrRwxFDj6OG0CXiQf7axOdl+gA1RyMPlYds7WWzjgS61cvMi
         RNbg==
X-Gm-Message-State: AOJu0Yx6nvepcQlRs7/6EihaA3FCC+wKyFqt7lmwLSXEMKaIryuTpYSI
	artBjlGFjJI/VQC21uqu5FJODEt8PbPzx0xxP9w8nCULMrxdixjehdlwNVnTg9F3rO5fmYgWeDj
	IkYRiiquwVyn29rxKRu5sRdxEw1+Qhpk=
X-Gm-Gg: ASbGnctQFcLqy7Vnx2YHl3BSf0qk09ZlJtcWOqErhuOpH00xmhKy6l6vv+RT9bVo9dU
	I7MzVuH7HGpLIllrrId/Ncv66T6t18qV05pWdCeIj78pOlurY/lhSkm+/8F/aAKSvGCahxSUAsV
	RfPhX59Kcrh+22/ACHkrhoEq75iIsamLof86rcx0zaSqtUSRnqcna4J/I0DeaaRrRZmy6IMtUqx
	vG7gNmx/5LgObA8iPT0e/i4HDEuUKd2sn6Z3XFbcYLdA9s=
X-Google-Smtp-Source: AGHT+IGT0dSpLfnfyfjod9omKoyiyTcAY2yOBoOWW+TYGnj4Belx84a3Q71GSObGJ6Adqi3U0Env7kYnPVVnhWkVmsk=
X-Received: by 2002:a05:6000:2210:b0:3ec:98fb:d767 with SMTP id
 ffacd0b85a97d-425671c6c47mr8516177f8f.58.1759773503651; Mon, 06 Oct 2025
 10:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002225356.1505480-1-ameryhung@gmail.com> <20251002225356.1505480-7-ameryhung@gmail.com>
 <CAADnVQ+X1Otu+hrBeCq6Zr9vAaH5vGU42s6jLdBiDiLQcwpj4Q@mail.gmail.com> <CAMB2axOUU5J4Ec=tuBDYePzucw1QQLciFWC01=eVQdPOhT1BGQ@mail.gmail.com>
In-Reply-To: <CAMB2axOUU5J4Ec=tuBDYePzucw1QQLciFWC01=eVQdPOhT1BGQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Oct 2025 10:58:10 -0700
X-Gm-Features: AS18NWCAlGzhw7oHjjmeZwDMW3kKguKo4hJhbaF1CEn3QC9R__3vT8fh7YTG-Uw
Message-ID: <CAADnVQ+=F5SkoRA4LU+JE+u87TLFp-mTS4bv+u9MUST2+CX8AA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/12] bpf: Change local_storage->lock and
 b->lock to rqspinlock
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 3:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Thu, Oct 2, 2025 at 4:37=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Oct 2, 2025 at 3:54=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > >         bpf_selem_free_list(&old_selem_free_list, false);
> > >         if (alloc_selem) {
> > >                 mem_uncharge(smap, owner, smap->elem_size);
> > > @@ -791,7 +812,7 @@ void bpf_local_storage_destroy(struct bpf_local_s=
torage *local_storage)
> > >          * when unlinking elem from the local_storage->list and
> > >          * the map's bucket->list.
> > >          */
> > > -       raw_spin_lock_irqsave(&local_storage->lock, flags);
> > > +       while (raw_res_spin_lock_irqsave(&local_storage->lock, flags)=
);
> >
> > This pattern and other while(foo) doesn't make sense to me.
> > res_spin_lock will fail only on deadlock or timeout.
> > We should not spin, since retry will likely produce the same
> > result. So the above pattern just enters into infinite spin.
>
> I only spin in destroy() and map_free(), which cannot deadlock with
> itself or each other. However, IIUC, a head waiter that detects
> deadlock will cause other queued waiters to also return -DEADLOCK. I
> think they should be able to make progress with a retry.

If it's in map_free() path then why are we taking the lock at all?
There are supposed to be no active users of it.
If there are users and we actually need that lock then the deadlock
is possible and retrying will deadlock the same way.
I feel AI explained it better:
"
raw_res_spin_lock_irqsave() can return -ETIMEDOUT (after 250ms) or
-EDEADLK. Both are non-zero, so the while() loop continues. The commit
message says "it cannot deadlock with itself or
bpf_local_storage_map_free", but:

1. If -ETIMEDOUT is returned because the lock holder is taking too long,
   retrying immediately won't help. The timeout means progress isn't
   being made, and spinning in a retry loop without any backoff or
   limit will prevent other work from proceeding.

2. If -EDEADLK is returned, it means the deadlock detector found a
   cycle. Retrying immediately without any state change won't break the
   deadlock cycle.
"

> Or better if
> rqspinlock does not force queued waiters to exit the queue if it is
> deadlock not timeout.

If a deadlock is detected, it's the same issue for all waiters.
I don't see the difference between timeout and deadlock.
Both are in the "do-not-retry" category.
Both mean that there is a bug somewhere.

> >
> > If it should never fail in practice then pr_warn_once and goto out
> > leaking memory. Better yet defer to irq_work and cleanup there.
>
> Hmm, both functions are already called in some deferred callbacks.
> Even if we defer the cleanup again, they still need to grab locks and
> still might fail, no?

If it's a map destroy path and we waited for RCU GP, there shouldn't be
a need to take a lock.
The css_free_rwork_fn() -> bpf_cgrp_storage_free() path
is currently implemented like it's similar to:
bpf_cgrp_storage_delete() which needs a lock.
But bpf_cgrp_storage_free() doesn't have to.
In css_free_rwork_fn() no prog or user space
should see 'cgrp' pointer, since we're about to kfree(cgrp); it.
I could be certainly missing something.

