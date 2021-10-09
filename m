Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2286342759B
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 04:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhJICOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 22:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhJICOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 22:14:18 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5369CC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 19:12:21 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id w10so24899369ybt.4
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 19:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6gHcuZ4VdaKufqrV4hL91j7/LXUMrDZymKvIUQK/38=;
        b=kB6lMJhSgmO1OGQHSGsC2nS3qJOjehi/YqG4eGfRz6hHUwaNEGkP3J/Awcss+vFA8q
         BHBeJfbsrBf7rJYvl0O34sIObAdZ5Vfc8aOEeSB0oNMYZV/X9R+oflpVsSFu+VaosWnx
         ymoNdaLvpGDQrcq2dl+R38dV4pZI7lo5lrR7cDcDomfEU7D1O3D3d0hllROcHBFiNz5J
         d8AZBH5D8i1THyW981h8y13AkHZysizgHQUypSR93NR9kbVfADqfy6x7DXDh9ZvWrRYW
         f+ySTvFn5YPLhgSnxTXiCxFFukADWlMGNKRx/rJ1v8YQU8A9aHdVgyol4nhb3aZRFMus
         fCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6gHcuZ4VdaKufqrV4hL91j7/LXUMrDZymKvIUQK/38=;
        b=UiUNb/1BysRNso565K7ULmL0gO6bqc0CcIWjj2z9cL7GQet4r+wprSDYEyTDU6+GeN
         b0nji2ckKn+61UMcgeBV9jQj6x/BoJXJ9sKBPgDfuaq6mHZddL43zAo3ZY6AzQPXAo/Q
         HRZLW1p3/fN8xXJ/Vdc0/89j5nwsk2svwEdnPmCCbKkQ759UtNEgucQ0+FihxVHxYVa/
         y54aSyzyw3FXY9U6pBw+i1Xv0xbfURf0sflgHilINlwGaUNGmNeeTdpPwTlLlwdSz6cX
         sf2sERqRB4asSdLXD3DyDXVL/das/ycrO457DdETcKyMYDHaAYp4V6O71YVspCV13b8W
         dkmg==
X-Gm-Message-State: AOAM531IL0PxRgTb79oUMWcQjWdQ7BuMdg5/ODMBL8pEJ8tWL4UdT6Rp
        oMCx2YMUMVn00Og41q5ELAtwM156YD9LpNG2Rq5YFlz98I4=
X-Google-Smtp-Source: ABdhPJwXHGXHaKo4VrGVjY707R+h6IAXDl/M9oHWWE7RV1Z6sBkTcYGYmVNlwQEKpeqJNUJL3BHlF61njQHXS+O79oY=
X-Received: by 2002:a25:5606:: with SMTP id k6mr7197256ybb.51.1633745540404;
 Fri, 08 Oct 2021 19:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-3-joannekoong@fb.com>
In-Reply-To: <20211006222103.3631981-3-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 19:12:07 -0700
Message-ID: <CAEf4BzY01h7=TG665i=r32th7VxX181Dakhe=QvxLZBUNzeiZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] libbpf: Add "map_extra" as a per-map-type
 extra flag
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 3:27 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the libbpf infrastructure for supporting a
> per-map-type "map_extra" field, whose definition will be
> idiosyncratic depending on map type.
>
> For example, for the bitset map, the lower 4 bits of map_extra
> is used to denote the number of hash functions.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  include/uapi/linux/bpf.h        |  1 +
>  tools/include/uapi/linux/bpf.h  |  1 +
>  tools/lib/bpf/bpf.c             |  1 +
>  tools/lib/bpf/bpf.h             |  1 +
>  tools/lib/bpf/bpf_helpers.h     |  1 +
>  tools/lib/bpf/libbpf.c          | 25 ++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h          |  4 ++++
>  tools/lib/bpf/libbpf.map        |  2 ++
>  tools/lib/bpf/libbpf_internal.h |  4 +++-
>  9 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b40fa1a72a75..a6f225e9c95a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5639,6 +5639,7 @@ struct bpf_map_info {
>         __u32 btf_id;
>         __u32 btf_key_type_id;
>         __u32 btf_value_type_id;
> +       __u32 map_extra;
>  } __attribute__((aligned(8)));
>
>  struct bpf_btf_info {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index b40fa1a72a75..a6f225e9c95a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5639,6 +5639,7 @@ struct bpf_map_info {
>         __u32 btf_id;
>         __u32 btf_key_type_id;
>         __u32 btf_value_type_id;
> +       __u32 map_extra;
>  } __attribute__((aligned(8)));
>
>  struct bpf_btf_info {
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 7d1741ceaa32..41e3e85e7789 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -97,6 +97,7 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
>         attr.btf_key_type_id = create_attr->btf_key_type_id;
>         attr.btf_value_type_id = create_attr->btf_value_type_id;
>         attr.map_ifindex = create_attr->map_ifindex;
> +       attr.map_extra = create_attr->map_extra;
>         if (attr.map_type == BPF_MAP_TYPE_STRUCT_OPS)
>                 attr.btf_vmlinux_value_type_id =
>                         create_attr->btf_vmlinux_value_type_id;
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 6fffb3cdf39b..c4049f2d63cc 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -50,6 +50,7 @@ struct bpf_create_map_attr {
>                 __u32 inner_map_fd;
>                 __u32 btf_vmlinux_value_type_id;
>         };
> +       __u32 map_extra;

btw, I think it might be better to use __u64 for map_extra in kernel
UAPI for extensibility (e.g., some maps might specify that this is a
pointer to some extra data structure, just like we do for some types
of bpf_iter program types to specify extra parameters). In libbpf you
can't express entire 64  bits with __uint() macro, but eventually that
limitation might be raised separately.

>  };
>
>  LIBBPF_API int
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 963b1060d944..bce5a0090f3f 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -133,6 +133,7 @@ struct bpf_map_def {
>         unsigned int value_size;
>         unsigned int max_entries;
>         unsigned int map_flags;
> +       unsigned int map_extra;
>  };
>
>  enum libbpf_pin_type {
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ed313fd491bd..12a9ecd45a78 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2274,6 +2274,10 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
>                         }
>                         map_def->pinning = val;
>                         map_def->parts |= MAP_DEF_PINNING;
> +               } else if (strcmp(name, "map_extra") == 0) {
> +                       if (!get_map_field_int(map_name, btf, m, &map_def->map_extra))
> +                               return -EINVAL;
> +                       map_def->parts |= MAP_DEF_MAP_EXTRA;
>                 } else {
>                         if (strict) {
>                                 pr_warn("map '%s': unknown field '%s'.\n", map_name, name);
> @@ -2298,6 +2302,7 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
>         map->def.value_size = def->value_size;
>         map->def.max_entries = def->max_entries;
>         map->def.map_flags = def->map_flags;
> +       map->def.map_extra = def->map_extra;
>
>         map->numa_node = def->numa_node;
>         map->btf_key_type_id = def->key_type_id;
> @@ -2322,6 +2327,8 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
>                 pr_debug("map '%s': found max_entries = %u.\n", map->name, def->max_entries);
>         if (def->parts & MAP_DEF_MAP_FLAGS)
>                 pr_debug("map '%s': found map_flags = %u.\n", map->name, def->map_flags);
> +       if (def->parts & MAP_DEF_MAP_EXTRA)
> +               pr_debug("map '%s': found map_extra = %u.\n", map->name, def->map_extra);
>         if (def->parts & MAP_DEF_PINNING)
>                 pr_debug("map '%s': found pinning = %u.\n", map->name, def->pinning);
>         if (def->parts & MAP_DEF_NUMA_NODE)
> @@ -4017,6 +4024,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>         map->def.value_size = info.value_size;
>         map->def.max_entries = info.max_entries;
>         map->def.map_flags = info.map_flags;
> +       map->def.map_extra = info.map_extra;
>         map->btf_key_type_id = info.btf_key_type_id;
>         map->btf_value_type_id = info.btf_value_type_id;
>         map->reused = true;
> @@ -4534,7 +4542,8 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>                 map_info.key_size == map->def.key_size &&
>                 map_info.value_size == map->def.value_size &&
>                 map_info.max_entries == map->def.max_entries &&
> -               map_info.map_flags == map->def.map_flags);
> +               map_info.map_flags == map->def.map_flags &&
> +               map_info.map_extra == map->def.map_extra);
>  }
>
>  static int
> @@ -4631,6 +4640,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>         create_attr.key_size = def->key_size;
>         create_attr.value_size = def->value_size;
>         create_attr.numa_node = map->numa_node;
> +       create_attr.map_extra = def->map_extra;
>
>         if (def->type == BPF_MAP_TYPE_PERF_EVENT_ARRAY && !def->max_entries) {
>                 int nr_cpus;
> @@ -8637,6 +8647,19 @@ int bpf_map__set_map_flags(struct bpf_map *map, __u32 flags)
>         return 0;
>  }
>
> +__u32 bpf_map__map_extra(const struct bpf_map *map)
> +{
> +       return map->def.map_extra;
> +}
> +
> +int bpf_map__set_map_extra(struct bpf_map *map, __u32 map_extra)
> +{
> +       if (map->fd >= 0)
> +               return libbpf_err(-EBUSY);
> +       map->def.map_extra = map_extra;
> +       return 0;
> +}
> +
>  __u32 bpf_map__numa_node(const struct bpf_map *map)
>  {
>         return map->numa_node;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 89ca9c83ed4e..55e8dfe6f3e1 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -486,6 +486,7 @@ struct bpf_map_def {
>         unsigned int value_size;
>         unsigned int max_entries;
>         unsigned int map_flags;
> +       unsigned int map_extra;
>  };
>
>  /**
> @@ -562,6 +563,9 @@ LIBBPF_API __u32 bpf_map__btf_value_type_id(const struct bpf_map *map);
>  /* get/set map if_index */
>  LIBBPF_API __u32 bpf_map__ifindex(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
> +/* get/set map map_extra flags */
> +LIBBPF_API __u32 bpf_map__map_extra(const struct bpf_map *map);
> +LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u32 map_extra);
>
>  typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
>  LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f270d25e4af3..308378b3f20b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -395,4 +395,6 @@ LIBBPF_0.6.0 {
>                 bpf_object__prev_program;
>                 btf__add_btf;
>                 btf__add_tag;
> +               bpf_map__map_extra;
> +               bpf_map__set_map_extra;
>  } LIBBPF_0.5.0;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index f7fd3944d46d..188db854d9c2 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -193,8 +193,9 @@ enum map_def_parts {
>         MAP_DEF_NUMA_NODE       = 0x080,
>         MAP_DEF_PINNING         = 0x100,
>         MAP_DEF_INNER_MAP       = 0x200,
> +       MAP_DEF_MAP_EXTRA       = 0x400,
>
> -       MAP_DEF_ALL             = 0x3ff, /* combination of all above */
> +       MAP_DEF_ALL             = 0x7ff, /* combination of all above */
>  };
>
>  struct btf_map_def {
> @@ -208,6 +209,7 @@ struct btf_map_def {
>         __u32 map_flags;
>         __u32 numa_node;
>         __u32 pinning;
> +       __u32 map_extra;
>  };
>
>  int parse_btf_map_def(const char *map_name, struct btf *btf,
> --
> 2.30.2
>
