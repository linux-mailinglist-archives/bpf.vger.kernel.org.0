Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B62699FD2
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 23:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBPWkc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 17:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPWkc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 17:40:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED23CE2A
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:40:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d40so8597534eda.8
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kMSYItjELSpaTAHKpkoz1/1rmAVEs36sLYv66yZKAEo=;
        b=MHPO1IPeymU+3UhVQsaoovxO1YY4JrN1LtkaI0Ys0EoLJ67gCuGk56PJEZd/DToRmT
         bPvTMKVp3fRXAIXNN55VwIuXZvdEwAB8Tz+JndCj8nEp8txAMh8moD2ZYYBS0JwNCnYs
         mIg8pM63Q8e+UHbteGhP76btjV3MY5O15th9uxG3nJmLfoic/BGjAXoubhTLIk7nGIe9
         GF/A4jxiJUCbN9PPJlSLGbBXVBNAZaNK8b2X/aoUkJs5xt2qvXiBLTJqMlKljoLFbcen
         BY7LpAucVF9JlUpVX7qhgNw6Dx59X0Zg5Q5R+Mn1P/1SrDgP5WK6q5bVpe/+YX8ZSCCE
         7bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMSYItjELSpaTAHKpkoz1/1rmAVEs36sLYv66yZKAEo=;
        b=Jc0nfF2570+7au1GDT/Up9jDWxtOmeYuqi6HDV7TgTyECLqR8KnYnAophQ149GFKzm
         RJAVz5ynmiFUPLk0VBCoq/Ifwsmi5SA1As7c2b5PsPZ7FwFrmkfsbmQk+oXnl0liVt2b
         GnYLeCzHonbC9j3cnjFdp1ZfnA8utvkZ89eto1MJ2esiG/jmlO6DGtgDLGOBkedj13CL
         /5qR/U+uMlX0OYMv9JfE9q0Hds4xC6uwSGGJDRHi9+9iQfeG8An/n7dFrqMv5leeZVAQ
         YzGCMthgYI3GQhVPFE73u2pHNTnWL5Ocn6Jd553z9Oz+yaocqQaYstlROztFC2tLDJUq
         305g==
X-Gm-Message-State: AO0yUKXcEJrY1EBQDcDD4wGBNpZ0wylWDZtxIH3COX/NhGNINGV6TZcn
        zHgxcl+PILa6wPnpBO7zY5n8EdOUSsLZLGXXXCivcEoK
X-Google-Smtp-Source: AK7set8o48NpGPA01c0ob2Y14gmDWy8+kSO02HaQXiuG3XrMQqcOscVh/V8QI2DyIFKsc9yLbOag6AUfzYZz75v9xRQ=
X-Received: by 2002:a50:bb66:0:b0:4ab:4d34:9762 with SMTP id
 y93-20020a50bb66000000b004ab4d349762mr3861763ede.5.1676587229293; Thu, 16 Feb
 2023 14:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-5-kuifeng@meta.com>
In-Reply-To: <20230214221718.503964-5-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 14:40:16 -0800
Message-ID: <CAEf4BzZ8k04R4Y0FY2k6KoSPZdiYRJxcnA1qypi=Hk-JM8ppWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>
> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
> placeholder, but now it is constructing an authentic one by calling
> bpf_link_create() if the map has the BPF_F_LINK flag.
>
> You can flag a struct_ops map with BPF_F_LINK by calling
> bpf_map__set_map_flags().
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 73 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 15 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 75ed95b7e455..1eff6a03ddd9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11430,29 +11430,41 @@ struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
>         return link;
>  }
>
> +struct bpf_link_struct_ops_map {

let's drop the "_map" suffix? struct_ops is always a map, so no need
to point this out

> +       struct bpf_link link;
> +       int map_fd;
> +};
> +
>  static int bpf_link__detach_struct_ops(struct bpf_link *link)
>  {
> +       struct bpf_link_struct_ops_map *st_link;
>         __u32 zero = 0;
>
> -       if (bpf_map_delete_elem(link->fd, &zero))
> +       st_link = container_of(link, struct bpf_link_struct_ops_map, link);
> +
> +       if (st_link->map_fd < 0) {
> +               /* Fake bpf_link */
> +               if (bpf_map_delete_elem(link->fd, &zero))
> +                       return -errno;
> +               return 0;
> +       }
> +
> +       if (bpf_map_delete_elem(st_link->map_fd, &zero))
> +               return -errno;
> +
> +       if (close(link->fd))
>                 return -errno;
>
>         return 0;
>  }
>
> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> +/*
> + * Update the map with the prepared vdata.
> + */
> +static int bpf_map__update_vdata(const struct bpf_map *map)

this is internal helper, so let's not use double underscores, just
bpf_map_update_vdata()

>  {
>         struct bpf_struct_ops *st_ops;
> -       struct bpf_link *link;
>         __u32 i, zero = 0;
> -       int err;
> -
> -       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> -               return libbpf_err_ptr(-EINVAL);
> -
> -       link = calloc(1, sizeof(*link));
> -       if (!link)
> -               return libbpf_err_ptr(-EINVAL);
>
>         st_ops = map->st_ops;
>         for (i = 0; i < btf_vlen(st_ops->type); i++) {
> @@ -11468,17 +11480,48 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>                 *(unsigned long *)kern_data = prog_fd;
>         }
>
> -       err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> +       return bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> +}
> +
> +struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> +{
> +       struct bpf_link_struct_ops_map *link;
> +       int err, fd;
> +
> +       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       link = calloc(1, sizeof(*link));
> +       if (!link)
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       err = bpf_map__update_vdata(map);
>         if (err) {
>                 err = -errno;
>                 free(link);
>                 return libbpf_err_ptr(err);
>         }
>
> -       link->detach = bpf_link__detach_struct_ops;
> -       link->fd = map->fd;
> +       link->link.detach = bpf_link__detach_struct_ops;
>
> -       return link;
> +       if (!(map->def.map_flags & BPF_F_LINK)) {

So this will always require a programmatic bpf_map__set_map_flags()
call, there is currently no declarative way to do this, right?

Is there any way to avoid this BPF_F_LINK flag approach? How bad would
it be if kernel just always created bpf_link-backed struct_ops?

Alternatively, should we think about SEC(".struct_ops.link") or
something like that to instruct libbpf to add this BPF_F_LINK flag
automatically?

> +               /* Fake bpf_link */
> +               link->link.fd = map->fd;
> +               link->map_fd = -1;
> +               return &link->link;
> +       }
> +
