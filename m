Return-Path: <bpf+bounces-71943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87288C02161
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2995048A1
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9802337BA2;
	Thu, 23 Oct 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+7c0vPE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F04334C23
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232892; cv=none; b=cvLFUZDmKWy5wqHCeV0mxyoW5ny18hu2FfXvWrov0RVk7k55zn27ZPwqEPOPdlf746eJwj+ZtkbRDjBis1DDpksXt3xD7JFQaJXAiAJLtmMV+lcW6OiS93ToeEYITGw5PHI1Rw/4rvK6qLqpRGf8t5TX8R0m1Y2YVFN87lHm3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232892; c=relaxed/simple;
	bh=GkL9WA5K+ltHnePlGyw1wMGJQ1UFA0pchGig9Ct/wWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slrWIft94l8CTZQUGbY/HsTh/aw+R4izIxVhxCpBn6MdbyHO1/eihSbycmWahTpNTCX7XmmvCiRAebLn4XA84YIfq20t5qLJ/qSkC8YX8fe3OzELYPE2D+fwheVGgpbizjllOXAaMO9RVuReziDFwKosJpb3n9w48iBAE5vXy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+7c0vPE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26d0fbe238bso6796785ad.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761232888; x=1761837688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2jwrgWQY1h1RtIcpPrpzP6Qz2BnEli8aRyjgsdjGiM=;
        b=3+7c0vPEqX/ppGqhsw/TDBYGHrSy2DzUgUUJTrOXirqcLXHR3Um9eUsfAPc+51e8eW
         ckwybn/WMsmH6A6aIGKh/+qquR2ILg7bQ3nMBLcyD4fZxYLTV/wvNoYMDNWoRvTc17eq
         xikMvD3hxcrevL8p5iC8KLPhucCG8V6IlXc1iwcblihJTZc6lzTADczOAR6kEC3avkLX
         NkwReVx0ZPbQidJEiraDACDprUDLSHDu4c1/Dh1e/+qQWzDk5ameUTJBCMoAYnQQuhGk
         i5XrSpNCzfX3t53v/WWVAHBxmMzT95qu0WyRDUWD1KLUmQX3dFCtvML1Z3DIz2vijKzU
         5zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232888; x=1761837688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2jwrgWQY1h1RtIcpPrpzP6Qz2BnEli8aRyjgsdjGiM=;
        b=ejPHpM5dOmWdLyRfeFrhjui7gUO6Y1IL+XbYh53TFf0tf6ESegJim1rbNY/+QUqaPn
         97zveXTc7bR8Th3yvOHc+KuKDkJi4+2Vn/Zba5aAA8i9EnpDy0IfkQKd8BM9i/q7vnZc
         lcrPzkHI1mtKx8lmiJDdAcMZ+DSP6xMvjnXbjbBb+CqQvw4llDCgfeWdA4h+EdgtX0eH
         Hx4lhtcuthBNQyrwKIP5Tm2FPqzybavBIyRGVY5k41EwrU3dC91cHjnwXg6ogEtKkVQU
         2T8p3gtRsdwxaVD9CsI1/fweayCWqkJCYgMU5xv3Lr9hTP5XSaSEfYDlZaBOXyIJgfl3
         dadw==
X-Forwarded-Encrypted: i=1; AJvYcCXDVzt206dB94xYrA4upKMctEiF30gofOF5JQPmx33oQCQ1ZMRso5fFMHpC0xXIppN1IQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJRF5xfVkiD7V/3RfJiZLlPU4wz5lCOa1t2djtKP8v2v2Qfag
	6riO0KgpYF3qylQeP6HrGFVjjUoXtSH2OE6nAbnnkwX+z5rMwVCLFunxCIrA+5Kp1x0Ux6K/n0u
	AhHrR5lV0NWt17TVNUZbcRuKJYVzBokcMUHn0jwgG
X-Gm-Gg: ASbGncs9PqCVL0aA7jc39yblbS5kTfqxo7VG++lESs/fYJY1MeJi+ryJhvQt3OdIKXv
	xjrQ1g/a9GRxlAPynp0xLybUsZxvk/GMIu3iMZD+oD8g7PKGRIn0c1qQ9VwHll70Gwo9nx/rZvM
	nHmmGliWVwIk8uejsGPYVNIT5MMGv1RCROpEv3282c5cN1x39SDL72TqLBADZutg2wSCYMgrqoX
	m7iFmyVxWXUiJc/Pk21Loq0GNH+6w42AgJRbNLIdF2cH0qwG9fs6JccFcPmqvdKj1YipcgMfXnC
	H0iNDgZxKbWyMalcZIHt4gxIlcgJc39Kw04Z
X-Google-Smtp-Source: AGHT+IEWgZ7UzgS2PohV24hBKhF9JtPcksvlA1uoFSx8c8CFEwNgsBYtAGAlA8K3H24IvkOMh8whAfHS8cAKsM7wQww=
X-Received: by 2002:a17:902:e746:b0:28d:195a:7d79 with SMTP id
 d9443c01a7336-290c9c897cemr312219295ad.5.1761232888223; Thu, 23 Oct 2025
 08:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz>
From: Marco Elver <elver@google.com>
Date: Thu, 23 Oct 2025 17:20:51 +0200
X-Gm-Features: AS18NWBMguvD9NqZ0MBG1ww1DA9Wez_eaadFg_kTQ6tj-ZGocLoyPMGw450Hbw4
Message-ID: <CANpmjNM06dVYKrraAb-XfF02u8+Jnh-rA5rhCEws4XLqVxdfWg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/19] slab: move kfence_alloc() out of internal bulk alloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 15:53, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
> allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
> but it's conceptually the wrong layer, as KFENCE allocations should only
> happen when objects are actually handed out from slab to its users.
>
> Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
> object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
> was refilled with KFENCE objects. Continuing like this would also
> complicate the upcoming sheaf refill changes.
>
> Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
> to the places that return slab objects to users. slab_alloc_node() is
> already covered (see above). Add kfence_alloc() to
> kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
> prefilled sheafs, with a comment that the caller should not expect the
> sheaf size to decrease after every allocation because of this
> possibility.
>
> For kmem_cache_alloc_bulk() implement a different strategy to handle
> KFENCE upfront and rely on internal batched operations afterwards.
> Assume there will be at most once KFENCE allocation per bulk allocation
> and then assign its index in the array of objects randomly.
>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 87a1d2f9de0d..4731b9e461c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5530,6 +5530,9 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
>   *
>   * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
>   * memcg charging is forced over limit if necessary, to avoid failure.
> + *
> + * It is possible that the allocation comes from kfence and then the sheaf
> + * size is not decreased.
>   */
>  void *
>  kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
> @@ -5541,7 +5544,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>         if (sheaf->size == 0)
>                 goto out;
>
> -       ret = sheaf->objects[--sheaf->size];
> +       ret = kfence_alloc(s, s->object_size, gfp);
> +
> +       if (likely(!ret))
> +               ret = sheaf->objects[--sheaf->size];
>
>         init = slab_want_init_on_alloc(gfp, s);
>
> @@ -7361,14 +7367,8 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>         local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>
>         for (i = 0; i < size; i++) {
> -               void *object = kfence_alloc(s, s->object_size, flags);
> -
> -               if (unlikely(object)) {
> -                       p[i] = object;
> -                       continue;
> -               }
> +               void *object = c->freelist;
>
> -               object = c->freelist;
>                 if (unlikely(!object)) {
>                         /*
>                          * We may have removed an object from c->freelist using
> @@ -7449,6 +7449,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>                                  void **p)
>  {
>         unsigned int i = 0;
> +       void *kfence_obj;
>
>         if (!size)
>                 return 0;
> @@ -7457,6 +7458,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>         if (unlikely(!s))
>                 return 0;
>
> +       /*
> +        * to make things simpler, only assume at most once kfence allocated
> +        * object per bulk allocation and choose its index randomly
> +        */
> +       kfence_obj = kfence_alloc(s, s->object_size, flags);
> +
> +       if (unlikely(kfence_obj)) {
> +               if (unlikely(size == 1)) {
> +                       p[0] = kfence_obj;
> +                       goto out;
> +               }
> +               size--;
> +       }
> +
>         if (s->cpu_sheaves)
>                 i = alloc_from_pcs_bulk(s, size, p);
>
> @@ -7468,10 +7483,23 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>                 if (unlikely(__kmem_cache_alloc_bulk(s, flags, size - i, p + i) == 0)) {
>                         if (i > 0)
>                                 __kmem_cache_free_bulk(s, i, p);
> +                       if (kfence_obj)
> +                               __kfence_free(kfence_obj);
>                         return 0;
>                 }
>         }
>
> +       if (unlikely(kfence_obj)) {

Might be nice to briefly write a comment here in code as well instead
of having to dig through the commit logs.

The tests still pass? (CONFIG_KFENCE_KUNIT_TEST=y)

> +               int idx = get_random_u32_below(size + 1);
> +
> +               if (idx != size)
> +                       p[size] = p[idx];
> +               p[idx] = kfence_obj;
> +
> +               size++;
> +       }
> +
> +out:
>         /*
>          * memcg and kmem_cache debug support and memory initialization.
>          * Done outside of the IRQ disabled fastpath loop.
>
> --
> 2.51.1

