Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE0137FFB5
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 23:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhEMVRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 17:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhEMVRb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 17:17:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D8AC061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:16:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v188so36403134ybe.1
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K10rAsBlRmHikt6SPsf8yyocVr8Lx6rqR8erIq5nF8U=;
        b=MkkWv26e14oSTrNxZpkBpuJZT4JzEP3EzYLmdZfLiBJoBhtOiZ2/4adRaZVYKb1nIT
         SHu+TQRbVLoDAU/HLMB1D7B/vHA4WQv9mxDlaEoJb29gmaKNe8+zS6lvX3c7/h42Asjg
         1iZNLe6jq13eIP0olvh9/MXysUebdDpvq9DkZ7lrKJOW27ho3DANBL+an3yQZDd1fCNL
         vXkjLuGm/awl0pF0D9jErIsiq/hUjYGPz/8IrffbuHQPu8IbWH0qQ4oMzKdCJUEKKsZR
         tqGXJCKFGkUK4he6oZ5vvwcYwnZXabUQEQq/umQNExmSs9FnakMaA+z2Gpjv2666CvSS
         LkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K10rAsBlRmHikt6SPsf8yyocVr8Lx6rqR8erIq5nF8U=;
        b=BkdMFsYCzdZj8IPrp/AkYrV7oUoBbLWiIJht6w4xebMk9j0qy7CTaamLiDNwQVRNK6
         rfCEGt3tFMe4mys62dXb5kc5NY41NiuyxJtAhZbOT/h9ybcY5L+H70IZl0JCgknTYTGf
         tkEi22zndytaOm4CTMduWMUj7dU/FKV6/4VqwmeP85gcIc4pd8eglGpPRtjhci0Up2as
         OetSArjyEFWpyAseyWkOmOuc93VVpPCufp/YscROgbSprT1uRtTlZZgqVlORCtZEXj/T
         pJQ/tbcW4p/Fy0YDq5piz7G6kOdvra7lIrbgdkrNexZytMazCFk6O6ebht0ykkAF+KZ5
         7iig==
X-Gm-Message-State: AOAM530siZTAiNCEL/Uw+pKokpv/R+Doo0L3eyCjEp7T5fLpdv5CmP31
        f2GqZbGU++KTiQm8cGNnI1EMZlSgJdhWNA0QTsE=
X-Google-Smtp-Source: ABdhPJzwweyku60OaWoELGas6PUoSnZGu4Msa/F4pnwAIVR3LdS0Hb1oeDCseNUXsLqhUK4IhWPoEEJqd5SR+wczfSI=
X-Received: by 2002:a25:7507:: with SMTP id q7mr59031955ybc.27.1620940580386;
 Thu, 13 May 2021 14:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com> <20210512213256.31203-17-alexei.starovoitov@gmail.com>
In-Reply-To: <20210512213256.31203-17-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 May 2021 14:16:07 -0700
Message-ID: <CAEf4Bzb=L0LH0OfEqe+uMq0rd8=zaHzPdWV5-Qf5_CQFkKT8pw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 16/21] libbpf: Introduce bpf_map__initial_value().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 12, 2021 at 2:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_map__initial_value() to read initial contents
> of rodata/bss maps. Note only mmaped maps qualify.
> Just as bpf_map__set_initial_value() works only for mmaped kconfig.

This sentence is confusing. bpf_map__set_initial_value() rejects
LIBBPF_MAP_KCONFIG, so it *doesn't* work for kconfig. But your
implementation will return non-NULL pointer for kconfig (it will be
all zeroes before load). So did you intend to match
set_initial_value() semantics or not?

>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c   | 8 ++++++++
>  tools/lib/bpf/libbpf.h   | 1 +
>  tools/lib/bpf/libbpf.map | 1 +
>  3 files changed, 10 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8fd70f0592ad..8d3b136c6b29 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9736,6 +9736,14 @@ int bpf_map__set_initial_value(struct bpf_map *map,
>         return 0;
>  }
>
> +const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
> +{
> +       if (!map->mmaped)
> +               return NULL;
> +       *psize = map->def.value_size;
> +       return map->mmaped;
> +}
> +
>  bool bpf_map__is_offload_neutral(const struct bpf_map *map)
>  {
>         return map->def.type == BPF_MAP_TYPE_PERF_EVENT_ARRAY;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8cf168f3717c..a50eab5fec0a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -471,6 +471,7 @@ LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
>  LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
>                                           const void *data, size_t size);
> +LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
>  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
>  LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 889ee2f3611c..dd0f24370939 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -359,6 +359,7 @@ LIBBPF_0.4.0 {
>                 bpf_linker__finalize;
>                 bpf_linker__free;
>                 bpf_linker__new;
> +               bpf_map__initial_value;
>                 bpf_map__inner_map;
>                 bpf_object__gen_loader;
>                 bpf_object__set_kversion;
> --
> 2.30.2
>
