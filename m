Return-Path: <bpf+bounces-48024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D51DA032AF
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974E73A149B
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10503145348;
	Mon,  6 Jan 2025 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeiIK4iC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C751372;
	Mon,  6 Jan 2025 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202271; cv=none; b=fqf+3nieZdJBUJVIHx3krwp60phjucXkfvh9zZg+iSo/G1X7nxC3R2UEmlSP1DtH23gH0+TIPw3NXDG8HhumD1S6HSo4E4pC3aJ4ZM5l0EazQ7L63kWI7Lf3OxdPYl/ZL4v9pDBUkN3c8tzlbyZHQu9GrWi0TQJHmflA8oLIvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202271; c=relaxed/simple;
	bh=/ctDcN9CIZKL1iOa/aSosQprVFC/Dj5ECj5GyixR09c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDGWWPE2ykI0xssxqM5GHeiblvCFODGbHHCNydo2GrBwcQ9OQvI+kZ6st/LQ9Ihsp8w572IonwSj9UmWwaTFZMls0W9C1g8h/7cr1CoUosQ/lDhLp5cKeIbGo5CFLUw5iKilGHnmYpWIRRvj4Am83ef/js8aU1aU2L/YI9D7K3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeiIK4iC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d6d5765so8724349f8f.3;
        Mon, 06 Jan 2025 14:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736202267; x=1736807067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yRii8cQYq4v6sojqxxPLQy7+tgIY3y0Gf7FEyS69kI=;
        b=GeiIK4iCo0tTngNKxiFRxyQsowj9uhmSWaFYyx9JpWgAMKW/PoRrT4OKLbN/o5saFs
         YUqcuTMBdP4t3iqmZUAo0vFHXF/GC4ehWbmegsLb6Ef/aO9gmZzKMFs53bgrZZGtVLGy
         48DHR65QpLUkar7XVqOz0GF2INoQjrU46fclRGne4AiIvOj+j5+6TQQkyodGZrFrlb/W
         ABPXdPuEGYyh/UzVlD++lgMvcG8LmxdHIG6VGK4IzeavsWXLNhDsfkiAJFPZU0svFtJD
         B2dXDQFm4LeQ2Df7BxGDwzKtjriCdd9dByyxvP2K0QMvIEnPjlJU6mn/vuQzSrV7kAOi
         mIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202267; x=1736807067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yRii8cQYq4v6sojqxxPLQy7+tgIY3y0Gf7FEyS69kI=;
        b=djuWDEkuKNRFLDmdMNsVzz4Y3aVhPDpe4MySP6qUV3oQT3JbZKSDllS4lkhtuDyfuJ
         uyZyZVk3r6QDMi4qxa4OUIhJM3MbVx0nwD9Iek5voVxirLyTBbPnZZQWvuZromo3l4Ev
         rXYHp0BlcKaOigFDEzEdj9QRbQEkSToX67Gq/RjnDzOWg28DgdyLf60IE/RKPSyO5/oj
         EE/69DMQpsk6H8c4fGn5FN3yTYm3eXfzlUPzA5R1p5GfxaPM1NGNLhh77wDHpGtpyKMK
         HNmpU6aIiMfYN2FTH/Ez7Jmvi0KIIZVtSeCMIHsjyGwZmTdaXgt9WXaarlXViVC/v7+G
         n3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+3uE4E3ojtL0y+BFc442F3hhtWWfBO4Bq484oDYGty1uICfqvRAyq7qBPAZPxq92qp3ptbno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQShCJiD2Ac/V+G/tTrPXvmo4TT3mScBDM0GOMwWAiOSnINCA
	EjhfoO9ZFXyARV+mYDJ8ZjT9uj1bOvGgNPR5vwnOnSWu7SmhVWOWj7Q/An246NFNLhetqcq6yxf
	TJFhAi07ZLzntzjvkGpU8RN0FYjDnoiXp
X-Gm-Gg: ASbGncvP+iToje56mmkFfAeTycraAzPLhm+B6MQEkZSnp0TiqhsmG4TQAF6JQUK/BsS
	4f68xFw5azHpgZnEaCovAasquf8kM1U3ITM69HA==
X-Google-Smtp-Source: AGHT+IEno07Jt/Xj4DMVKb7tly1unnhEtdA4e9b4MnTIlkbxpVwYKmBme2mLzWYbwoMwzMsd41dyP0tmC3mu8cRUy74=
X-Received: by 2002:a05:6000:1785:b0:385:fd07:85f8 with SMTP id
 ffacd0b85a97d-38a222003abmr49477353f8f.29.1736202266804; Mon, 06 Jan 2025
 14:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106081900.1665573-1-houtao@huaweicloud.com> <20250106081900.1665573-16-houtao@huaweicloud.com>
In-Reply-To: <20250106081900.1665573-16-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Jan 2025 14:24:15 -0800
X-Gm-Features: AbW1kvbvJnMwDk-gAARkKN7sUQGggnltjAFXaB6ixMT-ea06dpcFE-ljwO2gR60
Message-ID: <CAADnVQJzQ9ADqpCb7mcsQCU1enTdPH7XtZKkTHyY739sg62CzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 15/19] bpf: Disable migration before calling ops->map_free()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 12:07=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Disabling migration before calling ops->map_free() to simplify the
> freeing of map values or special fields allocated from bpf memory
> allocator.
>
> After disabling migration in bpf_map_free(), there is no need for
> additional migration_{disable|enable} pairs in the ->map_free()
> callbacks. Remove these redundant invocations.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/arraymap.c          | 2 --
>  kernel/bpf/bpf_local_storage.c | 2 --
>  kernel/bpf/hashtab.c           | 2 --
>  kernel/bpf/range_tree.c        | 2 --
>  kernel/bpf/syscall.c           | 8 +++++++-
>  5 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 451737493b17..eb28c0f219ee 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -455,7 +455,6 @@ static void array_map_free(struct bpf_map *map)
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         int i;
>
> -       migrate_disable();
>         if (!IS_ERR_OR_NULL(map->record)) {
>                 if (array->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)=
 {
>                         for (i =3D 0; i < array->map.max_entries; i++) {
> @@ -472,7 +471,6 @@ static void array_map_free(struct bpf_map *map)
>                                 bpf_obj_free_fields(map->record, array_ma=
p_elem_ptr(array, i));
>                 }
>         }
> -       migrate_enable();
>
>         if (array->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
>                 bpf_array_free_percpu(array);
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index b649cf736438..12cf6382175e 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -905,13 +905,11 @@ void bpf_local_storage_map_free(struct bpf_map *map=
,
>                 while ((selem =3D hlist_entry_safe(
>                                 rcu_dereference_raw(hlist_first_rcu(&b->l=
ist)),
>                                 struct bpf_local_storage_elem, map_node))=
) {
> -                       migrate_disable();
>                         if (busy_counter)
>                                 this_cpu_inc(*busy_counter);
>                         bpf_selem_unlink(selem, true);
>                         if (busy_counter)
>                                 this_cpu_dec(*busy_counter);
> -                       migrate_enable();
>                         cond_resched_rcu();
>                 }
>                 rcu_read_unlock();
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 8bf1ad326e02..6051f8a39fec 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1570,14 +1570,12 @@ static void htab_map_free(struct bpf_map *map)
>          * underneath and is responsible for waiting for callbacks to fin=
ish
>          * during bpf_mem_alloc_destroy().
>          */
> -       migrate_disable();
>         if (!htab_is_prealloc(htab)) {
>                 delete_all_elements(htab);
>         } else {
>                 htab_free_prealloced_fields(htab);
>                 prealloc_destroy(htab);
>         }
> -       migrate_enable();
>
>         bpf_map_free_elem_count(map);
>         free_percpu(htab->extra_elems);
> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 5bdf9aadca3a..37b80a23ae1a 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -259,9 +259,7 @@ void range_tree_destroy(struct range_tree *rt)
>
>         while ((rn =3D range_it_iter_first(rt, 0, -1U))) {
>                 range_it_remove(rn, rt);
> -               migrate_disable();
>                 bpf_mem_free(&bpf_global_ma, rn);
> -               migrate_enable();
>         }
>  }
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0503ce1916b6..e7a41abe4809 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -835,8 +835,14 @@ static void bpf_map_free(struct bpf_map *map)
>         struct btf_record *rec =3D map->record;
>         struct btf *btf =3D map->btf;
>
> -       /* implementation dependent freeing */
> +       /* implementation dependent freeing. Disabling migration to simpl=
ify
> +        * the free of values or special fields allocated from bpf memory
> +        * allocator.
> +        */
> +       migrate_disable();
>         map->ops->map_free(map);
> +       migrate_enable();
> +

I was about to comment on patches 10-13 that it's
better to do it in bpf_map_free(), but then I got to this patch.
All makes sense, but the patch breakdown is too fine grain.
Patches 10-13 introduce migrate pairs only to be deleted
in patch 15. Please squash them into one patch.

Also you mention in the cover letter:

> Considering the bpf-next CI is broken

What is this about?

The cant_migrate() additions throughout looks
a bit out of place. All that code doesn't care about migrations.
Only bpf_ma code does. Let's add it there instead?
The stack trace will tell us the caller anyway,
so no information lost.

Overall it looks great.

pw-bot: cr

