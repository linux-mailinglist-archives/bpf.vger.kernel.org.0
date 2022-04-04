Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA84F2140
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiDECPg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 22:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiDECPg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:15:36 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF65933D833
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 18:10:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id v2so9286815qtc.5
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 18:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdfSLincvRLzA12JMOoCrMo+hQUQA2Rj3h655/JMTgU=;
        b=i9oKu6xonglVEONA0H/X1svRauiD65LKNgdQcG0qTM24rd1k4MazHChAUYvikmnp+H
         kYfAzwfnuh+07arG+nES8H7JSTA/fyk6y8ViVlSERVlkAopCFBALUftY4uZhGV1cgS7h
         aAPKQd2ZeyHB9XvqPeoX+cGDjBtolX3JydZStv+G5RVha3lrhFIuoncT2GXp04F6i4RY
         aDj8DRlykxE5FhEIfmPoMIjF24mITbFh1bQzbY51XJWQi2hC7pd1Cd+gJjlxVDFQe2a7
         +Z65gdZXlqOVPLr6b3y8RmDYDTX8wyAHlKwN1IVXOpuo5X9k7W7A5AV/hQTTLP8eSTz+
         nFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdfSLincvRLzA12JMOoCrMo+hQUQA2Rj3h655/JMTgU=;
        b=0spdiBda+GDY2pivi9ngtAuO7HzZNBtGo3EhZU/BqERTpLndC+ApBXpTEZnotHfnIe
         2Wk2zRHVZrDG2ws6ZAUhgBMeY47pivKW8ui9HULt2CePyBS0jyPnACMLPa1V4QM2t/1r
         OibpDcpKB4nbhnujnOIzKHbAJ1Osh2jzI/vXWrU7zm8/BZ8xwauf9rrw2lJjWPUdIhYZ
         uf9Yz5GZWDjvUdrL4Gj+4APxrJZ1Fy1zRCtaFSPyMaXH0w8MeXl3pJk+rCY7KeOftcmZ
         kOkpj8+eUXQ6XXcYno9gUvGHHI3PJ+KYoai+AswJYxnU+AfnUYHzWLkqHmkx6VjBiqas
         NM1w==
X-Gm-Message-State: AOAM530VcOxlPdc8GOL0dW5JGuFowugW15E8xkdpGtjtHLcoKqqaOKum
        YO8c5TyX2hISC9uRpqpo50K2pbxiDVoSIbNl/57KkE2L
X-Google-Smtp-Source: ABdhPJz/k4GKQI4lbHzAL7lTACxiJMBNte+tyfDE3vTX98WuUO1G2O9y1QXyCrdQaUOWyDPPmMgXE8EMRDpr3bgd/Rw=
X-Received: by 2002:a05:6638:772:b0:319:e4eb:adb with SMTP id
 y18-20020a056638077200b00319e4eb0adbmr463444jad.237.1649116187029; Mon, 04
 Apr 2022 16:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220404225020.51029-1-iii@linux.ibm.com>
In-Reply-To: <20220404225020.51029-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 4 Apr 2022 16:49:36 -0700
Message-ID: <CAEf4BzZwwn9j746k6ybvA7vaNGcJuLSb86iEtueEUmQkAD0GhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Support Debian in resolve_full_path()
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

On Mon, Apr 4, 2022 at 3:50 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
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
> v1: https://lore.kernel.org/bpf/20220404102908.14688-1-iii@linux.ibm.com/
> v1 -> v2: Use a single return value (Andrii), get rid of nested #ifs,
>           simplify some of the conditions.
>
>  tools/lib/bpf/libbpf.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6d2be53e4ba9..648dc8717e8d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10707,15 +10707,54 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
>         return ret;
>  }
>
> +static const char *arch_specific_lib_paths(void)
> +{
> +       /*
> +        * Based on https://packages.debian.org/sid/libc6.
> +        *
> +        * Assume that the traced program is built for the same architecture
> +        * as libbpf, which should cover the vast majority of cases.
> +        */
> +#if defined(__x86_64__)
> +       return "/lib/x86_64-linux-gnu";
> +#elif defined(__i386__)
> +       return "/lib/i386-linux-gnu";
> +#elif defined(__s390x__)
> +       return "/lib/s390x-linux-gnu";
> +#elif defined(__s390__)
> +       return "/lib/s390-linux-gnu";
> +#elif defined(__arm__) && defined(__SOFTFP__)
> +       return "/lib/arm-linux-gnueabi";
> +#elif defined(__arm__) && !defined(__SOFTFP__)
> +       return "/lib/arm-linux-gnueabihf";
> +#elif defined(__aarch64__)
> +       return "/lib/aarch64-linux-gnu";
> +#elif defined(__mips__) && defined(__MIPSEL__) && _MIPS_SZLONG == 64
> +       return "/lib/mips64el-linux-gnuabi64";
> +#elif defined(__mips__) && defined(__MIPSEL__) && _MIPS_SZLONG == 32
> +       return "/lib/mipsel-linux-gnu";
> +#elif defined(__powerpc64__) && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +       return "/lib/powerpc64le-linux-gnu";
> +#elif defined(__sparc__) && defined(__arch64__)
> +       return "/lib/sparc64-linux-gnu";
> +#elif defined(__riscv) && __riscv_xlen == 64
> +       return "/lib/riscv64-linux-gnu";
> +#else
> +       return NULL;
> +#endif
> +}
> +
>  /* Get full path to program/shared library. */
>  static int resolve_full_path(const char *file, char *result, size_t result_sz)
>  {
> -       const char *search_paths[2];
> +       const char *search_paths[3];
>         int i;
>
> +       memset(search_paths, 0, sizeof(search_paths));

memset() is an overkill, I just added = {} to search_path declaration.
Applied to bpf-next, thanks!

>         if (strstr(file, ".so")) {
>                 search_paths[0] = getenv("LD_LIBRARY_PATH");
>                 search_paths[1] = "/usr/lib64:/usr/lib";
> +               search_paths[2] = arch_specific_lib_paths();
>         } else {
>                 search_paths[0] = getenv("PATH");
>                 search_paths[1] = "/usr/bin:/usr/sbin";
> --
> 2.35.1
>
