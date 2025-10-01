Return-Path: <bpf+bounces-70115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D0BB14F8
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C452B3A6628
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAD3286892;
	Wed,  1 Oct 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcnLykDJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2934BA40
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338044; cv=none; b=Lo3ui9ScXlx8hS1GBZOYMb6eP5GVr5oS2Zl8vFW6n1hTy8v8aCAhYs8K6/99n9xImqQxaUKXJ6uim6GJEhb0x8YtJDlTFYMRwzyfGA77Yg5NqnSerPyMoJmlA9W7xwrfKkGyjUfseE+P8+v3YPICn9ufyyQgE9nCkpReZECGLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338044; c=relaxed/simple;
	bh=mJl6+m/Zw8g15t9bJ/Hue4alqPBIEe5yNop51q+QCvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1Z17LtUgMu78WR8MIXW2GDt6e7D0u6fU3wxb1AYEwyQhl1HeOzIUAD7o/Dx2ibKVGSJgIqimuir4+lCPcFYg33rv0/+IpBgUBj1c5wtpxanPD04T3OHnvlmep6s2t4RD84L965if65fAdIg54z7MpjBlP6Cm55gSItrySuZvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcnLykDJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b58445361e8so1224225a12.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759338042; x=1759942842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8bSmxtZdJkzZvlA+jK0ccSD9nViRyIB4PzQzDnj2fM=;
        b=TcnLykDJNegNODTmlBMCRkyjUgRQvVQiAzdzcm+CkcHVCHxgi8DJH2Dh5FJ0Pd7z2Y
         rjUuUcWRZcsp7W7snzTG3VhehBf0BgRIlU52ZO0qyF4QLea3MI9OavaG/swdnZ7mvSF6
         eEL5fM5nR5ylANbruZQU5jKLvDzdcJl22LfsuVXS5ItIsUS8wCx3T8Tltt5UPGCGaRGt
         nOf3bg45taKaMMAM2x93iqBiKxibMO+kQkDWOtuWsICdwUKjQaR/GI1bhb6lVURsvYkC
         C7AaOw1kYLcMsVIuBdy+VmHZrcs8Of2OkZ2iy57CFpV/VUy4SBcL7v9iIFFXrC2fCqKH
         l+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759338042; x=1759942842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8bSmxtZdJkzZvlA+jK0ccSD9nViRyIB4PzQzDnj2fM=;
        b=YUKH4ZbKATQE7fll70hH3w/p+6HDThAC3qEuTBkzT7WkUTgmL6/1J/iQGUsXOm4KUv
         5GKzCUzr+zZ45Fhg1fP9B6v1/M5YGqytM89zcplcTHxZSSBuslZZimJ1nWymajtrlFAy
         Vo4044iaHwKcH4qykEA5eWnazZiRP/jONyXZdKUUvHYpADN3YrCjOQTqZXwDMfGT49Db
         RxbCZVGAVnKAYxiCdFKEiB2/4Dv4cb5EBGKDC5cHxbi5v40xlRsiNBFZXLv5gzTlXZFH
         9CcfRkrlMwLAuPIaagynx96So2u1C2RIlz4hzuLDQv07CG6LKrnHWWes7nRmZB89jj7D
         kXaw==
X-Gm-Message-State: AOJu0YxCcxgYseTxoNuIaBr6jRODMRrbwZtObNeUY8dUDMKKxAYCeaVb
	0DoOfhR+aA5+zVWFvsJXdOMWjR+s/sL5yyE537zpWLnm7fkX/lqJyMHv7RXqtD7PIGAiN/pYUB+
	VxuiiEP6wrHa34B9yhoCXLNT8NNk9shk=
X-Gm-Gg: ASbGncuF4zJAzDBCv8zK5R3aett+W++KjBnsdKPd0OnNMGehFwzRfwNV2cP5q+4JG9H
	M0fQMRNNZMKsoGiGkLqWzyUasj0drmkM9r9/wtxE+1xdT4vc4JvMYGNQP6N2rY40XDXk+Kp66DC
	DSjHzXpKi16EnnqEpHhCBYDczlrlgvdbmCgm0eWfHu6pCKRh8emIb2DjESNyHGecwR0VhqdG29g
	AJxRzl1IGTHxNWOtlGdjbmi/mlcN1uYKCnyVBSpQh6b1U2Juwjcmxxzxw==
X-Google-Smtp-Source: AGHT+IGWvFL/ziy9PhvEx4jQ+x8gDybcg8IHHxaNvgw+BQYnVG6/2JDcJtp9ZC9xBuWGcesG83U+qF0UJbCrMo9R1JM=
X-Received: by 2002:a17:903:1b4e:b0:271:9b0e:54c7 with SMTP id
 d9443c01a7336-28e8d0390f5mr3547085ad.11.1759338041960; Wed, 01 Oct 2025
 10:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com> <20251001132252.385398-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251001132252.385398-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Oct 2025 10:00:26 -0700
X-Gm-Features: AS18NWDWd85iQ3iMn_dHK51DGyuS824FmKi3dP4mOHw9eqIYo62gnZGBJ923sAQ
Message-ID: <CAEf4BzbK9cY+Oqn265uyzKSBWjy6rFRwUheMwZBJUeeuGGDrhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: extract internal structs helpers
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:23=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> arraymap and hashtab duplicate the logic that checks for and frees
> internal structs (timer, workqueue, task_work) based on
> BTF record flags. Centralize this by introducing two helpers:
>
>   * bpf_map_has_internal_structs(map)
>     Returns true if the map value contains any of internal structs:
>     BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK.
>
>   * bpf_map_free_internal_structs(map, obj)
>     Frees the internal structs for a single value object.
>
> Convert arraymap and both the prealloc/malloc hashtab paths to use the
> new generic functions. This keeps the functionality for when/how to free
> these special fields in one place and makes it easier to add support for
> new internal structs in the future without touching every map
> implementation.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h   |  4 ++++
>  kernel/bpf/arraymap.c | 17 ++++++----------
>  kernel/bpf/hashtab.c  | 45 ++++++++++++++++++++++++-------------------
>  3 files changed, 35 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a98c83346134..3f7525f5c436 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -663,6 +663,10 @@ int map_check_no_btf(const struct bpf_map *map,
>  bool bpf_map_meta_equal(const struct bpf_map *meta0,
>                         const struct bpf_map *meta1);
>
> +bool bpf_map_has_internal_structs(struct bpf_map *map);
> +
> +void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
> +
>  extern const struct bpf_map_ops bpf_map_offload_ops;
>
>  /* bpf_type_flag contains a set of flags that are applicable to the valu=
es of
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 80b1765a3159..bfde60402fd5 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -448,19 +448,14 @@ static void array_map_free_internal_structs(struct =
bpf_map *map)
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         int i;
>
> -       /* We don't reset or free fields other than timer and workqueue
> +       /* We don't reset or free fields other than timer, workqueue and =
task_work
>          * on uref dropping to zero.
>          */
> -       if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE |=
 BPF_TASK_WORK)) {
> -               for (i =3D 0; i < array->map.max_entries; i++) {
> -                       if (btf_record_has_field(map->record, BPF_TIMER))
> -                               bpf_obj_free_timer(map->record, array_map=
_elem_ptr(array, i));
> -                       if (btf_record_has_field(map->record, BPF_WORKQUE=
UE))
> -                               bpf_obj_free_workqueue(map->record, array=
_map_elem_ptr(array, i));
> -                       if (btf_record_has_field(map->record, BPF_TASK_WO=
RK))
> -                               bpf_obj_free_task_work(map->record, array=
_map_elem_ptr(array, i));
> -               }
> -       }
> +       if (!bpf_map_has_internal_structs(map))
> +               return;
> +
> +       for (i =3D 0; i < array->map.max_entries; i++)
> +               bpf_map_free_internal_structs(map, array_map_elem_ptr(arr=
ay, i));
>  }
>
>  /* Called when map->refcnt goes to zero, either from workqueue or from s=
yscall */
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c2fcd0cd51e5..40936dec0402 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -215,17 +215,19 @@ static bool htab_has_extra_elems(struct bpf_htab *h=
tab)
>         return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab=
(htab);
>  }
>
> -static void htab_free_internal_structs(struct bpf_htab *htab, struct hta=
b_elem *elem)
> +bool bpf_map_has_internal_structs(struct bpf_map *map)
>  {
> -       if (btf_record_has_field(htab->map.record, BPF_TIMER))
> -               bpf_obj_free_timer(htab->map.record,
> -                                  htab_elem_value(elem, htab->map.key_si=
ze));
> -       if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
> -               bpf_obj_free_workqueue(htab->map.record,
> -                                      htab_elem_value(elem, htab->map.ke=
y_size));
> -       if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
> -               bpf_obj_free_task_work(htab->map.record,
> -                                      htab_elem_value(elem, htab->map.ke=
y_size));
> +       return btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEU=
E | BPF_TASK_WORK);
> +}

make this static inline and put into include/linux/btf.h to keep this check=
 fast

> +
> +void bpf_map_free_internal_structs(struct bpf_map *map, void *obj)

I'd try to make it clearer that we are working with map value, so obj
-> val, and maybe name this bpf_map_value_free_internal_structs

(though we probably want to come up with shorter name for this
concept, "internal_structs" is quite verbose, but I don't have a great
suggestion)


Also, let's move this to kernel/bpf/helpers.c, it doesn't make sense
to keep this in hashtab.c

> +{
> +       if (btf_record_has_field(map->record, BPF_TIMER))
> +               bpf_obj_free_timer(map->record, obj);
> +       else if (btf_record_has_field(map->record, BPF_WORKQUEUE))
> +               bpf_obj_free_workqueue(map->record, obj);
> +       else if (btf_record_has_field(map->record, BPF_TASK_WORK))
> +               bpf_obj_free_task_work(map->record, obj);

why elses? all of them can be present (and let's add a test that verifies t=
hat)

pw-bot: cr


>  }
>
>  static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
> @@ -240,7 +242,8 @@ static void htab_free_prealloced_internal_structs(str=
uct bpf_htab *htab)
>                 struct htab_elem *elem;
>
>                 elem =3D get_htab_elem(htab, i);
> -               htab_free_internal_structs(htab, elem);
> +               bpf_map_free_internal_structs(&htab->map,
> +                                             htab_elem_value(elem, htab-=
>map.key_size));
>                 cond_resched();
>         }
>  }
> @@ -1509,8 +1512,9 @@ static void htab_free_malloced_internal_structs(str=
uct bpf_htab *htab)
>                 struct htab_elem *l;
>
>                 hlist_nulls_for_each_entry(l, n, head, hash_node) {
> -                       /* We only free timer on uref dropping to zero */
> -                       htab_free_internal_structs(htab, l);
> +                       /* We only free timer, wq, task_work on uref drop=
ping to zero */

not sure it makes sense to keep listing all possible special structs
we are freeing, maybe just make a generic comment and whoever needs to
know exactly can always check implementation of
bpf_map_free_internal_structs? (there was another comment like that
earlier, I'd generalize it as well)

> +                       bpf_map_free_internal_structs(&htab->map,
> +                                                     htab_elem_value(l, =
htab->map.key_size));
>                 }
>                 cond_resched_rcu();
>         }
> @@ -1521,13 +1525,14 @@ static void htab_map_free_internal_structs(struct=
 bpf_map *map)
>  {
>         struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
>
> -       /* We only free timer and workqueue on uref dropping to zero */
> -       if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQU=
EUE | BPF_TASK_WORK)) {
> -               if (!htab_is_prealloc(htab))
> -                       htab_free_malloced_internal_structs(htab);
> -               else
> -                       htab_free_prealloced_internal_structs(htab);
> -       }
> +       /* We only free timer, workqueue, task_work on uref dropping to z=
ero */
> +       if (!bpf_map_has_internal_structs(map))
> +               return;
> +
> +       if (htab_is_prealloc(htab))
> +               htab_free_prealloced_internal_structs(htab);
> +       else
> +               htab_free_malloced_internal_structs(htab);
>  }
>
>  /* Called when map->refcnt goes to zero, either from workqueue or from s=
yscall */
> --
> 2.51.0
>

