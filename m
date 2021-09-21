Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAC413E2D
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 01:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhIUX7X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 19:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhIUX7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 19:59:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28DC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:57:54 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id p4so3638489qki.3
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UaumyxZQ8hgRJEqk5WO6fWE8FSyHrc/zxJatMcodpY=;
        b=SeA/ZmxFklQpIJLxNuKj8zOEtDm9d21FVb33Ify+spixiueVq9Rn+0Opvb/s7O9I+O
         qIrfwYZrhO+5PDzlpZ+CRBwueWhsWyNLndhduKW0uKm/QF3GhTlnvmLSKEEr9OoLOpPc
         HFPjNEbF07SBPR5wo12ys2uU1NRy1DVXSBoMR6J0dsgj3PwCL78yxJHkzP/+v3EDLdoy
         cav5R3yOpv3rj5DgqeJaZnt6FO+apeUStxDjQgKEjVc+5afiX/oe0cwnL6UzyrPbl4as
         5D3EprHcSZYfb11+FkGwYmaHTRCmb8cX0u334K1gbK1TdCgcWEBNrqvAIZTrDLgLLQz1
         L/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UaumyxZQ8hgRJEqk5WO6fWE8FSyHrc/zxJatMcodpY=;
        b=4r1bQuNVmIjzb1mOT7vamih8hzpslp9i8zL+NPf+eA5QYY27u1fBeOVaO3qXdXfP3F
         lr2xMlBdilfK5hxgNcLKWL/Run5U3eBOLc5dptji4KTf4ssP7fVFwNjYF+EgbLA1eC0r
         EpkwTfFjXtLZeioKe9UzKIlEQJ0Ke1SAEXDLBdOTPekA5nqC1tYIuR86Dxo4sweXAKyF
         bYR8wp1saBx6rEcVTch5v/5tDPNYN3B0LGW8mrK5MnFi7fU/5xp+X3AetnqFj+IaX3oY
         0WscZ5n55JhK4uWSj340XTD1x4uuYhtOgNd75f6onTxtQLsYRvRV7RkHRFIjAPV0/7xV
         wucQ==
X-Gm-Message-State: AOAM531HVPBQ5e4L/pBGKSe+80iJKle/Y9pQTVcwfULOy/XnoNM0QMWV
        tiO37IouYg+V8NFLamUqbND71mveNPlXRoiIsso=
X-Google-Smtp-Source: ABdhPJxagZHZN0Ie0ClOxz1aUBIrU/XsP+LI7xbfcfbaT22TxTtxAxkBiuqFjSF6DoBKlri2f9MUlTX7qPFo3pgjoi4=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr40005786ybp.51.1632268673775;
 Tue, 21 Sep 2021 16:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-1-joannekoong@fb.com> <20210921210225.4095056-3-joannekoong@fb.com>
In-Reply-To: <20210921210225.4095056-3-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 16:57:42 -0700
Message-ID: <CAEf4BzYb1FioqRXTGZY+v0ScRSv_5jYdx7KOz47FUjAru8maeQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/5] libbpf: Allow the number of hashes in
 bloom filter maps to be configurable
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 2:30 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the libbpf infrastructure that will allow the user to
> specify a configurable number of hash functions to use for the bloom
> filter map.
>
> Please note that this patch does not enforce that a pinned bloom filter
> map may only be reused if the number of hash functions is the same. If
> they are not the same, the number of hash functions used will be the one
> that was set for the pinned map.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  include/uapi/linux/bpf.h        |  5 ++++-
>  tools/include/uapi/linux/bpf.h  |  5 ++++-
>  tools/lib/bpf/bpf.c             |  2 ++
>  tools/lib/bpf/bpf.h             |  1 +
>  tools/lib/bpf/libbpf.c          | 32 +++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf.h          |  2 ++
>  tools/lib/bpf/libbpf.map        |  1 +
>  tools/lib/bpf/libbpf_internal.h |  4 +++-
>  8 files changed, 44 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fec9fcfe0629..2e3048488feb 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1262,7 +1262,10 @@ union bpf_attr {
>                 __u32   map_flags;      /* BPF_MAP_CREATE related
>                                          * flags defined above.
>                                          */
> -               __u32   inner_map_fd;   /* fd pointing to the inner map */
> +               union {
> +                       __u32   inner_map_fd;   /* fd pointing to the inner map */
> +                       __u32   nr_hash_funcs;  /* or number of hash functions */
> +               };
>                 __u32   numa_node;      /* numa node (effective only if
>                                          * BPF_F_NUMA_NODE is set).
>                                          */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index fec9fcfe0629..2e3048488feb 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1262,7 +1262,10 @@ union bpf_attr {
>                 __u32   map_flags;      /* BPF_MAP_CREATE related
>                                          * flags defined above.
>                                          */
> -               __u32   inner_map_fd;   /* fd pointing to the inner map */
> +               union {
> +                       __u32   inner_map_fd;   /* fd pointing to the inner map */
> +                       __u32   nr_hash_funcs;  /* or number of hash functions */
> +               };
>                 __u32   numa_node;      /* numa node (effective only if
>                                          * BPF_F_NUMA_NODE is set).
>                                          */

these changes should be part of patch 1, otherwise patch 1 leaves
kernel in non-compilable state and breaks bisection


> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 2401fad090c5..8a9dd4f6d6c8 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -100,6 +100,8 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
>         if (attr.map_type == BPF_MAP_TYPE_STRUCT_OPS)
>                 attr.btf_vmlinux_value_type_id =
>                         create_attr->btf_vmlinux_value_type_id;
> +       else if (attr.map_type == BPF_MAP_TYPE_BLOOM_FILTER)
> +               attr.nr_hash_funcs = create_attr->nr_hash_funcs;
>         else
>                 attr.inner_map_fd = create_attr->inner_map_fd;
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 6fffb3cdf39b..1194b6f01572 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -49,6 +49,7 @@ struct bpf_create_map_attr {
>         union {
>                 __u32 inner_map_fd;
>                 __u32 btf_vmlinux_value_type_id;
> +               __u32 nr_hash_funcs;
>         };
>  };
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index da65a1666a5e..e51e68a07aaf 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -378,6 +378,7 @@ struct bpf_map {
>         char *pin_path;
>         bool pinned;
>         bool reused;
> +       __u32 nr_hash_funcs;

nit: please keep it next to inner_map_fd field

>  };
>
>  enum extern_type {
> @@ -1291,6 +1292,11 @@ static bool bpf_map_type__is_map_in_map(enum bpf_map_type type)
>         return false;
>  }
>
> +static inline bool bpf_map__is_bloom_filter(const struct bpf_map *map)
> +{
> +       return map->def.type == BPF_MAP_TYPE_BLOOM_FILTER;
> +}

this is used in only one place, it's ok to just open-code it

> +
>  int bpf_object__section_size(const struct bpf_object *obj, const char *name,
>                              __u32 *size)
>  {

[...]

> @@ -8610,6 +8624,14 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
>         return 0;
>  }
>
> +int bpf_map__set_nr_hash_funcs(struct bpf_map *map, __u32 nr_hash_funcs)
> +{
> +       if (map->fd >= 0)
> +               return libbpf_err(-EBUSY);

should we disallow this for anything but BLOOM_FILTER?

> +       map->nr_hash_funcs = nr_hash_funcs;
> +       return 0;
> +}
> +
>  __u32 bpf_map__btf_key_type_id(const struct bpf_map *map)
>  {
>         return map ? map->btf_key_type_id : 0;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d0bedd673273..5c441744f766 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -550,6 +550,8 @@ LIBBPF_API __u32 bpf_map__btf_value_type_id(const struct bpf_map *map);
>  /* get/set map if_index */
>  LIBBPF_API __u32 bpf_map__ifindex(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
> +/* set nr_hash_funcs */
> +LIBBPF_API int bpf_map__set_nr_hash_funcs(struct bpf_map *map, __u32 nr_hash_funcs);

Let's not add this setter at all right now. Let's allow setting this
from BPF source code only in BTF map definition. It's unlikely anyone
would be setting the number of hash functions dynamically and I just
hate the idea of this one-off setter just for one specific map type.
We can always add it later if there really will be a need for that.

>
>  typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
>  LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,

[...]
