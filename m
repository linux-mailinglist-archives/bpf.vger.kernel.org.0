Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C098404496
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 06:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhIIEqU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 00:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350440AbhIIEqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 00:46:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F5C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 21:45:10 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y13so1354179ybi.6
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 21:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuWlqHB+pDlmi14q0GyBjoFXZ/evOu3ozUT5CgobBCc=;
        b=i2EiDAh3Vx+p1B49/wC9V7+vbq4zamlcN3ZeGYQ63YVlxPgXay5VNp806sXs+ih10Z
         NhSP9bO6nPfBcdljSecFi8dHtUKAbsEfhZJTXfLgBN+e9CIQSamRd1R3wePsOHhARTuj
         MTHUvnmul9ElWUWWr7pei+/z3A/m4BnZRtJvO2IylvSfzgCAaXeI02zKKMWpIjl0peV3
         Q86+Gc4U/IZ2cDkzkoZQueBMcDYO/9+UgNQceBJsQWjQZN5MWfUYLMZtqi1GDp8zAn3X
         u56TPJirb6xfl1Er28PVM2H6hFBxPSaB/jR/P93gh8psBUDgA4L52LlcBbrffALJaPth
         HUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuWlqHB+pDlmi14q0GyBjoFXZ/evOu3ozUT5CgobBCc=;
        b=FV7IrmY57z56WuWO8z947q2JaOZcj9fIKe72NW0kKJxkRI9A9lJtjhyQ5clHm01vh1
         R1zkty/R7igv4n7fKuG7NX8U8pdA70H3cBeR94zsm7akXpsUaV4ekeoRwCow+a9spTkq
         R8qAECucDg3VcvsiG2R5U1InIye6Yu/JldVA7U82OtjxuA93/9CuG1xYJ5CWBbFrNWqC
         oML0EmyhTWWwGZYIrWpo/KWyuivdmKttk/2mbDQPn+rpN1OwWgziuzxEoXH6x7dEKN09
         cgE3N38OQen9wsPseI2Tnb1nVPbSqJDyebLGj2IxBIf96/eUZ9YJDkQfexQvdVDwIdct
         Uf9Q==
X-Gm-Message-State: AOAM532LaB+S2Razo9LvOCS3I4DlZl4TjP+qDQB9vUws8cYMULkaU0Rf
        GdfrzZuCjUGHQZEL2TVS6gJ99GuDVUVwNr8/2Q9JlHPSwXk=
X-Google-Smtp-Source: ABdhPJwCZJriWTcEzMYKP8I5ltg9WaxJArv6KVQsSosRhGEubAtUppKo8kkqu2K4VOnNXFVBBzkHhrBLtI5hZjGfxHE=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr1484722ybt.178.1631162709628;
 Wed, 08 Sep 2021 21:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210906165456.325999-1-hengqi.chen@gmail.com>
In-Reply-To: <20210906165456.325999-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 21:44:58 -0700
Message-ID: <CAEf4BzbWQudS5bRrrX3XptLLa6y8DTNavS4ZoivVRoEQzNukAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Deprecate bpf_{map,program}__{prev,next}
 APIs
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

On Mon, Sep 6, 2021 at 9:55 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Deprecate bpf_{map,program}__{prev,next} APIs. Replace them with
> a new set of APIs named bpf_object__{prev,next}_{program,map} which
> follow the libbpf API naming convention. No functionality changes.
>
> Closes: https://github.com/libbpf/libbpf/issues/296

I'm hesitant about using Closes: as if it was a proper Linux tag.
Let's stick to using it in a reference:

   [0] Closes: ...


> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c   | 24 ++++++++++++++++++------
>  tools/lib/bpf/libbpf.h   | 30 ++++++++++++++++++++----------
>  tools/lib/bpf/libbpf.map |  4 ++++
>  3 files changed, 42 insertions(+), 16 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 88d8825fc6f6..8d82853fb4a0 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7347,7 +7347,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
>         return 0;
>
>  err_unpin_maps:
> -       while ((map = bpf_map__prev(map, obj))) {
> +       while ((map = bpf_object__prev_map(map, obj))) {
>                 if (!map->pin_path)
>                         continue;
>
> @@ -7427,7 +7427,7 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
>         return 0;
>
>  err_unpin_programs:
> -       while ((prog = bpf_program__prev(prog, obj))) {
> +       while ((prog = bpf_object__prev_program(prog, obj))) {
>                 char buf[PATH_MAX];
>                 int len;
>
> @@ -7666,8 +7666,11 @@ __bpf_program__iter(const struct bpf_program *p, const struct bpf_object *obj,
>         return &obj->programs[idx];
>  }
>
> +__attribute__((alias("bpf_object__next_program")))
> +struct bpf_program *bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj);
> +
>  struct bpf_program *
> -bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj)
> +bpf_object__next_program(struct bpf_program *prev, const struct bpf_object *obj)

I think for bpf_object__next_program it makes more sense to have obj
as the first argument (it's a "method" of bpf_object, after all). So
you can't have bpf_program__next aliased to bpf_object__next_program,
you have to add a small wrapper function. Same for other new APIs.

>  {
>         struct bpf_program *prog = prev;
>
> @@ -7678,8 +7681,11 @@ bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj)
>         return prog;
>  }
>

[...]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index f177d897c5f7..e6aab4cd263b 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -186,16 +186,22 @@ LIBBPF_API int libbpf_find_vmlinux_btf_id(const char *name,
>
>  /* Accessors of bpf_program */
>  struct bpf_program;
> -LIBBPF_API struct bpf_program *bpf_program__next(struct bpf_program *prog,
> +LIBBPF_API LIBBPF_DEPRECATED("bpf_program__next() is deprecated, use bpf_object__next_program() instead")

We shouldn't deprecate API until the replacement API was already
released as part of an official libbpf release. I suggest to wait
until the LIBBPF_DEPRECATE_SINCE ([0]) patch lands first, and then
using that here to deprecate those APIs starting from 0.7 (because we
are now developing 0.6 libbpf).

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20210908213226.1871016-1-andrii@kernel.org/

> +struct bpf_program *bpf_program__next(struct bpf_program *prog,
>                                                  const struct bpf_object *obj);
> +LIBBPF_API struct bpf_program *bpf_object__next_program(struct bpf_program *prog,
> +                                                       const struct bpf_object *obj);
>

[...]

>  /* get/set map FD */
>  LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index bbc53bb25f68..0c6d510e7747 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -378,6 +378,10 @@ LIBBPF_0.5.0 {
>                 bpf_program__attach_tracepoint_opts;
>                 bpf_program__attach_uprobe_opts;
>                 bpf_object__gen_loader;
> +               bpf_object__next_map;
> +               bpf_object__next_program;
> +               bpf_object__prev_map;
> +               bpf_object__prev_program;

For next revision, please add the LIBBPF_0.6.0 section, libbpf 0.5 was
just released today, so we are now moving into the v0.6 development
cycle. Thanks!

>                 btf__load_from_kernel_by_id;
>                 btf__load_from_kernel_by_id_split;
>                 btf__load_into_kernel;
> --
> 2.30.2
