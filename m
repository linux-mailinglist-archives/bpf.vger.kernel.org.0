Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC43525F3
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 06:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhDBEIS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 00:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhDBEIR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 00:08:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F5BC061788
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 21:08:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1814210wmj.1
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 21:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r29s2NuB4h8xDuoc4V2TUkw3k2SQOmwLpoFzxMpsSfU=;
        b=uO9cVaFbcLWG2qSj/V5Qkp9SImi/1O/PNF5uCdkXCUUYZJA9vpqlZt2zRX/qXJ+oah
         rO4VamcAG68UI6cC43pmYE6l2QOlTbqrFGjbSxNuXrWd/OtmqO6rMnqhxjBVRyqFyxlC
         OUKieCjk5HQ7Tftt13rMzjeAfydRy7xK+3jCFtWg8v5ll3hzus2DVE8HIb+pwdbsI7yC
         QVCqXkHxo8PllGMMtIKKFuW4k/d3AriUj05NbOe4teBaYbR9X2E74zD2YaXYDn5M4r7L
         PIglkR+DonJicpVCPf6bYjXpdXpqh5F3TGvDZnH7i+ffnm5eBtVnpMfc7h/1w6E2v96N
         XOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r29s2NuB4h8xDuoc4V2TUkw3k2SQOmwLpoFzxMpsSfU=;
        b=Bl2iUWSVoYCSQO+qnoZvbFB2nGPMPYakcHqjUIVxDqvf1a1Vo9+dZ1DHNP41vhJSQC
         Hz1eSpAK7YPqEEs8gxoRVUX9c7bOoe5Ihm2V8BZllPMWEqnp4JXPZBHYDI/MX7POj/S7
         yVG5U2DjFwX1CFHfPhrcL9F5tw4tqXEr362a69latJqAEqJRcXhKoAvUTTRCuIdXi+Go
         4mjHNR8JCgNR/+p2AD74/8ASF4Y0tVtP6NOQW8ThMt7B6mQjTrOfzLBnOWy+6eKqBYmO
         C9r3k77o1tgGAnRQhc6sEZEIM4pJbQkXndURCtf8X1Gnt4AjU6oP9kMYjCPN6wM+Axv4
         +ysg==
X-Gm-Message-State: AOAM530c691EcXlcszY26ZjbuNWGRIiIkGYTcdzV5G/MU6v65n051+Bb
        bDrj4lJd3wvBTnSpIaVLA8tybJJdX3abk0GUuqZa/g==
X-Google-Smtp-Source: ABdhPJzufLcR/4YtyTXgyOTuNyEx/ynwbR2Yl8q78bJ+i0nAQpDxD5IjgzH727vIE/K26GxxXakVKXJN8RA1Zji4Frc=
X-Received: by 2002:a05:600c:9:: with SMTP id g9mr11022806wmc.134.1617336493632;
 Thu, 01 Apr 2021 21:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210401002442.2fe56b88@xhacker> <20210401002518.5cf48e91@xhacker>
In-Reply-To: <20210401002518.5cf48e91@xhacker>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Apr 2021 09:38:02 +0530
Message-ID: <CAAhSdy0CgxZj14Jx62CS=gRVzZs9c9NUysWi1iTTZ3BJvAOjPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] riscv: add __init section marker to some functions
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

On Wed, Mar 31, 2021 at 10:00 PM Jisheng Zhang
<jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> They are not needed after booting, so mark them as __init to move them
> to the __init section.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/traps.c  | 2 +-
>  arch/riscv/mm/init.c       | 6 +++---
>  arch/riscv/mm/kasan_init.c | 6 +++---
>  arch/riscv/mm/ptdump.c     | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 1357abf79570..07fdded10c21 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -197,6 +197,6 @@ int is_valid_bugaddr(unsigned long pc)
>  #endif /* CONFIG_GENERIC_BUG */
>
>  /* stvec & scratch is already set from head.S */
> -void trap_init(void)
> +void __init trap_init(void)
>  {
>  }

The trap_init() is unused currently so you can drop this change
and remove trap_init() as a separate patch.

> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 067583ab1bd7..76bf2de8aa59 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -57,7 +57,7 @@ static void __init zone_sizes_init(void)
>         free_area_init(max_zone_pfns);
>  }
>
> -static void setup_zero_page(void)
> +static void __init setup_zero_page(void)
>  {
>         memset((void *)empty_zero_page, 0, PAGE_SIZE);
>  }
> @@ -75,7 +75,7 @@ static inline void print_mlm(char *name, unsigned long b, unsigned long t)
>                   (((t) - (b)) >> 20));
>  }
>
> -static void print_vm_layout(void)
> +static void __init print_vm_layout(void)
>  {
>         pr_notice("Virtual kernel memory layout:\n");
>         print_mlk("fixmap", (unsigned long)FIXADDR_START,
> @@ -557,7 +557,7 @@ static inline void setup_vm_final(void)
>  #endif /* CONFIG_MMU */
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -void protect_kernel_text_data(void)
> +void __init protect_kernel_text_data(void)
>  {
>         unsigned long text_start = (unsigned long)_start;
>         unsigned long init_text_start = (unsigned long)__init_text_begin;
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 4f85c6d0ddf8..e1d041ac1534 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -60,7 +60,7 @@ asmlinkage void __init kasan_early_init(void)
>         local_flush_tlb_all();
>  }
>
> -static void kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
> +static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
>  {
>         phys_addr_t phys_addr;
>         pte_t *ptep, *base_pte;
> @@ -82,7 +82,7 @@ static void kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long en
>         set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(base_pte)), PAGE_TABLE));
>  }
>
> -static void kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long end)
> +static void __init kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long end)
>  {
>         phys_addr_t phys_addr;
>         pmd_t *pmdp, *base_pmd;
> @@ -117,7 +117,7 @@ static void kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long en
>         set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
>  }
>
> -static void kasan_populate_pgd(unsigned long vaddr, unsigned long end)
> +static void __init kasan_populate_pgd(unsigned long vaddr, unsigned long end)
>  {
>         phys_addr_t phys_addr;
>         pgd_t *pgdp = pgd_offset_k(vaddr);
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index ace74dec7492..3b7b6e4d025e 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -331,7 +331,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>
>  DEFINE_SHOW_ATTRIBUTE(ptdump);
>
> -static int ptdump_init(void)
> +static int __init ptdump_init(void)
>  {
>         unsigned int i, j;
>
> --
> 2.31.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Apart from above, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
