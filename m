Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F178B4F1EA7
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiDDWES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376676AbiDDV5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 17:57:53 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB370403F4
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 14:40:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h63so12949318iof.12
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUOvq+YuXnN4TZrm+WH+ksWMq/F56sm+hM6YCKtUhcM=;
        b=fv7GkY6wtsaELRONycyk5FhudxWOKI2DWeBpTai90BaSc11eu4OOc/XAfMyoWYOoDA
         JWTge+nFSn7nPAlUYob6UOCR9eP2HmHlsqIofoUak3Pv9EQbSCM0qeDOL5M+l7YhivQO
         qI67mDF38dI/L1ApjUu9mo/Kdtqi4dhh9K6UxYtEmNQUeCd+go6StcZ9kjdeSkCRknqU
         YUa7bYWmP/oyDtdKbzTZ7WnGgYxaif3xnFqqQ6PhQFynpVgh7yczaiJYExJ2USRVARH8
         h20xk4ufQ7MSBWcRGi1yp22Jx2bax/brXxdl5diGsLL9jbxK4dwsks4ktPjJeSbbZHNX
         CW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUOvq+YuXnN4TZrm+WH+ksWMq/F56sm+hM6YCKtUhcM=;
        b=xVmd1gym8GKJsW2+ak35t+vIjYiY10M76uYS3kNhgplQVpjIvdzjSSnS43A8WiWTL/
         6fXvHg5WjBwsIqmoxSFc3uz8svoEcwZzRbfm2rkbMfJViOAw8rbc+Bj1B6f26nsDd5de
         ZcwTfNkjpjcST2DHj2+y3c6fHZaPaIX4b9lAomyXpEFtTapfleuOFK8lmd1XJmt+r6iY
         /z2B/eIHOaja7UvvvHqdETdKwB66A5DldHiCUV+ZM9TH/sKG+WAxxonrJuweux6PGBs3
         YJbe6z+eTZ1fo4Kr8Z+58DZy+dAIBFmrbVF/KYxgAYrpcJh9+4i8t0aiz+EwKInw7n41
         HUlA==
X-Gm-Message-State: AOAM533ousyUZym/xjqwJ5v6m1vaF49PMW1sf7oyDRH1TuIA8TVCvGIO
        //4OqoNtmPYr5uzGz8XGEFAWTyX3BC1RFz++WD7g8+s6
X-Google-Smtp-Source: ABdhPJzwUJ3Sr0daYuEZMagm8EMgVAMCw87vi9/q3KW6F8BP+GM3JS8c6rfOibu73oQizj/UcBr00+2fKQXKxldzVSc=
X-Received: by 2002:a05:6638:1685:b0:323:9fed:890a with SMTP id
 f5-20020a056638168500b003239fed890amr206408jat.103.1649108422990; Mon, 04 Apr
 2022 14:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220404102908.14688-1-iii@linux.ibm.com>
In-Reply-To: <20220404102908.14688-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 4 Apr 2022 14:40:12 -0700
Message-ID: <CAEf4BzZh8_cR+CxgQSAK5XpRd3Qc-M_wU-2V15CNVKJCCDyHTg@mail.gmail.com>
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

that's pretty comprehensive :)

But let's make this function return const char * instead, with NULL
for unknown/unsupported architectures. This will make the below code
simpler....

>  /* Get full path to program/shared library. */
>  static int resolve_full_path(const char *file, char *result, size_t result_sz)
>  {
> -       const char *search_paths[2];
> -       int i;
> +       const char *search_paths[3];
> +       int i, n = 0;
>

instead of counting, we can just NULL-initialize search_paths and
teach the loop below to ignore NULL entries?


>         if (strstr(file, ".so")) {
> -               search_paths[0] = getenv("LD_LIBRARY_PATH");
> -               search_paths[1] = "/usr/lib64:/usr/lib";
> +               search_paths[n++] = getenv("LD_LIBRARY_PATH");
> +               search_paths[n++] = "/usr/lib64:/usr/lib";
> +               add_debian_library_paths(search_paths, &n);

so you'll just have

search_paths[2] = arch_specific_lib_paths();

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

oh, actually we already do ignore NULLs, it seems?

> --
> 2.35.1
>
