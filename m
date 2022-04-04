Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7BE4F1F3F
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 00:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiDDWrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 18:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345917AbiDDWrJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 18:47:09 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A209DF2E
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 14:58:51 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9so7888254ilu.9
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9KBVSF1lnIoOaXV6H3DrBCJxS7v/cBk50kASg9NzGs=;
        b=EZd+y/aIQSOa9kRIudWq/63U3LVRevrfW9uj1YmEQ1JxfQ9juxScdgBkitA1FD231M
         DUf4807P5us46unAb9xSXY8tLKjiMPoTwLSTvnye7ws1hAUSWQnhDDTtx/uSdtcy6ght
         wzZwvNlwTINpxnDiSrD1IQaIVfoCpmAs37HpuzCPQYDECah9BNcbv4JYeMyTrrRWprqq
         IOIjvRqAJJxaGCu/mSD3vh+rkuV9yiQLJB5S00PY1lOa58Nw7tIMbzPnoqhCDWTP0J+M
         QwxzL4yqTJlh8rVa/YRkE3ua6De8jxQiJpd9l8OGXl8UYpyqdkAx8I/Y2jrhk9cvN5ab
         ipWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9KBVSF1lnIoOaXV6H3DrBCJxS7v/cBk50kASg9NzGs=;
        b=HD/BATcjNXIGGGLsZWl0Bmk50HFzKBp9jI6bD77SaVeVVbZSdrP+4cW9p77RtKuNqq
         /QaiwhbXcUCPR3HGpu15NpAjx04gGA7FE/9uVXQ6lo1J45h0GtJ0E/mDt5jeNH/7yH3v
         9SYIcbTP249vDWZmM/eVUt9hDQYSgGE4NiHZ4oMJCgELitp37uIEmNG1jlmHl30Y+m0i
         cY0MTFIds7KhP4AUKtJ8Z/43ZKsh4aQfbz8ZiEKE7WDu2Dc2T/LKlAU1iuaXgGzIjcKZ
         +w8BlMFe36we9IA0kfr2SiXudPtoyKmj5+T02Ps/Bx95DU/9D1tGzILcM+QbF7eRyKlY
         UCmA==
X-Gm-Message-State: AOAM533P+VegGVj24IbegXIin5JjOxm+xpjBd3Jg8vuXFhMzDhCW7sZb
        HUjLOeWs+zYcRVmx5GCUE1suGFIvHtm9l+Jq2DZNF/A5
X-Google-Smtp-Source: ABdhPJx4FHLQp6uqWNdql6Hgv1g/iz1NHAx6HRQ6ev/qGBoQpzUjR6ZqmabBX8SpkneOvX61D8W9om2cAFLMj9BfSAQ=
X-Received: by 2002:a92:cd89:0:b0:2c9:bdf3:c5dd with SMTP id
 r9-20020a92cd89000000b002c9bdf3c5ddmr165254ilb.252.1649109530448; Mon, 04 Apr
 2022 14:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220404102908.14688-1-iii@linux.ibm.com>
In-Reply-To: <20220404102908.14688-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 4 Apr 2022 14:58:39 -0700
Message-ID: <CAEf4BzZfSUTNAXQM6BcXF6rQGe6LaSfpgiA9uQXu8Fvb3Kk-KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Support Debian in resolve_full_path()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 4, 2022 at 3:29 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> attach_probe selftest fails on Debian-based distros with `failed to
> resolve full path for 'libc.so.6'`. The reason is that these distros
> embraced multiarch to the point where even for the "main" architecture
> they store libc in /lib/<triple>.
>
> This is configured in /etc/ld.so.conf and in theory it's possible to
> replicate the loader's parsing and processing logic in libbpf, however
> a much simpler solution is to just enumerate the known library paths.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/libbpf.c | 54 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6d2be53e4ba9..4f616b11564f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10707,21 +10707,61 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
>         return ret;
>  }
>
> +static void add_debian_library_paths(const char **search_paths, int *n)
> +{
> +       /*
> +        * Based on https://packages.debian.org/sid/libc6.
> +        *
> +        * Assume that the traced program is built for the same architecture
> +        * as libbpf, which should cover the vast majority of cases.
> +        */
> +#if defined(__x86_64__)

can you please also drop defined() where possible, it looks cleaner to me:

#if __x86_64__

vs

#if defined(__x86_64__)

> +       search_paths[(*n)++] = "/lib/x86_64-linux-gnu";
> +#elif defined(__i386__)
> +       search_paths[(*n)++] = "/lib/i386-linux-gnu";
> +#elif defined(__s390x__)
> +       search_paths[(*n)++] = "/lib/s390x-linux-gnu";
> +#elif defined(__s390__)
> +       search_paths[(*n)++] = "/lib/s390-linux-gnu";
> +#elif defined(__arm__)
> +#if defined(__SOFTFP__)
> +       search_paths[(*n)++] = "/lib/arm-linux-gnueabi";
> +#else
> +       search_paths[(*n)++] = "/lib/arm-linux-gnueabihf";
> +#endif /* defined(__SOFTFP__) */
> +#elif defined(__aarch64__)
> +       search_paths[(*n)++] = "/lib/aarch64-linux-gnu";
> +#elif defined(__mips__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
> +#if _MIPS_SZLONG == 64
> +       search_paths[(*n)++] = "/lib/mips64el-linux-gnuabi64";
> +#elif _MIPS_SZLONG == 32
> +       search_paths[(*n)++] = "/lib/mipsel-linux-gnu";
> +#endif
> +#elif defined(__powerpc__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
> +       search_paths[(*n)++] = "/lib/powerpc64le-linux-gnu";
> +#elif defined(__sparc__)
> +       search_paths[(*n)++] = "/lib/sparc64-linux-gnu";
> +#elif defined(__riscv) && __riscv_xlen == 64
> +       search_paths[(*n)++] = "/lib/riscv64-linux-gnu";
> +#endif
> +}
> +
>  /* Get full path to program/shared library. */
>  static int resolve_full_path(const char *file, char *result, size_t result_sz)
>  {
> -       const char *search_paths[2];
> -       int i;
> +       const char *search_paths[3];
> +       int i, n = 0;
>
>         if (strstr(file, ".so")) {
> -               search_paths[0] = getenv("LD_LIBRARY_PATH");
> -               search_paths[1] = "/usr/lib64:/usr/lib";
> +               search_paths[n++] = getenv("LD_LIBRARY_PATH");
> +               search_paths[n++] = "/usr/lib64:/usr/lib";
> +               add_debian_library_paths(search_paths, &n);
>         } else {
> -               search_paths[0] = getenv("PATH");
> -               search_paths[1] = "/usr/bin:/usr/sbin";
> +               search_paths[n++] = getenv("PATH");
> +               search_paths[n++] = "/usr/bin:/usr/sbin";
>         }
>
> -       for (i = 0; i < ARRAY_SIZE(search_paths); i++) {
> +       for (i = 0; i < n; i++) {
>                 const char *s;
>
>                 if (!search_paths[i])
> --
> 2.35.1
>
