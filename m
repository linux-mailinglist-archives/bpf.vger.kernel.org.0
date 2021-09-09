Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18391404476
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 06:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhIIE12 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 00:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350256AbhIIE1V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 00:27:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F2C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 21:26:13 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v10so1268414ybq.7
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 21:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JA2YLD7vWHr9XS7St1jXRPJ6/X3vK8FYHMEIt/xiMZ8=;
        b=UGtyvd0S6QOInFcYiBPcbk7MJ2iYwPuJFMQnUYTJFKRFvUfEF5vACOUGN60jrCrEiS
         9Y9yO9rhd3z7TIuoMeZSPbudJ6ZjXyYvbDlwZepxFjhfGkqbYl7H3MZXtMm6gs0ttq+p
         ZWYOCudEh/ttEL1na1BehGotADUeNbNzQFNJ+ztr7RlQIS6TliQXpuiKjbMagY9XH8bX
         rcb4BDGM8YLN9gMZUMnw2WfjNlXo4xiYDRWxwXrdYhbaezKbAN+q2nT07luYIpm6qPfL
         wy+YRKlCSIdgeshjE1s2acwCs3irI4U5ew2xQhTrHckDwbuXsYUOExzjHKh6yooni5Lt
         7lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JA2YLD7vWHr9XS7St1jXRPJ6/X3vK8FYHMEIt/xiMZ8=;
        b=DPfysviJvEbpQSGXvZGFQupomfzpuzNQj6d8l2UiJOPsWcgOkq7a1F5gNj4HpQQkVj
         MZ5VMcrXn4rw9OgPW1RZQ64jDxPOmkF40c5ca1MeSVNUhZgZ0MI3+CLlojmmwQgCDPnF
         6XVIcjb4T+4nP8ZN1wU59oc09Z4cSq0LANEJz4sbLLOZOfq2DerUgY+D78ucg4hYijIs
         RmJlWl+SQyX7Xu8pEEdbJAS9nsfRTjbjMwY3IMXC6amKhRoWvNRg2uE38Ak3Rj8DPq0O
         GWxFSfl/lUnZzh79Y/bvI9ylx1ww+HK7HnFxwGJa51ohQHhvzaExT3Ba08i0hk12KFN9
         8/jA==
X-Gm-Message-State: AOAM530fr6uo9ognp5JS1MfFmV1/0WNcL0lhLoWsBcDrcuN/lrMIpo3v
        83I17HrxKFMQPAVCk8duWgInYCkkgyyDgW+s6+8=
X-Google-Smtp-Source: ABdhPJwG6XHiH9ig1iunmG2W4aoegMquuTwYvdD4KQUmPaXeB/q1h8a4SXi11o5IeibbKxJWeYyhvCL4b6pHe8LotAk=
X-Received: by 2002:a5b:702:: with SMTP id g2mr1226455ybq.307.1631161572549;
 Wed, 08 Sep 2021 21:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210905100914.33007-1-hengqi.chen@gmail.com>
In-Reply-To: <20210905100914.33007-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 21:26:01 -0700
Message-ID: <CAEf4BzYfOGi9YLTWWprDtRCHWNpx00kJWHWQ7WbczUaUZi8HRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Support uniform BTF-defined
 key/value specification across all BPF maps
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 5, 2021 at 3:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> A bunch of BPF maps do not support specifying types for key and value.

s/types/BTF types/, it's a bit confusing otherwise

> This is non-uniform and inconvenient[0]. Currently, libbpf uses a retry
> logic which removes BTF type IDs when BPF map creation failed. Instead
> of retrying, this commit recognizes those specialized map and removes

s/map/maps/

> BTF type IDs when creating BPF map.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/355
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

For patch sets consisting of two or more patches, we ask for a cover
letter, so for the next revision please provide a cover letter with an
overall description of what the series is about.

>  tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 88d8825fc6f6..7068c4d07337 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4613,6 +4613,26 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>                         create_attr.inner_map_fd = map->inner_map_fd;
>         }
>
> +       if (def->type == BPF_MAP_TYPE_PERF_EVENT_ARRAY ||
> +           def->type == BPF_MAP_TYPE_STACK_TRACE ||
> +           def->type == BPF_MAP_TYPE_CGROUP_ARRAY ||
> +           def->type == BPF_MAP_TYPE_ARRAY_OF_MAPS ||
> +           def->type == BPF_MAP_TYPE_HASH_OF_MAPS ||
> +           def->type == BPF_MAP_TYPE_DEVMAP ||
> +           def->type == BPF_MAP_TYPE_SOCKMAP ||
> +           def->type == BPF_MAP_TYPE_CPUMAP ||
> +           def->type == BPF_MAP_TYPE_XSKMAP ||
> +           def->type == BPF_MAP_TYPE_SOCKHASH ||
> +           def->type == BPF_MAP_TYPE_QUEUE ||
> +           def->type == BPF_MAP_TYPE_STACK ||
> +           def->type == BPF_MAP_TYPE_DEVMAP_HASH) {
> +               create_attr.btf_fd = 0;
> +               create_attr.btf_key_type_id = 0;
> +               create_attr.btf_value_type_id = 0;
> +               map->btf_key_type_id = 0;
> +               map->btf_value_type_id = 0;
> +       }

Let's do this as a more succinct switch statement. Consider also
slightly rearranging entries to keep "related" map types together:
  - SOCKMAP + SOCKHASH
  - DEVMAP + DEVMAP_HASH + CPUMAP + XSKMAP

Thanks!


> +
>         if (obj->gen_loader) {
>                 bpf_gen__map_create(obj->gen_loader, &create_attr, is_inner ? -1 : map - obj->maps);
>                 /* Pretend to have valid FD to pass various fd >= 0 checks.
> @@ -4622,21 +4642,6 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>         } else {
>                 map->fd = bpf_create_map_xattr(&create_attr);
>         }
> -       if (map->fd < 0 && (create_attr.btf_key_type_id ||
> -                           create_attr.btf_value_type_id)) {
> -               char *cp, errmsg[STRERR_BUFSIZE];
> -
> -               err = -errno;
> -               cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> -               pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
> -                       map->name, cp, err);
> -               create_attr.btf_fd = 0;
> -               create_attr.btf_key_type_id = 0;
> -               create_attr.btf_value_type_id = 0;
> -               map->btf_key_type_id = 0;
> -               map->btf_value_type_id = 0;
> -               map->fd = bpf_create_map_xattr(&create_attr);
> -       }
>

Please don't remove this fallback logic. There are multiple situations
where libbpf might need to retry map creation without BTF.

>         err = map->fd < 0 ? -errno : 0;
>
> --
> 2.25.1
>
