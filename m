Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED93506B1
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhCaSsn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 14:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhCaSs1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 14:48:27 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FBC061574
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 11:48:27 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a143so22234805ybg.7
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzXwTqaCsjNr5R9cHtOcIFzO+e5/2EeDyvGIAoWicuE=;
        b=i3j3yuTJuOdjC+VAAv7q7LLZYwzRdZXDNfJ0gmAaV5bEM3B+gOU2pdCGisYs3S9JVd
         zK6lwtnMY8LvLpfTdNk48BNPkt7ea0nFVLrXY+UsxeOBYv+iSmPglSZX+6WwcvAem4HY
         Y10C1U9tCjiWMj6G0envyp0dGxRvYtKcOh3EBTRuOzdSoXXv0qDpRHzYsNh7xFGn90Gl
         j2bpQ8+aeWM8UAW6h7lffjHmmiznyLgqLfuEYdp6EbyD5OUdHGrb1c5K84+iwObRjb2t
         OAH/4zVzi0iU9kyFI83hVplAoNVAmX8n2uWNWUff77hvSt+BD07m16I5WRk9WznLICOR
         YUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzXwTqaCsjNr5R9cHtOcIFzO+e5/2EeDyvGIAoWicuE=;
        b=CzqoOssSqVtzCtoza717pzNwTyCJT0gS3A9mk4ZiZeMqPskUJ/W1PiTdDojgPfqNQO
         DTQOx6JroEujcN/bUCPJ1u4vFKuhsl0WFzVfTpn+1/dxIbLqYrYBeqGbT1ahOFLB4EhG
         j2aqO8G3mUVmu3t/8VgYYEpz58McgUFyR+nLowj0Zh69mQXABQlBP9NVmEPuz3EwdfoT
         ANgfBsgFvOxBgKM9wVAdK34gdawTkezF6ir2EoV7QvwbIE0/1yMIIRlEKNL8sD4KzaHA
         WlgwdUbXqAsm7huQGBaLiuxLCpNX7HnSVTlJiRlDm1+XMN7AAitq/Nxp5h9IQ+2VUdh1
         7gzQ==
X-Gm-Message-State: AOAM532APG0TN7V2iHEYrHDr0QS80ZrUk8i0erPhrr0hlvjMqRafq/nH
        J5ZfRpdbJL2/ndfbWrm8R339+efQZj/DO91v5Bb+nEEJ
X-Google-Smtp-Source: ABdhPJyMVuGezhNGI30Cf8bcuTllALgG43t/GfEmb1oKBdIo2fyggioXioH7pq051Cvxd6tBURA1ntD16roEa8eJ8FE=
X-Received: by 2002:a25:ab03:: with SMTP id u3mr6704472ybi.347.1617216506413;
 Wed, 31 Mar 2021 11:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com> <20210331164504.320614-7-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164504.320614-7-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 31 Mar 2021 11:48:15 -0700
Message-ID: <CAEf4BzYMHLn2=+my40Un07CN8zGJZ5PpHSHZ3JJX6v=ZcsAG5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 7/8] libbpf: add bpf_map__inner_map API
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 9:45 AM Yauheni Kaliuta
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
> index 7aad78dbb4b4..b48dc380059d 100644
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
> +    if (!bpf_map_type__is_map_in_map(map->def.type))
> +        return NULL;
> +
> +    return map->inner_map;
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
> index f5990f7208ce..eeb6d5ebd1cc 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -360,4 +360,5 @@ LIBBPF_0.4.0 {
>                 bpf_linker__free;
>                 bpf_linker__new;
>                 bpf_object__set_kversion;
> +               bpf_map__inner_map;

please keep the list sorted alphabetically

>  } LIBBPF_0.3.0;
> --
> 2.31.1
>
