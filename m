Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7706659277
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 23:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiL2Wdr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 17:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiL2Wdq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 17:33:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB023BC25;
        Thu, 29 Dec 2022 14:33:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gh17so47947538ejb.6;
        Thu, 29 Dec 2022 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnEqCpAGobkh5yewq/ZVNZcO4mC87hVyaNZrine7Wa0=;
        b=Fk/9xRQHxoeMg/p1YiGg64Q8qCkmhOA5vj6mgCyojGZ74/c5sgf/7iEUbSzOzZp3TH
         D3fbeJsBlnuO648QzYX5d8dR3Www0JQSlHB0duujUoW8mlZ2BFxr6/P7MG/DV2RYTI/g
         99shbkG4y+8yaNYxGguM8+0dU3YDol6y0cIP5rOJp7Mow0VMDW3H3d7k4EYRJo7YRECz
         laxG4XiKn4yQUjOEohcobt+zxi71ykjatlVyA6jdwLkSbLCWvDcVQIl07MPUuuGzsbt/
         545mX+k0fVqGwbyZM8XHT51wc6mZBhGrd8VkH0nQC54AY/jTx9C39oNzI6TnrHVqirNT
         Atpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnEqCpAGobkh5yewq/ZVNZcO4mC87hVyaNZrine7Wa0=;
        b=6mfPWKxl2ETu+O8Pi89lPnRyyzWG0BHrXlhWpWcP31KVo3jneZEI4rNq5F1Sz8ALeD
         cW3S/Go4t/ksvXnChZRheWuX/TATSnKBOMJqiq0JAGR/hXy63iSJfG+exaXcxHxlMFQP
         ikK3KrmlHccEMkJw2+UpAY6qIK0ALu5/ceCcE2NRGXS5bndvzHqImc2p0q3acMeOtjA3
         Ha9tD4pa1Vhx1hep8H+1Let7cBesbOSrU333YHZhyrIjswvYs481B6iEo93LGWDUvWVI
         RElyFM7MMimYT7cNwg//q2kU8pwSCQE0Ebv1HC1LmjVYMfwbfYQsrB64a2zGtabTatNR
         GN3Q==
X-Gm-Message-State: AFqh2kpFEqHLLZkVNXw+spPj4gbCqmcu37bgWPhR2GE4uzFxTHHdhNSW
        C+ohdXi3obs5jkxzv2noMzyJStS3gLOQi3m7pAY=
X-Google-Smtp-Source: AMrXdXuixgE4j+vNTM6toM3AGYa/w3FzZ5+RZbWzcDytBMAu1O+/+kYQ1OQW5eKfMbpTGScdKOAes4DqZOsa9OCNNDE=
X-Received: by 2002:a17:906:2ccc:b0:7f3:3b2:314f with SMTP id
 r12-20020a1709062ccc00b007f303b2314fmr2337967ejr.115.1672353224524; Thu, 29
 Dec 2022 14:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20221224112058.12038-1-liuxin350@huawei.com>
In-Reply-To: <20221224112058.12038-1-liuxin350@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Dec 2022 14:33:32 -0800
Message-ID: <CAEf4BzbYAX2KS-KA_6PPhn2edP+1_pDGJC6m6_=ihWGsz71heA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Added the description of some API functions
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
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

On Sat, Dec 24, 2022 at 3:21 AM Xin Liu <liuxin350@huawei.com> wrote:
>
> Currently, many API functions are not described in the document.
> I have tried to add the API description of the following four API
> functions:
>  libbpf_set_print
>  bpf_object__open
>  bpf_object__load
>  bpf_object__close
>
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---

I've tweaked descriptions a bit to match the overall style and fixed
few typos. Pushed to bpf-next, thanks!

>  tools/lib/bpf/libbpf.h | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index eee883f007f9..bf3af52d42be 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -96,6 +96,12 @@ enum libbpf_print_level {
>  typedef int (*libbpf_print_fn_t)(enum libbpf_print_level level,
>                                  const char *, va_list ap);
>
> +/**
> + * @brief **libbpf_set_print()** use the user-provided log print function.
> + * @param fn the log print function. Disable all print if the parameter
> + * is NULL.
> + * @return Pointer to old print function.
> + */
>  LIBBPF_API libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn);
>
>  /* Hide internal to user */
> @@ -174,6 +180,14 @@ struct bpf_object_open_opts {
>  };
>  #define bpf_object_open_opts__last_field kernel_log_level
>
> +/**
> + * @brief **bpf_object__open()** creates a bpf_object by opening
> + * the BPF ELF object file pointed to by the passed path and loading it
> + * into memory.
> + * @param path BPF object file path.
> + * @return pointer to the new bpf_object; or NULL is returned on error,
> + * error code is stored in errno
> + */
>  LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
>
>  /**
> @@ -204,9 +218,20 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
>                      const struct bpf_object_open_opts *opts);
>
>  /* Load/unload object into/from kernel */
> +/**
> + * @brief **bpf_object__load()** load bpf_object into kernel
> + * @param obj pointer to a valid bpf_object
> + * @return 0, on success; negative error code, otherwise, error code is
> + * stored in errno
> + */
>  LIBBPF_API int bpf_object__load(struct bpf_object *obj);
>
> -LIBBPF_API void bpf_object__close(struct bpf_object *object);
> +/**
> + * @brief **bpf_object__close()** close a bpf_object and release all
> + * resources.
> + * @param obj pointer to a valid bpf_object
> + */
> +LIBBPF_API void bpf_object__close(struct bpf_object *obj);
>
>  /* pin_maps and unpin_maps can both be called with a NULL path, in which case
>   * they will use the pin_path attribute of each map (and ignore all maps that
> --
> 2.33.0
>
