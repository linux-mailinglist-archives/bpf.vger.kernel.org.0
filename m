Return-Path: <bpf+bounces-79188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67109D2C1FA
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 06:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B48E63027CC5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B51C345CA2;
	Fri, 16 Jan 2026 05:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCihBOC1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B806238178
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542339; cv=pass; b=kFJutzB7VINtvbmANyUQSVnjE+fVq/DTst8QvhqcXxV7Z7vi8lRo7demOJXdl8dfk2UN5Hbd3imv2p8Ou3yrXseCZP+dXxpl+Cp36B42/9zd56+cAQ0E7zdFanIr+f89PhwQD45uWiOgeuyY+GKsz7n89V7SaNBz4yP060g77M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542339; c=relaxed/simple;
	bh=O7GOd0Lhv+RwGmCCcJI3vXg56EI/++xWS58YgV3u1t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgGnAa+aPv82FKw2D+m/G7A2ehdvB6ZhzxhGPkz7GSS0iSvoMxuRBoVvrjodVptgDFHepnhDoOU19YM9dSo5DPG9UDtioYugjyPjw/A3gc3AuokkSwezzHzbKilgKhzjQ/edYkuLsWwo/iCUNBw5tz6XC/fc0hzGEoqmBON+guo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MCihBOC1; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-501511aa012so241291cf.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 21:45:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768542337; cv=none;
        d=google.com; s=arc-20240605;
        b=bIOcL+oi2Yly4BwUjsGKlSG4AKxXIY+rsQDv0bK+rd8FCZh2Q74WbtUhr/OREHus2r
         jNzhHwBYSCn+5xjIJur50hV25++Mu1H8rxIPjHOUklMzRnYhxt2Y6rNCLY7sgYeDfre3
         +eQY+BzTRPS0fQP0jHO/mYi1/s9zSBbm4Magx0Mzd2WO3FNbmJEDejktJ2AQIt/z9Tsl
         AWcqkAiGZ8QwUuO0Iv3YP551zWmVmNQCB7jWvcM0r6QYmKY/OuRaxlKyyF/wyG+wmE3l
         rdeRs5JUBAdiF5pxFtzORvKPJu9wwd6G7hApGy/bza0c+3+DehBcouZKjZRGep2Xsh+s
         VI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oD4lKTyPruUjM+2ZGAjFWRV4Lq8q1KPCB1ITiVRP8FE=;
        fh=Run/F0xyAGQvo5s+LmVN/CPWhAkG/p2DAVHpUtqFocc=;
        b=JzFWI2FTeaRsYABGonzZEvlUnyTqQGNmjKcvDC293iR7qdpPuz0ynMa1iWlURK6/BT
         gePNymfWXIW/8OoDuXXpBdSHmolC3Mz8ifIrxsV+MIOqEkJwclb0m0u5UNXuJdy2YvwK
         HyqkR3m/Wea30I7UR6hayO0PsYaRBcLmwL1GQ7su7kCIh2inDlOO4qWzpfJNDHCJjAQI
         z5AUkShPFPPCSunwPZoAUoJwj4vsv+7ZR9Af3MgmzU/uWdNUaKfz1SD3hPbi2xt1eMTR
         fydtzxpEAoFRHXrU/Q0gG7gzkgZTDh0o361zdR43+Itduq/BDJAzxupwgVgdojLm9KNW
         eoSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768542337; x=1769147137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD4lKTyPruUjM+2ZGAjFWRV4Lq8q1KPCB1ITiVRP8FE=;
        b=MCihBOC14RNtlI3IvPziOKKjK7qzIqeoYGYdpBT/P/70j3f7zshz1VHR1RnBKEsyNQ
         DRRFslB18VRyI/5EshdIqsgN8qX6XmGxjRHEtYPcWehLrfvEM/IrJ0MW2erT2jQO6SBK
         bAl3C0nPFK8UX7FQNAAff3N/pVqj31xKpMceOX1QL3iftpCK7ZE/75r+Lumtg7CTb9ve
         exCxptgBQYIQfgOVg/L5GrG+gBsLM92eKc7ww98Ia5l1PfurOlXPG7Lpq1y07qoCIXWO
         BfCsyXGI5KQwvEqETBqyiSWzhrA/CAnMmKiqnFBks0PGOBPnr6reKTq42u+B/1X7+yeG
         BHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768542337; x=1769147137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oD4lKTyPruUjM+2ZGAjFWRV4Lq8q1KPCB1ITiVRP8FE=;
        b=OERxeohm7Cgktr0lHgwK1xvs0F4YEaFu44nRbj+qqukabFMvKDYvDpmExIa3P8Tvqf
         5srk+3iIK9TamAnxnBIoRzXTLjhqTVwpFU4HiI83E6jHltAw9cFeltwFAN3pWWSnwyeq
         Uo2vUYP68DtWHnoTlSB/yoEIUL7R2L7bfv3R1aALUSlPJNauiVvNdnHqbEe/bqPDHJdF
         eAeLgUgFLAQQEb2vm60ptS7QUEj8sQgnCnkh1JdXAsZlJ+baQbiYeOPumpLJbk/oW+2O
         q43exez+ChzYzq0jqYWlYj1NYT5CXCzdPuxwNq5e57B3Ly3fiK+eA5BdcwmwC3wiymFC
         7UeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWUrIM8j7Bf4rBDGIFzaKUYiiQXkRqNcdfNoz0tnV5n9WijuSHhYyQcMaU+kbeP82WfvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuF8oWQR613HQCWfjLa10XrBkudey7YjATcN6PegmALoFApJvI
	VJjAUta2aFkE3Y5J8J/VeO6ZOv0XZOIQMPQRIISCT+xi7o+I7KU0XCaAtxV06JKnk0Tm1754sea
	2DdzeymNhbL8vTOsjSS5UkEGzh11v/QTEFekf9Q+e
X-Gm-Gg: AY/fxX7FrCGIY5K7mjkTqjrgQ9ih3EbjGsU8MiSkRoULFjNMuYRNeyOuqhpahM6NKA2
	rX0UU6qfCH5OVW6VRC+ONEgzwEUuJFeJM+Xqqf55BApwBN1OKPCRmw8HRFDpVJU8iOK6Vs8Eib5
	/+9Tgv5c/tV9Z7qxHTKo9uiQKvcK/u205+grwCkFPyFrxFmmjUyu82/9o5roYKAcGOc3AoeKESy
	GNqj8GBZKrEGjJZ2Mxt1gVWFNiHuW99WkwY89znhy4ZrdXoS5ATcCSwW9YsS5V8JUqk8UyC3FKS
	cco2oAZEW/sVqlEAQEqdBxILy1vLDY5KVw==
X-Received: by 2002:ac8:5a93:0:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-502a23ba0bemr6815851cf.12.1768542336851; Thu, 15 Jan 2026
 21:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz> <20260112-sheaves-for-all-v2-4-98225cfb50cf@suse.cz>
In-Reply-To: <20260112-sheaves-for-all-v2-4-98225cfb50cf@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 05:45:26 +0000
X-Gm-Features: AZwV_Qj313U65TQKJGcZKomalyp4G4s3S9dwtw3N-deAJ8pCUFL8HFCSglYguDc
Message-ID: <CAJuCfpFKKtxB2mREuOSa4oQu=MBGkbQRQNYSSnubAAgPENcO-Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/20] slab: add sheaves to most caches
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> In the first step to replace cpu (partial) slabs with sheaves, enable
> sheaves for almost all caches. Treat args->sheaf_capacity as a minimum,
> and calculate sheaf capacity with a formula that roughly follows the
> formula for number of objects in cpu partial slabs in set_cpu_partial().
>
> This should achieve roughly similar contention on the barn spin lock as
> there's currently for node list_lock without sheaves, to make
> benchmarking results comparable. It can be further tuned later.
>
> Don't enable sheaves for bootstrap caches as that wouldn't work. In
> order to recognize them by SLAB_NO_OBJ_EXT, make sure the flag exists
> even for !CONFIG_SLAB_OBJ_EXT.
>
> This limitation will be lifted for kmalloc caches after the necessary
> bootstrapping changes.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

One nit but otherwise LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/slab.h |  6 ------
>  mm/slub.c            | 51 ++++++++++++++++++++++++++++++++++++++++++++++=
+----
>  2 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 2482992248dc..2682ee57ec90 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -57,9 +57,7 @@ enum _slab_flag_bits {
>  #endif
>         _SLAB_OBJECT_POISON,
>         _SLAB_CMPXCHG_DOUBLE,
> -#ifdef CONFIG_SLAB_OBJ_EXT
>         _SLAB_NO_OBJ_EXT,
> -#endif
>         _SLAB_FLAGS_LAST_BIT
>  };
>
> @@ -238,11 +236,7 @@ enum _slab_flag_bits {
>  #define SLAB_TEMPORARY         SLAB_RECLAIM_ACCOUNT    /* Objects are sh=
ort-lived */
>
>  /* Slab created using create_boot_cache */
> -#ifdef CONFIG_SLAB_OBJ_EXT
>  #define SLAB_NO_OBJ_EXT                __SLAB_FLAG_BIT(_SLAB_NO_OBJ_EXT)
> -#else
> -#define SLAB_NO_OBJ_EXT                __SLAB_FLAG_UNUSED
> -#endif
>
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
> diff --git a/mm/slub.c b/mm/slub.c
> index 8ffeb3ab3228..6e05e3cc5c49 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7857,6 +7857,48 @@ static void set_cpu_partial(struct kmem_cache *s)
>  #endif
>  }
>
> +static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
> +                                            struct kmem_cache_args *args=
)
> +
> +{
> +       unsigned int capacity;
> +       size_t size;
> +
> +
> +       if (IS_ENABLED(CONFIG_SLUB_TINY) || s->flags & SLAB_DEBUG_FLAGS)
> +               return 0;
> +
> +       /* bootstrap caches can't have sheaves for now */
> +       if (s->flags & SLAB_NO_OBJ_EXT)
> +               return 0;
> +
> +       /*
> +        * For now we use roughly similar formula (divided by two as ther=
e are
> +        * two percpu sheaves) as what was used for percpu partial slabs,=
 which
> +        * should result in similar lock contention (barn or list_lock)
> +        */
> +       if (s->size >=3D PAGE_SIZE)
> +               capacity =3D 4;
> +       else if (s->size >=3D 1024)
> +               capacity =3D 12;
> +       else if (s->size >=3D 256)
> +               capacity =3D 26;
> +       else
> +               capacity =3D 60;
> +
> +       /* Increment capacity to make sheaf exactly a kmalloc size bucket=
 */
> +       size =3D struct_size_t(struct slab_sheaf, objects, capacity);
> +       size =3D kmalloc_size_roundup(size);
> +       capacity =3D (size - struct_size_t(struct slab_sheaf, objects, 0)=
) / sizeof(void *);
> +
> +       /*
> +        * Respect an explicit request for capacity that's typically moti=
vated by
> +        * expected maximum size of kmem_cache_prefill_sheaf() to not end=
 up
> +        * using low-performance oversize sheaves
> +        */
> +       return max(capacity, args->sheaf_capacity);
> +}
> +
>  /*
>   * calculate_sizes() determines the order and the distribution of data w=
ithin
>   * a slab object.
> @@ -7991,6 +8033,10 @@ static int calculate_sizes(struct kmem_cache_args =
*args, struct kmem_cache *s)
>         if (s->flags & SLAB_RECLAIM_ACCOUNT)
>                 s->allocflags |=3D __GFP_RECLAIMABLE;
>
> +       /* kmalloc caches need extra care to support sheaves */
> +       if (!is_kmalloc_cache(s))

nit: All the checks for the cases when sheaves should not be used
(like SLAB_DEBUG_FLAGS and SLAB_NO_OBJ_EXT) are done inside
calculate_sheaf_capacity(). Only this is_kmalloc_cache() one is here.
It would be nice to have all of them in the same place but maybe you
have a reason for keeping it here?

> +               s->sheaf_capacity =3D calculate_sheaf_capacity(s, args);
> +
>         /*
>          * Determine the number of objects per slab
>          */
> @@ -8595,15 +8641,12 @@ int do_kmem_cache_create(struct kmem_cache *s, co=
nst char *name,
>
>         set_cpu_partial(s);
>
> -       if (args->sheaf_capacity && !IS_ENABLED(CONFIG_SLUB_TINY)
> -                                       && !(s->flags & SLAB_DEBUG_FLAGS)=
) {
> +       if (s->sheaf_capacity) {
>                 s->cpu_sheaves =3D alloc_percpu(struct slub_percpu_sheave=
s);
>                 if (!s->cpu_sheaves) {
>                         err =3D -ENOMEM;
>                         goto out;
>                 }
> -               // TODO: increase capacity to grow slab_sheaf up to next =
kmalloc size?
> -               s->sheaf_capacity =3D args->sheaf_capacity;
>         }
>
>  #ifdef CONFIG_NUMA
>
> --
> 2.52.0
>

