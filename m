Return-Path: <bpf+bounces-57610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA51AAD33F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927A64C6B02
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B218DF6E;
	Wed,  7 May 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrezJXHN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44CBA38
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584603; cv=none; b=LNpm1MRO1O4irClTcCfp3nGVnWRYaKYaOex9n2IHcZvbwnP7LTUoxEpoc0bvV9QUkHbxX0ItvfzR6W+I6TAICDI/6pmHs4KFB9bgT7nORo2Mq5/3wkHEBjAaYNyhZsVqwnS1TE78lhYPSHpDD3igZeKPN2v8H0rM7P4Q7X2AqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584603; c=relaxed/simple;
	bh=+942YOX8z0y0pwZiTFOijR7QTcIy5mT9DIC53KMhOM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0mFowWs5wAgI23A9PLHjpDmWEwoNr0j/fcQhjVnop52HQ+92JVprAD8iDmHzNfIvemWCKDMouqmMUEtf8I9cGforjJVyn6OVmh210MFw81N8U7bzSvyFbj1lPfszbrFl+GJPVIdzZC0vYLniEpcQtg6njSyRFMOaC5vuJ2ItJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrezJXHN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0ac853894so1174637f8f.3
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746584598; x=1747189398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9Guy6qToRjjPPqJUbaVWM/+tW9xgTcFVjBVft6BE5E=;
        b=GrezJXHNHGQmT75Zq0RDvrD2jKbLglCWBWgUwpkH1d2CwOV1CM97hZlOjP36X669Wq
         yawIw48efInI7TIK8AmGjhdHkIfgInL9zWwET7qKGImAs2JjI1vY3iduOEBYAxLhYSnL
         xyHeuV+ixJQeggXhWBhjSdaPwJvGDW/ovWoADAdrKsqFQ3gBXOZsk3wrKNZj95AV/dxB
         lG2P4DkiYYAbeZSoG5YvaAZ6SCAuws8X8M9PkSdspTZOj8/12kskajBfH0OjV/lbkq6R
         Ijs7HUWNQJ+ritAmZ6IByYidXOHe6jB86iajDSVRdqiCY/XQruk+rKX8TsTQHWouvo7Y
         msLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746584598; x=1747189398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9Guy6qToRjjPPqJUbaVWM/+tW9xgTcFVjBVft6BE5E=;
        b=mRZZ3pNWWqPNXk/oHTtnMX8fQ5b9aufCgghKXV6gNUsIGK8NMEz/7TGA2qr6ETDPjS
         1SoAbCJ44/DpGoF5nnb+MKy2l7EpA1FNBYebT1lhprt/l/hvNyIs6ZTaS6gGS5ZBtWKT
         MOqLSb/osP7UgIjUTsT4DeqOFnvRNBod0cN33n/4uCKxMOkmWX3nlLqZEWss6cTTnfMl
         6MtUPK05uHSSg/4gKH5ZAi/KQvt+EDGZfEgCITpqTIPzTX6UztfqTkHijJlctP557OZn
         +bikbSA+/BoVa+a6VWVTDxFO6psPsnKU+K9B8SIynoOgQywTcBSeT7TwtIKWMgSdNnjo
         iywg==
X-Forwarded-Encrypted: i=1; AJvYcCWzr30G++Pw/qQHOR3YF2gEaykSyN0mRpnQYIwvf6Q+NOIKJwHGc9LPOuMwEXfV1kLHURk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdPshW6llckb80vghgaScqOJHxoIr0Ia0WAm98ilPUTFOL/ln
	aDQjM7LSFeGjEaZek9txxGjf6GwgzMrJ5IB+nihNroYcFcW4AavkH6YrUov5AcGQ3Ruaht+Kp8Y
	GnnCq9l7XO0XMa1Rr59Xv2OPBTEs=
X-Gm-Gg: ASbGncu2bl7H7x5y4PPfHGN5G9+Ht9W4J/mnSrPKbS1E+WO3hWk1Qvn1Cvmu3aLV2uc
	OP2lU3hcodWf7ZSkFLtPayM+Pkk4dWDF2qdxW6IUY9xAwk+p5Ro5R/8J48C0WrNJSiNK2gHEFGp
	96nvy3pc5h6dwUglsSHk7waUdc/i4VS9Kp/xia/SzBxkNgRmizkA==
X-Google-Smtp-Source: AGHT+IEU58FPM4QcTZNAt99CfK6J6kaaS+h1APjmMIBcKMeDKZVp8zweh4RTbN6cyZecTc7PJp+FNu7Zsq2w1/fD6jk=
X-Received: by 2002:adf:ce8f:0:b0:3a0:b4ca:45a with SMTP id
 ffacd0b85a97d-3a0b4ca057dmr789359f8f.29.1746584597801; Tue, 06 May 2025
 19:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com> <4d3e5d4b-502b-459b-9779-c0bf55ef2a03@suse.cz>
 <aBqp1ScxaTznSf36@harry>
In-Reply-To: <aBqp1ScxaTznSf36@harry>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 19:23:05 -0700
X-Gm-Features: ATxdqUFMxlOo0x0dJttoslBPR3J4Lu4Bd2_PvDm6ylzuUCF_CmzZC5N_rFzBpEM
Message-ID: <CAADnVQKSD-n3FXCABfJqXa=vq5rAt45RX20cwktHNofX2aZ8zQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:31=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> On Tue, May 06, 2025 at 02:01:48PM +0200, Vlastimil Babka wrote:
> > On 5/1/25 05:27, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > kmalloc_nolock() relies on ability of local_lock to detect the situat=
ion
> > > when it's locked.
> > > In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened =
in
> > > irq saved region that protects _that specific_ per-cpu kmem_cache_cpu=
.
> > > In that case retry the operation in a different kmalloc bucket.
> > > The second attempt will likely succeed, since this cpu locked
> > > different kmem_cache_cpu.
> > > When lock_local_is_locked() sees locked memcg_stock.stock_lock
> > > fallback to atomic operations.
> > >
> > > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > > per-cpu rt_spin_lock is locked by current task. In this case re-entra=
nce
> > > into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> > > a different bucket that is most likely is not locked by current
> > > task. Though it may be locked by a different task it's safe to
> > > rt_spin_lock() on it.
> > >
> > > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > > immediately if called from hard irq or NMI in PREEMPT_RT.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
>
> ... snip ...
>
> > > @@ -4354,6 +4406,88 @@ void *__kmalloc_noprof(size_t size, gfp_t flag=
s)
> > >  }
> > >  EXPORT_SYMBOL(__kmalloc_noprof);
> > >
> > > +/**
> > > + * kmalloc_nolock - Allocate an object of given size from any contex=
t.
> > > + * @size: size to allocate
> > > + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
> > > + * @node: node number of the target node.
> > > + *
> > > + * Return: pointer to the new object or NULL in case of error.
> > > + * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
> > > + * There is no reason to call it again and expect !NULL.
> > > + */
> > > +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> > > +{
> > > +   gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> > > +   struct kmem_cache *s;
> > > +   bool can_retry =3D true;
> > > +   void *ret =3D ERR_PTR(-EBUSY);
> > > +
> > > +   VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
> > > +
> > > +   if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > > +           return NULL;
> > > +   if (unlikely(!size))
> > > +           return ZERO_SIZE_PTR;
> > > +
> > > +   if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
> > > +           /* kmalloc_nolock() in PREEMPT_RT is not supported from i=
rq */
> > > +           return NULL;
> > > +retry:
> > > +   s =3D kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> >
> > The idea of retrying on different bucket is based on wrong assumptions =
and
> > thus won't work as you expect. kmalloc_slab() doesn't select buckets tr=
uly
> > randomly, but deterministically via hashing from a random per-boot seed=
 and
> > the _RET_IP_, as the security hardening goal is to make different kmall=
oc()
> > callsites get different caches with high probability.
>
> It's not retrying with the same size, so I don't think it's relying on an=
y
> assumption about random kmalloc caches. (yeah, it wastes some memory if
> allocated from the next size bucket)
>
>         if (PTR_ERR(ret) =3D=3D -EBUSY) {
>                 if (can_retry) {
>                         /* pick the next kmalloc bucket */
>                         size =3D s->object_size + 1;
>                         /*
>                          * Another alternative is to
>                          * if (memcg) alloc_gfp &=3D ~__GFP_ACCOUNT;
>                          * else if (!memcg) alloc_gfp |=3D __GFP_ACCOUNT;
>                          * to retry from bucket of the same size.
>                          */
>                         can_retry =3D false;
>                         goto retry;
>                 }
>                 ret =3D NULL;
>         }
>
> By the way, it doesn't check if a kmalloc cache that can serve
> (s->object_size + 1) allocations actually exists, which is not true for
> the largest kmalloc cache?

Good catch.
I need to add a check for s->object_size + 1 < KMALLOC_MAX_CACHE_SIZE.

