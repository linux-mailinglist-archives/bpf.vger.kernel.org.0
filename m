Return-Path: <bpf+bounces-73776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FCC38E23
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 03:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D4C189C649
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 02:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6013A226173;
	Thu,  6 Nov 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp6UJxkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED801A9F84
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396760; cv=none; b=aXp/P78goBDIWRqA2cMHaPqS0S89tDAKVZkhSnfYsb8DJRArOGvzD2e6OG3JIWK5glwmmzmN9SqjLTkvrr80Hvp9ZU+XR4emM4j+hAztna8pVdGbesbAJnB+B8mihtIqzidtXHCcJefhTU/20Er48T4IICWraxxqyF4cq+hXfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396760; c=relaxed/simple;
	bh=P4wGWJkm8gOctpm2JR1V83NPDjbvnu7PRXyFxGiiAHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1RbO5aFAaXKbRHWUBh135ZOp8OYtywEXdV0cKnPrK1xgYhdyJZ0ITS2/r2zW6sdfnv4y+72Ok/pnU4UZ81VTJKdqoN+7QcbJEURuhNhh51mlXrnoo5vajHFiWSQXw1BeJolqGQi2EzhJe4FIxEHtcacRcnL8jbwdHqEQeSv4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp6UJxkZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-421851bcb25so228564f8f.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 18:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762396757; x=1763001557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewoAJCSF8NH/dTxpovl4STEPgaBdVGC9xI+etM7pZH8=;
        b=cp6UJxkZ1gFNVSj6GNbcxQnqWKSXuaQzZorbV/UdINM4oUSSFdvQjnLzjtDB644com
         xT94NCd0wQiFGm8lf1b5kqMcAqS5UH15bROydhqs7tZANuDNOcoFBy8xiKiSuHlexdC1
         1U8dibLakopdm/OrtcxJ92YH82jfjbRkoiOIN82Hq/ttfvx9uzNTdIyqqIE1cqIllUFp
         5WGsKFHk2567zF4getVOLEr+0Kdc6oCHGrFQVDaBTEXlu5waqjrnd9O34jbwLnGliFcx
         pPaWtKAy8ZnPemAfYLMJGc9AN1xZdvJa2TbSkn5lgDq1ZBPi2WtqTlnWeO1sFKmp4JGB
         chkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396757; x=1763001557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewoAJCSF8NH/dTxpovl4STEPgaBdVGC9xI+etM7pZH8=;
        b=UqD7iYUJd99Jjcv8Vzc8K0+7GR7QaPFiH1mrJoVDW/ojHCumJwBAQFnyjuZaNnO1ga
         YKbfQmoY6ANf8ry78dLk9jZjkUCrzORQ+KfmWvETS0SjslqXVBleS/TmkOblb3l2mnlt
         fZRPSmN1Be3y9rVwl9+RcQkLcad2kBJtjxR71PjmqR2Zf5/bK7HQFYZxWZCQ0vJz6U30
         Qvvw4HIZ0a0jAiE3wAut2x8cfNsHts8FHvS1QQeGq1HjO/OURiUIlkDwECksNoRVJ/Qw
         nbxxlGV5sBvg2ygTjLSH4sJeDvQSGMinzKazg4YRj4MWkD3VrNkNMn9aspQNioUraMHs
         LJEg==
X-Forwarded-Encrypted: i=1; AJvYcCVVf09y0pKG9le/aKD0jufPtnbu6vYvkUdmOTbOe7Mue6amSXkeANiusZoST7uImeeIKAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKEblCmuqHi47ig15orMo+0Bw5rWBvhcEQ8j9CUJAjSPEFgn4C
	D2EIn16a5za3jVUY792N6xiaQRbICHxLpYscZX/S88as1SiMI6Yi+vW6pOh6SyFP33YroovCqBy
	zB7mxk+l07AZMbbqugVueDNbHAlJ4VNU=
X-Gm-Gg: ASbGncupBQ4WN2O8PkqjsBe/vrP4RFsILldeDNTnWGxnKEZ5A8fnWNMExf/q8nS/w+v
	AvgsFEo6uXsJcRPLUi6WsELoedKN/A0hADUHuAl9C6+qZ3/nzXD9uVoR3A6caDLR9k3xtq6M8nN
	K2fVJ5r19oG00q7jR/HJ4HPJyWsHWW3GBk9oNmT8AWRlGfwYMlgc75sYjyvrsgIk3vE71zw+dx3
	FAl7F9ORA52kvBfPWxo3A25Y6f8gu7fyRlDlx1Khshx2vc9VSV915UBlPqg8FNUp0HHPYS2vyhM
	CRThli1tt4JxN9JRifsSCrnHaHQ6
X-Google-Smtp-Source: AGHT+IEMYxYr58b+9gWCWiOxY19wV2YuCXhlo+gockn3ye5gvJ4AIE1Hket4divhHgZldaCGzsJU+k/vwey2D9OfBOE=
X-Received: by 2002:a05:6000:2dca:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-429e32e36eamr4631215f8f.16.1762396757374; Wed, 05 Nov 2025
 18:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz> <20251105-sheaves-cleanups-v1-2-b8218e1ac7ef@suse.cz>
In-Reply-To: <20251105-sheaves-cleanups-v1-2-b8218e1ac7ef@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:39:06 -0800
X-Gm-Features: AWmQ_bnDlj12yke_m0UY9rM9to7dPxs3SzBTZ6_PfSj5mhKDDRMWfaCanTzBLeU
Message-ID: <CAADnVQJY_iZ5a1_GbZ7HUot7tMwpxFyABEdrRU3tcMWPnVyGjg@mail.gmail.com>
Subject: Re: [PATCH 2/5] slab: move kfence_alloc() out of internal bulk alloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:05=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
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
> index 074abe8e79f8..0237a329d4e5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5540,6 +5540,9 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, g=
fp_t gfp,
>   *
>   * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUN=
T
>   * memcg charging is forced over limit if necessary, to avoid failure.
> + *
> + * It is possible that the allocation comes from kfence and then the she=
af
> + * size is not decreased.
>   */
>  void *
>  kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
> @@ -5551,7 +5554,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cac=
he *s, gfp_t gfp,
>         if (sheaf->size =3D=3D 0)
>                 goto out;
>
> -       ret =3D sheaf->objects[--sheaf->size];
> +       ret =3D kfence_alloc(s, s->object_size, gfp);
> +
> +       if (likely(!ret))
> +               ret =3D sheaf->objects[--sheaf->size];

Judging by this direction you plan to add it to kmalloc/alloc_from_pcs too?
If so it will break sheaves+kmalloc_nolock approach in
your prior patch set, since kfence_alloc() is not trylock-ed.
Or this will stay kmem_cache specific?

