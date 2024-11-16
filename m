Return-Path: <bpf+bounces-45027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C59D00E7
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744851F22F54
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1B19AA63;
	Sat, 16 Nov 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+jtyfxU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0681198A32
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791615; cv=none; b=iF5QKbiPGULVSPbVemCOg62ZzDeghD/V4FMVl3Co2J49XBZEI05CoVLpyaIqMrx4Z2EZpLv99icOnD6Sr5kbBl/TOnF5vjFxTkDUiWCPaFW20+hQgTO1Gt3jhnSKw4wZBw1HrZCr0ayQhse6uUE2rYosWi7FNJB7e8FoHvCvzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791615; c=relaxed/simple;
	bh=GneETWNuQbIKPXjN7Bgw5dQvWSF0td9Y12igZBFgv1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsU/8zMMelHiCToDAbfUdDm76TAhuWxmKTI3wh7hfve9e0JDpi8khcvSz1NXK+fi3OREwb/OQDtKgNp9OIKlAb6WkP18flQ3lgRrznAvn6SC3eNP6Rk1IJsXsFFZmxAWH5VbxeWW5hebs58lLH6XcyDL0ELhkLA7kIXQy81e4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+jtyfxU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3823f1ed492so101716f8f.1
        for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 13:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731791612; x=1732396412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dDhpQKeKCOHpYq1q9d/wZt5vbSCK68JYDrGvDMs02k=;
        b=g+jtyfxUzW9p68c4bHKaEs3O514LDN7JeqR8jS/ThOO6le7OrFlYb9i8w1zi0N/zD2
         H8E3d7YSQZ5qp/NRrxmaFFQK9jXiIscSVPXMawRhDJIEicCjibHUJr5g3WW/f6V78I0i
         KdZlGqKfMdZ3YfaItf8ThazHGzkWvlOrMAGUDGjZ/V37ks3ltss2tPCDtRVyj0hVxxG/
         J+3zA2SfRNm+Zu6rsfsMKwcb1bUAAsO9lfGOHU7vCFTBBd0wB+ewGkESUW5tMlBQwCNp
         HX/D4lHr454Sxqo9VWsCOWhfTjXV5sqGNj9nvwPyid5p8eRMwHjqIBqOEurVToSL6k+/
         grPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791612; x=1732396412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dDhpQKeKCOHpYq1q9d/wZt5vbSCK68JYDrGvDMs02k=;
        b=SyPiQDeqWy83ZSWGJxPrCmCnPq1sgdZvRbUCb89UKEOrhb4MWl6kYpuzTQr206yZqK
         w+8D+gpq1zDj3RqbF6XuvFtUirtew1heepzWdzZ/0Kn+raLdgHbw2Qtt+cSH9L3btUoy
         VFAKxBa110emw0VoOZmaD05n/MKIci7GjWGDMUgCAUjzc0uTmBhxb6+FnsMIteNbGFOz
         f4no0WPhK0faPvgBVKKeyuD+lmNomETQygUPYTMivVJXL09FCOYD393wyesKOUpefMgO
         +OPwvo2TtHtqaGopXWn5eq9a9NdRofYJ1BN7ljJHiE164QGZMEjXWH5rVbJ9TJfnZIWW
         aEbQ==
X-Gm-Message-State: AOJu0YyhI+TbtZwD38wyz8Rbdb3QN47URr4/oke/zQyb6eo4ErtG8COW
	qkoKCyBBmGhwjXdOkP93Fq5P8egkQJuqeB5T1XGe1ywkSc8OVBA1IzDkp6cuVG+s+o95O2mMmE3
	wSnl3fPJZXGJb69CaXcUUaJ1kWss=
X-Google-Smtp-Source: AGHT+IERg180eYsWsfE3AGTNTKe/Lns2k0t9xV3PGtNkTH6C1lGtsalMYi9alOa6Z2EXvVeMv5gqxDH8YklhcuL1g6w=
X-Received: by 2002:a05:6000:1865:b0:37d:443b:7ca4 with SMTP id
 ffacd0b85a97d-38214022068mr11374949f8f.14.1731791611849; Sat, 16 Nov 2024
 13:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com> <20241116194202.GR22801@noisy.programming.kicks-ass.net>
In-Reply-To: <20241116194202.GR22801@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 13:13:20 -0800
Message-ID: <CAADnVQLOyY=Jvibq-hnv6dpXy+hAJFWojyHh7wuEiMn-itMvaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 11:42=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Nov 15, 2024 at 05:48:53PM -0800, Alexei Starovoitov wrote:
> > +static inline struct page *try_alloc_page_noprof(int nid)
> > +{
> > +     /* If spin_locks are not held and interrupts are enabled, use nor=
mal path. */
> > +     if (preemptible())
> > +             return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GFP_ZE=
RO, 0);
>
> This isn't right for PREEMPT_RT, spinlock_t will be preemptible, but you
> very much do not want regular allocation calls while inside the
> allocator itself for example.

I'm aware that spinlocks are preemptible in RT.
Here is my understanding of why the above is correct...
- preemptible() means that IRQs are not disabled and preempt_count =3D=3D 0=
.

- All page alloc operations are protected either by
pcp_spin_trylock() or by spin_lock_irqsave(&zone->lock, flags)
or both together.

- In non-RT spin_lock_irqsave disables IRQs, so preemptible()
check guarantees that we're not holding zone->lock.
The page alloc logic can hold pcp lock when try_alloc_page() is called,
but it's always using pcp_trylock, so it's still ok to call it
with GFP_NOWAIT. pcp trylock will fail and zone->lock will proceed
to acquire zone->lock.

- In RT spin_lock_irqsave doesn't disable IRQs despite its name.
It calls rt_spin_lock() which calls rcu_read_lock()
which increments preempt_count.
So preemptible() checks guards try_alloc_page() from re-entering
in zone->lock protected code.
And pcp_trylock is trylock.

So I believe the above is safe.

> > +     /*
> > +      * Best effort allocation from percpu free list.
> > +      * If it's empty attempt to spin_trylock zone->lock.
> > +      * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
> > +      * that may need to grab a lock.
> > +      * Do not specify __GFP_ACCOUNT to avoid local_lock.
> > +      * Do not warn either.
> > +      */
> > +     return alloc_pages_node_noprof(nid, __GFP_TRYLOCK | __GFP_NOWARN =
| __GFP_ZERO, 0);
> > +}

