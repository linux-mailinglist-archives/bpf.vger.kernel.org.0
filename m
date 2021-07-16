Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC23CB1E7
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 07:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhGPFaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 01:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhGPFaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Jul 2021 01:30:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F16C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 22:27:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p22so12952117yba.7
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 22:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzJeOtPHmlRopsF1+ghLfMXFj1WSu1KHEXkAoClDTWk=;
        b=ihzOc3tQvDZbLyoDwYA+ByMURRbB9QHv9IxQ101sYthHdPhQsmHKOGptOIbc0kHYLi
         0qyYZ+Mup6q8ktA2UCxzgFeVzKoShd7Z73d6vIovH37+aie0b6x7EJYgJYttVIaQuApi
         pLB8K3CTLct3rsGCf5l7Z7WZxuSejdGHE8Iv2LWfhmUoyHWlXI9x8hc382W5dG6VX5F/
         GmU4iQJoZMbjdXjqh5qHsNnjzWJjpXeU7Ls58UJPrGLee0Dhoy+NRYhggeGFXhqJlWNU
         oWJRTclS+6OZg4mD00/tz9ITZ8HQcPleolKedCD6EsRhPnazAh/Kz8mbwaGS8fAvlKfA
         RJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzJeOtPHmlRopsF1+ghLfMXFj1WSu1KHEXkAoClDTWk=;
        b=GxMBu4AaRobLkK6uMEHd1hQ8RgNzEouacvf9h8qCaX26/OtIoFai+s+sZkbKrurmsC
         qAOigmHm2dMB5jjZHZp6MAN40V6deKlwrdzT9/kQ6eBKeBksOeOBYQ1YzV7lfCjbAK5b
         gSB+552lM0eruCajT/FGHHVBGNzPoegnAopniOObZwzePBkirfP5zr5sHJMnBkArRq/S
         W1EdboVk82OAn8OBG2GmfEYyfAPrauYz2eGMSKwzD2RwFHXc1FhsxOrh8CEO7XDGPXCb
         yoHLf+uuBGgZ5N1pYF2eU/GruyBh9Gv2/6TS8DqEVbVJh/ck9KLvKaKSFvn7fo/BrVa9
         LtTQ==
X-Gm-Message-State: AOAM531W/p8bko+bNWlBevw7XRPZRgJBs8fIQ5nsyKk7s858XXIT/1YU
        eoWzwp2BTWdUYkra237oS+8j0cGA9eyDWkNpY+4j5qbOKTj7qw==
X-Google-Smtp-Source: ABdhPJzgd6MVt2o04nRwoaDwUIJhSKQwH6RaJzqmqNvkQvlQjKDyCXrldBoKdumLswRNqljtv483o21FOMUhx9ZP79I=
X-Received: by 2002:a25:1455:: with SMTP id 82mr10281551ybu.403.1626413242604;
 Thu, 15 Jul 2021 22:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210714165440.472566-1-m@lambda.lt> <20210714165440.472566-2-m@lambda.lt>
In-Reply-To: <20210714165440.472566-2-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Jul 2021 22:27:11 -0700
Message-ID: <CAEf4BzbNpqkDGfprj_hH-=3zZNxZ7SkEsCRZnb5==6vfAoXt8w@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] libbpf: fix removal of inner map in bpf_object__create_map
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 14, 2021 at 9:52 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> If creating an outer map of a BTF-defined map-in-map fails (via
> bpf_object__create_map()), then the previously created its inner map
> won't be destroyed.
>
> Fix this by ensuring that the destroy routines are not bypassed in the
> case of a failure.
>
> Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  tools/lib/bpf/libbpf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6f5e2757bb3c..1a840e81ea0a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4479,6 +4479,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>  {
>         struct bpf_create_map_attr create_attr;
>         struct bpf_map_def *def = &map->def;
> +       int ret = 0;
>
>         memset(&create_attr, 0, sizeof(create_attr));
>
> @@ -4561,7 +4562,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>         }
>
>         if (map->fd < 0)
> -               return -errno;
> +               ret = -errno;

Oh, isn't this a complicated function, eh? I stared at the code for a
while until I understood the whole idea with map->inner_map handling
there.

I think your change is correct, I'd just love you to consolidate all
those "int err" definitions, and use just one throughout this
function. It will clean up two other if() blocks, and in this case
"err" name is more appropriate, because it always is <= 0.

>
>         if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
>                 if (obj->gen_loader)
> @@ -4570,7 +4571,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>                 zfree(&map->inner_map);
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
> --
> 2.32.0
>
