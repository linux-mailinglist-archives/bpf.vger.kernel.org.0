Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0CA301DB
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfE3S0Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 14:26:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44366 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfE3S0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 14:26:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id w187so4492828qkb.11;
        Thu, 30 May 2019 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4F8rpOYydEBteOrpJHUvf+ltyCvWepHpLkF2UiorwM=;
        b=RRkSK4IfvrJOfIwSjMgfplKYF7wdFEqbVZokEFKrsSgjxhxsqrXhbWdDEkHHg9z0+R
         fYgBk43pk0yhzGD0PhJb1ve5dR3i9GAsniDND86t5kU3i9MjfiN8/rZl3LzuqOpIRAYH
         X0lToH5zZcu6uNbkr6GpZIW42peuw1SacYN8h0alTmHFL+v3MK07EVhHlzQlbUBPNj5n
         xMW5GMOPToCAeTwyZ+fXlOWciYxhWxQsAodrlS3u3zpoAQvSQRBt4QvFzpJcWiH8pqxJ
         boWSoCZyYeXjqPrgfUd9XJJGfpi+Ks5gmHgJleX+kIpgbdObGIScjPsEmcfD6Og4vgv4
         dnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4F8rpOYydEBteOrpJHUvf+ltyCvWepHpLkF2UiorwM=;
        b=gQa7+FVZ3T38VFmkODQQj8qv/qsiXUtxK7oVf8dUJJMQMSBnZGkt9bhcH5v6lhdZos
         pncPS0WVIYc/eRmDvX2qej3gdP8CPCD9mQl5S2X7JOeBiS0JwpGdMeAh3VDt1ROxMkGS
         8RqOuUjxe864vAHY3uZtF4aFgRtbVu+pOBEuqHczNH9szmDFxQn2El89lgRGg/JY6hVA
         wnREwCR8r/mTsa7XgA/KlRvdCjB5VITCA/eoIUf8Xg+qF9zR945fSFDzyVARfePRiMf3
         iH5ZZ0QkFaSSxpk7YEv6bWC+5NFqWUxKkJ8IKQH1izu4OaneLnvaUvz7jNbLYSlAAiw4
         TRVw==
X-Gm-Message-State: APjAAAWftATB5kSAVjfh29JJPooMhwYltFom9TlfTEOXLoFn1vj44Z14
        0TKbYPuCKdfm6WG6gXWQoJxoGhTEDABkmC3VrTA=
X-Google-Smtp-Source: APXvYqwvh8h7SfCboFztJzuM3+QCUwc1Dzk8sGI8iZVjBaAM3c01ZJ7ar8ATunTMtOXppOU1D1YKjWaHfB58Gr1Hqvw=
X-Received: by 2002:a37:4e92:: with SMTP id c140mr4637203qkb.48.1559240783402;
 Thu, 30 May 2019 11:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190530010359.2499670-1-guro@fb.com> <20190530010359.2499670-2-guro@fb.com>
In-Reply-To: <20190530010359.2499670-2-guro@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 30 May 2019 11:26:12 -0700
Message-ID: <CAPhsuW6MxT51mqmkuyC87xCpsLm1cFpCXx7rCYdWL4TBzOsHqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: add memlock precharge check for cgroup_local_storage
To:     Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 29, 2019 at 6:05 PM Roman Gushchin <guro@fb.com> wrote:
>
> Cgroup local storage maps lack the memlock precharge check,
> which is performed before the memory allocation for
> most other bpf map types.
>
> Let's add it in order to unify all map types.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/bpf/local_storage.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 980e8f1f6cb5..e48302ecb389 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -272,6 +272,8 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  {
>         int numa_node = bpf_map_attr_numa_node(attr);
>         struct bpf_cgroup_storage_map *map;
> +       u32 pages;
> +       int ret;
>
>         if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
>                 return ERR_PTR(-EINVAL);
> @@ -290,13 +292,18 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>                 /* max_entries is not used and enforced to be 0 */
>                 return ERR_PTR(-EINVAL);
>
> +       pages = round_up(sizeof(struct bpf_cgroup_storage_map), PAGE_SIZE) >>
> +               PAGE_SHIFT;
> +       ret = bpf_map_precharge_memlock(pages);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +
>         map = kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
>                            __GFP_ZERO | GFP_USER, numa_node);
>         if (!map)
>                 return ERR_PTR(-ENOMEM);
>
> -       map->map.pages = round_up(sizeof(struct bpf_cgroup_storage_map),
> -                                 PAGE_SIZE) >> PAGE_SHIFT;
> +       map->map.pages = pages;
>
>         /* copy mandatory map attributes */
>         bpf_map_init_from_attr(&map->map, attr);
> --
> 2.20.1
>
