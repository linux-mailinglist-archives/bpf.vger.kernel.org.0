Return-Path: <bpf+bounces-79382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8773D399D0
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 21:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9328C300A857
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0330146C;
	Sun, 18 Jan 2026 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wzRnwKJ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7E26CE34
	for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768769160; cv=pass; b=jPmgAbMNhgwcPYExNFkO0Ra/qVlB0ctDbUtP5abTrgpT+81KtmxJ2LhN915lm3DjHppf7fT80Hehlc/eIAYg8ddj83E/okOKT5GTlR62Cm3CYlBaak+r3BiwXrpNC9wYKETXcQ1dovcPEYsLe3/uM+BzpK+WroU0Dl0Qs8KGuyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768769160; c=relaxed/simple;
	bh=T5T9IiIX1AkP1xCGwU+8g1cSZbEPTGfdWyqDodv+S2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flBZySbgG/J+fXO2MqxzbiQeHhweZUkf8GgU93PtiygRjsGhUwAtMiqccaxSD2rsRdYaDE9HaDNTQgsQYKoXmGh539LnPZ2XEwm0qQJNc6dQUBU/KAoAKSk0e8hijbRg72HuZVr7ebFEjWc5b+ZRB4i+Jp1szb9/k7nekEnjWqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wzRnwKJ+; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6505d147ce4so6264a12.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 12:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768769157; cv=none;
        d=google.com; s=arc-20240605;
        b=cFe1jprbSHtig8m+WaCuGVXnI0GDOVZwREhA6+SNCFC+RmI0QyMdldSyuIMqBsnhYL
         ulDXCc7WpIYpWvOJVvXgFkuMu9IePITfWQyXxYDUHwp/IQONnDKJ/HbWfZ/rubWsGhhn
         N/7CCNGjlwAr3/nrwERXw65gqCMJIz3TZXExIXUJmBLKT1Wpa/AhYUAoXxVQKrAYWlko
         BIIH+pQVTvsAB5tN1lhw8+y0E9OsP3v6jDg5+HNsEeZexInLlbl1E02GbdeC3/5yXeTN
         GOcZ5qm9o7A5J3X75L2uw++FrT1y40ObrUUqPeYhZLTYdlKgHtuZXDVIywA5sUgF5WUo
         J4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IJvJDVCfQGiQhTyEeyupPbB3kxPlJFu+RnX8pclHBaI=;
        fh=iYPKwqQSVVbZIxUNfWKGLq6f/Qgvi2fZPaYKB3vAHc0=;
        b=M2nHNcpK1ruJSoEZdyJI/jUUYQ+HbZN6wk2lkut3YL8EmQX8RWCa4D8kirNo4Eq6kl
         oNBrw8iRhai64tnmK/Sx2cUsHHoBttnB6RpZY5inRxIaBhp9pCmq9loZ3A6W++k4U0XX
         TftfOLkaVdSsvYmk7gWgGUN8eSN0q4JTPNuLrWrch2V0LoJsv0WLzdQSYbTGpJ7YfN6Y
         3863gzLYHpwi594zevXXHYOxgyOEp/bbtiBSylBnSDFjER739jBWfknRti+d/yydTtRM
         wwbetOUVCid38PB8DO/lNbsHrQm26l8RMzhpkgjNNynUoFaL9ivX/xkDdrUCYGOWzWUt
         Uouw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768769157; x=1769373957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJvJDVCfQGiQhTyEeyupPbB3kxPlJFu+RnX8pclHBaI=;
        b=wzRnwKJ+M367QSQ1O15gx1WoGHrqjhPeMqzqyuKnKTSE4jQdykijIIJQnD2t46KzNG
         RuDOeiIrW+nEaQmdJ8ST9acjZ9dBPFlXpo1W/I408OiWHUqP0P/JXApZlDShQdGx6pOF
         h2642tkfX8YKyO7e2BgxP4DOYnzSPT/P8EzJIYUHJvOBu1lb2R0pSXckHZG76hIUNLiE
         Anqjlgs3dPbOdLt4e51WnHzUZiEVnLMy8xA5M9h7KfH/I6A8+IuF8DwD9dQ30r+tmlYH
         BNRDyxdoJQWNr7QcLmso8KxGmB/FFk36ssyCUWwHaNrLrO+TFlusTDR1/w+HA+bwsvCv
         CJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768769157; x=1769373957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJvJDVCfQGiQhTyEeyupPbB3kxPlJFu+RnX8pclHBaI=;
        b=QETWFCDs8xZ4f3WMiAUirpVrGlSCAXd7ZBuqe5U28tHCze8U+ZdJShaKLxrLm+T/mI
         IjoJiFRLWVSi4mnfZS5HQU7rMzsW3HVHvdWSrqEvYGV3qZOrxjWeYT4tJ7oocr3jQmEx
         po6iR+BjHpjTtHMkw926cBN6aY9GybUuULEum3wJp54v9auUuiyVmNF+F1tcUL/69mRU
         5RdyLpBVbCG0ORjegbjQhIwmqATkyAYY+9Z46aoqgcULRfDPX/q9jyAL/mgyA7h2noMq
         ZnX+RBfUf/oGxszg1ay7HLvrO7bVL9M/YLogdSLsgysZB0EVf1AQbCiqGUrpuoZBpq7+
         Uung==
X-Forwarded-Encrypted: i=1; AJvYcCUkvS2ypv+g+9Sp/ElTBHApl2NraMOGFz4pZTZjMdHBzbezrxpTQNhxWdMVXTiG3mV4TUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ET/Qaq/FOwLexzB0atQO8shzCWDyA7nu6XjE7mf7xs9fHIrp
	D1lCgGlzGBQFS+oVB3JhcbG8njvlTzxwHB6zsnT/ib08j4JeZv2Afop3lR2I/KD5+0CRde/HPIW
	pPMbDwMnS2MIu7HItkZIre3VBrPo+TdImmAKpY933
X-Gm-Gg: AY/fxX7yyG7vocg6sk9JhcEeqEN8UeQ6iJIW+/4jjZJv96fllbFUO8G6zqeBlMFKHVQ
	6Y0TUWJM7rUgBXzL73RWkmbcr4zSq63SK0CdzI+Qat35QVtKoI9fX8TkON1+O9DDooNsPafK8oa
	Fgud7jeCpaq5DGK1hnjelyGFURv2x+b2jh7ZpWlLLYObVE+tHlOWVHXK9zM241a9voAs1gCy7dI
	r2KT5+2YDaMkFZcS0W0UhsL3MX2RyvfIhRJY8KjzDZd9W9Q9O89Rb4vr/EmDxLdZ8L0laVyWYbI
	wRD9mp4zDufTEK8pPDjgwyY=
X-Received: by 2002:a05:6402:b79:b0:650:5d5c:711c with SMTP id
 4fb4d7f45d1cf-6561ee75634mr22230a12.17.1768769156751; Sun, 18 Jan 2026
 12:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-7-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-7-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 18 Jan 2026 20:45:43 +0000
X-Gm-Features: AZwV_QiwVzd1b1HBHsztjRZ_PLBdReYsBX8Ibd28htOveyCZqKIEsBm2-CrYcsc
Message-ID: <CAJuCfpELoHBKSq=DyLPPtQwqL=nPaQ1cBD-sthJd64MbW40Bxw@mail.gmail.com>
Subject: Re: [PATCH v3 07/21] slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
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

On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Before we enable percpu sheaves for kmalloc caches, we need to make sure
> kmalloc_nolock() and kfree_nolock() will continue working properly and
> not spin when not allowed to.
>
> Percpu sheaves themselves use local_trylock() so they are already
> compatible. We just need to be careful with the barn->lock spin_lock.
> Pass a new allow_spin parameter where necessary to use
> spin_trylock_irqsave().
>
> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
> for now it will always fail until we enable sheaves for kmalloc caches
> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 79 ++++++++++++++++++++++++++++++++++++++++++++-------------=
------
>  1 file changed, 56 insertions(+), 23 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 706cb6398f05..b385247c219f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2893,7 +2893,8 @@ static void pcs_destroy(struct kmem_cache *s)
>         s->cpu_sheaves =3D NULL;
>  }
>
> -static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
> +static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
> +                                              bool allow_spin)
>  {
>         struct slab_sheaf *empty =3D NULL;
>         unsigned long flags;
> @@ -2901,7 +2902,10 @@ static struct slab_sheaf *barn_get_empty_sheaf(str=
uct node_barn *barn)
>         if (!data_race(barn->nr_empty))
>                 return NULL;
>
> -       spin_lock_irqsave(&barn->lock, flags);
> +       if (likely(allow_spin))
> +               spin_lock_irqsave(&barn->lock, flags);
> +       else if (!spin_trylock_irqsave(&barn->lock, flags))
> +               return NULL;
>
>         if (likely(barn->nr_empty)) {
>                 empty =3D list_first_entry(&barn->sheaves_empty,
> @@ -2978,7 +2982,8 @@ static struct slab_sheaf *barn_get_full_or_empty_sh=
eaf(struct node_barn *barn)
>   * change.
>   */
>  static struct slab_sheaf *
> -barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empt=
y)
> +barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empt=
y,
> +                        bool allow_spin)
>  {
>         struct slab_sheaf *full =3D NULL;
>         unsigned long flags;
> @@ -2986,7 +2991,10 @@ barn_replace_empty_sheaf(struct node_barn *barn, s=
truct slab_sheaf *empty)
>         if (!data_race(barn->nr_full))
>                 return NULL;
>
> -       spin_lock_irqsave(&barn->lock, flags);
> +       if (likely(allow_spin))
> +               spin_lock_irqsave(&barn->lock, flags);
> +       else if (!spin_trylock_irqsave(&barn->lock, flags))
> +               return NULL;
>
>         if (likely(barn->nr_full)) {
>                 full =3D list_first_entry(&barn->sheaves_full, struct sla=
b_sheaf,
> @@ -3007,7 +3015,8 @@ barn_replace_empty_sheaf(struct node_barn *barn, st=
ruct slab_sheaf *empty)
>   * barn. But if there are too many full sheaves, reject this with -E2BIG=
.
>   */
>  static struct slab_sheaf *
> -barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
> +barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full,
> +                       bool allow_spin)
>  {
>         struct slab_sheaf *empty;
>         unsigned long flags;
> @@ -3018,7 +3027,10 @@ barn_replace_full_sheaf(struct node_barn *barn, st=
ruct slab_sheaf *full)
>         if (!data_race(barn->nr_empty))
>                 return ERR_PTR(-ENOMEM);
>
> -       spin_lock_irqsave(&barn->lock, flags);
> +       if (likely(allow_spin))
> +               spin_lock_irqsave(&barn->lock, flags);
> +       else if (!spin_trylock_irqsave(&barn->lock, flags))
> +               return ERR_PTR(-EBUSY);
>
>         if (likely(barn->nr_empty)) {
>                 empty =3D list_first_entry(&barn->sheaves_empty, struct s=
lab_sheaf,
> @@ -5012,7 +5024,8 @@ __pcs_replace_empty_main(struct kmem_cache *s, stru=
ct slub_percpu_sheaves *pcs,
>                 return NULL;
>         }
>
> -       full =3D barn_replace_empty_sheaf(barn, pcs->main);
> +       full =3D barn_replace_empty_sheaf(barn, pcs->main,
> +                                       gfpflags_allow_spinning(gfp));
>
>         if (full) {
>                 stat(s, BARN_GET);
> @@ -5029,7 +5042,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, stru=
ct slub_percpu_sheaves *pcs,
>                         empty =3D pcs->spare;
>                         pcs->spare =3D NULL;
>                 } else {
> -                       empty =3D barn_get_empty_sheaf(barn);
> +                       empty =3D barn_get_empty_sheaf(barn, true);
>                 }
>         }
>
> @@ -5169,7 +5182,8 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gf=
p, int node)
>  }
>
>  static __fastpath_inline
> -unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void=
 **p)
> +unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t=
 size,
> +                                void **p)
>  {
>         struct slub_percpu_sheaves *pcs;
>         struct slab_sheaf *main;
> @@ -5203,7 +5217,8 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache =
*s, size_t size, void **p)
>                         return allocated;
>                 }
>
> -               full =3D barn_replace_empty_sheaf(barn, pcs->main);
> +               full =3D barn_replace_empty_sheaf(barn, pcs->main,
> +                                               gfpflags_allow_spinning(g=
fp));
>
>                 if (full) {
>                         stat(s, BARN_GET);
> @@ -5701,7 +5716,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_=
flags, int node)
>         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
>         struct kmem_cache *s;
>         bool can_retry =3D true;
> -       void *ret =3D ERR_PTR(-EBUSY);
> +       void *ret;
>
>         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
>                                       __GFP_NO_OBJ_EXT));
> @@ -5732,6 +5747,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp=
_flags, int node)
>                  */
>                 return NULL;
>
> +       ret =3D alloc_from_pcs(s, alloc_gfp, node);
> +       if (ret)
> +               goto success;
> +
> +       ret =3D ERR_PTR(-EBUSY);
> +
>         /*
>          * Do not call slab_alloc_node(), since trylock mode isn't
>          * compatible with slab_pre_alloc_hook/should_failslab and
> @@ -5768,6 +5789,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_=
flags, int node)
>                 ret =3D NULL;
>         }
>
> +success:
>         maybe_wipe_obj_freeptr(s, ret);
>         slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
>                              slab_want_init_on_alloc(alloc_gfp, s), size)=
;
> @@ -6088,7 +6110,8 @@ static void __pcs_install_empty_sheaf(struct kmem_c=
ache *s,
>   * unlocked.
>   */
>  static struct slub_percpu_sheaves *
> -__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves=
 *pcs)
> +__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves=
 *pcs,
> +                       bool allow_spin)
>  {
>         struct slab_sheaf *empty;
>         struct node_barn *barn;
> @@ -6112,7 +6135,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struc=
t slub_percpu_sheaves *pcs)
>         put_fail =3D false;
>
>         if (!pcs->spare) {
> -               empty =3D barn_get_empty_sheaf(barn);
> +               empty =3D barn_get_empty_sheaf(barn, allow_spin);
>                 if (empty) {
>                         pcs->spare =3D pcs->main;
>                         pcs->main =3D empty;
> @@ -6126,7 +6149,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struc=
t slub_percpu_sheaves *pcs)
>                 return pcs;
>         }
>
> -       empty =3D barn_replace_full_sheaf(barn, pcs->main);
> +       empty =3D barn_replace_full_sheaf(barn, pcs->main, allow_spin);
>
>         if (!IS_ERR(empty)) {
>                 stat(s, BARN_PUT);
> @@ -6134,7 +6157,8 @@ __pcs_replace_full_main(struct kmem_cache *s, struc=
t slub_percpu_sheaves *pcs)
>                 return pcs;
>         }
>
> -       if (PTR_ERR(empty) =3D=3D -E2BIG) {
> +       /* sheaf_flush_unused() doesn't support !allow_spin */
> +       if (PTR_ERR(empty) =3D=3D -E2BIG && allow_spin) {
>                 /* Since we got here, spare exists and is full */
>                 struct slab_sheaf *to_flush =3D pcs->spare;
>
> @@ -6159,6 +6183,14 @@ __pcs_replace_full_main(struct kmem_cache *s, stru=
ct slub_percpu_sheaves *pcs)
>  alloc_empty:
>         local_unlock(&s->cpu_sheaves->lock);
>
> +       /*
> +        * alloc_empty_sheaf() doesn't support !allow_spin and it's
> +        * easier to fall back to freeing directly without sheaves
> +        * than add the support (and to sheaf_flush_unused() above)
> +        */
> +       if (!allow_spin)
> +               return NULL;
> +
>         empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
>         if (empty)
>                 goto got_empty;
> @@ -6201,7 +6233,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struc=
t slub_percpu_sheaves *pcs)
>   * The object is expected to have passed slab_free_hook() already.
>   */
>  static __fastpath_inline
> -bool free_to_pcs(struct kmem_cache *s, void *object)
> +bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
>  {
>         struct slub_percpu_sheaves *pcs;
>
> @@ -6212,7 +6244,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object=
)
>
>         if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
>
> -               pcs =3D __pcs_replace_full_main(s, pcs);
> +               pcs =3D __pcs_replace_full_main(s, pcs, allow_spin);
>                 if (unlikely(!pcs))
>                         return false;
>         }
> @@ -6319,7 +6351,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *=
obj)
>                         goto fail;
>                 }
>
> -               empty =3D barn_get_empty_sheaf(barn);
> +               empty =3D barn_get_empty_sheaf(barn, true);
>
>                 if (empty) {
>                         pcs->rcu_free =3D empty;
> @@ -6437,7 +6469,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, =
size_t size, void **p)
>                 goto no_empty;
>
>         if (!pcs->spare) {
> -               empty =3D barn_get_empty_sheaf(barn);
> +               empty =3D barn_get_empty_sheaf(barn, true);
>                 if (!empty)
>                         goto no_empty;
>
> @@ -6451,7 +6483,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, =
size_t size, void **p)
>                 goto do_free;
>         }
>
> -       empty =3D barn_replace_full_sheaf(barn, pcs->main);
> +       empty =3D barn_replace_full_sheaf(barn, pcs->main, true);
>         if (IS_ERR(empty)) {
>                 stat(s, BARN_PUT_FAIL);
>                 goto no_empty;
> @@ -6703,7 +6735,7 @@ void slab_free(struct kmem_cache *s, struct slab *s=
lab, void *object,
>
>         if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa=
_mem_id())
>             && likely(!slab_test_pfmemalloc(slab))) {
> -               if (likely(free_to_pcs(s, object)))
> +               if (likely(free_to_pcs(s, object, true)))
>                         return;
>         }
>
> @@ -6964,7 +6996,8 @@ void kfree_nolock(const void *object)
>          * since kasan quarantine takes locks and not supported from NMI.
>          */
>         kasan_slab_free(s, x, false, false, /* skip quarantine */true);
> -       do_slab_free(s, slab, x, x, 0, _RET_IP_);
> +       if (!free_to_pcs(s, x, false))
> +               do_slab_free(s, slab, x, x, 0, _RET_IP_);
>  }
>  EXPORT_SYMBOL_GPL(kfree_nolock);
>
> @@ -7516,7 +7549,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache =
*s, gfp_t flags, size_t size,
>                 size--;
>         }
>
> -       i =3D alloc_from_pcs_bulk(s, size, p);
> +       i =3D alloc_from_pcs_bulk(s, flags, size, p);
>
>         if (i < size) {
>                 /*
>
> --
> 2.52.0
>

