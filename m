Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F53595EA
	for <lists+bpf@lfdr.de>; Fri,  9 Apr 2021 08:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhDIG6N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Apr 2021 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhDIG6N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Apr 2021 02:58:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4AAC061760
        for <bpf@vger.kernel.org>; Thu,  8 Apr 2021 23:58:00 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j206so5444365ybj.11
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4+XnNi4UPkmmKiu0jhMiGC5S5slWHMAqnIyLHMf3gc=;
        b=e4UqK/hY/YHyu4vofXzqsbflHZ6Q3RbhqmsoNDui1TH9t6d5eFckx9iqZ1xf19wzrl
         shm2VT5UkiiArskDDWKxTs7UCQzZ3fhDDP/lVMRKVj9fmzxHBjqI1Evokh4dg5q7diq2
         ZFnVwDjWDsTeDzbHd5YdN3Fdg9WSeTwkqn/4tcrPLuZeY1qBgQiygolbNAEoe2oi494E
         Q5289qU2S+iFYOE+LHPNMB6epRdTBhvFgmk+epNgDTu2YAPh+mFlLnovCUo0OhYiBMma
         l0ZniAjrYpgtI4gJPkcYVuH0ANsJAHd2OFsqxIU2pOeAWZNs4ULXhAubSS7y/OsiDMA5
         d2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4+XnNi4UPkmmKiu0jhMiGC5S5slWHMAqnIyLHMf3gc=;
        b=QCaf6UDqgmVP4ZHdqbzPnoXFJRod/4WbK5r1SnWd98kG30wbYnJaUiOS9KciDtywDW
         In6kTAGP1a8tO2rQzDBL/Qn1Lj9tM3p2idNtqiPwQXOQBOb8bGNm1+XwhxGvPlutKQer
         dqB+IA8MtZDwzcGyIjh+gRnZAvN956YDilo/lHfvdJk3YS2YCzYeWeZjGvcfGmULFHWr
         +UOrHiAkc6B+cQUVCCTl7zzYwWfk6+VLBxJfjTEbEjFlhkjSv0QRdu4V8+AiloI+pAW1
         zqi6ALysRZo7RVZqo1SSn5344mzcFT7bg7I2G4On0SXw/yI1vNUscztfHDiJWoykmA/Q
         Z8LQ==
X-Gm-Message-State: AOAM532Hju4DnOTw0BRuOXNM2G9YVNMyego6bD+CEqfZoEPW2D/D53wO
        8axPMlMxKbjMqx4AiQAIYLpjLuXFxU1Rn6iOE0oxA+ip
X-Google-Smtp-Source: ABdhPJwvjYPcHa9s8hmo0ZZM54/VPwONNDlONuwiRF81WcmSWsk5ZZWvYtH4QnQv9kWf2/Xu8VNTeF/SwisZV7o8aQ0=
X-Received: by 2002:a25:9942:: with SMTP id n2mr16545844ybo.230.1617951479653;
 Thu, 08 Apr 2021 23:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com> <20210408061310.95877-7-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-7-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Apr 2021 23:57:22 -0700
Message-ID: <CAEf4BzZLaFLkhu6GMOzP9spyKNAJbKaLwnHUYX6EsyCy6kGKOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 7/9] libbpf: add bpf_map__inner_map API
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 11:14 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>
> The API gives access to inner map for map in map types (array or
> hash of map). It will be used to dynamically set max_entries in it.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c   | 10 ++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 12 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7aad78dbb4b4..ed5586cce227 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2194,6 +2194,7 @@ static int parse_btf_map_def(struct bpf_object *obj,
>                         map->inner_map = calloc(1, sizeof(*map->inner_map));
>                         if (!map->inner_map)
>                                 return -ENOMEM;
> +                       map->inner_map->fd = -1;
>                         map->inner_map->sec_idx = obj->efile.btf_maps_shndx;
>                         map->inner_map->name = malloc(strlen(map->name) +
>                                                       sizeof(".inner") + 1);
> @@ -3845,6 +3846,14 @@ __u32 bpf_map__max_entries(const struct bpf_map *map)
>         return map->def.max_entries;
>  }
>
> +struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
> +{
> +       if (!bpf_map_type__is_map_in_map(map->def.type))
> +               return NULL;
> +
> +       return map->inner_map;
> +}
> +
>  int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
>  {
>         if (map->fd >= 0)
> @@ -9476,6 +9485,7 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
>                 pr_warn("error: inner_map_fd already specified\n");
>                 return -EINVAL;
>         }
> +       zfree(&map->inner_map);
>         map->inner_map_fd = fd;
>         return 0;
>  }
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index f500621d28e5..bec4e6a6e31d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -480,6 +480,7 @@ LIBBPF_API int bpf_map__pin(struct bpf_map *map, const char *path);
>  LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
>
>  LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
> +LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
>
>  LIBBPF_API long libbpf_get_error(const void *ptr);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f5990f7208ce..9768daa75415 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -349,6 +349,7 @@ LIBBPF_0.3.0 {
>                 ring_buffer__epoll_fd;
>                 xsk_setup_xdp_prog;
>                 xsk_socket__update_xskmap;
> +               bpf_map__inner_map;

This is neither in the right version (should be in 0.4.0) nor is in
alphabetical order (despite cover letter saying otherwise).
But I've fixed it up while applying. Please be more careful next time.

>  } LIBBPF_0.2.0;
>
>  LIBBPF_0.4.0 {

> --
> 2.31.1
>
