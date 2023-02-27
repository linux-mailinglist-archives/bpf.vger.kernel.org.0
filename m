Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2066A6A485C
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjB0RmL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 12:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0RmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 12:42:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7244924480;
        Mon, 27 Feb 2023 09:41:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id eg37so28897436edb.12;
        Mon, 27 Feb 2023 09:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eIeMiDmyoZNopFwsCcCae+ahksr8qg85C7DiX+Xl+Bo=;
        b=gmOJC1tCA+FQUwkmazGGq2ifhj6JrhCVZihHN6pR9mfqAaE6B+wTFQlaEeq0oYfsTA
         vOkihc4jr+wMM0J//e7aJut2bvR3HYRRl9z3q124gF3t9GkTwfJNotyIuHxmWWFdQgci
         NZwQwcTiPAKlnlTRVZipgCpPbaIudYSHhUIH++zWGuINuZfemH3llR+PhGcI8pZ37qd+
         X043tGWtz/CCPvetXK6CElXmwRYvopaojPagfDLXSRtn8Y7uoCo+FrjQLwtJL+pbu9xX
         ZFqO9yLyeDIpwqWecAYh1FMCTkA28RDAeEVe4+JdkioSM8GH4I15vzbcj/FeeLBipWFI
         olzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIeMiDmyoZNopFwsCcCae+ahksr8qg85C7DiX+Xl+Bo=;
        b=aFp60GxGdBOuo2enazYVhInMRWUKD9egkhEQqcd6vnD3yOrNYTa0cuC26SEM1AGBL/
         0nPvKohdF9WlrdUlYneMu9L8Sqw7aLH4wkwqzs4WvEMEw5hHggvTqv2txCdAxNA3bWxb
         HUMrgtJVq7Lexew1pBkKlQKnrr9NM/qmU7Apyamx3/qTUJ5BgQy/ShcsnrLaMFL7Vzr9
         EmrXaT7zG7gloVjnB0zKV+SnGASWxBZ629hjVJFT5ntBTlksdkrwzN8KYRWE9HntuIV2
         9Titwx2+EQTK0x/r/JJJkHcBScGzqhI1q3WDE0xbZXtOgrs0MXb0FCgkK/LaYANozw0J
         UmrQ==
X-Gm-Message-State: AO0yUKURLeEsrbe9bsYm7sUF0T2a3EYwJkDwvEMV8s72XXfy/WvklB/l
        PUsiSBpP9BgRSTVBewlMKHIICle0hdKMY7PB1b8=
X-Google-Smtp-Source: AK7set+MUdNH5CkG7s511ae9j26hjxbQw+Ai6xmtCXEIfyom2bAoAZ4nTfSi4yyVxbG/gJxjyFHHjt5iRuVYwTwlBQw=
X-Received: by 2002:a50:bb41:0:b0:4ac:b616:4ba9 with SMTP id
 y59-20020a50bb41000000b004acb6164ba9mr157116ede.5.1677519627380; Mon, 27 Feb
 2023 09:40:27 -0800 (PST)
MIME-Version: 1.0
References: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn> <1677235015-21717-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1677235015-21717-3-git-send-email-yangtiezhu@loongson.cn>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 09:40:15 -0800
Message-ID: <CAEf4Bza7hTwLOgELWDyFUZEL_RpTkWYZ_abS8O1uoE5gqVYh8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Check __TARGET_ARCH_loongarch
 if target is bpf for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 2:37 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> If target is bpf, there is no __loongarch__ definition, __BITS_PER_LONG
> defaults to 32, __NR_nanosleep is not defined:
>
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_nanosleep 101
>   __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
>   #endif
>
> Check __TARGET_ARCH_loongarch to include arch specified bitsperlong.h,
> then __BITS_PER_LONG is 64, __NR_nanosleep can also be defined to fix
> the following build errors:
>
>   clang  -g -Werror -D__TARGET_ARCH_loongarch ... -target bpf -c progs/test_vmlinux.c ...
>   progs/test_vmlinux.c:24:18: error: use of undeclared identifier '__NR_nanosleep'
>           if (args->id != __NR_nanosleep)
>                           ^
>   progs/test_vmlinux.c:42:12: error: use of undeclared identifier '__NR_nanosleep'
>           if (id != __NR_nanosleep)
>                     ^
>   progs/test_vmlinux.c:60:12: error: use of undeclared identifier '__NR_nanosleep'
>           if (id != __NR_nanosleep)
>                     ^
>   3 errors generated.
>   make: *** [Makefile:572: tools/testing/selftests/bpf/test_vmlinux.bpf.o] Error 1
>   make: Leaving directory 'tools/testing/selftests/bpf'
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/include/uapi/asm/bitsperlong.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
> index da52065..10b4023 100644
> --- a/tools/include/uapi/asm/bitsperlong.h
> +++ b/tools/include/uapi/asm/bitsperlong.h
> @@ -17,7 +17,7 @@
>  #include "../../../arch/riscv/include/uapi/asm/bitsperlong.h"
>  #elif defined(__alpha__)
>  #include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
> -#elif defined(__loongarch__)
> +#elif defined(__loongarch__) || defined(__TARGET_ARCH_loongarch)

__TARGET_ARCH_ is libbpf-specific convention, we can't add that to UAPI headers


let's think about some other solution


>  #include "../../../arch/loongarch/include/uapi/asm/bitsperlong.h"
>  #else
>  #include <asm-generic/bitsperlong.h>
> --
> 2.1.0
>
