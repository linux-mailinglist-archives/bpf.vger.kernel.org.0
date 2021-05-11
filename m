Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2437B2B8
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 01:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEKXlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhEKXlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 19:41:10 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B23C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:40:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 82so28547936yby.7
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5ylpITsmPvdln2bAynqbr/Of+R9Ntiiz3wsT/Rk9FY=;
        b=h0je6PY6DXbBq2ZAPO0D1rV0z7W63SBnmNCupBkPIKmFmlfmqxVAHSRE8DepS1CH3B
         UWuLWAxGqAhtgRGtTBfaQIcSjyBdscCI4pBVLySyBxHifyk2nggR/mMmJwl2NCXa5aj9
         FQaLNhS22n44cGxHNsK8XQNOTiOdtVD8sSpYYD0xyjz3Yxw56HTlqmbMMSQ3wE44Bdsv
         yZJF351T3eHnI1EblFRyiCmMacL73k7GoKPQqnVhNr1O7J53pSNEtttBt58lAZ20SdcT
         CYZKzV7eODmm64f/PVH/uGFTkyhZBj0sGlQn2edKCu7hK4CfvcDIavGzfWSAOLBotODQ
         xuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5ylpITsmPvdln2bAynqbr/Of+R9Ntiiz3wsT/Rk9FY=;
        b=Vipk3yGbw4CUXqxKanVbdzQWbWSTFWAp/wwZdEBhTdkuS/vfy2gO/VVNY2PrcuP5RL
         +S77WUhA2PuPCuCoHoF1BDjvs3JK6U5YeIB9M61Ey3aCNHZvhDQ1I+hkU7pXAmhbdnn1
         f8vp/R+tZGDu9BJ40kOddhaAsX8TwEzjRor+2X34PeW4N2HezQQMNA/5PirsLyXfYu8n
         kzk5ABwimOkoskn/877tzTQVOv8Y/oIIAQjG3FHtbji6XCKU20QWfWUU4wK6eRhesL6v
         FmB4W5mU2Ak8UUn1lF24sYcRtflBgGy4MER8FZ3W7ohJROoQdg0xcb3GAxiTx7Q0ee8E
         DoVw==
X-Gm-Message-State: AOAM530rwuvnAL3NeNaxPmR9U94Ymtq92di45Cfrw2e4fckJV2tlbinW
        ZNlY7W2GU2k/MvikVvFHryJLbz7d+nhT3rh7T20=
X-Google-Smtp-Source: ABdhPJx2L6EQDchnwuW52iDWkJDR9sZnVUWMlPM1vY0KnQqOj+X9KzI1jamsCUNAMkBr7OtSnzYn7HXXru38LI+sPnI=
X-Received: by 2002:a5b:d4c:: with SMTP id f12mr19733221ybr.510.1620776401589;
 Tue, 11 May 2021 16:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-18-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-18-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 16:39:50 -0700
Message-ID: <CAEf4Bzbfihb6JTQ7zyLBJfbHV6Y-ai28vL+TSmGEX3K5tH=FNA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 17/22] libbpf: Introduce bpf_map__get_initial_value().
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

On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_map__get_initial_value() to read initial contents
> of rodata/bss maps. Note only mmaped maps qualify.
> Just as bpf_map__set_initial_value() works only for mmaped kconfig.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c   | 10 ++++++++++
>  tools/lib/bpf/libbpf.h   |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 13 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 24a659448782..f7cdbb0e1faf 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9763,6 +9763,16 @@ int bpf_map__set_initial_value(struct bpf_map *map,
>         return 0;
>  }
>
> +int bpf_map__get_initial_value(struct bpf_map *map,
> +                              const void **pdata, size_t *psize)

the general patterns (there are legacy exceptions) for getters is to
not have "get_" in the name. Please rename it to just
bpf_map__initial_value().

Also btf__get_raw_data() (note the legacy naming) follows a slightly
different pattern of returning NULL on error or valid pointer on
success. And then the size is returned as outer param. Unless there is
a good reason not to, let's be consistent with that pattern?

> +{
> +       if (!map->mmaped)
> +               return -EINVAL;
> +       *psize = map->def.value_size;
> +       *pdata = map->mmaped;
> +       return 0;
> +}
> +
>  bool bpf_map__is_offload_neutral(const struct bpf_map *map)
>  {
>         return map->def.type == BPF_MAP_TYPE_PERF_EVENT_ARRAY;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index fb291b4529e8..f8976a30586f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -471,6 +471,8 @@ LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
>  LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
>                                           const void *data, size_t size);
> +LIBBPF_API int bpf_map__get_initial_value(struct bpf_map *map,
> +                                         const void **pdata, size_t *psize);
>  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
>  LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 889ee2f3611c..44285045ddf4 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -360,6 +360,7 @@ LIBBPF_0.4.0 {
>                 bpf_linker__free;
>                 bpf_linker__new;
>                 bpf_map__inner_map;
> +               bpf_map__get_initial_value;

nit: g < i, and as bpf_map__initial_value will still go before inner_map getter

>                 bpf_object__gen_loader;
>                 bpf_object__set_kversion;
>  } LIBBPF_0.3.0;
> --
> 2.30.2
>
