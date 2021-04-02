Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CEF35260F
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 06:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhDBESn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 00:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhDBESm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 00:18:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33176C061788
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 21:18:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so1817546wmi.3
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 21:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEf69q7AWE2x1/Rq0Iy3chkYVF+eXWxDAEWrpJWIPb0=;
        b=BiN5pFW/O77DiJXd0zx2/X1iLpsaPL6JiRjeMEk1PTjCMe5IYyCVuNyE/BDjW9dIjZ
         uoHOhBWvf5BPD2vTlyDG6HjXQg07ebuyoMX1EfVMRxOK2GWLsjRPkz7J2sb+ef6//hgr
         pt4sNPV9i0Rtcuj5utnP8QuvOClSES26++sg+APEy0lcDT7xhN8CEVVgMN50DjD9YY2e
         QksmwcQnz+uOeY8ntNWTj8qV3MgiYDpoQ7WOn/sQqqbxBQTO9DtVbBi7GHOhks+t+0dp
         Rad0fUf0hiiSKPClQTyzzg5Se1Drv7oKzWSNbevXc+Kway8nQRGPGr+qfVqI9MneH2ff
         YWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEf69q7AWE2x1/Rq0Iy3chkYVF+eXWxDAEWrpJWIPb0=;
        b=sZfhs+9Dx7NKtECgjcEeS3vUwa/tqH1fiQg9x1X3BvplIhTjxJfDaJbUD+q9GsfDEe
         MHcz1qvpMLqNFC+DB4HsJOfNL6o/Mg16FGyYohaeeuFtrLq5Te5rm9a7whjtZXMfXDtp
         p/D3d0gzPpQOAD/OLToSLsWvh69mmPVN/7DCQPGMPdOART2bpqxMQc/mB7jcmcNwFms9
         LrD0XPW1F8bX6WOUnIqZqjyYbqO1x44vAG2rslW+jSwVQFzsnV8CY6JKh1EVMNPJRdlU
         MzAxJAqzl6cBW8O1S/R4ABElK6R+FGzOuPwieI3EfpzB4iR2v59qAp2ZWSb7GrwnilTL
         m2WA==
X-Gm-Message-State: AOAM532FpDpua5EZZBBSjKVEK9LIuQEvmvTmZGI1Rj1lIdgjW9ukY18n
        xAfBg+r9X3TV3H6nc5ASuqmtuc+u062ag60vRlTIYw==
X-Google-Smtp-Source: ABdhPJygYb0Y34DkjFFMv58xpc9hYG+0m/JrspXVGLRPCjAU15Jzob3/DzPfO3yJZJFY3fTuzhjvnZTg71sUU9tB6Ug=
X-Received: by 2002:a1c:60c2:: with SMTP id u185mr10663309wmb.157.1617337118714;
 Thu, 01 Apr 2021 21:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210401002442.2fe56b88@xhacker> <20210401002900.470f3413@xhacker>
In-Reply-To: <20210401002900.470f3413@xhacker>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Apr 2021 09:48:27 +0530
Message-ID: <CAAhSdy0mYFTwhPEHVU11yFzAwUMR_wZx3LtA0KF11wW=wNu_zA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] riscv: module: Create module allocations without
 exec permissions
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 10:04 PM Jisheng Zhang
<jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> The core code manages the executable permissions of code regions of
> modules explicitly, it is not necessary to create the module vmalloc
> regions with RWX permissions. Create them with RW- permissions instead.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/module.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 104fba889cf7..e89367bba7c9 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -407,14 +407,20 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>         return 0;
>  }
>
> -#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> +#ifdef CONFIG_MMU
> +
> +#ifdef CONFIG_64BIT
>  #define VMALLOC_MODULE_START \
>          max(PFN_ALIGN((unsigned long)&_end - SZ_2G), VMALLOC_START)
> +#else
> +#define VMALLOC_MODULE_START   VMALLOC_START
> +#endif
> +
>  void *module_alloc(unsigned long size)
>  {
>         return __vmalloc_node_range(size, 1, VMALLOC_MODULE_START,
>                                     VMALLOC_END, GFP_KERNEL,
> -                                   PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +                                   PAGE_KERNEL, 0, NUMA_NO_NODE,
>                                     __builtin_return_address(0));
>  }
>  #endif
> --
> 2.31.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
