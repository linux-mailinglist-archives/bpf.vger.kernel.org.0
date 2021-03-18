Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639A9340E36
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 20:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhCRT2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhCRT15 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 15:27:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D2C061760
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 12:27:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 75so6352281lfa.2
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fspya4XBtFR7Kjia5AOXCu2vMjqacQ/eg21hgvTyIiA=;
        b=V0zGJmtjfeUxAzYW2JbBAD59Y6NFskvJjGprJjF5sRu1F7yND0V/Ocx2wCviLvTJqS
         2iwD++kbQJ8uatls/4I4kAMuA5pliKsV0PGcuKvjtjimeorSf7fD/SyrkWSG6LaU9kFp
         uOqEA6rQcj02QEEz565bO3ofLdjyfKvBy6chVF2qpDpm9ctaVp5XaZJt2kCHru35NhPC
         6t0Wk+Kp6RuXDHNUr/Xdfi4KhAr334sWMxO7Ci4gVb01vkBuSI20u0lzzrm8VOgYkNh3
         bPG/VCgWtabQQ1lP/K4RMFSESYslBiEH2U243vQuv7EPAAG9aCWRBl8QnhlceiFUwWoK
         MIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fspya4XBtFR7Kjia5AOXCu2vMjqacQ/eg21hgvTyIiA=;
        b=pJfuF07sFjaLFr+Cu0UDYmRnxqiUdpPpv5vDvyEc83WnG3QB2uO3oNFWY9WTaftHkr
         uIsywCRWUeZuBnFTNHHm7RBKLvBcktmYWv8mH29HK4rAhJRasKUF6oT1ll0Y3VDXuYnl
         jKefbyKUpckull71fvFpLPVHdAlqIiHfuFrsZ2G/8znwn6/xTznmeyDyVo6A20ZiH+Nd
         +OxrYot/AKcRQiYHPIKNSXahQr5jpPRPe3ebNhAOZFTeFj9k9QXnXLMHAigYIPl8tygp
         w7nS6IDOx+5UjmN1ECBuuYCPZmFStcjmdb3PR+MK/42x0y7ejbDD1tnqmThbEDwKzw9Z
         /Olw==
X-Gm-Message-State: AOAM530HQsodKRPKW+uwWDKFSPY04BuwEJ/x6C8RYQtTRx6n8v8GTSEZ
        UEUeBorvVF9ohyGX4RSF0P4EIoY0nZAn5i3ytiDKbw==
X-Google-Smtp-Source: ABdhPJweTgo1kbO051P2mdlKBZSgkmABnh4OQ7GaD+B5jCTTrQXCv4+NpbYAUz7Wi1fnX1PvZh2MNc08DzjnXvFdNNk=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr4465444lft.368.1616095674888;
 Thu, 18 Mar 2021 12:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com> <20210318171111.706303-5-samitolvanen@google.com>
In-Reply-To: <20210318171111.706303-5-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 12:27:43 -0700
Message-ID: <CAKwvOdkbok-BoYGfvHH1HR=cMztaBYZKB-UHRDZ4g5YjSCuq2A@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] module: ensure __cfi_check alignment
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
> aligned and at the beginning of the .text section. While Clang would
> normally align the function correctly, it fails to do so for modules
> with no executable code.
>
> This change ensures the correct __cfi_check() location and
> alignment. It also discards the .eh_frame section, which Clang can
> generate with certain sanitizers, such as CFI.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=46293
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/module.lds.S | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 168cd27e6122..93518579cf5d 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -3,10 +3,19 @@
>   * Archs are free to supply their own linker scripts.  ld will
>   * combine them automatically.
>   */
> +#include <asm/page.h>
> +
> +#ifdef CONFIG_CFI_CLANG
> +# define ALIGN_CFI ALIGN(PAGE_SIZE)
> +#else
> +# define ALIGN_CFI
> +#endif
> +
>  SECTIONS {
>         /DISCARD/ : {
>                 *(.discard)
>                 *(.discard.*)
> +               *(.eh_frame)

Do we want to unconditionally discard this section from modules for
all arches/configs?  I like how we conditionally do so on
SANITIZER_DISCARDS in include/asm-generic/vmlinux.lds.h for example.

>         }
>
>         __ksymtab               0 : { *(SORT(___ksymtab+*)) }
> @@ -40,7 +49,14 @@ SECTIONS {
>                 *(.rodata..L*)
>         }
>
> -       .text : { *(.text .text.[0-9a-zA-Z_]*) }
> +       /*
> +        * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
> +        * of the .text section, and is aligned to PAGE_SIZE.
> +        */
> +       .text : ALIGN_CFI {
> +               *(.text.__cfi_check)
> +               *(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
> +       }
>  }
>
>  /* bring in arch-specific sections */
> --
> 2.31.0.291.g576ba9dcdaf-goog
>


-- 
Thanks,
~Nick Desaulniers
