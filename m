Return-Path: <bpf+bounces-79657-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EG7N7zHb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79657-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:21:48 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3C495CC
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9F8258DB30
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315D3B8BB2;
	Tue, 20 Jan 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0iyZoiq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69353A7853
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929611; cv=pass; b=Kv+SnIitlFOG8WjhxiYPhszdY409UaS9K1+0M6Ces6xkH1LFMzDhjq2LEmjSxscOnF1huX8wxHUFWGY/V+Lj/jN1tu8l3xtvqEayLOZoTXLX2xykJm2KWKPM9t0LTcuc+D8pHTdIxDo/ttfFMegUT91G/s88ubtMXVzhBwYjt34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929611; c=relaxed/simple;
	bh=vmFE6Gem1lPQyoSciAtrzm28BM8NUKhCcyfRVDAVyfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkB1jywDwSExtvlCjDxDAwkzwpn5FVUSldQvtk7LwXMFvVrnDBCDbMdHIriOGyJi+fcAtD218U4xzh1RvY1tZxVR1QL0YJU9aVYi0U3tx7YEXG9MbXlEYQn7871+1xrkJgbqQA8aEC7Jf5P8RZKeZYq9vO+huxiNtntvAl3ipMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0iyZoiq; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014b5d8551so1543061cf.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:20:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768929608; cv=none;
        d=google.com; s=arc-20240605;
        b=jtT9e2pBIxDMPwKYWPDCgA79/h3xBtVL7aro18D6Dbs+HSpGlN+pIqjiS8bnCTHE5T
         SYl+Ai+LyhoHUFnCIit0wMSS99RlIG1HzMiGeQfzUD9/JUxtshMGZicbL5ODNgaBJiuv
         Mzf2BxFv4kBBDDrnUIDg8Hv47AqTVziCOp/qQFcrkCKyFvYIhUbo9swV2PSyMmuL8jpC
         8nPpsLxokRhwZxZzocTWBEX+UOploefp7TccgR2vJpAiXfP2p1/f250EId4DFWUm6l52
         PW9dk7sExNaWhW59GUOnYbg03gC0PAaNfZ8Hu06vlQCdf3dhi8RnzOn6e+wGpwm7ffDz
         dVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XjgInJxzHZA1FL2RVNq/kScJMYVHdTMpDmOcyNlB2Pg=;
        fh=UUUE/ApO2lJZs9LUYoA9/JmKAS4rCILjj56RnlnONbw=;
        b=ALmjEa0mI75IUad6yEL0PRYOJdw4I3K0D0ZVL2i1L9kgUPespDQVxVQozPtEjhZtTR
         E+c1SYHOek9/OihqJhIqTlbBNpdLIGnzqui2Y6UCsIcmr8Xf+ow54XV6L9GzcPS8cQlC
         13V+BSTAyCpLnT4kUWrj66x+GHMBgRzdkotngWM/gXNu932UrueVm76B+lEcz1JNoQIU
         1bSEhE8a0TipudzmxJAuzW/PbkaswvjifXWrit4jco2th5tdYyMqOBGyhViEjZ5zJUp3
         bGHn+25su6fsMtAjdhu50BgN6km7ALpCyKbzOTA4HMauDAHIPafe2cezLgGuajJYivZV
         2qhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768929608; x=1769534408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjgInJxzHZA1FL2RVNq/kScJMYVHdTMpDmOcyNlB2Pg=;
        b=J0iyZoiqOJ8a5+WWHruwqWIV6iNBVOMBLVa8+yXrZ/KqyegK5Gkz9J3rfhTPOmSg0P
         dU2pa4P10kae5AbjFRX4VhXO9LqycVd/sa8kPESigDKpPYR6RkHRMTr3Tf8fVV0hMr+3
         iNX4b4UX0BZ7H4qqQwm3HFEtKa3Pz7wLPS3ciZvsLUZuk20CF7lwIMPF+ZAU9MHyXvhS
         sRUaFrnmPqsFfA9jZ+x/K8yWothGmHG++hmJiIT8lrz4TCA+mFSpbOZOAs26Y1E6CbX8
         pHqTbJ1VWW3DV1wAZC/b/62pXIOeXH54nXsEXimEuaQVHJqF85LGxP64St14kzHvwbbN
         pGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929608; x=1769534408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XjgInJxzHZA1FL2RVNq/kScJMYVHdTMpDmOcyNlB2Pg=;
        b=LklZUCat5q6MwBlYo6Fug/87xX/F70AaVBOJMXuMbX4EJqN9lT26wDMGbcJqbSbQhQ
         YWv2zVkJ8ox3EmwbaiTk3oqx26ogzlnGddUHP13N6VqFekfwzRPOUxG1pEG3Xa0IRYAU
         QHfvqEzg03ytdl80gshSjTtR4feuH2gJOHvyDRk1pMMcOSqidj2oAwz4y9sOXiYhwxEO
         eNCSRgzMuzORpX7dpckKOph+1KwGh7G2sBm9vA5Gi77dzmFq7RDjwOfJnpFf8GOLpou4
         A3m/n7981ZXhlKWKQaWxw1nUL14z9eIcA2V8eMEVQuDYgjoYJ980Q6Uzid3p6iC+AWll
         y0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrfnUeX/HQJTy4U6n2Ac/nscQ3zK54Oxeuoaguv9XVfO+WmcAREfR/xd91tmhdQ35iJSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4T+i+TqkD3ZVhhUIs9aJmMVUwqrNDnuR5PmfcDHYIw4QanOg
	Xm5xksByNxEljlk8RtkAi9PLInhEg0Z/Wnew+5M0XoaFv3WM23pweSRQl9wlEmiQ0cmPK5yOY1r
	jzda/TB+A0SMWqIkMltVpcU6XRQrf6i9zUj/5Qwbi
X-Gm-Gg: AY/fxX78slW19V+NXrdfrr6FgLoNuV1az/6SR1I9wUg0fg82iEOLjRfXU2WihgARiaX
	GvYvRIqIyyR8vv6czpZs8AddtJHGeYfv9X7FY+ctJG2dpFCjH7W8Ea2bpcxwmqOsPoMJ9IVMZdW
	L/HZZuumq75aSteFsVB4Nul+3KptdWMtHfhywqxkL2bjfawlusYWc9OW1MEsuGQfts8mGap46tW
	XQlTfNMjSgUzlobHsMUtpn8AqLv9Io35IXkq7cEuagSAP/rLTXKE8Cdzd9+VQt9oTSptpJe4Fs8
	Lj5fJDUN3/lMyEI8vHAUnpghYRWcLnDz3g==
X-Received: by 2002:ac8:7f49:0:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-502b07275d9mr30014031cf.17.1768929607523; Tue, 20 Jan 2026
 09:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Jan 2026 17:19:56 +0000
X-Gm-Features: AZwV_Qi9JsdZs4u4zpyMKVEbr1yatFKMUCA5FvcV_dcEEUthHo8JPVRpfNJYn0g
Message-ID: <CAJuCfpErRjMi2aCCThHiS1F_LvaXjkVQvX9kJjqrpw8YnXoNBA@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial list
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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79657-lists,bpf=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,bpf@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[bpf];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: 3BF3C495CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> At this point we have sheaves enabled for all caches, but their refill
> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> slabs - now a redundant caching layer that we are about to remove.
>
> The refill will thus be done from slabs on the node partial list.
> Introduce new functions that can do that in an optimized way as it's
> easier than modifying the __kmem_cache_alloc_bulk() call chain.
>
> Extend struct partial_context so it can return a list of slabs from the
> partial list with the sum of free objects in them within the requested
> min and max.
>
> Introduce get_partial_node_bulk() that removes the slabs from freelist
> and returns them in the list.
>
> Introduce get_freelist_nofreeze() which grabs the freelist without
> freezing the slab.
>
> Introduce alloc_from_new_slab() which can allocate multiple objects from
> a newly allocated slab where we don't need to synchronize with freeing.
> In some aspects it's similar to alloc_single_from_new_slab() but assumes
> the cache is a non-debug one so it can avoid some actions.
>
> Introduce __refill_objects() that uses the functions above to fill an
> array of objects. It has to handle the possibility that the slabs will
> contain more objects that were requested, due to concurrent freeing of
> objects to those slabs. When no more slabs on partial lists are
> available, it will allocate new slabs. It is intended to be only used
> in context where spinning is allowed, so add a WARN_ON_ONCE check there.
>
> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> only refilled from contexts that allow spinning, or even blocking.
>

Some nits, but otherwise LGTM.
Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 264 insertions(+), 20 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 9bea8a65e510..dce80463f92c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -246,6 +246,9 @@ struct partial_context {
>         gfp_t flags;
>         unsigned int orig_size;
>         void *object;
> +       unsigned int min_objects;
> +       unsigned int max_objects;
> +       struct list_head slabs;
>  };
>
>  static inline bool kmem_cache_debug(struct kmem_cache *s)
> @@ -2650,9 +2653,9 @@ static void free_empty_sheaf(struct kmem_cache *s, =
struct slab_sheaf *sheaf)
>         stat(s, SHEAF_FREE);
>  }
>
> -static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> -                                  size_t size, void **p);
> -
> +static unsigned int
> +__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int=
 min,
> +                unsigned int max);
>
>  static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
>                          gfp_t gfp)
> @@ -2663,8 +2666,8 @@ static int refill_sheaf(struct kmem_cache *s, struc=
t slab_sheaf *sheaf,
>         if (!to_fill)
>                 return 0;
>
> -       filled =3D __kmem_cache_alloc_bulk(s, gfp, to_fill,
> -                                        &sheaf->objects[sheaf->size]);
> +       filled =3D __refill_objects(s, &sheaf->objects[sheaf->size], gfp,
> +                       to_fill, to_fill);
>
>         sheaf->size +=3D filled;
>
> @@ -3522,6 +3525,63 @@ static inline void put_cpu_partial(struct kmem_cac=
he *s, struct slab *slab,
>  #endif
>  static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
>
> +static bool get_partial_node_bulk(struct kmem_cache *s,
> +                                 struct kmem_cache_node *n,
> +                                 struct partial_context *pc)
> +{
> +       struct slab *slab, *slab2;
> +       unsigned int total_free =3D 0;
> +       unsigned long flags;
> +
> +       /* Racy check to avoid taking the lock unnecessarily. */
> +       if (!n || data_race(!n->nr_partial))
> +               return false;
> +
> +       INIT_LIST_HEAD(&pc->slabs);
> +
> +       spin_lock_irqsave(&n->list_lock, flags);
> +
> +       list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> +               struct freelist_counters flc;
> +               unsigned int slab_free;
> +
> +               if (!pfmemalloc_match(slab, pc->flags))
> +                       continue;
> +
> +               /*
> +                * determine the number of free objects in the slab racil=
y
> +                *
> +                * due to atomic updates done by a racing free we should =
not
> +                * read an inconsistent value here, but do a sanity check=
 anyway
> +                *
> +                * slab_free is a lower bound due to subsequent concurren=
t
> +                * freeing, the caller might get more objects than reques=
ted and
> +                * must deal with it
> +                */
> +               flc.counters =3D data_race(READ_ONCE(slab->counters));
> +               slab_free =3D flc.objects - flc.inuse;
> +
> +               if (unlikely(slab_free > oo_objects(s->oo)))
> +                       continue;
> +
> +               /* we have already min and this would get us over the max=
 */
> +               if (total_free >=3D pc->min_objects
> +                   && total_free + slab_free > pc->max_objects)
> +                       break;
> +
> +               remove_partial(n, slab);
> +
> +               list_add(&slab->slab_list, &pc->slabs);
> +
> +               total_free +=3D slab_free;
> +               if (total_free >=3D pc->max_objects)
> +                       break;

From the above code it seems like you are trying to get at least
pc->min_objects and as close as possible to the pc->max_objects
without exceeding it (with a possibility that we will exceed both
min_objects and max_objects in one step). Is that indeed the intent?
Because otherwise could could simplify these conditions to stop once
you crossed pc->min_objects.

> +       }
> +
> +       spin_unlock_irqrestore(&n->list_lock, flags);
> +       return total_free > 0;
> +}
> +
>  /*
>   * Try to allocate a partial slab from a specific node.
>   */
> @@ -4448,6 +4508,33 @@ static inline void *get_freelist(struct kmem_cache=
 *s, struct slab *slab)
>         return old.freelist;
>  }
>
> +/*
> + * Get the slab's freelist and do not freeze it.
> + *
> + * Assumes the slab is isolated from node partial list and not frozen.
> + *
> + * Assumes this is performed only for caches without debugging so we
> + * don't need to worry about adding the slab to the full list

nit: Missing a period sign at the end of the above sentence.

> + */
> +static inline void *get_freelist_nofreeze(struct kmem_cache *s, struct s=
lab *slab)

I was going to comment on similarities between
get_freelist_nofreeze(), get_freelist() and freeze_slab() and
possibility of consolidating them but then I saw you removing the
other functions in the next patch. So, I'm mentioning it here merely
for other reviewers not to trip on this.

> +{
> +       struct freelist_counters old, new;
> +
> +       do {
> +               old.freelist =3D slab->freelist;
> +               old.counters =3D slab->counters;
> +
> +               new.freelist =3D NULL;
> +               new.counters =3D old.counters;
> +               VM_WARN_ON_ONCE(new.frozen);
> +
> +               new.inuse =3D old.objects;
> +
> +       } while (!slab_update_freelist(s, slab, &old, &new, "get_freelist=
_nofreeze"));
> +
> +       return old.freelist;
> +}
> +
>  /*
>   * Freeze the partial slab and return the pointer to the freelist.
>   */
> @@ -4471,6 +4558,65 @@ static inline void *freeze_slab(struct kmem_cache =
*s, struct slab *slab)
>         return old.freelist;
>  }
>
> +/*
> + * If the object has been wiped upon free, make sure it's fully initiali=
zed by
> + * zeroing out freelist pointer.
> + *
> + * Note that we also wipe custom freelist pointers.
> + */
> +static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
> +                                                  void *obj)
> +{
> +       if (unlikely(slab_want_init_on_free(s)) && obj &&
> +           !freeptr_outside_object(s))
> +               memset((void *)((char *)kasan_reset_tag(obj) + s->offset)=
,
> +                       0, sizeof(void *));
> +}
> +
> +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct sla=
b *slab,
> +               void **p, unsigned int count, bool allow_spin)
> +{
> +       unsigned int allocated =3D 0;
> +       struct kmem_cache_node *n;
> +       unsigned long flags;
> +       void *object;
> +
> +       if (!allow_spin && (slab->objects - slab->inuse) > count) {
> +
> +               n =3D get_node(s, slab_nid(slab));
> +
> +               if (!spin_trylock_irqsave(&n->list_lock, flags)) {
> +                       /* Unlucky, discard newly allocated slab */
> +                       defer_deactivate_slab(slab, NULL);
> +                       return 0;
> +               }
> +       }
> +
> +       object =3D slab->freelist;
> +       while (object && allocated < count) {
> +               p[allocated] =3D object;
> +               object =3D get_freepointer(s, object);
> +               maybe_wipe_obj_freeptr(s, p[allocated]);
> +
> +               slab->inuse++;
> +               allocated++;
> +       }
> +       slab->freelist =3D object;
> +
> +       if (slab->freelist) {

nit: It's a bit subtle that the checks for slab->freelist here and the
earlier one for ((slab->objects - slab->inuse) > count) are
effectively equivalent. That's because this is a new slab and objects
can't be freed into it concurrently. I would feel better if both
checks were explicitly the same, like having "bool extra_objs =3D
(slab->objects - slab->inuse) > count;" and use it for both checks.
But this is minor, so feel free to ignore.

> +
> +               if (allow_spin) {
> +                       n =3D get_node(s, slab_nid(slab));
> +                       spin_lock_irqsave(&n->list_lock, flags);
> +               }
> +               add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +               spin_unlock_irqrestore(&n->list_lock, flags);
> +       }
> +
> +       inc_slabs_node(s, slab_nid(slab), slab->objects);
> +       return allocated;
> +}
> +
>  /*
>   * Slow path. The lockless freelist is empty or we need to perform
>   * debugging duties.
> @@ -4913,21 +5059,6 @@ static __always_inline void *__slab_alloc_node(str=
uct kmem_cache *s,
>         return object;
>  }
>
> -/*
> - * If the object has been wiped upon free, make sure it's fully initiali=
zed by
> - * zeroing out freelist pointer.
> - *
> - * Note that we also wipe custom freelist pointers.
> - */
> -static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
> -                                                  void *obj)
> -{
> -       if (unlikely(slab_want_init_on_free(s)) && obj &&
> -           !freeptr_outside_object(s))
> -               memset((void *)((char *)kasan_reset_tag(obj) + s->offset)=
,
> -                       0, sizeof(void *));
> -}
> -
>  static __fastpath_inline
>  struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags=
)
>  {
> @@ -5388,6 +5519,9 @@ static int __prefill_sheaf_pfmemalloc(struct kmem_c=
ache *s,
>         return ret;
>  }
>
> +static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> +                                  size_t size, void **p);
> +
>  /*
>   * returns a sheaf that has at least the requested size
>   * when prefilling is needed, do so with given gfp flags
> @@ -7463,6 +7597,116 @@ void kmem_cache_free_bulk(struct kmem_cache *s, s=
ize_t size, void **p)
>  }
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
>
> +static unsigned int
> +__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int=
 min,
> +                unsigned int max)
> +{
> +       struct slab *slab, *slab2;
> +       struct partial_context pc;
> +       unsigned int refilled =3D 0;
> +       unsigned long flags;
> +       void *object;
> +       int node;
> +
> +       pc.flags =3D gfp;
> +       pc.min_objects =3D min;
> +       pc.max_objects =3D max;
> +
> +       node =3D numa_mem_id();
> +
> +       if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> +               return 0;
> +
> +       /* TODO: consider also other nodes? */
> +       if (!get_partial_node_bulk(s, get_node(s, node), &pc))
> +               goto new_slab;
> +
> +       list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> +
> +               list_del(&slab->slab_list);
> +
> +               object =3D get_freelist_nofreeze(s, slab);
> +
> +               while (object && refilled < max) {
> +                       p[refilled] =3D object;
> +                       object =3D get_freepointer(s, object);
> +                       maybe_wipe_obj_freeptr(s, p[refilled]);
> +
> +                       refilled++;
> +               }
> +
> +               /*
> +                * Freelist had more objects than we can accommodate, we =
need to
> +                * free them back. We can treat it like a detached freeli=
st, just
> +                * need to find the tail object.
> +                */
> +               if (unlikely(object)) {
> +                       void *head =3D object;
> +                       void *tail;
> +                       int cnt =3D 0;
> +
> +                       do {
> +                               tail =3D object;
> +                               cnt++;
> +                               object =3D get_freepointer(s, object);
> +                       } while (object);
> +                       do_slab_free(s, slab, head, tail, cnt, _RET_IP_);
> +               }
> +
> +               if (refilled >=3D max)
> +                       break;
> +       }
> +
> +       if (unlikely(!list_empty(&pc.slabs))) {
> +               struct kmem_cache_node *n =3D get_node(s, node);
> +
> +               spin_lock_irqsave(&n->list_lock, flags);
> +
> +               list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_lis=
t) {
> +
> +                       if (unlikely(!slab->inuse && n->nr_partial >=3D s=
->min_partial))
> +                               continue;
> +
> +                       list_del(&slab->slab_list);
> +                       add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +               }
> +
> +               spin_unlock_irqrestore(&n->list_lock, flags);
> +
> +               /* any slabs left are completely free and for discard */
> +               list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_lis=
t) {
> +
> +                       list_del(&slab->slab_list);
> +                       discard_slab(s, slab);
> +               }
> +       }
> +
> +
> +       if (likely(refilled >=3D min))
> +               goto out;
> +
> +new_slab:
> +
> +       slab =3D new_slab(s, pc.flags, node);
> +       if (!slab)
> +               goto out;
> +
> +       stat(s, ALLOC_SLAB);
> +
> +       /*
> +        * TODO: possible optimization - if we know we will consume the w=
hole
> +        * slab we might skip creating the freelist?
> +        */
> +       refilled +=3D alloc_from_new_slab(s, slab, p + refilled, max - re=
filled,
> +                                       /* allow_spin =3D */ true);
> +
> +       if (refilled < min)
> +               goto new_slab;

Ok, allow_spin=3Dtrue saves us from a potential infinite loop here. LGTM.

> +out:
> +
> +       return refilled;
> +}
> +
>  static inline
>  int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t si=
ze,
>                             void **p)
>
> --
> 2.52.0
>

