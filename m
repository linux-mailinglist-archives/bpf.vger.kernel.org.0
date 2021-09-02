Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF383FE801
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 05:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhIBDbV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 23:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhIBDbV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 23:31:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A4C061575
        for <bpf@vger.kernel.org>; Wed,  1 Sep 2021 20:30:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a93so1121896ybi.1
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7/ejXC5gEjeebx93ybkLc6O8AlY+cDie8vLCwMNUEw=;
        b=FN5kRGjLOHFiDPviC6eKs9ouf1OFxtp2fS9Bnjxp3fNDTkLPIxUQwlAaNq1LYySsPQ
         bevrUyCgf6qy/Xuyzh8LmadlSlPJLO9DMFBNkwB6U1l+kKOGqflQDxmwk1EXh2VyYkmp
         b9PNY6pE7PN8jD7hcOA5vBEJGbRbIfx0eH4sL+n3HMytT4QSb4ZWoMByXHGWORrAOD/r
         PSy8HS3Qw9o3F4+j3SbphTA4wYiVPlgcdM3Vi2qmuhGjjduHq3VaHVoEkO1BFzkDs7Kj
         J/cNKrRZyvE9wVoY5Joy26A2VIKaHrrIKdnJwh8R4VL6qsmkAf8FwLaHBjsvTJwBYuZz
         jPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7/ejXC5gEjeebx93ybkLc6O8AlY+cDie8vLCwMNUEw=;
        b=XBiqxtZmomUAXVVBTuHdF/e7Ui+RXtaCP3GUjkjtY2NkYEYnDbDBh7CTG6qRfXHfrR
         HIDjDfaUcUcLHfC+NPgfpDeFeGjkPbJuY+96usqrNgmM0WRYabo8gJ7n4BwLR4IBU1h5
         hr8gl/qBkL2+at3u4x0oXLU+AFR6+9TRRWOI+m2geQ4YacmZqzOA2pisrU14Im11rxvT
         IiFt8c9E7nK0tYJx1+F40K6xhfc9aORRYl7yP2QslaQl3Tk78J5LZallJYmy84V3Gv4j
         dByHtX3smWvmR2waEZCwilI0i0sMsKtoItXXUrg3/04u+Oo9TqJOL70I2Rzr/stPnbpS
         5EUQ==
X-Gm-Message-State: AOAM5306JdYF7YFbuZUEjeCJLQyQoZ3JomRRE4djTl1Hs2JaMvB6acY0
        hMHDWBM/O0yoPaXDab5Vd4bO/h0CfMySmXxAGt358yFO
X-Google-Smtp-Source: ABdhPJxREygnpaqlH9kiSybeGIx9xoraywyWrtyQNMs1U6gfQCPJX++nGobmzev5GwUJv3yMkxuayNm0BvWQEh5enwo=
X-Received: by 2002:a25:1e03:: with SMTP id e3mr1469088ybe.459.1630553422641;
 Wed, 01 Sep 2021 20:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225005.2762202-1-joannekoong@fb.com> <20210831225005.2762202-3-joannekoong@fb.com>
In-Reply-To: <20210831225005.2762202-3-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Sep 2021 20:30:11 -0700
Message-ID: <CAEf4BzZFqyGE+rPtxW1obwCMkw+pvT3WL2_Anx4NPHCzk3SgvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: Allow the number of hashes in bloom
 filter maps to be configurable
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 3:51 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the libbpf infrastructure that will allow the user to
> specify the number of hash functions to use for the bloom filter map.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  tools/lib/bpf/bpf.c             |  2 ++
>  tools/lib/bpf/bpf.h             |  1 +
>  tools/lib/bpf/libbpf.c          | 32 +++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h          |  3 +++
>  tools/lib/bpf/libbpf.map        |  2 ++
>  tools/lib/bpf/libbpf_internal.h |  4 +++-
>  6 files changed, 42 insertions(+), 2 deletions(-)
>

[...]

>  __u32 bpf_map__key_size(const struct bpf_map *map)
>  {
>         return map->def.key_size;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index f177d897c5f7..497b84772be8 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -538,6 +538,9 @@ LIBBPF_API __u32 bpf_map__btf_value_type_id(const struct bpf_map *map);
>  /* get/set map if_index */
>  LIBBPF_API __u32 bpf_map__ifindex(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
> +/* get/set nr_hashes. used for bloom filter maps */
> +LIBBPF_API __u32 bpf_map__nr_hashes(const struct bpf_map *map);
> +LIBBPF_API int bpf_map__set_nr_hashes(struct bpf_map *map, __u32 nr_hashes);
>
>  typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
>  LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index bbc53bb25f68..372c2478274f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -385,4 +385,6 @@ LIBBPF_0.5.0 {
>                 btf__load_vmlinux_btf;
>                 btf_dump__dump_type_data;
>                 libbpf_set_strict_mode;
> +               bpf_map__nr_hashes;
> +               bpf_map__set_nr_hashes;

I'd really like to avoid this very niche and specific set of APIs. As
I mentioned on first patch, I think nr_hash can be easily passed
through map_flags property.

>  } LIBBPF_0.4.0;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 533b0211f40a..501ae042980d 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -171,8 +171,9 @@ enum map_def_parts {
>         MAP_DEF_NUMA_NODE       = 0x080,
>         MAP_DEF_PINNING         = 0x100,
>         MAP_DEF_INNER_MAP       = 0x200,
> +       MAP_DEF_NR_HASHES       = 0x400,
>
> -       MAP_DEF_ALL             = 0x3ff, /* combination of all above */
> +       MAP_DEF_ALL             = 0x7ff, /* combination of all above */
>  };
>
>  struct btf_map_def {
> @@ -186,6 +187,7 @@ struct btf_map_def {
>         __u32 map_flags;
>         __u32 numa_node;
>         __u32 pinning;
> +       __u32 nr_hashes; /* used for bloom filter maps */

we can't extend btf_map_def, it's fixed indefinitely

>  };
>
>  int parse_btf_map_def(const char *map_name, struct btf *btf,
> --
> 2.30.2
>
