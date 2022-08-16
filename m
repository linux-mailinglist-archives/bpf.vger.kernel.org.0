Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044D45964AC
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiHPVeI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiHPVeH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:34:07 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0679603
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:34:06 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g16so6934795qkl.11
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BrTE69LFuDZV42x2tjQU8nS0/YwiclsLylMrci0eHkY=;
        b=pijKzvu2Zmh+Zmat1SYyJ0TP6tS4qjR9ffk13n/nKdbN+RZLQQBQgobBNV+rgk4nXo
         5Rp+woksoBzhxuoBPvNXUNKFEdWGWuzlqM2QjRGL9sMHIgM5+Zpf+mfUknp6uEXvNW4s
         EAXSd6g/GXnDTWwOwAU03F18Vqoo7bWXeE/nKu03nilcpy/GZPlDyCVG5IYR9BP4CXJc
         oIPvLkEg1/Gu50PYn8IXb4lc9ckQTEy1G3puujdB2WNFH7Li6kkkK603I+7A86/7aiCL
         mJvdqw/ZiRlL+mPbpng2svK3h7d8l7dU26ZH/PgeQXNVFMJ+sauJ3UD1NK/f5m0mCagi
         6dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BrTE69LFuDZV42x2tjQU8nS0/YwiclsLylMrci0eHkY=;
        b=V0Mh1OymNCtBMK5Bz7O0FtEAVIxShx6/IlQcYneP55FTJP/QdpR8XEsBJgj3Rs2DaY
         vUfqMDaL5PFuhOJEq0xBeDxpCsGOI8P+ZCxhaE2cR0xd4Ko1ZiXTOzOhjScgt/aXtCql
         DjLFgR6fnsaRl2uPFzyMIJfLLKuOH7zazIKrE9/4GTHZAzSXAdFROekk/5eD5t3bEw/e
         N/LeaW1iahG4uNZAJtjvNL0csW7tcZLg705IkbDMKjroju38NBqoF9rd2OOu6hKk9TFU
         FzIcyJ4zyc8mtvKeTSVdKWwnOhGpkzznRQkoBM/a617k9rzp+kP2WHEbIkYImzB09beY
         ycCA==
X-Gm-Message-State: ACgBeo0WzEnwH29qHRPo63jMJL25Bp7fBy6JNTKLgOI+H97/0wU7GaUy
        jsuNZiPh+rPU761gs5aPIRacbwo8s4MHBPE0pgH5hA==
X-Google-Smtp-Source: AA6agR4ofPF1Co7PtBBoaHao4UEnSnA21lTY+Pv7dsoI/ZmyccSe/5JtqY/ifudFOAqvI5dhM30hLcbKQxTtE1RLlpQ=
X-Received: by 2002:a37:e118:0:b0:6ba:e5ce:123b with SMTP id
 c24-20020a37e118000000b006bae5ce123bmr13528006qkm.221.1660685645647; Tue, 16
 Aug 2022 14:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220816001929.369487-1-andrii@kernel.org> <20220816001929.369487-4-andrii@kernel.org>
In-Reply-To: <20220816001929.369487-4-andrii@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Aug 2022 14:33:55 -0700
Message-ID: <CA+khW7h1n1fA53B-2SDc2z-sVOCFVt8f9pBPT1D_sbJ4T63PdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: clean up deprecated and legacy aliases
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 9:23 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Remove two missed deprecated APIs that were aliased to new APIs:
> bpf_object__unload and bpf_prog_attach_xattr.
>

Three functions? Missing btf__load()?

> Also move legacy API libbpf_find_kernel_btf (aliased to
> btf__load_vmlinux_btf) into libbpf_legacy.h.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

The change itself looks good to me. Verified these functions are no
longer used in the source file.

Acked-by: Hao Luo <haoluo@google.com>


>  tools/lib/bpf/bpf.c           | 5 -----
>  tools/lib/bpf/btf.c           | 2 --
>  tools/lib/bpf/btf.h           | 1 -
>  tools/lib/bpf/libbpf.c        | 2 --
>  tools/lib/bpf/libbpf_legacy.h | 2 ++
>  5 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index e3a0bd7efa2f..1d49a0352836 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -641,11 +641,6 @@ int bpf_prog_attach_opts(int prog_fd, int target_fd,
>         return libbpf_err_errno(ret);
>  }
>
> -__attribute__((alias("bpf_prog_attach_opts")))
> -int bpf_prog_attach_xattr(int prog_fd, int target_fd,
> -                         enum bpf_attach_type type,
> -                         const struct bpf_prog_attach_opts *opts);
> -
>  int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
>  {
>         const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d14f1a52d7a..361131518d63 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1225,8 +1225,6 @@ int btf__load_into_kernel(struct btf *btf)
>         return btf_load_into_kernel(btf, NULL, 0, 0);
>  }
>
> -int btf__load(struct btf *) __attribute__((alias("btf__load_into_kernel")));
> -
>  int btf__fd(const struct btf *btf)
>  {
>         return btf->fd;
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 583760df83b4..ae543144ee30 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -116,7 +116,6 @@ LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_b
>
>  LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
>  LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
> -LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
>
>  LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
>  LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 89f192a3ef77..9aaf6f7e89df 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7260,8 +7260,6 @@ static int bpf_object_unload(struct bpf_object *obj)
>         return 0;
>  }
>
> -int bpf_object__unload(struct bpf_object *obj) __attribute__((alias("bpf_object_unload")));
> -
>  static int bpf_object__sanitize_maps(struct bpf_object *obj)
>  {
>         struct bpf_map *m;
> diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
> index 5b7e0155db6a..1e1be467bede 100644
> --- a/tools/lib/bpf/libbpf_legacy.h
> +++ b/tools/lib/bpf/libbpf_legacy.h
> @@ -125,6 +125,8 @@ struct bpf_map;
>  struct btf;
>  struct btf_ext;
>
> +LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
> +
>  LIBBPF_API enum bpf_prog_type bpf_program__get_type(const struct bpf_program *prog);
>  LIBBPF_API enum bpf_attach_type bpf_program__get_expected_attach_type(const struct bpf_program *prog);
>  LIBBPF_API const char *bpf_map__get_pin_path(const struct bpf_map *map);
> --
> 2.30.2
>
